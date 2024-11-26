Return-Path: <linux-kernel+bounces-422563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203CC9D9B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF70AB2B3DB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7C1D8DE8;
	Tue, 26 Nov 2024 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cgn8Km/S"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51311D63FD
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638027; cv=none; b=EUplJzEJcQywT7NXyaruUhmAN8IjVHuuzrNQi2QM5e+E1w3rcPd98JlAOtta07Pu1hQvYo+vfKxSn+aqKvsJE0rs1RuhPPYP5g3EF81jXQevz6SJc0NMlNSoC9PkZpKj7rB7TQ0MpJwG88i2w5BuXVB1UlwQg8ofHosLw0Kqn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638027; c=relaxed/simple;
	bh=P7cJDdqJWrLuL8K2uEZRvjaoWn4MVm6+xAAkGWyiVYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s0gyrgD4NR5gFWHYCHRixk7rYhOOrFtGc/XN0UPdNn993hzDjR1G7FXWqN00bUO1G45yCOxDDs8Nwcm2ep7Eu4Y0qQUYj5QtRlfTM4cZNjdHwz+dnn6WPVlaqj3GjfcMpSTE/sJ6C+wnQakfnMM/d8mJMNo0YYQJHCiPjNSRxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cgn8Km/S; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f1e73033cbso1090679eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638025; x=1733242825; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=cgn8Km/SwG/fy7Su2kBHmgQdxp4jgrnKQwgxfpOGNl+ypdIaiXrPknhCQbvMIZTfJt
         R/a0qS+xkU7kokODG50CKAm8vWLzvpdd08E7KhjxJu90MNRAOdLwjmZpuMmjCvI6v7Ao
         Ygjfa1A1G1bBqu0wWOTFffn5hwQpFNco8sVeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638025; x=1733242825;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKrUO2mKilVMnb8uGrp8DPUwicBtZJtjKmdkARmt5l4=;
        b=oZO5MKjYfouk5jv5QMTqzUBMhJEWF7Wz8CjErYRyKoLhTKzc+ETmtzjxLqfL8Gn4sV
         +JoH5eDqELlVmTrfQt25+LLrWJOvj/s7yzhXoU1+fxQ+r+Scb3m4/BLYX0qxOhyk6wmd
         mI7F4SdnaIddTM4hBUNmRWqezQexU+33pIdFpaues50Fw1Zy/nDVBYWJvYfLx/HJMrjx
         WjOJb/I0FHLFOQIIcoxWbVt2s5HXAbaZBWdi1tgacZCj20EvHus794gdMhWY4V8YuXPv
         BuyzzoIysqIbT6j7WlVyxxBWhN5YcwqVey2ogcSJZATQn/XO3mI7hL/P5S/MO1bxQbnC
         1pJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTgncUhNmbW+I63Ej/A3XhJhyKJGonOxM3si3+uVvik9iHoH+/NAdOhNCdxt5K90CLsnwlJabc0bBfMfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXL5whQ+56KnbSMuSkZbT1CaaLCdf7Vft/zO/vde4oZ9NQfOG
	dmPLIpgS6MJBvu/dVK9eu1g5NBQSVgaoXQO2vwYRpUKgkgSjOS2b43fdBNk8Pw==
X-Gm-Gg: ASbGnctC6p8gBzd3fb/8bherkAqhp5zCBX6gQBGmSS0/mCkEsuRbS+LMTZBCv1BeD17
	iMXSV4YFsducz2LioGO8c4KbbM8c1O7qCjArhaCVrr5UeTesPOwPHfM430PwwZZw+6uKj6gRHQA
	I7ijbq17zWQtqarx2qK0lndeuCzyZlJEoWxJVy44GHufdu2nxkgCiml/IGb4MXBufHgJ6FDsDWh
	v489KLGTQerVMPKjB+0HROYX1IwyKVT/jkAZTu9UfqiLccQQTvqir6e3Kh8NpawN6+Bg5dnVFtq
	u2/nJN2mdzIjEbNsZMcoQ0mQ
X-Google-Smtp-Source: AGHT+IFdNgRDGrF5CTdu4yR9Csg3r8Ps+A7V5ZKG5GFvlDcY4AMEGEJVb3A2Xw6tVAlAoAPaVnBh7Q==
X-Received: by 2002:a05:6358:52c8:b0:1ca:9839:5d09 with SMTP id e5c5f4694b2df-1ca98395ef6mr446689555d.8.1732638024799;
        Tue, 26 Nov 2024 08:20:24 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:24 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:51 +0000
Subject: [PATCH 1/9] media: uvcvideo: Do not set an async control owned by
 other fh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-1-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

If a file handle is waiting for a response from an async control, avoid
that other file handle operate with it.

Without this patch, the first file handle will never get the event
associated to that operation.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..5d3a28edf7f0 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1950,6 +1950,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	if (!(ctrl->info.flags & UVC_CTRL_FLAG_SET_CUR))
 		return -EACCES;
 
+	/* Other file handle is waiting a response from this async control. */
+	if (ctrl->handle && ctrl->handle != handle)
+		return -EBUSY;
+
 	/* Clamp out of range values. */
 	switch (mapping->v4l2_type) {
 	case V4L2_CTRL_TYPE_INTEGER:

-- 
2.47.0.338.g60cca15819-goog


