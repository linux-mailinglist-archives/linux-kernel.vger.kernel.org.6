Return-Path: <linux-kernel+bounces-323017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358F69736A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665951C249EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BE01917E5;
	Tue, 10 Sep 2024 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbHsUOG5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57D18DF9E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969596; cv=none; b=XR7hrGHt3jAGcZD9mIPagKPsOyL2RUtXQcf7LCD4rfA5dnUCRQIeOH9F3/HFbzSMBgJs5iVF0IUYXqYJFZenY4rDWwqfIO9MJEfTeS5Y43zSfVgSir6TFlldxi+24uurrus19cbl1SN6vySPtwhN/EMxlpLVEP/nR+O7MUo302A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969596; c=relaxed/simple;
	bh=cUCDRbBErAAoJlh8tblnGbkXDRsg/AAOLJeqTKetPgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE29DvXrwCoWdQ0tClJvUZlIYwqKJNkq7vJUODp+2u7cZYr+n19KryyCkWa57kw+UhIZGjfXHYQ4mDSdBZBWAkrBH36hcawzngjPrZSgfQkxVRn2HeBF28e1yAC3HFUG/pPEIVJBUY5O2ikYsYJ9idGFNG8yJDPSBckgol3hOVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbHsUOG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CEC4CEC3;
	Tue, 10 Sep 2024 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725969595;
	bh=cUCDRbBErAAoJlh8tblnGbkXDRsg/AAOLJeqTKetPgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AbHsUOG5POnujaToGxaetCcAiAOuf73FugTzA2g6XA13NNB07NmBEV8dtqnjZj2NW
	 n1Mu48xZrf4X3CHsuAFPjSfLHLAv5ywLlx8xVxCcS53XMP2dhzjYdayO2z8avUjAei
	 /iL3CNgClreQXhPHQQ25Q+WcsjnjOICeLKbb7bENi5DLBBwBx3FvmJVm5XJLMOfog4
	 TLA0c5HZnMPbMZ238fBzZ6VBpzcXQrYav4ID5jhsl13w9A3vzat8KUylts53Zprjtu
	 zJVZ+RWaiUdY0fCLB0dpChIohluLj4a7DxoRgp7Q2TPlgU9uBfU6uQSDiicWt37+Ui
	 Ks405ow8suOJA==
Date: Tue, 10 Sep 2024 13:59:52 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
Cc: Borislav Petkov <bp@alien8.de>, 
	linux-stm32@st-md-mailman.stormreply.com, Yannick Fertre <yannick.fertre@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: dw_mipi_dsi-stm.c:(.text+0x8db9a3): undefined reference to
 `clk_hw_unregister'
Message-ID: <20240910-gleaming-boa-of-drama-d0a4db@houat>
References: <20240905081902.GAZtlpdlQp5XOm5XtO@fat_crate.local>
 <544a633e-de53-493d-9c29-de8ff52630da@foss.st.com>
 <20240909084506.GBZt61kqqGVUTqjKc4@fat_crate.local>
 <0e9018d0-c49f-4dac-aa0f-b05504f9c6f6@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ikp2nxlqytchy5qv"
Content-Disposition: inline
In-Reply-To: <0e9018d0-c49f-4dac-aa0f-b05504f9c6f6@foss.st.com>


--ikp2nxlqytchy5qv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:48:49PM GMT, Raphael Gallais-Pou wrote:
>=20
> On 9/9/24 10:45, Borislav Petkov wrote:
> > On Mon, Sep 09, 2024 at 08:57:57AM +0200, Raphael Gallais-Pou wrote:
> >> Arnd Bergmann sent a patch regarding this issue on x86 that I merged s=
everal
> >> weeks ago.
> >>
> >> https://lore.kernel.org/lkml/20240719075454.3595358-1-arnd@kernel.org/
> >> https://lore.kernel.org/all/c3d0757a-07c0-4f83-9f06-c3ad205aa1e9@foss.=
st.com/
> > Thanks.
> >
> >> Now, I'm not familiar with PowerPC architecture and toolchains, but I =
think
> >> this patch should fix your problem.  Do you have the above fixup in yo=
ur
> >> tree ? If not please try it.
> > Not PowerPC - it is an x86 build. I do random config builds as part of =
build
> > testing and when a driver depends on COMPILE_TEST, it does gets built i=
n some
> > .configs. So some may fail, as in this case.
>=20
> Unless I am mistaken, the link you provided refers to a PowerPC linker er=
ror:
>=20
> [...]
>=20
> compiler: powerpc-linux-gcc (GCC) 14.1.0
>=20
> [...]
>    powerpc-linux-ld: drivers/gpu/drm/stm/dw_mipi_dsi-stm.o: in function `=
dw_mipi_dsi_stm_remove':
>    dw_mipi_dsi-stm.c:(.text+0x664): undefined reference to `of_clk_del_pr=
ovider'
> >> powerpc-linux-ld: dw_mipi_dsi-stm.c:(.text+0x66c): undefined reference=
 to `clk_hw_unregister'    powerpc-linux-ld: drivers/gpu/drm/stm/dw_mipi_ds=
i-stm.o: in function `dw_mipi_dsi_stm_probe':
>    dw_mipi_dsi-stm.c:(.text+0x98c): undefined reference to `clk_hw_regist=
er'
>=20
> >
> > So I think you should send that patch to Linus now so that such randcon=
fig
> > builds do not fail anymore.
>=20
> What do you mean by 'sending it to Linus' ? If you meant to do a pull req=
uest,
> then no. This patch is already in the drm-misc tree, which means it will =
keep
> its usual pace of merging with the rest of the drm-misc tree.
>=20
> For more information about drm-misc tree:
> https://drm.pages.freedesktop.org/maintainer-tools/repositories/drm-misc.=
html#merge-timeline

That's not entirely correct. This should have been merged in
drm-misc-fixes to begin with. I've cherry-picked the patch and pushed
it.

Maxime

--ikp2nxlqytchy5qv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZuA0uAAKCRAnX84Zoj2+
dgyDAYCAyvDYsPL75t2AkYl/NeLGpHI0ydusikNL/pViVa44jYu00uf/os+RII4U
dJpBTEUBgIaB1vXiJA/gQbNty16ep7csySm1uhCN7oxqzpj2egL/ETWyppe/T/+R
ABp2aU8SiA==
=h+RS
-----END PGP SIGNATURE-----

--ikp2nxlqytchy5qv--

