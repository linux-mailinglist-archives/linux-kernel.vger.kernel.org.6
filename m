Return-Path: <linux-kernel+bounces-186693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A80008CC7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357351F21C77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D3E13F42B;
	Wed, 22 May 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oV2nk4xj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BMvdYy82"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821B41A80
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 20:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716410004; cv=none; b=AnMUThynkt9kWHD4er9QoSRnTi6KfL22YpeK5icYxVqixFVpKP1ohsYpiEbXsZvLvGVQ90sc2DsFBG4oMIVZOoOZTOCX688q3t8jozGsuY3UsCRzL8ZO3x/BEDvtew954DaRmW0vfDvql7OxUGchIGuxka9gXuU7Y3iiHRqYH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716410004; c=relaxed/simple;
	bh=tzPwgd6mpPtdr9k+ONZukSmxvPYOFq+QSJ4VIGnns7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YcGR/p0UWC4DVyhvh35fEP8ca1tSYvulucO7Jr9o/rfn574SUeQpHJxGpRbC4RXZGXVBXLbkW+ajGCqYYaWqxq/aNluTJY21Y3lQmyNWiEUajf4Gto1SfUdOxxDvqtwODNAtR9DQGSIoMtLTwqaWhjkw4fpBwM9qnFW94UFoRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oV2nk4xj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BMvdYy82; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716410001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVPu7soflFC6APg0qW4QU5kW4QlLz5zGFgZVFxvpwnQ=;
	b=oV2nk4xj5ILcDht/lpLtt68PFt5jAmMHeJ+QQXr5ZdqCe1Klc+kRAKH6yaqV7uEGq5nwLq
	A+YN21LV2qal/1kWLNWrlrPDaT6BLbUxjqA8mgJUByBJ3xQVn+ebjhcTG6pzijC3wk/2u/
	DT1TBAzIewykgLiYBeHMc5P2zXmubGvESRnN0X20sh4TEs8puAuJa429SZqx4alGLe6DFh
	xHbHM6myozU1PpgItwntQOU8hOfe5+bqG88Hxj6+VAWEYwG3o8m9eOicx4C0yiE0jARyst
	NLJ3yMi/lJTkldaHit0QK/767KkFY+9yanYoNI89PbmuMjzi/BVkRy79Lm6qaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716410001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vVPu7soflFC6APg0qW4QU5kW4QlLz5zGFgZVFxvpwnQ=;
	b=BMvdYy82LJkLEjwF0mme+5hegrVm/HTi4yksnzm0wt4KJ8IgRiX1Iudp0TNwn/Qqstq1ke
	6dBh9sYIaAOeB8DA==
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 Vivek Goyal <vgoyal@in.ibm.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Steve
 Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/head/64: level2_kernel_pgt's kernel area is built
 with _PAGE_PRESENT set
In-Reply-To: <20240522140614.fxe6tw6y5clrnve3@master>
References: <20240323232621.10400-1-richard.weiyang@gmail.com>
 <87jzjmgod2.ffs@tglx> <20240522140614.fxe6tw6y5clrnve3@master>
Date: Wed, 22 May 2024 22:33:20 +0200
Message-ID: <87a5khh9in.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 22 2024 at 14:06, Wei Yang wrote:
> On Wed, May 22, 2024 at 11:58:01AM +0200, Thomas Gleixner wrote:
>>
>>What's the actual problem you are trying to solve?
>
> Not a problem. It tries to remove some duplicate check.

I assume you mean redundant check, right?

The changelog should explain that. I really could not figure out
what this is about.

>>>  	/* fixup pages that are part of the kernel image */
>>>  	for (; i <= pmd_index((unsigned long)_end); i++)
>>> -		if (pmd[i] & _PAGE_PRESENT)
>>> -			pmd[i] += load_delta;
>>> +		pmd[i] += load_delta;
>>
>>Fixing up non-present PMDs is a pointless exercise.
>>
>
> Agree. While we are sure then range here must present.
>
> The whole process looks like this
>
>     pmd in [0, _text)
>         unset _PAGE_PRESENT
>     pmd in [_text, _end]
>         fix up delta
>     pmd in (_end, 256)
>         unset _PAGE_PRESENT
>
> Since we have compiled in _PAGE_PRESENT in this page table, it is not
> necessary to check _PAGE_PRESENT again before fixing up delta.

That wants to be in the change log.

Referencing the history of the code is definitely interesting and you
did a great job on decoding it, but for the change itself the only
relevant information is that all PMDs between _text and _end are marked
present because the whole table is marked so.

> BTW, if one entry between _text and _end is not present, we will failed to
> fixing the kernel code pmd entry, which will lead to some problem.

It does not because a non-present entry does not care about the load
delta obviously.

Thanks,

        tglx

