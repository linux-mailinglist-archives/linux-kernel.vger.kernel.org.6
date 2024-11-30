Return-Path: <linux-kernel+bounces-426065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BEB9DEE6D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36843280C32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425384037;
	Sat, 30 Nov 2024 01:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l8XyQRXY"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF3457C93
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931561; cv=none; b=ATU7HhxhdXzb/DFfrcQZigw1RKUJj+hzr34EYJ8uY6FRGyI12kM9jY3MOO8QlVwP3k2YX3URShLO1FA4ZKbLUfsi8C7Efg6BK5NZtwIG9Q30WaGjXz/Nlsmpg05WHP93vpODqIUvoy7pA1QIxk+sERG9c7kx+QM4vLbnxlWJMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931561; c=relaxed/simple;
	bh=rXzXs1LIiHZL8UtREKepdy9gjR2Nvrl9SsrJH4c2YZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cwQRCI5Nk7LBh/PCpXJnSk8j/ZvsmGcpX475fEJohCutr3tB9gRRxjF8eVnBSomcjOnFT4lKnXL5ze7gkuoB/0h+a63RhLpC6q3LEqF/UnNpSN6DinEFrpxJP9eeaCBYZrcm0KPlGaT8HmEYJi+EXi+zwtrctHaUv+c7kMETVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l8XyQRXY; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df119675dso2969511e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931558; x=1733536358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rL+Q+A1E5WdeyWGlnmxBrdioN3F1q14QakvZcTSmWyI=;
        b=l8XyQRXYQBp7wnDYwF+fLpCr0OTLfMEPHz0KrxvzUhhuZMPN/RxWJYgLB9QmRN5EAU
         R1mY+Sl/LrXptRVELzc2l4VgeC1fuNE0R6Tun/2tQBTMxG0r08ttI5aO8qCML4Lo72t6
         10Ko9ZFBjZ5Vak3+j4LejBzRvuqJvo9PEUue9JIvUkwjfJs3bJTzXtsrOC/lVyjQN2OR
         FG6UI7gAeNEuXDB3z2SKnTffw6AhA3PgCgzF0IbhhhdLwAZaQy01u6zjmBOF2Wvu9AVQ
         TjYI85Jr3ciVJJznImG5XalUzFZznvpAdWV+8B+p8ePZK/FupdIBtyEXeiaUOvNQVS3V
         10gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931558; x=1733536358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL+Q+A1E5WdeyWGlnmxBrdioN3F1q14QakvZcTSmWyI=;
        b=ALcD/Dm2dMm/q552djuZQeEDrwoJJSzgVjdgU/0OjWfZXIQv6eTIsyrCdxFAoDsH0i
         yodS5h/RYpgCr+X9Tadvt9tIVd6TGIFEdP+FNdc/sibQActewXkxuSZxd9+Da3aAd3Mw
         2o9JjCG0Yy9wNmTIgUD7ZUpoipkNVvZOpFR2hqrkU2Of53iO0pHcsVVjQyelHR5szkvX
         SwVRYGUdC7ulP32EeZcGKE7Nxdz9lnt1j6ViD+9wD4f8aJQsAtcvhyim3WK8dw66sLhr
         Y+Vaby2w1LdiGUdyrbEzgeOz47SdqUaqkGFFmDE8Ou5/NXrEISVwI4ttSMQExcN+IBtp
         fc5A==
X-Forwarded-Encrypted: i=1; AJvYcCUdVQxwl+L7gxYEIXwJk8cs3vnq0Q/5M+VLgBbD/+lCHQzhplRGUql3OBu60h4MF7qJ6cU5uz8JLTQzqxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsj5h6i47LXDctaTUWnF7OYhbJJgoqWEc+WKdBB+FKH2zf3F6U
	gFp4HJKxriS7vHJL32TP0mYHEmpScspB0xHDzm8IELaAqXZ50GjBqjOx6DkRwDQ=
X-Gm-Gg: ASbGnctFb/HuQRTHPNwOJ1J04pmi6lElZaEiFKkasvFZs+2BETOODpN+65i8J4JT5Vs
	flTDnmEE4r14ZL8Gc15I5naxUi9Updk+VCWSXGX5UKB22sfaBMzSuxPVWTkbu3kz6Ek+rKlqY0v
	5hePHF+WGXyMsUHhh7FCChPFeJ8yAoUo76wSzBTv9mRBTMnS5RsNTWPh0aKHhjC9pi/k6iU3Uxf
	gdkBKkJdjlQQeZkKk9hFDqP16xcbWf0N9LHqz7rAXDoYIrXNj3hCa7nMg==
X-Google-Smtp-Source: AGHT+IGVvdf1lO5fwuFWw9xeRiergMVxDBWPVsqq8kgBU3WEnEIe51FT1/PQjZaCSi/PMkMqSKbTIQ==
X-Received: by 2002:a05:6512:2822:b0:539:da76:c77e with SMTP id 2adb3069b0e04-53df00aa234mr9021742e87.5.1732931558219;
        Fri, 29 Nov 2024 17:52:38 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443172sm636408e87.84.2024.11.29.17.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:52:36 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:52:26 +0200
Subject: [PATCH v5 01/10] drm/tests: hdmi: handle empty modes in
 find_preferred_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-hdmi-mode-valid-v5-1-742644ec3b1f@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rXzXs1LIiHZL8UtREKepdy9gjR2Nvrl9SsrJH4c2YZQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm/fBLnvkUW9qRbw575QavDrP72LTHBm1NxMz
 85M4Ziti7uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pv3wAKCRCLPIo+Aiko
 1dv7CACoQI2bC+09l2FHVrI7eITxhbdZjhlH6ypKucApGgA2wGe3crPMsMfJbwgJSJY1noUUULK
 YusunI4AlPgsBei8HxSGMe41Mk0z8AcWabq+XcdFbHG9aaY7Q+myFSq3c3F2ErXzjv0yWu8DFBA
 8oR967KFGvjLLSa7noPp/Moe5zrDoJaVD7HriBced36KzyqZLROp652AKv+6CpC+rsOt/T1NK4L
 CNXvVqRyV1Adpa4JZASWt/Yj/xDR+/FMfqRCCdFJLQPyN9uG1m4rChL+TjewMB99voI2nIaImHt
 /oXkkNBHtWoZFXDTAnJws5tJU/s1zd70ka0C29pX++CTpwbp
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If the connector->modes list is empty, then list_first_entry() returns a
bogus entry. Change that to use list_first_entry_or_null().

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 294773342e710dc56772f839c2db9c2e487bbc1e..1e77689af6549f162eb3026c7bd2bbd59516ed98 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -46,7 +46,7 @@ static struct drm_display_mode *find_preferred_mode(struct drm_connector *connec
 	struct drm_display_mode *mode, *preferred;
 
 	mutex_lock(&drm->mode_config.mutex);
-	preferred = list_first_entry(&connector->modes, struct drm_display_mode, head);
+	preferred = list_first_entry_or_null(&connector->modes, struct drm_display_mode, head);
 	list_for_each_entry(mode, &connector->modes, head)
 		if (mode->type & DRM_MODE_TYPE_PREFERRED)
 			preferred = mode;

-- 
2.39.5


