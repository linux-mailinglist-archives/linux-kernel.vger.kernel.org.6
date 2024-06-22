Return-Path: <linux-kernel+bounces-225872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC3913691
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 00:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B491D2846A1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 22:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9604C12E1C6;
	Sat, 22 Jun 2024 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lg3k0beJ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B8E129E94
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719093749; cv=none; b=jGz63dg0EvUMPg+zTpdRY7vsTtkI/L4eYwfruW+jSNueErONTQMYt17Nkpn82QcyahAkOK6RYmXvcHWyI7WBie/2L/LUjVB+gR5Cw1361S6AuvT/Ib/5cJG4cSRWlucOGOvW0qcr86/bYbOoLFUEP+8Nrt76S411ZBhIsDMylO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719093749; c=relaxed/simple;
	bh=c8linT71WnUmb2XL4MjDcI9MoIjYqa8Jfex5sF8uhhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ceptvM7qDOyauIRghL+Aybca6exdDtzoN8LkYhOBU3O3huoqSdvZ5tCl1R4Cg6X98Uwp+8Mu4RU82xGpp6ASzMi3qTeGmA6evXep6kjaatMsawi7D2oC+JxsKoQUTmzjJfeSQRC6upLUWYJS9CuuVdJwaXFR92uNgE/91jHWfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lg3k0beJ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so33559041fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 15:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719093746; x=1719698546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcLXGMyi48kmnj7pjstYNNfWzbNrifnXYs8snVK6Jn4=;
        b=lg3k0beJMCcdx7US7mZlhJd/4sAiI3vWMWjrWoCxR5p5CweZVYNhQC+3IQy8tB7Dar
         R71WgzdORdpmGyBBmVyJbx5WXhJ86Ybo5KXNqgAdZBtuZGIuHB45rvRpTJlBGid7pjgA
         0XrnaZ8ec4erzT/QmeHj9giQjMfOiXz0PPZ6QQHejhJTfhCpiEilrNas7N3bjFNcSmUm
         d7oHf0UytLZfDGasF/J+Z4keA6z7K16QhzkI0BkyjIE0AZz2dvU7raksgv0OlDm53rQd
         rr4g8T62qv63x7PZaQOFLJJpmtoIKx4NRAp9zgWV4ulvXvN7pyDUo+EA5jUqsUXhneST
         bh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719093746; x=1719698546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hcLXGMyi48kmnj7pjstYNNfWzbNrifnXYs8snVK6Jn4=;
        b=r9DwyQpO+agoCwYpqrJk37xKnH1PO/NVIaSKHCM/Y4UPbgT6I+2lzIMZgO3vW0yRDs
         EaLQThiL58Ig9PDg221k11WhVpi4SoyljJFlvrzIL4gjmwJFBuxpsjLPLS0oaWzjCLpd
         z2lscDoHLibmjlHG2TD3cYDKrp2WVyfIQ7f+MpNqUR9zp0Ed2MPIC7ATwNuyYRKIuTv9
         pVBnTOLE2D85z6NT0c1ryMWd+xPI8zjijjfxaOaWy1/+EvaLyWDj2xWZyxoijRr5HpFo
         +5hoLjzeinnZB3dScCAPHU9YsZhl7VYjNQrnDi8xyGQ71Z6Tznn/gWU77lGpKbgfLz6i
         krBw==
X-Forwarded-Encrypted: i=1; AJvYcCXa0IxQ9YbV6sbX1exxCSBAcZ0szkxpfZALvKkMBs1xId5LPx2wVE1GG/2No8Zvsg06mgFdMb2T+M81GB9nZhXdgrVN3QooF28TrgnF
X-Gm-Message-State: AOJu0Yzco14EWBQkR81fRCCfM4Mqb+pk1znZKP1WydLD329PvuZ0nToE
	YUxydVmX8TvPWEroWzpT3X1gtOvplIrBptoyRIarMUex+6h6kBbXr0XG5akJKi4=
X-Google-Smtp-Source: AGHT+IEosm1MB8sVMKXefmGRiaVDftf+7yDqEsDBy2wvjyJ7dnTWcgC8vmNbs+aNIEBPJzhSJChLuw==
X-Received: by 2002:a2e:994f:0:b0:2ec:4fea:8b9e with SMTP id 38308e7fff4ca-2ec5b337a97mr4258801fa.15.1719093745913;
        Sat, 22 Jun 2024 15:02:25 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec55e56ea5sm2502051fa.112.2024.06.22.15.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 15:02:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 23 Jun 2024 01:02:23 +0300
Subject: [PATCH v3 10/13] drm/msm/hdmi: expand the HDMI_CFG macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-fd-hdmi-hpd-v3-10-8645a64cbd63@linaro.org>
References: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
In-Reply-To: <20240623-fd-hdmi-hpd-v3-0-8645a64cbd63@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2236;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=c8linT71WnUmb2XL4MjDcI9MoIjYqa8Jfex5sF8uhhg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmd0npxQE+1N8qoZFUtMdjZ+FEG5yO3+10/F2ly
 w+8ND4VQ7mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZndJ6QAKCRCLPIo+Aiko
 1VN5B/0VeC+RdpAdyBSPOw5fDyKRSeXRtfm3jDRuz2kdmzp+6j+2ra1isZBr/dsTEm6TLHuL+8i
 Vr83ibPymZn2baMMSl+jxPqbiVY/Tx2W5l3wargUjKixUCnC6ilkyQJtFcpV/f7XZ8RlSc9mn/G
 +++cAG5s7k6JVroJt70muCE2VWSCNU8SYzQ14IZDP4wP85pmG1bz0HHp4UnbhOFuTvJ0k8oo4HN
 8LfFLuImZ5kf0WJhBk3oPvTtuGHtg9uPPIXwd3LpEUAPZmWJEyO48wHOVcOb3BiHvQKSmIamFP8
 ket0CfVSADHb1eS6IHCr9Ve6pdFyR6FY+A3/0rqrsTq8q2ci
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Expand the HDMI_CFG() macro in HDMI config description. It has no added
value other than hiding some boilerplate declarations.

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c | 16 ++++++++--------
 drivers/gpu/drm/msm/hdmi/hdmi.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 48dd1843ea1f..5ba9a23ef122 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -222,24 +222,24 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
  * The hdmi device:
  */
 
-#define HDMI_CFG(item, entry) \
-	.item ## _names = item ##_names_ ## entry, \
-	.item ## _cnt   = ARRAY_SIZE(item ## _names_ ## entry)
-
 static const char *pwr_reg_names_8960[] = {"core-vdda"};
 static const char *pwr_clk_names_8960[] = {"core", "master_iface", "slave_iface"};
 
 static const struct hdmi_platform_config hdmi_tx_8960_config = {
-		HDMI_CFG(pwr_reg, 8960),
-		HDMI_CFG(pwr_clk, 8960),
+	.pwr_reg_names = pwr_reg_names_8960,
+	.pwr_reg_cnt = ARRAY_SIZE(pwr_reg_names_8960),
+	.pwr_clk_names = pwr_clk_names_8960,
+	.pwr_clk_cnt = ARRAY_SIZE(pwr_clk_names_8960),
 };
 
 static const char *pwr_reg_names_8x74[] = {"core-vdda", "core-vcc"};
 static const char *pwr_clk_names_8x74[] = {"iface", "core", "mdp_core", "alt_iface"};
 
 static const struct hdmi_platform_config hdmi_tx_8974_config = {
-		HDMI_CFG(pwr_reg, 8x74),
-		HDMI_CFG(pwr_clk, 8x74),
+	.pwr_reg_names = pwr_reg_names_8x74,
+	.pwr_reg_cnt = ARRAY_SIZE(pwr_reg_names_8x74),
+	.pwr_clk_names = pwr_clk_names_8x74,
+	.pwr_clk_cnt = ARRAY_SIZE(pwr_clk_names_8x74),
 };
 
 /*
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 9bc4bd6761de..1c2e46d38792 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -87,7 +87,7 @@ struct hdmi_platform_config {
 	const char **pwr_reg_names;
 	int pwr_reg_cnt;
 
-	/* clks that need to be on for hpd: */
+	/* clks that need to be on: */
 	const char **pwr_clk_names;
 	int pwr_clk_cnt;
 };

-- 
2.39.2


