Return-Path: <linux-kernel+bounces-237540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C7923A99
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438B3284880
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFA158849;
	Tue,  2 Jul 2024 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="se6Vi0Mf"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA64157465
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719913741; cv=none; b=Czu062krk7DFpTHwUkZp3JpCJIvxX/SoMMvRv1OlwqxWps6vr5tRc+2e0dGctJKdx0GCQqg3Os8GF6tsUfvGrM/0Ug5V1R8BJB/lOMM0J4NxHi/cnCg1zGLhtXrENO39HGSu8XSgM1xzc5cdpimC+p5F1HhBVOp+Asn+/NI9RH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719913741; c=relaxed/simple;
	bh=XfWO1UT95i4nFh6ks6YHBz3BepXJnrLcVKL7lmB6nak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfGtsNCTp8/YWPWe3LIQXpR7A9GwjnBZ1Xg5NoKdh1oM2VI+8bY1HXkSbsBQ/oqqXE5UTBy1g5wNPE6J6jKhwLxKh5TTcsEEYXwd9y0YmBPf++YSoG/AoYwkkfI20Nu9/E0EcuolichoNEFPpj4Dt7Krj9kxHdGrcsZGtPn4UdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=se6Vi0Mf; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec595d0acbso48710881fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719913738; x=1720518538; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQKBE1FE4gVeE/pTxSlRLGb8qXFL4Qosomf5ec/NnUU=;
        b=se6Vi0MfUsUjEtSfeGtC2cvAJrTgPXYpSlrlKvijhKT7u9Y4fv+XKyI1yU1Fr8U3L4
         yZBEqu4i04o3BNnDd5L4OZu4epFSguIG6+srtmaH1ZVNr/OOQv9nwvPyOALhPOBVDjWz
         MAIdccJd+21gf+O8G24i3Q/FWXx4iL9tl/xJQmSQKbJXdkz5x853rtd4Rz+HumBvVCeg
         LMhx77k2UCS1wQ+HX8DdHUZFkMUHi46DZkjr2nK9aWpj08K66f4YId9ByFdj9e5VdYtV
         bS1qnLKDfEcVUsfyxy2DKokx2n5U0ffOIMo/Q2fcneaZUacUluCRYriepxrRffj/sPzE
         dfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719913738; x=1720518538;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQKBE1FE4gVeE/pTxSlRLGb8qXFL4Qosomf5ec/NnUU=;
        b=oMkORlLIWvtmupkn/arpRVWXusVaPloINP9MgSkzd8645se93TzOKkGhTRZiLIvJwR
         75KXqT0vNQK83rl8gJMZHMlkRFQf0NNiCzfSA1VoFMzy2iTtEy/L3BLk1rUE8vV7jBN5
         47uHW5n00RcoOxbFADOUAkOfmK11nh62zQYlAiQvPpPsSUFRxP8Pg0bKbYnMwmDAjGbV
         dqbakGl7/wVl66q+GO+iLXjwZPd/TpR99IKHlC4YtJcwSWX8x6KP9EUA4f1kNCWrH7fk
         HYuiEZFzFLwVS5ApOihHwGI4+p7wU0y8eaOwL6tzoMy+1vWSLoA33Pmd/Oa4hGIKLFCT
         0iHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoW7RZUldmdH9tZQA41xtvVXEWsOfaHQl2psbLLuOOvg2XedcjDZluAYLq7kgIEZJVlZOu9XgxAQ2WDQgGa/7iQy11BrbaJ36m2+aC
X-Gm-Message-State: AOJu0YzoMGzRneWi80CLdnUI+43YFvvKgxnK5CRx9lHfMeYJB0uB2ShM
	6zRuLF2xZ2jXIZwMkNrVQSKxPumJiM6lSWLJ0I0D7Jt5HLSgp/KaPcgTNxvxTzg=
X-Google-Smtp-Source: AGHT+IFqBUb9Z/lQB5tnnDyAQuJJOp+uTr+Pgp7gBda/3vOoSNPxzuipgShTPcGYxiszIB8CQWowdg==
X-Received: by 2002:a2e:a78f:0:b0:2ec:4e99:92 with SMTP id 38308e7fff4ca-2ee5e3c32e9mr78874021fa.29.1719913737970;
        Tue, 02 Jul 2024 02:48:57 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5160e333sm16231161fa.5.2024.07.02.02.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:48:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 02 Jul 2024 12:48:55 +0300
Subject: [PATCH v3 4/4] drm/bridge-connector: reset the HDMI connector
 state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-4-12b0e3124ca4@linaro.org>
References: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
In-Reply-To: <20240702-drm-bridge-connector-fix-hdmi-reset-v3-0-12b0e3124ca4@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 dri-devel@lists.freedesktop.org, igt-dev@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2314;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=XfWO1UT95i4nFh6ks6YHBz3BepXJnrLcVKL7lmB6nak=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1rzWdb9r/6I6H3gyF9qODH2lY8y17SPBf1qHDLNjUucT
 kuIepl0MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAin5nY//B5XWtTEbstXeAl
 e5cpTPjg5Bv6mSzbxX8zL5dOCQsN9w9VU3yc2/Bsbu603rUvpjwq1D/43/h+ppPUa84AowTVN1x
 7bl38cu5UDd8Unw1/7nEb9q5ZZaG18dzsRl+usvX+jK9nnrizbGp+wfsoo6q9IsXLtBxcTUx7Ty
 j4hBdPe5iyu4rjTra+//LSHE4pI7v/af0tD3JNZaPUnjeYrvbssdi2KkdM87eDq/OkWdqPLkidL
 QrZ8u7jm5yX5x7O/ML992hwf8KVD54zrMK8pBtqm2dMPP5hgdPZ9nrujPS3bHXHPXucNgnKGGmF
 trMfWP7HXuCEqdek/ki3yxsvLF1st1dQfs/ST30WWfr+AA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On HDMI connectors which use drm_bridge_connector and DRM_BRIDGE_OP_HDMI
IGT chokes on the max_bpc property in several kms_properties tests due
to the the drm_bridge_connector failing to reset HDMI-related
properties.

Call __drm_atomic_helper_connector_hdmi_reset() if the
drm_bridge_connector has bridge_hdmi.

It is impossible to call this function from HDMI bridges, there is is no
function that corresponds to the drm_connector_funcs::reset().

Fixes: 6b4468b0c6ba ("drm/bridge-connector: implement glue code for HDMI connector")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/display/Kconfig                |  1 +
 drivers/gpu/drm/display/drm_bridge_connector.c | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index 1a192a45961b..bfd025f8c7b5 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -9,6 +9,7 @@ config DRM_DISPLAY_HELPER
 config DRM_BRIDGE_CONNECTOR
 	bool
 	depends on DRM && DRM_BRIDGE && DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_HDMI_STATE_HELPER
 	help
 	  DRM connector implementation terminating DRM bridge chains.
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 0869b663f17e..7ebb35438459 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -216,8 +216,19 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 	}
 }
 
+static void drm_bridge_connector_reset(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+
+	drm_atomic_helper_connector_reset(connector);
+	if (bridge_connector->bridge_hdmi)
+		__drm_atomic_helper_connector_hdmi_reset(connector,
+							 connector->state);
+}
+
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.reset = drm_bridge_connector_reset,
 	.detect = drm_bridge_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,

-- 
2.39.2


