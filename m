Return-Path: <linux-kernel+bounces-422504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050E9D9A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64DB5B22554
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 15:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846061D61A5;
	Tue, 26 Nov 2024 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6ZbDx2i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XtWgePsm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rHgs3+NI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KIoAM/tv"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997431D47DC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732634849; cv=none; b=Edwbb1zYnCbgxB5JRtl9vPGyYjrueaF4K6FiWizI23Cph68rrHKj/d/U9WaugnM8JEp3ENSzjNi2o0sdPJe+4vJwqc3Pf2AEnuQJPoAolcz/XKOxFVsRrelF4tba7ZfPrwQC4iBDsFnSI47qTsm/ZaR6YIiAeML7DeFTWCHsDdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732634849; c=relaxed/simple;
	bh=W/DUeEbmLZMkcpi542rcgkiblMV0Id21LYPi9LfqoIs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eVqtIRC2CMWLL+YSFmm0SBlrpkrjsgX9p+TzMW5/9+GJI9NW0wjriTx7BOeH5/7cT0pmglC3XUxgdW92cCC45Wfmax0JG6eQMYxG/4IgWUkERq0LcFIkNAY8IPdwY3J/WvZMcQgIAVjkSagJF7IRztTiW0FhDbWZrhjiUtyAKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6ZbDx2i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XtWgePsm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rHgs3+NI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KIoAM/tv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 575851F750;
	Tue, 26 Nov 2024 15:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732634844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A4DgMpMQcHaicV7qzhrooFxm0LSeTCsYPO16RJiC4qg=;
	b=t6ZbDx2ibBq1e4VBUC6DyCWZ2pvireqPfUiThJvGkB5rELQfkB9SH098rSoiY3Pvg9pSVJ
	EqQdfbJp/LpIPwUl0rBHoLqUUbHHfAVOsHf9rNuPpcSVGn0JXROm5YJg/54obdiF//QJUI
	MCvgXHYBAF0URDk/dKW9w3727HiEQsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732634844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A4DgMpMQcHaicV7qzhrooFxm0LSeTCsYPO16RJiC4qg=;
	b=XtWgePsmHo7rfNDVokizDxEbzJ9droo45bx9L0YWNE8fiQWOE711bzTww5RXWH0oIrKpFP
	gIjgYJ7S3MjCS0Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rHgs3+NI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="KIoAM/tv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732634843; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A4DgMpMQcHaicV7qzhrooFxm0LSeTCsYPO16RJiC4qg=;
	b=rHgs3+NIo8CPXI2oFtvzxcAcdL8IvY1qmwfOBjbSR4uZgykFcJW5jT2qZeoeFDX7GCN0Y4
	05o8lBD8QLrceSmPQLs+Gb9WO0lH6S0+yYoWXFJ2xZnisPTpOd5WCDM9cv3FZHENFFmyIG
	nFT5TGGLIfA8nL+LsYVxJVOatzFj7Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732634843;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A4DgMpMQcHaicV7qzhrooFxm0LSeTCsYPO16RJiC4qg=;
	b=KIoAM/tvmqigLgesJpTKmgvd4GWB/gMjZ2B95kP9uqX4F2i6Pk3GbIqwZRe0GViDq/GR3z
	356jou0xnkvlQUAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41A4013890;
	Tue, 26 Nov 2024 15:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V7GdD9voRWfCDAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Nov 2024 15:27:23 +0000
Message-ID: <36577539-bff6-476e-8d6b-ca20e3de2391@suse.cz>
Date: Tue, 26 Nov 2024 16:27:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm/slab: Avoid build bug for calls to kmalloc with a
 large constant
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>,
 Dave Kleikamp <dave.kleikamp@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
 <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
 <7fb6c5a2-b9ae-4a29-a871-2f0bdc636e41@arm.com>
 <9675f4f0-6290-43aa-bf17-6b9c2b461485@suse.cz>
 <69746c3a-72af-4c28-8f04-bcfae7a78107@arm.com>
 <ba2a3841-6dbc-4920-81f9-2fc0518ec1d3@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <ba2a3841-6dbc-4920-81f9-2fc0518ec1d3@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 575851F750
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[arm.com,oracle.com,linux-foundation.org,linux.com,google.com,gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 11/26/24 16:09, Vlastimil Babka wrote:
> On 11/26/24 15:53, Ryan Roberts wrote:
>> On 26/11/2024 12:36, Vlastimil Babka wrote:
>>> On 11/26/24 13:18, Ryan Roberts wrote:
>>>> On 14/11/2024 10:09, Vlastimil Babka wrote:
>>>>> On 11/1/24 21:16, Dave Kleikamp wrote:
>>>>>> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
>>>>>> is no longer optimized out with a constant size, so a build bug may
>>>>>> occur on a path that won't be reached.
>>>>>
>>>>> That's rather unfortunate, the __builtin_constant_p(size) part of
>>>>> kmalloc_noprof() really expects things to resolve at compile time and it
>>>>> would be better to keep it that way.
>>>>>
>>>>> I think it would be better if we based KMALLOC_MAX_CACHE_SIZE itself on
>>>>> PAGE_SHIFT_MAX and kept it constant, instead of introducing
>>>>> KMALLOC_SHIFT_HIGH_MAX only for some sanity checks.
>>>>>
>>>>> So if the kernel was built to support 4k to 64k, but booted as 4k, it would
>>>>> still create and use kmalloc caches up to 128k. SLUB should handle that fine
>>>>> (if not, please report it :)
>>>>
>>>> So when PAGE_SIZE_MAX=64K and PAGE_SIZE=4K, kmalloc will support up to 128K
>>>> whereas before it only supported up to 8K. I was trying to avoid that since I
>>>> assumed that would be costly in terms of extra memory allocated for those higher
>>>> order buckets that will never be used. But I have no idea how SLUB works in
>>>> practice. Perhaps memory for the cache is only lazily allocated so we won't see
>>>> an issue in practice?
>>> 
>>> Yes the e.g. 128k slabs themselves will be lazily allocated. There will be
>>> some overhead with the management structures (struct kmem_cache etc) but
>>> much smaller.
>>> To be completely honest, some extra overhead might come to be when the slabs
>>> are allocated ans later the user frees those allocations. kmalloc_large()
>>> wwould return them immediately, while a regular kmem_cache will keep one or
>>> more per cpu for reuse. But if that becomes a visible problem we can tune
>>> those caches to discard slabs more aggressively.
>> 
>> Sorry to keep pushing on this, now that I've actually looked at the code, I feel
>> I have a slightly better understanding:
>> 
>> void *kmalloc_noprof(size_t size, gfp_t flags)
>> {
>> 	if (__builtin_constant_p(size) && size) {
>> 		
>> 		if (size > KMALLOC_MAX_CACHE_SIZE)
>> 			return __kmalloc_large_noprof(size, flags); <<< (1)
>> 
>> 		index = kmalloc_index(size);
>> 		return __kmalloc_cache_noprof(...);   <<< (2)
>> 	}
>> 	return __kmalloc_noprof(size, flags);   <<< (3)
>> }
>> 
>> So if size and KMALLOC_MAX_CACHE_SIZE are constant, we end up with this
>> resolving either to a call to (1) or (2), decided at compile time. If
>> KMALLOC_MAX_CACHE_SIZE is not constant, (1), (2) and the runtime conditional
>> need to be kept in the function.
>> 
>> But intuatively, I would have guessed that given the choice between the overhead
>> of keeping that runtime conditional vs keeping per-cpu slab caches for extra
>> sizes between 16K and 128K, then the runtime conditional would be preferable. I
>> would guess that quite a bit of memory could get tied up in those caches?
>> 
>> Why is your preference the opposite? What am I not understanding?
> 
> +CC more slab people.
> 
> So the above is an inline function, but constructed in a way that it should,
> without further inline code, become
> - a call to __kmalloc_large_noprof() for build-time constant size larger
> than KMALLOC_MAX_CACHE_SIZE
> - a call to __kmalloc_cache_noprof() for build-time constant size smaller
> than KMALLOC_MAX_CACHE_SIZE, where the cache is picked from an array with
> compile-time calculated index
> - call to __kmalloc_noprof() for non-constant sizes otherwise
> 
> If KMALLOC_MAX_CACHE_SIZE stops being build-time constant, the sensible way
> to handle it would be to #ifdef or otherwise compile out away the whole "if
> __builtin_constant_p(size)" part and just call __kmalloc_noprof() always, so
> we don't blow the inline paths with a KMALLOC_MAX_CACHE_SIZE check leading
> to choice between calling __kmalloc_large_noprof() or __kmalloc_cache_noprof().

Or maybe we could have PAGE_SIZE_MAX derived KMALLOC_MAX_CACHE_SIZE_MAX
behave as the code above currently does with KMALLOC_MAX_CACHE_SIZE, and
additionally have PAGE_SIZE_MIN derived KMALLOC_MAX_CACHE_SIZE_MIN, where
build-time-constant size larger than KMALLOC_MAX_CACHE_SIZE_MIN (which is a
compile-time test) is redirected to __kmalloc_noprof() for a run-time test.

That seems like the optimum solution :)

> I just don't believe we would waste so much memory with caches the extra
> sizes for sizes between 16K and 128K, so would do that suggestion only if
> proven wrong. But I wouldn't mind it that much if you chose it right away.
> The solution earlier in this thread to patch __kmalloc_index() would be
> worse than either of those two alternatives though.



