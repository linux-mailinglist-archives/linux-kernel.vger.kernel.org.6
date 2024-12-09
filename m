Return-Path: <linux-kernel+bounces-437311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B59C9E91A5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87749188776F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604CD217F5E;
	Mon,  9 Dec 2024 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gL2y2z/E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BB2165E1
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742237; cv=none; b=DfQyu6q5EjLo3FGjY3MjpDVROJLeFZ29g3CTBW2Gaw7R45h/wn0qp8d0l9SS2jQNgQdY9hS02B4D+bTwqSwPOJaaZs0FaslbvMdzQXtcWTVjQ5fnS2f1W4ftuStTjmHw4TrRihFNR0OwvP1dAauNdq6eeOQ42ss9UjrRlJdDRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742237; c=relaxed/simple;
	bh=xrEgomVVXwnBdjRTCLu5uuQJKTeAi1hJTlC/TEzDw80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOkj2ih0tMUah8G0FUucqeN7PfiCdu9/DZlnS0oau6oGZWi0ab75uqABrm6YvUgFqS8bX/4i29+3YNmjA+/SV2ZeuNxA1LQWCR1eQgUnZO1NWHna7qCT3Di8E5841MZ6PANyD38BikNuyRNTWbVi2gyRSQPM8rGpLTMiZCqdPh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gL2y2z/E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733742234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49y0zMV2jUdlIFZXvm7qDmUjzQ2LlPnBFxgIlWfWKm4=;
	b=gL2y2z/EFWT5AMw94ByigrEkrnYYtv0iJVLRGdFPDNU0pGZgmrB9jQQVrrE2mtmEKlDFwo
	AJwaMU6btR4Gebl88Slu070IgS8U+f7L2zLEtX9emNsNUH/MG2bCnQTQGQSRrpS79hS9Rh
	x23JNnwvt7cFAP2C3g7Lme4wMZtpe7o=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-c7iLpJ5hNkmPfRU_ce2hvw-1; Mon, 09 Dec 2024 06:03:53 -0500
X-MC-Unique: c7iLpJ5hNkmPfRU_ce2hvw-1
X-Mimecast-MFC-AGG-ID: c7iLpJ5hNkmPfRU_ce2hvw
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d3d2cccbe4so1827468a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742232; x=1734347032;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49y0zMV2jUdlIFZXvm7qDmUjzQ2LlPnBFxgIlWfWKm4=;
        b=GDpz5nR4pkVUtyNYKTh0mBuWXwgHEUvPta2XYXfh/sjsunVIkksDT3PHFledMWYgCm
         //n4fUZ3ZIp099S8AohuL4AcDjns4HF6EGbH9seljaOcrdpWj/F2/cIwUn5AYMK112oA
         j9kUqBw0wvmU7DaOY6AbF8glJ8A/0GDKFmJnspj5H986RszQ2nquQmz5sRwpuuOV//l4
         uXrWuQYVsuAuJ9nLWO75qqPJmXsB8Ff0SMJMCJ+jfIHoHKNC6r2LryXPoFXTTNklqfkt
         WJ6zGky8+URQERVRwQsPg0NyLDQrJAusARTs17ULSIq7nptDpBxUwjXDcPCW8zFH1w8/
         k1sw==
X-Forwarded-Encrypted: i=1; AJvYcCWlwZkTZ0HvJt79U8rudR+AZTx/B1EQoamG5MezSwr0S10Q3HzorNPOSmc5t5kL43JbILHip24KhY0mlh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/X0KRMbXu6YK0Nnn7iHAepUPd8I9K5O7GyFySvXcDKbOVk55P
	0sD1QD4oPCt9WTUB3ITN9Vbj45EIh9BgnmjF0M+F+T6gPDqyTi+qHRilSlTIa8LKWCEa/XUiDTv
	T7CuHoC/9caMlVkmYCh4qGSUnfkl3FEf5oymcN1WkCftN91027p1jhA51AIVOcQ==
X-Gm-Gg: ASbGncvTxgK30OWxX2CrbgE6MvLa1qyFahikCILbJd9Te23enSsMBzqzHq3prz3RcKm
	1nuToVcJtHY24++RZ7buIJXZaNcfcYeX8K5AOs+8kMrjFp9unjHiKP7Qqw/GPoWKeWQKAkXKZaP
	zOtbfoJ+Q7sBK7jVGct1q7djvwWsb/frpDtpAWAGszM/ECjeaMlTieNskeJiIU0XICCobe97jRL
	q3PG0u/KxP5F3mC4oLauToZd3P2Sjwz1iwsyZt1XfcXEVfEvGvmIA==
X-Received: by 2002:a05:6402:274d:b0:5d3:d4cf:fea0 with SMTP id 4fb4d7f45d1cf-5d418612f4dmr127102a12.21.1733742232002;
        Mon, 09 Dec 2024 03:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkNYdowjrz3mSpV9KDvjJ3H/wZiO0JmX+dDywJhyG14O6i1opu/Mwa++qOGEIMTia0xwIkgA==
X-Received: by 2002:a05:6402:274d:b0:5d3:d4cf:fea0 with SMTP id 4fb4d7f45d1cf-5d418612f4dmr127084a12.21.1733742231651;
        Mon, 09 Dec 2024 03:03:51 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3ea09245bsm2705074a12.78.2024.12.09.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 03:03:51 -0800 (PST)
Message-ID: <02a89566-a6f7-4feb-84c3-079795c98a46@redhat.com>
Date: Mon, 9 Dec 2024 12:03:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] media: uvcvideo: Flush the control cache when we
 get an event
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241203-uvc-fix-async-v6-0-26c867231118@chromium.org>
 <20241203-uvc-fix-async-v6-5-26c867231118@chromium.org>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241203-uvc-fix-async-v6-5-26c867231118@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ricardo,

On 3-Dec-24 10:20 PM, Ricardo Ribalda wrote:
> Asynchronous controls trigger an event when they have completed their
> operation.
> 
> This can make that the control cached value does not match the value in
> the device.
> 
> Let's flush the cache to be on the safe side.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Thank you for your patch.

It seems that you have missed Laurent's reply asking to improve the commit message:

"Conceptually this change looks fine, but the commit message needs to
explain why this is safe to do without protecting ctrl->loaded with a
lock."

https://lore.kernel.org/linux-media/20241203203748.GD5196@pendragon.ideasonboard.com/

Or maybe the posting of this v6 and that reply have crossed each other.

Either way please post a new version addressing this comment.

Thanks & Regards,

Hans



> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 3dc9b7a49f64..db29e0e8bfd4 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1622,6 +1622,9 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
>  
>  	mutex_lock(&chain->ctrl_mutex);
>  
> +	/* Flush the control cache, the data might have changed. */
> +	ctrl->loaded = 0;
> +
>  	handle = ctrl->handle;
>  	if (handle)
>  		uvc_ctrl_set_handle(handle, ctrl, NULL);
> 


