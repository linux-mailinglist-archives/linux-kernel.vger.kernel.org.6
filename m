Return-Path: <linux-kernel+bounces-529288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CDA422BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27632176C76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073E816CD1D;
	Mon, 24 Feb 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb3Cml7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96D13CA9C;
	Mon, 24 Feb 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740406108; cv=none; b=qUXd1U4t/mgHiHFPGjRlW+2yLAviDKPbNpQ5gKe1TnnME99wszoa1TeewhqD+Nxq5HQAV2HJ3c4xWf7rAKxopKvTyRiH+Dvu86w7DTnLyNzKRLkvR1E2ZSjENHSDqbwc0czKf9ih1+Ze2WBldjI8CWukJex6dNwMPqUhaIf7AHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740406108; c=relaxed/simple;
	bh=vd3B0vaoYmWrEwfvlZc/TyNtOvkacT1VFbQ0/tLVD/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBchEFtmRFV7Ufw1TUSBHrPhwWqlTvh6U8cGwEl/uaeIL8bSDW4DOr63AMlGOV1jb/fWPo9HG4AexPGCQWqYWDktcyZSvJjokPrWzJ+U+935UhoxHanKMfYCc+PUqrlpm9jMEpw1otY8012fu8mLMqjtYrceSM6M0MuzbaDa3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb3Cml7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABE6C4CED6;
	Mon, 24 Feb 2025 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740406107;
	bh=vd3B0vaoYmWrEwfvlZc/TyNtOvkacT1VFbQ0/tLVD/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zb3Cml7lejMq5Fcc9rUVdkU51MS42Z5H0wAU08RlpMTI+S18C+9pW3BPCb7HRLMti
	 cRYCHCFMHZ36BulMivJuwwXyGujWhSzNFGDSypN9izM9VJJyt7af1t4g7Y+BzhBvA1
	 zBhQuq1PzMjD9QpI4r5jJAabf20K8shucgUpv3ZFCEt6g9D+wP6QXyPTlaJRgCGY/r
	 SRnXzs1X9CGpZ2qmGjqwyo9sztbA1N/HYqbTjV0RzlVY21jeGivmNFO29Vx6Be8Bct
	 IujeOf00WGFxCJIkWDxM6yv3yBf2+uzuiQETtrW9nsGGRq8fHJxta/6H9ImEXzQNeY
	 B2EDsYzc9HkNw==
Date: Mon, 24 Feb 2025 14:08:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: linux-sound@vger.kernel.org, tiwai@suse.de, vkoul@kernel.org,
	vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev, bard.liao@intel.com
Subject: Re: [PATCH v2 14/16] ASoC: SOF: Intel: hda-sdw-bpt: add CHAIN_DMA
 support
Message-ID: <19271ec0-11b9-4ba5-bfd1-5e5521721882@sirena.org.uk>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
 <20250224064451.33772-15-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9FuncJUmc2uGyLva"
Content-Disposition: inline
In-Reply-To: <20250224064451.33772-15-yung-chuan.liao@linux.intel.com>
X-Cookie: Phone call for chucky-pooh.


--9FuncJUmc2uGyLva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 02:44:48PM +0800, Bard Liao wrote:
> When the firmware is involved, the data can be transferred with a
> CHAIN_DMA on LNL+.
>=20
> The CHAIN_DMA needs to be programmed before the DMAs per the
> documentation. The states are not exactly symmetrical, on stop we must
> do a PAUSE and RESET.

Acked-by: Mark Brown <broonie@kernel.org>

--9FuncJUmc2uGyLva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme8fVYACgkQJNaLcl1U
h9C41Af/S93+ZUOMMb1ZnGRrNKQNE5LHVu04XxEyD3E+7hsnmGL+SJgcJixB0IU7
yXMDQQ318hzyLSeW4qVBZPpghJL8ZMq1FKbzc92yMy3QX1i2DxulLs4GyIFFqtbi
hA9UI+k0W2pRTjEBrXaGfBTAdaSfc/iHBSln7sJ9DxvkG0to86axqpEZ5CSu+sbX
NBXDoW53nqYQAf6RSoSWKKF41jDp+6uYqzVrQt+EOY+NtpugxDk/dKyQppGuUfzG
kkVu3wyeA2tL0vu048eOMpoJxQfj0zvVPL8rTLNyecJ/e1ScZl4f+5OHX18dpeR8
Ud1psIi7Onk6Rcs2564rnEr1IyQG5A==
=OBwV
-----END PGP SIGNATURE-----

--9FuncJUmc2uGyLva--

