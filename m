Return-Path: <linux-kernel+bounces-276570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34694955F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D5E287715
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FFE2C697;
	Tue,  6 Aug 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3w6boAF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13E0175A5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960927; cv=none; b=bHbhJUzt6ZM8ZB0+CsIfxtFfeuFNKyKOaIMMHcNm7W5jxIOvSlaLfgFZzAk2PF/hPQl7lWYn8D7wKQzWZ6hY33kcvlDReEUWAAI5NQdHUwENOupIdkfhHN1h9Am1XmZU2yKrfS1xtU1Slu7fkm6FhAFbhlulloKrI6+WMNpegA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960927; c=relaxed/simple;
	bh=nLF70tU9lKmCy8VEiRDxCHWc8vhxDCk0gMzJ6rlRNVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLbnFB6jI4RmdjjjEJ1VVhv+5NtnrzSizeX2xpA+bthTvtO6FwswUaradYOYHLelr43w5ZezVQIH3RO6s1EwNGndZL+XhQ0OCKsjpsOOJHIEjMkm/k2jKgxGkEU8J0xQUT2t/L0CObtKhboLCkxNAjTcEYpIJu4plY56mvNS9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3w6boAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722960924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocUO54UkX6UEu2Jsdmx7F3rzWjBkiKGcuGMRQDNpeXo=;
	b=R3w6boAFcdwlhVerNqBp7JwPV0eBQyTyml0W2/TUZKdirhzA4yHU4bJAwo6xVkhZNmm4GB
	rVqQf2uvtlLveUZKIlMsg0aXRVWJ7gSjoyP8fYDnwM2c6SEF2nWeZgyk6lMLwVkafYn6tl
	lUbQBaCs1TaB5RDBM/H9POr4Zs7i4/4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-ttqLFjRfO3-g3vt4kA9zxQ-1; Tue,
 06 Aug 2024 12:15:19 -0400
X-MC-Unique: ttqLFjRfO3-g3vt4kA9zxQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AC5B1955D45;
	Tue,  6 Aug 2024 16:15:16 +0000 (UTC)
Received: from [10.2.16.146] (unknown [10.2.16.146])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B73E300019B;
	Tue,  6 Aug 2024 16:15:13 +0000 (UTC)
Message-ID: <bc5fb22c-189f-4f45-a7b3-185634ec3e26@redhat.com>
Date: Tue, 6 Aug 2024 12:15:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: Use raw_spinlock_t in struct
 memory_failure_cpu
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Huang Ying <ying.huang@intel.com>, Len Brown <len.brown@intel.com>
References: <20240806142535.1033323-1-longman@redhat.com>
 <ZrJG6OtoQCUadS9L@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZrJG6OtoQCUadS9L@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 8/6/24 11:53, Juri Lelli wrote:
> Hi Waimain,
>
> On 06/08/24 10:25, Waiman Long wrote:
>> The memory_failure_cpu structure is a per-cpu structure. Access to its
>> content requires the use of get_cpu_var() to lock in the current CPU
>> and disable preemption. The use of a regular spinlock_t for locking
>> purpose is fine for a non-RT kernel.
>>
>> Since the integration of RT spinlock support into the v5.15 kernel,
>> a spinlock_t in a RT kernel becomes a sleeping lock and taking a
>> sleeping lock in a preemption disabled context is illegal resulting in
>> the following kind of warning.
>>
>>    [12135.732244] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>    [12135.732248] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 270076, name: kworker/0:0
>>    [12135.732252] preempt_count: 1, expected: 0
>>    [12135.732255] RCU nest depth: 2, expected: 2
>>      :
>>    [12135.732420] Hardware name: Dell Inc. PowerEdge R640/0HG0J8, BIOS 2.10.2 02/24/2021
>>    [12135.732423] Workqueue: kacpi_notify acpi_os_execute_deferred
>>    [12135.732433] Call Trace:
>>    [12135.732436]  <TASK>
>>    [12135.732450]  dump_stack_lvl+0x57/0x81
>>    [12135.732461]  __might_resched.cold+0xf4/0x12f
>>    [12135.732479]  rt_spin_lock+0x4c/0x100
>>    [12135.732491]  memory_failure_queue+0x40/0xe0
>>    [12135.732503]  ghes_do_memory_failure+0x53/0x390
>>    [12135.732516]  ghes_do_proc.constprop.0+0x229/0x3e0
>>    [12135.732575]  ghes_proc+0xf9/0x1a0
>>    [12135.732591]  ghes_notify_hed+0x6a/0x150
>>    [12135.732602]  notifier_call_chain+0x43/0xb0
>>    [12135.732626]  blocking_notifier_call_chain+0x43/0x60
>>    [12135.732637]  acpi_ev_notify_dispatch+0x47/0x70
>>    [12135.732648]  acpi_os_execute_deferred+0x13/0x20
>>    [12135.732654]  process_one_work+0x41f/0x500
>>    [12135.732695]  worker_thread+0x192/0x360
>>    [12135.732715]  kthread+0x111/0x140
>>    [12135.732733]  ret_from_fork+0x29/0x50
>>    [12135.732779]  </TASK>
>>
>> Fix it by using a raw_spinlock_t for locking instead.
> IIUC this is executed to recover a fault condition already, so maybe
> latencies are of no interest at that point, but I wonder if something
> like
>
> https://elixir.bootlin.com/linux/v6.10.1/source/Documentation/locking/locktypes.rst#L434
>
> would still work and save us from introducing a raw_spinlock?
>
> Or maybe the critical section is anyway tiny and we don't care either?

There are only 2 critical sections that makes use of this lock - 
memory_failure_queue() and memory_failure_work_func().  In 
memory_failure_queue(), there is a kfifo_put() and either 
schedule_work_on() or pr_err(). In memory_failure_work_func(), the 
critical section is just a kfifo_get(). kfifo_get() and kfifo_put() are 
not using loop and their run time, though not very short, shouldn't be 
long. The schedule_work_on() will take its own raw_spinlock_t to do its 
work anyway. So the only call that may have a long runtime is pr_err() 
before the printk rework lands. Fortunately, we can easily take the 
pr_err() call out of the critical section.

As memory_failure_queue() is not a frequently called function and I 
doubt there will be much contention in the lock, I believe it is easier 
to understand to just use raw_spinlock_t than using migrate_disable() 
without using get_cpu_var(). Also if there is hardware issue leading to 
the call to memory_failure_queue(), a bit extra latency due to the use 
of raw_spinlock_t is not the most important concern anyway.

I will post a v2 patch to move pr_err() call out of the lock critical 
section.

Cheers,
Longman



