Return-Path: <linux-kernel+bounces-175307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82818C1DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DE92833B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C29153BE2;
	Fri, 10 May 2024 06:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKIkVsf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCC1311BA
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321491; cv=none; b=OCRSLIJQT2XAXkvRv4d9/FPgIKYCIS7ycWRQDPohfOY5H8v0Xc+r2O4fGxwccyuIfx9I6N/JCPI754jDukdOXuTEtRqKBcBF8vVcaR83s1KxkX9qxGW9yuvM65tYxitMsvTy/Lc43s9/WF+9aD6ZAixwVv+WYeQwt6gOWwgqNC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321491; c=relaxed/simple;
	bh=tVmNsvP0F79RlUZxEG/LA65KskpKIapcIo/v8yoB4ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTU9UX9A/aNW1xQiyHHqMyTVk7O6ZUKoBU6Zhyw/XFCLQmGhmw+S1Z54rmpjUy0xK82I7gUmn85pERz5mUAboo/xIk+NE3VstCo2PGGHn5DIVhutoujz85UFfX/cI4l2kcIAMibOZKHe9bIah7ddGmh8B6XKikPnvCu0GwZIZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKIkVsf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F38C113CC;
	Fri, 10 May 2024 06:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715321490;
	bh=tVmNsvP0F79RlUZxEG/LA65KskpKIapcIo/v8yoB4ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKIkVsf1od6aPk7MnyWPjHXMFynzPXSzitJyehux5ITdgempS7Ky/BGauZ1LFfr4q
	 u48+U1egGclO8lOKUPkEgr3ZTGLNo8Wiqbin0UlmczIbxjbgfqPh5sdlEFcjWRhMDq
	 3vF3AWWbTz6kh7d5Q21DwCRwnFmNo16Kde9vF5A2GSPKfZu+9XTXYgE3r3JFnWvYCd
	 wX7ECcY52y6b7haB1rNgqUHT9uJgVZPuNYigZwD1N+2viHnTTWV4HadJgtSL2hGJc4
	 DcrHbLCrjSszwUsRy4Iy1y058wBu57KGjOOuSIZeHRgW9FvOXDemw0Yycz/3FDYfKK
	 H6eArB6YW8+0A==
Date: Fri, 10 May 2024 07:11:27 +0100
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: andriy.shevchenko@linux.intel.com, lgirdwood@gmail.com, perex@perex.cz,
	pierre-louis.bossart@linux.intel.com, 13916275206@139.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, bard.liao@intel.com,
	yung-chuan.liao@linux.intel.com, kevin-lu@ti.com,
	cameron.berkenpas@gmail.com, tiwai@suse.de, baojun.xu@ti.com,
	soyer@irl.hu, Baojun.Xu@fpt.com
Subject: Re: [PATCH v4 1/3] ALSA: ASoc/tas2781: Fix wrong loading calibrated
 data sequence
Message-ID: <Zj26j5CrWA9PZI3l@finisterre.sirena.org.uk>
References: <20240510034123.1181-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IBGLJYrAp7PURpSa"
Content-Disposition: inline
In-Reply-To: <20240510034123.1181-1-shenghao-ding@ti.com>
X-Cookie: Did I SELL OUT yet??


--IBGLJYrAp7PURpSa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 11:41:19AM +0800, Shenghao Ding wrote:

> Calibrated data will be set to default after loading DSP config params,
> which will cause speaker protection work abnormally. Reload calibrated
> data after loading DSP config params.

This changelog...

> -#ifndef __TASDEVICE_DSP_H__
> -#define __TASDEVICE_DSP_H__
> +#ifndef __TAS2781_DSP_H__
> +#define __TAS2781_DSP_H__
> =20
>  #define MAIN_ALL_DEVICES			0x0d
>  #define MAIN_DEVICE_A				0x01
> @@ -180,7 +180,6 @@ void tasdevice_calbin_remove(void *context);
>  int tasdevice_select_tuningprm_cfg(void *context, int prm,
>  	int cfg_no, int rca_conf_no);
>  int tasdevice_prmg_load(void *context, int prm_no);
> -int tasdevice_prmg_calibdata_load(void *context, int prm_no);
>  void tasdevice_tuning_switch(void *context, int state);
>  int tas2781_load_calibration(void *context, char *file_name,
>  	unsigned short i);

=2E..doesn't seem to have much relationship with the change?

--IBGLJYrAp7PURpSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY9uo4ACgkQJNaLcl1U
h9D4agf+I0bZ1B3cEZzcn8kwAbokayZK3bWdqamWTuNLb3Vcx2uhyC4/bvRK5qQn
J6hS0j9LlmPaTipkl0Y7ztNShtj4T1VRNBY9RN3zRg9WuGh6ruQNGjFZO5gLMlr6
pg6e0ZfZ1Ja76r2kTsr4VzmBuhuoaDSpemsDCbCHHj3ibiHVobR7k2T0YnBoOGyQ
je4perE+5AwpAYiUrQUJklo14YYepi+ofoALKisnmpHva6wKFeq6L3l3IacPFBvM
cmODN8eF+LcZWc9GEd7SRIkmW9esFWti/G84NItQC2V6v9JaIDG4APXcFYPAWn1N
9s0AEBIhbb8SzQnWR1ajUfJH6zQR3A==
=r0T+
-----END PGP SIGNATURE-----

--IBGLJYrAp7PURpSa--

