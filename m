Return-Path: <linux-kernel+bounces-417150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D1C9D4F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8413A1F226B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACA51D959B;
	Thu, 21 Nov 2024 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ISitnSPF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F691D7E5C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732202587; cv=none; b=OOeYrvR150pHynRyJhX/u5u9ZtO1USJa7geoJFnghV5AXZsHKrXmoehJKj86maEqNDjVDQq8niPhPlRwhFH2i5HQdAW3yxTIzZvCMmWR/NIqhBShX/K3lV//WelsJcFmxEBUIzrIP5BA5OK4W7RCvUV4NHgz1giqZQONkR6FInU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732202587; c=relaxed/simple;
	bh=4j1oHZJTIWnnx0/vAMDpKl86n3IdJER/FO2g+qzHEyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBG/rLb4v2aaS3FROc2jLYfNoXthi8M6blFK1++v92Et/hRbK38EUUnYuUMTcHqZ0r+pzKM/HCrrNRp71Y7qCdMSd8D+yXNdsGdgqH/CCsLPWSbAMyHc8+tkEzXzKuw5kS3h7eXe6ZIu8p/oO1KtnBUhfmuuhg53lvXy01HV+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ISitnSPF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732202585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yQ1+seg1G6mD2kQofC74bb9fRezyPyIc1BYXVQ8fbhI=;
	b=ISitnSPF0dlH7zX6t/cKA9MKdNopieazM1ZNB0X+c+i+bM7PvVbJAgsLK54rk4n/Dyj0uG
	fk9SURNBSK5EkHFJjnGaqu/z0JFYMSBoN9Q53Ic9oaIMdzDLX7puVI2cYTaWTiXki9iDvA
	GcuJcAwGSgnRnjjAIX0ijTa7IoixwLc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-wqmm6SRrNHWQths-h_Vuxw-1; Thu, 21 Nov 2024 10:23:03 -0500
X-MC-Unique: wqmm6SRrNHWQths-h_Vuxw-1
X-Mimecast-MFC-AGG-ID: wqmm6SRrNHWQths-h_Vuxw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315d98a75fso7547945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732202582; x=1732807382;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yQ1+seg1G6mD2kQofC74bb9fRezyPyIc1BYXVQ8fbhI=;
        b=D8fKwbRdyVjCWDanAbTvQh7YSQ4SLzmIxKvlZNqgpqIONCZvX1xmt5UP0ysTHGb7j3
         3on1HwlSJU87Zk1ZBzFincfV/JX1d8LGYWwJJCdaIMLYTitBgabWSDsdlWSUpUPjHUU+
         NCzHUNC8O5TYtPuiI/roAJth4FrChFajEUx7PSQhljHGFhNBgw+zRjXY6segFSjRFUbA
         iydWjnSqFGE5hLU7sEKsm2/Xg7x2B+if7WDcgRzzMYdGAs2WmA4yoANq8qBvUFT87C4P
         3VW4Qk3wZRKN4ns3tEaRa8MO0HGE6dA1O8r9P/jeG8Mq6w3oA5247GKw9PTlTa7Fk2a5
         HsLA==
X-Forwarded-Encrypted: i=1; AJvYcCUD/1dpb2hlWEYhgEmaW9I4P6cZw1DbkTBVTmTycEkCx8jS2INqBtsWjI3xEP+snt1AYc9fvrsV+zcs9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkBYrjT4WS9EEtzGUNnwuGTCqAilbpBwjaHom/RW29qwx2ET6x
	LCVf1z3D0fpH+uU6P28njVqMT1EyZFtOcI2UoW+REzNOqy6v9SzvHMLJ2SIyg0bkOq5H75+/3uZ
	9o3JB9Kn6CeFJV77o3ZLssohjKC4QSjyWAOj9TOb4BVRZ5/YCXDe3cSEGmfUnxA==
X-Gm-Gg: ASbGncvuVb1/XlWumPaOMQpo6nfzih+TTEjy1Hand0EFKuTWW8wLSx9qhrSv8XRFASc
	1HLV1Pibu6kZZwRVz6tnYL9tu34QRi7+VOCMiBRbD05jNCye6idVK5YqS3XjwQyvfRNMTD/d3LU
	v+nfcRiv5GNsMkzBXIyDpxvLYrUCTH7KaOajv8s2mwJRrnWlaETcog66+CYs50vzMgjJ9d4hWTZ
	VXtjsMrtEIVWdaNYSp4kbDJBkBpFT3cFXAtzcxrHpAcvikmhDEEWowg3acGQTsESXCIdWtultrd
	zuPSIXNkCKybKCjd/qfQn9wLAHUxXbQq1UyZ/3w7As8g6H9PFQxaprMpAPOSQBXrZpr9CathzAk
	=
X-Received: by 2002:a05:600c:4fd5:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-433489d46ecmr68782045e9.16.1732202582590;
        Thu, 21 Nov 2024 07:23:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2+puqfWgT2tnUKmnaI1vWBou9Rrm+LD1BnE+atl5gMoBU9M/oXMi0GVNjTX/ujYPV6rn7YQ==
X-Received: by 2002:a05:600c:4fd5:b0:42c:b905:2bf9 with SMTP id 5b1f17b1804b1-433489d46ecmr68781765e9.16.1732202582166;
        Thu, 21 Nov 2024 07:23:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c70c:de00:1200:8636:b63b:f43? (p200300cbc70cde0012008636b63b0f43.dip0.t-ipconnect.de. [2003:cb:c70c:de00:1200:8636:b63b:f43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254910e77sm5255572f8f.59.2024.11.21.07.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 07:23:01 -0800 (PST)
Message-ID: <056df1ac-3b90-48b8-9bba-ac84305983a6@redhat.com>
Date: Thu, 21 Nov 2024 16:23:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] /dev/mem: Add a new parameter strict_devmem to bypass
 strict devmem
To: Greg KH <gregkh@linuxfoundation.org>, Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, arnd@arndb.de, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <20241120122858.22190-1-laoar.shao@gmail.com>
 <0aa9f3bd-b1b6-4089-b9eb-5b72d7a1541a@redhat.com>
 <CALOAHbBMebKtsRnfOFvNKorQk_4KGoCzKd0JcYv2p6pXhJqYbQ@mail.gmail.com>
 <2024112134-theater-jasmine-61f3@gregkh>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <2024112134-theater-jasmine-61f3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21.11.24 16:14, Greg KH wrote:
> On Thu, Nov 21, 2024 at 10:31:12PM +0800, Yafang Shao wrote:
>> On Thu, Nov 21, 2024 at 4:51 PM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 20.11.24 13:28, Yafang Shao wrote:
>>>> When CONFIG_STRICT_DEVMEM is enabled, writing to /dev/mem to override
>>>> kernel data for debugging purposes is prohibited. This configuration is
>>>> always enabled on our production servers. However, there are times when we
>>>> need to use the crash utility to modify kernel data to analyze complex
>>>> issues.
>>>>
>>>> As suggested by Ingo, we can add a boot time knob of soft-enabling it.
>>>> Therefore, a new parameter "strict_devmem=" is added. The reuslt are as
>>>> follows,
>>>>
>>>> - Before this change
>>>>     crash> wr panic_on_oops 0
>>>>     wr: cannot write to /proc/kcore      <<<< failed
>>>>
>>>> - After this change
>>>>     - default
>>>>       crash> wr panic_on_oops 0
>>>>       wr: cannot write to /proc/kcore    <<<< failed
>>>>
>>>>     - strict_devmem=off
>>>>       crash> p panic_on_oops
>>>>       panic_on_oops = $1 = 1
>>>>       crash> wr panic_on_oops 0
>>>>       crash> p panic_on_oops
>>>>       panic_on_oops = $2 = 0            <<<< succeeded
>>>>
>>>>     - strict_devmem=invalid
>>>>       [    0.230052] Invalid option string for strict_devmem: 'invalid'
>>>>       crash> wr panic_on_oops 0
>>>>       wr: cannot write to /proc/kcore  <<<< failed
>>>>
>>>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>>>> ---
>>>>    .../admin-guide/kernel-parameters.txt         | 16 ++++++++++++++
>>>>    drivers/char/mem.c                            | 21 +++++++++++++++++++
>>>>    2 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index 1518343bbe22..7fe0f66d0dfb 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -6563,6 +6563,22 @@
>>>>                        them frequently to increase the rate of SLB faults
>>>>                        on kernel addresses.
>>>>
>>>> +     strict_devmem=
>>>> +                     [KNL] Under CONFIG_STRICT_DEVMEM, whether strict devmem
>>>> +                     is enabled for this boot. Strict devmem checking is used
>>>> +                     to protect the userspace (root) access to all of memory,
>>>> +                     including kernel and userspace memory. Accidental access
>>>> +                     to this is obviously disastrous, but specific access can
>>>> +                     be used by people debugging the kernel. Note that with
>>>> +                     PAT support enabled, even in this case there are
>>>> +                     restrictions on /dev/mem use due to the cache aliasing
>>>> +                     requirements.
>>>> +             on      If IO_STRICT_DEVMEM=n, the /dev/mem file only allows
>>>> +                     userspace access to PCI space and the BIOS code and data
>>>> +                     regions. This is sufficient for dosemu and X and all
>>>> +                     common users of /dev/mem. (default)
>>>> +             off     Disable strict devmem checks.
>>>> +
>>>>        sunrpc.min_resvport=
>>>>        sunrpc.max_resvport=
>>>>                        [NFS,SUNRPC]
>>>
>>> This will allow to violate EXCLUSIVE_SYSTEM_RAM, and I am afraid I don't
>>> enjoy seeing devmem handling+config getting more complicated.
>>
>> That poses a challenge. Perhaps we should also consider disabling
>> functions that rely on EXCLUSIVE_SYSTEM_RAM when strict_devmem=off,
>> but implementing such a change seems overly complex.
>>
>> Our primary goal is to temporarily bypass STRICT_DEVMEM for live
>> kernel debugging. In an earlier version, I proposed making the
>> fucntion devmem_is_allowed() error-injectable, but Ingo pointed out
>> that it violates the principles of STRICT_DEVMEM.
> 
> I think that "primary goal" is the problem here.  We don't want to do
> that, at all, for all the reasons why we implemented STRICT_DEVMEM and
> for why people enable it.

+1

> 
> Either you enable it because you want the protection and "security" it
> provides, or you do not.  Don't try to work around it please.
> 
>> Do you have any suggestions on enabling write access to /dev/mem in
>> debugging tools like the crash utility, while maintaining
>> compatibility with the existing rules?
> 
> I think you just don't provide write access to /dev/mem for debugging
> tools as it's a huge security hole that people realized and have plugged
> up.  If you want to provide access to this for "debugging" then just
> don't enable that option and live with the risk involved, I don't see
> how you can have it both ways.

Exactly. And I think a reasonable approach would be to have a debug 
kernel around into which you can boot, and make sure the debug kernel 
has such security features turned off.

If you rely on distros, maybe you could convince the distro to ship the 
debug kernel with STRICT_DEVMEM off. I just checked RHEL9, and it only 
seems to be off in debug kernels on arm64 and s390x (IIUC). Maybe there 
is a reason we don't even want that off on debug kernels on x86_64, or 
nobody requested it so far, because using the crash utility with write 
access on a live system ... is a rather weird ... debugging mechanism in 
2024 IMHO.

-- 
Cheers,

David / dhildenb


