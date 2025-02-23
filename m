Return-Path: <linux-kernel+bounces-527910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A92A41132
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D38727AB8EE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80A20E337;
	Sun, 23 Feb 2025 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eS7BxmcT"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7820E011
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337178; cv=none; b=FtFn3Wjo2D3C+E5/WHkP/uNSdjQ8bhvBoJAiE7pf8TRG1AH6UOgNjYJwHiHv60Z7oJj60uqWmyL7y75ay6zY8Mqlxnnc5+B0JgLr3OdAwCUPKepOGN4EjKjhj7tejA5eZv10svjEQjkHirEv9vpmrhEjika1T8GNBCgtbesgYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337178; c=relaxed/simple;
	bh=6eScQ+yILkmrR5/v9Ls6gwtXx6JH8fWeq4Wm72IvMxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L4uNnRl9HzoBL7ons/+yjppVJcCB7e9ONRy4zsxmDLn2CvFkTLput17Yc5Hd4AWBu2MBRvSTLHvmuSXMKHsjYh4768whToFB0CpP2Vh7liteWk5oTf+6p9IunjN1n+Z5rYji9deK3mu9109815RohV2KqYm5NUXsR6v0T3VJ4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eS7BxmcT; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c0b9f35dc7so533694685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337176; x=1740941976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqSkdPwdXz1L9xwrOG1KS2QGCidHxC0xW5jcZHcDLmY=;
        b=eS7BxmcT7MFxFMy8QvB0dLbA0M9nZZCgk6zYXvcIuqS4SFmqv8J5WdQMnJiX2FuJoQ
         sP4UewsEdToJcHo0mpLMZ0/VlObfb5sxbvECEoBczm0vM7aWFp7xyJvkkQq2YSHLZnV2
         3T+7/spu4St5ZStxQTaD6Gwp9cmVRkFUtP+hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337176; x=1740941976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqSkdPwdXz1L9xwrOG1KS2QGCidHxC0xW5jcZHcDLmY=;
        b=W23s9MXtQ5KhxFcDzNO7rpgLrSepp2J1nWxuByKfVzideVqBNnXvxsmxI3IGVoYuB0
         lnjw1OlCpHtA5JaW7ET/XkQEs1mBcGYEUUk8JhtPnf/g+33WjzaLFzj+NnNPKRAYojqO
         RlAFE1NunhJADRoseAo1LlFSvDnVhhn9C5rYFvWvltpZh/yixgaYoR4jCoH6LFwSgyg6
         rArNgT7qLivO14Qd3//K1PRfPkVTqGloUEYNCFnOEkiBIlVb3VGb50MzEbYZCsQwhkI+
         QnNs8Aj7hrRXA5wHmZqVn7X7h8DliYf8U30K7YvmJYX/h7pVAGNuM96PqgzLLJovEvkx
         ik3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFjoQ1ATqrTQYgopkghP2mFuVzYBKi9wbMiTpt+0cXPpXqDTKKR3yU+BYfE9EhZnfI/QRxQFSHdjMz45Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOaMKXGmHCHGHEk/V8PZJPAaBGujF7KJoJFcP1G3g8w2Yed5Fk
	FJes081DS6iEsBOKkzSeHvurWr5IcWZYvOQ4l0B1gzhwvl1Y24FnbUqkFjXIXA==
X-Gm-Gg: ASbGncuGTViTPAzz2a7k+Vw2Ygxqy5/Vacn+UoQDQJ5HtbX8SgUbwEiC+XMjn2RCLgU
	q/T9F1Bh7TUGpHzGHSkhuTpwNigwkon03FGGt/TC/AWaxX8I1XkBonRebuqxH+8n6Tli9y1ByoW
	93AbctlJmI33swFxe0/gOclhoKdiqCppQNV2FfITCXaTQMMK3O3IaHsHb8C/4nxX4Rrs6SDGKkQ
	rIH1vnifpf/e/p2B3PA5qT+1au0fxX/dIInKxlcYMd12TNj9Z6yqHurPQpMRz19wIKDnem55eRQ
	pOA1nIiSO9JQcE2juqW2vrQyMDMgy/PklAMNCjmrBI8Iad418m9z6l7+SroqeMxCTXzTcuqoJJf
	1ADw=
X-Google-Smtp-Source: AGHT+IFnnjBZgIrWZHVi+Chtu9HWxFVqKZWb2RhLpbJR73isjU+nhyv6klkh0PJNTJcvUMHxLxjZcQ==
X-Received: by 2002:a05:620a:2b97:b0:7c0:874f:c87 with SMTP id af79cd13be357-7c0cef6475dmr1731625685a.35.1740337176294;
        Sun, 23 Feb 2025 10:59:36 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:34 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:10 +0000
Subject: [PATCH v3 07/12] media: v4l2: Remove vidioc_queryctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-7-4292911cab6b@chromium.org>
References: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
In-Reply-To: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
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
vidioc_query_ext_ctrl. We can remove this callback to reduce the
temptation of new drivers to implement it.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c   | 3 +--
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 --
 include/media/v4l2-ioctl.h           | 4 ----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 252308a67fa8..5267a0686400 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -572,8 +572,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
 	   and that can't be tested here. If the bit for these control ioctls
 	   is set, then the ioctl is valid. But if it is 0, then it can still
 	   be valid if the filehandle passed the control handler. */
-	if (vdev->ctrl_handler || ops->vidioc_queryctrl ||
-	    ops->vidioc_query_ext_ctrl)
+	if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERYCTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index deed2b44ee18..48ddeb01e70a 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2294,8 +2294,6 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
 		return v4l2_queryctrl(vfh->ctrl_handler, p);
 	if (vfd->ctrl_handler)
 		return v4l2_queryctrl(vfd->ctrl_handler, p);
-	if (ops->vidioc_queryctrl)
-		return ops->vidioc_queryctrl(file, fh, p);
 	if (!ops->vidioc_query_ext_ctrl)
 		return -ENOTTY;
 
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index bdbb7e542321..013996c33a9e 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -193,8 +193,6 @@ struct v4l2_fh;
  *	:ref:`VIDIOC_G_OUTPUT <vidioc_g_output>` ioctl
  * @vidioc_s_output: pointer to the function that implements
  *	:ref:`VIDIOC_S_OUTPUT <vidioc_g_output>` ioctl
- * @vidioc_queryctrl: pointer to the function that implements
- *	:ref:`VIDIOC_QUERYCTRL <vidioc_queryctrl>` ioctl
  * @vidioc_query_ext_ctrl: pointer to the function that implements
  *	:ref:`VIDIOC_QUERY_EXT_CTRL <vidioc_queryctrl>` ioctl
  * @vidioc_g_ctrl: pointer to the function that implements
@@ -461,8 +459,6 @@ struct v4l2_ioctl_ops {
 	int (*vidioc_s_output)(struct file *file, void *fh, unsigned int i);
 
 		/* Control handling */
-	int (*vidioc_queryctrl)(struct file *file, void *fh,
-				struct v4l2_queryctrl *a);
 	int (*vidioc_query_ext_ctrl)(struct file *file, void *fh,
 				     struct v4l2_query_ext_ctrl *a);
 	int (*vidioc_g_ctrl)(struct file *file, void *fh,

-- 
2.48.1.601.g30ceb7b040-goog


