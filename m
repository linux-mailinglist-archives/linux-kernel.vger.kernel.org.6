Return-Path: <linux-kernel+bounces-182647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E647E8C8DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1EF285D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3731422CC;
	Fri, 17 May 2024 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mFo7Gl7Y"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7913E048
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981864; cv=none; b=kP1rDFzpSmu3o3Jmi4vD3Du8roYdJtAqkgVIYpsE3S3hV2uYDmYSI/hpdR5GiS0EXVHydJEo9xHEO/X9oTihfdihuCuRFWN0eLuKv9fVVYjANzn5ivzFsZyEwoiaL+jGvu3lu/3w0NZdC+JJ4TE0lmEgub0Y8gEnlwGlk3/nH/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981864; c=relaxed/simple;
	bh=ckWQJuqXlhrd6HsiKwZ31CHUqWA+QXm9Sn8Kntfaoik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPEoUOLnzI9KI8ViKU75EjCFkVASeuSG7JdH2+o4+RU4XUlsz//1CfM2VfG++ZBWgYNvDDix2mEqMYFChEMSalI48JtlRqAIYvF72xhUV6JXoEMo/nyAJy/wl97+ZWslWq/c3CHf7ACiljgroWN8lzdczkqWlv4eAJ7zSOr5pJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mFo7Gl7Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f457853950so426325b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981862; x=1716586662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdxmCQIjRAvO8BCfViIMJHCflXvR2bqDUxHByEsJNv0=;
        b=mFo7Gl7Y5iATgGbX6iD92/I1S6PMcpFFVs07aKCH0FsXMTdGkENwl5nz60X88MQRk/
         bdVkYDWGnbbGEJ0qiP0RDdmfnjryqlaadDKejyxTLRilWYfsftsxbj6WCya2xJhU5hAN
         F5GdYPEhRdOankhQ35zIfk47EGsLqJFW6cVvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981862; x=1716586662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdxmCQIjRAvO8BCfViIMJHCflXvR2bqDUxHByEsJNv0=;
        b=AJ5vqhFQFXBGy1Yg09pgueRvCyGXT2mSryi3ypkxONKLkLAqPIaKv/FhSn5lGOKyQQ
         Lo41v+zWitpwm3INjomfyK4A2ax8vbdF+hWKbNm9UKJt8UvGD69JCx00Lno2nnBFa4/4
         LIwrRq404kvWsutgaAFh9WswEf3Y80R+rpxpeZTDDZ+7QaUZ9IMES05d8gyn2nz8WXUz
         Eszk+TItDFZjKqutag3nDc0Junyojtjmn2yszVa0StaY2FkIl9Px4HNuWMmWq3w0o4qb
         JqJwVDHrHpxIb0h0pzRWpsFBVgty+fsLO3WEWT5qxsCQ2TQnQriVZ0zGmZUCnJfjnDj5
         rfng==
X-Forwarded-Encrypted: i=1; AJvYcCXHA1e1aI7qQkGqZraxuNCzXCshXLu/CvyzSzyQCxCbHxRqxJ2k8VSjUqkiapFeop+W0cyt1jzPD9i5HDsSKiJcnu7C6tqnj+qOtpE1
X-Gm-Message-State: AOJu0YxTbdQhWj0Cf+Ch4JwcygYkpTm/yxf0rUDQNo/fW4bmmkthLIiw
	WsEzG2lUjjzdA4KV6j0kBLjG8OPH/ZOVWMKYF2KoXFc46N1UP3sfd8c7nSmCqA==
X-Google-Smtp-Source: AGHT+IHX2L9EVLQc886otDLXwIh9pr9UtYuwXLoQCTn5ubCeZ2plNpUi+ivhbdW42Vwp09Y6f6yc9w==
X-Received: by 2002:a05:6a20:d80b:b0:1af:37bf:d7de with SMTP id adf61e73a8af0-1b1ca3bca44mr433294637.7.1715981862038;
        Fri, 17 May 2024 14:37:42 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:26de:b1dd:5:771c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b2f8b3sm15168736b3a.211.2024.05.17.14.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:37:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] drm/panel: ilitek-ili9882t: If prepare fails, disable GPIO before regulators
Date: Fri, 17 May 2024 14:36:39 -0700
Message-ID: <20240517143643.4.Ieb0179065847972a0f13e9a8574a80a5f65f3338@changeid>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240517213712.3135166-1-dianders@chromium.org>
References: <20240517213712.3135166-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enable GPIO should clearly be set low before turning off
regulators. That matches both the inverse order that things were
enabled and also the order in unprepare().

Fixes: e2450d32e5fb ("drm/panel: ili9882t: Break out as separate driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 830d7cfbe857..a2ea25bb6624 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -495,13 +495,13 @@ static int ili9882t_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
+	gpiod_set_value(ili->enable_gpio, 0);
 	regulator_disable(ili->avee);
 poweroffavdd:
 	regulator_disable(ili->avdd);
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(ili->pp1800);
-	gpiod_set_value(ili->enable_gpio, 0);
 
 	return ret;
 }
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


