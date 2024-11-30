Return-Path: <linux-kernel+bounces-426070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23BA9DEE78
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16C69B21E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C061146D57;
	Sat, 30 Nov 2024 01:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhQRCZsp"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80587145B18
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931574; cv=none; b=q9lC+7bZoCpcFO6xbMzIwwoKgzqRdjohOFxaAx+564awAyM05cyEO1st59pevVEGFvYxHUuzTRshjdNXHuST4jAuk94D/FGYHGEPxNk+NhkpKEAswdnRawdRh1rlIUqt5U+yWvs4qV5G3F2t1dEHnotuLYIJdVyQz3NL7nHFdLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931574; c=relaxed/simple;
	bh=At9SvTe5LA0QiGChV0O2Dfze46Fe9tZ8M4odvfGUE7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OG1HXi+pshvopEbENKbsbGt1mm1qcGbbt5OdYItDe2VVhIrvVDFLU8NtU1oht83bclHN1GCdRFlEorIOL7oFpvKWAWBu8sRNjPOfVVAKphaiTerzSFpNtaTr/Df5KisOdu7OS3ftWZLCFyJ+OyNuTtgQvAyl7Q7Nk27P9Dv4xh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LhQRCZsp; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so35764201fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931571; x=1733536371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqzd45OJ/2bjI5cuXyLBaiv2D5kR3sXVh9d8XfqZ3RA=;
        b=LhQRCZspxf4nuaPEoUXy57qRIZJFWy/KYyOM/oGnfvt7DkOQCQnHquSz2N3oOXYyAa
         RMIA34YS/fT/hcPuNdIUG6V7o3HpJ9vGsJ/yypeHJZLSR3xWBuZ8B1UZHWJiWMJGcU9w
         7jb5K5U58AqivPkNrc64ZbOyg60g9qt/8yRvmTgMtqb6TC/eNmcKC57/W/QMMU8KRlUO
         XcIomouS9iKqFh2xrpe9PUVFVXnAL1C5SweMWfXCeECkOb7zz4gnOBVW6mkrPci/jkRx
         w656FW3TzYy3IxDJ4f91risEOqQQQPRl+QWHSCEm3sJ6/VTQIW4HdDQsDwNJmUxJikT2
         M8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931571; x=1733536371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqzd45OJ/2bjI5cuXyLBaiv2D5kR3sXVh9d8XfqZ3RA=;
        b=OM0u0aQhgo5yCt9Ix1L0zka8V8rrUbbH80h/N2HIxapRUZUXV9/d7ub5tyN5cy03YP
         YyelR/j1fZ2et+q/seKkwYnwcanT9fwzcNvw/dL0qMYc2ehMdVoazltxqJ8WIWHy8v0g
         aJbNjun2OQewARJXGSaIMp7ZMzFKTRf6QcKx1z2Wp52LvrZs/ODUJQZhktap5Vb82jWv
         /lOwF6TLXXdke/Pfa3875rjuekRi1m77cwLWj2Z139OtIHwG256BdRq9NrU0nKqZ3zuG
         AGNDsuPYAUjpT4U4gw97P6u3IEPZZmKBRc4RDKZ17FA/oyayj4OIU7zB7rD5sP7sszK7
         TUwg==
X-Forwarded-Encrypted: i=1; AJvYcCUqoMPzoFMmKW3c2TLCp3qDrR/9ZW0+6QyapQ78GJlkVCQAfDnO8+uzObMjBHTE3mvABNhQU/32DB9sJks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJu2J3axl4H3A/596PDo6I0/5wAGVdapBj5jGUXeYSpFGdJZ+
	VJup9Kxz+v6I7mX9UqjWMjwI70qs9JPPuYh+Aqr4SgNJLtYTZADrkhULzfvUahA=
X-Gm-Gg: ASbGncsudf492mUgNNiHrgwgfxgZDp+5elHDwIyKOPmBSdNQFaJ2e/2t/kDPKk6GAOT
	vb6GoNUjP9kWc2MWfcMvymkJ+SqJrvMzbL8PEiwp/jnmAUyxBvG6DThGDEW2WQEDdCdgkgf6sfL
	obRC0Au+MfU21iES31TLh9ONBqxWTsPuiYP8OHtT6sakhE4GMngXdM0Jm/b1h5MVxiNS5NyYn8M
	12Yyh0mLMI91Fe/GHruSQorw/hbl5SYoWq5/qanZfL9KetuIKa24ioIEA==
X-Google-Smtp-Source: AGHT+IEm8Yb0TxS+eVr/75rrNhY8EmahWTK3d4I/qjVsct4VbSz/US+qIlExC4PPMtJ+C61FxhlMpw==
X-Received: by 2002:a05:6512:124f:b0:53d:ede3:3e0 with SMTP id 2adb3069b0e04-53df00a924emr13257471e87.11.1732931570640;
        Fri, 29 Nov 2024 17:52:50 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:31 +0200
Subject: [PATCH v5 06/10] drm/vc4: use drm_hdmi_connector_mode_valid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-6-742644ec3b1f@linaro.org>
References: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
In-Reply-To: <20241130-hdmi-mode-valid-v5-0-742644ec3b1f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=At9SvTe5LA0QiGChV0O2Dfze46Fe9tZ8M4odvfGUE7I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/gUrzKupzPQSPNAvUfGl7XQ6IFP4Mjuc6k9
 OiwxKE8NgSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv4AAKCRCLPIo+Aiko
 1UbOCACfmiglysJU/tIyjGlA11c+mgJ7cYK2eOEWh0ZSy72NW65KgY5a8FbZ9EVCQERqWc7dP90
 abFOIQdTPse1qE2HvCyMqVIHoKKywUEf4E5vhK1BOu4ArILzt6nstUi+E03GQUFjvM2cTgf7lZC
 edUwdUGA5Lm0pJq04VtA/+pg5wi6+qb33fd00ohAnTYmpBWYYRLGm6ytcdhJuewk6P3AOo7hT27
 VbGBcMiGZNp3E3P4Tvk6KoR0Nm7SOKWMpn6omYVsIhV19KKTtk2UPYZWDe45jm5te3OB0TScfc7
 HaKxP4L24nxyZtXeCB/cUIMb9RVM/dcHbcZ6lkb25qQPXzn4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Use new drm_hdmi_connector_mode_valid() helper instead of a
module-specific copy.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index b9fc4d981cf4d682bedd978795cf7284d2650e74..297afd89036ba8fba571379f5b6d63227eadb66e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -580,6 +580,7 @@ static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs =
 	.detect_ctx = vc4_hdmi_connector_detect_ctx,
 	.get_modes = vc4_hdmi_connector_get_modes,
 	.atomic_check = vc4_hdmi_connector_atomic_check,
+	.mode_valid = drm_hdmi_connector_mode_valid,
 };
 
 static const struct drm_connector_hdmi_funcs vc4_hdmi_hdmi_connector_funcs;
@@ -1765,7 +1766,6 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 			    const struct drm_display_mode *mode)
 {
 	struct vc4_hdmi *vc4_hdmi = encoder_to_vc4_hdmi(encoder);
-	unsigned long long rate;
 
 	if (vc4_hdmi->variant->unsupported_odd_h_timings &&
 	    !(mode->flags & DRM_MODE_FLAG_DBLCLK) &&
@@ -1773,8 +1773,7 @@ vc4_hdmi_encoder_mode_valid(struct drm_encoder *encoder,
 	     (mode->hsync_end % 2) || (mode->htotal % 2)))
 		return MODE_H_ILLEGAL;
 
-	rate = drm_hdmi_compute_mode_clock(mode, 8, HDMI_COLORSPACE_RGB);
-	return vc4_hdmi_connector_clock_valid(&vc4_hdmi->connector, mode, rate);
+	return MODE_OK;
 }
 
 static const struct drm_encoder_helper_funcs vc4_hdmi_encoder_helper_funcs = {

-- 
2.39.5


