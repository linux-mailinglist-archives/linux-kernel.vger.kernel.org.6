Return-Path: <linux-kernel+bounces-185329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F78CB38F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F23282FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAA148FEB;
	Tue, 21 May 2024 18:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw31hlnj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E81487C0;
	Tue, 21 May 2024 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316588; cv=none; b=l/umpAsJdtlssCz4Dt/tZwlqMAxl863vqxonikHRtQ5VIoqN8Qn8snUY6kcdIkV/8Dr7kzpulekqhc89DugtF0goRp790xXmRennB57WrdtMiOFU8BXPp1dZcpbpZ6YtoJT+EuQaI/Eb0yQd8yvZMTKkTXwt4cjAqeYcOkbnFtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316588; c=relaxed/simple;
	bh=Qif+DrNGwZw6ld87IATmKiKJraQRzZ2B2ke5q3Vf1kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvpwqcbxTvg6V0PPGJT1J6GxZZK9nFTeoMe8oKjWeDSJUgF/k6B5IxF/LzjWXJ55w38uHm5aXkeVZBDKFvSJb3JZV82YBkx+lc5LOH0PXCZHsnLLoSNUMLRmmDlP/931eBePs5BSjlrDNtNBM9vjG6TZxczCk89BBlSEtPpAR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw31hlnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F1AC32786;
	Tue, 21 May 2024 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316588;
	bh=Qif+DrNGwZw6ld87IATmKiKJraQRzZ2B2ke5q3Vf1kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xw31hlnjmdxoiYu1/ESkfQc7CLKhglUtdXdIzzgpQQ90NRMCoM6yLMMbwjKCL49I6
	 7oF82dHen9MBjEVBaFuMyb/oD+of4pKvn+CRgEKQgnvBnQMqWi5qJRg1Y0SDI7MeDI
	 Hm9Do2fludPafkyxRogReGjWToAskQEqhU9luCcSIYQ/cEfx53kYlhJ0LWZnw+854t
	 xCBPZgV8K3gQGxdWWxhaLf773tnO9hKbkT6yV4wbeeRwHsmkXqvXWuagmKa9Re1h78
	 dxn3BvYVkUjTMHkwcIcKCp893p7MwfLbTKz0TlugXiVrxfkV9O66TKbFcb92ENC5d7
	 IySKLBfpikgvQ==
Date: Tue, 21 May 2024 19:36:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	sound-open-firmware@alsa-project.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mete <yurnerolinux@yandex.com>
Subject: Re: Fwd: Garbled sound at start of a playback after some inactivity
 on said channel with DP/HDMI on RDNA devices
Message-ID: <03d0fd01-278d-40ff-afcb-7107394b89eb@sirena.org.uk>
References: <ZkHKYocpP-abFwLB@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L6sjAcF/gQbrXx+k"
Content-Disposition: inline
In-Reply-To: <ZkHKYocpP-abFwLB@archie.me>
X-Cookie: Eloquence is logic on fire.


--L6sjAcF/gQbrXx+k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 13, 2024 at 03:08:02PM +0700, Bagas Sanjaya wrote:

> >   Device-1: AMD Navi 31 [Radeon RX 7900 XT/7900 XTX/7900M]
> >     vendor: Sapphire PULSE driver: amdgpu v: kernel arch: RDNA-3 bus-ID: 03:00.0
> >   Device-2: AMD Raphael vendor: Gigabyte driver: amdgpu v: kernel
> >     arch: RDNA-2 bus-ID: 12:00.0 temp: 39.0 C

You've CCed a bunch of Intel and NXP people for some reason but whatever
this is it seems to be an AMD issue?

--L6sjAcF/gQbrXx+k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZM6aUACgkQJNaLcl1U
h9Bh8Qf/TD463H97TlPpFR7DeBL7xGVV4ZBbaV2EuT0tQkaH840iSaXSmATQDLy5
o9eB2MF2QZI3GdTlwuRhmmGxzyXF62lfNdbYQ+NMfmM/Dm3H/HaXqF2xG0Qxxaid
lPdQz5w/Spz69WVPCn74rJtwjP03NNvJ18UDs5rihSCEh2AJ/UfCfQYtkoeCZzL6
UVvzxC64m8l2VJhRmeSEG6eIAznpLdj0VUdkqMvrBp7H2Yp7Gmh3wycDW03iXy6B
avSgOoEEubmixFymQEt12HGRB0Lj2lTfsVvDmYqpz9ogPh2WyT7+K5/NldJLxZA7
5/Pk7Ba5K4YwVn7+6xnblFvKrjGqcQ==
=lmKP
-----END PGP SIGNATURE-----

--L6sjAcF/gQbrXx+k--

