Return-Path: <linux-kernel+bounces-413065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565E9D12EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185821F2253B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B01A08B6;
	Mon, 18 Nov 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IX46Vykx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2SESeyKC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bfOoCiYT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="z5i8gX8Y"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4919B5A9;
	Mon, 18 Nov 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939995; cv=none; b=ioW47+hM1PeoUxLJ1gsCe5ZXHbvh62bQNp7aaq5sxGjtZUjXZLiiFV4oqnppHNuRsN34S4Kwj9/MTx1c52gZo76XNkhfxSa9hTeDSlAg1T7KfkwJO7v+6jLoNbxtE/jL0q84+pOIisaqvd6Z9tk1PqD7B+zhMKZu+IFdZwwbV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939995; c=relaxed/simple;
	bh=mNQXSj7B9lAc/kdpj2qVGcHNyZJI7tv+0JnJ8oN7Y78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hryqJf6GJrhidJZLE34GFbTiSwof1OfOXgCN96guUXJgAU58Ce7mVxsCVOfyENCeIV05ZO6b/GKofBGQQzctdYE4X2Iqj5j6llhQgbY9Azw0dpW4DiM84cOylPhkaehsu7zxXifGhdembEAjmAPplRqp0pJsaSLWDhAa3jik3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IX46Vykx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2SESeyKC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bfOoCiYT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=z5i8gX8Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1861218BB;
	Mon, 18 Nov 2024 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731939992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=//UoUtpWKLHH/tF8AGkvFCsF74EDM0ATlUHwxLWCZ4I=;
	b=IX46VykxXzFGCjtXZ38uL90FXdQeFt4pC/cJa4kliFrCgseeXESV1mpc5WUYzk2by0rj8l
	q/QlgPqKtx9vgVDMOU+FrN136nCJn2V/1imgD9a4T3TTSM9QyjGWMqCPyR2rqp5w6kXv4o
	Y+CO0IE5GQRd17zVgTF8CS5sQA7ZlXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731939992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=//UoUtpWKLHH/tF8AGkvFCsF74EDM0ATlUHwxLWCZ4I=;
	b=2SESeyKCxlxQEBp9yoEIEp3NQnFVCVM9wZTM15yJw91ngPLDOPnSkeAd1nxJ+bJaSGKDWN
	dbnf50jXRw4OlLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731939991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=//UoUtpWKLHH/tF8AGkvFCsF74EDM0ATlUHwxLWCZ4I=;
	b=bfOoCiYTUyL561y4abzHpM6sjtTmMt+yO+7K04hfNpredJwmHLVcC4r1T/+j2b2hp5Ao/Q
	U/uJ1t0ugRfMzKkc5FgJTwSdK+BpxG37zFlBuaeu/Cyj1v7VoUYjto7FGsPcdiPQ0Df+pq
	3mBo0lp2VNa9PLvB8N7cxkD3erPkNWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731939991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=//UoUtpWKLHH/tF8AGkvFCsF74EDM0ATlUHwxLWCZ4I=;
	b=z5i8gX8YX9gOtasUMxBEeVGfO0ouRlioKPTSfvBRRA/BDGvkOcK7vICl1H+C3ulUZc01Ig
	LeeFwO5XJ9yxRoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD4EF134A0;
	Mon, 18 Nov 2024 14:26:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aZ7WKZdOO2fcdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 18 Nov 2024 14:26:31 +0000
Message-ID: <9dc33d5f-fc04-4780-80ae-3c5f80a8b891@suse.cz>
Date: Mon, 18 Nov 2024 15:26:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 6/6] mm, slub: sheaf prefilling for guaranteed
 allocations
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20241112-slub-percpu-caches-v1-0-ddc0bdc27e05@suse.cz>
 <20241112-slub-percpu-caches-v1-6-ddc0bdc27e05@suse.cz>
 <CAB=+i9QoavVWZ6HxiOb8ypqov0rM+HAK4ge7nKHdQRPUaNPmkw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAB=+i9QoavVWZ6HxiOb8ypqov0rM+HAK4ge7nKHdQRPUaNPmkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,kernel.org,lge.com,linux.dev,infradead.org,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 11/18/24 14:13, Hyeonggon Yoo wrote:
> On Wed, Nov 13, 2024 at 1:39 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> +
>> +/*
>> + * Allocate from a sheaf obtained by kmem_cache_prefill_sheaf()
>> + *
>> + * Guaranteed not to fail as many allocations as was the requested count.
>> + * After the sheaf is emptied, it fails - no fallback to the slab cache itself.
>> + *
>> + * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>> + * memcg charging is forced over limit if necessary, to avoid failure.
>> + */
>> +void *
>> +kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>> +                                  struct slab_sheaf *sheaf)
>> +{
>> +       void *ret = NULL;
>> +       bool init;
>> +
>> +       if (sheaf->size == 0)
>> +               goto out;
>> +
>> +       ret = sheaf->objects[--sheaf->size];
>> +
>> +       init = slab_want_init_on_alloc(gfp, s);
>> +
>> +       /* add __GFP_NOFAIL to force successful memcg charging */
>> +       slab_post_alloc_hook(s, NULL, gfp | __GFP_NOFAIL, 1, &ret, init, s->object_size);
> 
> Maybe I'm missing something, but how can this be used for non-sleepable contexts
> if __GFP_NOFAIL is used? I think we have to charge them when the sheaf

AFAIK it forces memcg to simply charge even if allocated memory goes over
the memcg limit. So there's no issue with a non-sleepable context, there
shouldn't be memcg reclaim happening in that case.

> is returned
> via kmem_cache_prefill_sheaf(), just like users of bulk alloc/free?

That would be very costly to charge/uncharge if most of the objects are not
actually used - it's what we want to avoid here.
Going over the memcgs limit a bit in a very rare case isn't considered such
an issue, for example Linus advocated such approach too in another context.

> Best,
> Hyeonggon
> 
>> +out:
>> +       trace_kmem_cache_alloc(_RET_IP_, ret, s, gfp, NUMA_NO_NODE);
>> +
>> +       return ret;
>> +}
>> +
>>  /*
>>   * To avoid unnecessary overhead, we pass through large allocation requests
>>   * directly to the page allocator. We use __GFP_COMP, because we will need to
>>
>> --
>> 2.47.0
>>


