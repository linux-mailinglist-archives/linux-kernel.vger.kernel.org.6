Return-Path: <linux-kernel+bounces-422569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873A9D9B46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F9B168057
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356D21DDA0F;
	Tue, 26 Nov 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cGVCOFTA"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1761DB52D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638033; cv=none; b=F8afPUgqfboEIFFbxF3Wggc1jt+7CdD6PElR6Key14b82rS9kTPSHEaSg7UMwi3zwdoaNPIP03Pd2uijmQW1xiYCVRJFIwxJp3J57+4q0yj7+9Wa+u8Z6xb6tntHQGQDGGKq1ZOlKk4PUNywCMPzKdKqkAYTC6bKaF5JPAnA/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638033; c=relaxed/simple;
	bh=3Dzgzh4yU33ztM7bLdskr2zw4uRmtMH9ym8FV6irr3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLy7gEeQpmrzyAzwqOEgcsbf+kJTXprouS7IL0brANddVwYov2HJN7I3Tf7QCq5QhKdbKC1xs0UxE8FxKVQBZf7B6LL7ve1i1BuFgTCE5oqs4gwWYs5Ewb+hYz63Bn+VlNQ/C6NaG8zfJaz/ZX2lUBwpXy+APpe1+UrlE6WTAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cGVCOFTA; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f1d1068451so1184164eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732638031; x=1733242831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/lu/EGVVDXuMSIzdRCxVlnfxSM4yuT3W6HrMPORjdo=;
        b=cGVCOFTAmJgqnFtFVRgf0nmNWSofQXtS1eTM85jrTLPQ2LrLa3KCDgBcGKiPRor7pB
         3mEUg5dO7E4dBDzwuAyUm9c7rXNTJ+yIc+g+nW5F40S0P4Ld6y0iu6WPwnFxoRMHW1TN
         KundA9BsmwBPjYx1YoxQWFtmESbXHur5EkwAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732638031; x=1733242831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/lu/EGVVDXuMSIzdRCxVlnfxSM4yuT3W6HrMPORjdo=;
        b=mj7Uib/LHI7z11J75PWvrCm6tAC4DCTzEhSJ8nGCy7JBgPYUw0HvEgwghqjeF8CdkX
         wkVwVIbXkLeVChWgNrgSUM+l9CugxscAVPWRn+qExdSPrxw2h6kttHtVBHPNAvt4eCvH
         82Ez3uCxK952C06Ecs6++XXnjYe7p8Ose+DFYK5u+lJobqiCfFNk5eHmAz5SH4VyjQng
         uT1lTBaptuYBIr6pxj0xFNp17zvvxEFuWD9R02JsIgG+HW8ae3LbcUVp+z9V0shEGCC/
         O4gFtjyea34HWIJwa0q3gcf5T8wadOyjMairRYP+OVBK3dY5Oz7TUUNT3KUx9SY4S4pV
         tbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi/vNLkYTNYWSfRJFzASP1Hyp/8x9Q7a/p+0mtZ4dabJwFujfR5oFcc1Rod0K9smBoaZQFmvMh7oxF/WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSm174TnyKbYCb2WRf5seGGpU8cdtFlS08eQR+vSmqVYek3G1t
	nY7HE2mxgRWUxYjXvahRAP2AoRRgO34W0ouHXK+skVSesX9aDtOGa+0bnZt6hg==
X-Gm-Gg: ASbGncsOzEE2HgQLpUYnAXONNjm0kNjRrILHHIQuW5rhtrrd5vZrg0tqW9O7/Q+sXS9
	mLGavBjI0CEYFvWmnOaeBD13APvNK3k1r+rcfwEeS07YkelBz2+/o1IPeCpOPFtBjUib2jWika9
	jLFfD/6paPdU0hFW5TXWaTAtn50dr9x2ZrMS6slIx8Ud1XEcj/iLaJCBlkodv+wzrTK12f8DNSP
	9obTgXQxeEORvdLLlf7xRYY0VxOT7ZZeFnFKVFFgXDN1R4NlCkqDHXXiu9eiN9FTrNJn1ruaH1f
	nY0r6sSHcfi/QK+/uGDjDlpL
X-Google-Smtp-Source: AGHT+IFPBjhCNlx/WOQpP/DrR9JEp90XgxFyirfWiypz7tV1QsQQ+4YXuQ598fwfKwMo0jUvpfnh+Q==
X-Received: by 2002:a05:6359:5cc2:b0:1ca:a77a:e9b8 with SMTP id e5c5f4694b2df-1caa77aeac9mr318229855d.17.1732638030982;
        Tue, 26 Nov 2024 08:20:30 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b4e8205fdsm346532241.1.2024.11.26.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:20:30 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Nov 2024 16:18:57 +0000
Subject: [PATCH 7/9] media: uvcvideo: Make power management granular
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-uvc-granpower-ng-v1-7-6312bf26549c@chromium.org>
References: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
In-Reply-To: <20241126-uvc-granpower-ng-v1-0-6312bf26549c@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

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
index 1972ede38c70..3595f67fd7e2 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -612,7 +612,6 @@ static int uvc_v4l2_open(struct file *file)
 {
 	struct uvc_streaming *stream;
 	struct uvc_fh *handle;
-	int ret = 0;
 
 	stream = video_drvdata(file);
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
@@ -622,12 +621,6 @@ static int uvc_v4l2_open(struct file *file)
 	if (!handle)
 		return -ENOMEM;
 
-	ret = uvc_status_get(stream->dev);
-	if (ret) {
-		kfree(handle);
-		return ret;
-	}
-
 	v4l2_fh_init(&handle->vfh, &stream->vdev);
 	v4l2_fh_add(&handle->vfh);
 	handle->chain = stream->chain;
@@ -661,7 +654,6 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	uvc_status_put(stream->dev);
 	return 0;
 }
 

-- 
2.47.0.338.g60cca15819-goog


