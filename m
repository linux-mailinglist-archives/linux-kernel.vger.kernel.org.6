Return-Path: <linux-kernel+bounces-276774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD47949835
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C34283146
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F67C13F435;
	Tue,  6 Aug 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3N+kqFy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Otv343aG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3N+kqFy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Otv343aG"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2D7143C46
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972324; cv=none; b=fQldvQ56nbwNYO96OMStax4C6fEl/MYXvPnzFjVvI4iq+zvhAMzZA9oCg3+j5mQvwN2YQvNOZWuNrcOmIVWknmAsN+WhV2na+4h69dCGuHFOqDTGySNcB8YkVz+Rj4F0Zx38+2nXGaKgC47DRUVARD/kEt0epUuapDYF1wh2ygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972324; c=relaxed/simple;
	bh=nKZFVihKqTm84RdaH0Eo9AY48ZY/m0h6MBMKVCPWFVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKU/cDfJ3ge/MkxPMedAfgwsZfCEwHomA8B7J1+pjssBswXACIfcVM08isCWdeXm/2VSRO/MGGaTuKoDp6OwjuDtlhHOGC9dqO0l5LrTPwpmcWHknRAK374UPVPD366K3Vl8bjVD5eQN04a5PtfzPzcIdeBV3qXSAG3g8vsBMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3N+kqFy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Otv343aG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3N+kqFy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Otv343aG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B382521C63;
	Tue,  6 Aug 2024 19:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722972319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erff64m2PYhhEZewy1Xpr955U24XBaDBGE3Nuyfc/FA=;
	b=v3N+kqFyx5iG3H3dlEJCNs+824Mtg7ZbeKDyIW27nRN+6dSrqLkYpLBN5I+dg2b3vuIjML
	w1BjYQyJCToyxAOoPSW6XbdRst40IGc7sgsNMGI/ZE7v3nnjSzp9tYKzQSOhYewJNwFH8p
	ZNgrGaVtveBoIm+LORAh29Q4Zqar3iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722972319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erff64m2PYhhEZewy1Xpr955U24XBaDBGE3Nuyfc/FA=;
	b=Otv343aGwrINwUL54VSKo9Izk4dH6K8CCS4IpOIS5SGh1kPzQ4yzX62lp5Kjs89FwpUf9R
	BYAS3g3zbW1bzPDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v3N+kqFy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Otv343aG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722972319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erff64m2PYhhEZewy1Xpr955U24XBaDBGE3Nuyfc/FA=;
	b=v3N+kqFyx5iG3H3dlEJCNs+824Mtg7ZbeKDyIW27nRN+6dSrqLkYpLBN5I+dg2b3vuIjML
	w1BjYQyJCToyxAOoPSW6XbdRst40IGc7sgsNMGI/ZE7v3nnjSzp9tYKzQSOhYewJNwFH8p
	ZNgrGaVtveBoIm+LORAh29Q4Zqar3iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722972319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=erff64m2PYhhEZewy1Xpr955U24XBaDBGE3Nuyfc/FA=;
	b=Otv343aGwrINwUL54VSKo9Izk4dH6K8CCS4IpOIS5SGh1kPzQ4yzX62lp5Kjs89FwpUf9R
	BYAS3g3zbW1bzPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A326913929;
	Tue,  6 Aug 2024 19:25:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3YOEJ594smZGLwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 Aug 2024 19:25:19 +0000
Message-ID: <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz>
Date: Tue, 6 Aug 2024 21:25:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <87le194kuq.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B382521C63
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On 8/6/24 19:33, Thomas Gleixner wrote:
> On Tue, Aug 06 2024 at 13:02, Vlastimil Babka wrote:
>> On 8/6/24 04:40, Linus Torvalds wrote:
>> It looks like maxobj calculation is bogus, would be useful to see what values it
>> calculates from. I'm attaching a diff, but maybe it will also hide the issue...
> 
> It does hide it :(
> 
>> If someone has a /proc/slabinfo from a working boot with otherwise same config
>> it might be also enough to guess what values should be expected there,
>> at least the s-size.
>>
>> objects=21 vs 25 also seem odd though
>>
>> used=5 with used=6 in the first two also suggests we already passed this code
>> successfully for creating a number of kmalloc caches and only then it started
>> failing, that's also weird.
> 
> I added a printk() to check_slab() and on the non-failing boot this
> looks like:
> 
> [    0.000000] c 000000004017b0f8 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 2
> [    0.000000] c 000000004017b1c8 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 1
> [    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 2
> [    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 3
> [    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 3
> [    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 4
> [    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 4
> [    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 5
> [    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 5
> [    0.000000] c 0000000043402010 c 0000000041ed0080 objects 25 max 25 order 1 size 320, inuse 6
> [    0.000000] c 0000000043402150 c 0000000041ed0000 objects 21 max 21 order 0 size 192, inuse 6
> 
> I did some more experiments to figure out why adding or removing text
> cures it. The minimal change which makes it boot again is:
> 
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
> +	current->flags &= ~PF_MEMALLOC;
>  	handle_softirqs(false);
>  }
> 
> That results in the following System.map delta:
> 
> --- ../upstream.txt	2024-08-06 16:52:49.746528992 +0200
> +++ ../build-misc/System.map	2024-08-06 19:02:32.652201977 +0200
> @@ -47600,15 +47600,15 @@
>  0000000041218c30 T __do_softirq
>  0000000041218c30 T __irqentry_text_end
>  0000000041218c30 T __softirqentry_text_start
> -0000000041218c70 T $$divoI
> -0000000041218c70 T __softirqentry_text_end
> -00000000412190d0 T $$divI_2
> -00000000412190d0 T $$divide_by_constant
> -00000000412190e0 T $$divI_4
> -00000000412190f0 T $$divI_8
> -0000000041219100 T $$divI_16
> -00000000412192d8 T $$divI_17
> -000000004121930c T $$divU_17
> +0000000041218c80 T $$divoI
> +0000000041218c80 T __softirqentry_text_end
> +00000000412190e0 T $$divI_2
> +00000000412190e0 T $$divide_by_constant
> +00000000412190f0 T $$divI_4
> +0000000041219100 T $$divI_8
> +0000000041219110 T $$divI_16
> +00000000412192e8 T $$divI_17
> +000000004121931c T $$divU_17
>  000000004121a000 D __start_opd
>  000000004121a000 D _etext
>  000000004121a000 D _sdata
> 
> So this change adds 16 bytes to __softirq() which moves the division
> functions up by 16 bytes. That's all it takes to make the stupid go
> away....

Heh I was actually wondering if the division is somhow messed up because
maxobj = order_objects() and order_objects() does a division. Now I suspect
it even more.

> I wonder whether this is some qemu stupid.
> 
> Thanks,
> 
>         tglx


