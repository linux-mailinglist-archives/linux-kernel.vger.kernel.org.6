Return-Path: <linux-kernel+bounces-541930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4863BA4C38A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234C13AC968
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CBB33F6;
	Mon,  3 Mar 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0gwdqmY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8804820F086
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741012657; cv=none; b=qrlWzthUdov914symi7IQ/4ndImfvDPaTeOAt3sEE/kf1I9jKiXEi72KxQEYkdwvt/MO0iX5S8jF9NiNWa19kdzdWrnEGH16UsWfF1bX1dvzkqOKt6cryxkfq7BW/Z2Yf30cgN3/beH0+wkdPIWrlXnu3nDG76BqiTz9Pz1Z4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741012657; c=relaxed/simple;
	bh=TfOXMpBObOpEU6afGJtTBzSD8HAl5um0orBw1XOeFsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyZ/D68MOmMLYZbYhBHM4BjTjo33j1uQvi4fr8ykTWMAdREfmPjBbxecEfZNwkWonkFrWpM8YzDMXsvBWMv1YM3ELyTyQz9jyHidjMeVKGvDYRDd5GSu3M/4FXczQpjMHzZp2aaSLl4vYaX0H2tromXCAByxxYBrb06iS0rs1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0gwdqmY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741012654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JeGJDQQ0J7/ssTaE+NatAO0lrGt6/z3dtpI/4Izuzo=;
	b=V0gwdqmYuDN/+HeV5a4VyCqHC5qA0vqNOJd4o+ckne/IP2II8U/DkFzpDF9up2UnYylA2w
	CVeamopUTVmwiMlYqY3VNUafso6S0pTLWjTJ/VH6NbpllslI9MxdWoUibV3Xt2137XecOw
	BVN4qhpdP+Xki4/V5v9z5cOwUf6zRss=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-C1sLhwwKNS6pbIPxam78AQ-1; Mon, 03 Mar 2025 09:37:31 -0500
X-MC-Unique: C1sLhwwKNS6pbIPxam78AQ-1
X-Mimecast-MFC-AGG-ID: C1sLhwwKNS6pbIPxam78AQ_1741012650
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf748e5f18so130587566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 06:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741012650; x=1741617450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JeGJDQQ0J7/ssTaE+NatAO0lrGt6/z3dtpI/4Izuzo=;
        b=aBTqWSgIKjNE/kzugu+cATTLXcnHC2rYwGaYcuYCSlLe/3M0Vas0ZVZceI9AZhClFk
         hZju4ZMl+n48jDkbNN3OvMofnnnRxINssrGT//Cz3wMKrxX6urnbQ/V6xZqEW/0MwIlA
         k25TzMyZI9SFOB6yVpRXLalyrOFA/1VThZrKdY/sgxPC51JYUjZlQmlnRXBQAi6ehh2S
         FdPyEkM8g3qcopW4qlfXxaLB0C4mDTZKFgBrrpUeEknn0wfRvrfQw2NTyOVrpfned6P6
         5ZG2tDwpggTAVs9K5W45wDjAVOzO7ZQIgFnKb1RSBUBc/EyNnCP+vlm+kAMpQBFVtwrM
         UEbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjMb43/cahMKD1RINKaIat23ES8MAhNOkt/5odBgKNgbA2fIDCrDv5FJ06DNCs6+nbgMMchfdUgpHWnkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ02YBEikLxo0ua4l2NA1c+7ThxBYvp9/llX9Kn6mYf74iNho1
	fA5MDcfYFUk3GABDO+wYKPV7nw4DZQVc8dei3xW9lwgDHKr9uDdLb/MCm4MWSXLizeuAfw+3A2Z
	iHbagSJfMcEYcWjouNoPxxQ90lAU+3Lmif+9QJSRCzOkp2gHyi3N9dS1CfBO0EQ==
X-Gm-Gg: ASbGncuAWka7ptJBcwI/YLhYv7Is4z3WoYw93Evfy66x4CUqsy1fwkV98lstLWHMNeR
	+iSdYzWCf4hCjhqsv7u01wfjTImGB5FAHciH/bGP7tf4GNEx7iqere2aDJ2wscMHS8Iu6DF5bof
	tv0QhQaurIrL0LwuZmGFSXZrp3F6DeJcMGxJEAOyFnfHaaVga3tTi+gafQADZrB6yybF2ejlCpc
	UqNix87xfFq83BMjchTj3F1/io+bQvPWFqPVkjg9YF+PsOYZ42vI44gNuPuQL2e9cD3TJIii+Mg
	2EmA13sen1oV3Zv10BY=
X-Received: by 2002:a17:907:60cd:b0:abf:68b5:f78b with SMTP id a640c23a62f3a-abf68b61eabmr536239166b.24.1741012649874;
        Mon, 03 Mar 2025 06:37:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHa1u+zdvCoDiv3SXFker98na2A8agZhqfoWf/EbLSUWGYSaQKN28uCrbnmaQppxKND+Sj27A==
X-Received: by 2002:a17:907:60cd:b0:abf:68b5:f78b with SMTP id a640c23a62f3a-abf68b61eabmr536235966b.24.1741012649485;
        Mon, 03 Mar 2025 06:37:29 -0800 (PST)
Received: from [10.40.98.122] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1e57faa1dsm63669066b.95.2025.03.03.06.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 06:37:28 -0800 (PST)
Message-ID: <f9246e9e-3905-4bb2-9799-90677f9521de@redhat.com>
Date: Mon, 3 Mar 2025 15:37:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] media: uvcvideo: Make power management granular
To: Ricardo Ribalda <ribalda@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <20250226-uvc-granpower-ng-v4-0-3ec9be906048@chromium.org>
 <20250226-uvc-granpower-ng-v4-4-3ec9be906048@chromium.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20250226-uvc-granpower-ng-v4-4-3ec9be906048@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Feb-25 15:23, Ricardo Ribalda wrote:
> Now that every ioctl takes care of their power management we can remove
> the "global" power management.
> 
> Despite its size, this is a relatively big change. We hope that there
> are no size effects of it. If there are some specific devices that
> miss-behave, we can add a small quirk for them.
> 
> This patch introduces a behavioral change for the uvc "trigger" button.
> It will not work unless the camera is streaming. We consider that this
> the most common (if not the only) usecase and therefore we do not consider
> it a regression.

You may want to expand this part of the commit message a bit and make it
clear that before the "trigger" button would work as long as an open has
/dev/video# open and now it only works when the camera is actually
streaming.

I agree that in practice this is not an issue since apps only open
the /dev/video# node for a longer period at a time (vs short open
for query/probe) when they actually want to stream.

Otherwise the patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 1c9ac72be58a..6af93e00b304 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -652,7 +652,6 @@ static int uvc_v4l2_open(struct file *file)
>  {
>  	struct uvc_streaming *stream;
>  	struct uvc_fh *handle;
> -	int ret = 0;
>  
>  	stream = video_drvdata(file);
>  	uvc_dbg(stream->dev, CALLS, "%s\n", __func__);
> @@ -662,12 +661,6 @@ static int uvc_v4l2_open(struct file *file)
>  	if (!handle)
>  		return -ENOMEM;
>  
> -	ret = uvc_pm_get(stream->dev);
> -	if (ret) {
> -		kfree(handle);
> -		return ret;
> -	}
> -
>  	v4l2_fh_init(&handle->vfh, &stream->vdev);
>  	v4l2_fh_add(&handle->vfh);
>  	handle->chain = stream->chain;
> @@ -701,7 +694,6 @@ static int uvc_v4l2_release(struct file *file)
>  	kfree(handle);
>  	file->private_data = NULL;
>  
> -	uvc_pm_put(stream->dev);
>  	return 0;
>  }
>  
> 


