Return-Path: <linux-kernel+bounces-534084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FCFA462A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F171672E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEA221F3D;
	Wed, 26 Feb 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ED5Bnt73"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD242221732
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579813; cv=none; b=HLYpvmpzp6wnwSM0yPuTKkqn0gAZjsEanKgZHPWdoG7/dXF6u6R/Mkw3SA7H1obhTbNv6l/OAeo+8CP5Nep/jRQJeTge8QQQBXlQKlwaUq4SRLKnxvd+zNImcnfW6W8GiHLFYDAxaWEa75vskclLOYqqxmztiBns7Ao95Ygc910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579813; c=relaxed/simple;
	bh=ri+j1q9HNTbPxqJ5PKx8hnKBR80LOJzmJuwIpKv0D6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToJPQrZH2T6BP/7puhIFonIn5f6kL3DgHl5SMoljKSMOc2X9QbGpsEohLJcXYhBnZ0oxJcS226O1w4fIhduqsELDPDdiaa/yEUu3kXzklUUvlRX739sj5GBE1dS42yFUBUELyaI5Gj16lNFLVSrkp0+2G+DCwtDa96lKQHI1Pd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ED5Bnt73; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0b9f35dc7so933878285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740579810; x=1741184610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FR7Ypv0Sg+ewXBIGdoxyyeMv+vtDJwycIUjyx2MKkFY=;
        b=ED5Bnt73wpD3fChX3kqbJa3/XhmoG76Oyzv4FTfkR8UQR0x0iInvO6gv/vZp9HnW+E
         ++7HupKvm6+/9hlElPdS+ocGL/JEWZILR1TTtZ9mb1ufUgjklUru3tJAOj26yxZNg+A8
         uIgIieCR+Z13WkyFwWno2Au6D0TdRjVwtlV0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579810; x=1741184610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FR7Ypv0Sg+ewXBIGdoxyyeMv+vtDJwycIUjyx2MKkFY=;
        b=ccJoZSvtjqAIaVr4csJ7bpCS2Sv14cpMvdIRdclVq5LL7C+x1Jls2wXUKWjE5gdWX1
         JtUA4scnR7K+45ACkgQLs1haGpEUzsOO0tbpQRy8xYCoOU+yoIq7mwadspwq3tuACpqc
         8mrGo/uhmhrNRx/U99ZNVmndhkQIGCcDO0uvn4CMmYKs8GgR9oNgRWb9gs0YmLkGFPH3
         7AD/e2wG8LxdFytsHXik7E/tWltWm/0f98+eGPf30J9eqa7nCqkMHo69CL4F4fRIfC84
         vkWtdXWIRhby0egYPrcrxyyoD5KNAagQK0Tp34jW4RSTvxY91I9ssfEqQI+Qo0MhRFFH
         L35A==
X-Forwarded-Encrypted: i=1; AJvYcCWOCsJjSi4CBt6Lr1RZSMB0xsqTtVT8/k2iDeDDYu/z32OqVXcXidA7eRls4y/7Bkk8wZcqp2d32mXUsa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxv0rDVBPjSybT8s3WG/ggdr1KFG8QJj6kFbmS/FJq92aQltL7
	osRiZ0bjja5CTXh/SyvfCkSoDmleNJZsgbxM9A5F2YFL7N7tiSmwDyQGEKbG/A==
X-Gm-Gg: ASbGncueNz944O+ruFUCkdz1VYWWwhGeVXlZyy1pv/MncYOOeBkfl5v4fl55AUo23VZ
	xuXi7DSXUsDj+ZgaUak4zGj9dYYcW2z4kDPzKX13wPR/j/vsuy2psN8VF4wJ/76mDPP54Uy1loO
	J+UBXASI9yAcUk0NSgwIgTW526H/dKVCavQx0hwCQGzVwmkfgb7HA3YRnEOU+hicvkvRwNwcTKS
	cFDipD/VbYb0jPhXAk0b21/ebhEEW5Rwt5BoLScxo+kb5SDnTOAcqf37bDFWaiZ3hF9Cs9Yh7bv
	40mMBrfQ1zT2zly2djMerHA9dvJQjCXS/OY77fPgVoXusE7OmVAKLgBqzaPcEAmxEpj9UwB3T+S
	eQxw=
X-Google-Smtp-Source: AGHT+IH79EX6T3W52JGBBGWui/gHd8e8j+HpD2LiLS0W30noVcOURaOisGZHFg886wnhbnBhazedTQ==
X-Received: by 2002:a05:620a:404a:b0:7c0:808b:1c78 with SMTP id af79cd13be357-7c247fcb611mr700665085a.36.1740579810731;
        Wed, 26 Feb 2025 06:23:30 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cfb0sm246336085a.103.2025.02.26.06.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:23:29 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Feb 2025 14:23:27 +0000
Subject: [PATCH v4 1/5] media: uvcvideo: Keep streaming state in the file
 handle
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-uvc-granpower-ng-v4-1-3ec9be906048@chromium.org>
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

Add a variable in the file handle state to figure out if a camera is in
the streaming state or not. This variable will be used in the future for
power management policies.

Now that we are at it, make use of guards to simplify the code.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 18 +++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 93c6cdb23881..f9cd6db759c5 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -835,11 +835,18 @@ static int uvc_ioctl_streamon(struct file *file, void *fh,
 	if (!uvc_has_privileges(handle))
 		return -EBUSY;
 
-	mutex_lock(&stream->mutex);
+	guard(mutex)(&stream->mutex);
+
+	if (handle->is_streaming)
+		return 0;
+
 	ret = uvc_queue_streamon(&stream->queue, type);
-	mutex_unlock(&stream->mutex);
+	if (ret)
+		return ret;
 
-	return ret;
+	handle->is_streaming = true;
+
+	return 0;
 }
 
 static int uvc_ioctl_streamoff(struct file *file, void *fh,
@@ -851,9 +858,10 @@ static int uvc_ioctl_streamoff(struct file *file, void *fh,
 	if (!uvc_has_privileges(handle))
 		return -EBUSY;
 
-	mutex_lock(&stream->mutex);
+	guard(mutex)(&stream->mutex);
+
 	uvc_queue_streamoff(&stream->queue, type);
-	mutex_unlock(&stream->mutex);
+	handle->is_streaming = false;
 
 	return 0;
 }
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 5e388f05f3fc..bc87e1f2c669 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -618,6 +618,7 @@ struct uvc_fh {
 	struct uvc_streaming *stream;
 	enum uvc_handle_state state;
 	unsigned int pending_async_ctrls;
+	bool is_streaming;
 };
 
 struct uvc_driver {

-- 
2.48.1.658.g4767266eb4-goog


