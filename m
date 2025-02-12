Return-Path: <linux-kernel+bounces-510252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88260A31A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 01:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D485F1883B14
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 00:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA24C81;
	Wed, 12 Feb 2025 00:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P70UUJ7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297842111
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319403; cv=none; b=FAE71bGXhS9vOztkIJ221IrV0WNXtq5RlAFLXYzr3Y3H+itKs+fZQIp6oxOZe6pvCJjk6kS5laO9/AaNb2QL8ETd+SvNqn6kiFZ7eqs1MTuRO498AIieapa+U7jKzL5EPrUzllme0xXnRHLnu2qPypWE5+YLCCXs3ec5E+hFTek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319403; c=relaxed/simple;
	bh=vF9sAsivftSRk9YysN+Elnzfq9dO+3SugGtK1Qgvf6M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lr0TJY4jRi8ApUS9RUqw69uDMwHEvDszkfEBKfpJhNskE5DMZ6VKgANeFKvnjh6QzJ3k38X3BywKtp5SH1FDu6NTDBe1mr5WFOlJXZiyFWv9ojRmRu632/9Uh6iqHXKgv4RNPwnPjVtM4upBwgp/n5EFEAUiDTOwkeI9lBSnYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P70UUJ7Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739319400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw447gaPb7zNMocf3h4BtDlt/qfajgVcEdNoBnnrQDw=;
	b=P70UUJ7YzwtZ/XhuDWdREn1g4QBcZaoZWIwK1d+tGNQSOj1jTQPMMDg1w+L4vQSKNiSSFK
	vTKMJGngyA4qCABN6GVKzDnPW5evc8PwR0883L6XMixno0FWLcmu1CT4N6b64n9hSeRJFi
	wVvpNeoKihW4KJ98uChPXjV/K+783HM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-9SIXYdRQPbirwF52tzzjrw-1; Tue, 11 Feb 2025 19:16:38 -0500
X-MC-Unique: 9SIXYdRQPbirwF52tzzjrw-1
X-Mimecast-MFC-AGG-ID: 9SIXYdRQPbirwF52tzzjrw
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c067ec2de7so53430485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 16:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319398; x=1739924198;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw447gaPb7zNMocf3h4BtDlt/qfajgVcEdNoBnnrQDw=;
        b=SyPE8IekWqx/3H76IjhqmmrNw3mKlnwRWip9YGZWNXCQb/zb/DiYaBhLqLEJBXX/8u
         Jj01GRsnXwNbZ81TKWwGnZgPMo3EyLCLQRHjiEMWqXxcesIZztKm42k9kY3sMjpwLnaG
         WRVLMcvXeSjWuNhxvENKEluk+o0FxXabtH69qbUL2Xn/ifqiJ0q5viwDTxRo5hHmyUdT
         a3kY2U1Ffk//g4NV8ph6w1XJFYoAOrSTnfO8DllvDhTOyvhO1zBwSKITP2l/j0P5J9DV
         QbyIWuagweEKsxj5rcMbUx1EE8j2x1TYRvFOqwJEI9K5g4ziaduEYi1gvy5sqOwXibsP
         HOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWDyPFtI6qC6tXA3bWDmH2dCXeRWpX5F054g3ZC4fFZrsYUYcPfDbBUpHZ/mu32ouUOyPw8vbmxwuDTwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgYmL4PdvK3jtpyNYbMqpEqY8NjaW14WP7nJl8D++F2/DGj0uO
	T8WpIvOyOFGLPrqCeltYuLMsuolBAWhqW5EVaDHk4vHjIlZqH73dsjvr0x8N04MyBJ7NowobMRj
	jdNcfL1Dcsz0rp6HGuXs13ssH9ai7qrsjhOp+myR+c2A6/FYIkuOKdqyBjWY5EA==
X-Gm-Gg: ASbGncsogpDyZDzPfxANE+nM7ZGB9FkE7/CbvleRVb7mPHKlZhGnYHoVGvC7KtX+vgi
	on9SepqV7wQDbsuiw/Qpt2TIqKKav+YFL6f5nwgIY/GC79OLBWg3CMqJuqSJm5TYBUdk6NU7WQC
	z4TkFTLUB7CJW/2z1ZzRmEe0Lon8wHJKvRmUhSex2/7JQo8KaIWGjkfdUPaQBHbZJzNviDyZg0R
	MKmxgBmRDLEYIhQgDGmlomyMZRu3lyEMvEfmvC3vEIGMZra3nmk6bUbC/uq1xtRdfip5ReD1R1T
	jtUAaS9NgaKfM553dNGew9vrE621xA13xELHGnkC2b5c4m7P
X-Received: by 2002:a05:620a:24d4:b0:7b6:fdb9:197e with SMTP id af79cd13be357-7c07025941dmr154537985a.8.1739319398120;
        Tue, 11 Feb 2025 16:16:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENzMVSe0weoS27WWCT7JtaiNjOl1Kw02kBUwi9+QkdbL5XSwYfk9EZa1PX4HVM1t7uIloPkw==
X-Received: by 2002:a05:620a:24d4:b0:7b6:fdb9:197e with SMTP id af79cd13be357-7c07025941dmr154535485a.8.1739319397850;
        Tue, 11 Feb 2025 16:16:37 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0728eb208sm3484785a.99.2025.02.11.16.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 16:16:36 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6b6c1245-f6ee-4af7-b463-e8b6da60c661@redhat.com>
Date: Tue, 11 Feb 2025 19:16:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
 <20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
Content-Language: en-US
In-Reply-To: <20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/11/25 5:57 PM, Andrew Morton wrote:
> On Tue, 11 Feb 2025 11:07:50 -0500 Waiman Long <longman@redhat.com> wrote:
>
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
>> The print_address_description() is run with a raw_spinlock_t acquired
>> and interrupt disabled. The find_vm_area() function needs to acquire
>> a spinlock_t which becomes a sleeping lock in the RT kernel. IOW,
>> we can't call find_vm_area() in a RT kernel. Fix this bug report
>> by skipping the find_vm_area() call in this case and just print out
>> the address as is.
>>
>> For !RT kernel, follow the example set in commit 0cce06ba859a
>> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
>> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
>> inside raw_spinlock_t warning.
>>
> Thanks.  I added it and shall await review from the KASAN developers.
>
> I'm thinking we add
>
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Cc: <stable@vger.kernel.org>
>
> but c056a364e954 is 3 years old and I don't think we care about -rt in
> such old kernels.  Thoughts?

The KASAN report_lock was changed to a raw_spinlock_t in v6.13 kernel 
with commit e30a0361b851 ("kasan: make report_lock a raw spinlock") to 
fix a similar RT problem. The report_lock is acquired before calling 
print_address_description(). Before commit e30a0361b851, this 
find_vm_area() is a secondary issue. We may consider commit e30a0361b851 
isn't complete and this is a fix for that.

The DEFINE_WAIT_OVERRIDE_MAP() macro was introduced in v6.4. So this 
patch cannot be backported to a version earlier than that unless commit 
0cce06ba859a is there.

Cheers,
Longman



