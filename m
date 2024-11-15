Return-Path: <linux-kernel+bounces-410554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FB69CDD31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7A4B2852C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C07018C00B;
	Fri, 15 Nov 2024 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lt3/8/f0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dcZhBi6s";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lt3/8/f0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dcZhBi6s"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C9E154C00
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 11:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731668551; cv=none; b=ougtCmjJEuCobnOErdSKaKvvse20JphKh+LN8JZcxjNP7gYJ/Um2cP81vg6ahGwR5mtd25eTfbp+fh6c9bEibuAzGnQueFm+kP8FmxgOth4+Usq0feUtLcloP3Q6UG64dqDSIs2m6N9rcYWbP/ECCtrhNKFCXjP2zUy6eSWFnV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731668551; c=relaxed/simple;
	bh=HVzxacYiDbhjobUhuA5niw73NKdPNaqdKbKKPAbhwo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YidCCZRjUxadw5TE5C5QK1amtqXj8K4XTZhRblBiUeonAV02j3XK2b9IYPnVq4gb741GzGQk8QSIHKoUKk+NDu3Nqf+BPUxcNVJaqFbjecXHjOgr1hBOe1TNJSTdJ798/uX1nq6RV8XfxJBJDK6K35BStQroXwpinBtSUOBXtkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lt3/8/f0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dcZhBi6s; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lt3/8/f0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dcZhBi6s; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E2B11F806;
	Fri, 15 Nov 2024 11:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731668547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CaKjRLnpC239oXGpUgc4pPUvL79CAjd8/+DsZGm6FWA=;
	b=lt3/8/f0c3WlY/vrR0AOc2qvRjF3TDonPcpJ8xJeRJxCS32JcwnIE+/BX+8WSyfnxT6ZgG
	UahfbtsjH1fXMiXmLKtzKhD6D/HpMBQh6DJom8wA/F+3iBOVX21PYxAK63rkiyQ9WzLCdj
	JXoRGqEqSU4BzD2vfbec8gbIVEG+yu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731668547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CaKjRLnpC239oXGpUgc4pPUvL79CAjd8/+DsZGm6FWA=;
	b=dcZhBi6sctJO037ibHyDh47nMXmWPOWpV5y9061fcmTjrn+Iqh2nN0tczx+oV4yiw1uN0d
	VILiEKc9pQgV7GAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731668547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CaKjRLnpC239oXGpUgc4pPUvL79CAjd8/+DsZGm6FWA=;
	b=lt3/8/f0c3WlY/vrR0AOc2qvRjF3TDonPcpJ8xJeRJxCS32JcwnIE+/BX+8WSyfnxT6ZgG
	UahfbtsjH1fXMiXmLKtzKhD6D/HpMBQh6DJom8wA/F+3iBOVX21PYxAK63rkiyQ9WzLCdj
	JXoRGqEqSU4BzD2vfbec8gbIVEG+yu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731668547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CaKjRLnpC239oXGpUgc4pPUvL79CAjd8/+DsZGm6FWA=;
	b=dcZhBi6sctJO037ibHyDh47nMXmWPOWpV5y9061fcmTjrn+Iqh2nN0tczx+oV4yiw1uN0d
	VILiEKc9pQgV7GAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FA1213485;
	Fri, 15 Nov 2024 11:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cSv9FkMqN2cdYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Nov 2024 11:02:27 +0000
Message-ID: <3727258a-7caf-4f05-b8a9-20ab82ee4ea0@suse.cz>
Date: Fri, 15 Nov 2024 12:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
To: Raghavendra K T <raghavendra.kt@amd.com>,
 Adrian Huang <adrianhuang0701@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Adrian Huang <ahuang12@lenovo.com>, Jiwei Sun <sunjw10@lenovo.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20241113102146.2384-1-ahuang12@lenovo.com>
 <1c8e478d-866a-440e-a11f-80fd210cc5ca@amd.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <1c8e478d-866a-440e-a11f-80fd210cc5ca@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[amd.com,gmail.com,redhat.com,infradead.org,linaro.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/15/24 11:45, Raghavendra K T wrote:
> + Vlastimil
> 
> Looks like he was unintentionally missed in CC. He has added Reviewed-by 
> to V1

Thanks, seems I did it for v1 when v2 was already sent, and without also cc
linux-mm I didn't notice it was.

> On 11/13/2024 3:51 PM, Adrian Huang wrote:
>> From: Adrian Huang <ahuang12@lenovo.com>
>> 
>> [Problem Description]
>> When running the hackbench program of LTP, the following memory leak is
>> reported by kmemleak.
>> 
>>    # /opt/ltp/testcases/bin/hackbench 20 thread 1000
>>    Running with 20*40 (== 800) tasks.
>> 
>>    # dmesg | grep kmemleak
>>    ...
>>    kmemleak: 480 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>>    kmemleak: 665 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>> 
>>    # cat /sys/kernel/debug/kmemleak
>>    unreferenced object 0xffff888cd8ca2c40 (size 64):
>>      comm "hackbench", pid 17142, jiffies 4299780315
>>      hex dump (first 32 bytes):
>>        ac 74 49 00 01 00 00 00 4c 84 49 00 01 00 00 00  .tI.....L.I.....
>>        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>      backtrace (crc bff18fd4):
>>        [<ffffffff81419a89>] __kmalloc_cache_noprof+0x2f9/0x3f0
>>        [<ffffffff8113f715>] task_numa_work+0x725/0xa00
>>        [<ffffffff8110f878>] task_work_run+0x58/0x90
>>        [<ffffffff81ddd9f8>] syscall_exit_to_user_mode+0x1c8/0x1e0
>>        [<ffffffff81dd78d5>] do_syscall_64+0x85/0x150
>>        [<ffffffff81e0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    ...
>> 
>> This issue can be consistently reproduced on three different servers:
>>    * a 448-core server
>>    * a 256-core server
>>    * a 192-core server
>> 
>> [Root Cause]
>> Since multiple threads are created by the hackbench program (along with
>> the command argument 'thread'), a shared vma might be accessed by two or
>> more cores simultaneously. When two or more cores observe that
>> vma->numab_state is NULL at the same time, vma->numab_state will be
>> overwritten.
>> 
>> Although current code ensures that only one thread scans the VMAs in a
>> single 'numa_scan_period', there might be a chance for another thread
>> to enter in the next 'numa_scan_period' while we have not gotten till
>> numab_state allocation [1].
>> 
>> Note that the command `/opt/ltp/testcases/bin/hackbench 50 process 1000`
>> cannot the reproduce the issue. It is verified with 200+ test runs.
>> 
>> [Solution]
>> Use the cmpxchg atomic operation to ensure that only one thread executes
>> the vma->numab_state assignment.
>> 
>> [1] https://lore.kernel.org/lkml/1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com/
>> 
>> Fixes: ef6a22b70f6d ("sched/numa: apply the scan delay to every new vma")
>> Reported-by: Jiwei Sun <sunjw10@lenovo.com>
>> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
>> Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

>> ---
>>   kernel/sched/fair.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 3356315d7e64..7f99df294583 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3399,10 +3399,16 @@ static void task_numa_work(struct callback_head *work)
>>   
>>   		/* Initialise new per-VMA NUMAB state. */
>>   		if (!vma->numab_state) {
>> -			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
>> -				GFP_KERNEL);
>> -			if (!vma->numab_state)
>> +			struct vma_numab_state *ptr;
>> +
>> +			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
>> +			if (!ptr)
>> +				continue;
>> +
>> +			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
>> +				kfree(ptr);
>>   				continue;
>> +			}
>>   
>>   			vma->numab_state->start_scan_seq = mm->numa_scan_seq;
>>   


