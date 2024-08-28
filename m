Return-Path: <linux-kernel+bounces-305385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E18B962DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8698A1F2505D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E01A3BC2;
	Wed, 28 Aug 2024 16:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwCg6cd2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b4PS8DGG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H5W3UPIq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/WvVi33q"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE9F381B1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863997; cv=none; b=atBBW3xTqqQsY5eeclo8tN30H5ZgnQLE21y/4HHzIiXMCJrgFhXnLNAmpPy/gi2Zupy5ApkuB5jyG/06gpnYwsN+v7rQIQ/rFKLDuv0WwujGv/3qIjlrd/EEMPwCayNewwwaKlr6YZgYbuJemk3eKwCMWviCpPQmCsj32xEVHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863997; c=relaxed/simple;
	bh=GilFrZLWIIjrSiOmNjH0bPECv5zLlHCWFegIe/NImF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XWqntYfgvU98BmoCTkj6BWGkjcyECitlJoduqX+PU22jACp/+Vrwky/Of6TiujhgmoS5tRaTvA+ZnRLBUOiN53ZJpzSUnAA35j4XcSEoM8K4ZDY62NNcbLnrfuZD08sBeC+ZwFqvuQsFpJNk4UwrG6t7knWEF5tnUgWS74JhSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwCg6cd2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b4PS8DGG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H5W3UPIq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/WvVi33q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD91A1FCD9;
	Wed, 28 Aug 2024 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724863993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nplJiAjwJn1ceQN8N9+I+yusbXl2GrGAVQg3C/PpJlA=;
	b=hwCg6cd2zJTj24WjwjhorHHga1+LZBjc9VskRjxGdkPQKFputXt19vDyeePuJoW3KPVnxG
	OjFG0BAMQC8dVQk1ptCYLWYDHqGYhkmqNzsNIyddxGfxJBou1olBOV0GZacLzBnpydFfkC
	EfHkkjAon+vC8FK0H2+0Tdzb+C+X094=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724863993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nplJiAjwJn1ceQN8N9+I+yusbXl2GrGAVQg3C/PpJlA=;
	b=b4PS8DGGXBYP8vvSXa9oDyAbGUA71m+dzZwhBf47Bhhe2U4lRGSHFaOXBSBeF3LhpOZGH7
	bBpGqq5LcwWjkrCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724863991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nplJiAjwJn1ceQN8N9+I+yusbXl2GrGAVQg3C/PpJlA=;
	b=H5W3UPIqSupAAuD99oTOc1AFmcMiGkhq9dDCV2sbcbia5R3j8tx5CShC7GhN9LFDVQ8EvT
	TMeBTS5CuXIweatEW1/73hl0dbCxW5ulZkOWjEsxHaIlS/VB4eI/vO+TFwqd5vMs8bQ0E3
	zHubh3NdPfOf5t/ix9/GM6vsA2kkiqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724863991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nplJiAjwJn1ceQN8N9+I+yusbXl2GrGAVQg3C/PpJlA=;
	b=/WvVi33qOWQwnrZVwOlJ5DK2Pod+UmqV8oC26+WqyTUU3Aoyxvml5fk9/LSnT9SpaeIwnN
	5vzP9WYjxcnG7mAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A99D81398F;
	Wed, 28 Aug 2024 16:53:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G265KPdVz2bNawAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 28 Aug 2024 16:53:11 +0000
Message-ID: <7c0d1d9f-f233-47a4-87fe-d01c348d7787@suse.cz>
Date: Wed, 28 Aug 2024 18:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] mm, slub: avoid zeroing kmalloc redzone
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: nicolas.bouchinet@clip-os.org, chengming.zhou@linux.dev,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
References: <20240823062415.3632189-1-peng.fan@oss.nxp.com>
 <ZsssFS68lfFR2yJU@feng-clx.sh.intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <ZsssFS68lfFR2yJU@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[clip-os.org,linux.dev,linux.com,kernel.org,google.com,lge.com,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,nxp.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,nxp.com:email,imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 8/25/24 15:05, Feng Tang wrote:
> On Fri, Aug 23, 2024 at 02:24:15PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> With commit 946fa0dbf2d8
>> ("mm/slub: extend redzone check to extra allocated kmalloc space than requested"),
>> setting orig_size treats the wasted space (object_size - orig_size) as
>> redzones. But (in check_object()) when orig_size is set to zero, the entire
>> object is perceived as a redzone. To a valid allocated kmalloc space,
>> when init_on_free=1, the wasted space and the orig_size should
>> not be cleared to 0, otherwise there will be kernel dump:

Could we make it more clear?

Since commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
kmalloc space than requested"), setting orig_size treats the wasted space
(object_size - orig_size) as a redzone. However with init_on_free=1 we clear
the full object->size, including the redzone.

Additionally we clear the object metadata, including the stored orig_size,
making it zero, which makes check_object() treat the the whole object as a
redzone.

These issues lead to the following BUG report with "slub_debug=FUZ
init_on_free=1":

>> 
>> [    0.000000] =============================================================================
>> [    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
>> [    0.000000] -----------------------------------------------------------------------------
>> [    0.000000]
>> [    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
>> [    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
>> [    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
>> [    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
>> [    0.000000]
>> [    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
>> [    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
>> [    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
>> [    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
>> [    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
>> [    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
>> [    0.000000] Call trace:
>> [    0.000000]  dump_backtrace+0x90/0xe8
>> [    0.000000]  show_stack+0x18/0x24
>> [    0.000000]  dump_stack_lvl+0x74/0x8c
>> [    0.000000]  dump_stack+0x18/0x24
>> [    0.000000]  print_trailer+0x150/0x218
>> [    0.000000]  check_object+0xe4/0x454
>> [    0.000000]  free_to_partial_list+0x2f8/0x5ec
>> 
>> To address the issue, use orig_size to clear the used area. And restore
>> the value of orig_size after clear the remaining area.
>> 
>> When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
>> s->object_size. So when using memset to init the area, the size can simply
>> be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
>> enabled. And orig_size can never be bigger than object_size.
>> 
>> Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
> 
> Thanks for the fix! I missed to test the 'init_on_free' case back then.
> 
> Reviewed-by: Feng Tang <feng.tang@intel.com>

By the way Feng, have you noticed the other issue we have, with krealloc()
and redzoning? Want to look at that? Thanks.

https://lore.kernel.org/all/44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz/


> with one small nit below
> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> 
>> RFC->V1:
>>  Update commit log (Per Hyeonggon)
>>  Use orig_size to do memset(Per Hyeonggon)
>>  Add get_orig_size and set_orig_size when CONFIG_SLUB_DEBUG not enabled(kernel test robot)
>>  https://lore.kernel.org/all/20240819064115.385086-1-peng.fan@oss.nxp.com/
>> 
>>  mm/slub.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 94f5a4143825..a5fbeb2835b1 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -1895,6 +1895,15 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
>>  static inline void dec_slabs_node(struct kmem_cache *s, int node,
>>  							int objects) {}
>>  
>> +static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
>> +{
>> +	return s->object_size;
>> +}
>> +
>> +static inline void set_orig_size(struct kmem_cache *s, void *object,
>> +				 unsigned int orig_size)
>> +{}
> 
> Current get_orig_size() and set_orig_size() are protected by
> CONFIG_SLUB_DEUG=y macro, and with this patch, they will be called
> in both ON and OFF case. Maybe we can just lift those existing
> functions out of the "#ifdef CONFIG_SLUB_DEBUG" protection?

I agree. As for the "code is larger for !CONFIG_SLUB_DEBUG" concern I think
the code will be eliminated anyway, because of the

if (!slub_debug_orig_size(s))
    return;

and slub_debug_orig_size() does kmem_cache_debug_flags() which is a
compile-time false for !CONFIG_SLUB_DEBUG.

> Thanks,
> Feng


