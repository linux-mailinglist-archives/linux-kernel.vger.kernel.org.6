Return-Path: <linux-kernel+bounces-262103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA41B93C0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DEC51F22318
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96838199256;
	Thu, 25 Jul 2024 11:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yr2l1lTN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58B481A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906864; cv=none; b=JoXZlFEUDADly5I0drglNo/hlvvlGfxqDqjvjFSHFxYTc5UlVpPiyp17Wsi7n9j4zNMRpIDL8+RDhJ4va4BZibJZNCdcNS20HydDlOY57/mhR7q5bD6Nde6jcgkH7qYkUgkJ+0oFLXSZxPBQ2Aojy3S1bCOC22w9y3HRIYzFjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906864; c=relaxed/simple;
	bh=+XTWa9hpEf4S+deZBp3LjU6C8IT8BthfSBNlMkyWCAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BmF+rnWy8VlL9d0RDwKhEZWok37trhTr2+lFjVpN2LHuWSFPhP2JciLxFNSFcCp+GeERbCiNrFT5wxSPTwyQADNzaawthmk5oyLJC1pUTu/WTlhrCbZ5XJYWZ4u25sEAG/Q3sasKn7B7y0T/wWhgXjFcmMm9/u9kJEBsWOWnRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yr2l1lTN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd530a4eso75808e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721906861; x=1722511661; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdP3yGNeewRdl+uUZaeGE/lFC2ApLtozrXP5QIFLxBE=;
        b=yr2l1lTNfAri2FZ8luzQ54uqifA+3b4q60BRXydEFYJLfBqQIeInqK2/QL/31oIFux
         jgRZ9Lss+Q+HlFREQY55BIYWVfmzhVTudLvwx34kxqc9oow98nEPCMPdJLFkssc+xdHS
         ZwKN6aAybei53R06GNH5skYV1fcdexO59GecRiT3KAuV5ODZNSUfFRpNACzT9rUj9YZX
         PW1F7y7+xx84FyGooAUYOBt0gf5g5etH3F8gyR0UhRZaGzhtOHfZUIWlcWSkxTFDojnM
         L3Mn1fdbVV1hgH+8t5znc4EXk0siV8VmSIjDw1T1cxDLAuh8RaY+ZuZdx+f5Pm4S5T/U
         J7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906861; x=1722511661;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdP3yGNeewRdl+uUZaeGE/lFC2ApLtozrXP5QIFLxBE=;
        b=DxYN+AkjNtDOgcwyEN4wG+8tXgBbUz/gB7G2mViSYCJ3kiv/kDR4zK3Dm3OiN5YTZu
         jYa6u8yNNojcf7VsjspZRb27Nf/DCdKgRcQffgnPkqdzW0Fk6ATWw4yTGQ45Xi3HIIDZ
         4fcRACgkOOCFHWLfIMb/Ia4YAk0a6u82R+PlB12FbtrOx0h4kDI8/pbrbQaydWojcfFg
         Kl0Cz+QRsXGKZle57RQc3n1Ayln4qc4BKuAc17Wq1xZLr/ozs63mn3g12b/iU7STnSN1
         XwMQ3idtk/jXczvXCDColukALGmbJlDd1nSnOo2JnWV8V8AD7QonS2kvO786liqlFBfy
         UOXg==
X-Forwarded-Encrypted: i=1; AJvYcCV8vu9sGS0WH5HPbctXsPCo6e5xDGaB/P4IwivBVN3KCk3UIIjrEeG14bKwYOxorLbQM3V+1Y8PFXqOWLOf5JJn/qbtNpf1vGWWazbE
X-Gm-Message-State: AOJu0YyohaYqhhiCV2sQ3hqqpH8vrVSQRBi6lvId6DKF2vHP/kkUAs9N
	1WarQwFyx2qCYBhAJDEg5S0WKJD7LqCsL6ucei/4yR+9rNuiZChyBfknRZOlp/qkUFNRlqJozcm
	Q
X-Google-Smtp-Source: AGHT+IFhbtKpxAHdMYK8H7+fG4jmhEs/+GrCat1GPYdIv4DpNNfgCXV9V8g1hKOE95kDn+bbcz8PyA==
X-Received: by 2002:a05:6512:304b:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-52fd60f4f14mr1053270e87.47.1721906860992;
        Thu, 25 Jul 2024 04:27:40 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5bc3e8dsm194177e87.5.2024.07.25.04.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:27:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jul 2024 14:27:39 +0300
Subject: [PATCH] firmware: qcom: enable qseecom on Lenovo Yoga C630
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-more-qseecom-v1-1-a55a3553d1fe@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKo2omYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcyNT3dz8olTdwuLU1OT8XF1jc0tLY+Mky2RzM0sloJaCotS0zAqwcdG
 xtbUAQvVTJ14AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=+XTWa9hpEf4S+deZBp3LjU6C8IT8BthfSBNlMkyWCAY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmojarqF0R/OZSmoYGrVDMvllZo7y5HQgCeYoT/
 eZVnpNt3dyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZqI2qwAKCRCLPIo+Aiko
 1dsyB/4gvN3N5LSDmUw7IC5bD8PIl396dkxFn/AMhhPoZ8vg3Ct4meoi3KYCIazx+L6ai/YMmNb
 KBnJudRmjMl2LMoW4henuOaGEHsMe0wU8zgTfxjDui5UZ0U4br+9xhRfp4+40AiH2KEnk6BZV/G
 bwE2gwovyZo3hTxhGNI1+MCtS0Zh9izACiTvxjBAJacNRLCUvB4oF38DwC06VNH2WJfiNpHKwjf
 5Jvq1WVtm7MKElFVTGxs7Wr0Xdfg5fZ/phe1xRrFgTGlMGVwvDDaAXutglem0miYiZVOO9ciZMc
 zxGTIjY0xifz8H6X08MSfZmOYyOCjPKEejePXCMefFo07d6j
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

qseecom driver end uefi vars access works on the Lenovo Yoga C630.
Enable the QSEECOM device on that laptop.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 00c379a3cceb..9b427bab2028 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1725,6 +1725,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "lenovo,flex-5g" },
 	{ .compatible = "lenovo,thinkpad-x13s", },
+	{ .compatible = "lenovo,yoga-c630", },
 	{ .compatible = "qcom,sc8180x-primus" },
 	{ .compatible = "qcom,x1e80100-crd" },
 	{ .compatible = "qcom,x1e80100-qcp" },

---
base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
change-id: 20240725-more-qseecom-379933b9c769

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


