Return-Path: <linux-kernel+bounces-280028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1189594C4CA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424771C260A4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF8E14F9FB;
	Thu,  8 Aug 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c+YWnb8t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCozqKQj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA81148FF6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142652; cv=none; b=OU4ly0Dn7+w1gjX6+dHotwgNEgt+NGnIDFEPLz0KsuHhn4TTvy+ufWlCpBU2DvkQwh5L1S6bYj4/uHnPrKOdNl10f7GTzTmMOKgmSPTPZO6O+UQaGtV3wRo3/pSpj/AXiJVXz4RJ4MiH43j13zWGzE+BjPT+t3EsTMpu377pvQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142652; c=relaxed/simple;
	bh=RgvLTjtsXqvx1dljrlnmlzlUHVbk42kAkn8cMGh+aAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HjSE7hFV9MhUfHHxbc92AN7BEC1bt9hlxk5u9TUsdbL8XNES58UdyOscOWjYDdCNG5vEfELgGNeUiMZErvTG9ILzRip+U8FTg6Y/eb14wi8tC+u/kN2UXa43GTVP6g6h+yomY05Rdrms2Wrmtx6I7kXdT79DtgGAUZ6fQzHnwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c+YWnb8t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FCozqKQj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723142649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lFQ9qbgGkQHynofX0hc8YhiCkhKls2r3nBy42ncXMI=;
	b=c+YWnb8t/2+gNPAI1lkGBnN3oT1HREArLLtnnTDT1x8rHMvPbEhhX9QEfPUP4bdzsDVua3
	2k5YhUWaB7vbcWEo3SbnoHy2JP4NliuduQaedZgytDpr9yqjK11g2QOj3nL+NwgfkVPwlV
	Xh1h1Pnw2vHQsJddpg5ExwUZl1NIuQf5OL29Y5AgmHTPNO+XIN9POLvx2dNTpas/eT/U6k
	OR8oV4PrBrtOLu4uEoXomldzu4XguKcs6Khtij3Hp0O83h4SRr0JWZVdvdPj3Xygy2xfOg
	pTLBQeOb3JryNxUAvKsnZX6hvE0khfhuJbcVmwTQUkKLyjbWDPBWixcxvSnRew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723142649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7lFQ9qbgGkQHynofX0hc8YhiCkhKls2r3nBy42ncXMI=;
	b=FCozqKQjeKHGZj3Fa0b6j6gA7KQZEHT0J6VzWWcyswp+x8R2W4u4zpTdfs/qTwTOtdIVX6
	KCX9psOVfmn0OHAQ==
To: Dan Williams <dan.j.williams@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, Max Ramanouski <max8rr8@gmail.com>,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc: max8rr8@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org, Dan
 Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
Date: Thu, 08 Aug 2024 20:44:08 +0200
Message-ID: <87zfpmyhvr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 09:39, Dan Williams wrote:
> Dan Williams wrote:
>> Apologies was trying to quickly reverse engineer how private memory
>> might be different than typical memremap_pages(), but it is indeed the
>> same in this aspect.
>> 
>> So the real difference is that the private memory case tries to
>> allocate physical memory by searching for holes in the iomem_resource
>> starting from U64_MAX. That might explain why only the private memory
>> case is violating assumptions with respect to high_memory spilling into
>> vmalloc space.
>
> Not U64_MAX, but it starts searching for free physical address space
> starting at MAX_PHYSMEM_BITS, see gfr_start().

Wait. MAX_PHYSMEM_BITS is either 46 (4-level) or 52 (5-level), which is
fully covered by the identity map space.

So even if the search starts from top of that space, how do we end up
with high_memory > VMALLOC_START?

That does not make any sense at all.

> That aspect of private memory has always bothered me, but I am not
> sure that is the historical assumption violation you are referring to
> above.

The historical assumption about max_pfn and high_memory is that this is
the end of the actual memory space.

Thanks,

        tglx

