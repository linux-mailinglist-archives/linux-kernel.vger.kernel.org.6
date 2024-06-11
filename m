Return-Path: <linux-kernel+bounces-209664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72688903911
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A2411C22745
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FF178CD2;
	Tue, 11 Jun 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjPFo+Si"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE7176AD4;
	Tue, 11 Jun 2024 10:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102356; cv=none; b=rkQejE7/Hpb8eTf2eenQ8IK5KLaje438vazzTbFSiybMC+I392h/UmKnL4+zaa+2b8s7b6m1MkjF1wDB9YP0sm7GhRIZPA3/+6vPvIsoxB29eXdBsjESiOmP2GkYHjLd0Rhvu3AbTJrkmhqnmHdppq3rbl3db/twi3og6ncQHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102356; c=relaxed/simple;
	bh=48QYdfypmjq2I+QLwjJDC0+p53AFnmSrM5vjdg5plFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CztuyHslzX2jpTdI2V8JXuAhyScDszI7jLpVDk/11mQTOputyrSFlSzzJISHs7j7MMCObzgucMjuKfj22moePFIOTUgr/EixMpc0VFXr1T0IASRxapFQN2vRogQIwwxptcf1A3XxIo72m6MUdOhjHBAF0MgGj3EEaxy8dGPEwUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjPFo+Si; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D08BC2BD10;
	Tue, 11 Jun 2024 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718102356;
	bh=48QYdfypmjq2I+QLwjJDC0+p53AFnmSrM5vjdg5plFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XjPFo+SiEAm33bKHZdR9iuweZnZ2aj6cxv5hKjUdp2BH9FaBF68enEWGF9xXrQJ7n
	 2vjEGYoiTUd6xZvBjaIXHrCNc9UK92PN9yKShbbpbCIpMtg2tRnUyqoiKdiqcnIvb+
	 f/bU2XIXsIgFtWt1reDzv+ZRi+Q1anlnmqCqlmz7nxpOAR7JgWMUPWA8lWArSauHZH
	 vs9zAp4gEI9i3arrLtcMj3GyyCMyaz0AZhrMw2nvFeDqqRCmbikshLFXqybQkfZ0e1
	 Wi6XpN02fFvFO8+U70U5YAjO3Bl7MBk0jYjH2rp26r5PWyxnYofB6y2euhBRNPrzKx
	 zePYONOgIOCZg==
Date: Tue, 11 Jun 2024 11:39:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jai Luthra <j-luthra@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org, Devarsh Thakkar <devarsht@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [PATCH v2 1/2] ALSA: dmaengine: Synchronize dma channel in
 prepare()
Message-ID: <ZmgpUFy5-_5n_zyd@finisterre.sirena.org.uk>
References: <20240610-asoc_next-v2-0-b52aaf5d67c4@ti.com>
 <20240610-asoc_next-v2-1-b52aaf5d67c4@ti.com>
 <3557bd0f-86b4-4dce-90dd-59303f4f1154@metafoo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0TfXp5NDpMNDG3Z7"
Content-Disposition: inline
In-Reply-To: <3557bd0f-86b4-4dce-90dd-59303f4f1154@metafoo.de>
X-Cookie: Your love life will be... interesting.


--0TfXp5NDpMNDG3Z7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2024 at 05:45:52PM -0700, Lars-Peter Clausen wrote:
> On 6/10/24 03:56, Jai Luthra wrote:

> > Sometimes the stream may be stopped due to XRUN events, in which case
> > the userspace can call snd_pcm_drop() and snd_pcm_prepare() to stop and
> > start the stream again.

> > In these cases, we must wait for the DMA channel to synchronize before
> > marking the stream as prepared for playback, as the DMA channel gets
> > stopped by snd_pcm_drop() without any synchronization.

> We should really implement the sync_stop() PCM callback and let the ALSA
> core let care of the sync.

Good point, that's a better idea.

--0TfXp5NDpMNDG3Z7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZoKU8ACgkQJNaLcl1U
h9BedQf+LgwsDPZ2r9hVlvRNDyt6JZgIXzyPghbWNXb2jndRsTN0kXDZlyMRdPtN
iljCdWcV193flVjp3ZMX7IsVtIEDiMtwNuspJjIU2nXEqEgQE4FcfSkLv5Q8uIcQ
jSp1zqxvo8AFrEKQrySdNdc5iysKN265nBFq3Q7KfAVvpndZL1ZYnCbJ738EoNhx
3RgYTlvAuOIoux34F/bXbrYPsEfQseB6Z9JvxvwtKoVDcDUcTUkQv2mwlN6zzqwO
Vk8fk1bIjPmf304blTqV3T53LPtTTOQvRIFu1xeFI61zpMRRq79wIHSSBUtiaxcs
Ijdg6xeeM0a9FfxfcH5bm3UKiRhKdA==
=pWL3
-----END PGP SIGNATURE-----

--0TfXp5NDpMNDG3Z7--

