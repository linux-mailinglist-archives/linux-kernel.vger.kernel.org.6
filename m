Return-Path: <linux-kernel+bounces-442999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFCB9EE54D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5861887352
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E96211A20;
	Thu, 12 Dec 2024 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZ7PHaIa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0220C01A;
	Thu, 12 Dec 2024 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003900; cv=none; b=YMBNkIYeahun01HEd/7YefdbtL/Wu+VbL+RNPKbdPoN5cBZdc9zjy8xeijosiiUVChVAJCZ1N6SKdLUOV+7WZISPv8+EZupIVwLNXKj3su0VVJMmHuOcAP0Ruj85pVoRvuN8HUd7NI0hKqLecf6GNnnydT3wCL3a/Tdo6/a0jAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003900; c=relaxed/simple;
	bh=4GmCDohNAOfCN5wWOW+nZPuvP+Y3UIn9m30OSN5j1JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+1jgmmxvGxfwAudC0pYoMaByqNUnmPWyhJ0fQsvKm0BI9P+UhGMzI7M6Qz9KMi88mpHroMol7wyU2TH2qtG6zmdAVs2cJ4U+OljuVQ5QCzcxWroxXaeoCLW50EDB4ArzI2/e+yyE7DWLZoBix/CAIhY/N4oI0140MOpoYW3phE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZ7PHaIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C692C4CED1;
	Thu, 12 Dec 2024 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734003899;
	bh=4GmCDohNAOfCN5wWOW+nZPuvP+Y3UIn9m30OSN5j1JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fZ7PHaIaPPzTVBHTSLkX1+O9i3Zzay8xBUl2gIG3heoj6Z+fk9meBl13EQtHQApDu
	 Yw94mtEVg7nI8104jxTR94i4yw/MJJfGSIbgfp4ciEyhuk60ZjABeF4RAtV6cozv/I
	 EGNGxUK2lp3f1g1KWx1NHWA8TvA/hfjKSjxFLH2UPn1Qx2/4rCVe38ivLVqwgjQkJQ
	 fiBtT3zOeOtBw8cZRr8uVg3xQKACPhUNyLhUm2B2v7uXXG5XoBaSVVV9RhhmldzA0w
	 wvtEu88criAqDPQ7R6jqh6P1tx4ccozYrt+Xoj44g5NveBFbwVr9Z9HLpvInw6lyxL
	 PgsQDvsJRFdkg==
Date: Thu, 12 Dec 2024 11:44:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
	lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
Message-ID: <58b4a167-5a13-49b2-9b08-58c3041b772b@sirena.org.uk>
References: <20241212074509.3445859-1-shengjiu.wang@nxp.com>
 <20241212074509.3445859-5-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xCorpfkhpxX1YyjE"
Content-Disposition: inline
In-Reply-To: <20241212074509.3445859-5-shengjiu.wang@nxp.com>
X-Cookie: You can't push on a string.


--xCorpfkhpxX1YyjE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 03:45:07PM +0800, Shengjiu Wang wrote:
> Implement the ASRC memory to memory function using
> the compress framework, user can use this function with
> compress ioctl interface.
>=20
> This feature can be shared by ASRC and EASRC drivers

This breaks an x86 allmodconfig build (using GCC 13):

/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:186:68: warning: =E2=80=98s=
truct snd_compr_task_runtime=E2=80=99 declared inside parameter list will n=
ot be visible outside of this definition or declaration
  186 | static void asrc_m2m_device_run(struct fsl_asrc_pair *pair, struct =
snd_compr_task_runtime *task)
      |                                                                    =
^~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98asrc_=
m2m_device_run=E2=80=99:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:212:26: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  212 |         in_buf_len =3D task->input_size;
      |                          ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:279:13: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  279 |         task->output_size =3D out_dma_len;
      |             ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: At top level:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:451:49: warning: =E2=80=98s=
truct snd_compr_task_runtime=E2=80=99 declared inside parameter list will n=
ot be visible outside of this definition or declaration
  451 |                                          struct snd_compr_task_runt=
ime *task)
      |                                                 ^~~~~~~~~~~~~~~~~~~=
~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98fsl_a=
src_m2m_comp_task_create=E2=80=99:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:465:13: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  465 |         task->input =3D dma_buf_export(&exp_info_in);
      |             ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:466:24: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  466 |         if (IS_ERR(task->input)) {
      |                        ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:467:35: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  467 |                 ret =3D PTR_ERR(task->input);
      |                                   ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:475:13: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  475 |         task->output =3D dma_buf_export(&exp_info_out);
      |             ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:476:24: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  476 |         if (IS_ERR(task->output)) {
      |                        ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:477:35: error: invalid use =
of undefined type =E2=80=98struct snd_compr_task_runtime=E2=80=99
  477 |                 ret =3D PTR_ERR(task->output);
      |                                   ^~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: At top level:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:523:48: warning: =E2=80=98s=
truct snd_compr_task_runtime=E2=80=99 declared inside parameter list will n=
ot be visible outside of this definition or declaration
  523 |                                         struct snd_compr_task_runti=
me *task)
      |                                                ^~~~~~~~~~~~~~~~~~~~=
~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98fsl_a=
src_m2m_comp_task_start=E2=80=99:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:528:35: error: passing argu=
ment 2 of =E2=80=98asrc_m2m_device_run=E2=80=99 from incompatible pointer t=
ype [-Werror=3Dincompatible-pointer-types]
  528 |         asrc_m2m_device_run(pair, task);
      |                                   ^~~~
      |                                   |
      |                                   struct snd_compr_task_runtime *
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:186:92: note: expected =E2=
=80=98struct snd_compr_task_runtime *=E2=80=99 but argument is of type =E2=
=80=98struct snd_compr_task_runtime *=E2=80=99
  186 | static void asrc_m2m_device_run(struct fsl_asrc_pair *pair, struct =
snd_compr_task_runtime *task)
      |                                                             ~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~^~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: At top level:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:534:47: warning: =E2=80=98s=
truct snd_compr_task_runtime=E2=80=99 declared inside parameter list will n=
ot be visible outside of this definition or declaration
  534 |                                        struct snd_compr_task_runtim=
e *task)
      |                                               ^~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:540:47: warning: =E2=80=98s=
truct snd_compr_task_runtime=E2=80=99 declared inside parameter list will n=
ot be visible outside of this definition or declaration
  540 |                                        struct snd_compr_task_runtim=
e *task)
      |                                               ^~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:623:10: error: =E2=80=98str=
uct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_create=E2=80=99
  623 |         .task_create =3D fsl_asrc_m2m_comp_task_create,
      |          ^~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:623:24: warning: excess ele=
ments in struct initializer
  623 |         .task_create =3D fsl_asrc_m2m_comp_task_create,
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:623:24: note: (near initial=
ization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:624:10: error: =E2=80=98str=
uct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_start=E2=80=99
  624 |         .task_start =3D fsl_asrc_m2m_comp_task_start,
      |          ^~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:624:23: warning: excess ele=
ments in struct initializer
  624 |         .task_start =3D fsl_asrc_m2m_comp_task_start,
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:624:23: note: (near initial=
ization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:625:10: error: =E2=80=98str=
uct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_stop=E2=80=99
  625 |         .task_stop =3D fsl_asrc_m2m_comp_task_stop,
      |          ^~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:625:22: warning: excess ele=
ments in struct initializer
  625 |         .task_stop =3D fsl_asrc_m2m_comp_task_stop,
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:625:22: note: (near initial=
ization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:626:10: error: =E2=80=98str=
uct snd_compr_ops=E2=80=99 has no member named =E2=80=98task_free=E2=80=99
  626 |         .task_free =3D fsl_asrc_m2m_comp_task_free,
      |          ^~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:626:22: warning: excess ele=
ments in struct initializer
  626 |         .task_free =3D fsl_asrc_m2m_comp_task_free,
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:626:22: note: (near initial=
ization for =E2=80=98fsl_asrc_m2m_compr_ops=E2=80=99)
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c: In function =E2=80=98fsl_a=
src_m2m_init=E2=80=99:
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:701:41: error: =E2=80=98SND=
_COMPRESS_ACCEL=E2=80=99 undeclared (first use in this function); did you m=
ean =E2=80=98SNDRV_COMPRESS_AVAIL=E2=80=99?
  701 |         ret =3D snd_compress_new(card, 0, SND_COMPRESS_ACCEL, "ASRC=
 M2M", compr);
      |                                         ^~~~~~~~~~~~~~~~~~
      |                                         SNDRV_COMPRESS_AVAIL
/build/stage/linux/sound/soc/fsl/fsl_asrc_m2m.c:701:41: note: each undeclar=
ed identifier is reported only once for each function it appears in
cc1: some warnings being treated as errors

--xCorpfkhpxX1YyjE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdazLUACgkQJNaLcl1U
h9DcEgf+OJCZW0jgiKXMBoR3Ew+s4HvrHC3fxP0nd/Prc6FZAauL78YdYhJce2IO
Bp2bONmgi4zDJCJM9+SR1kEonO1EI0hCluisw/T588uAXQfGe4bukCis09k7zaEn
/w6FL5Na9sIbOGVLyEImrEDVgcm/XcekklQTrIifLdd51FWA4/9BYwV3LSKpaDX0
icGNN5H9gKADDidG2fWdPtndf6mMtkxOmvW9/lGADAYRCRCuwjRSxfCgd4wN8MQs
NithgGAj0D9hihQ5VNSo9+HYVdzBZ+9rFVEjiUD4WxdqSDUjmVFZJAqQfRzOaqsz
kEcfFqKySi1g/P4F5smjSPnIr7A8AQ==
=C/Kj
-----END PGP SIGNATURE-----

--xCorpfkhpxX1YyjE--

