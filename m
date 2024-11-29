Return-Path: <linux-kernel+bounces-425629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD4B9DE801
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007A21617C0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05D519F128;
	Fri, 29 Nov 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSQXEyI5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1C11E485
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732888088; cv=none; b=sABgjHkyDGJQl8aRUN3qVlQvZ4ZZDetN3qitUCFxHnXv3CmVlwbz8Tabj0T8JA1Ul7+uN97smh6nVEtRaIiHIRKbsJoRFKQi37dnJYdo+digjsHGWQ06xo8ApzyJV9rYal6KouSGVfpXb8pBk/NCc6qOHxDqa2ZpD7ykBWHH5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732888088; c=relaxed/simple;
	bh=Nov4WwVgnw9MBLZF9YdzlkYIbU1JeR7TcCld3ITeakM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l8a74ifbslK/+IVa7OlO8FW0aOrteMNuYli60sJaVXhiPdAe3Cxrsip9oWuatHwavbqab5sVW0qCnuXHsfpmGzMhiyEHiUwPpTarWmDSrJtF88xJQFS05XjvS6PyeyDyKVaH3KF2GT6c9JrtCq+p9YPVUQixh0k+Y7Il3tQ0RTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSQXEyI5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732888086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HMmFWZIVsvsZuC4wwiEbwa+1U6EsQirOx43TwVqzJz8=;
	b=dSQXEyI5Q3cT6S5ATZQwJYFFvBhRtc33F2tu6i7DnDh0qzmqCHPxewCbjvXjwNNsMpZyF3
	G49iqXKrHMAzyJT9ENa9sMew+M+wS+5FIN7ykXHBJ/pyQtbzKTl7eN6P2/zsGaBo8qah7B
	lPZYswatTsV8TvYZuRGTNf34Da2g4cs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-uomxcEfXPlSkf8hcIG3kBA-1; Fri, 29 Nov 2024 08:48:04 -0500
X-MC-Unique: uomxcEfXPlSkf8hcIG3kBA-1
X-Mimecast-MFC-AGG-ID: uomxcEfXPlSkf8hcIG3kBA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d7f6dff1so607197f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732888083; x=1733492883;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HMmFWZIVsvsZuC4wwiEbwa+1U6EsQirOx43TwVqzJz8=;
        b=JpSh4qQeTDScVP+PT0ObPwruXaFZ+jGqbP9EZqJaXHzqyJ+r4kpcHu0anaUBPONwvA
         fI9NlayhKlR3MpqBRyXaoXP+2nUl/Xzp0By4Cqv76iUpzgY3Z9w4DGYtoEZ56U8JZTuq
         Wk/0iLwtlDn5mwL76HO1a+uMQK28LZOmEDyK63ak9DNVRVb+tdvowVK4FjFZ/9GkbHwC
         SkvFGNdBVKwwi2gw7Fx4FDmEBLUu6mh2y4hxefWUzRgcTtNSJ0RI7yjZzo9VQx6Oi9tz
         Xh5rAQ9IurlXR5KCLmZMrOopmRrj0AVXZKq6Y3G7EBitkiz9kzPOVl+m6E4ZRigzsMVH
         N15Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHooGxhNPa/t/GQQqNNbqfK0AdM+YT7OpDAaA84ZB59k4MJiKaVc8vr7mm+/WKofB/sGe1c3N8qI+bXPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZt/6GKEzMblEETxkVAEwALOeWu23CLFtsEYMxoVzi5BAJx+d
	L99YQe38KbA+YpQSWRWfkvYuDM2oSWCSs6ZNrR/qjAxEEYQbOc6rpnpUUnuLU3pKCgBbMroPrPU
	HbMO6WGDuML3vSLfXJPtB2eRpBFhg52j/OYPCkn6NLL9nLb5mIbBls+/2DgaxkA==
X-Gm-Gg: ASbGncs+Kxz0BBI0XUnwT2sDiTrX4KhhJPRoqoXwz91runwgc5KW3TTJO7TehkfW/yd
	Kxtc8/I3QLorOHq2yEOkaU4Tag0OSNrGZqwOxuQdPdr2Ci652JRll/LOxWzvHUC/sDzrKAPvm+P
	UeEHeS+0Dnsn8GmfKicJt7IH2unX3RmBPKQYtzg2HCDF4zYYRP6Qjf+T5aEJCsThNWHwU/Nf8L/
	ueUW173cw9RHLEaI8CEzqAHhpcoctWubrE9Pt0VHkbex59U0RlQaxrNILyCMJ/a+X8e6TsUp5kC
	Gh6hi4mKRyuLizw7D8JDwmqSKio7PjoJoNOVRMw2sundT8BITvWb+WBn6s2/wJcA0NViRwrSrbY
	T6w==
X-Received: by 2002:a5d:6da7:0:b0:382:30a5:c389 with SMTP id ffacd0b85a97d-385c6ef3a7emr9621932f8f.53.1732888083378;
        Fri, 29 Nov 2024 05:48:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGTZXHyEY3ktP4oTSzHqL7LERPy1F+0VxB/twnxd1aG03ZdInm1v7n3bcdbCRWcBQr/hyMLA==
X-Received: by 2002:a5d:6da7:0:b0:382:30a5:c389 with SMTP id ffacd0b85a97d-385c6ef3a7emr9621903f8f.53.1732888083008;
        Fri, 29 Nov 2024 05:48:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2dad8sm4494852f8f.18.2024.11.29.05.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:48:01 -0800 (PST)
Message-ID: <9d4ef1a2-11fb-455f-8b37-954215bf25d2@redhat.com>
Date: Fri, 29 Nov 2024 14:47:59 +0100
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
References: <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <20241129122624.GH24400@noisy.programming.kicks-ass.net>
 <74be541b-22ad-42b5-b3c5-79b201e28f04@redhat.com>
 <e97dba32-b5a8-43b1-9bea-e42daf6078c1@lucifer.local>
 <9d6be5bd-ffb9-4a27-b56d-521cf6b7486e@redhat.com>
 <6cab3e8a-dff7-41d1-af22-f18b8f2820dc@lucifer.local>
 <c8ecd378-c197-4e06-94ef-e03b5ee28616@redhat.com>
 <94dabe57-232b-4a21-b2cf-bcfbda75c881@lucifer.local>
 <6795cc9a-6230-431f-b089-7909f7bc4f30@redhat.com>
 <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <60191c97-dce2-4a92-8b47-c402478ba336@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 14:38, Lorenzo Stoakes wrote:
> On Fri, Nov 29, 2024 at 02:24:24PM +0100, David Hildenbrand wrote:
>> On 29.11.24 14:19, Lorenzo Stoakes wrote:
>>> On Fri, Nov 29, 2024 at 02:12:23PM +0100, David Hildenbrand wrote:
>>>> On 29.11.24 14:02, Lorenzo Stoakes wrote:
>>>>> On Fri, Nov 29, 2024 at 01:59:01PM +0100, David Hildenbrand wrote:
>>>>>> On 29.11.24 13:55, Lorenzo Stoakes wrote:
>>>>>>> On Fri, Nov 29, 2024 at 01:45:42PM +0100, David Hildenbrand wrote:
>>>>>>>> On 29.11.24 13:26, Peter Zijlstra wrote:
>>>>>>>>> On Fri, Nov 29, 2024 at 01:12:57PM +0100, David Hildenbrand wrote:
>>>>>>>>>
>>>>>>>>>> Well, I think we simply will want vm_insert_pages_prot() that stops treating
>>>>>>>>>> these things like folios :) . *likely*  we'd want a distinct memdesc/type.
>>>>>>>>>>
>>>>>>>>>> We could start that work right now by making some user (iouring,
>>>>>>>>>> ring_buffer) set a new page->_type, and checking that in
>>>>>>>>>> vm_insert_pages_prot() + vm_normal_page(). If set, don't touch the refcount
>>>>>>>>>> and the mapcount.
>>>>>>>>>>
>>>>>>>>>> Because then, we can just make all the relevant drivers set the type, refuse
>>>>>>>>>> in vm_insert_pages_prot() anything that doesn't have the type set, and
>>>>>>>>>> refuse in vm_normal_page() any pages with this memdesc.
>>>>>>>>>>
>>>>>>>>>> Maybe we'd have to teach CoW to copy from such pages, maybe not. GUP of
>>>>>>>>>> these things will stop working, I hope that is not a problem.
>>>>>>>>>
>>>>>>>>> Well... perf-tool likes to call write() upon these pages in order to
>>>>>>>>> write out the data from the mmap() into a file.
>>>>>>>
>>>>>>> I'm confused about what you mean, write() using the fd should work fine, how
>>>>>>> would they interact with the mmap? I mean be making a silly mistake here
>>>>>>
>>>>>> write() to file from the mmap()'ed address range to *some* file.
>>>>>>
>>>>>
>>>>> Yeah sorry my brain melted down briefly, for some reason was thinking of read()
>>>>> writing into the buffer...
>>>>>
>>>>>> This will GUP the pages you inserted.
>>>>>>
>>>>>> GUP does not work on PFNMAP.
>>>>>
>>>>> Well it _does_ if struct page **pages is set to NULL :)
>>>>
>>>> Hm? :)
>>>>
>>>> check_vma_flags() unconditionally refuses VM_PFNMAP.
>>>
>>> Ha, funny with my name all over git blame there... ok yup missed this, the
>>> vm_normal_page() == NULL stuff must but for mixed map (and those other weird
>>> cases I think you can get0...
>>>
>>> Well good. Where is write() invoking GUP? I'm kind of surprised it's not just
>>> using uaccess?
>>>
>>> One thing to note is I did run all the perf tests with no issues whatsoever. You
>>> would _think_ this would have come up...
>>>
>>> I'm editing some test code to explicitly write() from the buffer anyway to see.
> 
> I just tested it and write() works fine, it uses uaccess afaict as part of the
> lib/iov_iter.c code:
> 
> generic_perform_write()
> -> copy_folio_from_iter_atomic()
> -> copy_page_from_iter_atomic()
> -> __copy_from_iter()
> -> copy_from_user_iter()
> -> raw_copy_from_user()
> -> copy_user_generic()
> -> [uaccess asm]
> 

Ah yes. O_DIRECT is the problematic bit I suspect, which will use GUP.

Ptrace access and friends should also no longer work on these pages, 
likely that's tolerable.

>>>
>>> If we can't do pfnmap, and we definitely can't do mixedmap (because it's
>>> basically entirely equivalent in every way to just faulting in the pages as
>>> before and requires the same hacks) then I will have to go back to the drawing
>>> board or somehow change the faulting code.
>>>
>>> This really sucks.
>>>
>>> I'm not quite sure I even understand why we don't allow GUP used _just for
>>> pinning_ on VM_PFNMAP when it is -in effect- already pinned on assumption
>>> whatever mapped it will maintain the lifetime.
>>>
>>> What a mess...
>>
>> Because VM_PFNMAP is dangerous as hell. To get a feeling for that (and also why I
>> raised my refcounting comment earlier) just read recent:
>>
>> commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
>> Author: Linus Torvalds <torvalds@linux-foundation.org>
>> Date:   Wed Sep 11 17:11:23 2024 -0700
>>
>>      mm: avoid leaving partial pfn mappings around in error case
>>      As Jann points out, PFN mappings are special, because unlike normal
>>      memory mappings, there is no lifetime information associated with the
>>      mapping - it is just a raw mapping of PFNs with no reference counting of
>>      a 'struct page'.
>>
> 
> I'm _very_ aware of this, having worked extensively on things around this kind
> of issue recently (was a little bit involved with the above one too :), and
> explicitly zap on error in this patch to ensure we leave no broken code paths.
> 
> I agree it's horrible, but we need to have a way of mapping this memory without
> having to 'trick' the faulting mechanism to behave correctly.

What's completely "surprising" to me is, if there is no page_mkwrite, 
but the VMA is writable, then just map the PTE writable ...

> 
> At least in perf's case, we're safe, because we ref count in open/close of VMA's.
> 
> This is a special case due to the R/W, R/O thing.
> 
> In reference to that - you said in another email about mapping one part as a
> separate R/W VMA and another as a separate R/O VMA, problem is all of the perf
> code is set up with its own reference counting mechanism and it's not allowed to
> split/merge etc., so we'd have to totally rework all of that to make that work
> and correctly refcount things.
> 
> It'd be a big task. I don't think that's a reasonable thing to put effort into
> at this time...
> 
> Also who knows if there's somebody, somewhere who _relies_ somehow on this being
> a single mapping...

The main issue here really is that we allow R/O pages in VM_WRITE VMAs, 
and want to make write faults fail :(

What an absolute mess, yeah, without some more core changes 
vm_insert_pages() cannot be used, unfortunately.

-- 
Cheers,

David / dhildenb


