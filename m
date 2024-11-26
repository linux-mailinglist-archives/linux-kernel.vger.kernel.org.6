Return-Path: <linux-kernel+bounces-422300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA86B9D9753
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337BCB23481
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A1B1CD219;
	Tue, 26 Nov 2024 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="boLqMRJr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e4ozsGO8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="boLqMRJr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e4ozsGO8"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CA27442
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732624594; cv=none; b=cCsfJCrL4pDu27eSp3nQQg5M7q1wjUUQvMC8Jr5AgG46ci/L1dAHIX3PCXWbirWQHXY6QqPYaLN/PqiJiZQqTEySMcR6k2EUmN4bBrmR9duZqT4DpbEhNa4iej+SURntnh/jpfl+UFgh/PpFqQn/lSG8aKVG39TcvwI7Y3kxqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732624594; c=relaxed/simple;
	bh=OKFFgcgAl5OVf1q5k7xhiCwTAAYuICWI5z9APUqyB4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuqCCKKep9JIHZzy89PHeh5LFvdEWHBK2dP35VfW0GquaDUquxG1M2zmcbgktnW5gPFzqbyOPSt9U8Lkt1FFZtSlNyIIbGi5/4RIS6cEANGqZZyM+zXohvY/rd5yak1uDzFLclwP4n+bwqyv/OxTiSGT9kI585QIuPYUv5wzJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=boLqMRJr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e4ozsGO8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=boLqMRJr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e4ozsGO8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 782FD1F745;
	Tue, 26 Nov 2024 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BLEya6E7ELTfrUjipQUSn0lt0twW9YOZE0Q8PEW1SaA=;
	b=boLqMRJramn1CbtheRx/PGZ4+1U8P3ymVkqWk67uVmWQWCdUuGMaVhHBxXv0h6ADF7RF2f
	+ZsB4wLi/zpIHc2/xblO+YQgef6HPAaGqdCVeAWEaK4orFiPmS1Xiplxj0RZTNB6B3kzgg
	Ek6ZcwMJUQCDXYUOZdxbHi6lzmIYDEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BLEya6E7ELTfrUjipQUSn0lt0twW9YOZE0Q8PEW1SaA=;
	b=e4ozsGO8mMsBC5/830LFdI/VFGFhoUvUNeUayLlZI9nMqNJabMhNpO/g4DotpOyncszB0i
	U6w6o0QdSOEK/CBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732624590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BLEya6E7ELTfrUjipQUSn0lt0twW9YOZE0Q8PEW1SaA=;
	b=boLqMRJramn1CbtheRx/PGZ4+1U8P3ymVkqWk67uVmWQWCdUuGMaVhHBxXv0h6ADF7RF2f
	+ZsB4wLi/zpIHc2/xblO+YQgef6HPAaGqdCVeAWEaK4orFiPmS1Xiplxj0RZTNB6B3kzgg
	Ek6ZcwMJUQCDXYUOZdxbHi6lzmIYDEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732624590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BLEya6E7ELTfrUjipQUSn0lt0twW9YOZE0Q8PEW1SaA=;
	b=e4ozsGO8mMsBC5/830LFdI/VFGFhoUvUNeUayLlZI9nMqNJabMhNpO/g4DotpOyncszB0i
	U6w6o0QdSOEK/CBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 669D2139AA;
	Tue, 26 Nov 2024 12:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cyuyGM7ARWeWUQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 26 Nov 2024 12:36:30 +0000
Message-ID: <9675f4f0-6290-43aa-bf17-6b9c2b461485@suse.cz>
Date: Tue, 26 Nov 2024 13:36:30 +0100
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
To: Ryan Roberts <ryan.roberts@arm.com>,
 Dave Kleikamp <dave.kleikamp@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-6-ryan.roberts@arm.com>
 <44312f4a-8b9c-49ce-9277-5873a94ca1bb@oracle.com>
 <cb9cabed-0038-42b3-b9fc-c9ba62b12781@suse.cz>
 <7fb6c5a2-b9ae-4a29-a871-2f0bdc636e41@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <7fb6c5a2-b9ae-4a29-a871-2f0bdc636e41@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/26/24 13:18, Ryan Roberts wrote:
> On 14/11/2024 10:09, Vlastimil Babka wrote:
>> On 11/1/24 21:16, Dave Kleikamp wrote:
>>> When boot-time page size is enabled, the test against KMALLOC_MAX_CACHE_SIZE
>>> is no longer optimized out with a constant size, so a build bug may
>>> occur on a path that won't be reached.
>> 
>> That's rather unfortunate, the __builtin_constant_p(size) part of
>> kmalloc_noprof() really expects things to resolve at compile time and it
>> would be better to keep it that way.
>> 
>> I think it would be better if we based KMALLOC_MAX_CACHE_SIZE itself on
>> PAGE_SHIFT_MAX and kept it constant, instead of introducing
>> KMALLOC_SHIFT_HIGH_MAX only for some sanity checks.
>> 
>> So if the kernel was built to support 4k to 64k, but booted as 4k, it would
>> still create and use kmalloc caches up to 128k. SLUB should handle that fine
>> (if not, please report it :)
> 
> So when PAGE_SIZE_MAX=64K and PAGE_SIZE=4K, kmalloc will support up to 128K
> whereas before it only supported up to 8K. I was trying to avoid that since I
> assumed that would be costly in terms of extra memory allocated for those higher
> order buckets that will never be used. But I have no idea how SLUB works in
> practice. Perhaps memory for the cache is only lazily allocated so we won't see
> an issue in practice?

Yes the e.g. 128k slabs themselves will be lazily allocated. There will be
some overhead with the management structures (struct kmem_cache etc) but
much smaller.
To be completely honest, some extra overhead might come to be when the slabs
are allocated ans later the user frees those allocations. kmalloc_large()
wwould return them immediately, while a regular kmem_cache will keep one or
more per cpu for reuse. But if that becomes a visible problem we can tune
those caches to discard slabs more aggressively.

> I'm happy to make this change if you're certain it's the right approach; please
> confirm.

Yes it's much better option than breaking the build-time-constant part of
kmalloc_noprof().

>> 
>> Maybe we could also stop adding + 1 to PAGE_SHIFT_MAX if it's >=64k, so the
>> cache size is max 64k and not 128k but that should be probably evaluated
>> separately from this series.
> 
> I'm inferring from this that perhaps there is a memory cost with having the
> higher orders defined but unused.

Yeah as per above, should not be too large and we could tune it down if
necessary.

> Thanks,
> Ryan
> 
>> 
>> Vlastimil
>> 
>>> Found compiling drivers/net/ethernet/qlogic/qed/qed_sriov.c
>>>
>>> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>>> ---
>>>
>>> Ryan,
>>>
>>> Please consider incorporating this fix or something similar into your
>>> mm patch in the boot-time pages size patches.
>>>
>>>   include/linux/slab.h | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>>> index 9848296ca6ba..a4c7507ab8ec 100644
>>> --- a/include/linux/slab.h
>>> +++ b/include/linux/slab.h
>>> @@ -685,7 +685,8 @@ static __always_inline unsigned int __kmalloc_index(size_t size,
>>>   	if (size <= 1024 * 1024) return 20;
>>>   	if (size <=  2 * 1024 * 1024) return 21;
>>>   
>>> -	if (!IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>>> +	if (!IS_ENABLED(CONFIG_ARM64_BOOT_TIME_PAGE_SIZE) &&
>>> +	    !IS_ENABLED(CONFIG_PROFILE_ALL_BRANCHES) && size_is_constant)
>>>   		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
>>>   	else
>>>   		BUG();
>> 
> 


