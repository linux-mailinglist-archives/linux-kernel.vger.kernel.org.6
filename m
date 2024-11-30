Return-Path: <linux-kernel+bounces-426502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB709DF423
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 00:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF4FB2247C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800141C1F0E;
	Sat, 30 Nov 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIUlA+WE"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76F1C07C9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 23:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733010955; cv=none; b=V8IGhfFChQU0eHSoj4bdJMPqxVF1wo64sWxITB94BG1U6fdy1LmUNGzgnlGXIK2gZPOSFUKkULB6BMgB2zcPsoaBArqiEmuh+TSX+2HyzOBowsTMbnbrdONYk90Hzp5CErI4TFjtIppE584eB+b/Id0xVskFGBWBYE5KThv1+xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733010955; c=relaxed/simple;
	bh=d3Sl+FXytgREFItAwcczh3Q1vneGssZw9wmeXf8zqcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHfbHCxMZnnJw+Us5YdcXbBK3XD9+ioR4l+LVUip2ArQe9dAng6YyQlBBMKkAfk4S00mqNQHTWSqHvB9bI9fufQcuVTh/zMtuL28dS76R9INkERZh4doaHxj2vHu5n5JN4atEd8BMf9n9C/y+sTwvWPVWVicUS3zKPlaLbAkKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eIUlA+WE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53df19bf6a9so3513683e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 15:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733010952; x=1733615752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IU6Gl7Dl4dmhuEZdQnvRmTEGRcXAkcJN0vDa70RMZrc=;
        b=eIUlA+WE60ecrtZshtZ3cS2zJHP7ml84/Y8cdh3ZO9jNMWB9936y62LeNHObBZzzfq
         BaJN+mfsSc9tdXftmrW633JyTtO1YVO2CoXxyX0ASCyzTfS2sAnWN9otcnwokaDrc85L
         LuHn2lGRdaYql/piLFq843UXhm3rE7x7emAovxGG2Qhv3huYuWzajfyN4z7qtMlqoqmZ
         +gaebchyYkTnYxkkGlOTrE+43u34+HhHI/5dX8YSwgALCI0JtCbaiimcA0t+UjClPUAJ
         vW+Spq8RBT5ltpA77kRMXuun8wOzE+7LnvT9KZQZkAS9efuojlwy1uPxoCSbHHde2irU
         eptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733010952; x=1733615752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU6Gl7Dl4dmhuEZdQnvRmTEGRcXAkcJN0vDa70RMZrc=;
        b=n/7iEoSHagjdj12F6LyTh86RACAU23Wz8AQXzB6Uspk95SXhQ3KPdQrSrNryZ0MWb5
         ajaaaly4NU/BnJt28bCIhbvzIwwBu+d6hvWbGJr8+w/wn2lZxcZ6cUy0cXE311YQzO16
         y7KwNuch2X5rtRnoxpFmSfNpP3/4NiAB7e+bU7pk7V987gkQu6X5QLO+9NIVysZs/XCO
         0/9QULFPd47lrfkYPMB8etHaY+Q9JDm28KItXEDIaFI6GuVAH4evfGUZsF8ZDRoqdm4h
         I5Vpwv6s3IUooc2WLU3atSRPbFWWOZICvUsBl9LmMYPU2iXJdal7Jyn9/XaTOJySICxU
         E+kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj3PQwJqiWx0l8nJ7gy24vBz2pwCdiQbJ5nCApfLmz/iBsGvYLZhxo4wSLvBQWlFwrw3X1Je4FhFBnaAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SyZGepmjSrJXGOuJhpFkdj5QQDfVDwGOh5HBtMGrt+rocawl
	kYDH57uJCHvBUVK9QgqJVGIc+gBeuZNfMHirFVtbumRTAO+v1Q5QxUHP0WrPVSM=
X-Gm-Gg: ASbGncsp4OE1yd9yf7CklMY918ddYMiC2YMGQtm7NQmxZOSQiC7DxJdLzv0A/xz1J46
	BoCl4I29FKN2SzbaDvwqU6rjOwKaoZFTZZONb9YdLVGJAmBLDWr+OKXUhisUPVIn8rLY7b6HSdx
	C/gbeQ+Pd/6Qay/w3gGfgwYyhg9O1NA53UIGBOO/jeuNDoI90SahV8Q7eIiyoxvaza+igkbr4VF
	DXGNRckumd78aIYqStX+v0c9VOf85zeEB1NoyJcKrigkXdFrMTlFM5IgQ==
X-Google-Smtp-Source: AGHT+IF0apDYRdHR7KZD93hjbqsmabdU0vO1rz/bbiVNjvW03bvvtexlWq6c4CLLSgjKkBK26w1wwQ==
X-Received: by 2002:a05:6512:2210:b0:53d:ed6c:26ea with SMTP id 2adb3069b0e04-53df00c79a2mr8823937e87.8.1733010952229;
        Sat, 30 Nov 2024 15:55:52 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649647dsm900706e87.195.2024.11.30.15.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 15:55:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 01 Dec 2024 01:55:26 +0200
Subject: [PATCH 09/10] drm/sti: hdmi: use eld_mutex to protect access to
 connector->eld
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241201-drm-connector-eld-mutex-v1-9-ba56a6545c03@linaro.org>
References: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
In-Reply-To: <20241201-drm-connector-eld-mutex-v1-0-ba56a6545c03@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Phong LE <ple@baylibre.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=962;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=d3Sl+FXytgREFItAwcczh3Q1vneGssZw9wmeXf8zqcs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnS6Xuuw73RrqNIAMj0Vd/VMNJk3KOMIlLIxeOc
 0MnV4M5vNuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0ul7gAKCRCLPIo+Aiko
 1Qv/B/4/5rLxZCjkqK+Zdlhp2+yqWP4ISG1uXt/zd2hXrjtxgOkih9U6WKdNa6Xoz/QuAEp+lKl
 oVznmDwzY+sTM1b4PwOdG5DBpKIgyXf5k7n1y/cyABsH0BdP5Tzn74sUaSZBQgnUGSYhGgKdDc/
 YAAgPkbRyOmTtniJolkAmqMYl0NihkgeU26RZ+pfNtFLhks7GHDURf3XLOq7x45EuwGaROru3jt
 SmIhwz9wcEA5r2kDJq5DDr04T/9Y0XgMWhQKi1kbsG7wK9OJlgiYKe7dSOEQ94g/A4Aet9kG185
 zd4yXm2idTSpwhIe2gyR7gCJgHyrA/FNOXXul+pcZq+liRGD
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 847470f747c0efad61c2ebdc3fb3746a7a13a863..3c8f3532c79723e7b1a720c855c90e40584cc6ca 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1225,7 +1225,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }

-- 
2.39.5


