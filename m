Return-Path: <linux-kernel+bounces-437267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D261C9E910B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB2D1886A59
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB11217F24;
	Mon,  9 Dec 2024 10:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaJ/pkLD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654152165F6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733741782; cv=none; b=D9fOuhkBqnpd15zCRhxZz10I78umXy+bfwkLa/zezyziZ4idg0Y96ikUzNkYw8QLxBdY9US7AQX6z6wOP1fL9LNheczKBaUbyj0yB+3/ycETutw2gI7fpLbER4pNl6wf2qm4WyjS6QIsSQ/JLT047KQy1YzGioYLUPplZVB/UwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733741782; c=relaxed/simple;
	bh=3r1r017xQ0bfBPZX6AJhQtn+7FlWzW+/NiOQ2g33wQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpENEmn9ZDqPmbXTcgPNv9/84ppkHPKwYtCIGEvExW9sFTiHFySH1ERwAzyx+o6LjmgnxHCoAX1i4MKVoKRlKvPnJlgnbAMRVUzkOIjM+XH6WdwjqvOPdHmgJLWlcMU7g0HiPtbRqR9m8FLNMmIlCJCqunKqryrknWMXnBcnvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaJ/pkLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733741778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r0LbryMuat7RH0ATlewYVWKmDIYyFyuiu+TeKBqC3xo=;
	b=BaJ/pkLDpGKEfIKFsH/Ibojqtr+vnmBNk7kauFuUPQS9fe0z5v0IEnt/XBlegACvOZ/8eo
	0OdzoduuEv5oxRiJjg2aVl/OV3fC5uA6lrG+hx9DbmVSyfO366BcEKfIkkUj0YepYCN8ss
	qcaIBFCWCkkJicsyXO6lx0y/ajoHWT8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-EoMfmN43PxSZOtgOoHGyBg-1; Mon, 09 Dec 2024 05:56:16 -0500
X-MC-Unique: EoMfmN43PxSZOtgOoHGyBg-1
X-Mimecast-MFC-AGG-ID: EoMfmN43PxSZOtgOoHGyBg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so2264390f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 02:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733741775; x=1734346575;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r0LbryMuat7RH0ATlewYVWKmDIYyFyuiu+TeKBqC3xo=;
        b=OQFcM7CyQ9GrOF6dYkj45KC2Z/T/iPuSQ+XCkbk0wtuR4O7MweGMc+nBO+Nq48nc3P
         KIWA1sedTqKDJheNKJr29Iz7zh3G9tEA9bOExa+tJln1/ZEUC4rw5dSYMXKOq41+uWNI
         +7xFRDQv/daPivs/991wnN3l69dWmr7yY3xOGlhfaLDVHH7ZTXgDvC1tsdbsYdU3pYpY
         UMUVXjlXsmQ6GuhN6vqLBihuWSdDLFx68Ir+kz/XzIkisR5GOP6voX583QLllm4/4crr
         dFCrWUf3NYKGk7pmhHFoMxXZaJqnzzhNFZ/rq+m5z7innccQ/izZdfgVCKK2lqQdu/fU
         dEXA==
X-Forwarded-Encrypted: i=1; AJvYcCW1oxzU5jm279DqkGjbVtYXtkrHHeG1ucAmKpwnnTtLE3TXKrEGOFvmmicFhl1fE2ArhE1BbKe6fACUWDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQiL49zDCiz7I/tHAe9wmt77JNgxpNOOKfRdb/XCs3e/Qz24t3
	gkGwiX8SGO63tfMqhwoO7W0z+Z7QsASjgu3s1HhuRr0PJS0AKy98nYUdRylKMnEKGhtU+UK3xvg
	bt7HDJTgs/oHSYrqaw5nRlAPNTnyYIOHS6nN0hJTu/Np1UdSjGQxrTluraz46Vw==
X-Gm-Gg: ASbGncugTq6wCaG8aMQtOXuxJcpuVB5H9+T4xYKcQdGMEkNDUdkhp+g8L0aIUTQJ9Xf
	OFj+fS9PGRY4Y6iRj9cu7mEUT2p8LWImH4brT9L5EN6EuW1cPaWIs9e4pMIbWqEQP2gTHezBy41
	3RjzaqGCBgkLucfERKVtAki5jBEENGdwcqhK+3mQehguNRdGPxT3jxbhf65Ux2TDYlQJ37HMepL
	lQujfSGIaRGY6tVpm0ds1FGdHmZxLRtXTHSxOfyGF2eLybFy5XjmAnceUUCcPIlKPC3W+SJWj+d
	Ma0cQh+x
X-Received: by 2002:a5d:64e8:0:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-3862a914866mr7419448f8f.19.1733741775660;
        Mon, 09 Dec 2024 02:56:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwcP+cRMRrf3tdHGbxQ+3psA3g0VschafaLoZwoDwMwNQZXeIZnYXR+fpZ3kjCQCiAi/kuXQ==
X-Received: by 2002:a5d:64e8:0:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-3862a914866mr7419428f8f.19.1733741775304;
        Mon, 09 Dec 2024 02:56:15 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f4a8758sm12669019f8f.27.2024.12.09.02.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 02:56:14 -0800 (PST)
Message-ID: <606fbf9a-c9ba-4f08-a708-db38fe6065ce@redhat.com>
Date: Mon, 9 Dec 2024 11:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: remove an avoidable load of page refcount in
 page_ref_add_unless
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: yuzhao@google.com, akpm@linux-foundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241207082931.1707465-1-mjguzik@gmail.com>
 <94d0dcbe-2001-4a9c-a767-b337b688b616@redhat.com>
 <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGudoHEggB=F9j7r+ndQs1WxpRWB4O5VdBo+PLx+yd1xrj4-Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.12.24 11:25, Mateusz Guzik wrote:
> On Mon, Dec 9, 2024 at 10:28 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.12.24 09:29, Mateusz Guzik wrote:
>>> Explicitly pre-checking the count adds nothing as atomic_add_unless
>>> starts with doing the same thing. iow no functional changes.
>>
>> I recall that we added that check because with the hugetlb vmemmap
>> optimization, some of the tail pages we don't ever expect to be modified
>>    (because they are fake-duplicated) might be mapped R/O.
>>
>> If the arch implementation of atomic_add_unless() would trigger an
>> unconditional write fault, we'd be in trouble. That would likely only be
>> the case if the arch provides a dedicate instruction.
>>
>> atomic_add_unless()->raw_atomic_add_unless()
>>
>> Nobody currently defines arch_atomic_add_unless().
>>
>> raw_atomic_fetch_add_unless()->arch_atomic_fetch_add_unless() is defined
>> on some architectures.
>>
>> I scanned some of the inline-asm, and I think most of them perform a
>> check first.
>>
> 
> Huh.
> 
> Some arch triggering a write fault despite not changing the value is
> not something I thought about. Sounds pretty broken to me if any arch
> was to do it, but then stranger things did happen.

Yeah, it really depends on what the architecture defines. For example, 
on s390x for "COMPARE AND SWAP" the spec states something like

"When the result of the comparison is unequal, the
second operand is loaded at the first-operand loca-
tion, and the second-operand location remains
unchanged. However, on some models, the contents
may be fetched and subsequently stored back
unchanged at the second-operand location. This
update appears to be a block-concurrent interlocked-
update reference as observed by other CPUs."

So there might be an unconditional store on an instruction where one 
would not expect it.


Something similar-but-different recently popped up on aarch64, which 
does what one would expect:

"The atomic RMW instructions, for example, ldadd, actually does load +
add + store in one instruction, it will trigger two page faults per the
ARM64 architecture spec, the first fault is a read fault, the second
fault is a write fault.

Some applications use atomic RMW instructions to populate memory, for
example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
at launch time) between v18 and v22 in order to permit use of memory
concurrently with pretouch." [1]

And Christoph commented:

"x86 does not do a read fault on atomics so we have an issue htere." [2]

I did not check if that is actually true on x86.



> 
> However, if this is seen as a real concern, then I think the best way
> forward is to drop the patch (and maybe instead add a comment what's
> up with the extra load).

I assume we're currently fine because no architecture actually defines 
such an instruction that would be a problem for add_unless.


[1] https://lore.kernel.org/linux-arm-kernel/Zmw1jltdkMrTrT_l@arm.com/T/
[2] 
https://lore.kernel.org/linux-arm-kernel/c1ba9ba3-b0d6-4c6c-d628-614751d737c2@gentwo.org/

-- 
Cheers,

David / dhildenb


