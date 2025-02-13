Return-Path: <linux-kernel+bounces-512217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DC0A335B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 04:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9E9188B1B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E28204698;
	Thu, 13 Feb 2025 03:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bD7FURvg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D453D1E48A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739415636; cv=none; b=FtK+5HbnEfjfKOWfXtqEEra34SBwwJp2zqQekBl2mcXohGUkJAVhDPTVsahP9YWGjp2OnpOnWW44XCs3BLkUlrQ83Fig+DmfiehB3OATNSvLaEoC4pJZD/3DkOSqZ27LmEzWKppJlGGS+u5XGx9rs0WLVKyhrYn7WBy7r+zfUKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739415636; c=relaxed/simple;
	bh=CDg75yNWrOAs+yCPL9HuRHn/Y610P8WBA57CoIkJnLE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rE2nOGaXo8wtK3ixMNBDqfWWKnXmBiSfZ6XcITvnLhtLGCkksCltjiD6GZ4ww27vEyxnSD59eLkHXTzC6SeUvvtoW1tJszd3N31rP4ybelVikH1Vf9SCqBoUp8e9posQ6ImTlGqT+zk3PJeSuonO5SPHLWJukXmjmfqKxSqaaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bD7FURvg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739415633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWwww+9wjYnmYiIoosHtl2D22JscWljOY5A6wHcnvOU=;
	b=bD7FURvgrjzp633QYY7URfDn7UZkR5XjrzLNjumuvP9RuGVRJv76bnVtArv4ktfuk6y/Df
	rAF2umhOcoLgIa0wmU6pVc/4Hh0VjBBTQDr4gQPSCpJ/abiHDHhKMTOUSTenjpxcCE+sT8
	VCbXWaRSEm08BOkGP+3ezarYG2ITgxg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-BFu0InIdOFycoI3eA4eBcg-1; Wed, 12 Feb 2025 22:00:32 -0500
X-MC-Unique: BFu0InIdOFycoI3eA4eBcg-1
X-Mimecast-MFC-AGG-ID: BFu0InIdOFycoI3eA4eBcg
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c07bba1575so53539685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739415632; x=1740020432;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OWwww+9wjYnmYiIoosHtl2D22JscWljOY5A6wHcnvOU=;
        b=Z8/CCkJojuyBOQPS1QBJYoMKJv/BGgfxNJBwHwESxnTkiI/nsAOsSCyZuokDBHMRaT
         KtKRWOwBlL0Avm3HQn/KTrGcI/EnHspyZnhb9w8WV1vtLjtnHvJf9/YKfPH2XCEuILzF
         OB2N4TT58batkNROeXYO4DwkTcV6Zg8cncfFo2LjcxEp9+4Kj2ZVGR4daCX0ovrmpoys
         mnFfJj4ipNrofAspk8Bi+90XVRC2gavayh13O6jNAnpH2SggeA/LJd8IUbQ0yCVY85gP
         vuNfHxLdwPasxYq8nEz8Z7d3SLdSVt6KqhjGMuS7FMkn/rCih3kNvdkacS//jmQpob2E
         TQng==
X-Forwarded-Encrypted: i=1; AJvYcCVdfaBdlpQ0btb/zVjT19ALCmPVarP1dhiNnybjyVGZeSvGtjSKpM9hHff4967oId3nD7Cgo4FWspke3mw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb6/hQAB/NndKt6hOkVbWVKToNunVAwB5JGp3HVTqZoMUKwyY4
	3WbN6hrMQcr7LTQuWF4pC9EFahDl22OkG63ulqqb96BMycCW3pYh9fKPLzhhQxUhgXmA8EwTJXk
	4e5jtzd4rTIO68dvLxb9fL6JuV9h2GAnwAMMVfy2pxb1frNQt0KAxN92ux1xS1w==
X-Gm-Gg: ASbGnctRBE+X9+xpmFy/erTOLBjROHnBubSx6No9vgdv6KJV1AhOfudIj40zDu5Qp3M
	2h9UNeT2cWEh7ay8AHHLUHw8N0S2vhVg4P3zuSdYWA1NCkbCe5s45QwCpRYRZKvkQXIt0993/lB
	14ov0W17h+ITPMpoY2Hr0R6CrIUgwCr2edxuwYkE8GRcSwVMtnCHB/LxknVNNlTpkojBXsnVOWL
	F8YQSw57LBRJKs59m2V6Xv/4Ksa58Qb8Ag79wDryZmyNFpbRNnbCIh8hI93HcviJ2MYy0drESxA
	SBmVjWHUNNVNB6rtM02Rj3zA63a2mGg8rZo3M7E1uIEsClqL
X-Received: by 2002:a05:620a:4154:b0:7b6:e47a:8e1d with SMTP id af79cd13be357-7c07a14eca8mr288912385a.31.1739415631944;
        Wed, 12 Feb 2025 19:00:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrPdXEC7uKTGrnTsRzg3yFpGic5d9M8ugrhFeLTyhpIMQ12jCFsEbrGCa3smwHMxU+LwNpWQ==
X-Received: by 2002:a05:620a:4154:b0:7b6:e47a:8e1d with SMTP id af79cd13be357-7c07a14eca8mr288908485a.31.1739415631630;
        Wed, 12 Feb 2025 19:00:31 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c608269sm26919485a.31.2025.02.12.19.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 19:00:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b9fdff48-da6a-4190-addb-acb948ea9ad7@redhat.com>
Date: Wed, 12 Feb 2025 22:00:29 -0500
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

Lockdep currently issues warnings for taking spinlock_t inside 
raw_spinlock_t because it is not allowed in RT. Test coverage of RT 
kernels is likely less than !RT kernel and so less bug of this kind will 
be caught. By making !RT doing the same check, we increase coverage. 
However, we do allow override in the !RT case, but it has to be done on 
a case-by-case basis.

Currently we only do that for debugging code, not the code that will be 
used in production kernel yet.

Cheers,
Longman


