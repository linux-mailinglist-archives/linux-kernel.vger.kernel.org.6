Return-Path: <linux-kernel+bounces-439710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED419EB2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27C71882060
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E65F1B3727;
	Tue, 10 Dec 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZacQnUJ4"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198971AB533
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840218; cv=none; b=elG7TxpPsFFB20QYx+crIgs6BMYwpBwT+BuPZa6bKgtaiUUsIrriIsOpU7sDUR333aSzTdYZMVPt0bblVb5djD1bYbokFlqS2XT2ap8cRPBvMwX0HTp2jQHgPuvmBjzasgjYnITvhxlGOa1lDWsI/QiscW1+Qg1awSMExzM3xb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840218; c=relaxed/simple;
	bh=Dv9z5EQ6QS4Oh3NjXL0UPCIboG/Nxyen1A1+0E3853U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNYz21s4H035Ce9wriPKJELxtrQMgF0lygpwg7sZAH8rRPOTha84vjw11olehg/RdOyTmurcif/roqkrguRQCocGevPMVyMBKFJlT+SXZII39O2X1LfnvUSkq79T9oeoycKlFIZstppZEpaSA0I/ImefJdX7FH7fUaQEwvlFiH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZacQnUJ4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso2618594a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733840215; x=1734445015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG04n3jH1DFELR10HVCrrQfC/3zE3v8nOQLbFlHi9xk=;
        b=ZacQnUJ4UFpJ6L9J2PBNQKtkvibehSkqEtS6LUCStkF8cWKXz2u+Vnkn3SuXwLl+8B
         tY2qzGuzrzqxoiOpGjrjUPJKvL4o4oChRK3OWOvrujhlbB1y9RuWqQXwEB1V3GTt+Yoc
         iY+eh7RCbjunY1PKcFJBU1mwHok9BN8/MCnQdLnwhS4lt7ijbmqJgTQndCLeo3Klm7Q5
         8mUVBF74EsDD4HW468WbBgRSpIIu6Or3wN6Xq/R6YSDsb11wPFxgDo/Y225wGTO+Mt9a
         Ojf+BIp3KpKKet3OIkj2DwX1f85XICdQCalqtayfebd2rg+jC8C2Vk530N1AP1U09Frj
         ji7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733840215; x=1734445015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG04n3jH1DFELR10HVCrrQfC/3zE3v8nOQLbFlHi9xk=;
        b=RNqSUkH1oqAOyEd17NZ5rSgH5sRGMSsBbv83jjf5TkkXCe4ugRiv7DsNNUsW7YxDAD
         2gNHthWDjv2pYCO4W+PABpgwwLwCBmBGIruoIGLVLzbrm2+S7CM7S0hCYGvvEWi9Phyc
         /iwyV53VhtUP7am8IPc5zX0IU9nu/O8ZpmVU53UG2DsC1+z75U8Qt8i8G4rcZcloZImC
         94QOXVV19R8c7a83N/V28wvyTsPiwmycwG+l0CgBctCu7NAOvWF3LYjHzpIt9PoHvkTr
         Vi49x3FXlaGoQOKaXaTkV9HCIOgGNl35aH75A13VIPrRXR8P+z0w1+ru/W/nM+7gnjX3
         ElEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjCeZcDpegKKwwK+aFstyLNhVRjRzuFfaxO3VZs9VBqaUH72g8LK7hc48SRwJ1Fp6nclJopM2d6Ke7Oxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPM/zH2EGwCQyl/8AXYVi9JzTa1ne/U34B0kFiWrm00onmT6Jc
	0kwsk6AlY1mXjaS6HcGjjq6OOIhQam9mLcbv3MGsq0Xktyf+YWELKPEt1OKS8fU=
X-Gm-Gg: ASbGnctBZkp4mBvdIrHLaExvpO1EGhyv/XmJ+iSVJI37nKAa6CJ/461MwL70Qq3c8Lu
	PpiFLdwWiC60nlMknZ7UG9FjqgB5KiHl8A7DCtLyY0z7U0WXS6qesAJjuhefZOAnUxUNksKTZzy
	c6K5riLS9ttVKWRraMyUi0I9KKJMHr72hbhsVS+Oay0rWQa34vNatW4LxnvWpdr8jDJjf7wlM5e
	1auRCbzXcydY58otRDC5Ghn1hOe5yxl2wtOmR2+pJ3lGqOKLV+cUZUUeI1A8w==
X-Google-Smtp-Source: AGHT+IF8sFjqWDAeeHbyCT42Lo9bApykjgIi669+j87CMogHug4+toN6HpTcfoP9+THi9qi2bknF3A==
X-Received: by 2002:a05:6402:1d4e:b0:5d3:cd9a:d05e with SMTP id 4fb4d7f45d1cf-5d41e2a7ce6mr3458173a12.9.1733840215431;
        Tue, 10 Dec 2024 06:16:55 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dc2602b0sm5104362a12.18.2024.12.10.06.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:16:55 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 10 Dec 2024 16:16:49 +0200
Subject: [PATCH 3/4] drm/bridge: lontium-lt9611: drop atomic_check()
 callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-bridge_hdmi_check-v1-3-a8fdd8c5afa5@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Dv9z5EQ6QS4Oh3NjXL0UPCIboG/Nxyen1A1+0E3853U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnWE1S/0Nn6akcX1McXx0ZVZ1AI/dMr6QkkQx/u
 U7fii/uAsiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1hNUgAKCRCLPIo+Aiko
 1Ws5B/9oZ0/B7Eid9JGphPr14wDxOw29qknjLVHN5U7NEDQ8dTTi/dtbyoKPzfPnFFN9dIwGtem
 prJkHHRdfpP7LhRqHneiVD36zQCzdQLIgqZVBLaov/fZF6zWQ6hDKZn2LmAB7lDzbqm6QBuBPt0
 Mm06Ike4H+6d3galuqrXSJz9a747j81Lc1142qL1UGobmHzTb4gLlhLPab8l++29FWXY60kMImn
 0DKEX5nwYTHM0g+J8Zb+tRum977h8CXvl5yCLQJ/aOM7o0o32N59NziNqXFoN0ePdWDYXxdrqa2
 m7FfIhlygeUX6aIyYBkpvoM51yk+ZRB67f6CRUpo61LW/I7r
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As drm_bridge_connector now provides atomic_check() implementation which
calls drm_atomic_helper_connector_hdmi_check(), drop the duplicating
callback from the bridge driver.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 1ffbe473e4103dfc315a8cd3571e9407bf518797..71edb2b659de374c88b453a90a7cae902b97d91b 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -767,15 +767,6 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-static int lt9611_bridge_atomic_check(struct drm_bridge *bridge,
-				      struct drm_bridge_state *bridge_state,
-				      struct drm_crtc_state *crtc_state,
-				      struct drm_connector_state *conn_state)
-{
-	return drm_atomic_helper_connector_hdmi_check(conn_state->connector,
-						      conn_state->state);
-}
-
 static void lt9611_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					    struct drm_bridge_state *old_bridge_state)
 {
@@ -947,7 +938,6 @@ static const struct drm_bridge_funcs lt9611_bridge_funcs = {
 	.edid_read = lt9611_bridge_edid_read,
 	.hpd_enable = lt9611_bridge_hpd_enable,
 
-	.atomic_check = lt9611_bridge_atomic_check,
 	.atomic_pre_enable = lt9611_bridge_atomic_pre_enable,
 	.atomic_enable = lt9611_bridge_atomic_enable,
 	.atomic_disable = lt9611_bridge_atomic_disable,

-- 
2.39.5


