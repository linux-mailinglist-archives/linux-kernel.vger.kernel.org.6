Return-Path: <linux-kernel+bounces-409510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B869C8DCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A78C286493
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE311420A8;
	Thu, 14 Nov 2024 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g+ANTVDV"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4595413D531
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597723; cv=none; b=uw4le7Z8XHvEhPodST+yY5dVGkX83RF2H9zewWnhRlc23pRGoHe22BfY/Q3sBMIzTOd0JpQSGsQ1jSgBabMg5ZWKQm9Jbbyf2AS9PHelrdTK1+hyQSM1Gv+/drBzD27w9Q+fofhotXxgHNPG48NkKr6x/tav62prSGZs7m3kgUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597723; c=relaxed/simple;
	bh=JPgBzdK5kXF+ofLBW/zhx49+poy6AcfTzeTtO+4kxCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQqoZPo28vTV3+rjURbZmpgz/Pvtix0Cia0uIL5h4LPxMuaxtTcQh597UvQUte/8zuO8eg7ODWZWgBZoiDddZUoLXy2PfopPVTWPBbzxuRX3hDq8++T/iBEO14Fb0kwbnVcWGvISzPwIVsc8DHHKmju36vpPlbb6CBNGHB3vPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g+ANTVDV; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DEEC0291;
	Thu, 14 Nov 2024 16:21:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731597705;
	bh=JPgBzdK5kXF+ofLBW/zhx49+poy6AcfTzeTtO+4kxCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+ANTVDVL6tZXXHYv2ZS8GOxmv//FZCBMihRqyDQjHSmy0OLo4Bq2FdaZEAoEoN/X
	 hDxkdrPzHoEXf2CauIpYtbodldukKPLZDIh4Gbfzvry5+ms4IpVLQG0U8KKcIWaxqN
	 Du6/tZCmJyX1mzZmEq50tBh5f4R4eou8DMVaBXz4=
Date: Thu, 14 Nov 2024 17:21:50 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Fei Shao <fshao@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/bridge: panel: Use devm_drm_bridge_add()
Message-ID: <20241114152150.GG26171@pendragon.ideasonboard.com>
References: <20241009052402.411978-1-fshao@chromium.org>
 <20241024-stalwart-bandicoot-of-music-bc6b29@houat>
 <CAC=S1niZuiJkWBvci+bmrU-BvahhXyWWAYAMOB200a3Ppu=rTg@mail.gmail.com>
 <20241114-gray-corgi-of-youth-f992ec@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114-gray-corgi-of-youth-f992ec@houat>

On Thu, Nov 14, 2024 at 02:12:01PM +0100, Maxime Ripard wrote:
> On Tue, Oct 29, 2024 at 10:53:49PM +0800, Fei Shao wrote:
> > On Thu, Oct 24, 2024 at 8:36 PM Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Wed, Oct 09, 2024 at 01:23:31PM +0800, Fei Shao wrote:
> > > > In the mtk_dsi driver, its DSI host attach callback calls
> > > > devm_drm_of_get_bridge() to get the next bridge. If that next bridge is
> > > > a panel bridge, a panel_bridge object is allocated and managed by the
> > > > panel device.
> > > >
> > > > Later, if the attach callback fails with -EPROBE_DEFER from subsequent
> > > > component_add(), the panel device invoking the callback at probe time
> > > > also fails, and all device-managed resources are freed accordingly.
> > > >
> > > > This exposes a drm_bridge bridge_list corruption due to the unbalanced
> > > > lifecycle between the DSI host and the panel devices: the panel_bridge
> > > > object managed by panel device is freed, while drm_bridge_remove() is
> > > > bound to DSI host device and never gets called.
> > > > The next drm_bridge_add() will trigger UAF against the freed bridge list
> > > > object and result in kernel panic.
> > > >
> > > > This bug is observed on a MediaTek MT8188-based Chromebook with MIPI DSI
> > > > outputting to a DSI panel (DT is WIP for upstream).
> > > >
> > > > As a fix, using devm_drm_bridge_add() with the panel device in the panel
> > > > path seems reasonable. This also implies a chain of potential cleanup
> > > > actions:
> > > >
> > > > 1. Removing drm_bridge_remove() means devm_drm_panel_bridge_release()
> > > >    becomes hollow and can be removed.
> > > >
> > > > 2. devm_drm_panel_bridge_add_typed() is almost emptied except for the
> > > >    `bridge->pre_enable_prev_first` line. Itself can be also removed if
> > > >    we move the line into drm_panel_bridge_add_typed(). (maybe?)
> > > >
> > > > 3. drm_panel_bridge_add_typed() now calls all the needed devm_* calls,
> > > >    so it's essentially the new devm_drm_panel_bridge_add_typed().
> > > >
> > > > 4. drmm_panel_bridge_add() needs to be updated accordingly since it
> > > >    calls drm_panel_bridge_add_typed(). But now there's only one bridge
> > > >    object to be freed, and it's already being managed by panel device.
> > > >    I wonder if we still need both drmm_ and devm_ version in this case.
> > > >    (maybe yes from DRM PoV, I don't know much about the context)
> > > >
> > > > This is a RFC patch since I'm not sure if my understanding is correct
> > > > (for both the fix and the cleanup). It fixes the issue I encountered,
> > > > but I don't expect it to be picked up directly due to the redundant
> > > > commit message and the dangling devm_drm_panel_bridge_release().
> > > > I plan to resend the official patch(es) once I know what I supposed to
> > > > do next.
> > > >
> > > > For reference, here's the KASAN report from the device:
> > > > ==================================================================
> > > >  BUG: KASAN: slab-use-after-free in drm_bridge_add+0x98/0x230
> > > >  Read of size 8 at addr ffffff80c4e9e100 by task kworker/u32:1/69
> > > >
> > > >  CPU: 1 UID: 0 PID: 69 Comm: kworker/u32:1 Not tainted 6.12.0-rc1-next-20241004-kasan-00030-g062135fa4046 #1
> > > >  Hardware name: Google Ciri sku0/unprovisioned board (DT)
> > > >  Workqueue: events_unbound deferred_probe_work_func
> > > >  Call trace:
> > > >   dump_backtrace+0xfc/0x140
> > > >   show_stack+0x24/0x38
> > > >   dump_stack_lvl+0x40/0xc8
> > > >   print_report+0x140/0x700
> > > >   kasan_report+0xcc/0x130
> > > >   __asan_report_load8_noabort+0x20/0x30
> > > >   drm_bridge_add+0x98/0x230
> > > >   devm_drm_panel_bridge_add_typed+0x174/0x298
> > > >   devm_drm_of_get_bridge+0xe8/0x190
> > > >   mtk_dsi_host_attach+0x130/0x2b0
> > > >   mipi_dsi_attach+0x8c/0xe8
> > > >   hx83102_probe+0x1a8/0x368
> > > >   mipi_dsi_drv_probe+0x6c/0x88
> > > >   really_probe+0x1c4/0x698
> > > >   __driver_probe_device+0x160/0x298
> > > >   driver_probe_device+0x7c/0x2a8
> > > >   __device_attach_driver+0x2a0/0x398
> > > >   bus_for_each_drv+0x198/0x200
> > > >   __device_attach+0x1c0/0x308
> > > >   device_initial_probe+0x20/0x38
> > > >   bus_probe_device+0x11c/0x1f8
> > > >   deferred_probe_work_func+0x80/0x250
> > > >   worker_thread+0x9b4/0x2780
> > > >   kthread+0x274/0x350
> > > >   ret_from_fork+0x10/0x20
> > > >
> > > >  Allocated by task 69:
> > > >   kasan_save_track+0x40/0x78
> > > >   kasan_save_alloc_info+0x44/0x58
> > > >   __kasan_kmalloc+0x84/0xa0
> > > >   __kmalloc_node_track_caller_noprof+0x228/0x450
> > > >   devm_kmalloc+0x6c/0x288
> > > >   devm_drm_panel_bridge_add_typed+0xa0/0x298
> > > >   devm_drm_of_get_bridge+0xe8/0x190
> > > >   mtk_dsi_host_attach+0x130/0x2b0
> > > >   mipi_dsi_attach+0x8c/0xe8
> > > >   hx83102_probe+0x1a8/0x368
> > > >   mipi_dsi_drv_probe+0x6c/0x88
> > > >   really_probe+0x1c4/0x698
> > > >   __driver_probe_device+0x160/0x298
> > > >   driver_probe_device+0x7c/0x2a8
> > > >   __device_attach_driver+0x2a0/0x398
> > > >   bus_for_each_drv+0x198/0x200
> > > >   __device_attach+0x1c0/0x308
> > > >   device_initial_probe+0x20/0x38
> > > >   bus_probe_device+0x11c/0x1f8
> > > >   deferred_probe_work_func+0x80/0x250
> > > >   worker_thread+0x9b4/0x2780
> > > >   kthread+0x274/0x350
> > > >   ret_from_fork+0x10/0x20
> > > >
> > > >  Freed by task 69:
> > > >   kasan_save_track+0x40/0x78
> > > >   kasan_save_free_info+0x58/0x78
> > > >   __kasan_slab_free+0x48/0x68
> > > >   kfree+0xd4/0x750
> > > >   devres_release_all+0x144/0x1e8
> > > >   really_probe+0x48c/0x698
> > > >   __driver_probe_device+0x160/0x298
> > > >   driver_probe_device+0x7c/0x2a8
> > > >   __device_attach_driver+0x2a0/0x398
> > > >   bus_for_each_drv+0x198/0x200
> > > >   __device_attach+0x1c0/0x308
> > > >   device_initial_probe+0x20/0x38
> > > >   bus_probe_device+0x11c/0x1f8
> > > >   deferred_probe_work_func+0x80/0x250
> > > >   worker_thread+0x9b4/0x2780
> > > >   kthread+0x274/0x350
> > > >   ret_from_fork+0x10/0x20
> > > >
> > > >  The buggy address belongs to the object at ffffff80c4e9e000
> > > >   which belongs to the cache kmalloc-4k of size 4096
> > > >  The buggy address is located 256 bytes inside of
> > > >   freed 4096-byte region [ffffff80c4e9e000, ffffff80c4e9f000)
> > > >
> > > >  The buggy address belongs to the physical page:
> > > >  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> > > >  flags: 0x8000000000000040(head|zone=2)
> > > >  page_type: f5(slab)
> > > >  page: refcount:1 mapcount:0 mapping:0000000000000000
> > > >  index:0x0 pfn:0x104e98
> > > >  raw: 8000000000000040 ffffff80c0003040 dead000000000122 0000000000000000
> > > >  raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
> > > >  head: 8000000000000040 ffffff80c0003040 dead000000000122 0000000000000000
> > > >  head: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
> > > >  head: 8000000000000003 fffffffec313a601 ffffffffffffffff 0000000000000000
> > > >  head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
> > > >  page dumped because: kasan: bad access detected
> > > >
> > > >  Memory state around the buggy address:
> > > >   ffffff80c4e9e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >   ffffff80c4e9e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >  >ffffff80c4e9e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >                     ^
> > > >   ffffff80c4e9e180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > >   ffffff80c4e9e200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > > > ===================================================================
> > > >
> > > > Signed-off-by: Fei Shao <fshao@chromium.org>
> > >
> > > I was looking at the driver to try to follow your (awesome btw, thanks)
> > > commit log, and it does have a quite different structure compared to
> > > what we recommend.
> > >
> > > Would following
> > > https://docs.kernel.org/gpu/drm-kms-helpers.html#special-care-with-mipi-dsi-bridges
> > > help?
> > 
> > Hi Maxime,
> > 
> > Thank you for the pointer.
> > I read the suggested pattern in the doc and compared it with the
> > drivers. If I understand correctly, both the MIPI-DSI host and panel
> > drivers follow the instructions:
> > 
> > 1. The MIPI-DSI host driver must run mipi_dsi_host_register() in its probe hook.
> >    >> drm/mediatek/mtk_dsi.c runs mipi_dsi_host_register() in the probe hook.
> > 2. In its probe hook, the bridge driver must try to find its MIPI-DSI
> > host, register as a MIPI-DSI device and attach the MIPI-DSI device to
> > its host.
> >    >> drm/panel/panel-himax-hx83102.c follows and runs
> > mipi_dsi_attach() at the end of probe hook.
> > 3. In its struct mipi_dsi_host_ops.attach hook, the MIPI-DSI host can
> > now add its component.
> >    >> drm/mediatek/mtk_dsi.c calls component_add() in the attach callback.
> > 
> > Could you elaborate on the "different structures" you mentioned?
> 
> Yeah, you're right, sorry.
> 
> > To clarify my point: the issue is that component_add() may return
> > -EPROBE_DEFER if the component (e.g. DSI encoder) is not ready,
> > causing the panel bridge to be removed. However, drm_bridge_remove()
> > is bound to MIPI-DSI host instead of panel bridge, which owns the
> > actual list_head object.
> > 
> > This might be reproducible with other MIPI-DSI host + panel
> > combinations by forcibly returning -EPROBE_DEFER in the host attach
> > hook (verification with another device is needed), so the fix may be
> > required in drm/bridge/panel.c.
> 
> Yeah, I think you're just hitting another bridge lifetime issue, and
> it's not the only one unfortunately. Tying the bridge structure lifetime
> itself to the device is wrong, it should be tied to the DRM device
> lifetime instead.
> 
> But then, the discussion becomes that bridges typically probe outside of
> the "main" DRM device probe path, so you don't have access to the DRM
> device structure until attach at best.
> 
> That's why I'm a bit skeptical about your patch. It might workaround
> your issue, but it doesn't actually solve the problem. I guess the best
> way about it would be to convert bridges to reference counting, with the
> device taking a reference at probe time when it allocates the structure
> (and giving it back at remove time), and the DRM device taking one when
> it's attached and one when it's detached.

+1, I was considering writing exactly the same while reading your
review until I reached this paragraph. devm_* is a nice dream, and maybe
APIs that simplify cleanup in a similar way can be implemented (possibly
based on cleanup.h), but behind the scene they will need to rely on a
sound reference-counting base.

> It's much more involved than just another helper though :/

-- 
Regards,

Laurent Pinchart

