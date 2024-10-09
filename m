Return-Path: <linux-kernel+bounces-356837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23899677E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BF91F24881
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4DE18FC67;
	Wed,  9 Oct 2024 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO8H+cgI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6694E18E751;
	Wed,  9 Oct 2024 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470435; cv=none; b=BH+Oqcq73m5WW1WB8P4FxLDnFyiEbNfiramAWUm/ipa4VaONzpYQ/hYZTFbaPtodJnMqSifBDsvMp4oVmiFyJgpzlcQgiWCerP2Cf9maZkZj0OGoEgQyg4IapN5EJtPLNvIECaFwojz9gHyK/1W5rw4zdZhVFaBKnNXezgIGJ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470435; c=relaxed/simple;
	bh=Rww3IS45r2NS+UekZyW+WghC6bwtpbCs4b/u3VzVP2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1Xav5FwMHZKn4revHqod9BOQbDCdoiXsE8Gb8Jy0TOxyWutf7mgNzAILyVsAo5ACsLu0gCX4Iqmwr8mb2RzFad85bZnbuPGL0V53bvf21IOYMHNujkqAqhJWoFoLCHXZkPhz99a3K/1+sxyAWuy0hD+65dfohTUcScbbwCpt88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO8H+cgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF7AC4CEC5;
	Wed,  9 Oct 2024 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470434;
	bh=Rww3IS45r2NS+UekZyW+WghC6bwtpbCs4b/u3VzVP2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NO8H+cgInQfzz9znSqpB4KWHRlzawJwIDsTBU5nn0ImIaZqiHVsV/T5vaVcfTuWIl
	 vH39OrCDPF2pelg/eZgk79OWH0UKxZDqfr+Jqs0pXz+du7QYBib2+VdhWlZq8vaB6t
	 ZDyYgCGh9th7PKTipEurkkIo0PNwTkOoH+q5uHMNXWmlikscY9maum3nHNkQBMUTs5
	 fGzKOfKHbUswGzbhb9xBz4PeuDv6HEfHSAEChDYSns7A+fXWanksYdSSQB5Fx33tSd
	 4VLCJSULdkwl0xgd84rxW8mmMzgRT37qWH9BoFaxyHInCqqkLb8nW8DulYplCFpw78
	 d2Wy8/8hLpQGA==
Date: Wed, 9 Oct 2024 11:40:31 +0100
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
Subject: Re: [PATCH v2?] ASoC: codecs: aw88399: Fix error handling in
 aw_dev_get_dsp_status function
Message-ID: <ZwZdnxjkhnjEqQoQ@finisterre.sirena.org.uk>
References: <20241009073938.7472-1-zhujun2@cmss.chinamobile.com>
 <01d7c030-1d80-4533-9279-2b6961e712ac@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="191BPD28J/WmOGT9"
Content-Disposition: inline
In-Reply-To: <01d7c030-1d80-4533-9279-2b6961e712ac@web.de>
X-Cookie: Editing is a rewording activity.


--191BPD28J/WmOGT9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 10:43:51AM +0200, Markus Elfring wrote:
> How do you think about to replace the word =E2=80=9Cfunction=E2=80=9D (in=
 the summary phrase)
> by parentheses?

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--191BPD28J/WmOGT9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcGXZ4ACgkQJNaLcl1U
h9BGCwgAgHEHWi/IAg1nGDn9KSIF/kjI551WbarZlwd6UBNlHE4GMYjXDF/qXTdc
7CeXVSd3urt2dN2GOfmwOZmcboQ02UdjJNdQJwFUjSxSuxIcdwB58amlO3fCBTV9
iLld2deR6gXmwC8xsEuKiZa6h6nZiGinucUeXQJbiwkRrx+Zk9Cf9M2DUCwgBevf
LbElj8hcgEFyRklr3Sguvxo9DYagYbWaRWZitsmnPFHt5ZXwBK4i9kT/eDERDr5V
7t3aAbbUr/So0NCd4i7Z2pPzbAi/ySj8WGg3WMfYgSf3nFIbLCsC3PI1pmr9ksRg
9/Y6c0EYagukNg5sgG4j7XKUJG/5Zw==
=LEoq
-----END PGP SIGNATURE-----

--191BPD28J/WmOGT9--

