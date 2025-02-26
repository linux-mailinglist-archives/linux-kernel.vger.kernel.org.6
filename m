Return-Path: <linux-kernel+bounces-534085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7604DA4629F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041AE3B18A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38831227E89;
	Wed, 26 Feb 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VlTu6iqz"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0AB22173E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579814; cv=none; b=JEvfopKVCUuAP8xJJdV7QsvRua/aYjBtFkWRgojgLataFgKNVnLRXUjX0+QuCqC5yyKvDA36Jt0qPDvMaReAog09OVe+43pDecvX3O8BdefhOkiRCrf1ZmOTkEb0XZNAw0MWhNB+YW8LPuMSGEk6nkUxN1MRh2x/Eh+JMvwf78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579814; c=relaxed/simple;
	bh=71qURUpKQyHqhn8hHrbpIZhkr9HtzexcGmxJCr00cjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ey6iDClDVLTd3sFivI0j8IhFW4KeK6FoxZ8IILwdTdjbPVTEKsBsdWTBoBnAhMPz/gNx753vQ8re+6ewq7NaiY1kPUrNJ09QTIBj2ZzF9Hi9TL5KXQAJwaD32QVRmfNc7BPD9SChMAKr9Ia1mWTGyBWgV+hsZ9yqlqCoOB4YcgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VlTu6iqz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c24ae82de4so53671985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740579812; x=1741184612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2vbUd0IkHjhLkq4YLUTxGcYI4X6Kojg8kTGYZFd8GM=;
        b=VlTu6iqzZGlq3ht1GCmuK1OelGevKydVcN2QJdKdOAsETpuWJ3JS5PyJ+K4LM2ffRR
         vSzZmrHPQU/HKIYwtyl2geSKkxVDygtH3ZIIlCvBkfL/xsd1DGrt7OHTsnhMQyq+vE27
         t84hjsJdF9d4grfg6zgPj60bvKDm5Xnmpe2gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579812; x=1741184612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2vbUd0IkHjhLkq4YLUTxGcYI4X6Kojg8kTGYZFd8GM=;
        b=PLzpsWEkHLESs5VIZd8W7jxgqMiYkArTPG2jve8iaf2KdK+H1tQ4/yC+4wqFumYEDo
         DTv5zHIgJNppXE9or+nCeMTVVoRIwivfXFukfpkl4tPCbGxd4Mhj1al0rAZbC/yQYSiQ
         dEcaotiRtVU0SNiexeKzRjIpYIRa/ccFAGwUBV/2h9IGTt7Sqknl/o5iAtqHqZGLj9ed
         dlL8pcyH/ypIlvh7F0VE1Gs4hoSi2xygcnEWzUXYV7KvXTPZnVzBz8uDuB+UfYxrIKSS
         2o20jR4t07K7UGQ7furEpiX5qmmDmjENs8k9BHmHEgjlQXUh5CCcDY01Ce0Dv0SrVDX7
         ERiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5WMhMwTzQ2Uqd5NIJWohRNYjFT1Y/4oB1GDKjJirFbgE/taouo+TdnZpvywNshKVX9uwJVXDY0vSa9mU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSGCpmjehyt7WH8yspgNUG+7x8azt8Ce6X+k9mEBo+LS9K7ct1
	B7W1eiz6ivTLhAJfK4ZLvuRur+oWRJcHCC06Gh7hEKsFkQTwNebiTN1k5ulacA==
X-Gm-Gg: ASbGncsNhg1/WppdF7z7fzafkVuqUctBaQCzt5ZbZu/0Bp+vcDdQsu+q4B7qccBvEMG
	Kqrdaas0wTu1PmqCHp3cwv9v9hVs7fD4o98zAk/ywV+tUYIs2oZEG6fEY1Y7gHqURAz8gJKFe8T
	lKemuW2XOHTzcYa3kBQOntLb5AXkuRs7+tok5wF43/tEKGSJxQhL9PzWEdHbNHQa6atOQMNxjap
	gkxQd+1WkI4wcsQsQ2vbOkncIMVq7QPn+JN86VsjP4fDA9QwMacfy/KHvCL+u5FLOcuTDAdjolE
	u1wP8xC10CE4JxzepHuB8G6Zbq6MoiRv8+vIl/bd2xbh3+jkNV4JFd6ik8JnNbwmkKmeU+JrKv4
	7AXI=
X-Google-Smtp-Source: AGHT+IEIjZIDI9MFFXd5K8qshi0fFF0mSwbprLeHtnyDrbye91YUoOAfrTDjrDmjYqtIPY5GIvRxrQ==
X-Received: by 2002:a05:620a:31a8:b0:7c0:bb3f:e285 with SMTP id af79cd13be357-7c0cf8ce834mr2663166985a.24.1740579811861;
        Wed, 26 Feb 2025 06:23:31 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c33cfb0sm246336085a.103.2025.02.26.06.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:23:30 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 26 Feb 2025 14:23:28 +0000
Subject: [PATCH v4 2/5] media: uvcvideo: Create uvc_pm_(get|put) functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-uvc-granpower-ng-v4-2-3ec9be906048@chromium.org>
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

Most of the times that we have to call uvc_status_(get|put) we need to
call the usb_autopm_ functions.

Create a new pair of functions that automate this for us. This
simplifies the current code and future PM changes in the driver.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 36 ++++++++++++++++++++++++------------
 drivers/media/usb/uvc/uvcvideo.h |  4 ++++
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index f9cd6db759c5..de1e105f7263 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -26,6 +26,27 @@
 
 #include "uvcvideo.h"
 
+int uvc_pm_get(struct uvc_device *dev)
+{
+	int ret;
+
+	ret = usb_autopm_get_interface(dev->intf);
+	if (ret)
+		return ret;
+
+	ret = uvc_status_get(dev);
+	if (ret)
+		usb_autopm_put_interface(dev->intf);
+
+	return ret;
+}
+
+void uvc_pm_put(struct uvc_device *dev)
+{
+	uvc_status_put(dev);
+	usb_autopm_put_interface(dev->intf);
+}
+
 static int uvc_acquire_privileges(struct uvc_fh *handle);
 
 static int uvc_control_add_xu_mapping(struct uvc_video_chain *chain,
@@ -636,20 +657,13 @@ static int uvc_v4l2_open(struct file *file)
 	stream = video_drvdata(file);
 	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
 
-	ret = usb_autopm_get_interface(stream->dev->intf);
-	if (ret < 0)
-		return ret;
-
 	/* Create the device handle. */
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (handle == NULL) {
-		usb_autopm_put_interface(stream->dev->intf);
+	if (!handle)
 		return -ENOMEM;
-	}
 
-	ret = uvc_status_get(stream->dev);
+	ret = uvc_pm_get(stream->dev);
 	if (ret) {
-		usb_autopm_put_interface(stream->dev->intf);
 		kfree(handle);
 		return ret;
 	}
@@ -684,9 +698,7 @@ static int uvc_v4l2_release(struct file *file)
 	kfree(handle);
 	file->private_data = NULL;
 
-	uvc_status_put(stream->dev);
-
-	usb_autopm_put_interface(stream->dev->intf);
+	uvc_pm_put(stream->dev);
 	return 0;
 }
 
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index bc87e1f2c669..fbe3649c7cd6 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -763,6 +763,10 @@ void uvc_status_suspend(struct uvc_device *dev);
 int uvc_status_get(struct uvc_device *dev);
 void uvc_status_put(struct uvc_device *dev);
 
+/* PM */
+int uvc_pm_get(struct uvc_device *dev);
+void uvc_pm_put(struct uvc_device *dev);
+
 /* Controls */
 extern const struct v4l2_subscribed_event_ops uvc_ctrl_sub_ev_ops;
 

-- 
2.48.1.658.g4767266eb4-goog


