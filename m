Return-Path: <linux-kernel+bounces-518117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2234EA38A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFBE3A97DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5D226865;
	Mon, 17 Feb 2025 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSsUuBaN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DF226523
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739811578; cv=none; b=mc5an7RqnEXeGpUGrjsAzJyunzSWvqWXD8oyTHeH+nPJTXHDTzoQCmxEbQxIIbIsqoLkFhv5HvLQoHA0INjrdGPwpiSgZhXwoV2w4rtq4FelDvZtdq9pRE249Pr9y18gPeUuTPTdoAB3TsGnXpRorZNryXG/WZpHXlqZfgNg52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739811578; c=relaxed/simple;
	bh=LFfddsZxBXlITmL/+vGigj/geWMyNyFUYG9hBOPHVDA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GbtBXP9kGphV+2t3N6forlSeyJmL7bKm+bztigypgQg6HWukhxUNyXcage76olIDF8/+pikwOiypw82okWk+Krw+z7bs8OoWXhdr1ac3PaWuJY07i92Ly/lrs2dGq/HisRPDe3tUfk6589JjaalQPmq/xNFcaR1v4yq43Rh03X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSsUuBaN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739811575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0W6qcikXZaQHJ5MmZumHOc5P/nL0OyRhrHq+XSV9Has=;
	b=BSsUuBaNcVInY5G1vpgqYYf6BitJXDiTBF5swLFJvQPph038CwBVsjXBHprsPcUcl4qZTR
	RLA4dIB+8aB2uZDwdE5AYfh9OTxwr6+kNbfqBDs42LNHfhnu+3MhS96piqNj0FHyU/AWU2
	duCzAYodAF6f+fP+v1C04UiHP6G9jpI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-IZMPw-O5PVumj9ivdRGYEA-1; Mon, 17 Feb 2025 11:59:34 -0500
X-MC-Unique: IZMPw-O5PVumj9ivdRGYEA-1
X-Mimecast-MFC-AGG-ID: IZMPw-O5PVumj9ivdRGYEA_1739811573
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-438e4e9a53fso33797855e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739811573; x=1740416373;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W6qcikXZaQHJ5MmZumHOc5P/nL0OyRhrHq+XSV9Has=;
        b=OQrnetk8XCl/lFzl5/dd0Zjp5Mq7Ej30NMnJ7VN2c0v1eDT2NUUqGRrwhJS3yknBG2
         iV3dYmYQ5nHZ0a/fvhd+2BNCtyb3CiRC13RwVy23wTDp/b7VwV/dC8UkE6VGQdEL7pa+
         M1qmBGjgEAk1Azob5umQcTA1O8mkJ69NsjMRR7pyjK1HOw4yPMI1ObDsIFA3tep0ZWVE
         6iitxT8M69Ji3AbmaQGAAor/fxGTpYTt3yPgdw0DP1vVfo4dXvTWerHadGANsdry1E1m
         SIOpMODlmMPyavdsVzhus4UW6kI9Nz/X+icAKmxp87G9xAwrtZQq5t6iqY/xRI7KPCC4
         kpKw==
X-Forwarded-Encrypted: i=1; AJvYcCUlW2fq+XfdAgm91WznVOOI8hBpAZ+4cICUdJJa/kiRdC63ZoJnPZ72tTUcv9cnqNzzSqvbeuD6etKiDp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrr6HCACVfX71AEl+hkgk0YsI093DiHy19xlDvAsSbqBGl/Pqi
	cbhkQoLEktR1ZdmxdW/6/2KMpiVNdWV+zshL3WHASelWNu8vlGUBMhN11bGSQr0DTWm3oXo0fZ9
	Gv4yfn+WaRkxYylK6xBZoOrLJjvy5z+mWHrTTorpC+5BSOF2pnUTCxpWrHYZ3JQ==
X-Gm-Gg: ASbGncu9BRi6XlT6NZI9hclo5Evf3VEEF702n2bsgLJxc3iSgLFftvOe7iLDL8TyTus
	8gzlsM+0Ns06eCyGsqGcK1AqgW8sxQ8LziZ8r8Evq7V8qj2bx9NfYF1uIMjMghFPWVRSJ2nVxcK
	I167OQPEAZSdD1T9lwevHGB5huh0PoTR1IXh5IpxErj7i+88++wc17GNToudycgaGal7izJOZVy
	oko3rPWwgB0n326vBh3WRDWO6AW6DWG7KEwSc9QX/9f7yZT86uBUF66vY/Ys8YO/WHibjxbAzIb
	Fe5j2chrmKmHTtIhAGxaZOlRH3FooIX1iFEDP9WuGW+cx2o=
X-Received: by 2002:a05:600c:19d4:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-4396e75dbd7mr92775065e9.27.1739811573313;
        Mon, 17 Feb 2025 08:59:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOqZlM5EzB206Q+H0V17yPFgmin7Z3Uw/ompItL7QBdeJycXAdZjmpTyIaaffqdxx8zVUaug==
X-Received: by 2002:a05:600c:19d4:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-4396e75dbd7mr92774785e9.27.1739811572818;
        Mon, 17 Feb 2025 08:59:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44a7sm12956361f8f.12.2025.02.17.08.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:59:31 -0800 (PST)
Message-ID: <7fb416d6-00b5-4e28-b257-151d3289e76d@redhat.com>
Date: Mon, 17 Feb 2025 17:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Content-Language: en-US
From: Eric Auger <eauger@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
 <83b43e73-8599-44ff-8657-6d5f2f9b2de5@redhat.com>
 <20250214070904-mutt-send-email-mst@kernel.org>
 <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
In-Reply-To: <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michael,

On 2/17/25 10:25 AM, Eric Auger wrote:
> Hi Michael, Hongyu,
> 
> On 2/14/25 1:16 PM, Michael S. Tsirkin wrote:
>> On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
>>> Hi,
>>>
>>> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
>>>>
>>>>
>>>> On 2025/2/6 16:59, Eric Auger wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/4/25 12:46 PM, Eric Auger wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>>>>>> Hi Kirill, Michael
>>>>>>>>
>>>>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>>>>>> accesses during the hang.
>>>>>>>>>
>>>>>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
>>>>>>>>> reason: rejected
>>>>>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
>>>>>>>>> reason: rejected
>>>>>>>>>     ...
>>>>>>>>>
>>>>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
>>>>>>>>> console
>>>>>>>>> is not in use.
>>>>>>>>>
>>>>>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>>>>>> underlying virtio-pci device is removed.
>>>>>>>>>
>>>>>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>>>>>> bus shutdown.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>>>>>
>>>>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>>>>>
>>>>>>>> I think this fix is really needed. I have another test case with a
>>>>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>>>>>
>>>>>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>>>>>> iommu shutdown.
>>>>>>>>
>>>>>>>> With that fix, the above test case is fixed and I do not see spurious
>>>>>>>> vhost IOTLB miss spurious requests.
>>>>>>>>
>>>>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>>>>>> IOTLB callbacks when IOMMU gets disabled,
>>>>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
>>>>>>>> eric.auger@redhat.com/)
>>>>>>>>
>>>>>>>>
>>>>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>>
>>>>>>>> Eric
>>>>>>>>
>>>>>>>>> ---
>>>>>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>>>>> --- a/drivers/virtio/virtio.c
>>>>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>>>>       of_node_put(dev->dev.of_node);
>>>>>>>>>   }
>>>>>>>>>   +static void virtio_dev_shutdown(struct device *_d)
>>>>>>>>> +{
>>>>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>>>>> +
>>>>>>>>> +    if (drv && drv->remove)
>>>>>>>>> +        drv->remove(dev);
>>>>>>>
>>>>>>>
>>>>>>> I am concerned that full remove is a heavyweight operation.
>>>>>>> Do not want to slow down reboots even more.
>>>>>>> How about just doing a reset, instead?
>>>>>>
>>>>>> I tested with
>>>>>>
>>>>>> static void virtio_dev_shutdown(struct device *_d)
>>>>>> {
>>>>>>          struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>
>>>>>>          virtio_reset_device(dev);
>>>>>> }
>>>>>>
>>>>>>
>>>>>> and it fixes my issue.
>>>>>>
>>>>>> Kirill, would that fix you issue too?
>>>>
>>>> Hi,
>>>>
>>>> sorry for my late response, I synced with Kirill offline and did a retest.
>>>>
>>>> The issue is still reproduced on my side, kexec will be stuck in case of
>>>> "console=hvc0" append in kernel cmdline and even with such patch applied.
>>>
>>> Thanks for testing!
>>>
>>> Michael, it looks like the initial patch from Kyrill is the one that
>>> fixes both issues. virtio_reset_device() usage does not work for the
>>> initial bug report while it works for me. Other ideas?
>>>
>>> Thanks
>>>
>>> Eric
>>
>> Ah, wait a second.
>>
>> Looks like virtio-console continues to write to the MMIO even after
>> underlying virtio-pci device is removed.
>>
>> Hmm. I am not sure why that is a problem, but I assume some hypervisors just
>> hang the system if you try to kick them after reset.
>> Unfortunate that spec did not disallow it.
>>
>> If we want to prevent that, we want to do something like this:
>>
>>
>> 	/*
>> 	 * Some devices get wedged if you kick them after they are
>> 	 * reset. Mark all vqs as broken to make sure we don't.
>> 	 */
>>         virtio_break_device(dev);
>>         /*
>>          * The below virtio_synchronize_cbs() guarantees that any
>>          * interrupt for this line arriving after
>>          * virtio_synchronize_vqs() has completed is guaranteed to see
>>          * vq->broken as true.
>>          */
>>         virtio_synchronize_cbs(dev);
>>         dev->config->reset(dev);
I have tested that code as an implentation of the virtio shutdown
callback and yes it also fixes the viommu/vhost issue.

Michael, will you send a patch then?

Thanks

Eric
>>
>>
>> I assume this still works for you, yes?
> Would that still been done in the virtio_dev_shutdown()?
> 
> Is that what you tested Hongyu?
> 
> Eric
>>
>>
>>
>>>>
>>>> my kernel code base is 6.14.0-rc2.
>>>>
>>>> let me know if any more experiments needed.
>>>>
>>>> ---
>>>>  drivers/virtio/virtio.c | 8 ++++++++
>>>>  1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>> index ba37665188b5..f9f885d04763 100644
>>>> --- a/drivers/virtio/virtio.c
>>>> +++ b/drivers/virtio/virtio.c
>>>> @@ -395,6 +395,13 @@ static const struct cpumask
>>>> *virtio_irq_get_affinity(struct device *_d,
>>>>         return dev->config->get_vq_affinity(dev, irq_vec);
>>>>  }
>>>>
>>>> +static void virtio_dev_shutdown(struct device *_d)
>>>> +{
>>>> +        struct virtio_device *dev = dev_to_virtio(_d);
>>>> +
>>>> +        virtio_reset_device(dev);
>>>> +}
>>>> +
>>>>  static const struct bus_type virtio_bus = {
>>>>         .name  = "virtio",
>>>>         .match = virtio_dev_match,
>>>> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
>>>>         .probe = virtio_dev_probe,
>>>>         .remove = virtio_dev_remove,
>>>>         .irq_get_affinity = virtio_irq_get_affinity,
>>>> +       .shutdown = virtio_dev_shutdown,
>>>>  };
>>>>
>>>>  int __register_virtio_driver(struct virtio_driver *driver, struct
>>>> module *owner)
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>>> gentle ping.
>>>>>
>>>>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
>>>>> the above addition I get rid of spurious warning in qemu on guest reboot.
>>>>>
>>>>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
>>>>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
>>>>> argument (22)
>>>>>
>>>>> Would you mind if I respin?
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Eric
>>>>>>>
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>>   static const struct bus_type virtio_bus = {
>>>>>>>>>       .name  = "virtio",
>>>>>>>>>       .match = virtio_dev_match,
>>>>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>>>>>       .uevent = virtio_uevent,
>>>>>>>>>       .probe = virtio_dev_probe,
>>>>>>>>>       .remove = virtio_dev_remove,
>>>>>>>>> +    .shutdown = virtio_dev_shutdown,
>>>>>>>>>   };
>>>>>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
>>>>>>>>> struct module *owner)
>>>>>>>
>>>>>>
>>>>>
>>>>
>>
> 


