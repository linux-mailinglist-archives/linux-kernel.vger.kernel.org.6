Return-Path: <linux-kernel+bounces-306630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3C964183
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1DE1C24875
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0955C19148A;
	Thu, 29 Aug 2024 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8CAhsDm"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAB1917C4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926757; cv=none; b=g/N2xGAr3ucy+K2cvauTlb46B+zaWSKoxV6IQiXpTh0Y+zPxzlOd4GvIdjUO2bFRlk28ATDdznI/LIXmcxlV6RcZ8HUsQHnFbcbE7+f4UUeOe97IjlFBtkH1wmtNOsqJY8Vpe3cftRC83ka9tWCc1DE9bYIbyEFM+TdFE4cnYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926757; c=relaxed/simple;
	bh=oRRqzh/38gBnAzFP7qMOQGGRKbYK9LdfD2QoV6AEGNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LDFArekzzkNicLN/K09wFtzlbK5yCw4y7gV55kXwCZNPj/nJGuCWdRzK78ae+0u8jHgrGDxw0gXHbxlS40hkaHeM7V+MfrIyOSan01EF0dj05zqOudwsuvDjd65Oj8Ifqws8YVeqDB4rXUiVypaYfde/uFsxO/3RWd7xt3WICV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8CAhsDm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso1209652b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926755; x=1725531555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pm46gM0TTBbBdMjovlXNb5pnDJgcjv/io30h+9vcb2w=;
        b=R8CAhsDm3HcYpBCD46abgVRLXAG+xivUyfbk/odyZiYVg+TSuWE5F86LfrLyvMGo/5
         gK0AU9iuwiO8OabZT1hKA1Ym5XRuZGoHRBBJcpkpET1DeqQIxWpWc105aUgK23R/3WMt
         UuBk7W+Fq/6lTCHyMymvUXp/aArsT65InW14IwRg8w6X5KJ8PQIkY4w+0q/ulOE8igom
         m/Wc2Avba8MwcgY1Y1OnnQbDwNgh27lnDVpxdKLd5rA/KXkSskrfq3kP346WWeOZh/nU
         TTwtczFlHY34+JBt62D9NreBk2ZEqJCjjglOsBMVSnsPR/KWrGMHJ+gHBHvpSvnVHij6
         iRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926755; x=1725531555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pm46gM0TTBbBdMjovlXNb5pnDJgcjv/io30h+9vcb2w=;
        b=k3dGVec2RBZqVT0qfIXazPeRJkAcTpo5TK1qI/G2l677fMN5FVAH2vq+ehgIoYcaNs
         4sUsRHEB6cFeWION6S5PwdT96aER3yN4RS4G8ouRqQAB/SUp61UmhX2c8tslPPGyG6eD
         J1/t4coUo9LTYnw/s927xOm9OtNRhk1sLLIOLdG1DNFb/TN1qEVGrYiVtc3WlCvYQOPz
         VJa+kzIEc5hr2MXa3pTQJGzPIEIK9VUoeskrgyDTOVoO7V4TiOkAYwkU0Q/4k8jGfpUw
         MzNF4iUO47ri8H6H8amdUVIB8vAQINYQcyFfrliFLbpR54eyb3lzx6RafOE36Vsi+pHX
         9QXg==
X-Forwarded-Encrypted: i=1; AJvYcCUkCVvWJHYvN+FuYMIscryWd+29wCYsAbwJXSuvYinwAN9LzCskl1/X1rpUFHEgtGno8/N1ddq5A6MCHi8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyka9Mbf/+eobdeoijzX50hUEfst0H+ij3TAXFx9Sp6Q+YBp1e
	08bYAI12aZoRII/ecLvZZixSFzkMo2Hl6bBb5KvbqVBl0KQeYfgFyX9U0TTzQ3Y=
X-Google-Smtp-Source: AGHT+IFIi/GI1xiHx4ikkWEaDUD/O7jnJJ9faqHg9EcKdEHEXIo+BEOFueQ/+R9j5m2bXWlUa+kVtA==
X-Received: by 2002:a05:6a21:458b:b0:1c4:85a2:9958 with SMTP id adf61e73a8af0-1cce58672eamr1524199637.25.1724926755196;
        Thu, 29 Aug 2024 03:19:15 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.167])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d4df4sm891684a12.82.2024.08.29.03.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:19:14 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 29 Aug 2024 18:17:30 +0800
Subject: [PATCH 01/21] drm/msm/dsi: add support to DSI CTRL v2.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-1-bdb05b4b5a2e@linaro.org>
References: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
In-Reply-To: <20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724926736; l=1217;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=C1k3RPwM6WNScuAGLeEJNZ/C8SUXvF2SN04fTyxqBC4=;
 b=IL2p1n//a/cGjDAbXalP8f4Wm6zhrPhNJ5sIDGMkYy4qtn/Aw3KFCQjztAspCIV9D1mB87nyE
 sNLBBVEeWJmDVH9l6gal907ZbTHPctNj7XlZo4S7aFE/u3f8VHrLul4
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

From: Jonathan Marek <jonathan@marek.ca>

Add support to DSI CTRL v2.8.0 with priority support

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 185d7de0bf376..6388bb12696ff 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2238,13 +2238,23 @@ int msm_dsi_host_cmd_rx(struct mipi_dsi_host *host,
 	return ret;
 }
 
+#define DSI_VBIF_CTRL			(0x01CC - 4)
+#define DSI_VBIF_CTRL_PRIORITY		0x07
+
 void msm_dsi_host_cmd_xfer_commit(struct mipi_dsi_host *host, u32 dma_base,
 				  u32 len)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
+	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
+	u32 reg;
 
 	dsi_write(msm_host, REG_DSI_DMA_BASE, dma_base);
 	dsi_write(msm_host, REG_DSI_DMA_LEN, len);
+	if (cfg_hnd->minor >= MSM_DSI_6G_VER_MINOR_V2_8_0) {
+		reg = dsi_read(msm_host, DSI_VBIF_CTRL);
+		reg |= (DSI_VBIF_CTRL_PRIORITY & 0x7);
+		dsi_write(msm_host, DSI_VBIF_CTRL, reg);
+	}
 	dsi_write(msm_host, REG_DSI_TRIG_DMA, 1);
 
 	/* Make sure trigger happens */

-- 
2.34.1


