Return-Path: <linux-kernel+bounces-418127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B419D5D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03786B21BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBCD1BE243;
	Fri, 22 Nov 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6hVg2/k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2410A3E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273110; cv=none; b=l6ugfuktJH3hNDXIPeYqWOAjv3ZMisYXsgFjrmDrgU103ku5LEqrr9OHhfFDHEh13mcL9DZC8YHNHnnE7VHCA7u2yHVF9HHz3iA/NAtgFtTm2ATANa1RynEwinGve4d0ctXBUpGCFymvw9PUXysW368Uzv3xS80KmTpeKvF3z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273110; c=relaxed/simple;
	bh=ErroYIF+Xu/AlZHDhPU+sf1sYbeI+95FwzVRgokKy+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk658bf4SanemDB6URJLu5JVILu+kyhwHo/1gOKn8UvNSsnG4SiK6hJOXrGO/4AcZD9dOHq37l9h5yqsUp8hQoKzOced6pKBFt++d2srPrQcsP49G4KhwWSTjvSZ1ofGPRUgIehhXt2d0ifmmnTxXGMe2xWVc1LBhThw97XARjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6hVg2/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M4KSeNARUrcT6PyfK2VFIz8RVHXdk2W/lj3qUJoTa5k=;
	b=i6hVg2/kEHBmwD0QcV6cVyJQCvDTgBFnQ7HRBgCFIA2h2tDyHbShzTf3m/7lUNJvafd8rm
	WtizYEB/A48XojK8CdLXmWTS29FrMc0SD5LF6hUBEb5ww0qV9/eTh9CPUeHWHAn3cbzNIO
	gIobJi7bglgTzE4dcVmdrcXAZ8ZFGzg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-oAnUiC2HOYiKz6Ze8SvQNA-1; Fri, 22 Nov 2024 05:58:25 -0500
X-MC-Unique: oAnUiC2HOYiKz6Ze8SvQNA-1
X-Mimecast-MFC-AGG-ID: oAnUiC2HOYiKz6Ze8SvQNA
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53dd08f5299so983237e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 02:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732273104; x=1732877904;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M4KSeNARUrcT6PyfK2VFIz8RVHXdk2W/lj3qUJoTa5k=;
        b=lVfbuUO9AO7n2xFeGZjhSRfPOGx7lZwPIKMKaaCeSg5FCuv5fo8++Dy0Uzuhd8zGku
         dD/BGMvZ7HsRYbPRA2GcjLfIPXvth0jMZaluy1FZ4Khq/CtNbY/DmQHMdxHCO1z2JO9g
         GTJ4yZn1L6DjQmGhpmqLsu+lBs1+D0U9h/rIL6cUbU9BYHHytx+OAPKGQLE1L/fKU5G5
         nU/zFkHvA8d8Svjr/+D1RBfjysOuTwJzNQBiazA7aeCan7oCAIDrJH5Uh+uVjncNXVJD
         wljGm5irtSBo+hhnClwju1xte3m1n0PvpsdZSLx/DNKQ1eos7ZdQ2UTlHlLwXVPl8vT8
         CAZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLuCau9fWaB0VmB4fYoq6OD1pk6RVecOlk8ckzHP255fZcLgWVF6siK4Ok64ORKVRJfAQNCEQBw0SroZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztPZ6iyd9edwxXK1X85TAXGzy3Izefib+0LVOEUWC5Q2VJdmrH
	+i2EFPqHd01iJ+4n5yBhBJsZ+6mwVh6SeAS3BQgdsZx7Ka6+Wj14/RV93YV6FxcC8yj0ArsfhNi
	P40ls/t5SgHCDCz9U+WE/kBhd7ziEBxCQA+L7DNwHKwkwiqCxWT7v2ojtRU5F6g==
X-Gm-Gg: ASbGncskffZ0w+nnz2kBNyekGLGl8UkRj0avtpRkCXVRKEZRxkemOHn7HKVueIRRZDj
	m0p1/F7kTYLFccirQFHqAiRs507qgIsQM57Ak+5tBueSh3a2nd1TOgkicYG3x+Y2B5WpsNmkpK7
	xjYldST1SF/21NgTK5Ao6O/305GCXsymKHza/NCsFyDPjjSwUyPnqKtTBNRKrGzWRJeDfFtH/u3
	Hm+IBuSXE7PSLqGz7iustA5ayR6EomMryPNDiJcsnWqFpPtgMOkJmO3mWmTtkcEkG5vgsZWHav9
	eM+omseF+tP5E3GoPIYZD3sFu9zhwH6wnS8hBw97wlEKy7grWTQhM3z3EAntkwSS/KaXbkWYsNU
	=
X-Received: by 2002:a05:6512:3e1f:b0:53d:d467:3aa1 with SMTP id 2adb3069b0e04-53dd4673c22mr827694e87.40.1732273104317;
        Fri, 22 Nov 2024 02:58:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMiudN8Z6Q+xj/jBgEP1v4n1HRTPySjXiecTBzRMBXBvV2+wsyNSBo8Az8bbQ+e6h0WYkFnw==
X-Received: by 2002:a05:6512:3e1f:b0:53d:d467:3aa1 with SMTP id 2adb3069b0e04-53dd4673c22mr827666e87.40.1732273103726;
        Fri, 22 Nov 2024 02:58:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433cde8fcdfsm23186935e9.32.2024.11.22.02.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 02:58:22 -0800 (PST)
Message-ID: <a74a8fb5-8434-4ed4-b6b3-519e0a14ed2c@redhat.com>
Date: Fri, 22 Nov 2024 11:58:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, mingo@redhat.com, arnd@arndb.de,
 x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <20241120122858.22190-1-laoar.shao@gmail.com>
 <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
 <2024112134-theater-jasmine-61f3@gregkh>
 <056df1ac-3b90-48b8-9bba-ac84305983a6@redhat.com>
 <CALOAHbCSTZz=FRDRjFW+eqssnpOAyq+UUi+KbYBR0crGHSB7qg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbCSTZz=FRDRjFW+eqssnpOAyq+UUi+KbYBR0crGHSB7qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.24 03:14, Yafang Shao wrote:
> On Thu, Nov 21, 2024 at 11:23 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 21.11.24 16:14, Greg KH wrote:
>>> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
>>>> On Thu, Nov 21, 2024 at 4:51 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>
>>>>> On 20.11.24 13:28, Yafang Shao wrote:
>>>>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
>>>>>> kernel data for debugging purposes is prohibited. This configuration is
>>>>>> always enabled on our production servers. However, there are times when we
>>>>>> need to use the crash utility to modify kernel data to analyze complex
>>>>>> issues.
>>>>>>
>>>>>> As suggested by Ingo, we can add a boot time knob of soft-enabling it.
>>>>>> Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
>>>>>> follows,
>>>>>>
>>>>>> - Before this change
>>>>>>      crash> wr panic_on_oops 0
>>>>>>      wr: cannot write to /proc/kcore      <<<< failed
>>>>>>
>>>>>> - After this change
>>>>>>      - default
>>>>>>        crash> wr panic_on_oops 0
>>>>>>        wr: cannot write to /proc/kcore    <<<< failed
>>>>>>
>>>>>>      - strict_devmem=off
>>>>>>        crash> p panic_on_oops
>>>>>>        panic_on_oops = $1 = 1
>>>>>>        crash> wr panic_on_oops 0
>>>>>>        crash> p panic_on_oops
>>>>>>        panic_on_oops = $2 = 0            <<<< succeeded
>>>>>>
>>>>>>      - strict_devmem=invalid
>>>>>>        [    0.230052] Invalid option string for strict_devmem: 'invalid'
>>>>>>        crash> wr panic_on_oops 0
>>>>>>        wr: cannot write to /proc/kcore  <<<< failed
>>>>>>
>>>>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>>> ---
>>>>>>     .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
>>>>>>     drivers/char/mem.c                            | 21 +++++++++++++++++++
>>>>>>     2 files changed, 37 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> index 1518343bbe22..7fe0f66d0dfb 100644
>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>> @@ -6563,6 +6563,22 @@
>>>>>>                         them frequently to increase the rate of SLB faults
>>>>>>                         on kernel addresses.
>>>>>>
>>>>>> +     strict_devmem=
>>>>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
>>>>>> +                     is enabled for this boot. Strict devmem checking is used
>>>>>> +                     to protect the userspace (root) access to all of memory,
>>>>>> +                     including kernel and userspace memory. Accidental access
>>>>>> +                     to this is obviously disastrous, but specific access can
>>>>>> +                     be used by people debugging the kernel. Note that with
>>>>>> +                     PAT support enabled, even in this case there are
>>>>>> +                     restrictions on /dev/mem use due to the cache aliasing
>>>>>> +                     requirements.
>>>>>> +             on      If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
>>>>>> +                     userspace access to PCI space and the BIOS code and data
>>>>>> +                     regions. This is sufficient for dosemu and X and all
>>>>>> +                     common users of /dev/mem. (default)
>>>>>> +             off     Disable strict devmem checks.
>>>>>> +
>>>>>>         sunrpc.min_resvport=
>>>>>>         sunrpc.max_resvport=
>>>>>>                         [NFS,SUNRPC]
>>>>>
>>>>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't
>>>>> enjoy seeing devmem handling+config getting more complicated.
>>>>
>>>> That poses a challenge. Perhaps we should also consider disabling
>>>> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=off,
>>>> but implementing such a change seems overly complex.
>>>>
>>>> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
>>>> kernel debugging. In an earlier version, I proposed making the
>>>> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
>>>> that it violates the principles of STRICT_DEVMEM.
>>>
>>> I think that "primary goal" is the problem here.  We don't want to do
>>> that, at all, for all the reasons why we implemented STRICT_DEVMEM and
>>> for why people enable it.
>>
>> +1
>>
>>>
>>> Either you enable it because you want the protection and "security" it
>>> provides, or you do not.  Don't try to work around it please.
>>>
>>>> Do you have any suggestions on enabling write access to /dev/mem in
>>>> debugging tools like the crash utility, while maintaining
>>>> compatibility with the existing rules?
>>>
>>> I think you just don't provide write access to /dev/mem for debugging
>>> tools as it's a huge security hole that people realized and have plugged
>>> up.  If you want to provide access to this for "debugging" then just
>>> don't enable that option and live with the risk involved, I don't see
>>> how you can have it both ways.
>>
>> Exactly. And I think a reasonable approach would be to have a debug
>> kernel around into which you can boot, and make sure the debug kernel
>> has such security features turned off.
>>
>> If you rely on distros, maybe you could convince the distro to ship the
>> debug kernel with STRICT_DEVMEM off. I just checked RHEL9, and it only
>> seems to be off in debug kernels on arm64 and s390x (IIUC). Maybe there
>> is a reason we don't even want that off on debug kernels on x86_64, or
>> nobody requested it so far, because using the crash utility with write
>> access on a live system ... is a rather weird ... debugging mechanism in
>> 2024 IMHO.
> 
> It seems I might be a bit outdated.
> Could you share how you typically modify a live system these days? Are
> you using live patching, writing kernel modules, or perhaps some
> clever tools or techniques I'm not familiar with?

I think modifying live systems is something people usually don't do 
anymore. The common debugging workflow is to use kdump and analyze it 
offline.

I mean, people like me working for distributions analyze *a lot* of 
issues, and never really rely on /dev/mem or crash on a production 
system. Well, and apparently not even in debug kernels where some of 
them have STRICT_DEVMEM enabled.

If you find yourself having to modify a live production system, you are 
probably something wrong.

If you really want to modify your live system, there is kdb/kgdb. 
Alternatively, use a debug kernel where you disable security/safety 
mechanisms.

-- 
Cheers,

David / dhildenb


