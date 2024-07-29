Return-Path: <linux-kernel+bounces-266145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F23393FB9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0E41C2291F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBAE16C6AC;
	Mon, 29 Jul 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5tqtdLZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69015DBDD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271341; cv=none; b=I0SmGK2YvL8h0uZaRASUuCw79iTG//yAZACEAe0ufBG6MPT/KcwE5E5FqJ0ctcWe+RrQltz9/z6SfTv7XeiJj3SSc5Cun+fwwsOzpi9SK8dgjo61U9rf5ttY4cFEJ/GBbADvm2m4xOm1purDqtfTLgLqptrawszsBOcQiUXnqcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271341; c=relaxed/simple;
	bh=BgcRqKiDCihQph7GkqrD4JQhL/HY9twKibTZZYxxhjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxBxBNSrr1WoH9oTi9HYIsCAbor2UoC3ShuxYoVhIBo6AexxRHli03/Z+8zox2Em/yS8f0mX9BWMu4GgH7K7sFUDeLSHBL9L3ki4L+CF/5X6hhKtcScqLBa1ubqzkVIb5/q0Xu7y8E7laZnKUGsIDNYLY5fUWl1dHlCNChOr34c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5tqtdLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947B8C32786;
	Mon, 29 Jul 2024 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271340;
	bh=BgcRqKiDCihQph7GkqrD4JQhL/HY9twKibTZZYxxhjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5tqtdLZgPI+wH5vT8AwzFSQuutBwUQXSMlOpoJVm43rIqpMCbDHcD6aCiysLb12n
	 POGf1IPb0yXn78b312PT/Gu4MISy4OuGHTfQMCaOjO5J5WMlJWWWVFyHDrYXDoZsdO
	 SKzUl2HV7kDh3R73dz1SayQQgSjXb8TK1Bt8OLuSro89QVHzC+I9MBhtZ4Rdvk3U1y
	 6JY6szNEEemCjrl4BGJKmBEXlBSeD/Kf04B4FQttMTG1H9/Lebc/VtXTVGgDBVASPP
	 2I34eM/S/O3eeMHR3Fklnoij1uCO7KQaRHX0VAtnDDa0b8XJs/UN4BMO0oOs3ZVQ9W
	 H1G72iq/6w6DA==
Date: Mon, 29 Jul 2024 17:42:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	zhourui@huaqin.com, alsa-devel@alsa-project.org, i-salazar@ti.com,
	linux-kernel@vger.kernel.org, j-chadha@ti.com,
	liam.r.girdwood@intel.com, jaden-yue@ti.com,
	yung-chuan.liao@linux.intel.com, dipa@ti.com, yuhsuan@google.com,
	henry.lo@ti.com, tiwai@suse.de, baojun.xu@ti.com, soyer@irl.hu,
	Baojun.Xu@fpt.com, judyhsiao@google.com, navada@ti.com,
	cujomalainey@google.com, aanya@ti.com, nayeem.mahmud@ti.com,
	savyasanchi.shukla@netradyne.com, flaviopr@microsoft.com,
	jesse-ji@ti.com, darren.ye@mediatek.com, antheas.dk@gmail.com
Subject: Re: [PATCH v1] ASoc: tas2781: Move tas2563_dvc_table into a separate
 Header file
Message-ID: <1dc0518a-f0b3-4617-9c79-ac903ca9ee33@sirena.org.uk>
References: <20240716061123.127-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Uj2v2I2plHuUzS/C"
Content-Disposition: inline
In-Reply-To: <20240716061123.127-1-shenghao-ding@ti.com>
X-Cookie: Penalty for private use.


--Uj2v2I2plHuUzS/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2024 at 02:11:21PM +0800, Shenghao Ding wrote:
> Move tas2563_dvc_table into a separate Header file, as only tas2781
> codec driver use this table, and hda side codec driver won't use it.

This doesn't apply against current code (or your other patch to this
driver from the same day), please check and resend?

--Uj2v2I2plHuUzS/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmanxmEACgkQJNaLcl1U
h9BzyAf8D0ct9/VEgNw15CMnmzG4y4KRg9EHMkwsoF+BaINwcHnkiwJNDpFxglMv
I5yVs+R11sSTd1ANo3WEAkqVBmSuRax/wnxG0Ffdq/vFCkqdneSMsBYLqLu5A28M
1uyy0XN6IG83iG9ctvMs7ArHhS3vXBYdLVBMbh5WnmjUV+B/+1GkcmTVSUFfgzYw
6lBI2zyWCLZ5+1FuwYQAvVpPu7OJn8c7zbzRLPJqja87nWCEimxy7bURkovKRCCj
J/+IDL2VNVmfKnsDg9NpN1gW+D/mFQBfFsBcjZ0r27dBJdqN/989mqqFDt+8otYt
AI8a2Kqf7KnKe6DYJzk0M86mqoHh5g==
=v+3f
-----END PGP SIGNATURE-----

--Uj2v2I2plHuUzS/C--

