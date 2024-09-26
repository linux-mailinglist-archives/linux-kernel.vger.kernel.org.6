Return-Path: <linux-kernel+bounces-339915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B1986C22
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48926283C85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB09188595;
	Thu, 26 Sep 2024 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZnvO57H"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD517ADFF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727329816; cv=none; b=qxrbW4cx3wVXYa4h/WMD15k6DKmXW0VX0/a4mgjU2j//lKE2JAWxRyrolm98ot5TF4V4vSMJvhQU6iD2iXA0c37JBn/D3i/ACsFK43uH9cKwF+xmMoGauImQRiNuueI6GcpIK7mjLQQM0e+RBtZS5AwdLHeM4wDkKRRmbSPPGvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727329816; c=relaxed/simple;
	bh=Bfu7bqhrmzOz9Ey2Adj2zHRWUZVXSf36bOoXdS7G1BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n0L4airvG72KZEdcdrFMbcTgUP6qNFL623LdKAK5vAF500+KhXPK1jP/g/ezRyGrwNG+in7hPmXEY5HoWBwFMh+9OgV8LXHTTo54hxp2qzevekKULPy+3jzVN7iEvDFKxn38xy8OZt4hBPgTF8mt1CcqCp3tEN53V6LTr/m8KOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OZnvO57H; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4581f44b9b4so3490651cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727329812; x=1727934612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYIvqRnC2mqEpaPGnRTLTAO+wgXxtOMY+ADw+uJOyw8=;
        b=OZnvO57HA6FDm+Fwkd89McBAPowcvbSdIEMk86MotSNhQdIZKwax19WLh2XjaYyo13
         GYDsQdPe0zTvzZMTqsmW5+XbTak08dmOz+4weyzXnlSx5BY/b2YJoJN5Fb4XnZMdXDRN
         aWp+0lH1iYfZbJ5FYq+Zv+IQPEw51faDnwK7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727329812; x=1727934612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYIvqRnC2mqEpaPGnRTLTAO+wgXxtOMY+ADw+uJOyw8=;
        b=ZTJmEZDUlo7KTZvz0nY7Z8T3mr+nQ/ESgsZ1UnMDKABFvbrpiPN4BVWKhG3b6TiDd+
         d08PKtQScFGokFzKWcAW7fSpGOJhuFdFoQlgLg/Ipg7lmxjPl2MsN9gKjR68fVvjZVVP
         7Mghy+Y3Y2QJZqnQTkQ9wvrEHsl0MYS5uHVVbOMRXNT3AwoykYyVn2P8I/OEgGlTfmjU
         eVkJun56Xe3ttCd2BrRl9qrxBSCj7kiHus55Ql1ALjE2s9MqjEgi6RFsOOyaylPnEEVD
         UtFENF/tDSTJ9YsS3ax5X7CQ/Xje9yuSpoPbSksTYu8E3z1I2f4PYZ1sejT904YMBF9I
         ywkA==
X-Forwarded-Encrypted: i=1; AJvYcCVcQ09DaiZvwUO+rzDvqgLzkPJpaTOkPl2M3weNwOh/obBBfws5GbBRRf05mNIcuAx2nyAUBXboO7ZLvRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzw/G+FLSiTcbR7gzN2jq0dS/lig1mb0tlt69nJdJ6ubzxdWxs
	1XUJOd0Q7GzkZgwStQ2JoQZYAEBQWjLUbH6Ab5TP8X5cIhf3lGZ0tIalVQmv/A==
X-Google-Smtp-Source: AGHT+IHpOZiuMWVYTw3bufjx9CXLF6X5TIqgtqRz1AT4LYEzDp58FI5NPEJFOE2ClOgshqTOtjB2iQ==
X-Received: by 2002:a05:622a:130f:b0:44f:fb77:74ce with SMTP id d75a77b69052e-45b5e030abcmr70037471cf.47.1727329812443;
        Wed, 25 Sep 2024 22:50:12 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5264b629sm22406781cf.64.2024.09.25.22.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 22:50:10 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Sep 2024 05:49:58 +0000
Subject: [PATCH v7 2/3] media: uvcvideo: Avoid race condition during
 unregister
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-guenter-mini-v7-2-690441953d4a@chromium.org>
References: <20240926-guenter-mini-v7-0-690441953d4a@chromium.org>
In-Reply-To: <20240926-guenter-mini-v7-0-690441953d4a@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
X-Mailer: b4 0.13.0

The control events are handled asynchronously by the driver. Once the
control event are handled, the urb is re-submitted.

If we simply kill the urb, there is a chance that a control event is
waiting to be processed, which will re-submit the urb after the device is
disconnected.

Fix this by calling uvc_status_suspend(), which flushes the async
controls and kills the URB in a race-free manner.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index e438ae5af2e8..d8d5b327693f 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -294,7 +294,7 @@ int uvc_status_init(struct uvc_device *dev)
 
 void uvc_status_unregister(struct uvc_device *dev)
 {
-	usb_kill_urb(dev->int_urb);
+	uvc_status_suspend(dev);
 	uvc_input_unregister(dev);
 }
 

-- 
2.46.1.824.gd892dcdcdd-goog


