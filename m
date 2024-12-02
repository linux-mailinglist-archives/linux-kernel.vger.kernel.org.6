Return-Path: <linux-kernel+bounces-427690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65C49E04CD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7530028313C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20004207A0B;
	Mon,  2 Dec 2024 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GzElPN2V"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1C0205AC4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149489; cv=none; b=YbmLvWTZUG2x+mrB06DA7k2BL3JqOcpBHNs/VF0+L7uWDfyKYNYYK+bpk8bCqIzDxKZByecDa+xqdBOXouuH/pimVlfFI7JVpVZCPzKEIAnf94GB3RxQlBQzKMAJKmKSFperMKHN5dkINqq8+PkYK24ZYBHAtcaf+a1c48ZlPNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149489; c=relaxed/simple;
	bh=s/DB0EW2SPaRTypHFdwKgdfZkbgjDIcSlMWC0VeRtOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZEaD6Wjls6YFE7ICW1NncuD39PMklqRzSgobIYDiNy5YvWptOVpZJQkRbL1T6PdghchmWhfbhiqJq0IGdIHA1eP62g7QSukr8zMmcYJ96fY3Ano9WmzEhPauENl1i32m9dnes73IOCVXOIDBLry8o0XRIDee5eC/TMQsab1Ynxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GzElPN2V; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea55d16d73so1321338b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149486; x=1733754286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XX9qg9tc+/hZit/CPAJ2FBRiBE/du1gO7Pr4Y7PEr0=;
        b=GzElPN2VoN9x8w20pGzdXMU2jODgG6rkOLXRlXqhScHEpvJkjOi1KeGbSVDJ0VbUUG
         Gmm5PL2HnBmBttt/AUkMYtThZ7TKasrAuavFKRSt7PRJj+mrvOVvW96ah2iGuKOAgsFJ
         Z9oG+y2qOUqEUxxY2VLyMNJuMT/O+7zlCzPFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149486; x=1733754286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XX9qg9tc+/hZit/CPAJ2FBRiBE/du1gO7Pr4Y7PEr0=;
        b=uG0XecKiHSmRzc+ytL9YP3jquVfXfFZA1cRU+iZcrDD2uZnLFI8R8L10stYgGzESZx
         GMN6eGnehUJENwn1mx1Tw3hyvn90yP3eRZmd39G+8hoBvfRHHe+NeImCYShIPWhAxs4n
         JiDqRjbQpaer09RU2yQfc3Ap5tz0FIYU2Tn1Q093+M+UrNmk61D9SYa8QoNIIR+aUZLz
         Iy5GVaobD5NHYMxc0FbXBs77+NlNi7Ui2aOUeoMoM6QA0dY1tljT64mbu0p6txSpktDg
         SOyycMdQ/ZcNyBPToVYThJ/A0RRWE/BvS++vEKChrSlS0m/RtSxrrhLvJPWYJrazkYfA
         B4gg==
X-Forwarded-Encrypted: i=1; AJvYcCU4ekVreAcj9DrQcczhUh05P88SaU7JOI83ywAgxNaPdRhvYuAzbvMdm+35Z9FfWPoAkZvtmUhD9xt8thQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk6hirXbi0KpqGGaB2p1cnCKar0EpIy41VCu5GGM7IRQrXQhCP
	PUXSLWuehL6EfQgDRnIWlA+W0GIg+wKJ0+ymcJMWdphnCtABvHedI6zOyUs3lw==
X-Gm-Gg: ASbGncu6IuEemjVqJuVLHkp7irf7ZXdpeMBoxGeVjl4W/XvGrtmGFCvh8sENufscmKc
	lV8I/g21tvsoTis/qLmveTvZiaeDORZn/u7cJAU0pr6S2WaCV3MBfkZxaHLp1fUnkt124RcBmdW
	nAgc8y1YAg1IuuLB1RSUo5utUyZ7ETWp3BOTLqGHwIGGQeWh8+G+CxU02N8IY7q31PiLgiVFiw8
	YHeRcQeqvVxOoZyyX5h0AmI4VsP3Vz4WdPy4ExZfbVWFv4H9fZaL+2TvgeRJa8La3oAOZZwamii
	q954VEaLRW6b+eaUaDHDUkO8
X-Google-Smtp-Source: AGHT+IFgO5znn3TOM6ZaburHci+S3FJx/nAZp7WZvG/y937GkzxZ+xTYFExdyNaYVbvBJfDJ07/Zgw==
X-Received: by 2002:a05:6358:5f02:b0:1ca:9c5d:1bf with SMTP id e5c5f4694b2df-1cab158543emr937389255d.4.1733149486483;
        Mon, 02 Dec 2024 06:24:46 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:45 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 14:24:38 +0000
Subject: [PATCH v5 4/5] media: uvcvideo: Remove redundant NULL assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-uvc-fix-async-v5-4-6658c1fe312b@chromium.org>
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

ctrl->handle will only be different than NULL for controls that have
mappings. This is because that assignment is only done inside
uvc_ctrl_set() for mapped controls.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 576e3854be91..e90bf2aeb5e4 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1672,10 +1672,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
 	struct uvc_device *dev = chain->dev;
 	struct uvc_ctrl_work *w = &dev->async_ctrl;
 
-	if (list_empty(&ctrl->info.mappings)) {
-		ctrl->handle = NULL;
+	if (list_empty(&ctrl->info.mappings))
 		return false;
-	}
 
 	w->data = data;
 	w->urb = urb;

-- 
2.47.0.338.g60cca15819-goog


