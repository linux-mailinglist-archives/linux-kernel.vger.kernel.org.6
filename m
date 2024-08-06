Return-Path: <linux-kernel+bounces-276021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3CF948D64
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4359284567
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247221C2317;
	Tue,  6 Aug 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dafgAsjI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaR+tEPi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EHe7Ttnm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kw9g0X29"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD3143C4B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722942170; cv=none; b=USW4kPmVCVlyJX5ay4C7i67aMcQtvaSkvhXh2QGchUlfd2hJJTmKrsZ63imJdSIimv06RsgKa9HlA5J3d8AWhpFcTvHHHNB0txee+H90Ud/choB7VtraJ5KdrbFu76K6BVpq5IsO+ebyPOkWf8X2aEqKglf494Y15dhHkthwjKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722942170; c=relaxed/simple;
	bh=eojuUNyg8r6KuRjisoJu0mJSz662BzSdzu0PJLyeQIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZX9E9a5SsbpXCuNMJfl1tkx+ZuUPgNH0O02rqh6jZyD0x0PLa4Da35vQDR7ED89KW9LMTNU82K/Uho/Pd6Hcbl1BXVyNaEWFpCtBlC8Eeb33benZk/q4sMW/w3aNALbVulvi2nNGRCFPP1O9Kz0VsYXggmF60oWRQmR5/kTZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dafgAsjI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaR+tEPi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EHe7Ttnm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kw9g0X29; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2ACB21B66;
	Tue,  6 Aug 2024 11:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722942166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yMCXfwsD69mi8EaHLN1W8uTi3azOp475jm7XAaTLgJU=;
	b=dafgAsjIPVW4fEsg9Ao3huPn3114MBGHFEb4/+v/XKwba3tJhXhz1RQeLagPCaIII44YLH
	1hdAZnGUL7QDXygZGYkhOHmCVYzpj2iu+xXp6KaLtIuY4jX79AGl8v2L5ILd+rro3JgngP
	PHQvz0WTH9ceMU1vMz4KPYBMw2PxY1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722942166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yMCXfwsD69mi8EaHLN1W8uTi3azOp475jm7XAaTLgJU=;
	b=eaR+tEPiYw6PLhXgIYHUuZ+CIqiD1tI8iLBrh3104ilFZBTZ8BVhqupSkz2dA5xFqv4tKi
	lYK/APMVsWMmcCBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EHe7Ttnm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kw9g0X29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722942165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yMCXfwsD69mi8EaHLN1W8uTi3azOp475jm7XAaTLgJU=;
	b=EHe7TtnmOGbpbRZrlQ12sZzb81Ozm+OVcyc7T0nTQAJ+p6W/mpoQSAEj2uWcvUSy1MkXZN
	+m7RxAPicfkapq+cXEsmLva7mjw7wLjoPn8e4bEOCyXwL+OfNjiScmgu2kxa1gIoB3PnqZ
	uQWVQiyY75kJxAiMpJtRKX9TKuXYbqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722942165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yMCXfwsD69mi8EaHLN1W8uTi3azOp475jm7XAaTLgJU=;
	b=kw9g0X29zWnroPTIC+DfVdT6MYAtB+KgQo9jflwBc5zITL5NYm2md7KhJMGNtDAcfD4jlY
	fqadX/UZBprzabCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1D1713770;
	Tue,  6 Aug 2024 11:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RCX4LtUCsmYvHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 Aug 2024 11:02:45 +0000
Message-ID: <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
Date: Tue, 6 Aug 2024 13:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: D2ACB21B66

On 8/6/24 04:40, Linus Torvalds wrote:
> [ Let's drop random people and bring in Vlastimil ]

tglx was reproducing it so I add him back

> Vlastimil,
>  it turns out that the "this patch" is entirely a red herring, and the
> problem comes and goes randomly with just some code layout issues. See
> 
>    http://server.roeck-us.net/qemu/parisc64-6.10.3/
> 
> for more detail, particularly you'll see the "log.bad.gz" with the full log.

[    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
[    0.000000] Slab 0x0000000041ed0000 objects=21 used=5 fp=0x00000000434003d0 flags=0x200(workingset|section=0|zone=0)

flags tell us this came from the partial list (workingset), there's no head flag so order-0

since the error was detected it basically throws the slab page away and tries another one

[    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
[    0.000000] Slab 0x0000000041ed0080 objects=25 used=6 fp=0x0000000043402790 flags=0x240(workingset|head|section=0|zone=0)

this was also from the partial list but head flag so at least order-1, two things are weird:
- max=16 is same as above even though it should be at least double as
slab page's order is larger
- objects=25 also isn't at least twice than objects=21

All the following are:
[    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
[    0.000000] Slab 0x0000000041ed0300 objects=25 used=1 fp=0x000000004340c150 flags=0x40(head|section=0|zone=0)

we depleted the partial list so it's allocating new slab pages, that are
also at least order-1

It looks like maxobj calculation is bogus, would be useful to see what values it
calculates from. I'm attaching a diff, but maybe it will also hide the issue...

If someone has a /proc/slabinfo from a working boot with otherwise same config
it might be also enough to guess what values should be expected there,
at least the s-size.

objects=21 vs 25 also seem odd though

used=5 with used=6 in the first two also suggests we already passed this code
successfully for creating a number of kmalloc caches and only then it started
failing, that's also weird.

> See also
> 
>    https://lore.kernel.org/all/87y15a4p4h.ffs@tglx/
> 
> for this thread.
> 
> I don't think this is really a slub issue, since it only happens on
> parisc, but maybe you can see what would make parisc different, and
> what could possibly make it all timing- or layout-dependent.
> 
>                  Linus
> 
> On Sun, 4 Aug 2024 at 11:36, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> With this patch in v6.10.3, all my parisc64 qemu tests get stuck with repeated error messages
>>
>> [    0.000000] =============================================================================
>> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
>> [    0.000000] -----------------------------------------------------------------------------
>>
>> This never stops until the emulation aborts.

diff --git a/mm/slub.c b/mm/slub.c
index 4927edec6a8c..ec4ed5215f2f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1386,8 +1386,8 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
 
 	maxobj = order_objects(slab_order(slab), s->size);
 	if (slab->objects > maxobj) {
-		slab_err(s, slab, "objects %u > max %u",
-			slab->objects, maxobj);
+		slab_err(s, slab, "objects %u > max %u (order %d size %u)",
+			slab->objects, maxobj, slab_order(slab), s->size);
 		return 0;
 	}
 	if (slab->inuse > slab->objects) {


