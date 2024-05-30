Return-Path: <linux-kernel+bounces-195610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2D8D4F42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10CCD285C18
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC3182D3B;
	Thu, 30 May 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lw/JMKK6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D5182D01
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083652; cv=none; b=Sw9+maHlCYWuSoLRijR55WGJhO185SOzQf/mfXph69hchlx1JA3tiyR1ejsbQn2Af3sSfgjy7HfaruKtU8E18MbINP1fArtTqvKoAT9+ICpawBGXlhYYxGRCz4t+UYy/Oa4DNWCk3n9y/PncgQ+W/oe1R+JaDdQDHrJ7uSRQES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083652; c=relaxed/simple;
	bh=bi2dy1JH5i6qd8dR05t2RFgbb5YxpsCSkK8He6pwaPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNle834Hse0Hizp0ZIaMMOTBeggBdCjUrOA6MX3+MCI20ilL3bQ2yZfK1i5E0Ut2HKfPo/qOi/GMvmk8EyHT3egkhBCiBbdMMUgETfSvBSZEtRWLViznYyoCwvKbQo1kSdprXMe61SgFFkdKQuQbwiijWzdcZkgzsaoJ30Ik2Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lw/JMKK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B857EC32781;
	Thu, 30 May 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083652;
	bh=bi2dy1JH5i6qd8dR05t2RFgbb5YxpsCSkK8He6pwaPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lw/JMKK64FM/ys7PssXjAU7fjFJY0Eh/vuSfeYRoEHikqTEsgDseOqOcSldF9QQts
	 PvAbVjIVMnpC1tPKkiXjRzle0+WEOJNA5ODnss+aOkvCv/500U5qdOSX/TMqNGggAu
	 DuQaSWMYWjKNe4T8VYQya4HVS3an7rXL09IT5wDDCLH/iE+FY1NY118ki8KRkSAO53
	 vew3d2fbElqmykbVk0O9LJ1RJtbPdEc3xv5bYmJKJgYpdaciT9MD9wmV2k1GSiR3L5
	 QqVBQAMojyqRjvETvcVkTb5miYArd5Iykdj2RqlQFP3Z3pPuY14RbU6MDntYiV2ln3
	 193lz3GwZh/qg==
Date: Thu, 30 May 2024 16:40:47 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Message-ID: <bac071f3-76fd-48fa-92fc-3a511759aa67@sirena.org.uk>
References: <20240529-arm64-sve-trap-mitigation-v6-1-c2037be6aced@kernel.org>
 <ZliFrIRcH1zbOeiU@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Mw6N+ieN4n79Ouzd"
Content-Disposition: inline
In-Reply-To: <ZliFrIRcH1zbOeiU@e133380.arm.com>
X-Cookie: To err is human, to moo bovine.


--Mw6N+ieN4n79Ouzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 03:03:42PM +0100, Dave Martin wrote:
> On Wed, May 29, 2024 at 08:46:23PM +0100, Mark Brown wrote:

> > When we are in a syscall we take the opportunity to discard the SVE state,
> > saving only the FPSIMD subset of the register state. When we reload the
> > state from memory we reenable SVE access traps, stopping tracking SVE until
> > the task takes another SVE access trap. This means that for a task which is
> > actively using SVE many blocking system calls will have the additional
> > overhead of a SVE access trap.

> Playing devil's advocate here: doesn't a blocking syscall already imply
> a high overhead (at least in terms of latency for the thread concerned)?

> i.e., does letting TIF_SVE linger across some blocking syscalls make a
> meaningful difference in some known use case?

I don't have any solid examples since I didn't do physical benchmarking
yet (the only thing I have access to is Graviton, I need to figure out
deploying kernels there for test).  I am always slightly nervous about
only benchmarking on big cores, though for something like this they
might well get more benefit anyway.

> Could your instrumentation be extended to build a histogram of the delay
> between successive SVE traps per task?

You could do that instrumentation, what I had was extremely crude
though.

> There's a difference here between a task that takes a lot of traps in a
> burst (perhaps due to startup or a specific library call), versus a task
> that uses SVE sporadically for all time.

The pattern I was seeing was mostly either a very small number of SVE
uses during startup and then none for the rest of the runtime or
otherwise SVE used on comfortably over 50% of the restores so I didn't
look super hard.  I'd expect you will see some things more in the middle
where a non-SVE application uses a SVE enabled library (eg, a JIT that
doesn't generate SVE code doing calls out occasionally to a C library
built with SVE) though.

> I wonder whether the sweet spot for the timeout may be quite a lot
> shorter than a second.  Still, once we have something we can tune, we
> can always tune it later as you suggest.

My instinct is that a second is probably on the high end, yeah.  Given
that it's just pulling numbers out of thin air I went high to minimise
the impact on tasks that are actively using SVE for a long time,
guessing that short running tasks are likely to not get scheduled so
often anyway and they only pay the cost when preempted.

> > +			if (time_after(jiffies, current->thread.sve_timeout)) {
> > +				clear_thread_flag(TIF_SVE);
> > +				sve_user_disable();
> > +			} else {
> > +				sve_flush_live(true, sve_vq_minus_one);

> Didn't we already flush Zn[max:128] as a side-effect of loading the
> V-regs in fpsimd_load_state() above?

Looking at the pseudoode for V[] that does appear to be true for the Z
registers since we are now setting the vector length, but we do still
need to worry about the P and FFR registers so there still needs to be
some flush.  Unless we're both missing something there there's room for
an optimisation here, it won't make a difference for 128 bit VLs since
we skip the Z register flush there anyway but it would help with larger
VLs.

> Also, unless I'm missing something, prior to this patch we could just
> fall through this code with TIF_SVE still set, suggesting that either
> this flush is not needed for some reason, or it is shadowed by another
> flush done somewhere else, or a flush is currenly needed but missing.
> Am I just getting myself confused here?

With the current code we will disable SVE so the contents of the state
only accessible with SVE become immaterial, we deal with it when we take
an access trap.

With this patch we will leave SVE enabled so we do need to ensure that
the visible SVE state is flushed.  As you point out we no longer need to
flush the Z registers even for larger VLs since SVE is always enabled
for EL1 and this patch means that we always set the vector length if the
task has TIF_SVE.  Setting the VL means that the constrained
unpredictable choice between zeroing the maximum or currently visible
upper bits in the Z registers will always zero all the bits that EL0
could access.  We do however continue to need to flush the predicate
registers.

--Mw6N+ieN4n79Ouzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZYnf4ACgkQJNaLcl1U
h9BH/Af/ZjVlG2wP2REXw/799jMZW00bhKv5xxae5aTMp/wYxs1TXyDDo9aF6CbJ
O/d7A7883Dv8aJc1PaXfWACnLssnA9thQo1IAywiybo9iPv9v+5okVhuucHXvW4W
b5uEyqbM+nAKxIoSkTZbA1yecZsXc3XFHQ061hjDv3QA2qgVzkjnYQW7tkmzclzL
Eb+QyVXqt4JFtS6vA7XcME0ptyxQs/PXtwmzDnupnxrheLNmHsrF5Iq942ekDJOD
S1767PQ2gL1lrWqJwTG8j2pra6tvTzZlpZEFCoVcH6/PumpMcLkE3NotqBEf9fHU
UadtldqO+eyMcbZv6H8XBHGIjp0m/w==
=QFcO
-----END PGP SIGNATURE-----

--Mw6N+ieN4n79Ouzd--

