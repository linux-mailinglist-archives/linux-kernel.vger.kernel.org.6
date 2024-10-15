Return-Path: <linux-kernel+bounces-365465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2C99E2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE33B247C0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064E1DBB24;
	Tue, 15 Oct 2024 09:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nYf8meGY"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353131DACBB
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984219; cv=none; b=YJaT9KvSgQBa42OnUFzUgjIMcH2340tKC45jQMPvg3BulVpz0TAycx1Tqxdnat45ruJRzhdpsR7DsD5y/DeLS+yTLmj0J0rtK3JkaiInxVMZEaN0Hc6QJ0vYGGhkOtd6yTZnWwXDYKYZ7YvMnhXb16xbJs5ZdGCssvqdtMEaHQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984219; c=relaxed/simple;
	bh=u81bBw+iifxSp2FSScSBbWz6v8n8Ij7HMXFeueE71+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOPeP0FT6cFXpTEr8QUtmb0v5tfZNpKevS57EIvGpZ1JLuRaJhLyMXYJU8GHTd001S2bASV5uGhZKHtJHwtaqtFbXGXImlW1GjgZkjRGPbNkeikE6rV89/m2XaVQFS/3xFfrM+VyJ6vphODMm1p8GYotOwy0R/HnUB3yWYbk/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nYf8meGY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e8607c2aso3004320e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728984215; x=1729589015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYwNqTPtJJwCGBZRPO/H4MGldhIszpAIUEyOWLkI9lQ=;
        b=nYf8meGYj8WLMJR4y0q1FlIn2AyzeDPhgpyNBg92LYijUtidr/XDp6rSlUp4Pp/2G9
         G/CkmG1QRdQGGGC8ekS0A9oFzntvOvR0Q+E7Yjt1JUY2GBnK0Xh5bVhZOTEGtX79CuUJ
         +tjwvX1F+K9fJMjvw+0XeAgFAWxhcG+WlyS/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728984215; x=1729589015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYwNqTPtJJwCGBZRPO/H4MGldhIszpAIUEyOWLkI9lQ=;
        b=GuCLb1D+4OnwKTeItkmE974dBlAKXPClrgL5Ajz+tgp93of+JMnHTZ+BOdEQ/M3v4b
         gsEfLyV+ieffrkQsBSBPK8V8UijU0WASVjB5h3lL3b5Mnjt7CT9gOimDnLCKGnB5bU/y
         WasFbwm3uzzciCkYKOUgo9BdfwhVwaqXKcUK6gdNAt/1G4M7/wdVecUqSQhq2a//2qdw
         lv3ny6Oxd3I6R0F8Jrai1AWS6oWiIG/LngJBedptrf8V+ekCOtVRKp6DHrRsWa2OyrEs
         oG82OoLGphDe7CzXM06kGbK8OwwiVA2cmvJU9jQAs4bdKdKiQk1ylBvsMIRV0OMq4qrI
         jQww==
X-Forwarded-Encrypted: i=1; AJvYcCW+Wbp23ANsJBlvvQqwsUMI65WG3KSyGFRF2zD7AqQFjPFtLaKXsQbb64ngPoPg/9SAaesDSZdWaSK0Tcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3mEyVTlnXVLhetDWu5fC5lfg9KMxN2W/ITf06R8FVNbUb6TH
	CfRn3+Z85nYNdH0lQ1oIOOEAmLXLQf/Q4IhWNq48qrrRc8SbycPFYnpIxUQDvvVRZBe1pKNyebJ
	H3bxW9J7Agmoij8oeQtVRpbZYNLnxcUf80Ttc
X-Google-Smtp-Source: AGHT+IFV47hnuZqPU8RhR//utkV871fOcHo5TpPMUNV3121IIX2DLWmCimjvd/SSV+fw/mzvFLAzm1XuhrgWhYzEIyM=
X-Received: by 2002:a05:6512:3344:b0:539:9746:2d77 with SMTP id
 2adb3069b0e04-539da5992a2mr5287207e87.61.1728984215195; Tue, 15 Oct 2024
 02:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009052402.411978-1-fshao@chromium.org>
In-Reply-To: <20241009052402.411978-1-fshao@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Oct 2024 17:23:23 +0800
Message-ID: <CAGXv+5GWf=9TZw1im1+uF1biWgdhV4fKVkTu-xUHmk5qcLebBQ@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/bridge: panel: Use devm_drm_bridge_add()
To: Fei Shao <fshao@chromium.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 1:24=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote:
>
> In the mtk_dsi driver, its DSI host attach callback calls
> devm_drm_of_get_bridge() to get the next bridge. If that next bridge is
> a panel bridge, a panel_bridge object is allocated and managed by the
> panel device.
>
> Later, if the attach callback fails with -EPROBE_DEFER from subsequent
> component_add(), the panel device invoking the callback at probe time
> also fails, and all device-managed resources are freed accordingly.
>
> This exposes a drm_bridge bridge_list corruption due to the unbalanced
> lifecycle between the DSI host and the panel devices: the panel_bridge
> object managed by panel device is freed, while drm_bridge_remove() is
> bound to DSI host device and never gets called.
> The next drm_bridge_add() will trigger UAF against the freed bridge list
> object and result in kernel panic.

I think this comes back to Laurent's comment [1] when devm_drm_of_get_bridg=
e()
was first introduced. Maybe it's best to let the panel core always register
a bridge.

https://lore.kernel.org/dri-devel/YUvKcTv2hSrUqIvF@pendragon.ideasonboard.c=
om/

> This bug is observed on a MediaTek MT8188-based Chromebook with MIPI DSI
> outputting to a DSI panel (DT is WIP for upstream).
>
> As a fix, using devm_drm_bridge_add() with the panel device in the panel
> path seems reasonable. This also implies a chain of potential cleanup
> actions:
>
> 1. Removing drm_bridge_remove() means devm_drm_panel_bridge_release()
>    becomes hollow and can be removed.
>
> 2. devm_drm_panel_bridge_add_typed() is almost emptied except for the
>    `bridge->pre_enable_prev_first` line. Itself can be also removed if
>    we move the line into drm_panel_bridge_add_typed(). (maybe?)
>
> 3. drm_panel_bridge_add_typed() now calls all the needed devm_* calls,
>    so it's essentially the new devm_drm_panel_bridge_add_typed().
>
> 4. drmm_panel_bridge_add() needs to be updated accordingly since it
>    calls drm_panel_bridge_add_typed(). But now there's only one bridge
>    object to be freed, and it's already being managed by panel device.
>    I wonder if we still need both drmm_ and devm_ version in this case.
>    (maybe yes from DRM PoV, I don't know much about the context)
>
> This is a RFC patch since I'm not sure if my understanding is correct
> (for both the fix and the cleanup). It fixes the issue I encountered,
> but I don't expect it to be picked up directly due to the redundant
> commit message and the dangling devm_drm_panel_bridge_release().
> I plan to resend the official patch(es) once I know what I supposed to
> do next.
>
> For reference, here's the KASAN report from the device:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  BUG: KASAN: slab-use-after-free in drm_bridge_add+0x98/0x230
>  Read of size 8 at addr ffffff80c4e9e100 by task kworker/u32:1/69
>
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
>
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
>
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
>
>  The buggy address belongs to the object at ffffff80c4e9e000
>   which belongs to the cache kmalloc-4k of size 4096
>  The buggy address is located 256 bytes inside of
>   freed 4096-byte region [ffffff80c4e9e000, ffffff80c4e9f000)
>
>  The buggy address belongs to the physical page:
>  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>  flags: 0x8000000000000040(head|zone=3D2)
>  page_type: f5(slab)
>  page: refcount:1 mapcount:0 mapping:0000000000000000
>  index:0x0 pfn:0x104e98
>  raw: 8000000000000040 ffffff80c0003040 dead000000000122 0000000000000000
>  raw: 0000000000000000 0000000000040004 00000001f5000000 0000000000000000
>  head: 8000000000000040 ffffff80c0003040 dead000000000122 000000000000000=
0
>  head: 0000000000000000 0000000000040004 00000001f5000000 000000000000000=
0
>  head: 8000000000000003 fffffffec313a601 ffffffffffffffff 000000000000000=
0
>  head: 0000000000000008 0000000000000000 00000000ffffffff 000000000000000=
0
>  page dumped because: kasan: bad access detected
>
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
>
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
>
>  drivers/gpu/drm/bridge/panel.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/pane=
l.c
> index 6e88339dec0f..352723c59c70 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -303,7 +303,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct =
drm_panel *panel,
>         panel_bridge->bridge.ops =3D DRM_BRIDGE_OP_MODES;
>         panel_bridge->bridge.type =3D connector_type;
>
> -       drm_bridge_add(&panel_bridge->bridge);
> +       devm_drm_bridge_add(panel->dev, &panel_bridge->bridge);
>
>         return &panel_bridge->bridge;
>  }
> @@ -327,7 +327,6 @@ void drm_panel_bridge_remove(struct drm_bridge *bridg=
e)
>
>         panel_bridge =3D drm_bridge_to_panel_bridge(bridge);
>
> -       drm_bridge_remove(bridge);

I believe this is incorrect, because the bridge object is still freed
on the next line. If one calls drm_panel_bridge_remove() explicitly,
or somehow the interface device is unbound before the panel device
(which can happen for RGB or LVDS panels where the panel is not a
sub-device of the interface), it will still blow up. Also, some
drivers choose to manage the lifetime themselves with
drm_panel_bridge_add_typed() and drm_panel_bridge_remove(). A new
devm_drm_bridge_remove() function needs to be added and used here.


ChenYu


>         devm_kfree(panel_bridge->panel->dev, bridge);
>  }
>  EXPORT_SYMBOL(drm_panel_bridge_remove);
> @@ -359,8 +358,6 @@ static void devm_drm_panel_bridge_release(struct devi=
ce *dev, void *res)
>
>         if (!bridge)
>                 return;
> -
> -       drm_bridge_remove(bridge);
>  }
>
>  /**
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

