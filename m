Return-Path: <linux-kernel+bounces-437760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA9D9E9839
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE66162AC0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10081ACED8;
	Mon,  9 Dec 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="flCSm7iV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB94535973
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753149; cv=none; b=oyx7Ci3gXzIGmyH1OSOwMF2b2fVC4eDyZPYnyAxHcovTaMj8+a/GmIjvcfcZFaqFcWRS2Ye6Rzob1wuWiP0ldyF2wIjXjrAodnKx746lAHPXvfO9vc3OHx4xL9dRHkvD2hF0PjIU64b9IzylgudS7dJcsyO9IJL3IEHAsfzLWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753149; c=relaxed/simple;
	bh=acJHuaxIXGJw6YF8KF1ie6KzrYHn7K0WJ6bKJJAwMx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sq0btMuS7laOj5/g7vxv65MemSd7OJik/m6aF3PQ+E3UeN1PbPiHnTtWhyVC1CNx9a+DOmHMUshXAbezQYzQwST1/KAaYd8ypATTMIipMLCb8GZL5Ab5vgEoVZKFVAD1icXHeyMGjqSusv9xknl99+nDeUQ+t7igwpo9NKfduK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=flCSm7iV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733753146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bR5VzsU/V5aABk2Uvi+9ITDsVWeQb+wiYJ/e4jUMMoo=;
	b=flCSm7iVCvQGDSnyGoYxexifomaTgk1McaWsJlwHeoQz1khGCppyRMhYf2kSqyH2FqcZs7
	BDg6rz3kjauVQ3axPD6+KQACQb5iAV8SsmhA3kSSspNAF0Czv8Mm57Fa2GQ2lItyWRuN7L
	j4tJHXl2UJZitsRVSaahmwQvuYl/zTE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-qQHrRB5WN4WnDG694Zv3zw-1; Mon, 09 Dec 2024 09:05:45 -0500
X-MC-Unique: qQHrRB5WN4WnDG694Zv3zw-1
X-Mimecast-MFC-AGG-ID: qQHrRB5WN4WnDG694Zv3zw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa665246a3cso142709466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753145; x=1734357945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bR5VzsU/V5aABk2Uvi+9ITDsVWeQb+wiYJ/e4jUMMoo=;
        b=w6iThEi/klxzoJ6V364aF//30X19BzEvIEfhUi2AL30qqh/M1bt8lOhQ1PeybX3VX+
         9dIE4mRxXFIYFejszsKi8fMW6pSnBy1vXuWuhXlbyB7Sd/+tkYLagdw/OaJhLyiR9xCY
         6scfchDQ47zq7Mk+rMIE5MbnVmMCg0rQ1Cl8ggVfe0lWECtEuWree7A95Vx47D5W1bQ9
         xUZnQ4+Y+exLKA/Fy0rJZzLm3tH16/ngziJ1pkTFGfDA1Idmfou0LSKEfZjkgo/WDhfN
         TfCAytdnGXA7B2CMvKjtceP0zOgMTWNfntu1c20HOecjW+9qUmyOF+4bmQHZjcZJ0pXq
         KH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbvd9rN4BicEY49BPrNvyuZz7jHfch6sbRPSlxX2iULkEwx7FZt+py60q4E5ojtbotK/VNi/Qb4tswNe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvTFGIl0bDAvxWrkLrOoA2A8Q6fnqAPNR0ADcyueAeX50X+Mjh
	x3lqZF8x8eoZrHu8e+vj7qN+/OhxnnwCRzPETX0SvAkuD4NVjuzNXuOh76s2Jo+axieeuzuu2X9
	vy9E+fXwQNKC+41JvdIEHN5CegU5v1S2JR80PSj5rZpN/YahIGimfCHIrzvnAOg==
X-Gm-Gg: ASbGncvY2CtDvbdfHWO9R0pkTtQqU2kQHRfIjr2H8AmWx4YDvr3KAlOjA5gOYEpdPB1
	P5HUrDD+4jAbziNezJVUdvcUntUvHQWug16nCsl8H5oqPaxRZeKUCrdkQJ/0N7jjCIhyJSnoSgp
	jC8YDkJKlH3B53mLS1KVDW13laY6YakYKEPIauzg3dtpTRl9Km55PYJAGL5ld1yaDTUYzEVvfVv
	AHbqwdMQaxPb0S6WWWF3d3g/9UGjmzskWU3XY6ZX0gAdyAwCydyvA==
X-Received: by 2002:a17:907:2da6:b0:aa6:887a:57c0 with SMTP id a640c23a62f3a-aa69cd53836mr71385266b.28.1733753144502;
        Mon, 09 Dec 2024 06:05:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzBMNP1UMaoZxfqN84aRncoiJxbBelep0R+5LUGjYdJcC3YZj4AiE8TmDVq47czeCPt54b+A==
X-Received: by 2002:a17:907:2da6:b0:aa6:887a:57c0 with SMTP id a640c23a62f3a-aa69cd53836mr71371166b.28.1733753143331;
        Mon, 09 Dec 2024 06:05:43 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa671f14766sm287365066b.169.2024.12.09.06.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 06:05:42 -0800 (PST)
Message-ID: <1cac4857-c261-461f-9749-8c8c68a0db07@redhat.com>
Date: Mon, 9 Dec 2024 15:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 14/19] media: uvcvideo: Use the camera to clamp
 compound controls
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Ricardo Ribalda <ribalda@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-14-64cfeb56b6f8@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114-uvc-roi-v15-14-64cfeb56b6f8@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 14-Nov-24 8:10 PM, Ricardo Ribalda wrote:
> Compound controls cannot e reliable clamped. There is plenty of space
> for interpretation for the device manufacturer.
> 
> When we write a compound control, let the camera do the clamping and
> return back to the user the value used by the device.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 0dae5e8c3ca0..72ed7dc9cfc1 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2339,6 +2339,18 @@ int uvc_ctrl_set(struct uvc_fh *handle, struct v4l2_ext_control *xctrl)
>  
>  	ctrl->dirty = 1;
>  	ctrl->modified = 1;
> +
> +	/*
> +	 * Compound controls cannot reliable clamp the value when they are
> +	 * written to the device. Let the device do the clamping and read back
> +	 * the value that the device is using. We do not need to return an
> +	 * error if this fails.
> +	 */
> +	if (uvc_ctrl_mapping_is_compound(mapping) &&
> +	    uvc_ctrl_is_readable(V4L2_CTRL_WHICH_CUR_VAL, ctrl, mapping))
> +		uvc_mapping_get_xctrl_compound(chain, ctrl, mapping,
> +					       V4L2_CTRL_WHICH_CUR_VAL, xctrl);
> +

I do not believe that this actually works / does what you want it to do.

At this point we have only updated in memory structures for the control
and not send anything to camera.

Querying the control to return the actual achieved values to userspace
only makes sense after uvc_ctrl_commit() has succeeded, unless I am
missing something ?

Regards,

Hans



