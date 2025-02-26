Return-Path: <linux-kernel+bounces-533371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE8CA4593B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1507A52EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA4A226CF7;
	Wed, 26 Feb 2025 08:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8sqDx7d"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B2224247
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560376; cv=none; b=RvliupWd/RG3XQXIU3Cgb8y9QWr6sJcfxTH2+nkVeE945vM5HtHbpVzQEpGLY3nPbN9VWPF/HhBG6wEwkAMHu+WMaliC8jqktuE8pYFIlwJeq1GkL/+/7LfwagfMKmSvLw2NZO9DWk9oooacPeFx3xzv2D6bUPA/cWirrQM0/Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560376; c=relaxed/simple;
	bh=f0rJpJCum+b7lqaI4sn4V9SXHt/v6K6WBKvJft3vbro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TF8b4WFlS+na5DrVpId9FoF9Q756g11cvRm3L81lcQpBY5vmwY8AYQTr2YTzYLKDNNFIYMsI1fW/vEE/KW3qrtGCE7zKSCfLw6HaaSoMxpgG2uci5w2K2pSURmHJBZhWzfnCNBKSqt8lUIYc3cV86GFf5CgAVd+eDo64kxfKVP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8sqDx7d; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-548878c6a5aso1580466e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740560371; x=1741165171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJeDvmYfwTrdzYlRuhgm/ygX8U3uOitNLlW6Q4NvxDE=;
        b=u8sqDx7dF8J76pNEhn24VRvrilFHR8ZcwskAS9DZ0NRChS0agCzAChJhucM/F8IV1I
         dvzVOjZqqNyu2t6m3/U7A6WKFwm08CohYrFGEkRHxElZ2hZ5DtgodEW+YEs27sn+2Qn1
         vgeoHXzWXJx//yIXnUd93ZsHTt12Ev4aGu6f6T6D/aviIwTW+hclWrnqXMiQYUlzkGdn
         ZY1YUz4FaYXcCKGTlJM41Z9CLFoFs21p/Z9EYVfTPYvNq3xRQlgJP8f3j4ghPysLmA8i
         x5F5m25IifjoMoOBW7S6UuL8WSvSaAs4Zvt2YVeZ/yCiH3i4Rg26usLRKt/ZTHu1bR1x
         +6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740560371; x=1741165171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJeDvmYfwTrdzYlRuhgm/ygX8U3uOitNLlW6Q4NvxDE=;
        b=VgprwDvvH+snLOMr6/gPAZuYXmoCxppY79icM0YfF0BuzW433R5wvE7mQtUzJkZV7a
         QkjoF8nYraLELZOF3sgNwC797lwTdk+vu6iRuazkJdWphHeWSWUS/73HscUt5bFpCLUt
         cm+Jfm13KqeoF4J2F7OPMCFDmipKecNyzY+WeFrLpZrPhvjwsEnQf+oCHMjt2T5syznd
         qJ/HRY3Fhsb1f+Ilg8cdE+43ecRR06m+XDSNlPxsnmNqeJTd+yaL1CvI95vaxppeDni8
         toB2bwriz94JRqLcDef/v31uukI+BLTYKD/JzjSPnwB6khk4YP1skhZ6Qeklw5P2TKxM
         cO7g==
X-Forwarded-Encrypted: i=1; AJvYcCW1cs4Xl1yLqF0iFCX585+Pym5ADVDa/fbLZ217ITppxkQ5Pl9q04ghSDNkY9ZdyuEtm3mRZw022u3GYsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvKcGEvxCwOAHVc2sLX+7JdM6T1sxyAIRMMkE7+5tZ26Ji77zA
	xbf3IyyiqhXeBgfOrIfEcTTXJYc+GFcO+wRLeJt9qbb+weyUpQFdPeoKPICKl58EkAx4T+iwOq8
	5YEg=
X-Gm-Gg: ASbGncumReNQlCt+n2dFXEMmUe1H344Kt77cP8M23bDwO9Tj6bbmmNYnAF6yCOEYK9x
	WhTHAQfGc9HriqcYLA/IZHMUfJG2bLG16LYoTe8sD5y7GJrXR8PY97A4nFVvv1JMLcWvox1b9y1
	Cl25bcMsLqLtR6bthWEtbzdwfgoQqTrKd0uTyS11s1WckQaolQelqogiJRVjoGUSiA/n9anWNzY
	sVcZj33z87XEsh6GZza3I5Da345KdV196HQpKQAXHMZ0qgujfpiDpSJ/+WDqWEQ4A78c6NwivSf
	pn7dM1hJh0qdqPFIp820NNGj84jUnmDbgg==
X-Google-Smtp-Source: AGHT+IHnyRZE9xXoxSH11WZO/mjHOb7FtOwcpzIW8SeHSDOj8wlDRd0QXQhax5YrxPLGfiQ8QHD+/g==
X-Received: by 2002:a05:6512:b98:b0:545:2c86:17e6 with SMTP id 2adb3069b0e04-5483912fcc4mr10487208e87.5.1740560370919;
        Wed, 26 Feb 2025 00:59:30 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a819e0c49sm4556641fa.10.2025.02.26.00.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 00:59:29 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 26 Feb 2025 10:59:24 +0200
Subject: [PATCH v8 1/7] drm/msm/hdmi: switch to atomic bridge callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-bridge-hdmi-connector-v8-1-340af24b35cc@linaro.org>
References: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
In-Reply-To: <20250226-bridge-hdmi-connector-v8-0-340af24b35cc@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2282;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=f0rJpJCum+b7lqaI4sn4V9SXHt/v6K6WBKvJft3vbro=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnvtfsfP5JOx4k9UNQsIABWXjlycLBo0B9VJPQr
 V2fMgIBoe2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ77X7AAKCRCLPIo+Aiko
 1fTVB/4gVuuKglGSNvRERQTsX298FmX2Q10UUHn8rmqstQrQ8oMQIL4EaDQp8VNkz1PLE/1bw9p
 ksul49Hd3DEFRM5mq8/7INGZ1FEwRZ7ZQr20Z1edKNZ7PUsgea7eUlODfTUbYlONna9hVUzi0yT
 t0QE8MLblgVWHsQ+oN0Wb0s64tF3dFG0Pk2n13YcIEjMvw/u6d5VEaY+ZrxkV1CV/Xs99XI/IiB
 2WhjKiDSBtHxwbDhn5hviSxdlcMDBOMhSIVKkizA6v3tscwuKGbmAAp7GIIS9skFTEo8icdswxq
 QciDiWte6IZK26X18olApN11vmF8XCRoM8ygHZC4jcZiIasf
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Change MSM HDMI bridge to use atomic_* callbacks in preparation to
enablign the HDMI connector support.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 4a5b5112227f516dfc4279d0f319ec1e5b17f240..d839c71091dcdc3b020fcbba8d698d58ee7fc749 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -126,7 +126,8 @@ static void msm_hdmi_config_avi_infoframe(struct hdmi *hdmi)
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL1, val);
 }
 
-static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					      struct drm_bridge_state *old_bridge_state)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -152,7 +153,8 @@ static void msm_hdmi_bridge_pre_enable(struct drm_bridge *bridge)
 		msm_hdmi_hdcp_on(hdmi->hdcp_ctrl);
 }
 
-static void msm_hdmi_bridge_post_disable(struct drm_bridge *bridge)
+static void msm_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
+						struct drm_bridge_state *old_bridge_state)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
@@ -299,8 +301,11 @@ static enum drm_mode_status msm_hdmi_bridge_mode_valid(struct drm_bridge *bridge
 }
 
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
-	.pre_enable = msm_hdmi_bridge_pre_enable,
-	.post_disable = msm_hdmi_bridge_post_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_pre_enable = msm_hdmi_bridge_atomic_pre_enable,
+	.atomic_post_disable = msm_hdmi_bridge_atomic_post_disable,
 	.mode_set = msm_hdmi_bridge_mode_set,
 	.mode_valid = msm_hdmi_bridge_mode_valid,
 	.edid_read = msm_hdmi_bridge_edid_read,

-- 
2.39.5


