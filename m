Return-Path: <linux-kernel+bounces-429890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D939A9E2837
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFA7287338
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCF71F8AF8;
	Tue,  3 Dec 2024 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YptYq9x8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF11304BA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244796; cv=none; b=dkclXNomUbT44CjDKZQEoekMhlmzxEgMvPybtDmMayjqTSvv99CK3Btun7Rrz6RgpiRxL1dOwi3pQtlrplnpEX5L/pJoBzuh01PgBPrmQuLJOIsEi7CYa3OpMJKie7p+4JBnnH7NRJ8A5RTmGO0VP2jqq23J6INiDDOY1D22Fds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244796; c=relaxed/simple;
	bh=n/0zLPb5Wfwf5ixhKJ0hEDqs+kdK/IJ6TEf/PR1iuOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDZtDZFOP5nro2k/inb5eX/hFI/2uVAQHbtLYItXxp0EMGlr+g2TxiIBlHhqW/0azD4xdzYguYuGHhG152qOuhWJl3VE8Sx4ZiUkIUyyRD4yFgS23uvCF0pZpPTzCy2GvlJlm5v6E93W90RcydevHBn4NM7CA6tkelB3VUp+zGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YptYq9x8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E1C4CECF;
	Tue,  3 Dec 2024 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733244795;
	bh=n/0zLPb5Wfwf5ixhKJ0hEDqs+kdK/IJ6TEf/PR1iuOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YptYq9x8eFznxIF25GEkMXFyi7kalYe5TIcRjtkiQGIsQyv9nXlg40Kf6/MvqJwtb
	 4e+mPkX8FVCpzOFtzn3rn8GFQY6EystAGLzNQJgEOuV2r0k82cbiI5qoWBGwDJdFBf
	 dfJDG5JfqCA83eOe0zDRRTauC+3X5ivRKIMnqCVeZGCBt4nhSTpe0xXq8KZKf8aEx4
	 vGTKzuZuLvaeWibVCzU9CVBwuOC2RIgUUWGHxJvHnF7ia85B5G+D7KEve0pXfVveDA
	 a3fSUDOu1Lsvw071pEvsuCssZxMFQtgVs3W7vWlG4RMLYUmSWTowuIM7E1lKzPzGIp
	 TEL0WAZGdsQ7w==
Date: Tue, 3 Dec 2024 16:53:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arm64/signal: Consistently invalidate the in
 register FP state in restore
Message-ID: <f9e297ab-8325-4b48-b8fc-21486ff48cd2@sirena.org.uk>
References: <20241203-arm64-sme-reenable-v1-0-d853479d1b77@kernel.org>
 <20241203-arm64-sme-reenable-v1-4-d853479d1b77@kernel.org>
 <Z08k6QsYRzO8+O4t@e133380.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hX1yMOOoh6B0Yabs"
Content-Disposition: inline
In-Reply-To: <Z08k6QsYRzO8+O4t@e133380.arm.com>
X-Cookie: Alimony is the high cost of leaving.


--hX1yMOOoh6B0Yabs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2024 at 03:34:01PM +0000, Dave Martin wrote:
> On Tue, Dec 03, 2024 at 12:45:56PM +0000, Mark Brown wrote:
> > When restoring the SVE and SME specific floating point register states we
> > flush the task floating point state, marking the hardware state as stale so
> > that preemption does not result in us saving register state from the signal

Now I think about it again this should probably be dropped from the
series, or at least ordered after the reenablement.

> > +	 * thread floating point state with preemption enabled, so
> > +	 * protection is needed to prevent a racing context switch
> > +	 * from writing stale registers back over the new data. Mark
> > +	 * the register floating point state as invalid and unbind the
> > +	 * task from the CPU to force a reload before we return to
> > +	 * userspace. fpsimd_flush_task_state() has a check for FP
> > +	 * support.
> > +	 */

> Maybe add a comment in fpsimd_flush_task_state() about why the
> system_supports_fpsimd() check is important?  It's not obvious there
> why we should ever be calling that function on non-FPSIMD systems.

There already is a comment in there about it?

> But would it be a good idea to stick a
> WARN_ON(!test_thread_flag(TIF_FOREIGN_FPSTATE)) at the start of the
> functions that rely on this?

As I mentioned in reply to one of your other messages I want to just gut
the whole API here and replace it with get/put functions for the state
which would include the get/put functions making sure they're paired
with each other.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--hX1yMOOoh6B0Yabs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdPN3cACgkQJNaLcl1U
h9B40Qf/USE0v0sbO6fCh4oVL2BkT7MBvtv3GiKG3bKqv8rcKBrqefb39r32mr2b
YsoSkhYJH9EZH16B+f9i7gf4XmBbHBBAFU3sMicLJuuA12hPEss3iLw6C3XHW843
WUnmJQxmEe0i807I75qY1GflS6wPNP+2fgNw9lwxN+x9zfRsQptLX8h9LRhTrDB1
7sd3nY2tJ1t5BNMiXEsnlT4fS+DyEMPCgP2r+yZgxFV1gfM/h8Txr+OvUMNqN4EF
nThX1ZHx4KKIkrjsAod8Nlk9tAZMsDvTF6ZSv2PguRc+v02EwXB6icK5sbkU3KFv
ZkvisFiNqm6+JA6FcucI4pyUHbBIZw==
=zNbQ
-----END PGP SIGNATURE-----

--hX1yMOOoh6B0Yabs--

