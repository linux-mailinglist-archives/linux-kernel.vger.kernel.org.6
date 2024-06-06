Return-Path: <linux-kernel+bounces-204708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB28FF2EE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0F74B2C750
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B88198843;
	Thu,  6 Jun 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbGf5zDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA021340
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691857; cv=none; b=QUXGXl7ICUBqsvMPfTA59CXbxZvN6D8QneoVEnzRbplcoug6EFcbqqEN6XjgnHrZ7Vt6HdDIZxvgZt5uUw/M6fQXZ/9z0VRbYnPNUSUeBrIBSpbmEjhxxB6HCPCoC5yodrJKkAYLsKcdnNjSY9kzCXzelTLK9l48XX0aHkhFimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691857; c=relaxed/simple;
	bh=dV5l9/2KlgdMTnEfn5xLgjte1stGsB+A4NqfT1+wkB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbQxtrqr3jYpRT12FbTKWkIDz29xSgKvx18lHCL83yKBwEmy7ARAZJxZ4zHOHP2qONWXUjzJ1jUypnIERNR6Fi9BFOm5qXTiic+uLyQunVgERhjzRnYVajsuCEjCd94lNBg4pFRaPLdS3yX1kNA3YDDNjynQe8EPwBvNpELAcCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbGf5zDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE82C2BD10;
	Thu,  6 Jun 2024 16:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717691856;
	bh=dV5l9/2KlgdMTnEfn5xLgjte1stGsB+A4NqfT1+wkB4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=YbGf5zDW7RSbEfRaKUeYJECNoSKahkXzKHR5x2tZv7x9pzyTT4HM+C9F3c9jh53of
	 0uj3K8DUMwVF/p3DCqmNAybAYaIharl3XBwWV+SpJfJj5J97iiu5gmnywTxtvqjbDF
	 d/vetSOst5+uIP9o6TlG9MhBRqgrR1vf+mQeSlt+KE1g2g5UVi6yqhcoyaz99C/yLg
	 DpBtakjSLxZIwvrZxBe9rfh395bALCO0QoEPKxpBrjuaDtNcWL1RE0odcd9V6vWBMT
	 u95TWgYNlQYAmfz6Asr9jAA8hcHRMAWE8dNyIMenVxZeDfNhx0aCziEFoCkRsbppRV
	 /z4LdA0+lYSdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1D676CE3F34; Thu,  6 Jun 2024 09:37:36 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:37:36 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
	joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
	frederic@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/4] tools/memory-model: Define more of LKMM in
 tools/memory-model
Message-ID: <cbced924-3f22-484d-8e65-4eebe7c9329a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240604152922.495908-1-jonas.oberhauser@huaweicloud.com>
 <88c1ebc8-4805-4d1d-868a-889043899979@rowland.harvard.edu>
 <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc3bd10-3bf5-4b1a-a275-dd328c42e307@huaweicloud.com>

On Wed, Jun 05, 2024 at 09:58:42PM +0200, Jonas Oberhauser wrote:
> 
> 
> Am 6/4/2024 um 7:56 PM schrieb Alan Stern:
> > On Tue, Jun 04, 2024 at 05:29:18PM +0200, Jonas Oberhauser wrote:
> > > Currently, the effect of several tag on operations is defined only in
> > > the herd7 tool's OCaml code as syntax transformations, while the effect
> > > of all other tags is defined in tools/memory-model.
> > > This asymmetry means that two seemingly analogous definitions in
> > > tools/memory-model behave quite differently because the generated
> > > representation is sometimes modified by hardcoded behavior in herd7.
> > > 
> > > It also makes it hard to see that the behavior of the formalization
> > > matches the intuition described in explanation.txt without delving into
> > > the implementation of herd7.
> > > 
> > > Furthermore, this hardcoded behavior is hard to maintain inside herd7 and
> > > other tools implementing WMM, and has caused several bugs and confusions
> > > with the tool maintainers, e.g.:
> > > 
> > >    https://github.com/MPI-SWS/genmc/issues/22
> > >    https://github.com/herd/herdtools7/issues/384#issuecomment-1132859904
> > >    https://github.com/hernanponcedeleon/Dat3M/issues/254
> > > 
> > > It also means that potential future extensions of LKMM with new tags may
> > > not work without changing internals of the herd7 tool.
> > > 
> > > In this patch series, we first emulate the effect of herd7 transformations
> > > in tools/memory-model through explicit rules in .cat and .bell files that
> > > reference the transformed tags.
> > > These transformations do not have any immediate effect with the current
> > > herd7 implementation, because they apply after the syntax transformations
> > > have already modified those tags.
> > > 
> > > In a second step, we then distinguish between syntactic tags (that are
> > > placed by the programmer on operations, e.g., an 'ACQUIRE tag on both the
> > > read and write of an xchg_acquire() operation) and sets of events (that
> > > would be defined after the (emulated) transformations, e.g., an Acquire
> > > set that includes only on the read of the xchg_acquire(), but "has been
> > > removed" from the write).
> > > 
> > > This second step is incompatible with the current herd7 implementation,
> > > since herd7 uses hardcoded tag names to decide what to do with LKMM;
> > > therefore, the newly introduced syntactic tags will be ignored or
> > > processed incorrectly by herd7.
> > 
> > The patches look good to me.
> > 
> > Just to clarify: Your first step encompasses patches 1 - 3, and the
> > second step is patch 4.  The first three patches can be applied now, but
> > the last one needs to wait until herd7 has been updated.  Is this all
> > correct?
> 
> Exactly.

Just to make sure that I am following along properly...  My belief is
that there will be a new version of this series.  Please let me know if
I am missing something.

							Thanx, Paul

