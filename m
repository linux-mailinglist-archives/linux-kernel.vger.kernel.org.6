Return-Path: <linux-kernel+bounces-267450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7079411A1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BA221F24275
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6819EEA1;
	Tue, 30 Jul 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQELhS7V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pAiSiIfD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQELhS7V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pAiSiIfD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5386AEE;
	Tue, 30 Jul 2024 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341636; cv=none; b=A8rc3NPfJ3nDMkGKzo98+1/p8+VLCmjE+YUd7+kxHwfGEnn2wbX3FbJOM6YdYPbNM9fHy43D1UWtf4kQdZzuNFIrWgr683UYV3D1CgoVChbPFWZShkspNvI3Q4NnH0/9Kli9ZLw5PcijEP2Yc542ErUcFznWVwDaXZk5MJqkiyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341636; c=relaxed/simple;
	bh=1jRg2NRTSWVd96OmIZv36gokoNbld1xheExgrUbnqdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/VjyEVsYoEB3MGRxZaMj3t7jdlcuoKHtLirSZRomNNqXLUhxQPt7RCwInIV+Zy6JRn8VgTo9rmvWClOEWW2geQYgenwMUZU4qfeN8fYocJwtf8plalqlVDZEvWHVBzeu3mSrBkz3UPxQn5Sc/IjysyKZFPYNPyHI81+fHlSbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQELhS7V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pAiSiIfD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQELhS7V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pAiSiIfD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1AB1021B58;
	Tue, 30 Jul 2024 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722341632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gewwiAOFBIXgHIYvN7XPN/gKtcFdzSUlsLbeW58038k=;
	b=nQELhS7VM9k84VEeCedz18z7o+EETrYlL1210oVlQ7XP+8ww/9UD/I0hA4zOi2aIrStyKr
	fwdsI78ZYRNAVNSdGgDEoMHQRNv9oukmA3bBLcB3kB1ewjTd4zmZtvChcEvtCLa8DFFWGV
	Sqgfn9S+fCVYpER8DbbCPQmgi4+5LoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722341632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gewwiAOFBIXgHIYvN7XPN/gKtcFdzSUlsLbeW58038k=;
	b=pAiSiIfDTAA5VkfUga9ln8d+qH4wUBmsxdKruDkA6zMtkWA6FjPSiiNqSOoPlLFKZy1h8T
	orQ3NP0UT+7hxuAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nQELhS7V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pAiSiIfD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722341632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gewwiAOFBIXgHIYvN7XPN/gKtcFdzSUlsLbeW58038k=;
	b=nQELhS7VM9k84VEeCedz18z7o+EETrYlL1210oVlQ7XP+8ww/9UD/I0hA4zOi2aIrStyKr
	fwdsI78ZYRNAVNSdGgDEoMHQRNv9oukmA3bBLcB3kB1ewjTd4zmZtvChcEvtCLa8DFFWGV
	Sqgfn9S+fCVYpER8DbbCPQmgi4+5LoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722341632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gewwiAOFBIXgHIYvN7XPN/gKtcFdzSUlsLbeW58038k=;
	b=pAiSiIfDTAA5VkfUga9ln8d+qH4wUBmsxdKruDkA6zMtkWA6FjPSiiNqSOoPlLFKZy1h8T
	orQ3NP0UT+7hxuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E62A213297;
	Tue, 30 Jul 2024 12:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dfH1N//YqGZMRAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 12:13:51 +0000
Message-ID: <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz>
Date: Tue, 30 Jul 2024 14:15:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, urezki@gmail.com, hch@infradead.org, kees@kernel.org,
 ojeda@kernel.org, wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
 chandan.babu@oracle.com, christian.koenig@amd.com, maz@kernel.org,
 oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
 kasan-dev <kasan-dev@googlegroups.com>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz> <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae> <ZqhDXkFNaN_Cx11e@cassiopeiae>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <ZqhDXkFNaN_Cx11e@cassiopeiae>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1AB1021B58
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,ellerman.id.au,oracle.com,amd.com,vger.kernel.org,kvack.org,intel.com,googlegroups.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On 7/30/24 3:35 AM, Danilo Krummrich wrote:
> On Mon, Jul 29, 2024 at 09:08:16PM +0200, Danilo Krummrich wrote:
>> On Fri, Jul 26, 2024 at 10:05:47PM +0200, Danilo Krummrich wrote:
>>> On Fri, Jul 26, 2024 at 04:37:43PM +0200, Vlastimil Babka wrote:
>>>> On 7/22/24 6:29 PM, Danilo Krummrich wrote:
>>>>> Implement vrealloc() analogous to krealloc().
>>>>>
>>>>> Currently, krealloc() requires the caller to pass the size of the
>>>>> previous memory allocation, which, instead, should be self-contained.
>>>>>
>>>>> We attempt to fix this in a subsequent patch which, in order to do so,
>>>>> requires vrealloc().
>>>>>
>>>>> Besides that, we need realloc() functions for kernel allocators in Rust
>>>>> too. With `Vec` or `KVec` respectively, potentially growing (and
>>>>> shrinking) data structures are rather common.
>>>>>
>>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>>
>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>>
>>>>> --- a/mm/vmalloc.c
>>>>> +++ b/mm/vmalloc.c
>>>>> @@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>>>>>  }
>>>>>  EXPORT_SYMBOL(vzalloc_node_noprof);
>>>>>  
>>>>> +/**
>>>>> + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
>>>>> + * @p: object to reallocate memory for
>>>>> + * @size: the size to reallocate
>>>>> + * @flags: the flags for the page level allocator
>>>>> + *
>>>>> + * The contents of the object pointed to are preserved up to the lesser of the
>>>>> + * new and old size (__GFP_ZERO flag is effectively ignored).
>>>>
>>>> Well, technically not correct as we don't shrink. Get 8 pages, kvrealloc to
>>>> 4 pages, kvrealloc back to 8 and the last 4 are not zeroed. But it's not
>>>> new, kvrealloc() did the same before patch 2/2.
>>>
>>> Taking it (too) literal, it's not wrong. The contents of the object pointed to
>>> are indeed preserved up to the lesser of the new and old size. It's just that
>>> the rest may be "preserved" as well.
>>>
>>> I work on implementing shrink and grow for vrealloc(). In the meantime I think
>>> we could probably just memset() spare memory to zero.
>>
>> Probably, this was a bad idea. Even with shrinking implemented we'd need to
>> memset() potential spare memory of the last page to zero, when new_size <
>> old_size.
>>
>> Analogously, the same would be true for krealloc() buckets. That's probably not
>> worth it.

I think it could remove unexpected bad surprises with the API so why not
do it.

>> I think we should indeed just document that __GFP_ZERO doesn't work for
>> re-allocating memory and start to warn about it. As already mentioned, I think
>> we should at least gurantee that *realloc(NULL, size, flags | __GFP_ZERO) is
>> valid, i.e. WARN_ON(p && flags & __GFP_ZERO).
> 
> Maybe I spoke a bit to soon with this last paragraph. I think continuously
> gowing something with __GFP_ZERO is a legitimate use case. I just did a quick
> grep for users of krealloc() with __GFP_ZERO and found 18 matches.
> 
> So, I think, at least for now, we should instead document that __GFP_ZERO is
> only fully honored when the buffer is grown continuously (without intermediate
> shrinking) and __GFP_ZERO is supplied in every iteration.
> 
> In case I miss something here, and not even this case is safe, it looks like
> we have 18 broken users of krealloc().

+CC Feng Tang

Let's say we kmalloc(56, __GFP_ZERO), we get an object from kmalloc-64
cache. Since commit 946fa0dbf2d89 ("mm/slub: extend redzone check to
extra allocated kmalloc space than requested") and preceding commits, if
slub_debug is enabled (red zoning or user tracking), only the 56 bytes
will be zeroed. The rest will be either unknown garbage, or redzone.

Then we might e.g. krealloc(120) and get a kmalloc-128 object and 64
bytes (result of ksize()) will be copied, including the garbage/redzone.
I think it's fixable because when we do this in slub_debug, we also
store the original size in the metadata, so we could read it back and
adjust how many bytes are copied.

Then we could guarantee that if __GFP_ZERO is used consistently on
initial kmalloc() and on krealloc() and the user doesn't corrupt the
extra space themselves (which is a bug anyway that the redzoning is
supposed to catch) all will be fine.

There might be also KASAN side to this, I see poison_kmalloc_redzone()
is also redzoning the area between requested size and cache's object_size?

>>
>>>
>>> nommu would still uses krealloc() though...
>>>
>>>>
>>>> But it's also fundamentally not true for krealloc(), or kvrealloc()
>>>> switching from a kmalloc to valloc. ksize() returns the size of the kmalloc
>>>> bucket, we don't know what was the exact prior allocation size.
>>>
>>> Probably a stupid question, but can't we just zero the full bucket initially and
>>> make sure to memset() spare memory in the bucket to zero when krealloc() is
>>> called with new_size < ksize()?
>>>
>>>> Worse, we
>>>> started poisoning the padding in debug configurations, so even a
>>>> kmalloc(__GFP_ZERO) followed by krealloc(__GFP_ZERO) can give you unexpected
>>>> poison now...
>>>
>>> As in writing magics directly to the spare memory in the bucket? Which would
>>> then also be copied over to a new buffer in __do_krealloc()?
>>>
>>>>
>>>> I guess we should just document __GFP_ZERO is not honored at all for
>>>> realloc, and maybe start even warning :/ Hopefully nobody relies on that.
>>>
>>> I think it'd be great to make __GFP_ZERO work in all cases. However, if that's
>>> really not possible, I'd prefer if we could at least gurantee that
>>> *realloc(NULL, size, flags | __GFP_ZERO) is a valid call, i.e.
>>> WARN_ON(p && flags & __GFP_ZERO).
>>>
>>>>
>>>>> + *
>>>>> + * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
>>>>> + * @p is not a %NULL pointer, the object pointed to is freed.
>>>>> + *
>>>>> + * Return: pointer to the allocated memory; %NULL if @size is zero or in case of
>>>>> + *         failure
>>>>> + */
>>>>> +void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
>>>>> +{
>>>>> +	size_t old_size = 0;
>>>>> +	void *n;
>>>>> +
>>>>> +	if (!size) {
>>>>> +		vfree(p);
>>>>> +		return NULL;
>>>>> +	}
>>>>> +
>>>>> +	if (p) {
>>>>> +		struct vm_struct *vm;
>>>>> +
>>>>> +		vm = find_vm_area(p);
>>>>> +		if (unlikely(!vm)) {
>>>>> +			WARN(1, "Trying to vrealloc() nonexistent vm area (%p)\n", p);
>>>>> +			return NULL;
>>>>> +		}
>>>>> +
>>>>> +		old_size = get_vm_area_size(vm);
>>>>> +	}
>>>>> +
>>>>> +	if (size <= old_size) {
>>>>> +		/*
>>>>> +		 * TODO: Shrink the vm_area, i.e. unmap and free unused pages.
>>>>> +		 * What would be a good heuristic for when to shrink the
>>>>> +		 * vm_area?
>>>>> +		 */
>>>>> +		return (void *)p;
>>>>> +	}
>>>>> +
>>>>> +	/* TODO: Grow the vm_area, i.e. allocate and map additional pages. */
>>>>> +	n = __vmalloc_noprof(size, flags);
>>>>> +	if (!n)
>>>>> +		return NULL;
>>>>> +
>>>>> +	if (p) {
>>>>> +		memcpy(n, p, old_size);
>>>>> +		vfree(p);
>>>>> +	}
>>>>> +
>>>>> +	return n;
>>>>> +}
>>>>> +
>>>>>  #if defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA32)
>>>>>  #define GFP_VMALLOC32 (GFP_DMA32 | GFP_KERNEL)
>>>>>  #elif defined(CONFIG_64BIT) && defined(CONFIG_ZONE_DMA)
>>>>

