Return-Path: <linux-kernel+bounces-527911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2102CA41134
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6090D1890DD6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972020E702;
	Sun, 23 Feb 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1bQxXoL"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526A420E037
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337179; cv=none; b=SQ0lwj8ze8CN6UKa35+EetngqZ9iZMnbMtvickJbZklfKKc3e8JCSek+baUetb80aG8vf1HHkpVGUEjqFdFUztbjBlJ0dPjoUGxCwewFyCwDCZO4jUQ7tIWgRqW9p0JICwu/XHxThoJ+44A5VTd6ECRqQtxQ64JCKa2m7qaiu8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337179; c=relaxed/simple;
	bh=xXpFiA/NyUpbzOvlTbdhsbIOHNibM6ftIRafynCnP+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=neGfMMRM/4T3Fk8K/qysqWGaM8I+0xhU2+T6GPkLkGWEJKvzPiRIGeNQ3qoVb6hUBjq0/uPUd1wTk2Lwg6I3ilpl9qBf9aGuMZTwNZFO5u9MPOkF8YiHvgp5kLlioe4LbxIjdMk+htprsnlkWpXPBpJMippVwoNWrxGrrr0WkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L1bQxXoL; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-471f2e1bea9so37231321cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337177; x=1740941977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iyWdZqEotC84XlO1OAQy2WGSlw/iOHY1m4U05QqJMk=;
        b=L1bQxXoLt2OtRdRHXyaQPEmo2MINA6Zg9ZFb3/iKlX9xOfCpAh/23q/FU/ZTMwtylx
         LOQ4G1n3csGuaqvZJ+qXylJezC8oG9eZsDigh+nnhgX4tMzL8KuPuC+K9sZzb6Jx3DBB
         3uZn/idSkZ/5Q7Qzq/Hkf92p8S1rudjutMxfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337177; x=1740941977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/iyWdZqEotC84XlO1OAQy2WGSlw/iOHY1m4U05QqJMk=;
        b=d6VsDB2eBIFXKS8ASMyUxkx/EPFAwSByUT2885U7h5MR3c11vtsp//yqkiKHzIFl3O
         30U2fkt5gBOnjSy8Q9N7Q6zRnK0XQ97sNnzEzY2w5zIa0YIHJxLyG/SLP6hE0m2iem8c
         KWNAZRdLCI0u2n5lYWQSmZrTmhONLHGJ5We6s9eSgFhiz3j/I6eKEdPjwI0DMQrtgitB
         PULs7F4fdgZvWEgeNRxZeLaP60qxSuqu4f5q6ubwvBzYaDZeGFKa03T/w/CJfsBBLsrk
         k0a+nHQ+/yl4pMaSsYNeUvkH6qEyhr4aCge1RQVdn8q5xkMe07r2oLoWcI4FCGoF4Ad2
         DJBw==
X-Forwarded-Encrypted: i=1; AJvYcCUu+njTrxI3tigxuFiFvAYP+biAGVdIsh69IPdtaLuOAywMStH+RUJxIv37krWyMsMli+A5+CzT+BSPXis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1UTWDdgT38DyvgWwHZPxXRqxD00/p2Wp2z5ikRLbGcIdfCI5
	HG8do/+jjl09cDZJt8ADx9FN90XDAdy/A+ij3c4sCItcCf/uk7LMgjwLthIusw==
X-Gm-Gg: ASbGncvItTNShX+yTCbxK18DzW5W8BouV5oYzQIhqw3Bc7dCWbUqQoDa9y8AX4mAM3H
	UH9LSFCKd5M3xtYjCt8b1p8Jv40Pg9SxuTW1IBt8EUz3ZEcGGqACL/ceyKWzhAOU0ZqFSFwzBJt
	OEd0I07B4w4F3S86bQ+BHrMXF5OWYeNtaeGDxF/qDFpaBzlZsMxBVl5mIZWFHGuhaTxlIOR/HNa
	uSSlgdbLjuxKU5V8QVFK7RrcfuAMEcRkxNKecOFn4y0eEX/R2ApMs6GaeRKM0IH6E6CksF6FgHc
	z/uXhjOkEXCxx8MiBZ9HG8UqKW+yT01cWuZfINnJONHMF4LPXKBrtOVcMTiXr26O+4ih7ztw1hc
	LI8Q=
X-Google-Smtp-Source: AGHT+IFmA5F6ZvDlLt6gf9is1F56bMr6yT4/exI4Bz1fcJqcD+qyUMAxAufOoGLCX4weML9wR0ltAg==
X-Received: by 2002:a05:6214:daf:b0:6e4:4331:aad9 with SMTP id 6a1803df08f44-6e6ae7c96e2mr137768826d6.2.1740337177325;
        Sun, 23 Feb 2025 10:59:37 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:36 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:11 +0000
Subject: [PATCH v3 08/12] media: v4l2: Remove vidioc_g_ctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-8-4292911cab6b@chromium.org>
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
index 48ddeb01e70a..d6af0ab0d7ea 100644
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
2.48.1.601.g30ceb7b040-goog


