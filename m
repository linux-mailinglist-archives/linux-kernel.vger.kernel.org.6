Return-Path: <linux-kernel+bounces-531449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF79A440A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7CA164774
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA31624F8;
	Tue, 25 Feb 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdhwUbrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57165433CE;
	Tue, 25 Feb 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489624; cv=none; b=RwNWZnpUKZQa90LJRGyq0V96NzLRIbKflzD5QEh17UWjelkcntjHnFJQKEEoLAcemGo1WyMtIhtlP9febnzLOcALH5PZfRMeVx7JYUfOczsSNQ8avEkKQkNjnwGltb7TNzcGY8GwVRjU9/MKQhJLVBUhrK7WXIFUOo9bTDgs3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489624; c=relaxed/simple;
	bh=dfAK7SX3PAcngLvN+TTXq78fi95cSmXCJNnXQz5sDYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvsGyALcSQ15EIg+sUQ0CbyAf2GpvJzx2pee4zGOw5TR1yJuTz9D9U+UL/uo+8Ic/aYKfvAvj8vR32tLrOnVK6Pg5HY+h2nzbyT83sGIdaq9LwMlIywcih/2E9bIj7ee2iIpj1ryUwPKPhRT5pJbHu1vdA6uDQxRaCj0g5A5V5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdhwUbrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC9C4CEDD;
	Tue, 25 Feb 2025 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740489623;
	bh=dfAK7SX3PAcngLvN+TTXq78fi95cSmXCJNnXQz5sDYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdhwUbrRy4MkEPdJOvsjlXWHY9v2ddvBSerrHVuHx7x/aUgSeZ+HouitztqlMatlK
	 sKJbq8sknggxLvSqNgGqA0O80avqdF0t1MWfvF7gFY9Z4K8MCqRX1P8qyKGqHhkSYJ
	 35/DClm8586xGkiD/U8UTDzGvqEL8A1U3E5yjWInyLqYVhajagM/N/MaW4Y/QMlJR5
	 sb5rf1RdMZljuGDxzliuSri1KaSWhO+gzvZgTTkE7LdlrWV/93FAhp4fMVnZt2Keq5
	 2Yf/eiOxOg3rI5AZV9Hxjqpkw4kXwPVMUmz5XDgHVp1jy43q0JZblxZ3r3redl/4iD
	 sGXe37pzc63xA==
Date: Tue, 25 Feb 2025 13:20:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Weidong Wang <wangweidong.a@awinic.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Ben Yi <yijiangtao@awinic.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor+dt@kernel.org>,
	Igor Prusov <ivprusov@salutedevices.com>,
	Jack Yu <jack.yu@realtek.com>, Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Paul Handrigan <paulha@opensource.cirrus.com>,
	Prasad Kumpatla <quic_pkumpatl@quicinc.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add aw88166 amplifier driver
Message-ID: <2f9dcbc4-22dc-4663-8972-328a2faab5de@sirena.org.uk>
References: <20250221102623.369435-3-wangweidong.a@awinic.com>
 <32992dc7-15a1-4ca5-a5a1-e7e26ce74fbc@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5ksm0M28hlCWRaWJ"
Content-Disposition: inline
In-Reply-To: <32992dc7-15a1-4ca5-a5a1-e7e26ce74fbc@web.de>
X-Cookie: I'm not available for comment..


--5ksm0M28hlCWRaWJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 02:09:39PM +0100, Markus Elfring wrote:
> =E2=80=A6
> > The driver is for amplifiers aw88166 of Awinic Technology
> =E2=80=A6
>=20
> You may occasionally put more than 57 characters into text lines
> of such a change description.

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--5ksm0M28hlCWRaWJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme9w5AACgkQJNaLcl1U
h9ASjwf/R7DZkWb0naPakmHeXGgxosFU2gDD3YLyChZWaCOyoXciu1t2yk7Nf9EY
WBj9hulz0Ycae1Ll/hYDw5yoG6Uxwi7CrUlHg1g2u9ws/IkIegzP1oMVFu5iCAeu
ONtCH4Zfw/RL7PvcCnK50XN6cqwcVGGlaTrJFX+DMjRdL8FfcJlgzjTDMzHY/HYc
Nj31A0bH76+7BduJndc0/W5DieFTxCxOYpRVMWbArdHLLrp1uK8PJAEayPXd7oR/
H34gQkXoAEc+vYHtTP56761jX3uCBcpwGNgknVOA4qL0upasUof2HLfQU3/pYGr0
TMwlAGyv+xYWBdCIpd55eopERPdTQg==
=X+KE
-----END PGP SIGNATURE-----

--5ksm0M28hlCWRaWJ--

