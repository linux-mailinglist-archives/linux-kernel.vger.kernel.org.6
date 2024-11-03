Return-Path: <linux-kernel+bounces-393858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA289BA669
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1253D1C2082C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C718870D;
	Sun,  3 Nov 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7Cwo7Iq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E418454C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648260; cv=none; b=dVdTIE1VmISY2fPvnzTebEux8WBkzZnYE5tf9f+WxQLs+Q5rlRkgBR9NtSjrYWiD/VRdit7PzNj+F51d52fUF6uQ8jAbC7hJ41OGsFW2SM9UlvBUEjFU6Dxj3K722gazLUwOYmp5XkgVLeSxx3Rk1BY280hZm7ShgzYQ37xpDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648260; c=relaxed/simple;
	bh=mae3Gh6or7JrLymWCsMNtNCARjI7LWkDxZrSIGAGP9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOsTd5BkSh+5SAT0//fdSaHfw5x3bprmcx6OTndGFwAV++JfeUPIUgwFOPb03bh3QZxopnV8sfqCMf+wMGYc1cz9WnKAHOlrJAXb30d7/bEqforYtDqeodJDfhfCIjuVycF+0lYGyNUKsszU9XV3NdyRxeoEb27A27EqJU5UtkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7Cwo7Iq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so5136925e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 07:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730648257; x=1731253057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHBiL2cbYeKB+zA3Rm2DZYzzZNQf7HEMbqDSolKWjAg=;
        b=f7Cwo7IqnJL3u+sJNnZ/mrQTdveT25RHiaYC98vcCT21BUoYf+5181bMt9jGMSeLTS
         I670mAjPl7GmVGNH8prCO1/mViZZtqZE//SrRtkWieR8KpP/mmw4sm+CzaWIydKsPGEQ
         K7u5x4hpiQusLHBO4Ts6tQej3wv8E6Dy70G2kO9r5ud7HQ0IcAzZvl2m/CwbvKY/syog
         qKS0dqDoObonPwleHuj//h8SakLo8jUqQYvoNmSw1J7WvX39OpzY6prpoPjPAN3Z8bXm
         Imt4dSZyQibNuv9f26jyyS7gLGe8ghyUsiQ4tmzZybTD4Hvi65PsldkzI624bgLnpEB9
         HNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730648257; x=1731253057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHBiL2cbYeKB+zA3Rm2DZYzzZNQf7HEMbqDSolKWjAg=;
        b=rwPptihbLgg9XBmcbHg0wx6SBvvl2UGi10rv577ctnl/KZMY6fxx6yeE1uCWPybWyu
         D7Tzu4/hCTb0XmMs08Wwjr8ugqcOu1sm+52hbxLrFVfGDVhP7cUic3g6ZrpKUg0++K0S
         Pyk9MRsJ2hfIQ5ghkVFXzpJH387qCUOBvRQAxIuJhwE5NqIE0UC9hC/f6OCpt8TYdvrQ
         D5EGuiZVdAKzPqMi7nENpuHvFwEiB8zoEMWHY+c/N2SwB3D7pwgJZhfkt2oIUOy9DoFD
         OXXsp4zQ06oLhB0J37JMYJ5nb9oyAKpVjUD2Ru9sPK9j86pBy1KX8BaRlFY/qW9Z1FKt
         fEBw==
X-Forwarded-Encrypted: i=1; AJvYcCXfn8qa/y/m3hdzY51jakpuoat0GMspfZcg91iyMOPeZIN/IPsGcrkWMYYFTQpqIXshPSSEl4g2SkLcZf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye/EM491WS2vgwsinQQGNH7TszTdhGlfOlN4SVHGo5VJb3bXID
	K4yLBlY5U0bo5JIHadJd5/jb03kUdzLDLiMm4tFWQSk0UmnN9luORtCXfp2vPLI=
X-Google-Smtp-Source: AGHT+IGrWk1s+VZRS752AlLgG5HEcggaOQzwvrY37xqZd3MxJf+L2u/ZJJ3HLdqKowifTP21joGJrw==
X-Received: by 2002:a05:6512:3b82:b0:539:9767:903d with SMTP id 2adb3069b0e04-53d65e16e31mr5415538e87.60.1730648256752;
        Sun, 03 Nov 2024 07:37:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce4fbsm1321133e87.128.2024.11.03.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:37:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 03 Nov 2024 17:37:30 +0200
Subject: [PATCH 2/2] firmware: qcom: scm: rework QSEECOM allowlist
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241103-rework-qseecom-v1-2-1d75d4eedc1e@linaro.org>
References: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
In-Reply-To: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3375;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=mae3Gh6or7JrLymWCsMNtNCARjI7LWkDxZrSIGAGP9o=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJ5i6aTmspQrArnd1R8cZ/mcHVMrANrvz+hRkP
 DOUF8ZUGZ6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyeYugAKCRCLPIo+Aiko
 1Q4tCACoIz60m8eY8oQTgYlihqjtE1IK7qkRW077f6ZGhrrN2zNZxzhRuE1wyZVHUP9pPTnl3pd
 jd6VBVDKDuO5AY7FGN6zrCV70cISK86X8DwB3PxC27KgmH2xg8EF88icMrEJ03QJUjSlR4044gr
 AlV1jxJF1BLoYLJKqdjRt81RnHg/nHCRAYEhxXNhH5EX63j2ngpcRYnsH6BpEDiLOy8tvsE2PMb
 5ZlSORscXTYBuLU4/CavL4lfrziK3d8ZwA/m6AkGS+Ct/1DC5KKnxxRl2JMwv7sa3qaM8sjQxcz
 DnXC1IKApNaTEa2TdjsHkuNmofNMOpljE4T0sakdzBVJRehf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Listing individual machines in qcom_scm_qseecom_allowlist doesn't scale.
Allow it to function as allow and disallow list at the same time by the
means of the match->data and list the SoC families instead of devices.

In case a particular device has buggy or incompatible firmware user
still can disable QSEECOM by specifying qcom_scm.qseecom=off kernel
param and (in the longer term) adding machine-specific entry to the
qcom_scm_qseecom_allowlist table.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 9fed03d0a4b7e5709edf2db9a58b5326301008b4..6f70fbb0ddfbf88542ff2b3ed2bc372c2f3ce9eb 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1743,28 +1743,23 @@ module_param(qseecom, charp, 0);
 
 /*
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
- * any potential issues with this, only allow validated machines for now. Users
+ * any potential issues with this, only allow validated platforms for now. Users
  * still can manually enable or disable it via the qcom_scm.qseecom modparam.
+ *
+ * To disable QSEECOM for a particular machine, add compatible entry and set
+ * data to (void *)false.
  */
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
-	{ .compatible = "dell,xps13-9345" },
-	{ .compatible = "lenovo,flex-5g" },
-	{ .compatible = "lenovo,thinkpad-t14s" },
-	{ .compatible = "lenovo,thinkpad-x13s", },
-	{ .compatible = "lenovo,yoga-slim7x" },
-	{ .compatible = "microsoft,arcata", },
-	{ .compatible = "microsoft,romulus13", },
-	{ .compatible = "microsoft,romulus15", },
-	{ .compatible = "qcom,sc8180x-primus" },
-	{ .compatible = "qcom,x1e80100-crd" },
-	{ .compatible = "qcom,x1e80100-qcp" },
+	{ .compatible = "qcom,sc8180x", .data = (void *)true },
+	{ .compatible = "qcom,sc8280xp", .data = (void *)true },
+	{ .compatible = "qcom,x1e80100", .data = (void *)true },
 	{ }
 };
 
 static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev)
 {
 	struct device_node *np;
-	bool match;
+	const struct of_device_id *match;
 
 	if (!strcmp(qseecom, "off")) {
 		dev_info(scm_dev, "qseecom: disabled by modparam\n");
@@ -1783,7 +1778,17 @@ static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev)
 	match = of_match_node(qcom_scm_qseecom_allowlist, np);
 	of_node_put(np);
 
-	return match;
+	if (!match) {
+		dev_info(scm_dev, "qseecom: untested machine, skipping\n");
+		return false;
+	}
+
+	if (!match->data) {
+		dev_info(scm_dev, "qseecom: disabled by the allowlist\n");
+		return false;
+	}
+
+	return true;
 }
 
 static void qcom_scm_qseecom_free(void *data)
@@ -1817,10 +1822,8 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed(scm->dev)) {
-		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
+	if (!qcom_scm_qseecom_machine_is_allowed(scm->dev))
 		return 0;
-	}
 
 	/*
 	 * Set up QSEECOM interface device. All application clients will be

-- 
2.39.5


