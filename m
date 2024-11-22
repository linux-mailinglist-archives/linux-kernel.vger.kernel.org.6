Return-Path: <linux-kernel+bounces-418005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF79D5BB9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47511B222B0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199281DF25D;
	Fri, 22 Nov 2024 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O98FkhEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEE1DE8B6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732266917; cv=none; b=pSZyGC3qWoAAjbc/6mokjWiVf9ck8/rmDsw4Dn7V9r+SsSyEFkzp1eicZHptKm+AjBRoETvGfzCMrMrdHUAXmg/qGZBeWcaitlrzYcxvc2eEdZvqvVF0WRDWIt5eqFjSneeB/QoD2dmEXP2+DdP5gm0502WlfumJq1fgnleUNaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732266917; c=relaxed/simple;
	bh=R6maSGuuOMKhhf9sSnHx8qiK51scqKOLehJIOotIrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nN9t114Y1KUV1WlvOGH1Fud0uWGh2+bVBnC60YnY8hRNcMXV49iujER5TLwRrCu/wowXJAM2uio1+X0lqxqzuLg0gRilQiIQaQzfgnEnO7TgRYsJ84EIOZTPLvNyLjCbXqIT8hs4w/vBrGKmkX9PltrtSQY9xr1Bs0hk3fE2Zig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O98FkhEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F25C4CEDF;
	Fri, 22 Nov 2024 09:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732266916;
	bh=R6maSGuuOMKhhf9sSnHx8qiK51scqKOLehJIOotIrMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O98FkhEaQQs9rPvqF+c1qXRvM9FG3+cAOYMCXCC7iq4k5sppI9C/IqigYL39LWwnW
	 DI0BcG7znPyh6z1SvNA1nEPwhZuZeshfmOo6bAjSA6qKKLXN5YnRKDRcD+VrjY5py+
	 FfVXgYLnMi47knyttXkw9NHZe7NTXLjzxCAenvbjLkgyCfkX5aub8KVSiUv1Ccm2gU
	 pQsc9+7tom/pdoQdV+c5NwgomdmK7eQETs7gQc4eVXfsCZ6J86qnr3OHHaAHPmr0Iw
	 2/sjiGf2JSjwBur4jRB7mVt/oCuIO2NuIra9SxkDxog4Ihc8roGk7FjWQLVHFT345b
	 kox4weqSIuDJQ==
Date: Fri, 22 Nov 2024 10:15:14 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@kernel.org>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Algea Cao <algea.cao@rock-chips.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Arnd Bergmann <arnd@arndb.de>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
Message-ID: <20241122-rebel-donkey-of-atheism-a0b8b6@houat>
References: <20241018151016.3496613-1-arnd@kernel.org>
 <20241104172950.GA741087@thelio-3990X>
 <CAMuHMdXrrCiLm2sQmpegtVHV8X5AUp-8E5BejDxRpMbeAfHhvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="km5zocuqrx7s7sxg"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXrrCiLm2sQmpegtVHV8X5AUp-8E5BejDxRpMbeAfHhvQ@mail.gmail.com>


--km5zocuqrx7s7sxg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/rockchip: avoid 64-bit division
MIME-Version: 1.0

On Fri, Nov 22, 2024 at 09:36:16AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 4, 2024 at 6:30=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
> > On Fri, Oct 18, 2024 at 03:10:10PM +0000, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Dividing a 64-bit integer prevents building this for 32-bit targets:
> > >
> > > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/rockchip/rockchip=
drm.ko] undefined!
> > >
> > > As this function is not performance criticial, just Use the div_u64()=
 helper.
> > >
> > > Fixes: 128a9bf8ace2 ("drm/rockchip: Add basic RK3588 HDMI output supp=
ort")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Can someone please pick this up? It is still broken in next-20241104...
> >
> > https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integrat=
ion2/builds/2oNvJFRj8tkDieb6VfrMf4rh1Kn/build.log
> >
> > > ---
> > >  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers=
/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > index 9c796ee4c303..c8b362cc2b95 100644
> > > --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > @@ -82,7 +82,7 @@ static void dw_hdmi_qp_rockchip_encoder_enable(stru=
ct drm_encoder *encoder)
> > >                * comment in rk_hdptx_phy_power_on() from
> > >                * drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
> > >                */
> > > -             phy_set_bus_width(hdmi->phy, rate / 100);
> > > +             phy_set_bus_width(hdmi->phy, div_u64(rate, 100));
> > >       }
> > >  }
>=20
> noreply@ellerman.id.au has just told me this build issue is now upstream:
>=20
>     FAILED linus/m68k-allmodconfig/m68k-gcc8.1 Fri Nov 22, 05:34
>     http://kisskb.ellerman.id.au/kisskb/buildresult/15277242/
>=20
>     Commit:   Merge tag 'drm-next-2024-11-21' of
> https://gitlab.freedesktop.org/drm/kernel
>               28eb75e178d389d325f1666e422bc13bbbb9804c
>     Compiler: m68k-linux-gcc (GCC) 8.1.0 / GNU ld (GNU Binutils) 2.30
>=20
>     ERROR: modpost: "__udivdi3"
> [drivers/gpu/drm/rockchip/rockchipdrm.ko] undefined!
>=20
> Applying this patch fixes it, so
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>=20
> Do we really need +5 weeks to apply a fix for a reported build issue?

Do we really need that kind of comments?

It was applied already, I made sure it's part of the next PR we send to
Linus. And it should be in linux-next tomorrow.

Maxime

--km5zocuqrx7s7sxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZ0BLoQAKCRAnX84Zoj2+
dvdpAYCvsOCxb45AeqggVGmNsnQVm/dPhE0CFCB0XgME96Ckt5GWCfvgvHHFGQ67
DbeiNMsBfj0lX0BUOAJb43jsZ7t5pR3aQV2oQXOnvO4fBEweIdvhGYuMQ03s9rcE
THskPa19zg==
=YJ/Z
-----END PGP SIGNATURE-----

--km5zocuqrx7s7sxg--

