Return-Path: <linux-kernel+bounces-517292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A67A37EEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3353AD8A9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0E215F67;
	Mon, 17 Feb 2025 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HG/crocv"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C4215197;
	Mon, 17 Feb 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739785696; cv=none; b=sVmcMzDuC8wNlskAKCNc4yOZUjcaT6JqUr2YN+eIB7LeEueOW8E8TecbX9JP3FqezdsD0yU02nhX63jV5S3lQLiN803MSr4GmDQVJdGeoXlAB0xePBq2hHyK3cX2+3yd2dQqdCMptJ9yPoayBZz06IDUugR5XprV3hN5DIhv50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739785696; c=relaxed/simple;
	bh=Ol+LO05peUoIHHc4y2q7vedCdV5t6QRNAdlO0AqfKr4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j3QJcG9Y8N6KH7qnw96s790ro0+7Hu/lZlqP4YKOEZlEW7iBLdlDjdT+2KzlWiAM2JNzhnjm9/gAUbnJPf6jWNjNnR7tkPdGu5Q7jzu7q+IaagNsLRxIGcAGDCsSdY5C+wBEy8ehYIazZ7ekt2jsGSIgnJFWBCz+P96N8rlUZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HG/crocv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbae92be71so2313866b.2;
        Mon, 17 Feb 2025 01:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739785693; x=1740390493; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnZT6ZOq0Mk/tb82Bl5SiBs0WKnPFXIEG0Jtf01o8LM=;
        b=HG/crocv3yfRMgbYQ9PSs6h8nos2WzqUbRpt0V0T2t9FpuWz4HMYMg126ga2upgW7G
         67cS1ynrS5F4LnpuAwNlpHCtzOFPVZbhlmq6K2B1fTtD8Us9jUgfzZ8C8GkpFg83sOap
         XCyPYglgWzE63LLcJz5g1wg3xmDSLWaMoXz0ushJab9l0AF8ozu7Sz1SpCAlbSTaES4x
         3G3A005neti9o9U5tx/NOs3AYiCBxNrwJAp1uMw76htVEeyRveAmE59X3Jnby+yGJLcd
         Ws32Dph8Bpsxze01v8GE6MF94pNipokhDw5VrZUA0lbWR5aBmjOkNWtqQk3zT/om/u+k
         9y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739785693; x=1740390493;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnZT6ZOq0Mk/tb82Bl5SiBs0WKnPFXIEG0Jtf01o8LM=;
        b=kul8pOD7ucbrAURE5y1KNutk6Nz7VQw1TOIRrwn8qncIWfeJe6ZmEeJjcMh0sUhxOO
         b1qZP/VEgpjBRQy3olOHoccyz67VXYbCsg6+Tqyw50FGLU2DZs20Vv1l078m/X0Y5bFy
         5x/7dtGhkB3MzJWk07Dg2dYp+H7M5Oc+UNvdC/q2BU71Ldl32y8yYtbvB/CyLsa23YJI
         ozqqsp/U56yZXPXkrRFI9ciGG+aLrBckVXBIzZqpzGSrnMaQOL0bZ5XDgmV79368vT2K
         Qzx4Awolj7n+wc3RHYYCaVfM/yuZCPOnG4OdG26DCYH+5Zhh44WJyfXYw6PqgrMg2/bT
         K6mA==
X-Forwarded-Encrypted: i=1; AJvYcCUuEsTaSz+6yJbWtz0jUP5u6LNpStCo5o1bjYQRRBVXS3n2MTmPVMKsHmQonGGlfJ7rXQF4G3zvFW7YwsEN@vger.kernel.org, AJvYcCV/W/aMP4/xZPPrJ4D+6nBoxv7IRA8x45FielfWIACFDu2j5jn3El7psvGc0f058XDixPYpAkQhDQnE@vger.kernel.org
X-Gm-Message-State: AOJu0YwVLCfmfgIh+62NSOPgUWFZwGYiZ973E+3bdvVnqG+p8fSibaef
	DXV0gu4pNWA6JWiRv5i1f+2d/swLV7DHp/B5blCfBhT7tBwf9Ssg
X-Gm-Gg: ASbGncu9JzDCnVGK+rk5hpaGgWN1r4M3BGWwp5Jx5zls26Dr8jgdwh/EB4tywYPT4HE
	T3O2NLIfymj4EYetvQgoGEiWWWaATvBgFk5smErZlmlFzlO2HTQ1ncuNEVu65Er5X8rrH5scr/T
	qX2dorBVUleEU9ALAmCQWHW1OKCEzdO5xk971M4izLAZIh6l9VgyxsNaS/VYAbiTAFnDbYzKCES
	BHhjIgAa4Mb4POduKCgr7mGeZZvCU6WVQfk1C+hwIqlvh4OyTcd4rgq2JPMep6CxbzrcxbrxzUC
	yALJd+/1rFE6dFUJ9Bnn3w9cFFyrLXaqkFwsLHWlLCUjP/zgKZctWn+sOLc8DiR+ZJ9FrYNz
X-Google-Smtp-Source: AGHT+IE7UjRmly5ZRe5H57cBCYRfro4iVdDEYEpGmSZjMPaWgTgD+u8eMLWweNc3hp3YASP3wNo/5w==
X-Received: by 2002:a05:6402:13c9:b0:5e0:68de:ab93 with SMTP id 4fb4d7f45d1cf-5e068deabbbmr2293237a12.21.1739785692680;
        Mon, 17 Feb 2025 01:48:12 -0800 (PST)
Received: from smtpclient.apple (89-66-237-154.dynamic.chello.pl. [89.66.237.154])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322b9sm856628766b.37.2025.02.17.01.48.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2025 01:48:12 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH] arm64: dts: rockchip: add hdmi1 support to ROCK 5 ITX
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <20250217023521.35071-1-liujianfeng1994@gmail.com>
Date: Mon, 17 Feb 2025 10:48:00 +0100
Cc: conor+dt@kernel.org,
 devicetree@vger.kernel.org,
 heiko@sntech.de,
 krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 robh@kernel.org,
 sfr@canb.auug.org.au
Content-Transfer-Encoding: quoted-printable
Message-Id: <975CFBEF-4E37-41E4-BE3F-7294FE7E4D3F@gmail.com>
References: <2FE649E5-61FE-4299-81D1-F838298A04A5@gmail.com>
 <20250217023521.35071-1-liujianfeng1994@gmail.com>
To: Jianfeng Liu <liujianfeng1994@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> Wiadomo=C5=9B=C4=87 napisana przez Jianfeng Liu =
<liujianfeng1994@gmail.com> w dniu 17 lut 2025, o godz. 03:35:
>=20
> Hi,
>=20
> On Sun, 16 Feb 2025 20:53:27 +0100, Piotr Oniszczuk wrote:
>> [    0.531139] rockchip-drm display-subsystem: bound fdea0000.hdmi =
(ops dw_hdmi_qp_rockchip_ops)
>=20
> It seems that hdmi qp driver is built in kernel, while armbian builds =
it
> as module. I don't know if this is related. And here is the dmesg =
output
> of drm on armbian:
>=20
> jfliu@rock-5-itx:~$ sudo dmesg |grep drm
> [    2.190256] panthor fb000000.gpu: [drm] clock rate =3D 198000000
> [    2.191470] panthor fb000000.gpu: [drm] mali-g610 id 0xa867 major =
0x0 minor 0x0 status 0x5
> [    2.191478] panthor fb000000.gpu: [drm] Features: L2:0x7120306 =
Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
> [    2.191482] panthor fb000000.gpu: [drm] shader_present=3D0x50005 =
l2_present=3D0x1 tiler_present=3D0x1
> [    2.195853] panthor fb000000.gpu: [drm] Firmware protected mode =
entry not be supported, ignoring
> [    2.196019] panthor fb000000.gpu: [drm] Firmware git sha: =
814b47b551159067b67a37c4e9adda458ad9d852
> [    2.196407] panthor fb000000.gpu: [drm] CSF FW using interface =
v1.1.0, Features 0x0 Instrumentation features 0x71
> [    2.221006] [drm] Initialized panthor 1.3.0 for fb000000.gpu on =
minor 0
> [    2.566800] rockchip-drm display-subsystem: bound fdd90000.vop (ops =
rockchip_drm_fini [rockchipdrm])
> [    2.567523] rockchip-drm display-subsystem: bound fdea0000.hdmi =
(ops rockchip_drm_fini [rockchipdrm])
> [    2.567882] [drm] Initialized rockchip 1.0.0 for display-subsystem =
on minor 1
> [    2.740995] rockchip-drm display-subsystem: [drm] fb0: =
rockchipdrmfb frame buffer device
>=20
>> Is it possible to provide me url with kernel package you are using =
(wich works ok for you)?
>=20
> I'm working on 6.14-rc2 now and this patch is included in this armbian =
pr:
> https://github.com/armbian/build/pull/7835
>=20
> And here is the kernel deb I built, which is confirmed working:
> =
https://cdn.haguro.top/share/kernel-rockchip64-edge_6.14-rc2-rock5itx-hdmi=
1_arm64.tar
>=20

many thx for providing me .deb
this is very helpful!

I manually installed it on my sd card and sill getting:

root@myth-frontend-56b0f018b5e0:~ # uname -a
Linux myth-frontend-56b0f018b5e0 6.14.0-rc2-edge-rockchip64 #4 SMP =
PREEMPT Mon Feb 10 04:45:03 CST 2025 aarch64 GNU/Linux
root@myth-frontend-56b0f018b5e0:~ # dmesg | grep drm
[    6.996022] panthor fb000000.gpu: [drm] clock rate =3D 198000000
[    7.002431] panthor fb000000.gpu: [drm] mali-g610 id 0xa867 major 0x0 =
minor 0x0 status 0x5
[    7.003155] panthor fb000000.gpu: [drm] Features: L2:0x7120306 =
Tiler:0x809 Mem:0x301 MMU:0x2830 AS:0xff
[    7.003972] panthor fb000000.gpu: [drm] shader_present=3D0x50005 =
l2_present=3D0x1 tiler_present=3D0x1
[    7.185792] panthor fb000000.gpu: [drm] Firmware protected mode entry =
not be supported, ignoring
[    7.186635] panthor fb000000.gpu: [drm] Firmware git sha: =
814b47b551159067b67a37c4e9adda458ad9d852
[    7.187616] panthor fb000000.gpu: [drm] CSF FW using interface =
v1.1.0, Features 0x0 Instrumentation features 0x71
[    7.188861] [drm] Initialized panthor 1.3.0 for fb000000.gpu on minor =
0
[    7.225079] rockchip-drm display-subsystem: bound fdd90000.vop (ops =
vop2_component_ops [rockchipdrm])
[    7.227485] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops =
dw_hdmi_qp_rockchip_ops [rockchipdrm])
[    7.228666] [drm] Initialized rockchip 1.0.0 for display-subsystem on =
minor 1
[    7.229327] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
[    7.230466] rockchip-drm display-subsystem: [drm] Cannot find any =
crtc or sizes
root@myth-frontend-56b0f018b5e0:~ #

but why roobi os works ok on hdmi1 on this board?

btw: looking on dri debug i see following:

root@myth-frontend-56b0f018b5e0:~ # cat /sys/kernel/debug/dri/1/state
plane[32]: Cluster0-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D0
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[38]: Cluster1-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D1
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[44]: Cluster2-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D2
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[50]: Cluster3-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D3
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[56]: Esmart0-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D4
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[62]: Esmart1-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D5
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[68]: Esmart2-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D6
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
plane[74]: Esmart3-win0
        crtc=3D(null)
        fb=3D0
        crtc-pos=3D0x0+0+0
        src-pos=3D0.000000x0.000000+0.000000+0.000000
        rotation=3D1
        normalized-zpos=3D7
        color-encoding=3DITU-R BT.601 YCbCr
        color-range=3DYCbCr limited range
        color_mgmt_changed=3D0
crtc[80]: video_port1
        enable=3D0
        active=3D0
        self_refresh_active=3D0
        planes_changed=3D0
        mode_changed=3D0
        active_changed=3D0
        connectors_changed=3D0
        color_mgmt_changed=3D0
        plane_mask=3D0
        connector_mask=3D0
        encoder_mask=3D0
        mode: "": 0 0 0 0 0 0 0 0 0 0 0x0 0x0
connector[82]: HDMI-A-1
        crtc=3D(null)
        self_refresh_aware=3D0
        interlace_allowed=3D0
        ycbcr_420_allowed=3D0
        max_requested_bpc=3D8
        colorspace=3DDefault
        broadcast_rgb=3DAutomatic
        is_limited_range=3Dn
        output_bpc=3D0
        output_format=3DRGB
        tmds_char_rate=3D0
root@myth-frontend-56b0f018b5e0:~ #
 =20



