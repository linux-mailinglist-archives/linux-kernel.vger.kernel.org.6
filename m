Return-Path: <linux-kernel+bounces-418949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1CA9D67B9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F116131E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3817C21C;
	Sat, 23 Nov 2024 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yXkFRHZP"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A48173336
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732340710; cv=none; b=sCWi+xMarj9npv2VkJwT+CkYe9fwuofmKP16sRoi67uFUx+J3Re2yx036gRId8NtVEnvGO5xDcoGVawk26Qxc5BgkMVJYjfWf/7889q/5VcLqU/4eb5Gjc12FfkScuZ87eRRwy4LQZNi62icy93VtVzGFOAc/jeKU3G1vc3Wu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732340710; c=relaxed/simple;
	bh=RCQrEDg9Jf371ZVvZyxUNDcRd0dYuvhxst+HGMFH54g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JgWjjIQmmZQQG1KFdYCI0EoXwskcETivHcHtIRtb3aR+OXaRuc6txSKYw4gcxFzLcvV2oECy+jpfXDlbN6MHsQN6cQcQ5zOgDRfXfgALnmbS5LnKWMQo+imEjeOJo02oh1dh0Iko8q5kmAYrbp6XtbRWHBuqBmgF9ais8DHcHMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yXkFRHZP; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so1614976e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732340706; x=1732945506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DrDg8Sfy8VjRbQb9wXIsHbLpgOpk0bBFDGmPm833LU=;
        b=yXkFRHZPQPlL0FuRED/8VNXea9kevJTm/p2MnrA36V87TH24kyK/fSRUo7keOyKgYG
         LVlcHe1VQR7xr3Qcjxyo5t801U7FRqFWznGibFu5R5TzbuQLeKsgvDyUMi1bX5LEtj6E
         MZ6rSxOMex3SA+Tc5wcykSQpQJ9C8SJXqyS8qTFTAmY7v9f8hqZRu88BmIenu091GTAc
         X16jUUFn9x0T2RmUm9mFK+lmsAoNGAdm/M3/9dcxswkydQM+5qbanCuzxUpY/dX6KmUO
         i1QAXo8tdtnryykmRNgNceV6o1kl+md36vHOJ7W1juo1DhNbJ/UTTIsX0Te7fKt5TBix
         RCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732340706; x=1732945506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DrDg8Sfy8VjRbQb9wXIsHbLpgOpk0bBFDGmPm833LU=;
        b=ipr/1ACxAOaAAUNgI3yS6Ae+hgK5zL4AFNSMBBO261AJ2lz1P8x/AP0KLDNyoBO1Yt
         CBCnB8fsefxZLSXZ0PVQfQJG7x4oVtx3kVq1nM4DEIP+3PieGCvwv6UPZbxYlB6MWCBL
         Z5UIk/stDpszbJo225hBtyoLH3UveR+i2gLOEWs+14JQFEytFm1tDp/7peoOhC/O8AwV
         H0yD+4jvM4kIAOpTGQqB5F72hJv3i3od4ivgTxwBpamiNpQrJCO74n1SBqJsWT0MFTl2
         0bdbW6TrCorxTcgNvE/wHOp0ZldCBq0QoZwMQcjpH5s2cBmBpRboXG0lSTMUcBz4zoz4
         OpuQ==
X-Gm-Message-State: AOJu0YwWslwO5hRRKdeefRww8mIitbGpoW2lW1Xm5sExBkWRCGMdQpxF
	xwoCwsNaGyNWza8FqQG0I5SVyIsbKp1y7a624tTq1gnCYE+eDA9xPMZKzjtmftU=
X-Gm-Gg: ASbGncubKPef9jMqAzZM79vgXEowTRlWoOLk6N38Rv26doOT3vWEnnBkJLI/EP53WyX
	QXGC8oLjIjvO7Aek1D950xFtk1BVvRj/CSsT4gshSIEY6hKUM/MVPYLpyxcbJjM1LGU9Z27+7OY
	MJJCvTBFBuhTcigpv85D8LiFiObHlRqbKxEKhy5nonfmWw0wr0fVa0P9PDq0fubZDLX6bnLsmNm
	YRT5c4qNb6g3BmHypoUL15ak2mbpy92Q9coAPpkqgGT+DkTHFe7irtxQA==
X-Google-Smtp-Source: AGHT+IHNt5F2db538ToS6v4lWa1hIYzGmz2N5AfeJ0J+hmybh71MXci0fQWRwaxAHDyf839+P0+6rw==
X-Received: by 2002:a05:6512:3c83:b0:539:f7c1:5feb with SMTP id 2adb3069b0e04-53dd39a4b16mr2495567e87.39.1732340705843;
        Fri, 22 Nov 2024 21:45:05 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24457e1sm740143e87.34.2024.11.22.21.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 21:45:04 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 23 Nov 2024 07:44:55 +0200
Subject: [PATCH v2 2/3] drm/msm/mdss: reuse defined bitfields for UBWC 2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-msm-mdss-ubwc-v2-2-41344bc6ef9c@linaro.org>
References: <20241123-msm-mdss-ubwc-v2-0-41344bc6ef9c@linaro.org>
In-Reply-To: <20241123-msm-mdss-ubwc-v2-0-41344bc6ef9c@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Connor Abbott <cwabbott0@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=RCQrEDg9Jf371ZVvZyxUNDcRd0dYuvhxst+HGMFH54g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQWvaJC/hfMr53Xnp+aU8MlaVVv17sAyaPbzhy
 7IVBxOCTZ2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0Fr2gAKCRCLPIo+Aiko
 1dkOB/401lf+nszpksFsYEwE+4wZaylb0UuOyr6FiEosWoZPPznYOblrU4AVUIRMXw3X+cqS+cK
 jLxPa+zbtH+nUwqueapeeZHBZ6cjSuvYAvDUU77o/kz4/4gfdjyLSMvS2jJCRNFbvINciLFo78z
 soguSxPjKZ5eS+o4seBUMs6iuEGAstV1VGVfOI/tsTRWyCb6Wg1UxOpE8mIAgVz7SZhQOBtNjvQ
 VXCcQcK8JzupqDL9bJyAGAfGjKitrHrnzPpD2vopgG/x/WhsdtIGKevxK4aYoG5OhhG57xIe2ox
 AQWwwp26Gx5Tgj7y6lAtqfaiTCZLz5umIPQqiamiivqCkqLa
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow other msm_mdss_setup_ubwc_dec_nn functions and use individual
bits instead of just specifying the value to be programmed to the
UBWC_STATIC register.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 17 +++++++++++++----
 drivers/gpu/drm/msm/msm_mdss.h |  1 -
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 4b57f39bec4e6232a0f5b4d49f8ae1200e74ac78..2fdad0fa4bc159e9a10755da2c0402fd87734aee 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -166,8 +166,16 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *msm_mdss)
 static void msm_mdss_setup_ubwc_dec_20(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
 
-	writel_relaxed(data->ubwc_static, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
+	if (data->ubwc_bank_spread)
+		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
+
+	if (data->ubwc_enc_version == UBWC_1_0)
+		value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN;
+
+	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
 
 static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
@@ -587,7 +595,8 @@ static const struct msm_mdss_data sa8775p_data = {
 static const struct msm_mdss_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.ubwc_static = 0x1e,
+	.ubwc_swizzle = 6,
+	.ubwc_bank_spread = true,
 	.highest_bank_bit = 0x1,
 	.reg_bus_bw = 76800,
 };
@@ -638,7 +647,7 @@ static const struct msm_mdss_data sm6350_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 0x1e,
+	.ubwc_bank_spread = true,
 	.highest_bank_bit = 1,
 	.reg_bus_bw = 76800,
 };
@@ -661,7 +670,7 @@ static const struct msm_mdss_data sm6115_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 7,
-	.ubwc_static = 0x11f,
+	.ubwc_bank_spread = true,
 	.highest_bank_bit = 0x1,
 	.reg_bus_bw = 76800,
 };
diff --git a/drivers/gpu/drm/msm/msm_mdss.h b/drivers/gpu/drm/msm/msm_mdss.h
index 715e1426093de5a4f3b7d2b66b889573c30b7b5c..14dc53704314558841ee1fe08d93309fd2233812 100644
--- a/drivers/gpu/drm/msm/msm_mdss.h
+++ b/drivers/gpu/drm/msm/msm_mdss.h
@@ -11,7 +11,6 @@ struct msm_mdss_data {
 	/* can be read from register 0x58 */
 	u32 ubwc_dec_version;
 	u32 ubwc_swizzle;
-	u32 ubwc_static;
 	u32 highest_bank_bit;
 	bool ubwc_bank_spread;
 	bool macrotile_mode;

-- 
2.39.5


