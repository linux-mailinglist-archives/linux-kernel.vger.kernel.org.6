Return-Path: <linux-kernel+bounces-439194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3F9EAC13
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF928DD51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E6210F52;
	Tue, 10 Dec 2024 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y+6h7vWe"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D41C2080C0
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822943; cv=none; b=sI3xcr0XS2P6g9Zojdm3qCLW6weAv4J9LqIlS8pH1GGNihn8JYQcVhYhqzetcUs0kUrAJpCWB6daQHT1IVbJi+ju3wZkc5XRCPhojm9ojt+fadLtktpB+Y7lIxgAdipym8BwaMNFIX2Q1B60m8bSDV83wqf9acAwGfdzLZM91Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822943; c=relaxed/simple;
	bh=UCSCdBd2wYaTg2mVCWPKK/8ZcXTPSRHtCpuikvCx6bI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJSiKA1982jNiyR/l2l82h/+Wtp6bHq4+qPfVBBGE/mf2SJwV2EYXu4QrLBKhZVgEkIvJHa/38w+WhxZtUrdOAPWrG0v7F8VSSPdoEOMrqhONU6v41jDD85Af6iSNX0AFbuP+OGg9qpwMM4bPM8yJcIX4csXHLqqisaV+rZ9UWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y+6h7vWe; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46772a0f85bso9245891cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822940; x=1734427740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiogjbYyyp3CBgcBMLahUXd4YrS+7xUetAO4W7bj77A=;
        b=Y+6h7vWe5HAwwUqdm1SiV73n5I0p+/eicUZJq4BZzI/h84HiUwA6ZaJWoqnhbOqMfa
         56eh9lXWDEd4YsaXcEVAHSx5ZIxqZpROJBdcQK03trWPYLcJnVf1/JKogft+KSwBlxSY
         Kan4qOh8bzm6BXTkW2nMgOGuBxWZ5uG8efAik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822940; x=1734427740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiogjbYyyp3CBgcBMLahUXd4YrS+7xUetAO4W7bj77A=;
        b=PQy0DveK4qMd619YEf+2L5TGXGf5Rx053OVpzAFAltQ4uWKpqsLSMz12skmRDIBoJy
         6Jql3GVkP1yIDklBcx7mnb3RLU7Gn+Cz3g11XkaTyz9eO2IE/AfI6cpCxoLV3IrfVxpu
         7D8hgj7zQdcAyx6/8jHdnzW4PkC4DkZo5329sL7bK5Qpv2HMbaSul2RccYRnw3nHwEVX
         AiAGF1t73CHR5XHNpM2eRnzZcL8I3RkjibuPW1NgGEn5odQ0vPTwbavpCDcWN+84KKLF
         oRguDQiZXhBXiRav2dxozmHp2dLpgrJ5AJoi6IDbJ+G1Zd8hDsCTT4DKmeb6ltnjrsH+
         PMBw==
X-Forwarded-Encrypted: i=1; AJvYcCW+hStvIboH7+ZYudSJ+GAUIF+nFdAt6ZsEanVm3BOIXlf4qLmopZOw5O9oXNLMLA2BMqs70i8q6er2tfA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx01UrwoMRonoRrUYZMentei1muhcboR8vEHlr2iUHd4KiGgiN9
	v1/+hFe2516h0t71a01GEj5ShElyCRt5v4TQrWrrmXcZ3wvQdN3O/ewE8EY8Lg==
X-Gm-Gg: ASbGncvmR7bCAW77IKkTxXlsIFpPaG2MjssC05dxAT8gK8J457DyreC+60rhgSGFvnH
	p/nDdqCO1z7Ot1fzlrvKmb5468k5qt5URVVyg7efulWvMEjQQiHk6p0B6zWknj+B9kglch/h1vs
	QnwToz6xY/4rakqnUiQUIjsSDwMDr/gGzBNnC+nIfPdnyrtWqMITv6aY9hNZnBqzsykkBQ0tXcm
	Kuwf7GzMFObrFlsi4n/ELOLAo7Y+cK24x70QDWtkfa5dzAU1kMYOBfuGEBMMuaZr9Vy7zFkzZ1J
	JpDJSOZEfeDpwO6Vn/qe3xJgnyBr
X-Google-Smtp-Source: AGHT+IF8s1VwNRHBCKTet1sDHMwDl1DPA/dKCCMhA10gvPO+iNrMX8TslNymChXUWbVD4blpu2r8gA==
X-Received: by 2002:a05:622a:4a1a:b0:467:681c:425f with SMTP id d75a77b69052e-467681c44famr119359851cf.4.1733822939993;
        Tue, 10 Dec 2024 01:28:59 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:59 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:51 +0000
Subject: [PATCH v2 07/11] media: v4l2: Remove vidioc_queryctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-7-c0a33d69f416@chromium.org>
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
index 7d615ebc511e..f512d62ab0c6 100644
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


