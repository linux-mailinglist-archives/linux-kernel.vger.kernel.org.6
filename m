Return-Path: <linux-kernel+bounces-376271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777839AA279
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9806F1C21F99
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7519DF9A;
	Tue, 22 Oct 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceqwwk4l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1A61537D9;
	Tue, 22 Oct 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601255; cv=none; b=T79fB2tN38Ox9L1Y0Ay2LbwOpkRpEInhqqDqGoe3y5GrKXm6AdIcbk68p+6pP71WhwxqaM4cfBNng8BBYqq02QlV1Jgxn0JBB1Aa5oeJD/MQJR3E4sIrVaEwCLXyYPA3P1Fw7ATW3DOD+6u8l3lJkAhZ3qLBoekshaC7VFWTx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601255; c=relaxed/simple;
	bh=D3msSIe67di5Vaz3wDHkL7agUu/vJ2DlJ1+20F+ceqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fn3akr7CjihrOGfFbJ+2Izq8BC+hewqJuHxYUXbikTsjNgdydHuszH7EhHmW0ivuBDiUy4P8quVkkVU4D/TOApeKLxEEaRbBA2kxDp5aUbh3vASEx9Iwhtx1vm3qtoc0SbGvoO39p8o5jLkgaBVovfllsyqhqgb5or90n4vh67U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceqwwk4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0B0C4CEC3;
	Tue, 22 Oct 2024 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729601255;
	bh=D3msSIe67di5Vaz3wDHkL7agUu/vJ2DlJ1+20F+ceqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceqwwk4lMxBHqnwefwP3SSoLlo7D05IbnN4ChzIbE0he4f6fdj6WJ9/BHPrDOosar
	 aT6b70K6zgdp/JO9q7M6zdzMOxA+8O3M8eEGwavKQPBVJlJIKRNuR0oV9J43z1GNqe
	 jdia2zTie6nvpVbeJTLdQw9yA2aoRfanrLzaJ/7v0LLbYNo4DUZmRgEk1k3tmgqbbX
	 MP/grHtGZChIGNisX+V8KGb7ZwT++42zrIdux8b+c76ic3k1qf03EUXfSz5Lllr4dk
	 Tsqg/mFb4D9ZfbLMBzh5Ji4XvQo648YDV+2SDytNuGHS4oPp9axFe+WngWPGkbnxba
	 yPQoW4Ga5F4lA==
Date: Tue, 22 Oct 2024 13:47:30 +0100
From: Mark Brown <broonie@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <11b3c020-5381-498f-9363-f87a5c6ec5a9@sirena.org.uk>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <a4d7222ddb039a03a337fcfb047f5e804bc541d4.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wYReHOfDGmNWvfwP"
Content-Disposition: inline
In-Reply-To: <a4d7222ddb039a03a337fcfb047f5e804bc541d4.camel@HansenPartnership.com>
X-Cookie: Surprise due today.  Also the rent.


--wYReHOfDGmNWvfwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 07:51:03AM -0400, James Bottomley wrote:
> On Tue, 2024-10-22 at 04:12 -0400, Steven Rostedt wrote:
> > Christoph Hellwig <hch@infradead.org> wrote:

> > But when I find a bug that's in Linus's tree, I put the fix on top of
> > "urgent", run it through my test suite (takes 8 hours or so), then
> > send a pull request to Linus. My "urgent" branch doesn't go into
> > linux-next as it doesn't have changes that should affect others work,
> > which is what I think linux-next is mostly for.

> That's not necessarily a safe assumption.  The reason we put scsi-fixes
> into -next is precisely to pick up if this happens.  I admit it happens
> very rarely because of the compact and local nature of the fixes, but
> the signal rate isn't zero.

Yeah, just yesterday there was a cross architecture build break
introduced by a fix in the selftests.

The whole reason pending-fixes exists is that we had a disruptive
problem with fixes that hadn't been given enough coverage at some point,
IIRC in the case that immediately inspired it was that there was a
dependency on changes that were only in -next that hadn't been noticed
which is why we've now got the fixes tested independently of any new
development. =20

> >  I also find known bugs in Linus's tree to be high priority to be
> > fixed (I stop what I'm doing to get the fix out ASAP).

> > Now, if there was better testing from linux-next, maybe it would be
> > worth the time to push my urgent branch there for a bit. But so far I
> > haven't seen the benefit of doing that.

> It does at least get 0day running over it, although that can also be
> configured for your branches separately as well.  It's also not unwise
> to have some pause time before fixing and sending ... the fix you first
> thought of isn't always the best one (or even sometimes an actual fix).

I'm also covering it in my CI and do occasionally find issues there, as
does KernelCI.  There's probably others I'm less aware of.  TBH half the
reason I cover it is that it also cuts down the number of bisect steps
for -next a little.

--wYReHOfDGmNWvfwP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcXnuEACgkQJNaLcl1U
h9BTHgf9HmTQjK4SHPOp3EbtD2Nvlf3YNSQeF9dSzE7l0Wvta2as4AnpKt8ycfir
BcJfbW5Sds4Krxt7H/GuGOPYt5agDZm8QfnTBXbk5GaAjJwlsrzogTzeGW7cyhLb
MKQAPMgNQwRAx8EZj9WuoyK8U0QjcNnTNotGFhXFd9iTKtX61+JP2CFb30t8p+op
capW8pXwqh+PmgimeUdptb8+jbjZCDSBE03uig7ZIdRTccy4NeRRwYameC74JKn2
yqXXu1ajRvso4XBWU5H2TJOIzIOx95QEbDbTqztad5o/XHwTNdNUlpbE/XAkY60e
pCf2KRx3YOk2dlYfvcGtkKv3TgGFfQ==
=vrin
-----END PGP SIGNATURE-----

--wYReHOfDGmNWvfwP--

