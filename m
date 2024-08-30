Return-Path: <linux-kernel+bounces-307927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C051965510
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD7191C22936
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45C5136331;
	Fri, 30 Aug 2024 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="E/0c8iee"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8B128DCB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983513; cv=none; b=qEn7IRdPSYD0/7Zj20NGdVA1r782WL/uX9ByOVhqN/X61REKdtUdgapeac2fqavgKvtcr1b9P/5hYgXwa8DpgsrKvN8nxoFdmi0a3otjTQQCAFTqtpv+aV8/SvX/90OREuwGD7oKDUifnewwagzRHW50n89qNUvQsDtNqHDpYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983513; c=relaxed/simple;
	bh=2yuuJVKQ+Siguo8PGv6DbdWIFXlssxpRT1fH4pUOoOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lP5HbQcHit9zyOrB0xCy0VjKPRxiHwuIZCx0x3O257X0eODykigqfyEHVJVo659+9FUc+H8J8Q4bNda92pJ68iX+wLXyCFUW6KdnpAWdY4sVJj0SMOGdUOcWKxcPPqeprACYjpZDwTVfdXw1Eru65VJ/jHqssnz3/NFrIAZ1eo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=E/0c8iee; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-715e64ea7d1so1067939b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1724983511; x=1725588311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/5DVpazD2e4b/WBbkd9CtgNXP337r5jJGNekgg+Vhw=;
        b=E/0c8ieetU+zFDoVaTu0zaDElO1if6E/aR0MY7eiMi5ZUAgJeIap1YAalUY9Gek1be
         XEHP/Dh0yfsydoXgImTSeTwY10+nOVk9iUTEnF56cpCZpHKsl1+AOQjgKx4MbGoL4ybd
         PbVRO9kQAdKfiztLoQovUsCy/OFQkP56bU6eHISKk1gTqwOMxI0M+xCDhflpFc0zbQOV
         yv9CcLsDK0xAlZo/f8KiB+Py7UOOsk/aIlf7q7nzloeANBQFMlbRjHyAXwnq8JIxKtrp
         b1UBl2VSZtLlO2lj7jkjWdY/Y+YGotXA4cbdlWkE/CXhPXdAobB0eNy2/uDdpMfb54iI
         qqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983511; x=1725588311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/5DVpazD2e4b/WBbkd9CtgNXP337r5jJGNekgg+Vhw=;
        b=rKrFrqhrWZTEPgyF47iGrmpF7e6wOaxnjCg2lxqhddASnr9wSJF0NtVKUceeoAmDVX
         HrHYQOame1Kw53osc5AvSZ4/xHIpXxfzHuBEmefHVupqLBrNeMrpIT3cAFdp/9+FRluy
         njwIXOTPzflPsmCBjvz1FkKg5dvBBBwKZtp42VsZ+YHzQNFTIlDjEmNmfs0vCErIr+WU
         2zglsFbZPfMouZKhSgy/2bw2GL5MmsBZEhm61XKpzNY1H/3R/4sRtPl9WxFKPq8LvFKO
         ts23RSv/FPJTOS2dZ5O52Dusjd0tkVloUGrAPqTVMmjYADXpvZcrH2X8HATKy93q9RKd
         KsUg==
X-Forwarded-Encrypted: i=1; AJvYcCW4aQGXCpX2SAwvW5awYUEDXxLwrKozTdI8YCAJJAqqPKQ+jizvzuJ+L6TK8SR2YbgGw7vOPJfwMtiaLI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/b2FqUvdZozCCBirhy/37ZmNxLr5BIoG3IsrR74Ynppglcdtk
	YTGY18ZE01XpGPQ95Fi7o+nx/LRMEgMMuwUjU3J/yqS2mn6vrdAqnkv888MMeNr1NvknqSoK5t4
	WiwI=
X-Google-Smtp-Source: AGHT+IEMCsy/a+MiMSHWPUNa+kuvu9LDzb34kNddaRUMbVVgmr3mLn7LTVs5FWxj4etZ87zK3Tk5tg==
X-Received: by 2002:a05:6a20:9d92:b0:1cc:9f24:42 with SMTP id adf61e73a8af0-1cce1027549mr4694666637.20.1724983511028;
        Thu, 29 Aug 2024 19:05:11 -0700 (PDT)
Received: from lunchbox.darkphysics (c-73-83-183-190.hsd1.wa.comcast.net. [73.83.183.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534444sm17643255ad.147.2024.08.29.19.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:05:10 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/3] Staging: rtl8192e: Yet another variable rename and cleanup series
Date: Thu, 29 Aug 2024 19:05:05 -0700
Message-Id: <20240830020508.532945-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series renames pNetwork and bHWError variables, and 
improves readability by inserting spaces around opperators.

Cheers!
~Tree

Tree Davies (3):
  Staging: rtl8192e: Rename variable pNetwork
  Staging: rtl8192e: Rename variable bHwError
  Staging: rtl8192e: Add spaces around operators.

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  8 +--
 drivers/staging/rtl8192e/rtl819x_HTProc.c     | 34 +++++-----
 drivers/staging/rtl8192e/rtllib.h             | 68 +++++++++----------
 3 files changed, 55 insertions(+), 55 deletions(-)

-- 
2.30.2


