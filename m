Return-Path: <linux-kernel+bounces-409834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2659C9243
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919FD28148C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97021B6CF9;
	Thu, 14 Nov 2024 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g1TOtMXc"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EBF1B3940
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611464; cv=none; b=B4keUBxpxcPnNcG6MELdEVB4pf4gfL3mPGcSwqErL3xcSWnNce1YnzfQ60OGJyHAsM3tbZi8BG/n3aDhpBDXX1op758/7ZUqHSZS/GI2gZRg8snrqdPYcj0ou12fHgBBZO0BneeQbAO//B6Ur6Zi4Iato3r88Go6wDYPF0WyLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611464; c=relaxed/simple;
	bh=k4uDTu8QR04JKFyNIWvlkLGzbPquiHwpezPKOuusA5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eKBiQVSABMid584vtpzfoqWhAQf6S4oGKIaZ/GTv6dQiRUEQPBC4CyThMlAuskbFvkVlN2KLl6sYu58Mz2jwqLdUCZFEFU2EFtRVA2UU7QsRC3ANxKdTHHMjI61jnRqiOW1x4w75kiuLr6jdS8VUea3QOuu34fa8Rem4xW5gfag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g1TOtMXc; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b13bf566c0so52189485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611461; x=1732216261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7E0huVHEFwjCBRTjS+ylKmb8Bs68bY9XRKBoQt8QA8=;
        b=g1TOtMXcFxhUxMNeF/MUlcxXweZKbgYCFpexSiqJVvO6n4qcvJ5kdxppqgdu+nE6pt
         b+0FkGloSQ86ZdpbfQOQlR4vLfrUuYOXMso/AGttoV6gnIllxz7es2VL/teRSy3xX45n
         cbi15V/9Z1MjlRopVTgX8EqaX0OhD7v3lRvC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611461; x=1732216261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7E0huVHEFwjCBRTjS+ylKmb8Bs68bY9XRKBoQt8QA8=;
        b=qdc2zSsW+l3NthXnszUt14lQj0vy4eYuEVcgYUMMnJhSR6xVfrlm8yQePUeMjg/uwI
         qb/dZlRlp9pScErSmDItk4ZxpM2rD5OzyvWqj9jLmjlHtAYKfAJLueJXq8Wp2P477tTf
         6bP7iHGq3KZwLs84y7TDSYuzmdD+s/OaxVZ+04tpdOBqiTsFkKrMuNFSX0nXKj8qzZy+
         hE7PiF5zp8pzXladagNTh5q1NR32yZrXbFjVdDUb7aX1oB/OTXjBcc3PNgPmW2SqjkUR
         0VRpa8VRmzAQgDZb9lVOjrx9dIqFVIXVY5FJLU+pDg5d1d5/WkO97gkrahkuEvNEkSBu
         cKMw==
X-Forwarded-Encrypted: i=1; AJvYcCVGxyKR94tqZSp10GoxywlTQmqJTVWfzi0gB12psq5yJ2BcrzYKBUyGzZHTMCF+T/97cwGcVO12MkDdR0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3gOZ2gxGo/3qVWPKEWOjYsy8fgPuHWMn+JO7bGEA1Jsa005Fl
	zrZ3NOO0oqqE/1PfIBHX9iynFA8H6++2qxyPWE3QE2S8Lt61Wc95EsY0lQF66Q==
X-Google-Smtp-Source: AGHT+IGZMIzlcVDne/EBA7zSnMfQWXO3fs22rn5PFrTiSjbHbo9hkBJ1di5xITi8OVdVSgzseLvdGw==
X-Received: by 2002:a05:6214:4909:b0:6d3:f73c:4430 with SMTP id 6a1803df08f44-6d3f73c6993mr22012796d6.26.1731611461706;
        Thu, 14 Nov 2024 11:11:01 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:11:01 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:46 +0000
Subject: [PATCH v15 17/19] media: uvcvideo: Add sanity check to
 uvc_ioctl_xu_ctrl_map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-17-64cfeb56b6f8@chromium.org>
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
In-Reply-To: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, Ricardo Ribalda <ribalda@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Do not process unknown data types.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 5000c74271e0..4c88dab15554 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -106,6 +106,12 @@ static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
 	struct uvc_control_mapping *map;
 	int ret;
 
+	if (xmap->data_type > UVC_CTRL_DATA_TYPE_BITMASK) {
+		uvc_dbg(chain->dev, CONTROL,
+			"Unsupported UVC data type %u\n", xmap->data_type);
+		return -ENOTTY;
+	}
+
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (map == NULL)
 		return -ENOMEM;

-- 
2.47.0.338.g60cca15819-goog


