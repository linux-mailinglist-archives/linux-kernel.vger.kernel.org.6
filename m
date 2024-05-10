Return-Path: <linux-kernel+bounces-175309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1436A8C1DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455131C20DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4D515B116;
	Fri, 10 May 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcxfVZkH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FF14D716
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321647; cv=none; b=p86Wa3JseWvQXrhC2m0vFVmphRnt9/rZKrMfVC1RS0L/RzFp7cO33GEpDs0sZSAt+JdQkec2Zpha9pqq8nkHanmViojjpXhoeAhG7q5OVNl9qLoNSZYCJRtFZLENonObDf5wb01P6zBX+iwDs0yG5xgDN8tTq013UF1Lq/wglBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321647; c=relaxed/simple;
	bh=GcGGzGvYTnpARMt/AI5IU7S4k5OFyk1tpsWpYMoYjcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Df7kAR43GxV1p/CIoHR6GdwNcMsS8TB4D8OvDbkub3Gzw0ugm2U9XnRKUM4eD3mn0pKdbNo+PcJCjtTaZHVs7iFTuEekC1WwwMMBhVlQGl4UmEcJVZVxFSRRmcdfMxFpa8fI2BkVWBgDE5lF9QCvyR+3UQZAupaF12wYI4GJ5jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcxfVZkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD07C113CC;
	Fri, 10 May 2024 06:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715321646;
	bh=GcGGzGvYTnpARMt/AI5IU7S4k5OFyk1tpsWpYMoYjcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VcxfVZkHI2PN9GT/A6Ie2JpUCLXvDZ445sFIKtu6SteAEJNjUEIQmcSPtTL9Gaff4
	 9F+i4dcWBCvQA+c2jHCvTcK0vTrEC72EQLiig7BopziafxXVX2gXJMX5OO7+kxyr0U
	 p9U39b+JKiWRmO1xfVlfNzTKz8cRpti/PQnJsXkmEu7iwKFV97iUz3NhPSNUJt3O6G
	 blDtJy+LTrw51bUX2cjujeqpByvrjN81pldB/ef8JVDGxdlKmoCR5PBsVS8RBdrIwF
	 +xrQyRCT0mnb8Wh4oYrc7VdpvOdpR+NOnu1ivJh0UNUwHvAGF2ggVlRalqTlrAKONo
	 weeHegGwXFt+Q==
Date: Fri, 10 May 2024 07:14:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v4 2/3] ALSA: ASoc/tas2781: Fix wrong loading calibrated
 data sequence
Message-ID: <Zj27LHKXSFXx_6G2@finisterre.sirena.org.uk>
References: <20240510034123.1181-1-shenghao-ding@ti.com>
 <20240510034123.1181-2-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XFZRnGJeJ9yJiLPF"
Content-Disposition: inline
In-Reply-To: <20240510034123.1181-2-shenghao-ding@ti.com>
X-Cookie: Did I SELL OUT yet??


--XFZRnGJeJ9yJiLPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 10, 2024 at 11:41:20AM +0800, Shenghao Ding wrote:

>  - Divide one patch into two individual patches. compiling warning patch
>    has been upstream in another patch (Fixes: 1ae14f3520b1 ("ASoC: tas2781:
>    Fix a warning reported by robot kernel test"))

Oh, I see what's going on - when you split a patch up into several
patches each individual patch needs to have it's own changelog
describing what's going on in that specific patch.  If you just
replicate the changelog you had for the original patch into each of the
split patches it will inevitably not describe the separated out patches
well.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--XFZRnGJeJ9yJiLPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY9uysACgkQJNaLcl1U
h9C/xQf/cyPxlEXFdtS915Zzymf6A2TgMO5OeS1+5HrB001oEMTyOX9DmHRVNiZG
53thK9VMJPUFZcw/qrjxtTRSV8Uf2zOx7YtC7QXCyonB3HM4MwRk6wvmF0n1AV/u
jBamorjme2Bfv1lqfPvv/guVNWhl0AUOWnDlBNYfU9Q71/MBADrixWHqACG0GLO1
MvgUgBYHXSj9uUbtcLNhyUY4chDk6lx7L2DP8lIC8dGrxK7r5W4j1y8Wodnn5RlB
oehwsucjA/N5Pgw7ZuXRAcaXnZYgsdVPIlG7IKGjBXhAh0aK5+QDtWR9Td6bfmsb
La3dh+SC1AEosVa63EqnSlaFgs1R4A==
=VKsH
-----END PGP SIGNATURE-----

--XFZRnGJeJ9yJiLPF--

