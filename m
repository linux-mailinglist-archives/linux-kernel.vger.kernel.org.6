Return-Path: <linux-kernel+bounces-538798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15FDA49D32
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8043B160461
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BF2702D6;
	Fri, 28 Feb 2025 15:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8Bcfo4P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D625DAE6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755892; cv=none; b=P6SUzdJjNA1xF4/ByPyYmXk77xYPicVq7mFxXLnO/4ZxbPTYnfNYl+ZCw8cErvF//g9sUyFAMhbRV3Rb99w+RkwmMG51AB1FO35F4/s5y2sB0pv4usnTvh/IonfFA4Xn2IB6ZHv/nByQPL8kSnqynBaOIDVAiHzNW9MKSLTdkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755892; c=relaxed/simple;
	bh=XhIt/KoZqwDvvkIfHWRz0q4gswKfJ2Xd7V1fYHDEERM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNmlEbMZNiEgZ7IgOmdyGGeORUNE0y83gI2VRn0zXCNIpV3i3j3fJbMnH2TuoT7O1P1dEp/+xj2DUtB+HTtbpBiwCv7ur494UOM2h0ZIEX9mgdWL9S1pAWzux7qCfF9n8btqaOMLI+RfOJAol/xCBaRF4R+Hk7zJokI3TUGIElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y8Bcfo4P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740755889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d3RzxgVOKGkYis1oh2Ggnk5D21zUMvhHIGAVWotSvO4=;
	b=Y8Bcfo4PGp1r1/SZaaVi2SC/E2JX2PPnJwi7VGJRVgXE9AfQw2i6DpD5JbYnTKoA9eopz5
	IeXp9fBRtzuuXEMRt5gSI7cJvTE2M8wwjQayF13Dxf1eY6411Fr4VcvgaPaNL0n7yDd8Zw
	GpfhfbPARhqPNL1IyzSI66ujy4vwOZo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-eyLpiShzMfq3-xcfYiwRIw-1; Fri, 28 Feb 2025 10:18:07 -0500
X-MC-Unique: eyLpiShzMfq3-xcfYiwRIw-1
X-Mimecast-MFC-AGG-ID: eyLpiShzMfq3-xcfYiwRIw_1740755887
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f4e3e9c5bso977074f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 07:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740755886; x=1741360686;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d3RzxgVOKGkYis1oh2Ggnk5D21zUMvhHIGAVWotSvO4=;
        b=PfimNP2zjnMSzNgDNv8rRsK57szhoKHfOBTTFI8c5g/iY6MUIxprx3MdiPU8dxIMPT
         nY4nMKkR6VWMKgfAJj1ZVqtPGUWKuGCLmwI8maeWXd73Svwh74n0j6zLYcdWsOZLJXXj
         jPsTEGOxat+rGbfujEFQ+BEGykFx/8sWwTFKf1JeOWB4V+3Xo/AzOPApMDqhJRAVy2n3
         URraQ5oIZcj4nEEQKhS3heL0q/9KyQqhf5uLamlymGqnUkihzYZUBc2WmZWbY0kJfMda
         9mcMS7YtXYEDBUNYfaFs/CGz9Xw7qv3KA9zIGcfr2sKZsPQNVRB6Rf3pQuqOGJfVPtW2
         LNjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCEEt2EhxtydrLsJJq4MZZi4lgyYLLaW3i42CGKEM46/Lj5ilf5sTPSc3Nl1sg8jbX6QkvkLz8eLFEawY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy30T5NApKeWrhIHpxAdJPDFzKYq4uyuUHTJC/2XWAvrYipz1ya
	4vJA6VgTAtiaBKsex/1oWLTO7qoeaSVBVbC+/lFaCKzmL+jiUaT+9VupMNp8S06q/ZZYcFQph4Q
	J1l0mGrIuVwoksiI/oYhZC24fsqV+9szl7cviPaT8lhyEQXYKDkDZdXbsZOiUlw==
X-Gm-Gg: ASbGncvLGT6gA0Z5lQqDWwIhanTfRhH+SbyF3tTLx5/t2m6bof2H3JJmoeMhqDpNuuD
	kAJHajsYfG6z4kNX/G7X18n3ayYhkLg8+8Q8UENg3Fg+5lysQ8sRXhrjdliry3Z930vxCKcvsZf
	7tXZl/IAGzAITAAgA37Mee3vmHpNhauPE0eiTXwQmXFFhkLeS464Uxq8u4O9OvyJDFihLkHa8ME
	BPyS/kYb1dJvzEuXldG80oeEuvCPsfMiP6sI+w1QRGVKJSVzg1Xh9/0B8hdJAMOPfLU48N68UVw
	a3r//nsyD4ZNIA99JUqeYYDF
X-Received: by 2002:a05:6000:1f88:b0:38b:f44b:8663 with SMTP id ffacd0b85a97d-390eca38bfdmr3863877f8f.55.1740755885152;
        Fri, 28 Feb 2025 07:18:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+h8QzgQEysGgPFIp2qJ/GwMRCcXRRRrDEODCU9GYT3OUmcARrVeMuokjbfP7Emvy7x9Abdw==
X-Received: by 2002:a05:6000:1f88:b0:38b:f44b:8663 with SMTP id ffacd0b85a97d-390eca38bfdmr3863654f8f.55.1740755883253;
        Fri, 28 Feb 2025 07:18:03 -0800 (PST)
Received: from ?IPV6:2a02:8070:4688:86a0::a40b? ([2a02:8070:4688:86a0::a40b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5870e7sm95040575e9.35.2025.02.28.07.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 07:18:02 -0800 (PST)
Message-ID: <7c5cc18e-71e0-4ebb-bb0d-5765a9467753@redhat.com>
Date: Fri, 28 Feb 2025 16:18:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] SKSM: Synchronous Kernel Samepage Merging
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, Olivier Dion <odion@efficios.com>,
 linux-mm@kvack.org
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wgedRzDqOLhbOnvziVHZm9jtGOrT4GJEqA9etJDwTQ5Mg@mail.gmail.com>
 <8524caa9-e1f6-4411-b86b-d9457ddb8007@efficios.com>
 <CAHk-=wi5-+P49c3NPeZB_qrNyOtAJS3YadHB0q7J3eZ3UUwrjw@mail.gmail.com>
 <029759d4-f7b2-4ec6-b5d0-7c8a1c0fbd80@redhat.com>
 <78ebaad9-c7ba-423a-a824-c2b1a499aea6@efficios.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <78ebaad9-c7ba-423a-a824-c2b1a499aea6@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.02.25 16:01, Mathieu Desnoyers wrote:
> On 2025-02-28 08:59, David Hildenbrand wrote:
>> On 28.02.25 06:17, Linus Torvalds wrote:
>>> On Thu, 27 Feb 2025 at 19:03, Mathieu Desnoyers
>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>
>>>> I'd be fine with SKSM replacing KSM entirely. However, I don't
>>>> think we should try to re-implement the existing KSM userspace ABIs
>>>> over SKSM.
>>>
>>> No, absolutely. The only point (for me) for your new synchronous one
>>> would be if it replaced the kernel thread async scanning, which would
>>> make the old user space interface basically pointless.
>>>
>>> But I don't actually know who uses KSM right now. My reaction really
>>> comes from a "it's not nice code in the kernel", not from any actual
>>> knowledge of the users.
>>>
>>> Maybe it works really well in some cloud VM environment, and we're
>>> stuck with it forever.
>>
>> Exactly that; and besides the VM use-case, lately people stated using it
>> in the context of interpreters (IIRC inside Meta) quite successfully as
>> well.
>>
> 
> I suspect that SKSM is a better fit for JIT and code patching than KSM,
> because user-space knows better when a set of pages is going to become
> invariant for a long time and thus benefit from merging. This removes
> the background scanning from the picture.
 > > Does the interpreter use-case require background scanning, or does
> it know when a set of pages are meant to become invariant for a long
> time ?

To make the JIT/interpreter use case happy, people wanted ways to 
*force* KSM on for *the whole process*, not just individual VMAs like 
the traditional VM use case would have done.

I recall one of the reasons being that you don't really want to modify 
your JIT/interpreter to just make KSM work.

See [1] "KSM at Meta" for some details, and in general, optimization 
work to adapt KSM to new use cases.

Regarding some concerns you raised, Stefan did a lot of optimization 
work like "smart scanning" (slide "Optimization - Smart Scan (6.7)") to 
reduce the scanning overhead and make it much more efficient.

So people started optimizing for that already and got pretty good results.

[1] 
https://lpc.events/event/17/contributions/1625/attachments/1320/2649/KSM.pdf

-- 
Cheers,

David / dhildenb


