Return-Path: <linux-kernel+bounces-409831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DC79C923C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B7E1F2139E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA631B3937;
	Thu, 14 Nov 2024 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OqYSFX5P"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D41A08CB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611461; cv=none; b=rZxWllTZyb7+9FdmqdZpc10JqsTOq2Nq8VzwByOlNeXhHJS4/Yd9towAWngRcUPAAcaKuzJp1gmrAwtf+K2OMgZDF9fi5S1f73JssNfKHG6mVjXxiqDGPWUdvibM+Kt0zLT7D9IyZEIXCoTvG2XRHbSLajgMg3JwdHYppY+FdG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611461; c=relaxed/simple;
	bh=EY5Eo52MkamV+RiJa+5OacEJMnFkljSo2OxdtrPOeRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RWs6JuFNKRF5A+YsuCDFUjmV0KkPXv+5KWFXEDWPev+KUqMPfaEB9GQT1ynidndVM5YraeONVXmX4JGhKmC2OucxiYmlP1dU2dcwNFKyCIGEG/XqLR9L/qouzbTr7cPW+N+Y7FZLQKv/Q6bFkrSTFtVhdGZL8qaR6Hw4DVJFiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OqYSFX5P; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ee763f9779so546639eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 11:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731611458; x=1732216258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFp+1e8oNM+DJbAtPSv+MyzrHN+BGnrJgCSNAWaI55I=;
        b=OqYSFX5P2wbtV/NYx1TnDFjnHWAAfLhTbsi2V6xwUnSHtvGPLOS6mdd1lTA0pd616G
         VqbP98GAxYOHGCtmHW3CoegmtVdFFS5oETPSd7gGGeriK9lmA6LlrIElX+fVe1DHFdQf
         MseJWhdlOxsZpyplHjHJ6HAkM84Z1yE7OG2BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611458; x=1732216258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFp+1e8oNM+DJbAtPSv+MyzrHN+BGnrJgCSNAWaI55I=;
        b=PC3hoA2C9+lvwKQxgBVL0l9rL4IlymKhhm7hQE5y4mVMQ+2lLH6ri6phwzNXqis9Ok
         CeeK4F4pDEWkedczxkczofk/4sBjBtAjA409xGsDQKkiG+QdtKbkraXeJvbC9vhBPky/
         pYlN/K836aWCQOCP5Tg1l0b2kxbT4QMOCrj0f21dtIFwdLWXT7zZRJbz8R1S9CKiszUT
         pxLq3rDZsmyIZkkBr4329dT7gEZLQUqcZske3xHuNwOEzjUS+EItcO/V19+A3nOJgf/i
         bLjfkM46gMgnyhZrlwTYdMVV/5gUjm7OdEHPy4lruS/wqGEtYEZEETBXnZVf7Yekd0ye
         1X+g==
X-Forwarded-Encrypted: i=1; AJvYcCXJfMHcI/Atr26gFaSozEY8qihC5e+xyqF+5twNkHTKiPTNC7++qw198Y67YpmzlomAO1IqxWRqJDC7qp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqv//bulaiTDolcGE02xwgkx56HvJQUSNQzlRJH4xQTa4gcU0/
	GB3MKu9hGqWrUrMGQRb+KRboM9tZ47fvv5XKyASvWBP2s0sQ9aJGTLNm/HWUEA==
X-Google-Smtp-Source: AGHT+IFNvD+gf1x55TT4Tlp5DIkK4UJiITK817j7zFhtUPdS3c13ovbIzET8/U/C8Kmf0gEGTY4ncg==
X-Received: by 2002:a05:6359:5197:b0:1c3:e003:bddb with SMTP id e5c5f4694b2df-1c6cd2a3094mr13550655d.22.1731611458448;
        Thu, 14 Nov 2024 11:10:58 -0800 (PST)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee7cc7e1sm8857766d6.53.2024.11.14.11.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:10:58 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 19:10:43 +0000
Subject: [PATCH v15 14/19] media: uvcvideo: Use the camera to clamp
 compound controls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-uvc-roi-v15-14-64cfeb56b6f8@chromium.org>
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

Compound controls cannot e reliable clamped. There is plenty of space
for interpretation for the device manufacturer.

When we write a compound control, let the camera do the clamping and
return back to the user the value used by the device.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 0dae5e8c3ca0..72ed7dc9cfc1 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2339,6 +2339,18 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl)
 
 	ctrl->dirty = 1;
 	ctrl->modified = 1;
+
+	/*
+	 * Compound controls cannot reliable clamp the value when they are
+	 * written to the device. Let the device do the clamping and read back
+	 * the value that the device is using. We do not need to return an
+	 * error if this fails.
+	 */
+	if (uvc_ctrl_mapping_is_compound(mapping) &&
+	    uvc_ctrl_is_readable(V4L2_CTRL_WHICH_CUR_VAL, ctrl, mapping))
+		uvc_mapping_get_xctrl_compound(chain, ctrl, mapping,
+					       V4L2_CTRL_WHICH_CUR_VAL, xctrl);
+
 	return 0;
 }
 

-- 
2.47.0.338.g60cca15819-goog


