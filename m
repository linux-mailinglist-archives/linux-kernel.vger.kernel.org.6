Return-Path: <linux-kernel+bounces-425897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108939DEC5A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92502820C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B814A1A42C4;
	Fri, 29 Nov 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/vk8ZML"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD21A254E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908314; cv=none; b=NxgksJAEnFrDkDZgslmhi5giNvb2PH8QmHpusgngY1idaskgb9kgDk3v23exSwwl8ar1AFr17kwkJVDINdqs6Tw7o/xnzumfqNF73CWox5r2iXOvGAFfuVILStVoiYZ6f75nM7Xuk391DWRQTMAfyUJ+WUgAYzmqgJuHimWLDgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908314; c=relaxed/simple;
	bh=KDAOGjpXXULpZa75pLl+o8CodfY7IbmICZMYyev2FdU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVIYMihknL4cnPfmAMeqVkRvpx5SSN9DhvQDB7XrcLhjcw84/NgSptR0fARmQcWWg2pnFPV9UEZi/avCKSuwg6WM20EYg3m3EgRqF7nSpDTzH6+9Yqa1r2tiMW04ll6G+qlcYaEO3YhZdOUmTKuf4z9EtndLmmarq9mg7p6QN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T/vk8ZML; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d87a55bc50so11754566d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732908310; x=1733513110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DsG2Wx3W9iEMxWqh3g5yUw4V+bP3sc1QbSYtLT8mhKI=;
        b=T/vk8ZMLG+g6cSw/uloiOmkCDvM8y5KeYGFMRun0KbsM6Z5F6M06LgllDP0n1CzuN9
         VM2/1Tp/ffu2oFAdXdyxa6MWewiMvOEpvYqS4BgjFoIu+6yuejQ2871B3Xtvq1k7d5zC
         Lt/djj0sGnmwyTG0XhIkQOLDz5gdv9g3c3FyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908310; x=1733513110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsG2Wx3W9iEMxWqh3g5yUw4V+bP3sc1QbSYtLT8mhKI=;
        b=uqEP4tN5KR5/uHllIDiSpzRpsiUPFRnc4V9lVKwzcFsid2xXIxigvU4zqmAeVIFkIW
         F+jmGSK0VsCquJl3hbzere69IXqbNukQi7iitteNAOGRVV2/2y14hf9YjEDfcdBXS2oi
         9ko6UxFKESozI6Xh4R1T3HOEA8y0rf6xW4kKGt1jZ6SGdn9X6sKPfczc7nmufCHMPEaJ
         c+rrpv8IXbNrWu2W+/Dbp/3uO8Cl8ty8TgOdKYkap9ydZUTnUMuk2wf+MjZF+JgZvxeO
         Lp18ZVi1eFZWYaK/L9hfeQZ0WLWvt7al6x3uBJRFqG/j4NN95JjnMOY6uA+2h1OPPTeZ
         +JUg==
X-Forwarded-Encrypted: i=1; AJvYcCWgPsRqKODnHHvNfyidSoSsurODc0MPMPkRj2PnkJS84gtR/VXVqbQt/51DTCVyjpO5jajZELFsZdrcZTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHZDGJvWVg7DymqoxxbS5q54RMmUAbZtxPPP8T9NK0pnmb/qUp
	AeXt4XhFmN3CjXDNohdKDodviekOiBUsMe9a5E+u9sg+C0+nm3wVhTnP4CHxDg==
X-Gm-Gg: ASbGncuBc2/T6oQ+H9Kg0o+IyxXDdtefInW99X1Q7TcjZ0OI16V2lYjYh+6CawKYuZB
	VTqigAPJaGyo1o+YugQKy/+qi00LBVxCeK/wWyfvLtlkGpfkbwL5kPjpqvbL7WKA1mFUzmQqBhZ
	O+vKn8AXvj0C9vr0DJWcCiYbweLt5J2gd5xUn3frbUHm012u1PI0hFGDsXq/zRdrsLzWArLrxpT
	o9S3ei/Tp5l0rq/MJP+4S+Br8ldk5QfI6LMzPCPERDJZBHu3K/DbU+pz2Tth6nWwZf0zeTU8mro
	n63gCKYcSL5YwaHX7KzY0jnP
X-Google-Smtp-Source: AGHT+IHWYLjW914nhGcA62UKvuHc86hH3lbm+mb3t304Ztc6ITsE/xyJVsbWU3vwDNxLRMjZMNifvQ==
X-Received: by 2002:a05:6214:1d25:b0:6d8:8289:26ac with SMTP id 6a1803df08f44-6d8828927damr78350326d6.45.1732908310529;
        Fri, 29 Nov 2024 11:25:10 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87d899ec2sm14462146d6.50.2024.11.29.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:25:09 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 19:25:02 +0000
Subject: [PATCH v3 1/4] media: uvcvideo: Do not replace the handler of an
 async ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-uvc-fix-async-v3-1-ab675ce66db7@chromium.org>
References: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

ctrl->handle was used to keep a reference to the last fh that changed an
asynchronous control.

But what we need instead, is to keep a reference to the originator of an
uncompleted operation.

We use that handle to filter control events. Under some situations, the
originator of an event shall not be notified.

In the current implementation, we unconditionally replace the handle
pointer, which can result in an invalid notification to the real
originator of the operation.

Lets fix that.

Cc: stable@vger.kernel.org
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
 drivers/media/usb/uvc/uvcvideo.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 4fe26e82e3d1..88ef8fdc2be2 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2046,7 +2046,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	mapping->set(mapping, value,
 		uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
-	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS)
+	if (ctrl->info.flags & UVC_CTRL_FLAG_ASYNCHRONOUS && !ctrl->handle)
 		ctrl->handle = handle;
 
 	ctrl->dirty = 1;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 07f9921d83f2..ce688b80e986 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -150,7 +150,10 @@ struct uvc_control {
 
 	u8 *uvc_data;
 
-	struct uvc_fh *handle;	/* File handle that last changed the control. */
+	struct uvc_fh *handle;	/*
+				 * File handle that initially changed the
+				 * async control.
+				 */
 };
 
 /*

-- 
2.47.0.338.g60cca15819-goog


