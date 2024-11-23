Return-Path: <linux-kernel+bounces-418950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D009D67BB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF47161434
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 05:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2A417E8E2;
	Sat, 23 Nov 2024 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si3ed5fP"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57866183CB0
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732340711; cv=none; b=kjR1ZgdlFvyz6jIzJfJ6PSEEGLWh5bfwCSa/feWfU2dx1dXGNUMEFKQf8FMV5OEmKN1e5xKAKWHxyZW3hhh2P7Nq/hqyC0ioseDzqcy0vo1FCYHvMRcrCxNAa+3rnJhBgj+DDiE6yQ5feSX3tM41njjfyo+Z6pRkvS3s4Z5OeRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732340711; c=relaxed/simple;
	bh=gdM2PmIA7KXreNC4e0p5DKW62M8digF3+8KzLk+7N4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DkEx3ZkZQXLd0Mazs+hpWA5rx/XqNab0GJ/9K7qqKpN3p2k5xcp+2gPpbqlo9/C8CRLvujpOtn4KCOvAXXdnNSDpQPJ69enBJ/q/o3kdZZLXwd/lYsbiO0v8feOgb4+HVxr4KCHED1DhIwqp/CvFdXLhQzlznNTjj4HLas7mca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Si3ed5fP; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb49510250so33753481fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 21:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732340707; x=1732945507; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hEtTqrfQSr9pI7m+IfwZIAeqdoTOG6+nBJQtRsFkFE=;
        b=Si3ed5fP8Jl1yKmDBEgE/N3AsJHJdM2K8JPCu4AC5mDd18vq9GFk4uhSbmWd50+ytf
         DCF9ixkD+4H5btZVMt6HqE3ukUvb5OCOLKSEYk5yDRJURtwjKHMNSNOdNg6vCT9WdnhQ
         7F0WRgczkS2LYSDchN+rxTbiCqn6q25saBGdrbdPRYh7M9/jjhQc0SA0HQOOzsBSqIUp
         rosZPl8pnPAeZMxykuHIEpAw3Gb7OGZKAYDChdt6sPR5bGNoCf/kjFsd6npCcnNbuwS1
         i258QwVUaspNyV0mTSMW98nRvwzrYcB5X8DKsvK14bogmM3GlBeJoGWyaw4DqVqLqwvk
         aC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732340707; x=1732945507;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hEtTqrfQSr9pI7m+IfwZIAeqdoTOG6+nBJQtRsFkFE=;
        b=jbcusvhRJ4bvuEun0x3WiQQY1Na2bntLH4A4S2ZEjo2AKuztuiFAehF90NAzl3OPbU
         7Q/Q2fYWmK7n86swD1jC/dLiS6LDKq2jQ3JD44mzvjoviIkXxMaati7Yr48Db1HUeAHd
         PvIGjiWU+g82R8KzoiuM/YvXpAxENGWRoWpIGbb7rAOjRnIBOUtG4Ye18SI2escCkWmS
         vSD6sp//zyF0P3JDGeZ1MaDRbBNeia8OIIhVTST+8sVUxy6KwX/kAMmSq8zdPsUtPVrM
         DCKxgDX0dpxv5vXkI8ehNAEFSeRcKtY0bJMaju6Pz6yhmai6X7ph4uxNjK2+D3Fuxjbu
         6x9A==
X-Gm-Message-State: AOJu0YxwyAkXqC7ZwWK5lmYA5pUPbgxUoMXqLVWIadxXX5oczG150uzk
	TCBJwnXFCd2AtxH9WeL1i1xy0Qssvqi7PY1noNqoiqLrXK7HP8OrG93rqqASFtI=
X-Gm-Gg: ASbGncsxfoZfDdQvgelz8gSIlzRSvZ9Xl7gKxFqfTiHLpIqovHUcxatb+Zcwu2vX9Fz
	KNCxu5gWdxQR4rnp1wNRF2bcOFAUUeTTL4mHyMRFphp7zz0Wm6Gr+I8NHlv9JRDPApCitZn/tRS
	fc11KSxo6gW6w7upksKxWgG4opmrXsP0BGbF+PkKRlgPKt6knzp6shWpFSMGB4uSmEAlDfSWVSi
	ggCHVpks/yYXuvhTRPdssnwNogFjdODIH1I4x2VK29cMGWEu5IFthSJuA==
X-Google-Smtp-Source: AGHT+IEJNfzSkuCdzOOYuqLdhThDbipynbQzrrmzQe+8Fcb8wjmn7htIVDE2uytHwA9HycVmGGo/ww==
X-Received: by 2002:a05:6512:3a8d:b0:53d:dbec:9fca with SMTP id 2adb3069b0e04-53ddbeca289mr516396e87.0.1732340707412;
        Fri, 22 Nov 2024 21:45:07 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24457e1sm740143e87.34.2024.11.22.21.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 21:45:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 23 Nov 2024 07:44:56 +0200
Subject: [PATCH v2 3/3] drm/msm/mdss: use boolean values for macrotile_mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-msm-mdss-ubwc-v2-3-41344bc6ef9c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2536;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=gdM2PmIA7KXreNC4e0p5DKW62M8digF3+8KzLk+7N4s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQWvaGO+Y6FoVYTBQaZpzt8UIWJKd7OgPZXoQb
 1CWB/ILgCCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0Fr2gAKCRCLPIo+Aiko
 1aiHCACm2sH3vJTnYnx5BmVp1ztQ3EUYnPTFk6PpxdglQX8AeznE9hDRIEelD+LPW43iHWofTU6
 pkI62suQqYHajFWAEqWMO18EwqVqy8xODNIIV0GBVjgYSpuWvZlSix4uU/5q/T/Kwi9ygdrhe2z
 sNdynfWUQE2Ey1w1uwdNpWI2v/n4ETEGp+y50kNNaroNRRgX0nJOy4Qt4zwdij2pr6Fg/QvqHi5
 6DpG0F50H4ZDjhi8BmRCgHDpijcmR2jRVWR9JaGB2LlmjHrVbRK0IiWFItjDK72fIio18UrkFxZ
 Ek0kVpOmVc/k+s/ED6PQDFAFrTg+2vnXABrRLWw9SGP24yXx
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The macrotile_mode is a flag, not a bit value. Use true/false values to
set it rather than 1/0.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2fdad0fa4bc159e9a10755da2c0402fd87734aee..2d9db179accb0fd8666fe80371ea44a1fcc15e1f 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -588,7 +588,7 @@ static const struct msm_mdss_data sa8775p_data = {
 	.ubwc_swizzle = 4,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 0,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
 
@@ -607,7 +607,7 @@ static const struct msm_mdss_data sc7280_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 1,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
 
@@ -615,7 +615,7 @@ static const struct msm_mdss_data sc8180x_data = {
 	.ubwc_enc_version = UBWC_3_0,
 	.ubwc_dec_version = UBWC_3_0,
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
 
@@ -625,7 +625,7 @@ static const struct msm_mdss_data sc8280xp_data = {
 	.ubwc_swizzle = 6,
 	.ubwc_bank_spread = true,
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
 
@@ -689,7 +689,7 @@ static const struct msm_mdss_data sm8250_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 76800,
 };
 
@@ -700,7 +700,7 @@ static const struct msm_mdss_data sm8350_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 74000,
 };
 
@@ -711,7 +711,7 @@ static const struct msm_mdss_data sm8550_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	.reg_bus_bw = 57000,
 };
 
@@ -722,7 +722,7 @@ static const struct msm_mdss_data x1e80100_data = {
 	.ubwc_bank_spread = true,
 	/* TODO: highest_bank_bit = 2 for LP_DDR4 */
 	.highest_bank_bit = 3,
-	.macrotile_mode = 1,
+	.macrotile_mode = true,
 	/* TODO: Add reg_bus_bw with real value */
 };
 

-- 
2.39.5


