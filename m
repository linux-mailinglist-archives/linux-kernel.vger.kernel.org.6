Return-Path: <linux-kernel+bounces-404206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8AA9C40CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC892B2269C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6216519F461;
	Mon, 11 Nov 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSivWRvG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTcrkz3T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iSivWRvG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RTcrkz3T"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E07419F40A;
	Mon, 11 Nov 2024 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334980; cv=none; b=cwHz0wnjQIdLbMJ7mkURRfcM8zjQ9sp6ATmFh10K/+mvhdobo5br/YZ5/XPGtISOHsqpB5tUx6yLS30FCt1B/ukHE/7J5ZOjDyFMTpyGYc7VWUiuO14YoBDwjBulsvX0av3kuM2UcG8Gu0Z+iuvGysr7o+oq/HqaszshGx46Oq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334980; c=relaxed/simple;
	bh=jkmx01FPidqvXCxiFNOh5MQi5I4qha5aRUZgQmYFg3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0DjmVaSlVHy0hjvITi5nMbtC2eyzoCgLGWtOEaTSdupILiHyro7CeBhJNY78yATRfowIiyW1iBi0BvurO5yUNk3j2pU0KqRdchW+72+xS75T+PqyIRe2e7egylVZ24GODhRzGGVA4qzBOof3o/n+umtfFnLuivAlz6oRPqoPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSivWRvG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTcrkz3T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iSivWRvG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RTcrkz3T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F15A2197F;
	Mon, 11 Nov 2024 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731334976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ylqRczdtPk6FBk0ATcE9oLq4cfq/CJi8fE0TC6Molow=;
	b=iSivWRvGAdPQQrNW9ZzBPEszT0gBicVI7rxmq078gcziTcL/JzPqr3g6MHoyIn0k1kR4qA
	3HVaX8W1P/0eeNnpSGIHxe7TCjCsf2chGDfL3AXRFhECoA3lFiU94zPEeHRhfgAiW8883z
	OGyQ/2ccFnu8lz3OutdqIVXzjVSazqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731334976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ylqRczdtPk6FBk0ATcE9oLq4cfq/CJi8fE0TC6Molow=;
	b=RTcrkz3Tq6dgPYbq9UYZyx9VzGGDq0bKrcL2Q5g3tiu4pkaxfUXhagLpgP0/gfzlmLoEwD
	xDEcXO1TtSO6gwBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731334976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ylqRczdtPk6FBk0ATcE9oLq4cfq/CJi8fE0TC6Molow=;
	b=iSivWRvGAdPQQrNW9ZzBPEszT0gBicVI7rxmq078gcziTcL/JzPqr3g6MHoyIn0k1kR4qA
	3HVaX8W1P/0eeNnpSGIHxe7TCjCsf2chGDfL3AXRFhECoA3lFiU94zPEeHRhfgAiW8883z
	OGyQ/2ccFnu8lz3OutdqIVXzjVSazqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731334976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ylqRczdtPk6FBk0ATcE9oLq4cfq/CJi8fE0TC6Molow=;
	b=RTcrkz3Tq6dgPYbq9UYZyx9VzGGDq0bKrcL2Q5g3tiu4pkaxfUXhagLpgP0/gfzlmLoEwD
	xDEcXO1TtSO6gwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EDD613A17;
	Mon, 11 Nov 2024 14:22:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMteIkATMmfXZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 11 Nov 2024 14:22:56 +0000
Message-ID: <52f12d95-f8f2-4c18-9aa9-2e55768e0a94@suse.cz>
Date: Mon, 11 Nov 2024 15:22:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-50219: mm/page_alloc: let GFP_ATOMIC order-0 allocs
 access highatomic reserves
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 linux-cve-announce@vger.kernel.org, Matt Fleming <mfleming@cloudflare.com>
References: <2024110925-CVE-2024-50219-c970@gregkh>
 <f6e053b5-982d-472b-9c75-95d7f390bd68@suse.cz>
 <2024111147-spur-stooge-c0b0@gregkh>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <2024111147-spur-stooge-c0b0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 

On 11/11/24 15:04, Greg Kroah-Hartman wrote:
> On Mon, Nov 11, 2024 at 11:40:49AM +0100, Vlastimil Babka wrote:
>> On 11/9/24 11:15, Greg Kroah-Hartman wrote:
>> > Description
>> > ===========
>> > 
>> > In the Linux kernel, the following vulnerability has been resolved:
>> > 
>> > mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves
>> > 
>> > Under memory pressure it's possible for GFP_ATOMIC order-0 allocations to
>> > fail even though free pages are available in the highatomic reserves. 
>> > GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
>> > since it's only run from reclaim.
>> > 
>> > Given that such allocations will pass the watermarks in
>> > __zone_watermark_unusable_free(), it makes sense to fallback to highatomic
>> > reserves the same way that ALLOC_OOM can.
>> > 
>> > This fixes order-0 page allocation failures observed on Cloudflare's fleet
>> > when handling network packets:
>> 
>> Hi,
>> 
>> I would like to dispute the CVE. GFP_ATOMIC page allocations failures can
>> generally happen (typically from network receive path, like here) and should
>> always have a fallback. The impact could be somewhat worse performance at
>> worst. AFAIK they are not affected by panic_on_warn nor panic_on_oom either,
>> it's a pr_warn(), so I don't think there's a DoS vector.
> 
> I read this as "there was a failure, with no fallback", but in looking
> at the traceback:
> 
>> >   kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
>> >   nodemask=(null),cpuset=/,mems_allowed=0-7
>> >   CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
>> >   Hardware name: MACHINE
>> >   Call Trace:
>> >    <IRQ>
>> >    dump_stack_lvl+0x3c/0x50
>> >    warn_alloc+0x13a/0x1c0
>> >    __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
>> >    __alloc_pages+0x327/0x340
>> >    __napi_alloc_skb+0x16d/0x1f0
> 
> This function DOES have a fallback if this failed, so it's ok here.
> Many other ATOMIC allocations in the kernel do not have fallbacks, which
> would cause a crash.

That would make them buggy and those should either use __GFP_NOFAIL or
handle the failure gracefully.

> Note, it is setting the NOWARN flag, so shouldn't this not be warning?

Hmm seems it does now, but AFAICS it's since 6e9b01909a81 ("net: remove
gfp_mask from napi_alloc_skb()") (since v6.10?) but the report above was
from 6.6.
Wasn't aware they decided to silence the warnings, I thought it was
intentional to make the admin aware they might need to increase the atomic
memory reserves for better performance (it's not trivial to tune AFAIK,
depends on bursty arrivals of packets etc). Also if there's a suboptimal
behavior in the implementation like the one commit fixed, it won't be so
easy to spot it anymore. On the other hand, less need to explain the
occasional warning :)

> Anyway, you are right, I'll go reject this one, thanks for the review!

Thanks!
Vlastimil

> 
> thanks,
> 
> greg k-h


