Return-Path: <linux-kernel+bounces-263976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A3993DD6F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42201C217C6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048A1C680;
	Sat, 27 Jul 2024 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeUtVqCH"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5B14A8F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058342; cv=none; b=HsIJDGEZj6xpff0K55tHcwmvRZ/wC6yIyH0VGSpw1m/pX4gZ2Xz6IKG3DBktoTQj9hWxzDXy4Jo48RounUehsM35kVhWk0nl8oZGzspYo+JZhyRRcJG7uAW8F2eFNMMbQzdbjgONI4/dNalyrEvc9Gj7OBwuDEgRnQqaGo33PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058342; c=relaxed/simple;
	bh=GEANmLRl3pd78CbWRm41BOno0EJdXj6oN+vaLlcrdT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LeR8mbRpp6NOweW3qrt9bPYJX8O66dVLf5D2kKHQalozO9BlYEU8oQzLSn2TeydDsG2xvABts7ommcht2MgrX8Q2zTvPS56v3k2U9o2kv8gcC3SomcT9qPE/LZS3L9J8Q+5N9aMUDPX0h1nu5olEskdkO/5fqZFkS1gCkIP1ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeUtVqCH; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db16a98d16so1065586b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 22:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722058339; x=1722663139; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ll2tSeXkgEmDF6KKRHBsaNEm0CYvP0CwAGds8QRblZc=;
        b=MeUtVqCHUSjfz0Op/DKO/rkaMvO2DUVbsh2ALrMNfZfJQg2pE/uzT0D46UmKqI0lhr
         kCdVjUWMgAGlT9/srtA8QGR/o4AMi0vM3zm2kh2BE5PG7rWTIehNTR9J1iARp58ForTk
         Z90A1dC6IozAhZcW6XNjJiquIgP/42JXJ+a+ut7AI9yGv+3lTG600WUBhbZO54D3i3Dx
         Lluae7JdGPHLVOMxhtG0gUNBe/w6A6XYG6eIRNr+ol8NCO3lZAtnH7ky0usRuy4FflCS
         Jdhscb3pjoPkwxvR4VSnUsDD74AOxxPVVDpcFZ4NAinV7z6XJ4seNSU5kSYWN3zyl8Bt
         /EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722058339; x=1722663139;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ll2tSeXkgEmDF6KKRHBsaNEm0CYvP0CwAGds8QRblZc=;
        b=gi86nRRbWx3S17gegMt31wCiklWRlHf7RVabuVMCgbv9p/EAFueMRv0HpQsHUSWMC5
         rSkRCO5zzQX8tjNcAZH06p1tvMq4AC+/dRzAd8baPHCfX4UoK5vPGp5Z9q97cnKVf6Eq
         OazxMVOhDhjf9TKA551HBMCELK9yfZn98v1vA3YUuGntUxNsuMpw4olXCoa8eHh5DB1w
         HkQ8wF1xLvkaGMsblgoQgFk6fj9LOYagymybWc8/A2FFjfU7tAVQQaqyy6OTJ63X/D4t
         1w6hzAUKQdoefvGkw3gVRyLLCsyd314BTdQxT3BFFmyLHS0fBlRtZ8PrJ4tLpzIzNgxT
         Ducw==
X-Forwarded-Encrypted: i=1; AJvYcCU3D9ic8+QAG2T8DRX+NZ5Qh4KpW/TdFj2rzuTuq3qnG8ifXR4SRHclvY9mzO1gtVcy28DXRJ341oR6G/IpixP9UFHw0ZIjtFTn6RUO
X-Gm-Message-State: AOJu0YxwIhMONHMH+57k5gFwGuIQ+IB3eHNTPr52qIL1KS/2eAhTqmUE
	rzhREspHxqiK6V0wtUThg4S3sqn+d/3NIyEVEk66YTMjeC2OtcJyir4vU9m6AnU=
X-Google-Smtp-Source: AGHT+IHUCPIsi7uCYJwSWeWo164OHgRFN3CFwvOwVNjz9dDYRNJ4CXpR1iCMOHy3FSP/CtE+ihndVg==
X-Received: by 2002:a05:6830:65c5:b0:703:802a:98a8 with SMTP id 46e09a7af769-70940c0eb3cmr2782964a34.9.1722058338829;
        Fri, 26 Jul 2024 22:32:18 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7093070671fsm1112735a34.21.2024.07.26.22.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 22:32:18 -0700 (PDT)
Date: Sat, 27 Jul 2024 00:32:15 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/plane: Fix IS_ERR() vs NULL bug
Message-ID: <83d9bb89-1a16-4ca4-80b4-1965fca498c1@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The drm_property_create_signed_range() function returns NULL on error,
it doesn't return error pointers.  Change the IS_ERR() tests to check
for NULL.

Fixes: 8f7179a1027d ("drm/atomic: Add support for mouse hotspots")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/drm_plane.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index a28b22fdd7a4..4fcb5d486de6 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -328,14 +328,14 @@ static int drm_plane_create_hotspot_properties(struct drm_plane *plane)
 
 	prop_x = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_X",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_x))
-		return PTR_ERR(prop_x);
+	if (!prop_x)
+		return -ENOMEM;
 
 	prop_y = drm_property_create_signed_range(plane->dev, 0, "HOTSPOT_Y",
 						  INT_MIN, INT_MAX);
-	if (IS_ERR(prop_y)) {
+	if (!prop_y) {
 		drm_property_destroy(plane->dev, prop_x);
-		return PTR_ERR(prop_y);
+		return -ENOMEM;
 	}
 
 	drm_object_attach_property(&plane->base, prop_x, 0);
-- 
2.43.0


