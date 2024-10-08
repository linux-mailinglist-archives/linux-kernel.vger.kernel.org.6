Return-Path: <linux-kernel+bounces-354935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F9B9944BD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B92879DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C21C2DB8;
	Tue,  8 Oct 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeaV2hCu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C571C2322;
	Tue,  8 Oct 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380953; cv=none; b=c77LrPVbCPkWuFZf0keyiNfAJt2WVxyA5fuP2MiAJlF0bn5VaWDariZLtLgaPhz7MOU9EmGFFPpcyXOxUISnqdRT7CnP1n82+JuZC79pr/38WaJPASk+8cJW3nfF4zLDlzSSvdk3hAE+fEYlqMcwjCAA7Pup0SM64xy8ZH6ZDeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380953; c=relaxed/simple;
	bh=6Oe4lOymiFbbttkw2/k5vL3jnxSJdzZTenZxFyHXga8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hON0Bl80kGASz0Wk8ewq0Ao4ItnTLD+q7m9xiQ0+kc8ERDP+Xw5t6tkc8cXby+wZwP7igKJFIFvgP5yjdmqyzet1iQ/YG5f4k1YYV5iQNYT3uBX2hJHQpFYwH0LpOLjCwxGKRCWxAA0OADwuCgygcQhPDThleezFXn2yzX3I7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeaV2hCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CF3C4CEC7;
	Tue,  8 Oct 2024 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728380952;
	bh=6Oe4lOymiFbbttkw2/k5vL3jnxSJdzZTenZxFyHXga8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeaV2hCuNM9/bJcfltFyWgfhXMrmwZP3L8VRIh5ZKnThTyJL8rJTP9SwKvR9rJj3B
	 jqOmWtMqddzJ2G2br9QTjalahu6zlJ/4WRrZHi0t5blK9wFDBEhX7PULAEgjvpxZY1
	 ErqjcO85nEtgG8r3rOCLKNVRexaB5T2Atz+9hiTmgUkDGOUVMtxI3yLt8rRWX0A9Ql
	 8HF8yO9Vcq0r2J/GDqAthyscCbLf0uTu8vbEJCx2iuYu3PZaWQgImOnhZT6BmQb1ca
	 xm+AmBPZAGcnLPIpJfzq9OrI3B4/C84aIO/v0zEpM4mn21kRGhjj78tt+YzYtdkwfb
	 L3ylwJcPks0/w==
Date: Tue, 8 Oct 2024 10:49:09 +0100
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
Subject: Re: [PATCH] ASoC: codecs: aw88399: Correct error handling in
 aw_dev_get_dsp_status function
Message-ID: <ZwUAFaVkP7MLFn_O@finisterre.sirena.org.uk>
References: <20241008025923.10606-1-zhujun2@cmss.chinamobile.com>
 <6849d647-0240-4d3b-8f35-e4e65397e389@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TSB0aCd0HgCe3e0d"
Content-Disposition: inline
In-Reply-To: <6849d647-0240-4d3b-8f35-e4e65397e389@web.de>
X-Cookie: Editing is a rewording activity.


--TSB0aCd0HgCe3e0d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 08:32:32AM +0200, Markus Elfring wrote:
> * Please check the subsystem specification once more.
>=20
> * How do you think about to replace the word =E2=80=9Cfunction=E2=80=9D (=
in the summary phrase)
>   by parentheses?

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--TSB0aCd0HgCe3e0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcFABQACgkQJNaLcl1U
h9BRNAf/Tk8WFAYAuAYF4quSPeBvWtoalHDjKypnXRlpkmQ3EJjVhGfVapiMukVH
1C5RLcTAtf0nu7XM8gFQnFCXO+axnRBvN+mNEfeByDwhZkq3NfdEJ61WUEJ6JkaL
QtGODSIgIXHYEsEf/cwSrNFAEpESxredbqLjmhGfc7toB9r3tvhG5wZNFSRjEEiH
5F9ios/O3uVuoX/edF2LH22+TGh+tktWui/0i4LVUGFkcyFhpY6rbAKJTvAOJqGw
pYAU8iM2cIdcqfUhPo2C+KV2SiHQmwLxp64s7RvLqmY19JbTloGUnggItTAD3DIr
NaDU2xe67VTw5A+vLc44zk+vdVGcVg==
=4dlo
-----END PGP SIGNATURE-----

--TSB0aCd0HgCe3e0d--

