Return-Path: <linux-kernel+bounces-379768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 719839AE373
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06235284135
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85621CACDE;
	Thu, 24 Oct 2024 11:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCyvV3+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD281B3944;
	Thu, 24 Oct 2024 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768114; cv=none; b=lH5YZ5Khot6pLp6apogEp3rBpSzSk8DNQXym+PuZgZG/5/g/v5B9CLb9DiYO33hDTxWhii5bRfSNMQalabTsz8Laynhf+u6aD1mkOfR3f0k8NKeyKSkazendmJjngWGV78Mk2LytTZnspXYKl9NMR9oqrcj4ixW3qQ8XuDf9+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768114; c=relaxed/simple;
	bh=9peKOBarqdpPkLjjJH9GEgF7N61JBW2Rmu4/0jGcnWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlho5pZmiML3kjQXda3q8JxW/VYca8CU1/t9fYLUw+O3Uz6hqzzFadGC7fQomm1bZdx6XaY5E+Kv/+C2vo9Ua7J5JxCsensGwHwW3bIIpwZxkKxnfnQIP0i4/87jKnk5ptsFpdd9kl2mniF4R3FZpyNZosNASAey8Wy3jSRdLOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCyvV3+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65987C4CECC;
	Thu, 24 Oct 2024 11:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729768113;
	bh=9peKOBarqdpPkLjjJH9GEgF7N61JBW2Rmu4/0jGcnWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCyvV3+7tJi19rgCFZNXGlpaG2Fvdv0drAf/gQJlTbO/kQLUSKy3dIuhbZkJLTwh3
	 +A15YkZgZM+T6HTGYBKSrS/lmucRuGPrSJ6hrrYVT/Xd4piwcfNOi8XdxxrSkZVULD
	 Vj4NQ9xistEbkcSfhIwKDmzPvrhR6sR24MTP9FUTuoFYWJpkxWI4MNAjUDoU39bSxs
	 Au1zPkeRq/in99JZFyLyf7QrenIWEEp6u39Hji84AyIhDHVEgq3TQZsHJJlRPnyqtx
	 kqp/fRT4/18p7G0Nq4hqwMER4KqYHuNFzM4YBtV2+cK0EPN75LJLyr45/UP00t73HS
	 ueuQeAVndxEIw==
Date: Thu, 24 Oct 2024 12:08:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <658bb573-69f5-4873-98d3-9e9d6412966d@sirena.org.uk>
References: <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
 <20241024052139.2cf7397f@rorschach.local.home>
 <ZxoSZQSw0z6AdgaU@infradead.org>
 <20241024054909.49ae9faa@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k4/QeDWtOnPbDnaJ"
Content-Disposition: inline
In-Reply-To: <20241024054909.49ae9faa@rorschach.local.home>
X-Cookie: Real programs don't eat cache.


--k4/QeDWtOnPbDnaJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2024 at 05:49:09AM -0400, Steven Rostedt wrote:

> So basically, all I need to do to satisfy your request is to add fixes
> branch that I push to that is pushed after it passes my tests (and not
> the urgent branch that is still being tested and may have bugs) and
> then have that be added to linux-next?

> Now I have been batching changes and not send a pull request right
> after my tests pass. I've been sending a pull request at most now once
> a week. So I could have this branch hold the code that's already been
> tested.

Yes, that's what pretty much everyone is doing here.  Generally we find
very few issues this way but it's certainly a non-zero number.

--k4/QeDWtOnPbDnaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcaKqsACgkQJNaLcl1U
h9Dw9Qf/eOHIPV0pF/+EE1YW/VNkqtLBqTfT5ASltXbCel7CT84ZLvIwaKUC5s/0
d/zALFEN2Kwnko0Q29GdjdpQ0z3ZkjJPDhq12Mr3YQ5Mqa3Z1EmTkH8rXeH1U0Jv
a9sUhwvut8dNDXBg522E3fABjlB+NnW7yi1a6GlYNhW13tYINqBbKdKtRnYqx5wt
lnHrRH9dbGyEt5n0fZ0QrU0ej+9BNXnjlUHbNRhy9ZHbMDXGBZCVpAp5wvGlGJDk
2Xo5uFR+j2EjubrDOaVRwVkSJMvAOH4BzCDICz7n1MoUgLseOJpncYPN/EDnwLAs
BXr/knfq+eusKEuJQsxz+pmCM9qaUg==
=y6xr
-----END PGP SIGNATURE-----

--k4/QeDWtOnPbDnaJ--

