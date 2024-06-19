Return-Path: <linux-kernel+bounces-221138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECBA90EF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAD71C20E7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3778714EC52;
	Wed, 19 Jun 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9H08w5J"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB36C13DDAF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805020; cv=none; b=TP3gxgQPC/11/pMvFUCJkggB2rlS1cSef/GVH7oL1kBtcU6pAilab9YSpEGf1zDvszdRenT+Zjoj/bgHdYUJ2ktjzUzPMkyHx6uG3Znkc7Mlk7qpYjZITRevhMaMNLUyYPtWQxR7EA9/H07UGIhX2C0k71QFYNREd+IR+NG6lgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805020; c=relaxed/simple;
	bh=217pORuOAd2sNk8WHvREoY/vJe9tUAWXYctgC/DdSRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uh+rwLJSJSgL1tkC9AlylIwh7g4D7hBVWunTZxDH24IO3ZxypcfUr8YjtU3mZ05Fc/5VKK0v+WgV3G/zbKv1Aucgzc/04G6VZ/GXdgx3rPyfzRHcAV8YemDx1Q1uqfS4PGNt3kYGKLDlkmGKmMBbQmqDx0F7SAbe3hnzu3qi3u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9H08w5J; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6bce380eb96so4537576a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718805018; x=1719409818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZTQnv09PBqGC+05GHEbv1DDrULxaj/6Q8hEp1369So=;
        b=L9H08w5JDQkc/Dl5G3FFBkmA8ZvXSo+cUF7ZCUQHdmFjrt9ursnegrpo4ZfX3SLc41
         X4FStpaISSlH6p9q3bWjzCB77cfUa3DfIKYP4QpoifdoXMc8FU14FzKXJInjjJfQkfnS
         SvmEayJirTwwnbqOO5lIjEoKakVMtgpzljX26yFb0YJuJnER2sx3VJfoBMBYE8KiZHP8
         2+rOHPW33YGvw6W2gU8JCfaI60PJFQl1Bkrq8giSJExNgUj+4yu3sUDfRgAoAAm5AcIq
         5PxdKK+7ZKe8QPXHy70EZgUfPTN/bYukAMeFEjwUck6FNHwEgVYWH1TBjBUJ7JlAT5l5
         JqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805018; x=1719409818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZTQnv09PBqGC+05GHEbv1DDrULxaj/6Q8hEp1369So=;
        b=Pb4GZRXM6traiI++iEIFMTw6vn/++g1+jLGz//Ywib+2aTVWhPp+Z7WZFmrgoUF3k3
         YN4k1gsyF94iP+C6XiZR/0VQKykYbpEg1inT79uWseEIE9lJ9vtC5PTydO8K4Q4mFBke
         BxHyPG+30vj35bAHWB+WBCncXFsz1ACf65Muf3gb5PQb6cZkBG5sVdQBAbluYb6JncJu
         F2JUGJHEq/91suhF8jYZuz68JaBza/GsEG8/Pwva5qZh/LTGisxIittlGeLuzdYHcl+J
         1fF/dy9kgXZh4CxOCb4sz47PYxlcLJ/fikJrs70LhrARnl6LXZ0prlAMtmlfx1kMyRwm
         wmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUFUeq2NZNe3AsOrIzuWM/T7pFm2cFtgkA//pN6ypqKRov+Qze9TFbBvfhRS22r7ABxYNXV1Y8fSanchOp9rHChlvWTyZ54TpNzbRF
X-Gm-Message-State: AOJu0YzQD2Dh+J79C/zK+PcuGkvbk2jVXNNdR+HK51lWbXYvwySqARbY
	iw2SpWVkXe7cbDZAQoOJmXU5LKCmHCV3899P6vk78MVmVzVZ8f3PbCWZhTDkAnQeG9rXwbqFAgU
	J82EaeMb4ns5kM6/cXpOOTNlEFTg=
X-Google-Smtp-Source: AGHT+IG+EvjSwtHF5waL+ZwqlIuQEUJpqivfp1yeEtKYVKZW125eUYnfAcDvUfWdFV1Joj5SA9tawyCp/iqpv6kF8T0=
X-Received: by 2002:a17:90a:c70e:b0:2c3:1234:8bbb with SMTP id
 98e67ed59e1d1-2c7b5d7bfaamr2652814a91.38.1718805017816; Wed, 19 Jun 2024
 06:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
 <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
 <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com> <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
In-Reply-To: <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Jun 2024 09:50:05 -0400
Message-ID: <CADnq5_OXUKj=bfK0NOAhOzmhYCSnQXbxHbwLOaBQ6wFX033Wgw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Candice Li <candice.li@amd.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Hamza Mahfooz <hamza.mahfooz@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, 
	Lijo Lazar <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Shashank Sharma <shashank.sharma@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org, 
	chenxuebing <chenxb_99091@126.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 7:53=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Jun 18, 2024 at 3:00=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > >
> > > On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@=
chromium.org> wrote:
> > > > >
> > > > > Based on grepping through the source code this driver appears to =
be
> > > > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > > > time. Among other things, this means that if a panel is in use th=
at it
> > > > > won't be cleanly powered off at system shutdown time.
> > > > >
> > > > > The fact that we should call drm_atomic_helper_shutdown() in the =
case
> > > > > of OS shutdown/restart comes straight out of the kernel doc "driv=
er
> > > > > instance overview" in drm_drv.c.
> > > > >
> > > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > ---
> > > > > This commit is only compile-time tested.
> > > > >
> > > > > ...and further, I'd say that this patch is more of a plea for hel=
p
> > > > > than a patch I think is actually right. I'm _fairly_ certain that
> > > > > drm/amdgpu needs this call at shutdown time but the logic is a bi=
t
> > > > > hard for me to follow. I'd appreciate if anyone who actually know=
s
> > > > > what this should look like could illuminate me, or perhaps even j=
ust
> > > > > post a patch themselves!
> > > >
> > > > I'm not sure this patch makes sense or not.  The driver doesn't rea=
lly
> > > > do a formal tear down in its shutdown routine, it just quiesces the
> > > > hardware.  What are the actual requirements of the shutdown functio=
n?
> > > > In the past when we did a full driver tear down in shutdown, it
> > > > delayed the shutdown sequence and users complained.
> > >
> > > The "inspiration" for this patch is to handle panels properly.
> > > Specifically, panels often have several power/enable signals going to
> > > them and often have requirements that these signals are powered off i=
n
> > > the proper order with the proper delays between them. While we can't
> > > always do so when the system crashes / reboots in an uncontrolled way=
,
> > > panel manufacturers / HW Engineers get upset if we don't power things
> > > off properly during an orderly shutdown/reboot. When panels are
> > > powered off badly it can cause garbage on the screen and, so I've bee=
n
> > > told, can even cause long term damage to the panels over time.
> > >
> > > In Linux, some panel drivers have tried to ensure a proper poweroff o=
f
> > > the panel by handling the shutdown() call themselves. However, this i=
s
> > > ugly and panel maintainers want panel drivers to stop doing it. We
> > > have removed the code doing this from most panels now [1]. Instead th=
e
> > > assumption is that the DRM modeset drivers should be calling
> > > drm_atomic_helper_shutdown() which will make sure panels get an
> > > orderly shutdown.
> > >
> > > For a lot more details, see the cover letter [2] which then contains
> > > links to even more discussions about the topic.
> > >
> > > [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chrom=
ium.org
> > > [2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chrom=
ium.org
> >
> > I don't think it's an issue.  We quiesce the hardware as if we were
> > about to suspend the system (e.g., S3).  For the display hardware we
> > call drm_atomic_helper_suspend() as part of that sequence.
>
> OK. It's no skin off my teeth and we can drop this patch if you're
> convinced it's not needed. From the point of view of someone who has
> no experience with this driver it seems weird to me that it would use
> drm_atomic_helper_suspend() at shutdown time instead of the documented
> drm_atomic_helper_shutdown(), but if it works for everyone then I'm
> not gonna complain.

I think the problem is that it is not clear exactly what the
expectations are around the PCI shutdown callback.  The documentation
says:

"Hook into reboot_notifier_list (kernel/sys.c). Intended to stop any
idling DMA operations. Useful for enabling wake-on-lan (NIC) or
changing the power state of a device before reboot. e.g.
drivers/net/e100.c."

We tried a full driver teardown in the shutdown callback and it added
a lot of latency that really wasn't needed since the system was just
going into a reboot or power down.  The best middle ground was to just
leverage our hw level suspend code to quiesce the hardware.  Adding
complexity to call drm_atomic_helper_suspend() vs
drm_atomic_helper_shutdown() doesn't seem worth it since the functions
do pretty much the same thing (both call
drm_atomic_helper_disable_all()).  Maybe it's better to update the
documentation to recommend drm_atomic_helper_suspend() if drivers want
to leverage their suspend code?

Alex

