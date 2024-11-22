Return-Path: <linux-kernel+bounces-417993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 050FE9D5BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8545D1F2257B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06341D3576;
	Fri, 22 Nov 2024 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwmuxVM9"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13031C460E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266795; cv=none; b=K29MpV8L71LzGDgvwQzo9J65zMDXNd+c2PxtPlkL2emvSj6kZPebm9r+k69cY9kSAAnBSxbSZxWcZ8auSe/V5BJGhJIw6VY+OXqvxJ6amECrXobdiiCZmHPi7dXe8hcGHAlhEWWq9ySCg6DkRKvlimnMMyPMaDY713gFdZ3g/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266795; c=relaxed/simple;
	bh=cHHtfh9y6/Xe5pWD0imwgSoaSzh5tOQpdFVxQZ5xP/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsqifhVyMJ5L/sX9AGQ5niY/m8zUcgqS9sGsx5CERbYyEeK1bDmAd8I1Dy3kIId/kBH0wggn36W0uLHpjCNcU+v5JEfB/Jq4ieVRvpRSg5P+sFguPeQmNO7X4JYjEsAemhIB6x76OTrHz/XZxiWSRTZ9CtjY4qDOQEkXCxkGSK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cwmuxVM9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e63c8678so2076597e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732266792; x=1732871592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6W3bqmSBPUsE+fVjxjecsCfWlJC1+mE/7mRAcZKJqvU=;
        b=cwmuxVM9XP1QccMFJGTwlDwmYfzc2k8QZ5bD/+19jLZQrLHrxLc0T83woBp6mPrQ8W
         3bASFPltppPVZvbbrQRQDPmyM/9XRMLIdVrP2jZHlxOkQgm+QgOpkR+mnbfRLVhlGWeh
         t+00zvF5OojkT8hpiGHplq8n2DjSKUZmpGPa+fR8nW1jvhKNDV0o6NHI86poqNpDQxEZ
         0/5iACRPMFNPQpwYio8c79jJL9do1dxcLRuuGfTpt7Z0hZCRLY6N5dQVFW2zOkVA8nqb
         pnL5s45Uf1Xkp8jR1ubO9B7zGAG5UUXFExkNsHl4YHFAPeSWcneLiBdTOx3OeGDoko9n
         ShBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732266792; x=1732871592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6W3bqmSBPUsE+fVjxjecsCfWlJC1+mE/7mRAcZKJqvU=;
        b=J1ZElfUWHCMYjYKZcfALMBLuE3IH3N5szGpxnvtz6zn3dltFBuGRwrOv3RHBzb4STo
         oYbg6ea4NnNsIyZWC2bUStSh7RS+BA2da3rP2vpACI4vMnJpVLso4PKMyeVhZM+GLIAi
         A7SPOnpjCXXN40SjkAANRSrigkz0fJ7PYI7FH++XeSHCFEA/CeztNIjCtruYW7bydV1j
         yyBlT/hD+4B0I4kiFurafEsnlt8E2Jds7QEw/TyjitcHtPx/o/BPwRUtowoDPwNoisPp
         xwXbXPNewE9V2fAPU0tB9DptgDrM7FgsiNZbMjya+08685OVYlLFBuXSKboaxPjqqniO
         f0Ew==
X-Forwarded-Encrypted: i=1; AJvYcCXqXhZVSp7znh6cXsmzRSON89Q4uaQ3aLyzanQzJNtc8Xlwz7AsBvBIRQhoN5diARYBquscC1aOE+2F9JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKXJ6kfzhDtk/jk5jrBdlqOcdjPW3iGtcQkCq3sIpJmZq+8jv
	IvYHH1dG0I54iXzAYR/dE29zQ81d2toeaKZWD22H5MPo5Fz47PzQOX/99+WxCAOjZL8XNZz5AFw
	8
X-Gm-Gg: ASbGnctkvANEqMhWZNGm4QaCBxz8BxwVx6vN4ShRqt3Xdos/r2IA6wJjOeH0HZ+svwm
	JDGLPeAnPl+f4hi6RzNggaATwJGDwMwFKB92B8gUnvcUQmmDjjcvKzhTnp7srL2lpATIoxbSj5Z
	t0bbB3YPfPcB2bmsAAKJUXTZXGgsHgdfPTssJwdytr1FVeYQGkNZ/Lk4hR016UMNzIqCRHdQK7N
	s5NRHrNctM+9jjxe6EQcnau4RZTIKBBEIuI8DMhUVJWiGBaY7YkachnBw==
X-Google-Smtp-Source: AGHT+IF9ThfWnsEQI6UyED7pA9h6Wf7FpGWyg1saUJdib/WRVSKuqZ2ksQYV61QNiecHx3mAhZLedA==
X-Received: by 2002:ac2:568f:0:b0:53d:a024:ddb2 with SMTP id 2adb3069b0e04-53dd37a6c3bmr1142300e87.24.1732266791780;
        Fri, 22 Nov 2024 01:13:11 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2451386sm299530e87.77.2024.11.22.01.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:13:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Nov 2024 11:12:57 +0200
Subject: [PATCH v4 01/10] drm/tests: hdmi: handle empty modes in
 find_preferred_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-hdmi-mode-valid-v4-1-2fee4a83ab79@linaro.org>
References: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
In-Reply-To: <20241122-hdmi-mode-valid-v4-0-2fee4a83ab79@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=cHHtfh9y6/Xe5pWD0imwgSoaSzh5tOQpdFVxQZ5xP/s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnQEshW4nqOdXL0T4IVeWcFtdcIU865J/geaZOs
 dJST3YPq1iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0BLIQAKCRCLPIo+Aiko
 1aCMB/4mAMbVULeSJaQKgD/thf0SdySNUWeV6CvGlRgfogZod1ZMqfju5iE0YiqI7xy28Ycv74E
 B0vuUvxyNt+MKQbKrGS8BTlEhjMqCpiI/CHQBw9F6k2HpfGFkrWHDIoMHaaoW5DaERqX6xacG/s
 DhPpiLyKV55OciJGf0cj7Okd9I+OzcIvE3aVDAo8uG6emEXX0UO2hya4rXHN74Rwop72ki1rJn+
 7Co2fSv5VYDWughxDBVCLzuLe6u6WeSCbhxlSg97MXogFyunITxmcV5RlLk5Z5TQWDhuX4634jq
 pnHjEf3jhAkLQer5IkvtUgJ1d8uMHBw5CJY0WH/gX/wWSOgj
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If the connector->modes list is empty, then list_first_entry() returns a
bogus entry. Change that to use list_first_entry_or_null().

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


