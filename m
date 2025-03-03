Return-Path: <linux-kernel+bounces-542639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968CA4CBD3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075993A9F70
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFB236A62;
	Mon,  3 Mar 2025 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWTopqml"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F29233132
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029227; cv=none; b=kONA21OSVUlaNfVBOCLN/TutWdMIGWzHU8PPJE61Pf7DuwIMptetpVfcX4/upiSJIBju+97Z0YF9dR0lcKoem8KRg5hCCgUaNUlFNiRwc3vgQLiaB4h4v5HzDv46vLDLoJtCmZmrJcgeCzCPcvt6FGLkeguRJPWJ+reI+3DqTU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029227; c=relaxed/simple;
	bh=oZxC6dyJCosOIF+mgQG382FfCTLvK7fHEuNpSTlA6/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVLOett3/gNaHm+VBS3vx+jbZqs2GeaqqDm/mWF8F/P5tT5JDhk7NhxBxgrvXMGu4g/4xz4O+NZJWvcrk4sn8+G5Czla00AZGfBjajWav/iIx66SB0QQnvKLG0o+TgnFMHQDLGY9gHCsQRhHgXs1R6ix6P73OGFf02F6bS6Ogqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EWTopqml; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e88983cedaso37546626d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 11:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741029224; x=1741634024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lRCIFV1ZgaG5znhFrv01vJjvvWfbVwJPIuxC5a3io7I=;
        b=EWTopqmlbY9FaKgfpik1ZkCDucRQHrO5KF4yyGERUbhLr3nYCTscIB7JoYL87jL95F
         9SsGzrgsudO9rW4sqEXdWEkJ5ue+hUb+LB1+NhymPvBw8psYfyTXBBeKt0cEqWzsUJm8
         3WB9GiXVEZXFT8rlK7LXH8kXOgKRpq4NaOPwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741029224; x=1741634024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRCIFV1ZgaG5znhFrv01vJjvvWfbVwJPIuxC5a3io7I=;
        b=tdD7ggK71QuliIa08RfuU2HR2VeOsaTuu/0FGrmSNw+s8XcywvBoBtML47hNPWK0WE
         sOi0T4ZpqfPAbrcjcRqngdk6/jpfVf6/83lqJeSs2mfoUtYTuuhbgy1VjmnREq0j9Jjz
         eiv5yoUT60TyA7dQ7/GPr+i/B7EBN+iG3TdXvjC646GbhzQeAm7N1Vq+H4pdY4+kPbO+
         yiSnvY8Hyjz7yPJS4AQ2YL777matrcQl063InB8XHPP/ALyAa8l6UmEfVzjqwqtHd2Uf
         05S2PvYBPAIfkEIy94rYPH7hNPZkN1d85lGWNGL+4ETK9OVhNiUDQgcmwIzQ+HZOhMEy
         aWBw==
X-Forwarded-Encrypted: i=1; AJvYcCUST2ijDspjQEpVTLcMdnQyF7b6yVXAyysAc4C3CXCncvJfMgkKxf0WDXzKFswMLFMWHxI7GNGORtbVgvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTGYwVM2jk7D1t5/3Ky0HKTIZtf/D7qdIsENgj0IgPdPMGd5e
	VrRinzrUn5kzliSqBR6+E8+68wOadXEn0yaT1V8MSflXX6HdJxc4VfTdfqi5AQ==
X-Gm-Gg: ASbGncuLm/67ZykFALpV4Tq0nU5ohwiRcjmMdQc23sTLCKQFbwKIVtsXKh7WuNSOG0d
	2qni8h7EIKhf3C6iPBOvUOqrK7XmXNYRuVFuuuQA4IylKCTwtPTiOEQlv8OXAbk7Nb9u93bJ2B5
	6GePndI41EvPvYp2BtzokS1Uiha8A7hKTubuFsMFarA8tDLl9BJrpnQV3K/7TwOJjD1h2o83Ggz
	OVxNoP0oMbbaiEv9VhET5ueFjAAkAh9yUSFNGJ/wFsmqBk5sgayFwJ/I+RCyW4DkKc6l/QZXSri
	aGUtMox4hJcvycLdG5UGwLwDGz9+orFlYrfdOiOfmm6TTnOeEGjLSIKblVUZtu4WM3u4E1b8dVz
	BVGbOq5E4PPodKlKV7/qWAw==
X-Google-Smtp-Source: AGHT+IGgAMhBvpb4nsGeXahyeU7QvHudr2zB0sMWGj7GvAH27b8oGyIO1P2rU2HrJVT6CCDwg9nu2g==
X-Received: by 2002:a05:6214:1c0c:b0:6e8:96aa:6034 with SMTP id 6a1803df08f44-6e8a0c888d7mr226692286d6.3.1741029224267;
        Mon, 03 Mar 2025 11:13:44 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474e0f1e0c1sm19745661cf.47.2025.03.03.11.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:13:43 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 03 Mar 2025 19:13:39 +0000
Subject: [PATCH v5 2/5] media: uvcvideo: Create uvc_pm_(get|put) functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-uvc-granpower-ng-v5-2-a3dfbe29fe91@chromium.org>
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

Most of the times that we have to call uvc_status_(get|put) we need to
call the usb_autopm_ functions.

Create a new pair of functions that automate this for us. This
simplifies the current code and future PM changes in the driver.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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
2.48.1.711.g2feabab25a-goog


