Return-Path: <linux-kernel+bounces-542638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6625AA4CBD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817901886F75
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE9F23498F;
	Mon,  3 Mar 2025 19:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UKGaCHCI"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC91230BDB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029225; cv=none; b=E8VSNMizJhT6S6hvebI9W4IcRubo09kWt4sOg+TH9qE8cC4o7iocFGb9PgRi9c1+QU/4S5t5JP9mi6q1nJkZcyxurCEyrVbfYjIz2LfU/ilt6QS6jL0TYx3sp6xZ7gBWWatg+QuOXCNMsiWjPcdi8FMUHi4/gxHYs3n2eLA3Y0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029225; c=relaxed/simple;
	bh=qj9XlT1WiKm4AO6hkKE1By7lypenS+uznQVD6sIZ6Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFz42dJboNMBZPg+Jsig21HIpi1UAysBljNYZAYdy6KohNmVm1WuhiMYsTs3VGxnQPaAqgVM07ZgHyOx93kr/zd/rANv1S2NFgxNWM6xx0no9p75+WojeQsHgH+xnHUecEEIwFJ0QYjguMBZSbdiVL00fRSj2oHFosEGr2uismk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UKGaCHCI; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474d11c7f1cso7537591cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741029223; x=1741634023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MnG0EicLIQ9fYl+R5jdVwfngFFSuuPxJwnjFoj+2kg=;
        b=UKGaCHCIxdhRTo+gWPJCqO+HG1UY50P+q/gh8jSpXK0yWzP1589Kch8BP3uPUMq391
         h9OcKARkjtjRKTqfUI5QQuaKQAZx/odHhz05HtNuAx/Z5USHIyMzJ48Ti2y5QPCix+qc
         zxngfCf19ednZZCf/SHkA89rQRHzy1mw5C5/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029223; x=1741634023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MnG0EicLIQ9fYl+R5jdVwfngFFSuuPxJwnjFoj+2kg=;
        b=BwKDK7YcN+JFGrndXk73JgIm0rm9MH/AOuwCpgHSX+ry0XYFw3OzV08YMTOEkRD2VP
         Js1bDtxvmm165RRW7rBwqBf9vFqp1bKhzt4DymZhKlW/Ae37VAcHCJEqpSanc41piZhc
         38DfJlemSEvxaj1gFOGP9j4OT8BlffJihnQleaizstx1MDNDZO1No6cO8sR/cdpAhgFb
         CNdzUM0+uBSIZUMeotWSITkzSRK5m1JzAwkRDw5fQATv0/6nS2bPufLYe28R5jydSblp
         uAFWUnLxI+8Fqt2kMS1RJKaqvllFuag8Wk8hCsMlA62EkZ9OW4Vu5ie+9wFqQLjaGRbF
         NwBg==
X-Forwarded-Encrypted: i=1; AJvYcCW9idV/dXMdD3WBksy7Uc+sbKqTpoEmATMmrxdFRPqQQV6I/3AaD82UUvm4Z0jVVwC3a9EMLbZ27mOb61I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhtZNWuu53DnxEAU99cNb2R0mBGTWVLePjx/VAVoJQiTfql0hr
	OV1jey2anp7ls0RzIoZC3Hde3s3G6v7XKAC2zpPG5X8JI8BfiEFa/VBZUSDD89mzIUqh4pFj95D
	a5A==
X-Gm-Gg: ASbGncuSHWmoqfcnnloF4eMQnUiL/mSL7sBP4mXZim0ThORkR3Ya9/Vca9mOyRfrRun
	5qnprPcZXIs/uf9Ved4CjJGRDNw3BOVA4xh1yMNyaR9GpE/nVuyXx+yvISpzRzn5dTUtU4Lw4kA
	zXTWFVm92FyhtXfXmbiRO3KxgXRz42204oQarc/3cU6zhkFtQVs2BlyjODRcexlJWqUpCPsy3ZQ
	Ad8h24cbTiPw6zuoKE1JQp9uKbm2Wmrj8HH26rIew/P01pguY+9WP0woTk7BMVXdGnMzRvvDWH2
	7N205KSfQDF+9tv2G82xEICQWbg/3hPERLISq6rfG5vsjPNgIP0sWXSo6jyMNei1kQZrOOt0lvc
	y/T/ujNFyhLr+Wio8+P1DEw==
X-Google-Smtp-Source: AGHT+IEQGZ29VcDcFbL/MqUTzdoYNbg1Fi5VRhzqMJ4olgsaszoAZ6iyTyqbDbVixb0BJPPsVpFm0A==
X-Received: by 2002:ac8:5a95:0:b0:472:28d:62b0 with SMTP id d75a77b69052e-474bc0f4bcdmr250554011cf.41.1741029223076;
        Mon, 03 Mar 2025 11:13:43 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm19745661cf.47.2025.03.03.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:42 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:13:38 +0000
Subject: [PATCH v5 1/5] media: uvcvideo: Keep streaming state in the file
 handle
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-granpower-ng-v5-1-a3dfbe29fe91@chromium.org>
References: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
In-Reply-To: <20250303-uvc-granpower-ng-v5-0-a3dfbe29fe91@chromium.org>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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
2.48.1.711.g2feabab25a-goog


