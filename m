Return-Path: <linux-kernel+bounces-575397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D714A701BD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04CB17DA3F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490FF267720;
	Tue, 25 Mar 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B50Agt/V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2AF2676DE;
	Tue, 25 Mar 2025 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908398; cv=none; b=cy2f8I+rSuXkXZQFjhj/63XR24w4DN0SYX/uhRNpSqhK28ZPUvtTFNoE0T9hcekb48wp0LpDbXFcn/HChFts/Fx+/ze+7h1cUQOELY8N5z+hQgpaeujT0Y0gfXt+vkTjsLOmqkQYg2Pe9PI6L/tVIxS/l2xoeqt49uxphERxSIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908398; c=relaxed/simple;
	bh=9/vAdU6YpWoZQFVnJqRUELJBenZuBXKJ/Z9FKV3i85Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWXLLqGjr2Y6ofY6KOP2GZWg3cQO8EzlEWdvsZJUKvt2WR1Hj5pl72x0mtmIDh7Bane8sHia66iT2rg7no7uW2E/AJ1vqoGTag0NJOteVgk5FU1ImmWwcjtIpo/lMOBPFqZ//hf0E6SY559ERZ0VN972jJmCfsfiaO8bjQJAjc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B50Agt/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515F9C4CEE4;
	Tue, 25 Mar 2025 13:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742908398;
	bh=9/vAdU6YpWoZQFVnJqRUELJBenZuBXKJ/Z9FKV3i85Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B50Agt/VJUcDNJ39fcIHxqa7xsEY9MWBYkFajfURCk7O6rGYmUSwZevLF61Umz+gw
	 wyJSsr0dDa3yGNoNezYMlGsaF7soBG11TSFKKxWE96JFK5kC26wZo4IDSnLwtebjty
	 tGk7bylpawc3779NktTQXxJ529JN+C3zJ60pYj7uFNSItDvFNtfnqptMvuyRW7cNIv
	 mN8yfLvApcfslPRixMbF4+BmXRYd58lq6NfxY/E6Ek62sPP3h46vILtDQMfK5N4I90
	 9l/lV2d1FRPldFsMuKusk+Y0jkQAQdR696dlAgSexG5hUN4YRCyEFUYXvRMxSRKAGZ
	 uiyRLM5puaLkg==
Date: Tue, 25 Mar 2025 13:13:13 +0000
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org
Subject: Re: [tip: objtool/urgent] objtool, spi: amd: Fix out-of-bounds stack
 access in amd_set_spi_freq()
Message-ID: <88002e90-28f3-479d-8b80-42cfd9947834@sirena.org.uk>
References: <78fef0f2434f35be9095bcc9ffa23dd8cab667b9.1742852847.git.jpoimboe@kernel.org>
 <174289169862.14745.4727974073679138257.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F220FFN2FAnRam1d"
Content-Disposition: inline
In-Reply-To: <174289169862.14745.4727974073679138257.tip-bot2@tip-bot2>
X-Cookie: Don't get mad, get interest.


--F220FFN2FAnRam1d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 08:34:58AM -0000, tip-bot2 for Josh Poimboeuf wrote:
> The following commit has been merged into the objtool/urgent branch of ti=
p:
>=20
> Commit-ID:     0239716b82b75dc5cb64c5ec5405dac6c3448d48
> Gitweb:        https://git.kernel.org/tip/0239716b82b75dc5cb64c5ec5405dac=
6c3448d48
> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
> AuthorDate:    Mon, 24 Mar 2025 14:56:04 -07:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 25 Mar 2025 09:20:28 +01:00

Acked-by: Mark Brown <broonie@kernel.org>

--F220FFN2FAnRam1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfiq+gACgkQJNaLcl1U
h9DFAAf/aCThwa7pY2hEKXM7izhtOoKfy7n9PmKVigB58cC1LhaB6LbRDVdCGVV2
K5MxCALzgvkCJ7CSASzXVteUDHjqx9Oef4Oeh9Ovq2nRIJHxQyqM+WUjn/1Ko5t5
JOGlZ5vOSaJpgIKHu1roq24ACxYyhA2C1Cw30PrGeXIx5YvzUb4Ym6BHA10aeuHC
+xIv8QsWqQPsMxh6cs6N7BHYfxiUXQRbiOW+W9RR2S48xQlRPm21idWUKq85c0s+
VHuwQ3Z0BKRzuRfFUZng1IRA7BOKk4v5V1vKqsKHzplHTuJqrqu2U+v2Qo/+7fRq
5qlxFY+btHr0UlwTvnCWNH1i/EG+Ng==
=KMnH
-----END PGP SIGNATURE-----

--F220FFN2FAnRam1d--

