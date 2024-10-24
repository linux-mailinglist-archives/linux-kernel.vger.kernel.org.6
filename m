Return-Path: <linux-kernel+bounces-379705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DDD9AE272
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8FE2848CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509EC1C07EB;
	Thu, 24 Oct 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1sHTJhXr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g+FX7HKc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1sHTJhXr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g+FX7HKc"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F961C07CD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765436; cv=none; b=Ty1EzxOhN0IXA0NEGMotroAyF0iLNVM/vQqlftc2hSCWCUsPx2TB7kv4Joo4TMT/TbFkjW7pgQDBdUfzYTIOmiN7tN4IZA4huSphfl/rkXWBD/FYCxoGARr7XxxW5Ih/ITKpowWZ8cf16Hwq1nwg41UzbEp4gKJm8eTlcGd7/J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765436; c=relaxed/simple;
	bh=K9+PVgJ4QLzQTNJ7284HGN6FKpDzsZiLxAx03A0sbMg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=s0w4cpBIFAoDBXIU5KLl5fMocprdA+UprF/BS0DaFa4kNDcoX+lZrYaGVqjP2rP9OrsZpuY4KgyJ9wnm75zfSdPjqIxUY8Nb5y32BG0voOXl/MTGVrNMtMtqzuP9RO0CYHMLNKJlI73XL1uGY2aSdIC1gZVm+juo5QghtNu3Pp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1sHTJhXr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g+FX7HKc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1sHTJhXr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g+FX7HKc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 605B11FB40;
	Thu, 24 Oct 2024 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729765428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6FLhILfbPiEBCiN9SHFKWQURQTQMt2eKXUD1yQfLPFE=;
	b=1sHTJhXrIPDG+Q1OIDpDAY5cw7NThmx2HKTb+6NefKUpz46N0Fm0mYz0g6N4wk3aF/mXLe
	p/WfJ+WvbBJx3GQ6SYzBi2rBNoHHzxd9jcpx8h0siDBBIViWKOJOIO2zFj8vk/orn7xHCO
	ueN7yYfM4bE3sjAscvJT/Y9Oum8ixTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729765428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6FLhILfbPiEBCiN9SHFKWQURQTQMt2eKXUD1yQfLPFE=;
	b=g+FX7HKc4q8AVWs9Ab5wSVx8jUs/LfhRNu1WQL/ICf0qFHx0FYmFPbNdeHP3qBNuzBxoLe
	asOoHvssO3lnlTBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1sHTJhXr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g+FX7HKc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729765428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6FLhILfbPiEBCiN9SHFKWQURQTQMt2eKXUD1yQfLPFE=;
	b=1sHTJhXrIPDG+Q1OIDpDAY5cw7NThmx2HKTb+6NefKUpz46N0Fm0mYz0g6N4wk3aF/mXLe
	p/WfJ+WvbBJx3GQ6SYzBi2rBNoHHzxd9jcpx8h0siDBBIViWKOJOIO2zFj8vk/orn7xHCO
	ueN7yYfM4bE3sjAscvJT/Y9Oum8ixTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729765428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6FLhILfbPiEBCiN9SHFKWQURQTQMt2eKXUD1yQfLPFE=;
	b=g+FX7HKc4q8AVWs9Ab5wSVx8jUs/LfhRNu1WQL/ICf0qFHx0FYmFPbNdeHP3qBNuzBxoLe
	asOoHvssO3lnlTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 466B6136F5;
	Thu, 24 Oct 2024 10:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yK50EDQgGmdhXAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 24 Oct 2024 10:23:48 +0000
Message-ID: <ce35b58e-f18c-4701-8494-fa8d1f6e5148@suse.cz>
Date: Thu, 24 Oct 2024 12:23:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: darktable performance regression on AMD systems caused by "mm:
 align larger anonymous mappings on THP boundaries"
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Rik van Riel <riel@surriel.com>
Cc: Matthias <matthias@bodenbinder.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Yang Shi <yang@os.amperecomputing.com>, Petr Tesarik <ptesarik@suse.com>
References: <2050f0d4-57b0-481d-bab8-05e8d48fed0c@leemhuis.info>
 <f81ef5bd-e930-4982-a5a8-cd4aca272912@suse.cz>
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
In-Reply-To: <f81ef5bd-e930-4982-a5a8-cd4aca272912@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 605B11FB40
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/24/24 11:58, Vlastimil Babka wrote:
> On 10/24/24 09:45, Thorsten Leemhuis wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker.
>> 
>> Rik, I noticed a report about a regression in bugzilla.kernel.org that
>> appears to be caused by the following change of yours:
>> 
>> efa7df3e3bb5da ("mm: align larger anonymous mappings on THP boundaries")
>> [v6.7]
>> 
>> It might be one of those "some things got faster, a few things became
>> slower" situations. Not sure. Felt odd that the reporter was able to
>> reproduce it on two AMD systems, but not on a Intel system. Maybe there
>> is a bug somewhere else that was exposed by this.
> 
> It seems very similar to what we've seen with spec benchmarks such as cactus
> and bisected to the same commit:
> 
> https://bugzilla.suse.com/show_bug.cgi?id=1229012
> 
> The exact regression varies per system. Intel regresses too but relatively
> less. The theory is that there are many large-ish allocations that don't
> have individual sizes aligned to 2MB and would have been merged, commit
> efa7df3e3bb5da causes them to become separate areas where each aligns its
> start at 2MB boundary and there are gaps between. This (gaps and vma
> fragmentation) itself is not great, but most of the problem seemed to be
> from the start alignment, which togethter with the access pattern causes
> more TLB or cache missess due to limited associtativity.
> 
> So maybe darktable has a similar problem. A simple candidate fix could
> change commit efa7df3e3bb5da so that the mapping size has to be a multiple
> of THP size (2MB) in order to become aligned, right now it's enough if it's
> THP sized or larger.

Maybe this could be enough to fix the issue? (on 6.12-rc4)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9c0fb43064b5..a5297cfb1dfc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -900,7 +900,8 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
-	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)
+		   && IS_ALIGNED(len, PMD_SIZE)) {
 		/* Ensures that larger anonymous mappings are THP aligned. */
 		addr = thp_get_unmapped_area_vmflags(file, addr, len,
 						     pgoff, flags, vm_flags);


