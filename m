Return-Path: <linux-kernel+bounces-421231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 459739D8857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04685281FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1871B218A;
	Mon, 25 Nov 2024 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go3y66ix"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E076184527
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545947; cv=none; b=B4makwdtWELSXNSEqb0F7dtHth8FCZaqzJNnSotvZUMBDumZsKk14I7h1mLajcmVvsrB8XSaM/+EO/kmY5uw64lQeCJvQntOlv31xDBJlnAhr3Q0QLuIJZFgw2EVxmhR7Kcf0oVwo8pYmPy19pHKkibN/cSWBJaEoye1MSZPyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545947; c=relaxed/simple;
	bh=A93m4QWwr1DKIr9JoOdS/zRM64fTVZ/uLiSodqn6Klg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t61KO2x4OANAol05YTQqhcZ/QuNfFLfoawSeXVKMQqtVQ63OAh0AkXAt8riSRJbtt6B0AikOtUrJJ83UlH7juBM7OTIxZHFElWlwlciUzfjybiNwVJiX7SgA+JBM/S6lbEKd7nmikFvJOJF07wD+anVL+T8AFRwc2ClLn9eL/vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=go3y66ix; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732545944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ankbv3wYc8gvqXx4U+2BPWwR2ubmjjuUEkrMwtzno7A=;
	b=go3y66ix26JYqAwk4QozclNJH9QFHhBLsTe0CtnesSxGeUFry+u5r/aOC6VBV0ahAggUIX
	TMv+oclI/k0eb+vsi3Do14XaYOauQ8G6uckpYvIQnSJgS1xUTUSPb9pIftOhf2ElqPtocc
	uowyuZ2+ZnUVZaILDtYRh8s1CgydsxI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-1mKCIw08NW-hrliHEm16kw-1; Mon, 25 Nov 2024 09:45:43 -0500
X-MC-Unique: 1mKCIw08NW-hrliHEm16kw-1
X-Mimecast-MFC-AGG-ID: 1mKCIw08NW-hrliHEm16kw
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d01059bc97so2628040a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:45:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732545942; x=1733150742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ankbv3wYc8gvqXx4U+2BPWwR2ubmjjuUEkrMwtzno7A=;
        b=XZNbNetei9AufDTa7N4l2fHazV/rOm6Ekpek9PRo3l7CpnQ3+Y/jZhD67xFFcq/pyL
         OUt5MJSGwIh2Zm0+afEBV6RKcA9x4c4Mo9uRc7eNm/Jo3k9yzrHclKXTMK9ZXX9TZPZd
         mv74LF1aAheF4BLyyslOSGgb8lIWxbAWOHQXA2n6cWrIxcK+0PPqBsvdlVegz/jPRUmR
         Yd7N5P/m1WtMvrEdS7CQmqzaDi1ua02cv6O6k5ZUXZUe7yeztUqhC+XsulcJimczglI6
         U/xFswfxuVY19f1PQXPKSYUhGCNRspIVyOus4l2G6OHwvPSvpoBVk31e9rhWNH+pJHPM
         GUPA==
X-Gm-Message-State: AOJu0Yx3kgbyM1QEUCAIN7LdMnifw1J8RsVfawHu1l2e5Jw6YlCMur2z
	nvVfQ7+/EZUBOszz7D+4P/i3k07Ce5KxEnNFauahujhTtZIry7Munm+6L24v6QYY/6rue5CL0XL
	N7+udm4CqCTqO+IFUqlrc1RpVt+0TgZejYqeJQoAuO9NGf+xiQjtvmKmScQJT3A==
X-Gm-Gg: ASbGnct1tiUTxfRnvWIUkIt12KfJqX2Li3mpYNSTC0geOGVTmEJswpxluc/tk6t2dUs
	N1O/fdKhcDNoHRPRcJ9QdpPOL4mkh/xBzJkvmr3mkErIbt1yFTQCiBceA+gfk3CM41nFnIZ8Emm
	ko1UjxLM8Wza8M0ZGBUwVtyJE5apu9/RE1l40QPF3D/ckTs7lKQWlDuLSMfYkjZTgC5X4+qbNe0
	Axb1GzyUFd35ZAx4OLZ8/WbfPELdVU6j+vj/LjtkslwRjUxgtH9VyQOHLs2cG1/POoyIYvL2CnQ
	Jep4Bof1HtqiCTAbuJgEeIjIqezE9ynL6HsboTSlQSCdJTkcV4xbMW65s1rekcp0gg1OBqf/TVD
	I0wY8IN5njp0DrdjMzzVxtimn
X-Received: by 2002:a50:cc9e:0:b0:5d0:2859:e919 with SMTP id 4fb4d7f45d1cf-5d02859ec56mr8909646a12.0.1732545941976;
        Mon, 25 Nov 2024 06:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET8rHq93IcIMU2Zz0NRTpOp0eRyhh/02COfTiRk3zzxD6RqnNhH+Z5UMYzBOHbvRpOTHc3SA==
X-Received: by 2002:a50:cc9e:0:b0:5d0:2859:e919 with SMTP id 4fb4d7f45d1cf-5d02859ec56mr8909625a12.0.1732545941501;
        Mon, 25 Nov 2024 06:45:41 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c052fsm4189014a12.44.2024.11.25.06.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 06:45:39 -0800 (PST)
Message-ID: <7da09249-f2ff-4a0c-8a06-1594b02ce87a@redhat.com>
Date: Mon, 25 Nov 2024 15:45:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] media: uvcvideo: Factor out gpio functions to its
 own file
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Yunke Cao <yunkec@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>
References: <20241112-uvc-subdev-v3-0-0ea573d41a18@chromium.org>
 <20241112-uvc-subdev-v3-2-0ea573d41a18@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241112-uvc-subdev-v3-2-0ea573d41a18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 12-Nov-24 6:30 PM, Ricardo Ribalda wrote:
> This is just a refactor patch, no new functionality is added.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

I guess this patch may need to change depending on if we want
to keep the GPIO handling as a UVC entity or not.

Laurent what is your take on this, should this stay as
a struct uvc_entity; or should the gpio_desc and input_device
be stored directly inside struct uvc_device as is done for
the snapshot-button input_device?


Also de we want a separate input_device for this or do
we re-use the snapshot button one ?

Since my plan is to open-up the permission on the device with
the SW_CAMERA_LENS_COVER to be equal to the /dev/video#
permissions sharing has the downside of allowing keylogging
of the snapshot button.

Either way (one or 2 input-devices) I don't have a strong
preference.

Regards,

Hans




> ---
>  drivers/media/usb/uvc/Makefile     |   3 +-
>  drivers/media/usb/uvc/uvc_driver.c | 119 +------------------------------------
>  drivers/media/usb/uvc/uvc_gpio.c   | 118 ++++++++++++++++++++++++++++++++++++
>  drivers/media/usb/uvc/uvcvideo.h   |   8 +++
>  4 files changed, 131 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/Makefile b/drivers/media/usb/uvc/Makefile
> index 4f9eee4f81ab..85514b6e538f 100644
> --- a/drivers/media/usb/uvc/Makefile
> +++ b/drivers/media/usb/uvc/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  uvcvideo-objs  := uvc_driver.o uvc_queue.o uvc_v4l2.o uvc_video.o uvc_ctrl.o \
> -		  uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o
> +		  uvc_status.o uvc_isight.o uvc_debugfs.o uvc_metadata.o \
> +		  uvc_gpio.o
>  ifeq ($(CONFIG_MEDIA_CONTROLLER),y)
>  uvcvideo-objs  += uvc_entity.o
>  endif
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index cd13bf01265d..5b48768a4f7f 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -8,7 +8,6 @@
>  
>  #include <linux/atomic.h>
>  #include <linux/bits.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -775,9 +774,9 @@ static const u8 uvc_media_transport_input_guid[16] =
>  	UVC_GUID_UVC_MEDIA_TRANSPORT_INPUT;
>  static const u8 uvc_processing_guid[16] = UVC_GUID_UVC_PROCESSING;
>  
> -static struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> -					       u16 id, unsigned int num_pads,
> -					       unsigned int extra_size)
> +struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> +					u16 id, unsigned int num_pads,
> +					unsigned int extra_size)
>  {
>  	struct uvc_entity *entity;
>  	unsigned int num_inputs;
> @@ -1240,118 +1239,6 @@ static int uvc_parse_control(struct uvc_device *dev)
>  	return 0;
>  }
>  
> -/* -----------------------------------------------------------------------------
> - * Privacy GPIO
> - */
> -
> -static void uvc_gpio_event(struct uvc_device *dev)
> -{
> -	struct uvc_entity *unit = dev->gpio_unit;
> -	struct uvc_video_chain *chain;
> -	u8 new_val;
> -
> -	if (!unit)
> -		return;
> -
> -	new_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
> -
> -	/* GPIO entities are always on the first chain. */
> -	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
> -	uvc_ctrl_status_event(chain, unit->controls, &new_val);
> -}
> -
> -static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> -			    u8 cs, void *data, u16 size)
> -{
> -	if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
> -		return -EINVAL;
> -
> -	*(u8 *)data = gpiod_get_value_cansleep(entity->gpio.gpio_privacy);
> -
> -	return 0;
> -}
> -
> -static int uvc_gpio_get_info(struct uvc_device *dev, struct uvc_entity *entity,
> -			     u8 cs, u8 *caps)
> -{
> -	if (cs != UVC_CT_PRIVACY_CONTROL)
> -		return -EINVAL;
> -
> -	*caps = UVC_CONTROL_CAP_GET | UVC_CONTROL_CAP_AUTOUPDATE;
> -	return 0;
> -}
> -
> -static irqreturn_t uvc_gpio_irq(int irq, void *data)
> -{
> -	struct uvc_device *dev = data;
> -
> -	uvc_gpio_event(dev);
> -	return IRQ_HANDLED;
> -}
> -
> -static int uvc_gpio_parse(struct uvc_device *dev)
> -{
> -	struct uvc_entity *unit;
> -	struct gpio_desc *gpio_privacy;
> -	int irq;
> -
> -	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
> -					       GPIOD_IN);
> -	if (IS_ERR_OR_NULL(gpio_privacy))
> -		return PTR_ERR_OR_ZERO(gpio_privacy);
> -
> -	irq = gpiod_to_irq(gpio_privacy);
> -	if (irq < 0)
> -		return dev_err_probe(&dev->intf->dev, irq,
> -				     "No IRQ for privacy GPIO\n");
> -
> -	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
> -				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
> -	if (IS_ERR(unit))
> -		return PTR_ERR(unit);
> -
> -	unit->gpio.gpio_privacy = gpio_privacy;
> -	unit->gpio.irq = irq;
> -	unit->gpio.bControlSize = 1;
> -	unit->gpio.bmControls = (u8 *)unit + sizeof(*unit);
> -	unit->gpio.bmControls[0] = 1;
> -	unit->get_cur = uvc_gpio_get_cur;
> -	unit->get_info = uvc_gpio_get_info;
> -	strscpy(unit->name, "GPIO", sizeof(unit->name));
> -
> -	list_add_tail(&unit->list, &dev->entities);
> -
> -	dev->gpio_unit = unit;
> -
> -	return 0;
> -}
> -
> -static int uvc_gpio_init_irq(struct uvc_device *dev)
> -{
> -	struct uvc_entity *unit = dev->gpio_unit;
> -	int ret;
> -
> -	if (!unit || unit->gpio.irq < 0)
> -		return 0;
> -
> -	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
> -				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
> -				   IRQF_TRIGGER_RISING,
> -				   "uvc_privacy_gpio", dev);
> -
> -	unit->gpio.initialized = !ret;
> -
> -	return ret;
> -}
> -
> -static void uvc_gpio_deinit(struct uvc_device *dev)
> -{
> -	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
> -		return;
> -
> -	free_irq(dev->gpio_unit->gpio.irq, dev);
> -}
> -
>  /* ------------------------------------------------------------------------
>   * UVC device scan
>   */
> diff --git a/drivers/media/usb/uvc/uvc_gpio.c b/drivers/media/usb/uvc/uvc_gpio.c
> new file mode 100644
> index 000000000000..453739acbe8f
> --- /dev/null
> +++ b/drivers/media/usb/uvc/uvc_gpio.c
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *      uvc_gpio.c  --  USB Video Class driver
> + *
> + *      Copyright 2024 Google LLC
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/gpio/consumer.h>
> +#include "uvcvideo.h"
> +
> +static void uvc_gpio_event(struct uvc_device *dev)
> +{
> +	struct uvc_entity *unit = dev->gpio_unit;
> +	struct uvc_video_chain *chain;
> +	u8 new_val;
> +
> +	if (!unit)
> +		return;
> +
> +	new_val = gpiod_get_value_cansleep(unit->gpio.gpio_privacy);
> +
> +	/* GPIO entities are always on the first chain. */
> +	chain = list_first_entry(&dev->chains, struct uvc_video_chain, list);
> +	uvc_ctrl_status_event(chain, unit->controls, &new_val);
> +}
> +
> +static int uvc_gpio_get_cur(struct uvc_device *dev, struct uvc_entity *entity,
> +			    u8 cs, void *data, u16 size)
> +{
> +	if (cs != UVC_CT_PRIVACY_CONTROL || size < 1)
> +		return -EINVAL;
> +
> +	*(u8 *)data = gpiod_get_value_cansleep(entity->gpio.gpio_privacy);
> +
> +	return 0;
> +}
> +
> +static int uvc_gpio_get_info(struct uvc_device *dev, struct uvc_entity *entity,
> +			     u8 cs, u8 *caps)
> +{
> +	if (cs != UVC_CT_PRIVACY_CONTROL)
> +		return -EINVAL;
> +
> +	*caps = UVC_CONTROL_CAP_GET | UVC_CONTROL_CAP_AUTOUPDATE;
> +	return 0;
> +}
> +
> +static irqreturn_t uvc_gpio_irq(int irq, void *data)
> +{
> +	struct uvc_device *dev = data;
> +
> +	uvc_gpio_event(dev);
> +	return IRQ_HANDLED;
> +}
> +
> +int uvc_gpio_parse(struct uvc_device *dev)
> +{
> +	struct uvc_entity *unit;
> +	struct gpio_desc *gpio_privacy;
> +	int irq;
> +
> +	gpio_privacy = devm_gpiod_get_optional(&dev->intf->dev, "privacy",
> +					       GPIOD_IN);
> +	if (IS_ERR_OR_NULL(gpio_privacy))
> +		return PTR_ERR_OR_ZERO(gpio_privacy);
> +
> +	irq = gpiod_to_irq(gpio_privacy);
> +	if (irq < 0)
> +		return dev_err_probe(&dev->udev->dev, irq,
> +				     "No IRQ for privacy GPIO\n");
> +
> +	unit = uvc_alloc_new_entity(dev, UVC_EXT_GPIO_UNIT,
> +				    UVC_EXT_GPIO_UNIT_ID, 0, 1);
> +	if (IS_ERR(unit))
> +		return PTR_ERR(unit);
> +
> +	unit->gpio.gpio_privacy = gpio_privacy;
> +	unit->gpio.irq = irq;
> +	unit->gpio.bControlSize = 1;
> +	unit->gpio.bmControls = (u8 *)unit + sizeof(*unit);
> +	unit->gpio.bmControls[0] = 1;
> +	unit->get_cur = uvc_gpio_get_cur;
> +	unit->get_info = uvc_gpio_get_info;
> +	strscpy(unit->name, "GPIO", sizeof(unit->name));
> +
> +	list_add_tail(&unit->list, &dev->entities);
> +
> +	dev->gpio_unit = unit;
> +
> +	return 0;
> +}
> +
> +int uvc_gpio_init_irq(struct uvc_device *dev)
> +{
> +	struct uvc_entity *unit = dev->gpio_unit;
> +	int ret;
> +
> +	if (!unit || unit->gpio.irq < 0)
> +		return 0;
> +
> +	ret = request_threaded_irq(unit->gpio.irq, NULL, uvc_gpio_irq,
> +				   IRQF_ONESHOT | IRQF_TRIGGER_FALLING |
> +				   IRQF_TRIGGER_RISING,
> +				   "uvc_privacy_gpio", dev);
> +
> +	unit->gpio.initialized = !ret;
> +
> +	return ret;
> +}
> +
> +void uvc_gpio_deinit(struct uvc_device *dev)
> +{
> +	if (!dev->gpio_unit || !dev->gpio_unit->gpio.initialized)
> +		return;
> +
> +	free_irq(dev->gpio_unit->gpio.irq, dev);
> +}
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index 965a789ed03e..91ed59b54d9a 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -673,6 +673,9 @@ do {									\
>  extern struct uvc_driver uvc_driver;
>  
>  struct uvc_entity *uvc_entity_by_id(struct uvc_device *dev, int id);
> +struct uvc_entity *uvc_alloc_new_entity(struct uvc_device *dev, u16 type,
> +					u16 id, unsigned int num_pads,
> +					unsigned int extra_size);
>  
>  /* Video buffers queue management. */
>  int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type,
> @@ -817,4 +820,9 @@ void uvc_debugfs_cleanup_stream(struct uvc_streaming *stream);
>  size_t uvc_video_stats_dump(struct uvc_streaming *stream, char *buf,
>  			    size_t size);
>  
> +/* gpio */
> +int uvc_gpio_parse(struct uvc_device *dev);
> +int uvc_gpio_init_irq(struct uvc_device *dev);
> +void uvc_gpio_deinit(struct uvc_device *dev);
> +
>  #endif
> 


