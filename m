Return-Path: <linux-kernel+bounces-425235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D469DBF20
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAA4B223AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6321547FF;
	Fri, 29 Nov 2024 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kJ1cDHNM"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07D722EE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855989; cv=none; b=pwyeh6TkmpaIc74MHe5ajZ64TB1Um1tEtpnO+1YIbVc356psosh/i4kKhtYshrI+CE4mCYp+oX9d2y9IZpViFUfoiGZl0RkRLwDI0K/g3vEhiiQ4NIm8AbBbDrDo+LOQPGvxFE5TAG2uBl/aHCjL6lsjDpHupMsRhl7ncNLjrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855989; c=relaxed/simple;
	bh=bwBxKDqMxlUgslkesFmVpw6JEFkrHYjpktkLOSV5WOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K5USEizB5gyEvX4XS6/+C5iQ0TD2G986MFlCu9uOwmlEkB2z8pI/PglsWB3Ft2U1iFG4XAh5L9ooUtr17myv9kBCXx/Oweszv0iRawxr3o73wG0P1co/to9sB3XHPJ0FKJOeWhOYYDP6MX4t2SO7T/b8pJlf1yO3e8SlS0Liv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kJ1cDHNM; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53df6322ea7so2450557e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732855986; x=1733460786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abtvqwEX06VcD2noVO4k9EKdu5qyrMwQkmf5rMXN72U=;
        b=kJ1cDHNMsqhPVTT9yqY6VhKChnJ8IfxmDAFWBNxI9aQ3hD7D9pQlW6uhZEmmSP550s
         8Cng3VeRGACXRj6Jo2p8h+tVYm0YTigXBIc0JLaV9fnocUSu7sI+f+Z6mcDZbygbLKvh
         ihLXwwuQPRoa7/pSBdvd0Sgo4eOlqjR9FGTXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732855986; x=1733460786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abtvqwEX06VcD2noVO4k9EKdu5qyrMwQkmf5rMXN72U=;
        b=DPHllAV5MHglNMQavUUCKfArVVgpSjKqW8v+Cb6jCH37AWKTt2U9+p6lSo5tNH+93P
         HCGPZOttF7TkXvjWKzQQUC/nnTdHcxOqpXSTFYmhfoDc1oqteLNcreOzNT8IQBry82DP
         xepgUjXsi+NMdfBY8s1uYMEc43gnw0DAtpzsk7K8xz+watB1b/tM0Of5ogb/4JNDlrhw
         BtrCK89EM6DOIY1hl7eNDbxDcVFmVegUgsdb9GsnRFnkalPHqWdMJZVh525Jt7zoutgP
         RuRiOFYkzQii8IemtCDaw7N0AFXvitBOqxCT+3qyC3i7oeCybjQTVTUj9j16BXXgyKyN
         TUDg==
X-Forwarded-Encrypted: i=1; AJvYcCUU4zsBHdYdsrWzmKTIASml91C2kp+KwX75RdmsksFfahEN60fiCn8pG+KFaGR6Bc5dmONmc2bphv7DRk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPThuDnzdf6351KO5sNPMg3QF07aGpk83hXv6gdfZMOM3FxoK6
	3qmCAhDTynagCG+obFoDBbbDE6QeyABhbzWW98l53A3bF8mlcKATMzj9U5FH+v4uIqXEyHFxQa8
	V7owjaCSroH0uohp8rI8U/z0/m0zzYCjA8UFa
X-Gm-Gg: ASbGnctxZiLt4jXrA0n7lD7ZLAFn+NBPwviFY30FnnctFf2sTzD1vLiZaiHWkHkFaMU
	xDJskRHsaDZIQwVXqu7lJnXaY2zv/aVPxCWkoXt4Zc3L9/hFXJj91HsUyLA==
X-Google-Smtp-Source: AGHT+IEtmckcH/VBO2udjmn3Tmhgf3cufwQHIynvCEhGB01bD0IxU/vDhlfY86A9/F7LTzPWg+uiqElMGmXeMAXs32k=
X-Received: by 2002:ac2:4c45:0:b0:53b:4a6c:1849 with SMTP id
 2adb3069b0e04-53df010b1b4mr8365871e87.35.1732855985503; Thu, 28 Nov 2024
 20:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009052402.411978-1-fshao@chromium.org> <20241024-stalwart-bandicoot-of-music-bc6b29@houat>
 <CAC=S1niZuiJkWBvci+bmrU-BvahhXyWWAYAMOB200a3Ppu=rTg@mail.gmail.com>
 <20241114-gray-corgi-of-youth-f992ec@houat> <CAGXv+5EmVj6S2iioYgMKvY8NM3_jzCDS9-GC-GOMU44j0ikmKA@mail.gmail.com>
 <58ee3fdd-ae38-4e6d-9280-cc419d0f28da@linux.dev>
In-Reply-To: <58ee3fdd-ae38-4e6d-9280-cc419d0f28da@linux.dev>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 29 Nov 2024 12:52:54 +0800
Message-ID: <CAGXv+5HD6y0hcEeUzJd5vh1mapftY5E436ojgzTF46uYQuTrig@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/bridge: panel: Use devm_drm_bridge_add()
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>, Fei Shao <fshao@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 2:46=E2=80=AFAM Sui Jingfeng <sui.jingfeng@linux.de=
v> wrote:
>
> Hi,
>
> On 2024/11/27 17:58, Chen-Yu Tsai wrote:
> > Revisiting this thread since I just stepped on the same problem on a
> > different device.
> >
> > On Thu, Nov 14, 2024 at 9:12=E2=80=AFPM Maxime Ripard <mripard@kernel.o=
rg> wrote:
> >> On Tue, Oct 29, 2024 at 10:53:49PM +0800, Fei Shao wrote:
> >>> On Thu, Oct 24, 2024 at 8:36=E2=80=AFPM Maxime Ripard <mripard@kernel=
.org> wrote:
> >>>> On Wed, Oct 09, 2024 at 01:23:31PM +0800, Fei Shao wrote:
> >>>>> In the mtk_dsi driver, its DSI host attach callback calls
> >>>>> devm_drm_of_get_bridge() to get the next bridge. If that next bridg=
e is
> >>>>> a panel bridge, a panel_bridge object is allocated and managed by t=
he
> >>>>> panel device.
> >>>>>
> >>>>> Later, if the attach callback fails with -EPROBE_DEFER from subsequ=
ent
> >>>>> component_add(), the panel device invoking the callback at probe ti=
me
> >>>>> also fails, and all device-managed resources are freed accordingly.
> >>>>>
> >>>>> This exposes a drm_bridge bridge_list corruption due to the unbalan=
ced
> >>>>> lifecycle between the DSI host and the panel devices: the panel_bri=
dge
> >>>>> object managed by panel device is freed, while drm_bridge_remove() =
is
> >>>>> bound to DSI host device and never gets called.
> >>>>> The next drm_bridge_add() will trigger UAF against the freed bridge=
 list
> >>>>> object and result in kernel panic.
> >>>>>
> >>>>> This bug is observed on a MediaTek MT8188-based Chromebook with MIP=
I DSI
> >>>>> outputting to a DSI panel (DT is WIP for upstream).
> >>>>>
> >>>>> As a fix, using devm_drm_bridge_add() with the panel device in the =
panel
> >>>>> path seems reasonable. This also implies a chain of potential clean=
up
> >>>>> actions:
> >>>>>
> >>>>> 1. Removing drm_bridge_remove() means devm_drm_panel_bridge_release=
()
> >>>>>     becomes hollow and can be removed.
> >>>>>
> >>>>> 2. devm_drm_panel_bridge_add_typed() is almost emptied except for t=
he
> >>>>>     `bridge->pre_enable_prev_first` line. Itself can be also remove=
d if
> >>>>>     we move the line into drm_panel_bridge_add_typed(). (maybe?)
> >>>>>
> >>>>> 3. drm_panel_bridge_add_typed() now calls all the needed devm_* cal=
ls,
> >>>>>     so it's essentially the new devm_drm_panel_bridge_add_typed().
> >>>>>
> >>>>> 4. drmm_panel_bridge_add() needs to be updated accordingly since it
> >>>>>     calls drm_panel_bridge_add_typed(). But now there's only one br=
idge
> >>>>>     object to be freed, and it's already being managed by panel dev=
ice.
> >>>>>     I wonder if we still need both drmm_ and devm_ version in this =
case.
> >>>>>     (maybe yes from DRM PoV, I don't know much about the context)
> >>>>>
> >>>>> This is a RFC patch since I'm not sure if my understanding is corre=
ct
> >>>>> (for both the fix and the cleanup). It fixes the issue I encountere=
d,
> >>>>> but I don't expect it to be picked up directly due to the redundant
> >>>>> commit message and the dangling devm_drm_panel_bridge_release().
> >>>>> I plan to resend the official patch(es) once I know what I supposed=
 to
> >>>>> do next.
> >>>>>
> >>>>> For reference, here's the KASAN report from the device:
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>   BUG: KASAN: slab-use-after-free in drm_bridge_add+0x98/0x230
> >>>>>   Read of size 8 at addr ffffff80c4e9e100 by task kworker/u32:1/69
> >>>>>
> >>>>>   CPU: 1 UID: 0 PID: 69 Comm: kworker/u32:1 Not tainted 6.12.0-rc1-=
next-20241004-kasan-00030-g062135fa4046 #1
> >>>>>   Hardware name: Google Ciri sku0/unprovisioned board (DT)
> >>>>>   Workqueue: events_unbound deferred_probe_work_func
> >>>>>   Call trace:
> >>>>>    dump_backtrace+0xfc/0x140
> >>>>>    show_stack+0x24/0x38
> >>>>>    dump_stack_lvl+0x40/0xc8
> >>>>>    print_report+0x140/0x700
> >>>>>    kasan_report+0xcc/0x130
> >>>>>    __asan_report_load8_noabort+0x20/0x30
> >>>>>    drm_bridge_add+0x98/0x230
> >>>>>    devm_drm_panel_bridge_add_typed+0x174/0x298
> >>>>>    devm_drm_of_get_bridge+0xe8/0x190
> >>>>>    mtk_dsi_host_attach+0x130/0x2b0
> >>>>>    mipi_dsi_attach+0x8c/0xe8
> >>>>>    hx83102_probe+0x1a8/0x368
> >>>>>    mipi_dsi_drv_probe+0x6c/0x88
> >>>>>    really_probe+0x1c4/0x698
> >>>>>    __driver_probe_device+0x160/0x298
> >>>>>    driver_probe_device+0x7c/0x2a8
> >>>>>    __device_attach_driver+0x2a0/0x398
> >>>>>    bus_for_each_drv+0x198/0x200
> >>>>>    __device_attach+0x1c0/0x308
> >>>>>    device_initial_probe+0x20/0x38
> >>>>>    bus_probe_device+0x11c/0x1f8
> >>>>>    deferred_probe_work_func+0x80/0x250
> >>>>>    worker_thread+0x9b4/0x2780
> >>>>>    kthread+0x274/0x350
> >>>>>    ret_from_fork+0x10/0x20
> >>>>>
> >>>>>   Allocated by task 69:
> >>>>>    kasan_save_track+0x40/0x78
> >>>>>    kasan_save_alloc_info+0x44/0x58
> >>>>>    __kasan_kmalloc+0x84/0xa0
> >>>>>    __kmalloc_node_track_caller_noprof+0x228/0x450
> >>>>>    devm_kmalloc+0x6c/0x288
> >>>>>    devm_drm_panel_bridge_add_typed+0xa0/0x298
> >>>>>    devm_drm_of_get_bridge+0xe8/0x190
> >>>>>    mtk_dsi_host_attach+0x130/0x2b0
> >>>>>    mipi_dsi_attach+0x8c/0xe8
> >>>>>    hx83102_probe+0x1a8/0x368
> >>>>>    mipi_dsi_drv_probe+0x6c/0x88
> >>>>>    really_probe+0x1c4/0x698
> >>>>>    __driver_probe_device+0x160/0x298
> >>>>>    driver_probe_device+0x7c/0x2a8
> >>>>>    __device_attach_driver+0x2a0/0x398
> >>>>>    bus_for_each_drv+0x198/0x200
> >>>>>    __device_attach+0x1c0/0x308
> >>>>>    device_initial_probe+0x20/0x38
> >>>>>    bus_probe_device+0x11c/0x1f8
> >>>>>    deferred_probe_work_func+0x80/0x250
> >>>>>    worker_thread+0x9b4/0x2780
> >>>>>    kthread+0x274/0x350
> >>>>>    ret_from_fork+0x10/0x20
> >>>>>
> >>>>>   Freed by task 69:
> >>>>>    kasan_save_track+0x40/0x78
> >>>>>    kasan_save_free_info+0x58/0x78
> >>>>>    __kasan_slab_free+0x48/0x68
> >>>>>    kfree+0xd4/0x750
> >>>>>    devres_release_all+0x144/0x1e8
> >>>>>    really_probe+0x48c/0x698
> >>>>>    __driver_probe_device+0x160/0x298
> >>>>>    driver_probe_device+0x7c/0x2a8
> >>>>>    __device_attach_driver+0x2a0/0x398
> >>>>>    bus_for_each_drv+0x198/0x200
> >>>>>    __device_attach+0x1c0/0x308
> >>>>>    device_initial_probe+0x20/0x38
> >>>>>    bus_probe_device+0x11c/0x1f8
> >>>>>    deferred_probe_work_func+0x80/0x250
> >>>>>    worker_thread+0x9b4/0x2780
> >>>>>    kthread+0x274/0x350
> >>>>>    ret_from_fork+0x10/0x20
> >>>>>
> >>>>>   The buggy address belongs to the object at ffffff80c4e9e000
> >>>>>    which belongs to the cache kmalloc-4k of size 4096
> >>>>>   The buggy address is located 256 bytes inside of
> >>>>>    freed 4096-byte region [ffffff80c4e9e000, ffffff80c4e9f000)
> >>>>>
> >>>>>   The buggy address belongs to the physical page:
> >>>>>   head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pinc=
ount:0
> >>>>>   flags: 0x8000000000000040(head|zone=3D2)
> >>>>>   page_type: f5(slab)
> >>>>>   page: refcount:1 mapcount:0 mapping:0000000000000000
> >>>>>   index:0x0 pfn:0x104e98
> >>>>>   raw: 8000000000000040 ffffff80c0003040 dead000000000122 000000000=
0000000
> >>>>>   raw: 0000000000000000 0000000000040004 00000001f5000000 000000000=
0000000
> >>>>>   head: 8000000000000040 ffffff80c0003040 dead000000000122 00000000=
00000000
> >>>>>   head: 0000000000000000 0000000000040004 00000001f5000000 00000000=
00000000
> >>>>>   head: 8000000000000003 fffffffec313a601 ffffffffffffffff 00000000=
00000000
> >>>>>   head: 0000000000000008 0000000000000000 00000000ffffffff 00000000=
00000000
> >>>>>   page dumped because: kasan: bad access detected
> >>>>>
> >>>>>   Memory state around the buggy address:
> >>>>>    ffffff80c4e9e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
> >>>>>    ffffff80c4e9e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
> >>>>>   >ffffff80c4e9e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
> >>>>>                      ^
> >>>>>    ffffff80c4e9e180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
> >>>>>    ffffff80c4e9e200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb f=
b
> >>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>
> >>>>> Signed-off-by: Fei Shao <fshao@chromium.org>
> >>>> I was looking at the driver to try to follow your (awesome btw, than=
ks)
> >>>> commit log, and it does have a quite different structure compared to
> >>>> what we recommend.
> >>>>
> >>>> Would following
> >>>> https://docs.kernel.org/gpu/drm-kms-helpers.html#special-care-with-m=
ipi-dsi-bridges
> >>>> help?
> >>> Hi Maxime,
> >>>
> >>> Thank you for the pointer.
> >>> I read the suggested pattern in the doc and compared it with the
> >>> drivers. If I understand correctly, both the MIPI-DSI host and panel
> >>> drivers follow the instructions:
> >>>
> >>> 1. The MIPI-DSI host driver must run mipi_dsi_host_register() in its =
probe hook.
> >>>     >> drm/mediatek/mtk_dsi.c runs mipi_dsi_host_register() in the pr=
obe hook.
> >>> 2. In its probe hook, the bridge driver must try to find its MIPI-DSI
> >>> host, register as a MIPI-DSI device and attach the MIPI-DSI device to
> >>> its host.
> >>>     >> drm/panel/panel-himax-hx83102.c follows and runs
> >>> mipi_dsi_attach() at the end of probe hook.
> >>> 3. In its struct mipi_dsi_host_ops.attach hook, the MIPI-DSI host can
> >>> now add its component.
> >>>     >> drm/mediatek/mtk_dsi.c calls component_add() in the attach cal=
lback.
> >>>
> >>> Could you elaborate on the "different structures" you mentioned?
> >> Yeah, you're right, sorry.
> >>
> >>> To clarify my point: the issue is that component_add() may return
> >>> -EPROBE_DEFER if the component (e.g. DSI encoder) is not ready,
> >>> causing the panel bridge to be removed. However, drm_bridge_remove()
> >>> is bound to MIPI-DSI host instead of panel bridge, which owns the
> >>> actual list_head object.
> >>>
> >>> This might be reproducible with other MIPI-DSI host + panel
> >>> combinations by forcibly returning -EPROBE_DEFER in the host attach
> >>> hook (verification with another device is needed), so the fix may be
> >>> required in drm/bridge/panel.c.
> >> Yeah, I think you're just hitting another bridge lifetime issue, and
> >> it's not the only one unfortunately. Tying the bridge structure lifeti=
me
> >> itself to the device is wrong, it should be tied to the DRM device
> >> lifetime instead.
> > I think the more immediate issue is that the bridge object's lifetime
> > and drm_bridge_add/remove are inconsistent when devm_drm_of_get_bridge(=
)
> > or drmm_of_get_bridge() are used.
>
> Well, I think this is more of probe issue of multiple kernel modules.
>
> The root issue is that the global bridge list still stores the
> pointer to *old* the bridge instance which has been freed after
> the first '-EPROBE_DEFER' happened. The next time the
> 'drm_bridge_add(&panel_bridge->bridge);' is called, we will deference
> the *old* NULL pointer. Because it will touch the 'struct drm_bridge::lis=
t'
> field, which's backing memory has been freed.

Yes. That is what is causing the crash.

> > These helpers tie the bridge add/removal to the device or drm_device
> > passed in, but internally they call down to drm_panel_bridge_add_typed(=
)
> > which allocates the bridge object tied to the panel device.
>
> When the devm_drm_panel_bridge_add_typed() is passed a pointer of
> DSI host device, we essentially tie the lifetime of the freshly
> created drm bridge instance to the DSI host device. But, the
> 'struct panel_bridge' clearly hint that the bridge instance has
> the same lifetime with the backing panel, after all, it's the
> underlying panel baking the bridge.

Exactly.

> >> But then, the discussion becomes that bridges typically probe outside =
of
> >> the "main" DRM device probe path, so you don't have access to the DRM
> >> device structure until attach at best.
> >>
> >> That's why I'm a bit skeptical about your patch. It might workaround
> >> your issue, but it doesn't actually solve the problem. I guess the bes=
t
> >> way about it would be to convert bridges to reference counting, with t=
he
> >> device taking a reference at probe time when it allocates the structur=
e
> >> (and giving it back at remove time), and the DRM device taking one whe=
n
> >> it's attached and one when it's detached.
> > Without going as far, it's probably better to align the lifecycle of
> > the two parts. Most other bridge drivers in the kernel have |drm_bridge=
|
> > lifecycle tied to their underlying |device|, either with explicit
> > drm_bridge_{add,remove}() calls in their probe/bind and remove/unbind
> > callbacks respectively, or with devm_drm_bridge_add in the probe/bind
> > path. The only ones with a narrower lifecycle are the DSI hosts, which
> > add the bridge in during host attach and remove it during host detach.
> >
> > I'm thinking about fixing the panel_bridge lifecycle such that it is
> > tied to the panel itself. Maybe that would involve making
> > devm_drm_of_get_bridge() correctly return bridges even if a panel was
> > found, and then making the panels create and add panel bridges directly=
,
> > possibly within drm_panel_add(). Would that make sense?
>
> I think, align the lifetime of the bridge with 'panel->dev' probably help=
s.
> Modifying the devm_drm_of_get_bridge() function like the following patter=
n:
>
>
> ```
>
> struct drm_bridge *devm_drm_of_get_bridge(struct device_node *np, u32
> port, u32 endpoint)
> {
>      struct drm_bridge *bridge;
>      struct drm_panel *panel;
>      int ret;
>
>      ret =3D drm_of_find_panel_or_bridge(np, port, endpoint, &panel, &bri=
dge);
>      if (ret)
>          return ERR_PTR(ret);
>
>      if (panel)
>          bridge =3D devm_drm_panel_bridge_add(panel->dev, panel);
>
>      return bridge;
> }

That's one possible solution I thought of, but then the devm_ prefix
no longer makes sense. Also the panel_bridge is still implicitly created,
and we might as well move that to the panel side.

> ```
>
>
> Or alternatively, inline this to drm/mediatek,
> rename it as mtk_drm_of_get_bridge().

I would prefer to not do that, since that only fixes the issue for
MediaTek, while we have some 30 odd users of devm_drm_of_get_bridge().

> Or alternatively, manage the bridge's lifetime manually.
> Remove it from the global bridge list if errors happen.

That's also one way; it's just messy.


Thanks
ChenYu

> >
> > Thanks
> > ChenYu
> >
> >> It's much more involved than just another helper though :/
> >>
> >> Maxime
>
> --
> Best regards,
> Sui
>

