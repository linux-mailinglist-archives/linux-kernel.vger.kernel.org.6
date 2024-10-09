Return-Path: <linux-kernel+bounces-357036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3035996AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C20D1F220B1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814119EED6;
	Wed,  9 Oct 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZAqNlMQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DF9198A2C;
	Wed,  9 Oct 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728478057; cv=none; b=gC5n9JyLRzuhmnK6Mt0W1k6acTYT+J9hj1/fEwFpphr6lzg8Qx09ceAEicHzW8rFw4bbqN0OVYR9nVe2UEYqXdV9LdmSFuKgNmro0VNDaC3rYCuWU8uvdwaMtUp5AVbojAHb7qq9T1uE1WUr4ETr1Fjbw5s9QCpMffUmHF8PztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728478057; c=relaxed/simple;
	bh=/cClVKu0WirJrAjj5JqfKMW8mJ9doZzehtVEwSPEMFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhyp3nmFD2bMXIavS4DMd7bpL84n7kHJgeuUbedTuxzvTFSJztVgb+VrI3va4Js/oWTDjFdXQnrkJKPRqv7CI9HOMLIxcpHbZJVhQemyLuMSAQ814nwYlLMj0b3bhx6YkgdKqzKuRE3WfKJNRw4D/swhZDfakRXMHAHUZZPMEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZAqNlMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACB9C4CEC5;
	Wed,  9 Oct 2024 12:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728478056;
	bh=/cClVKu0WirJrAjj5JqfKMW8mJ9doZzehtVEwSPEMFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZAqNlMQpDeaakZDC5Z2umFZNV36nvDVScVMU8iqzIFlER7lVWpk6LZ/ssdw1fTZH
	 ZhTSUwCEbC27sIzqMvhIif3Jc9NPrMaQZrWsnsP1azP3L4pxzD7MR6n4I10qp+zHq9
	 xij13IAYDV82s0leqEh/gdcz+f8m7lwdCwbMYcXVjILu4QJYCla08ai4l2fxghawvd
	 jK/klS8ty7X/YSneBVLoH/3YX3KewWGKx1EHte80Wti9R3+AGlgKIH6gFq/l6jYseB
	 kEMOb2PBDj5t7umC0+pwtPAwrk7I7P5qkhhxVO+WgzMJEjKv6hCUHFA1edO8IP3O6N
	 dsLTaH85x6etQ==
Date: Wed, 9 Oct 2024 13:47:33 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Weidong Wang <wangweidong.a@awinic.com>
Subject: Re: [PATCH v3?] ASoC: codecs: aw88399: Fix error handling in
 aw_dev_get_dsp_status()
Message-ID: <ZwZ7Zf0VCvert7Ya@finisterre.sirena.org.uk>
References: <20241009094313.8820-1-zhujun2@cmss.chinamobile.com>
 <fbbe290b-4dd4-4a65-acfb-8150b621a5c7@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YDwmDK3G4M1B3y3U"
Content-Disposition: inline
In-Reply-To: <fbbe290b-4dd4-4a65-acfb-8150b621a5c7@web.de>
X-Cookie: Editing is a rewording activity.


--YDwmDK3G4M1B3y3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 01:12:21PM +0200, Markus Elfring wrote:
> > Changed the error handling in aw_dev_get_dsp_status to return -EPERM di=
rectly
> > instead of setting it to a variable.
>=20
> * How do you think about to choose an imperative wording for an improved =
change description?

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--YDwmDK3G4M1B3y3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGe2QACgkQJNaLcl1U
h9DLmAf9GPKPMvUQq1tKRcf7RQw8o5cTGICgSIzlLml3h6wB/Z6GM8uS2SKq+MgK
1D8d4nSReLMVz0CZN46WlSFWbl5MlT/4N2UIT/DlZmv0htUSSpX94/xKrsrmdV2k
jqfNrj1yEkcfTthqdx4RnFy9r3vUFNXq4FR80hMIhlMUN2ODHvyON/4iL0X3aGEs
DaXwguKnDh7AuNsW7BbQmgJz99kjTH1Et8eROIQGwkv9CFYJYJR4gO3cyWocqxuj
lEt7B4yki9dTQ4xTZCtTG2MPYZqPVmnG87G5jKhVwPm9noM0foTckpEDa4hTN+8+
lRKhxURxxqqI5eel7CjrTCoW2WGw+Q==
=LNZN
-----END PGP SIGNATURE-----

--YDwmDK3G4M1B3y3U--

