Return-Path: <linux-kernel+bounces-547642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3939A50BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E35E7A5DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD59253F24;
	Wed,  5 Mar 2025 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBDmC7Ud"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D7024C062
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204170; cv=none; b=C+LPWk7X8cIdHIll1S3OrcAWOeSvqMmTwow7xlEuaz5fUcUhLBP3pKDnd0qRvKoGGj6yJfR6gDT9p044fggbH2sgwLW2A6HIKVU63fLwHO/zWVX+k57RHgHH3KhQySIJ1QuVUZlc8P8buHJOUOvoyUiFt3hScXcr0iBsvSEoiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204170; c=relaxed/simple;
	bh=Hk1Ju+6+lnMPErwaMCbnFHDb0WcrpE4WwWYUxrm7PCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCXVb8L9odYbHKzz20p0rOCl5HFexkiGyTpwOdLjbuFR2Vm7S4h9tsahB8/u1YoRMKprFEcUdi03PQc2C8Z6TAzN6c6H1aXXtQIKKrlJZSdPjRsF3xlgt/KPXxwmCr0X1PT4K7x4RZM3ugVS5FtidQRtumjrOaofIMvhDBgB6aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KBDmC7Ud; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741204168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=03yN7yH51hsHUzMn2+esz4Pv4dir90wQl0oFMfmdQtc=;
	b=KBDmC7Udrl7hAh915R3SicnfsNNNdw6auls9miXJ6vio4w1JV6GXlKdg4MU2ugzUUfjNIc
	7PsWGvNnKxpirjtLiG4ozfJ8lyMSFkmgbvG6aNDENChdVAP7suC0OlDKxu5Q9+EoBA9pOv
	sM8aj5fzzFGQoaNy6JMSsIR1eey1Oz0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-yBEH8jxONg6xyod59flq8A-1; Wed, 05 Mar 2025 14:49:22 -0500
X-MC-Unique: yBEH8jxONg6xyod59flq8A-1
X-Mimecast-MFC-AGG-ID: yBEH8jxONg6xyod59flq8A_1741204156
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bcd9a46feso10123405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741204156; x=1741808956;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=03yN7yH51hsHUzMn2+esz4Pv4dir90wQl0oFMfmdQtc=;
        b=H+K0B8wS20GWuHkLuu5QOG95+VZh5RbpBxoGxefiFIxoiQWQy6cr5TMy84QOZAjshi
         bQseTpHHIYiXnf53RoZGAw4xSDDh3HouT4so/230upe9+xPgD7fR7MsfW5ZbbeC/U5Qe
         /QxMAqfrn3WDD9O539hO+vO/AobdXJL6EavCNHMr6D+QVj8yKi5lM12hPObUi87AwXCU
         YTHrrMHmT7E3QoScs2SLxuqg8HuKuzcYdp3t8Uxpx5MR+BqfbXPyjVuDVGwv+ZlpaUGX
         NB134Bs7V2V/pwk0ytgNa88qUXafbwnProR0TK0J5wKXIB7yKznSV6wsWvki0C2592q7
         HMqg==
X-Forwarded-Encrypted: i=1; AJvYcCUbUh9XWCxLqKfpIuRTnf1LTea4/Z8A6BLhoYSVLPFqK90TgOEHhWbMXqLa4UPTLkIM4uzUtVenbYelk1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNLv0twqD+mLm51cG+8+r/uUfzSadU41n6MVrDdpY4qvciqAjQ
	GkljHuiqdJjErQl5ALRcQKBv705wFw65yEGfHFHuWMaJVcPElfIw5gewhvkE+sSVrgDUbz7lsk0
	9INVVxgzkZPoTg+MQdZj66aKtRN/LCLHIKZFVWVjjQluzvzpVA1xWMeH+nkhVjg==
X-Gm-Gg: ASbGnctG19l+yq4u/ywZ+XN0oXqvALyZ5jUhBCNlp2225ajLjhSHEHHeaffO7Dp6AB4
	GCPEZwuPQmxmty+25HNp2SrkOLl9XKADIhnzk4Yawf1urlX+9yJt6qW23xN9CFo5HsZT/77XNOz
	tnUwCFcZJIwZdRdm36PyOwWypUSkHO3d2RbcVQ7KyaGJ75X0X9kNktBfKrP1IcRaMlwpShhlAgT
	Nf4MeMSjva21E0dHmCGA5/pq4OBZBTomwMpagm7YTDKzWIQXCgGWUXLevlRqeYMFXCmn8afzoRD
	mqzo/KS9d6c/q/i67yswHfQzVa9OYtPjrSdn8aMboiRMChZ3AyArx4NnbR2Cuk1oIZOq9bkm50R
	8lvbuOYqm+qHJVgyedtUkHz314L8liG7HyxpYR2DWx7g=
X-Received: by 2002:a05:600c:35d4:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43bd298f9fbmr41869685e9.11.1741204155842;
        Wed, 05 Mar 2025 11:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHaclzLgfCSRWemIkkhnUP4/0u1OqlT3G4gkm4XEO0QvHJdU5h97AT9npPILhWPM591bWsdJQ==
X-Received: by 2002:a05:600c:35d4:b0:439:9f42:c137 with SMTP id 5b1f17b1804b1-43bd298f9fbmr41869485e9.11.1741204155413;
        Wed, 05 Mar 2025 11:49:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:5b00:84f2:50f3:bdc8:d500? (p200300cbc7395b0084f250f3bdc8d500.dip0.t-ipconnect.de. [2003:cb:c739:5b00:84f2:50f3:bdc8:d500])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd91338cesm14038955e9.7.2025.03.05.11.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:49:15 -0800 (PST)
Message-ID: <7e151e6b-3f81-4e37-b314-c6e9f19c1b82@redhat.com>
Date: Wed, 5 Mar 2025 20:49:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for MADV_DONTNEED
 and MADV_FREE
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>, SeongJae Park <sj@kernel.org>,
 "Liam R. Howlett" <howlett@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
 <snby4wevysj2hr6rmqcwezcujhwmjgtby6ogkrc4wmqnzcqcsv@tu23rsyltc2m>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <snby4wevysj2hr6rmqcwezcujhwmjgtby6ogkrc4wmqnzcqcsv@tu23rsyltc2m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.03.25 20:46, Shakeel Butt wrote:
> On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
>> On 05.03.25 19:56, Matthew Wilcox wrote:
>>> On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
>>>> For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
>>>> can happen for each vma of the given address ranges.  Because such tlb
>>>> flushes are for address ranges of same process, doing those in a batch
>>>> is more efficient while still being safe.  Modify madvise() and
>>>> process_madvise() entry level code path to do such batched tlb flushes,
>>>> while the internal unmap logics do only gathering of the tlb entries to
>>>> flush.
>>>
>>> Do real applications actually do madvise requests that span multiple
>>> VMAs?  It just seems weird to me.  Like, each vma comes from a separate
>>> call to mmap [1], so why would it make sense for an application to
>>> call madvise() across a VMA boundary?
>>
>> I had the same question. If this happens in an app, I would assume that a
>> single MADV_DONTNEED call would usually not span multiples VMAs, and if it
>> does, not that many (and that often) that we would really care about it.
> 
> IMHO madvise() is just an add-on and the real motivation behind this
> series is your next point.
> 
>>
>> OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
>> would make more sense to me. I don't recall if process_madvise() allows for
>> that already, and if it does, is this series primarily tackling optimizing
>> that?
> 
> Yes process_madvise() allows that and that is what SJ has benchmarked
> and reported in the cover letter. In addition, we are adding
> process_madvise() support in jemalloc which will land soon.

Makes a lot of sense to me!

-- 
Cheers,

David / dhildenb


