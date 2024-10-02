Return-Path: <linux-kernel+bounces-347429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C5298D299
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CD21C20F24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4639420010B;
	Wed,  2 Oct 2024 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UkJm0hGE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1fwNELec";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UkJm0hGE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1fwNELec"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE919750B
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727870250; cv=none; b=pKqbioLtFGuV5BB/qHPZdEDREEu1umWmWrDMIMKekcmcu+dFKn1Gx7Z7goJxy4bQcnDhnS1ZLQgYy4SLLU6As/J46bUVZZagVDYcEwQflhaCiAfn7T8TYHAG7KqEcWP8SvjF+TMs5i5wNfT9pPnKA9GbxOz1at2tNnwnwCbd1H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727870250; c=relaxed/simple;
	bh=bkyYAHK/E5OSezMhHLVT2qQujaRoYRX0QZ8HaDFt3Ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0pMBwQIQMWFeOF9ztfABdwPxRkP48RsQBlgHueQ5PBEbmDCNK0Vqgii4HbQoAAoOMOhQsmTmDXSGsyQMKFT2JEHe0keykdNVKQ+Be1oYYKgXn6ZvGubygz6eoS9oidmJ3+9SteWZpt9zx80Zy97Jv4Qa1ZMXZ2CNXhaZoc9bA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UkJm0hGE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1fwNELec; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UkJm0hGE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1fwNELec; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7AABC1FD55;
	Wed,  2 Oct 2024 11:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727870246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0zSULsybhIYIyvc2ZdLfLYnJTnMWjTry6HsYdYLFvek=;
	b=UkJm0hGEc+Oj7/aSPYALrDbc0wqUn4ZhF6U8RgkPC3ce7xKPCJTtECMWHAZCcOHknxK43/
	gwkRRp5gg69RHW1fiGWizGLV3amqrcjlPx5nlT9z5nSXhe6mDiUE7dWlG6F8aqt4F+cYxp
	qOvlMlfYyl26d0R+fiiVhf1lTurusbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727870246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0zSULsybhIYIyvc2ZdLfLYnJTnMWjTry6HsYdYLFvek=;
	b=1fwNELecDAwQ9LvSp6k2+WAfcRwDVMHcFflMkz7r7LaoIjXzZR4MpKGczidncqBYpVrJGi
	5qlYqrb6OoLkr7Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727870246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0zSULsybhIYIyvc2ZdLfLYnJTnMWjTry6HsYdYLFvek=;
	b=UkJm0hGEc+Oj7/aSPYALrDbc0wqUn4ZhF6U8RgkPC3ce7xKPCJTtECMWHAZCcOHknxK43/
	gwkRRp5gg69RHW1fiGWizGLV3amqrcjlPx5nlT9z5nSXhe6mDiUE7dWlG6F8aqt4F+cYxp
	qOvlMlfYyl26d0R+fiiVhf1lTurusbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727870246;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0zSULsybhIYIyvc2ZdLfLYnJTnMWjTry6HsYdYLFvek=;
	b=1fwNELecDAwQ9LvSp6k2+WAfcRwDVMHcFflMkz7r7LaoIjXzZR4MpKGczidncqBYpVrJGi
	5qlYqrb6OoLkr7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FD7413974;
	Wed,  2 Oct 2024 11:57:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1SgFFyY1/WZ2fwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 02 Oct 2024 11:57:26 +0000
Message-ID: <5cec5b5c-a833-435b-a8da-13bb4a77e287@suse.cz>
Date: Wed, 2 Oct 2024 13:57:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, slub: prefetch freelist in ___slab_alloc()
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhangxiaoxu5@huawei.com, cl@linux.com, wangkefeng.wang@huawei.com,
 penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev
References: <20240819070204.753179-1-liuyongqiang13@huawei.com>
 <CAB=+i9TxYRcr+ZRMD31SDay+899RXOwTvQevC=8sv7b27ZO1Vg@mail.gmail.com>
 <6e744d2b-bbb3-4e1f-bd61-e0e971f974db@huawei.com>
 <CAB=+i9RF_kjYgnsPJrE-1STT+zbCOKr3dHPKN1RyR7-jk4NdpA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAB=+i9RF_kjYgnsPJrE-1STT+zbCOKr3dHPKN1RyR7-jk4NdpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,huawei.com];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 9/14/24 15:45, Hyeonggon Yoo wrote:
> On Wed, Aug 21, 2024 at 3:58 PM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>>
>>
>> 在 2024/8/19 17:33, Hyeonggon Yoo 写道:
>> > On Mon, Aug 19, 2024 at 4:02 PM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>> >> commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
>> >> slab_alloc()") introduced prefetch_freepointer() for fastpath
>> >> allocation. Use it at the freelist firt load could have a bit
>> >> improvement in some workloads. Here is hackbench results at
>> >> arm64 machine(about 3.8%):
>> >>
>> >> Before:
>> >>    average time cost of 'hackbench -g 100 -l 1000': 17.068
>> >>
>> >> Afther:
>> >>    average time cost of 'hackbench -g 100 -l 1000': 16.416
>> >>
>> >> There is also having about 5% improvement at x86_64 machine
>> >> for hackbench.
>> > I think adding more prefetch might not be a good idea unless we have
>> > more real-world data supporting it because prefetch might help when slab
>> > is frequently used, but it will end up unnecessarily using more cache
>> > lines when slab is not frequently used.
>>
> 
> Hi,
> 
> sorry for the late reply.
> Thanks for explaining how it impacts hackbench, even when prefetch is
> added in the slow path.
> 
> However, I still think the main issue is that hackbench is too
> synthetic to make a strong argument that
> prefetch in the slow path would help in most real-world scenarios.
> 
>> Yes, prefetching unnecessary objects is a bad idea. But I think the slab
>> entered
>>
>> in slowpath that means it will more likely need more objects.
> 
> The fast path is hit when an object can be allocated from the CPU slab
> without much work,
> and the slow path is hit when it can’t. This doesn't give any
> indication about future allocations.
> 
> To be honest, I'm not even sure if prefetching in the fast path really
> helps if slab is not frequently called.
> Just because it hits the fast path or slow path doesn’t necessarily
> mean more objects will be needed in the future.

Yeah but in some sense if we keep the fastpath prefetch then it makes sense
to have the analogical slow path one too.

> And then, I don't think "Prefetch some data because we might need it
> in the future" is not a good argument
> because if we don't need it, it just wastes a cache line. If it helps
> in some cases but hurts in other cases,
> is not a net gain.
> 
> I might be wrong. If I am, please prove me wrong and convince me and others.
> 
> Best,
> Hyeonggon
> 
>> I've tested the cases from commit 0ad9500e16fe ("slub: prefetch next freelist pointer in
>> slab_alloc()"). Here is the result:
>> Before:
>>
>> Performance counter stats for './hackbench 50 process 4000' (32 runs):
>>
>>                  2545.28 msec task-clock                #    6.938 CPUs
>> utilized        ( +-  1.75% )
>>                       6166     context-switches          #    0.002
>> M/sec                    ( +-  1.58% )
>>                      1129      cpu-migrations            #    0.444
>> K/sec                     ( +-  2.16% )
>>                    13298      page-faults                  # 0.005
>> M/sec                    ( +-  0.38% )
>>          4435113150      cycles                           # 1.742
>> GHz                         ( +-  1.22% )
>>          2259717630      instructions                 #    0.51 insn per
>> cycle           ( +-  0.05% )
>>            385847392      branches                     #  151.593
>> M/sec                    ( +-  0.06% )
>>               6205369       branch-misses            #    1.61% of all
>> branches       ( +-  0.56% )
>>
>>             0.36688 +- 0.00595 seconds time elapsed  ( +-  1.62% )
>> After:
>>
>>   Performance counter stats for './hackbench 50 process 4000' (32 runs):
>>
>>                 2277.61 msec task-clock                #    6.855 CPUs
>> utilized            ( +-  0.98% )
>>                      5653      context-switches         #    0.002
>> M/sec                       ( +-  1.62% )
>>                      1081      cpu-migrations           #    0.475
>> K/sec                        ( +-  1.89% )
>>                    13217      page-faults                 # 0.006
>> M/sec                       ( +-  0.48% )
>>          3751509945      cycles                          #    1.647
>> GHz                          ( +-  1.14% )
>>          2253177626      instructions                #    0.60 insn per
>> cycle             ( +-  0.06% )
>>            384509166      branches                    #    168.821
>> M/sec                    ( +-  0.07% )
>>                6045031      branch-misses           #    1.57% of all
>> branches          ( +-  0.58% )
>>
>>             0.33225 +- 0.00321 seconds time elapsed  ( +-  0.97% )
>>
>> >
>> > Also I don't understand how adding prefetch in slowpath affects the performance
>> > because most allocs/frees should be done in the fastpath. Could you
>> > please explain?
>>
>> By adding some debug info to count the slowpath for the hackbench:

You could just try enabling the CONFIG_SLUB_STATS to get this count?

>>
>> 'hackbench -g 100 -l 1000' slab alloc total: 80416886, and the slowpath:
>> 7184236.
>>
>> About 9% slowpath in total allocation. The perf stats in arm64 as follow：

Now that's somewhat weird. we improve a case hit in 9% and yet the overal
improvement is 5%? Sounds too good to make sense.

>> Before:
>>   Performance counter stats for './hackbench -g 100 -l 1000' (32 runs):
>>
>>         34766611220 branches                      ( +-  0.01% )
>>             382593804      branch-misses                  # 1.10% of all
>> branches          ( +-  0.14% )
>>           1120091414 cache-misses                 ( +-  0.08% )
>>         76810485402 L1-dcache-loads               ( +-  0.03% )
>>           1120091414      L1-dcache-load-misses     #    1.46% of all
>> L1-dcache hits    ( +-  0.08% )
>>
>>             23.8854 +- 0.0804 seconds time elapsed  ( +-  0.34% )
>>
>> After:
>>   Performance counter stats for './hackbench -g 100 -l 1000' (32 runs):
>>
>>         34812735277 branches                  ( +-  0.01% )
>>             393449644      branch-misses             #    1.13% of all
>> branches           ( +-  0.15% )
>>           1095185949 cache-misses             ( +-  0.15% )
>>         76995789602 L1-dcache-loads             ( +-  0.03% )
>>           1095185949      L1-dcache-load-misses     #    1.42% of all
>> L1-dcache hits    ( +-  0.15% )
>>
>>              23.341 +- 0.104 seconds time elapsed  ( +-  0.45% )
>>
>> It seems having less L1-dcache-load-misses.
>>
>> >
>> >> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
>> >> ---
>> >>   mm/slub.c | 1 +
>> >>   1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/mm/slub.c b/mm/slub.c
>> >> index c9d8a2497fd6..f9daaff10c6a 100644
>> >> --- a/mm/slub.c
>> >> +++ b/mm/slub.c
>> >> @@ -3630,6 +3630,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> >>          VM_BUG_ON(!c->slab->frozen);
>> >>          c->freelist = get_freepointer(s, freelist);
>> >>          c->tid = next_tid(c->tid);
>> >> +       prefetch_freepointer(s, c->freelist);
>> >>          local_unlock_irqrestore(&s->cpu_slab->lock, flags);

Ideally you'd store c->freelist in a local variable and move the prefetch
below local_unlock_irqrestore() so we don't make the locked section larger.

>> >>          return freelist;
>> >>
>> >> --
>> >> 2.25.1
>> >>


