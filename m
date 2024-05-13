Return-Path: <linux-kernel+bounces-177991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF228C4735
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F161E1F21CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2463C08A;
	Mon, 13 May 2024 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyLLoYUZ"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5F3BBC9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715626399; cv=none; b=rM9jG9kwlsf2U4StTfmk+twu1suw5bxAWMCpOauRBf82MkC2Q2kgk+5yI/EIZnsh7VK8UtS1Xps1J/qcynSemhkZ8hqlJ3f9UwEGg2X24895xuuUN+J021Veg1IqIhRbVGrUwjNIb+nhT7qHCzcaM7YQo2CH2BYOFfaFC1o1Q1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715626399; c=relaxed/simple;
	bh=wMZgnbIK7sP6x1dsaZAtpTBrCjF5xgujlfHt77Mnmag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A9Kz/HVbF2h/FtEezOva7eKqHZngS/skj8aGN3t3fGMokGsb3yG59GTCKgij/FgkghDS0awn+JkDrPRkBYzI1IrcLojFsDeZ+EuTRTSv19FUuT7m09Vx6yooVekzNbyDCSQrqBKlXzOYvD7tCojJt98OM09SYVKw43E2jwXegiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyLLoYUZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f0ea2c726aso2069092a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715626397; x=1716231197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMmxtb1bP8C4W9exPsVYRtD/ZNYomRnzlZHgxlhoTfc=;
        b=HyLLoYUZpeS5I/0eg7WVvTQmGZS1zdtxs4zQNdmt9FDFfMp7iS/en5SApsFDErS21n
         xnYAy/colTjZ2vMh+5zp26jKZlsm3PydIvQiuVa0XNiy9YPRc0+Q+Nr+aAzBS3EA0BX+
         OgDJRQWz5qdD0ovUCikQHE1fTG5zmhIPYUsW2A+4YH9Hdxp6axrGr8W5lb+l0FFZDz5h
         BcHp60RM/9+go+CZhZDB+Ab4sMACfG5QlOgE5AqLpULeyJDx0n+dni2ROsVYC/I/pUyj
         +DuIwdEOlQBa4XCIoy9aMmjtavRvEzxedMsdGXetU4J1Es2y/Tx/SFWdfNoYp2LDZVw0
         wSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715626397; x=1716231197;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMmxtb1bP8C4W9exPsVYRtD/ZNYomRnzlZHgxlhoTfc=;
        b=ZIkv5mQ96kSXnE6n413OO+DvEgOHOLKuUJ5AARl/34pQArDpye5NNvCfa0Dvh3CuK0
         QBRGzl4Te37QiZmDoKO5wCdwSrJzcvYtn+W3GeCXF2JZXPWjjTItgJzLvwmrJYkkoMPx
         BIiQ8DqfDyV8CC7ZKUGy5brWtKQ4ZWQNvg4L5S5Xr2MaP7+RibUJFn2fEBI6Fjq5oWjw
         YRA5vIiMICfk5frZmdH+QTerXI9fvrOrWQ9qrv5trOZ3PnsXHSJOoxd+cmaeVrn9ZoTi
         om+/epbA/n1wogQG0eUC+VF8vQwC0FFRydWjrMuGNQgsZhtZTkABYRBmL/669ILW4CoB
         TVbA==
X-Gm-Message-State: AOJu0Yy8b0U4k5Jh0kE06bQ7gnO7+0fMza3+QBVM7+Gw8awTHm9b0Vpp
	IQyvRnD0R0gUK8i3X6MI2CywD/5XtkaYtsPilrwd9C0mhW6KeGk=
X-Google-Smtp-Source: AGHT+IHoSQQ3Es6ZLWvYCDS9qvSY1HU1WYA4NSAr36Bw///5fme+1cqpYJRi40/ZRnUdH6LUSn/O4w==
X-Received: by 2002:a9d:62da:0:b0:6f0:6b5b:11ca with SMTP id 46e09a7af769-6f0e92d0274mr11707941a34.32.1715626397050;
        Mon, 13 May 2024 11:53:17 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e022339dsm1671627a34.62.2024.05.13.11.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:53:16 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from mail.minyard.net (unknown [IPv6:2001:470:b8f6:1b:70d0:cf4:423d:2df1])
	by serve.minyard.net (Postfix) with ESMTPSA id E19061800BA;
	Mon, 13 May 2024 18:53:15 +0000 (UTC)
Date: Mon, 13 May 2024 13:53:14 -0500
From: Corey Minyard <minyard@acm.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.10
Message-ID: <ZkJhmhatRHeKuIfE@mail.minyard.net>
Reply-To: minyard@acm.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 8d025e2092e29bfd13e56c78e22af25fac83c8ec:

  Merge tag 'erofs-for-6.9-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2024-03-27 20:24:09 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.10-1

for you to fetch changes up to 999dff3c13930ad77a7070a5fb4473b1fafdcecc:

  ipmi: kcs_bmc_npcm7xx: Convert to platform remove callback returning void (2024-04-17 14:55:04 -0500)

----------------------------------------------------------------
ipmi: Mostly updates for deprecated interfaces

These changes are mostly updates for deprecated interfaces,
platform.remove and converting from a tasklet to a BH workqueue.  Also
use HAS_IOPORT for disabling inb()/outb().

-corey

----------------------------------------------------------------
Allen Pais (1):
      ipmi: Convert from tasklet to BH workqueue

Niklas Schnelle (1):
      char: ipmi: handle HAS_IOPORT dependencies

Uwe Kleine-König (6):
      ipmi: bt-bmc: Convert to platform remove callback returning void
      ipmi: ipmi_powernv: Convert to platform remove callback returning void
      ipmi: ipmi_si_platform: Convert to platform remove callback returning void
      ipmi: ipmi_ssif: Convert to platform remove callback returning void
      ipmi: kcs_bmc_aspeed: Convert to platform remove callback returning void
      ipmi: kcs_bmc_npcm7xx: Convert to platform remove callback returning void

 drivers/char/ipmi/Makefile           | 11 ++++-------
 drivers/char/ipmi/bt-bmc.c           |  5 ++---
 drivers/char/ipmi/ipmi_msghandler.c  | 29 ++++++++++++++---------------
 drivers/char/ipmi/ipmi_powernv.c     |  6 ++----
 drivers/char/ipmi/ipmi_si_intf.c     |  3 ++-
 drivers/char/ipmi/ipmi_si_pci.c      |  3 +++
 drivers/char/ipmi/ipmi_si_platform.c |  6 ++----
 drivers/char/ipmi/ipmi_ssif.c        |  5 ++---
 drivers/char/ipmi/kcs_bmc_aspeed.c   |  6 ++----
 drivers/char/ipmi/kcs_bmc_npcm7xx.c  |  6 ++----
 10 files changed, 35 insertions(+), 45 deletions(-)


