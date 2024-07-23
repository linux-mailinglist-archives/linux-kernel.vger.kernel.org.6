Return-Path: <linux-kernel+bounces-259921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF346939FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5F411C22177
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F54D1534E1;
	Tue, 23 Jul 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlbZWANr"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CBD152E13
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721734117; cv=none; b=GYKxnxMfVcCCJlg+JnWMqqakLnitfdV0bjoRBwaY8hzBoEtv9hI5cqElNErS3ie9u9KCiNKPzuS21vhEXVnq7GpQkoUnA9IlJYnI3i/IqsHjvIFe872P5UXSiJdAtnOhZ4S9DQlW41iuzMGUeWYT+MhpP1cs4DgxP9g9MFXJ1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721734117; c=relaxed/simple;
	bh=K8AEM2mcq7TRg6o3TnsmrMLLHMy2YLDrxUEl2B8ISDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qQVgy/WKjQKy/iZGx/LUteL/Zl2lcypO+O54aexEc2g95nu4Wu1nuHeMOrKKCw3lliF0bCnTk29uRRZyyE6PoVcUEXbgjV1kQ29lasJpugpQBjMsSdhFZpGrITJKYzkM/K22R2ClKDlHRMpB8vkemCK7FpTyA/JcrYgLyzKBKk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DlbZWANr; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efdf02d13so4119676e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 04:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721734114; x=1722338914; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZZgDyvUnfIiK6dqjIQeqQjzwpl3uL+ejXAze6MYs34=;
        b=DlbZWANr6X17ZZ8x2GfwDIaIkMnzYX8emXvlDMT8xs74hKAfyKUJPsB+LKF6chaiPu
         GY3JaumDqp6KgX9B9UaXWtZCCU26JVT+NTOBoq64IUp0L5InpruJpzmHEcOmC27w0yNj
         3c/4zIpLkthofB3i9QdV1ZkcRMIkWP9vAMq9zb5JpUKG8NkZIzJyZqcXBJjNs8bF1NEB
         NDOnwHSn0Z0UH1qpRexeKcijPmgPvVaqm3DiFSqatvmIgdmJWYRTc1OmV9bgOQ7Fkszr
         Bfa7tNohuMHFG4fjLxvKUeMnf285tF6tqok00px8tNo5vmEWUPZ8OWc3yOC1YMMZ5qpi
         02ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721734114; x=1722338914;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZZgDyvUnfIiK6dqjIQeqQjzwpl3uL+ejXAze6MYs34=;
        b=cXwMXz6VHT4FoMaxcRHpZJz+fqZi2FqSvGMOau1qxjobBvsUMV9YOvhjQPKgyRIGd1
         H9ylqa2jCFXt/29cJvYD70gRo2LSdI9lwdN7U35Kz0mFQtQdwplbAG3huzlxywZ3Fcv/
         zP1IK6ME4luVx2mRT0wA4nBxDUm1ViA6eP8tG8GBtadZAzfku+wemolmCnZcItnL5McV
         ZNPb8YAdBzJvnR08Q4i/2Dm/QaZMzvmoYCDsgt+w6vxC2oNJFyCDoTivKYM2bNJnGc1C
         kYrzgDZq8Y4XR3wCEJjn2BE1JD0m6vAb05DZqyT7jv444c8by9GPrx9e/q+nRqvR7ZuG
         8uXg==
X-Forwarded-Encrypted: i=1; AJvYcCUC8aQJ9nZeZ26k9Y1jgo75noXfPmTvPLkVFs38MQl0dfsEBlZcJAoiz2EUdIRSIvp97GiE/KUx0s8e6tddslVtkzpK1wmQGvgL8Kjl
X-Gm-Message-State: AOJu0YzaTlbNGdet76Y3migVb1o859uGtAMGps1PL8pQ//8Og5zJ+4l+
	Tx55mMjmJZgrD9T9EOoL4gElo6leRTIMr8wDWg3lVBBWuwiCFkKSKF8Up7+Oo9Q=
X-Google-Smtp-Source: AGHT+IFVubN/sUs09LgZCr85LweF3Egl3m9RRTtlPTknXOo6pKP9yE7dJ4hjxxqhY445kGD9aO3Dig==
X-Received: by 2002:a05:6512:32c2:b0:52e:9808:3f48 with SMTP id 2adb3069b0e04-52efb6324b9mr7813068e87.21.1721734114058;
        Tue, 23 Jul 2024 04:28:34 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52f01552b43sm950871e87.286.2024.07.23.04.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 04:28:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 14:28:31 +0300
Subject: [PATCH v2 4/5] arm64: dts: qcom: msm8998-clamshell: enable
 resin/VolDown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-miix630-support-v2-4-7d98f6047a17@linaro.org>
References: <20240723-miix630-support-v2-0-7d98f6047a17@linaro.org>
In-Reply-To: <20240723-miix630-support-v2-0-7d98f6047a17@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=K8AEM2mcq7TRg6o3TnsmrMLLHMy2YLDrxUEl2B8ISDU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmn5PdmLn+ut8KKDLaNVqSldK+SAaGHcGmWfS1L
 S7AYxuFbPqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZp+T3QAKCRCLPIo+Aiko
 1eoNCACCP3gWdl0izQkBVAtQDuxk5bCB+cHV7onckMf0nzTbJQeQ8P2x8iCYUS0trR4SB5Z2jVw
 d/48dq7n9hnL8nne9bUzKHkHXtVHAXT/X2ly4rGd+VfgDbrGviAWWAE3850a5GpaDm5tx1qdSsB
 8EWy998PUbIsrBzmy64vjgRHpB45kHNFpoZNTFBdVGNGEOo2lIRFqfrXEz2YtfiIfVZkyAC4Ylf
 gT/1tLM6PwIUKs6TkAbQgZyxVIbcDZEMWYlg1bVIyQbMAFLtFPYU6Y9e9PgY9CaAnhFv9s43vMk
 NREG8kp8VtvzPbriVSqEKiVu/IMvgSO8EKWFPbPudPF/3YU4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Let resin device generate the VolumeDown key.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 3b7172aa4037..9a3fe610c937 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -128,6 +128,12 @@ pm8005_s1: s1 { /* VDD_GFX supply */
 	};
 };
 
+&pm8998_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
 &qusb2phy {
 	status = "okay";
 

-- 
2.39.2


