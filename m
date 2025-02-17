Return-Path: <linux-kernel+bounces-518173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17AA38AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4313B19AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A54232366;
	Mon, 17 Feb 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdeo+KhA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7B231CB0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814992; cv=none; b=H7g1y77laslLDCm24nC61xPeMn6dDqKf5FWweAbyE8BCkAE6s1LnAcmYTolsxs+zstT4Tqd/9hNPsBPVpQ7cUDTLU3EOMsSoRkNhxeBROr35lIG1dGmE8spP0j9piywTJjW52S0kik4DaSY4c7lUn6Scgmd49GNmBl8/9VMUCkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814992; c=relaxed/simple;
	bh=zE9veftWabe5c1OeAd736Vhg6Lh9Ujaj6TI7WKjzoaM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=W0Hug7u/1AXVUrOtloU1u5YMmdevEd8VVHio8D9tOsaUATQnd5uybFT7udU612exDbeHbwkJYzjwjtfRNqWHE3Wd0fBqqW4FjIb0CHNDyOHnOXHgmENuV6bkhVFCd0TPp74YlDLcn/LoIdmmhbr+lLQ8DTQkiR95kUyCM4ZMQyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdeo+KhA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739814989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niJ7GrqnlE8mjwkLXdroJsmq3cDp8d9woXPb/vSi3Z0=;
	b=Mdeo+KhAIkxykZIjwTJp4audP2hqoAAscrkKKXdwHXwwYpYxjppLz9mHdT7QEGfWc9FI5K
	7koV/wN9vNemHP/Y1w6EHmojYHx1XU2wjnj95tzHcVkbCotPrxxiCZprNHIH1FkJdk2LkA
	B6JK96EPoIKuh4Cf6ZxcUsdEEiFCVSU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-hPwcytRXPxycfYoN2PfJcA-1; Mon, 17 Feb 2025 12:56:28 -0500
X-MC-Unique: hPwcytRXPxycfYoN2PfJcA-1
X-Mimecast-MFC-AGG-ID: hPwcytRXPxycfYoN2PfJcA_1739814988
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c096d65f9fso265371585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739814987; x=1740419787;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niJ7GrqnlE8mjwkLXdroJsmq3cDp8d9woXPb/vSi3Z0=;
        b=bwdO8GlaH6Ortn2KMm7r/eICPj6Gu0sdRYal7678rcsIn5xfPqu4c1bOkbX0YQUkgL
         P6CENtCoyptqwmeo97/zgZZ5fwl3+gCfxL9pvnWq939gWrxaDszyJ3fKsGjQQrFCgsqx
         BCPrXGiP783I4o8GiHl4yOnCm3HGoewLcnB1ih4oV+RkE+vuai/sa/J7dATJDcyVnvVC
         zIQysx+/V530s2Ga18dVpdT6mkZG/HfpsbRXL/9g8Lv7mOXFktZYIe9GkvYc1LY7ZTAy
         lXolwXYb5pPMDOCwHhTeYNA2GDwrI5A5c8L2UBJvTJp0VTtgddiaBkVszmdJMJal1KDo
         ZWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtJy/Jg1sSp57nH0uDHT86mScGBU1skI9Pp7rkDANie0eqIJ0QoPzYDKoSV+VaUR82OASTB+8PasaOGoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVvyAYIlqc9ES3fUhu6LIhCnK7VV9yD990F/CKHPy2DlyWE9r
	yXLKjyb0D6f6Cf0UFBgTjjeTs1dRb+kNjJFcW5IRl12WpcxL6s9BxbSdYzOdhjnUDhF0iZoM/3X
	tBIML/D7lbD2yCCn3layfMzv3yeUQv3vF2rFcG3g5NsEFfd8cAOHoN8CLKrLZwTBekotC0eX4
X-Gm-Gg: ASbGncv92s+vRqLVTXJN4QEYfiRpt4fCFZzU4KG29N5x7adxKNY2Z6SKfgazri0Zy1r
	BO0T+tOva7PTud7ipE9u5vy4Eh2pnXfnG2z0Ya9S7Q4r4L7C4K5kkZJSPevSCS5w4OEe4F5FZ/y
	XjLvwyEsxk0ORuXPAczskIPrJPQd/0DijUE6GRYQkLeWSa/ofz9L4LelKuKvtEGGkMz8GiDc5XQ
	2Ce6U50fOyrTCatgeTBfece2CgqhtBHyOSyoedY2Lfdl36+Fefq1O1jVNcFs//45jxcKe2/cppe
	ufee0l0uK1VOI+PIsNyaMK9jZsDbvoZeF+1SyEb8+D39qHC1
X-Received: by 2002:ad4:5f8b:0:b0:6e6:62e0:887b with SMTP id 6a1803df08f44-6e66cd29e70mr149586946d6.45.1739814987300;
        Mon, 17 Feb 2025 09:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMaH0te3WvqMwaIP410mOdgQto6F2VrfNkiVPnhvou7kFgzG16oJDSLaT8GWZZ/9EJy6ockQ==
X-Received: by 2002:ad4:5f8b:0:b0:6e6:62e0:887b with SMTP id 6a1803df08f44-6e66cd29e70mr149586706d6.45.1739814987028;
        Mon, 17 Feb 2025 09:56:27 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f46a8sm54068316d6.82.2025.02.17.09.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 09:56:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d9c96532-9598-426e-a469-dafd17d47a70@redhat.com>
Date: Mon, 17 Feb 2025 12:56:25 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250217042108.185932-1-longman@redhat.com>
 <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/25 11:28 AM, Andrey Konovalov wrote:
> On Mon, Feb 17, 2025 at 5:21 AM Waiman Long <longman@redhat.com> wrote:
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
>>
>> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/kasan/report.c | 43 ++++++++++++++++++++++++++++++-------------
>>   1 file changed, 30 insertions(+), 13 deletions(-)
>>
>>   [v3] Rename helper to print_vmalloc_info_set_page.
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 3fe77a360f1c..7c8c2e173aa4 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void *addr)
>>                          sizeof(init_thread_union.stack));
>>   }
>>
>> +/*
>> + * RT kernel cannot call find_vm_area() in atomic context. For !RT kernel,
>> + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
>> + * to WAIT_SLEEP.
> Quoting your response from the other thread:
>
>> Lockdep currently issues warnings for taking spinlock_t inside
>> raw_spinlock_t because it is not allowed in RT. Test coverage of RT
>> kernels is likely less than !RT kernel and so less bug of this kind will
>> be caught. By making !RT doing the same check, we increase coverage.
>> However, we do allow override in the !RT case, but it has to be done on
>> a case-by-case basis.
> Got it.
>
> So let's put this exactly this explanation in the comment, otherwise
> it's unclear why we need something special for the !RT case.

Sure. Will do that.


>> + */
>> +static inline void print_vmalloc_info_set_page(void *addr, struct page **ppage)
>> +{
>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>> +               struct vm_struct *va;
>> +
>> +               lock_map_acquire_try(&vmalloc_map);
>> +               va = find_vm_area(addr);
>> +               if (va) {
>> +                       pr_err("The buggy address belongs to the virtual mapping at\n"
>> +                              " [%px, %px) created by:\n"
>> +                              " %pS\n",
>> +                              va->addr, va->addr + va->size, va->caller);
>> +                       pr_err("\n");
>> +
>> +                       *ppage = vmalloc_to_page(addr);
> Looking at the code again, I actually like the Andrey Ryabinin's
> suggestion from the v1 thread: add a separate function that contains
> an annotated call of find_vm_area(). And keep vmalloc_to_page()
> outside of it, just as done in the upstream version now.

I can make the change if it is what you want.

Cheers,
Longman


