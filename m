Return-Path: <linux-kernel+bounces-446606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA6C9F26D2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 23:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B3A18847A8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF9A1CEEB0;
	Sun, 15 Dec 2024 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H+qSPw9p"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F11CEAC2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734302671; cv=none; b=QDwdL5dBH3rND0bG4eNY7TRkfTwSLmSTFI4ywImovdD14w2lsRhY1ctu2TjIYhdfBHqN7hpKOGIgc6SntAlbHc/CvcnjUjtE8wNwIedPIVK6VqVOBmVJuKEoOtf0kEnlw3Hwd4eCQ0EL9ztGuThcgT4On7kXAMr+6CLkYBypBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734302671; c=relaxed/simple;
	bh=uGnZRrKJoZhV4YQRCG927L3JErIL80muN9PIVthRAy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uC+O3ldGX3MPQ2z4wpz/r1UAFV1U9dMmCDl0rUl1EHKH5a1Z9x5SpqVWXF6cBB9oDA/ObUyNq9LAUEKbXguz1wu2FwqnX4iPgw4/Zil98e1Z/Ia/3GG547JhvxxDB15ms6tmneghJYHZ3MG4ASkrMcpHJzwwWCnmfDN2F7FDX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H+qSPw9p; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so29429051fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734302667; x=1734907467; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mux+X2T90rARK9K4me0bLNJaTeYIMJC1kTPXh2h86DA=;
        b=H+qSPw9pMs6blVjAQOMEWWLl7qUiu6UjIhktQQcE67OVr+Jm4TViZHyTfVRgGYeAz3
         7M4oC3WCFNBPPBlyxLwYJWuPDYBrvXihjZr53Ar1F4zu0PG4KxJ+0Pk8s+o3yd5ifnWw
         EvEPqiTRfNOAkZ0r5l1dmxnuK8S0lJfnDeecVZbyhEdzlWn6To3vEsZWKpSrLqnHFon7
         iySRCkeiEocFbwy7/TYWtN5F359Vh/zB405dHzHSawFIfeaPJ/dfrDaiLrPolUiMPZAm
         Fc/eAdIlctYNJHchZCh62FE44jh5BsyB8jMXVXuHcY/scWqj6mtIBwUmSnjW6HNuE8f1
         Qjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734302667; x=1734907467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mux+X2T90rARK9K4me0bLNJaTeYIMJC1kTPXh2h86DA=;
        b=DOgiu8h+oqEdEz4RveXv87uQ6BFLYUA8iDTl5BVASONF+fauJ5/vbTs7H+HGG36FZc
         jNZLl2W+gIdQLh/pE/Dn/KAd3koXtZ1epamfOF/wG9Oc1KlE7K9KE2h40WfB1pjQuaZb
         4T0m9gzGYKiDY1oglhgGMEB/3UD0dGxTrChQi12XJwT7kPW6R98KaQSzIgwIjIu+z1OW
         DwDpYem6eE173b38ccvaBiK/9Gu13ynBfpit3YJWnHz+sYNW4alwfc1RgDDC5eywzAF5
         ExsGB3FUInV/NNspP8ZGvmIFyRms4usdJukH1zQDM7+X6F9J1i2CGJ2wW+/2v1xeIzke
         CU+w==
X-Forwarded-Encrypted: i=1; AJvYcCUaOxk5mmbqwv+sxA9mlqknzcmqUYtyBS/aBJL/2Ry23z00c5rZyezW1d+muvdQkJulgvB8dKt8udSy3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBi1rWVnyvn2XiMunOboEDDXFj+DnnK9fjYaUTYdZIy3Ez6dYr
	S43K9un31RHRJGPwXH74UNZizK1bL15yzczgwfbi5/Iae6JaadanXFQbeA3/bnc=
X-Gm-Gg: ASbGnct7tyrvoxc1YJZFwI22YnEnZkMic91VLXodVz2FrjlsdMsnsfew3TkpP2XdzzN
	jpL5XOkXWrYhvqIEFjmxOBjHRFGeWsvb+TI0PAv/dCFZ9wvtZ+iYZ9WBY/1Ox6JQfRIiZBljA46
	ODWOd2R8KM2SW1DK0tuEiQRbOJeMwMRABkD9vsqnfuE28uVK2+xZ5Tw2taQKR4MISTKUBVq+XIG
	rUYVsFYblxT7p8Jq/8UDQyOXnELEPB0zbOCLmOfpjr6b86Eviq6tS3w9arRwGWH
X-Google-Smtp-Source: AGHT+IEq3ZSHhSfGAciD4CoixAdrzoly+2VPI6MLxX5QrDDkNWHI7duVoDIS29ql4JE64rpxz9bIzw==
X-Received: by 2002:a2e:7d18:0:b0:2ff:c242:29c8 with SMTP id 38308e7fff4ca-302544e318amr26962871fa.35.1734302667392;
        Sun, 15 Dec 2024 14:44:27 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441a41d1sm7201701fa.100.2024.12.15.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 14:44:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 16 Dec 2024 00:44:11 +0200
Subject: [PATCH v4 06/16] drm/msm/dp: split MMSS_DP_DSC_DTO register write
 to a separate function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-fd-dp-audio-fixup-v4-6-f8d1961cf22f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2587;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=uGnZRrKJoZhV4YQRCG927L3JErIL80muN9PIVthRAy0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnX1u5s2V6HYGYWdaq0LWCQVdXUekZ49Bda6Fml
 emCsVBina+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ19buQAKCRCLPIo+Aiko
 1SHzB/sGEuMbZ3IWUbSZECISEc6h8hHaR6+noAaxl5hFc8WULW6Tj05/3XRUn2Ttbbxt+E3K1Zx
 JLsnwDQisJwq2SKAh1QXWGKzGB/ig7CULjSUfHkIva0u/LTjWXcotaqZCqsCN/Q2e+J4F9O/Lfj
 X6FvFHU7Zeac0iqTCXb1P5zglgQuTJTTYv0sxbuTpFSrZZDmkkz7som662RzaKnuRNUTR8VgfbE
 1SLZxlRk49Hy3Va6DlUxdYEQkGbyiCnVwzhu/Yi9SvSBUIWfcItU5Kw/Z+nS4f7wc1x2LRNQXBb
 ZqW7kCjvnCB4tYe3/T9XWQ+fqA8Sri98Ph0D64z6RF2h0o24
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

It's the dp_panel's duty to clear the MMSS_DP_DSC_DTO register. Once DP
driver gets DSC support, it will handle that register in other places
too. Split a call to write 0x0 to that register to a separate function.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dp/dp_catalog.c | 8 ++++++++
 drivers/gpu/drm/msm/dp/dp_catalog.h | 2 ++
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
index 7b7eadb2f83b169d8df27ee93589abe05b38f3ae..354ec834f9357c4797fc08a4532e69acc67b4317 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.c
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
@@ -1039,6 +1039,14 @@ void msm_dp_catalog_panel_tpg_disable(struct msm_dp_catalog *msm_dp_catalog)
 	msm_dp_write_p0(catalog, MMSS_DP_TIMING_ENGINE_EN, 0x0);
 }
 
+void msm_dp_catalog_panel_clear_dsc_dto(struct msm_dp_catalog *msm_dp_catalog)
+{
+	struct msm_dp_catalog_private *catalog = container_of(msm_dp_catalog,
+				struct msm_dp_catalog_private, msm_dp_catalog);
+
+	msm_dp_write_p0(catalog, MMSS_DP_DSC_DTO, 0x0);
+}
+
 static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_t *len)
 {
 	struct resource *res;
diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
index 6678b0ac9a67881244884d59487fa288d33d1be7..08bb42e91b779633875dbeb4130bc55a6571cfb1 100644
--- a/drivers/gpu/drm/msm/dp/dp_catalog.h
+++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
@@ -92,6 +92,8 @@ void msm_dp_catalog_panel_tpg_enable(struct msm_dp_catalog *msm_dp_catalog,
 				struct drm_display_mode *drm_mode);
 void msm_dp_catalog_panel_tpg_disable(struct msm_dp_catalog *msm_dp_catalog);
 
+void msm_dp_catalog_panel_clear_dsc_dto(struct msm_dp_catalog *msm_dp_catalog);
+
 struct msm_dp_catalog *msm_dp_catalog_get(struct device *dev);
 
 /* DP Audio APIs */
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9c463ae2f8fae916661fef1c7e225f55c1026478..b9c461fee96f8fae9259ce03a32e1155b42d17bb 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2011,6 +2011,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 		pixel_rate_orig,
 		ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420);
 
+	msm_dp_catalog_panel_clear_dsc_dto(ctrl->catalog);
+
 	msm_dp_ctrl_setup_tr_unit(ctrl);
 
 	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, DP_STATE_CTRL_SEND_VIDEO);

-- 
2.39.5


