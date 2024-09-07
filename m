Return-Path: <linux-kernel+bounces-319903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE814970394
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB551F222F0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 18:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D4B165EFB;
	Sat,  7 Sep 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DqswWrsy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E43415F323
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725733607; cv=none; b=VxSA2HFDOQH7zwz7cRBYdl6C0wNFxch0eX+lAukDau2OPCadKOO6CuNX3dD7Ungx1oH/B+x4st2Exrnkn9rXgXkw8slsbyLiL0qCazg/0zOMS2Rv8pbvreL0GXR61yDz52uvm6EPp9O9GxeB/nFfQYXfmx/pNAK+kAQwQoNBMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725733607; c=relaxed/simple;
	bh=+bBNzUOGCWh7ue7Ni11kvgCYA/GRTWFBSh6VyM9mF4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo5tsTz8rAXFPqGDx8huySSeKCwLGbcmO5xEVPT7r1nLWNXpTIP88IzNYECeeorfiNvl0CQfd9GU9qWCWX35NXzWFSNjyiZhSqbAWIOSmelBNIkp/2s3J16gMi/uYF7YGr8GPhGzdH5JX3DkWuGle98hw0hFrhD+gq9+7wbTSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=DqswWrsy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [IPV6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f] (unknown [IPv6:2405:201:2015:f873:55d7:c02e:b2eb:ee3f])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A7623593;
	Sat,  7 Sep 2024 20:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1725733527;
	bh=+bBNzUOGCWh7ue7Ni11kvgCYA/GRTWFBSh6VyM9mF4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DqswWrsysj0Dsi2ZnSuf3qHUyy2T/BMmUYchiQBlaD3AOLk86/ycZfA7HNS6pfPtF
	 yzMabs164LqskKZQ244Sb+fzHXpCoP+oxlXLLEiGMGcJYRg0lZiBlugre9NtEPJEsv
	 sxDybLizt3erWcXa6LrAG8EC+kaoanRJCxRXd9YU=
Message-ID: <2f5af934-de4a-4548-ac59-f23c3ae0f54e@ideasonboard.com>
Date: Sat, 7 Sep 2024 23:56:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] staging: vchiq_core: Factor out bulk transfer for
 blocking mode
To: Stefan Wahren <wahrenst@gmx.net>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20240906072506.174026-1-umang.jain@ideasonboard.com>
 <20240906072506.174026-4-umang.jain@ideasonboard.com>
 <5e3f9758-e392-44af-83c4-e60714046708@gmx.net>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <5e3f9758-e392-44af-83c4-e60714046708@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Stefan

On 07/09/24 5:19 pm, Stefan Wahren wrote:
> Hi Umang,
>
> Am 06.09.24 um 09:25 schrieb Umang Jain:
>> Factor out bulk transfer for blocking mode into a separate dedicated
>> function bulk_xfer_blocking_interruptible(). It is suffixed by
>> "_interruptible" to denote that it can be interrupted and -EAGAIN
>> can be returned. It would be up to the users of the function to retry
>> the call in those cases.
>>
>> Adjust the calls to vchiq-dev.c ioctl interface and vchiq_arm.c
>> for blocking bulk transfers.
>>
>> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> i applied this series on top of recent linux-next and the vchiq ping
> test on Raspberry Pi 3 B Plus (multi_v7_defconfig) crashes or hanges
> strangly.

This is really annoying. The behavior is non-deterministic

I tested this repeatedly and I see the hang on my 3rd ping test.
The first 2 ping tests completed successfully.

Here is the output for all 3 tries:

https://paste.debian.net/plain/1328739

I'll take a look and fix it in next version.

>
> I bisected the issue to this patch, but it's possible the root cause
> might be introduced before.
>
> But i'm pretty sure that the series introduced the regression.
>
> Sorry, i don't have the time analyse this issue deeper.
>
> Best regards
>> ---
>>   .../interface/vchiq_arm/vchiq_arm.c           |  5 +--
>>   .../interface/vchiq_arm/vchiq_core.c          | 42 ++++++++++++++++---
>>   .../interface/vchiq_arm/vchiq_core.h          |  5 +++
>>   .../interface/vchiq_arm/vchiq_dev.c           |  6 +++
>>   4 files changed, 49 insertions(+), 9 deletions(-)
>>
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> index c4d97dbf6ba8..688c9b1be868 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
>> @@ -968,9 +968,8 @@ vchiq_blocking_bulk_transfer(struct 
>> vchiq_instance *instance, unsigned int handl
>>               return -ENOMEM;
>>       }
>>
>> -    ret = vchiq_bulk_transfer(instance, handle, data, NULL, size,
>> -                  &waiter->bulk_waiter,
>> -                  VCHIQ_BULK_MODE_BLOCKING, dir);
>> +    ret = vchiq_bulk_xfer_blocking_interruptible(instance, handle, 
>> data, NULL, size,
>> +                             &waiter->bulk_waiter, dir);
>>       if ((ret != -EAGAIN) || fatal_signal_pending(current) || 
>> !waiter->bulk_waiter.bulk) {
>>           struct vchiq_bulk *bulk = waiter->bulk_waiter.bulk;
>>
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> index f36044bab194..43f951fa4b89 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
>> @@ -2985,6 +2985,42 @@ vchiq_remove_service(struct vchiq_instance 
>> *instance, unsigned int handle)
>>       return status;
>>   }
>>
>> +int
>> +vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance 
>> *instance, unsigned int handle,
>> +                       void *offset, void __user *uoffset, int size,
>> +                       void __user *userdata, enum vchiq_bulk_dir dir)
>> +{
>> +    struct vchiq_service *service = find_service_by_handle(instance, 
>> handle);
>> +    struct bulk_waiter *bulk_waiter;
>> +    enum vchiq_bulk_mode mode = VCHIQ_BULK_MODE_BLOCKING;
>> +    int status = -EINVAL;
>> +
>> +    if (!service)
>> +        return -EINVAL;
>> +
>> +    if (service->srvstate != VCHIQ_SRVSTATE_OPEN)
>> +        goto error_exit;
>> +
>> +    if (!offset && !uoffset)
>> +        goto error_exit;
>> +
>> +    if (vchiq_check_service(service))
>> +        goto error_exit;
>> +
>> +    bulk_waiter = userdata;
>> +    init_completion(&bulk_waiter->event);
>> +    bulk_waiter->actual = 0;
>> +    bulk_waiter->bulk = NULL;
>> +
>> +    status = vchiq_bulk_xfer_queue_msg_interruptible(service, 
>> offset, uoffset, size,
>> +                             userdata, mode, dir);
>> +
>> +error_exit:
>> +    vchiq_service_put(service);
>> +
>> +    return status;
>> +}
>> +
>>   /*
>>    * This function may be called by kernel threads or user threads.
>>    * User threads may receive -EAGAIN to indicate that a signal has been
>> @@ -3018,12 +3054,6 @@ int vchiq_bulk_transfer(struct vchiq_instance 
>> *instance, unsigned int handle,
>>       case VCHIQ_BULK_MODE_NOCALLBACK:
>>       case VCHIQ_BULK_MODE_CALLBACK:
>>           break;
>> -    case VCHIQ_BULK_MODE_BLOCKING:
>> -        bulk_waiter = userdata;
>> -        init_completion(&bulk_waiter->event);
>> -        bulk_waiter->actual = 0;
>> -        bulk_waiter->bulk = NULL;
>> -        break;
>>       default:
>>           goto error_exit;
>>       }
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>> index 985d9ea3a06a..2dd89101c1c6 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
>> @@ -474,6 +474,11 @@ extern int
>>   vchiq_bulk_xfer_waiting_interruptible(struct vchiq_instance *instance,
>>                         unsigned int handle, struct bulk_waiter 
>> *userdata);
>>
>> +extern int
>> +vchiq_bulk_xfer_blocking_interruptible(struct vchiq_instance 
>> *instance, unsigned int handle,
>> +                       void *offset, void __user *uoffset, int size,
>> +                       void __user *userdata, enum vchiq_bulk_dir dir);
>> +
>>   extern int
>>   vchiq_bulk_transfer(struct vchiq_instance *instance, unsigned int 
>> handle, void *offset,
>>               void __user *uoffset, int size, void *userdata, enum 
>> vchiq_bulk_mode mode,
>> diff --git 
>> a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c 
>> b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>> index 550838d2863b..830633f2326b 100644
>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
>> @@ -304,6 +304,12 @@ static int vchiq_irq_queue_bulk_tx_rx(struct 
>> vchiq_instance *instance,
>>           }
>>
>>           userdata = &waiter->bulk_waiter;
>> +
>> +        status = vchiq_bulk_xfer_blocking_interruptible(instance, 
>> args->handle,
>> +                                NULL, args->data, args->size,
>> +                                userdata, dir);
>> +
>> +        goto bulk_transfer_handled;
>>       } else if (args->mode == VCHIQ_BULK_MODE_WAITING) {
>>           mutex_lock(&instance->bulk_waiter_list_mutex);
>>           list_for_each_entry(iter, &instance->bulk_waiter_list,
>


