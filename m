Return-Path: <linux-kernel+bounces-568874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C652A69BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 23:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EF4188DFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9C0215171;
	Wed, 19 Mar 2025 21:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b="eHm3Va7C"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2C818E25
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421579; cv=none; b=P0ryHp05A0DCoFsJ1NORGwxlF5uqJYwgXWVC/rTXIQkfUVKgFLw/UMdGyZNYng9oKOTQdQnfkmy3WrxCcGXoCFSgP59kolYo3zaj+2Jh7EvghqfuOh7ssgPs6UqsS8Vkec8ZY/re3m+QqIHZErfPLZjS9rj1hYv1UChLYaLIUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421579; c=relaxed/simple;
	bh=DuHROmou9tfYbDx47pfkG9I5pk+qCEdU/XjY/OEtDl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGyjxPhWwT+7p1dPga7dPc0hd2vAbyL9Z9qs6xAi1Tyg6E5eEI+Wp4z5wFyMQPTZ1PSl4YgCQsm4Rh+h2fuH7v0eRgwpZc0wVfjGvfGfhzEqpumwXiSmWcFVgsDrpCqFvajCiO3o5fKRvk/k4K/iu/idK730xCYtuC3feF01LXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org; spf=pass smtp.mailfrom=neverthere.org; dkim=pass (2048-bit key) header.d=neverthere.org header.i=@neverthere.org header.b=eHm3Va7C; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=neverthere.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neverthere.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22580c9ee0aso792635ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverthere.org; s=google; t=1742421577; x=1743026377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhHffwlirpZOJ87BsBnAyn0bghFD+bu1krAlw6AA89Q=;
        b=eHm3Va7CPTfmQ2pXqvucNZ2mFSgXl5BQqKlYXRY50xoD6mGnx3DYbwfosJBcjM5rnh
         DkSj5zIKjT3i41aG4bOie2ZSU6omGmHCQ2N8Hbxkjhj4fUlYR9T5jWgbhIFH+6OtxS+o
         4DQEwGZfO5fNxvFwzNTIysM0XAifqQJSzrfz8kkI0iJgAgELUhxvDW812S203fqQE7Nt
         wLO54ePyju/vpoEStAd+Y35oHDqPrxX370VDDWxZcJTd0NtHg5jCXPLq2/QxoHDXGLP0
         Izbx7curmK/Naf0rfYGEBmVtUPl0mQ2Pr+wEg3Tbi0t2HZiNc6PYaBcZ0kC/PH+M7d0i
         LaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421577; x=1743026377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhHffwlirpZOJ87BsBnAyn0bghFD+bu1krAlw6AA89Q=;
        b=rVSX8opazCWsXmnmBFkVDTUNyAP+JimWDupPHp7nWQR0qFBvxQVkIDyeyaNIji6On5
         h1AMTMd0P1vajF3uxPg3fWyuNbZXvJbNtcsQ1XPLNwW2nyFLSTtDMjxsjojcSSD1CLFj
         LaYrMmvWNS27a7h4ho0w3B4HCrWHqrsu7C2WFMtFgZSiE7SBbUlqPrBrgMuYopGFLcpU
         6BsaJRIYn4wfyXyw8MOqwXE4PnzQHJILNim9DoPUh8R7HhjRY6D/DtGpXjEuXPe+6TBK
         AO4CNgADwHjcHF7RLNqMN5xREYyB4vo3LjYtEX9046RKh/O8YKB61lc0SfGCzsQl4Um9
         Gb5w==
X-Forwarded-Encrypted: i=1; AJvYcCVNk5h32CqRG8BKzD4NTsSfiIr9R4ZmhDS4dFJlC/vawt7cIZWQZrYQC0WCsaX5+a+HPPTGRc1ep3+IpRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAONQT5UC+LBFy3Yg8s68UVMSs3jMrEwLzfuwdy0e2x8/O3IRo
	YQ0xbAYpThHpir9EthMg+RAfJLgFtBX87+y0n0EjAsHOSC5TboyGB0GoFOkX6Q==
X-Gm-Gg: ASbGncuvVSHo/DC/WloBZbZlCArRSWVYTFGgQNYiJPMMG9pFLA+STQM9Aklg2xij9ET
	0lR/ydYC1b5IJmgQc8qDmdlrCkyYcCBrvQOkBoi4SztEH0smEWW2AP/258eKW9E8Ql+HR/gMgSC
	6K3lMujXxp4PgJ0mjSBGhaFX5wKxZ28FKIl2z1BDPG6KPSX4caswbzz2801Wn2u7OqllmyVxGzD
	KFh7ta6rgyCOcdAWZES8YWlXwOPtL0HDYwW6pLIdwBSm+G1f8KC7v/ToHnNjW/34e2OLfHBWxLJ
	V7RQQArwt56+FJiZjBYDoRDU4BwG+E3kY1YQIz/vbq90ZEgK+5XkeVT4MaTEC8iPPFacztgetl7
	oOfHuuLHgGA==
X-Google-Smtp-Source: AGHT+IHijFMQ5qiJupJGGoqNu3+/AqRhKkzmiIpkcLRmsE2+T0qD4Wrj3bd9cEZPaXOb1DWS7CHUHQ==
X-Received: by 2002:a05:6a00:1ad4:b0:736:32d2:aa93 with SMTP id d2e1a72fcca58-7377aa4dc65mr1501168b3a.20.1742421576913;
        Wed, 19 Mar 2025 14:59:36 -0700 (PDT)
Received: from tiamat (c-69-181-214-135.hsd1.ca.comcast.net. [69.181.214.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115592b7sm12623597b3a.64.2025.03.19.14.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:59:36 -0700 (PDT)
From: Michael Rubin <matchstick@neverthere.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Rubin <matchstick@neverthere.org>
Subject: [PATCH v1 00/20] Removing typedef for gpib_board
Date: Wed, 19 Mar 2025 21:59:04 +0000
Message-ID: <20250319215924.19387-1-matchstick@neverthere.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

staging: gpib: Removing typedef for gpib_board

Adhering to Linux code style.

In general, a pointer, or a struct that has elements that can reasonably be
directly accessed should never be a typedef.

* Patch 1: struct typing for gpib_board

  Introduces struct gpib_board replacing gpib_board_t

* Patch 2 - Patch 18

  Adopting "struct gpib_board" as opposed to "gpib_board_t" for each
  subsystem in gpib.

  *  staging: gpib: agilent_82350b: struct gpib_board
  *  staging: gpib: agilent_82357a: struct gpib_board
  *  staging: gpib: cb7210: struct gpib_board
  *  staging: gpib: cec_gpib: struct gpib_board
  *  staging: gpib: common: struct gpib_board
  *  staging: gpib: eastwood: struct gpib_board
  *  staging: gpib: fmh_gpib: struct gpib_board
  *  staging: gpib: gpio: struct gpib_board
  *  staging: gpib: hp2335: struct gpib_board
  *  staging: gpib: hp_82341: struct gpib_board
  *  staging: gpib: ines: struct gpib_board
  *  staging: gpib: lpvo_usb_gpib: struct gpib_board
  *  staging: gpib: nec7210 struct gpib_board
  *  staging: gpib: ni_usb_gpib: struct gpib_board
  *  staging: gpib: pc2: struct gpib_board
  *  staging: gpib: tms9914: struct gpib_board
  *  staging: gpib: tnt4882: struct gpib_board

* Patch 19: staging: gpib: struct typing for gpib_gboard_t

  Adopting "struct gbip_board" as opposed to "gpib_board_t" for include files.

* Patch 20: staging: gpib: Removing typedef for gpib_board

  Removing typedef for gpib_board_t

Michael Rubin (20):
  staging: gpib: struct typing for gpib_board
  staging: gpib: agilent_82350b: struct gpib_board
  staging: gpib: agilent_82357a: struct gpib_board
  staging: gpib: cb7210: struct gpib_board
  staging: gpib: cec_gpib: struct gpib_board
  staging: gpib: common: struct gpib_board
  staging: gpib: eastwood: struct gpib_board
  staging: gpib: fmh_gpib: struct gpib_board
  staging: gpib: gpio: struct gpib_board
  staging: gpib: hp2335: struct gpib_board
  staging: gpib: hp_82341: struct gpib_board
  staging: gpib: ines: struct gpib_board
  staging: gpib: lpvo_usb_gpib: struct gpib_board
  staging: gpib: nec7210 struct gpib_board
  staging: gpib: ni_usb_gpib: struct gpib_board
  staging: gpib: pc2: struct gpib_board
  staging: gpib: tms9914: struct gpib_board
  staging: gpib: tnt4882: struct gpib_board
  staging: gpib: struct typing for gpib_gboard_t
  staging: gpib: Removing typedef for gpib_board

 .../gpib/agilent_82350b/agilent_82350b.c      |  99 +++++----
 .../gpib/agilent_82357a/agilent_82357a.c      |  85 ++++----
 drivers/staging/gpib/cb7210/cb7210.c          | 107 +++++-----
 drivers/staging/gpib/cec/cec_gpib.c           |  59 +++---
 drivers/staging/gpib/common/gpib_os.c         | 196 +++++++++---------
 drivers/staging/gpib/common/iblib.c           |  50 ++---
 drivers/staging/gpib/common/ibsys.h           |  14 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c    |  93 +++++----
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      | 122 +++++------
 drivers/staging/gpib/gpio/gpib_bitbang.c      |  72 +++----
 drivers/staging/gpib/hp_82335/hp82335.c       |  56 ++---
 drivers/staging/gpib/hp_82341/hp_82341.c      |  68 +++---
 drivers/staging/gpib/include/gpibP.h          |  10 +-
 drivers/staging/gpib/include/gpib_proto.h     |  58 +++---
 drivers/staging/gpib/include/gpib_types.h     |  58 +++---
 drivers/staging/gpib/include/nec7210.h        |  58 +++---
 drivers/staging/gpib/include/tms9914.h        |  52 ++---
 drivers/staging/gpib/ines/ines.h              |  54 ++---
 drivers/staging/gpib/ines/ines_gpib.c         | 111 +++++-----
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  66 +++---
 drivers/staging/gpib/nec7210/nec7210.c        |  76 +++----
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     |  70 +++----
 drivers/staging/gpib/pc2/pc2_gpib.c           |  68 +++---
 drivers/staging/gpib/tms9914/tms9914.c        |  66 +++---
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   | 100 ++++-----
 25 files changed, 947 insertions(+), 921 deletions(-)

-- 
2.43.0


