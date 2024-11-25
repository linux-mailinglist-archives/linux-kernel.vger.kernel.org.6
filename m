Return-Path: <linux-kernel+bounces-421338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071D9D89F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B54AB2C399
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3E91B4126;
	Mon, 25 Nov 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4fuiLOo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F367028689
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550313; cv=none; b=N4NWsw+sJJ/Aqn0Rpb4yKxHcIObrsznFTOl1Sx6j95yoS/9T9lJDZMEXIcmyiFhELsoHyTlR0nXjaxB9jdqublWmEqAdDQzDQ7AukfraQ7uWkfnBuWssTvgN7FxXFrG/UZEmShuLAQrR3bneuu8/0JKnVpTxMzkI4OG37tNE9us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550313; c=relaxed/simple;
	bh=n9nsHQU/q3zmY1nwn5s/Sbu8AryLW47j2njd18hXIzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbcHIo2qiNF2ItoMTqR1UR/Ce2lQonLG06ytdegMA9z2Ny+ADjptFnnirqC7bkX4eULIwjbCSC6UjItIWumZ2PHFQ8pMfOdENZZmT/I13hzVzSBV2TpKk1jUP5z1i5sRUKQ3/di8hz3PJiE9yw2MI2Bw8dCKBRBVF18Zs5xxA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X4fuiLOo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732550310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZZEqh+fB722kR+ORsr9nW0uQ3VjG3C3wXwryfTwc4o=;
	b=X4fuiLOoRK0UhkuwoBGNGv4VRJ/0GF90fg8X8xm+Aw+BWmx47gR4j417TjFJGrppmkfvL3
	1EybVG2wBFdqE4ZehOKWWkwIIPDxTuRu7Hw3CUYEradTYwoknJe4PjRmqpdNIu9UIP9KxB
	eVVVwNH153i95ViMvp5saul6XA+T7DQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-UfbhtdWGMdGUhNc4i0M9GQ-1; Mon, 25 Nov 2024 10:58:29 -0500
X-MC-Unique: UfbhtdWGMdGUhNc4i0M9GQ-1
X-Mimecast-MFC-AGG-ID: UfbhtdWGMdGUhNc4i0M9GQ
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d035c8f3afso1775151a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732550308; x=1733155108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zZZEqh+fB722kR+ORsr9nW0uQ3VjG3C3wXwryfTwc4o=;
        b=WkNopEYNKJzOA06XnR6EM9QeHeOCZhxtgchJifJUacYfDn+SkXP3WnzFu9mY7ZQEEc
         xSGsxaa9lnGq/NnLT0c8c/wf/e+nzWVtOTlhs10Pk+J0WMSf8NZ7nhGgGOvFvJSx0xhB
         pBJOtK/JtfheS8hxLkf6OGWUgReDmBuDD0OA74W0rYhCK/dw4PYuR2io09pSkYe88yYx
         9RE8GOhmyk55MlKyGjt59TivvUDuLvvXOhLci8hRYSq2JX1sfhSzb2HMx0iZz7x/iHe6
         3WIzthw8TThdz2aLzhhQljclHTRoEpE6YmKW0Mgn6y5KIWa8Df5NEJINTL3oFhlCJkPF
         8BiA==
X-Forwarded-Encrypted: i=1; AJvYcCX6ZSLdbaCQiR7ASGEmzHvn+7jp61ka+IyZzhHiZw2fIazxuhA35wpHiR+XqjSipisg/1MuWkeyd9DFzks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn3916gW95hNqpdoQRqO9LkFkcWkoJ4//rwZtY82iqZkLIoBdt
	XX33hDT7R6nyKGJaWtfRbEejwdWhINBrTNXa9y74oJwbX7pv6SAm475OhkM4orAznByCOUgY4+Q
	BjpKg4Fb+NAHUI+1r4QxduP4WjTJgtPnKoayNbh8Jr63em4O/FNM/hvAbIQmCjA==
X-Gm-Gg: ASbGncsZVBOZFmPbWaRRAbcAUavfop/DJ1ffU4+sukikYUa8MkpIZb0x0093v+q8ruJ
	/yXzYHOY/zAm8Of+Oq4FgVulI+5p20Ve3l5wp6F966++aHJ2i4/Tq9lOZiJ5AvWi7bCWJud1R/e
	60w1CkT0Ojk2N2CKiUxEQNtewIPISogvDG1SYQcRIN+Wc91UhWk5Z73PQCpuSpbAjEB2rBWXIW2
	0HLCxn3rLGuvXzR3lgmH7M8mcW1wbe73hZDCcG7KUrFI/uqkXOKZQqPm/59Jw4y+Xb0b2WfksVG
	/QVR/9dJk3qmiF23CwRcyPP89FQM4y6KC9jPzrqZO3ZqC/0Ku8UJxT957JvIyaTQ5KjeKQajrya
	W6nF4Gozw6qCO+zSl2HE2qjxp
X-Received: by 2002:a05:6402:40d2:b0:5cf:c188:81be with SMTP id 4fb4d7f45d1cf-5d0205de24bmr13356969a12.13.1732550307833;
        Mon, 25 Nov 2024 07:58:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXcQ2J9BAdoBQsYcHjaOgnNAXgrgaeYpF7lcRavj36a+9OA6UPm0GDCsEzeRAO8Ia7PwUe7w==
X-Received: by 2002:a05:6402:40d2:b0:5cf:c188:81be with SMTP id 4fb4d7f45d1cf-5d0205de24bmr13356944a12.13.1732550307466;
        Mon, 25 Nov 2024 07:58:27 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d02217169asm4234224a12.73.2024.11.25.07.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 07:58:26 -0800 (PST)
Message-ID: <451d1f96-f3d8-47f9-a8a6-d0a98c71901c@redhat.com>
Date: Mon, 25 Nov 2024 16:58:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 06/19] media: uvcvideo: Handle uvc menu translation
 inside uvc_set_le_value
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-6-64cfeb56b6f8@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-6-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> Be consistent with uvc_get_le_value() and do the menu translation there.
> 
> Note that in this case, the refactor does not provide much... but
> consistency is a nice feature.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 77f7058ec966..c975e0ab479b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -939,6 +939,8 @@ static void uvc_set_le_value(struct uvc_control_mapping *mapping,
>  	int offset = mapping->offset;
>  	u8 mask;
>  
> +	if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU)
> +		value = uvc_mapping_get_menu_value(mapping, value);
>  	/*
>  	 * According to the v4l2 spec, writing any value to a button control
>  	 * should result in the action belonging to the button control being

There is a:

	if (mapping->v4l2_type == V4L2_CTRL_TYPE_BUTTON)

below this comment block, maybe put the if (mapping->v4l2_type == V4L2_CTRL_TYPE_MENU) below
that as "else if (mapping->v4l2_type == V4L2_CTRL_TYPE_BUTTON) ... "

Or maybe make this a switch-case on mapping->v4l2_type right away for future
special handling of other types ?

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans






> @@ -1988,23 +1990,23 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>  		if (!test_bit(xctrl->value, &mapping->menu_mask))
>  			return -EINVAL;
>  
> -		value = uvc_mapping_get_menu_value(mapping, xctrl->value);
> -
>  		/*
>  		 * Valid menu indices are reported by the GET_RES request for
>  		 * UVC controls that support it.
>  		 */
>  		if (mapping->data_type == UVC_CTRL_DATA_TYPE_BITMASK) {
> +			int val = uvc_mapping_get_menu_value(mapping,
> +							     xctrl->value);
>  			if (!ctrl->cached) {
>  				ret = uvc_ctrl_populate_cache(chain, ctrl);
>  				if (ret < 0)
>  					return ret;
>  			}
>  
> -			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & value))
> +			if (!(uvc_get_ctrl_bitmap(ctrl, mapping) & val))
>  				return -EINVAL;
>  		}
> -
> +		value = xctrl->value;
>  		break;
>  
>  	default:
> 


