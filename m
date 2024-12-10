Return-Path: <linux-kernel+bounces-439520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21799EB072
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC65616888B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527C11A0BCF;
	Tue, 10 Dec 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qJBMGtBF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gf1e1f9Q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qJBMGtBF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gf1e1f9Q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF41A0B0D;
	Tue, 10 Dec 2024 12:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832392; cv=none; b=OcHQmbpPWGVsxMJaXNT8nGfwjdrBKVBfwJcVKl/2eWh280rPLnkxZoglYYjubpHfzuIwxo6HbcepIHXNxH5wyTztWyAk+eorpx87Chc3NXoJy4Vck5e2I2mmOyk7lSZdh3qt8sCyjcsacwypCr9hlAWB3kN8zoKp0lgx03zebrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832392; c=relaxed/simple;
	bh=1/+zi2oed/oMIsCnusE2JFOeNlspb/ZjC0p5az1x+ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pC6NBytbCAlPgKfYlky/IWmvaGL4FfJGQZZ3GUYp+/2k0VzIqbntBXgjo6hsQ0EgxQpgfjPYIDhU4rzk6KnKwkmJiiz/pwHn2+esLmfIJZQBjgZEhHLsfZlWkDX8ssQI/Kig2Myr9r/bbyDN4em89RlwI1YaTQrDemWtMSUAtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qJBMGtBF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gf1e1f9Q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qJBMGtBF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gf1e1f9Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D47A81F395;
	Tue, 10 Dec 2024 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733832386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OkZB7jqkDiu96dB+hkG5d8vaATfSyqCtRYPDrmMMQ10=;
	b=qJBMGtBFixuL5n1gpUVThJejxNTGV1cS+YFy5em5AyDY0SRKWCgjy3jm1N03y4k/R5KEvY
	7n1wumCGQBQ85j75zuQnoJAciZ4J9XSVEyNBWh/j8Zvklmz01u0A7bDCNUu3uM9rFP8Ink
	2o4jqhrynkSKEtZ5eqtIzfzYPqQ5hW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733832386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OkZB7jqkDiu96dB+hkG5d8vaATfSyqCtRYPDrmMMQ10=;
	b=Gf1e1f9QMSno+QUQmHZKaNTRBA9q80elKWNOhZSB+xSxXSrSwoM6K8JDsjwU0ieHr64Jws
	IeI++Xz97Dw9NZDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733832386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OkZB7jqkDiu96dB+hkG5d8vaATfSyqCtRYPDrmMMQ10=;
	b=qJBMGtBFixuL5n1gpUVThJejxNTGV1cS+YFy5em5AyDY0SRKWCgjy3jm1N03y4k/R5KEvY
	7n1wumCGQBQ85j75zuQnoJAciZ4J9XSVEyNBWh/j8Zvklmz01u0A7bDCNUu3uM9rFP8Ink
	2o4jqhrynkSKEtZ5eqtIzfzYPqQ5hW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733832386;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OkZB7jqkDiu96dB+hkG5d8vaATfSyqCtRYPDrmMMQ10=;
	b=Gf1e1f9QMSno+QUQmHZKaNTRBA9q80elKWNOhZSB+xSxXSrSwoM6K8JDsjwU0ieHr64Jws
	IeI++Xz97Dw9NZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9657E13A15;
	Tue, 10 Dec 2024 12:06:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DbcEJMIuWGenZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 10 Dec 2024 12:06:26 +0000
Message-ID: <9f000fbf-b5c4-41f5-8a4a-9c78b37c2ec5@suse.cz>
Date: Tue, 10 Dec 2024 13:06:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
 mhocko@suse.com, hannes@cmpxchg.org, mjguzik@gmail.com,
 oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
 peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
 brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com
References: <20241206225204.4008261-1-surenb@google.com>
 <20241206225204.4008261-5-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241206225204.4008261-5-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[infradead.org,oracle.com,suse.com,cmpxchg.org,gmail.com,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,google.com,linux.dev,soleen.com,lwn.net,vger.kernel.org,kvack.org,android.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLumbhs4xhzuuihrchnpuyb6qu)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 12/6/24 23:52, Suren Baghdasaryan wrote:
> To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
> object reuse before RCU grace period is over will be detected inside
> lock_vma_under_rcu().
> lock_vma_under_rcu() enters RCU read section, finds the vma at the
> given address, locks the vma and checks if it got detached or remapped
> to cover a different address range. These last checks are there
> to ensure that the vma was not modified after we found it but before
> locking it.
> vma reuse introduces several new possibilities:
> 1. vma can be reused after it was found but before it is locked;
> 2. vma can be reused and reinitialized (including changing its vm_mm)
> while being locked in vma_start_read();
> 3. vma can be reused and reinitialized after it was found but before
> it is locked, then attached at a new address or to a new mm while
> read-locked;
> For case #1 current checks will help detecting cases when:
> - vma was reused but not yet added into the tree (detached check)
> - vma was reused at a different address range (address check);
> We are missing the check for vm_mm to ensure the reused vma was not
> attached to a different mm. This patch adds the missing check.
> For case #2, we pass mm to vma_start_read() to prevent access to
> unstable vma->vm_mm. This might lead to vma_start_read() returning
> a false locked result but that's not critical if it's rare because
> it will only lead to a retry under mmap_lock.
> For case #3, we ensure the order in which vma->detached flag and
> vm_start/vm_end/vm_mm are set and checked. vma gets attached after
> vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
> vma->detached before checking vm_start/vm_end/vm_mm. This is required
> because attaching vma happens without vma write-lock, as opposed to
> vma detaching, which requires vma write-lock. This patch adds memory
> barriers inside is_vma_detached() and vma_mark_attached() needed to
> order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
> After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep.
> This will facilitate vm_area_struct reuse and will minimize the number
> of call_rcu() calls.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h               |  36 +++++--
>  include/linux/mm_types.h         |  10 +-
>  include/linux/slab.h             |   6 --
>  kernel/fork.c                    | 157 +++++++++++++++++++++++++------
>  mm/memory.c                      |  15 ++-
>  mm/vma.c                         |   2 +-
>  tools/testing/vma/vma_internal.h |   7 +-
>  7 files changed, 179 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2bf38c1e9cca..3568bcbc7c81 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -257,7 +257,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *);
>  struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
>  void vm_area_free(struct vm_area_struct *);
>  /* Use only if VMA has no other users */
> -void __vm_area_free(struct vm_area_struct *vma);
> +void vm_area_free_unreachable(struct vm_area_struct *vma);
>  
>  #ifndef CONFIG_MMU
>  extern struct rb_root nommu_region_tree;
> @@ -706,8 +706,10 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
>   * Try to read-lock a vma. The function is allowed to occasionally yield false
>   * locked result to avoid performance overhead, in which case we fall back to
>   * using mmap_lock. The function should never yield false unlocked result.
> + * False locked result is possible if mm_lock_seq overflows or if vma gets
> + * reused and attached to a different mm before we lock it.
>   */
> -static inline bool vma_start_read(struct vm_area_struct *vma)
> +static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
>  {
>  	/*
>  	 * Check before locking. A race might cause false locked result.
> @@ -716,7 +718,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * we don't rely on for anything - the mm_lock_seq read against which we
>  	 * need ordering is below.
>  	 */
> -	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
> +	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
>  		return false;
>  
>  	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
> @@ -733,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * after it has been unlocked.
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
> -	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> +	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
>  		up_read(&vma->vm_lock.lock);
>  		return false;
>  	}

This could have been perhaps another preparatory patch to make this one smaller?

>  
> +static void vm_area_ctor(void *data)
> +{
> +	struct vm_area_struct *vma = (struct vm_area_struct *)data;
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* vma is not locked, can't use vma_mark_detached() */
> +	vma->detached = true;
> +#endif
> +	INIT_LIST_HEAD(&vma->anon_vma_chain);
> +	vma_lock_init(vma);
> +}
> +
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static void vma_clear(struct vm_area_struct *vma, struct mm_struct *mm)
> +{
> +	vma->vm_mm = mm;
> +	vma->vm_ops = &vma_dummy_vm_ops;
> +	vma->vm_start = 0;
> +	vma->vm_end = 0;
> +	vma->anon_vma = NULL;
> +	vma->vm_pgoff = 0;
> +	vma->vm_file = NULL;
> +	vma->vm_private_data = NULL;
> +	vm_flags_init(vma, 0);
> +	memset(&vma->vm_page_prot, 0, sizeof(vma->vm_page_prot));
> +	memset(&vma->shared, 0, sizeof(vma->shared));
> +	memset(&vma->vm_userfaultfd_ctx, 0, sizeof(vma->vm_userfaultfd_ctx));
> +	vma_numab_state_init(vma);
> +#ifdef CONFIG_ANON_VMA_NAME
> +	vma->anon_name = NULL;
> +#endif
> +#ifdef CONFIG_SWAP
> +	memset(&vma->swap_readahead_info, 0, sizeof(vma->swap_readahead_info));
> +#endif
> +#ifndef CONFIG_MMU
> +	vma->vm_region = NULL;
> +#endif
> +#ifdef CONFIG_NUMA
> +	vma->vm_policy = NULL;
> +#endif

This isn't the ideal pattern I think, now that we have a ctor. Ideally the
ctor would do all this (except setting the vm_mm), and then we need to make
sure it's also done when freeing the vma, to make sure the freed object is
in the same state as a new object after the constructor.

On freeing, things like numab_state and anon_name could be NULL'd (by the
respective destructors) only when they are non-NULL and thus freeing the
objects pointed to. vm_policy and vm_file could perhaps be handled same way
after some refactoring (see remove_vma()), vma_dummy_vm_ops are possibly
already reset by vma_close(), etc.

> +}
> +
> +static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *dest)
> +{
> +	dest->vm_mm = src->vm_mm;
> +	dest->vm_ops = src->vm_ops;
> +	dest->vm_start = src->vm_start;
> +	dest->vm_end = src->vm_end;
> +	dest->anon_vma = src->anon_vma;
> +	dest->vm_pgoff = src->vm_pgoff;
> +	dest->vm_file = src->vm_file;
> +	dest->vm_private_data = src->vm_private_data;
> +	vm_flags_init(dest, src->vm_flags);
> +	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
> +	       sizeof(dest->vm_page_prot));
> +	memcpy(&dest->shared, &src->shared, sizeof(dest->shared));
> +	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
> +	       sizeof(dest->vm_userfaultfd_ctx));
> +#ifdef CONFIG_ANON_VMA_NAME
> +	dest->anon_name = src->anon_name;
> +#endif
> +#ifdef CONFIG_SWAP
> +	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
> +	       sizeof(dest->swap_readahead_info));
> +#endif
> +#ifndef CONFIG_MMU
> +	dest->vm_region = src->vm_region;
> +#endif
> +#ifdef CONFIG_NUMA
> +	dest->vm_policy = src->vm_policy;
> +#endif
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */

