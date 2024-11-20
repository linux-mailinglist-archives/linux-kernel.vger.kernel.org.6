Return-Path: <linux-kernel+bounces-415567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22F19D381A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73755283CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4050E19C569;
	Wed, 20 Nov 2024 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UB4KvUqV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m04/al2j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UB4KvUqV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m04/al2j"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573A17ADE9;
	Wed, 20 Nov 2024 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097810; cv=none; b=DVhOgY0v1ed+S3guxliB1cCiPhw0fiTaJ2WQwk2TYqBKUwleVIZ1fi552L9zF5QFk9x0cL9+M4nB7Ek6JyvLD8PopcgM0Nf1a+SPKblxUtM9kHExkMcqGg/1Nglc7xWLIaA0TFYxMupDsh3Hm22WilQR79pPrPWoKY0qp7KRK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097810; c=relaxed/simple;
	bh=nbl14KaWt5s69PbRD84JTxQGIC2j52PBBVGg9TUKmzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fasJqQN5BndEmfyQB85VmIVTPruAOK+oabrvFvZtk9BvKMw+IDl8SSVDQ+PH4xH1tN1wx3/7t0/kSgvw09hBqdZblRCuiJ3JVAJPXsREsm298L6eWUIW/TXJ3pGw5BAfR71exe4JHG33GUQyplMU0q0vA4lxbNF3QqGvENEv62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UB4KvUqV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m04/al2j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UB4KvUqV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m04/al2j; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AE041F76E;
	Wed, 20 Nov 2024 10:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732097806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJ0fhc3nRRLgNyK2OSmovOVzCLYbFdfk+N0sZ8Il+t8=;
	b=UB4KvUqVcU73Vl36epJjxDkx5sdlpskOyie7vKTF6hskW0A+/aNGD4XgT/e3M/tgqYrSw9
	AVj9Cly/tUG0l3BMY4hqlGoz9gFnyGVmVsDm6fVTlfHw7RTsYBZYOj0jIVlH/oecS5gTFy
	uSkq9OAKwJfjoMHyIInZafU7+jGAXqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732097806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJ0fhc3nRRLgNyK2OSmovOVzCLYbFdfk+N0sZ8Il+t8=;
	b=m04/al2j+hYCaywYmw6q52mVuh0CAWEQqjZpQmhdi/gIa7PGS5Rry8elaKw+CqxC+vL5Bg
	Q7c/7IjnVtcH94AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UB4KvUqV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="m04/al2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732097806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJ0fhc3nRRLgNyK2OSmovOVzCLYbFdfk+N0sZ8Il+t8=;
	b=UB4KvUqVcU73Vl36epJjxDkx5sdlpskOyie7vKTF6hskW0A+/aNGD4XgT/e3M/tgqYrSw9
	AVj9Cly/tUG0l3BMY4hqlGoz9gFnyGVmVsDm6fVTlfHw7RTsYBZYOj0jIVlH/oecS5gTFy
	uSkq9OAKwJfjoMHyIInZafU7+jGAXqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732097806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJ0fhc3nRRLgNyK2OSmovOVzCLYbFdfk+N0sZ8Il+t8=;
	b=m04/al2j+hYCaywYmw6q52mVuh0CAWEQqjZpQmhdi/gIa7PGS5Rry8elaKw+CqxC+vL5Bg
	Q7c/7IjnVtcH94AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21E12137CF;
	Wed, 20 Nov 2024 10:16:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q3rrBw63PWfgYAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 20 Nov 2024 10:16:46 +0000
Message-ID: <d3e5cb3a-9c58-477f-a7f7-c96f7e856a9f@suse.cz>
Date: Wed, 20 Nov 2024 11:16:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
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
References: <20241120000826.335387-1-surenb@google.com>
 <20241120000826.335387-5-surenb@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241120000826.335387-5-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5AE041F76E
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLk41rrgs15z4i1nmqiwtynpyh)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,oracle.com,suse.com,cmpxchg.org,gmail.com,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,google.com,linux.dev,soleen.com,lwn.net,vger.kernel.org,kvack.org,android.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 11/20/24 01:08, Suren Baghdasaryan wrote:
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
> it is locked, then attached at a new address or to a new mm while being
> read-locked;
> For case #1 current checks will help detecting cases when:
> - vma was reused but not yet added into the tree (detached check)
> - vma was reused at a different address range (address check);
> We are missing the check for vm_mm to ensure the reused vma was not
> attached to a different mm. This patch adds the missing check.
> For case #2, we pass mm to vma_start_read() to prevent access to
> unstable vma->vm_mm.

So we may now be looking at different mm's mm_lock_seq.sequence and return a
false unlocked result, right? I guess the mm validation in
lock_vma_under_rcu() handles that, but maybe the comment of vma_start_read()
needs updating.

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
> Adding a freeptr_t into vm_area_struct (unioned with vm_start/vm_end)
> could be used to avoids bloating the structure, however currently
> custom free pointers are not supported in combination with a ctor
> (see the comment for kmem_cache_args.freeptr_offset).

I think there's nothing fundamental preventing to support that, there was
just no user of it. We can do it later.

> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -436,6 +436,11 @@ static struct kmem_cache *vm_area_cachep;
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>  
> +static void vm_area_ctor(void *data)
> +{
> +	vma_lock_init(data);
> +}
> +
>  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
> @@ -462,8 +467,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	 * orig->shared.rb may be modified concurrently, but the clone
>  	 * will be reinitialized.
>  	 */
> -	data_race(memcpy(new, orig, sizeof(*new)));
> -	vma_lock_init(new);
> +	vma_copy(new, orig);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
>  #ifdef CONFIG_PER_VMA_LOCK
>  	/* vma is not locked, can't use vma_mark_detached() */

Here we mark it detached but we might have already copied it as attached and
confused a reader?

I think this will be covered by what you said in reply to willy:
"vma_copy() will have to also copy vma members individually."

> @@ -475,32 +479,37 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	return new;
>  }
>  

