Return-Path: <linux-kernel+bounces-558369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA41A5E4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3147AAD20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45D1EE7D6;
	Wed, 12 Mar 2025 20:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SU2fqUpt"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FA31EE031
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741809619; cv=none; b=PREbvxFO+0gC7O8GC2MAg2wtvFd/ifi8ttcH+jUSbOe7IRHiimTy98P26H8sMNvIu7GpWnlbKHjcGhq4X++vIC96IqGY7ZINi2W46hqMJR0bVaSQe/FQRrnX39eMEaPD1d1fSZNwBT0MtGhJmf0U4Vw1Ru2vXp5DquZ35XyDBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741809619; c=relaxed/simple;
	bh=0GWy3rp0F7KpgF0wRntfFfUSkJ3mXo1eZ4Tv31fz+NU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ARja3jSM/n7OXCbPE+Ktm/ITpaQ+2TS3TMT/CQT6RGEJQnT9Y9u/1MKDUlyYwZKNkvDw+dTNJyj6uKXqVBkn9u5pmniY/AXspm9avO12kmlYW2GkdS04W3PUEq7ziQo6DOXB1aMhtC/e6qTsVE7+6bxAb5hlJaGnwdiBkXicWpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SU2fqUpt; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ce15cc3so3312725ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741809618; x=1742414418; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VDEU9Q/7+kilAtJ4k6780hVL8+VoEsG1QL4aEk8tmxQ=;
        b=SU2fqUptnupcXjUcbadrvw6eLSxB+cksmDIymDFv7/ys4QqAfmEQPZIF084wbQZaT5
         RFZi+Zv0xnJFTOji8wa/4rgCuv6O9u+Io/uw9repBr3Bwv3JAU3sYIAXgHQSci9ByZ9q
         FUZYwJM3vkuJ2ZD6klEkZqRw2Js85KuvU34Q/+cDO1tHCCv8AWHLIpkqxAu3JtTJjoYI
         bGLVjaDz4Vyw+hth3Q0V0V8MmDS7p9sGtcUuwNhsLrr2bTRWrYFaLxnpOMq1kVltqUBU
         9o9wVetgRbwuRpBIS4hDBWUpATpi3scCgJ6qda8d1z6Z4/1T29nUsLfZtrDNFgLDj2sQ
         mIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741809618; x=1742414418;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDEU9Q/7+kilAtJ4k6780hVL8+VoEsG1QL4aEk8tmxQ=;
        b=kIoqKW2NOOA+kUvR/dLoKnTe6CXvEkXv8KsZ3nDHDb3O4Wb+EOsJudggDGOifoiMbB
         KjM8ckW5/itwletWCXxB8vqLm6e2FKQ1FKma0MwpFxJPHy1Np1n7GUTZi54R8ki/HT8U
         8faRI5/KAHo42eOfb/H/xSlWdtxSXLujDKzdue0tAwjh5H/qieLSyzy/cMBCD5fMYtaF
         gJfNiVlU/j/KdooEYIEVc4LDBFIe1zkGWhCrQogmUXP4KjBktmIhOxtlIJV2G6Y+NngM
         R8MSTFdgp7jnnCLZpF+p8tZtTztd+QS+y1tgDh7lRWlzKCBeFg4lPZwCJG2yisICfHIy
         lJVw==
X-Forwarded-Encrypted: i=1; AJvYcCXnQ/dAuqA3To4Kg2+5Gzjq+t4L4d5IP8sMqOdu5MST5HqZjlZUBG0X6ICjRDsnFK3PaFKMelFYgnA2uAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZrFPIA/EVf1/lRGak4BZhDsVSJ1pct/b9YlCvXVt4Re1gNnA
	AvqJlf9yjN73mUvb3z1VEDoQ3e2SK2ML0CJGzKWuzpPEWg9CtDXBhYqDQjVx52J8YCT8IK+BDOL
	FKQ==
X-Google-Smtp-Source: AGHT+IG+7wN0jLCNhozwudp+CmZ2bIOC2JWCQMC5PPVbBuF1mi37k+/+m0ELnNvF8x64iohsHTAqLd5wRsg=
X-Received: from plbjy16.prod.google.com ([2002:a17:903:42d0:b0:223:37b7:2388])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234d:b0:220:c34c:5760
 with SMTP id d9443c01a7336-22428c240demr280258275ad.51.1741809617329; Wed, 12
 Mar 2025 13:00:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 19:59:11 +0000
In-Reply-To: <20250312195951.1579682-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312195951.1579682-1-jthies@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312195951.1579682-3-jthies@google.com>
Subject: [PATCH v1 2/3] usb: typec: cros_ec_ucsi: Load driver from OF and ACPI definitions
From: Jameson Thies <jthies@google.com>
To: tzungbi@kernel.org, ukaszb@chromium.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, groeck@chromium.org, swboyd@chromium.org, 
	akuchynski@chromium.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for cros_ec_ucsi to load based on "google,cros-ec-ucsi"
compatible devices and "GOOG0021" ACPI nodes.

Signed-off-by: Jameson Thies <jthies@google.com>
---
 drivers/usb/typec/ucsi/cros_ec_ucsi.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/cros_ec_ucsi.c b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
index c605c8616726..d916893b8908 100644
--- a/drivers/usb/typec/ucsi/cros_ec_ucsi.c
+++ b/drivers/usb/typec/ucsi/cros_ec_ucsi.c
@@ -5,11 +5,13 @@
  * Copyright 2024 Google LLC.
  */
 
+#include <linux/acpi.h>
 #include <linux/container_of.h>
 #include <linux/dev_printk.h>
 #include <linux/jiffies.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_data/cros_ec_proto.h>
@@ -226,7 +228,6 @@ static void cros_ucsi_destroy(struct cros_ucsi_data *udata)
 static int cros_ucsi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct cros_ec_dev *ec_data = dev_get_drvdata(dev->parent);
 	struct cros_ucsi_data *udata;
 	int ret;
 
@@ -236,7 +237,14 @@ static int cros_ucsi_probe(struct platform_device *pdev)
 
 	udata->dev = dev;
 
-	udata->ec = ec_data->ec_dev;
+	if (is_acpi_device_node(dev->fwnode) || is_of_node(dev->fwnode)) {
+		udata->ec = dev_get_drvdata(pdev->dev.parent);
+	} else {
+		struct cros_ec_dev *ec_data = dev_get_drvdata(dev->parent);
+
+		udata->ec = ec_data->ec_dev;
+	}
+
 	if (!udata->ec)
 		return dev_err_probe(dev, -ENODEV, "couldn't find parent EC device\n");
 
@@ -317,10 +325,24 @@ static const struct platform_device_id cros_ucsi_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, cros_ucsi_id);
 
+static const struct acpi_device_id cros_ec_ucsi_acpi_device_ids[] = {
+	{ "GOOG0021", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, cros_ec_ucsi_acpi_device_ids);
+
+static const struct of_device_id cros_ucsi_of_match[] = {
+	{ .compatible = "google,cros-ec-ucsi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cros_ucsi_of_match);
+
 static struct platform_driver cros_ucsi_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.pm = &cros_ucsi_pm_ops,
+		.acpi_match_table = cros_ec_ucsi_acpi_device_ids,
+		.of_match_table = cros_ucsi_of_match,
 	},
 	.id_table = cros_ucsi_id,
 	.probe = cros_ucsi_probe,
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


