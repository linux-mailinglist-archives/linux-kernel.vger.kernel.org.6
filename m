Return-Path: <linux-kernel+bounces-353124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AA699290E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7E11C229A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81AD18BC12;
	Mon,  7 Oct 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CnEStV+E"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48C1E519
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728296502; cv=none; b=sBMZCEr3Z4UmZp4DeNkbqwD4KzRhC8C22mjXVUYsLWO81B1K6KBsXExoULmARpUw3QOJaeuJaAEPpQ7BlVKSq8w2lCSJMm9WJkcKshGgqWFlXvyS/TAUsoiIkjNq4PHS8kcS4sDbZuBAEEPi8HDX1M6RLl9yWXV4qODh7Q4yScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728296502; c=relaxed/simple;
	bh=McHCI2CeKX0UmIbnN8lAxQw51P+SFzgK5O5zhW1o0fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWiX28WTkZcoHYTXG+NS84fE8BMyLIx98Rfj0HIraseo2OkCQH2IxVLmc9o82R1FSSBNjMp80YaU/dMNZ/oN20E85Mh6x0fzM1RKt2He1reqXaklC8vDocPEByGZ6qD1XNkF2ijjZNuUCNYhLTez6de/MaRxxd5v+03C+jPemDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CnEStV+E; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fada911953so49775261fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 03:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728296498; x=1728901298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42VI+/VqIwVfuu0I3eZ6zIr2bxJZcgc94pI3kbkx00Q=;
        b=CnEStV+EMTqJovDNiM6hd0o+/2usxoX4uFm/1+NAtLJB/YsFcaAZDIqnSIcJl34a/1
         +0giFqZnPFS/HZoNHhH2FeeWwKVXntLbwZYulSd5ajWOy2YwQUm0E25PbMJuF5BXy17h
         okRPEBaJE8HhGI//6Et4HTde0NWA2KnCXdgbjWkcFr9t3T2+InbOWpV2x6vn25yi5jDU
         53et5eZEP415PSSTQy0MA+YlLgaKCpKDDmgjG/O3BEI1e2Fnhs1hkJYUU8h9a21EtMql
         JmK8RyjMPHFgAiVUofR+Emlrz6Yz1KfsYkrbBjz4eCxfA6LsrbJ4ZnvXor2v2XAgSNia
         26dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728296498; x=1728901298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42VI+/VqIwVfuu0I3eZ6zIr2bxJZcgc94pI3kbkx00Q=;
        b=I5Dw+eiyeOejO4b14qq6ebxkiW/PLQHtkFDrYHIV15ZHqxYzpaoxxsm5D46C/gOgHQ
         0P/wDpP0k6VCTpM8L177Vdxp7Eo3PA0C8ySiLEbeXpLOLewvcSG7zbUXSRuQx0FMmqrk
         FrM0ffGixgumiGQnLL7l3A45K3cWMIDslWeD0ZAvflDnp3xi50RU9r6Xfrz6+nQYPK/d
         XiOI89vcJ2i7vrSwUZAhMv7XPifBAFuIYX7LDHpvDA12touPw88g4myDrElz07Lg0US2
         2QBjM1ZqFzoWHz2c1DYwCRg3itotc7Vd+3LJlZWQNjruIVHGVA/Rzp/S8KTheoW/aEP+
         IlkA==
X-Forwarded-Encrypted: i=1; AJvYcCWHzIFpkK9EGFnIxnnSiXeswSM3T1Npf3Uov5DGtQMY0ExCKzglt2BbsgTn2DxBEc/E/6sGLDwdH+JBccU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3k8hhiOe7QnbYIi5vcHFljzC+9TGvYnBoL5HuN12IiPFTTPes
	18Q6uTrbow0tkSJHCCVKuBhLmoNZdVFcqoQuQRvmJHzSiPco8Uh48o4Plbe6p4tYzJpl6k2aHHz
	57NXR4sqUDw9scCpnODRmwaP7G0jwWhz4Zzl9Tw==
X-Google-Smtp-Source: AGHT+IHlMfA/pcWv2+DY9iQvFy/My+z3wfF73pL3P5IaEuYxJ3RSQTNXxxl8wziWzlqxsxegJhC+HlVXy29H0n3c1NA=
X-Received: by 2002:a2e:a552:0:b0:2f7:5900:1a37 with SMTP id
 38308e7fff4ca-2faea25332amr46441421fa.17.1728296498430; Mon, 07 Oct 2024
 03:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZwLNuZL-8Gh5UUQb@robin>
In-Reply-To: <ZwLNuZL-8Gh5UUQb@robin>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 7 Oct 2024 12:21:26 +0200
Message-ID: <CACRpkdayPwv3QZka0V48S63CVf1XOwRVWJ4gjJRzhv_7J089Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/fbdev-dma: Only cleanup deferred I/O if necessary
To: Janne Grunau <j@jannau.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 7:49=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> Commit 5a498d4d06d6 ("drm/fbdev-dma: Only install deferred I/O if
> necessary") initializes deferred I/O only if it is used.
> drm_fbdev_dma_fb_destroy() however calls fb_deferred_io_cleanup()
> unconditionally with struct fb_info.fbdefio =3D=3D NULL. KASAN with the
> out-of-tree Apple silicon display driver posts following warning from
> __flush_work() of a random struct work_struct instead of the expected
> NULL pointer derefs.
>
> [   22.053799] ------------[ cut here ]------------
> [   22.054832] WARNING: CPU: 2 PID: 1 at kernel/workqueue.c:4177 __flush_=
work+0x4d8/0x580
> [   22.056597] Modules linked in: uhid bnep uinput nls_ascii ip6_tables i=
p_tables i2c_dev loop fuse dm_multipath nfnetlink zram hid_magicmouse btrfs=
 xor xor_neon brcmfmac_wcc raid6_pq hci_bcm4377 bluetooth brcmfmac hid_appl=
e brcmutil nvmem_spmi_mfd simple_mfd_spmi dockchannel_hid cfg80211 joydev r=
egmap_spmi nvme_apple ecdh_generic ecc macsmc_hid rfkill dwc3 appledrm snd_=
soc_macaudio macsmc_power nvme_core apple_isp phy_apple_atc apple_sart appl=
e_rtkit_helper apple_dockchannel tps6598x macsmc_hwmon snd_soc_cs42l84 vide=
obuf2_v4l2 spmi_apple_controller nvmem_apple_efuses videobuf2_dma_sg apple_=
z2 videobuf2_memops spi_nor panel_summit videobuf2_common asahi videodev pw=
m_apple apple_dcp snd_soc_apple_mca apple_admac spi_apple clk_apple_nco i2c=
_pasemi_platform snd_pcm_dmaengine mc i2c_pasemi_core mux_core ofpart adpdr=
m drm_dma_helper apple_dart apple_soc_cpufreq leds_pwm phram
> [   22.073768] CPU: 2 UID: 0 PID: 1 Comm: systemd-shutdow Not tainted 6.1=
1.2-asahi+ #asahi-dev
> [   22.075612] Hardware name: Apple MacBook Pro (13-inch, M2, 2022) (DT)
> [   22.077032] pstate: 01400005 (nzcv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [   22.078567] pc : __flush_work+0x4d8/0x580
> [   22.079471] lr : __flush_work+0x54/0x580
> [   22.080345] sp : ffffc000836ef820
> [   22.081089] x29: ffffc000836ef880 x28: 0000000000000000 x27: ffff80002=
ddb7128
> [   22.082678] x26: dfffc00000000000 x25: 1ffff000096f0c57 x24: ffffc0008=
2d3e358
> [   22.084263] x23: ffff80004b7862b8 x22: dfffc00000000000 x21: ffff80005=
aa1d470
> [   22.085855] x20: ffff80004b786000 x19: ffff80004b7862a0 x18: 000000000=
0000000
> [   22.087439] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000005
> [   22.089030] x14: 1ffff800106ddf0a x13: 0000000000000000 x12: 000000000=
0000000
> [   22.090618] x11: ffffb800106ddf0f x10: dfffc00000000000 x9 : 1ffff8001=
06ddf0e
> [   22.092206] x8 : 0000000000000000 x7 : aaaaaaaaaaaaaaaa x6 : 000000000=
0000001
> [   22.093790] x5 : ffffc000836ef728 x4 : 0000000000000000 x3 : 000000000=
0000020
> [   22.095368] x2 : 0000000000000008 x1 : 00000000000000aa x0 : 000000000=
0000000
> [   22.096955] Call trace:
> [   22.097505]  __flush_work+0x4d8/0x580
> [   22.098330]  flush_delayed_work+0x80/0xb8
> [   22.099231]  fb_deferred_io_cleanup+0x3c/0x130
> [   22.100217]  drm_fbdev_dma_fb_destroy+0x6c/0xe0 [drm_dma_helper]
> [   22.101559]  unregister_framebuffer+0x210/0x2f0
> [   22.102575]  drm_fb_helper_unregister_info+0x48/0x60
> [   22.103683]  drm_fbdev_dma_client_unregister+0x4c/0x80 [drm_dma_helper=
]
> [   22.105147]  drm_client_dev_unregister+0x1cc/0x230
> [   22.106217]  drm_dev_unregister+0x58/0x570
> [   22.107125]  apple_drm_unbind+0x50/0x98 [appledrm]
> [   22.108199]  component_del+0x1f8/0x3a8
> [   22.109042]  dcp_platform_shutdown+0x24/0x38 [apple_dcp]
> [   22.110357]  platform_shutdown+0x70/0x90
> [   22.111219]  device_shutdown+0x368/0x4d8
> [   22.112095]  kernel_restart+0x6c/0x1d0
> [   22.112946]  __arm64_sys_reboot+0x1c8/0x328
> [   22.113868]  invoke_syscall+0x78/0x1a8
> [   22.114703]  do_el0_svc+0x124/0x1a0
> [   22.115498]  el0_svc+0x3c/0xe0
> [   22.116181]  el0t_64_sync_handler+0x70/0xc0
> [   22.117110]  el0t_64_sync+0x190/0x198
> [   22.117931] ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> Fixes: 5a498d4d06d6 ("drm/fbdev-dma: Only install deferred I/O if necessa=
ry")

Good catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

