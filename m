Return-Path: <linux-kernel+bounces-564768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B823DA65A82
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F91887269
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8A91FBC89;
	Mon, 17 Mar 2025 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="JdZmt0wa"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03677199EBB
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231614; cv=none; b=CT5V98ZWuCkazuQcAEStHey4MRoHNqaI+06nHhdi0UYI4FXAXGq3levzxJscA/s8X9yi9alja2Nr7+xa2G22kJPhdoiuvOC7btv6nwNbVc4TrUFvBHyFfxGyNGOBzLqpx47GBRMR0PgFurUsjJ7ITzrehGGCCQKSh00HO1lNjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231614; c=relaxed/simple;
	bh=X4Y16gQO1I9hR6tCJlQp3S0GEXb/4985/QrdFJI9Zh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Txx67jD/ENbf7P8S+yG7Kv+4pvjEPlk8iMnque1fVpBkIWUyEk3Jp06do+WILcJluHaoWwwwtJR8D+LguDEkcX/qRUH2PMC0/1ZOxVvaGJg59Q2N8PpErOZ9+wtOEXmRU56IqWMUxtQ0vp56+IEdKYe3Up4IFJXuFNM82e+P4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=JdZmt0wa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe574976so15009915e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1742231611; x=1742836411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRDTsBjDbCS/Pgq7ZICBGwt1MaN5NlT93wkTd9DN6xA=;
        b=JdZmt0waaaTaysSC4aXHHE++i2ta6q8IxGBrrQ0Mbnv3DYLcNUYaVzyBVg3gmn/3Zk
         lCtsRxo3MC0cDWhWt/mtwll/v2wAD/+JgYnYKtf3Hf3o/KkXF1G41kWNooMjZ247ZjDQ
         YO7ICtab//+Ip3LwxF36u2BKHH1NKFCR93J0S6JylFyf65bxDEvXmJlAKPneKoqoinzA
         BwoflPEDwe24IDzqoj2+eGSEJnVD4O7Sp6elD50obHcYsPyT0a3MVA4Q3vtKawwwqI+1
         pE2ph/lX0eWZ4EOebcGRk6tAqS9N6kDLlqtyPW82IJ7tWWoikP8VIycuV2BhlEh9aHt6
         U15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742231611; x=1742836411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRDTsBjDbCS/Pgq7ZICBGwt1MaN5NlT93wkTd9DN6xA=;
        b=KSHvcej59XOtD6EDjLENzqfTdiamwYWLIJ0ZBrUYZccUeTtBreKy7CR2ksx6UcXKxJ
         ozlk1+2//mU6nsrzufnkHpJz0T5uWkiNPPTf7bzW9r2Vu61ptrLk9/9UML9MJQ6RE4bz
         f1CgHSGhAGlCjcCT63UD/3kypIwSXpMaGhU/oAfdK1/rHp3uAoiFt4LbBpOmVyOMfHwn
         x1IAhp07pi1+Fe0Dph+9OSqQSb/syIXadlRjRRz1VJAaE4wbCX0m0Pxu2FrGfiH/e8e9
         3LYnAgwTSNbbEB/+fb9R9Ec8qfPmFTUMg1Um5ElcxvQ1jAcxsMPYTUUFgwYo8ZSmXR0D
         eaFg==
X-Forwarded-Encrypted: i=1; AJvYcCWnou5ZFq8dzpHUlB3JuzAdYkY4VNJNCHexw5bH6wHAGWilMxTjTXCKg+UiaaWp9094Nli+HnXzwgybrbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp88dHgA5chXEM431/B3hSP3bkd4L+/5M2FWv0upPrfMGiSJwe
	G5J0DuaU4lyBGmFlUSrGZA9U5cwlT9tnQX/7OJ9QZTyhUyOUurPqffospuPH2OI=
X-Gm-Gg: ASbGncsZyLGrwHaR4RgcWpM2PUX+rBw99LYvPpKfDF+9yGw6Fobh7XUYBfxFaAeYCXU
	ySU2wYT090mqlTpL0RtvR0kPUK+ieXM9fOjBC9bs/c54QqBDRLxNArnSA8++OUCw5yEbRwh1lw8
	WZF1lc0An1IcdKSF8WFoIkxYfOuM7x1EmEhbc3Tq2NmVYAfm7Yo0Dj98OvdEhD1WxfnlJQxOgNP
	L5P9d/AVu+ywpK2Vy6NASxXGVoIXnqXnwHf6R1GNQrdFTXyqAa+zE34mKwO3/Vn8oKPRf8OnojL
	s/xTXrWB9h3f5I0pjDd9McZSB8ZEyDwjhA==
X-Google-Smtp-Source: AGHT+IHaQFEGmNJHvYPiwKVLfVH0wjBZjXXR2bM1ay2xIHNWMsAaGkue/Sb8FK6LJoE+P8Wy8OzqnQ==
X-Received: by 2002:a05:600c:3d0e:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d2bb4d786mr47087915e9.23.1742231611236;
        Mon, 17 Mar 2025 10:13:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda15dsm112003365e9.3.2025.03.17.10.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:13:29 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Date: Mon, 17 Mar 2025 17:12:22 +0000
Subject: [PATCH v4 1/3] drm/display: Update comment on hdmi hotplug helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-vc4_hotplug-v4-1-2af625629186@raspberrypi.com>
References: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
In-Reply-To: <20250317-vc4_hotplug-v4-0-2af625629186@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>
X-Mailer: b4 0.14.2

Update the comment on drm_atomic_helper_connector_hdmi_hotplug() to
clarify that it must be called for all status updates.

Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c205f37da1e12b11c384670db83e43613e031340..cac819ac468de020e4e75b3bcb09c31f909bd61e 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -816,7 +816,7 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
  * @status: Connection status
  *
  * This function should be called as a part of the .detect() / .detect_ctx()
- * callbacks, updating the HDMI-specific connector's data.
+ * callbacks for all status changes.
  */
 void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					      enum drm_connector_status status)

-- 
2.34.1


