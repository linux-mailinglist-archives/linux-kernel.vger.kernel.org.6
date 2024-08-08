Return-Path: <linux-kernel+bounces-280001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D75F94C45F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0FD1F26677
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A3E1474B2;
	Thu,  8 Aug 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hc09FZTP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9280C13
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141964; cv=none; b=Cz+3s5ebTY1BMjBMSk+o1Gbs/LI/l64YVgI1lLNHvObthM0VtUSVBjubsKFzLOzzxrkMxKbYoAchxhVftqffSEtGx2puzdRvPzA0yCYazPFR/MkFYEyFoyVAsOqbytW3JgYvhRqK6+C0YlRwvROEU1HlbknnWB3L6mmhw3VZ3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141964; c=relaxed/simple;
	bh=m4Ld8dHbB+JXQotUzhSuM6EmaklWFfNmYOEsUH6d9Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXR/DhQcaqstTzvhnuMfShpyZZDveB8IW80QQbROQPZlw47ZMi1tS6Whx21MjuMp27vJP7aUjqAcBzI16VBYaqGZL7UphGokMS+pferDFBxug3nTkDxm3j3cnNe1pMmXmApKqN4KeB2MYdeDTxebvIcDttWe7g03flJLDEvGDuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hc09FZTP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723141960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smsHi6xEMXRFi8V3HreFHnPllEpbGv3MaP8Bg03pLpM=;
	b=hc09FZTPPAPQj8AChOdn0erSw0b2owbMQxiOgK4kb2A/k9S7qlavDCKcAlIkOrz5NNrpzn
	jdZzOtU+Kopk9Nyz8pdgIPQnnEm6gMrSxvcA544XAABbS7mK4XwWD6SY/fIORJJR3cVaqm
	hpI7H04DK9F99b0NDo4Gbupc7Jn9qlU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-qTL7JnWaOM6bx3Z9eRmUZw-1; Thu,
 08 Aug 2024 14:32:35 -0400
X-MC-Unique: qTL7JnWaOM6bx3Z9eRmUZw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCB381944A86;
	Thu,  8 Aug 2024 18:32:33 +0000 (UTC)
Received: from [10.2.16.232] (unknown [10.2.16.232])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64E8719560AA;
	Thu,  8 Aug 2024 18:32:32 +0000 (UTC)
Message-ID: <f8c46f64-1ac3-4da3-87b5-ef7ec2e37fb8@redhat.com>
Date: Thu, 8 Aug 2024 14:32:31 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/stackdepot: Double DEPOT_POOLS_CAP if KASAN is
 enabled
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org
References: <20240808125430.1172152-1-longman@redhat.com>
 <CA+fCnZdWgAD1pu4yyjON0ph9ae1B6iaWas0CbET+MXLNNXt5Hg@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CA+fCnZdWgAD1pu4yyjON0ph9ae1B6iaWas0CbET+MXLNNXt5Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 8/8/24 12:12, Andrey Konovalov wrote:
> On Thu, Aug 8, 2024 at 2:54 PM Waiman Long <longman@redhat.com> wrote:
>> As said in commit 02754e0a484a ("lib/stackdepot.c: bump stackdepot
>> capacity from 16MB to 128MB"), KASAN uses stackdepot to memorize stacks
>> for all kmalloc/kfree calls. So stackdepot capacity was increased 8
>> times to accommodate KASAN usage even thought it was claimed 4X should
>> be enough at that time.
>>
>> With commit fc60e0caa94d ("lib/stackdepot: use fixed-sized slots
>> for stack records"), all stackdepot records uses a fixed size with
>> CONFIG_STACKDEPOT_MAX_FRAMES (default=64) entries. This is merged to
>> support evictable KASAN stack records. Commit 31639fd6cebd ("stackdepot:
>> use variable size records for non-evictable entries") re-enabled
>> the use of variable size records for non-KASAN use cases, but KASAN
>> (generic mode) still uses the large fixed size stack records.
> No, since commit 711d349174fd ("kasan: revert eviction of stack traces
> in generic mode") Generic KASAN doesn't use fixed-sized slots.
>
>> With the default CONFIG_STACKDEPOT_MAX_FRAMES of 64, KASAN use of
>> stackdepot space had been more than double than before. Assuming an
>> average stack frame size of 16, a KASAN stack record is almost 4X the
>> size of a non-KASAN one.
> So this is not correct.
Yes, you are right. I missed the KASAN commit 711d349174fd in my 
analysis. I will update the commit log in the next version.
>> When a wide variety of workloads are run on a debug kernel with KASAN
>> enabled, the following warning may sometimes be printed.
>>
>>   [ 6818.650674] Stack depot reached limit capacity
>>   [ 6818.650730] WARNING: CPU: 1 PID: 272741 at lib/stackdepot.c:252 depot_alloc_stack+0x39e/0x3d0
>>     :
>>   [ 6818.650907] Call Trace:
>>   [ 6818.650909]  [<00047dd453d84b92>] depot_alloc_stack+0x3a2/0x3d0
>>   [ 6818.650916]  [<00047dd453d85254>] stack_depot_save_flags+0x4f4/0x5c0
>>   [ 6818.650920]  [<00047dd4535872c6>] kasan_save_stack+0x56/0x70
>>   [ 6818.650924]  [<00047dd453587328>] kasan_save_track+0x28/0x40
>>   [ 6818.650927]  [<00047dd45358a27a>] kasan_save_free_info+0x4a/0x70
>>   [ 6818.650930]  [<00047dd45358766a>] __kasan_slab_free+0x12a/0x1d0
>>   [ 6818.650933]  [<00047dd45350deb4>] kmem_cache_free+0x1b4/0x580
>>   [ 6818.650938]  [<00047dd452c520da>] __put_task_struct+0x24a/0x320
>>   [ 6818.650945]  [<00047dd452c6aee4>] delayed_put_task_struct+0x294/0x350
>>   [ 6818.650949]  [<00047dd452e9066a>] rcu_do_batch+0x6ea/0x2090
>>   [ 6818.650953]  [<00047dd452ea60f4>] rcu_core+0x474/0xa90
>>   [ 6818.650956]  [<00047dd452c780c0>] handle_softirqs+0x3c0/0xf90
>>   [ 6818.650960]  [<00047dd452c76fbe>] __irq_exit_rcu+0x35e/0x460
>>   [ 6818.650963]  [<00047dd452c79992>] irq_exit_rcu+0x22/0xb0
>>   [ 6818.650966]  [<00047dd454bd8128>] do_ext_irq+0xd8/0x120
>>   [ 6818.650972]  [<00047dd454c0ddd0>] ext_int_handler+0xb8/0xe8
>>   [ 6818.650979]  [<00047dd453589cf6>] kasan_check_range+0x236/0x2f0
>>   [ 6818.650982]  [<00047dd453378cf0>] filemap_get_pages+0x190/0xaa0
>>   [ 6818.650986]  [<00047dd453379940>] filemap_read+0x340/0xa70
>>   [ 6818.650989]  [<00047dd3d325d226>] xfs_file_buffered_read+0x2c6/0x400 [xfs]
>>   [ 6818.651431]  [<00047dd3d325dfe2>] xfs_file_read_iter+0x2c2/0x550 [xfs]
>>   [ 6818.651663]  [<00047dd45364710c>] vfs_read+0x64c/0x8c0
>>   [ 6818.651669]  [<00047dd453648ed8>] ksys_read+0x118/0x200
>>   [ 6818.651672]  [<00047dd452b6cf5a>] do_syscall+0x27a/0x380
>>   [ 6818.651676]  [<00047dd454bd7e74>] __do_syscall+0xf4/0x1a0
>>   [ 6818.651680]  [<00047dd454c0db58>] system_call+0x70/0x98
>>
>> With all the recent changes in stackdepot to support new KASAN features,
>> it is obvious that the current DEPOT_POOLS_CAP of 8192 may not be
>> enough when KASAN is enabled. Fix this stackdepot capability issue
>> by doubling DEPOT_POOLS_CAP if KASAN is enabled. With 4k pages, the
>> maximum stackdepot capacity is doubled to 256 MB with KASAN enabled.
> It is possible that the stack depot runs out of space due to a truly
> large number of unique stack traces, but I would first make sure that
> is indeed the case. The one thing to check would be to dump all the
> stack traces from the stack depot when it overflows, and check whether
> they make sense. There have been cases in the past, when e.g. the task
> context part of a stack trace from an interrupt didn't get stripped
> properly, and thus almost each stack trace from an interrupt was
> considered unique by the stack depot. Perhaps, something similar
> started happening again.

It could be.

Anyway, I got a bug report from our QE team and they have seen it once 
so far. So it is not an easily reproducible problem. I need to do 
further investigation first. Thanks for your quick response.

Cheers,
Longman



