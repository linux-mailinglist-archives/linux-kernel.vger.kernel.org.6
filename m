Return-Path: <linux-kernel+bounces-224218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE3911F00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 703FAB21091
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB0816D4EE;
	Fri, 21 Jun 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEsfXgdp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1BA16B3B9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959363; cv=none; b=eXo4ZXJFAjaY576A4k478LDb31Evr/bk7tJsSvwOz/abuMZRuoR/pALx9ADYJQgcwZLj/RMmprnmbnW6x7PtYZXplumPwyjuOSZxsNqpX6EStz3sk/4TVN9q/wj+QjkDblqRsYxYIyXorIJwVRUsbSxBImBPcCdRJxgLI0N8YNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959363; c=relaxed/simple;
	bh=uZrZCpJHyb7XqYBHsx21rQwle1LUXwCjnR5FTxqq/PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwDVUNw3pROi7om6Hj+pq5tdWxQ+SzHiXcgwTJqJkqsTSpsqs2Rg1N/6YbIlYFyFur+Zwaei8GCMb4H2RrMcvPLIJJzGA1Bl+gcmxOwmoQ3d4T4uNL9GhDyEJSCof6R2mooSfny6fS7BEXD+Hb2vX2LlRH101fVaoVMa6HGjPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEsfXgdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB14C2BBFC;
	Fri, 21 Jun 2024 08:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959362;
	bh=uZrZCpJHyb7XqYBHsx21rQwle1LUXwCjnR5FTxqq/PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fEsfXgdpRP/fn8yT6QOCWWrMiDNHhEZm0S+idy0Z/R8T+3WmAEsfBUaqjrpr+dv2P
	 X+O9jnhavj2q/seWvXiLWreaUL7+dxIK3vRrwKOHAhJebZciRuSmYHBBmpWj2XJg3i
	 C0QpPvZ4uUmWpUf7ovVL7LVcwuGAeABkMDFSHjRfX1tv8l86BjnEQdQ2db+uQuT9iu
	 ci9+/VDLwDIJHEA2oq7PCrQAc1JN4scvwrdM5y/N48r75ySznazS4dIjFN4mwOTA1i
	 7tRMMrB5NzUsu+wrPzfJelKX7FRlsuZ4tFYaTxYvl3XSuLlaNWF6Vm3OJ8XdJDh+kC
	 5s8f/ljkR2m1A==
Date: Fri, 21 Jun 2024 10:42:40 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
	Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Candice Li <candice.li@amd.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, 
	Ma Jun <Jun.Ma2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Shashank Sharma <shashank.sharma@amd.com>, Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Victor Lu <victorchengchi.lu@amd.com>, 
	amd-gfx@lists.freedesktop.org, chenxuebing <chenxb_99091@126.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
Message-ID: <20240621-nimble-roaring-ibis-fbda90@houat>
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
 <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
 <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
 <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
 <CADnq5_OXUKj=bfK0NOAhOzmhYCSnQXbxHbwLOaBQ6wFX033Wgw@mail.gmail.com>
 <CADnq5_O1EGj-_xx7LuiXSVY7MSmfS7_1-hqShFk6Deu1wsBwOA@mail.gmail.com>
 <20240620-puzzling-hopping-griffin-e43ba6@houat>
 <CADnq5_PwE0n39hPuEfasGLrwe+rzzzisaKfwz9a9bbpR+RDgqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5f5e7eoh2tcinh3"
Content-Disposition: inline
In-Reply-To: <CADnq5_PwE0n39hPuEfasGLrwe+rzzzisaKfwz9a9bbpR+RDgqQ@mail.gmail.com>


--a5f5e7eoh2tcinh3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 09:00:23AM GMT, Alex Deucher wrote:
> On Thu, Jun 20, 2024 at 3:10=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > Hi,
> >
> > On Wed, Jun 19, 2024 at 09:53:12AM GMT, Alex Deucher wrote:
> > > On Wed, Jun 19, 2024 at 9:50=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Tue, Jun 18, 2024 at 7:53=E2=80=AFPM Doug Anderson <dianders@chr=
omium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Tue, Jun 18, 2024 at 3:00=E2=80=AFPM Alex Deucher <alexdeucher=
@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders=
@chromium.org> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > >
> > > > > > > On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeu=
cher@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <d=
ianders@chromium.org> wrote:
> > > > > > > > >
> > > > > > > > > Based on grepping through the source code this driver app=
ears to be
> > > > > > > > > missing a call to drm_atomic_helper_shutdown() at system =
shutdown
> > > > > > > > > time. Among other things, this means that if a panel is i=
n use that it
> > > > > > > > > won't be cleanly powered off at system shutdown time.
> > > > > > > > >
> > > > > > > > > The fact that we should call drm_atomic_helper_shutdown()=
 in the case
> > > > > > > > > of OS shutdown/restart comes straight out of the kernel d=
oc "driver
> > > > > > > > > instance overview" in drm_drv.c.
> > > > > > > > >
> > > > > > > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > > > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > > > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > > > > > ---
> > > > > > > > > This commit is only compile-time tested.
> > > > > > > > >
> > > > > > > > > ...and further, I'd say that this patch is more of a plea=
 for help
> > > > > > > > > than a patch I think is actually right. I'm _fairly_ cert=
ain that
> > > > > > > > > drm/amdgpu needs this call at shutdown time but the logic=
 is a bit
> > > > > > > > > hard for me to follow. I'd appreciate if anyone who actua=
lly knows
> > > > > > > > > what this should look like could illuminate me, or perhap=
s even just
> > > > > > > > > post a patch themselves!
> > > > > > > >
> > > > > > > > I'm not sure this patch makes sense or not.  The driver doe=
sn't really
> > > > > > > > do a formal tear down in its shutdown routine, it just quie=
sces the
> > > > > > > > hardware.  What are the actual requirements of the shutdown=
 function?
> > > > > > > > In the past when we did a full driver tear down in shutdown=
, it
> > > > > > > > delayed the shutdown sequence and users complained.
> > > > > > >
> > > > > > > The "inspiration" for this patch is to handle panels properly.
> > > > > > > Specifically, panels often have several power/enable signals =
going to
> > > > > > > them and often have requirements that these signals are power=
ed off in
> > > > > > > the proper order with the proper delays between them. While w=
e can't
> > > > > > > always do so when the system crashes / reboots in an uncontro=
lled way,
> > > > > > > panel manufacturers / HW Engineers get upset if we don't powe=
r things
> > > > > > > off properly during an orderly shutdown/reboot. When panels a=
re
> > > > > > > powered off badly it can cause garbage on the screen and, so =
I've been
> > > > > > > told, can even cause long term damage to the panels over time.
> > > > > > >
> > > > > > > In Linux, some panel drivers have tried to ensure a proper po=
weroff of
> > > > > > > the panel by handling the shutdown() call themselves. However=
, this is
> > > > > > > ugly and panel maintainers want panel drivers to stop doing i=
t. We
> > > > > > > have removed the code doing this from most panels now [1]. In=
stead the
> > > > > > > assumption is that the DRM modeset drivers should be calling
> > > > > > > drm_atomic_helper_shutdown() which will make sure panels get =
an
> > > > > > > orderly shutdown.
> > > > > > >
> > > > > > > For a lot more details, see the cover letter [2] which then c=
ontains
> > > > > > > links to even more discussions about the topic.
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/r/20240605002401.2848541-1-diande=
rs@chromium.org
> > > > > > > [2] https://lore.kernel.org/r/20240612222435.3188234-1-diande=
rs@chromium.org
> > > > > >
> > > > > > I don't think it's an issue.  We quiesce the hardware as if we =
were
> > > > > > about to suspend the system (e.g., S3).  For the display hardwa=
re we
> > > > > > call drm_atomic_helper_suspend() as part of that sequence.
> > > > >
> > > > > OK. It's no skin off my teeth and we can drop this patch if you're
> > > > > convinced it's not needed. From the point of view of someone who =
has
> > > > > no experience with this driver it seems weird to me that it would=
 use
> > > > > drm_atomic_helper_suspend() at shutdown time instead of the docum=
ented
> > > > > drm_atomic_helper_shutdown(), but if it works for everyone then I=
'm
> > > > > not gonna complain.
> > > >
> > > > I think the problem is that it is not clear exactly what the
> > > > expectations are around the PCI shutdown callback.  The documentati=
on
> > > > says:
> > > >
> > > > "Hook into reboot_notifier_list (kernel/sys.c). Intended to stop any
> > > > idling DMA operations. Useful for enabling wake-on-lan (NIC) or
> > > > changing the power state of a device before reboot. e.g.
> > > > drivers/net/e100.c."
> > >
> > > Arguably, there is no requirement to even touch the display hardware
> > > at all.  In theory you could just leave the display hardware as is in
> > > the current state.  The system will either be rebooting or powering
> > > down anyway.
> >
> > I think it mostly boils down to a cultural mismatch :)
> >
> > Doug works on panel for ARM systems, where devices need (and need to
> > handle) much more resources than what's typical on a system with an AMD
> > GPU.
> >
> > So, for the kind of hardware Doug usually deals with, we definitely need
> > the shutdown hook to make sure the regulators, GPIOs, etc. supplying the
> > panel are properly shutdown.
> >
> > And panels usually tied to AMD GPUs probably don't need any of that.
>=20
> Makes sense.  I think drm_atomic_helper_suspend() is a viable
> alternative if drivers want to leverage their existing suspend code.
> I could write up a doc patch unless there is reason to prefer the
> shutdown variant.

It could be worth adding that mention in the _shutdown() doc indeed, but
I'm not sure we need to enforce anything at this point. I'd rather have
either, at the driver's authors discretion.

Maxime

--a5f5e7eoh2tcinh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZnU8/wAKCRDj7w1vZxhR
xVpPAP47y/HB3Fexh5PbMWnorykQz3Ag2b52AxxdXh02osSdvAD9FsW5cTVmwAD6
lscl3XAVezknK5j7PwB7r1wuzc2X0w8=
=D7JB
-----END PGP SIGNATURE-----

--a5f5e7eoh2tcinh3--

