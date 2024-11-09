Return-Path: <linux-kernel+bounces-402820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DC79C2D20
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 13:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CED01C211C6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 12:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A890F1991AC;
	Sat,  9 Nov 2024 12:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kMiAlQy/"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D771990BB
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 12:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731155731; cv=none; b=AJriDUtpuysE3T+ST2zJYn8lMNFCefuowBouZ2QzLUv+RHuHUbWkkois72wvEIzDAF3CvasxiOC/bz5Ne7zL46vcCe7+aiyMzKmkJ9V6uu9+a8qj1vlNQWX0LULdn1aUE2e2BPtkic5BQSFeH0w2nXnG6JNDs8kYuTPiu0y7Ahs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731155731; c=relaxed/simple;
	bh=bVuetdndH1+H+sM8qub00TaR8PUlbIR46HTQjmQ2vjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2Qnv7gA9LKIP4b0k9XRHBfMUr0O0KrKuHwoQfkAQqp+HTqgPgCMzTIP4HtpavziC1gFbbfVlCfba6CHhtfe+fzZ2ooxrgMSm/dEgpylVVR8fZAmAKn6XRD1PKCV2bN9oh3uzSYg5CvIYWvUBHFxzKx3Rd6R3ZqnH0E+J9hbYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kMiAlQy/; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f53973fdso2980854e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 04:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731155727; x=1731760527; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhftGPVLtDhe2UTpRu1zgEjgWPv2gRVws0y4aDafrjo=;
        b=kMiAlQy/H4s5cwPylcaw5DExtE7fU9qpvOo+uleHBEM+N+wu+WI3XknKyzhiu5yJPg
         aw8uBtIM5AWja3QwjdnD3euXDT7SA7eixwjXoMsAygF6XVr6FazwN+MjRdWyubviWCVN
         xFZccdA68+dKzYeipneVRNE9GehbEXzsWP9nJypuPNmiDueQlIFpdjPo6a+XyFp/4uL/
         h2ksfdZIEgaJMshRnHy9kDouCxcAUFHMn2WgHhGra2MF0YDfwmZWd8KTKUVI1NM8B+Jq
         ChV5Gxj7gaXesf/YMTyElD0fpSm6QUkz7Dd9a7B2rZxhT+Kc4pgUYko1/0Kqcxnxs6aE
         BDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731155727; x=1731760527;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhftGPVLtDhe2UTpRu1zgEjgWPv2gRVws0y4aDafrjo=;
        b=kDpHiZbiAmeNkB2kbzT80PRoEsqNlYVHIUr98h21q0Dlaar8/BnzrfeN2QDqx6B6gr
         Pn7aZ2sqBh4MrpHZg5aOxxxY0jcCt5ZRP+hUFCZcV/CT2yaIvKa0eDVJQcys7lbP2hQV
         Llh6p7/g0gJ9XXCiFLTgxOXyUU6tXDyi5W2/wm9rkXKjDLcfSdsrBnjrEtyRQ3KUC5lC
         m5u5equJhpxb7jFfwgI2qUXKUCYFIWOjkoCPTYIudj3AZ93ZKfEf7ynERFyHf0w7ly+f
         Pj8nSyL46DFuYqI5WXFdBhZCNXhW4Z6NN0HIR2Yc2xQGP9QCpmKZwyUji1smLVGKIZVO
         /rTw==
X-Forwarded-Encrypted: i=1; AJvYcCWtCNuojxV2LrjqPnNo8fOPT9cGLKp25rco/1r999YaatfI4p8FX1EWihZ/njveuRfWeZDN9ydTC74lWMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgtnWvdJzIAD/MBBZ4DqowpZnyNgHHvjlitIhlGL/fOXPDW/Lx
	859egGqtyBCw7btk8f4phzYvsCvhHQ8YiUzNlzJNeR3bZ4eYjqUbRJUmo3lBMho=
X-Google-Smtp-Source: AGHT+IEigUfK1s5B1XhS9sfEmdo+maxC2U8AZO/uY92umN9wYkTsgVSKNmZyXdmp1QCMyrfV4W+TfA==
X-Received: by 2002:a05:6512:31cc:b0:539:e1a7:345d with SMTP id 2adb3069b0e04-53d866c94cbmr2232719e87.10.1731155727195;
        Sat, 09 Nov 2024 04:35:27 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826784dbsm922899e87.15.2024.11.09.04.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:35:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 09 Nov 2024 14:35:09 +0200
Subject: [PATCH v3 5/7] drm/bridge: lontium-lt9611: drop TMDS char rate
 check in mode_valid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241109-hdmi-mode-valid-v3-5-5348c2368076@linaro.org>
References: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
In-Reply-To: <20241109-hdmi-mode-valid-v3-0-5348c2368076@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=bVuetdndH1+H+sM8qub00TaR8PUlbIR46HTQjmQ2vjc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnL1b/ZfMsGkQ52uI+m656a0A3dgPEqlPCAieD6
 1QAsnoR/kuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZy9W/wAKCRCLPIo+Aiko
 1eNxB/wJULjX0l8Lz4aRPnuWR70dfZVJYrQkpc+zPAuribEC0F0j7hQNWkmczAezUyvVpgP+Fgh
 04j4uyP1p4ZjZjgOqT7vq+wr3pCtkA/QWAIopDvYotWFldcsgLXdYCtpZskcTOcaG5rGGFCyTyU
 eNJhP0NRQ+UKJrK/n9t+WRARtDE9xjju194IYz61poLEPBdhGQVMp2rdhYyF6My5hgikZ4N6oq+
 a4ut24LnuuY50GSMoRukcFdytXScvNZQgHpSrxvkTvQvMdx2jsx70hJE59nYLmCcQpNLcXQ3z4x
 JeLtLBiJCB09gw/tvJDQ6ZibiPFWU4BeltZf1zuT3eU5stU+
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop manual check of the TMDS char rate in the mode_valid callback. This
check is now being performed by the core.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 1b31fdebe164063e6f3972fdf8a5801ef4c35c4e..b8ccffdf515ade6e3bf863edbedc41e6f2030f29 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -757,7 +757,6 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 						     const struct drm_display_mode *mode)
 {
 	struct lt9611 *lt9611 = bridge_to_lt9611(bridge);
-	unsigned long long rate;
 
 	if (mode->hdisplay > 3840)
 		return MODE_BAD_HVALUE;
@@ -765,8 +764,7 @@ static enum drm_mode_status lt9611_bridge_mode_valid(struct drm_bridge *bridge,
 	if (mode->hdisplay > 2000 && !lt9611->dsi1_node)
 		return MODE_PANEL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, rate);
+	return MODE_OK;
 }
 
 static int lt9611_bridge_atomic_check(struct drm_bridge *bridge,

-- 
2.39.5


