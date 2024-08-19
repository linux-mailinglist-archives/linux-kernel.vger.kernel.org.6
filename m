Return-Path: <linux-kernel+bounces-291685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823495658D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9361C21A95
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B115B97C;
	Mon, 19 Aug 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="shwREonM"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E315B0EB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055894; cv=none; b=C+l82WQV6NU0xynTTpoaoYRxKMiaOXmEeVFUmPRHOxfnJvtx4SnOFHdj3OCL7vtwzGTQfUNJbWNIh8/JbAEDEbzmbu8REx/GwlBVJrWsK0gt9KDbGisMqt2nj1ffkrpEjaxc272KE6OoEqoG97T981hlnuF8iQBTBff4Bs9+HLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055894; c=relaxed/simple;
	bh=VlEWS+I2qBUoAZu3MZiZFqikaq4uXZWuP6/ITJZxiQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQLQ77jcpDd9JbGJMi0SKo0oEyUwOz9mDBlRMYv0tZpVSPtVfDLWFaGClB/G3EjdIa1GxbBKrAM6HVUDawPzbSUiunl+uLfQbaLx2jWEeXNxeqMV0whjeILitcMZ/5nB+7SQ9Jpj4jEOo+e5kvh1UHBbFWKhfOHfVzFbjQkreHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=shwREonM; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37195f88a17so1914873f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724055891; x=1724660691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns4EUZZ3nTL5odSKliuQhTwD1CbjvkOmQ7rToMzAA/s=;
        b=shwREonM23gbHLe1N7T/9wHhpCdWBD+QzoZnEleGkDhR0J78aNDGBmKUm1Atx69m/P
         cfVD/cbkLRwFV2INk70RfEeBYrd55Gxue8+7OOaBgTm+/yZWivSbW9IAlfSvJA1oQwFj
         wSk0/M6YuABQ9RKPCI2If9ExNunKh5YHkEznfEsXmXIBhSLnZ4CHwjzl/4S0TV0DyL8K
         +BQyK1uXCOW8r0WWC1GfIUF5o/ruiteOWjZWWOBA7JanC+ZGU+YYbZt+SVXrWX/CPxHH
         5VZhHfE6cBz8OV85O39vZ2cpKAAMUeLMDng70ak/kC2sVCzHndIQhv36zkLSPvEa2a7o
         wWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055891; x=1724660691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns4EUZZ3nTL5odSKliuQhTwD1CbjvkOmQ7rToMzAA/s=;
        b=rtSy4P1nawj8bKHhfr1Kld058wZdQ7DZm10cQyfmc0e3xNbmwzyfdu4t5aTw6V9TvL
         v9PxXIt5XfBXUBY+TKOMoMlq3qrP5iOPZOp7yO5/q/VzooNnP3IyifTB9a4HZ2BCMP40
         CW3ju+0Ph8EVmdR0cm6slP/SHKG7sAcvzLL4XmcgnmQijU/zoQIFqWrJO88ADYeu68Y0
         ZB2X4hQr/Aik7/S9X2OQasX8ITwDx+JJt9JADWiM7q0TFW26Q6MF1Mkecr2y+EHe1Gll
         28scRFBJcd2EcBYLdCcJL54VfzQHm0zS0GYzMdtZHvamS+yqRflyiPKUxH7+9WZOSljI
         mEWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+RiVg42qk8cW2g7sDLCLQEd7B5i/R5jw/EdYqacVy5/bJIzWMrRxS54e0eRPPMLP/Mrs5zZycHoPA2NmH3c1qFeWIMsS74W1yb5bv
X-Gm-Message-State: AOJu0Yzh+5PfOwnyAFbDX9hRlIR5WHVo4iC+6w8sqHQM+9ncXgFHLDNr
	tP3UtkY3LNUiDGsfkqU4ES6p93BYQLMZ2rkJpVQuI///TtTXEq4+ci+bsiK6C6M=
X-Google-Smtp-Source: AGHT+IFVgF7niGJvoZowan0lPbSxtB3YSrW7+PmIqFLoVMhdafkr+QrJoILTdYPsvFiGEZpxfsdYjw==
X-Received: by 2002:a5d:6602:0:b0:368:3194:8a85 with SMTP id ffacd0b85a97d-3719431769amr7258735f8f.7.1724055890365;
        Mon, 19 Aug 2024 01:24:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:7b55:8f70:3ecb:b4ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded7d5a9sm153441175e9.43.2024.08.19.01.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:24:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH v2 2/2] PCI/pwrctl: put the bus rescan on a different thread
Date: Mon, 19 Aug 2024 10:24:44 +0200
Message-ID: <20240819082445.10248-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819082445.10248-1-brgl@bgdev.pl>
References: <20240819082445.10248-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If we trigger the bus rescan from sysfs, we'll try to lock the PCI
rescan mutex recursively and deadlock - the platform device will be
populated and probed on the same thread that handles the sysfs write.

Add a workqueue to the pwrctl code on which we schedule the rescan for
controlled PCI devices. While at it: add a new interface for
initializing the pwrctl context where we'd now assign the parent device
address and initialize the workqueue.

Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Reported-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/core.c              | 26 +++++++++++++++++++++++---
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c |  2 +-
 include/linux/pci-pwrctl.h             |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
index feca26ad2f6a..01d913b60316 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctl/core.c
@@ -48,6 +48,28 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 	return NOTIFY_DONE;
 }
 
+static void rescan_work_func(struct work_struct *work)
+{
+	struct pci_pwrctl *pwrctl = container_of(work, struct pci_pwrctl, work);
+
+	pci_lock_rescan_remove();
+	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
+	pci_unlock_rescan_remove();
+}
+
+/**
+ * pci_pwrctl_init() - Initialize the PCI power control context struct
+ *
+ * @pwrctl: PCI power control data
+ * @dev: Parent device
+ */
+void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev)
+{
+	pwrctl->dev = dev;
+	INIT_WORK(&pwrctl->work, rescan_work_func);
+}
+EXPORT_SYMBOL_GPL(pci_pwrctl_init);
+
 /**
  * pci_pwrctl_device_set_ready() - Notify the pwrctl subsystem that the PCI
  * device is powered-up and ready to be detected.
@@ -74,9 +96,7 @@ int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
 	if (ret)
 		return ret;
 
-	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
-	pci_unlock_rescan_remove();
+	schedule_work(&pwrctl->work);
 
 	return 0;
 }
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
index c7a113a76c0c..f07758c9edad 100644
--- a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -50,7 +50,7 @@ static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->ctx.dev = dev;
+	pci_pwrctl_init(&data->ctx, dev);
 
 	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
 	if (ret)
diff --git a/include/linux/pci-pwrctl.h b/include/linux/pci-pwrctl.h
index 45e9cfe740e4..0d23dddf59ec 100644
--- a/include/linux/pci-pwrctl.h
+++ b/include/linux/pci-pwrctl.h
@@ -7,6 +7,7 @@
 #define __PCI_PWRCTL_H__
 
 #include <linux/notifier.h>
+#include <linux/workqueue.h>
 
 struct device;
 struct device_link;
@@ -41,8 +42,10 @@ struct pci_pwrctl {
 	/* Private: don't use. */
 	struct notifier_block nb;
 	struct device_link *link;
+	struct work_struct work;
 };
 
+void pci_pwrctl_init(struct pci_pwrctl *pwrctl, struct device *dev);
 int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl);
 void pci_pwrctl_device_unset_ready(struct pci_pwrctl *pwrctl);
 int devm_pci_pwrctl_device_set_ready(struct device *dev,
-- 
2.43.0


