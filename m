Return-Path: <linux-kernel+bounces-394775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5055C9BB3BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9C61C223AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450421B372C;
	Mon,  4 Nov 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIKxeh5v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PZXyS6QR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CIKxeh5v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PZXyS6QR"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BEB16EC0E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720755; cv=none; b=gug2aOOWMzefa7W33joca0w4RuTSWWw9vF3Gxpx1sawq1nnyaFcxxmbuWsWIH864hz6Hsq8DAIQZRERIpn1x8FTHIAhjg4gDc66xoYVu+ajfzYCf6+noeyaCKGeuvVzMQrAXN+g1FiZ0vAaukHfwQA4/9AuY59d+n6TmbxIjcQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720755; c=relaxed/simple;
	bh=dt3ywtIcZdAqd1RIcNUdaWvxTGDeN65Lml5b096vYrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHPGPzXQzXDutv0A/CkmR0c8Ip1JJRxcaeP/O5H8bRZIZNLulvmXeghcmS3JSnEa0aLC5gpHSV/Ytb9Aa3Y6+B77S2cDodf/fdNiFBX2YJZyRwmVzCpUXX+zxc8Om9zGViAvA2aO6djBJfqKzJxRZQQf3ZqIEAxZ1alDrPUbSAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIKxeh5v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PZXyS6QR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CIKxeh5v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PZXyS6QR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 865FB21E8F;
	Mon,  4 Nov 2024 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730720751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7jdXmAKMKDFjcbluumBKxTyPOR5iiGpNO1xmBUem+jg=;
	b=CIKxeh5v17OKWwBqBsk0f3AflWwVsBJOc1N7iY27WEuZHhNQPEzxj+Q2eq5vru3k+6R7FG
	JlyR3ArGhmm8cdKEy0XUUmD+eWjv75OlNN8pfXCdxu9afhk6OwD0O6k2cViybLeKbiZfIP
	8Q7TqsLUXZUEY0/K04VGdRuP5aRnAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730720751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7jdXmAKMKDFjcbluumBKxTyPOR5iiGpNO1xmBUem+jg=;
	b=PZXyS6QRh8t0MyrD3+dCVpMIccwhnSj37fWI04RJ3FUU9MvmZztOkABin9RtxJDi1VidLj
	e9T4YTXjXwGgzmAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CIKxeh5v;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PZXyS6QR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730720751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7jdXmAKMKDFjcbluumBKxTyPOR5iiGpNO1xmBUem+jg=;
	b=CIKxeh5v17OKWwBqBsk0f3AflWwVsBJOc1N7iY27WEuZHhNQPEzxj+Q2eq5vru3k+6R7FG
	JlyR3ArGhmm8cdKEy0XUUmD+eWjv75OlNN8pfXCdxu9afhk6OwD0O6k2cViybLeKbiZfIP
	8Q7TqsLUXZUEY0/K04VGdRuP5aRnAnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730720751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7jdXmAKMKDFjcbluumBKxTyPOR5iiGpNO1xmBUem+jg=;
	b=PZXyS6QRh8t0MyrD3+dCVpMIccwhnSj37fWI04RJ3FUU9MvmZztOkABin9RtxJDi1VidLj
	e9T4YTXjXwGgzmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D72D1373E;
	Mon,  4 Nov 2024 11:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pa6BEu+zKGfiSQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 04 Nov 2024 11:45:51 +0000
Message-ID: <79335db3-4528-446e-a839-272645133e19@suse.cz>
Date: Mon, 4 Nov 2024 12:45:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/slub: Improve data handling of krealloc() when
 orig_size is enabled
Content-Language: en-US
To: Feng Tang <feng.tang@intel.com>, Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Andrew Morton
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
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>
References: <20240911064535.557650-1-feng.tang@intel.com>
 <d3dd32ba-2866-40ce-ad2b-a147dcd2bf86@suse.cz>
 <CANpmjNM5XjwwSc8WrDE9=FGmSScftYrbsvC+db+82GaMPiQqvQ@mail.gmail.com>
 <49ef066d-d001-411e-8db7-f064bdc2104c@suse.cz>
 <2382d6e1-7719-4bf9-8a4a-1e2c32ee7c9f@suse.cz>
 <ZwzNtGALCG9jUNUD@feng-clx.sh.intel.com>
 <a34e6796-e550-465c-92dc-ee659716b918@suse.cz>
 <Zw0UKtx5d2hnHvDV@feng-clx.sh.intel.com>
 <0e8d49d2-e89b-44df-9dff-29e8f24de105@suse.cz>
 <Zw0otGNgqPUeTdWJ@feng-clx.sh.intel.com>
 <Zyiv40cZcaCKlGtM@feng-clx.sh.intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <Zyiv40cZcaCKlGtM@feng-clx.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 865FB21E8F
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,linux-foundation.org,linux.com,kernel.org,lge.com,linux.dev,gmail.com,linuxfoundation.org,arm.com,kvack.org,googlegroups.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 11/4/24 12:28, Feng Tang wrote:
> On Mon, Oct 14, 2024 at 10:20:36PM +0800, Tang, Feng wrote:
>> On Mon, Oct 14, 2024 at 03:12:09PM +0200, Vlastimil Babka wrote:
>> > > 
>> > >> So I think in __do_krealloc() we should do things manually to determine ks
>> > >> and not call ksize(). Just not break any of the cases ksize() handles
>> > >> (kfence, large kmalloc).
>> > > 
>> > > OK, originally I tried not to expose internals of __ksize(). Let me
>> > > try this way.
>> > 
>> > ksize() makes assumptions that a user outside of slab itself is calling it.
>> > 
>> > But we (well mostly Kees) also introduced kmalloc_size_roundup() to avoid
>> > querying ksize() for the purposes of writing beyond the original
>> > kmalloc(size) up to the bucket size. So maybe we can also investigate if the
>> > skip_orig_size_check() mechanism can be removed now?
>> 
>> I did a quick grep, and fortunately it seems that the ksize() user are
>> much less than before. We used to see some trouble in network code, which
>> is now very clean without the need to skip orig_size check. Will check
>> other call site later.
>  
> 
> I did more further check about ksize() usage, and there are still some
> places to be handled. The thing stands out is kfree_sensitive(), and
> another potential one is sound/soc/codecs/cs-amp-lib-test.c
> 
> Some details:
> 
> * Thanks to Kees Cook, who has cured many cases of ksize() as below:
>   
>   drivers/base/devres.c:        total_old_size = ksize(container_of(ptr, struct devres, data));
>   drivers/net/ethernet/intel/igb/igb_main.c:        } else if (size > ksize(q_vector)) {   
>   net/core/skbuff.c:        *size = ksize(data);
>   net/openvswitch/flow_netlink.c:        new_acts_size = max(next_offset + req_size, ksize(*sfa) * 2);
>   kernel/bpf/verifier.c:        alloc_bytes = max(ksize(orig), kmalloc_size_roundup(bytes));
> 
> * Some callers use ksize() mostly for calculation or sanity check,
>   and not for accessing those extra space, which are fine:
> 
>   drivers/gpu/drm/drm_managed.c:        WARN_ON(dev + 1 > (struct drm_device *) (container + ksize(container)));
>   lib/kunit/string-stream-test.c:        actual_bytes_used = ksize(stream);
>   lib/kunit/string-stream-test.c:                actual_bytes_used += ksize(frag_container);
>   lib/kunit/string-stream-test.c:                actual_bytes_used += ksize(frag_container->fragment);
>   mm/nommu.c:                return ksize(objp);
>   mm/util.c:                        memcpy(n, kasan_reset_tag(p), ksize(p));
>   security/tomoyo/gc.c:        tomoyo_memory_used[TOMOYO_MEMORY_POLICY] -= ksize(ptr);
>   security/tomoyo/memory.c:                const size_t s = ksize(ptr);
>   drivers/md/dm-vdo/memory-alloc.c:                        add_kmalloc_block(ksize(p));
>   drivers/md/dm-vdo/memory-alloc.c:                add_kmalloc_block(ksize(p));
>   drivers/md/dm-vdo/memory-alloc.c:                        remove_kmalloc_block(ksize(ptr));
> 	
> * One usage may need to be handled 
>  
>   sound/soc/codecs/cs-amp-lib-test.c:        KUNIT_ASSERT_GE_MSG(test, ksize(buf), priv->cal_blob->size, "Buffer to small");
> 
> * bigger problem is the kfree_sensitive(), which will use ksize() to
>   get the total size and then zero all of them.
>   
>   One solution for this could be get the kmem_cache first, and
>   do the skip_orig_size_check() 

Maybe add a parameter for __ksize() that controls if we do
skip_orig_size_check(), current ksize() will pass "false" to it (once
remaining wrong users are handled), then another ksize_internal() variant
will pass "true" and be used from kfree_sensitive()?

> Thanks,
> Feng


