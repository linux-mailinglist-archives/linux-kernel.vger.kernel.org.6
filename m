Return-Path: <linux-kernel+bounces-429295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C69E19E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10A7166873
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7460C1E2833;
	Tue,  3 Dec 2024 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+1u4pEX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF301E260F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223107; cv=none; b=RRgqCNECrxQoKUdnm2LeLny5sr+CZzr8MbkOn2SF7JrgkQI/8v8E3OYfNh/Ewe1OcdFw9aWKIiS2UWpW7q7GZasti9y/G3GJ5KTuKGp5K2jlcHncJEbN4aSAKm7wdY1KA/3JwE1KK7fJDu9MWkxeNjTqDLcLa3tANGKzrzms9KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223107; c=relaxed/simple;
	bh=Ce7eqkBn1WuMrJkw0TRcBg7fUgpKz6dkNrAf3moL5Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEvEdc6amGgR0/r4ATrgKOg131wIB0mEuEgIde12YccfQbUerogTXRLNgGHq8ILAKADtncuC/aZ3oFOYZvECncF3baVkIDtt9gN0lCnIeM9cCyA0/1kC20NGDQKCuMyEWYOF6dNxXcqTMI49Zdstk55p2ch3y3mOjBBSLSa+XAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P+1u4pEX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733223104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GqDYXPSGry8fvFKf3Y6FQQzvxwwFWyLPiSnjxx0zMng=;
	b=P+1u4pEXfMgEquLRyJ5+RAUXv1EoKJLxsTNcvF9DJm/dAhjcUEKXqp69d9WfJEPToM4KTF
	o50YPB8T5jUmQ9X3j4WRK1Z1MB1kQHCK2yPSK7vnXmZpRYxmq4A8Xlp0YGU+TltSkbokUQ
	Is5SVYbStHeARg8NX8ljPewP5wr9YyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-HhUnwqd-NCOa-xaGjonCmw-1; Tue, 03 Dec 2024 05:51:43 -0500
X-MC-Unique: HhUnwqd-NCOa-xaGjonCmw-1
X-Mimecast-MFC-AGG-ID: HhUnwqd-NCOa-xaGjonCmw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d735965bso2579286f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733223102; x=1733827902;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GqDYXPSGry8fvFKf3Y6FQQzvxwwFWyLPiSnjxx0zMng=;
        b=iiid6Ht+aEfz52X6jnt+PxyiJocL45cKQBIZrRcOIjboXFsuxLf41C+dA5aZH7AtCv
         nrzqeAIGsbeVnCbeQI1785BLuVixxpvgVOZ6jvN1YiC0RGG8n0mpG22AE9p1rM9sz5nd
         qzK9MCY2CLDwjrOf36T+P3d6EffIIuUQPuLc6q7GkLjv+q+8FuKpbWPEeQf+oh4mhAGw
         QHUNu+dSuRuiFOQ6DfxTvrgO9R7lvr9+HiLB3FrN/LiBP3N6tDLETZ0sk5u2NvjCKDZe
         lPGMRypvdlfcllHneEoi1yRBPDtJqhnKLyowoTL57PuYOGJRXnrI/qkHXP1vtiz+3Psc
         cq2Q==
X-Gm-Message-State: AOJu0YyhxEAcogPmF65XdN+CzalZHFx8YruGhBTORiNAcFagP0GJf2LL
	oEd3ESOKXP7GceT4Gs2sKvlKeT3NhsMIupK+ICvOCJQogYCFx7KKjQHQzzbh2cXoyj4B2X9BbFh
	rkTUlWdRgya22dE9BUme8cdzZcO6VPRbKNQ8P2ljKfJAw/7trjrjOuTNqgINl6g==
X-Gm-Gg: ASbGnct5rSSEyZqSEr/KouYsPyVCap0BpnJSeGigJr2b8rXlVHSuvAb/ptyfBm7wdEt
	n9fm2x1U6slbnqux8/JgGgT7xocEyAn5nAmrRt9qXBrlTD67IGUQmVUS13chvbc1rvVq5VLvUWw
	0DHqxJBmabKVoURAhS0301rDqx55kZSHxSeEjcrPHRFIOgJzQUwEPWWqE/3sFams33PODtVCJZl
	g6NeKwzhoEwvjwgyR4XW4P2mIvMadK9ZN9DXoflTg9X6oqAbWRNpW9C81iSxeg69WLdxfKFr3Ud
	wysa21PIKUPOzYaXX3dbyC3fOGvw8gGkjvyGXvCCnSikZA306ASSi+HlxXTgE6zDGT9n8SHH814
	OBw==
X-Received: by 2002:a05:6000:698:b0:385:de8d:c0f5 with SMTP id ffacd0b85a97d-385fd3ce003mr1805490f8f.16.1733223102025;
        Tue, 03 Dec 2024 02:51:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsiHmkxMqZNYBRMic15i3J+xhBUi5IkfKnDUhcGUpt0ArEviRKcEDiXtnq3XnP9doeeDQT1Q==
X-Received: by 2002:a05:6000:698:b0:385:de8d:c0f5 with SMTP id ffacd0b85a97d-385fd3ce003mr1805453f8f.16.1733223101624;
        Tue, 03 Dec 2024 02:51:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:1b00:fd9e:c26c:c552:1de7? (p200300cbc7461b00fd9ec26cc5521de7.dip0.t-ipconnect.de. [2003:cb:c746:1b00:fd9e:c26c:c552:1de7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2e1bdsm15556376f8f.9.2024.12.03.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 02:51:40 -0800 (PST)
Message-ID: <29dfdbf6-e356-4555-a421-e4926610c32b@redhat.com>
Date: Tue, 3 Dec 2024 11:51:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com> <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
 <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
 <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
 <Z07gkXQDrNfL10hu@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z07gkXQDrNfL10hu@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.24 11:42, Baoquan He wrote:
> On 11/29/24 at 11:38am, David Hildenbrand wrote:
>> On 25.11.24 15:41, Baoquan He wrote:
>>> On 11/22/24 at 10:30am, David Hildenbrand wrote:
>>>> On 22.11.24 10:16, Baoquan He wrote:
>>>>> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>>>>> ......snip...
>>>>>> @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>>>>>>     		return -EINVAL;
>>>>>>     	}
>>>>>> +	/* We'll recheck under lock later. */
>>>>>> +	if (data_race(vmcore_opened))
>>>>>> +		return -EBUSY;
>>>>>
>>>>
>>>> Hi,
>>>>
>>>>> As I commented to patch 7, if vmcore is opened and closed after
>>>>> checking, do we need to give up any chance to add device dumping
>>>>> as below?
>>>>>
>>>>> fd = open(/proc/vmcore);
>>>>> ...do checking;
>>>>> close(fd);
>>>>>
>>>>> quit any device dump adding;
>>>>>
>>>>> run makedumpfile on s390;
>>>>>      ->fd = open(/proc/vmcore);
>>>>>        -> try to dump;
>>>>>      ->close(fd);
>>>>
>>>> The only reasonable case where this could happen (with virtio_mem) would be
>>>> when you hotplug a virtio-mem device into a VM that is currently in the
>>>> kdump kernel. However, in this case, the device would not provide any memory
>>>> we want to dump:
>>>>
>>>> (1) The memory was not available to the 1st (crashed) kernel, because
>>>>       the device got hotplugged later.
>>>> (2) Hotplugged virtio-mem devices show up with "no plugged memory",
>>>>       meaning there wouldn't be even something to dump.
>>>>
>>>> Drivers will be loaded (as part of the kernel or as part of the initrd)
>>>> before any kdump action is happening. Similarly, just imagine your NIC
>>>> driver not being loaded when you start dumping to a network share ...
>>>>
>>>> This should similarly apply to vmcoredd providers.
>>>>
>>>> There is another concern I had at some point with changing the effective
>>>> /proc/vmcore size after someone already opened it, and might assume the size
>>>> will stay unmodified (IOW, the file was completely static before vmcoredd
>>>> showed up).
>>>>
>>>> So unless there is a real use case that requires tracking whether the file
>>>> is no longer open, to support modifying the vmcore afterwards, we should
>>>> keep it simple.
>>>>
>>>> I am not aware of any such cases, and my experiments with virtio_mem showed
>>>> that the driver get loaded extremely early from the initrd, compared to when
>>>> we actually start messing with /proc/vmcore from user space.
> 
> It's OK, David, I don't have strong opinion about the current
> implementation. I raised this concern because
> 
> 1) I saw the original vmcoredd only warn when doing register if
> vmcore_opened is true;
> 
> 2) in patch 1, it says vmcore_mutex is introduced to protect vmcore
> modifications from concurrent opening. If we are confident, the old
> vmcoredd_mutex can guarantee it, I could be wrong here.

I don't see how. We're protecting the list, but not the 
vmcoredd_update_size(), which modifies sizes, offsets and all that.

> 
> Anyway, it's just a tiny concern, I believe it won't cause issue at
> present. So it's up to you.

I can keep allowing to add stuff after the vmcore was opened and closed 
again (but not while it is open). It doesn't make any sense IMHO, but it 
seems to be easy to add.

Thanks!

-- 
Cheers,

David / dhildenb


