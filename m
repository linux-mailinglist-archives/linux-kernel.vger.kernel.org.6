Return-Path: <linux-kernel+bounces-393857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CE9BA667
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDEFC1C20D2D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6D187856;
	Sun,  3 Nov 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzevnEA3"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30924175D39
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648259; cv=none; b=Z3Zozu0QNabc/ByIrRKD8J9jDON0aR+aPIDlklXJ2jtK/FsXQ8iljAWSFSPZDAXAL/grDf1fus9DzMtj/wZXZVdorngYv4IMVwtJVMqmLHIRNZTeT0ILmKcWFJi5q8a3QyvI1balUH3DTMPZI9Fx2s3eDy8jSiPzPVoP6E6v4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648259; c=relaxed/simple;
	bh=sw8qDmg/fpdLnRt0QbNfK7Tvz/5Vb2q/W5NquGgNRVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SNm8O2qqo9RLVbKvJatoojcw5lvpvjliZ0IZfPOGgHp0idf0MjwxEoLo24Qqxht3/GDLLybOSRpTS3zckIGWMFk8tFwDjF+TZ71SXshmhfSzWbQ+18XRp0lPCbHeeraLI3gsFlstRX+wo0eFd/Htzg3uSq+A6o2s8Gzg+Cs6P4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TzevnEA3; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe76e802so4052122e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 07:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730648255; x=1731253055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rBtSxH+nRblxK0rTBEsk8wDwXuSSuDQ0C3QTkMi0+c=;
        b=TzevnEA3W8bavNN/EKB/QdC8XCQYPIeKFongK507BIu8eD50IeagtzDjG+QayE4CwZ
         pRs8hyG15otjeGQbMbPL+RQyL5I/DvyE6LWNXIP2F1yeQRne8XXaOKglotgsRk89baUZ
         xtq9/8QJZQXRTPFQQB8eosgctpApc7EZrq+mtwSTGXmqaiD/VIMpj6XvuIlhd3hHrtvg
         pvgeYRNdccwE4dmnTtxFr+pwZVDMcKPboGTjKu9ha6WmkjHbruBEAt+M56dZ1UJrpPpI
         qkAx2C95OQvjwzoruHQBbmOkDGRl+N5yKVYRz88MfwOyDKJQaSkkizf/y/3dVE/uS+0t
         EHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730648255; x=1731253055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6rBtSxH+nRblxK0rTBEsk8wDwXuSSuDQ0C3QTkMi0+c=;
        b=iVSrkMahHZTCabgrGQeZ07WSRdbHPU5dSvELYVM2LXVgVemLypzAMoPmy7P5H2A+ef
         6IH+7xR48WYEtb/6DQjPHEdbm864nNvdNEJSm6j4WjPie+fy0Evg8fW9XgaV+TvlXaQd
         G0Pr6dBQBttuqyf2LjLbPhClTJ++NXr4c2wGv9aLEnqyYDJR0654Z5X+Z6Bze+zx6+2R
         SSom4L++meleEyRhoTTuXEif9YZNeNhvwPCd4pYxR7b+Rd5z1FmLdsW2eHxP6g67RrL1
         WGleu/2riiTwj8TqFr5N9sGYdEb2COsNPzCS3bS15m/8GOOTgDSPNxas9l7f0LkeIruN
         o32g==
X-Forwarded-Encrypted: i=1; AJvYcCXAWuEuvqjm0ADweIsqvgLtIB11tTOMmwUqUIenFAWNcU+Ga153W3aehPlAoZVh6WR0GrcMzHYlfduOCCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5fYYPUkjGhfH82RNRQ60p21cNr0bmHBc+iiIUCikGaV8mqgU
	HSTEryWySR8U5VT98SdW69D26lQzUipt7xvGwxquP7rOuz9IBGsaG1Ttr45nOsg=
X-Google-Smtp-Source: AGHT+IELXtJDR4+8b0XHAj6OvRNeBjogWCkvRsCEPs881Boox9IIZGNTUcfx9zV3PZ+sUY+jBA73VA==
X-Received: by 2002:a05:6512:33ce:b0:536:7a24:8e82 with SMTP id 2adb3069b0e04-53d65de4988mr4332637e87.13.1730648255202;
        Sun, 03 Nov 2024 07:37:35 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce4fbsm1321133e87.128.2024.11.03.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:37:34 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 03 Nov 2024 17:37:29 +0200
Subject: [PATCH 1/2] firmware: qcom: scm: add modparam to control QSEECOM
 enablement
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241103-rework-qseecom-v1-1-1d75d4eedc1e@linaro.org>
References: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
In-Reply-To: <20241103-rework-qseecom-v1-0-1d75d4eedc1e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2753;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=sw8qDmg/fpdLnRt0QbNfK7Tvz/5Vb2q/W5NquGgNRVw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnJ5i6PbyX3LbrCM8bdBp6waXJ/6gErOoy8fFEf
 wy2jBKsJ4iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZyeYugAKCRCLPIo+Aiko
 1bdvB/4viK378touiBV3Ea8U8V53xptxxPEMK/v1ndWvX8gjI7HbWYmCUH2f+UZx63oe2hdPBxZ
 IFz85s3PyCbNxfoS2wskEmTPJJnsQQknb9Og50Ek3vOJzwIKmht3nUqqHw/hy0kmyb5BtwtZ4SB
 D28u/YMoFLVpQ7aSoHLzcM/c6wNgKx0oh3m9gmk3jLl8yTncju6D4L2wje0MOi2SIZLXxtX3EJR
 f0pHpEJhzQU+WpR4RREyjkeCB6+hlln+KV35ebPjuEPtBVmS423ZXtLIdI15ImxiPVhfmIRDJxd
 Tw1L+cXnOLB85iKSBVAk5JXzqKaPn3CIQVIn0Zt63AXv8oKP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

In preparation to enabling QSEECOM for the platforms rather than
individual machines provide a mechanism for the user to override default
selection. Allow users to use qcom_scm.qseecom modparam. Setting it to
'force' will enable QSEECOM even if it disabled or not handled by the
allowlist. Setting it to 'off' will forcebly disable the QSEECOM
interface, allowing incompatible machines to function. All other values
mean 'auto', trusting the allowlist in the module.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 47853860422525da79a249824afb45f6801151fd..9fed03d0a4b7e5709edf2db9a58b5326301008b4 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1737,9 +1737,14 @@ int qcom_scm_qseecom_app_send(u32 app_id, void *req, size_t req_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
 
+static char *qseecom = "auto";
+MODULE_PARM_DESC(qseecom, "Enable QSEECOM interface (force | off | auto)");
+module_param(qseecom, charp, 0);
+
 /*
  * We do not yet support re-entrant calls via the qseecom interface. To prevent
- + any potential issues with this, only allow validated machines for now.
+ * any potential issues with this, only allow validated machines for now. Users
+ * still can manually enable or disable it via the qcom_scm.qseecom modparam.
  */
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "dell,xps13-9345" },
@@ -1756,11 +1761,21 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ }
 };
 
-static bool qcom_scm_qseecom_machine_is_allowed(void)
+static bool qcom_scm_qseecom_machine_is_allowed(struct device *scm_dev)
 {
 	struct device_node *np;
 	bool match;
 
+	if (!strcmp(qseecom, "off")) {
+		dev_info(scm_dev, "qseecom: disabled by modparam\n");
+		return false;
+	} else if (!strcmp(qseecom, "force")) {
+		dev_info(scm_dev, "qseecom: forcebly enabled\n");
+		return true;
+	} else if (strcmp(qseecom, "auto")) {
+		dev_warn(scm_dev, "qseecom: invalid value for the modparam, ignoring\n");
+	}
+
 	np = of_find_node_by_path("/");
 	if (!np)
 		return false;
@@ -1802,7 +1817,7 @@ static int qcom_scm_qseecom_init(struct qcom_scm *scm)
 
 	dev_info(scm->dev, "qseecom: found qseecom with version 0x%x\n", version);
 
-	if (!qcom_scm_qseecom_machine_is_allowed()) {
+	if (!qcom_scm_qseecom_machine_is_allowed(scm->dev)) {
 		dev_info(scm->dev, "qseecom: untested machine, skipping\n");
 		return 0;
 	}

-- 
2.39.5


