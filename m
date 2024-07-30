Return-Path: <linux-kernel+bounces-267468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC129411DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22EBFB284D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823119FA77;
	Tue, 30 Jul 2024 12:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmuBha4/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910419E81D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342454; cv=none; b=m3UQJ+hWY+CI+ppVRNZWgfSgjBfvheTCwow6rPypw3ikEBnE0pwvx5sEis2q78TyqPCBGAjli+ELDq5O1t+ZqTC26I/sFbVogQMtjM4MEVhe1WBlQUh0hk9BfaUbik4aVXDiGjPcTKWBtSTfQ4RaAuP67p6sFsEsXZoI3g/2+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342454; c=relaxed/simple;
	bh=prajFAXc15IKFQqLopgO8RX/edCg/+NlgdG7rdK6U/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebg1+rIivuhPPAH9n4N39ZdFmCLwsFte6BYRdUnlWdvD2WxxiMfRJHC0oVHUqdXJvAzvWNue10lVxMcw75gBuRpMn936z6x2njCD+pc8NQ/Dd6s1CrH4Z+WaX+l11zQD6qBeihbowEn6DnXj76YTadSOq8QPrXm9fnFIVPzTxhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmuBha4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A2DC4AF0A;
	Tue, 30 Jul 2024 12:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722342453;
	bh=prajFAXc15IKFQqLopgO8RX/edCg/+NlgdG7rdK6U/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmuBha4/V+uRHTVN+VPOqRW/TQ30dPB6xXATXhyonRat7B2RfN7P8YkKRrE15qFRi
	 WtBcvhKW1kueI7YgCPrv6BLxE5NKD9iAj9syawPvx42rRHJaCisiKyEPxpQVNzwy8Q
	 DGkdm0+qPLQR3GaHqDcfUt2JlAYCzE7/OyCbgRx8ts4l5bF86F7C10l/WvgfiQfemg
	 EO3ejrHVI4CvCYfDrmIjimYePkS5bvVsfq7esD/RZD5V+MghD5OYnmhuFdJq/6Y6ih
	 3OyC97nXxoWq8QXRHxoiOLqCs7+qF5STFLIFhdqPOQ+WFECAiA0+z161AcGqOTjTCU
	 Em4SEGCQRSBdQ==
Date: Tue, 30 Jul 2024 13:27:24 +0100
From: Mark Brown <broonie@kernel.org>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>,
	"pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"zhourui@huaqin.com" <zhourui@huaqin.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Salazar, Ivan" <i-salazar@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chadha, Jasjot Singh" <j-chadha@ti.com>,
	"liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
	"Yue, Jaden" <jaden-yue@ti.com>,
	"yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
	"Rao, Dipa" <dipa@ti.com>,
	"yuhsuan@google.com" <yuhsuan@google.com>,
	"Lo, Henry" <henry.lo@ti.com>, "tiwai@suse.de" <tiwai@suse.de>,
	"Xu, Baojun" <baojun.xu@ti.com>, "soyer@irl.hu" <soyer@irl.hu>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"judyhsiao@google.com" <judyhsiao@google.com>,
	"Navada Kanyana, Mukund" <navada@ti.com>,
	"cujomalainey@google.com" <cujomalainey@google.com>,
	"Kutty, Aanya" <aanya@ti.com>,
	"Mahmud, Nayeem" <nayeem.mahmud@ti.com>,
	"savyasanchi.shukla@netradyne.com" <savyasanchi.shukla@netradyne.com>,
	"flaviopr@microsoft.com" <flaviopr@microsoft.com>,
	"Ji, Jesse" <jesse-ji@ti.com>,
	"darren.ye@mediatek.com" <darren.ye@mediatek.com>,
	"antheas.dk@gmail.com" <antheas.dk@gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ASoc: tas2781: Move tas2563_dvc_table
 into a separate Header file
Message-ID: <e8ce11fd-ff6a-4ca0-ac33-5abf20cf242d@sirena.org.uk>
References: <20240716061123.127-1-shenghao-ding@ti.com>
 <1dc0518a-f0b3-4617-9c79-ac903ca9ee33@sirena.org.uk>
 <9f92b5275c3e4b7d896e90f8a654f11e@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M31YrSuujxfYiekN"
Content-Disposition: inline
In-Reply-To: <9f92b5275c3e4b7d896e90f8a654f11e@ti.com>
X-Cookie: Don't SANFORIZE me!!


--M31YrSuujxfYiekN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 01:24:34AM +0000, Ding, Shenghao wrote:

> One more thing, these day my colleague and I want have some adjustment on=
 the=20
> tas2781 driver code to support both i2c and spi interface, and plan to ab=
stract
> the common part, especially the dsp binary parsing, as a shared lib. Woul=
d you
> be so kind and give us some advice on it? Thanks.

That seems like a sensible and reasonable design - factoring out common
code is a good idea, there's a number of existing drivers doing things
ike that.  Possibly the biggest example is the Cirrus/Wolfson Arizona
drivers and the wm_adsp DSPs they use.  Do you have specific questions
around this?

--M31YrSuujxfYiekN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmao3CsACgkQJNaLcl1U
h9BGQgf4kAzdugFNKyAftef9KQS+4e7h1g9tO7s0fepdIaECIgySGuABwn0nfyjh
DKoldNoNHuv/YOW7I1iwHkcgG+WGaR7i2cfecBTBmHOmuELB+HUx+3WypdxiVBJA
QvtR70ebI/7G3f259pd4v1PIMxNt8gkIn7hYyouqI21ocPKd9W93lR7lzia/B42a
p3zrqgnIgXH8w724gwYjuTdYQfqJPoHUPWNGtLoT5Vcpd6SPtq1aC2L77E5buUxa
21LXUGX3h3X4up38Cd4jaPb2Y/+3bPzW++33PhEcTSgc456HoNHXN/z1+k9/+b8b
4IJb5mBQWptGhDn0Pv+DucscmB8w
=3BSB
-----END PGP SIGNATURE-----

--M31YrSuujxfYiekN--

