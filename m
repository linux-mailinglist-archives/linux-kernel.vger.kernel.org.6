Return-Path: <linux-kernel+bounces-562309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A3EA6228A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E638820BA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1CCA2D;
	Sat, 15 Mar 2025 00:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw8m3b0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E2367
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741997357; cv=none; b=ORGrZNzGnlSm3VO+UepoZ1yBQ12D5DWjHiTHEU6dhULsU+6NpxXMEmsA14vRfc/8fWjyj/jBc61Q+WF1oLNbhgNRQlx8m8A51N8cUzqpuGhdvwzH6PagYtHrWVph/uQg3mEySMDPQDxFlj+bJygjaVjonSZxVRHrbpv0H/Zl8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741997357; c=relaxed/simple;
	bh=1hzQXG5cAVBTHOofZVU8ev8nYzxsc97HHdljY3+t8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojqmCvO9NpamEbGGQOz2a3EV/NJVeobpVMa0JF9UumTxTeMEeBmJsz7Im+I0TIyjMZorRkru+TiQpUykW3HsFQsQQq3T11YHitb264pFXL/vVPfmfSQ23FqxV5Cq4PqJpkl2+i3y2gkbSjbPJBInoNTrawpGXAJnHyfG9JQD1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw8m3b0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76706C4CEE3;
	Sat, 15 Mar 2025 00:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741997357;
	bh=1hzQXG5cAVBTHOofZVU8ev8nYzxsc97HHdljY3+t8BE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw8m3b0L4PejpOYOOHZFHQw/XP11RU/fABCc2fBve5e1cAX9mK0hFo+IsfRkPY5bz
	 5e9cRTf34nxigOFZC5swNuQo0CWwWCnFrhMqmYpvkzv7dUngvN4s/MVXwjDVZAwc2+
	 yjEYLSEDKXWERb3X57vLDnM+Suu6dVTba0yn+5IWyUP0o1wn6+o/250sTvCdDguf+z
	 bDCJljSs3PBWjZzO87+oBTJZWtDlWOse1xoR6weUqTfCiw39JTwXsuhfEaRiLSs7qE
	 X/hGLtw9Gk3S/HQsqia7QmPiB0S40RCund9acIdamhuZJ7JP2lqNdbWa4I8w+u6n2t
	 ZujMcavdGBkZw==
Date: Fri, 14 Mar 2025 17:09:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, 
	Uros Bizjak <ubizjak@gmail.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 14/20] x86/barrier: Use alternative_io() in 32-bit
 barrier functions
Message-ID: <jdcd4zoezsi7beoak43dqzkxnel7hqdhtyqbf4cqr6rvs3qfyf@i2qhxrld5p5l>
References: <cover.1741988314.git.jpoimboe@kernel.org>
 <1c2fe7f93c4dd8a87c2e1fa8b780a8a2968be445.1741988314.git.jpoimboe@kernel.org>
 <CAHk-=wjtvTPERDdrok2kDrSSFBjqHCCNVff95VVxhvP6wCC6jg@mail.gmail.com>
 <CAHk-=whH5bHRYB12aAcb=nK7erOmOSo6o2FXjHtxObWumFANHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whH5bHRYB12aAcb=nK7erOmOSo6o2FXjHtxObWumFANHA@mail.gmail.com>

On Fri, Mar 14, 2025 at 01:54:00PM -1000, Linus Torvalds wrote:
> On Fri, 14 Mar 2025 at 13:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > because that ARG(), ARG(), ARGC() pattern looks odd to me.
> >
> > Maybe it's just me.
> 
> Oh, and the other thing I reacted to is that I think the
> "alternative_io()" thing should be renamed.
> 
> The "io" makes me think "actual I/O". As in PCI or disks or whatever.
> It always read oddly, but now it's *comletely* pointless, because the
> new macro model actually takes pretty much arbitrary asm arguments, to
> the "both input and output arguments" no longer makes any real sense.
> 
> So I think it would be better to just call this "alternative_asm()",
> and make naming simpler. Hmm?

Thing is, we still have alternative(), which is also an asm wrapper, but
it's for when the caller doesn't care about adding any constraints.

So the "_io()" distinguishes from that.

-- 
Josh

