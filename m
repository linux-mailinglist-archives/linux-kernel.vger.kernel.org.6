Return-Path: <linux-kernel+bounces-523386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127D8A3D610
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124E63B1459
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162F51F0E29;
	Thu, 20 Feb 2025 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pMN66nek"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D011EF0B4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046099; cv=none; b=TM/x1+DfK6WahHprNtXEsAWywk1nevWQaZ2q0T9y7lnG0c0txDh25teMLWkCvr/y6dre0Ifz9xsKRDmTliilDLHJ1Dyek8ErtTgSJ8xBSYOzEs2CKmfkN+HqPG+1t7Ocv5n5+puvy547Q5GtS//Pd5O7a6LlbgqIdaTYrgwmK2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046099; c=relaxed/simple;
	bh=lyKLAJr554JAOHjjCnxBQz5CBxEAxvVfUFObcdY1ag4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tD295zg02JFDddkDaMeH6/hUc2itcpTHflGZEcxbImnLPO2vac72FIqp+tAwWnHAsjSoq8g4IGkxJglTcy9GRwUtgYLOoI5qHzsX0jCqc1gTDByKlGK3QSLHOIRUntHtOP/6uTi7SIztT+4X9E3+xMKM15nm6b4nnK++wPVegDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pMN66nek; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fc1f410186so3192473a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740046097; x=1740650897; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2bbvpaMxnQ9ItTta/5Hoc0GpndlEEH7ZCqt3McNEd4=;
        b=pMN66nekuLFBz4im6BfMjGPPlebDjrLzCFvhrRIRXrD6ZtDYlwp+qUbwiwX5Jc2Qv5
         bje0EmL34ZoRpJPgi+CrlWQ95kyPPX1WxJAhecZTWP2hV349c0cD+RdUU18rK1A4kFI8
         o2CcveKuw6Fdste+s/0v6EyXlr1rmXOWMUJDQ28N5tVzXT0VX0WU+Tg3BXoXlNOQV3Fu
         iVy3VEelOhkcOD+tpxc1afrdyS0UkpDKMDFr192a/1WtLuCIx1sSvv9etKQmNafk/E/A
         uyBc9cyMJoIXqKUghPbWxBoPiBWhZ2uc9vQVnH0dV/HyttFTu1fnrGB8OR+4J6o5SVGE
         OsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046097; x=1740650897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2bbvpaMxnQ9ItTta/5Hoc0GpndlEEH7ZCqt3McNEd4=;
        b=oT9fpQWqrhKMwlw75geZfE2gguglqvyAeSfo9dOVzosC1LSxeot2vPSgo7hSXIq7g2
         C8REIBF6MSgmEzCZRKU1dTIP/BoNXjo7yz3Ts9OqFav6B7SgYCVQU5MUqNgGvij0XErh
         d7OCBT2gbRDnIFDP4FkagQ1XtHMdzpJqjUQWU2QHo+sQ9WfwdkX7K9ClsF2jJHV/R1OL
         +MtG8wvMq9qQzQ2lBSEKhoAtfr7BybJteoCqd4sWpyyGe3KklC++tk0PlpUTL2NTG5SL
         VMV1DiHx4mGtvxvcrNn1tDZQ/TVBbc4JcoSFIpFUf2SlzUGtO01qR/FNQcTL0XrvCLsG
         /T/A==
X-Forwarded-Encrypted: i=1; AJvYcCXf7o9GKM3lUG0h2jL8Tqtg9t7e+7UNp9wuswPr5BYU4ZV2lWXKvfmqUo+RH1rrYaecVVVRSUg4ixaX/aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD4y8LSi4pCjUOB7aXAkFCmA+CuKty0QeHoYvzwB7jn3SiKuvy
	O+IMAtBFByYb1Z+mVp9rWRayWXF6bpP7PoqnB35Zqb+Yjdd8k5E0akxWQFdCWu4=
X-Gm-Gg: ASbGncvPI66bggvrE+Db9Yyqn1kGfCwfqMRFlCyoAnvbGstHOHc8q0mK9HyOhyKHHhP
	OcIdYnSWrtFxAq70ztY1DZhz78Ww55rdR6+vgEEyBwDP5S24tLmIim7ULU+/lGQDAm11PFpLu9/
	L5miYO+UPJ0EF6Uz/WIBFIWO6dPKYt9FnB0LHh2yhjx/Hgz4lKXSPgy/kG00XQHgsAEOUU+pBwp
	7FJ15f1gfI4iKnmhbPYFjbz+X36T2K5gNm6+MfdtXlbi06obUZrkNKMe3+CEI3zbofElLzHZhpq
	OnN40XGg7y/g
X-Google-Smtp-Source: AGHT+IHCE4RtRNEXKZoOaSDN6mdrpoY8L7CkHQP/kzENk3sqFeSHV34QzJKi6JsrMhW9w9ua07iDCQ==
X-Received: by 2002:a17:90a:d445:b0:2fa:21d3:4332 with SMTP id 98e67ed59e1d1-2fccc97dfe7mr4597618a91.12.1740046097223;
        Thu, 20 Feb 2025 02:08:17 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm15304645a91.6.2025.02.20.02.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:08:16 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 20 Feb 2025 18:07:52 +0800
Subject: [PATCH v2 1/5] drm/msm/dsi: add support VBIF_CTRL_PRIORITY to
 v2.8.0 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dual-dsi-v2-1-6c0038d5a2ef@linaro.org>
References: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
In-Reply-To: <20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, 
 Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740046076; l=1578;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=lyKLAJr554JAOHjjCnxBQz5CBxEAxvVfUFObcdY1ag4=;
 b=m9wZrPVBSR+QFJ2DUz/SNoHz3xMrc85nVdPM1VuwlkkM2KmcuqsZt4IzPpcd3vqZEPukV8UFz
 Q1wZLZvkNnCDMVDPFv4QVErnUTSQ+9VvDwTKh1lvQQdWOSoY1Qs3jj7
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

This change originates from the Qualcomm Android Linux driver. It is
essential to support a dual-DSI configuration with two panels in
some circumstances per testing. As the name suggests, this modification
may enhance the bandwidth robustness of a bus.

Co-developed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 42e100a8adca09d7b55afce0e2553e76d898744f..f59c4cd6bc8cdb31c1302f8e3ff395486c0b4898 100644
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


