Return-Path: <linux-kernel+bounces-353370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91087992CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2F31C22772
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8303A1D359A;
	Mon,  7 Oct 2024 13:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axvzQWTx"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F01D3573
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307056; cv=none; b=ait057RQbDZDINEkCYUVtv13q4HyPFvA30clNNKCflpA83vvCLvsTlLsUB2zp19CmWgXpeTsj0KMmNNvEFW/B0TawZyCyRbE7K1mbD9fUKu/d1VFtW3x4LUgMIvE46eHQd4kfB/YqjQGLTIW9HaZzxQz53JojOsDwLTqcqlKU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307056; c=relaxed/simple;
	bh=ddw8l3YCTAuLxv+jteyeIIS7bB7nKrgoAA+CJ9tHpXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEm0DVa/VbR04XZft+Zp0Ba6CujONtzbCiV+0la3cO58I3eUaY+c6LBOQRsHnkbrPRO4ZwsuD6YY9uTCQlq/ukKqghr87kq5QuSx4ogStyb9JahTjiiIbAfXS353datCkhhgTc+d3ioWXpV9NDqYWAYh0ssuwapDEeP1qaxM8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axvzQWTx; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7e9f0e91961so324932a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728307054; x=1728911854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UzKiiQL3EI3IDr1l8nY/KAW6iC7df0rzMYPbYqPhEfw=;
        b=axvzQWTxJRwcWfERsAliE2vL2x5UKEStkzl/b8qD3ethHay3wwvEKnSt09rl/RMNDp
         g8tP2mEDgAw/uFuU8iAk1Z3GRrrsD6f5XE1f49/5nsyhpVL6CwWCrxXSlDDXzs0vAjym
         QwWhq8ghaRdm8Up9tXsjui239u4fF07k5vYGrFT+5uB6b6oDiaCFJkpviZ/xRBC/8GuA
         G5h+r0t13EF5/LYExZTuU9YAEjNB4Hx2OgfOeZpFrTdY0ZS/M7O1tzwZ8VdqOqY8TLY1
         zRO3Piw3H/3tc3W39BsdVrP0znrSjeoqbdTJRyjVCk1kEguwpHKyC/oj5j5qxvkUpKwm
         0edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728307054; x=1728911854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UzKiiQL3EI3IDr1l8nY/KAW6iC7df0rzMYPbYqPhEfw=;
        b=N5PTQIYjcZ0z6KzG8Is3ZcKRr7Tn6KwytH53BXeV+nKiuz4d+hCI5TzgCtCQtINX79
         CZo1Pf+HIQDo0YOrQ7nPEevun5H8XADkecE6JHhHFFB7RQ8FAIPxliyP31uea44qC4eE
         4BZtwagSMXvRFFnX2eFaH/r9OSz3waeygXdI4v9bACT9Q9Mr7ftBvP4jZQI6XqU3JHsr
         G6XvlDT4nBROwgXIdGJbx6lPYMLKQIcUWYGsKi/6LR8ZzhbEtyX86rAYgK5FHjGMK2jU
         fqu/c2W16OVNE7nbs4HUrE2BD6LNVPSJUb6DhshOGrSFHr393WE16sIQpdghGBKSgtC1
         IvrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3ybhX8MkW16ERvwmb9hszLC+WRucXGhNAnHV1bFKvzgHwrVYdvvnh13TiEJJEOXsPGnBjPHnHQDabOIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/69t4vlYM0N9vbkEeQ35RAycCRVrbQ5cPjdzhbrjH8IZsyay
	Z8/AHP/XjxigI+v0zt6EAF039HuXzwqQDIOLeZ0d57+0/9Xbb4lr7BxiWopbs+7C8zfVJnYuku2
	/gAge+e1Dn30vSSY0M9LQYjO25ec=
X-Google-Smtp-Source: AGHT+IHxLqJ4yjEnteY4GLZxQXgFstmP9TCJO7FY4S0XvVp7wAzpcyXHsyNYeBqrDA9rqlZv30dQ0lfq1akuR5ulq1s=
X-Received: by 2002:a05:6a20:2591:b0:1cf:52f5:dc with SMTP id
 adf61e73a8af0-1d6dfa1e5bfmr8344894637.1.1728307054351; Mon, 07 Oct 2024
 06:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003060650.18454-1-wuhoipok@gmail.com> <d2704a2b-ceb2-4919-81d3-f6ff58a734fe@xenosoft.de>
 <c868e394-b1ad-4f30-b27b-c779e3458c42@csgroup.eu>
In-Reply-To: <c868e394-b1ad-4f30-b27b-c779e3458c42@csgroup.eu>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Oct 2024 09:17:21 -0400
Message-ID: <CADnq5_N8RgDKb=8Up8gnk2t=o5btFqhD0Y10qguyZxUzo2ysKA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: add late_register for connector
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, Wu Hoi Pok <wuhoipok@gmail.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>, 
	mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au, 
	Christian Zigotzky <info@xenosoft.de>, Darren Stevens <darren@stevens-zone.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a different issue related to the radeon ttm to gem conversion.
@Christian Koenig is working on the fix.

Alex

On Mon, Oct 7, 2024 at 4:23=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 06/10/2024 =C3=A0 18:56, Christian Zigotzky a =C3=A9crit :
> > On 03 October 2024 at 08:06 am, Wu Hoi Pok wrote:
> >> This is a fix patch not tested yet,
> >> for a bug I introduce in previous rework of radeon driver.
> >> The bug is a null dereference in 'aux.dev', which is the
> >> 'device' not registered, resulting in kernel panic. By having
> >> 'late_register', the connector should be registered after
> >> 'drm_dev_register' automatically.
> >>
> >> Please help testing thank you.
> > Hello Wu Hoi Pok,
> >
> > Thanks a lot for your patch. Unfortunately there is a new issue after
> > patching the RC1. Could you please fix the following issue?
> >
> > Thanks,
> > Christian
> >
> > ---
> >
> > Linux fienix 6.12.0-rc1-2-powerpc64-smp #1 SMP Fri Oct  4 08:55:45 CEST
> > 2024 ppc64 GNU/Linux
> >
> > [   29.167145] systemd[1]: Sent message type=3Dsignal sender=3Dn/a
> > destination=3Dn/a
> > path=3D/org/freedesktop/systemd1/unit/NetworkManager_2eservice
> > interface=3Dorg.freedesktop.DBus.Properties member=3DPropertiesChanged
> > cookie=3D103 reply_cookie=3D0 signature=3Dsa{sv}as error-name=3Dn/a
> > error-message=3Dn/a
> > [   29.542140] systemd-journald[1301]: Successfully sent stream file
> > descriptor to service manager.
> > [   29.561863] BUG: Kernel NULL pointer dereference on read at 0x000000=
00
> > [   29.567156] Faulting instruction address: 0xc000000000c973c0
> > [   29.571574] cpu 0x1: Vector: 300 (Data Access) at [c000000006f97640]
> > [   29.576637]     pc: c000000000c973c0: .drm_gem_object_free+0x20/0x70
> > [   29.581708]     lr: c000000000d28dd8: .radeon_bo_unref+0x58/0x90
> > [   29.586428]     sp: c000000006f978e0
> > [   29.588695]    msr: 9000000000009032
> > [   29.590962]    dar: 0
> > [   29.591925]  dsisr: 40000000
> > [   29.593496]   current =3D 0xc0000000085b1f00
> > [   29.596286]   paca    =3D 0xc00000003ffff680     irqmask: 0x03
> > irq_happened: 0x01
> > [   29.602119]     pid   =3D 1524, comm =3D Xorg.wrap
> > [   29.605257] Linux version 6.12.0-rc1-2-powerpc64-smp
> > (geeko@buildhost) (powerpc64-suse-linux-gcc (SUSE Linux) 7.5.0, GNU ld
> > (GNU Binutils; devel:gcc / SLE-15) 2.43.1.20240828-150300.536) #1 SMP
> > Fri Oct  4 08:55:45 CEST 2024
> > [   29.623892] enter ? for help
> > [   29.625487] [c000000006f97960] c000000000d28dd8
> > .radeon_bo_unref+0x58/0x90
> > [   29.631083] [c000000006f979e0] c000000000e287b0
> > .radeon_vm_fini+0x260/0x330
> > [   29.636765] [c000000006f97aa0] c000000000d07c94
> > .radeon_driver_postclose_kms+0x1a4/0x1f0
> > [   29.643579] [c000000006f97b30] c000000000c9374c
> > .drm_file_free+0x28c/0x300
> > [   29.649174] [c000000006f97be0] c000000000c93900 .drm_release+0x90/0x=
170
> > [   29.654508] [c000000006f97c70] c000000000304790 .__fput+0x120/0x3b0
> > [   29.659495] [c000000006f97d10] c0000000002fe0fc .__se_sys_close+0x4c=
/0xc0
> > [   29.665004] [c000000006f97d90] c000000000025bac
> > .system_call_exception+0x22c/0x260
> > [   29.671295] [c000000006f97e10] c00000000000b554
> > system_call_common+0xf4/0x258
> > [   29.677164] --- Exception: c00 (System Call) at 00000000006b2b48
> > [   29.681876] SP (fff4b3d0) is in userspace
> > [   29.684577] 1:mon>  <no input ...>
> > [   31.666727] Oops: Kernel access of bad area, sig: 11 [#1]
> > [   31.670829] BE PAGE_SIZE=3D4K MMU=3DHash SMP NR_CPUS=3D2 A-EON Amiga=
one X1000
> > [   31.676144] Modules linked in: snd_hda_codec_idt
> > snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel snd_intel_dspcfg
> > snd_hda_codec snd_hda_core dm_mod
> > [   31.688703] CPU: 1 UID: 0 PID: 1524 Comm: Xorg.wrap Not tainted
> > 6.12.0-rc1-2-powerpc64-smp #1
> > [   31.695932] Hardware name: pasemi,nemo PA6T 0x900102 A-EON Amigaone =
X1000
> > [   31.701417] NIP:  c000000000c973c0 LR: c000000000d28dd8 CTR:
> > c000000000d07af0
> > [   31.707250] REGS: c000000006f97640 TRAP: 0300   Not tainted
> > (6.12.0-rc1-2-powerpc64-smp)
> > [   31.714128] MSR:  9000000000009032 <SF,HV,EE,ME,IR,DR,RI> CR:
> > 28002222  XER: 20000000
> > [   31.720773] DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
> >                 GPR00: c000000000d28dd8 c000000006f978e0
> > c00000000207a800 c0000000085f5468
> >                 GPR04: 0000000000000b9b 0000000000000b9a
> > 0000000179779000 c0000000086a4b00
> >                 GPR08: 0000000000000000 0000000000000000
> > 0000000000000001 0000000000000000
> >                 GPR12: 0000000048002202 c00000003ffff680
> > 0000000000000000 0000000000000000
> >                 GPR16: 00000000006e3318 0000000000000001
> > 00000000006e289c 0000000000000063
> >                 GPR20: 00000000c04064a0 00000000007f0088
> > 00000000fff4c734 00000000007d165c
> >                 GPR24: 00000000007d1668 c000000024b6a220
> > c000000003588000 c000000024b6a200
> >                 GPR28: c000000003b3cc00 c000000024b6a248
> > c000000002d48820 c0000000085f5468
> > [   31.778903] NIP [c000000000c973c0] .drm_gem_object_free+0x20/0x70
> > [   31.783701] LR [c000000000d28dd8] .radeon_bo_unref+0x58/0x90
> > [   31.788062] Call Trace:
> > [   31.789199] [c000000006f978e0] [c000000006f97990] 0xc000000006f97990
> > (unreliable)
> > [   31.795388] [c000000006f97960] [c000000000d28dd8]
> > .radeon_bo_unref+0x58/0x90
> > [   31.801142] [c000000006f979e0] [c000000000e287b0]
> > .radeon_vm_fini+0x260/0x330
> > [   31.806982] [c000000006f97aa0] [c000000000d07c94]
> > .radeon_driver_postclose_kms+0x1a4/0x1f0
> > [   31.813954] [c000000006f97b30] [c000000000c9374c]
> > .drm_file_free+0x28c/0x300
> > [   31.819707] [c000000006f97be0] [c000000000c93900] .drm_release+0x90/=
0x170
> > [   31.825197] [c000000006f97c70] [c000000000304790] .__fput+0x120/0x3b=
0
> > [   31.830342] [c000000006f97d10] [c0000000002fe0fc]
> > .__se_sys_close+0x4c/0xc0
> > [   31.836010] [c000000006f97d90] [c000000000025bac]
> > .system_call_exception+0x22c/0x260
> > [   31.842460] [c000000006f97e10] [c00000000000b554]
> > system_call_common+0xf4/0x258
> > [   31.848476] --- interrupt: c00 at 0x6b2b48
> > [   31.851267] NIP:  00000000006b2b48 LR: 00000000006b2b20 CTR:
> > 0000000000000000
> > [   31.857101] REGS: c000000006f97e80 TRAP: 0c00   Not tainted
> > (6.12.0-rc1-2-powerpc64-smp)
> > [   31.863978] MSR:  100000000200f032 <HV,VEC,EE,PR,FP,ME,IR,DR,RI>  CR=
:
> > 28002400  XER: 00000000
> > [   31.871235] IRQMASK: 0
> >                 GPR00: 0000000000000006 00000000fff4b3d0
> > 00000000f7b7f3a0 0000000000000003
> >                 GPR04: 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000
> >                 GPR08: 0000000000000000 0000000000000000
> > 0000000000000000 0000000000000000
> >                 GPR12: 0000000000000000 00000000007efff4
> > 0000000000000000 0000000000000000
> >                 GPR16: 00000000006e3318 0000000000000001
> > 00000000006e289c 0000000000000063
> >                 GPR20: 00000000c04064a0 00000000007f0088
> > 00000000fff4c734 00000000007d165c
> >                 GPR24: 00000000007d1668 00000000fff4b400
> > 0000000000000001 0000000000000001
> >                 GPR28: 00000000fff4b46c 0000000000000000
> > 00000000007bfff4 0000000000000003
> > [   31.926053] NIP [00000000006b2b48] 0x6b2b48
> > [   31.928930] LR [00000000006b2b20] 0x6b2b20
> > [   31.931720] --- interrupt: c00
> > [   31.933466] Code: ebe1fff8 7c0803a6 4e800020 60000000 7c0802a6
> > fbe1fff8 7c7f1b78 f8010010 f821ff81 60000000 60000000 e93f0140
> > <e9290000> 7d2a0074 794ad182 0b0a0000
> > [   31.946913] ---[ end trace 0000000000000000 ]---
> >
> >
>
> That's a NULL pointer dereference in drm_gem_object_free().
>
> Trying to read obj->funcs->free while obj->funcs is NULL.
>
> Christophe

