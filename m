Return-Path: <linux-kernel+bounces-438301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF699E9F83
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81F91884D81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5519DF77;
	Mon,  9 Dec 2024 19:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAyzBA/y"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B16B199EAF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772345; cv=none; b=kbbWFHtO0h4l/CWSx1aeY49kKubz9TKaElMJQJDIs2AlkCeA/MPRZ7/CsAfXwNw7uIPpmAUsIacveicBtarVxgYgNkL4S5HylBRi5V5A5oLI/eLw9MhzCoYnIDjzKZviIpoumX/Z6+i+YipvFd8EWtaW6lHm5hOTCoaNjo1v+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772345; c=relaxed/simple;
	bh=3YJ9Y+ZQdC2SGtqO8a01crBHDOxCq7X/DFwMMUL8kxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTP2jfiPzLLVP0Qmq3JnTPxKdgMuuJr07V0A0GH+sJF8tHlPpT7pu6yGiEyGZA1lZZE09AB9IU8ztfwjw5qg9AxmLyqjLdF3htZySGdCFd3V8B8odOyA1LVeIFxG1jn/Xf9BbFT2hMAf5bMRqmly2xQ8xadzSdyEk3fe0+ErVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JAyzBA/y; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b15467f383so415487385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772342; x=1734377142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTWHjAR4u8Qk/v839F4GfzYW0oIRDw0e+cKCRcE0Tyo=;
        b=JAyzBA/ym+POLRyoUuP/5p+7uDsR9LvgdICoevXVoh9lUiXnI3VtN/Dv+21TTDDpai
         QUb+odFOe5SxIXD23+OAB2ybX/StIqpSH3ZsWWA2LlqgbIi+gPvjV3mGuNtV5s19Q+xa
         MhG+nJGF+QqUlwOrUd53NL9vBQJWQgNRDiQvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772342; x=1734377142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTWHjAR4u8Qk/v839F4GfzYW0oIRDw0e+cKCRcE0Tyo=;
        b=jE4WZ/+zM7LssBF1/TZZ2uiXxDvrMLZWz04pyf7LDj1mg8rPfBACorUzgwnoAi0jWP
         DTjHF6ny/tdyKcWgYGiIOtIR8AZEC9MJjY/qEZSba+mFdk0vUupKB40MCtL9m8kq+yaG
         2fJeb8Jg6XyFiEAFMOZCNVVUKydtxnZj+ErWoWcDle6ZCv4CPN4tUgOegRGtIjR4YOjL
         B7L+btn6mvbqiz7gAiR4nY5Odg9ImcbwJxV0vcX7PuPA/fldizfIm/IYiP3ctFCGHCAe
         lIi+mBhRZLzwgvP0jFnJQqiMdDSmoDOE+W0D7aLTjGIKw9nuqNKv7B/fuXZHQL+s4/VI
         BmXA==
X-Forwarded-Encrypted: i=1; AJvYcCX/aNc2TkOY/Bx7kn9TgS5GwXt19CWA3ICzwxDjk069NTM/xxz9MAGjnTKsPps/FlzqGxLOaxpn5Hst92Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDxoSNwJmzxmA+sXUynurzT2m6V2mfc0E0xcMmgpzELKKqWyO
	9WavifOX2PuMAlt4E2lk22Jzj0bFUJgHXnxh1Y2JV47p0WagI8xj0bPr3Opfmg==
X-Gm-Gg: ASbGncuruSezFr8soz4aoUmAtRcSA8vm2JOPtcU7ti4tbCb5c/0EjrVVAffvR2Qc3rB
	ntmij0vkN8jvgI6JlTO5+eLZ1Sp3wN7lvT6Li6FYeFm+tjSvdVX/MuXs25eq76A+gNC69mJnVzv
	5JXEJ0IzTipXIY2wNsI4ub+uFs0b/AmF9bouWNtpAgjcrvdeLGDPUWn2t0BzJPqDcRvweSJfkaA
	0yOq5XiMEt5KiBBs+Fy9GncdxoSTWcK4rvTjGLqWKvbatsWNDDUSi6sxC286pkfHIxmJZtEQA36
	iW5zGBtKJctmaq8Q5gP+c47w
X-Google-Smtp-Source: AGHT+IFX2iboYasZ2NAJeqVx58Ze6o0VlnPHCW1gi9xbgB3BYBf0YbNtsWkaDTB0PiB/STP6px6iRg==
X-Received: by 2002:a05:620a:458e:b0:7b1:4d3b:d618 with SMTP id af79cd13be357-7b6dcea6f83mr267761985a.57.1733772342090;
        Mon, 09 Dec 2024 11:25:42 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:41 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:39 +0000
Subject: [PATCH 08/10] media: v4l2: Remove vidioc_g_ctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-8-deff7acfcdcb@chromium.org>
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
index 30e32ce5278f..4e65d50bef27 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2363,8 +2363,6 @@ static int v4l_g_ctrl(const struct v4l2_ioctl_ops *ops,
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


