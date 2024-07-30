Return-Path: <linux-kernel+bounces-267635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94EE9413BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 138C7B2389A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6561A08BE;
	Tue, 30 Jul 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yzGxhFWz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cRVQ0sHw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yzGxhFWz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cRVQ0sHw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5E41A08A2;
	Tue, 30 Jul 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347810; cv=none; b=HIcMnoq0AT6KqxLW8401za+GV6DVRVkXeGuNFPWyoZmdowcXz0Lw/NKICwxV1kcgGwKS3Vzk2oUWauQC9lVNYBlFTcX7WnLTx/rvGdlP9nF+XwrlfV7v4JxKQxMJIZ0JIsq2h9Ed2Dq3dvLHCJuwprxk4cMZ7G4z94di1tf6d4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347810; c=relaxed/simple;
	bh=JjTjGnYUJk+r/KNyYLAw1ftHES0TrsS32IiJ5XNymu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=baLpgp60jTsIbm0DjQXlNDkMBbvVN6WNtersjR/48NoiBtMPGWOWgdam9lc5EzQ4cHrNSAzRQSW0YNCM50wWPJGx/JiFZCjOa9lfJXECKCUPTloPm4dP6+L1MaqimUCi1g7WSWuZUcDXxJhcGaavLy+in1/RAjxT/s7Gu5teCuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yzGxhFWz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cRVQ0sHw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yzGxhFWz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cRVQ0sHw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C6D721B2B;
	Tue, 30 Jul 2024 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTjsllBsZ0Sc2hQb4mXDp4REPh1mWvWiYq8KYR/uMy4=;
	b=yzGxhFWzz7dOIJzAQLsBT9HLwvB2Ln77ZvsoCk3l6nznhzgyjxXNqe+4aHSlpGMGWdMjva
	Ze7hzU78gGJHYYN/aH/4B++16zYpx1vQl8yMgDrp2uA0JhEyNpf1gDGqE1DrTHMtO31RC5
	8BIorIKYcIFAkCLJQwlraozEGhDIjyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTjsllBsZ0Sc2hQb4mXDp4REPh1mWvWiYq8KYR/uMy4=;
	b=cRVQ0sHwaJRCVsq3QLFGsWcx3dI7RemwmM2tLJ+cFFC+uAdWif4pdAWLYYqKQlM5ufaiTw
	m2nToJbgBO6RAHBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTjsllBsZ0Sc2hQb4mXDp4REPh1mWvWiYq8KYR/uMy4=;
	b=yzGxhFWzz7dOIJzAQLsBT9HLwvB2Ln77ZvsoCk3l6nznhzgyjxXNqe+4aHSlpGMGWdMjva
	Ze7hzU78gGJHYYN/aH/4B++16zYpx1vQl8yMgDrp2uA0JhEyNpf1gDGqE1DrTHMtO31RC5
	8BIorIKYcIFAkCLJQwlraozEGhDIjyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTjsllBsZ0Sc2hQb4mXDp4REPh1mWvWiYq8KYR/uMy4=;
	b=cRVQ0sHwaJRCVsq3QLFGsWcx3dI7RemwmM2tLJ+cFFC+uAdWif4pdAWLYYqKQlM5ufaiTw
	m2nToJbgBO6RAHBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE61813983;
	Tue, 30 Jul 2024 13:56:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tlP5KR7xqGYoYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jul 2024 13:56:46 +0000
Message-ID: <d0234a41-811e-40a7-b239-e51b35862adc@suse.cz>
Date: Tue, 30 Jul 2024 15:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: vmalloc: implement vrealloc()
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, roman.gushchin@linux.dev,
 42.hyeyoo@gmail.com, urezki@gmail.com, hch@infradead.org, kees@kernel.org,
 ojeda@kernel.org, wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
 chandan.babu@oracle.com, christian.koenig@amd.com, maz@kernel.org,
 oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rust-for-linux@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
 kasan-dev <kasan-dev@googlegroups.com>
References: <20240722163111.4766-1-dakr@kernel.org>
 <20240722163111.4766-2-dakr@kernel.org>
 <07491799-9753-4fc9-b642-6d7d7d9575aa@suse.cz> <ZqQBjjtPXeErPsva@cassiopeiae>
 <ZqfomPVr7PadY8Et@cassiopeiae> <ZqhDXkFNaN_Cx11e@cassiopeiae>
 <44fa564b-9c8f-4ac2-bce3-f6d2c99b73b7@suse.cz> <ZqjnR4Wxzf-ciUGW@pollux>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <ZqjnR4Wxzf-ciUGW@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.41 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.com,kernel.org,google.com,lge.com,linux-foundation.org,linux.dev,gmail.com,infradead.org,ellerman.id.au,oracle.com,amd.com,vger.kernel.org,kvack.org,intel.com,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: 0.41

On 7/30/24 3:14 PM, Danilo Krummrich wrote:
> On Tue, Jul 30, 2024 at 02:15:34PM +0200, Vlastimil Babka wrote:
>> On 7/30/24 3:35 AM, Danilo Krummrich wrote:
>>> On Mon, Jul 29, 2024 at 09:08:16PM +0200, Danilo Krummrich wrote:
>>>> On Fri, Jul 26, 2024 at 10:05:47PM +0200, Danilo Krummrich wrote:
>>>>> On Fri, Jul 26, 2024 at 04:37:43PM +0200, Vlastimil Babka wrote:
>>>>>> On 7/22/24 6:29 PM, Danilo Krummrich wrote:
>>>>>>> Implement vrealloc() analogous to krealloc().
>>>>>>>
>>>>>>> Currently, krealloc() requires the caller to pass the size of the
>>>>>>> previous memory allocation, which, instead, should be self-contained.
>>>>>>>
>>>>>>> We attempt to fix this in a subsequent patch which, in order to do so,
>>>>>>> requires vrealloc().
>>>>>>>
>>>>>>> Besides that, we need realloc() functions for kernel allocators in Rust
>>>>>>> too. With `Vec` or `KVec` respectively, potentially growing (and
>>>>>>> shrinking) data structures are rather common.
>>>>>>>
>>>>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>>>>
>>>>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>>>>>
>>>>>>> --- a/mm/vmalloc.c
>>>>>>> +++ b/mm/vmalloc.c
>>>>>>> @@ -4037,6 +4037,65 @@ void *vzalloc_node_noprof(unsigned long size, int node)
>>>>>>>  }
>>>>>>>  EXPORT_SYMBOL(vzalloc_node_noprof);
>>>>>>>  
>>>>>>> +/**
>>>>>>> + * vrealloc - reallocate virtually contiguous memory; contents remain unchanged
>>>>>>> + * @p: object to reallocate memory for
>>>>>>> + * @size: the size to reallocate
>>>>>>> + * @flags: the flags for the page level allocator
>>>>>>> + *
>>>>>>> + * The contents of the object pointed to are preserved up to the lesser of the
>>>>>>> + * new and old size (__GFP_ZERO flag is effectively ignored).
>>>>>>
>>>>>> Well, technically not correct as we don't shrink. Get 8 pages, kvrealloc to
>>>>>> 4 pages, kvrealloc back to 8 and the last 4 are not zeroed. But it's not
>>>>>> new, kvrealloc() did the same before patch 2/2.
>>>>>
>>>>> Taking it (too) literal, it's not wrong. The contents of the object pointed to
>>>>> are indeed preserved up to the lesser of the new and old size. It's just that
>>>>> the rest may be "preserved" as well.
>>>>>
>>>>> I work on implementing shrink and grow for vrealloc(). In the meantime I think
>>>>> we could probably just memset() spare memory to zero.
>>>>
>>>> Probably, this was a bad idea. Even with shrinking implemented we'd need to
>>>> memset() potential spare memory of the last page to zero, when new_size <
>>>> old_size.
>>>>
>>>> Analogously, the same would be true for krealloc() buckets. That's probably not
>>>> worth it.
>>
>> I think it could remove unexpected bad surprises with the API so why not
>> do it.
> 
> We'd either need to do it *every* time we shrink an allocation on spec, or we
> only do it when shrinking with __GFP_ZERO flag set, which might be a bit
> counter-intuitive.

I don't think it is that much counterintuitive.

> If we do it, I'd probably vote for the latter semantics. While it sounds more
> error prone, it's less wasteful and enough to cover the most common case where
> the actual *realloc() call is always with the same parameters, but a changing
> size.

Yeah. Or with hardening enabled (init_on_alloc) it could be done always.

