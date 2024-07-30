Return-Path: <linux-kernel+bounces-268113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63794207E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9971C23DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB918C90C;
	Tue, 30 Jul 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FroozuDP"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625E2189B94
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367374; cv=none; b=REcTCRVrS0jCY/xsO1mCfwWlvWhlIzcUUBsChN8uVScNDpEJvv9L97+4lyH9WldCYzL/JFQNXeNltWUfm+votzPlCFGZUJJEnE4NgTe6zlsFiXnZIbngQ7/DjMbU8tdG2Pd5IsgqoRnii13E3QgbpYPibTB6horQvf+vKDAyJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367374; c=relaxed/simple;
	bh=exU5Yc8xgZaMWWaT3tSQFyGZhYBy0BCDsIGDgbVngZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3JTeLylYNCC9NGfQIdZC+8+lIZNs2EKDFJH15qQMXy2h2GrOZK/+FNqssJREWTS/qPvW2AeXT+URfEbxPp7E8iCnsLcNRCBRE4D8VVyBkeQUtBXZEc4iJQ5EnaZ/K7MK5ljsUyjMIOosTYlyCKx+9WsJzgIRyoqibfBIB4uOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FroozuDP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BbRYxi6Z1xQuUKuePlP3pOg74/6zRtxxA0g/pAZgPD4=; b=FroozuDPORgBvo1zWZ9A6Pp6fU
	6Rusqt0OEzX3jmvVUToMJziYiLHaihuI91wMclzgEeQWWlXLwfnzD2XfM/rUjZkleLlHr1BLPQI0d
	3IMrZRWXpNpqj/3RLxUUu3q5N/8stz2QMtCdVt+SBTGmeh8GvTomJJ5sm/ffT4EkuCP7FcnipDZoM
	nDfigsvFvTNlPu8RlKA+t5YVRiMOMopgGZxtnMTtaCbCGZLz7EXUVn/dt/6+Ac/k2YUuKLoq/nt+U
	EDOVC3Bpllu85BtwgzXOvcD+BwvLf9bICE45gwIZX9KV2ce3LYAm3pPfJA45thu3LCnhvB5+2/ewo
	B3YVkeAQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYsQg-000000054fN-2Jy9;
	Tue, 30 Jul 2024 19:22:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5121E3003EA; Tue, 30 Jul 2024 21:22:37 +0200 (CEST)
Date: Tue, 30 Jul 2024 21:22:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240730192237.GR33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>

On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:

> Which makes me think it's asm_exc_int3 just recursively failing.

Sounds like text_poke() going sideways, there's a jump_label fail out
there:

 https://lkml.kernel.org/r/20240730132626.GV26599@noisy.programming.kicks-ass.net

> Let's see it x86 people have some idea, but that
> 
>    restore_all_switch_stack+0x65/0xe6
> 
> and doing an objdump to see the code generation, it is literally here:
> 
>         0f 20 d8                mov    %cr3,%eax
>         0d 00 10 00 00          or     $0x1000,%eax
>         0f 22 d8                mov    %eax,%cr3

That looks like SWITCH_TO_USER_CR3

>         eb 16                   jmp    <restore_all_switch_stack+0x7d>
> 
> with that "jmp" instruction being the restore_all_switch_stack+0x65 address.

Thish would make this BUG_IF_WRONG_CR3, which starts with an ALTERNATIVE
jmp. I think we landed a pile of ALTERNATIVE patches this merge window.

That said, Boris did spend an awful lot of time testing them... but this
is 32bit so who knows how much time that got.

