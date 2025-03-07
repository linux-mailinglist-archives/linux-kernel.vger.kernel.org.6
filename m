Return-Path: <linux-kernel+bounces-551687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A70A56F82
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C8C189A51B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191B23E227;
	Fri,  7 Mar 2025 17:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQAF0v2j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D35218AD4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741369614; cv=none; b=HU60HFPU4PbfVDrqiVIuq3goiADNSIt7vGK1IwYWag0oV2YuNtjPxj816CLZKcP4PJlG79KODnW06p2wzZDkyY2q9AXKcsuj0oxaQScHs93uI+hLJQ12MoRYO3243k+p8S1abzOXANkNJTdN2nNFXMh59oHliCwwHYZ0incoQ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741369614; c=relaxed/simple;
	bh=rr6rG35T+U9XH1VQ+tZpBfJBPzWQiMlS00hamAESYr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrYiWyNZ/M3jSICngfVsPsG13DxcOY/o2NRxHntt4zv9ioE1VRNzj11rEoOJJS4AVp2ITytmN1Myvd22cRPuoBfj69H6i2wQiaPr3Q2dyfmXz9bjza71G9EveT6Wn4VrjVivhUfpg/+/R9LDxiiYsGSXns8PJcIws1lRA9OX9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQAF0v2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAAAC4CED1;
	Fri,  7 Mar 2025 17:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741369614;
	bh=rr6rG35T+U9XH1VQ+tZpBfJBPzWQiMlS00hamAESYr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BQAF0v2jxW7PjcH6Q5pBpo71I3hg9a9v+y0EbwZ78SO6ZZB/fOPCYHmED+bxFg9Ek
	 QSQfvdeaw1YaHBxbmhrGetD6qkfMaor6AB6s3Q3ioKXl8cnyG5B/6V8oV765NhqUSg
	 VNqN8tdQ2ujAcbRyeJ1LcOOlw9NDjhaFHMhaydZMJESNwxcfPJEd5UYp2uZAgqbEra
	 cQuTMH7z4weYcRbxPw2LYDRKFqWFPeQ9cu1q8Vc2XwEL44WPcbFCXZPR2jSdmsJ0o2
	 qQLV+UK5L64nbk2rYhGu3xQOWDVyPZdIDl8IuaEO3Er3zdM+oRBR1kaLHBBnjLuZbo
	 BPCtKB5FizF/g==
Date: Fri, 7 Mar 2025 18:46:51 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Doug Anderson <dianders@chromium.org>, 
	Michael Trimarchi <michael@amarulasolutions.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Tejas Vipin <tejasvipin76@gmail.com>
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
Message-ID: <20250307-happy-jasmine-raccoon-c6226c@houat>
References: <20250305-mipi-synaptic-1-v1-1-92017cd19ef6@redhat.com>
 <20250306-clever-lime-tanuki-e2fc43@houat>
 <CAN9Xe3SDyC47HWww1eH63aZOiM-WF9BGxztM3yh9bf6ORuY7VA@mail.gmail.com>
 <20250306-brave-wonderful-sambar-3d0bc5@houat>
 <CAD=FV=XZJjNpzUgvGog0pFGwqUR09SocYFEk5355eptbK_gjqA@mail.gmail.com>
 <CAN9Xe3TEYjfjDcaCL7MOUBMu5Uq0ifN36=jRumtDX7pQ0FsK3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gg5hyn5372yljeqf"
Content-Disposition: inline
In-Reply-To: <CAN9Xe3TEYjfjDcaCL7MOUBMu5Uq0ifN36=jRumtDX7pQ0FsK3g@mail.gmail.com>


--gg5hyn5372yljeqf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/panel/synaptics-r63353: Use _multi variants
MIME-Version: 1.0

On Thu, Mar 06, 2025 at 02:12:14PM -0500, Anusha Srivatsa wrote:
> On Thu, Mar 6, 2025 at 12:54=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> > On Thu, Mar 6, 2025 at 9:20=E2=80=AFAM Maxime Ripard <mripard@kernel.or=
g> wrote:
> > >
> > > On Thu, Mar 06, 2025 at 10:08:24AM -0500, Anusha Srivatsa wrote:
> > > > On Thu, Mar 6, 2025 at 4:31=E2=80=AFAM Maxime Ripard <mripard@kerne=
l.org>
> > wrote:
> > > >
> > > > > Hi Anusha,
> > > > >
> > > > > On Wed, Mar 05, 2025 at 07:01:41PM -0500, Anusha Srivatsa wrote:
> > > > > > Move away from using deprecated API and use _multi
> > > > > > variants if available. Use mipi_dsi_msleep()
> > > > > > and mipi_dsi_usleep_range() instead of msleep()
> > > > > > and usleep_range() respectively.
> > > > > >
> > > > > > Used Coccinelle to find the multiple occurences.
> > > > > > SmPl patch:
> > > > > > @rule@
> > > > > > identifier dsi_var;
> > > > > > identifier r;
> > > > > > identifier func;
> > > > > > type t;
> > > > > > position p;
> > > > > > expression dsi_device;
> > > > > > expression list es;
> > > > > > @@
> > > > > > t func(...) {
> > > > > > ...
> > > > > > struct mipi_dsi_device *dsi_var =3D dsi_device;
> > > > > > +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> > > > > > <+...
> > > > > > (
> > > > > > -mipi_dsi_dcs_write_seq(dsi_var,es)@p;
> > > > > > +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> > > > > > |
> > > > > > -mipi_dsi_generic_write_seq(dsi_var,es)@p;
> > > > > > +mipi_dsi_generic_write_seq_multi(&dsi_ctx,es);
> > > > > > |
> > > > > > -mipi_dsi_generic_write(dsi_var,es)@p;
> > > > > > +mipi_dsi_generic_write_multi(&dsi_ctx,es);
> > > > > > |
> > > > > > -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> > > > > > +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> > > > > > |
> > > > > > ....rest of API
> > > > > > ..
> > > > > > )
> > > > > > -if(r < 0) {
> > > > > > -...
> > > > > > -}
> > > > > > ...+>
> > > > >
> > > > > The point of sending a single patch was to review the coccinelle
> > script,
> > > > > so you must put the entire script you used here.
> > > >
> > > > I was actually thinking of sending patches per driver this time aro=
und
> > > > since Tejas also seems to be looking into similar parts....Thoughts?
> > >
> > > Not really?
> > >
> > > The point of doing it with one driver was to make sure the coccinelle
> > > script was fine before rolling it to other drivers. And actually, it
> > > doesn't really matter: the whole point of putting the script in the
> > > commit log is to be able to review and document the script you used. =
If
> > > you're not going to put the one you used, it's kind of pointless.
> >
> > Personally, I don't have any interest in reviewing the coccinelle
> > script so I don't need it and, from my point of view, you could just
> > remove it from the patch description (or point to it indirectly or
> > something). I'll review each patch on its own merits. I am a bit
> > curious if you ended up fully generating this patch with a coccinelle
> > script or if you used a coccinelle script to start and then had to
> > manually tweak the patch after. Actually, I guess I'll take it back.
> > If you manage to fully generate conversions for all the panels with a
> > single cocinelle script, I would love to take a glance at your full
> > script just to satisfy my curiosity for how you handled everything
> > properly. :-P
> >
>=20
> managed to get all conversions other than the usleep_range() and mslee()
> because I was trying to replace them with mipi_dsi_* variants only in
> functions that I was  touching and not each and every occurrence. Didnt
> spend enough time to get the script smart enough to do that and did only
> usleep() and msleep change manually. Here goes the script:
>=20
> @rule_1@
> identifier dsi_var;
> expression dsi_device;
> expression list es;
> @@
> struct mipi_dsi_device *dsi_var =3D dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> -mipi_dsi_dcs_write_seq(dsi_var,es);
> +mipi_dsi_dcs_write_seq_multi(&dsi_ctx,es);
> ...+>
>=20
> //rule_2
> @@
> expression list es;
> identifier jdi;
> @@
> static int jdi_write_dcdc_registers(struct jdi_panel *jdi)
> {
> +struct mipi_dsi_multi_context dsi_ctx1 =3D { .dsi =3D jdi->link1 };
> +struct mipi_dsi_multi_context dsi_ctx2 =3D { .dsi =3D jdi->link2 };
> <+...
> -mipi_dsi_generic_write_seq(jdi->link1,es);
> +mipi_dsi_generic_write_seq_multi(&dsi_ctx1,es);
> -mipi_dsi_generic_write_seq(jdi->link2,es);
> +mipi_dsi_generic_write_seq_multi(&dsi_ctx2,es);
> ...+>
> }
> @rule_3@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var =3D dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi_var };
> <+...
> (
> -r =3D mipi_dsi_dcs_nop(dsi_var)@p;
> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> |
> |
> -r =3D mipi_dsi_dcs_write_buffer(dsi_var,es)@p;
> +mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_display_off(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_off_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_compression_mode_ext(dsi_var,es)@p;
> +mipi_dsi_compression_mode_ext_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_compression_mode(dsi_var,es)@p;
> +mipi_dsi_compression_mode_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_picture_parameter_set(dsi_var,es)@p;
> +mipi_dsi_picture_parameter_set_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_display_on(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_on_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_tear_on(dsi_var)@p;
> +mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_turn_on_peripheral(dsi_var)@p;
> +mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_soft_reset(dsi_var)@p;
> +mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
> |
> -r =3D mipi_dsi_dcs_set_display_brightness(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_pixel_format(dsi_var,es)@p;
> +mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_column_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_column_address_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_page_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_page_address_multi(&dsi_ctx,es);
> |
> -r =3D mipi_dsi_dcs_set_tear_scanline(dsi_var,es)@p;
> +mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,es);
> )

You're not matching on msleep because it doesn't return anything, and
here you're expecting a return value. You need to make 'r =3D' optional.

Maxime

--gg5hyn5372yljeqf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ8sxCgAKCRDj7w1vZxhR
xRXuAP9DekV7twDQLlm6Kf8ZqgdZDhzutwJfQqxSZTs/ypio5gEAmOleoGM88xvy
s3WWLN4L8gJDqXGhVNqK3S6m2gTFdgg=
=rYgT
-----END PGP SIGNATURE-----

--gg5hyn5372yljeqf--

