Return-Path: <linux-kernel+bounces-553221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A6DA585D8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC7D18809C0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF361DE2C4;
	Sun,  9 Mar 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX+nXnqx"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5F632;
	Sun,  9 Mar 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741538080; cv=none; b=qvL4jV1l0eg8po9ts/uguuMrYmPUStx/ijc9WDVz9+7RADGvQ53Tp7nl6uyv0KNN8WMKpRhlbO5bWu/hKyXunEANL37fJs6usbdU6WhASmI4zts+UIZ6A0Pu9/l5ppJAtv0J9pHSSb7jl/TBWQFaZvt9PsJ6LO8WIMmQlkDK21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741538080; c=relaxed/simple;
	bh=xpllkjNVrgJ0iZIu22DmxPVlFUpujDzfh1xh9rScFXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LnYhfEFash+gjYqnE70Pcy3wDZtsLXr8dCa9UHJFj5G7ZISrjIR/MbGFvAFQUVIp4nXLBhLnzq/rfHQsOHy1HOAQf8OxH0vlXiKvrX/yMthY/pie8z2jU9dcG/zGyddNnXfXETIIQPdPG1NX/WuWO13A6AxDJL6l11sh7ZEShX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lX+nXnqx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549be93d5eso2998242276.1;
        Sun, 09 Mar 2025 09:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741538077; x=1742142877; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz4EbdwAmmH+Q5PNAQemsQ3FNp00gePnRgO4RO5D6xg=;
        b=lX+nXnqxI6EopeuoVX/sBK0g+Q9ZXcaT5NseMV8Qrv90aE4NCm7+ZHYjyC2QjBS2sJ
         EDXqECCIHWv+d5IvuMS7lhlgZ+9vMOoa1Vmure166yeW2fLRSYgVUzzkCrqduKwp9AzV
         Quz5SylrZDE8Re+JTBQz2RnV9LHfs+JG5o1KGAMWJhblPtIOArAAdmRhoBl7a1OJQhz9
         DBgI8VtJYVyrwY7upc8A09T2vuX9UQryrqehOoF1aPa41XbBzRgx4ytCy0ycChFOwRca
         GfxYSbDtonEG0FuaSLJmxPbK7F0TFMurCYz3o/6fCVlN/bQRv9DBqz5VHu5cB5UcD9KW
         K8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741538077; x=1742142877;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz4EbdwAmmH+Q5PNAQemsQ3FNp00gePnRgO4RO5D6xg=;
        b=aLbe8lO1krs5JasFDM8t2V9s67RsBblyNax6QtBWpHGu+7J/Tg0zrp2OSTBw0dZUtV
         3rxzKq/2Fe8b5kYod1Etc34sxRf0DHuwBwYJc7AS4WEjPMcRypZbdmTcxCIKHrjFR2Qs
         5M7awzK43wjtA5ecf0CxYN2oTdBVyk9xh//xQPpeP4wFaK+1CLfOkesnhDlD8TK6mOsX
         d6EhxnxnDL+vE7VbJNG1zKt0SQYhB89LKP2+Q3Vuh6on0Vm8dwdMRMRaeazBzYPMit6E
         O+C989C8Un3QaHbwaEw+sJagJYsM2f+2Nbm1oJCZxdV/YKV4alKlINX0aiOVRgJezFQG
         mANw==
X-Forwarded-Encrypted: i=1; AJvYcCUPjajuXAbmb+LS5LJ+/7Zyr22fGSP7f5sw/PBZ0szM48LNXrjqOeTzp0YaSO5HgGnBUTXv76EuygfbHEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya43FGIUt+fledsNtbxAJlzC79/9g9CiDoLfvTJntEZGmmJvT9
	L4hHms+mSu7NJQA/C70rUEuesDx/99FLBYTaQd9R6uNx5wSwy89K
X-Gm-Gg: ASbGncvTFXNvtiFsGSGurPXTohEnFkfDxVF+ZWpmfVKUA8wSv9kY7YnjAPHRdGu5N/+
	HH6//1arT5oUPPQ5bOyo1WDbeCQLdYJoQgkFXVBxXZUpJ0BPfjWCH4KQSmtGcSt91P4j5lqnpZ2
	PR6q1HcAesYRXAQcvkBED0qOv6uXz4g3zS/SnlZ7vXrPUiMWdivselWxhUMN1nGI1kQa42N3ZBM
	gB7imofXrGcxKfXEeO9hypcJe/xSFtcyNGb8WQ7Mq+RAdsJzgoHrRVDXMVzqpJ/CgEfXKNNENln
	QExV/Kr5jMl4yUaFtROVx4BvXDglCXSiyRAzhY0mJ069fg==
X-Google-Smtp-Source: AGHT+IGT83w25Qpcuu0mcy9mL718T06iGF91r/pIkU8OkPtpl59MUlGAPtjUuG6wwqOIcsC+qTfuog==
X-Received: by 2002:a05:690c:3706:b0:6fe:b88e:4d82 with SMTP id 00721157ae682-6febf3c011emr129998527b3.28.1741538077388;
        Sun, 09 Mar 2025 09:34:37 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c2e86bsm16988037b3.79.2025.03.09.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 09:34:36 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sun, 09 Mar 2025 11:33:52 -0500
Subject: [PATCH] platform/x86: dell: Fix ALIENWARE_WMI dependencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-dell-kconfig-fix-v1-1-38a2308d0ac6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAO/CzWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYwNL3ZTUnBzd7OT8vLTMdN20zApdkxTjlMRUEEpKUwJqKyhKBQqDjYy
 Ora0FAKmWyxdiAAAA
X-Change-ID: 20250309-dell-kconfig-fix-4d3daedaedbf
To: Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

If ACPI_PLATFORM_PROFILE is selected by ALIENWARE_WMI_WMAX, the former
is forced to be at least =m, because the latter is a bool.

This allows the following config:

	CONFIG_ALIENWARE_WMI=y
	CONFIG_ACPI_PLATFORM_PROFILE=m

which causes a linking error, because ALIENWARE_WMI_WMAX is only used to
conditionally link alienware-wmi-wmax.c to the alienware-wmi kernel
object, which might not be a module.

Move the ACPI_PLATFORM_PROFILE reverse dependency to ALIENWARE_WMI to
fix this issue.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503051819.bQ9P70Og-lkp@intel.com/
Fixes: b1b8fcf6e677 ("platform/x86: Update alienware-wmi config entries")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index f8a0dffcaab7c3b423472c5b9093011334a698c8..87c2ceb12d48d610c85fa739abbc4f0d88e33ec8 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -22,6 +22,7 @@ config ALIENWARE_WMI
 	depends on DMI
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
+	select ACPI_PLATFORM_PROFILE
 	help
 	 This is a driver for controlling Alienware WMI driven features.
 
@@ -43,7 +44,6 @@ config ALIENWARE_WMI_WMAX
 	bool "Alienware WMAX WMI device driver"
 	default y
 	depends on ALIENWARE_WMI
-	select ACPI_PLATFORM_PROFILE
 	help
 	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep and
 	 AWCC thermal control capabilities.

---
base-commit: e57eabe2fb044950e6ffdfe01803895043dec0b7
change-id: 20250309-dell-kconfig-fix-4d3daedaedbf

Best regards,
-- 
 ~ Kurt


