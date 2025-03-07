Return-Path: <linux-kernel+bounces-550766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F5EA563D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB3816C13E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30E2066EA;
	Fri,  7 Mar 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNJAT/D1"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B791C84BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339867; cv=none; b=C7WAp3zvjW9zPb2i3uIdgM8XGIRIEvrqheIiYFe5qOXlYUOcppNC7K9tQ4STpXi3Cp+sSW3BsriSTFi0avLNz/lAAK6gz0umJ9cADcWmgGc3IQrgAVZSvC0bbF7cHppfdTkG2YWIGH8gbpnrD26yqbHE55dcETCg2la23KUQ1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339867; c=relaxed/simple;
	bh=0clyfl35KjfOEHzeeZP6agmpTPeexmG9vqN3A0Y5WQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZD2mu9ont8jQ+MfZBapByBbuxLqcgWZGkJ+KESohXl3RUPhPYDwRjZol91c6quu6UYzn6rkw3SU+2WQzZOcowq9xUTo/Q327rpXWj7uZdOPXOuEOVS8S36fPcUKmPFKYaCXPBy9MJcJQ1uatww7VqbU+pmNRhoyhRV4HXm23bCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNJAT/D1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso758980f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741339864; x=1741944664; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuKtV48t1X7LVR4XRl12tQehYIh96gIBPvAMlUyvJ9c=;
        b=RNJAT/D1soU1CFiP6IVla6knNceGmgRaR3NiZ7pyRJn4+U1Nn9aLcoTN+lvyQpJ3Kn
         F6Fol9WwLqnwYhzZ4g1pcANv5MUBtmC7OxWeNMpYFyxN0HK3VyW9P4U0eGBOUt8+NNaW
         oEgBC1XZoaayMqTHgqeJwTcGHrJt4ys8O8d9BXLOVDRhKT+WGvR27lJptgv4xNIpWowQ
         xN9QAZAMZNApIPkb+i85b9fKXrfvjCNuRnDAjjNUnevKAu1BmJxTjMuGZRUnrBtcVWJw
         8wsooTUwEeLZHH/p7l+Wsj2ISK23dPfjTTvPWzNx9xMEtfNdRwZHTvfVrAq8nzUbLRRt
         KW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339864; x=1741944664;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuKtV48t1X7LVR4XRl12tQehYIh96gIBPvAMlUyvJ9c=;
        b=b2gDe1jYfhu66h6UpWBk7dEbxLGH3XvvaELro9mCJirA90Qe2gLnY2K4Vef+ImWaGt
         YC1hEHII6sGxtshM0XzfE3VwSx+aGiQABidYZe3YKTIrrzgMN1UG8kkYE9ntrVK7TZBe
         qQ5A8ddy96OQ7rSLQ8uIlG/+Znwp5s8jF7+Z1NLDLps9olXx/0SnMuXMWvjzTryusEPt
         +M0ZG4E/29mIdQIUZjgSHuTzAt11nZXQecx9dOqrxxfJDO11mbgVtu4nHk6S8eZgtZda
         IhJPrp+pEGEDI7yE3QbkZI62kcye9naWedp4gkiuc/cVpKgaif0nRgTUJVuzWIfXehaa
         hb7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNyQWsc8nQNiodeniepjV0rfsdPN3gX6HC59PUtLobtq0kPoHREYfOjvRtkzZ1iVmpvPSOl0VSbfK2UDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJVlWxTRfpcZtV874/Oxl1aARZjy+mo0RT2FBVk1RoJpJvaC7e
	Xc3Hvt1mZie0xVsxHw+ZInQryDHN/N1W0nPx3rASrYnd9y1ZZA0pDCpTnWo2Q9Y=
X-Gm-Gg: ASbGncv0IPT7MCwWiWIJkgQ6IeDlDtM8HBWDbyQr3yl2wQGkb+dnaJEhvjwHC8DvP1B
	SqZZn0MMt4+IZb98Wv7TKBz6v+safm3IgPAV3UCYs0CSvVpNodiHf6tmeBS1tNrrvJb2tPPvWWj
	inFIc/kOLSVyzbGP8YeklYWnY+PehlNzA3698XeKKyAJLDeg/qDHc8UprVWjZKFkC7SIzyGk7x9
	WzRspwSZRS4Jc+ZlDRI45FDcczaeT4laN67363edjtW8lAcuxoM7ikmJKmgsXZ5LQGwCeGQwP6G
	S1Dms0UNszx+mRFjSYe/hbzkgCXnFbTiLYu7mkGFn2p+MYfvaA==
X-Google-Smtp-Source: AGHT+IHGgil9XvvJ/78/5L3MyKGSYheLPT+najegLrndXP1vKPLf/Ab1cHu+/RbdCgsBcMvfznnH8w==
X-Received: by 2002:a05:6000:402b:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-39132db746amr1441891f8f.49.1741339864000;
        Fri, 07 Mar 2025 01:31:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c0e2f39sm4690339f8f.80.2025.03.07.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:31:03 -0800 (PST)
Date: Fri, 7 Mar 2025 12:30:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Janne Grunau <j@jannau.net>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Neal Gompa <neal@gompa.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	dri-devel@lists.freedesktop.org, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm: adp: Fix NULL vs IS_ERR() check in adp_plane_new()
Message-ID: <14a845e8-54d0-45f8-b8b9-927609d92ede@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The __drmm_universal_plane_alloc() function doesn't return NULL, it
returns error pointers.  Update the check to match.

Fixes: 332122eba628 ("drm: adp: Add Apple Display Pipe driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/adp/adp_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index 0a39abdc9238..db36807005a6 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -232,9 +232,9 @@ static struct drm_plane *adp_plane_new(struct adp_drv_private *adp)
 					     ALL_CRTCS, &adp_plane_funcs,
 					     plane_formats, ARRAY_SIZE(plane_formats),
 					     NULL, DRM_PLANE_TYPE_PRIMARY, "plane");
-	if (!plane) {
+	if (IS_ERR(plane)) {
 		drm_err(drm, "failed to allocate plane");
-		return ERR_PTR(-ENOMEM);
+		return plane;
 	}
 
 	drm_plane_helper_add(plane, &adp_plane_helper_funcs);
-- 
2.47.2


