Return-Path: <linux-kernel+bounces-221145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1934490EF73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 15:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928E91F22DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7814EC79;
	Wed, 19 Jun 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccMRLCaQ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB413DDAF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805206; cv=none; b=Fa/Zg6u9jRd39VGUVWUN7oDOfqoBMv24BfoQ10Su7vyjApjh7ScFpAYhT7NBuU8NUpKAwsQeAARHyf7pkBh+RwMemAyhWSIJoTVgoqhYDLHq3X0sFpMUEQPUP3uNGLH/Wo79zrJYyA4FtWf0Amn9MKDYmhE5lcGkQk/V8PtjcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805206; c=relaxed/simple;
	bh=wW93xxzTiTV5Ny3UiyzdXLUJcbS9Yx7Bk9mJDdLd7SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4DfKdub7umyY7Kjg3cmTA6oQ55aEXPTvve3sTmhnUxqBxlkee12xvAmKwDEPMikx0Xfc+1ED2mwr6JxsfV/IZwZeW22RIR89LH8Gs7iWe4Uo0WW0lr/SQqSxZdxAtAmrGzTjuarpBcjupH3JsjhAWx0GKFQNPLtBJCaFnbOaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccMRLCaQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7062c11d0d1so799550b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718805204; x=1719410004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raeXeI6lwsevNLvXbd1wYh1qsMJosT/xi6mC5/F+he0=;
        b=ccMRLCaQg5iZTExjBkK+c110xeSLi2fp/C5axm72FUfZl+GeKfOGRqs27Iw7h0DGQO
         6+AsaAWHnNygqT8mkl/PlouomASAQsE43/DaPAfzZGqOYuL3IgAJBnTtan+QgpLZLr0B
         vbmdgrpHuidGaJD0C1LxoRE+D6oPwFjaiYPgYw6IKmh5UOElbfFQmi7hqMKSpYOTBKlr
         cCDgiDz4uRV6v/u4eegu2yGNo/aeTutnG39YoR2+O/khbi8utC1Ri3P56zLd4IDJX297
         reILV6YrCg1g4y3tX9WVRzBpKV89CoFIb9J3km2y0uKSyWFh/lwInf2d7p8WGezgu2Lf
         5UIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805204; x=1719410004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raeXeI6lwsevNLvXbd1wYh1qsMJosT/xi6mC5/F+he0=;
        b=TL5c6cbzWEXlyycGzU5OV/MmpEmw43avWR+Et95VpoIewTbliyQibj8RbHfgEUyViw
         9x2+DZ52HEqnn43MopVGEablckiPISmJbwU7HlAEtgE3QHYcmAhCtT1GAeZEHV30pBLa
         jy5FVECNZmvjj5DUzkyLmJ9bdKlLAeLFtqKppVu50c37gywGeu6MlCt6OdzcvExmitNC
         S2Jt5jXyKPVY2MCarFBzpU4udRJv8d46KDlncCO1/s4QyO7XyeBq/NR0T94lX2NF2Izr
         Q4Bovqkq7mxP29oJTlFlskFor76aK7lU7cvrPYun9ycEMDSkmNszw3IhgMH/qScmM2Xc
         q49w==
X-Forwarded-Encrypted: i=1; AJvYcCURlIfT8BRCmTJ+7PjRP6++9+wQktMveqTWjIAmjK17geaAdanFK8R63HBZnRR5uo0AawbuVZyP6LV+0B3ufOttG5otBzxLLLS59rda
X-Gm-Message-State: AOJu0Yz5fMsIyz6WGodEajnrryGZHcuqJvXBoB9TgD+BK7FZBNkbwd6C
	EEzolKNPpvuHYxIGl5bAZ2bF/i0/AQXEP+BxIgfh0uEioUfPvorRMEFXVECHxMAxqD+bsM6g1/O
	2u/eMT1ICSTnFouf9G3tmDZ+zvFw=
X-Google-Smtp-Source: AGHT+IGfmLwqL/WkyQUnXfiuN9AiOOQ44qs6v6SXVcDXsEMS0iiTxBl8WlPuS7Nozytf9SFo6IkiWknJVQCz/uGDszY=
X-Received: by 2002:a05:6a20:9313:b0:1b8:5c3c:794f with SMTP id
 adf61e73a8af0-1bcbb3a0026mr2432960637.10.1718805203901; Wed, 19 Jun 2024
 06:53:23 -0700 (PDT)
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
 <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
 <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com> <CADnq5_OXUKj=bfK0NOAhOzmhYCSnQXbxHbwLOaBQ6wFX033Wgw@mail.gmail.com>
In-Reply-To: <CADnq5_OXUKj=bfK0NOAhOzmhYCSnQXbxHbwLOaBQ6wFX033Wgw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Jun 2024 09:53:12 -0400
Message-ID: <CADnq5_O1EGj-_xx7LuiXSVY7MSmfS7_1-hqShFk6Deu1wsBwOA@mail.gmail.com>
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

On Wed, Jun 19, 2024 at 9:50=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Jun 18, 2024 at 7:53=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Tue, Jun 18, 2024 at 3:00=E2=80=AFPM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders@chrom=
ium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > >
> > > > On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <diander=
s@chromium.org> wrote:
> > > > > >
> > > > > > Based on grepping through the source code this driver appears t=
o be
> > > > > > missing a call to drm_atomic_helper_shutdown() at system shutdo=
wn
> > > > > > time. Among other things, this means that if a panel is in use =
that it
> > > > > > won't be cleanly powered off at system shutdown time.
> > > > > >
> > > > > > The fact that we should call drm_atomic_helper_shutdown() in th=
e case
> > > > > > of OS shutdown/restart comes straight out of the kernel doc "dr=
iver
> > > > > > instance overview" in drm_drv.c.
> > > > > >
> > > > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > > > ---
> > > > > > This commit is only compile-time tested.
> > > > > >
> > > > > > ...and further, I'd say that this patch is more of a plea for h=
elp
> > > > > > than a patch I think is actually right. I'm _fairly_ certain th=
at
> > > > > > drm/amdgpu needs this call at shutdown time but the logic is a =
bit
> > > > > > hard for me to follow. I'd appreciate if anyone who actually kn=
ows
> > > > > > what this should look like could illuminate me, or perhaps even=
 just
> > > > > > post a patch themselves!
> > > > >
> > > > > I'm not sure this patch makes sense or not.  The driver doesn't r=
eally
> > > > > do a formal tear down in its shutdown routine, it just quiesces t=
he
> > > > > hardware.  What are the actual requirements of the shutdown funct=
ion?
> > > > > In the past when we did a full driver tear down in shutdown, it
> > > > > delayed the shutdown sequence and users complained.
> > > >
> > > > The "inspiration" for this patch is to handle panels properly.
> > > > Specifically, panels often have several power/enable signals going =
to
> > > > them and often have requirements that these signals are powered off=
 in
> > > > the proper order with the proper delays between them. While we can'=
t
> > > > always do so when the system crashes / reboots in an uncontrolled w=
ay,
> > > > panel manufacturers / HW Engineers get upset if we don't power thin=
gs
> > > > off properly during an orderly shutdown/reboot. When panels are
> > > > powered off badly it can cause garbage on the screen and, so I've b=
een
> > > > told, can even cause long term damage to the panels over time.
> > > >
> > > > In Linux, some panel drivers have tried to ensure a proper poweroff=
 of
> > > > the panel by handling the shutdown() call themselves. However, this=
 is
> > > > ugly and panel maintainers want panel drivers to stop doing it. We
> > > > have removed the code doing this from most panels now [1]. Instead =
the
> > > > assumption is that the DRM modeset drivers should be calling
> > > > drm_atomic_helper_shutdown() which will make sure panels get an
> > > > orderly shutdown.
> > > >
> > > > For a lot more details, see the cover letter [2] which then contain=
s
> > > > links to even more discussions about the topic.
> > > >
> > > > [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chr=
omium.org
> > > > [2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chr=
omium.org
> > >
> > > I don't think it's an issue.  We quiesce the hardware as if we were
> > > about to suspend the system (e.g., S3).  For the display hardware we
> > > call drm_atomic_helper_suspend() as part of that sequence.
> >
> > OK. It's no skin off my teeth and we can drop this patch if you're
> > convinced it's not needed. From the point of view of someone who has
> > no experience with this driver it seems weird to me that it would use
> > drm_atomic_helper_suspend() at shutdown time instead of the documented
> > drm_atomic_helper_shutdown(), but if it works for everyone then I'm
> > not gonna complain.
>
> I think the problem is that it is not clear exactly what the
> expectations are around the PCI shutdown callback.  The documentation
> says:
>
> "Hook into reboot_notifier_list (kernel/sys.c). Intended to stop any
> idling DMA operations. Useful for enabling wake-on-lan (NIC) or
> changing the power state of a device before reboot. e.g.
> drivers/net/e100.c."

Arguably, there is no requirement to even touch the display hardware
at all.  In theory you could just leave the display hardware as is in
the current state.  The system will either be rebooting or powering
down anyway.

Alex

>
> We tried a full driver teardown in the shutdown callback and it added
> a lot of latency that really wasn't needed since the system was just
> going into a reboot or power down.  The best middle ground was to just
> leverage our hw level suspend code to quiesce the hardware.  Adding
> complexity to call drm_atomic_helper_suspend() vs
> drm_atomic_helper_shutdown() doesn't seem worth it since the functions
> do pretty much the same thing (both call
> drm_atomic_helper_disable_all()).  Maybe it's better to update the
> documentation to recommend drm_atomic_helper_suspend() if drivers want
> to leverage their suspend code?
>
> Alex

