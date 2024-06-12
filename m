Return-Path: <linux-kernel+bounces-211207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F016E904E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2B5283E71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD99D16D4DA;
	Wed, 12 Jun 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC3zGK44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105B1649DB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182276; cv=none; b=kCXoY3Oh67xo6rAh1uBUtaX/naaj8H3leZbH86UHiy6eKrG2wz2mZUCREEUM/i1PWJ4bW8XcV2AjvbTweHiaFQDzYNDtGQm+hvb33iykWjk2usMqmzthbmgX+WpHD0VoGtzOiUAL8oyqVd4or32ZwiVz2QFp46+/aDuggEfhTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182276; c=relaxed/simple;
	bh=+Fg8MSbfS/ALG6sMa6m9qlE7IiMT7kmW5KU4tZjfNYA=;
	h=Content-Type:Date:Message-Id:Cc:From:To:Subject:References:
	 In-Reply-To; b=BaTL2F9RFFO4HGtoWZpSKenTV9/cjxI+ZTlr8DPtUSt4W0ytwcWC+yWvOYzT7BVZ5IpchBe+rQn05zTD++E9VAcyxVKlp91kbGnVY9GDUrvOAKghzAA3IqSNhIWAwFmymUAoB6kzPZiE1gqcbebV2Em8AsIF+SiWgGrvrFMMyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC3zGK44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43719C3277B;
	Wed, 12 Jun 2024 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718182275;
	bh=+Fg8MSbfS/ALG6sMa6m9qlE7IiMT7kmW5KU4tZjfNYA=;
	h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
	b=rC3zGK44daOQK8iXDa5NuBhpGPHHodvbwhTwOf6MlCmeO6OMPPzjwRohEyGdOdf0J
	 8SbiM4axhgLPZIeFspGO4tRarjuVzkgTiYUINvQZkJQuAGyz2YRuAdj0xk1VSjC65W
	 6hbdM05sKSN410h2RDDoeEpVmxvELtmpBPhsBcLiyA4ajyvif6lHvIWAXJl106/sma
	 FnvOUaFM8gRIdBMLp8kMt6m8syXJUTN0u+6gvYFmwWX+YGX/VWG4ROlrnanyoYsLzt
	 ASmKVw8Rv+xYpIuamXHC5UAgO74nEM8A3z9IJvfDzChQ1/nef5d9F9IDj8Hl2iiYEs
	 xthqA6AYy2qbA==
Content-Type: multipart/signed;
 boundary=7b2fcfb2bc19ec479f785f2532bd3fa408f9eb8564abe48cd6d1a113fc26;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 12 Jun 2024 10:51:11 +0200
Message-Id: <D1XWS6SSXALZ.3NKR71449UYAO@kernel.org>
Cc: "Pratyush Yadav" <pratyush@kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Rasmus Villemoes"
 <rasmus.villemoes@prevas.dk>
From: "Michael Walle" <mwalle@kernel.org>
To: "Esben Haabendal" <esben@geanix.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: core: add flag for doing optional
 SFDP
X-Mailer: aerc 0.16.0
References: <20240603-macronix-mx25l3205d-fixups-v2-0-ff98da26835c@geanix.com> <20240603-macronix-mx25l3205d-fixups-v2-1-ff98da26835c@geanix.com> <a379a411-2c9e-4d9d-aa8f-4c4f3463cc27@linaro.org> <D1SZKLZBDDBA.1Z7ZD4UEOX05F@kernel.org> <48719b0f-1a7f-47f9-948a-c981a0a29b41@linaro.org> <D1T10API5U80.1OKB56YTFGMTN@kernel.org> <874ja6aszh.fsf@geanix.com> <1d683b33-16db-4d81-92cb-d98e35b87cba@linaro.org> <87le3g283a.fsf@geanix.com>
In-Reply-To: <87le3g283a.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--7b2fcfb2bc19ec479f785f2532bd3fa408f9eb8564abe48cd6d1a113fc26
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri Jun 7, 2024 at 3:30 PM CEST, Esben Haabendal wrote:
> But other than avoiding the "magic flags decide whether we use SFDP",
> should I be doing anything different?
>
> I assume we should still be calling the default_init() fixup functions,
> both for manufacturer and flash level. Or should we leave this for the
> deprecated case only?
No, they have to be handled.

> If the semantics is basically the same as for the deprecated, why not
> simply change the implementation of the deprecated approach to what we
> need? So having 3 cases:
>
> (1) SFDP only [indicated by size=3D=3D0]
> (2) static config only [indicated by no_sfdp_flags & SPI_NOR_SKIP_SFDP]
> (3) SFDP with fallback to static config [indicated with size!=3D0 and
>     !(no_sfdp_flags & SPI_NOR_SKIP_SFDP]
>
> Any reason that we should not be able to easily convert existing
> depracted flash info specifications to the new SFDP with fallback to
> static config?

IMHO the only difference is that dual/quad read will imply the sfdp
fallback. So maybe the function can really be renamed accordingly
and the "deprecated handling" is just that dual/quad read will set
the sfdp fallback flag.

> Also I am wondering if anyone can remember or otherwise figure out why
> we are doing this memcpy() dance with nor->params in
> spi_nor_sfdp_init_params_deprecated()? Why not simply call
> spi_nor_parse_sfdp() before
> spi_nor_no_sfdp_init_params()/spi_nor_manufacturer_init_params()?

spi_nor_parse_sfdp() will overwrite the parameters set by the former.
So if you'll swap the order, the latter (static) ones will overwrite
the the ones from sfdp.

The correct fix would be to make spi_nor_parse_sfdp() not fiddle
around the parameters if it might fail. The quick fix here might be
to push that memcpy into the parse function. But I haven't looked at
the code right now.

-michael

--7b2fcfb2bc19ec479f785f2532bd3fa408f9eb8564abe48cd6d1a113fc26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZmlhgBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/izxwF8CzrxOziPKhCN2zhrHk76FyksW3UYFiVO
7XgLBISBntTXf0PEtMtlD5Q2kTl8FXQkAX9IgKXy8/gae75SKVnCScyf3sYTFaNW
/3Ilo4uld3AZ/F/6dFbFfTOqU10H5dW3rrE=
=eo34
-----END PGP SIGNATURE-----

--7b2fcfb2bc19ec479f785f2532bd3fa408f9eb8564abe48cd6d1a113fc26--

