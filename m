Return-Path: <linux-kernel+bounces-393543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E1D9BA224
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 20:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4083628237C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B21AB513;
	Sat,  2 Nov 2024 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UetGPaoa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB221A76DA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576404; cv=none; b=XqFSKbwZH8EszxkGEGHn7N+6DRovYIC5EBaFZhPkPVyRVfVLnIvOt5OcZrMA6ON89SxaLbx43We2Jk5NTCNNqGGPpvuphB45YtUPjqJgceuKPJVpU4HfNulUO2qBiflOwi5gnTXmQg9G/a3wMzKZl/oxZX4OJODsxrOfpz2VTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576404; c=relaxed/simple;
	bh=F6IZAEofDbdC4lDW3iu38ep6yj9FSsEE8dp6aaqYybY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1sZCTk3I0CvQzlaHtZyF9I8gNHtxMeejeqbnkuZBJ7wK9waGeLIP4FDkmc1lkGK8AoWttsSuq1dY64WQJX6u1SyOZEtIWSx3Oz+yGwirzN47C8MCwXJQpbuky/vSAl9HkzW1kCLg9ByidrRHVXzRWJfgUwwc6uAePqMtnqQ7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UetGPaoa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730576400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V3g8+26iKRPY6D+zbC3t4hy7sOkk/+U+1XxMzqY8gvI=;
	b=UetGPaoaBm8+DyF/j74pYx8nT27TtA5bbisdF9ksGO6U1EmrMs6+S8bV2nsJ/0QKUSBtEc
	FSHLCGPAVpiQxFTAM+GHhJtvXypNwjvcwk+jZKvVDYn/2gcrX6R6kciuLuJj41q8kj6kUj
	bWnLWNtwoWmeiWSwvvW0lPlje+CGwYs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-P11Ojie1MIG9DYtt5brYVQ-1; Sat, 02 Nov 2024 15:39:57 -0400
X-MC-Unique: P11Ojie1MIG9DYtt5brYVQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a0710ca24so213683366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 12:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730576396; x=1731181196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3g8+26iKRPY6D+zbC3t4hy7sOkk/+U+1XxMzqY8gvI=;
        b=UUzmEU3VkKeFAdmoojcZe3lWBbeWelYr+yD6Tae9Jt64nhJuR6sw04Tc8KCsf24I4Z
         Y8B06WRlJDvoMaJzLN2inWtbSyOkMFiJCgtaTdOPaWMTcmqIzmnl4GJ1fiKHE+nVP8c/
         vpjQuGZR21TUU9zvzdgMJ8tM/Wcard5ilPlqBZkHgg38NivD4s9tBQdKRBcmF8FxaFnT
         uZ2t0FVwCb0DXiMsZBZPPtOjA68V8zvmqeZ5otKjBqOTnzVgtbFK1bHrR7yJh6grdtR/
         Wb6QOVMWNOEgDjVpz2spsW22moY+b7khSZ0djhwqf9HV+Bb/660x2yf60+Dn54WAIVLW
         s/CA==
X-Gm-Message-State: AOJu0YwycOCPzBKBB0UHxpm+VLxG1FSZWhuUiL0v5IwzEBXrV4AGPl+k
	/+SZizhdTDoA6/PEfWN0v9Y6dnc+iv+bMhc/6HuTtBoP3/hCs1g9gAnwEV4qaOaRDo9KCCzh1fZ
	zJ+zioSK0gFl1vetWYlQwvuGY9h+MC66el9kHbuq+AzLVyUul66EhmJv6p2lBsQ==
X-Received: by 2002:a17:907:3f98:b0:a9a:6314:40e7 with SMTP id a640c23a62f3a-a9e3a5a063amr1351144166b.17.1730576396047;
        Sat, 02 Nov 2024 12:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNVFKoD8PA1DxG79/9olz+kxVoRw4fAPXTHo91VPYL1mYIazwv3WGi9wHF74EZlWsXftkaFg==
X-Received: by 2002:a17:907:3f98:b0:a9a:6314:40e7 with SMTP id a640c23a62f3a-a9e3a5a063amr1351142066b.17.1730576395500;
        Sat, 02 Nov 2024 12:39:55 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cece71fbeesm592478a12.54.2024.11.02.12.39.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 12:39:54 -0700 (PDT)
Message-ID: <b318af93-cbde-486d-854d-918b61795b1f@redhat.com>
Date: Sat, 2 Nov 2024 20:39:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/intel/vsec: Remove a useless mutex
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 srinivas.pandruvada@linux.intel.com,
 "David E. Box" <david.e.box@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <ccc08a262304f7f8c2e435349f0f714ebf9acfcd.1730563031.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ccc08a262304f7f8c2e435349f0f714ebf9acfcd.1730563031.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Nov-24 4:59 PM, Christophe JAILLET wrote:
> ida_alloc()/ida_free() don't need any mutex, so remove this one.
> 
> It was introduced by commit 9a90ea7d3784 ("platform/x86/intel/vsec: Use
> mutex for ida_alloc() and ida_free()").
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> See:
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L375
> https://elixir.bootlin.com/linux/v6.11.2/source/lib/idr.c#L484
> 
> Review with care. This patch is clearly the opposite of the one in Fixes
> which states that locking IS needed.
> IIUC, idr_ functions need locking, but not ida_.
> 
> If I'm wrong, could you elaborate why? (because many other places will
> need to be fixed and the doc certainly needs updating)

This is my bad, looking at the ida docs they clearly state
no locking is necessary.

Back then I was working on / reviewing some other stuff using
idr which does need locking and I likely simply confused the 2
and suggested for the locking to be added.

Anyways dropping the locking looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>  drivers/platform/x86/intel/vsec.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 7b5cc9993974..9e0f8e38178c 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -79,17 +79,13 @@ static void intel_vsec_remove_aux(void *data)
>  	auxiliary_device_uninit(data);
>  }
>  
> -static DEFINE_MUTEX(vsec_ida_lock);
> -
>  static void intel_vsec_dev_release(struct device *dev)
>  {
>  	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(dev);
>  
>  	xa_erase(&auxdev_array, intel_vsec_dev->id);
>  
> -	mutex_lock(&vsec_ida_lock);
>  	ida_free(intel_vsec_dev->ida, intel_vsec_dev->auxdev.id);
> -	mutex_unlock(&vsec_ida_lock);
>  
>  	kfree(intel_vsec_dev->resource);
>  	kfree(intel_vsec_dev);
> @@ -113,9 +109,7 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
>  		return ret;
>  	}
>  
> -	mutex_lock(&vsec_ida_lock);
>  	id = ida_alloc(intel_vsec_dev->ida, GFP_KERNEL);
> -	mutex_unlock(&vsec_ida_lock);
>  	if (id < 0) {
>  		xa_erase(&auxdev_array, intel_vsec_dev->id);
>  		kfree(intel_vsec_dev->resource);


