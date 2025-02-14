Return-Path: <linux-kernel+bounces-514541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 415A8A35847
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868253AB0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE02221CA13;
	Fri, 14 Feb 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3+cAsDe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D8121ADD1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 07:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519827; cv=none; b=rzbsdMPvADM+XT8C8DRxXxUyk+56S2HhviicGGJgfL1fscqq5nT51Y4dzUdqVQLSRcKBgCxByXFNn3Vo79b1zDfSqZqjk/R+fNy5i/V8K4UQVUtHoRw6EFrAYbXc0rzdOy+HwnlOnNSnThl5X4wj9YvLh9lnmskwu93QBrNmk54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519827; c=relaxed/simple;
	bh=RAc3uRNAsAC7KE7UVF0+DQRlceMJza3pY+dhi4K5pyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0YMJ/HlbTXxdEBmxxSptAxuPt6tVNYTJNL8n1+zcqQtCt9Wntan7tjmkKmdJ1i+wz3y7guipyvU4wKffQuC//PLl6MyZi+d9WOa/VIzm8kQNMOTn3ruzX5gSq+oTqGHv6hcFHxcwlv4rhm6Hg9Zoj5cuuYU8Dy7cLwQJVomCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3+cAsDe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739519824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKdYMg8IBLgDesl4ekVYGz0UCbQcuGuYdL7TKUsf6Dg=;
	b=S3+cAsDeXByvUX3J+IhFv/TF9slJrRH5UnwDP2lzIdYgubqTo+1xlGD3pkTbID5oLs+9yr
	kGGmcLsr7j/WMFD6nNhDkPdHGBaaJ/7JqXvIghw2CMCLt7SJnBnuWeWs85nKrFXzN4h7JA
	diHYDDhCag7eBi8gyZymnGrGpoZDb0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-mEjxhA6nPted4vo3rexY7Q-1; Fri, 14 Feb 2025 02:57:01 -0500
X-MC-Unique: mEjxhA6nPted4vo3rexY7Q-1
X-Mimecast-MFC-AGG-ID: mEjxhA6nPted4vo3rexY7Q_1739519820
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38dbdc2926eso1829517f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 23:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739519820; x=1740124620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKdYMg8IBLgDesl4ekVYGz0UCbQcuGuYdL7TKUsf6Dg=;
        b=R9jKz/w+M2RrWN88KRgVqefjZ4LH0I7VAhM58xEFQk2VGRsz2ID/hXhvCnKgj+2ys3
         wSO4dDC7mKTKUt9RiGM2MIeAIDgHzRXNfyEKM7o/VRgLc4cP7LKcehPUYua/k7B5TzrJ
         bfkR/c0Zb+f+Bz2LUgBBE1Y5bUW6JXlcSaMeZkcuIqaGkfWs3RUh0sWrBJLgEhcXGULA
         +6YIamOSMA6z5GXvcGZLITdIlR9R+SU8qnw/cKMuZ+xvNh6EQArGNItrGFPeasCw1ePA
         OX25kbBtRmxzFj24xvFdX/DeL9hX1KsxXxsLuV6mhVFaPCulO2iIyMlu9Juv1ZQ8It/2
         xLHw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdrCYk6qW+IYLkN1IULcE1p8v9UabdB2pBZ6McMWw9BO+rt2YgrON5F+fmsq/FgfwuZxCaMJWcR1I+gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKkkAnGrM14f3lrPD9bVusNIarVrr8ua5LqMZauwEPI81JaqQd
	DJ7zsGyOFGlGkYonPUu0GJFaFo5V/1nkqB3tTx3UMHCwhq6btkOosGSk/u0dsJ75CVzFA3H7zq5
	uHQIEyVXRpXdfT9URvGh2v9WpBv9B+Cs14JHBC6k4uEMYT352QB9/E+UYNYhvYQ==
X-Gm-Gg: ASbGnctDFN9wAoDrTqQNvw1hmLCX7HstSkELRhZWi76E/zOXXbwnYCv6HZY9fHej68s
	UJXm981PV06TFHoDpH8aYyhmbv8SVkIGPjOqADL+8gcui7osF7E0caNRKXMdLLzQ6DTRY7txIBg
	s793oJTkWh9K65K2D5XIQ6bxi9qjmq93L7eIIZ5ADVg79KXhHbbybSFgfUQJeWSvDUT924qGBGK
	BGQr+WOzpW4KdCBzFthxAfR0dBM/w6yAyHNqlFF1lokhoOzzw8rT/R5fXUUFYUV233P2Jqen6I8
	6prbS7Rb93sGnzmBRTSeJovMEmH7OgIIblR1ZOxN8HeiU8I=
X-Received: by 2002:a5d:5f94:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38e65d8b981mr11978187f8f.33.1739519820356;
        Thu, 13 Feb 2025 23:57:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOwuVtgICUYzs4Eo3Rqa7ms7P6rPt8pmQ2fYQaQ+7uCx21947YDQCKykvrjeflZhpmmFI0Nw==
X-Received: by 2002:a5d:5f94:0:b0:38e:65d8:b677 with SMTP id ffacd0b85a97d-38e65d8b981mr11978161f8f.33.1739519819961;
        Thu, 13 Feb 2025 23:56:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43961884251sm36863315e9.31.2025.02.13.23.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:56:58 -0800 (PST)
Message-ID: <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
Date: Fri, 14 Feb 2025 08:56:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Content-Language: en-US
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240808075141.3433253-1-kirill.shutemov@linux.intel.com>
 <cc7312ca-2745-48a5-a5ac-9ee1d1c4bee0@redhat.com>
 <20250203094700-mutt-send-email-mst@kernel.org>
 <7cee3c9e-515e-41de-a15c-04c7591e83eb@redhat.com>
 <6bce0f4c-636f-456b-ab21-4a25d3dc8803@redhat.com>
 <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <90a09ffa-e316-41f0-916b-25635b1d4bc6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/14/25 8:21 AM, Ning, Hongyu wrote:
> 
> 
> On 2025/2/6 16:59, Eric Auger wrote:
>> Hi,
>>
>> On 2/4/25 12:46 PM, Eric Auger wrote:
>>> Hi,
>>>
>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>>> Hi Kirill, Michael
>>>>>
>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>>> accesses during the hang.
>>>>>>
>>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
>>>>>> reason: rejected
>>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
>>>>>> reason: rejected
>>>>>>     ...
>>>>>>
>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
>>>>>> console
>>>>>> is not in use.
>>>>>>
>>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>>> underlying virtio-pci device is removed.
>>>>>>
>>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>>> bus shutdown.
>>>>>>
>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>>
>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>>
>>>>> I think this fix is really needed. I have another test case with a
>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>>
>>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>>> iommu shutdown.
>>>>>
>>>>> With that fix, the above test case is fixed and I do not see spurious
>>>>> vhost IOTLB miss spurious requests.
>>>>>
>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>>> IOTLB callbacks when IOMMU gets disabled,
>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
>>>>> eric.auger@redhat.com/)
>>>>>
>>>>>
>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>
>>>>>> ---
>>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>   1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>> --- a/drivers/virtio/virtio.c
>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>       of_node_put(dev->dev.of_node);
>>>>>>   }
>>>>>>   +static void virtio_dev_shutdown(struct device *_d)
>>>>>> +{
>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>> +
>>>>>> +    if (drv && drv->remove)
>>>>>> +        drv->remove(dev);
>>>>
>>>>
>>>> I am concerned that full remove is a heavyweight operation.
>>>> Do not want to slow down reboots even more.
>>>> How about just doing a reset, instead?
>>>
>>> I tested with
>>>
>>> static void virtio_dev_shutdown(struct device *_d)
>>> {
>>>          struct virtio_device *dev = dev_to_virtio(_d);
>>>
>>>          virtio_reset_device(dev);
>>> }
>>>
>>>
>>> and it fixes my issue.
>>>
>>> Kirill, would that fix you issue too?
> 
> Hi,
> 
> sorry for my late response, I synced with Kirill offline and did a retest.
> 
> The issue is still reproduced on my side, kexec will be stuck in case of
> "console=hvc0" append in kernel cmdline and even with such patch applied.

Thanks for testing!

Michael, it looks like the initial patch from Kyrill is the one that
fixes both issues. virtio_reset_device() usage does not work for the
initial bug report while it works for me. Other ideas?

Thanks

Eric
> 
> my kernel code base is 6.14.0-rc2.
> 
> let me know if any more experiments needed.
> 
> ---
>  drivers/virtio/virtio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index ba37665188b5..f9f885d04763 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -395,6 +395,13 @@ static const struct cpumask
> *virtio_irq_get_affinity(struct device *_d,
>         return dev->config->get_vq_affinity(dev, irq_vec);
>  }
> 
> +static void virtio_dev_shutdown(struct device *_d)
> +{
> +        struct virtio_device *dev = dev_to_virtio(_d);
> +
> +        virtio_reset_device(dev);
> +}
> +
>  static const struct bus_type virtio_bus = {
>         .name  = "virtio",
>         .match = virtio_dev_match,
> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
>         .probe = virtio_dev_probe,
>         .remove = virtio_dev_remove,
>         .irq_get_affinity = virtio_irq_get_affinity,
> +       .shutdown = virtio_dev_shutdown,
>  };
> 
>  int __register_virtio_driver(struct virtio_driver *driver, struct
> module *owner)
> -- 
> 2.43.0
> 
> 
>> gentle ping.
>>
>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
>> the above addition I get rid of spurious warning in qemu on guest reboot.
>>
>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
>> argument (22)
>>
>> Would you mind if I respin?
>>
>> Thanks
>>
>> Eric
>>
>>
>>
>>
>>>
>>> Thanks
>>>
>>> Eric
>>>>
>>>>>> +}
>>>>>> +
>>>>>>   static const struct bus_type virtio_bus = {
>>>>>>       .name  = "virtio",
>>>>>>       .match = virtio_dev_match,
>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>>       .uevent = virtio_uevent,
>>>>>>       .probe = virtio_dev_probe,
>>>>>>       .remove = virtio_dev_remove,
>>>>>> +    .shutdown = virtio_dev_shutdown,
>>>>>>   };
>>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
>>>>>> struct module *owner)
>>>>
>>>
>>
> 


