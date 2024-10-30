Return-Path: <linux-kernel+bounces-389264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF679B6AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000101C206AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27A9219CA9;
	Wed, 30 Oct 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNXeP6SX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E196219CAE;
	Wed, 30 Oct 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308255; cv=none; b=cdgQAOXlW1c48eFKbopoUwgQ0Trvse2g+U+RAEPDYF6T4MvoHJ4GqeE6d0W0jbdUYMeBnwwMCRZ3byuBQuU4+CbjNa/d5qU7RXj4ikD2TXs9pTmKV1GWWVuMzT8AYVleQ1cPQwBmb2exic66A/fLh/2Lt4SRwITGs2S6zSCvIFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308255; c=relaxed/simple;
	bh=ca3vfwRVxz8HR6hgXtbC1AS1aZ+zuvqCi4svlgqeCWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0X+Q6PjO0hgrKuKqkSxHBef1ExXhkVrAccWfkYFNp4hw6+txyOdoD+1a6f34nOCROrU2M+9edQq68KocwCYwOra3tiw+m+rQhrOfgcqkRXfbExXAnQDP/kQFEJEz1YSHZhjCk9XfGsROMkGqcoL37cBrzs2jDVRq/TKcv3OpGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNXeP6SX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0604CC4CECE;
	Wed, 30 Oct 2024 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730308254;
	bh=ca3vfwRVxz8HR6hgXtbC1AS1aZ+zuvqCi4svlgqeCWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dNXeP6SX8hI3T+FtiH1wngFf1zAURzcXFYkjCRiF9O6dwpIl4VLrunPRCfZChiCQO
	 JMLrWWTPAY3G31ZkFFjU86EiaO/SPBB1ByfXhr4/Q3ONCKX1dVg822ieYDAXfEibSY
	 gsSB7wmq0+6d/KYZKpCQy/PQvZWhbgDEsQswnPa+Uxdp1KAM7YDcfEiDVwhWQXa40a
	 dmdvDtAR5x59D/w/Yov7fk6jixyu4ruz7WsAn/3Q8WdtE+SWVYurOHP0erVQ42GNRs
	 Vl1pnkVkjP27FjeRTAebcDPILlalWWw5BdgMG3pKASrsWkYIx9vDdCXm3SqjtYwJ8i
	 Yf6NOtxJWdtBQ==
Date: Wed, 30 Oct 2024 17:10:49 +0000
From: Mark Brown <broonie@kernel.org>
To: Suraj Sonawane <surajsonawane0215@gmail.com>
Cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev, perex@perex.cz, tiwai@suse.com,
	sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: fix uninit-value in
 sof_ipc4_pcm_dai_link_fixup_rate
Message-ID: <28112e29-e326-40d7-a550-d3466f454658@sirena.org.uk>
References: <20241030155705.31327-1-surajsonawane0215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ga2wZhdiu8rFg1Tl"
Content-Disposition: inline
In-Reply-To: <20241030155705.31327-1-surajsonawane0215@gmail.com>
X-Cookie: I feel partially hydrogenated!


--Ga2wZhdiu8rFg1Tl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2024 at 09:27:05PM +0530, Suraj Sonawane wrote:
> Fix an issue detected by the Smatch tool:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--Ga2wZhdiu8rFg1Tl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmciaJgACgkQJNaLcl1U
h9APzgf/fL3lMz/XXfWEBQ/iT0vfIFKAZ47WPnv6HT2WN7alwh4+3oMMjf22j4qJ
+ma+KvxEp4lv+OnY5aEOWZu+qFpcX2DuDfcwtTRPV60IUKM2KUDWYZ4VUsiRP+Dt
N5dbKJ48/G/tZtD1whLnvcMdzKgsr6skNR8fxMYi6WcNlOjX4dUJoKj0vAEcGeIV
iiVIlD23U4PZe3iABYGgvfXMto5+IaHNPPz00gNUF28NpTE1BKeJhqd3frsj8iSi
N7gB58DVs7pqFFvZX1H9UaIdZ8KU/kP6HHsq0VDy6RQX7z39KrCuDkcFeMDzcIRG
qmCGISo5uGoFCX7dpTKf/ZilT7+06w==
=7Egp
-----END PGP SIGNATURE-----

--Ga2wZhdiu8rFg1Tl--

