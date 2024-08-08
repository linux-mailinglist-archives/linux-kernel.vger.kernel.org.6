Return-Path: <linux-kernel+bounces-279042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F094B832
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF650B2344E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6E6188CD1;
	Thu,  8 Aug 2024 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4UJWgeT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cvkgefb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R4UJWgeT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1cvkgefb"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22431188002;
	Thu,  8 Aug 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103337; cv=none; b=bfxAhJuYYTm9CuLHzx0Zb4hOqH0xdnJGfJId5T2LKyo7PNcx8YxxonXH3hpkyFbi/uuO/CEfPfK49lJL1LUZp1lHR9EnL4KE65+sTByPlTJfiOFque9WvWylZVTWvRYSY5NR/UrxcOUx9A8wWATyNR6a/BI/XK0hhrkkq8Y/l1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103337; c=relaxed/simple;
	bh=VBSDN7h8+KVTV5Rf9jAemKhQj5tIorvgdAZQPir9/mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hR8X5/k04y/b+Z0fBQWOAyANbohtDd53F/BXK0kSQ9OwZ9LTDfhw0/kmrNNqYQbeIBrrPJWGXTn/lKl9pV/Bw5zrh9LaZM+kkKqQEs7Nc173CypYq9ecbc+uYdFAJjVmqzA5V6/OOSv5L4tiqg5P22JGp8a6+70K9U+518vIwp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4UJWgeT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cvkgefb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R4UJWgeT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1cvkgefb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 355F721B59;
	Thu,  8 Aug 2024 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723103333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kp3ofqiZig9WIAzOKKVizYYSlBk8WVR7ItmX48oQ08U=;
	b=R4UJWgeTrIzm5p1kBPK7/nF5FSWaXwXmrWUHPv4X/lZfJB4qmtB5cNXSpQIfjEc2mAHh0v
	Pn4J7arEjeAxvHG9lM7z5gncR7G+pxNjGqBd9lyaquk3kQV8ymDOVrJOP4JYz8LLMxurQd
	doISxZOWDP6og3JpmvfNw0PrL7Qn1Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723103333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kp3ofqiZig9WIAzOKKVizYYSlBk8WVR7ItmX48oQ08U=;
	b=1cvkgefbyEIwvDyGdWGtiI1BBD+Jmx4haFge5kuBTk1q0J2xKV0G55sPH+FigiDV5qIZTR
	CyOAeuh151gwh2Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R4UJWgeT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1cvkgefb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723103333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kp3ofqiZig9WIAzOKKVizYYSlBk8WVR7ItmX48oQ08U=;
	b=R4UJWgeTrIzm5p1kBPK7/nF5FSWaXwXmrWUHPv4X/lZfJB4qmtB5cNXSpQIfjEc2mAHh0v
	Pn4J7arEjeAxvHG9lM7z5gncR7G+pxNjGqBd9lyaquk3kQV8ymDOVrJOP4JYz8LLMxurQd
	doISxZOWDP6og3JpmvfNw0PrL7Qn1Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723103333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kp3ofqiZig9WIAzOKKVizYYSlBk8WVR7ItmX48oQ08U=;
	b=1cvkgefbyEIwvDyGdWGtiI1BBD+Jmx4haFge5kuBTk1q0J2xKV0G55sPH+FigiDV5qIZTR
	CyOAeuh151gwh2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2187B13876;
	Thu,  8 Aug 2024 07:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R07jB2V4tGb3AwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 08 Aug 2024 07:48:53 +0000
Message-ID: <7f75fc3e-dc8a-4d3f-b9b5-70f310a3d99c@suse.cz>
Date: Thu, 8 Aug 2024 09:48:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -3.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 355F721B59
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 8/8/24 03:07, Guenter Roeck wrote:
> On 8/6/24 16:24, Thomas Gleixner wrote:
>> Cc+: Helge, parisc ML
>> 
>> We're chasing a weird failure which has been tracked down to the
>> placement of the division library functions (I assume they are imported
>> from libgcc).
>> 
>> See the thread starting at:
>> 
>>    https://lore.kernel.org/all/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net
>> 
>> On Tue, Aug 06 2024 at 21:25, Vlastimil Babka wrote:
>>> On 8/6/24 19:33, Thomas Gleixner wrote:
>>>>
>>>> So this change adds 16 bytes to __softirq() which moves the division
>>>> functions up by 16 bytes. That's all it takes to make the stupid go
>>>> away....
>>>
>>> Heh I was actually wondering if the division is somhow messed up because
>>> maxobj = order_objects() and order_objects() does a division. Now I suspect
>>> it even more.
>> 
>> check_slab() calls into that muck, but I checked the disassembly of a
>> working and a broken kernel and the only difference there is the
>> displacement offset when the code calculates the call address, but
>> that's as expected a difference of 16 bytes.
>> 
>> Now it becomes interesting.
>> 
>> I added a unused function after __do_softirq() into the softirq text
>> section and filled it with ASM nonsense so that it occupies exactly one
>> page. That moves $$divoI, which is what check_slab() calls, exactly one
>> page forward:
>> 
> 
> With the above added to my tree, I can also play around with the code.
> Here is the next weird one:
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 4927edec6a8c..b8a33966d858 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1385,6 +1385,9 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
>          }
> 
>          maxobj = order_objects(slab_order(slab), s->size);
> +
> +       pr_info_once("##### slab->objects=%u maxobj=%u\n", slab->objects, maxobj);
> +
>          if (slab->objects > maxobj) {
>                  slab_err(s, slab, "objects %u > max %u",
>                          slab->objects, maxobj);
> 
> results in:
> 
> ##### slab->objects=21 maxobj=21
> =============================================================================
> BUG kmem_cache_node (Not tainted): objects 21 > max 16

But is this printed from the same attempt? The pr_info_once() might have
printed earlier and then stopped (as it's _once) and the error case might
have happened only later, and there was nothing printed in between as the
kmalloc caches are created in a loop.

> As Thomas noticed, this only happens if the divide assembler code is within a certain
> address range.
> 
> Ok, now I am really lost.
> 
> Guenter
> 


