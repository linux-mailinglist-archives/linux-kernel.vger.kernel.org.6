Return-Path: <linux-kernel+bounces-427688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DD09E04CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0540162721
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CCF205AD9;
	Mon,  2 Dec 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="euxp1nGC"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A06B205AAF
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149487; cv=none; b=ROMLMK0XvUDKg1A9L7gpRPuSXmGHaDzVp7awsWsM0aQGheufUkzAR1L4bsUe+uuKRTAIWcmO7K7ddPs1MRMmu2HnUL7n1wy+Oxnh3ovFI9cMHAjtDUUET1P6uvwvl7eVChh5ltxsS48bRh8BqjG+wwCg4IWRcd+zeYupzRrIMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149487; c=relaxed/simple;
	bh=8mMTjvFDHU6qYXM2tU7l/cSNhCgi8jgy/GoXdIYy7Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbZ98dipIOWJMz7Uv4UIO1yurApyLmQjbKqbOSpEQMNybizVe3i9rixdWll4cFnApnfaXsTrTWVNeWNIK3/2Wt6IQAZuSavqndUEvXf+Dsd+HkcMlQiZjq/TIY8ZNfd5nYyEYlICulS0eOXjhPrCOzKSxE6fx4BbMT13n2HTRB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=euxp1nGC; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-29e61fcc3d2so914722fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149485; x=1733754285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mnebE8+2v8qetjaorjvm129bKYEMI0HgfTeiXkJjeWc=;
        b=euxp1nGCpJVikS6tJR+UYnjxcGljnUZZHWa/D3Qccy5qI1ykMNw/WqDQvOJNZK2S6j
         EW3C2akjxZfEBoR86F8YRRa1NBIUe36o4mlcALR5enr9tNStkn7qTEmuJ/OprEdC1w+f
         87LdhZxTTh+3+LD0kDjd1R7oGe26AZ1qahQ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149485; x=1733754285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnebE8+2v8qetjaorjvm129bKYEMI0HgfTeiXkJjeWc=;
        b=w//7B/0XlhT/30esalSIvwP2MuMGtWk/4pJHqFAL+H/76ScvdfRlQRnBs3gsYGegRS
         0BZf9/rsAXPpoSfqVi7CzNUEJfS+pxXcZz0/iXvMS3Z+xLPMYi+CvDougYY/LWJvBIhv
         igDTTrITO9zpAHsrPUbDI8blcPhLbjlTSm7RVG34yqMjiIEOvVGFb3qCvzO+j3N+BxVd
         TCsyEHAU9DLPev62uFk9IlYxkHLsJKkmptJj81MADOBnupAQ7euPf+IEMtcLVJfv6Jwz
         u6NeMvbT+Zn8rAQP0Lmv2WhsmMCIzJT4oCW3gZfcTp/u7ccVmOVNC7mgvHJ5GdyQartV
         TUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuiwNpOSRUyb3HuCYBVdHNUQbeyeJQV3hqM0R4Rg3QiLtgRuXsDq+SVRYK3jT/9r8xPh5/OSTDWe+KorU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywrc5he2kj8EHZ5oylNpVT72ai3DX2VWkJoCxQKBMnYbJPUPCE
	jfHPGWpiLtxRUxgtZEvnF26WVff0Z8DNZ1qQXl6m93XEegBmA8r0Je4DTh0wJg==
X-Gm-Gg: ASbGncs/p6teYnmBmnqEYtxGrhnvncFQcPGBfL0nkZx5dX/7p2qaJd2LaRwrVod8EFR
	2duIg46AbMf0shGoy2vsRTc/AQY6h/yKaNc01Z+CUopySxyT3vpCQu3g3UbMjJ1t8bEPuJ3Q99W
	i0tVPRezvrX/DNV4+oUNd0iRdco2y2t6hBj4KgkSx7tk+Y2xT0pLU0sysE4R2x7XAiSxl67JzoM
	7eJIVmkLjz6PuV00kdMmZ2ubIQi4Kkb2IdGs9lgEbvSdSxYJCWJCCG9Th7cGhiThOdqY/bhAfkU
	G6tXM/REHpwWTcMCnQtZJGMx
X-Google-Smtp-Source: AGHT+IG8wtRsazkhHnoGNG6oh5veDC6ueDZxet87nom+g1i/pY5lzKPixDtX55T/kdnxYkUvhY0dZg==
X-Received: by 2002:a05:6359:459d:b0:1ca:a872:e461 with SMTP id e5c5f4694b2df-1cab15854d1mr668540455d.3.1733149485090;
        Mon, 02 Dec 2024 06:24:45 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:44 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 14:24:37 +0000
Subject: [PATCH v5 3/5] media: uvcvideo: Annotate lock requirements for
 uvc_ctrl_set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-uvc-fix-async-v5-3-6658c1fe312b@chromium.org>
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
In-Reply-To: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make it explicit that the function is always called with ctrl_mutex
being held.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index af1e38f5c6e9..576e3854be91 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1980,6 +1980,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	s32 max;
 	int ret;
 
+	lockdep_assert_held(&chain->ctrl_mutex);
+
 	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
 		return -EACCES;
 

-- 
2.47.0.338.g60cca15819-goog


