Return-Path: <linux-kernel+bounces-439190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1303E9EAC0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D1AC18835A0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35021DC99D;
	Tue, 10 Dec 2024 09:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FdEGy4tl"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B01E78F58
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822938; cv=none; b=FWoUQNum277KZeV4cAW9DrtvqIJZDYbYSRzqnefZ3Vd+M0dprO689VfUqePQq8xpdyQ6SyWDP/udI4w7pnZpb4iwu+qeYbaq3lB+CSlahZPfn8lr8tcgNSjd0JIvVNMXKlKKMvmypkuOLoEiSs8OpodvFVEVOI5Ft2OClApZlWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822938; c=relaxed/simple;
	bh=64tvBdAJsYjij/MYhZgHmQi1NAwPb0Ws3Nyiuj2wFEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lhB/L90ca0q4INmHdZNlWxuLLX5tgv/km2mqDDM+dZl6RdrwNAJvWmfgABQ5aQv6530AxDXelOmRphX2o8eu1U6jMtZflnk+9M+PWy624AxGwAeedWVg0yK2KJD3A40j9j3BmrxZpSavJ+zZc2pkZbcZqTMTrXo06PyZTfhb5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FdEGy4tl; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4675ae3dcf9so19540611cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822935; x=1734427735; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FjvmPnf8Z5eA5SFOWcK4xqjLhjw4Qhz4HdUq4wZg+ks=;
        b=FdEGy4tlxE1ABYGqzZpRsnZmsirrXrfPFw5SN5s0po1qLptNs1Wpe2BmMkcSQ4MNEt
         cVon5sgpRHRp49yd3SH+QvASBBvNWBoIkbt+x9uTVOYMkmMUt6MfhTzOgM+TtVEFATM1
         8t61iCxynytH5XPsnVfu81+I51SwFTus4tVFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822935; x=1734427735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjvmPnf8Z5eA5SFOWcK4xqjLhjw4Qhz4HdUq4wZg+ks=;
        b=ueHiZ76H+bf7smnKsf4mb0Jb9UR/netCKN8slaJaedvgjcCBvdoQWV5R7vJG6uBvV/
         w2FRxPCQ5C1l9Baf9CnyUAZCefY0uOmsh13AtrMYGNvVTHPY0GU52SCXmdavN1F1t6oY
         l2e+kSIDQCmehq+NkKgquhC8DVzKcY7Ze9so5GbOS2k2HouUKnfz7VVQE1v/Z3DvfNyL
         adMuMSzDqHg7UR5EQMtdzwoQ1gPHqQJi5e+bn7DkK5F4fhGdKNLcB8JT72Y3zQ8enYZx
         5HFqurvG++7QQVDAjr/aZGB5A65Nl0K85DP4a3D9txrNA08un2H32XZbJyZMAvt1B6zF
         oT6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJUlvkhPADyvazWCnpdNUlIMdpGIzh0npn0DXq6fLxm7r30Y5Oyu5JD0KiHc31UyoKxSOuaMOpKwpT4/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtuUMH53gAffzfhKr8pMVXqyU8nvPkVS5C/8INieKbI1OhCV09
	zqcAVpJj1UmSN9FID3FejmzDmUGlk5On4butG8Hila1kVpk7Aq6C6sgn2taD6Q==
X-Gm-Gg: ASbGncvHHHrnEAtDP+vTLZf4q/1JdSLiMQlOM2EqKocTtRrhD95/ZBSist56rf+Z+Tn
	wFgt90Y0CHm3BMtTyK6IyA07h/l6ZbZUlmiJlnK1TF1eonWE9wscyNTZHs6bgkb/FjtJn1ClPTz
	K/IikFDHqKAOAs1++JO8AAhI9W0PUdGuu3VCZGLWKWHznB/bc+53uyAabyIlbQqu7U3Ov12cJh0
	jgMWew5h6lmvuJLMBnVwXJr4u8CsMx8zMrZN4CTRGlk31JUvMm4uZL/NUwG3PII/Ho+Y2fhxjZM
	ZET6YKIJdsyuamT+PbSqChCk4hAv
X-Google-Smtp-Source: AGHT+IHGAkrg9JR1HBN/d9GzBVA8UPusHAYSvN2VMXg3nbckSt2H7xOL5ABV9A5DnG2qBp0kGbezeg==
X-Received: by 2002:a05:622a:1210:b0:467:64c1:c4a0 with SMTP id d75a77b69052e-4677205c693mr65416141cf.56.1733822935529;
        Tue, 10 Dec 2024 01:28:55 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:55 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:48 +0000
Subject: [PATCH v2 04/11] media: uvcvideo: Remove vidioc_queryctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-4-c0a33d69f416@chromium.org>
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

It can be implemented by the v4l2 ioctl framework using
vidioc_query_ext_ctrl.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 97c5407f6603..39f0ddb6d01c 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1014,15 +1014,6 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
 	return ret;
 }
 
-static int uvc_ioctl_queryctrl(struct file *file, void *fh,
-			       struct v4l2_queryctrl *qc)
-{
-	struct uvc_fh *handle = fh;
-	struct uvc_video_chain *chain = handle->chain;
-
-	return uvc_query_v4l2_ctrl(chain, qc);
-}
-
 static int uvc_ioctl_query_ext_ctrl(struct file *file, void *fh,
 				    struct v4l2_query_ext_ctrl *qec)
 {
@@ -1563,7 +1554,6 @@ const struct v4l2_ioctl_ops uvc_ioctl_ops = {
 	.vidioc_enum_input = uvc_ioctl_enum_input,
 	.vidioc_g_input = uvc_ioctl_g_input,
 	.vidioc_s_input = uvc_ioctl_s_input,
-	.vidioc_queryctrl = uvc_ioctl_queryctrl,
 	.vidioc_query_ext_ctrl = uvc_ioctl_query_ext_ctrl,
 	.vidioc_g_ext_ctrls = uvc_ioctl_g_ext_ctrls,
 	.vidioc_s_ext_ctrls = uvc_ioctl_s_ext_ctrls,

-- 
2.47.0.338.g60cca15819-goog


