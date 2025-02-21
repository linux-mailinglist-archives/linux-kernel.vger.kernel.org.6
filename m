Return-Path: <linux-kernel+bounces-525993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCC3A3F84B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B163E42219B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0086210F5D;
	Fri, 21 Feb 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuZgXODE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="62UonaN+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuZgXODE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="62UonaN+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921820FAAD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740151228; cv=none; b=W0lX1FivP3SIIywZ3bHu7TrTtja/SBwKjb74Py2GRkBFj/0dn6Ov6aa1up+7WLtd7g2POrBOQBQPCPgS3B9N5KD+XvPOXmcx7cK8xqz3xPe7P16xX5tQgct6zIkJU6SRcjLyiR1WQ5uwFmacXMmx8gNoGMB8QXMI48JZKXFf+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740151228; c=relaxed/simple;
	bh=yXA8fzenql5T5bcHZ5pwp49+KSm55Xd/WgY4/9PTUiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dtd6lAHHNVXbu/z1scby08sOGqiCxN4qkbvsecFNbXYlEeo2XPiwclbfuBrdfA2ehP5NGr125C8jgd7sRAKY8QqdD2JYHPqJoUC4EWt4IkverYTB+CwYjo+ZxY0CWRzJMzS1P17Jbnb2aKRS2PFmTHKlEbV9sw4sxdxPDmgOS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuZgXODE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=62UonaN+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuZgXODE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=62UonaN+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93F89202FC;
	Fri, 21 Feb 2025 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740151224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1F6zlIJCgXPp8mQLGS3l+uzc2ajWKdjZnBRx5Qv5Xc=;
	b=WuZgXODEVafiii1tdNnMR73qNT7xZJ5vZTUOOVvO/SOY+/qqevB2+Kj36fFqytpq2oxEpY
	JWfpIXVWQTsMUuakeS+3P2EdoFBLBy69345ocq+UJIJJbvdqbkSD4U1xZcB1QgejWk1RvO
	x3OulvFN+B/TfHfK9hd7733j2mBZkEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740151224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1F6zlIJCgXPp8mQLGS3l+uzc2ajWKdjZnBRx5Qv5Xc=;
	b=62UonaN+outew0fXq8U0C7ZtnOl/RXt61rAZd7Y9Vsxs7QQuTJZh5g3XgzDoy4wIwCnpew
	o+fBQPaGF9mJ4sCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740151224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1F6zlIJCgXPp8mQLGS3l+uzc2ajWKdjZnBRx5Qv5Xc=;
	b=WuZgXODEVafiii1tdNnMR73qNT7xZJ5vZTUOOVvO/SOY+/qqevB2+Kj36fFqytpq2oxEpY
	JWfpIXVWQTsMUuakeS+3P2EdoFBLBy69345ocq+UJIJJbvdqbkSD4U1xZcB1QgejWk1RvO
	x3OulvFN+B/TfHfK9hd7733j2mBZkEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740151224;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1F6zlIJCgXPp8mQLGS3l+uzc2ajWKdjZnBRx5Qv5Xc=;
	b=62UonaN+outew0fXq8U0C7ZtnOl/RXt61rAZd7Y9Vsxs7QQuTJZh5g3XgzDoy4wIwCnpew
	o+fBQPaGF9mJ4sCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5107E136AD;
	Fri, 21 Feb 2025 15:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o4h2E7iZuGfYGQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 21 Feb 2025 15:20:24 +0000
Message-ID: <14a04071-4650-4e81-b8b5-ab4dd330fe73@suse.cz>
Date: Fri, 21 Feb 2025 16:20:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 13/18] mm: move lesser used vma_area_struct members
 into the last cacheline
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com,
 lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com,
 hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
 mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
 oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org,
 dhowells@redhat.com, hdanton@sina.com, hughd@google.com,
 lokeshgidra@google.com, minchan@google.com, jannh@google.com,
 shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com,
 klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com
References: <20250213224655.1680278-1-surenb@google.com>
 <20250213224655.1680278-14-surenb@google.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250213224655.1680278-14-surenb@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,oracle.com,gmail.com,suse.com,cmpxchg.org,intel.com,techsingularity.net,redhat.com,stgolabs.net,kernel.org,sina.com,google.com,linux.dev,soleen.com,lwn.net,vger.kernel.org,kvack.org,android.com];
	R_RATELIMIT(0.00)[to_ip_from(RLumbhs4xhzuuihrchnpuyb6qu)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 2/13/25 23:46, Suren Baghdasaryan wrote:
> Move several vma_area_struct members which are rarely or never used
> during page fault handling into the last cacheline to better pack
> vm_area_struct. As a result vm_area_struct will fit into 3 as opposed
> to 4 cachelines. New typical vm_area_struct layout:
> 
> struct vm_area_struct {
>     union {
>         struct {
>             long unsigned int vm_start;              /*     0     8 */
>             long unsigned int vm_end;                /*     8     8 */
>         };                                           /*     0    16 */
>         freeptr_t          vm_freeptr;               /*     0     8 */
>     };                                               /*     0    16 */
>     struct mm_struct *         vm_mm;                /*    16     8 */
>     pgprot_t                   vm_page_prot;         /*    24     8 */
>     union {
>         const vm_flags_t   vm_flags;                 /*    32     8 */
>         vm_flags_t         __vm_flags;               /*    32     8 */
>     };                                               /*    32     8 */
>     unsigned int               vm_lock_seq;          /*    40     4 */
> 
>     /* XXX 4 bytes hole, try to pack */
> 
>     struct list_head           anon_vma_chain;       /*    48    16 */
>     /* --- cacheline 1 boundary (64 bytes) --- */
>     struct anon_vma *          anon_vma;             /*    64     8 */
>     const struct vm_operations_struct  * vm_ops;     /*    72     8 */
>     long unsigned int          vm_pgoff;             /*    80     8 */
>     struct file *              vm_file;              /*    88     8 */
>     void *                     vm_private_data;      /*    96     8 */
>     atomic_long_t              swap_readahead_info;  /*   104     8 */
>     struct mempolicy *         vm_policy;            /*   112     8 */
>     struct vma_numab_state *   numab_state;          /*   120     8 */
>     /* --- cacheline 2 boundary (128 bytes) --- */
>     refcount_t          vm_refcnt (__aligned__(64)); /*   128     4 */
> 
>     /* XXX 4 bytes hole, try to pack */
> 
>     struct {
>         struct rb_node     rb (__aligned__(8));      /*   136    24 */
>         long unsigned int  rb_subtree_last;          /*   160     8 */
>     } __attribute__((__aligned__(8))) shared;        /*   136    32 */
>     struct anon_vma_name *     anon_name;            /*   168     8 */
>     struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   176     8 */
> 
>     /* size: 192, cachelines: 3, members: 18 */
>     /* sum members: 176, holes: 2, sum holes: 8 */
>     /* padding: 8 */
>     /* forced alignments: 2, forced holes: 1, sum forced holes: 4 */
> } __attribute__((__aligned__(64)));
> 
> Memory consumption per 1000 VMAs becomes 48 pages:
> 
>     slabinfo after vm_area_struct changes:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    192   42    2 : ...
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>


