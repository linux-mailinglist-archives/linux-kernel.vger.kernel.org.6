Return-Path: <linux-kernel+bounces-268232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F1942203
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F782284CA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AA1189911;
	Tue, 30 Jul 2024 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/mzdPaH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jqpr76b7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K/mzdPaH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jqpr76b7"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C86238B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373620; cv=none; b=Ibh0YuSWeKnTc1kNV37qFHfr7j1YkOTPHqTUlYws1OR/7TLrZoF83DaQJ2d0JsqVfYIC39MXzjoveUsPsWz2rRmQQEyFOW8VlqjqY7UrPzpBrtMgH2TYZi6XMg76C7655rqaWOg2aqKM+SL9WmaqgJ9ICZLL9trf1Is/MYyhXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373620; c=relaxed/simple;
	bh=BVSHOTFi/7QifxnhQsRlu8quhzF39Hl89yIL3lMO/FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTRjJ+GrHqoqo1HpyQK++2YjyUsaxadIb6+XN6/x0JD078kYTShKbX8PHLIuP8c5MVyA2UZ3U1VSdboGedQkvRbyp6V+rbHycQfRheA2OBXUGaVjN8qLv9FXcvopE3AfCskuMmcoQblHdX/u08Q2qmpWJ/Bf6ymUCldisAvTvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/mzdPaH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jqpr76b7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K/mzdPaH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jqpr76b7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5487721A19;
	Tue, 30 Jul 2024 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722373616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=smX5tEVpIjxllAV42JGBizsl4IP88fKQHfu78rKR9w4=;
	b=K/mzdPaHFaE9H4p/muESdWTHyk+GGvC0gjizW0R6I7kjgZucfBBZcMc0qe+/z2awfaOrWL
	VV4PCIUUgCIfhbr3Phc266crmb5FMRG8PEJ9QEHgam/zBsA/av8x/cyZa5iovmmvFgth5P
	2i0yCxYAnL5oo6glcgJ3GvdgwkO4vdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722373616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=smX5tEVpIjxllAV42JGBizsl4IP88fKQHfu78rKR9w4=;
	b=Jqpr76b7//dXbPzhjjORI5DO0WzwDSIEYYHNQ0A8s3U+zuSmNY61ox/Tdea0gxrVf+Dm1d
	Fvtogf3iELA75CBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722373616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=smX5tEVpIjxllAV42JGBizsl4IP88fKQHfu78rKR9w4=;
	b=K/mzdPaHFaE9H4p/muESdWTHyk+GGvC0gjizW0R6I7kjgZucfBBZcMc0qe+/z2awfaOrWL
	VV4PCIUUgCIfhbr3Phc266crmb5FMRG8PEJ9QEHgam/zBsA/av8x/cyZa5iovmmvFgth5P
	2i0yCxYAnL5oo6glcgJ3GvdgwkO4vdE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722373616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=smX5tEVpIjxllAV42JGBizsl4IP88fKQHfu78rKR9w4=;
	b=Jqpr76b7//dXbPzhjjORI5DO0WzwDSIEYYHNQ0A8s3U+zuSmNY61ox/Tdea0gxrVf+Dm1d
	Fvtogf3iELA75CBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD8513983;
	Tue, 30 Jul 2024 21:06:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BGd8DvBVqWaRVwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 21:06:56 +0000
Message-ID: <9369adda-9cb9-4447-92fa-b7a70bd81fb6@suse.cz>
Date: Tue, 30 Jul 2024 23:06:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: krealloc: consider spare memory for __GFP_ZERO
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240730194214.31483-1-dakr@kernel.org>
 <20240730133111.d180e1a6fc63b2883fe99821@linux-foundation.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240730133111.d180e1a6fc63b2883fe99821@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.41 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.41

On 7/30/24 10:31 PM, Andrew Morton wrote:
> On Tue, 30 Jul 2024 21:42:05 +0200 Danilo Krummrich <dakr@kernel.org> wrote:
> 
>> As long as krealloc() is called with __GFP_ZERO consistently, starting
>> with the initial memory allocation, __GFP_ZERO should be fully honored.
>> 
>> However, if for an existing allocation krealloc() is called with a
>> decreased size, it is not ensured that the spare portion the allocation
>> is zeroed. Thus, if krealloc() is subsequently called with a larger size
>> again, __GFP_ZERO can't be fully honored, since we don't know the
>> previous size, but only the bucket size.
> 
> Well that's bad.
> 
>> Example:
>> 
>> 	buf = kzalloc(64, GFP_KERNEL);
> 
> If this was kmalloc()

Then already here we have unitialized kernel memory that a buggy user could
expose, no?

>> 	memset(buf, 0xff, 64);
>> 
>> 	buf = krealloc(buf, 48, GFP_KERNEL | __GFP_ZERO);
>> 
>> 	/* After this call the last 16 bytes are still 0xff. */
>> 	buf = krealloc(buf, 64, GFP_KERNEL | __GFP_ZERO);
> 
> then this would expose uninitialized kernel memory to kernel code, with
> a risk that the kernel code will expose that to userspace, yes?
> 
> This does seem rather a trap, and I wonder whether krealloc() should
> just zero out any such data by default.

So unless I'm missing how this differs from plain kmalloc(), relying on
want_init_on_alloc() seems the right way how to opt-in harden against this
potential exposure.

>> Fix this, by explicitly setting spare memory to zero, when shrinking an
>> allocation with __GFP_ZERO flag set or init_on_alloc enabled.
>> 
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -1273,6 +1273,13 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>  
>>  	/* If the object still fits, repoison it precisely. */
>>  	if (ks >= new_size) {
>> +		/* Zero out spare memory. */
>> +		if (want_init_on_alloc(flags)) {
>> +			kasan_disable_current();
>> +			memset((void *)p + new_size, 0, ks - new_size);
> 
> Casting away the constness of `*p'.  This is just misleading everyone,
> really.  It would be better to make argument `p' have type "void *".
> 
>> +			kasan_enable_current();
>> +		}
>> +
>>  		p = kasan_krealloc((void *)p, new_size, flags);
> 


