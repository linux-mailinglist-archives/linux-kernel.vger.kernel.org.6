Return-Path: <linux-kernel+bounces-395008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AD29BB70F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5521B1C22107
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27B213CA81;
	Mon,  4 Nov 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOrNaQdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C779FD;
	Mon,  4 Nov 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729041; cv=none; b=X2+AnQFt32d42tfBdrmXLp8qjCOeSl7KasQGkjisdZAXjo6F9lOnV0jnyAPsZ++yGHCvmER8vUtXTZhFksphbsN9/nzQsnWXBWPJ0w8U1NmO/sFmndJShcvpvMgk4Z8FOO+dVEPCVLGepUk48QaJiaJz3iVOWoTlMJizSRc3Ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729041; c=relaxed/simple;
	bh=0BjiMv0VjBbA0wKoTP1NVXNesF4nWLPu+2GtxIbUMuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LceNXRD4MSKX5/7EwJabZxG72GJDfhd8g0wOzruM07VL2MTK+RxtGwZpA46JXbNmlnBq0UYuHM9g0vA1ZNB4xzbDpLtynCa7e7hBvLqVcwkUo8T0RH+J1ITZDuoGS1hSuXm45SrBRzDoWSNTLA24J09PuDrO+lAicUe6A0ESje4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOrNaQdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541ACC4CECE;
	Mon,  4 Nov 2024 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730729039;
	bh=0BjiMv0VjBbA0wKoTP1NVXNesF4nWLPu+2GtxIbUMuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOrNaQdR2NgTs0W4BXgN6H2uFywY5sWWlwpRj5WaK1/LoOwNAsrBu8LWq8/PRLvnk
	 xFidrFgaI9OFHM9ovVO1s4l6c5BpZT1DO5tt5rsGOwFWgMS5ZZLUkih2OWItsT31RI
	 WY0Ytb2rpppwmr6nyzW0gc3g6VLrIAfwIs1esPqLl1PKFKJtinzFijBCCRwIyto4IP
	 vrCbUReZXVN4rF1odjkj/vkP42pXLBO/9O6M2/TtpnB38NehLYwRek0o2aUPygojuq
	 5SgRRAMBEST+ag5bZBqSmWOEH5H1Yyw9IKOBh5f1HiEC7UaUUG30B6VLu1ktw8S3e+
	 Lkpb8d39cryVQ==
Date: Mon, 4 Nov 2024 14:03:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Ki-Seok Jo <kiseok.jo@irondevice.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: sma1307: Add driver for Iron Device SMA1307
Message-ID: <45c69c35-cc52-4fa2-9212-821a7f841b61@sirena.org.uk>
References: <20241104-irondevice-sma1307-v3-0-4bbe79895f54@irondevice.com>
 <20241104-irondevice-sma1307-v3-2-4bbe79895f54@irondevice.com>
 <SL2P216MB2337F87E4E884158CCE77DA38C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7C2n8T4N/M0aFJ1I"
Content-Disposition: inline
In-Reply-To: <SL2P216MB2337F87E4E884158CCE77DA38C512@SL2P216MB2337.KORP216.PROD.OUTLOOK.COM>
X-Cookie: The meek are contesting the will.


--7C2n8T4N/M0aFJ1I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 07:33:50AM +0000, Ki-Seok Jo wrote:
>=20
> The Iron Device SMA1307 is a boosted digital speaker amplifier
>=20
> v2 -> v3
> 	- Use BIT() macro
> 	- Changed the value in sizeof

The changelog should go after the --- so the tools automatically drop
it.

> ---
>  To                         |    0

This looks like it got in by mistake.  Other than that things look good,
I've fixed this up manually.

--7C2n8T4N/M0aFJ1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmco1EkACgkQJNaLcl1U
h9Ay7gf8DdtxLYVBqRNpwQOU/2HkpA+8Z088OKG1BdvWv/fMqBrJHWqA8u9Hp/xR
H5053JBVGnyurnri4P/0B9jvtEg0EVu27lNzJ9tRdqzGJW+0Qhi/L25DMMSf4o9y
+DfZfQPq7GzEJODXwwXN3FTOL+xgNn+F3054Yh67Zp6jaglOoxzlq1xRXSgOX6l/
X+uImrMZXBcz+rJRmib5ilWnvstvHk4UIV3Pcbslarl/8eYJ9BznMqWJlpY2eh0Q
f/MQKpse3+he2tO5gtXj0hPkyMqGy+Ys9oXcLjOC5dsgUY1hziWrsH0QC82PBJw7
R54cnxCQCEjGl8OEi/g2T5rrT3J5oQ==
=Tlvq
-----END PGP SIGNATURE-----

--7C2n8T4N/M0aFJ1I--

