Return-Path: <linux-kernel+bounces-255292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D6B933E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0756BB2392E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23F1802CA;
	Wed, 17 Jul 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="BGfINVfu"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0011CA1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226506; cv=none; b=RGC0pA0MEpEfx7hAUe049+epfnlkbjOaw/oP1X9S9qjuIK5qaS+SnD/xzvTgRljvt1FOXdbEnRR+fL5yG3Rx20Zqyr4r9oX9Tis3cSWOncC+7BYoLlL3bAbxOaakkqFqz4aAvPx8f0Ui+juhTQJr+gmhM3VEiRa6kV7wdDZq2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226506; c=relaxed/simple;
	bh=TXRdp4sLPyBjHireO5E8iSfsUYjYXhJMZ2bIi71ijzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDi+tpq8vW+ET4Q10djEz3EpFggXq8nN9Whc4chWoDA05XYJBbQDiJ6+jqeN8TOQdhckFjO+73g7IDGodjFBqs3/OXLvTBeHjxwWPXx3g4Y18quJNESqgmvHiB/EjbO073DsDftiAfA3QpeSC2TGjm1Ur68iI8bT7XyKRhLOaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=BGfINVfu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso8433461a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721226502; x=1721831302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQK8yMvfNSGnf1p8xmBjaXGXDPSD2BgTqAqf2SxlXE0=;
        b=BGfINVfuPc9G+WltAQ3PuAFpdgiVJEJI8hWNQq4JBL46op0Ym/CbkFDSjqcd2vbLp4
         uZCTS4bufuUAWUYGfOMz6JqmbwCaPR3j/zIItzUHbfG3SHt1sYjTssmbanfkcPY0vu4R
         /szyS2dQC/KQ8jFHxWL/8206Y+dRpQWd24bPnXvpDunxwPdOg95qM1aRTLWIMJ0onyJi
         BuYYo9AXpko0wGcmHQS3FuScDmytTtCvRHWbYmaJpaGvebFcul4aiwrVK3oa9P44hPJh
         7XzOQ0zStifrf4FHtLxpwKUq8fGR71b8lIoy6nfTSr+DMYkL+PW0/vSdT7mgyqsvsJxN
         BBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721226502; x=1721831302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQK8yMvfNSGnf1p8xmBjaXGXDPSD2BgTqAqf2SxlXE0=;
        b=kDDb9lV9z/9sENOzVteP/CW2uNTbHR3/m7SBrqdYb7oUXmiUPGL9boIKiOmFPdyYVV
         grnqywYBQsEwQLD7qjRzrQ95ddK/qbNd71A/7/nnhGtbQh8WRc5YXs1zCji74GmcPI55
         ZpwfSLXNexD0Cl7K57kMuMu7k8p8BTHshRq7oFm7meuvWXVGBQcIb97S92s9SIqRVZYr
         1xg7h1s+KzIYnsP4BnR13LfjeBG4l9VjRjaZe7DftVARmcy7bdbKM3GZ2Sj3LrX+hDvJ
         LogJ4+ccjTA7k1xJzK/pfSw5+scCBPxnVoGqJJ/yiNKDZHQVWleOIkVkYzh5VbIfm9S5
         AQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCXL7AoroEOrlUL/AknWLPqHrdHtHrIF4RkiAX0zRxnRpiMtbwrUo0S5+n+howsXEv+SVx0ywUu7CYwiLBUMlHkBt/q6/KNlB6O7pyhP
X-Gm-Message-State: AOJu0YwYmUe5iBHJazsj/a7LQO4ckM3PA3nlImolwkseRvQFSN/vBHIh
	lCJzlYC2yYtIgrP/t5npJG0CANTfdVGNPKc2yuULPAAjOBMj401YP4WVzKGXsSM=
X-Google-Smtp-Source: AGHT+IEK/bN6IEN43Wu/w+EWQWY6ZbHG9Yf5L4yiFAlZ6pQdzhejiqRLZguK2GdSYUetyx0LtYORFA==
X-Received: by 2002:a50:aad2:0:b0:57d:3791:e8e4 with SMTP id 4fb4d7f45d1cf-5a05ce11c1emr1053460a12.32.1721226501700;
        Wed, 17 Jul 2024 07:28:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6724:3f6f:5a36:d95d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b268a276bsm7011640a12.62.2024.07.17.07.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:28:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2] Kconfig: reduce the amount of power sequencing noise
Date: Wed, 17 Jul 2024 16:28:03 +0200
Message-ID: <20240717142803.53248-1-brgl@bgdev.pl>
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

Let's automate the selection of PCI_PWRCTL by introducing a new hidden
symbol: HAVE_PWRCTL which should be selected by all platforms that have
the need to include PCI power control code (right now: only ARCH_QCOM).

The pwrseq-based PCI pwrctl driver itself will then be selected by the
drivers binding to devices that may require external handling of the
power-up sequence (currently: ath11k and ath12k) based on the value
of HAVE_PWRCTL.

Make all PCI pwrctl Kconfig symbols hidden so that no questions are
asked during configuration.

Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
I'm sending it as a single patch for more clarity as it most likely will
end up being picked up by Linus directly.

Changes in v2:
- introduce new HAVE_PWRCTL symbol and select it from ARCH_QCOM
- select PCI_PWRCTL from the relevant drivers

 arch/arm64/Kconfig.platforms            |  1 +
 drivers/net/wireless/ath/ath11k/Kconfig |  1 +
 drivers/net/wireless/ath/ath12k/Kconfig |  1 +
 drivers/pci/pwrctl/Kconfig              | 11 +++--------
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d1461335e78f..53d9f4bfd6fe 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -266,6 +266,7 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
+	select HAVE_PWRCTL
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index 27f0523bf967..2e935d381b6b 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -24,6 +24,7 @@ config ATH11K_PCI
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
+	select PCI_PWRCTL_PWRSEQ if HAVE_PWRCTL
 	help
 	  This module adds support for PCIE bus
 
diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index eceab9153e98..f64e7c322216 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -7,6 +7,7 @@ config ATH12K
 	select MHI_BUS
 	select QRTR
 	select QRTR_MHI
+	select PCI_PWRCTL_PWRSEQ if HAVE_PWRCTL
 	help
 	  Enable support for Qualcomm Technologies Wi-Fi 7 (IEEE
 	  802.11be) family of chipsets, for example WCN7850 and
diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index f1b824955d4b..54589bb2403b 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -1,17 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-menu "PCI Power control drivers"
+config HAVE_PWRCTL
+	bool
 
 config PCI_PWRCTL
 	tristate
 
 config PCI_PWRCTL_PWRSEQ
-	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	tristate
 	select POWER_SEQUENCING
 	select PCI_PWRCTL
-	default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
-	help
-	  Enable support for the PCI power control driver for device
-	  drivers using the Power Sequencing subsystem.
-
-endmenu
-- 
2.43.0


