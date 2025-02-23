Return-Path: <linux-kernel+bounces-527904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95848A41126
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77ADD170C25
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10B420B7F2;
	Sun, 23 Feb 2025 18:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVJUnLiY"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB9418FDDB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337166; cv=none; b=cYYmRjd+5dDti3JogfZ9uQOmSozPXCbf7Jq4tXKHj/C62lbrNTMnOKO0Skl40zHp51xUD2/gxFyQsKyeIsUE3rDaXqlw+OmC/hYa0B0ZgjOSZph7/a7S4RSxyHkgfEwxkVIDAY2sKLsXKhELe/HcDzJpxLBNX5US91/ki3p9XIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337166; c=relaxed/simple;
	bh=o5WkpnQ73V+VMo8bdoFaUftuXdW+rujG4ME3lX7eEqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=czqlV7DBnE4eRiyNl2Z4ek+cEt4le3wwhmNb+jrCBAZFpBaTMWtHIKkpr/RRJbGMaDZ6OPx6uUvkNDEYmfNHYNvxcZ5m2sG3wZEIXDHmt2Chc9wTdyXylDxm4CUNV7MzqMSp3K0dSpYNKHEpVdrcQc4Yo5tjBG/wPYK/NZzrlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVJUnLiY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0893f9aa6so343211385a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337163; x=1740941963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgEaj88gwe50jW8BgyaHtEFtSSSTKBTD6iombmDXrgk=;
        b=ZVJUnLiY1GSIP75VooeahuZnuYwRhsVZWXF1VAxDhKZaRwq4FlkUjpy7Uecd6UDGme
         rGNBLSM65Rtzzqi6a6BqTJToyJ9QJXTJlg/wvgCos6T/dEmEwQ/6SFMFYuxQIUSmqe9q
         E9yACB8p2ZyVeOIGAnOv54niodLHiOldbp9to=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337163; x=1740941963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgEaj88gwe50jW8BgyaHtEFtSSSTKBTD6iombmDXrgk=;
        b=udjOX7+Igx+1q5unXObViCniPk77moYNimUWxHYj45+opUt+jIEzPKaE4XeEPIuWDZ
         /EJiLzTn5GaWx3UjZToDqYrmNI482MT6U7jJzLYsY1S4+o40jPCeKDr3sYirUiiUTsuw
         UY1TPD8X/q5RFS1JKv47DGcwvARxFsnx08DONVRvJxojoctH6Sbb8iOqpR8ILgAhDhhI
         hkdq9F6Ay4Ro3hHarDpHYR3kPTzB4SiUMHOxW2SPpnl43eq6U2BzX7JNwyFiumCbt7A9
         OfZ4zxMB5eJru/0T3hCks0nGwjE0+teBDqFreFQElPpnxF4jivrXsV32I75vD6noVpWX
         vx6A==
X-Forwarded-Encrypted: i=1; AJvYcCUNhSq6mlh0lm7g94BKmphqlU6AujAVabsTa8KSBBgmVaCVQukm3z4O2eY4KBQ3vSAfLjnW5fiFrFXNK1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTklnjo6yxg8jE+/+AXozgFFOOsmj+7oB2U1qZWzbKrCdayE6
	TLpiacRmUUkcdNZIgPQNnF30U8WrHIpvy/FJT4Ad2RBTNpb+F5l3XTafhPMX/A==
X-Gm-Gg: ASbGncugJcXvvh2OOyo90WP0ybYCm7mdL8LS9XNXUCQYY0XztQyjJ2n3fCGRflBIiP4
	JA0JJ4C9OwMwMAkRrB5VEER/dPQysTQ89B88DBnDjHrnLvsr6GYDC1fzdmpFR7EwXnw4M2b4G6/
	YMJ2viKu3d9ZWygFUI8LYydEolz+3OTDceDL8kd+TXDhUbgRDfJBRWn/WmUiP+MAqSDpeIfkABV
	ofYd+cyPl4j1GsM5tHGv+4XB87qYuX8y6abn4wqIASx5xjqRAgvGHGOxTjOqbs13jax0hrs5D16
	hWohgQGd3YPGOKrBjF9UKWIUXQDwZwio+FiKgBNIq9hdLA56T1kUKKdKlEdGI4JHn7qeU67LUuy
	z55w=
X-Google-Smtp-Source: AGHT+IHGjRoitg4iizBR56/YqzL9lfxWldkcIk6dKi7DdbK876lHC2pCcmEyx2EPjcz9GSOVicGTRQ==
X-Received: by 2002:a05:620a:1910:b0:7c0:b4f4:1633 with SMTP id af79cd13be357-7c0cf8c6679mr1064156285a.15.1740337163452;
        Sun, 23 Feb 2025 10:59:23 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:22 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:04 +0000
Subject: [PATCH v3 01/12] media: ioctl: Simulate v4l2_queryctrl with
 v4l2_query_ext_ctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-1-4292911cab6b@chromium.org>
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

v4l2_queryctrl is a subset of v4l2_query_ext_ctrl. If the driver does
not implement v4l2_queryctrl we can implement it with
v4l2_query_ext_ctrl.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/v4l2-core/v4l2-dev.c   |  3 ++-
 drivers/media/v4l2-core/v4l2-ioctl.c | 37 +++++++++++++++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index 5bcaeeba4d09..252308a67fa8 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -572,7 +572,8 @@ static void determine_valid_ioctls(struct video_device *vdev)
 	   and that can't be tested here. If the bit for these control ioctls
 	   is set, then the ioctl is valid. But if it is 0, then it can still
 	   be valid if the filehandle passed the control handler. */
-	if (vdev->ctrl_handler || ops->vidioc_queryctrl)
+	if (vdev->ctrl_handler || ops->vidioc_queryctrl ||
+	    ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERYCTRL), valid_ioctls);
 	if (vdev->ctrl_handler || ops->vidioc_query_ext_ctrl)
 		__set_bit(_IOC_NR(VIDIOC_QUERY_EXT_CTRL), valid_ioctls);
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 0304daa8471d..deed2b44ee18 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -2284,9 +2284,11 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
 				struct file *file, void *fh, void *arg)
 {
 	struct video_device *vfd = video_devdata(file);
+	struct v4l2_query_ext_ctrl qec = {};
 	struct v4l2_queryctrl *p = arg;
 	struct v4l2_fh *vfh =
 		test_bit(V4L2_FL_USES_V4L2_FH, &vfd->flags) ? fh : NULL;
+	int ret;
 
 	if (vfh && vfh->ctrl_handler)
 		return v4l2_queryctrl(vfh->ctrl_handler, p);
@@ -2294,7 +2296,40 @@ static int v4l_queryctrl(const struct v4l2_ioctl_ops *ops,
 		return v4l2_queryctrl(vfd->ctrl_handler, p);
 	if (ops->vidioc_queryctrl)
 		return ops->vidioc_queryctrl(file, fh, p);
-	return -ENOTTY;
+	if (!ops->vidioc_query_ext_ctrl)
+		return -ENOTTY;
+
+	/* Simulate query_ext_ctr using query_ctrl. */
+	qec.id = p->id;
+	ret = ops->vidioc_query_ext_ctrl(file, fh, &qec);
+	if (ret)
+		return ret;
+
+	p->id = qec.id;
+	p->type = qec.type;
+	p->flags = qec.flags;
+	strscpy(p->name, qec.name, sizeof(p->name));
+	switch (p->type) {
+	case V4L2_CTRL_TYPE_INTEGER:
+	case V4L2_CTRL_TYPE_BOOLEAN:
+	case V4L2_CTRL_TYPE_MENU:
+	case V4L2_CTRL_TYPE_INTEGER_MENU:
+	case V4L2_CTRL_TYPE_STRING:
+	case V4L2_CTRL_TYPE_BITMASK:
+		p->minimum = qec.minimum;
+		p->maximum = qec.maximum;
+		p->step = qec.step;
+		p->default_value = qec.default_value;
+		break;
+	default:
+		p->minimum = 0;
+		p->maximum = 0;
+		p->step = 0;
+		p->default_value = 0;
+		break;
+	}
+
+	return 0;
 }
 
 static int v4l_query_ext_ctrl(const struct v4l2_ioctl_ops *ops,

-- 
2.48.1.601.g30ceb7b040-goog


