Return-Path: <linux-kernel+bounces-527907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380AA4112C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61770173349
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97420CCF4;
	Sun, 23 Feb 2025 18:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Me+M/EUD"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E29920C479
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337171; cv=none; b=NGBPDEfDO4oGotEIbd59W2o9nXvTnNYAAvPcULIvZWEqGsiZ4cGcwKFlFn9KbzPEf2AqfPrW5qiwkiMP4KZIrnl6OeCCXSVZh8xfkNkC8a8+rJ0KkzawFbTasvYC5rvAfz33NPf7SmW9zsMCYENm1IdkzaPe8c77fP+Ssn4JEpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337171; c=relaxed/simple;
	bh=xHh1GodNV49mVOXTDlr/kmEEgfRtOkAHCbSYPASBaZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPYafXAoLwTZ2kPZnUn7qPxPUu7Bm837zQXADHH86NE3ZUoVIUjiq6cwVZGsxNj88CXva8jBgpfAlz7PqcoUjb0vt5TXFKhNVmAKC6wVgbk3khklFEjhsYP3m8ZbSYvA0nmGkZOC2A1N0N7P5reUnytFUkM4XfegOn58bAQtA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Me+M/EUD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0b24cc566so321990985a.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337169; x=1740941969; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRb6n6dm7lw2Z9XBFIWilv+DzQlMIIsiVy3tu994jwM=;
        b=Me+M/EUDOEG1Slj5OTfOzycsg8s37tnkh2Z5MeN+oTTtcq9LpUHOrL5Pxk1JOMaHbw
         WDb2ABmVZ2vDaynXy5humC9f40EbigNNIh86yJK+yCjpzYInbrZGaakjQAy3zXY90XkM
         w/wlk3E83eoAM8j0mLtW7WPfvtdwIP6ItMuoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337169; x=1740941969;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRb6n6dm7lw2Z9XBFIWilv+DzQlMIIsiVy3tu994jwM=;
        b=hmIQ7uFFySDFLCiTpHWhYKV5trOT6I5FbkrJuBsjz2mb2YErMBzLo59uffkGeg6+hX
         odPyMDEbNrNTyKDX8/PbuEaA9yJnfVsf0Ipgd5D+s3ceLTGxMM5nquGBc8JlmNtuPq0A
         tUVLoLp/bM4r2ILXSy7WtMhFOHIEXJvibu9vz+joSQlpNiRTQE3WM6YUCt9YsBzSZhLY
         HJYcxrWxcpQQMKYgq2cqPSHNG7qpEF9ie75M1KipQgRtC55pNgIUK1YrY0AJYgOjJjLN
         dz4itzW1yUwTGb6C+oFkZcjpXTw7V47K0KcT79J4WPMpWpx+R1MZdrjYraSB3JnGlaFQ
         q3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXL677hOTv5/Qt8jv2XfcXVc5o+4zY3kxnPe7lLSJZoDsi7v/ldbEaf0KyMD9tONe4WXO3OIUiy/6k2nnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGDyfSYvuqhF5TIIIz7LH8QlSeMrwdwmOJcw7VMjgqd4POMdw
	O6Sl/+gxRRm6ROXOX/L58Ai3F1OQsr1FxC9eQeFFU9MpaWHySbh6X4b9Fmozzw==
X-Gm-Gg: ASbGncuja7GrjBk02lcn94YM1HQ9wxzbinInXNpPEO4BU3vnWZVgRcRPZO1n1QyxhrA
	PO9IH3P9hWq4nTUb/nnHwlKpSss0TrCvajX2h+kfEHIXT5TfXMEFMaarNLT7jC3RWOT7z9nqvTv
	Zx3aThcnq4PGXnCPbCdDvTkOhMflRoghKLuiuOhoLXMOHBZy08OdHjyEfg27J7a1WCVwYbUjyzJ
	2rMKwHclq1M4yQ2wp8LXBhDTSBaj8gCJQ1L/4dYvLyw+0qHQ4wr4GCYFQvioqO/mWVNAE+89OiV
	OPdsVfkZqaQNi4BbUY2+GfT9NRbYypWzZW7qyFZe0Qx9wUanauWgL699EShnc3cKfospoOkJMUy
	Or7Q=
X-Google-Smtp-Source: AGHT+IFIm1syTpeE2i1EYWI3iEtSyliT4ATG6d2xnrdk5fvsT0z7+hE4dqtz3meToG77GzeKzuMC5Q==
X-Received: by 2002:a05:620a:444c:b0:7c0:7a0b:3727 with SMTP id af79cd13be357-7c0ceefd391mr1224831785a.16.1740337169084;
        Sun, 23 Feb 2025 10:59:29 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:07 +0000
Subject: [PATCH v3 04/12] media: uvcvideo: Remove vidioc_queryctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-4-4292911cab6b@chromium.org>
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

It can be implemented by the v4l2 ioctl framework using
vidioc_query_ext_ctrl.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 93c6cdb23881..89052455ed50 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -963,15 +963,6 @@ static int uvc_ioctl_s_input(struct file *file, void *fh, unsigned int input)
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
@@ -1491,7 +1482,6 @@ const struct v4l2_ioctl_ops uvc_ioctl_ops = {
 	.vidioc_enum_input = uvc_ioctl_enum_input,
 	.vidioc_g_input = uvc_ioctl_g_input,
 	.vidioc_s_input = uvc_ioctl_s_input,
-	.vidioc_queryctrl = uvc_ioctl_queryctrl,
 	.vidioc_query_ext_ctrl = uvc_ioctl_query_ext_ctrl,
 	.vidioc_g_ext_ctrls = uvc_ioctl_g_ext_ctrls,
 	.vidioc_s_ext_ctrls = uvc_ioctl_s_ext_ctrls,

-- 
2.48.1.601.g30ceb7b040-goog


