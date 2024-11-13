Return-Path: <linux-kernel+bounces-407844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AD89C75A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9DD1F2201C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1D813B791;
	Wed, 13 Nov 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="swqLElMO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWHHpyRo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="swqLElMO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWHHpyRo"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12973208A7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510595; cv=none; b=Mmm4T0Y0TwlS37MpqOUyG19yj+WjS2Rknq9o4LS/XwlCR+vnwY7CseuMSeNP/14GC795EmRIBHGXqz2glRD2LXZHwO42ra8UFfjB1bq3UFLC+p9k2n4TgF3okSkHdTeBHM+wofVf52a2WkJHLC5gf58uyHttGivFb2glJH4j0K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510595; c=relaxed/simple;
	bh=D5OSlaRrhOG0Q8/BNYE1nxBk0i+xEvjZpUMDlgvb2Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv9MGC55NdPjRc5drZyegaFanno1Y2V0O6CWbvFyzh9qV+mclhqEjHSKAqAW3Hy4nXDsZ9iJOzFs2J97TOrOeu8hwhF/vvdKt2BnlkQK0NKHxKtBALp5SySCTFdOZTkscQe09F7XHmOdYCwRKmvERUGRJVmN5pMMFuQKKQ8xupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=swqLElMO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWHHpyRo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=swqLElMO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWHHpyRo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DF4121137;
	Wed, 13 Nov 2024 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731510591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4iJ1l2BTJVeMoB7baqjT7BcG8SgipsbPqwJAjDalYo=;
	b=swqLElMOtmlH28HnWbiSY8pE8puNrD4SI9Ju2ZRfBRrBD5uYgDIbNZE6GehJkVckOvAvka
	olosQ50gkZlYAPJuIrceQ3AYydYYB5ZWCASfduM/j5TgBGx5ljiIoUjBzixjH7pmADDnJD
	HSXIHfIGrM+bxG1g30Z3o3ZvFSTNHgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731510591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4iJ1l2BTJVeMoB7baqjT7BcG8SgipsbPqwJAjDalYo=;
	b=jWHHpyRoD248PFt+uzVbGDlRaA7eBxocpi3mTdiXpkc33RJkVX1LZi45KOa2yEYBwpNjKi
	hoZmZlBAbXdJW0AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731510591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4iJ1l2BTJVeMoB7baqjT7BcG8SgipsbPqwJAjDalYo=;
	b=swqLElMOtmlH28HnWbiSY8pE8puNrD4SI9Ju2ZRfBRrBD5uYgDIbNZE6GehJkVckOvAvka
	olosQ50gkZlYAPJuIrceQ3AYydYYB5ZWCASfduM/j5TgBGx5ljiIoUjBzixjH7pmADDnJD
	HSXIHfIGrM+bxG1g30Z3o3ZvFSTNHgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731510591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L4iJ1l2BTJVeMoB7baqjT7BcG8SgipsbPqwJAjDalYo=;
	b=jWHHpyRoD248PFt+uzVbGDlRaA7eBxocpi3mTdiXpkc33RJkVX1LZi45KOa2yEYBwpNjKi
	hoZmZlBAbXdJW0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFC8813301;
	Wed, 13 Nov 2024 15:09:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d8/wNT7BNGcqCgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 13 Nov 2024 15:09:50 +0000
Message-ID: <23fdd6b6-3922-43e8-9aeb-213534ba3e94@suse.cz>
Date: Wed, 13 Nov 2024 16:09:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
 willy@infradead.org, liam.howlett@oracle.com, mhocko@suse.com,
 hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
 mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
 oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org,
 dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com,
 jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
 pasha.tatashin@soleen.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
 <dc1453fb-e066-46df-96ad-fb70cca985a8@suse.cz>
 <7eea5f41-acf0-4feb-8138-a93b67473ccb@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <7eea5f41-acf0-4feb-8138-a93b67473ccb@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,infradead.org,oracle.com,suse.com,cmpxchg.org,gmail.com,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,linux.dev,soleen.com,kvack.org,vger.kernel.org,android.com];
	R_RATELIMIT(0.00)[to_ip_from(RLumbhs4xhzuuihrchnpuyb6qu)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/13/24 15:58, Lorenzo Stoakes wrote:
> On Wed, Nov 13, 2024 at 03:45:24PM +0100, Vlastimil Babka wrote:
>> On 11/13/24 15:28, Lorenzo Stoakes wrote:
>> > On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
>> >> Back when per-vma locks were introduces, vm_lock was moved out of
>> >> vm_area_struct in [1] because of the performance regression caused by
>> >> false cacheline sharing. Recent investigation [2] revealed that the
>> >> regressions is limited to a rather old Broadwell microarchitecture and
>> >> even there it can be mitigated by disabling adjacent cacheline
>> >> prefetching, see [3].
>> >
>> > I don't see a motivating reason as to why we want to do this? We increase
>> > memory usage here which is not good, but later lock optimisation mitigates
>>
>> I'd say we don't normally split logically single structures into multiple
>> structures just because they might pack better in multiple slabs vs single
>> slab. Because that means more complicated management, extra pointer
>> dereferences etc. And if that split away part is a lock, it even complicates
>> things further. So the only motivation for doing that split was that it
>> appeared to perform better, but that was found to be misleading.
>>
>> But sure it can be described better, and include the new
>> SLAB_TYPESAFE_BY_RCU conversion part as the motivation - that would be
>> likely impossible to do with a split away lock.
> 
> Right, my point is that there is no justification given here at all, and we
> should give one. I understand the provenance of why we split the lock, but
> there has to be a motivating reason if everything is working fine right
> now.
> 
> The SLAB_TYPESAFE_BY_RCU one seems to be the key one, but also something
> along the lines of complicated management, concern about ordering of
> allocating/freeing things, etc.
> 
> Just needs some extra explanation here.

Right.

>>
>> > it, but why wouldn't we just do the lock optimisations and use less memory
>> > overall?
>>
>> If the lock is made much smaller then the packing benefit by split might
>> disappear, as is the case here.
>>
> 
> Yeah, but the lock would be smaller so we'd save space still right?

If it becomes small enough that it makes the vma including the lock fit in
192 bytes, then we're no longer saving space by keeping it in a separate
cache. Yes it would make the motivation even more obvious by shrinking it
first and then saying "look, we can even save more space by not having it
separate anymore". But there's the downside of nonstandard locking so I
think the order of changes that first unsplit the lock and only then
consider the pros and cons of shrinking makes more sense.
>> >> This patchset moves vm_lock back into vm_area_struct, aligning it at the
>> >> cacheline boundary and changing the cache to be cache-aligned as well.
>> >> This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
>> >> (vm_lock) bytes to 256 bytes:
>> >>
>> >>     slabinfo before:
>> >>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>> >>      vma_lock         ...     40  102    1 : ...
>> >>      vm_area_struct   ...    160   51    2 : ...
>> >
>> > Pedantry, but it might be worth mentioning how much this can vary by config.
>> >
>> > For instance, on my machine:
>> >
>> > vm_area_struct    125238 138820    184   44
>> >
>> >>
>> >>     slabinfo after moving vm_lock:
>> >>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>> >>      vm_area_struct   ...    256   32    2 : ...
>> >>
>> >> Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
>> >> which is 5.5MB per 100000 VMAs. This memory consumption growth can be
>> >> addressed later by optimizing the vm_lock.
>> >
>> > Yes grabbing this back is of critical importance I'd say! :)
>>
>> I doubt it's that critical. We'll have to weight that against introducing
>> another non-standard locking primitive.
> 
> Avoiding unnecessary VMA overhead is important, and a strong part of the
> motivation for the guard pages series for instance, so I don't think we
> should be unconcerned about unnecessary extra memory usage.

Yeah guard pages eliminate whole VMAs from existence so they are great :)

> I'm guessing from what you say you're not in favour of the subsequent
> 'non-standard' locking changes...

True.

>>
>> > Functionally it looks ok to me but would like to see a stronger
>> > justification in the commit msg! :)
>> >
>> >>
>> >> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
>> >> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
>> >> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
>> >>
>> >> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> >> ---
>> >>  include/linux/mm.h       | 28 +++++++++++++----------
>> >>  include/linux/mm_types.h |  6 +++--
>> >>  kernel/fork.c            | 49 ++++------------------------------------
>> >>  3 files changed, 25 insertions(+), 58 deletions(-)
>> >>


