Return-Path: <linux-kernel+bounces-282911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FD394EA6F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7C9280E52
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013616EB54;
	Mon, 12 Aug 2024 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cABFegQ8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8h8nGUz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE121876
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723457037; cv=none; b=bbay0BatdGwMlMTuiMYSsB1L6ihkUktJHI+WxF24hQcRdFyLfM8Jy5+m1jYxwvzD10hkONWz6isXpGrEjXeawlmU33YAggTwVezkYGEIrC1mXvcIK5rUu/8vYPURBLyNkim9KaSA/PRnkWouuLYIde69ok6TiLmlEdsvhQuz39s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723457037; c=relaxed/simple;
	bh=c+F6pih3HXN3RRsXKqoQpXQEz+y1uqBWiJvMUIAA9fs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nSpCQp/laIRUhaJGiDEmg7PO89dveGpmLVlUSVr620WO9XQfbXCdles2WEqFAmP4ma5DIu2jWD6/N1lZqsQWbQeUkM5IBjd3HPo+RbFP6oTwBHPJVmaKT+SN/vMep6X/KUF82gFNSZkJGjnrAX+jbEvBzu4L7TJQZdrTEW8b20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cABFegQ8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8h8nGUz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723457034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBF+ztuG3CVbPA559Kz5ePviHRu7t2DYysXz02ANcRM=;
	b=cABFegQ8su832/BA0n9TEorAY72ijtvN5/Wk6eiZUtLC10ULdz/l6g0KaLvJChgs8n80tk
	Lum+E+o6ki2dCalfCrDnyCY9iwmU8l7+cYdPO1FU9QpFPssI51vKIs/p9SugCrH1TYW7Jc
	JLbK8AGuhVRUQlSY34rhMzMFPEuoIlURwveHP0YFYOR70yKWybKi/8DZ91l4QHUpgjp7aT
	5QP1Bnb0cyP/0T5NGsZ05JnUNWJUMmPN/QYwNwLPd/x4W+TmV3j+l0PpkKFGB9Rvm9amjv
	PzC6u8k3uDg61zRQe4FTlYc7gUe8OihPrSy5+0ZEAmAYvhrRQSRA2I8ApRkCTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723457034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MBF+ztuG3CVbPA559Kz5ePviHRu7t2DYysXz02ANcRM=;
	b=G8h8nGUzCJ4NMvT+VA97uinHq6q5jlYLPjF41zu/XNG+AsQdoiNG238YLyXncHxBBpUDm8
	meH1VhK3EF9ByxAA==
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
 Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <87o75y428z.fsf@nvdebian.thelocal>
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal>
Date: Mon, 12 Aug 2024 12:03:53 +0200
Message-ID: <87ikw6rrau.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 17:41, Alistair Popple wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>> ---
>> --- a/arch/x86/include/asm/pgtable_64_types.h
>> +++ b/arch/x86/include/asm/pgtable_64_types.h
>> @@ -187,6 +187,8 @@ extern unsigned int ptrs_per_p4d;
>>  #define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
>>  #endif /* CONFIG_KMSAN */
>>  
>> +#define DIRECT_MAP_END		(VMALLOC_START - 1)
>
> If I'm understanding the KASLR implementation correctly then this
> doesn't seem quite right - the entropy means there is a hole from the
> end of the direct map (ie. the range PAGE_OFFSET to
> PAGE_OFFSET+kaslr_regions[0].size_tb) and VMALLOC_START which shouldn't
> be used.
>
> In practice hotplugging memory into that range probably works, but it
> seems like it would set us up for future bugs. It also means memory
> hotplug could fail intermittently based on the per-boot entropy.
>
> For example with CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING set to 10T one
> could imagine hotplugging 16T would mostly work except on some system
> boots if KASLR happens to randomly place VMALLOC_START close to the end
> of the direct map.
>
> Therefore to keep memory hotplug deterministic I think it would be
> better to define DIRECT_MAP_END as a variable that KASLR sets/updates.

Right. I forgot about the hole.

> This does not look right to me - isn't DIRECT_MAP_END a virtual address
> where as the resource ranges are physical addresses? Ie. I think this
> should be:
>
> +		end = min_t(resource_size_t, base->end, __pa(DIRECT_MAP_END));
>
> The same applies to the rest of the DIRECT_MAP_END users here. Perhaps
> it would be better to define this as DIRECT_MAP_SIZE and calculate this
> based off PAGE_OFFSET instead?

Duh, yes. I shouldn't try to write patches at 30C :)

