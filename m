Return-Path: <linux-kernel+bounces-410707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9721F9CDFF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE8CDB23F72
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255E31BDAB9;
	Fri, 15 Nov 2024 13:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eA8Yrwbx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8mW8jHon";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bfopt31V";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCQBk4UE"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AA1B85FA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677387; cv=none; b=GSSmmfqsqubReQrOOHHlZGE78vkEVJBviuHkROh+SYZHXExXyKZbrKo7+vaI6Y4DNXsmMUPKE/jkLUAD5msMX0caRvdRRxbB+hZmKDnTddvHDSFuMCNpqqQ2Q2vgTuDwT7GYXtPwC9cd39GvCyANanjRIVJQnF1HZnsIdR6d5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677387; c=relaxed/simple;
	bh=1dqkeB0JnD4g5z+Wt5SWJAPiJ3tAL+M+7YCoHf8W6hA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOTUSAg5ba29KCNQmPnr0an6yZqGHf4O9/OoN9PY+1E3189i+zV4QHX/+gwe4ZNjhsKeNnRhqDHXDfJgyHfqhD5CrKwyVBnw5ECKn70klAVsu8GYmWj1J6gO5iqgMG3D9wsjlwH/h4bHodMlYk5XE68dTLeVFE+YGeTTd6BGe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eA8Yrwbx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8mW8jHon; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bfopt31V; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCQBk4UE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 583FE211D4;
	Fri, 15 Nov 2024 13:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731677383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=klW9mk1OBna+iR5vt4sj+lP9w1g7OCAAjSCAHllQfnw=;
	b=eA8YrwbxIDOlqxgMfTZXuDhiXBojnEdn0unkFJDO4n5/QDuZIGhvYS9e+pegXO0c0yn+Ii
	1qbSPwOp1+ENFcOIDOtlLkha1iVU5IE+osKo/XiCarmk65ErlDPNXTRK0jXCm00b7/fQcb
	2g8rN8ZfKuG2DJ1rXd2XEMYGUUaVxzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731677383;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=klW9mk1OBna+iR5vt4sj+lP9w1g7OCAAjSCAHllQfnw=;
	b=8mW8jHonpLf/g705WrqY8M0qNgo7nWQhIO3Xu8t2wp6mSsKuoF2UROpyGEK1FIqqFSc6nV
	i5xusg+YXtUQ8YAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Bfopt31V;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gCQBk4UE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731677382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=klW9mk1OBna+iR5vt4sj+lP9w1g7OCAAjSCAHllQfnw=;
	b=Bfopt31VdL3GOAojggO91sr1LjIIVwp7uD6JJP0lYZ8RVqdvhhBVaGLDsCFgR5MaUWAXFs
	8JhMVYqapc8xmR86gC9aMtt8Z0sCd0t8MuoAfJvet1UP2hLyw+Crqz7PpNbNHGZ6kC2AkJ
	zAKfiTppKBOwOkmmO+1LPlbovZeJC9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731677382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=klW9mk1OBna+iR5vt4sj+lP9w1g7OCAAjSCAHllQfnw=;
	b=gCQBk4UETMGWnJAC2kMlIFmkOkTYejZfql4t7Qh3rMQYuWKbA+EAIxBncwiSmIzT0PpeHF
	v38Dlx7PZamTrEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23B22134B8;
	Fri, 15 Nov 2024 13:29:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tfBECMZMN2fQFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 15 Nov 2024 13:29:42 +0000
Message-ID: <95c1aedc-1bb3-480f-9c82-efc22d2beaf8@suse.cz>
Date: Fri, 15 Nov 2024 14:29:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] mm/slub: Improve redzone check and zeroing for
 krealloc()
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Danilo Krummrich <dakr@kernel.org>, Narasimhan.V@amd.com,
 linux-mm@kvack.org, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
References: <20241016154152.1376492-1-feng.tang@intel.com>
 <20241016154152.1376492-3-feng.tang@intel.com>
 <CAB=+i9QUC+zscxC6AuK9qUaD-Y9VmAv2-Ovqt8JRJJARWxZ-EQ@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAB=+i9QUC+zscxC6AuK9qUaD-Y9VmAv2-Ovqt8JRJJARWxZ-EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 583FE211D4
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.com,kernel.org,google.com,lge.com,linux.dev,gmail.com,amd.com,kvack.org,googlegroups.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/14/24 14:34, Hyeonggon Yoo wrote:
> On Thu, Oct 17, 2024 at 12:42 AM Feng Tang <feng.tang@intel.com> wrote:
>>
>> For current krealloc(), one problem is its caller doesn't pass the old
>> request size, say the object is 64 bytes kmalloc one, but caller may
>> only requested 48 bytes. Then when krealloc() shrinks or grows in the
>> same object, or allocate a new bigger object, it lacks this 'original
>> size' information to do accurate data preserving or zeroing (when
>> __GFP_ZERO is set).
>>
>> Thus with slub debug redzone and object tracking enabled, parts of the
>> object after krealloc() might contain redzone data instead of zeroes,
>> which is violating the __GFP_ZERO guarantees. Good thing is in this
>> case, kmalloc caches do have this 'orig_size' feature. So solve the
>> problem by utilize 'org_size' to do accurate data zeroing and preserving.
>>
>> [Thanks to syzbot and V, Narasimhan for discovering kfence and big
>>  kmalloc related issues in early patch version]
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Feng Tang <feng.tang@intel.com>
>> ---
>>  mm/slub.c | 84 +++++++++++++++++++++++++++++++++++++++----------------
>>  1 file changed, 60 insertions(+), 24 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1d348899f7a3..958f7af79fad 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4718,34 +4718,66 @@ static __always_inline __realloc_size(2) void *
>>  __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>>  {
>>         void *ret;
>> -       size_t ks;
>> -
>> -       /* Check for double-free before calling ksize. */
>> -       if (likely(!ZERO_OR_NULL_PTR(p))) {
>> -               if (!kasan_check_byte(p))
>> -                       return NULL;
>> -               ks = ksize(p);
>> -       } else
>> -               ks = 0;
>> -
>> -       /* If the object still fits, repoison it precisely. */
>> -       if (ks >= new_size) {
>> -               /* Zero out spare memory. */
>> -               if (want_init_on_alloc(flags)) {
>> -                       kasan_disable_current();
>> +       size_t ks = 0;
>> +       int orig_size = 0;
>> +       struct kmem_cache *s = NULL;
>> +
>> +       /* Check for double-free. */
>> +       if (unlikely(ZERO_OR_NULL_PTR(p)))
>> +               goto alloc_new;
> 
> nit: I think kasan_check_bytes() is the function that checks for double-free?

Hm yeah, moved the comment.

> Otherwise looks good to me,
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!


