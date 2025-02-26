Return-Path: <linux-kernel+bounces-534088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C29A462A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD00C3B5082
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3525C22A4E2;
	Wed, 26 Feb 2025 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V3KwENbW"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0EF229B30
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579818; cv=none; b=D44L9UNy0dg7AsU0iXPJEIaQI7zUBCshTybPBsuVqWkrlxkS5PTMf19X/SHRTCnH3+GRhY8Pagiya7WmZ6/pKk6NoTm5z6ZjnXRvVcf3Lr+OewcyCN37Vdik6zlv1hVOMFmx/bn6F1jh3NOBqvsrI82tmCyRzXxmDcTKqH4UsKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579818; c=relaxed/simple;
	bh=R9QrElg18QTPPLjHryDyJoCPAU+VfX0dGP/jT9Hqae0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OEyT2kW9zBqmiH1+vi+4JtOKQhLGH4SSjg8IZaR8Wg62Wz6zCGJfF9gzlEo/qWjRYU2fSk5ErFXfGB5bFAB+wkJOTIWehP4BFm9igqtLQ6rNKU4C1zj7piX1sj7jfjRmXVAS4wNgeZQawsMA9Rja7CxUf89hyYCowFFrRFxf9tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V3KwENbW; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c0b0ca6742so736223885a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740579816; x=1741184616; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KEERa7N5D4CRNojIsTNdFIgtRBSnpqe9YJ9niy4368=;
        b=V3KwENbW4YPlMU9AqXfYm4P+ohsG9TPxKs7iobxygQiqcGWIFDclViut12mcBcLozV
         LqV64WuN4lu+7V0HB6yXPpL+0C50zLwMZnudWvKNrK2SeFNv7oluEmMkaragGqXhLTkZ
         KAUiGuWqeQA6EqvOYNC2lBK1PJ7YjULlpMVzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579816; x=1741184616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KEERa7N5D4CRNojIsTNdFIgtRBSnpqe9YJ9niy4368=;
        b=pn3E48H0t7kpRHugnoCRg0aWj2hLnh72QrMsNSKSmiUJeib++1TV0Oc6q+WL4lP3Qz
         TRFuqW3F9Q+bj7/RkRwKz0x2KvmF8N7AO/zwAWkUhUkdK/+JVBT/GPna149OHfYZ9X2P
         bTXaSyBf79lOQ3X8Bo0pLfrUtJz9OOH4WH6NbTMAKL6C06qV/EehgpUhx6JQB+k9bclB
         dgvUH7ecvv0MMv79nLBVmKWLMTIj4bVkcQ+HsnGfRZ/WifCxQYTlCcdU5slgIQdJZ+fp
         cz3FUxyYhumTAwNcvJaFBX2D2fiP7hoZB7I5jSVyLVFc1lPvys6AJoFfjA1aIbok8536
         MXmA==
X-Forwarded-Encrypted: i=1; AJvYcCXzln67hll54S+rGNzRBcY1Iv4SgJn8Ajl5xLmnlUDTRkpiZrfRGMMjw/M40oviJkd0sKrbpEe9wZKS438=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw0XJu0Aam3gciZhyuvWPdFZ5pLts/whSWYoHGpfnyERBHJEaJ
	iPvRtWsO6pcI0Ib8jIJ5IxPNmfZIpMD4y+jNTY+qjSbmhIillFIcswtPz6ilLA==
X-Gm-Gg: ASbGncuzHQKl5eSi0Lfcpntp7uTD4860HPjxmkYmCcV2RPEP9Oh2lztMwVFIWek4aVb
	2r1n/X1KiItp7Ku8pTrEnae16QXSHgFkv3YW+Z7y2UJvFslV/cKueiYOa8OHZxhtwB6q087TTHn
	P3dzJJLbLmJBsr8LdBwCzXcwqwyxmQulT6Cg14XiB6s9uEF6OllJd8n1exVdZ3sMJ8gy2i+bKhn
	/scRpfoIAerBzjetF4aRQ4RLgLGqUvYgpAECRDq1P91UNmShxrG8cEKiagL8ucaMkbCRgRDygVO
	NpvBbp8OoMUhoteRN6hmNGEMv4s7wiW6MQzVrJTy5DKiL/0A4wd0qJ1OFQZXgydyCwrgUG84PZQ
	RhBc=
X-Google-Smtp-Source: AGHT+IFYWattDD81UWH54aS/cRKfe95cQMADw1AlcxpsVhbtQXOtLPwSz7HYmPnEqiQEI4Klm2FKVg==
X-Received: by 2002:a05:620a:19a8:b0:7c0:874f:c87 with SMTP id af79cd13be357-7c247fcb77cmr516463985a.35.1740579815835;
        Wed, 26 Feb 2025 06:23:35 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cfb0sm246336085a.103.2025.02.26.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:23:35 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Feb 2025 14:23:31 +0000
Subject: [PATCH v4 5/5] media: uvcvideo: Do not turn on the camera for some
 ioctls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-uvc-granpower-ng-v4-5-3ec9be906048@chromium.org>
References: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
In-Reply-To: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.1

There are some ioctls that do not need to turn on the camera. Do not
call uvc_pm_get in those cases.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 6af93e00b304..de8d26164996 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1450,6 +1450,26 @@ static long uvc_v4l2_video_ioctl2(struct file *file,
 {
 	struct uvc_fh *handle = file->private_data;
 
+	/* The following IOCTLs do not need to turn on the camera. */
+	switch (cmd) {
+	case VIDIOC_CREATE_BUFS:
+	case VIDIOC_DQBUF:
+	case VIDIOC_ENUM_FMT:
+	case VIDIOC_ENUM_FRAMEINTERVALS:
+	case VIDIOC_ENUM_FRAMESIZES:
+	case VIDIOC_ENUMINPUT:
+	case VIDIOC_EXPBUF:
+	case VIDIOC_G_FMT:
+	case VIDIOC_G_PARM:
+	case VIDIOC_G_SELECTION:
+	case VIDIOC_QBUF:
+	case VIDIOC_QUERYCAP:
+	case VIDIOC_REQBUFS:
+	case VIDIOC_SUBSCRIBE_EVENT:
+	case VIDIOC_UNSUBSCRIBE_EVENT:
+		return video_ioctl2(file, cmd, arg);
+	}
+
 	guard(uvc_pm)(handle->stream->dev);
 
 	return video_ioctl2(file, cmd, arg);

-- 
2.48.1.658.g4767266eb4-goog


