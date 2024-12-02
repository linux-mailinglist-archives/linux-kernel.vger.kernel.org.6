Return-Path: <linux-kernel+bounces-427814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A891F9E0638
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 698EE287066
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03355204F6D;
	Mon,  2 Dec 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3J9x6Vea"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57A2040B0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151915; cv=none; b=ihmdNH1abLjEDqCpuxS9IWhb3ADfwGBm+4q2AQA2RVgpHRFbzU19Ue9b3tJJ+l2AVBQA/DweW9p5TQ5XytG/HyLo17wt7XyVKZqr2zfaN4GApbM4QHkovIRvIOu3e4Dy864lIERVzpFt7fQ+WOCNeIX/LoxsLwzJpSXlaa6WVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151915; c=relaxed/simple;
	bh=kNGiCZdzIlXUf/Hf8biWZP3yf+DnBInMTrMFp3DPZ0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvUoDA8FDIAJExbG40K59XSdPcgEiESrpVN/6zTcpGCLAtnje8WeSAS0H+pQb38kbIQ+6EG1SIpJwQk6DE6ryedZpNGG35wjRueIkVyXpgvotOyzb3AY93mJo7xN8IJoLuxQzBWZrcw5nYMUQrUBT6pVQBvuqFGaa03DysDGAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3J9x6Vea; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6681e92b1so319963185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 07:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733151912; x=1733756712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bfBZkGGwd+WXNqsHeftulIPKfKwX0tDqU4K/BD6pObg=;
        b=3J9x6VeanEqZqOkRoR5c0ePE5rO03WvfeReZmDAQkzwoSk5YeqG5kcsqTbXuQurDgf
         bo70t4MW/JZA/rDFCnY427wsxhAbSGXUNuWPfLTsT2FkOBHqfRsWm7UulCK9pY18Uz15
         jBFV2rHgrukvGrZZYw6eN8wdrfgy2pVPRJzlmFO3ddOcvw/aQGuTFGwU2xOgHIMV4myQ
         JTshWDZcydkE5P1sE97Fd9qCOkC5vFcQW0Dxx44ze61pInVa9HkFvBV6/vpNbnuPpo5H
         9e66cVPq0bUkJVxc2ZNLZc29lswYYQRroUxWrroeaydpVJyfDzJ/sq1Um5zSD5EAi6Os
         xQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151912; x=1733756712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfBZkGGwd+WXNqsHeftulIPKfKwX0tDqU4K/BD6pObg=;
        b=Bfwy7qO8gXo2BdottdSsmdS2HWSkPvjVJQ44+LpuQvC5SlKkj9Mqp+zNm9bmabYWzc
         DfO3uph4URM0B5TrAKHQssDQuAI9XX4VeLP1CZKKA6WlIG4Oxiat04VFgT7HgLsL6Zbq
         0l/A68GDit2XfpdCsmdq+qY9aSkOAQIO3gbv/7MkXzKlB80r+p6NWJqscn0qEIur7uTe
         fZqxzFntPDjwhpbrkmUWSYFiA2T+mgfcEY5KB4HQ1TQKphMN6A0OOFZEK5RCWtr6xe1Q
         2TtePDWjzyV4FSSYsuml+VOWMbClEFbnpyhtg7oiqgREVU2h8cRUKMjntnzD3x7GDvTh
         r5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV5+oCFkwXVazNLJ7Ul0HaaFZoLX99Dgd5jWK8fwiV5ic0+lkVrVUooghqkFg8yO+FXRpcXVowXEpP3sWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIZKl3CdEY6NmcNnpNBFb/d+RIIfP/W3C/hYOKlQFv/yWKXaq
	YCj9j3hmvEKXUnHw6s5HjHNyz3XZoxpSNd5JBL/jtDl2YWFIu9LGU2V9L01qfAWJ9O8j4xsNW2u
	hdNURTfSzppgWwjJVkHfDiGdHLka3l1PrHsE2
X-Gm-Gg: ASbGncsls6oTs5ChQd2UNvBIkHVbQHWWhAZ3zG5JiS7PnY2WcUJUQP5C8B6h9hJFoYp
	nGgY1SWNPpLaqEfT8pMw5isuDGDtFTA==
X-Google-Smtp-Source: AGHT+IG9Nz7EUYJBmLwTEZx7xuhK780YVC2j26Mdb+DOgr27uTLe/GvC8A8DFrnSF1rOzPtzTKtw+7qHiQR+ULbiPac=
X-Received: by 2002:a0c:eec9:0:b0:6d8:9124:8795 with SMTP id
 6a1803df08f44-6d891248a01mr148347966d6.1.1733151912026; Mon, 02 Dec 2024
 07:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain>
In-Reply-To: <60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain>
From: =?UTF-8?Q?Beno=C3=AEt_Sevens?= <bsevens@google.com>
Date: Mon, 2 Dec 2024 16:05:01 +0100
Message-ID: <CAGCho0Xe-jGcanAxehP+ENmrG0Otq5DzQO-yKHx7Ot_UzSRXWQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: Fix a DMA to stack memory bug
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, wangdicheng <wangdicheng@kylinos.cn>, 
	Manuel Barrio Linares <mbarriolinares@gmail.com>, Lianqin Hu <hulianqin@vivo.com>, 
	Shen Lichuan <shenlichuan@vivo.com>, Cyan Nyan <cyan.vtb@gmail.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Mon, 2 Dec 2024 at 13:57, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> The usb_get_descriptor() function does DMA so we're not allowed
> to use a stack buffer for that.  Doing DMA to the stack is not portable
> all architectures.  Move the "new_device_descriptor" from being stored
> on the stack and allocate it with kmalloc() instead.
>

Thanks for fixing this. It looks good to me.

Note that the commit that is being fixed is already queued for
backporting, so I don't know how this usually goes then.

> Fixes: b909df18ce2a ("ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices")
> Cc: stable@kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  sound/usb/quirks.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 8bc959b60be3..7c9d352864da 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -555,7 +555,7 @@ int snd_usb_create_quirk(struct snd_usb_audio *chip,
>  static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interface *intf)
>  {
>         struct usb_host_config *config = dev->actconfig;
> -       struct usb_device_descriptor new_device_descriptor;
> +       struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
>         int err;
>
>         if (le16_to_cpu(get_cfg_desc(config)->wTotalLength) == EXTIGY_FIRMWARE_SIZE_OLD ||
> @@ -566,15 +566,19 @@ static int snd_usb_extigy_boot_quirk(struct usb_device *dev, struct usb_interfac
>                                       0x10, 0x43, 0x0001, 0x000a, NULL, 0);
>                 if (err < 0)
>                         dev_dbg(&dev->dev, "error sending boot message: %d\n", err);
> +
> +               new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
> +               if (!new_device_descriptor)
> +                       return -ENOMEM;
>                 err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
> -                               &new_device_descriptor, sizeof(new_device_descriptor));
> +                               new_device_descriptor, sizeof(*new_device_descriptor));
>                 if (err < 0)
>                         dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
> -               if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
> +               if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
>                         dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
> -                               new_device_descriptor.bNumConfigurations);
> +                               new_device_descriptor->bNumConfigurations);
>                 else
> -                       memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
> +                       memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
>                 err = usb_reset_configuration(dev);
>                 if (err < 0)
>                         dev_dbg(&dev->dev, "error usb_reset_configuration: %d\n", err);
> @@ -906,7 +910,7 @@ static void mbox2_setup_48_24_magic(struct usb_device *dev)
>  static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
>  {
>         struct usb_host_config *config = dev->actconfig;
> -       struct usb_device_descriptor new_device_descriptor;
> +       struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
>         int err;
>         u8 bootresponse[0x12];
>         int fwsize;
> @@ -941,15 +945,19 @@ static int snd_usb_mbox2_boot_quirk(struct usb_device *dev)
>
>         dev_dbg(&dev->dev, "device initialised!\n");
>
> +       new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
> +       if (!new_device_descriptor)
> +               return -ENOMEM;
> +
>         err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
> -               &new_device_descriptor, sizeof(new_device_descriptor));
> +               new_device_descriptor, sizeof(*new_device_descriptor));
>         if (err < 0)
>                 dev_dbg(&dev->dev, "error usb_get_descriptor: %d\n", err);
> -       if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
> +       if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
>                 dev_dbg(&dev->dev, "error too large bNumConfigurations: %d\n",
> -                       new_device_descriptor.bNumConfigurations);
> +                       new_device_descriptor->bNumConfigurations);
>         else
> -               memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
> +               memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
>
>         err = usb_reset_configuration(dev);
>         if (err < 0)
> @@ -1259,7 +1267,7 @@ static void mbox3_setup_defaults(struct usb_device *dev)
>  static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
>  {
>         struct usb_host_config *config = dev->actconfig;
> -       struct usb_device_descriptor new_device_descriptor;
> +       struct usb_device_descriptor *new_device_descriptor __free(kfree) = NULL;
>         int err;
>         int descriptor_size;
>
> @@ -1272,15 +1280,19 @@ static int snd_usb_mbox3_boot_quirk(struct usb_device *dev)
>
>         dev_dbg(&dev->dev, "MBOX3: device initialised!\n");
>
> +       new_device_descriptor = kmalloc(sizeof(*new_device_descriptor), GFP_KERNEL);
> +       if (!new_device_descriptor)
> +               return -ENOMEM;
> +
>         err = usb_get_descriptor(dev, USB_DT_DEVICE, 0,
> -               &new_device_descriptor, sizeof(new_device_descriptor));
> +               new_device_descriptor, sizeof(*new_device_descriptor));
>         if (err < 0)
>                 dev_dbg(&dev->dev, "MBOX3: error usb_get_descriptor: %d\n", err);
> -       if (new_device_descriptor.bNumConfigurations > dev->descriptor.bNumConfigurations)
> +       if (new_device_descriptor->bNumConfigurations > dev->descriptor.bNumConfigurations)
>                 dev_dbg(&dev->dev, "MBOX3: error too large bNumConfigurations: %d\n",
> -                       new_device_descriptor.bNumConfigurations);
> +                       new_device_descriptor->bNumConfigurations);
>         else
> -               memcpy(&dev->descriptor, &new_device_descriptor, sizeof(dev->descriptor));
> +               memcpy(&dev->descriptor, new_device_descriptor, sizeof(dev->descriptor));
>
>         err = usb_reset_configuration(dev);
>         if (err < 0)
> --
> 2.45.2
>

