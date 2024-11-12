Return-Path: <linux-kernel+bounces-405535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3519C5297
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDFDB284FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F820E325;
	Tue, 12 Nov 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQRhNUdY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA215539F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405635; cv=none; b=BRTTwmfpaXuECsbL2hhtLV2+YhKnxFjZe5H1XvD9h/3yXJIFgPmaBmjyQuUjn5bzg6ScFoEXR8DHJg/VUF6lR8vUUz0/juxPUwRTnvoMX4nT4DgvMSx/ByqHUbe/AR4lAikaP2JeFNZGt+RkS0uhBqGlqfIMBZFjD/+3K/2vnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405635; c=relaxed/simple;
	bh=PZpWwIaqpEkf0GddjPCXdhQFVh+zdBbtaLAf1Q8J9LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxbugxYRwEOiSgCMDH14n4J6+HCBHVGX1zPXEejgqayHD2xKfcBjfCWTaZJGN41fj1sAAKcD06sQr13CqKIlJ/4yTRwohR3uqVNdyerh/79/hjY6DFYLZmp5iSOal33Cp9WKGOeXRHX5s1SZpY4iqA+Once59N31scP4JVx5qw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQRhNUdY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731405632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/g7kvUmEiFxKI9h6mQjPf5Uq7FOJ+DtGygEwGMCj0Pc=;
	b=WQRhNUdY+4Ni38QYyREPqXbmBRvkaytVXsB+UZ5/oclIq+Z8MTi6P/tLuVy2mEcgIPzWcm
	XiosG6XUZR2EE2psxFiL1oaWr6sihxqrZ+YE95gvcvfKwkzstl1TsTB6mebnHDmVBcZKKy
	Lfc7a2CTs3gWfIJjPDNREjCaakXtNZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-k94AFCU-ONmWYcAh_ALF3A-1; Tue, 12 Nov 2024 05:00:30 -0500
X-MC-Unique: k94AFCU-ONmWYcAh_ALF3A-1
X-Mimecast-MFC-AGG-ID: k94AFCU-ONmWYcAh_ALF3A
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431518e6d8fso39525915e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405630; x=1732010430;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/g7kvUmEiFxKI9h6mQjPf5Uq7FOJ+DtGygEwGMCj0Pc=;
        b=X/MNJEwtJrgTVdlI6RvceeyEy6UamN8XBC8k75HSj4vTZhlGaFP2svinN9hrTwiBYl
         GUzsjD9L0b4KgFHCI0axYJClO7CL1U992osc1K7icH1PQOCRKZF2hrjpO3MTvEwMU8L6
         NRa090LyeobQiy0Jjismc4xL/kA5eIRQZoOP5WKKsgdGnl7kOq4odU33ByR/sCGRYoMw
         q5W81kMRSuvRw3EFss90Cvmp2Ds0HZTg+B8GsdQX00tl1DI5IVaXCqEWSaNYXlr8gF/l
         QnEeXLY+eRvgasQ0KTzaoLgZVo6DlEy3cROZaLesOarZzVKY97LvAnF4wYreQ/2s+EMt
         My+Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4sq/diPvr2BCZEFU5sGrjTlbng27a2atg/UIUvAgPmHYU/IYnnJ1z29DGccRO1hEbz61YJMYnA5mZ1Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWc3yYC325dcCOMrexdJV+puJKCwEmrlGsJVugcJo+pwl82ag
	CzHHSkcHsZXiDYxhjXTyqmtgc6Vq9I1VLHkT0WLrIdZAsIB4TGWdJKjJ0Wlt3lcQ21xjHDhDer+
	jKF8C9x73J4qvbe134C5lln7Ww1b5WQD1xspNYJ1CehqaK30lQ4je6CFstvztzA==
X-Received: by 2002:a05:600c:4587:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-432b74a0c04mr143719845e9.0.1731405629738;
        Tue, 12 Nov 2024 02:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqTqPH/uell8dxfDHzR5SZujlJDZ25L/v3M3oMrYgW7GP8h3EzFcDSVtowC6DEhh3Ic5I10Q==
X-Received: by 2002:a05:600c:4587:b0:431:52a3:d9ea with SMTP id 5b1f17b1804b1-432b74a0c04mr143719395e9.0.1731405629258;
        Tue, 12 Nov 2024 02:00:29 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda0411csm14784067f8f.95.2024.11.12.02.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 02:00:28 -0800 (PST)
Message-ID: <50578e9d-6562-4f0f-af7c-cabfb875bbb7@redhat.com>
Date: Tue, 12 Nov 2024 11:00:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
To: Asahi Lina <lina@asahilina.net>, Alistair Popple <apopple@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Dan Williams <dan.j.williams@intel.com>
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
 <c00226ea-6e29-4432-a1c4-a25e9e05df9c@redhat.com>
 <2d8380b9-3d03-4263-b5bf-7e0227c83ba9@asahilina.net>
 <0977a33b-8318-43a5-a5a1-4eb8c93ca270@redhat.com>
 <64d386e8-6684-4213-8aba-7d1daf94f2cf@asahilina.net>
 <412298ff-80bc-4111-8c72-29a5263a5d32@redhat.com>
 <87ttceu0i8.fsf@nvdebian.thelocal>
 <821d15f9-233e-4b9d-8194-5de1835113c7@asahilina.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <821d15f9-233e-4b9d-8194-5de1835113c7@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.24 10:48, Asahi Lina wrote:
> 
> 
> On 11/11/24 8:24 AM, Alistair Popple wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> On 07.11.24 18:32, Asahi Lina wrote:
>>>> On 11/8/24 2:14 AM, David Hildenbrand wrote:
>>>>> I recall that there is still a problem with false-positives on
>>>>> folio_test_anon() with ZONE_DEVICE pages, so it's maybe not that
>>>>> easy ... and the whole get_dev_pagemap() stuff is nasty.
>>
>> Specifically FS DAX reuses PAGE_MAPPING_ANON in
>> include/linux/page-flags.h
>>
>>      /*
>>       * Different with flags above, this flag is used only for fsdax mode.  It
>>       * indicates that this page->mapping is now under reflink case.
>>       */
>>      #define PAGE_MAPPING_DAX_SHARED	((void *)0x1)
>>
>> FS DAX pages are never anon though, so you could probably test for
>> !vma_is_dax() and/or add an implementation of is_fsdax_page().
>>
>>>>> Likely we would have to do what GUP does, and temporarily grab a pgmap
>>>>> reference. Gah.
>>>>>
>>>>>
>>>>> So if we sort out the pagemap stuff and the possibly wrong
>>>>> folio_test_anon() on some ZONE_DEVICE pages (but not all, because IIRC
>>>>> DEVICE_PRIVATE can be anon ...), it might be doable.
>>
>> Correct, DEVICE_PRIVATE and DEVICE_COHERENT pages are always anon (at
>> least for now).
>>
>>>>> But it sounds ugly, especially because that code might change soon and
>>>>> not require messing with ZONE_DEVICE pages on that level.
>>
>> Yes, I'm hopoing to get the next version of that series posted this
>> week. I found a couple of other FS DAX bugs that slowed me down.
>>
>>   - Alistair
>>
>>>>> And then, we'd not be able to handle VM_PFNMAP cleanly ...
>>>>>
> 
> If this is all going to be fixed another way soon then I think there's
> no rush to get a workaround in earlier than that, I just don't want it
> to fall by the wayside.
> 
> We have my original patch downstream in libkrunfw (which despite the
> lockdep complaints does work in practice)

I assume it's sufficient to deadlock when a writer pops up after you 
succeeded with the first read-locking, and before you start the second 
read-locking. IIRC, rwsem is a fair lock, so read-locking when 
already-read-locked is not guaranteed to work.

That's why lockdep complains.

-- 
Cheers,

David / dhildenb


