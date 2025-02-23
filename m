Return-Path: <linux-kernel+bounces-527912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BF6A41136
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0F7A051C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326FA20E70A;
	Sun, 23 Feb 2025 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgLzfCTp"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D420E70B
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337182; cv=none; b=BtwKZ+EwRH2enoEKOm/gFpYXChBVv6NM7Zrr7p7Czqgg2x1Z/sBg64sYK/OXD8TjlW0hj+IhCUcJ6d7cYROdLdlvlMCTMiDull9B/nHZlzUvm2frKH6c9yAQr9OERUjcKn/81R2oUx88wiBlcTwaGtpnTHh/49PIj4NCQFG8xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337182; c=relaxed/simple;
	bh=WmADWSvj6uAUkvJFbyL8wOMewg1Hx0JsVjiP96waOB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T5AUmYqapv61y4CPBhBXTrs75ZSZCr+hyWBgk63sF5mNiqo8M3sPLrwddyDGGuvF2Xd6IjLxLn0iIC7cpBEYHeXIURaRM7jK2o4edozyDKUZQD5qHnz1l9ieHKuqpJfBYdiEjt+MyztlRlr7pUxqZN0Np45r2A59qcEUi5IMViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dgLzfCTp; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e65a00556aso30767266d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337179; x=1740941979; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmMOjl+qwMNw0jD9DMRg4cojYEKleYPWUi1Y0A1e5HY=;
        b=dgLzfCTp/tGPFgPBuj1CO3pFLDfvWufi/QuUvGB6WXD2w+85I3hrs7zpVnmec87Fys
         TChxW1X1zO6qF0494NhlKMRG1DxsyHEKfeZAcahIr81p41i9BR+jbwh2kzEUD3A5a97j
         iGySdlCCdgpjTWTmSWSCiH6XVvz5i4f+5QMr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337179; x=1740941979;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmMOjl+qwMNw0jD9DMRg4cojYEKleYPWUi1Y0A1e5HY=;
        b=ggKrPJ19poeAu65v1M4UAC8EsO8xf64RX8yIJNinpUcZYhfWrCo0bqXXqHb/wZzesV
         FTLo3A2fp0PqcH/E0/+Od4SH5XvXCZtr/TNLWwfjFeMy0Y4iuhBApn/lOiUWYASF7DKP
         vAF6KLicF0Hme/hjViPpkJSe7z/pcROHkT/qM2XYy6uUVOsCZ9fbboTVEOylhlTFG9Qp
         tSsUlYXG7J+tDKgQiYmlSlg4O7Utdkn/9C7eSDEZTv8yb548JtQrnVXsTxkgxlpP75Qf
         6jeJ+/wmSeq00kQjpIim80Vyl7dINz+gWUkOh4TaC+q1qZAw1Ol+0zepLS/kWy/p9biv
         a7MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnZw4fwrnaQOhX5aqijbe7DJwD/NEpNdkLhIotx1QlfabRhw7dYcElMyHtsL8x131VpQ0lf03hVBwT43M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfngyq0gqR9qehI5zRDjzJd0FqOOcWtI7nYHglSlKES/bHQ7Sy
	jjZHvY3Skl9MczBPXWO7rrNzRgvKm2Wf/iGQ6auAovZ+KOpdjHxjS7+veJT60w==
X-Gm-Gg: ASbGncunv+trMmkLq9n8tqU9WYa4j4ALxUi+6nUrYbc6MJ4Jk76YMPU5xYXBZflzhym
	tNZb6pkDjv/g6UTEsHIqD3EDGUFgslh92Xmo3Zn3Xa7eLImRXddbnyGl8gm1WERCMrRpodLHwvc
	9mmDkxOhbcc+8Boq+diyq65tRw8Clo55Q7L6D5vJ+teFnU+MeHk2xw4Eiindm7i7cxc+pbUOUbr
	oP7ECg0oaPXERdnjjU6llTM+6y7obV3+Wky5GExJXEWMyP57rHnRw3+9wv5XF5Cjp21660DcGNu
	mvEboM6GGlg0viqwTY1urozWJVvGZeYvy21IAtQbpTvnxgHcXKSmoudljpc5XiobgomQjnQuh2w
	V2nU=
X-Google-Smtp-Source: AGHT+IG0N8p+jyjmOv+jFoMONGfZHngVMJ2/L46r6qBftBaVoQxFvMRvuW+hkaPMPsXXZun2oIuYDA==
X-Received: by 2002:a05:6214:d4e:b0:6e4:2e00:ddc1 with SMTP id 6a1803df08f44-6e6ae9ffd75mr145374826d6.40.1740337179698;
        Sun, 23 Feb 2025 10:59:39 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:38 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:12 +0000
Subject: [PATCH v3 09/12] media: cx231xx: Remove vidioc_s_ctrl callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-9-4292911cab6b@chromium.org>
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

The driver has been converted to the control framework in the past:
commit 88b6ffedd901 ("[media] cx231xx-417: convert to the control
framework").

This function is never called, the core will only use the control
framework instead.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/cx231xx/cx231xx-417.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-417.c b/drivers/media/usb/cx231xx/cx231xx-417.c
index a4a9781328c5..5a4b0f96cca2 100644
--- a/drivers/media/usb/cx231xx/cx231xx-417.c
+++ b/drivers/media/usb/cx231xx/cx231xx-417.c
@@ -1538,20 +1538,6 @@ static int vidioc_s_std(struct file *file, void *priv, v4l2_std_id id)
 	return 0;
 }
 
-static int vidioc_s_ctrl(struct file *file, void *priv,
-				struct v4l2_control *ctl)
-{
-	struct cx231xx *dev = video_drvdata(file);
-	struct v4l2_subdev *sd;
-
-	dprintk(3, "enter vidioc_s_ctrl()\n");
-	/* Update the A/V core */
-	v4l2_device_for_each_subdev(sd, &dev->v4l2_dev)
-		v4l2_s_ctrl(NULL, sd->ctrl_handler, ctl);
-	dprintk(3, "exit vidioc_s_ctrl()\n");
-	return 0;
-}
-
 static int vidioc_enum_fmt_vid_cap(struct file *file, void  *priv,
 					struct v4l2_fmtdesc *f)
 {
@@ -1627,7 +1613,6 @@ static const struct v4l2_ioctl_ops mpeg_ioctl_ops = {
 	.vidioc_enum_input	 = cx231xx_enum_input,
 	.vidioc_g_input		 = cx231xx_g_input,
 	.vidioc_s_input		 = cx231xx_s_input,
-	.vidioc_s_ctrl		 = vidioc_s_ctrl,
 	.vidioc_g_pixelaspect	 = vidioc_g_pixelaspect,
 	.vidioc_g_selection	 = vidioc_g_selection,
 	.vidioc_querycap	 = cx231xx_querycap,

-- 
2.48.1.601.g30ceb7b040-goog


