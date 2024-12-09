Return-Path: <linux-kernel+bounces-438302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0E59E9F84
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0212281D88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89C19DFA7;
	Mon,  9 Dec 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGur48/o"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131819CC1F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772345; cv=none; b=pM7tQKEeezginPDUTWE3wDwX100ExuDJXAsyLUu9fKbIld45s/mEPpzYakamxg8gmF2qBRpkrz/VMIoWHgs3DkP3wFpvLrzsfask2SbMgzZ6p8uEQ+FjLPces4H8DxUXctjcI5+LD0BHIE3mYuHhuZEdEXl/QxWJNvCckVe5j3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772345; c=relaxed/simple;
	bh=YVfCDMG+ewVwUxyDDbbSOUAdz+veaEMx7LKaz5GBLvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LImj0TWBqNyGR1E0NA1gzni1zQk5D1flbTXJfCrbdmCiHnWxnhWGFo75DArp2PNCarYo4+udY3W1HRuJmnM6p86uHUc/e9zPm/fczJgCUCuORxrwVgNyVIDTLqPgnLyC+gyVUtvmGwRNl5VCSBYOMVMm6CSt89wyyblwVr/o2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UGur48/o; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b6d6fe8b16so98090385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772343; x=1734377143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2k1H7nZ6EFiaX0ZIjONbwuF9mUJ/0XMhcmQKMZ+rwA=;
        b=UGur48/ozXYn0XUNvTuW8/Z0MIoh8wjLTbHOlPf57pyiN/ifs6VG8YP5cmqNzhhwKL
         8n0kabYc0ADcrqNCo/IpJbyKSpasFP90PxKGRoaVaOieWY8njQsmXEhvoTH55DneoxM9
         ZQRWOoJJokP5fSef33mBXg8o5Qhg4IVuUf4Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772343; x=1734377143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2k1H7nZ6EFiaX0ZIjONbwuF9mUJ/0XMhcmQKMZ+rwA=;
        b=L7tqEHRg/HZC0rj0jaHNyCBOpy9ROg6qc6ikPHwK0B4VR/V7IX3rs/FFNLWXPe8lxA
         V0L7lOGlI29hqe21mJYPvfRfuAb/xrAwnqonSTJpjoavoSL+c+3D+ju+v08tGM/5DWlo
         /irCT5gnpgVwrPQIKrqzrPoB1I7Q/yu0Tl0XoIn1YO1989UMjEvFYn4AKpV17UVZFl2Q
         +S4dH5Bn3g6RkqvLAik25pcSHNxqO1vO9gay+mJS0+KUbukExcA/UYnhOMz6L7S6FNwO
         tlaX//SEcSQaIHQBBjWlA8e8/ni4e6GxyUnVT+I1RO7XiAyJOOqZKoW1r0yB49epZIGb
         W3lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSus1JHqcsdF/L306rSsk/matVjZ0RNNevpB0szySFZyQfYwfpQaExGYfVGDf3hwF9WkDqq97tGUdw8Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFhrziQMiwst9GOpABGJ/bFL1EdsmUos8D/3b3Jstk0EE8M5gL
	UuAEUQAxnwUjRVAGLH4KqXS5AM6qg1mbRZ0QuF/dRgyIBkntbUU0AeFTiqiBjA==
X-Gm-Gg: ASbGncvB5Uwx1U+shHE5AKjWByTeqJIXQdErt+T3+g/EORenpdhWfsLts01JFEkUEig
	qypbthxH5t25wmF34w8/NWfNBv43WQc1KfcZ0VifMneX6J8M1rp7mMwl6bcHITkC1Nj0WvWeGpf
	hCJ2lbrJt1sJ/6aKkc95JtFepCASZz51pldlv1GbGTs0ehymqM1mPfGYRPo7nacB4VAXd4Jm49P
	sUDFFZjK33VGlMBuluTrw6aUhyAHjzw7LPXiPUCIboq8BtuSD6FeXJ5KNVrE/2/qwvuljClVmff
	8Pj/xLJms+Y1Mfyycmob888G
X-Google-Smtp-Source: AGHT+IEEiNvdKrQR0ZlgT/dI9fWuGcmjgZ2kgyinLriV9vaeViM47DQlUbu8twZBqoLXdUvISKJmXQ==
X-Received: by 2002:a05:620a:1918:b0:7b1:48ff:6b3c with SMTP id af79cd13be357-7b6dcdfe7c9mr246350985a.16.1733772342811;
        Mon, 09 Dec 2024 11:25:42 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:42 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:40 +0000
Subject: [PATCH 09/10] media: cx231xx: Replace s_ctrl with s_ext_ctrls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-9-deff7acfcdcb@chromium.org>
References: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
In-Reply-To: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The v4l2 ioctl framework can provide support for s_ctrl. This the last
driver implementing s_ctrl.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/cx231xx/cx231xx-417.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index a4a9781328c5..3c1941709ebf 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1538,17 +1538,24 @@ static int vidioc_s_std(struct file *file, void *priv, v4l2_std_id id)
 	return 0;
 }
 
-static int vidioc_s_ctrl(struct file *file, void *priv,
-				struct v4l2_control *ctl)
+static int cx231xx_s_ext_ctrls(struct file *file, void *priv,
+			       struct v4l2_ext_controls *ctls)
 {
 	struct cx231xx *dev = video_drvdata(file);
+	struct v4l2_control ctl;
 	struct v4l2_subdev *sd;
+	unsigned int i;
 
-	dprintk(3, "enter vidioc_s_ctrl()\n");
+	dprintk(3, "enter vidioc_s_ext_ctrl()\n");
 	/* Update the A/V core */
-	v4l2_device_for_each_subdev(sd, &dev->v4l2_dev)
-		v4l2_s_ctrl(NULL, sd->ctrl_handler, ctl);
-	dprintk(3, "exit vidioc_s_ctrl()\n");
+	for (i = 0; i < ctls->count; i++) {
+		ctl.id = ctls->controls[i].id;
+		ctl.value = ctls->controls[i].value;
+		v4l2_device_for_each_subdev(sd, &dev->v4l2_dev)
+			v4l2_s_ctrl(NULL, sd->ctrl_handler, &ctl);
+		ctls->controls[i].value = ctl.value;
+	}
+	dprintk(3, "exit vidioc_s_ext_ctrl()\n");
 	return 0;
 }
 
@@ -1627,7 +1634,7 @@ static const struct v4l2_ioctl_ops mpeg_ioctl_ops = {
 	.vidioc_enum_input	 = cx231xx_enum_input,
 	.vidioc_g_input		 = cx231xx_g_input,
 	.vidioc_s_input		 = cx231xx_s_input,
-	.vidioc_s_ctrl		 = vidioc_s_ctrl,
+	.vidioc_s_ext_ctrls	 = cx231xx_s_ext_ctrls,
 	.vidioc_g_pixelaspect	 = vidioc_g_pixelaspect,
 	.vidioc_g_selection	 = vidioc_g_selection,
 	.vidioc_querycap	 = cx231xx_querycap,

-- 
2.47.0.338.g60cca15819-goog


