Return-Path: <linux-kernel+bounces-446608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD49F26D5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC84C165248
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5461D2B22;
	Sun, 15 Dec 2024 22:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="erDdn4ya"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FA31C4A2C
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302676; cv=none; b=WojjKY6EFIpr9Fogrh5EOiczAIBBT7lYFDCQ1RwOvuFKTibRT2sugZ7NmpS7WEftCzKaoXsPRY2hNIkEPst788AqanDxrYSNnfwoKbvHfKFblkRyrfTL1LbtUKfObnW70soBgOW4XA4r0GirRWIKr+o3w2zLhAQBzEW9jkVeEks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302676; c=relaxed/simple;
	bh=ysAreE5Z/RcHbTBjNtDu2xspbXRBHDHxpb93FRND6NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iTP7+TtWdbHOAzDb5gpo9bryfy9HWB5tz26xxArIEsUs3YKdTUXzX/NThb5SThiju2YQTUjVp5i3uZ4ogMg/AG9WLHVmtgOWmwG+zANALrzPveTt32RC/MHDyIUlrY6toaJt/40w6sei9TYNpsjN7Lmc2nV0rcTS19Jutzn0NfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=erDdn4ya; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3011c7b39c7so38393741fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302672; x=1734907472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nubs3398lgrKxFnCwTc1Ymo101jsqe11SC2pCPEcqUQ=;
        b=erDdn4ya3Bz4PTRGbKR83bZXcmTvuMP4T1PXVsPJ+CogIgVYMYdp6xqL8Hy4tz3D+X
         JoS+J/UA6yDnLT/d06HxTrzrDSFT6HNuneqJbUdeAqx6Xna1/V1FlFeLSdbthA0/gqMg
         KzrtrdJH4wpa3IoTbJ4cEtC75stCSFbukmcj+RFZvhdRgRZ+b768+5uTcYd7w4OMqW48
         doAWd/JP5QUOEEyCuhDC1gqm6BPw3phr6GoyMoIKIJhiHAy7Oj8Kxe8nisRKcNYYSRk2
         Xp4NumRiilzcURJ0lvw+R9F6C9Dk30meYtOdPoLcC0Kav8O8LAh5hlNoK3HSg4o4ZSXA
         gP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302672; x=1734907472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nubs3398lgrKxFnCwTc1Ymo101jsqe11SC2pCPEcqUQ=;
        b=Uain92EVXnBebcgWZ7RqVnaW49NTTCIFQWjUZKW8z3q+Qns43TYjTGbTSmaNyclDLs
         VmN72V4TAKfJAZyiYRCrAyEk/HWWze0XsWvmGohj62QMHTFFq09w3TQkay8PPEIWNADh
         esiI/yZvbsLDHwW7WsRUfDSRUMu8EO/JtEJpjVayvzwzCXaymKWV0kzOb1b3GtgkbanL
         /fDsnr5wMfNIYKIqoLl+TcYRTqxGaUAoQPAv/X7AcOz9GOHd6AT12CK4kgUz35OOtHNi
         vnH3YIsY9sur2sRjLknPW13hWnPUAWZ8peCCbdz3O9snbBJsdkJdFOXuhOUqJ99rw1mW
         44ww==
X-Forwarded-Encrypted: i=1; AJvYcCU+HWKLm5zBXPSPcNun61p1IKqoGLdHjR+UkDlczH2u1ITJPTbNfp8cL5ue3424vYtPI2oLqrjGu/TZhxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS8b3e/9Ne2ioXdHVSxYE9Mz9fsDQmN5qNtLmRuYGJwoftaLQF
	TxhFwYVkad0fuavUy731J4fQqmJMl7zwVAk45HGoKBIJGwMONEckkslhTyqoGKs=
X-Gm-Gg: ASbGncvGDBdXDPSyMto8pvMNC+Ac/QB0ZU2sa4cSPiQuE08W2IrYGISdeyHLDFTs+YU
	Kesq3IacFsKHD6Q8OHEH5SNv4ZiFuwryM7rj+mLtZWFehwpLsDpQQGYdEUFzrTO5bXAqY02ho8o
	TrM/DEt79DRMzjrminZX2t8ogZDwTrxWOHvXqFQEuBp7Dllj91MgLswVtSRH39UhESl2Px8pJ0v
	h4xbSx6ixI9JBjuclIR0xvcMwWUQO8Okk8wWsMS2ZMEVC7cL0DdsesCzHWzB6EP
X-Google-Smtp-Source: AGHT+IGqHHO3GLDpWqOcMsqQWY8q49s2fKEdDxU/H/TcsNTAaJJAYzfLtem0/bo+E0Ao0strvHnoRQ==
X-Received: by 2002:a05:6512:a8e:b0:53e:39c2:f020 with SMTP id 2adb3069b0e04-5408ccff097mr2843422e87.6.1734302672230;
        Sun, 15 Dec 2024 14:44:32 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:31 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 00:44:13 +0200
Subject: [PATCH v4 08/16] drm/msm/dp: move I/O functions to global header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fd-dp-audio-fixup-v4-8-f8d1961cf22f@linaro.org>
References: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
In-Reply-To: <20241216-fd-dp-audio-fixup-v4-0-f8d1961cf22f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Paloma Arellano <quic_parellan@quicinc.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
 Stephen Boyd <swboyd@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5605;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ysAreE5Z/RcHbTBjNtDu2xspbXRBHDHxpb93FRND6NU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX1u6Jggs2naphQ8Ghnw42kXUU7Kjee7V20RQ0
 WgD+3PBmqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ19bugAKCRCLPIo+Aiko
 1dyoB/9Cv/BkoE65IYuBfpbPwkrZg86R5Goq6clXeaT5DTBi1qo85cBBsdEhrPXVNA8GV5xB0Gc
 9JDBjYmkwNBkIDXlDvuJcM2lT10QmLHC6RtUXrXMivJ84/3iihXq8dq10s+Noizg0Wg/tPVzKu9
 LfLw7lkCfo1cKPcuIzVCQ5/LOH1978IIZdr13klA5+OMOYF308NcgtP/S+AYDdouXshm7V30MqQ
 rBy/tPB+i9RSQ49TZ+3YxnwPKMhKGf9Q4LmZvm7Ofj/F2MFQ/Q12UHSVDG4vT1vrsRuX1cvBhm1
 ae2oYf5gluKkRMTVXzDrTnx/AmYzAc7kIHaQ3xwL8XZd8n+d
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Move msm_dp_read()/msm_write_foo() functions to the dp_catalog.h,
allowing other modules to access the data directly.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org> # sc7180-trogdor
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 65 -------------------------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h | 62 +++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 399bd11312d33268faee769946196d344546e63d..871c935cbe10bc2749960d61cc6b835a3ec2e296 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -81,71 +81,6 @@ void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_d
 				    msm_dp_catalog->p0_len, msm_dp_catalog->p0_base, "dp_p0");
 }
 
-static inline u32 msm_dp_read_aux(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
-{
-	return readl_relaxed(msm_dp_catalog->aux_base + offset);
-}
-
-static inline void msm_dp_write_aux(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure aux reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->aux_base + offset);
-}
-
-static inline u32 msm_dp_read_ahb(const struct msm_dp_catalog *msm_dp_catalog, u32 offset)
-{
-	return readl_relaxed(msm_dp_catalog->ahb_base + offset);
-}
-
-static inline void msm_dp_write_ahb(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure phy reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->ahb_base + offset);
-}
-
-static inline void msm_dp_write_p0(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure interface reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->p0_base + offset);
-}
-
-static inline u32 msm_dp_read_p0(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset)
-{
-	/*
-	 * To make sure interface reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	return readl_relaxed(msm_dp_catalog->p0_base + offset);
-}
-
-static inline u32 msm_dp_read_link(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
-{
-	return readl_relaxed(msm_dp_catalog->link_base + offset);
-}
-
-static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
-			       u32 offset, u32 data)
-{
-	/*
-	 * To make sure link reg writes happens before any other operation,
-	 * this function uses writel() instread of writel_relaxed()
-	 */
-	writel(data, msm_dp_catalog->link_base + offset);
-}
-
 /* aux related catalog functions */
 u32 msm_dp_catalog_aux_read_data(struct msm_dp_catalog *msm_dp_catalog)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 9aadaf1627a5813ab2d87e6e02dc0a967affdd79..d08761697a8e48b5e6827411eb5d1bc9df4894c8 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -47,6 +47,68 @@ struct msm_dp_catalog {
 	size_t p0_len;
 };
 
+/* IO */
+static inline u32 msm_dp_read_aux(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->aux_base + offset);
+}
+
+static inline void msm_dp_write_aux(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure aux reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->aux_base + offset);
+}
+
+static inline u32 msm_dp_read_ahb(const struct msm_dp_catalog *msm_dp_catalog, u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->ahb_base + offset);
+}
+
+static inline void msm_dp_write_ahb(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure phy reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->ahb_base + offset);
+}
+
+static inline void msm_dp_write_p0(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure interface reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->p0_base + offset);
+}
+
+static inline u32 msm_dp_read_p0(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->p0_base + offset);
+}
+
+static inline u32 msm_dp_read_link(struct msm_dp_catalog *msm_dp_catalog, u32 offset)
+{
+	return readl_relaxed(msm_dp_catalog->link_base + offset);
+}
+
+static inline void msm_dp_write_link(struct msm_dp_catalog *msm_dp_catalog,
+			       u32 offset, u32 data)
+{
+	/*
+	 * To make sure link reg writes happens before any other operation,
+	 * this function uses writel() instread of writel_relaxed()
+	 */
+	writel(data, msm_dp_catalog->link_base + offset);
+}
+
 /* Debug module */
 void msm_dp_catalog_snapshot(struct msm_dp_catalog *msm_dp_catalog, struct msm_disp_state *disp_state);
 

-- 
2.39.5


