Return-Path: <linux-kernel+bounces-276783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC0E949850
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA4F282819
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9F143C46;
	Tue,  6 Aug 2024 19:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sGtCweXn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1NtRH2AR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GHzJlcjU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ngSGUmp"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EE1C32
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722972722; cv=none; b=ZqNTi7pT0Ic3OOsRs0TAy47n0KHQtIasHp6iHicsVqkubn0Y8ioG+q6ZvNMP3/BvWM4KDHitF8t2LR19CVIHkuprwfoVYqS7uq5FYB6JntxV3b+LUaeGObwA6eKYChQV2Bw+mYDuAhm48W97FH5OWDd7A2u2qcMJd3lV0hq5HAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722972722; c=relaxed/simple;
	bh=3eLLWEhQPvRNgo6nf56/exD2FJHnydz1PnlNfQsdsZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hc6PmY9lWlpeVCuO8JCK+ZWxCOPbG3Ch5r63XDy9gsX27l6ovrZh8BIpVh+uYmMPyOjE4cw0kmP5UcRmZheL2XJs2EQovvdKYq3H3exuRX42MgjucG1sD+O5B4TlkBsB8hbqBdiYltbVv+xzLrUmA8XRdk7XphZhlsnO25gpOm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sGtCweXn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1NtRH2AR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GHzJlcjU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ngSGUmp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73DA121BFD;
	Tue,  6 Aug 2024 19:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722972716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FrHqaHM/05kDr3O2TWiLCpz2Azg9FaXt2a6jm0OY/5Y=;
	b=sGtCweXn7UplN2BHYTcVltkAQgAAqh3NFVt5fRtx2aqIWdnw8n/zhI7yv7ve5Nn96C54W0
	fxUwRnG91E9Z96pgwl10AwfeRrQqguLNNOcdCdSspiqyr9+giNrF1EqWQ+iZYnRAx9+xZS
	FywPikM4dPYMeK1xIK9cwttbYZWE4GU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722972716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FrHqaHM/05kDr3O2TWiLCpz2Azg9FaXt2a6jm0OY/5Y=;
	b=1NtRH2ARSoQdey8dX7DzfZIcMYHhpS67Rkewc4pH6D6YUVPPFJcouldhtOhmnwrDXt9h0+
	D349Ska/XcJQIjCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GHzJlcjU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ngSGUmp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722972715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FrHqaHM/05kDr3O2TWiLCpz2Azg9FaXt2a6jm0OY/5Y=;
	b=GHzJlcjUdZglaLvX1iINMjYWM3tUVWDsckmGXL4VF2zRsEFgtLnNPQUEg9UA5D7P7fX5YL
	9Aj48HnuqeJAbB5joTKmfCwMKMoXHHYUN3dAoSLRxCYWDJALwnwGaCEo+IKnuNkmd2IjRA
	rD/sk8q5YPyWOEkRn2JezdscER5t/kI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722972715;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FrHqaHM/05kDr3O2TWiLCpz2Azg9FaXt2a6jm0OY/5Y=;
	b=9ngSGUmp59IAyIV1YhqvSKS3KvdZ53auXoIw6hI6h7vr4Pml61To4fHXbRRwDmJ+p/y3Ga
	Lj6bqs2pJmMdV3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FAC613929;
	Tue,  6 Aug 2024 19:31:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X3++Fit6smb4MAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 Aug 2024 19:31:55 +0000
Message-ID: <75fc1760-7826-49d1-8da5-99c09ddb2aa4@suse.cz>
Date: Tue, 6 Aug 2024 21:31:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240731095022.970699670@linuxfoundation.org>
 <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz>
 <4f71784a-e896-4512-b1e5-600d0497037c@roeck-us.net>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <4f71784a-e896-4512-b1e5-600d0497037c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,roeck-us.net:url,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Rspamd-Queue-Id: 73DA121BFD

On 8/6/24 20:09, Guenter Roeck wrote:
> On 8/6/24 04:02, Vlastimil Babka wrote:
>> On 8/6/24 04:40, Linus Torvalds wrote:
>>> [ Let's drop random people and bring in Vlastimil ]
>> 
>> tglx was reproducing it so I add him back
>> 
>>> Vlastimil,
>>>   it turns out that the "this patch" is entirely a red herring, and the
>>> problem comes and goes randomly with just some code layout issues. See
>>>
>>>     http://server.roeck-us.net/qemu/parisc64-6.10.3/
>>>
>>> for more detail, particularly you'll see the "log.bad.gz" with the full log.
>> 
>> [    0.000000] BUG kmem_cache_node (Not tainted): objects 21 > max 16
>> [    0.000000] Slab 0x0000000041ed0000 objects=21 used=5 fp=0x00000000434003d0 flags=0x200(workingset|section=0|zone=0)
>> 
>> flags tell us this came from the partial list (workingset), there's no head flag so order-0
>> 
>> since the error was detected it basically throws the slab page away and tries another one
>> 
>> [    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
>> [    0.000000] Slab 0x0000000041ed0080 objects=25 used=6 fp=0x0000000043402790 flags=0x240(workingset|head|section=0|zone=0)

OK so I missed the first was "kmem_cache_node" and the rest is "kmem_cache"
which explains the 21 vs 25 difference, and the difference in order etc.

>> this was also from the partial list but head flag so at least order-1, two things are weird:
>> - max=16 is same as above even though it should be at least double as
>> slab page's order is larger
>> - objects=25 also isn't at least twice than objects=21
>> 
>> All the following are:
>> [    0.000000] BUG kmem_cache (Tainted: G    B             ): objects 25 > max 16
>> [    0.000000] Slab 0x0000000041ed0300 objects=25 used=1 fp=0x000000004340c150 flags=0x40(head|section=0|zone=0)
>> 
>> we depleted the partial list so it's allocating new slab pages, that are
>> also at least order-1
>> 
>> It looks like maxobj calculation is bogus, would be useful to see what values it
>> calculates from. I'm attaching a diff, but maybe it will also hide the issue...
>> 
> 
> If I am really careful I can catch the problem. Adding a parameter to slab_err()
> makes it disappear. Calling slab_order() multiple times makes it disappear. But I can
> assign the result of slab_order() to a variable and go from there, by changing the
> parameters to slab_err() one at a time. Here is what I get by combining multiple
> test runs.
> 
> objects 21 max 16 order 0 size 192
>   with:
>    Slab 0x0000000041ed0000 objects=21 used=5 fp=0x00000000434003d0 flags=0x200(workingset|section=0|zone=0)
> objects 25 max 16 order 1 size 320 (many times)
>   with:
>    Slab 0x0000000041ed0080 objects=25 used=6 fp=0x0000000043402790 flags=0x240(workingset|head|section=0|zone=0)
>    Slab 0x0000000041ed0300 objects=25 used=1 fp=0x000000004340c150 flags=0x40(head|section=0|zone=0)
>    Slab 0x0000000041ed0380 objects=25 used=1 fp=0x000000004340e150 flags=0x40(head|section=0|zone=0)
>    and so on
> 
> If I add a log message into check_slab() and display every check I get:
> 
> objects 21 max 21 (order 0 size 192)
> objects 25 max 25 (order 1 size 320)
> objects 25 max 25 (order 1 size 320)
> objects 25 max 25 (order 1 size 320)
> objects 21 max 21 (order 0 size 192)
> 
> and so on. I guess that confirms that the maxobj calculation is wrong in the failure case.

Agreed.

> That seems weird, though, given that order_objects() should return a constant based on
> order and size. PAGE_SIZE is 4096, meaning order_objects() should return 21 and 25, never
> 16. That does make me really wonder if there is an emulation problem, though I don't
> really understand why that would not be persistent.

Yeah 21 and 25 are expected for these sizes and orders.

> Any idea what else I could test ?
> 
> Thanks,
> Guenter
> 


