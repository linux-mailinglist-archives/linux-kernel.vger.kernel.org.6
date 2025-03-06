Return-Path: <linux-kernel+bounces-548690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B94A54816
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF823ACF42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7779E20B7FE;
	Thu,  6 Mar 2025 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dv3M3oLO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CFA20B7F4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257518; cv=none; b=Emh1/FF5UeFdI9/SzWb7Ssl8i/3z49kBraj3N101L0eBIhDk0YjU+YQQO5Lz/spf77MwPi0ZibdoK7kHz9puMMMju2YsJh313BM6u0IP3H7/Ewj79XNQo57wdu/od2yvETJsik8fiubJs1WCSldD+85HFEUa5PklSemJsR7kc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257518; c=relaxed/simple;
	bh=VRn/SZWmw/bW0rQEjT7PzLCCcJGdgMGZDEhJbkRHnjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5BRMGAov+K5gitAqgs6C46Gv1gdrov82EEh0rNPk5ONa/f3S+CbNSOfi9R0l9P3Edql+LhxpgXovNK6Xr3EEWDrI0hG08i/CXMfZOzNeJoU3Jrrste3l1Ha0yWnRP4XjZkbhejRgEebj8VxTJOHyb2EqeXsFCFm+I6RtHQK3Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dv3M3oLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36596C4CEE4;
	Thu,  6 Mar 2025 10:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741257518;
	bh=VRn/SZWmw/bW0rQEjT7PzLCCcJGdgMGZDEhJbkRHnjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dv3M3oLOvdBNO8wFIfLXNCt7Rag8zv5W6ntmdb7N074dpRtX+Z+EhJE+WCtacHPG6
	 7SXCNis9TYBRPTZZql5NXswU+aPC2OsNQVprGwF5DysjWJQxkWCOAofPZsPb75bN/x
	 aS/MtuID6wxU3P/PVIm4ZCURcjq6F6yrPBQJWBWJhTQfMqnnE8IdlTVmyKAqoeMKg8
	 RuB/CzK1BcpeRcn0tdnyJ/aeFAhQWJF0VQGAvSUHz52F07TkmNgL+hB+sS31/Zd/eW
	 loH4J268TohWeNzVpy6rBN0CmUYrbBLXQDGMrHkPzXkB7h0qVaN8DZjoWU9iaUoGcP
	 bAHgftbSih2VQ==
Date: Thu, 6 Mar 2025 11:38:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -tip] x86/locking/atomic: Use asm_inline for atomic
 locking insns
Message-ID: <Z8l7KeVvvHvmPmRc@gmail.com>
References: <20250228123825.2729925-1-ubizjak@gmail.com>
 <Z8lxmPmnJhBmPRvl@gmail.com>
 <CAFULd4btTdUrF6fTqafyViuaB+V8QD-s0pLE6XWb7BYzYAPmZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFULd4btTdUrF6fTqafyViuaB+V8QD-s0pLE6XWb7BYzYAPmZA@mail.gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> > So these are roughly the high level requirements around such patches.
> > Does this make sense?
> 
> In my opinion, the writing above makes perfect sense. As far as I'm 
> concerned, I'm able and can do the above code analysis, the 
> problematic part would be precise performance measurements. Although 
> with your instructions, I can also try that.

Yeah, so *personally* I find the kind of code generation analysis you 
routinely perform for your micro-optimization patches far more useful 
and persuasive, because it's basically a first principles argument: 
instructions removed are an inarguable positive in the overwhelming 
majority cases all other things equal (as long as it doesn't come at 
the expense of more function calls or worse instructions, etc.).

For inlining decisions code generation analysis is arguably more 
complicated - but that's the nature of inlining related patches.

Performance measurements can back up such arguments, and being more 
proficient in perf tooling is a useful toolbox to have anyway, but it's 
fundamentally a stohastic argument for something as comparatively small 
as a +0.12% code size increase.

But if code generation analysis is inconclusive or even negative, then 
performance measurements can trump all of that, but it's a substantial 
barrier of entry as you noted - and I'm somewhat sceptical whether a 
0.12% code generation effect *can* even be measured reliably even with 
the best of expertise and infrastructure...

Also, to shorten build & test times you can use the x86-64 defconfig. 
It's a config more or less representative of what major distros enable, 
and it's even bootable on some systems and in VMs, but it builds in far 
less time.

Thanks,

	Ingo

