Return-Path: <linux-kernel+bounces-364109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7D99CB44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212EEB25BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CAF1A76C4;
	Mon, 14 Oct 2024 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FfMDbpv1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f8YLxQaJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FfMDbpv1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f8YLxQaJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884A01A0B08
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911533; cv=none; b=GcdjhTLrNWMujKRjjnzqRw/sLiiWi/nW8GqP0M5urTYhfBvnhJjnIqtjd/gt3BJtdJTotI6uI+VQJgPNnjt+HqmhIerWbOcsjWz0PkjK+7L2RhvliT2qdbXJZcZ0m1EM35W1rr0zEunPNE94sJYQtsSch9GJhlwCY5dViLiCNCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911533; c=relaxed/simple;
	bh=a2Bn1VKga7M2ELS7uMwMKcaMGi3JbPfV/eGtuenVZ7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrpUZJtyRSKX+xwmqzOykYaeKsFipM1TvCLcPmu1s/E0bJ8WjG+NRmPKuG8Rgd0xSvZUYQWNX0+oZVhXo1xxSKDvSYkn+G5iCSqgLOjKqTTxHaZZ97ohTOm9D2EiaLo8Vpx1XthDJ0i5c9D3CyW/Ah/q4U2es/x108prdJS/zyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FfMDbpv1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f8YLxQaJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FfMDbpv1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f8YLxQaJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC7991FE53;
	Mon, 14 Oct 2024 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728911529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zqarmSZKN2z2nIPNDdOcCc2rTYxaKohP7Uy1zHoY2f0=;
	b=FfMDbpv1l2NtnzMw1Gbcz/vX1m1TNLxMqS84ge53GI/pqNfzz9Uw5XbO2JA/2wrrkFU9lC
	jSo/ylkJZcGz54O4RuUg20lu/od9J4zc651nxRaA1+N4hP7uYdLy/hclUt5v1/L0mpCHIy
	5TgIxpe2MPTJEtSLM/BXJCZbtiR+/R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728911529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zqarmSZKN2z2nIPNDdOcCc2rTYxaKohP7Uy1zHoY2f0=;
	b=f8YLxQaJYHtPhhrTQpBYViIIXrdvgsp7zqMU+e6rEnlnfu2ngOrQ+KDmzMTVjo1zsxK9oN
	eGytFjrqbMumSJCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FfMDbpv1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=f8YLxQaJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728911529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zqarmSZKN2z2nIPNDdOcCc2rTYxaKohP7Uy1zHoY2f0=;
	b=FfMDbpv1l2NtnzMw1Gbcz/vX1m1TNLxMqS84ge53GI/pqNfzz9Uw5XbO2JA/2wrrkFU9lC
	jSo/ylkJZcGz54O4RuUg20lu/od9J4zc651nxRaA1+N4hP7uYdLy/hclUt5v1/L0mpCHIy
	5TgIxpe2MPTJEtSLM/BXJCZbtiR+/R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728911529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zqarmSZKN2z2nIPNDdOcCc2rTYxaKohP7Uy1zHoY2f0=;
	b=f8YLxQaJYHtPhhrTQpBYViIIXrdvgsp7zqMU+e6rEnlnfu2ngOrQ+KDmzMTVjo1zsxK9oN
	eGytFjrqbMumSJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B26513A42;
	Mon, 14 Oct 2024 13:12:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3oR5HakYDWeOUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 14 Oct 2024 13:12:09 +0000
Message-ID: <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>
Date: Mon, 14 Oct 2024 15:12:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Kees Cook <keescook@chromium.org>
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
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
 <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC7991FE53
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.com,kernel.org,lge.com,linux.dev,gmail.com,linuxfoundation.org,arm.com,kvack.org,googlegroups.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/14/24 14:52, Feng Tang wrote:
> On Mon, Oct 14, 2024 at 10:53:32AM +0200, Vlastimil Babka wrote:
>> On 10/14/24 09:52, Feng Tang wrote:
>> > On Fri, Oct 04, 2024 at 05:52:10PM +0800, Vlastimil Babka wrote:
>> > Thanks for the suggestion!
>> > 
>> > As there were error report about the NULL slab for big kmalloc object, how
>> > about the following code for 
>> > 
>> > __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>> > {
>> > 	void *ret;
>> > 	size_t ks = 0;
>> > 	int orig_size = 0;
>> > 	struct kmem_cache *s = NULL;
>> > 
>> > 	/* Check for double-free. */
>> > 	if (likely(!ZERO_OR_NULL_PTR(p))) {
>> > 		if (!kasan_check_byte(p))
>> > 			return NULL;
>> > 
>> > 		ks = ksize(p);
>> 
>> I think this will result in __ksize() doing
>>   skip_orig_size_check(folio_slab(folio)->slab_cache, object);
>> and we don't want that?
> 
> I think that's fine. As later code will re-set the orig_size anyway.

But you also read it first.

>> > 		/* Some objects have no orig_size, like big kmalloc case */
>> > 		if (is_kfence_address(p)) {
>> > 			orig_size = kfence_ksize(p);
>> > 		} else if (virt_to_slab(p)) {
>> > 			s = virt_to_cache(p);
>> > 			orig_size = get_orig_size(s, (void *)p);

here.

>> > 		}

>> Also the checks below repeat some of the checks of ksize().
> 
> Yes, there is some redundancy, mostly the virt_to_slab() 
> 
>> So I think in __do_krealloc() we should do things manually to determine ks
>> and not call ksize(). Just not break any of the cases ksize() handles
>> (kfence, large kmalloc).
> 
> OK, originally I tried not to expose internals of __ksize(). Let me
> try this way.

ksize() makes assumptions that a user outside of slab itself is calling it.

But we (well mostly Kees) also introduced kmalloc_size_roundup() to avoid
querying ksize() for the purposes of writing beyond the original
kmalloc(size) up to the bucket size. So maybe we can also investigate if the
skip_orig_size_check() mechanism can be removed now?

Still I think __do_krealloc() should rather do its own thing and not call
ksize().

> Thanks,
> Feng
> 
>> 
>> > 
>> > 	} else {
>> > 		goto alloc_new;
>> > 	}
>> > 
>> > 	/* If the object doesn't fit, allocate a bigger one */
>> > 	if (new_size > ks)
>> > 		goto alloc_new;
>> > 
>> > 	/* Zero out spare memory. */
>> > 	if (want_init_on_alloc(flags)) {
>> > 		kasan_disable_current();
>> > 		if (orig_size && orig_size < new_size)
>> > 			memset((void *)p + orig_size, 0, new_size - orig_size);
>> > 		else
>> > 			memset((void *)p + new_size, 0, ks - new_size);
>> > 		kasan_enable_current();
>> > 	}
>> > 
>> > 	/* Setup kmalloc redzone when needed */
>> > 	if (s && slub_debug_orig_size(s) && !is_kfence_address(p)) {
>> > 		set_orig_size(s, (void *)p, new_size);
>> > 		if (s->flags & SLAB_RED_ZONE && new_size < ks)
>> > 			memset_no_sanitize_memory((void *)p + new_size,
>> > 						SLUB_RED_ACTIVE, ks - new_size);
>> > 	}
>> > 
>> > 	p = kasan_krealloc((void *)p, new_size, flags);
>> > 	return (void *)p;
>> > 
>> > alloc_new:
>> > 	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
>> > 	if (ret && p) {
>> > 		/* Disable KASAN checks as the object's redzone is accessed. */
>> > 		kasan_disable_current();
>> > 		memcpy(ret, kasan_reset_tag(p), orig_size ?: ks);
>> > 		kasan_enable_current();
>> > 	}
>> > 
>> > 	return ret;
>> > }


