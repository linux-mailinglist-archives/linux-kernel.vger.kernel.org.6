Return-Path: <linux-kernel+bounces-527918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 277ECA41149
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B433AB81F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493A19068E;
	Sun, 23 Feb 2025 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oCpFF9e7"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E9155743
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740339165; cv=none; b=sNy5CBPXMsCdkKDwFHIj+t7/qAP0RkkwT6OzIT0BQHScTEITGIxRyR+8yyui2V8lHCzdBX5KA5ZTyDWOyxjFkySWBqwuvVZbPtokUyMft0slZoTsgQO1kanDJp8Ldbkcf6DrF3tSEZjEGyBSA+xsOGlzWut800tgMhF9yOkUyu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740339165; c=relaxed/simple;
	bh=ZAUvJY754rggryTC2ahWK68Vo7OkVEGJzzBE/hxnpps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjFcl39GI6Im/RP2rpcccQtTOWA9yXmeVi19wKR1bqq9vZBCwrbRHv6YNN/xwhsYlZSOFdc31e7PC/lO2EPMbYibFAzcUR2MjZSQi0dQ1bUrcpHaXdKx2EduK1aaFeKpk5livri7jDdQKL/dAouUr4rWvIvQUBHdDG29ZuMqz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oCpFF9e7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54622e97753so3462439e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740339161; x=1740943961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7zznMgxYxrARWKQINL/Oo45oo2+34QKcLqU//MIFPe8=;
        b=oCpFF9e7ULcjVf5LUjvjq9fjuha6azUVoja59/KPFXjh1smz8+q0gyxJmyDxgYVy8u
         /x+Z9ZQja5MI2bhfz6UjqfFIgKbP1qiHnzeRYAfBLvyy9IInIjYmIwariw/G9uSZCpVA
         gPkfc6yGQgfg6JUBi3S8HomkvDJ52+AKQT5D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740339161; x=1740943961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zznMgxYxrARWKQINL/Oo45oo2+34QKcLqU//MIFPe8=;
        b=k3uROaCdeiIBx4zi/AS073UIOnuuYR/TaYFm9Nr5PhYvigNHBYkjtzJ/EReepac4WH
         MkYLrbO3cbeIbdpPz7hGHAGJVAEwpGfV7a2IlP8ob7Ul283n4F6x3XDWIN0VVAlrU/UW
         ybjH2P0p0cwDdy80RJTSzS7/0i9thogIgFCkHLae+3P12nitz5duTsurk+/bjGGUTl8f
         4m6rcPfPx9AcDnG0GutRb7mD9mY8+7w/UPR3w5HqTzZ5rj48Of1x9RzyfVyt0iKJdznt
         jbx+WpmKML5fYZ5DYKcfuS2jnh1G/+ykk+V1k56+BfIyh779Fd0LIz8o3gQleMM2dsU/
         4nAg==
X-Forwarded-Encrypted: i=1; AJvYcCXC6IsMN5Vfr1KvdAa/pJGGpXmNUHEgP8xfYGfIQz3ajECcpOgHD39jP8KtJ7oq2FjnfXxmvNqA9pzZB5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTU27RieKZguTlvadcVHISA+Voon4we22248xfevXE0NE9jVt5
	fIXOPxa0L4/TCWmbVtTTP0ahp4T4KfEnWZO2hmDr8djsjixRB6zdDrTuDCV3OZNNm95WXAtyVoe
	ccw==
X-Gm-Gg: ASbGnctrXHRiqr819/ymuqb8rEJeWZjSEe8QER1kiioUjyhkVNjwpU6087NUcKJI8pA
	es70TxCn7pCtq9v8wxeDnR0Wpon3Dzu/dM/G0OO0/0eYlQSEiTD9+F2ODdHNeZ0xdo5mpH7c4IH
	A+QlU7Vq6JkX3gcMSO64B2D9euqUAhr3XGHApxZy3LI8zhukKy2Cj01+JLnwYPDdvyCc8JFEZtv
	2/Db57A/9L4gTVX/ZIqcBm3eRfJAZWQgNZy7F4+hXP9vdX9UN+ciSwh8LJoMsKtffyuiSkU3Ipx
	waYSoB21twr3R8ut6pzlEW7TeTEL467MzpyKJIKVbpYCQDldhrRyjM4ECP2y9DMd
X-Google-Smtp-Source: AGHT+IFVQ/z5ZNshR9r/PyYqiaweb3aDCBC379agwprLy4pEsYdzeWFiYySDczLzcBS88JJWbfv95A==
X-Received: by 2002:a05:6512:3f17:b0:545:8c8:30f2 with SMTP id 2adb3069b0e04-54838c56e44mr3897283e87.1.1740339161295;
        Sun, 23 Feb 2025 11:32:41 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5461a4c5d48sm2433929e87.147.2025.02.23.11.32.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 11:32:39 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54605bfcc72so5459783e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:32:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQqBx45UYzRFlb3CqyAetMeFKXua4exYgPzYhXwD8KGp4OHDVBtHyiMCg+7JUKJSNfGHUXCePxacVWte0=@vger.kernel.org
X-Received: by 2002:a05:6512:138c:b0:545:2cb2:8b25 with SMTP id
 2adb3069b0e04-54838c72c15mr3279598e87.14.1740339157875; Sun, 23 Feb 2025
 11:32:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129-uvc-eprobedefer-v1-1-643b2603c0d2@chromium.org> <20250223143617.GA27463@pendragon.ideasonboard.com>
In-Reply-To: <20250223143617.GA27463@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 20:32:24 +0100
X-Gmail-Original-Message-ID: <CANiDSCupq4A=ctR=Kkp7VxB+gvw=Z8MdDZHDShVMMAzms0VUAg@mail.gmail.com>
X-Gm-Features: AWEUYZk4BCUlhZfDAEyMq_DXEXIN0g964L9anV-yYjRBNI9yv9NV-k2f4kKSGpc
Message-ID: <CANiDSCupq4A=ctR=Kkp7VxB+gvw=Z8MdDZHDShVMMAzms0VUAg@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Fix deferred probing error
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Feb 2025 at 15:36, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Jan 29, 2025 at 12:39:46PM +0000, Ricardo Ribalda wrote:
> > uvc_gpio_parse() can return -EPROBE_DEFER when the GPIOs it depends on
> > have not yet been probed. This return code should be propagated to the
> > caller of uvc_probe() to ensure that probing is retried when the required
> > GPIOs become available.
> >
> > Currently, this error code is incorrectly converted to -ENODEV,
> > causing some internal cameras to be ignored.
> >
> > This commit fixes this issue by propagating the -EPROBE_DEFER error.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_driver.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index a10d4f4d9f95..73a7f23b616c 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2253,9 +2253,10 @@ static int uvc_probe(struct usb_interface *intf,
> >       }
> >
> >       /* Parse the associated GPIOs. */
> > -     if (uvc_gpio_parse(dev) < 0) {
> > +     ret = uvc_gpio_parse(dev);
> > +     if (ret < 0) {
> >               uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
> > -             goto error;
> > +             goto error_retcode;
> >       }
> >
> >       dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
> > @@ -2328,9 +2329,11 @@ static int uvc_probe(struct usb_interface *intf,
> >       return 0;
> >
> >  error:
> > +     ret = -ENODEV;
> > +error_retcode:
>
> This isn't very nice. Could we instead also propagate error codes from
> other locations in the uvc_probe() function ? If you want to minimize
> changes, you can initialize ret to -ENODEV, and turn the (ret < 0) check
> for uvc_gpio_parse() to a (ret) check.

Not very nice, but easy to backport to stables. What about a follow-up
change like this:

index c93abe2367aa..8c67feca1688 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2261,7 +2261,7 @@ static int uvc_probe(struct usb_interface *intf,
        ret = uvc_gpio_parse(dev);
        if (ret < 0) {
                uvc_dbg(dev, PROBE, "Unable to parse UVC GPIOs\n");
-               goto error_retcode;
+               goto error;
        }

        dev_info(&dev->udev->dev, "Found UVC %u.%02x device %s (%04x:%04x)\n",
@@ -2285,24 +2285,32 @@ static int uvc_probe(struct usb_interface *intf,
        }

        /* Register the V4L2 device. */
-       if (v4l2_device_register(&intf->dev, &dev->vdev) < 0)
+       ret = v4l2_device_register(&intf->dev, &dev->vdev);
+       if (ret < 0)
                goto error;

        /* Scan the device for video chains. */
-       if (uvc_scan_device(dev) < 0)
+       if (uvc_scan_device(dev) < 0) {
+               ret = -ENODEV;
                goto error;
+       }

        /* Initialize controls. */
-       if (uvc_ctrl_init_device(dev) < 0)
+       if (uvc_ctrl_init_device(dev) < 0) {
+               ret = -ENODEV;
                goto error;
+       }

        /* Register video device nodes. */
-       if (uvc_register_chains(dev) < 0)
+       if (uvc_register_chains(dev) < 0) {
+               ret = -ENODEV;
                goto error;
+       }

 #ifdef CONFIG_MEDIA_CONTROLLER
        /* Register the media device node */
-       if (media_device_register(&dev->mdev) < 0)
+       ret = media_device_register(&dev->mdev);
+       if (ret < 0)
                goto error;
 #endif
        /* Save our data pointer in the interface data. */
@@ -2334,8 +2342,6 @@ static int uvc_probe(struct usb_interface *intf,
        return 0;

 error:
-       ret = -ENODEV;
-error_retcode:
        uvc_unregister_video(dev);
        kref_put(&dev->ref, uvc_delete);
        return ret;


>
> >       uvc_unregister_video(dev);
> >       kref_put(&dev->ref, uvc_delete);
> > -     return -ENODEV;
> > +     return ret;
> >  }
> >
> >  static void uvc_disconnect(struct usb_interface *intf)
> >
> > ---
> > base-commit: c4b7779abc6633677e6edb79e2809f4f61fde157
> > change-id: 20250129-uvc-eprobedefer-b5ebb4db63cc
>
> --
> Regards,
>
> Laurent Pinchart

Let me know what do you think so I can send a v2 with the change
proposed by Doug.

Regards!

-- 
Ricardo Ribalda

