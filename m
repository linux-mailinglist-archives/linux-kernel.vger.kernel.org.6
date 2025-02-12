Return-Path: <linux-kernel+bounces-511160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739B3A326EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37913A6D83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E8920E309;
	Wed, 12 Feb 2025 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAhG2LpD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1332066DB;
	Wed, 12 Feb 2025 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739366742; cv=none; b=TDvF7g0V+VlAibDLYPV1thnNTYOrmliCDVtV9NkWt3KtD2WXq3QHkKaAEfeH0fhgJYC+XRpzt8LOPyjsY0qtus3iwUSHGK+OSN7/zd7WzAkdAHSa0fGYtYW0VgDdl8FU7WpGGvSe7PrVqM4bSRm981LEVIqE1PpjACNtFjntbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739366742; c=relaxed/simple;
	bh=nPPGAafinSZNRKnDUDj9vQmOe7TF7b6+a4emffRKAYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeajW7PMHgJUB4zR8jW41BbKFi2hXkCcBQEyg+r+Pdv9PtoA4j0TE+FvV51gbgJDCUwnJi4wkWfouL2L7pqZs0CX4eZAK1fKc+kM+UPs/jtI6iusVbBKD75Iv+SF8FMYtDkIsm9ubnWSu474cxq/KdJahXo+McPC/613Njpok0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAhG2LpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E593C4CEDF;
	Wed, 12 Feb 2025 13:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739366740;
	bh=nPPGAafinSZNRKnDUDj9vQmOe7TF7b6+a4emffRKAYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAhG2LpDlvBgBq8FmGcFS6/4G9DTomVsJJBibWXyppxSQFKFNRnucrbef58FNnZNA
	 s4to0gnLvkK7YbMCfJfA2l6RtV1rs2uopS3B8LYOLGfbgP6spH75+z8YWn0UvKBI/k
	 2QpZcCzI64HaRF60cbMgQbktSb6ASPgq9UTHXrd9pEg3xtVk/9D5ruZ715CuBDG2Uo
	 CvPPE19SwxFIJ8WAMLcQo+IKWIhnqHtKY8GVfoapFP5oI3/1rKZDLoSWT4quxTOurA
	 9T98uazXT7lkTdEfeSiNMSpB0GHG26pBTyi1eNomcBD9pTmU6Hjntkd52nuRVGeXFH
	 LJbf+0XrEYUjA==
Date: Wed, 12 Feb 2025 13:25:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Frank Li <Frank.li@nxp.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: imx-card: Add playback_only or capture_only
 support
Message-ID: <3883923c-f2b5-4b0e-b9ec-e9094849fb2b@sirena.org.uk>
References: <20250211035737.3886974-1-shengjiu.wang@nxp.com>
 <20250211035737.3886974-3-shengjiu.wang@nxp.com>
 <Z6tuFp9nZFMJMgDa@lizhi-Precision-Tower-5810>
 <CAA+D8AMyXVdAWOTGHtrOyXjSLiMioAhZ1awepX3nproom87azQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eR5N2MBL3FgF7WFw"
Content-Disposition: inline
In-Reply-To: <CAA+D8AMyXVdAWOTGHtrOyXjSLiMioAhZ1awepX3nproom87azQ@mail.gmail.com>
X-Cookie: Reality does not exist -- yet.


--eR5N2MBL3FgF7WFw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 11:48:43AM +0800, Shengjiu Wang wrote:
> On Tue, Feb 11, 2025 at 11:34=E2=80=AFPM Frank Li <Frank.li@nxp.com> wrot=
e:
> > On Tue, Feb 11, 2025 at 11:57:37AM +0800, Shengjiu Wang wrote:

> > > With the DPCM case, the backend only support capture or
> > > playback, then the linked frontend can only support
> > > capture or playback, but frontend can't automatically
> > > enable only capture or playback, it needs the input
> > > from dt-binding.

> > wrap at 75 chars

> On my side, there are in 75 chars...

It's wrapped as above in the copy I got FWIW.

--eR5N2MBL3FgF7WFw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmesoUwACgkQJNaLcl1U
h9BCCwf/cUpzpsoM/MopBAnPQFijzei9fc7PPZKC/ddtC1NxAx1aXwrBNA7dyqNr
pIBX9Y8UaFzGZJx2HjxALElsYzRsvtc5nVOPoOboK/omzc5Ck3spzg/XIlRDDksO
kX6s5nDUqPGDqhEq7Rjcp1hmTK5h0SV1PlNmzuMHJHrULtG0ukp1I281ASSu5Two
dR0+y+0fdGHQspRQb1wKN07V+NVeLnDotZyVmVpVVTyeu+rbWt5K4jU2f0H17t/r
5pyU4R/MLgfX1+TUHnsFLGDxcxj+vQFZtSoJoLD9+wL+KDavhDWuFq9T2ivJ9c5c
apBK+i9RTJbJeidG8sQtRp3nR0RE6A==
=Hkwf
-----END PGP SIGNATURE-----

--eR5N2MBL3FgF7WFw--

