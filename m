Return-Path: <linux-kernel+bounces-209864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60F5903C08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4FFEB21319
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34A17C20C;
	Tue, 11 Jun 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nhcx8DHA"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7F176223;
	Tue, 11 Jun 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718109365; cv=none; b=MCACbJ3ggnuE6MQKRdJpYuUz9WB39V8R2zR4V2avAPN5FWLqIm2T2SXHjzYDhgkR9lxATGBJHsCUWfphmbLDdCK0vE2ii2P6PuxyjNlW6RqH2gWw6AyymDpMtN2wgpbfQ+23ziDEV1NrdRgLiWa3v17yDRz6DuSPPvUtCNcQRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718109365; c=relaxed/simple;
	bh=KOWpJtHBV4XE8VhY7yrO/kJc+8536QocG6HEWhHlh4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH0hR7doyeTp9svSjlBuro8gmXkfclmE0qmPj4QUZE1JWaEY3ZiNi3PUb4aSl1wDbJ2Pb5LHRVavUDcUkLRJHVgF7sVHxRQvcQh+wQ8HFhY5ZjeCvsTZp1dKDWEN6WZsSKg/uJ0QxwJfb6KgSATnzwcBnOmDJ2bcse+z24pm3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nhcx8DHA; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45BCZWRd047923;
	Tue, 11 Jun 2024 07:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718109332;
	bh=KOWpJtHBV4XE8VhY7yrO/kJc+8536QocG6HEWhHlh4g=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Nhcx8DHA/kSRjceH/kbOpERTMx87jQRTzlsoYjbgvjz43SrXNNW7tR4t4/Hqg797q
	 VCqL4tvR7/jF9LSr4Vma2FpVhXWhxrFIvfYoifJWz8mVRLcl6nDraflpVRXs9+aBwU
	 Kh1o2mfDAMVuzIuHQ4Zj5iGtNz5MqvehV0L4n3lI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45BCZWuJ116422
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 11 Jun 2024 07:35:32 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 11
 Jun 2024 07:35:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 11 Jun 2024 07:35:31 -0500
Received: from localhost (jluthra.dhcp.ti.com [172.24.227.116])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45BCZV1O121832;
	Tue, 11 Jun 2024 07:35:31 -0500
Date: Tue, 11 Jun 2024 18:05:30 +0530
From: Jai Luthra <j-luthra@ti.com>
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam
 Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Devarsh Thakkar <devarsht@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: Re: [PATCH v2 1/2] ALSA: dmaengine: Synchronize dma channel in
 prepare()
Message-ID: <e55jugzdtzgiqvvmvtgyp3rovthvl3ky2o4quuxvswt3w5nshr@stuqxwmbpnpo>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
 <20240610-asoc_next-v2-1-b52aaf5d67c4@ti.com>
 <3557bd0f-86b4-4dce-90dd-59303f4f1154@metafoo.de>
 <ZmgpUFy5-_5n_zyd@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a2pm5t3dxnjeog5a"
Content-Disposition: inline
In-Reply-To: <ZmgpUFy5-_5n_zyd@finisterre.sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--a2pm5t3dxnjeog5a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lars, Mark,

On Jun 11, 2024 at 11:39:12 +0100, Mark Brown wrote:
> On Mon, Jun 10, 2024 at 05:45:52PM -0700, Lars-Peter Clausen wrote:
> > On 6/10/24 03:56, Jai Luthra wrote:
>=20
> > > Sometimes the stream may be stopped due to XRUN events, in which case
> > > the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop a=
nd
> > > start the stream again.
>=20
> > > In these cases, we must wait for the DMA channel to synchronize before
> > > marking the stream as prepared for playback, as the DMA channel gets
> > > stopped by snd_pcm_drop() without any synchronization.
>=20
> > We should really implement the sync_stop() PCM callback and let the ALSA
> > core let care of the sync.
>=20
> Good point, that's a better idea.

Thanks for the suggestion, sending a v3 with the change.

Peter,
I've kept your R-by intact as it is a minor change.


--=20
Thanks,
Jai

GPG Fingerprint: 4DE0 D818 E5D5 75E8 D45A AFC5 43DE 91F9 249A 7145

--a2pm5t3dxnjeog5a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmZoRI8ACgkQQ96R+SSa
cUWdgg/8CE3gIScDM3oCtEbZLGwD4OSB1rjOChUtnO5P0OPRFipfhafhKyDsKtcZ
JlU9aFk+lazrHXLzQNrR2Uz9ljyhm1fc3FH+OCi04cTlRlu6Eees02ZwbQaSGV1g
kDQumGpedl0oh5+dc5eTypM3CzJpmTIumJYruaGqQzj0f9P2gyOMuvrlVorwQef7
Q3aWIZOJrj+F0hAchTFUN+1jW9IGnQJLnr1kPTurHP8wntJGjMV8bE00Jji5iZCE
/zxtqWpMB/tG8Utl41W6dV3UJ7esQFhtX+xyihclFEVfvHli+k6HNtIG4aPAf82K
LNzhGRLDAeUq7EmPk7x3GHVkRhJ2A4RbLBSfYhhHOEfO7B+WPnZqCCj9WjL1UUwJ
of3PUoqDV6jHX0kkzb+2Oe0p4YtcIUhlwBWlFXJd4Pe8tGd6ISc2IznTGCViun0P
YHVH5hWEBf4iuax1gvCiaRCE/VUJIQNs6gMTNlwq/6HiP9yJQm4C8v7rgPFZz8a4
QzfaCwpopSB1husKft8lmrLb8brM1ca4iHTuqJToZuQ4dEsOI7GvNodhuVY1XVGE
YJrze66Vn1qZMJHj1zJ3P8bbqWX5I4VuhcOKUv7BoPLMotefjCPUrLQ/F+xcwW3Q
TbFHBLZBaR3lYNgBq/b0D6LebzUzhCwqBQNAwlosRMs7KmgpZi0=
=iOPb
-----END PGP SIGNATURE-----

--a2pm5t3dxnjeog5a--

