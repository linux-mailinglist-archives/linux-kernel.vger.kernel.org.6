Return-Path: <linux-kernel+bounces-439199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A29EAC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7C19165755
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D743122330F;
	Tue, 10 Dec 2024 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h+q564Bb"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C5921576B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822949; cv=none; b=af9xninE1fUyQO2Wrh+1XSa55FhppXzaeQaoGpCTIgyoAm/euwq5FUZmq3p1Yys3kBEIuqSmQgKuZXaIckYD9p5UWpeHjEEBSwo38/7dyFJ/xcNrDsXMj5JgOrHHe8i552r1m2ZM4Zr4M82pJ+vEDCyrH4Q8HEleZ25La+GSe/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822949; c=relaxed/simple;
	bh=oBcqkfXM7E90s1taQvAsnIcQGP+0/edriRflHVpoMcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LdCzbz2qeFPZiXVnfpBkZ7h7JtSC2nBjqbpAoBoWJX9moUtC6YcjO+UOnEWQvMEz81o/wKQ+syoqrZs4gL/w1e3ET4DwzuQzDtM7VMaep5PIHyeqNtI9eg1NFo5Pi+/LbyIzndoUyjVMITM+rS43bUDjH1D8D6h+jwBi/wDywXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h+q564Bb; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e8814842so5540785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822946; x=1734427746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fauP20HSTE8MNs9sZtafcLYAmxh0dWmJO0jdKtoSo0I=;
        b=h+q564BbmKoNGPi+38Y8l45bw8AisgX31eE1zNL5+UxiVINz2okuh3tjZM1FwWvWuY
         XILhu0GHq3gKEW0eqU32ulUac03Q+EbhBTB+6RP6N8OZItddjZ87itOV8BMncpBP0C2o
         t+CHmzt/1/9iRwVftnnoSbzbi5bBg7BoRCrJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822946; x=1734427746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fauP20HSTE8MNs9sZtafcLYAmxh0dWmJO0jdKtoSo0I=;
        b=hOUti8vFOEnl661SEG3kuoIp3yvQibF+nOzpobXDtBHKHCB/1Bw61N5mq0ghNPFUTZ
         aoal3nZZiZHWxococTPIx6Y8HGPuJDnDVsfu4RMVUpXKH+SXTIccCZXlXyV0W5fcu4Is
         G+Q3GkvrpPbd3w62qtwWlqVnNGbnC/UuMLi+sNPiTVorX3w+f6a0kXtFCnouil0dgYU4
         0/aIrK2dLVJKhiq9MwzUzCHcYOlRJEWjuXBIRYKmek+PByKcBOhy4M0xKUALWuks+tzM
         9/Jf6fNIHPfhUVN6bW8sQYWpFN4cghLBG+dP9m9ZVaCswmTtkVQsD6IH48FjbMqt2sBF
         a2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVdm3iV8NdMIj2PrgnhE2bDZ1ASEqQ2ACbjFC9969LjpyzZ5woZSx+GU+NxWPSZd7hUwN4idBEAGHRsZ8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9hwhAwyoz9ydlhf8/A9UjGWSxNVHIqMzmAm94Glb2bafsQGeQ
	n34Im/rNlTphIjX94qrvHog2F+c33CVRbqY0Voj0PNxAcjAvunsFmq85ryedUA==
X-Gm-Gg: ASbGnct3mC75CIQ/SeSrZqhwDFCWWZ6AamFSxY7m9NJCG2/p6oi5vFrtmH1gGOLz0wq
	ArlyCWu5WdSrB/oeo3myve5qgez1NaRC39/baipeTnMgZhpAE93o8AnAcURLZU705xlPa/6WCCj
	e+N9yOykCHUjzz2bXttsXwVO8kdWsahfKIKJJviOiKXzx7MiwC8QopAHz+g4eAkCpVvaf7UmJIJ
	bp9vmduPdUJGn2W2ZvFUz3J1Uk2w+FVN2X0LKI/FnTaqP3LND9P6I3YRVet2FhDxJEuLB7C2fx+
	oz1RZHFMqnCw+LxkbL3+qAn+/Kdv
X-Google-Smtp-Source: AGHT+IEnAKwp90vPjCXMeqd1g8B6cI75StK2j/sdcO6TCrMFGNndcgYh+1KjE8474PP7wfMI8TymRw==
X-Received: by 2002:a05:620a:2a06:b0:7b6:deaa:3191 with SMTP id af79cd13be357-7b6deaa33cfmr302944585a.55.1733822945932;
        Tue, 10 Dec 2024 01:29:05 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:29:04 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:54 +0000
Subject: [PATCH v2 10/11] media: v4l2: Remove vidioc_s_ctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-10-c0a33d69f416@chromium.org>
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
index 03a62fa960b6..aa31678fb91e 100644
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
2.47.0.338.g60cca15819-goog


