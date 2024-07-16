Return-Path: <linux-kernel+bounces-254022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A47D932A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A190F1C20C61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649C19E7DB;
	Tue, 16 Jul 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BwYbrj/n"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F819E7C6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143417; cv=none; b=U6pHcRgGp8vz63C1X3K4A+EaVHqSmWpNI2ZAL/ZxT+pL9T3oAGUkP34kJJQ+EyW72+Q9RnInZ3ZAx8G2OySRtJzTY75J09SAnqqZMcOMT4caddtjKn3bVKetS3vf7f28Y+AShjxUiXpDWotqxYE5y5S0WM8C4g+pfOPmu2sytpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143417; c=relaxed/simple;
	bh=bGn+rHjny5c1SxClfYzY2jWr2ZLUz5ncts1GzjAekJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfDeHT7oF8wqdVQtKygU2twASnrKPcr35sRkVCn8GnQrmhXzV9C6RXtx/1+3LWOJbcY9xihZLbu4CzE3p+hXcqDNvAYnGJ8pOh5snvRD7Z51+XKcMSTjgHcsKft0kPelW6dFWH1YE4lM4Bbt2sv9XdDdodjOERgKvKBQDrt1VT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BwYbrj/n; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-595856e2332so7382381a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721143413; x=1721748213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxoFfd3TTbAHl2yndd9wu69CQvAfo9xTQ8OCO+y4mlk=;
        b=BwYbrj/ntSqdom7U6NEJtmA0YVHsYbeTIchcm4Uf9CODIbNN1lZbFiMYlBMjvKRrhd
         cCDEYPtLhTCv0O2p81vkgrDjZEO2WbZKxI2RbVY35Kye1g6rfW5kYBG0X2A8EHgzRVEx
         vsxOwOEqq7v+CjGMeWmzpt3eWo3dQCvAYjn9m+y2elx04qN6Cs3UJ5WolFvID/x9w9k6
         LERFRjBMPVdb5BU7Zv4UykFrnCmiEZAW8eQlg0H3j8VrBjyMh3SQBPa8O4Nz8W2cbqOD
         1u1a/jR1AAt3NJXKvDs1tVYh224GpD4yowudI+L2imOUSPWTkwDuCYt3e/4IHGpUiEmu
         I/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721143413; x=1721748213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxoFfd3TTbAHl2yndd9wu69CQvAfo9xTQ8OCO+y4mlk=;
        b=gdSDA0mETAjeOqd80CEB37IS00m4rAKQy8s4xUk42fh2T2swf/2kIiN0dhUwtqVR8A
         9g0kUUYbvgHuUUU79YOEAz74516OkWekCUiaiJIh5jdyRLOtsloS5KBoOyINeuwDoKtT
         DHGkf3ikQfQRRm59+a3OI+pmgS3pYpBHAikRR/FfjVNIhaxNfwUo57um5uDfFfgcEioP
         NezwED3pVpzHNsgaP87gpDl7Ltw6257y3LAeVA2NFvPSAMGTCGY+Z7kYBB1rq9d2eq+C
         sddQxYlNVTSJwi1tbbtVo9YXdDJMy6bcElWxEwkuehNmZp/0q2+horm3rB44NQypJ7Hf
         P5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVQVuSFP1S0Rgm5quxbPbvb8edV5RpEY+mf5iLg38VGH/MDWHarBDNlVhcRT3x+IbBu0sPMmj1lxj1mBm92bI8XTbwUikpeg//PvL/f
X-Gm-Message-State: AOJu0YwX1mJQzzo4ydEFgzlicY9oEb11KHyx2Mtw6XiLscHDm+Gji5EY
	sHlXJS7izD1supiA0xgqDb8lt8ZaLs5u4a5zs63Neumhl97wTccxonF7729DfsQ=
X-Google-Smtp-Source: AGHT+IHrZNQzj825v+rX0fE3xtI3Zhmow/MvKLEWELV6f65wff1M5rMXQGR/8kN/c0sQD3CaC703UA==
X-Received: by 2002:a50:f694:0:b0:58d:d3f6:58d2 with SMTP id 4fb4d7f45d1cf-59eee83203bmr1687238a12.3.1721143412642;
        Tue, 16 Jul 2024 08:23:32 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3bd0:8776:e8bf:4da9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59e663e4a6esm1938627a12.80.2024.07.16.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 08:23:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
Date: Tue, 16 Jul 2024 17:23:18 +0200
Message-ID: <20240716152318.207178-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Kconfig will ask the user twice about power sequencing: once for the QCom
WCN power sequencing driver and then again for the PCI power control
driver using it.

Let's remove the public menuconfig entry for PCI pwrctl and instead
default the relevant symbol to 'm' only for the architectures that
actually need it.

Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index f1b824955d4b..b8f289e6a185 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -1,17 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-menu "PCI Power control drivers"
-
 config PCI_PWRCTL
 	tristate
 
 config PCI_PWRCTL_PWRSEQ
-	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	tristate
 	select POWER_SEQUENCING
 	select PCI_PWRCTL
 	default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
-	help
-	  Enable support for the PCI power control driver for device
-	  drivers using the Power Sequencing subsystem.
-
-endmenu
-- 
2.43.0


