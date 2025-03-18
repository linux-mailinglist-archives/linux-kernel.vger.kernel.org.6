Return-Path: <linux-kernel+bounces-566102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC30A6732D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9A116BB1F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3C20B7FC;
	Tue, 18 Mar 2025 11:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4YateoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C220B7E8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298791; cv=none; b=HXQwOupXTvoHp+4bwLeYA0CUvtlRos6qxG+4rX19J7wJfiR+d4LARCw6d81NrzdX9jbjrp7YMYc//j1OpDB03b4gKivZ7gAPkwkrQP6MjyxDuFY/cVE7okk8ihlJs9Sn7T0VnuHfWuclsjSWNY3NzPFw0BPXc++SVFkXr1++6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298791; c=relaxed/simple;
	bh=Pi3tXlCdCVuWfu2QSEnnr8cG5QHyvTk2lMoea6QbjQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQiDFDnY0JgEe7+/B53eGGk1JOc3TRTwe0spD8UJv6jfiDpcId17Tb66CEWyhUOQtXbvK7L3zl0nj84T11OsUSc2apFhC2wtByYeneNmKShy/IMKdT4FANG+NGJd73sSvcOYTMyIy0MC5bcdTgWAMKufg8fUcQs8vd8aK9HGOeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4YateoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262A0C4CEE3;
	Tue, 18 Mar 2025 11:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298791;
	bh=Pi3tXlCdCVuWfu2QSEnnr8cG5QHyvTk2lMoea6QbjQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p4YateoOMouVdwOtx7ZzHjkskJCtSJqLI5jtmx1WyGdH2ieqeaS+PAII3DP8N0MIv
	 cxSnzKZwxRWNeWyAzIxuFHhXcfsarTj4TowXuA1UYILue+Q7WliDVBR1aqysJHQVEc
	 Iy795HqY3IW+yeAAY8vbzCzTJotDVlQYkbABm/fwlK1yu/89QcE20ifxi53IU17Dgo
	 StmrbOTy/py+t5sH028WoViO5Pjo2VFnCsAb8pxN77CD19SN/eBbkCE6VsDy26gIEW
	 JvGpzk95fFta6WPgTJXCBYFZsyE1ZkKgxhqmxIV4ZL8qEAxDOGGtOuzV2MuZmj0iNO
	 UjqMXEn2tUb3A==
Date: Tue, 18 Mar 2025 12:53:05 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Message-ID: <Z9leoRHkbu8Kgoed@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
 <Z9kwIYrOwO8nOpAE@gmail.com>
 <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318093736.GBZ9k-4Fu_CqwhgYt1@fat_crate.local>


* Borislav Petkov <bp@alien8.de> wrote:

> On Tue, Mar 18, 2025 at 09:34:41AM +0100, Ingo Molnar wrote:
> > That's a stupid rule, I don't know where it came from, and I never 
> > enforced it. It's not in Documentation/process/coding-style.rst.
> 
> I believe tglx came up with it - section "Changelog" in
> 
> Documentation/process/maintainer-tip.rst
> 
> Read the examples there.

Literally the first example there is kinda bogus:

  Example 1::

    ...

    When a CPU is dying, we cancel the worker and schedule a new worker 
    on a different CPU on the same domain.

  Improved version::

    ... 

    When a CPU is dying, the worker is canceled and a new worker is 
    scheduled on a different CPU in the same domain.

[ Note that I edited the first example to be a true equivalent 
  transformation to passive voice. The example in maintainer-tip.rst 
  makes other edits too which make it hard to compare. ]

How is one more word and saying the same thing in a more circumspect 
fashion a liguistic improvement?

And you don't have to believe me - I gave an LLM the following prompt:

  Which English sentence is easier to understand:
    "When a CPU is dying, the worker is canceled and a new worker is 
     scheduled on a different CPU in the same domain."
  or
    "When a CPU is dying, we cancel the worker and schedule a new worker 
     on a different CPU on the same domain."?

And it answered:

  The second sentence, "When a CPU is dying, we cancel the worker and 
  schedule a new worker on a different CPU on the same domain," is easier 
  to understand. It uses simpler language and a more direct structure, 
  making it clearer for the reader.

... and although I'd be the first one to distrust an LLM's opinion, 
it's correct in this case IMHO.

> And you and I have had this conversation already on IRC. I happen to 
> agree with him that "we" is ambiguous - with all those companies 
> submitting patches you don't know who's "we" interests are being 
> taken care of.

Few people will understand a generic personal pronoun to apply to a 
corporate entity magically, unless it's really clear and specific:

	"We at Intel believe that this condition cannot occur on Intel 
	 hardware."

in which case it's not a generic personal pronoun anymore.

Or to give another data point: since the v6.13 merge cycle we have 
merged over 11,000 commits in the upstream kernel, and over 1,500 
contain the word 'we' - over 13% of all commits. This is literally a 
pointless battle that creates unnecessary maintenance overhead and 
pointless detours for developers.

> And if you formulate your commit message in impersonal tone, it reads a lot
> clearer. It is simply a lot better this way.

Except *not even we* follow it consistently:

  starship:~/tip> gl --author=tglx --since=two-years-ago --grep='\<we\>' linus | grep -iw we
         by a context from task B and we do the check
    So it turns out that we have to do two passes of
      "The problem in current microcode loading method is that we load a
       microcode way, way too late; ideally we should load it before turning
       paging on.  This may only be practical on 32 bits since we can't get
       to 64-bit mode without paging on, but we should still do it as early
    MADT delivers we only trust the hardware anyway.
             * booting is too fragile that we want to limit the

Because it's actually a natural and direct linguistic construct.

And have a look at:

   $ gl --author=torvalds --since=two-years-ago --grep='\<we\>' linus | grep -iw we

it's 1352 examples of Linus using 'we' as a generic personal pronoun in 
the last 2 years alone...

Thanks,

	Ingo

