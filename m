Return-Path: <linux-kernel+bounces-339916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E667986C24
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6341C21F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 05:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA884188CD2;
	Thu, 26 Sep 2024 05:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WSS7ckOh"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14DA18756D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727329817; cv=none; b=VVcijVweM5EfSrF5Jmt0ozJ4a+Imxau8bPtDdS16nXgWLb7MaOerRyo+8mIt5sU6KTKIJ4p26Xn8dETtPvHwKQsM2UMh5CicWKo4RGKOZfdiiPhzSqiixs/7r2PCguSsbl1L6VIWXiI3FjdfsetcCx6lty3vucgBoVGlvK/YNXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727329817; c=relaxed/simple;
	bh=bp/AyInNx+sYmGScXTk/dVr8nFraf0tgtMRd3LHHRBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ifcRvnIPW9lJJvBqDoMV04eNwx28igCELHwUWcaHP4JeECgo5jjJsO+65ZjYZuS+rKt+QLCb4C36HvLNxrxBKRdrocLSTfzPThPsU2GPYcgJfWQtgFaBxV/k9R0k3bxNt0DWmXY9vq9rZafo1NVGUV3sd+9pmeCs/XsEKC9louA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WSS7ckOh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4582fb3822eso3802071cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727329814; x=1727934614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Jte9oqU3bEqLQEq3uaVn2nHKDdidO4uVkSl6injc2E=;
        b=WSS7ckOh7Rgcph7n8Z2LsZEk84OufCi6Ire0pDgM1fLfl9cILAbeVnpxUys1yMaL1M
         UoT6k0dJR8xaCvtgaFywqDbzaPhe1T1wLUpUiSg7HPbAQKi7Qm0Bz48cR86NU3Lu9gWb
         SeOyuibY33nC3nyEIXBcPn0izyvEM70KXUZy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727329814; x=1727934614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Jte9oqU3bEqLQEq3uaVn2nHKDdidO4uVkSl6injc2E=;
        b=vIGDE8sfC23slFTIox80XH8uQuOZzZj+68/Nk6XbZHDRpENlfW5uV5OMbkV5XXbcu8
         FzonTQC8hWSWs62wD1yJXkZw2OqNTojmYq7UiZt33G0KYYV5HgEi/HtRygDJZu25pWML
         nF80HoAGkLz2dy/r7o6BZ0OlLmlUH/WA21Ovuk1Dhq0LdU/fTqIW8jpDmF74I8W63yWd
         F00SIC/OFr25i8qR9OVQGJjiMUiFNEyszYPW2dSGQuauhYVMro9jelbPuLPXjOmW4tJ0
         0NgEs8tMdXUBJ+YCSQfgYInHcfQOg4Ty+iY0CdoLfwcC18Smn8MKiiPB0hsi8wSLHSEO
         t+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVa3wXZ+QOTER7uHzN6ybEdoHE4WL05yViPXiieDK/zNpdL39Z2CeOYUHPbORDjCiY7Pz1VyKPQO/qnyhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb024kA9IPaWVGGZKBRm0mjMZN1AbLkYLlIDOHx1+tviePJ4ld
	2590y8vHzBlY7J31LR5uxsD1UF/EiQf4wtFRVWUPO3l3MVf/Hf6jz6Va+9PysQ==
X-Google-Smtp-Source: AGHT+IFxCfHwEy321Bw8EBQt293rqr5m34pmJLEgFglHcCaIk+ih11NQYLPeHDvPTI9jJvdqYBjNuQ==
X-Received: by 2002:ac8:5885:0:b0:456:94fe:dcdf with SMTP id d75a77b69052e-45b5def4674mr65467061cf.35.1727329814538;
        Wed, 25 Sep 2024 22:50:14 -0700 (PDT)
Received: from denia.c.googlers.com (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5264b629sm22406781cf.64.2024.09.25.22.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 22:50:13 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Sep 2024 05:49:59 +0000
Subject: [PATCH v7 3/3] media: uvcvideo: Exit early if there is not int_urb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-guenter-mini-v7-3-690441953d4a@chromium.org>
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

If there is no int_urb there is no need to do a clean stop.

Also we avoid calling usb_kill_urb(NULL). It is properly handled by the
usb framework, but it is not polite.

Now that we are at it, fix the code style in uvc_status_start() for
consistency.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_status.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index d8d5b327693f..c7901ac32c26 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -308,7 +308,7 @@ static int uvc_status_start(struct uvc_device *dev, gfp_t flags)
 {
 	lockdep_assert_held(&dev->status_lock);
 
-	if (dev->int_urb == NULL)
+	if (!dev->int_urb)
 		return 0;
 
 	return usb_submit_urb(dev->int_urb, flags);
@@ -320,6 +320,9 @@ static void uvc_status_stop(struct uvc_device *dev)
 
 	lockdep_assert_held(&dev->status_lock);
 
+	if (!dev->int_urb)
+		return;
+
 	/*
 	 * Prevent the asynchronous control handler from requeing the URB. The
 	 * barrier is needed so the flush_status change is visible to other

-- 
2.46.1.824.gd892dcdcdd-goog


