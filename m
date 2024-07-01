Return-Path: <linux-kernel+bounces-236230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1D491DF0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA20FB2127D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5E14AD35;
	Mon,  1 Jul 2024 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYTfgAP+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209152231C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836618; cv=none; b=jW6lJUAkrOpg7QfDU7WtlS646GJDyXZaSfY7kI0wrT+yK4iQlqIRS2sPs2bC2AzF1+bFULjvIXPcF+04d3oVfiip2hejJIDGeSrvp75zlhByPDqH4BHNHMlp/08yOyggZS4etRyvPSlPzYkgY8bUW2EsHDLzcOE5i8a85w6lnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836618; c=relaxed/simple;
	bh=Kk7hKCQ0rQ+4DfET7z3nKVAwpR0YpyaypAt5Z4/yygU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1E/p0EXC9xck1NuANpqRbfS8rZd5CTo1wzgThqTQYd10ENjPOwr+8TMExMY2TbA645x3UofMVRvQoJaA0cNfwJly2h6WhxkrargMYfIiHwDeMVIAfUAr5BIdYT1GRYYFTmT1mqyh9KPPGXLhS1UXZE8eIjEylmccrVKYUuLiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYTfgAP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2C4C116B1;
	Mon,  1 Jul 2024 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719836617;
	bh=Kk7hKCQ0rQ+4DfET7z3nKVAwpR0YpyaypAt5Z4/yygU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYTfgAP+PnpdcDvOiS6uYiXMxnWqyUy7iLWgwdJFh19XyfL1qVPmyEE0Dk30LvsiE
	 MOzQdka3sE0v7NxV9dM3OJ9nyLKvjvq7H9DRcqRdMReMAUq/tsD0zjJHysna6E8wMX
	 ehhzIOT039uU9Fk/B9AVhrg3p0tYYNamVa43fFFHS2cHC0LunA1TY13DDeROhtGh8P
	 7hnmDSfyQ57ma4p7IGwNgii10cHwBgIKWjuhOah5KGsgbDsjarUxD+2SES8r53WO6g
	 +fkEgdgkVBOg8q7sqrju1riU8sqwcSuBRG/MIyDCPwZlIZ5kKwcfXdHXLWom90ZhV+
	 nxawNl1MEnFTA==
Date: Mon, 1 Jul 2024 13:23:28 +0100
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
	jesse-ji@ti.com, darren.ye@mediatek.com
Subject: Re: [PATCH v1] ASoc: tas2781: Add name_prefix as the prefix name of
 DSP firmwares and calibrated data files
Message-ID: <8245d8e7-3ff0-4f05-9f99-666e9693603f@sirena.org.uk>
References: <20240629101112.628-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oDtmPYbAjS8IMFoF"
Content-Disposition: inline
In-Reply-To: <20240629101112.628-1-shenghao-ding@ti.com>
X-Cookie: Microwaves frizz your heir.


--oDtmPYbAjS8IMFoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 29, 2024 at 06:11:10PM +0800, Shenghao Ding wrote:

>  	tas_priv->fw_state = TASDEVICE_RCA_FW_OK;
> -	scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
> -		tas_priv->dev_name);
> +	if (tas_priv->name_prefix)
> +		scnprintf(tas_priv->rca_binaryname, 64, "%s-%s_coef.bin",
> +			tas_priv->name_prefix, tas_priv->dev_name);
> +	else
> +		scnprintf(tas_priv->coef_binaryname, 64, "%s_coef.bin",
> +			tas_priv->dev_name);

I'll apply this but I do wonder if it's worth falling back to trying to
load the unprefixed name if we fail to load the prefixed one.

--oDtmPYbAjS8IMFoF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaCn8AACgkQJNaLcl1U
h9AjwAf+J1+DRZh2rLJitmV5riPW1tq3dorqJvTbAeR/1xGl1WZ7R2aHDVOroOTb
mZSHnVpCNk1L1+rU61q2Os1+rxCLgVfTlWOWWaqWcmRak15vDsvF875AT5GAy9I6
pYxsqfFkAWsQEhXL+4FnWu63CF1AR1x5nAclAwz86n263fH7aI0xpBlwzWyAAilA
SoGUTcqDCylt7Y1YFPqGYbfwmEVYOikhb8tjk07UdJ9pUwO1J/c7zTr3jbZvu8eU
BNv/g94BlUAugDDUGUdu7vhaalk9kT79H1PLFnc9LGpMruTr3CzomQU+YG9yRRHf
JJ7Y/N2M2KyS12GA3oZksRxkg9sepg==
=bwuW
-----END PGP SIGNATURE-----

--oDtmPYbAjS8IMFoF--

