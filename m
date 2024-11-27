Return-Path: <linux-kernel+bounces-423550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3499DA999
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF80281C13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1C1FCFE5;
	Wed, 27 Nov 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z9cXHJaV"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8B1FCFE7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716291; cv=none; b=roRpMAIsJcoRCA1lBM50UgkC50twzzhESX1YqmZhpAyDPmN80JdwI1lNk444E2pKppnMA9EOS+g2fStxI69K+PDcUyQpS4qlo2sK1wTUCr3G0YyGASf21rNbRFyu9KdEbN22NEm8F9IpcYCKt7UInxsQhSZw7kGZN9ER45JHZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716291; c=relaxed/simple;
	bh=j/r7tlOBhSqvDAZQqbEkOH74xCu4+GFpAyrNIzQsn0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZu9kYh0EaW3q/CTYi8Nl7T9bsqs/mGvrjo2/7Uw9M5pIjIOHhz7DkuiX9PGFpleymJG6sCabFpbL9mf06MnF0BMdunM9M+awPKAjyJ9EyBIlhzjtAv77j2DeOT2w2Gr6z61L43uuXrMliRbhM5bdPRAjC74b3AVmqVm3IuMCSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z9cXHJaV; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53de880c77eso2712333e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732716287; x=1733321087; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cj3RdAA2oW11L1rsVwn6o6z2j90OzfOsfLaXzRjhaQ4=;
        b=Z9cXHJaVApO7KBIjb8VriZWSZY2VHVAyj07HMuOFJTd/X6Gc6THaKGQAy8ZSNLx5oS
         aW3tC4v8v3Ab6Ww2ESBmM5+ugEkNat0zI6hqtFxHku1zoYeQ7vhzd1Fh/i0/nKeybiuR
         dY5KfA38r3qsnegxtIZrAVXT9yYtDgozkhhJpgb6HDcyD+gnr4wf76XppHrjlER0Q62+
         DyWZIeri6mGrCV+Hx+1tqHOVQj5xHEBTLGasL65YmtjAit/SxV0e/HnupIWJ48FEmNuf
         SLSdM5kTNsRFkMb9qcChHrnTmNWQ9acsxReALrJXJ6xilAJAoQt2UYA5141/5G0YbZII
         8/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716287; x=1733321087;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj3RdAA2oW11L1rsVwn6o6z2j90OzfOsfLaXzRjhaQ4=;
        b=lMcVMFUqXcJ+SUI10ymGD6LMTF/Tp+tCct2QLMVmqgF09tHvwrR8yMmpzqjXFqB83m
         rLZ2LsyjMCLQl8D/883Idd+r+tTQW3JAtD3V6YnsmTFHdM++u6t2/wxSvK2a3MuNs960
         kIUOMkK61bUj/m8fDj0Zb3Mjmi9mGLc7GVAgRrllnGo2JbcBPbbrVfZwQ90B9tCmjQcv
         Dg8R46Bwi/VrDVCMs5CsFHvRWWWm0/dBM4e71RUD6pi7B/d65z1pB7BcHZI8Nsn8hyP6
         eUGUGCftCyhJV9RVKDdQH5o7qOu09G67GQEq2Btnz88zADzrgRwpWJidpWCNrGkn6puJ
         mt4Q==
X-Gm-Message-State: AOJu0YzmGEHZ7wihT4vCOdrtFw0kGQbS2kpQYrV2PHZHaxE3/ZLNxvqL
	vGrgoH6/IKlGq68wDx0VF6o7cyj9/7kiTenchQwlq7t+nXAz7L4nYMq4Zo3uCDBM0aU0sX3NuqI
	Y
X-Gm-Gg: ASbGncvXIaHY0CVzdviHCH0s1/g2zJu4bMQy1sf9W+pWRBpCySj0rUfSv0+4HFL4qso
	RP6B/t6pe5OFua49KrAiHTFZkNxVBeQMEIhsTE0aY+8/rNEZjvlcql6A6idfyrfACspakxx3mdb
	0G3oNmf+DOysnf4cMCBmUVcw8JJPQVNa2ubd2Sl26ANpYk3aspDt/pFc/XUMGX5fqZYQng9hLoT
	veW2HwMI9iHhVn0k+ZaSkD0Ivq0mgYeo15xEA0HMIzOz7YtSGaUCGETrA==
X-Google-Smtp-Source: AGHT+IES1062CY/G/9t7vwt21bCpj5sK+9j6rcr1i8OV4fv5+q2zxrPYrJlhKLBr8i6P7OKE9DzeEQ==
X-Received: by 2002:a05:6512:3da6:b0:53d:d3f1:1400 with SMTP id 2adb3069b0e04-53df00a9fddmr1895192e87.3.1732716286716;
        Wed, 27 Nov 2024 06:04:46 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd44cb7c5sm2157291e87.122.2024.11.27.06.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:04:45 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 27 Nov 2024 16:04:32 +0200
Subject: [PATCH v3 1/3] drm/msm/mdss: define bitfields for the UBWC_STATIC
 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-msm-mdss-ubwc-v3-1-9782a7c2b023@linaro.org>
References: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
In-Reply-To: <20241127-msm-mdss-ubwc-v3-0-9782a7c2b023@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Connor Abbott <cwabbott0@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5908;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=j/r7tlOBhSqvDAZQqbEkOH74xCu4+GFpAyrNIzQsn0w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnRybyfKvbdKfXJ0DLvdoqIRAKlJ2B6OknMxNSU
 Dd15IjeZ02JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0cm8gAKCRCLPIo+Aiko
 1WyRB/9Y8oSMZFWsyXdkiAczsjjNQjL9SZA3YaJDa297u5epzgVHL0QzWOB0ZrRC4RtgaLCb5Me
 1k+xLxO90GlxceFmCfW6Say7DbW5jWUSr8JBHLqMoARVf2YztyLkk1ls39DrLRIpSmhPlzMTisb
 nZNwVjTykxeynNx+2X5rcC90jYZDEybh3g4HgYhS5RFIGJC95tXKiH5/0uw4D/Jr1Er4WM28fkH
 L3Bf7dmcAPIIHfHRt+X7CVjuIBmXLxOp630D78hAhluowfxChHedn2cM/62zXzhNmGtU87XuL7s
 yfZitq6WSKgHpRSDQH5CezJC01DcFeifa8YAuXiJiMU4uwY8
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Rather than hand-coding UBWC_STATIC value calculation, define
corresponding bitfields and use them to setup the register value.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c                 | 38 +++++++++++++++-----------
 drivers/gpu/drm/msm/msm_mdss.h                 |  1 +
 drivers/gpu/drm/msm/registers/display/mdss.xml | 11 +++++++-
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index b7bd899ead44bf86998e7295bccb31a334fa6811..bb176178855cbe14386481d90bf70aa82be4d522 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -173,15 +173,17 @@ static void msm_mdss_setup_ubwc_dec_20(struct msm_mdss *msm_mdss)
 static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
-	u32 value = (data->ubwc_swizzle & 0x1) |
-		    (data->highest_bank_bit & 0x3) << 4 |
-		    (data->macrotile_mode & 0x1) << 12;
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+
+	if (data->macrotile_mode)
+		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
 	if (data->ubwc_enc_version == UBWC_3_0)
-		value |= BIT(10);
+		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
 
 	if (data->ubwc_enc_version == UBWC_1_0)
-		value |= BIT(8);
+		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(1);
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
@@ -189,10 +191,14 @@ static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
 static void msm_mdss_setup_ubwc_dec_40(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
-	u32 value = (data->ubwc_swizzle & 0x7) |
-		    (data->ubwc_static & 0x1) << 3 |
-		    (data->highest_bank_bit & 0x7) << 4 |
-		    (data->macrotile_mode & 0x1) << 12;
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+
+	if (data->ubwc_bank_spread)
+		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
+
+	if (data->macrotile_mode)
+		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
 	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 
@@ -572,7 +578,7 @@ static const struct msm_mdss_data sa8775p_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 4,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	.highest_bank_bit = 0,
 	.macrotile_mode = 1,
 	.reg_bus_bw = 74000,
@@ -590,7 +596,7 @@ static const struct msm_mdss_data sc7280_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	.highest_bank_bit = 1,
 	.macrotile_mode = 1,
 	.reg_bus_bw = 74000,
@@ -608,7 +614,7 @@ static const struct msm_mdss_data sc8280xp_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	.highest_bank_bit = 3,
 	.macrotile_mode = 1,
 	.reg_bus_bw = 76800,
@@ -671,7 +677,7 @@ static const struct msm_mdss_data sm8250_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
 	.macrotile_mode = 1,
@@ -682,7 +688,7 @@ static const struct msm_mdss_data sm8350_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_0,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
 	.macrotile_mode = 1,
@@ -693,7 +699,7 @@ static const struct msm_mdss_data sm8550_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_3,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
 	.macrotile_mode = 1,
@@ -704,7 +710,7 @@ static const struct msm_mdss_data x1e80100_data = {
 	.ubwc_enc_version = UBWC_4_0,
 	.ubwc_dec_version = UBWC_4_3,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 1,
+	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
 	.macrotile_mode = 1,
diff --git a/drivers/gpu/drm/msm/msm_mdss.h b/drivers/gpu/drm/msm/msm_mdss.h
index 3afef4b1786d28902799333ff66c8b3ad0ab77fa..737ea6c39271ca85ab82b72914acb9781a7a2cb3 100644
--- a/drivers/gpu/drm/msm/msm_mdss.h
+++ b/drivers/gpu/drm/msm/msm_mdss.h
@@ -13,6 +13,7 @@ struct msm_mdss_data {
 	u32 ubwc_swizzle;
 	u32 ubwc_static;
 	u32 highest_bank_bit;
+	bool ubwc_bank_spread;
 	u32 macrotile_mode;
 	u32 reg_bus_bw;
 };
diff --git a/drivers/gpu/drm/msm/registers/display/mdss.xml b/drivers/gpu/drm/msm/registers/display/mdss.xml
index ac85caf1575c7908bcf68f0249da38dccf4f07b6..6e9f81cd4690433cef58f2377a27af6b0bb01a47 100644
--- a/drivers/gpu/drm/msm/registers/display/mdss.xml
+++ b/drivers/gpu/drm/msm/registers/display/mdss.xml
@@ -21,7 +21,16 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 
 	<reg32 offset="0x00058" name="UBWC_DEC_HW_VERSION"/>
 
-	<reg32 offset="0x00144" name="UBWC_STATIC"/>
+	<reg32 offset="0x00144" name="UBWC_STATIC">
+		<bitfield name="UBWC_SWIZZLE" low="0" high="2"/>
+		<bitfield name="UBWC_BANK_SPREAD" pos="3"/>
+		<!-- high=5 for UBWC < 4.0 -->
+		<bitfield name="HIGHEST_BANK_BIT" low="4" high="6"/>
+		<bitfield name="UBWC_MIN_ACC_LEN" low="8" high="9"/>
+		<bitfield name="UBWC_AMSBC" pos="10"/>
+		<bitfield name="MACROTILE_MODE" pos="12"/>
+	</reg32>
+
 	<reg32 offset="0x00150" name="UBWC_CTRL_2"/>
 	<reg32 offset="0x00154" name="UBWC_PREDICTION_MODE"/>
 </domain>

-- 
2.39.5


