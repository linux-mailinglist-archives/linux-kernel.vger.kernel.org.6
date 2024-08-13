Return-Path: <linux-kernel+bounces-285479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4B0950E04
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB5D1C22DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87241A7043;
	Tue, 13 Aug 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ckDkVz2Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sSHSUH8C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B241A3BD7
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723581463; cv=none; b=h9hd94unKPsgI44S8QmRtSZGM2EDfTEJ2uQXrm6hyPwRbX5muZTRP0egrnI3FR5agfvUv/YMrwqeOhczG12U7HNhUQ3QxUWDr1dgO7ETL6qJ0vheg6T1gWQ9bLrCq8pd+hMVwQbewYLwWuJ8ooXwcPUs9tZB+cj3QrwBvXyrI7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723581463; c=relaxed/simple;
	bh=ucrUkuUcTOokumv7qFjvbonPM5qo+67wkUvO88FE42E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PfOnECbxYsS9O9hVLhXJfd66QoLL6C8W3llmSvzcPK/bAscC40nLDK08cYV5FjIcOOCAy1VRruZxf43KqEseoZLGH4QG/e3ZCyUvSsB6lu6FblfkooIfVBn+sHFNM3Sgnj7Soq60tLVFvLtmv1pTkAfzwqSb0bh5wkxN8i/8tQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ckDkVz2Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sSHSUH8C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723581460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMyAWMlCvkMVYofPmgCvHs5joWjD8waWUUwkGJ/7ocw=;
	b=ckDkVz2YWb72l0idHAdFbpj+7GBXSSXFAE12GSxZf0Fjr85JOZoOzeq4qrsmaN/sMEhzZM
	b11KrbbxtmdMQoy/hauHKni9oiCUQT1xxk/V9mH3jp0NXfYPkoHOjQBW9g7GIwvsVvg0Qk
	hliiVO33xOsJJG8i8ph28jTVRrKMLFJ85FrHovgZa8Th23g3PSWI9K4KnybJ/gi0pdRW/U
	DYpTb7DmKSm0c7Jw+cq/PA+22i1xw4++H5g8Xr5qoNT7siwpMLa9vLMk9iF3K6I8rH33P6
	EY7Dxph9+hyEreC//s2JzsQKTOSAtBgVLziavK67UdX1KzW6xRYS6krogCgECQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723581460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sMyAWMlCvkMVYofPmgCvHs5joWjD8waWUUwkGJ/7ocw=;
	b=sSHSUH8CHF93lf+XyejOCxege9aNPgBWWJQZgIWiCO7YNufqJktcnSjDAxQechVBl4S71s
	dEWN3KKWnNWs5DCg==
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
  Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <87sev8rfyx.ffs@tglx>
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
 <87ikw6rrau.ffs@tglx> <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal> <87sev8rfyx.ffs@tglx>
Date: Tue, 13 Aug 2024 22:37:39 +0200
Message-ID: <87le10p3ak.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 13 2024 at 10:20, Thomas Gleixner wrote:

> On Tue, Aug 13 2024 at 11:33, Alistair Popple wrote:
>>> On Mon, Aug 12 2024 at 12:03, Thomas Gleixner wrote:
>>>  
>>> +#ifndef PHYSMEM_END
>>> +# define PHYSMEM_END	(1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT))
>>
>> However I think this should be:
>>
>> # define PHYSMEM_END	((1UL << MAX_PHYSMEM_BITS) - 1)
>
> Bah.

Aside of that the x86 define must not be inside
CONFIG_DYNAMIC_MEMORY_LAYOUT, it needs to be:

#ifdef CONFIG_RANDOMIZE_MEMORY
# define PHYSMEM_END            physmem_end
#endif

because CONFIG_DYNAMIC_MEMORY_LAYOUT is also selected by 5-level page
tables independent of KASLR. It does not need an else clause either
because that is covered by the generic fallback.

I'll send out a proper patch later.

Thanks,

        tglx

