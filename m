Return-Path: <linux-kernel+bounces-440064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CE89EB831
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F99162FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0893923ED5D;
	Tue, 10 Dec 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0VefjfpW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b41RJDep";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0VefjfpW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b41RJDep"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C423ED4F;
	Tue, 10 Dec 2024 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851539; cv=none; b=h+1pioXlKkc9b6aWmV6CiWcsbb/09HVv9GZrmN4iuYaT+9VXzBL4EMatkPSuWj07xB4ve+0dbwpE7/1awevnQSzXdCwBD2/I/x18sr8EjYAKpVXqIYK4fdFvJCuTlaKPh612B2MOAQ2qvs7+hx8PrNaCvPdMBxSxnCXmTVlmArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851539; c=relaxed/simple;
	bh=89lG/YYBfbH9HoYZ2s5/jkMekAx0+3un/DNe7QXj4mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2ofm3uEH40C4LYMe95frl0xcbeGdQKXfwKxLRlV0VWAwxSeTr7yfnwPwQiokDByGSEh7VvKK5ddUtf2fYv1Me6ALqt2NHvTY2GHxJgubc37onY3qp89IuouQG5O6cboGH89VnKlvFQofDm2uERenj8AT0jSrASgejqD0lDlg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0VefjfpW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b41RJDep; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0VefjfpW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b41RJDep; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A961F21168;
	Tue, 10 Dec 2024 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733851534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EY7dEEgii5GdwN9LLpq6TqyarjQDTGcHpcEeyszhw2o=;
	b=0VefjfpWdmsD5n9Z62niYq/RFaO9zz5hCrdpajqidmofTtk/ZYNDzFNyLLAVL1PJENqwIE
	LtmwJKqQKSG5Crf+8E1pSDUzfy8/LMc8XwdzyL9ikTwFlzLhwVzWxXBgc+kZfuyY6Bu8u8
	4Z6nb0dk7MTi9FEz4U33/RuhlL7nBb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733851534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EY7dEEgii5GdwN9LLpq6TqyarjQDTGcHpcEeyszhw2o=;
	b=b41RJDepM7D8h3zJPTyVPvGPIoevQEd5dgZfYhhuuo+1xqrjVvYHWoRi8szv2nkZIwSJzM
	yu919rS0omIARAAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0VefjfpW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b41RJDep
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733851534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EY7dEEgii5GdwN9LLpq6TqyarjQDTGcHpcEeyszhw2o=;
	b=0VefjfpWdmsD5n9Z62niYq/RFaO9zz5hCrdpajqidmofTtk/ZYNDzFNyLLAVL1PJENqwIE
	LtmwJKqQKSG5Crf+8E1pSDUzfy8/LMc8XwdzyL9ikTwFlzLhwVzWxXBgc+kZfuyY6Bu8u8
	4Z6nb0dk7MTi9FEz4U33/RuhlL7nBb8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733851534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EY7dEEgii5GdwN9LLpq6TqyarjQDTGcHpcEeyszhw2o=;
	b=b41RJDepM7D8h3zJPTyVPvGPIoevQEd5dgZfYhhuuo+1xqrjVvYHWoRi8szv2nkZIwSJzM
	yu919rS0omIARAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70074138D2;
	Tue, 10 Dec 2024 17:25:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fhkHG455WGccTwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 10 Dec 2024 17:25:34 +0000
Message-ID: <5036d089-0774-4863-88c5-eaaea1265ac7@suse.cz>
Date: Tue, 10 Dec 2024 18:25:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org,
 mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net,
 david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
 paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
 hdanton@sina.com, hughd@google.com, minchan@google.com, jannh@google.com,
 shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241206225204.4008261-1-surenb@google.com>
 <20241206225204.4008261-5-surenb@google.com>
 <6b29b2a5-c244-4930-a5a0-1a24a04e7e35@suse.cz>
 <CAJuCfpFxAZ-JwN8VqNF14zeBnsPM_pD0+-N2PDq5GcQGR1xqLQ@mail.gmail.com>
 <643beb6c-4226-46ca-b7e9-292467479aea@suse.cz>
 <CAJuCfpHR3LXfAZA_oh_2KBtFe6JQPU5T3nYMZd_ooAjRJd8xUQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAJuCfpHR3LXfAZA_oh_2KBtFe6JQPU5T3nYMZd_ooAjRJd8xUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A961F21168
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,oracle.com,suse.com,cmpxchg.org,gmail.com,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,google.com,linux.dev,soleen.com,lwn.net,vger.kernel.org,kvack.org,android.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLk41rrgs15z4i1nmqiwtynpyh)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 12/10/24 18:16, Suren Baghdasaryan wrote:
> On Tue, Dec 10, 2024 at 8:32 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 12/10/24 17:20, Suren Baghdasaryan wrote:
>> > On Tue, Dec 10, 2024 at 6:21 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> >>
>> >> On 12/6/24 23:52, Suren Baghdasaryan wrote:
>> >> > To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
>> >> > object reuse before RCU grace period is over will be detected inside
>> >> > lock_vma_under_rcu().
>> >> > lock_vma_under_rcu() enters RCU read section, finds the vma at the
>> >> > given address, locks the vma and checks if it got detached or remapped
>> >> > to cover a different address range. These last checks are there
>> >> > to ensure that the vma was not modified after we found it but before
>> >> > locking it.
>> >> > vma reuse introduces several new possibilities:
>> >> > 1. vma can be reused after it was found but before it is locked;
>> >> > 2. vma can be reused and reinitialized (including changing its vm_mm)
>> >> > while being locked in vma_start_read();
>> >> > 3. vma can be reused and reinitialized after it was found but before
>> >> > it is locked, then attached at a new address or to a new mm while
>> >> > read-locked;
>> >> > For case #1 current checks will help detecting cases when:
>> >> > - vma was reused but not yet added into the tree (detached check)
>> >> > - vma was reused at a different address range (address check);
>> >> > We are missing the check for vm_mm to ensure the reused vma was not
>> >> > attached to a different mm. This patch adds the missing check.
>> >> > For case #2, we pass mm to vma_start_read() to prevent access to
>> >> > unstable vma->vm_mm. This might lead to vma_start_read() returning
>> >> > a false locked result but that's not critical if it's rare because
>> >> > it will only lead to a retry under mmap_lock.
>> >> > For case #3, we ensure the order in which vma->detached flag and
>> >> > vm_start/vm_end/vm_mm are set and checked. vma gets attached after
>> >> > vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
>> >> > vma->detached before checking vm_start/vm_end/vm_mm. This is required
>> >> > because attaching vma happens without vma write-lock, as opposed to
>> >> > vma detaching, which requires vma write-lock. This patch adds memory
>> >> > barriers inside is_vma_detached() and vma_mark_attached() needed to
>> >> > order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
>> >> > After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep.
>> >> > This will facilitate vm_area_struct reuse and will minimize the number
>> >> > of call_rcu() calls.
>> >> >
>> >> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>> >>
>> >> I'm wondering about the vma freeing path. Consider vma_complete():
>> >>
>> >> vma_mark_detached(vp->remove);
>> >>   vma->detached = true; - plain write
>> >> vm_area_free(vp->remove);
>> >>   vma->vm_lock_seq = UINT_MAX; - plain write
>> >>   kmem_cache_free(vm_area_cachep)
>> >> ...
>> >> potential reallocation
>> >>
>> >> against:
>> >>
>> >> lock_vma_under_rcu()
>> >> - mas_walk finds a stale vma due to race
>> >> vma_start_read()
>> >>   if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
>> >>   - can be false, the vma was not being locked on the freeing side?
>> >>   down_read_trylock(&vma->vm_lock.lock) - suceeds, wasn't locked
>> >>     this is acquire, but was there any release?
>> >
>> > Yes, there was a release. I think what you missed is that
>> > vma_mark_detached() that is called from vma_complete() requires VMA to
>> > be write-locked (see vma_assert_write_locked() in
>> > vma_mark_detached()). The rule is that a VMA can be attached without
>> > write-locking but only a write-locked VMA can be detached. So, after
>>
>> OK but write unlocking means the mm's seqcount is bumped and becomes
>> non-equal with vma's vma->vm_lock_seq, right?
>>
>> Yet in the example above we happily set it to UINT_MAX and thus effectively
>> false unlock it for vma_start_read()?
>>
>> And this is all done before the vma_complete() side would actually reach
>> mmap_write_unlock(), AFAICS.
> 
> Ah, you are right. With the possibility of reuse, even a freed VMA
> should be kept write-locked until it is unlocked by
> mmap_write_unlock(). I think the fix for this is simply to not reset
> vma->vm_lock_seq inside vm_area_free(). I'll also need to add a

But even if we don't reset vm_lock_seq to UINT_MAX, then whover reallocated
it can proceed and end up doing a vma_start_write() and rewrite it there
anyway, no?

> comment for vm_lock_seq explaining these requirements.
> Do you agree that such a change would resolve the issue?
> 
>>
>> > vma_mark_detached() and before down_read_trylock(&vma->vm_lock.lock)
>> > in vma_start_read() the VMA write-lock should have been released by
>> > mmap_write_unlock() and therefore vma->detached=false should be
>> > visible to the reader when it executed lock_vma_under_rcu().
>> >
>> >>   is_vma_detached() - false negative as the write above didn't propagate
>> >>     here yet; a read barrier but where is the write barrier?
>> >>   checks for vma->vm_mm, vm_start, vm_end - nobody reset them yet so false
>> >>     positive, or they got reset on reallocation but writes didn't propagate
>> >>
>> >> Am I missing something that would prevent lock_vma_under_rcu() falsely
>> >> succeeding here?
>> >>
>>


