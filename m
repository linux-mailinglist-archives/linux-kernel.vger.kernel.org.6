Return-Path: <linux-kernel+bounces-405551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA49C52C9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5267F1F228AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0249B210184;
	Tue, 12 Nov 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M47x6GJ0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0IoXzgLp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M47x6GJ0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0IoXzgLp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FCD20E337
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406045; cv=none; b=MlsMqzEmtsRvaiYnhk4p61428NcHLNISEkMy522vTWyU0akndVaM/L050wzO+BRq1kGnn4orJq8F7ffg31n0UgIBhPYkDWBUK8pN+RFRpf3xAX6xYDzm1CgYVF1/VsS/Mnt9qZt7yQZnRz4hIrKJBM6ykc8gwnqaJgxF1jQ2zK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406045; c=relaxed/simple;
	bh=fKiP9Xwq6SB2pOYhGZP3TUjvfA/mUoe1SLEpc13ZZnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OEU8qODTnNgny/SFTusvzcZmIZf4qEzXnRFt0X7M/2WF1MAPfkoXfVXLx8tTUH7dNxvqeIrDvwqAx2/4bH4lTC2caUwYOhWQyy7673JdXuq/3l4Eg187TI5Ow56LesbROwW+ceW/JGRzYJ+HJdfiNLe6SMnnouearAcMSuGVexQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M47x6GJ0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0IoXzgLp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M47x6GJ0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0IoXzgLp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0924216E7;
	Tue, 12 Nov 2024 10:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731406040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MGDm23N0btDZ/ygxqDfjW8gUuYa5kE9YjORkIqBxqzA=;
	b=M47x6GJ0LX05abHbQdWGDM2MWjTN+Jztt9caSXg99IKDX78+lkaCDrJG9XeWxLFqgy8Ifl
	7pLxtVgCh3EKEQwGYTTD3a7cVd3LQszvaxvmvqpq3pao7+ndJDnbv2iHeA6LC+qDQzqgSC
	Sehmv9uy6mXiYHyvn3obN5FmMCUoeYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731406040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MGDm23N0btDZ/ygxqDfjW8gUuYa5kE9YjORkIqBxqzA=;
	b=0IoXzgLpUuWCn+6zmz/RZiQPxlO22yMl1CstCYbds7ClRMtt6ALB9X5DDEhBz9eU7802M3
	ZBspoBbEFOtzFoCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=M47x6GJ0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0IoXzgLp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731406040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MGDm23N0btDZ/ygxqDfjW8gUuYa5kE9YjORkIqBxqzA=;
	b=M47x6GJ0LX05abHbQdWGDM2MWjTN+Jztt9caSXg99IKDX78+lkaCDrJG9XeWxLFqgy8Ifl
	7pLxtVgCh3EKEQwGYTTD3a7cVd3LQszvaxvmvqpq3pao7+ndJDnbv2iHeA6LC+qDQzqgSC
	Sehmv9uy6mXiYHyvn3obN5FmMCUoeYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731406040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MGDm23N0btDZ/ygxqDfjW8gUuYa5kE9YjORkIqBxqzA=;
	b=0IoXzgLpUuWCn+6zmz/RZiQPxlO22yMl1CstCYbds7ClRMtt6ALB9X5DDEhBz9eU7802M3
	ZBspoBbEFOtzFoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 789E213721;
	Tue, 12 Nov 2024 10:07:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rgD3HNgoM2fTKgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Nov 2024 10:07:20 +0000
Message-ID: <fdb2bd2e-eaac-482b-bf32-641f9df7a5fc@suse.cz>
Date: Tue, 12 Nov 2024 11:07:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm: move lesser used vma_area_struct members into the
 last cacheline
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com,
 mhocko@suse.com, hannes@cmpxchg.org, mjguzik@gmail.com,
 oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
 peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
 brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
 souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20241111205506.3404479-1-surenb@google.com>
 <20241111205506.3404479-5-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241111205506.3404479-5-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B0924216E7
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
	RCPT_COUNT_TWELVE(0.00)[27];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	FREEMAIL_CC(0.00)[infradead.org,oracle.com,suse.com,cmpxchg.org,gmail.com,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,google.com,linux.dev,soleen.com,kvack.org,vger.kernel.org,android.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLk41rrgs15z4i1nmqiwtynpyh)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/11/24 21:55, Suren Baghdasaryan wrote:
> Move several vma_area_struct members which are rarely or never used
> during page fault handling into the last cacheline to better pack
> vm_area_struct. As a result vm_area_struct will fit into 3 cachelines
> as opposed to 4 cachelines before this change. New vm_area_struct layout:
> 
> struct vm_area_struct {
> 	union {
> 		struct {
> 			long unsigned int vm_start;      /*     0     8 */
> 			long unsigned int vm_end;        /*     8     8 */
> 		};                                       /*     0    16 */
> 		struct callback_head vm_rcu ;            /*     0    16 */
> 	} __attribute__((__aligned__(8)));               /*     0    16 */
> 	struct mm_struct *         vm_mm;                /*    16     8 */
> 	pgprot_t                   vm_page_prot;         /*    24     8 */
> 	union {
> 		const vm_flags_t   vm_flags;             /*    32     8 */
> 		vm_flags_t         __vm_flags;           /*    32     8 */
> 	};                                               /*    32     8 */
> 	bool                       detached;             /*    40     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	unsigned int               vm_lock_seq;          /*    44     4 */
> 	struct list_head           anon_vma_chain;       /*    48    16 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct anon_vma *          anon_vma;             /*    64     8 */
> 	const struct vm_operations_struct  * vm_ops;     /*    72     8 */
> 	long unsigned int          vm_pgoff;             /*    80     8 */
> 	struct file *              vm_file;              /*    88     8 */
> 	void *                     vm_private_data;      /*    96     8 */
> 	atomic_long_t              swap_readahead_info;  /*   104     8 */
> 	struct mempolicy *         vm_policy;            /*   112     8 */
> 
> 	/* XXX 8 bytes hole, try to pack */
> 
> 	/* --- cacheline 2 boundary (128 bytes) --- */
> 	struct vma_lock       vm_lock (__aligned__(64)); /*   128     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct {
> 		struct rb_node     rb (__aligned__(8));  /*   136    24 */
> 		long unsigned int  rb_subtree_last;      /*   160     8 */
> 	} __attribute__((__aligned__(8))) shared;        /*   136    32 */
> 	struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0 */

I don't see anon_name in the output, I thought it was added for Android? :)

> 
> 	/* size: 192, cachelines: 3, members: 17 */
> 	/* sum members: 153, holes: 3, sum holes: 15 */
> 	/* padding: 24 */

Instead you seem to have padding so an attempt to use SLAB_TYPESAFE_BY_RCU
should use that and not add more up to 256 pages.
Perhaps this pahole output wasn't generated with a fully representative config?

> 	/* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
> } __attribute__((__aligned__(64)));
> 
> 
> Memory consumption per 1000 VMAs becomes 48 pages:
> 
>     slabinfo after vm_area_struct changes:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    192   42    2 : ...
> 
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm_types.h | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 789bccc05520..c3755b680911 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -733,16 +733,6 @@ struct vm_area_struct {
>  	unsigned int vm_lock_seq;
>  #endif
>  
> -	/*
> -	 * For areas with an address space and backing store,
> -	 * linkage into the address_space->i_mmap interval tree.
> -	 *
> -	 */
> -	struct {
> -		struct rb_node rb;
> -		unsigned long rb_subtree_last;
> -	} shared;
> -
>  	/*
>  	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
>  	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
> @@ -762,14 +752,6 @@ struct vm_area_struct {
>  	struct file * vm_file;		/* File we map to (can be NULL). */
>  	void * vm_private_data;		/* was vm_pte (shared mem) */
>  
> -#ifdef CONFIG_ANON_VMA_NAME
> -	/*
> -	 * For private and shared anonymous mappings, a pointer to a null
> -	 * terminated string containing the name given to the vma, or NULL if
> -	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
> -	 */
> -	struct anon_vma_name *anon_name;
> -#endif
>  #ifdef CONFIG_SWAP
>  	atomic_long_t swap_readahead_info;
>  #endif
> @@ -782,11 +764,28 @@ struct vm_area_struct {
>  #ifdef CONFIG_NUMA_BALANCING
>  	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
>  #endif
> -	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>  #ifdef CONFIG_PER_VMA_LOCK
>  	/* Unstable RCU readers are allowed to read this. */
>  	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
>  #endif
> +	/*
> +	 * For areas with an address space and backing store,
> +	 * linkage into the address_space->i_mmap interval tree.
> +	 *
> +	 */
> +	struct {
> +		struct rb_node rb;
> +		unsigned long rb_subtree_last;
> +	} shared;
> +#ifdef CONFIG_ANON_VMA_NAME
> +	/*
> +	 * For private and shared anonymous mappings, a pointer to a null
> +	 * terminated string containing the name given to the vma, or NULL if
> +	 * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
> +	 */
> +	struct anon_vma_name *anon_name;
> +#endif
> +	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
>  } __randomize_layout;
>  
>  #ifdef CONFIG_NUMA


