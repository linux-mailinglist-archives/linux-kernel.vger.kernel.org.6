Return-Path: <linux-kernel+bounces-571442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0307A6BD46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11D03B40B1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C71DB92C;
	Fri, 21 Mar 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1VScosh"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF922ACC6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567784; cv=none; b=Nb9KoznuweMyN8b1DWSi44mDe+OUqlds+oHNONMephhsxqkCk7ApVpwnJ28tUpwDQX6NZjblIIbSul7Puxy+jN+l/MloE02J1LjQMW3zGi8ZZh6RR54CKwC54+4XfNw4zm114X8O9+thvd8tf9xSHPEepmm46+f81ytK/OsNmr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567784; c=relaxed/simple;
	bh=kBJwR7yqL0mQVL1xW7vBVyuWNi2t1Nj7PNvDRyuKSQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TztPYXWKi1SWa/i+T96Ybs4lfUkjexuKKXg8O7VW0UgfAThgltUM4cwqJDLoMJvQUMIy7HrbWjOBg0ypn7H32hymXNWpG+TTl2UbgndfZPb3njzE0d9uGI38PxRimWx1ZPvOrimzmlLA5mE8x6t0L49h73RYWhixITlHeKyWs3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M1VScosh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1265278f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567781; x=1743172581; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3fsDQxf7sE00cNo/2u31jHrQzeoPoyXMSlWbib8RZb4=;
        b=M1VScoshw+SzSRL9dSsBDwgqmKiVUXUX/wNZn4vO40SOggGpt4LN1lLwk4SUfqLm8h
         uitZ9sqUaa1QZXRERNeiLY58GmfJywy9HhRpqzMFAehMQeDylWxCPuL5jHD1U22vljkW
         hxOYoin7/4JzMNFpVXRkk50aUh+GurSB9uBPOCDYv+vmFNdk5W3SuOsV6u+Rsmt6v2rV
         O2FYG6jHIDgtZtrTo5B7At1HHZaRS3BGYyEdyEh017NxrDX869tHLvnc4rfSk4eiMVnA
         lbE/pnJhhIFpOlDK81hEoJKPYGwHU3kjzgpGGmQumW9cosK6eAz+tY37kXfaiYVlid/a
         qt1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567781; x=1743172581;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fsDQxf7sE00cNo/2u31jHrQzeoPoyXMSlWbib8RZb4=;
        b=wSsrrdNgy3HjHhCnBPZbL1VmerFscXhyM2HVJQSyCdTCmKl9iTUgFAj3Vbamoa8t4O
         V9DpNZNiT7RK3CiXvXV++e9SGv7D+y8MrWXhW1gKjyo+wIjFyPV0xleEDrVxbe7FEs/X
         H9A+YD6X0qqVq5CaKI7bFtwTjCG62gVChRNNbdkqTAQSxr9DwTkouNfDmzZK0M+8lm44
         6SlocHvFEgI9kAX2RjZDhbK9rJG73QP1GQ9Z0xtLsA8tlSAqUntuIDvyA4OYUPajpwXz
         sw0ZYxsbEBLs5P5eLRFmXTsJ0XNJND5lIaY+Mua3jmuAMFAbT4MIGB7gXYAzGBT3H6de
         WijQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCqkO43T6ZObj1Jh/QaytKaazDJO2LjtyOXJp8H/BiOclYDRG7HWSZR5uV/LI8spI9FER90cGgvgl7Lig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgirKi0SCCmQOH3wdhvTDBh354648B7NF2IRAJFqI5XuGiVtam
	UaaeH8l6j9j2sOJtZqnwk1UUOFwd58MSfiA9N63u6Gxx47h2xBvjBxxkvvQyno8=
X-Gm-Gg: ASbGncu5eqGKF+UFS4uBMqn+tW7pGejNnuDD3AmAy4PUMGYkVZjfm1DoSo/2hfLtj5f
	9FZ1h5UK9dAWON5qhjFAFSvFn2HipfFAIQHVhHfnH8Gb9oynn/Nn1wInAepqgDD61lVMDuEdyiM
	+EYsnS8oDrDfYeJ31AOlHUtfw08w0OrihBj9qnRCOIwZx9PrxN+yDXtBrIzOEaIf+rXgdHVqdm+
	+8/BxCx1ctW/Tqoqckvwd19uRULU/b6IKJ6yGx/yZF7FPj1Uz3ECYJ6BPXICSEhbR0mLxl6AN9C
	amCekj36fzzPCW891Q/DIgyHYT3k1hD4pdxCK/e7SaGVyN3VbQ==
X-Google-Smtp-Source: AGHT+IEgYecXG1++S76XR+sJROCwf96bxZG3f1zzap9S0mQvYbpTt9wv6b4eLg8AyhHlqK1JOitUsw==
X-Received: by 2002:a5d:64e4:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-3997f8fa36emr3786610f8f.15.1742567781323;
        Fri, 21 Mar 2025 07:36:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd277d5sm28710235e9.19.2025.03.21.07.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:36:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:36:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/bridge: chrontel-ch7033: Fix precedence bug in
 ch7033_bridge_mode_set()
Message-ID: <20c0422d-b4fc-4ec7-b3e5-4c4679f499f5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The problem is that the bitwise OR operation has higher precedence than
the ternary expression.  The existing code will either set
HPO_I, VPO_I, or "mode->clock >> 16" but not a combination of the three
which is what we want.

Fixes: e7f12054a1b9 ("drm/bridge: chrontel-ch7033: Add a new driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
From static analysis.  Not tested!

 drivers/gpu/drm/bridge/chrontel-ch7033.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index da17f0978a79..1b858a8ced57 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -404,9 +404,9 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
 	/* Input clock and sync polarity. */
 	regmap_update_bits(priv->regmap, 0x19, 0x1, mode->clock >> 16);
 	regmap_update_bits(priv->regmap, 0x19, HPO_I | VPO_I | GCLKFREQ,
-			   (mode->flags & DRM_MODE_FLAG_PHSYNC) ? HPO_I : 0 |
-			   (mode->flags & DRM_MODE_FLAG_PVSYNC) ? VPO_I : 0 |
-			   mode->clock >> 16);
+			   ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? HPO_I : 0) |
+			   ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? VPO_I : 0) |
+			   (mode->clock >> 16));
 	regmap_write(priv->regmap, 0x1a, mode->clock >> 8);
 	regmap_write(priv->regmap, 0x1b, mode->clock);
 
@@ -427,8 +427,8 @@ static void ch7033_bridge_mode_set(struct drm_bridge *bridge,
 
 	/* Output sync polarity. */
 	regmap_update_bits(priv->regmap, 0x2e, HPO_O | VPO_O,
-			   (mode->flags & DRM_MODE_FLAG_PHSYNC) ? HPO_O : 0 |
-			   (mode->flags & DRM_MODE_FLAG_PVSYNC) ? VPO_O : 0);
+			   ((mode->flags & DRM_MODE_FLAG_PHSYNC) ? HPO_O : 0) |
+			   ((mode->flags & DRM_MODE_FLAG_PVSYNC) ? VPO_O : 0));
 
 	/* HDMI horizontal output timing. */
 	regmap_update_bits(priv->regmap, 0x54, HWO_HDMI_HI | HOO_HDMI_HI,
-- 
2.47.2


