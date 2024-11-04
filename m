Return-Path: <linux-kernel+bounces-395389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991E9BBD44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89004B21550
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3141CB530;
	Mon,  4 Nov 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joJ9Ibb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031141C9EDB;
	Mon,  4 Nov 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744854; cv=none; b=r4ud1Cj4sXla2GkyFFkdwVcxHgASh4hDtgLOf7Y0lW6/FTQtTh1Dcm6eGpL3RkF6U6Bphu0IOFYIc40H+Aq6RAPI6u+2opXxBVnj28La+cAFfxyLfdpzEOXWjn1ZAPK4Gm62HhxXoh/J4KmobNHiJrXhElde32hIXF7zjrNsxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744854; c=relaxed/simple;
	bh=CKBWtU4GRwbElT4iatXhq6MbCOH4QUyqf9y8QhcrITE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8WKR48hJrAlNrQugW2q74IRiZkzQTxb0NimQBDdfreDvmhuPfpu12yjAtxk3iygTOi+h29fDqtBa99/J57ac+MSAva5qFbwK261p3fCFfeDbrHjwBZ01+MqOnND8/m7okd7V9ehfb6sPaI134AuCMgprRp/uI+Qq+s8REZaihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joJ9Ibb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F037BC4CECE;
	Mon,  4 Nov 2024 18:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730744853;
	bh=CKBWtU4GRwbElT4iatXhq6MbCOH4QUyqf9y8QhcrITE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joJ9Ibb1clP/25G7DfAJgTGMmPFZ2cDID+BuLHToL5dg6KVhcRp/pI7o3tN+qlcLD
	 ylp+VHx77luQ2CI0HfHpGGud7b6hZbdaGuvnyeqHjaYfD7C7AXbSsq5kBLO3//Wn+h
	 BtkpaUNZc0Oc+DQKTz8lr8XsH+kYibhjJdT5RI02qS9QeoK1OAoL3CWNhQx7nB13wj
	 l7UZ8u2SCbP+BYcC1eljStbMQVDly3LOiFTQtV9CnGKeIvSVYxP2Nfc4rejt/3vMiB
	 rMI1RD4yfihWp61JIg0ooGHv1ZgjBulglzC1kIy6z21peOvpnkKSQIhai8asAoTSGu
	 BP329W4/whkCA==
Date: Mon, 4 Nov 2024 18:27:28 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Suraj Sonawane <surajsonawane0215@gmail.com>, daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
	perex@perex.cz, pierre-louis.bossart@linux.dev,
	ranjani.sridharan@linux.intel.com,
	sound-open-firmware@alsa-project.org, tiwai@suse.com,
	yung-chuan.liao@linux.intel.com
Subject: Re: [PATCH v2] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
Message-ID: <d19b77e2-496b-4633-a69c-576cc79c004a@sirena.org.uk>
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
 <20241103113702.27673-1-surajsonawane0215@gmail.com>
 <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f5+v6BDU93UAdGtJ"
Content-Disposition: inline
In-Reply-To: <09d8462d-d305-4b83-ade9-747a88aedc38@linux.intel.com>
X-Cookie: The meek are contesting the will.


--f5+v6BDU93UAdGtJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 12:52:09PM +0200, P=E9ter Ujfalusi wrote:
> On 03/11/2024 13:37, Suraj Sonawane wrote:

> > Fix an issue detected by the Smatch tool:
> >=20
> > sound/soc/sof/ipc4-pcm.c: sof_ipc4_pcm_dai_link_fixup_rate()
> > error: uninitialized symbol 'be_rate'.
> >=20
> > This issue occurred because the variable 'be_rate' could remain
> > uninitialized if num_input_formats is zero. In such cases, the
> > loop that assigns a value to 'be_rate' would not execute,
> > potentially leading to undefined behavior when rate->min and
> > rate->max are set with an uninitialized 'be_rate'.
> >=20
> > To resolve this, an additional check for num_input_formats > 0
> > was added before setting rate->min and rate->max with 'be_rate'.
> > This ensures that 'be_rate' is assigned only when there are valid
> > input formats, preventing any use of uninitialized data.

> > -		rate->min =3D be_rate;
> > -		rate->max =3D rate->min;
> > +		/* Set rate only if be_rate was assigned */
> > +		if (num_input_formats > 0) {

> By definition the copier must have at least one input and one output
> format, this check is going to be always true.

Static analysis of the code can't reasonably tell that, we need
something that ensures that it doesn't detect a spuriously uninitialised
variable here.  Possibly a

	if (WARN_ON_ONCE(!num_input_formats))
		return -EINVAL;

or similar?

--f5+v6BDU93UAdGtJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcpEg8ACgkQJNaLcl1U
h9DKywf8Ce6RMkQi51AuKN/2vWZ6ETHIHkyh5Y1nCU7vJ0DVzwbqAk2AzWExYvZv
Oc1Ls3z0akVISRjusKzoBt9srKmhjoixTfjtPIrAzgx7vgoGq9Fko3eoMKohUIG7
Ct6QYPmfSYtmxbNb3b3YR3yIzr+vwTh/TsFGSuQm0dWJtcZbn2q6Tftb8PcjKhA9
Zldyq8N4OD74OWuftAHixtJDlS3c3gxS3yDmiteOg/yKQUwSPJZq0mKqcG/QjOu1
LWzaO4sRfG4XnparU24enWXjH71FAe0DjtuQxCXRDBTmVESBgoYQyrZ8ylRsxi62
rZFqE/iqe7ZQ6dfuBVxITwKKmWfDXA==
=Noxs
-----END PGP SIGNATURE-----

--f5+v6BDU93UAdGtJ--

