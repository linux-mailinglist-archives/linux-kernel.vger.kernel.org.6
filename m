Return-Path: <linux-kernel+bounces-220278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B9F90DED5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724E91F24978
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC532178398;
	Tue, 18 Jun 2024 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEKSipCA"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3DE482DA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747997; cv=none; b=XcIokv4q22otBgd5h5So17k/06RILXaacQxKv9KKFleMTr4/+mXsx8EJN6KOBQ+wBwXH2SNirH4RIUIpXZvlKnrtS1S9dDKE6yEUhU7rZoVg23uHOwrWBJz+oAkYo7NF1IFTjwMzI5Uf0irgozTDd/vc3W/pwguOZIfZSmYbdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747997; c=relaxed/simple;
	bh=JK73WTanU+uICcBsYfTAjdJyoAp+DglgvXGOHJ+rsYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltDEvyPhY5mIFbi7K75nFmlJFvAIVR693BCOwpnWKWD0x7Vs1MuR4upT6Nin1jmlt91lr9Y5/zjX24e84own4sd5rDAWEwYRrxMwvJEBfWjeFU/zwTds9nwm85K7ACM5RFNh+6WKa+CamObAATI+bnoqh+qP8WbZBAfp70ObFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEKSipCA; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-70df213542bso1073808a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718747995; x=1719352795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EU04kyl3dHWSxH/GsSb9jqBAdB+bRNmG9gEcHnqB7Kc=;
        b=bEKSipCAu+Uh5Qbd5ojCZyNl/5AKgJVeMiLLIQdZI3dyMogU/2i474xKy2NPY9r3ZF
         d3MXAJYWwukqXBwrtDLRowR2UtgXOm0gZftUEsD5m7Nvr8A8uv/FJ54NEbqqLIdhB8zT
         JPa1NWVWJKdh+6USr9wrfOXDp+GzKNMlcJ5PdiaC9Bg86zXmkI/aokIYgGuhDGo7WqAq
         hlDix16KLQz9uJdW+j+lqm55n2UMkAoKDox1V2VTikioLBJCBnYOcfr8cIwlROnAZGEf
         X4wb7T7xuQI8OgRkIcVBz4UrN6UhtBlp24AjaSb2nZ9/y1EhyxVt69+TJRHLFGf8g5dF
         6VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718747995; x=1719352795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EU04kyl3dHWSxH/GsSb9jqBAdB+bRNmG9gEcHnqB7Kc=;
        b=XA/sP7+2tsD0aV3AfbxNiasEQgXTUsXUZ02MXqCvwRzFyiHqIcA3uz5nf16iSLDGD0
         1D3/UAxfXVhotwh+tum06U9YFyx5J23/YdByHu5O3Tu5EphMSoSTdUAeQ+JXQPr5fKOU
         ZcasApFMDQrlc1Asp0rBiAgjRIGz+RUbEVxjOs8mubBXmmwOrktNQnPVWJFkHd5LD9SX
         6bOU3k6RvaOojul+JLnLpTy2dYEAgTTnAGku6aToPgs55W7E/6fE602YxQIRBPhevSp+
         RswmKdj1utIcCdvhcSR3XmZDGGVt7FCHYWBmi/TYXKmcOCNdjmkVKUu8rnQkztDWc2Or
         M9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCV0EluW8LdHg2cYT3rZcIGTIMJCbw9IZLtRx5nEMUdLSS5b34ZWI8ebfz49qp355GOU1wmccNNFVJGSCeWDHBkWQ2X2goToH9ZiNR5a
X-Gm-Message-State: AOJu0YzLwizRc6faXKZECWmFg/WyEtZRgGWmv3VirggOg2icG85OKCo0
	OAr5IAZeddepFj2CE93SMdG8XakiNuskuY9QkSkoer+vkpRzXiOK+ayRNwBiOIsm6sGKf3HRler
	SWVJj1luXEN/UWaE2bDWNzRG2CEw=
X-Google-Smtp-Source: AGHT+IGUaN7fpnj3ApZQ62pMjYcLw04OWKvr2yhL4FC1FgiK4tzz22/Z/RNOhLM8SD08NUIzF7HXcASRVABBvHBJOJA=
X-Received: by 2002:a17:90a:d484:b0:2c2:c799:eb20 with SMTP id
 98e67ed59e1d1-2c7b5c982demr1066657a91.23.1718747994883; Tue, 18 Jun 2024
 14:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com> <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
In-Reply-To: <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Jun 2024 17:59:42 -0400
Message-ID: <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
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

On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
>
> On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@chro=
mium.org> wrote:
> > >
> > > Based on grepping through the source code this driver appears to be
> > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > time. Among other things, this means that if a panel is in use that i=
t
> > > won't be cleanly powered off at system shutdown time.
> > >
> > > The fact that we should call drm_atomic_helper_shutdown() in the case
> > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > instance overview" in drm_drv.c.
> > >
> > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > This commit is only compile-time tested.
> > >
> > > ...and further, I'd say that this patch is more of a plea for help
> > > than a patch I think is actually right. I'm _fairly_ certain that
> > > drm/amdgpu needs this call at shutdown time but the logic is a bit
> > > hard for me to follow. I'd appreciate if anyone who actually knows
> > > what this should look like could illuminate me, or perhaps even just
> > > post a patch themselves!
> >
> > I'm not sure this patch makes sense or not.  The driver doesn't really
> > do a formal tear down in its shutdown routine, it just quiesces the
> > hardware.  What are the actual requirements of the shutdown function?
> > In the past when we did a full driver tear down in shutdown, it
> > delayed the shutdown sequence and users complained.
>
> The "inspiration" for this patch is to handle panels properly.
> Specifically, panels often have several power/enable signals going to
> them and often have requirements that these signals are powered off in
> the proper order with the proper delays between them. While we can't
> always do so when the system crashes / reboots in an uncontrolled way,
> panel manufacturers / HW Engineers get upset if we don't power things
> off properly during an orderly shutdown/reboot. When panels are
> powered off badly it can cause garbage on the screen and, so I've been
> told, can even cause long term damage to the panels over time.
>
> In Linux, some panel drivers have tried to ensure a proper poweroff of
> the panel by handling the shutdown() call themselves. However, this is
> ugly and panel maintainers want panel drivers to stop doing it. We
> have removed the code doing this from most panels now [1]. Instead the
> assumption is that the DRM modeset drivers should be calling
> drm_atomic_helper_shutdown() which will make sure panels get an
> orderly shutdown.
>
> For a lot more details, see the cover letter [2] which then contains
> links to even more discussions about the topic.
>
> [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chromium.=
org
> [2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chromium.=
org

I don't think it's an issue.  We quiesce the hardware as if we were
about to suspend the system (e.g., S3).  For the display hardware we
call drm_atomic_helper_suspend() as part of that sequence.

Alex

