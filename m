Return-Path: <linux-kernel+bounces-328350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79579978253
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBE6B21E76
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1E21DB52E;
	Fri, 13 Sep 2024 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbdFFwYi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8otsO+nQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wbdFFwYi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8otsO+nQ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3DB1D86D1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726236614; cv=none; b=GqrqpBue/Wg8lksUgElc8ej6BytsC8gJwSg1ZtEvKdodl1b7QskKCXgwkRE0g+BNp+U1l6HCwVYfCufy8D7W5ilhPdfUDMYhpyCPA6lSpbBKioLJt31iHmgRvAUi6kWMdqK/6aYs1+iuNpDA10duK3pZlw1q7elEntJtpBooV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726236614; c=relaxed/simple;
	bh=EI8D23mtm+1l0v683R9AEq473DWaxHNBxlXWP7LRB2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUGlybA6QJ4IUByvxywrh2KsFiC9ZM/B/UcrpcYfLNIePM9TUQ1NdJrsKS1o+8OSY/XNS3swtMl1Z4CAhrMEl/5xHLr80z6PPOaE2o9lMDpv1qvWRhKq5Q3imKiL7fh4dESrGGd+VTBFgIl1uoGxRdbIaBFUosHC8rfnb26pzPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbdFFwYi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8otsO+nQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wbdFFwYi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8otsO+nQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5EB7A219AF;
	Fri, 13 Sep 2024 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726236609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H2P1J1ksk9euax2Bu6daSipLCx8flOfu5u5SE133Wmo=;
	b=wbdFFwYiQH4/Uy3LK+Ofivo/xfTYGv0/fkQ8cTa2OLfzyxNEAu6+wyCOiGg7U/ibi5eAUI
	KyuoK5Nca2tOxHkBnpO7GYKKfP1S6ZHAQHUm8LjTPXFbzN8vhpvecLputi0QKVMRc5q1MX
	3oY3Py5eQ8PrRsBAZLiBbSimik6+d+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726236609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H2P1J1ksk9euax2Bu6daSipLCx8flOfu5u5SE133Wmo=;
	b=8otsO+nQL0Z8+nZBWtqvACsDwOaUqbBwmhz8+ZIrSu1Dw/6zsmQikEYxR38wJpOpe5k6bj
	hbYCu6fxANhQvnBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726236609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H2P1J1ksk9euax2Bu6daSipLCx8flOfu5u5SE133Wmo=;
	b=wbdFFwYiQH4/Uy3LK+Ofivo/xfTYGv0/fkQ8cTa2OLfzyxNEAu6+wyCOiGg7U/ibi5eAUI
	KyuoK5Nca2tOxHkBnpO7GYKKfP1S6ZHAQHUm8LjTPXFbzN8vhpvecLputi0QKVMRc5q1MX
	3oY3Py5eQ8PrRsBAZLiBbSimik6+d+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726236609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H2P1J1ksk9euax2Bu6daSipLCx8flOfu5u5SE133Wmo=;
	b=8otsO+nQL0Z8+nZBWtqvACsDwOaUqbBwmhz8+ZIrSu1Dw/6zsmQikEYxR38wJpOpe5k6bj
	hbYCu6fxANhQvnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4387413A73;
	Fri, 13 Sep 2024 14:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Uj+D8FH5GZiMwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 13 Sep 2024 14:10:09 +0000
Message-ID: <02820eb8-0b8f-4aa8-9315-85368e9c331e@suse.cz>
Date: Fri, 13 Sep 2024 16:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in
 sysfs_slab_add()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Liu Shixin <liushixin2@huawei.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20221112114602.1268989-1-liushixin2@huawei.com>
 <20221112114602.1268989-4-liushixin2@huawei.com>
 <3780a622-03f2-4cfe-5705-0e9d0be61d57@huawei.com>
 <CAB=+i9SiiH7JN1tTrmO6FS+HqQcKnwoAs3O2PKxfPy2parM8WA@mail.gmail.com>
 <68b86f66-cd00-bb7d-b8bb-5a94e8dd1ea2@huawei.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <68b86f66-cd00-bb7d-b8bb-5a94e8dd1ea2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_TO(0.00)[huawei.com,gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 9/6/24 10:10, Jinjie Ruan wrote:
> 
> 
> On 2024/9/5 21:59, Hyeonggon Yoo wrote:
>> On Thu, Sep 5, 2024 at 12:41 PM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>>>
>>>
>>>
>>> On 2022/11/12 19:46, Liu Shixin wrote:
>>>> There is a memory leak of kobj->name in sysfs_slab_add():
>>>>
>>>>  unreferenced object 0xffff88817e446440 (size 32):
>>>>    comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
>>>>    hex dump (first 32 bytes):
>>>>      75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_slab
>>>>      00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~............
>>>>    backtrace:
>>>>      [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
>>>>      [<000000002f70da0c>] kstrdup_const+0x4b/0x80
>>>>      [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
>>>>      [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
>>>>      [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
>>>>      [<000000009326fd57>] __kmem_cache_create+0x406/0x590
>>>>      [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
>>>>      [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
>>>>      [<000000007a6531c8>] 0xffffffffa02d802d
>>>>      [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
>>>>      [<00000000995ecdcf>] do_init_module+0xdf/0x320
>>>>      [<000000008821941f>] load_module+0x2f98/0x3330
>>>>      [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
>>>>      [<000000009339fbce>] do_syscall_64+0x35/0x80
>>>>      [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
>>>
>>>
>>> Hi，every one,
>> 
>> Hi.
>> 
>>> I found the same problem and it solve this problem with the patch, is
>>> there any plan to update the patch and solve it.

Hmm looks like back in 2022, Hyeonggon had some feedback to the series which
was not answered and then it got forgotten. Feel free to take over and send
an updated version.

>> What kernel version do you use,
> 
> 6.11.0-rc6
> 
>> and when do you encounter it or how do you reproduce it?
> 
> Hi, Hyeonggon,
> 
> Thank you, I encounter it when doing inject fault test while modprobe
> amdgpu.ko.

So I wonder where's the problem that results in kobject_init_and_add()
failing. If it's genuinely duplicate name as commit 80da026a8e5d suggests,
6.12-rc1 will have a warning to prevent that. Delayed destruction of
SLAB_TYPESAFE_BY_RCU caches should also no longer happen with 6.12-rc1. So
worth retrying with that and if it's still failing, we should look at the
root cause perhaps.

>> 
>> --
>> Hyeonggon


