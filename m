Return-Path: <linux-kernel+bounces-515028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CBAA35EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D8A170EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4800126618A;
	Fri, 14 Feb 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx3Dw1jk"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B58265CAD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539085; cv=none; b=Wwr2jwahsVktBm5Bo4+Gx50QGYNfoXfS3FRj3ZE7lxaVELbYixA04xDH6WrZvwHPHGwQtiXsDW5mdkocM1bevXLVM0mljnduKtJYB/3rwZ/sryXj/3DfwihVMV6Zj+7XDO5gZeJQVIapN3DeHNtGCBV0j2os5ON6unTQAaJmvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539085; c=relaxed/simple;
	bh=wrQ7FEvkfGwe1RgjRIh0czcnhsj69UfOzjSd6eJUfEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hf4QB2rdCIfAkLi2WMQxVlXqfFVTKjM92g9sJbK7vIWBKZEGaBm1efPORCI1+hQ/+h7GMdXzyVDpmR9tPQyEPazaaJTT9SL3FqDc2L0JI+o5uiNx91l/mvGBOpRXuy0hPq5Tv41pJ0sey64eILQwWrwkMRReKb+pEddZIdoMKvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cx3Dw1jk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38bec08834dso109614f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739539082; x=1740143882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LE456UUhTzImlgmj9NPbG9NBfxzf+5xtSodgSen1s8=;
        b=cx3Dw1jkBr4brsojr40fDYdqNYNFVsud3FT3dYFd4ZmyB6NRhZIdSs9/nc5CsLuh40
         +UXZD6HyVKiuSHc4qG5d4IbbfcxV590KUqbT4DO8Ii3Lh482/kfjP7ed7FQ2uQphfB0F
         EJDhlQ9kRJjjNFie55tJTzOkpi4kDarxF1uY9CCZgKAHITBMzLjUQApSvSfPn34JpMRZ
         In/mnpQipeCon9/ZJkFcFJiywaX1GelgM0scMDh9jbN09WkZYBxGhyCNXdSWjd2F/hfE
         yLoMJsAoLvAxOognhi1CovjKqAZWCQ4oXNCAAlmyecXhxHMLJ+F4PqUl3hgFOuiBLn/4
         pA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739539082; x=1740143882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LE456UUhTzImlgmj9NPbG9NBfxzf+5xtSodgSen1s8=;
        b=L29D0PwaSSY/h2x3oBqbt4enUFSm9xHE9adOi8khl8M2qihCx5zmMMfiKVfXOjiw4s
         w1uPBvBiPG/5DvNvWTR9yHFOom6iGAbtaXJGHfnSBCSIcllPFk09TTFogpcLOGEa5LwI
         t9yWygHCca56gYkr3sNDO0dpae2YTC4FtGipzsPuIrJIurL02DMa6IOFFT1jf2PIc3t2
         6JQRImoM4KFxRgaCv66KYusNwyoh7QcJN7x0bia5YymKdXg1Ea1oRADWyfRM2A16qnbb
         g4NjuYLA/K67I1iu6wDGSvffREyXNIpp7WBjxjKRiR4Mq3nG9I6nm7xJ9YUADLwJwZLV
         PbBg==
X-Forwarded-Encrypted: i=1; AJvYcCXqa3IKDOiTAukK9G19KH1WnXoR2gQjYT+kPbLf4JUe2WVsHfLsKWKAZRet5lwV8pPQWElUQCsh5BinTEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmObtprhy2SOChOuvh4BZqOyIy3+89nz5+H9dofrYzEcwsm4m
	apy30JsCKPMIdMVUTVIhJwUck0v2tr28K7poFTjY3V3jLurui3H5vLdsDno5/JE=
X-Gm-Gg: ASbGncvYI/Pr+E3hDLJ4M3dgoi50mXk5V2cGnrmy9GEmXnYL668t8NOiwwFbfs3ci68
	hlQDDJbePww7WpQQh6a8gzR6jHhsE+47RnH3wTQWGazXVcS8vdCdp7f4z6IVw89yidryNc6f7On
	GdTNb1Uk/uCCyADgrfR5u56YeJWwqh+1uGhrQtiqkWNlCGQvhMemRAMqHJraYIboytnYRoQgVo1
	rHFGcZMQePEDvaj8+WvBv7/HBB58BdxVu7din8X6My49aPWgwXOxbrrLEH8xHvZKmF/00p95HwD
	ZYx6RBnqGFWEV2nZaHuW/JepIYGf9Mc=
X-Google-Smtp-Source: AGHT+IERsb8pyYVEmTlSzt9ruB1hZL+QbDlon6/7017auPvH48KZTGyTGNiDtGRYQSA7i3P3XQptBw==
X-Received: by 2002:a05:6000:2104:b0:38d:daf3:be5a with SMTP id ffacd0b85a97d-38f2c777a53mr1413782f8f.7.1739539081555;
        Fri, 14 Feb 2025 05:18:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5655sm4607690f8f.77.2025.02.14.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 05:18:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 14 Feb 2025 14:17:46 +0100
Subject: [PATCH v2 3/4] drm/msm/dsi: Minor whitespace and style cleanup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-msm-cleanups-v2-3-1bec50f37dc1@linaro.org>
References: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
In-Reply-To: <20250214-drm-msm-cleanups-v2-0-1bec50f37dc1@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5028;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wrQ7FEvkfGwe1RgjRIh0czcnhsj69UfOzjSd6eJUfEs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnr0KBNopLG/nMFbPRPRRezQK48CkRgIUqrVvGU
 /bI1eQlugiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ69CgQAKCRDBN2bmhouD
 173sEACJr+2WUT8DaXnwjiufyWp84sk2wSRe2HDObjXTu9WK7LuVDYkXOFjAs9FmcKBXTFns+8G
 Z8qr4n8qQ8u5vK7XlonY/C5UWCgTDZy6P7LTH8z1PEWq2Q+Ld8Sw8Nesgew2V0jrhr7btKu/elH
 WNwaOPUUZLvQ+Lz+LHE6I2n1iuR/rY8yx3jfphh4fUlEQ0qJ1Hu8hDohVmwS+UBCEFWnqji9GSO
 T6/YPokGX/2sU2kTzfQ41/ykcmb5RfUE3djbJxz5LMQL/dUUv3PFgps1lmrjHdf0OHgVrmbgcQu
 tz44nF3BAl6CtaRBbpxqq7cfuq+kNh0c7XzDdnf/b86ohnwV4YPmb7f044GND9XUjZcRvoByOlM
 yzbjKOBhDbBtJ9MvKUMlFIEyBde7QgGe6o7hiLHGWmx129NtaWtya850nF/ddDM9HGU1f4Estnb
 oeUruJdIHDfgqNgUMJyjjGS/SaAfAp41+XmOWkwksgOYFioA95PI+uwwJaytHPzlcvlqtjbUJfq
 E9F910mNvtRSGVIyHbr8M4v7exsKitd0vo9VxLS/Fxwx90d+R7igmbsP5xv4JQzNjegKNxW5+bP
 ScnaAIntXwHjKmnI4GC5wANqKFQb1xS7iZr5yiEPVDwono8kmj5JNVu7CE/4sn3jRtHIrUc9xN6
 TfOEjLa9cL4A2Yw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Cleanup few obvious kernel coding style violations: missing or
unnecessary braces in 'if-else', unnecessary break lines, incorrect
breaking of long function declarations, unnecessary 'else' after a
'return'.  No functional impact expected.

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 51 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 8fc9f5486aebd3c08914409cd3c7824fa0b97515..051e26ae1b7f20d47969c3aff4e7fc6234f18d1a 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -179,18 +179,18 @@ struct msm_dsi_host {
 	int irq;
 };
 
-
 static inline u32 dsi_read(struct msm_dsi_host *msm_host, u32 reg)
 {
 	return readl(msm_host->ctrl_base + reg);
 }
+
 static inline void dsi_write(struct msm_dsi_host *msm_host, u32 reg, u32 data)
 {
 	writel(data, msm_host->ctrl_base + reg);
 }
 
-static const struct msm_dsi_cfg_handler *dsi_get_config(
-						struct msm_dsi_host *msm_host)
+static const struct msm_dsi_cfg_handler *
+dsi_get_config(struct msm_dsi_host *msm_host)
 {
 	const struct msm_dsi_cfg_handler *cfg_hnd = NULL;
 	struct device *dev = &msm_host->pdev->dev;
@@ -370,7 +370,6 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 	return 0;
 }
 
-
 int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 {
 	int ret;
@@ -588,7 +587,6 @@ static void dsi_calc_pclk(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
 
 	DBG("pclk=%lu, bclk=%lu", msm_host->pixel_clk_rate,
 				msm_host->byte_clk_rate);
-
 }
 
 int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi)
@@ -677,8 +675,8 @@ static inline enum dsi_traffic_mode dsi_get_traffic_mode(const u32 mode_flags)
 	return NON_BURST_SYNCH_EVENT;
 }
 
-static inline enum dsi_vid_dst_format dsi_get_vid_fmt(
-				const enum mipi_dsi_pixel_format mipi_fmt)
+static inline enum dsi_vid_dst_format
+dsi_get_vid_fmt(const enum mipi_dsi_pixel_format mipi_fmt)
 {
 	switch (mipi_fmt) {
 	case MIPI_DSI_FMT_RGB888:	return VID_DST_FORMAT_RGB888;
@@ -689,8 +687,8 @@ static inline enum dsi_vid_dst_format dsi_get_vid_fmt(
 	}
 }
 
-static inline enum dsi_cmd_dst_format dsi_get_cmd_fmt(
-				const enum mipi_dsi_pixel_format mipi_fmt)
+static inline enum dsi_cmd_dst_format
+dsi_get_cmd_fmt(const enum mipi_dsi_pixel_format mipi_fmt)
 {
 	switch (mipi_fmt) {
 	case MIPI_DSI_FMT_RGB888:	return CMD_DST_FORMAT_RGB888;
@@ -1282,14 +1280,15 @@ static int dsi_cmd_dma_add(struct msm_dsi_host *msm_host,
 static int dsi_short_read1_resp(u8 *buf, const struct mipi_dsi_msg *msg)
 {
 	u8 *data = msg->rx_buf;
+
 	if (data && (msg->rx_len >= 1)) {
 		*data = buf[1]; /* strip out dcs type */
 		return 1;
-	} else {
-		pr_err("%s: read data does not match with rx_buf len %zu\n",
-			__func__, msg->rx_len);
-		return -EINVAL;
 	}
+
+	pr_err("%s: read data does not match with rx_buf len %zu\n",
+		__func__, msg->rx_len);
+	return -EINVAL;
 }
 
 /*
@@ -1298,15 +1297,16 @@ static int dsi_short_read1_resp(u8 *buf, const struct mipi_dsi_msg *msg)
 static int dsi_short_read2_resp(u8 *buf, const struct mipi_dsi_msg *msg)
 {
 	u8 *data = msg->rx_buf;
+
 	if (data && (msg->rx_len >= 2)) {
 		data[0] = buf[1]; /* strip out dcs type */
 		data[1] = buf[2];
 		return 2;
-	} else {
-		pr_err("%s: read data does not match with rx_buf len %zu\n",
-			__func__, msg->rx_len);
-		return -EINVAL;
 	}
+
+	pr_err("%s: read data does not match with rx_buf len %zu\n",
+		__func__, msg->rx_len);
+	return -EINVAL;
 }
 
 static int dsi_long_read_resp(u8 *buf, const struct mipi_dsi_msg *msg)
@@ -1366,8 +1366,9 @@ static int dsi_cmd_dma_tx(struct msm_dsi_host *msm_host, int len)
 			ret = -ETIMEDOUT;
 		else
 			ret = len;
-	} else
+	} else {
 		ret = len;
+	}
 
 	return ret;
 }
@@ -1435,11 +1436,12 @@ static int dsi_cmds2buf_tx(struct msm_dsi_host *msm_host,
 		return len;
 	}
 
-	/* for video mode, do not send cmds more than
-	* one pixel line, since it only transmit it
-	* during BLLP.
-	*/
-	/* TODO: if the command is sent in LP mode, the bit rate is only
+	/*
+	 * for video mode, do not send cmds more than
+	 * one pixel line, since it only transmit it
+	 * during BLLP.
+	 *
+	 * TODO: if the command is sent in LP mode, the bit rate is only
 	 * half of esc clk rate. In this case, if the video is already
 	 * actively streaming, we need to check more carefully if the
 	 * command can be fit into one BLLP.
@@ -1864,9 +1866,8 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 	int ret;
 
 	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
-	if (!msm_host) {
+	if (!msm_host)
 		return -ENOMEM;
-	}
 
 	msm_host->pdev = pdev;
 	msm_dsi->host = &msm_host->base;

-- 
2.43.0


