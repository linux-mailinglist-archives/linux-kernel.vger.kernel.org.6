Return-Path: <linux-kernel+bounces-517260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CFA37E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F963A7E06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8163212D6B;
	Mon, 17 Feb 2025 09:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1x7jNnR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4752A212D68
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784320; cv=none; b=UK6tqRciRiY2aVFkuUP6Rghia9JYzQE7HKoqUG/EOtDa72mD0VXjybhpTXyLMbF4UB0EEbOu0zysMGYmDA8DzmbRuWGdIobtNmdc64Lig1PaJIAmpkioQPQQXZ15KAmBkwerrGYVQKTwqylw67yrF2kLbAeyrXWkKBncWCcw05w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784320; c=relaxed/simple;
	bh=aUcRjl3FfW/Sj8LYY5sFE2g/pDwLCqIUfz3WWvpSycs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ws7gXxUxOXrHb5vVlwafzctYVHKLXDkZHbOxKbBjSJiWf1vu6Mccszl4KeyJooFawJ2DBKfPEjFxT+2LVikCLrDmxSQVPKKsKPywA/loTtpF7QhlEVLtOBg3JQWq/PhvHrqep8N44+bzmkLnuxz+YZLKVRls6MQroLMuhCsqKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1x7jNnR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739784316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBf3Xl9Dv683aUdui4V5aEEqmtwzuaX9/tJJQKbjp/Q=;
	b=E1x7jNnRXbE/ai1XJnvareVwfoZFvSgIUXZ2ofLm9beIHlsa8kqyDFCBuXfV323LEE+SJr
	k5RJ7uwnPpL/XCasaiR7g+ZK8LTY5mo6t3hDEKMKKRIEIrtcJ3f1EqLWopbGSHxjF3LN24
	KcY2efCF8tjTZaCky8g00skewhSPEg0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-wf8O6yptOh2f8j_Z9r7dVw-1; Mon, 17 Feb 2025 04:25:15 -0500
X-MC-Unique: wf8O6yptOh2f8j_Z9r7dVw-1
X-Mimecast-MFC-AGG-ID: wf8O6yptOh2f8j_Z9r7dVw_1739784314
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f28a4647eso2114506f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 01:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739784314; x=1740389114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBf3Xl9Dv683aUdui4V5aEEqmtwzuaX9/tJJQKbjp/Q=;
        b=gassFPRjrlgcbeXLlL1WfaBKlpqq9C0SXTJm1rC/fOSkb1PoS0sOHT9DZin9lsbHS3
         a0j3UL52j+GNDXsF39/E2LV9R9tx1Yk7xp0MMaua6NV84lJfn//6A4ZPbLouwBfNflws
         30d4+6tzNcjWduc3cZ82Zkv+imuAjok8bMo9PVah1vm9fhKhSneMwltKlrZhT+pW4hZ1
         lnzSCrGwn67CpTMdLJEjjbmTDvZ/We6RXuxWnjmqcHhAHSu26u99OP6mgwDEFk+maZ+0
         3Qhu6MMcW/A73eq84tkk+/hbiYRd/zGJWKgdnPFqH4HgBUxTTF7ZzSHq8uDuww+lawNN
         in5w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+MVCLA60rEbgPfshcWkPvBxfuVIUlEP1blIVmuavJr1IyiyqrOssVNuUPMPLyxGnMfqPe2JBOfa9gNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGUTik8yzwjO5nSJoB0n9IKxMzyxzNFdD++CseFroNlzboS1E2
	mV1j1BbE4WG7o2CggA5H4zuKL9Eu6500SNXNpTphGzim/eFxIwTacPlMCixfcmOAtWMf9NhtFf8
	ekd95ZhltaffWX5oGItXK08XjLt2sjK+GzzUqkzGuCXWtwn+lTjikVs5p2Vhg5Q==
X-Gm-Gg: ASbGncs/Lfboq4OWUhFxdFM6/oQU0YSxF8IqkezFNSqPd1bB1/hX7rR5EIQXTgADHr9
	d4OCb78CMdLwzVBfPmmUUtkDLrzTtKBSIhkvFWL1ByrrsI650I4oraTAlXXBonPUVOfMmlIS+2/
	1gO/wLEpRy2yoJNLvs/0uL6nkKOdgDDHLmsEG9YQp8DzvvhpwLwfC2+ayf1Pq6yCtXJVOWNsKZi
	16enebce5pGr0MlUT6BEWZDiI6CiS2u+R3YcK/DRf6ODaumkjEMi4koNkApHuavhkWjGTXTNhTS
	GYeglmldHCYOlVVTUA+9S8ZPIsAqgpeiGUSZYFt6rEGHF78=
X-Received: by 2002:a05:6000:2c8:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-38f33f118bdmr8166062f8f.5.1739784313747;
        Mon, 17 Feb 2025 01:25:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+e3ZDeZZklxUwuPBgrKTx/D/C7WwNgIMX5Ndcpna23nQ0p5Q4XxreY1lRtBtdj9We5Lkd5w==
X-Received: by 2002:a05:6000:2c8:b0:38f:3224:65ff with SMTP id ffacd0b85a97d-38f33f118bdmr8166035f8f.5.1739784313312;
        Mon, 17 Feb 2025 01:25:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dab74sm11875696f8f.32.2025.02.17.01.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:25:12 -0800 (PST)
Message-ID: <a48ec78d-a86f-4332-87d0-e6071f72a7d1@redhat.com>
Date: Mon, 17 Feb 2025 10:25:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio: Remove virtio devices on device_shutdown()
Content-Language: en-US
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
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250214070904-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Michael, Hongyu,

On 2/14/25 1:16 PM, Michael S. Tsirkin wrote:
> On Fri, Feb 14, 2025 at 08:56:56AM +0100, Eric Auger wrote:
>> Hi,
>>
>> On 2/14/25 8:21 AM, Ning, Hongyu wrote:
>>>
>>>
>>> On 2025/2/6 16:59, Eric Auger wrote:
>>>> Hi,
>>>>
>>>> On 2/4/25 12:46 PM, Eric Auger wrote:
>>>>> Hi,
>>>>>
>>>>> On 2/3/25 3:48 PM, Michael S. Tsirkin wrote:
>>>>>> On Fri, Jan 31, 2025 at 10:53:15AM +0100, Eric Auger wrote:
>>>>>>> Hi Kirill, Michael
>>>>>>>
>>>>>>> On 8/8/24 9:51 AM, Kirill A. Shutemov wrote:
>>>>>>>> Hongyu reported a hang on kexec in a VM. QEMU reported invalid memory
>>>>>>>> accesses during the hang.
>>>>>>>>
>>>>>>>>     Invalid read at addr 0x102877002, size 2, region '(null)',
>>>>>>>> reason: rejected
>>>>>>>>     Invalid write at addr 0x102877A44, size 2, region '(null)',
>>>>>>>> reason: rejected
>>>>>>>>     ...
>>>>>>>>
>>>>>>>> It was traced down to virtio-console. Kexec works fine if virtio-
>>>>>>>> console
>>>>>>>> is not in use.
>>>>>>>>
>>>>>>>> Looks like virtio-console continues to write to the MMIO even after
>>>>>>>> underlying virtio-pci device is removed.
>>>>>>>>
>>>>>>>> The problem can be mitigated by removing all virtio devices on virtio
>>>>>>>> bus shutdown.
>>>>>>>>
>>>>>>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>>>>>> Reported-by: Hongyu Ning <hongyu.ning@linux.intel.com>
>>>>>>>
>>>>>>> Gentle ping on that patch that seems to have fallen though the cracks.
>>>>>>>
>>>>>>> I think this fix is really needed. I have another test case with a
>>>>>>> rebooting guest exposed with virtio-net (backed by vhost-net) and
>>>>>>> viommu. Since there is currently no shutdown for the virtio-net, on
>>>>>>> reboot, the IOMMU is disabled through the native_machine_shutdown()/
>>>>>>> x86_platform.iommu_shutdown() while the virtio-net is still alive.
>>>>>>>
>>>>>>> Normally device_shutdown() should call virtio-net shutdown before the
>>>>>>> IOMMU tear down and we wouldn't see any spurious transactions after
>>>>>>> iommu shutdown.
>>>>>>>
>>>>>>> With that fix, the above test case is fixed and I do not see spurious
>>>>>>> vhost IOTLB miss spurious requests.
>>>>>>>
>>>>>>> For more details, see qemu thread ([PATCH] hw/virtio/vhost: Disable
>>>>>>> IOTLB callbacks when IOMMU gets disabled,
>>>>>>> https://lore.kernel.org/all/20250120173339.865681-1-
>>>>>>> eric.auger@redhat.com/)
>>>>>>>
>>>>>>>
>>>>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>>>> Tested-by: Eric Auger <eric.auger@redhat.com>
>>>>>>>
>>>>>>> Thanks
>>>>>>>
>>>>>>> Eric
>>>>>>>
>>>>>>>> ---
>>>>>>>>   drivers/virtio/virtio.c | 10 ++++++++++
>>>>>>>>   1 file changed, 10 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>>>>>>> index a9b93e99c23a..6c2f908eb22c 100644
>>>>>>>> --- a/drivers/virtio/virtio.c
>>>>>>>> +++ b/drivers/virtio/virtio.c
>>>>>>>> @@ -356,6 +356,15 @@ static void virtio_dev_remove(struct device *_d)
>>>>>>>>       of_node_put(dev->dev.of_node);
>>>>>>>>   }
>>>>>>>>   +static void virtio_dev_shutdown(struct device *_d)
>>>>>>>> +{
>>>>>>>> +    struct virtio_device *dev = dev_to_virtio(_d);
>>>>>>>> +    struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
>>>>>>>> +
>>>>>>>> +    if (drv && drv->remove)
>>>>>>>> +        drv->remove(dev);
>>>>>>
>>>>>>
>>>>>> I am concerned that full remove is a heavyweight operation.
>>>>>> Do not want to slow down reboots even more.
>>>>>> How about just doing a reset, instead?
>>>>>
>>>>> I tested with
>>>>>
>>>>> static void virtio_dev_shutdown(struct device *_d)
>>>>> {
>>>>>          struct virtio_device *dev = dev_to_virtio(_d);
>>>>>
>>>>>          virtio_reset_device(dev);
>>>>> }
>>>>>
>>>>>
>>>>> and it fixes my issue.
>>>>>
>>>>> Kirill, would that fix you issue too?
>>>
>>> Hi,
>>>
>>> sorry for my late response, I synced with Kirill offline and did a retest.
>>>
>>> The issue is still reproduced on my side, kexec will be stuck in case of
>>> "console=hvc0" append in kernel cmdline and even with such patch applied.
>>
>> Thanks for testing!
>>
>> Michael, it looks like the initial patch from Kyrill is the one that
>> fixes both issues. virtio_reset_device() usage does not work for the
>> initial bug report while it works for me. Other ideas?
>>
>> Thanks
>>
>> Eric
> 
> Ah, wait a second.
> 
> Looks like virtio-console continues to write to the MMIO even after
> underlying virtio-pci device is removed.
> 
> Hmm. I am not sure why that is a problem, but I assume some hypervisors just
> hang the system if you try to kick them after reset.
> Unfortunate that spec did not disallow it.
> 
> If we want to prevent that, we want to do something like this:
> 
> 
> 	/*
> 	 * Some devices get wedged if you kick them after they are
> 	 * reset. Mark all vqs as broken to make sure we don't.
> 	 */
>         virtio_break_device(dev);
>         /*
>          * The below virtio_synchronize_cbs() guarantees that any
>          * interrupt for this line arriving after
>          * virtio_synchronize_vqs() has completed is guaranteed to see
>          * vq->broken as true.
>          */
>         virtio_synchronize_cbs(dev);
>         dev->config->reset(dev);
> 
> 
> I assume this still works for you, yes?
Would that still been done in the virtio_dev_shutdown()?

Is that what you tested Hongyu?

Eric
> 
> 
> 
>>>
>>> my kernel code base is 6.14.0-rc2.
>>>
>>> let me know if any more experiments needed.
>>>
>>> ---
>>>  drivers/virtio/virtio.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>>> index ba37665188b5..f9f885d04763 100644
>>> --- a/drivers/virtio/virtio.c
>>> +++ b/drivers/virtio/virtio.c
>>> @@ -395,6 +395,13 @@ static const struct cpumask
>>> *virtio_irq_get_affinity(struct device *_d,
>>>         return dev->config->get_vq_affinity(dev, irq_vec);
>>>  }
>>>
>>> +static void virtio_dev_shutdown(struct device *_d)
>>> +{
>>> +        struct virtio_device *dev = dev_to_virtio(_d);
>>> +
>>> +        virtio_reset_device(dev);
>>> +}
>>> +
>>>  static const struct bus_type virtio_bus = {
>>>         .name  = "virtio",
>>>         .match = virtio_dev_match,
>>> @@ -403,6 +410,7 @@ static const struct bus_type virtio_bus = {
>>>         .probe = virtio_dev_probe,
>>>         .remove = virtio_dev_remove,
>>>         .irq_get_affinity = virtio_irq_get_affinity,
>>> +       .shutdown = virtio_dev_shutdown,
>>>  };
>>>
>>>  int __register_virtio_driver(struct virtio_driver *driver, struct
>>> module *owner)
>>> -- 
>>> 2.43.0
>>>
>>>
>>>> gentle ping.
>>>>
>>>> this also fixes another issue with qemu vSMMU + virtio-scsi-pci. With
>>>> the above addition I get rid of spurious warning in qemu on guest reboot.
>>>>
>>>> qemu-system-aarch64: virtio: zero sized buffers are not allowed
>>>> qemu-system-aarch64: vhost vring error in virtqueue 0: Invalid
>>>> argument (22)
>>>>
>>>> Would you mind if I respin?
>>>>
>>>> Thanks
>>>>
>>>> Eric
>>>>
>>>>
>>>>
>>>>
>>>>>
>>>>> Thanks
>>>>>
>>>>> Eric
>>>>>>
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>   static const struct bus_type virtio_bus = {
>>>>>>>>       .name  = "virtio",
>>>>>>>>       .match = virtio_dev_match,
>>>>>>>> @@ -363,6 +372,7 @@ static const struct bus_type virtio_bus = {
>>>>>>>>       .uevent = virtio_uevent,
>>>>>>>>       .probe = virtio_dev_probe,
>>>>>>>>       .remove = virtio_dev_remove,
>>>>>>>> +    .shutdown = virtio_dev_shutdown,
>>>>>>>>   };
>>>>>>>>     int __register_virtio_driver(struct virtio_driver *driver,
>>>>>>>> struct module *owner)
>>>>>>
>>>>>
>>>>
>>>
> 


