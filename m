Return-Path: <linux-kernel+bounces-379862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8A29AE4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3FA1C241F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97681D5AB8;
	Thu, 24 Oct 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/gUY8gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083571D4154
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773359; cv=none; b=ZoOugxcg61nyPKcsB0yciXBCtolEvZIIVuaGM8mjLlIz1555WlZl5idGtnQtaH6PLm6WBsL1+kwm3nujMqDeZeUbD+cSl9Xn1BjM2aBvOoETQgN4o0EwjpDNaC3SjJM6jRILttG9kZaZ3D7k7Dis+l8hlgVSGiwrq09Ul9mLw0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773359; c=relaxed/simple;
	bh=bZLqgD3bwCnrhzSG0ujKytYoFRNy2GAd8aXG7PcqUQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVJY9QNf2XDiPx7W3SwPMDIctIaqHMuxq4o2yOQQFwZKyukn1hMnyaCM9E5YAuIvNULO23NmvdX9l9sVK2lr2pGC4zMAkBOI/MbV1vg20lM6dOJe/9bA7ThXW/oebawtFIk0rdTNDsku3gWhAdTQ++WZ0K4WRIZvRn7DQzn7YRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/gUY8gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625D9C4CECC;
	Thu, 24 Oct 2024 12:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773358;
	bh=bZLqgD3bwCnrhzSG0ujKytYoFRNy2GAd8aXG7PcqUQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/gUY8gpVxwgzloTNndRWP/FipvgJFBlTFMB6YBFiazqlo6dkhvJG09H2Jh0wEOwa
	 8LdqeDAJ5fAY5NuywAMnA+jZhCUj6mrpRbKrQKdhkVwANZeKAc2aMTsn57cNVvU2bp
	 FWQpTlnVPE8U5V/A8ISuZbVTX3rEnQyoiH/VKhFtD8q2OFGSuScRJ9TJsiBE7piDAM
	 EPlOorbZtRe42qXX27+TfAMjE7TgtDdGzigLGpykr3Itngos4r1VtbK14+5fxFoSFU
	 sCEb+oRwFimSQlxTG4KrfCaB7xudEhE+cAt4LQFntW8Jjv8Gm+77nInncXAdUxXMox
	 N0zl+k7R+2j5A==
Date: Thu, 24 Oct 2024 14:35:55 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Chen-Yu Tsai <wenst@chromium.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/bridge: panel: Use devm_drm_bridge_add()
Message-ID: <20241024-stalwart-bandicoot-of-music-bc6b29@houat>
References: <20241009052402.411978-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="dkuvoaq5vcnrqd3p"
Content-Disposition: inline
In-Reply-To: <20241009052402.411978-1-fshao@chromium.org>


--dkuvoaq5vcnrqd3p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] drm/bridge: panel: Use devm_drm_bridge_add()
MIME-Version: 1.0

On Wed, Oct 09, 2024 at 01:23:31PM +0800, Fei Shao wrote:
> In the mtk_dsi driver, its DSI host attach callback calls
> devm_drm_of_get_bridge() to get the next bridge. If that next bridge is
> a panel bridge, a panel_bridge object is allocated and managed by the
> panel device.
>=20
> Later, if the attach callback fails with -EPROBE_DEFER from subsequent
> component_add(), the panel device invoking the callback at probe time
> also fails, and all device-managed resources are freed accordingly.
>=20
> This exposes a drm_bridge bridge_list corruption due to the unbalanced
> lifecycle between the DSI host and the panel devices: the panel_bridge
> object managed by panel device is freed, while drm_bridge_remove() is
> bound to DSI host device and never gets called.
> The next drm_bridge_add() will trigger UAF against the freed bridge list
> object and result in kernel panic.
>=20
> This bug is observed on a MediaTek MT8188-based Chromebook with MIPI DSI
> outputting to a DSI panel (DT is WIP for upstream).
>=20
> As a fix, using devm_drm_bridge_add() with the panel device in the panel
> path seems reasonable. This also implies a chain of potential cleanup
> actions:
>=20
> 1. Removing drm_bridge_remove() means devm_drm_panel_bridge_release()
>    becomes hollow and can be removed.
>=20
> 2. devm_drm_panel_bridge_add_typed() is almost emptied except for the
>    `bridge->pre_enable_prev_first` line. Itself can be also removed if
>    we move the line into drm_panel_bridge_add_typed(). (maybe?)
>=20
> 3. drm_panel_bridge_add_typed() now calls all the needed devm_* calls,
>    so it's essentially the new devm_drm_panel_bridge_add_typed().
>=20
> 4. drmm_panel_bridge_add() needs to be updated accordingly since it
>    calls drm_panel_bridge_add_typed(). But now there's only one bridge
>    object to be freed, and it's already being managed by panel device.
>    I wonder if we still need both drmm_ and devm_ version in this case.
>    (maybe yes from DRM PoV, I don't know much about the context)
>=20
> This is a RFC patch since I'm not sure if my understanding is correct
> (for both the fix and the cleanup). It fixes the issue I encountered,
> but I don't expect it to be picked up directly due to the redundant
> commit message and the dangling devm_drm_panel_bridge_release().
> I plan to resend the official patch(es) once I know what I supposed to
> do next.
>=20
> For reference, here's the KASAN report from the device:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-use-after-free in drm_bridge_add+0x98/0x230
>  Read of size 8 at addr ffffff80c4e9e100 by task kworker/u32:1/69
>=20
>  CPU: 1 UID: 0 PID: 69 Comm: kworker/u32:1 Not tainted 6.12.0-rc1-next-20=
241004-kasan-00030-g062135fa4046 #1
>  Hardware name: Google Ciri sku0/unprovisioned board (DT)
>  Workqueue: events_unbound deferred_probe_work_func
>  Call trace:
>   dump_backtrace+0xfc/0x140
>   show_stack+0x24/0x38
>   dump_stack_lvl+0x40/0xc8
>   print_report+0x140/0x700
>   kasan_report+0xcc/0x130
>   __asan_report_load8_noabort+0x20/0x30
>   drm_bridge_add+0x98/0x230
>   devm_drm_panel_bridge_add_typed+0x174/0x298
>   devm_drm_of_get_bridge+0xe8/0x190
>   mtk_dsi_host_attach+0x130/0x2b0
>   mipi_dsi_attach+0x8c/0xe8
>   hx83102_probe+0x1a8/0x368
>   mipi_dsi_drv_probe+0x6c/0x88
>   really_probe+0x1c4/0x698
>   __driver_probe_device+0x160/0x298
>   driver_probe_device+0x7c/0x2a8
>   __device_attach_driver+0x2a0/0x398
>   bus_for_each_drv+0x198/0x200
>   __device_attach+0x1c0/0x308
>   device_initial_probe+0x20/0x38
>   bus_probe_device+0x11c/0x1f8
>   deferred_probe_work_func+0x80/0x250
>   worker_thread+0x9b4/0x2780
>   kthread+0x274/0x350
>   ret_from_fork+0x10/0x20
>=20
>  Allocated by task 69:
>   kasan_save_track+0x40/0x78
>   kasan_save_alloc_info+0x44/0x58
>   __kasan_kmalloc+0x84/0xa0
>   __kmalloc_node_track_caller_noprof+0x228/0x450
>   devm_kmalloc+0x6c/0x288
>   devm_drm_panel_bridge_add_typed+0xa0/0x298
>   devm_drm_of_get_bridge+0xe8/0x190
>   mtk_dsi_host_attach+0x130/0x2b0
>   mipi_dsi_attach+0x8c/0xe8
>   hx83102_probe+0x1a8/0x368
>   mipi_dsi_drv_probe+0x6c/0x88
>   really_probe+0x1c4/0x698
>   __driver_probe_device+0x160/0x298
>   driver_probe_device+0x7c/0x2a8
>   __device_attach_driver+0x2a0/0x398
>   bus_for_each_drv+0x198/0x200
>   __device_attach+0x1c0/0x308
>   device_initial_probe+0x20/0x38
>   bus_probe_device+0x11c/0x1f8
>   deferred_probe_work_func+0x80/0x250
>   worker_thread+0x9b4/0x2780
>   kthread+0x274/0x350
>   ret_from_fork+0x10/0x20
>=20
>  Freed by task 69:
>   kasan_save_track+0x40/0x78
>   kasan_save_free_info+0x58/0x78
>   __kasan_slab_free+0x48/0x68
>   kfree+0xd4/0x750
>   devres_release_all+0x144/0x1e8
>   really_probe+0x48c/0x698
>   __driver_probe_device+0x160/0x298
>   driver_probe_device+0x7c/0x2a8
>   __device_attach_driver+0x2a0/0x398
>   bus_for_each_drv+0x198/0x200
>   __device_attach+0x1c0/0x308
>   device_initial_probe+0x20/0x38
>   bus_probe_device+0x11c/0x1f8
>   deferred_probe_work_func+0x80/0x250
>   worker_thread+0x9b4/0x2780
>   kthread+0x274/0x350
>   ret_from_fork+0x10/0x20
>=20
>  The buggy address belongs to the object at ffffff80c4e9e000
>   which belongs to the cache kmalloc-4k of size 4096
>  The buggy address is located 256 bytes inside of
>   freed 4096-byte region [ffffff80c4e9e000, ffffff80c4e9f000)
>=20
>  The buggy address belongs to the physical page:
>  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  flags: 0x8000000000000040(head|zone=3D2)
>  page_type: f5(slab)
>  page: refcount:1 mapcount:0 mapping:0000000000000000
>  index:0x0 pfn:0x104e98
>  raw: 8000000000000040 ffffff80c0003040 dead000000000122 0000000000000000
>  raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
>  head: 8000000000000040 ffffff80c0003040 dead000000000122 0000000000000000
>  head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
>  head: 8000000000000003 fffffffec313a601 ffffffffffffffff 0000000000000000
>  head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: kasan: bad access detected
>=20
>  Memory state around the buggy address:
>   ffffff80c4e9e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffffff80c4e9e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  >ffffff80c4e9e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffffff80c4e9e180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffffff80c4e9e200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Signed-off-by: Fei Shao <fshao@chromium.org>

I was looking at the driver to try to follow your (awesome btw, thanks)
commit log, and it does have a quite different structure compared to
what we recommend.

Would following
https://docs.kernel.org/gpu/drm-kms-helpers.html#special-care-with-mipi-dsi=
-bridges
help?

Maxime

--dkuvoaq5vcnrqd3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxo/JwAKCRAnX84Zoj2+
djlwAYDU5AJMts7DqHAI/ZfjLhLmr61kQEljRX2stW/N47ZWhUKplzVN203QoZiz
mLAgACgBgMguwsc5LMVt2SiVLt90ReG/oNPadAg4oV5U3OKPsVa7t+TiPcgiMRq1
mvt1lDUj5w==
=fKn5
-----END PGP SIGNATURE-----

--dkuvoaq5vcnrqd3p--

