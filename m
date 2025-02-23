Return-Path: <linux-kernel+bounces-527913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E579CA4113C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715A01767EB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170120FA9A;
	Sun, 23 Feb 2025 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oVcWpjyj"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0CD1991DB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337184; cv=none; b=ceus/DrhOWJpyMJ/qhh/Qxv46Ub2P5zC9ln9EJN5Vvj0QSNKkjXq755JPjfC5y9tgSTna/h7J8s8VknRoLlqUx4XZA1fJeuoDRWXqEgJKP8cx8qH1kDIo8DtNBDbWZqgPfvGuflVKe+xqtPKrFwBkZD+4bhk0lC1MeSaJI/B7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337184; c=relaxed/simple;
	bh=R+jYJua/JoNmJtSkvaDUD0DjudTsHKGGp3KP+h8MO+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5z7p9yd+57aylAoiO1WOtStPtCpRjFvNX2EdmpHxStcS9aVESW6CdGyroBYCXGK7aCnxwerioX8Tx2R5dqzafE7fd/Iw7GucE59XPqefm90O25nTDGIPLYy3G8xry1ZKeVYIaghZP3rBqY8F6XN6Kce4pqYxe/i1ySIVFHkJ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oVcWpjyj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c0ade6036aso474947985a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337182; x=1740941982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTHD0WBrVxKMoHAJFWLjBpuZYRSXtcELoY8iTxveD40=;
        b=oVcWpjyjRoujNzYd/fWacYd9WSR4WUuEELJXzBAkBGTi6lx/H2Nhd9H4lbYV/KPTBp
         bnEDUt5tmpD/x42YXopOIIRULNqYyR2pe7oPtGdMpzZrNn7FvRwQnPkvb6VTc/BWkeRz
         nbjmTD4Ge29zWLroV35B7CPSA62jOlvjuW6ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337182; x=1740941982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTHD0WBrVxKMoHAJFWLjBpuZYRSXtcELoY8iTxveD40=;
        b=DWieiCh8Wt5DzSu9aFS4rahQ0gYuJymUrTHfcr+qWn9qcdWAWXOegBW08+tZXLKhSa
         Eyo/JOx1fzepMvy1+DKyX6BB6ONYi3hrjv2/w2+qRj1YxSQBLrSIuTTFQDuch+hblLri
         kHOalonKo29T3nPoHKBwc0+zXcrxw+414olxDawFEMq762z7oXPajvcpXFsRajdakg6/
         BIVOGAnrAkNwWVLLsZ6dZnmYdZbu/DW/AeGz2TmL7MUmGZxVelyCOMl4O5ghVAhzHKb3
         CmORyNkUabmqPF/QKkEKa3VRKKIHoo1nGm0lYmYNImu2XUpfOwJJucNEWo03Y1zQBLTB
         8LSA==
X-Forwarded-Encrypted: i=1; AJvYcCW9dgYFXXwslwwiQ/US4yakrgbXI9z7lQ/vEYtvEjOuAaGG9vC4MXxRPW8CdcC/ImuGQkVfsZVoMAv0HDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4VwZLK9BEG2l27gljtnIggbkpInT+zv6BpDb3OfUcMuMRkTxY
	KR0QGRAg9nAvpUUgionv75x1j02bIslxZdTnjwSWwfB+qTDkdMnvYE9JqFuKqA==
X-Gm-Gg: ASbGncuxwaYKQYZDnBxkBjnXWeKoc8LVcaY98uCNIEJzJXKq8EVcmVxFUo1hI9Q5mQO
	lIDB4wUp3IVco0n3y5+dluVH3na6QgHwEr3hR539Bwieh7fEvArjw32iHb5us3rKWl+Vi4uPAil
	nTaVSAiAjZ8dj0lxY/Cm9viN68ux98wtl3j3IK049R1K/7hN7ODjWp2YXLHS/b1/PfKrRD3HQ8S
	IgRSD8LA6vQkDjR2kx4zWtR4koFb+1zmAq37mcCHbXl22VxVNpO/KpVceAjeFRNUrc0ulDNgBQm
	/SUPF3Zjkxjycxi+jrD5s5kSI3KOcGDRe96QICycrJAEKKcaAWkod5AAemSqiL+nVjpdY6kxixF
	SZ70=
X-Google-Smtp-Source: AGHT+IHMMtAKUl1nnqWjm92ELMXJMqaYYhbAnpTq7xf63u5qZkQjjXTU4L/aQ34kAl2TkpYkioCZdA==
X-Received: by 2002:a05:620a:468b:b0:7b6:c324:d3a5 with SMTP id af79cd13be357-7c0c227c7demr1840363085a.19.1740337182001;
        Sun, 23 Feb 2025 10:59:42 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:40 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:13 +0000
Subject: [PATCH v3 10/12] media: v4l2: Remove vidioc_s_ctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-10-4292911cab6b@chromium.org>
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
vidiod_ext_ctrl. We can remove this callback.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c   | 2 +-
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 --
 include/media/v4l2-ioctl.h           | 4 ----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 068ee67cd574..b40c08ce909d 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -578,7 +578,7 @@ static void determine_valid_ioctls(struct video_device *vdev)
 		__set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_g_ext_ctrls)
 		__set_bit(_IOC_NR(VIDIOC_G_CTRL), valid_ioctls);
-	if (vdev->ctrl_handler || ops->vidioc_s_ctrl || ops->vidioc_s_ext_ctrls)
+	if (vdev->ctrl_handler || ops->vidioc_s_ext_ctrls)
 		__set_bit(_IOC_NR(VIDIOC_S_CTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_g_ext_ctrls)
 		__set_bit(_IOC_NR(VIDIOC_G_EXT_CTRLS), valid_ioctls);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index d6af0ab0d7ea..fea53b419351 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2411,8 +2411,6 @@ static int v4l_s_ctrl(const struct v4l2_ioctl_ops *ops,
 		return v4l2_s_ctrl(vfh, vfh->ctrl_handler, p);
 	if (vfd->ctrl_handler)
 		return v4l2_s_ctrl(NULL, vfd->ctrl_handler, p);
-	if (ops->vidioc_s_ctrl)
-		return ops->vidioc_s_ctrl(file, fh, p);
 	if (ops->vidioc_s_ext_ctrls == NULL)
 		return -ENOTTY;
 
diff --git a/include/media/v4l2-ioctl.h b/include/media/v4l2-ioctl.h
index 4d69128023f8..c6ec87e88dfe 100644
--- a/include/media/v4l2-ioctl.h
+++ b/include/media/v4l2-ioctl.h
@@ -195,8 +195,6 @@ struct v4l2_fh;
  *	:ref:`VIDIOC_S_OUTPUT <vidioc_g_output>` ioctl
  * @vidioc_query_ext_ctrl: pointer to the function that implements
  *	:ref:`VIDIOC_QUERY_EXT_CTRL <vidioc_queryctrl>` ioctl
- * @vidioc_s_ctrl: pointer to the function that implements
- *	:ref:`VIDIOC_S_CTRL <vidioc_g_ctrl>` ioctl
  * @vidioc_g_ext_ctrls: pointer to the function that implements
  *	:ref:`VIDIOC_G_EXT_CTRLS <vidioc_g_ext_ctrls>` ioctl
  * @vidioc_s_ext_ctrls: pointer to the function that implements
@@ -459,8 +457,6 @@ struct v4l2_ioctl_ops {
 		/* Control handling */
 	int (*vidioc_query_ext_ctrl)(struct file *file, void *fh,
 				     struct v4l2_query_ext_ctrl *a);
-	int (*vidioc_s_ctrl)(struct file *file, void *fh,
-			     struct v4l2_control *a);
 	int (*vidioc_g_ext_ctrls)(struct file *file, void *fh,
 				  struct v4l2_ext_controls *a);
 	int (*vidioc_s_ext_ctrls)(struct file *file, void *fh,

-- 
2.48.1.601.g30ceb7b040-goog


