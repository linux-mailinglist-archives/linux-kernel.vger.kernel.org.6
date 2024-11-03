Return-Path: <linux-kernel+bounces-393739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A5B9BA49F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581CBB21426
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 08:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972D31632F9;
	Sun,  3 Nov 2024 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey8YpAVS"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124315B13D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 08:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730621697; cv=none; b=Zs2b+JKuUq2UlyHTCH+V31udSbsLLLST8HsYn5gVbRNbXaRNQtZdOQonYfxLIBF6k88UuU5yEO+XOzPesmfbanOqgZDlg1Z21Ht79qJHAmcwWHxZBZOPTR8qMvCa226f2BvG/7YMkFGNm3MLZS9YC4H8VUxsH4UZpzKFuqVjSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730621697; c=relaxed/simple;
	bh=NwG1+Wj9EwKQULRNQC2RBaRfhLvBJD2j01XeEUWx0HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bf/oj2FqtlBmXRSiWQfR3Ec/rgX8ajiUIPc5djbngilbKHmJ48oW2xwFJJE8sKVhiyHnDv2/vO83HmN0wQXRj+4VEVAoc4K4kT707g5YjH2tEvW4BeDQQ8R6V+OoHphFPx873ie3H2172hO+7mfdxvk3gZmVNetfLMQhLTDHdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey8YpAVS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ced6a3f246so65800a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730621694; x=1731226494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhrqh6evD3D/ak3hvNLHVK8bkDBFpxBe3o3ECuiVp2c=;
        b=Ey8YpAVS342ftRlJSblhVxX5lb9Lh9PfT95mciLmRdble/k0vjpipiWqnnq2FET51A
         jrL1n6Oerwk7fI2egNykI/kiMp7Us4Ayqgn2xLfe3GACd7cU5sorr+q2yW4JI4hgpZlS
         kVZ1lU27pWCLRuscGn/CxGxf1rbfZN5J/fjYLTi+kBLS9GPW363pHEGVK5IaMbtZmktk
         8Bg6KWdetypwgMqDUa4oxKnSNjkWhsAawuMqWT4DvH79KgcDXoDUG7HOb9oGJR4GvBK+
         WgQbVSgy5DRx1IMxpaV9Dky1d5D4w7Er4vAasvxRaX6XIXwmINYMmFvoNvtnSMgX6Opo
         b/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730621694; x=1731226494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhrqh6evD3D/ak3hvNLHVK8bkDBFpxBe3o3ECuiVp2c=;
        b=r3KY4h2gvsXSR4/381VKRjSpWYvcBI8weUiF9N0HNbbPnD8mDJhT9ISauWEkJ6pyV/
         fhX6c4KAfG8xMZvh3KF2i0YBhkmMETOHAkPTm+JMytIuOzszBMzqGSgbUxZ7znIlReVS
         +fTs30J56sUsPAYTrGkZp3j87ctRP5C16MLZ1zRO5KhduZM7aRQqFkhqMSR9gKVvyLz4
         Rmiqiy9xKO79NUqOfK3qiOuscSJ9MkkiK94VlDvvLCsuNO46ZDWE6/moqBeD8CD5ZwMB
         510sv97KeTOeqyzdal/IbbBxJxjy+QTzRcPYdY3ocCNjppEGjAIXrAaJh3uut2c1d2tV
         nS8g==
X-Forwarded-Encrypted: i=1; AJvYcCV6+/aTuUyF5hS2axv0/5v2TjJrfCDW9RU0OSt39JFo9BLISANGVYWox076L9AS4QlESo/IaT1Lu8/ieIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISCHLDBNWh66RFAOyD26FS7iIEWhm9MXTQftajdj13oGdkXWE
	TFeJG/aihue0hGFvM99UeANp8xJkubGYn8gXS7Phrk4yHbH8WvHB
X-Google-Smtp-Source: AGHT+IFrII9FEvZRo5zbQYZe/IbDfG8BuKA5hR8Ye5W9KT3hoFXbU5FmwNTOB6bH14GaPocg7JnF6A==
X-Received: by 2002:a05:6402:84f:b0:5ce:c7ca:70ca with SMTP id 4fb4d7f45d1cf-5cec7ca71a0mr3751445a12.34.1730621693485;
        Sun, 03 Nov 2024 01:14:53 -0700 (PDT)
Received: from kernel-710.speedport.ip (p54a0712c.dip0.t-ipconnect.de. [84.160.113.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac789152sm3097882a12.43.2024.11.03.01.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 01:14:53 -0700 (PDT)
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: [PATCH 03/13] staging: rtl8723bs: Remove #if 1 in function hal_EfuseGetCurrentSize_BT
Date: Sun,  3 Nov 2024 09:14:24 +0100
Message-ID: <9259ce43226333a4ab4ba400bbfcaa2eead3f5d1.1730619982.git.philipp.g.hortmann@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
References: <cover.1730619982.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove #if 1 in function hal_EfuseGetCurrentSize_BT to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 28 -------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 2659999404a3..49b6507f991c 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1028,7 +1028,6 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 		/*  only when bank is switched we have to reset the efuse_addr. */
 		if (bank != startBank)
 			efuse_addr = 0;
-#if 1
 
 		while (AVAILABLE_EFUSE_ADDR(efuse_addr)) {
 			if (efuse_OneByteRead(padapter, efuse_addr,
@@ -1057,33 +1056,6 @@ static u16 hal_EfuseGetCurrentSize_BT(struct adapter *padapter, u8 bPseudoTest)
 			/* read next header */
 			efuse_addr += (word_cnts*2)+1;
 		}
-#else
-	while (
-		bContinual &&
-		efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest) &&
-		AVAILABLE_EFUSE_ADDR(efuse_addr)
-	) {
-			if (efuse_data != 0xFF) {
-				if ((efuse_data&0x1F) == 0x0F) { /* extended header */
-					efuse_addr++;
-					efuse_OneByteRead(padapter, efuse_addr, &efuse_data, bPseudoTest);
-					if ((efuse_data & 0x0F) == 0x0F) {
-						efuse_addr++;
-						continue;
-					} else {
-						hworden = efuse_data & 0x0F;
-					}
-				} else {
-					hworden =  efuse_data & 0x0F;
-				}
-				word_cnts = Efuse_CalculateWordCnts(hworden);
-				/* read next header */
-				efuse_addr = efuse_addr + (word_cnts*2)+1;
-			} else
-				bContinual = false;
-		}
-#endif
-
 
 		/*  Check if we need to check next bank efuse */
 		if (efuse_addr < retU2)
-- 
2.43.0


