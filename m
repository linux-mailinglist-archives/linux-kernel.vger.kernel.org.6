Return-Path: <linux-kernel+bounces-534087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974BBA462AB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7826A174079
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE9B22A4D8;
	Wed, 26 Feb 2025 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fmhPMZj/"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823292288D2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579817; cv=none; b=CjQNX16w9C25pNU7mLMDjR+B0aHb+3dqu4R3q5trFho3cjQYYK1ek9GZnqVvKmzZ4rwg+SzXXNgbEOfdfWW2mq3lwnkPFyS0u59XYr8cFL8eul4Udpb6MsdJBw4dUwwlg1i5Nt6hbmxdTrI9I8v8T4dzmk8zIWxbx6X2N7hKtBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579817; c=relaxed/simple;
	bh=dw2qCpBVW0oF8+tSPBXZ2JZkiHmFw0P6jwMv0gbw+7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dgtc5T3+nAWH0nOutB5wHT/wrWkAJDQ7MzpMs0drqOPREpNvHuI+dNOgkC2EIzUnIbtJPQrxB+hrAt6l3NSWLtaMIg0TsPDzT/g44msVilS6a9gDk6TjRTdO0LMTkv5huqElcXGhPD1j1nvPXwp4GeX53bV421OqpXow6Zcn1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fmhPMZj/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c0a4b030f2so884055485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740579814; x=1741184614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYDs65iHnr/HrHNwFIq/xPxUuGa4QvYVvNxcsi3oCLs=;
        b=fmhPMZj/4voxDZ3TwZxuqRET5S+aTihXU8U326TydySd5BkZSu1Eu4sHVmBKNJ0uGy
         ZOTXD5LODMdyrDSBl1zpknffXr1qmdZ3CffcZi1bW35zv5LUGW4tnLSehYrSsw3epCAM
         oK2yjxf/FkAW6Ey6P08x9MMb09em6QKt1urls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579814; x=1741184614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYDs65iHnr/HrHNwFIq/xPxUuGa4QvYVvNxcsi3oCLs=;
        b=mo4A+kYB5lWRtZjvdYwmPSUCUT2KaOX9CZuWalBeJxz28XwRbKDYggj54v8KZoKpst
         jAYaGvLqmZ/zRi3/yEnNA2mi2T7sopkt1F/jGFrlyFTVyv/3tUQL0eOsm3vAFqDTjOcq
         oA3glrEVVO18Dr8YbcIw4+HXvr9Ezmt1++4sJ2Aj7hRO2P4/vlrCpSqErJ4YUGFsoKcF
         c2zVn63zBHmEn8q1yu9i17rTcbV1ShD2tGF4CMIHnadFCwQSrFQr9jqYtEzNQqhGHQJ2
         HbDSA/vBUhnaWs+6dhlhDkjYyRoPPJv4Qv7/j22UlPXF4000V0Mf/J1bWMgyrulqHTeI
         La2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGZDXNzvuoGHDgxHd7/QvfWFcObuXZ1jLPmKa8vXX6t/0MNvjhSIbgOdEw1N+r4SCQqe7vPtSZmVkxUIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1z6nj0PtJYjrHNOFP9WIdHO6b+G1lGRCk5m8aueukmuckrl2Q
	CcdntIpn6zG+iCJgzQymNaV2Efar3+iwdDXLAE1mlk6I+7VX0agMPOIiWAhyXA==
X-Gm-Gg: ASbGncvb4vXmhrKRz+UrDLJv9o7evQSDy9EasMJkwwc0/LMdVx2hmPbUyATJhl+oSgn
	tYTPoOvulOkEyQAsqIWIfJxra9EnXlcTY4mSf4btBFn9tGaWx/+JTg97IXrD74ME/i661BkDf8d
	EHgA3nKHdJ58SLx3Csmub0rKEZY3k+dUNnJ/EyuQ1LnNmlN8YYHKFL0s4MQwaZ8TUr5amT519tZ
	Wk0NA9LDQvYn4hs60+emhSPHEQVJOlpBo7wl40KeN3kuvwmJbAbzBaGSx6KpfU2OnUwqU/OBkhy
	K4NqL0THgfTYntynoPwH3Lgz7lK4o7oKh4gBRXyeSPixUnlOcdySzQYsVFgt+TePr6p63xVSmm0
	Ek5A=
X-Google-Smtp-Source: AGHT+IHuBFTmRowGPXy5shP9GSkIqBZ6nfFU0exVZOHDnxwl24falNaz1yGkMFwRvKIgYhyKtaXQxA==
X-Received: by 2002:a05:620a:2a0f:b0:7c0:b76a:51d5 with SMTP id af79cd13be357-7c0cf7d816bmr2776159885a.0.1740579814399;
        Wed, 26 Feb 2025 06:23:34 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cfb0sm246336085a.103.2025.02.26.06.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:23:33 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Feb 2025 14:23:30 +0000
Subject: [PATCH v4 4/5] media: uvcvideo: Make power management granular
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-uvc-granpower-ng-v4-4-3ec9be906048@chromium.org>
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

Now that every ioctl takes care of their power management we can remove
the "global" power management.

Despite its size, this is a relatively big change. We hope that there
are no size effects of it. If there are some specific devices that
miss-behave, we can add a small quirk for them.

This patch introduces a behavioral change for the uvc "trigger" button.
It will not work unless the camera is streaming. We consider that this
the most common (if not the only) usecase and therefore we do not consider
it a regression.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 1c9ac72be58a..6af93e00b304 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -652,7 +652,6 @@ static int uvc_v4l2_open(struct file *file)
 {
 	struct uvc_streaming *stream;
 	struct uvc_fh *handle;
-	int ret = 0;
 
 	stream = video_drvdata(file);
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
@@ -662,12 +661,6 @@ static int uvc_v4l2_open(struct file *file)
 	if (!handle)
 		return -ENOMEM;
 
-	ret = uvc_pm_get(stream->dev);
-	if (ret) {
-		kfree(handle);
-		return ret;
-	}
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -701,7 +694,6 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	uvc_pm_put(stream->dev);
 	return 0;
 }
 

-- 
2.48.1.658.g4767266eb4-goog


