Return-Path: <linux-kernel+bounces-523387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE16A3D630
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A227A70D2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39911F12FD;
	Thu, 20 Feb 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwPxPics"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863151EF0B4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046108; cv=none; b=kr88RMRLHF3mf9P1pMN825+T9ctL4bOgzYDOjT9Rv4KcX56QdUGC2PDI6Vd3/lPSYVIHQC3tMKCgb7sKpHjwYtpCCdzNPU87r2l9SvkZD9/F6qv36fYS/y74wDcs8uBK/bYyOVPPrfNupwCxeDEApiB8n9wcW9yXXK5cxKBeFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046108; c=relaxed/simple;
	bh=hKjATXyKQvv1McdvtRyxOrJ1QBY9gQvAVDuJEgo+cmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3a37kLubYPZnQ26+nhL6mbNPhPo4zHU1EDbotI0Lw3XvwYS/k+mADib76cXLGnfHWcO4EHoemryoYYKVMTqTTny4W5uzflD1y2Bus15U5CAKuYOfaF3sqE4pzL+mwrvbTlZD2ugguUMIxSwI66zB+Y3TYWTe5f73JmLPFKlcm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FwPxPics; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso1271779a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740046106; x=1740650906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VlfjNAVucjRp1bpDBN6LbVxMwNg8iNsPGxdLh6LJhU=;
        b=FwPxPicsK0e5wdFXt7Gc2eOR5j/mkhJdJFNPBEC3Vl/MnoWBZTytHVif3R0oEw/asu
         JsNT6SX1rtVAv9FYuXLcOCzJMX3Fl/YBtaYomJww9N4F4jlHEst2lrk3nDPJIv1IxU8f
         ES3DUU4P1YgxBwJLAhi5bdl4uYw8nkJhDMM6rsm1a+HAiDI7x0d9qBSzlmiVX0gvSe4f
         4a6/cHW5sic8hIeDjgYIDwVKXtQPISioagxzG6ZvhASjpAIklIK57DZNveW0RqKN0IO9
         EB71ES48k/DYKz0P/nnMdJfjN2UoZv35OIojT/+qb0Z9Y6hNTg7bA+xRm/3JxrLcIkOp
         RH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046106; x=1740650906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VlfjNAVucjRp1bpDBN6LbVxMwNg8iNsPGxdLh6LJhU=;
        b=OvDHu2Dwg3d+QImhz5eJta9G1riVbeC7m86zJg8Nv7ZCXvVNWS2aML8YyhnrFteaHS
         CeBcWoSo/7VGGnYZfuzPNnZSR3i4EukeNLBJQjonzBCRoo+UEkwxGkwhJIpvENBpfN+T
         XEYNEJBnFM7Ufg3uQ/AbfcD66CAUlmpxGvImr51aAhmiojw0+zC/D8CsMBErRXdHclPU
         /gExUP07jxhlNbr+4nhistJBxpN/e2vuCeTIt38ELE0slAVG0lkdLs3MiopisUyVDCb9
         EuZPKqvtZVSOIRiyvCkayQeRUl6+yIfxFbInFKvL+R9Zrap+LYdcyB/+7TPtaDSneHya
         zzIA==
X-Forwarded-Encrypted: i=1; AJvYcCUuoiGU5ZDSjz450Torj5Atgn8L22SeJjFW8sfJYe5by2T8pVWwaz/aKNYORl9G5jQO54CBjeGvY6lCcFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwReCMyaTxK88js+477bwlqFamkN8UKmXwZ1BSYdm6/I/7Kvq4F
	DIf9PHXuv+zUe8ZQZQBtupH3xGbmYNY/DVV75jFCMJER9r4gkxMxIMYsGTeEOYY=
X-Gm-Gg: ASbGncsD3QhE1G/f1VJ6ZduTMcIbjL2KQ/mahnHh7OmWa4YgCJe7SfeYqHET38aAxOK
	TBQIS0OnrxEzStXvlU11pIrMyT+4WFtBHm8UfE7tPVkZp/Z1SWE9HFALOh8KeALMzBqWYWD4I+N
	49rpSzeBLucvQDrERVwbTB2FlaS1NQmSFdmgSx7xwAmlcDELEojyTBK8U8KakGPQ8spMSbg9cVQ
	21iL6Xj9eFyzhHX9fKmSMYH8QvirCgsuJvEtc1nXaoauvdriUX3Bn3tTQPEA1a35KVyjVy6Kobd
	JJrAFCW+0i4S
X-Google-Smtp-Source: AGHT+IFLxCMRudIcVvWorr4RKj/8cYBxLwu8tZJdzz6fVcUHM0ZcwncySmXk/oO/UFw1vBTAIhvBXQ==
X-Received: by 2002:a17:90b:3dc3:b0:2fa:1d9f:c80 with SMTP id 98e67ed59e1d1-2fcccc92715mr4602368a91.17.1740046106054;
        Thu, 20 Feb 2025 02:08:26 -0800 (PST)
Received: from [127.0.1.1] ([112.65.12.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3305sm15304645a91.6.2025.02.20.02.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:08:25 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 20 Feb 2025 18:07:53 +0800
Subject: [PATCH v2 2/5] drm/msm/dsi: check DSC width for the bonded DSI
 case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dual-dsi-v2-2-6c0038d5a2ef@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740046076; l=3234;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=hKjATXyKQvv1McdvtRyxOrJ1QBY9gQvAVDuJEgo+cmU=;
 b=17pUwBv+mzfkMK56B94QuKGJ5abm9UfGVZw6OxOxzVqtsJOc1Qzti6XjMCs6YMZ6yjKN42pT3
 fcq4CIFTnJvCLNjFsk1NSHXjb+L9HGGWs7B7Fnq3c6PVYwCgXOTrJQV
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

The frame width is validated to ensure it is a multiple of the DSC slice.
In the case of bonded DSI, the frame is divided horizontally in half for
compression and is delivered through two DSI interfaces. Therefore, the
width for each DSI interface should also be a multiple of the slice.
Currently, the implementation only validates this requirement against the
entire frame width. Use half of the frame width for validation.

Co-developed-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h         | 3 ++-
 drivers/gpu/drm/msm/dsi/dsi_host.c    | 6 +++++-
 drivers/gpu/drm/msm/dsi/dsi_manager.c | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 87496db203d6c7582eadcb74e94eb56a219df292..35b90c462f637111159b204269ce908614a21586 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -79,7 +79,8 @@ int msm_dsi_host_power_off(struct mipi_dsi_host *host);
 int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 				  const struct drm_display_mode *mode);
 enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
-					    const struct drm_display_mode *mode);
+					    const struct drm_display_mode *mode,
+					    bool is_bonded_dsi);
 unsigned long msm_dsi_host_get_mode_flags(struct mipi_dsi_host *host);
 int msm_dsi_host_register(struct mipi_dsi_host *host);
 void msm_dsi_host_unregister(struct mipi_dsi_host *host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index f59c4cd6bc8cdb31c1302f8e3ff395486c0b4898..908f5f1649d650f1cf152fc0b263541dc566ac68 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -2489,7 +2489,8 @@ int msm_dsi_host_set_display_mode(struct mipi_dsi_host *host,
 }
 
 enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
-					    const struct drm_display_mode *mode)
+					    const struct drm_display_mode *mode,
+					    bool is_bonded_dsi)
 {
 	struct msm_dsi_host *msm_host = to_msm_dsi_host(host);
 	struct drm_dsc_config *dsc = msm_host->dsc;
@@ -2499,6 +2500,9 @@ enum drm_mode_status msm_dsi_host_check_dsc(struct mipi_dsi_host *host,
 	if (!msm_host->dsc)
 		return MODE_OK;
 
+	if (is_bonded_dsi)
+		pic_width = mode->hdisplay / 2;
+
 	if (pic_width % dsc->slice_width) {
 		pr_err("DSI: pic_width %d has to be multiple of slice %d\n",
 		       pic_width, dsc->slice_width);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index b93205c034e4acc73d536deeddce6ebd694b4a80..be13bf682a9601484c9c14e8419563f37c2281ee 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -428,7 +428,7 @@ static enum drm_mode_status dsi_mgr_bridge_mode_valid(struct drm_bridge *bridge,
 			return MODE_ERROR;
 	}
 
-	return msm_dsi_host_check_dsc(host, mode);
+	return msm_dsi_host_check_dsc(host, mode, IS_BONDED_DSI());
 }
 
 static int dsi_mgr_bridge_attach(struct drm_bridge *bridge,

-- 
2.34.1


