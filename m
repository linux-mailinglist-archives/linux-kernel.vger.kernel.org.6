Return-Path: <linux-kernel+bounces-246926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B092C8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B6282085
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF43A29CEC;
	Wed, 10 Jul 2024 03:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPqfAlAt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720B364BA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581070; cv=none; b=gKyMFjnR70gbSiKjGMmR5IxTvfMBOsubK7DwTvWpxwO21VqI8T2LZiOYnXF/eLAELWNhyMI9/9YWWMRCnTfkh7CSYaWp21T8vo1vs1urSAAafF48A7ljcxRGg23X6dErOFrwE75v++f/ct+VuNTxbJGCE+XM/sy88rB1jbkS+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581070; c=relaxed/simple;
	bh=Brip5FaXwQSB5D6viWoAEJQjzdOuVYWrAXox5Ir7vew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yx6DlUJaPCg+6xVa7X3PuU1nJw7b4XfqfHQN+Bp1LW0FtgFAFyggHoQsRZS29xC9iRsXPIU49xW/whisj+xTsXbAjWT9YPDUrCkuQ6TS4yJx5EbFPuQJ7CDwbpO5fgoAS91bWJLZ/JiKEZ9LXwGQbu9kRIel0nojJ2YZaDcD3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPqfAlAt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720581067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3q2k0aK+nHm0+rP8SX0FxDxoWTsYNIFUUylFS3XcLTg=;
	b=ZPqfAlAtZIhl0od3QRRyhjwlOEkaRxC/AZON7mdvTZwcxVjldhB9E4qyGCWoK5/Mhose25
	2VosuVWAYBgVpdPlobyK9sEDuyDWwacIlRZk7uiNAhRI+rEwItskYrL6ISfyDwYWMF9I2K
	2Y9mtVk16DjK69OgZOf8/zhdluLL7Vc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-M-lLVbdjOQKjkHBK-ikuXw-1; Tue, 09 Jul 2024 23:11:05 -0400
X-MC-Unique: M-lLVbdjOQKjkHBK-ikuXw-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-75ea23782f5so2855538a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581064; x=1721185864;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3q2k0aK+nHm0+rP8SX0FxDxoWTsYNIFUUylFS3XcLTg=;
        b=ZB9kRs4fsgv+nb5q+RKSbnEFlN/Hum0fzZnBlTuOT02vOwcwY1XSHpVgi6n3lSm2o2
         BA2Dxt6X2TnH1/jBoXQtHTBAqphxSDuVuUggGVkyWkz5jjo5rlmOcGflt2F1J/2vmqrw
         W8D/bIvHMYIyFD3WzfUJCDQwHeky2UeVbylmXfPnOS4PazH41dK19zppyTuzY/WhvGUU
         EvYcz7OL9kE/VsOqmFwbviR+dOdqfAc4K8UBNMAvTFF9C8JMKr/TBMeCWhGLNZac05oH
         DJq8J54tyq+JhXkpYjwEkJtJYlyOz5eFy8IKbmLNrG4FnaW9I8zG+WzZMXIE6Khke9pW
         VNzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMENjihTJsg5h4UlQ3Q2SxcorAyCF7dUE7ZNAX5XaVXBQvEjw7DbLPqnzQH+DQ6prjvvwUrHbbPGVSc6OwtLY9OnCrRe9TVmMfCnvu
X-Gm-Message-State: AOJu0Yw1YcgV7Y7Nxlfs4RFC/xFxIIvGLG04w6m9IYqNjVOfCjmBHmF4
	XwvxPYcbDr1m+qZ5NC27d3pG+U6SgZg14BDHnfebTxBgBXXzRcSIL1Vf285WLmrYf0X/7u3AtKO
	9WW/erY1fsrE3FHh91w+VYmwolV5mKgpwCsKZ3810LWe9EKOzAmRbxSmvViVrpg==
X-Received: by 2002:a05:6a20:12ca:b0:1be:c947:f17a with SMTP id adf61e73a8af0-1c29821fadfmr5199435637.24.1720581064297;
        Tue, 09 Jul 2024 20:11:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwXqK/RmBGtKXJTYs/VK3YJiSgKXG7DZ9QplJpn6ejNV3sduoK9f1h6m5vA8ggf0/vGgDOeg==
X-Received: by 2002:a05:6a20:12ca:b0:1be:c947:f17a with SMTP id adf61e73a8af0-1c29821fadfmr5199425637.24.1720581063908;
        Tue, 09 Jul 2024 20:11:03 -0700 (PDT)
Received: from [172.20.2.228] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a0fc38sm23180415ad.17.2024.07.09.20.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 20:11:03 -0700 (PDT)
Message-ID: <e9658837-1613-4277-8b21-867f48d34cd9@redhat.com>
Date: Wed, 10 Jul 2024 05:11:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio_balloon: add work around for out of spec QEMU
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev
References: <cover.1720173841.git.mst@redhat.com>
 <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <14b1a2a1acfcaf6d519db8c67f6f207d7cdd7c3b.1720173841.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.07.24 12:08, Michael S. Tsirkin wrote:
> QEMU implemented the configuration
> 	VIRTIO_BALLOON_F_REPORTING && ! VIRTIO_BALLOON_F_FREE_PAGE_HINT
> incorrectly: it then uses vq3 for reporting, spec says it is always 4.
> 
> This is masked by a corresponding bug in driver:
> add a work around as I'm going to try and fix the driver bug.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 9a61febbd2f7..7dc3fcd56238 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -597,8 +597,23 @@ static int init_vqs(struct virtio_balloon *vb)
>   
>   	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
>   			      callbacks, names, NULL);
> -	if (err)
> -		return err;
> +	if (err) {
> +		/*
> +		 * Try to work around QEMU bug which since 2020 confused vq numbers
> +		 * when VIRTIO_BALLOON_F_REPORTING but not
> +		 * VIRTIO_BALLOON_F_FREE_PAGE_HINT are offered.
> +		 */
> +		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
> +		    !virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
> +			names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "reporting_vq";
> +			callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = balloon_ack;
> +			err = virtio_find_vqs(vb->vdev,
> +					      VIRTIO_BALLOON_VQ_REPORTING, vqs, callbacks, names, NULL);
> +		}
> +
> +		if (err)
> +			return err;
> +	}
>   
>   	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
>   	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


