Return-Path: <linux-kernel+bounces-199087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B81E8D81F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090A528A335
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD712880D;
	Mon,  3 Jun 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+nACH0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D5012838F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717416720; cv=none; b=cEelh6xnyb8WXIIVtsB/isXIH9PNgt6ybhoAiRKM2Kn6Qo/XGNPub4LBBO/sM+SpXprs68JXDTjvZgcq/V0nKqEMYAZdohLs0h6PQ5S+qIaaT0u5XAf0Z1825QAgHFS7jODGkdl9ry37AJECq5S4qku+JPWwUEOY+8og+9PQack=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717416720; c=relaxed/simple;
	bh=lfdsBvkspToag3c/bUTNykKvotNjW4bx0y0kYS1g6DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+72syTeY9r8qs2PD5ZrEV1qxdqH3baPnE4ft8P1pyqnb6cVXdCtrEBdaMGEVCCbGiwAJVcV8Nh4wPKSe0YfFxiipLZAG0siHOO943XtzW76gcq3RAJwVXFScIE2dJKOeLOZZ4fkYFxdIbvqSPsOloB2MspNGOTOrP4u1WLo3nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+nACH0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BD0C32789;
	Mon,  3 Jun 2024 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717416719;
	bh=lfdsBvkspToag3c/bUTNykKvotNjW4bx0y0kYS1g6DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+nACH0N3OERh+uTdpTd1+TVluP5kqPo1Oo6tP+KKUeE9/WuE3z4YTlDgEbmH21BT
	 y05bLUgOC9kWbCtFyTKUHDjyCuOp76EPRI4Ek1Elm8x73DFX4vxQNCam2Z5iNfe/i7
	 DgK57ezDygRoz1qvg80prkeWuwYbsAGEM/lw1FSZtn0IwWGS6V5bpELYdRihxIuEDu
	 yCzNwpkOKwxFA4Gpe4aTKPPb0fS8fagSmk8H+u+G4evgQcpDec454LGPaiDVosjDoD
	 L4lo8iXqMi9pGez80iYHdgyfF6yzIpwYJRPND3ajsezj5jioK2gwh6xO5byJJnE0Ob
	 flE6jrZ1Z5vbQ==
Date: Mon, 3 Jun 2024 13:11:53 +0100
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"tiwai@suse.de" <tiwai@suse.de>, "Xu, Baojun" <baojun.xu@ti.com>,
	"soyer@irl.hu" <soyer@irl.hu>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"yuhsuan@google.com" <yuhsuan@google.com>,
	"Yue, Jaden" <jaden-yue@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"Hari, Raj" <s-hari@ti.com>,
	"zhourui@huaqin.com" <zhourui@huaqin.com>
Subject: Re: [EXTERNAL] Re: [PATCH v6] ASoC: tas2781: Fix wrong loading
 calibrated data sequence
Message-ID: <90d891b7-1978-4a6c-86c6-bb693ce764d0@sirena.org.uk>
References: <20240518141546.1742-1-shenghao-ding@ti.com>
 <171623322336.94469.13172149100331733795.b4-ty@kernel.org>
 <138b621eeccc47329ec5fc808790667f@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t56nSOAk9HiTDqnB"
Content-Disposition: inline
In-Reply-To: <138b621eeccc47329ec5fc808790667f@ti.com>
X-Cookie: Don't let your status become too quo!


--t56nSOAk9HiTDqnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 02, 2024 at 01:11:39PM +0000, Ding, Shenghao wrote:

> One of my customers requested tas2781 driver in kernel 6.10 to be merged =
into kernel 6.1.=20
> I wondered how I  can handle this. May I resubmit the whole code into lat=
est 6.1 branch?
> Looking forward to your reply. Thanks.

You'd need to do something yourself - the stable kernels themselves
don't add new features, and I think v6.1 is not updated any more anyway.
The usual thing would be to do a backport and then publish it somehow,
some vendors have git trees they use (some use github), some share
patches via e-mail but there's a bunch of options there.

If this is for some OS vendor (or for use with a specific OS) you may be
able to work directly with them to add the driver, some OSs are open to
that but some aren't.

--t56nSOAk9HiTDqnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZdswgACgkQJNaLcl1U
h9DcVgf/RD2+kBh2SKALVqSZ99xuZFSd990nWdqi3Aim8rirFq0UVLho/uxX8/9+
+LdSe+lxv7oe6obTwdi+HHSOGc6dT21CKgpTXNLEyMid6W44zfVbSJdD6f7g4CXD
35MolBudlb3YCMfWttDYYeLzeBH1WG2dT9v1CK5R5zbhUGStgkU3ckg/QStOV0n6
0yLlupgJnhL+VeBtqvxaqgj7DMbDcoyKK4Fo5z1R2/fyJt0pJey7fzk2vUZVwH62
Zg0P7cGy3P+T58UnYIrkLWOFxdQ4V3X67q10waHTOFk/X3pkS0zqsavhxBE4R+Bp
fWaKvle81uJXipvaT4SJs34ce76yfA==
=cwAZ
-----END PGP SIGNATURE-----

--t56nSOAk9HiTDqnB--

