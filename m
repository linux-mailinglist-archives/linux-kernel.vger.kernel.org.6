Return-Path: <linux-kernel+bounces-425583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFA69DE708
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C1A164006
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC819D8BB;
	Fri, 29 Nov 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnS94GXv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7C156991
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885961; cv=none; b=Gv2V68MkHe6Bmq/r9QmJZEIbYaNekZyzsJPYFKaV95N+PqmsBkYo4RlRlb8DpTRIZFOcpRPWT/acYj7us7ctzVFQKufprx+3k0xk0btlm8oGJAYqQcpQGemFlZaT29YNgSn38ZjIXL8psHVj9JuVv3EOZAQYjn5Pq+VxHSqNQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885961; c=relaxed/simple;
	bh=jeExHsTopGg3lPs7vDqTygzkFIo/Hh0Ypi4h74FHzCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fg6axDJzVALZY4QsBx+/QY4tAizKZN2QkeDwymjIeCXtP1oNo8m54Am5LzuYch3jn5pY1U2c4KiR0QD1Fg+GwVaCKzHfZmqPh+ivuH3hVVsYyty8mBGCbSUtAd+s6mVZ/JniiZ7bwODj6J2y/N0M7JIfUgzKyCrCWpJ8HzxcDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnS94GXv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732885958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/hwYR3GugWMMQOPEFk6JjTcCSdLv4Wb1R0aJ/cKX0Rk=;
	b=EnS94GXvRuDu/96fhzLdOLQ+v9eimZpTH/yzWwBdKqjKWqD5HJ6k8jvKAdPzPgEGJ4nvOB
	8cXSJODVvigHCI2L9KlEdA2N7wgEruaJMq+zK3nseZNYIitOYlhALIvqkRdYhvrf+x9ZUL
	ST3J0WmXaVVcd+Ek2c/61geMHwRo1TM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-w_YwSdL1M6KbUJPzpQ4rsQ-1; Fri, 29 Nov 2024 08:12:36 -0500
X-MC-Unique: w_YwSdL1M6KbUJPzpQ4rsQ-1
X-Mimecast-MFC-AGG-ID: w_YwSdL1M6KbUJPzpQ4rsQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e03f54d0so209820f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:12:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885954; x=1733490754;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/hwYR3GugWMMQOPEFk6JjTcCSdLv4Wb1R0aJ/cKX0Rk=;
        b=X/3UxE8+vcLL2rsqHaaDvquOsu4Wu9zTOoC5yj6kG3026DKANNvdOJ/MJWaQWUG4FL
         mKpEZqOfBiqAeSgOI0iYK/XtXO2gQHXQmIUIx0z1tm0nHzYVKsrhCVDwFU/r3AkOx7rG
         JHXLNEYX++s4+NidFDswulIiPPFJPF7JUaKWoxyicII6OssrMSGYybSibBFXLKBWQFJU
         pcAPfVh40GX9U2AYg8tsvY5jsadtu6xj+rdT7cJyDopO8PwGOh8N/1xF+sjsBeiu3Fvk
         bangMeIXNFlMibS6I3YETyKfqsN8uUOLWCT4j+CbGtwpnkyZYNtg6miqdCVYrfXrhRBg
         g35w==
X-Forwarded-Encrypted: i=1; AJvYcCVPnGg8tBJVCy5OaLEu5cv+R0TGerF++MSu0frIUdeDKO054nA1gYB7QEWSJUY6zkurGTYFSfT4/wtcPJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWUwggngqtXgfbAglbWMnUNNFxo0m2tce9VOUG+bfKV+d8wmn
	F0kdqdexciubw6Y2DLHa0w3xDTa1I0QuARDF++GioeFlrRvK25kwAyzcJY6CjYryzs/l26FZMLG
	lgoqgc4Bjb//vFntuuF9ztrrQtcc4HP7ZbOYqfSKzOIdEE//ROoFPyXc7ErffAg==
X-Gm-Gg: ASbGnctORYeFFniR2R5wW0g5nteSMAqDJCbFdqMZ0yO/HO3rdPljyAapsSteP2L1kmB
	lVUafpGRWfERdGYRV4IF+8a3vkJCHX08BunN7QFSmvMCUsYyHEwyGuBFEAFzfGX5qLuZyTQToDZ
	kwAwufQ32aKMQcEGFwgvVaHPRrSkFkHAlHRHQb68nOrD23Fr120SWdgckXQnohVRXVYOxLlVypN
	+q+Li+5lzZHkaryKf4sgG7kmWcXRhcPXLu2E2ebnhj8gFf3zBW080ozOeWTUtD/pVuwmPaoioVi
	drbsyDEoWE95hq5skWHNacOBIE98tI/ySFgoF5oZMZmOcsukgVbN++jBosBJk4mtpOhycqhkaLV
	LJA==
X-Received: by 2002:a05:6000:156c:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-385c6baa5e6mr10230037f8f.0.1732885953649;
        Fri, 29 Nov 2024 05:12:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExEsoo67CVLNXO6FfxW8tgx24WlQQ/AN54SY+SW6f+rWspF1wsgU4wFEKp8G3gjjeOVuSyCw==
X-Received: by 2002:a05:6000:156c:b0:382:22f4:7773 with SMTP id ffacd0b85a97d-385c6baa5e6mr10229012f8f.0.1732885945142;
        Fri, 29 Nov 2024 05:12:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f2c7sm85744075e9.2.2024.11.29.05.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:12:24 -0800 (PST)
Message-ID: <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
Date: Fri, 29 Nov 2024 14:12:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 14:02, Lorenzo Stoakes wrote:
> On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
>> On 29.11.24 13:55, Lorenzo Stoakes wrote:
>>> On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
>>>> On 29.11.24 13:26, Peter Zijlstra wrote:
>>>>> On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
>>>>>
>>>>>> Well, I think we simply will want vm_insert_pages_prot() that stops treating
>>>>>> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>>>>>>
>>>>>> We could start that work right now by making some user (iouring,
>>>>>> ring_buffer) set a new page->_type, and checking that in
>>>>>> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
>>>>>> and the mapcount.
>>>>>>
>>>>>> Because then, we can just make all the relevant drivers set the type, refuse
>>>>>> in vm_insert_pages_prot() anything that doesn't have the type set, and
>>>>>> refuse in vm_normal_page() any pages with this memdesc.
>>>>>>
>>>>>> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
>>>>>> these things will stop working, I hope that is not a problem.
>>>>>
>>>>> Well... perf-tool likes to call write() upon these pages in order to
>>>>> write out the data from the mmap() into a file.
>>>
>>> I'm confused about what you mean, write() using the fd should work fine, how
>>> would they interact with the mmap? I mean be making a silly mistake here
>>
>> write() to file from the mmap()'ed address range to *some* file.
>>
> 
> Yeah sorry my brain melted down briefly, for some reason was thinking of read()
> writing into the buffer...
> 
>> This will GUP the pages you inserted.
>>
>> GUP does not work on PFNMAP.
> 
> Well it _does_ if struct page **pages is set to NULL :)

Hm? :)

check_vma_flags() unconditionally refuses VM_PFNMAP.

-- 
Cheers,

David / dhildenb


