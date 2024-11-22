Return-Path: <linux-kernel+bounces-418274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0173C9D5FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D611F227AC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C641DE89D;
	Fri, 22 Nov 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILYnev/6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CFF1EB39
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732281687; cv=none; b=gL3sPqckDz1aJTO8zxjHW33fQ86ufZ1BJxURFZyJ451ahsRRLZUNvztU25qkI9a3lxFtWr36Grop/8MRLwS8GIZoBgJJ5kP147wr6lXfpZ1EGaL3W1UDe+PW8DTLbxJgblyud9fqwclmDXm5RoMztIl7nXNHYqZgk9EKxHIMgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732281687; c=relaxed/simple;
	bh=6xZOo2d957x5uDzVJB843Pg3xD+XTvqCEZBpJFAGWx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oR2Ag8docrDVAO++FiFNKLfulCt6QUEM67h3rGTS1pg9z3GTyIloybB6DqafC93C3S1bY4kPnolNmyCE9WuFVqLY9jYv4xDuIkfEZnR6B0aaF7CEl7Z6ms2iwKOJTtepVNcEtvsX7Jqma4iReyxYyo06VESVqwTXdvC6x+ccEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ILYnev/6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732281684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9E37JXdFBN4h+TtkodQNwE1QE8CNZ3mDnlWZp8VQFy8=;
	b=ILYnev/68N84c3QhTVkHzkljIcVs/gA2QvX7PyaHg6Yq+rPo+JLoUhWAgthGkoD91r1fRp
	uC6VVSvagVnTyO+dNLvsElMsF89B8gyY6LmZ0t6XqL1uvffAyM35v/jonW9qMzPZHHG8Hu
	btiwlmikxkUtwQwXxgQxsJdAEV7bBGk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-DMIq_GpPP-meTWuFqRyFVw-1; Fri, 22 Nov 2024 08:21:23 -0500
X-MC-Unique: DMIq_GpPP-meTWuFqRyFVw-1
X-Mimecast-MFC-AGG-ID: DMIq_GpPP-meTWuFqRyFVw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4327bd6bd60so14157055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732281682; x=1732886482;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9E37JXdFBN4h+TtkodQNwE1QE8CNZ3mDnlWZp8VQFy8=;
        b=YucjGsV45ZvzHwkj5pdJdJj7rEScBezKB5MwIjVDMj+4COikkTjOShKcmcMeB4D980
         YS/HWr4qTMNPzt4PwNl03EmK/3p5K2/o2hfWCcQuFEpE/mtoP6zVdq57e9ghIQeKEO9T
         vt4ofBUojcp/FLJHPzs4BuHKtR9DDaAvi3clHwjyfSK33IXicSqOtUiCOsSwGFWeNuTk
         HY9GLhAUdOJnwMZQeWzEXhGlpkHg5E/WeQRW4lscEksmfbsKg07WUkgzqZtFNEThQj8b
         OZGgZ8Eh7H3q9HAEXW6UMmieV9Vgpc9KnNpQ++RoH8urDituUjs73LxwDPb0D9C3oO+V
         uHEA==
X-Forwarded-Encrypted: i=1; AJvYcCVX/+LBIz+IOrCiEyCkGsaJSrhW3+Q2kFYXvV+L5lXEnYX+ll1iWUT7HleQIRa55KWWaf8PPduE8yBQLn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGmUlLE2uPu5BizT6EbD/JgUQmcrN/n8JGHZogs7ZGmnqX6jxW
	xTvb7ZU/OiTvQfBPNEJh8b/o2gkwSKq27NyIlZDKANZmGXIc4X7DFh1G9/1uoef6TMMXPl49/7e
	3JiBY+LHpJAt/f4MbRvyakdND0CQWV1KtZo489Je6hzSQNbwJ/VfCqbAcu2aPnQ==
X-Gm-Gg: ASbGncvbJMk7c0IAb1BbUXUa0WAgqkgqHkng3GGlohfsdKcUhrFwfQDnb+RH7liiyUH
	P48DrHg0/sqo/tKmrdudOZix495veQEGRTnlS30mj1AF6LAoLepyt2wk8exsScUG99iOoYLE2Ya
	x8cyYMoUlUFpTtqa9ENWY0lK/In3eoCdZwXgYvdAWoeZ119qIvG6wUVHpOqbDOwb4oQTiHETBxZ
	67vlUTjMX169lE0J8rVeJSF5cCX+2V004Nzjb7VyINFA5l1n0Zik6XfECZEcczScxVUdjnLMUnF
	IufWuPKNxxEWKEOlNEoW1Y3H2aFqHYfHG8dRr1ebkh15oCT8o4+Yy4GhvhW/hRHKYwvrpuxfaX8
	=
X-Received: by 2002:a05:600c:1d90:b0:432:7c08:d113 with SMTP id 5b1f17b1804b1-433ce41017emr22078005e9.6.1732281682253;
        Fri, 22 Nov 2024 05:21:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmBuTclefzQCYSM3t0fOgBjjg2jyl6pxuXR8zvbZcK1FwxJNnN8437i/Qd3+2ERs0yaW/+pQ==
X-Received: by 2002:a05:600c:1d90:b0:432:7c08:d113 with SMTP id 5b1f17b1804b1-433ce41017emr22077775e9.6.1732281681882;
        Fri, 22 Nov 2024 05:21:21 -0800 (PST)
Received: from ?IPV6:2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8? (p200300cbc70b7a009ccd0493d8e29ac8.dip0.t-ipconnect.de. [2003:cb:c70b:7a00:9ccd:493:d8e2:9ac8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad62e9sm2463048f8f.6.2024.11.22.05.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 05:21:21 -0800 (PST)
Message-ID: <ebec1d7f-556e-44ca-b0d7-6f0b19c1dcca@redhat.com>
Date: Fri, 22 Nov 2024 14:21:19 +0100
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
 <a74a8fb5-8434-4ed4-b6b3-519e0a14ed2c@redhat.com>
 <CALOAHbCuZ7LWJZuYr8+z0OhnYGa-0bWAsFYr8_pDivghHsYBwg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CALOAHbCuZ7LWJZuYr8+z0OhnYGa-0bWAsFYr8_pDivghHsYBwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.11.24 12:50, Yafang Shao wrote:
> On Fri, Nov 22, 2024 at 6:58 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 22.11.24 03:14, Yafang Shao wrote:
>>> On Thu, Nov 21, 2024 at 11:23 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 21.11.24 16:14, Greg KH wrote:
>>>>> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
>>>>>> On Thu, Nov 21, 2024 at 4:51 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>>
>>>>>>> On 20.11.24 13:28, Yafang Shao wrote:
>>>>>>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
>>>>>>>> kernel data for debugging purposes is prohibited. This configuration is
>>>>>>>> always enabled on our production servers. However, there are times when we
>>>>>>>> need to use the crash utility to modify kernel data to analyze complex
>>>>>>>> issues.
>>>>>>>>
>>>>>>>> As suggested by Ingo, we can add a boot time knob of soft-enabling it.
>>>>>>>> Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
>>>>>>>> follows,
>>>>>>>>
>>>>>>>> - Before this change
>>>>>>>>       crash> wr panic_on_oops 0
>>>>>>>>       wr: cannot write to /proc/kcore      <<<< failed
>>>>>>>>
>>>>>>>> - After this change
>>>>>>>>       - default
>>>>>>>>         crash> wr panic_on_oops 0
>>>>>>>>         wr: cannot write to /proc/kcore    <<<< failed
>>>>>>>>
>>>>>>>>       - strict_devmem=off
>>>>>>>>         crash> p panic_on_oops
>>>>>>>>         panic_on_oops = $1 = 1
>>>>>>>>         crash> wr panic_on_oops 0
>>>>>>>>         crash> p panic_on_oops
>>>>>>>>         panic_on_oops = $2 = 0            <<<< succeeded
>>>>>>>>
>>>>>>>>       - strict_devmem=invalid
>>>>>>>>         [    0.230052] Invalid option string for strict_devmem: 'invalid'
>>>>>>>>         crash> wr panic_on_oops 0
>>>>>>>>         wr: cannot write to /proc/kcore  <<<< failed
>>>>>>>>
>>>>>>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>>>>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>>>>>> ---
>>>>>>>>      .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
>>>>>>>>      drivers/char/mem.c                            | 21 +++++++++++++++++++
>>>>>>>>      2 files changed, 37 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>>>>>> index 1518343bbe22..7fe0f66d0dfb 100644
>>>>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>>>>> @@ -6563,6 +6563,22 @@
>>>>>>>>                          them frequently to increase the rate of SLB faults
>>>>>>>>                          on kernel addresses.
>>>>>>>>
>>>>>>>> +     strict_devmem=
>>>>>>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
>>>>>>>> +                     is enabled for this boot. Strict devmem checking is used
>>>>>>>> +                     to protect the userspace (root) access to all of memory,
>>>>>>>> +                     including kernel and userspace memory. Accidental access
>>>>>>>> +                     to this is obviously disastrous, but specific access can
>>>>>>>> +                     be used by people debugging the kernel. Note that with
>>>>>>>> +                     PAT support enabled, even in this case there are
>>>>>>>> +                     restrictions on /dev/mem use due to the cache aliasing
>>>>>>>> +                     requirements.
>>>>>>>> +             on      If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
>>>>>>>> +                     userspace access to PCI space and the BIOS code and data
>>>>>>>> +                     regions. This is sufficient for dosemu and X and all
>>>>>>>> +                     common users of /dev/mem. (default)
>>>>>>>> +             off     Disable strict devmem checks.
>>>>>>>> +
>>>>>>>>          sunrpc.min_resvport=
>>>>>>>>          sunrpc.max_resvport=
>>>>>>>>                          [NFS,SUNRPC]
>>>>>>>
>>>>>>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't
>>>>>>> enjoy seeing devmem handling+config getting more complicated.
>>>>>>
>>>>>> That poses a challenge. Perhaps we should also consider disabling
>>>>>> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=off,
>>>>>> but implementing such a change seems overly complex.
>>>>>>
>>>>>> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
>>>>>> kernel debugging. In an earlier version, I proposed making the
>>>>>> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
>>>>>> that it violates the principles of STRICT_DEVMEM.
>>>>>
>>>>> I think that "primary goal" is the problem here.  We don't want to do
>>>>> that, at all, for all the reasons why we implemented STRICT_DEVMEM and
>>>>> for why people enable it.
>>>>
>>>> +1
>>>>
>>>>>
>>>>> Either you enable it because you want the protection and "security" it
>>>>> provides, or you do not.  Don't try to work around it please.
>>>>>
>>>>>> Do you have any suggestions on enabling write access to /dev/mem in
>>>>>> debugging tools like the crash utility, while maintaining
>>>>>> compatibility with the existing rules?
>>>>>
>>>>> I think you just don't provide write access to /dev/mem for debugging
>>>>> tools as it's a huge security hole that people realized and have plugged
>>>>> up.  If you want to provide access to this for "debugging" then just
>>>>> don't enable that option and live with the risk involved, I don't see
>>>>> how you can have it both ways.
>>>>
>>>> Exactly. And I think a reasonable approach would be to have a debug
>>>> kernel around into which you can boot, and make sure the debug kernel
>>>> has such security features turned off.
>>>>
>>>> If you rely on distros, maybe you could convince the distro to ship the
>>>> debug kernel with STRICT_DEVMEM off. I just checked RHEL9, and it only
>>>> seems to be off in debug kernels on arm64 and s390x (IIUC). Maybe there
>>>> is a reason we don't even want that off on debug kernels on x86_64, or
>>>> nobody requested it so far, because using the crash utility with write
>>>> access on a live system ... is a rather weird ... debugging mechanism in
>>>> 2024 IMHO.
>>>
>>> It seems I might be a bit outdated.
>>> Could you share how you typically modify a live system these days? Are
>>> you using live patching, writing kernel modules, or perhaps some
>>> clever tools or techniques I'm not familiar with?
>>
>> I think modifying live systems is something people usually don't do
>> anymore. The common debugging workflow is to use kdump and analyze it
>> offline.
>>
>> I mean, people like me working for distributions analyze *a lot* of
>> issues, and never really rely on /dev/mem or crash on a production
>> system. Well, and apparently not even in debug kernels where some of
>> them have STRICT_DEVMEM enabled.
>>
>> If you find yourself having to modify a live production system, you are
>> probably something wrong.
>>
>> If you really want to modify your live system, there is kdb/kgdb.
>> Alternatively, use a debug kernel where you disable security/safety
>> mechanisms.
> 
> On a live system, you can experiment and try different approaches for
> verification. However, with a dead system, you're left without any
> options to test or debug.

Yes, but I am saying that this is barely used. (I, for my part still am 
most efficient with kdump+straight printks :) )

So even with the option you propose, you'd still have to reboot into a 
kernel with strict_devmem= set, at which point you can reboot into a 
proper debug kernel.

... unless I am missing something important.

-- 
Cheers,

David / dhildenb


