Return-Path: <linux-kernel+bounces-269140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCB942E22
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCBABB24B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246761AED2E;
	Wed, 31 Jul 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iRXpD+vm"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E251AE87D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428411; cv=none; b=pplyST9AGFR67qdW8JG5u87+R7Ug/0KKmwiZBE1L+3TIS41absQjqth9uw39Xp//yirhJr8Jeisd0UgOUjv0q5Z7tKjZrIiIOD/1uJkBw32Y9Tj8r9nPIhtIXA9dDbma9Awy0K/RvER9czbsddmoGwCK3o1c8HsOx3hwgsHXeuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428411; c=relaxed/simple;
	bh=XfCBT7CW2C1Zp/1mIh2BKFue4nKOdj2tHTvLAkqRFBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKzSbdwZkBCTEmUydAZ5ywR8U/00/5GGahxIgFeAVyyJydiYNsm18309CB13nh0nt2cOaQt8ZAtxNDAx7FxA/M5BHHTWF8938aa9JmLqKH0LuGeVgeEKu/H7jDZUjrfja98Jd24oFWuvBSNG0KVuHlvTK8IotGAP7UX7JspLgSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iRXpD+vm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XfCBT7CW2C1Zp/1mIh2BKFue4nKOdj2tHTvLAkqRFBs=; b=iRXpD+vmVA/ps02klXY+HltDW7
	FK5ZAC47z8wWZxthH5g6gzbcrGFUA6b3webgkueobs0BL9wwwMkp5Glc58ISVOXoFbI98GyP1+NQs
	o2yhUZ4fxWWReXOw740VvByjmiARl3wR5HW8r0Rl95uREwZ/DiG0S4NCqYp3ciO2nTKkATlFXvbvt
	hxkerZDU2KfZ452zB6fOq+CyBq4/Gh+zsFeNAUtR89o9iNRdiQQ/6t20L8OO6644jGEdFRoWFnMFe
	UkTxkhgAcoGALjTo2fwY+yCBdsNsmMUN9vydKk0pFyLk/CNeH7bK3AhwLvksE4UEOovFCizFZJ03L
	pCv80QGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ8JH-00000005DG9-0eSD;
	Wed, 31 Jul 2024 12:20:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 382C5300820; Wed, 31 Jul 2024 14:20:02 +0200 (CEST)
Date: Wed, 31 Jul 2024 14:20:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731122002.GE33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daef7867-b548-4acb-b8bf-0bdeb057d6a4@roeck-us.net>

On Tue, Jul 30, 2024 at 01:24:34PM -0700, Guenter Roeck wrote:
> An interesting bit of information: The problem is seen with many,
> but not all CPUs. For example, I don't see it with athlon, n270, Dhyana,
> or EPYC. qemu32 is affected, but qemu64 is fine. But on the other side
> both kvm32 and kvm64 are affected.

pti=off makes it go away, could be those CPU models don't have meltdown
and as such don't enable PTI.

