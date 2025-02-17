Return-Path: <linux-kernel+bounces-516949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC03A37A14
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 04:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5431C1884A16
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9A514D444;
	Mon, 17 Feb 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0tBJOOT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF142A8C1
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739762995; cv=none; b=mBThb7e/PBwo22UHl5oCUn+wiZ+dkbgSX5HsJKJqxxgNHlwUEu+1vQapkkgwxTxdsrtN6bgvVwCyxpF/4hssYxTd8tXi8grs6c8X8kLhksHS3X+45h4wxEJrjGR898MtvFvz7eENPTeZnrsGrfXneo9oTDYpAddMtrVpfr+NxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739762995; c=relaxed/simple;
	bh=FL3ZsrfZxMGoXfY06SkF2H6GGli5f200lVWP0iyYqHw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=iXjyxOitiWr12jzIyanFI6foSDZoAjiRN7OtpHgCpjRgM0b63Flj45yj5SpRoEJRdumZnTWCLSAJGgNPfVtTjLQ9wUy5esbDDcDlzZmYuTXuUKbnQSZe/HwFtt3zpL2vzQD3jDtl8aHswfPvfGF9RhvbBLYdDKObhfCOZxDMa9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0tBJOOT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739762992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rWjuYHFq2b/x6u1PpE5bTN0UtHhvs4sXiLszKZ360YY=;
	b=E0tBJOOTbCyT74Z0T9378IMl7gOFQG/JMB+bqEp0WiFTWaHVPSP3zyigDtthsjzimEExON
	Do2fwGkfJ8rp6QaOtb5aW2xYcQPmcG1SrEDyAyQFT7/Gol1GouxdobAerznS0L9EDYB1eF
	vjVyy8MfYDKJMv2OaP7L0jF3mOXrpzc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-xyN1ikxlOKyTjtzkLgJhzA-1; Sun, 16 Feb 2025 22:29:50 -0500
X-MC-Unique: xyN1ikxlOKyTjtzkLgJhzA-1
X-Mimecast-MFC-AGG-ID: xyN1ikxlOKyTjtzkLgJhzA_1739762990
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-471f21160a9so15014941cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 19:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739762990; x=1740367790;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWjuYHFq2b/x6u1PpE5bTN0UtHhvs4sXiLszKZ360YY=;
        b=FlWr5xrNWzZiCB597rvdZhjgfsZ6k22FiSarz19WJLUsNqAKU/qJsI7Ddg/l9tC4ls
         RFCG+hMcC78ThsiTy1cXJfjSzCHPMt+2dM5uQAjb5fMdU6JwFXzZB3vF+6EPC+HqUYWL
         1mNPCKc5TlXBV0lHaYBTbVmROBy7Ko+jB3/dYyEnOu6aKcL3gECEa6Nd8XoemwR5xubG
         jp6ylNJK0qrLeK7XvoXOrp4qmX80IUsFyUWc0nFy6WJ5gGp/uA+jR1EduwtSR1ALmlCk
         QHI6OSqjCHBJUr5joxMJgRuXh0svf4pwcsMCHZMHSzPn5D6eKTVKvvrbpBCypL2+hgzt
         VGUg==
X-Forwarded-Encrypted: i=1; AJvYcCXzdwczZPbn9l00Rd346tUYqMRstqowEBhNhk9KMKBS+w0FWA4N7M19nmpAj3yEW0M3RgfzL+6e7GLMSgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSw3kj6QCYWwe59OYApW+gkMdf9w6WIdSgr8dEiHY5/z+yxeOJ
	TOxcUen2UnfIaG12UCmcB/qlp5qLSjExGA6NQab/10pE9xJt/1sXtXllTfplmDCBOPa/uXyHFz5
	etqqFnuUjvSHwPLVSJFUgaKmwZeEdhMAM7mRguFHw59akWU4WwqDi60i1EyB2fQ==
X-Gm-Gg: ASbGncuB0yNFybhYrbEfJ9L47lWNXjobI48DCLaBIi7pXUwpcSpgpOMvy+QPq0udbR5
	k0VWbhRgNq7iBJKLs3R7Apc4XBvho/Ow+PmEueWGICbJ1vUloO2nV9QEv55aUu6C01sckPC0Zaa
	bAF9fSE0bJ7HE9gT62KBEor8cDMWCf1XmkqcQpeGkfnu5ECfsXNRGT7kd2TjHTezaj2gV0cXLnP
	lX+ZZBNuRDB7MhLeoR8wIWMa6crrsIeJlmnVVX7HFCA7zprkoiQxbzZmMVhr5gdcECg3xx9CZJI
	MUEbDuJAhhbHMeDgbtL54+rzKRmMDyPr6HFD/qE63rqsEsiB
X-Received: by 2002:a05:622a:189a:b0:45d:8be9:b0e6 with SMTP id d75a77b69052e-471dbea2921mr114809101cf.43.1739762990397;
        Sun, 16 Feb 2025 19:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhaUXlGg7cIskye7XTwVsnaJVsOtdLiD/L3ISxp1SgnP95qHJjIUbymmMZLfOiirIuc8XZmw==
X-Received: by 2002:a05:622a:189a:b0:45d:8be9:b0e6 with SMTP id d75a77b69052e-471dbea2921mr114808981cf.43.1739762990094;
        Sun, 16 Feb 2025 19:29:50 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f1e866f4sm5639761cf.33.2025.02.16.19.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 19:29:49 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b278ffc5-74af-46cf-be67-ff778d96c85f@redhat.com>
Date: Sun, 16 Feb 2025 22:29:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: Don't call find_vm_area() in RT kernel
To: Andrey Konovalov <andreyknvl@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250212162151.1599059-1-longman@redhat.com>
 <CA+fCnZdbW1Y8gsMhMtKxYZz3W6+CeovOVsi+DZbWsFTE2VNPbA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+fCnZdbW1Y8gsMhMtKxYZz3W6+CeovOVsi+DZbWsFTE2VNPbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/12/25 8:48 PM, Andrey Konovalov wrote:
> On Wed, Feb 12, 2025 at 5:22 PM Waiman Long <longman@redhat.com> wrote:
>> The following bug report appeared with a test run in a RT debug kernel.
>>
>> [ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
>> [ 3359.353853] preempt_count: 1, expected: 0
>>    :
>> [ 3359.353933] Call trace:
>>    :
>> [ 3359.353955]  rt_spin_lock+0x70/0x140
>> [ 3359.353959]  find_vmap_area+0x84/0x168
>> [ 3359.353963]  find_vm_area+0x1c/0x50
>> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
>> [ 3359.353972]  print_report+0x108/0x1f8
>> [ 3359.353976]  kasan_report+0x90/0xc8
>> [ 3359.353980]  __asan_load1+0x60/0x70
>>
>> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
>> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
>> The print_address_description() function is called with report_lock
>> acquired and interrupt disabled.  However, the find_vm_area() function
>> still needs to acquire a spinlock_t which becomes a sleeping lock in
>> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
>> changing report_lock to a raw_spinlock_t is not enough to completely
>> solve this RT kernel problem.
>>
>> Fix this bug report by skipping the find_vm_area() call in this case
>> and just print out the address as is.
>>
>> For !RT kernel, follow the example set in commit 0cce06ba859a
>> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
>> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
>> inside raw_spinlock_t warning.
> Would it be possible to get lockdep to allow taking spinlock_t inside
> raw_spinlock_t instead of annotating the callers for the !RT case? Or
> is this a rare thing for this to be allowed on !RT?
>
>> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/kasan/report.c | 47 ++++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 34 insertions(+), 13 deletions(-)
>>
>>   [v2] Encapsulate the change into a new
>>        kasan_print_vmalloc_info_ret_page() helper
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 3fe77a360f1c..9580ac3f3203 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -370,6 +370,38 @@ static inline bool init_task_stack_addr(const void *addr)
>>                          sizeof(init_thread_union.stack));
>>   }
>>
>> +/*
>> + * RT kernel cannot call find_vm_area() in atomic context. For !RT kernel,
>> + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
>> + * to WAIT_SLEEP.
>> + *
>> + * Return: page pointer or NULL
>> + */
>> +static inline struct page *kasan_print_vmalloc_info_ret_page(void *addr)
> No need for the kasan_ prefix: this is a static function. (Also the
> _ret_* suffix is something I've never seen before in the kernel
> context, but I don't mind it.)

Sorry for missing that. Yes, I can remove the prefix. Will post a v3.

Cheers,
Longman


