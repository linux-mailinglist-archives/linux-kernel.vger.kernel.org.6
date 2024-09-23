Return-Path: <linux-kernel+bounces-334791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A997DC30
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 10:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CC81F21BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C862916DEB3;
	Sat, 21 Sep 2024 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgAGc/r6"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B516C453
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 08:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726906667; cv=none; b=qNCzYsOgUMrwS1IoQhyl+TRAr0JbdyoPlLp6dW3j9zEoRRD1axSPjwYfs66EpeZyG+HfmBF483YgkSNN7zl3saATZSky8pdlU1OqAjegwjhENXDxXpOkGTwyFIG6Us9Hcf0G8lo/ic3O/IVU7N0slzqjTcAZTeqanm+VXFBnHaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726906667; c=relaxed/simple;
	bh=ScCRd7+z7cwAGX0LzQnkBaj1sUTBN7g+ylhI1wBf8No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7caA8GAB2YDObqJpmy6eiNqt4FoXjaiSvhAjRoIFBD/Ef6WaOc0K9ePKi6w3rcZ27rCWLQU9YYyooyDmaxe19KIIlC4l+kr5m311lw0gid2aVwgpAddh0YeUZkuU/yHCmYtKy76eFxxATZwnkxedwYsAKugNs6jD1jl03H+Oko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgAGc/r6; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso31217751fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 01:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726906663; x=1727511463; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVsyILzzvjiOy2yaVn/07EEy8eWz3i45ZaANjyZGvio=;
        b=FgAGc/r6hwECoNVRH2jY/GLNV6Euzokvoicg9b4kf8Q4uWunuFtmN1A/CMWijzQRC+
         ZaOha+cA77nYgaZxF7vRf8W+LDab0uVOJa3JVOat4SsgV1NInJwdNeq+LYjC5wCsOB08
         R2Krb7pHj3WltBQerXzi6wKSFpjliAiLoMROecUhToSYj68hCS5s05kRc1b9LncdA0vG
         qseqR60LjwsBG3l85Pu226YoDhuWpRIYy2RmFbZU1mQZaO7qZRVYeup1YfoPqxdZSId/
         dX9MSOAGR7Ms4f3wjb0W2Jrk1lkE1i8JAQDiBP8J0mGlYvuikwqcNRNBiija0hjETCWg
         FLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726906663; x=1727511463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVsyILzzvjiOy2yaVn/07EEy8eWz3i45ZaANjyZGvio=;
        b=sh/PsuhcWLwLixvI5fTaUN29yquOCAeEtBQPPlo7KbeI8UAffNBtWpDckBz+zOMAfD
         NgpBRIJe+IsccGepwEaL5xnfSQvl9voGLNCrKhZ30UXNMlkaUKzFOB+a53g7wY8QJJA5
         SYmB+MY/bzTUArdQdjMRUUqUdb3CNYaQIC2e1OvobvlO471aifSP81JT/uDumT/KY+Tv
         hQEHUq1w4ShSC0pwiNVhNtYQKcgkBV0vX7mQku1TRfalHT+AVf/jTcwCJhv0fyrAUYkN
         HfQwunY148qsdhj/Gm5BhtHhOl0LTmO1+tCO5HoeuNSps4EAA6tNQ8Ofh7SR7oOVjJYN
         GQJg==
X-Gm-Message-State: AOJu0YxLw77IAqq1sZTGqQuObzx5St/t22jiNqQyrDsu7kBCVWK4hnzo
	TQiVN0gBSe8Kf9jd5fKpT8k30+zQ2V7/nZje6ehh0z5bJa2KHSir9nUknAe6CSo=
X-Google-Smtp-Source: AGHT+IFPY/W2L+v0opGRZsevBEm6pIXjNTUdy2RRjJsvIyR13eOixR1PdLXWb9cbd5UYsG/wDpqcXg==
X-Received: by 2002:a05:6512:1095:b0:530:e0fd:4a97 with SMTP id 2adb3069b0e04-536ac17ba54mr4389006e87.0.1726906663478;
        Sat, 21 Sep 2024 01:17:43 -0700 (PDT)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968d1sm2466380e87.175.2024.09.21.01.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 01:17:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 21 Sep 2024 11:17:32 +0300
Subject: [PATCH 4/4] drm/msm/mdss: reuse defined bitfields for UBWC 2.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240921-msm-mdss-ubwc-v1-4-411dcf309d05@linaro.org>
References: <20240921-msm-mdss-ubwc-v1-0-411dcf309d05@linaro.org>
In-Reply-To: <20240921-msm-mdss-ubwc-v1-0-411dcf309d05@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2564;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ScCRd7+z7cwAGX0LzQnkBaj1sUTBN7g+ylhI1wBf8No=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBm7oEfFUNz63SZIIIv4PSfaBvDuI15ysOw/396a
 6UffauUniqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZu6BHwAKCRCLPIo+Aiko
 1dLUCACLFFbWklq276VM0/8R0H4sDEzmkz4gKnwfDpRPWAfsBCwUuuo+yznN+gqcNrh5FQKRyJq
 4a6Lq5j9qgRAt92C9N3elKB+wQXyIy8k06pGS/gL/eWnx/2YpQJ1seTn0GcN9iEOEHyv2petgEK
 uT1h8YyflDQfylQpRjWCdItA7GaFNpShxp4W2cqcCf5LyFC7c3I1Pcvquel4wv1n15N8mc5xtvt
 PuSQ22r/G0Mlmt8BKBd0jpa/dGfK6YwDmSPZsYy0whHFOajAVpZXDaQBoGunDeJyGmpA0tRhLGr
 BQfl+po4ZAG2aTUqjR8nNkWJlMSoXHaIS+8hTXCMv7Qr31zK
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
index 7704e1c9eb2a..0b49187c52de 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -166,8 +166,16 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *msm_mdss)
 static void msm_mdss_setup_ubwc_dec_20(struct msm_mdss *msm_mdss)
 {
 	const struct msm_mdss_data *data = msm_mdss->mdss_data;
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
 
-	writel_relaxed(data->ubwc_static, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
+	if (data->unknown_3)
+		value |= MDSS_UBWC_STATIC_UNKNOWN_3;
+
+	if (data->ubwc_enc_version == UBWC_1_0)
+		value |= MDSS_UBWC_STATIC_UNKNOWN_8;
+
+	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
 }
 
 static void msm_mdss_setup_ubwc_dec_30(struct msm_mdss *msm_mdss)
@@ -577,7 +585,8 @@ static const struct msm_mdss_data qcm2290_data = {
 static const struct msm_mdss_data sc7180_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
-	.ubwc_static = 0x1e,
+	.ubwc_swizzle = 6,
+	.unknown_3 = true,
 	.highest_bank_bit = 0x1,
 	.reg_bus_bw = 76800,
 };
@@ -628,7 +637,7 @@ static const struct msm_mdss_data sm6350_data = {
 	.ubwc_enc_version = UBWC_2_0,
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 6,
-	.ubwc_static = 0x1e,
+	.unknown_3 = true,
 	.highest_bank_bit = 1,
 	.reg_bus_bw = 76800,
 };
@@ -651,7 +660,7 @@ static const struct msm_mdss_data sm6115_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_2_0,
 	.ubwc_swizzle = 7,
-	.ubwc_static = 0x11f,
+	.unknown_3 = true,
 	.highest_bank_bit = 0x1,
 	.reg_bus_bw = 76800,
 };
diff --git a/drivers/gpu/drm/msm/msm_mdss.h b/drivers/gpu/drm/msm/msm_mdss.h
index 69095c18ab4a..521d4e6b8043 100644
--- a/drivers/gpu/drm/msm/msm_mdss.h
+++ b/drivers/gpu/drm/msm/msm_mdss.h
@@ -11,7 +11,6 @@ struct msm_mdss_data {
 	/* can be read from register 0x58 */
 	u32 ubwc_dec_version;
 	u32 ubwc_swizzle;
-	u32 ubwc_static;
 	u32 highest_bank_bit;
 	bool unknown_3;
 	bool macrotile_mode;

-- 
2.39.5


