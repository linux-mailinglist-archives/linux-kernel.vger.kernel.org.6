Return-Path: <linux-kernel+bounces-427774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9059E058F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708A5287AA8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1920CCE8;
	Mon,  2 Dec 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9qEOp6B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2119F20CCC7
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150703; cv=none; b=Q8W+JKMMouNuj8k6g4mK/Ah37qaS5KwkUPh85x6+vajSLUrFeQ94Sc9yuRbXav06D/guBqeaJGdUNfFhtDJhjkdOMpaUBnWq31xict7WeCTCuOigBZSVtLkjVDB733E6G0vJy6Bz8SuWIwkSMgHi5fXMB5A2AbjqhjosFBCsOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150703; c=relaxed/simple;
	bh=J6NojA2RZH+RoRRnvD/OYyIay8Vieq6tR0DB9lycCcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJQmSazpeP1YayBzyQXOqOY5idwXbmT93Cu06E3T9nLpCjgUThMHc6H4G6Sq8vADXl9htrlz5HAIIjmOuxstR1rd1dQldrt5APsG6axgFCJPc/ZkJ9Jz0tcRJ2MooEiVUGXdy4Qjp500uttTo0mqvBVn2PrJoTiM9CFIICGwe3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9qEOp6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qh0LHQ0l/zAThehTKofaSdXJERCbtOgQsR2kqyENj+s=;
	b=Y9qEOp6B6Nv+y7RlWvpuFIcrs2whi0EwFSZr1g9x+6P7lVhXiSfzny7fI4QLfZbtqmP1iQ
	tHFkqfTf5w/XreCLIBjNcl69lWQJIfD12eHeHMucgYC8g4eBgntfXBIQoKXk0dJnft1eDy
	yV5COqS0IOhHaQvAhZN4JSpRnpsGJmk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-pUjNwnJfO6WaCLdEmYAZAw-1; Mon, 02 Dec 2024 09:45:00 -0500
X-MC-Unique: pUjNwnJfO6WaCLdEmYAZAw-1
X-Mimecast-MFC-AGG-ID: pUjNwnJfO6WaCLdEmYAZAw
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa53f3b322eso438093266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150698; x=1733755498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh0LHQ0l/zAThehTKofaSdXJERCbtOgQsR2kqyENj+s=;
        b=teJvrNSbR9chFFqXaOj0N510ofE1ubAqMlvMyMEv5cf64TCBGf0HVfzLgtTrkjaTeH
         fxZq4MBMe5DU+AhTCBHXeJrmEk7hjkwCT9xhG25gS3k92c8B+9wwbJXHj+1hN3msHkAF
         tkYeUYq45Y5Whm0RW79bXFwm0nu6p3xgFbqM4d7ff7oyQoc4go895zdrKDLjuFA7iVBK
         kzYuPkOw50ahPPiCwZf/KeQDEK/7NnIzNj4ZjTSzbbioa2LFMnnW5/aTEJqLEVlgeImb
         n30xsHICboeoAyK0VWJzJIg/bDZwD0mnagQMMzikQ3nZRhntFudPQgj8IIYQvLwCGWSr
         JW4g==
X-Forwarded-Encrypted: i=1; AJvYcCWhXgl/ZbwJQZk5K4NeHlgbE+ExxDzPw02zqF6GW/QhFqdPWOm+BLRPiYkMqNxeOhzndZRq6fE5kU11/ks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCi9mua4RD2J8hxZslE9EOGudKC5RaT/MTjspqziUMsnSiVlfQ
	73x3M+TfstZJZ3J2EReL0bhnMeHlIcBd12gBlzLsSccG9YBPrSrFO0epp7RxlrAYMkcx8zMLkzP
	DToN13QYMCfz4yFdsEkvqEkVuTuBbFNGvdyuRNkoExue9/0Yd0pT9lyeiQKeFXg==
X-Gm-Gg: ASbGncuxEiHTi8VTW3JZlYJdhFtrku/4qfPC5sbCPTYKeUYQM/CI5YzNpqUrY31WCqS
	8MUluwIUZPrn94MeJ2lOsvHOs+W59ib4T7alcYaipsLQq+4UDJMqfkJ4i4/VMTaomF31Y3fgn3i
	VPUxlUa3AHP3IHlT2/2rhsvLj63W14mSzLXJOU5pus2E9C/+gsiBaNNkXvKbD5L29yH+AVzxuvl
	nm/9seeAXRsEu5I6yL/bx1SFDirdr+Z+4GLJU+Lrrd0onVr2NKYyA==
X-Received: by 2002:a17:907:31c4:b0:aa5:ee58:5b0b with SMTP id a640c23a62f3a-aa5ee585b94mr57507366b.25.1733150698560;
        Mon, 02 Dec 2024 06:44:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ5xsPPDw4cMz2OuXoK45oswDh5+JI1Ux9Dyy0RZYl3J0FpDJcTTmFFvcexFdg7ZUlQCxJ0Q==
X-Received: by 2002:a17:907:31c4:b0:aa5:ee58:5b0b with SMTP id a640c23a62f3a-aa5ee585b94mr57503366b.25.1733150698102;
        Mon, 02 Dec 2024 06:44:58 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c19b5sm514217666b.5.2024.12.02.06.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:44:57 -0800 (PST)
Message-ID: <0531da34-d35f-4f46-be14-a9f864f38784@redhat.com>
Date: Mon, 2 Dec 2024 15:44:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] media: uvcvideo: Remove redundant NULL assignment
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
 <20241202-uvc-fix-async-v5-4-6658c1fe312b@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241202-uvc-fix-async-v5-4-6658c1fe312b@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Dec-24 3:24 PM, Ricardo Ribalda wrote:
> ctrl->handle will only be different than NULL for controls that have
> mappings. This is because that assignment is only done inside
> uvc_ctrl_set() for mapped controls.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 576e3854be91..e90bf2aeb5e4 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1672,10 +1672,8 @@ bool uvc_ctrl_status_event_async(struct urb *urb, struct uvc_video_chain *chain,
>  	struct uvc_device *dev = chain->dev;
>  	struct uvc_ctrl_work *w = &dev->async_ctrl;
>  
> -	if (list_empty(&ctrl->info.mappings)) {
> -		ctrl->handle = NULL;
> +	if (list_empty(&ctrl->info.mappings))
>  		return false;
> -	}
>  
>  	w->data = data;
>  	w->urb = urb;
> 


