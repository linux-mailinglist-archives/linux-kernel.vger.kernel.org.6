Return-Path: <linux-kernel+bounces-439711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECB39EB2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323A32869A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9F1B4245;
	Tue, 10 Dec 2024 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BUx3Wh4t"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6831AF0DE
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840220; cv=none; b=HldcRHMPQLgR2K2ZhuwlB7o5aglAeEPo9vlhSShE7wedI7gvsXTzoMCV6IDJhkc1bft4wyyef6z93LIhr19Tr8TEybMsTcZorSp9V66Xo3xahQdf2jpoS+roRJHjeDBkBhe+ESjIJeCsKIWE2x3SpyDSbN8/TV5eEqr153Rc5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840220; c=relaxed/simple;
	bh=iFbekFcbElRUJbcXMzK8ElBDVWKjAytyCvWyk7X8SUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zm1Slr874fjc96uBKPmqTVkF63Yc6TfnDrWYaAcY0saSrkVxxUHvzxxb3pA74sGELP3jdGNmUUGIJhZSNzhESo0Nzs0U8UE1Ea8IBTNFAjNwvk1ohMrJQTQ4fCrvzusLpjwcGFTlRywa/NIH20k31cHAl2gpYh1DABaTeNRAb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BUx3Wh4t; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa692211331so339732166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733840217; x=1734445017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VieodBk7g9+NNIIq8wzqsxrxxT4oOk+FbtOuCNcBAU=;
        b=BUx3Wh4tzaInkw1out7SiCE+T2crAotVefwSsbXaJl/87D+Blg4Xka958x8+Xky8ib
         5xr/xSEAlOSeoR1ZSuBMbrAWcOOtcllgDaQ5PGLsesO/D9yBIeHaVH7zoAUHQTQl3jYh
         fljMyrESxDJuzE4gkTOeu5sXZfCkvWkBIt45mdjs/WDkw2pLYKoAxEfLiOtEPj6LNNK+
         +F78TL7hvNm1e8dMRu70zTVGx0DX3OljsAiOmVIPlSUPSVMcALtWR2xY7BY/FQtCzNUv
         HjQPqY/tm8xbAeDfx9xN/DzEWlp/pTMRA2rqymGDD4yCoMcISuv7600rsAzC5+TD0KSQ
         BCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840217; x=1734445017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VieodBk7g9+NNIIq8wzqsxrxxT4oOk+FbtOuCNcBAU=;
        b=OQSAZ8mmGlt8K/MuRgOAvPZvWciVTYWokD64gTyznus8SFqRRf/tWBxWVDPHPh4KpU
         xVt7wqVb5T2AASnDsPuuv/xVpDtXhfTze9GmnCPuiku3XOv5n0Jwxh3VsYWDSi2ToPop
         mNswb2K9TgkNZZl8OfQBoMb+5m/8OJi9VkbLR4cl2S1emGWxlcJ49D0CEVYc1G+wb12O
         7mG9uN0TlP7ujjgkJxCu+DnUhi4E51iX3U58JsI6cK51BobHNX/GiE7N9A+j0w+5/FsJ
         qvW+y+jXUGno2XUBliv6QbxCRicycX6VMUVdOYAQyVnbVi8hEAkOTfntPcHNA7YJwjgY
         OKiA==
X-Forwarded-Encrypted: i=1; AJvYcCWAJrJTVZmBe6sXsYhU7r9WMVKgWnOP77h7oU5H3ixUVCinCVCtPGlY20gEiyxXIellh3aV9gKm2LOVI6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDgqHUHDVLlU+oJ/4DBGjzpqw/J+y7nafGqVSMfTD9vPzAiwd
	JXxmbELa4twi8GVKdl8zKxnkl8nTWu2B7esHaYxLum3Y4+TlH+oo8VWahhzJYWw=
X-Gm-Gg: ASbGncvSxpfAWf7Ls1oJFsfni5Hv3vY/N5V8oVDtlLwGyyhJ2b8hvusGP/m5v4bk0r3
	He0MztchKI47umPKNEROn/v4CmjrXrvcTpU1tQ5Xaikz5ROUrPI9OYFwRIO0DXmsk8/ZILgxSWs
	Fnw2Cbi37DU+wSoNVYj+eM3WsI2Af+oN0V2EPm1pfNVu0H1E3KkmH/zt0OeLZNjh9XDvHz9lkLB
	euIgIH9jVdAo/fbcISRR7eytY/wpWwRnXYS4MFQHk0tL5uyqTiHQvsEOp9vhg==
X-Google-Smtp-Source: AGHT+IFqj9fbpUiNnMEmvJaqOFp6heSbFuzVSyMydyTzS2DZeEIE3lH+oK4BSZlyPgf81n83uN7jJA==
X-Received: by 2002:a17:907:3da1:b0:a9a:6c41:50a8 with SMTP id a640c23a62f3a-aa6a01bebf7mr370929466b.17.1733840216571;
        Tue, 10 Dec 2024 06:16:56 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dc2602b0sm5104362a12.18.2024.12.10.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:16:56 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Dec 2024 16:16:50 +0200
Subject: [PATCH 4/4] drm/bridge: dw-hdmi-qp: drop atomic_check() callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bridge_hdmi_check-v1-4-a8fdd8c5afa5@linaro.org>
References: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
In-Reply-To: <20241210-bridge_hdmi_check-v1-0-a8fdd8c5afa5@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=iFbekFcbElRUJbcXMzK8ElBDVWKjAytyCvWyk7X8SUk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWE1SaxHLSu0OtwBtkIyYbWi0IxmjxvAGhmxU9
 sS13D1+OkKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1hNUgAKCRCLPIo+Aiko
 1UE2CACOGOQdt26+zxC6axMeEn4OWtbasMLCfvKvA1gR4JdDpUaq+snGJvhcXNFOjtt9wRZiyoU
 NwA3TsTrw7jLPoeMiTgDTbOnpOJlfU3jUM9O20cerZqKPELyWcgL0Ozi9WvwOjqW32T4OtS4Zzu
 eT5+/7pHAGGBIlrWyq9PH8QhXjJUM5eYBYhnzLpQZLL/zCcrLilrQ52M7x+1VuQoDN5lvLOum3T
 UvoHF6rMV6yb0s5T+lzBPB19mjwLfKlKxyTk/lnLHPY63nsf0XvL7vlimDibnc5inXoiN1pwu1n
 CD7wjE1v3Qm5jgejFH8SAgaghLW1R19Q6YdkyRRyZ0TtCWX1
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As drm_bridge_connector now provides atomic_check() implementation which
calls drm_atomic_helper_connector_hdmi_check(), drop the duplicating
callback from the bridge driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index c686671e4850a1af75b82995185ffc3cbb22a447..b281cabfe992eff88a4ba7bc903758bb119281f2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -361,22 +361,6 @@ static int dw_hdmi_qp_config_drm_infoframe(struct dw_hdmi_qp *hdmi,
 	return 0;
 }
 
-static int dw_hdmi_qp_bridge_atomic_check(struct drm_bridge *bridge,
-					  struct drm_bridge_state *bridge_state,
-					  struct drm_crtc_state *crtc_state,
-					  struct drm_connector_state *conn_state)
-{
-	struct dw_hdmi_qp *hdmi = bridge->driver_private;
-	int ret;
-
-	ret = drm_atomic_helper_connector_hdmi_check(conn_state->connector,
-						     conn_state->state);
-	if (ret)
-		dev_dbg(hdmi->dev, "%s failed: %d\n", __func__, ret);
-
-	return ret;
-}
-
 static void dw_hdmi_qp_bridge_atomic_enable(struct drm_bridge *bridge,
 					    struct drm_bridge_state *old_state)
 {
@@ -503,7 +487,6 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
-	.atomic_check = dw_hdmi_qp_bridge_atomic_check,
 	.atomic_enable = dw_hdmi_qp_bridge_atomic_enable,
 	.atomic_disable = dw_hdmi_qp_bridge_atomic_disable,
 	.detect = dw_hdmi_qp_bridge_detect,

-- 
2.39.5


