Return-Path: <linux-kernel+bounces-423120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8229DA31A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052E0284BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0BA14F9CC;
	Wed, 27 Nov 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vb2oHvWw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F20DBE46
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692698; cv=none; b=Gj1bVueWt1gjbv9NutYBfXcas4wGSzjZ07XUgAdulAZ25Ya7opK043jKo/uODKeEgizYvRjknsOm3zGkfqYBuNEgureP4CCuF9u4VSUm4SFRL0dgFlEn1Nvpjo0S1OMiSEJw0TcFIepFfrq+T0PwfSH+4rb1CXGUhxryqpBZRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692698; c=relaxed/simple;
	bh=dqZDut5fzTWDXSN5vDb91fVnxcC/3pJWX6YT082XNKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=O86aRpLogfG/nq9H/QQzjNIoEWq+g4elxCTxOVpvRj4l81qQNF+HwLfViMSMWavn9777RjXjBTkYPuhPl4WpNp5ly2/gc/UFZSPZHV5+ZlTMTD+V8x20abZwlhWuooVqAayYGJsTXG64VGylnX9M100ZvoZwhTy09oFVp3hgbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vb2oHvWw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ee55cfa88cso59062777b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732692696; x=1733297496; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5s5kassNlAoHNZdiz5aHlrrPJqXpxtHYXspH9LV6FQ8=;
        b=Vb2oHvWwJjKyBqTLeCeBKZ3+L0t0UrjOE+OMJFRnQZjNc7dvvxAUfOF0PKGw3xAjyB
         8E8ixEmu+T14AQ9OLcDPtF1WnhhtAt84f0m5mpWkkP6qPfqKxjhJT4PJfhILofszc2gP
         jrWCUMG9e5v0Gw3lL+TWTIPUHpg9B3Wh4TVDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692696; x=1733297496;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5s5kassNlAoHNZdiz5aHlrrPJqXpxtHYXspH9LV6FQ8=;
        b=khkBqFuLHuh+qy8KDgJpFC9L9psgbEuXbUBB88Cxx6y+7mS9uAHrmtYLROFD7UqhH4
         Qy8OeRDUMdHrFWzpoD6V+UaJyTcS+CUezfr2iQQK3NfKdLtX4+5v/FJc02XbUrumoIk+
         GTEqtaYqFUsVeZU1mMYCJuJ2jSVpIXNmEhxMYtmR3H6tMcQmQAYysCyxXwp5pmodyoTA
         d1iN/0Cp2VMlSSFW7Jco0pE2xG8uvNlPthxjWmY7QpfDhTQLe1NFFSptoAP5DX17gffT
         aa7vRUc6iQG9o0X0McqezuaKAsC0Uzitod4eE0L6vt2VT62EHIVXu/vzV9WEhKJ5QVIZ
         aFbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4FtjnAp+tID1WpW2BN9f8fTigyzvzivhMSJP7blqgpIzOct4yDfAZGY7iH/89gk8JRgDFKOH6lsxNuOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfuPaWDiaBZU9KMPOudCzc1+pKn8EmiZ4mqSpBgN3CpS5s5Q+6
	pwl2XmjH90BTzU69CDlwH6dqtDsOuiI3xQnHOghuUQ15W5ItPAzWDmMLT6fMkg==
X-Gm-Gg: ASbGncunHFXFZWEuJcdzLfjtxUQ7SefLdKYaMoxIqz2Kv7z29xaMI6laiaGZXq6Z5d+
	WdZBDovLcnwdE0F9dPST1RByznklk7T3fv+DpQ6KB9/0ZOcOW8Bcb8Pnb8K8QuB+F26B24SQFuO
	cm00b+GRBYEn+iW6oECp1rzrMrVWe/RGVgNO7IaO3b/LRJJ43xjVjeV1FABERVrDcNacYUMmReF
	wcNgSKDzSZW685/zxGu/8UpXv5QK9fYA2J0YkLGySAfmBUxO5zRLFAU2scKtIAa9YGCPZaJx2DE
	q5uafZDXL5nKVnezbf2YYqjl
X-Google-Smtp-Source: AGHT+IHyZnJyE9wo8p3SInxIuSgKOnoVMgLEx25GkkIkZK0krjmvoxt7Wx3KVXoA9xySjh7XgcLHtw==
X-Received: by 2002:a05:690c:67c7:b0:6ec:b10a:22a4 with SMTP id 00721157ae682-6ef37233377mr21660707b3.25.1732692696025;
        Tue, 26 Nov 2024 23:31:36 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451b23f13sm63653876d6.92.2024.11.26.23.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:31:35 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 27 Nov 2024 07:31:29 +0000
Subject: [PATCH] media: uvcvideo: Remove duplicated cap/out code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-uvc-dup-cap-out-v1-1-1bdcad2dabb0@chromium.org>
X-B4-Tracking: v=1; b=H4sIANDKRmcC/x3MPQqAMAxA4auUzAb6IwpeRRxCjZpFS2uLIL27x
 fEb3nshcRROMKkXIhdJcp0NplPgDzp3RlmbwWrbG2NHzMXjmgN6CnjlGwfSzmvDTpODVoXImzz
 /cV5q/QC1uw7UYQAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The *_vid_cap and *_vid_out helpers seem to be identical. Remove all the
duplicated code.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Unless I miss something, cap and out helpers are identical. So there is
no need to duplicate code
---
 drivers/media/usb/uvc/uvc_v4l2.c | 112 ++++++++-------------------------------
 1 file changed, 22 insertions(+), 90 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 97c5407f6603..11ccdaf0269f 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -361,9 +361,11 @@ static int uvc_v4l2_try_format(struct uvc_streaming *stream,
 	return ret;
 }
 
-static int uvc_v4l2_get_format(struct uvc_streaming *stream,
-	struct v4l2_format *fmt)
+static int uvc_ioctl_g_fmt(struct file *file, void *fh,
+			   struct v4l2_format *fmt)
 {
+	struct uvc_fh *handle = fh;
+	struct uvc_streaming *stream = handle->stream;
 	const struct uvc_format *format;
 	const struct uvc_frame *frame;
 	int ret = 0;
@@ -395,9 +397,11 @@ static int uvc_v4l2_get_format(struct uvc_streaming *stream,
 	return ret;
 }
 
-static int uvc_v4l2_set_format(struct uvc_streaming *stream,
-	struct v4l2_format *fmt)
+static int uvc_ioctl_s_fmt(struct file *file, void *fh,
+			   struct v4l2_format *fmt)
 {
+	struct uvc_fh *handle = fh;
+	struct uvc_streaming *stream = handle->stream;
 	struct uvc_streaming_control probe;
 	const struct uvc_format *format;
 	const struct uvc_frame *frame;
@@ -685,11 +689,13 @@ static int uvc_ioctl_querycap(struct file *file, void *fh,
 	return 0;
 }
 
-static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
+static int uvc_ioctl_enum_fmt(struct file *file, void *fh,
 			      struct v4l2_fmtdesc *fmt)
 {
-	const struct uvc_format *format;
+	struct uvc_fh *handle = fh;
+	struct uvc_streaming *stream = handle->stream;
 	enum v4l2_buf_type type = fmt->type;
+	const struct uvc_format *format;
 	u32 index = fmt->index;
 
 	if (fmt->type != stream->type || fmt->index >= stream->nformats)
@@ -707,82 +713,8 @@ static int uvc_ioctl_enum_fmt(struct uvc_streaming *stream,
 	return 0;
 }
 
-static int uvc_ioctl_enum_fmt_vid_cap(struct file *file, void *fh,
-				      struct v4l2_fmtdesc *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-
-	return uvc_ioctl_enum_fmt(stream, fmt);
-}
-
-static int uvc_ioctl_enum_fmt_vid_out(struct file *file, void *fh,
-				      struct v4l2_fmtdesc *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-
-	return uvc_ioctl_enum_fmt(stream, fmt);
-}
-
-static int uvc_ioctl_g_fmt_vid_cap(struct file *file, void *fh,
-				   struct v4l2_format *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-
-	return uvc_v4l2_get_format(stream, fmt);
-}
-
-static int uvc_ioctl_g_fmt_vid_out(struct file *file, void *fh,
-				   struct v4l2_format *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-
-	return uvc_v4l2_get_format(stream, fmt);
-}
-
-static int uvc_ioctl_s_fmt_vid_cap(struct file *file, void *fh,
-				   struct v4l2_format *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-	int ret;
-
-	ret = uvc_acquire_privileges(handle);
-	if (ret < 0)
-		return ret;
-
-	return uvc_v4l2_set_format(stream, fmt);
-}
-
-static int uvc_ioctl_s_fmt_vid_out(struct file *file, void *fh,
-				   struct v4l2_format *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-	int ret;
-
-	ret = uvc_acquire_privileges(handle);
-	if (ret < 0)
-		return ret;
-
-	return uvc_v4l2_set_format(stream, fmt);
-}
-
-static int uvc_ioctl_try_fmt_vid_cap(struct file *file, void *fh,
-				     struct v4l2_format *fmt)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_streaming *stream = handle->stream;
-	struct uvc_streaming_control probe;
-
-	return uvc_v4l2_try_format(stream, fmt, &probe, NULL, NULL);
-}
-
-static int uvc_ioctl_try_fmt_vid_out(struct file *file, void *fh,
-				     struct v4l2_format *fmt)
+static int uvc_ioctl_try_fmt(struct file *file, void *fh,
+			     struct v4l2_format *fmt)
 {
 	struct uvc_fh *handle = fh;
 	struct uvc_streaming *stream = handle->stream;
@@ -1544,14 +1476,14 @@ static unsigned long uvc_v4l2_get_unmapped_area(struct file *file,
 
 const struct v4l2_ioctl_ops uvc_ioctl_ops = {
 	.vidioc_querycap = uvc_ioctl_querycap,
-	.vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt_vid_cap,
-	.vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt_vid_out,
-	.vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt_vid_cap,
-	.vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt_vid_out,
-	.vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt_vid_cap,
-	.vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt_vid_out,
-	.vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt_vid_cap,
-	.vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt_vid_out,
+	.vidioc_enum_fmt_vid_cap = uvc_ioctl_enum_fmt,
+	.vidioc_enum_fmt_vid_out = uvc_ioctl_enum_fmt,
+	.vidioc_g_fmt_vid_cap = uvc_ioctl_g_fmt,
+	.vidioc_g_fmt_vid_out = uvc_ioctl_g_fmt,
+	.vidioc_s_fmt_vid_cap = uvc_ioctl_s_fmt,
+	.vidioc_s_fmt_vid_out = uvc_ioctl_s_fmt,
+	.vidioc_try_fmt_vid_cap = uvc_ioctl_try_fmt,
+	.vidioc_try_fmt_vid_out = uvc_ioctl_try_fmt,
 	.vidioc_reqbufs = uvc_ioctl_reqbufs,
 	.vidioc_querybuf = uvc_ioctl_querybuf,
 	.vidioc_qbuf = uvc_ioctl_qbuf,

---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-dup-cap-out-6a03c01e30a3

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


