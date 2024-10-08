Return-Path: <linux-kernel+bounces-355643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31D299553E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528531F281D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D61E0E1E;
	Tue,  8 Oct 2024 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Waw8KIXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB017A5BD;
	Tue,  8 Oct 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407052; cv=none; b=eQ9cSYscszUnVDght253mVNyq+iAuDOFaRbyCaCAoXfA8tGK07PZGnpzc8LMwXnXoAs6UGNV+E1tnn5kVZLkMCJvTXaEbvWwshzcRy24s3oDlV767iB1691FLLndl9Y7HxUmYbyiCuCzj+MklJx4sk6KxZk1t9SzgWkaBwP+Cxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407052; c=relaxed/simple;
	bh=0zW938phflKE5Gbfjg/+d3eM5rugnPUhMSVe/4FineA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG2ZurKji4DdcgAz9F4EOk5FpSVLFDlbFhCk6XMEXJKUnO9m0mKh0FscIqex7z/1uGppXafQk8h9wJ8eRdf7mSvBgrIn//OIK5fiRcV3lS0CIiQ+d2c2Qdbc0lKz41i1abz6+k0DWIS836Bc+T3vlS9rZ6iCmrUKIjKR0K90274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Waw8KIXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C514BC4CEC7;
	Tue,  8 Oct 2024 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728407052;
	bh=0zW938phflKE5Gbfjg/+d3eM5rugnPUhMSVe/4FineA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Waw8KIXbNxlPOg0aGTuMsKMnH0X91YnISlWgmfb6vpJISOhgGOrYZEedRPVdpKErt
	 nl76PDOmUjajKq3xRgctaS4hxDDc4t2iok1yWgPUhBlReb5fcvd2Ka6kk0HcFCCqZz
	 LUFbozDuwOZn7G0BZZStVWStHl6QY9S7/QlPQFuGNhlE91kKuntHxB7rZvCuZluYBf
	 VZJ8KMw9KgOACfbHlkbbsxHc3zeUVZ9VE0kCS/edfMae5/RsJ+obms5CA3isE9uY2h
	 pn6K46lDkTEytBM+OXCcIbHEiG+T3oXivr8osBMcuYs/1VRRZnbLiMcch10M9jzjNt
	 1Fau/tMXJqd8Q==
Date: Tue, 8 Oct 2024 18:04:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Jack Yu <jack.yu@realtek.com>, linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: rt-sdw-common: Fix bit-wise or'ing of values
 into uninitialized variable ret
Message-ID: <ZwVmCNAVSOgqT6Qd@finisterre.sirena.org.uk>
References: <20241008164707.203792-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TyLxbKPpMzmWmzzr"
Content-Disposition: inline
In-Reply-To: <20241008164707.203792-1-colin.i.king@gmail.com>
X-Cookie: Editing is a rewording activity.


--TyLxbKPpMzmWmzzr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2024 at 05:47:07PM +0100, Colin Ian King wrote:
> There are a handful of bit-wise or'ing of values into the uninitialized
> variable ret resulting in garbage results. Fix this by ininitializing
> ret to zero.

I'm very disappinted in the compiler for not noticing this :(

--TyLxbKPpMzmWmzzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcFZggACgkQJNaLcl1U
h9AmNQf/aZQV3YFAQKdZ3rOtcCP7qCa9RyGjVNX2wagfOjCuIt5zVWmotc87gvF+
NOiue6Z/eMAHXqqWJVEKTPa8Pl0peL+cc4wmkMHpd0/tWFlNd9Xfy/xYoG1OT1lS
EcXW0qTvM/pFkWtY/p9yFK45mkapMOqU0Z4A0UnpwWjzvcjcHd2dQeJamoYGkre9
3PDHu+anhvGW5Yl8mjAjTEkSffs2hMlYo1ICJuXB2o3ZaNs2/FlfaQyNj4K5UB6H
lilIYuHCL6cExFoZ6swCi1t3kkuVYFc9qJIUfm4548Y/uL14nZdWgsjbgw4bHVFJ
u3WJoSKaEOGJUSzNZYeKX2UL2SfG/g==
=sXUZ
-----END PGP SIGNATURE-----

--TyLxbKPpMzmWmzzr--

