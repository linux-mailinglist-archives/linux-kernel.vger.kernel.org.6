Return-Path: <linux-kernel+bounces-248399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DC92DCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7E01F2452C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2A4155CB8;
	Wed, 10 Jul 2024 23:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZ83WA0O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE71154BFE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654096; cv=none; b=FT7+XnH9mpdCtDFTAicyynL7iKxv4jzdFmU9ayerIcK1OxU2z9D6QiP/03Jd9/Sclnm/2liNCwRPEgLceW24LsLiEly7BVEI+PAEKtubkB74bwsErq58Rq4gj1FdJPJy5S/7zLiwUGBjGoj0eNuhxKpjwZMKxNeA5tFvrsJG6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654096; c=relaxed/simple;
	bh=bsHvnpV6OsDqnbtUYAcvVXDHmw8BcLBtbrr0H3pEvTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfWfpz6FnfxGTFZmZKvfuzZub3iUWpz87DDWPdu9d3Hxnt7sO+th7QzTKQMt0Ds7RVOsWctLR1aK5b6t+E3EzvN0Gbl1RC5W+n7UCKcBESBqNid/HMI1T0yUrosX77ywbQVxCFJNddjikMrCibAbvjjEaEtUJIKRCADtC2CZqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZ83WA0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02749C32781;
	Wed, 10 Jul 2024 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720654095;
	bh=bsHvnpV6OsDqnbtUYAcvVXDHmw8BcLBtbrr0H3pEvTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZ83WA0OjrqWn2TyhwMvEQL+5f1JTxE2eCMCGulddW6Lxs07XBjoNK6Ot1Tx36hSk
	 r1M1T1wIx3ZepmpGjPuF4v0N+5ait94ARIGx02A5UsDW9JM10P0zTEnbtPl5KUCw3N
	 wHBHmMWMcBJkC6JsvDXY/FMrRo7QPYK7Ry+M12rUYYysjsDmhu0hWwAa5HZYbEMfCF
	 ErnL4Htrb/heTnyZ/XxmtBCrJpLNwcXqn5bDYV7ni0UEnHIoTi+pVqzCla+oJOIF4E
	 GVMcylUKAMUCgl637GgBMPgKlOcGvHYs8i8FN39SO5Rl5nF91bFb938PnOuhPhB7cp
	 k4FGDQOqvyJlg==
Date: Thu, 11 Jul 2024 00:28:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64/fpsimd: Ensure we don't contend a SMCU from idling
 CPUs
Message-ID: <Zo8ZDBisWJonBVqF@finisterre.sirena.org.uk>
References: <20240618-arm64-sme-no-cpuidle-v1-1-1de872e1691f@kernel.org>
 <Zo7qzWVXRWulVtCT@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L3/FjBYZ6N0R7tlh"
Content-Disposition: inline
In-Reply-To: <Zo7qzWVXRWulVtCT@arm.com>
X-Cookie: Your love life will be... interesting.


--L3/FjBYZ6N0R7tlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 09:10:53PM +0100, Catalin Marinas wrote:
> On Tue, Jun 18, 2024 at 02:57:42PM +0100, Mark Brown wrote:

> > When we enter the kernel we currently don't update any of the floating
> > point register state until either something else uses floating point or we
> > get a CPU_PM_ENTER notification during suspend or cpuidle. This means that
> > for a system which has been configured with both suspend and cpuidle
> > disabled we will leave whatever floating point state was loaded in the
> > registers present while a CPU is idling.

> I guess this approach is useful when the kernel does a light WFI rather
> than going all the way to firmware for a deep sleep state. In general,
> the shallower the sleep state is, the more CPU state is retained. From a
> power perspective, I wonder whether we should leave the decision to drop
> the SME state to a cpuidle driver.

The concern here is if we don't have a cpuidle driver - we could also
make this conditional on !CPUIDLE.

> Which situations should we consider for such idle scenario (we discussed
> them offline briefly)? I think:

> 1. Thread migration: a thread using SME is moved to a different CPU.
>    Here SMSTOP makes sense because a new thread scheduled eventually
>    will need a different SME state.

> 2. Thread page fault followed by waiting for I/O etc. and the kernel may
>    switch to idle. Here it's probably less beneficial to do an SMSTOP.

> Any other cases? Blocking syscalls don't matter since we don't preserve
> the state between calls.

For syscalls we explicitly disable streaming mode, but we do allow ZA to
be active so you might have a blocking syscall with ZA enabled.  Having
state in ZA is less of a concern than streaming mode, it will have a
power impact but it is much less likely that there will be a performance
impact on other cores.

> The trade-off is for case (2) above and it depends on whether it happens
> sufficiently often to be noticeable. I wouldn't think so.

Yes, to me it seems much more likely that we would decide to schedule a
task out while it was using SME rather than getting faults where the
overhead of reloading the state was noticable.

> > +	/*
> > +	 * Leaving SME enabled may leave this core contending with
> > +	 * other cores if we have a SMCU, disable whenever we enter
> > +	 * idle to avoid this.  Only do this if they're actually
> > +	 * enabled to avoid overhead in cases where we don't enter a
> > +	 * low enough power state to loose register state.
> > +	 */
> > +	if (system_supports_sme() &&
> > +	    (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)))
> > +		fpsimd_save_and_flush_cpu_state();
> > +}

> Do we always enter here via the idle thread? If we already had a thread
> switch we probably don't need to save the SME state again, only flush
> the state.

If we've actually switched the thread then TIF_FOREIGN_FPSTATE has been
set and we'll just check the flag and return for the save portion rather
than actually writing any register values out so the overhead should be
minimal.  It feels safer to check in case we get better at doing the
save lazily.

Otherwise arch_cpu_idle_enter() is called from psci_checker as well as
the idle thread, this code should not be relevant either way in that
context since it runs before userspace and AIUI it's trying to do the
same thing as the idle thread there anyway.

--L3/FjBYZ6N0R7tlh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaPGQsACgkQJNaLcl1U
h9AcJgf/WczOs8zGYGk/ksHNcmmtVfaMpXvJbYh48xv8SU6tcvX618rujjbXrnCs
u3RCm5zf6+UO17cbLhmUeo5AgWiII9DUVi3VRCX1njulCmMgPwfRTAmbd5SGvfoD
Zs2SbNu2wvqIdJ0XGet7hOTGfJhlR72I4sakdBSqVMNdIgAjeH+m3cnlLFdnuHyb
pq42opUq2UzCar+leEzTkdmfdONXwfqA2KfBiA5vuQOuVee2ZqJrkJJ5X32yEuZz
ZkgGhaqg5v6/xIFMNKgHVZv3vbxeMW8Ny7nOlYW2eKi/f9CnKuE10M5kCqgoJIsw
a3l9UZ8v0isUSLgDyucTUt6rxWCQmA==
=oPw6
-----END PGP SIGNATURE-----

--L3/FjBYZ6N0R7tlh--

