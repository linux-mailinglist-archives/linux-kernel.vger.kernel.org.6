Return-Path: <linux-kernel+bounces-385748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563F9B3B30
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6CCB21F55
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C461DFD83;
	Mon, 28 Oct 2024 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAahoaRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA71D54D6;
	Mon, 28 Oct 2024 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730146584; cv=none; b=F9CP53LMotNKQmevy69YcLa742sGIQOnMXrjf8oa6kTfTtJuD1m5u8pEY+vroeO0bbKjdKkhD01j/119te589xgvs+qH9AGgI6538LMv4LBansdJKVoxOl/bJUDm7guCxfEe8yrNdOfa9ZRW8YmnKo33EAwlv+RPnslW5KGIAJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730146584; c=relaxed/simple;
	bh=fjLWvA7i3GcmtkFmThjSrRbvggXCZOWfPXHA2cv34BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTV1Irzz+PXucsnfTqQ0TkZMtdeuyyM1eLYTpy0q7viJ8Sg+ODu+rg6oi79FTOpvw4i/B9Fvo5MJHy3NcTDDDsSrLFr3Skh6wE02A+gF7uxLnTzivDyDcH5vRN/zZ6Pwmu0ifYghRm8X+J/PGKXTkwKYwVPyaBpa+WFCzpoJ72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAahoaRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D69FC4CEC3;
	Mon, 28 Oct 2024 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730146583;
	bh=fjLWvA7i3GcmtkFmThjSrRbvggXCZOWfPXHA2cv34BU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OAahoaRFRkKAULaecCkblSYO+GPba2tFO+uq8Bw68fTWiA7dDLcD5Wym7qt44XcHe
	 RvEaeLb+2o5J7If9eNJ0NHSw3M5wKviodbWGjhtyN3xdydMGWRJu8BzIObgg1BmYMb
	 71XeZQdO5cr47neFj1kUtX4nu1ypCQzxV1J+AVH1rPrUKtJ6XYTNayC/+AlO3niZ0Q
	 6DVDxYCuNp69acwWGw2fcYL+HTaKaYMjmIkVpo5F0b+aCS1DoPscatgPgVJDltv5vV
	 0+GrqeKSRrrgzJ5tJ8N26MXB2wfb+ZcJSz7YAIjUqWFVoPzRxa6jmZrh+ZMjVkxI+O
	 UZ9wOZ6InmCDg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1BC86CE0876; Mon, 28 Oct 2024 13:16:23 -0700 (PDT)
Date: Mon, 28 Oct 2024 13:16:23 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 0/5] tools/memory-model: Define more of LKMM in
 tools/memory-model
Message-ID: <70907739-56b9-4712-a1db-e55161c2a8d6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>

On Mon, Sep 30, 2024 at 12:57:05PM +0200, Jonas Oberhauser wrote:
> Currently, the effect of several tag on operations is defined only in
> the herd7 tool's OCaml code as syntax transformations, while the effect
> of all other tags is defined in tools/memory-model.
> This asymmetry means that two seemingly analogous definitions in 
> tools/memory-model behave quite differently because the generated
> representation is sometimes modified by hardcoded behavior in herd7.
> 
> It also makes it hard to see that the behavior of the formalization 
> matches the intuition described in explanation.txt without delving into
> the implementation of herd7.
> 
> Furthermore, this hardcoded behavior is hard to maintain inside herd7 and
> other tools implementing WMM, and has caused several bugs and confusions
> with the tool maintainers, e.g.:
> 
>   https://github.com/MPI-SWS/genmc/issues/22
>   https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904
>   https://github.com/hernanponcedeleon/Dat3M/issues/254
> 
> It also means that potential future extensions of LKMM with new tags may
> not work without changing internals of the herd7 tool.
> 
> In this patch series, we first emulate the effect of herd7 transformations
> in tools/memory-model through explicit rules in .cat and .bell files that
> reference the transformed tags.
> These transformations do not have any immediate effect with the current
> herd7 implementation, because they apply after the syntax transformations
> have already modified those tags.
> 
> In a second step, we then distinguish between syntactic tags (that are
> placed by the programmer on operations, e.g., an 'ACQUIRE tag on both the
> read and write of an xchg_acquire() operation) and sets of events (that
> would be defined after the (emulated) transformations, e.g., an Acquire
> set that includes only on the read of the xchg_acquire(), but "has been
> removed" from the write).
> 
> This second step (comprising patches 4 and 5) is incompatible with the
> current herd7 implementation, since herd7 uses hardcoded tag names to decide
> what to do with LKMM; therefore, the newly introduced syntactic tags will be
> ignored or processed incorrectly by herd7.

Thank you, Jonas!

Queued for further review and testing.  This does need at least an ack to
proceed to mainline (hint to LKMM maintainers).

							Thanx, Paul

> Have fun,
>   jonas
> 
> 
> Changes from v1 to v2:
>    - addressed several spelling/style issues pointed out by Alan
>    - simplified the definition of Marked accesses based on a
>       suggestion by Alan
> 
> Changes from v2 to v3:
>   - addressed imprecise comment pointed out by Boqun
>   - addressed the backwards compatibility issue pointed out by Akira
>     with help of Hernan: improved version compatibility by adding
>     an error message on older versions of herd and relying on a new
>     flag -lkmmv1 to select the version
>   - integrated recent patches, like the herd representation table
>     and primitives like atomic_add_unless or atomic_and_not
> 
> Changes from v3 to v4:
>   - removed a litmus test (submitted to Paul's larger test repo instead)
>   - fixed several formatting/naming issues pointed out by Akira
>   - updated the reference herd version number in memory-model/README.md.
>     *Note*: this may need to be retouched after herd is updated.
>     I also did not update the table under klitmus7 compatibility, which
>     I took to refer only to klitmus7, although its header is "herdtools7"
> 
> 
> 
> Jonas Oberhauser (5):
>   tools/memory-model: Legitimize current use of tags in LKMM macros
>   tools/memory-model: Define applicable tags on operation in tools/...
>   tools/memory-model: Define effect of Mb tags on RMWs in tools/...
>   tools/memory-model: Switch to softcoded herd7 tags
>   tools/memory-model: Distinguish between syntactic and semantic tags
> 
>  .../Documentation/herd-representation.txt     |  27 +--
>  tools/memory-model/README                     |   2 +-
>  tools/memory-model/linux-kernel.bell          |  33 ++-
>  tools/memory-model/linux-kernel.cat           |  10 +
>  tools/memory-model/linux-kernel.cfg           |   1 +
>  tools/memory-model/linux-kernel.def           | 196 +++++++++---------
>  6 files changed, 150 insertions(+), 119 deletions(-)
> 
> -- 
> 2.34.1
> 

