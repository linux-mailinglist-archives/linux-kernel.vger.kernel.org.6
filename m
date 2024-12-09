Return-Path: <linux-kernel+bounces-438300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFD9E9F81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1811882B14
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDF8198A01;
	Mon,  9 Dec 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m/fipHAp"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B919B3EE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772344; cv=none; b=OZ/nB9lJdHUlJFQy1QxEndMnHx7RUztVpoe9zGAIuPpSdINF1y9q6QK6D/BX9/rNqqERUyl5BZePwkn/SjQ6tAG63zOkzYQOeNA8DaVvMjKzvnk8RRAOzGhML33opxLvrpVCBNUq7yH6Zx4CSm+RJwSHylM7z3fCmVMJqmleHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772344; c=relaxed/simple;
	bh=oaCq3lFHUlXWfLBs1yLgfb1pQhfpAzznJwSy1NrE1wY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCLt+rG66IbUxP9eF4+FZIkx2UC7AJz5MtLC7a/0cKub4ocm3CcX9RrP9XVX5MzFon1y2fcSv5sJ7K2lF5oddXZIaIx+Rway6r14fkkHkn6PA0vaQMFjysAzLqORUBReu6jjMoefZAARlUf4xZOTZqdYs6D+MEyZlH0eB2/crKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m/fipHAp; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b676152a86so576765885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772341; x=1734377141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltErOm77Oh5lK6TbfQofWHlLQPTPm1Kvo+0ZzyBQyKQ=;
        b=m/fipHApLRWoXOYh7YusvwGzNf5CW5p+47YbogJlAMIOgzgXaOAdXFkic2X5Rfd02w
         /6cPL/kTauMxSls1e9w1oxjVPObxtFsaM194/hjD5vLQm42XHvbfgJK473TvFh9+yAlm
         RCFjKEq4lJ7twwDPXcwV36++P0ztVg8Y2QYtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772341; x=1734377141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltErOm77Oh5lK6TbfQofWHlLQPTPm1Kvo+0ZzyBQyKQ=;
        b=NM9qne50y3KKVqSqkD9N0TWLFkhro9c3Jc17Na1OJvprwIjgNZJG2VhDHh2G2n56m7
         PvFb2jnT9GBZ3YmQFkEHol3sxbBomD8U39iN8LOrNk5+d99Oar1BdXjjuAgEs8XBZho4
         KCouBKWeAB/mC3CsE8btUaQMKzUXKcGh3Rw+MY8rBAG14Z4lo5XGbV3uU0jz9cpU+nh1
         EX5i3xLJuG77Cr+E+XqJLdLNaE/uLsvgPXrXXqDI1pPG0zZgc7xislhQaqEwq0MIOaT6
         MUvCTO7uMykb0vVWjUiS2b9MM8tNVcbZ2WvUOf5S1lyG6gLhu851PpYWlBU28HO/NCsd
         4wHg==
X-Forwarded-Encrypted: i=1; AJvYcCV2p0AutFyZOhRHEQEvbAZ/LQq4RsEDE7AJY4/e86Q1KdmMGQ+X9ChHDv1/2cKW1E9MHUMxmhx5IqFirvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5SVLus74oTj1QQKRRwUikuusmqgrOuxTg1k3TbC0eEVXdlIrN
	mkK+tETxwJBCyuyBX9Pa9nLBW4LOVyxZi2byHAXj9BDCNEBF/jW7dMc6YhTE/A==
X-Gm-Gg: ASbGncsy+k0rjkTY0Z3sv3myzlRfMxO+xq1sML4isXj/WEz4hs+u/ff31O6Aum0H4Eq
	dv3MJ0MRJIO9QtJgsCMBU7L3GNQf+7DdIBz6aHodcnKQ7qSxx6lNsw6KKKcb3XXNGc9JH0ajM1s
	MAWHYEKl3apqPJsGa2kJL+D40liqL41uNcFxbXKto+di8/gmyUo/3NhclqtA/cuIgqZkJmpgp4H
	ewUHkU5rnXsTP0TGPFl4353P7pVjRqPQAAIqCv41K6SHRcpO4sCdtD7pZ/Ee/cuKHeVyrkLe+NP
	tDCLjSbS5PjWDxTMVUZLEIW1
X-Google-Smtp-Source: AGHT+IEC8fFJCiNRaM0A+A/h+DVBohii9gw561GeeuVFgC5WSmzaiO9D+NgO5W3/1EB4ImZzjjZjKw==
X-Received: by 2002:a05:620a:468f:b0:7b6:d0be:ca31 with SMTP id af79cd13be357-7b6de762d37mr79678685a.25.1733772341402;
        Mon, 09 Dec 2024 11:25:41 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:40 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:38 +0000
Subject: [PATCH 07/10] media: v4l2: Remove vidioc_queryctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-7-deff7acfcdcb@chromium.org>
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
index a5562f2f1fc9..30e32ce5278f 100644
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
2.47.0.338.g60cca15819-goog


