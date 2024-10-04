Return-Path: <linux-kernel+bounces-350079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F098FF7A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887761F22814
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54336144304;
	Fri,  4 Oct 2024 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uj3a0tJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfQE8COh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uj3a0tJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QfQE8COh"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116B126C04
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728033497; cv=none; b=FycvHR2qCLjL72GnnPVd6YtF98fTwLMXBTZKOHcOQ521ZgZ4rAyjxq9C3F0NLqQCAO3iUws2HM5L+kMdRRbTPp2zWv2HYaJvRE+TcOysEvOp27loNw5EYnkmjBhn5QxVgzUAYcO/RqsaKw+X+ogMKtgs4o3OSMSakuUkYKkXfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728033497; c=relaxed/simple;
	bh=QOkv93JmT6mwVv/wL78DHTH0ZyT1bVtwtEkJyAUU/Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxYqJvUIpu017Udm4px/2JKdOwBo98HwO271oJN/vCObG/5nIHSMR1Ybkdsxg0wvT7vQkLQcPFI9WMhmt5kgcLoZSt7SBLi7/5UPW0TXnb26gMWHRpVeOfjhB6UCefkRmBvJEOLPtq04ejlUPYiejYsXtPurTHxSq6iXBENS2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uj3a0tJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfQE8COh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uj3a0tJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QfQE8COh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF47D21E2C;
	Fri,  4 Oct 2024 09:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728033493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJvWtxFfWRqgDS5wtzltJ9aaFP0PBIh4+i3oe2Vw3LE=;
	b=Uj3a0tJLi6vJzbP43NaX8EQChX1CPkjOjqQ0cGbAsOUcjFqUMl8GpsKYUEkeTmN1+RZh7J
	k7sa6TiYIWDFhNgVZD+qdEbWD07n8B4eRUy2WRcsqpmQAgfvCErCgScq9MmNAHUEiYSvu/
	gZvjXSJkAN9mhCVplFM4rT1m1JSchD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728033493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJvWtxFfWRqgDS5wtzltJ9aaFP0PBIh4+i3oe2Vw3LE=;
	b=QfQE8COh2bEZTLQnOpylbVMrsW0InMP+mAHxnM0ZPaw0zrBEImDfE9ux3+Js+UfxPSRuJC
	MR4tDAfZeFxBu7Aw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Uj3a0tJL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QfQE8COh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728033493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJvWtxFfWRqgDS5wtzltJ9aaFP0PBIh4+i3oe2Vw3LE=;
	b=Uj3a0tJLi6vJzbP43NaX8EQChX1CPkjOjqQ0cGbAsOUcjFqUMl8GpsKYUEkeTmN1+RZh7J
	k7sa6TiYIWDFhNgVZD+qdEbWD07n8B4eRUy2WRcsqpmQAgfvCErCgScq9MmNAHUEiYSvu/
	gZvjXSJkAN9mhCVplFM4rT1m1JSchD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728033493;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hJvWtxFfWRqgDS5wtzltJ9aaFP0PBIh4+i3oe2Vw3LE=;
	b=QfQE8COh2bEZTLQnOpylbVMrsW0InMP+mAHxnM0ZPaw0zrBEImDfE9ux3+Js+UfxPSRuJC
	MR4tDAfZeFxBu7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8309813A55;
	Fri,  4 Oct 2024 09:18:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sMKfH9Wy/2YrCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 04 Oct 2024 09:18:13 +0000
Message-ID: <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
Date: Fri, 4 Oct 2024 11:18:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
To: Marco Elver <elver@google.com>
Cc: Feng Tang <feng.tang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>,
 David Gow <davidgow@google.com>, Danilo Krummrich <dakr@kernel.org>,
 Alexander Potapenko <glider@google.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AF47D21E2C
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,linuxfoundation.org,arm.com,kvack.org,googlegroups.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 10/4/24 08:44, Marco Elver wrote:
> On Wed, 2 Oct 2024 at 12:42, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 9/11/24 08:45, Feng Tang wrote:
>> > Danilo Krummrich's patch [1] raised one problem about krealloc() that
>> > its caller doesn't pass the old request size, say the object is 64
>> > bytes kmalloc one, but caller originally only requested 48 bytes. Then
>> > when krealloc() shrinks or grows in the same object, or allocate a new
>> > bigger object, it lacks this 'original size' information to do accurate
>> > data preserving or zeroing (when __GFP_ZERO is set).
>> >
>> > Thus with slub debug redzone and object tracking enabled, parts of the
>> > object after krealloc() might contain redzone data instead of zeroes,
>> > which is violating the __GFP_ZERO guarantees. Good thing is in this
>> > case, kmalloc caches do have this 'orig_size' feature, which could be
>> > used to improve the situation here.
>> >
>> > To make the 'orig_size' accurate, we adjust some kasan/slub meta data
>> > handling. Also add a slub kunit test case for krealloc().
>> >
>> > This patchset has dependency over patches in both -mm tree and -slab
>> > trees, so it is written based on linux-next tree '20240910' version.
>> >
>> > [1]. https://lore.kernel.org/lkml/20240812223707.32049-1-dakr@kernel.org/
>>
>> Thanks, added to slab/for-next
> 
> This series just hit -next, and we're seeing several "KFENCE: memory
> corruption ...". Here's one:
> https://lore.kernel.org/all/66ff8bf6.050a0220.49194.0453.GAE@google.com/
> 
> One more (no link):
> 
>> ==================================================================
>> BUG: KFENCE: memory corruption in xfs_iext_destroy_node+0xab/0x670 fs/xfs/libxfs/xfs_iext_tree.c:1051
>>
>> Corrupted memory at 0xffff88823bf5a0d0 [ 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 ] (in kfence-#172):
>> xfs_iext_destroy_node+0xab/0x670 fs/xfs/libxfs/xfs_iext_tree.c:1051
>> xfs_iext_destroy+0x66/0x100 fs/xfs/libxfs/xfs_iext_tree.c:1062
>> xfs_inode_free_callback+0x91/0x1d0 fs/xfs/xfs_icache.c:145
>> rcu_do_batch kernel/rcu/tree.c:2567 [inline]
> [...]
>>
>> kfence-#172: 0xffff88823bf5a000-0xffff88823bf5a0cf, size=208, cache=kmalloc-256
>>
>> allocated by task 5494 on cpu 0 at 101.266046s (0.409225s ago):
>> __do_krealloc mm/slub.c:4784 [inline]
>> krealloc_noprof+0xd6/0x2e0 mm/slub.c:4838
>> xfs_iext_realloc_root fs/xfs/libxfs/xfs_iext_tree.c:613 [inline]
> [...]
>>
>> freed by task 16 on cpu 0 at 101.573936s (0.186416s ago):
>> xfs_iext_destroy_node+0xab/0x670 fs/xfs/libxfs/xfs_iext_tree.c:1051
>> xfs_iext_destroy+0x66/0x100 fs/xfs/libxfs/xfs_iext_tree.c:1062
>> xfs_inode_free_callback+0x91/0x1d0 fs/xfs/xfs_icache.c:145
> [...]
>>
>> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc1-next-20241003-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>> ==================================================================
> 
> Unfortunately there's no reproducer yet it seems. Unless it's
> immediately obvious to say what's wrong, is it possible to take this
> series out of -next to confirm this series is causing the memory
> corruptions? Syzbot should then stop finding these crashes.

I think it's commit d0a38fad51cc7 doing in __do_krealloc()

-               ks = ksize(p);
+
+               s = virt_to_cache(p);
+               orig_size = get_orig_size(s, (void *)p);
+               ks = s->object_size;

so for kfence objects we don't get their actual allocation size but the
potentially larger bucket size?

I guess we could do:

ks = kfence_ksize(p) ?: s->object_size;

?

> Thanks,
> -- Marco


