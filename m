Return-Path: <linux-kernel+bounces-439195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC349EAC16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135A228E6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FC2210F74;
	Tue, 10 Dec 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Md16N89N"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0C2080FB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822944; cv=none; b=XtS1miRhXnJj3FAytdQjoeACdzGmMbSEXECwes/4gdcPfVZXuGafwZjAFTRbv2OYjEQFYorsS68ar/hFefpFtjK0DeCZ4od3yugdfBUH/TYnuDdjcQd6umrqNZ4cxC342IRhGXNC4PNrC+hC+/QSymjmRiAjhWBlNMaHJJW1+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822944; c=relaxed/simple;
	bh=cG4VxhpXxhG3TuQZqSRn1AJUQpiLuYKfsrXFh17x05g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVsHqRUVQw3PTZCZMLyqJKuFgV431dcsz9ptFlX5VgDyJW3O8S5XH7mNgOqMzEO5c6Oovm5fgJ6K+zLGyzOraumBJnL9v+RCBEE9eAJDwKbvkZGQEbHz6nOwhA1e5ap6GzjwKJo9LMtlwxEeBCvchnwWuLsIN/FGl/kLatQJGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Md16N89N; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4677230a9ccso12372051cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822942; x=1734427742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSXoybomn/ykxqyK2CoWexEZQMj81DftjVpdQUWPaP4=;
        b=Md16N89NGtmK0ZxXTjFBSgDYavnpTkjn9RmZhDR2QCINT8cVqM0eQXv078Saz6r66G
         Cx+tHWGvxsiGcxPaI1A/LE3p1ri6IgW3qr5APiPuHteU49uj8ug/NtbbJ0KpQuTHUnEh
         DPstyvfEfqQs5oj3wRBgHSjhf/Fm7h58kVjuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822942; x=1734427742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSXoybomn/ykxqyK2CoWexEZQMj81DftjVpdQUWPaP4=;
        b=wt4gnq7xzJ8Ws7bjwBRN/+n4HHHvnFTQqpux7qla0KAII6qczojmfAdaPHDrQLAhlf
         iFjyaliqodRDPEfRTcZzbxjh2nGgBDYj5lNfDxJAtknTpHVDmusH8XGyY1zvdbEYmjtG
         3lqt+5VcXTSQHYzb2yuuJSvQaxIYjUhJIZYhuHXxPUvqoxZTl1p12x+IUIStaqJZBJpM
         DNDn7kRPcg1B8NLr98Xe0ZROlhtAvOyxuqCjdO30I9S3nV6vMn+iVlOk8guU/RWfqay3
         kPSp1jPcakgDD+1DJlYRCMER33YAiLWkS4aIUNOzKOh/hxxiM2OpChf3zi5xoM+MOF5g
         B18Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUuwvkDnGRQJLW5KcVLI7d4YxB+BdCFuv37h3XCGTvWUBQ0PzvFI2qTW23Aj1q7oWfzWtU2BMG34nIxQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfZdCzNqeU7BUjA70t9Sow1aYgzXT4wdbzuVHjX/h6jwaEorok
	BmBrBrGLhRDis+gKcAi5mDlGmOOAOu7IH/ZVSiYzuQvM8CjHmO+UqH0Dt7YMnQ==
X-Gm-Gg: ASbGncvshIvEhj1SZukyfgjNIQFGl/jfkdba1Z/H00LBx88yHy2dJ9O7KZfVGl6prnu
	5k8tGHqc5z+qVC1kLEYF4QDsNbICblxdptRgTrR96Ga3K6GqcGzZXK/8H/Rm/bNYW9jCkRors15
	GQU0FCOkBfixTPsVHWyyNik+OtPGOGuuiv4FyIjuUG+lKYqb4nXK1ZkyeZMH77amNOObmeVtPV5
	uUchwzqngrdCvyOcaCbDOOMBUbiuvABw+7z/T5RXXR/RajZyhLgY0LjU8zKzEfKsIu9BsW23Dmf
	7qr70VifoEQaqdeITsC5637tsxYu
X-Google-Smtp-Source: AGHT+IHyw4/Sttmns55BK2aFWcYhSEUrFm8lcYTEWfDHCAAYIHWB09gHSf50A3dGLtaNkvGDK7brMA==
X-Received: by 2002:a05:622a:5588:b0:467:54f4:737b with SMTP id d75a77b69052e-46754f47fcfmr168332111cf.25.1733822942143;
        Tue, 10 Dec 2024 01:29:02 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:29:00 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:52 +0000
Subject: [PATCH v2 08/11] media: v4l2: Remove vidioc_g_ctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-8-c0a33d69f416@chromium.org>
References: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
In-Reply-To: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
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

All the drivers either use the control framework or provide a
vidioc_g_ext_ctrls callback. We can remove this callback.

Thanks for your service!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c   | 2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 --
 include/media/v4l2-ioctl.h           | 4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 5267a0686400..068ee67cd574 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -576,7 +576,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		__set_bit(_IOC_NR(VIDIOC_QUERYCTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
-	if (vdev->ctrl_handler || ops->vidioc_g_ctrl || ops->vidioc_g_ext_ctrls)
+	if (vdev->ctrl_handler || ops->vidioc_g_ext_ctrls)
 		__set_bit(_IOC_NR(VIDIOC_G_CTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_s_ctrl || ops->vidioc_s_ext_ctrls)
 		__set_bit(_IOC_NR(VIDIOC_S_CTRL), valid_ioctls);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index f512d62ab0c6..03a62fa960b6 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2378,8 +2378,6 @@ static int v4l_g_ctrl(const struct v4l2_ioctl_ops *ops,
 		return v4l2_g_ctrl(vfh->ctrl_handler, p);
 	if (vfd->ctrl_handler)
 		return v4l2_g_ctrl(vfd->ctrl_handler, p);
-	if (ops->vidioc_g_ctrl)
-		return ops->vidioc_g_ctrl(file, fh, p);
 	if (ops->vidioc_g_ext_ctrls == NULL)
 		return -ENOTTY;
 
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index 013996c33a9e..4d69128023f8 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -195,8 +195,6 @@ struct v4l2_fh;
  *	:ref:`VIDIOC_S_OUTPUT <vidioc_g_output>` ioctl
  * @vidioc_query_ext_ctrl: pointer to the function that implements
  *	:ref:`VIDIOC_QUERY_EXT_CTRL <vidioc_queryctrl>` ioctl
- * @vidioc_g_ctrl: pointer to the function that implements
- *	:ref:`VIDIOC_G_CTRL <vidioc_g_ctrl>` ioctl
  * @vidioc_s_ctrl: pointer to the function that implements
  *	:ref:`VIDIOC_S_CTRL <vidioc_g_ctrl>` ioctl
  * @vidioc_g_ext_ctrls: pointer to the function that implements
@@ -461,8 +459,6 @@ struct v4l2_ioctl_ops {
 		/* Control handling */
 	int (*vidioc_query_ext_ctrl)(struct file *file, void *fh,
 				     struct v4l2_query_ext_ctrl *a);
-	int (*vidioc_g_ctrl)(struct file *file, void *fh,
-			     struct v4l2_control *a);
 	int (*vidioc_s_ctrl)(struct file *file, void *fh,
 			     struct v4l2_control *a);
 	int (*vidioc_g_ext_ctrls)(struct file *file, void *fh,

-- 
2.47.0.338.g60cca15819-goog


