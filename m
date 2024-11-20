Return-Path: <linux-kernel+bounces-416002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9149D3EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A23128540E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9141BD4F9;
	Wed, 20 Nov 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENegmwnh"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4141B5ED8
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116390; cv=none; b=oUBEaYMDbcphOFByzjVAMOOV2JIL7prNf+yL4QWem6gUBuMToJLocU95ln//IFG7YdpKQgY/OoZcqVcfBnP7LR5Mr2sYw0vxYduG0k6e8AE/xXAaVnFOD5gRM8i8QziomrQhL3X8ekD1muev2qO8nIIk2Y1Yc35/PhpVdZiKohc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116390; c=relaxed/simple;
	bh=0/4FckMiSiHC8QtZcVOi7l51C08TGrth+2RVMZNClRY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5atsc4zicZRR2MTSMF8oKYde1ZyK6UUqWYIEutz4udH5hVYxCeDoG0e1VXkQIa29oKSfYJqdldaCCChWS3E6czB0vNm8PImw/mWMnIwoaKPfj1AIgTd1lKjV5q3X9s4zV1uzn67/zbttCgvNd9IRT9sssuxsHrH6h38RkKei1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENegmwnh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4609967ab7eso14725321cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732116388; x=1732721188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qumhdBhQMcwMSA8xBYQJzlSmgMMJFlVuWwTimH3pwtM=;
        b=ENegmwnh/wxL2CVDXS6NAHLd2aS7So4nyDddeckKu7JzBh+6c7JWu8sGeqtDiPBLot
         awye9PKknV1gcH0fPZCgqWE6L+GFUBg4VZ41MgB6PHZWG2phTmd9nR75BPFWMN1rv/M3
         S54oAk2XyEr1aZb1MoFEvj+adz/232+qkNJfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732116388; x=1732721188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qumhdBhQMcwMSA8xBYQJzlSmgMMJFlVuWwTimH3pwtM=;
        b=PlWJwvOgcDLC0mHWa/9w58oOLBNATZylWsVVfkeEJPsZlAcoyc7USVCE9C77CJarIK
         rU+TJKJFGO/r5x04z1vvtPHxjM+sIMHGAIrslRe9DmpBkSxaTZ9aPx6KIyw/4J4A5A1T
         HY2TBtUXHdJqyF/kFHWLa22W6CzJwGlyr0RllcwLLXkMz3kCUqAy0aMfi06YzgAT0W6O
         J7IXyGBr9kCbYbI4zr/2X5DLt/mrdwJ17E7rUWwUTyy7XbSe/s+2Pv03cd+SLpha76Qf
         elLpKfAJh/bdxOQXwI8swbOfnFi9wfnunWQLlFRfWtmL/p1mQwnqRD44FjEcKUxs8IWf
         JYHg==
X-Forwarded-Encrypted: i=1; AJvYcCWduWvax+EAsUlpak0MySwAhZeik4WC5VMUTw5Fzdgw84qKWOCRrY6YAmD6daoiHM9dwYBayPcCRIw2uQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFiKMJrzX9Pwgqq9ZIOmKFytviiSqP7HcSloElWo8V6NNGjtW
	yJc98EfaJIPwEpCs+EfTaagbI9jWNvx5OBUi7m6CZk8p/b7LF3mgVGbteDgdiQ==
X-Gm-Gg: ASbGncv4VrJHlojP1z2ggW3R1CqCByst9xRWOWmVRng4JsMc1YT1CaYJFAjGI0BJiPe
	c9U/oPzkBZEVQMB9wV4yKSHMreOTfNIJ/duuzzfR9XRvq5BCIhvquvsuWwlYQS8dda4XZ1AyVWE
	bnwADmdKe0mzNG6w3s9XabM8ydK5InpnOElgtZlYhM0pbsQq+SyedkzaAUDCuSl/f9M6fx1Hi0I
	qeNaC1qkugZ2+5Yb66BIavECIv5y6GfiW8IdcntIY/R/+Fm/6ztCK4PkeO+PnmQOdaGDiNubrTk
	+3o7woUZeQlv5m7yTAb/wwKh
X-Google-Smtp-Source: AGHT+IHPlAn+PtW4S65lZD+sW4FNYiPUzxXoFq72G2Q0cDPAJTNnHqS5O488xNRnPKLEVvl1B5oT8g==
X-Received: by 2002:a05:622a:c7:b0:461:2a3c:c1f with SMTP id d75a77b69052e-46479c353f4mr37026111cf.52.1732116387928;
        Wed, 20 Nov 2024 07:26:27 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46467fd76e2sm11207321cf.12.2024.11.20.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:26:27 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 20 Nov 2024 15:26:20 +0000
Subject: [PATCH v4 2/2] media: uvcvideo: Add more logging to
 uvc_query_ctrl()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-uvc-readless-v4-2-4672dbef3d46@chromium.org>
References: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
In-Reply-To: <20241120-uvc-readless-v4-0-4672dbef3d46@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

If we fail to query the ctrl error code there is no information on dmesg
or in uvc_dbg. This makes difficult to debug the issue.

Print a proper error message when we cannot retrieve the error code from
the device.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 482c4ceceaac..00d9e3420fb6 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -112,8 +112,12 @@ int uvc_query_ctrl(struct uvc_device *dev, u8 query, u8 unit,
 	error = *(u8 *)data;
 	*(u8 *)data = tmp;
 
-	if (ret != 1)
+	if (ret != 1) {
+		dev_err_ratelimited(&dev->udev->dev,
+				    "Failed to query (%s) UVC error code control %u on unit %u: %d (exp. 1).\n",
+				    uvc_query_name(query), cs, unit, ret);
 		return ret < 0 ? ret : -EPIPE;
+	}
 
 	uvc_dbg(dev, CONTROL, "Control error %u\n", error);
 

-- 
2.47.0.338.g60cca15819-goog


