Return-Path: <linux-kernel+bounces-363574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15EE99C422
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F3E1C228C7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0918B154BFB;
	Mon, 14 Oct 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="txCMgrn6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="srrGAWyH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H+2eXESj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U8fFOABY"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D83231C8E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896018; cv=none; b=iFQxPZA7ccx4Jk/1qPOdHpbdJB+eXbYNbNp64XeBQHW0gAD4GSqCkMn23giwJbg/gj1/6h5yIoNE200FMEMnik1E/+EI2XXPEfrdY5ROtl1NGerXQLyfIiJxD+SrLPmDKBYWFJg9dSI1fbjxKYuoimeN3uJJVrH5wyabtKkw0bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896018; c=relaxed/simple;
	bh=qSClutijEE597E6Y4brQ4MWniap0WMsTdthLe05ZQO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNBx0h7VfJF3PoALhbN7VLqxOIr9MPRXEYO1+jl9FOcN9cDP2YMaUOc1C5L+Z0ReWN/ARobqXkKHXmZC3eGM6NEFz39F/Se7q3WavN5xnwZP6RUlEo4kHpk3hICC7Ul8F0xTZ7LYQrBeozyPCJ49qpciEfKeX/Bw5B9x1HOs6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=txCMgrn6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=srrGAWyH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H+2eXESj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U8fFOABY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01B2021BD1;
	Mon, 14 Oct 2024 08:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728896014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VkZ73gkatyjPy2/ge37jSry6pjGozQUYmtnYd9iTMRI=;
	b=txCMgrn6GHxWgCZdJIRYPz1FHIJwnWzMQXnW1WeoQBuMB0zjaBDwWLgNgozo9Lhft3uqIP
	mRWcR0t/0KLOnWSKdBRX7gVnDOMkfqBVeKrHK5oNT/Qq3nGUoeNPT/fZTVCou40IQch9wq
	QOv9fS9aEaKP/WLo0f+Y/sNs5NZslK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728896014;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VkZ73gkatyjPy2/ge37jSry6pjGozQUYmtnYd9iTMRI=;
	b=srrGAWyHbOHoEiML1ydg8mwv+taW+lF8MxnalLTp4pJxQ7Oci/BRhCK1iro5mFp2OqGgWt
	DSeLae6gxI/m7mBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728896013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VkZ73gkatyjPy2/ge37jSry6pjGozQUYmtnYd9iTMRI=;
	b=H+2eXESj+pDqIwXHXYqWGFOEGivJ3yKXFc8NTxSciC1+wYrZY0C/RrSp0hOf7Sq4w6o+g7
	1+WGgVpe5cK2cpC09mSDQK1Uexx+vPBKNZXf5rmCwhm+tPOx9iZCcAiBP2NeiF2tapMPh7
	orZVNs8Kb3yHW9xmT3MHs5/3uZ5Ogd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728896013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VkZ73gkatyjPy2/ge37jSry6pjGozQUYmtnYd9iTMRI=;
	b=U8fFOABYMJDcg5OHRFg0V60EZDEmKYKqOU1m9oEYrNJ5QENifPdOsEst7U6G1vGq15v5TM
	OBeJfrWyJpwsCYCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAAD113A42;
	Mon, 14 Oct 2024 08:53:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ju0iMQzcDGc4ewAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Oct 2024 08:53:32 +0000
Message-ID: <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
Date: Mon, 14 Oct 2024 10:53:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
To: Feng Tang <feng.tang@intel.com>
Cc: Marco Elver <elver@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 David Gow <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Alexander Potapenko <glider@google.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.com,kernel.org,lge.com,linux.dev,gmail.com,linuxfoundation.org,arm.com,kvack.org,googlegroups.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/14/24 09:52, Feng Tang wrote:
> On Fri, Oct 04, 2024 at 05:52:10PM +0800, Vlastimil Babka wrote:
> Thanks for the suggestion!
> 
> As there were error report about the NULL slab for big kmalloc object, how
> about the following code for 
> 
> __do_krealloc(const void *p, size_t new_size, gfp_t flags)
> {
> 	void *ret;
> 	size_t ks = 0;
> 	int orig_size = 0;
> 	struct kmem_cache *s = NULL;
> 
> 	/* Check for double-free. */
> 	if (likely(!ZERO_OR_NULL_PTR(p))) {
> 		if (!kasan_check_byte(p))
> 			return NULL;
> 
> 		ks = ksize(p);

I think this will result in __ksize() doing
  skip_orig_size_check(folio_slab(folio)->slab_cache, object);
and we don't want that?

Also the checks below repeat some of the checks of ksize().

So I think in __do_krealloc() we should do things manually to determine ks
and not call ksize(). Just not break any of the cases ksize() handles
(kfence, large kmalloc).

> 
> 		/* Some objects have no orig_size, like big kmalloc case */
> 		if (is_kfence_address(p)) {
> 			orig_size = kfence_ksize(p);
> 		} else if (virt_to_slab(p)) {
> 			s = virt_to_cache(p);
> 			orig_size = get_orig_size(s, (void *)p);
> 		}
> 	} else {
> 		goto alloc_new;
> 	}
> 
> 	/* If the object doesn't fit, allocate a bigger one */
> 	if (new_size > ks)
> 		goto alloc_new;
> 
> 	/* Zero out spare memory. */
> 	if (want_init_on_alloc(flags)) {
> 		kasan_disable_current();
> 		if (orig_size && orig_size < new_size)
> 			memset((void *)p + orig_size, 0, new_size - orig_size);
> 		else
> 			memset((void *)p + new_size, 0, ks - new_size);
> 		kasan_enable_current();
> 	}
> 
> 	/* Setup kmalloc redzone when needed */
> 	if (s && slub_debug_orig_size(s) && !is_kfence_address(p)) {
> 		set_orig_size(s, (void *)p, new_size);
> 		if (s->flags & SLAB_RED_ZONE && new_size < ks)
> 			memset_no_sanitize_memory((void *)p + new_size,
> 						SLUB_RED_ACTIVE, ks - new_size);
> 	}
> 
> 	p = kasan_krealloc((void *)p, new_size, flags);
> 	return (void *)p;
> 
> alloc_new:
> 	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
> 	if (ret && p) {
> 		/* Disable KASAN checks as the object's redzone is accessed. */
> 		kasan_disable_current();
> 		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
> 		kasan_enable_current();
> 	}
> 
> 	return ret;
> }
> 
> I've run it with the reproducer of syzbot, so far the issue hasn't been
> reproduced on my local machine.
> 
> Thanks,
> Feng
> 
>> 
>> But either way means rewriting 2 commits. I think it's indeed better to drop
>> the series now from -next and submit a v3.
>> 
>> Vlastimil
>> 
>> >> Thanks,
>> >> -- Marco
>> > 
>> 


