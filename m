Return-Path: <linux-kernel+bounces-220276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D82390DEC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5FB21C45
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3FB178378;
	Tue, 18 Jun 2024 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrB46g9Z"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE74178384
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718747778; cv=none; b=SHn5MjeKeI+4qIMYlfJt5xIs8ffy2g92s8Q7Sh6qaIt9yj91FVcjFXVgFl6FEfiYfHASPJh2vXnWILJp7dPbZUsl/oLBFb7kOS7i3MFRMxj/A78oIMGVbrxJO+RGlnkzsqO/HFvB33kYz7g68wvn99h0lRTwYnjDZwRzGlCD9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718747778; c=relaxed/simple;
	bh=smmYYos6NqVFRFPZ/Mdtn60WSUoCoErKhAymh6N2XoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7z5d2jsLVskvAuPT2tcTe70enNLTc8ehouqDXguw6qen23pVjW/AWVF3XIUuDNteSxoFBbdYc/tDWV6gJon+3eoBTteDKd6EgcLrll+fN7NIJn+BYOGlEXZJPdDXN650YRb+IVFYH/NZalfs2UaesYkZXkUm4MvSCsykSCS+qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GrB46g9Z; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d24724514eso3468426b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718747776; x=1719352576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ji2+efuOAd6wBtWA0zFIRf6hUgNxX8IdSNdDWlzGrZQ=;
        b=GrB46g9ZzCt+UBj8A2/g+1RHZJhmzUZcpdB8cKrTCywEt6T8SuadDHmsphHXGw4avr
         VDixJHf9tbqy8aoo5enL+g+YwL68CJWTbWSj70O+1dGGAYUGXy82RlDalANnMZpJOTki
         hvWuF46AwnYmpFN/O+otCG8OeYz9pHSeU7Pjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718747776; x=1719352576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ji2+efuOAd6wBtWA0zFIRf6hUgNxX8IdSNdDWlzGrZQ=;
        b=qzGm7JDZL3M3w3EmoO1Z9ZDeVWJmLHNEEmRI5bij50U7zi8VjFDVnHrP47AwCTyJQf
         QvBEuVqmbSmBOhvxHatB8S5fdRlLRyChyPw5mR9Gy5M8L/mpPsatbaj+d7wMtuuhoQa3
         +oPjIaqjbuJt001MhvdG6t95fkZSIMtuhWXcy1fS9a6OM+Zogm1yz8D8f4aNABY1tHaO
         avzFn54SK/vWfTBaEY2+eoyG2kUjdohhLmblnF/ZX+3j3k4+diMbY0bEwcPDqQ49VAqA
         Q3R6uCxyzFe4tPKTt2e/Ive3AdNE+JAI9EbBNzbxLoaWjFThYfENtUd7n/x5s5MBHYzK
         aaDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsGJkFR9iQWzvSivNlxp7sGwhJMEXuVqY3Ob7hVXP74GX/dFa77YtHH1g8UQSCnfD9kbe0dw1a1dy3sbelHRk1Rk0LND7qlpaMjLnH
X-Gm-Message-State: AOJu0YwPTGCUSyhtwMuE8NSbpo6LHota305fUNK98r6n7nBBrkg38ERd
	3k+2rK08DR2jexnvR9XFrbzjo9ZCE660PEPbML+5marNeQTwBAhdzvffX176ZBvpNGZTVBYtzS0
	=
X-Google-Smtp-Source: AGHT+IGqN+G5rG4Su+FUN367Zg++vMzJCbz/S5dZyy+str6UequcOxKN+sAwc0CNT5tSk+djpEMv6Q==
X-Received: by 2002:a05:6808:1592:b0:3d2:4edc:1ffd with SMTP id 5614622812f47-3d51b96c223mr1318603b6e.12.1718747774837;
        Tue, 18 Jun 2024 14:56:14 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-441ef4de0ecsm59967051cf.9.2024.06.18.14.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 14:56:14 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44056f72257so119551cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:56:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9RIomMx590YXxbPfpHDIjwBMJe33ABQzSA7EgUzChUZusXYGLWjxAVxmvFzxupMaQvEjPtkS4sKGYQwUnUsch8WRuKzxGHRP80pC+
X-Received: by 2002:ac8:5748:0:b0:441:630e:110a with SMTP id
 d75a77b69052e-444aa409525mr298631cf.17.1718746453359; Tue, 18 Jun 2024
 14:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid> <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
In-Reply-To: <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 14:34:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
Message-ID: <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] drm/amdgpu: Call drm_atomic_helper_shutdown() at
 shutdown time
To: Alex Deucher <alexdeucher@gmail.com>
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

Hi,


On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@chromi=
um.org> wrote:
> >
> > Based on grepping through the source code this driver appears to be
> > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > time. Among other things, this means that if a panel is in use that it
> > won't be cleanly powered off at system shutdown time.
> >
> > The fact that we should call drm_atomic_helper_shutdown() in the case
> > of OS shutdown/restart comes straight out of the kernel doc "driver
> > instance overview" in drm_drv.c.
> >
> > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > This commit is only compile-time tested.
> >
> > ...and further, I'd say that this patch is more of a plea for help
> > than a patch I think is actually right. I'm _fairly_ certain that
> > drm/amdgpu needs this call at shutdown time but the logic is a bit
> > hard for me to follow. I'd appreciate if anyone who actually knows
> > what this should look like could illuminate me, or perhaps even just
> > post a patch themselves!
>
> I'm not sure this patch makes sense or not.  The driver doesn't really
> do a formal tear down in its shutdown routine, it just quiesces the
> hardware.  What are the actual requirements of the shutdown function?
> In the past when we did a full driver tear down in shutdown, it
> delayed the shutdown sequence and users complained.

The "inspiration" for this patch is to handle panels properly.
Specifically, panels often have several power/enable signals going to
them and often have requirements that these signals are powered off in
the proper order with the proper delays between them. While we can't
always do so when the system crashes / reboots in an uncontrolled way,
panel manufacturers / HW Engineers get upset if we don't power things
off properly during an orderly shutdown/reboot. When panels are
powered off badly it can cause garbage on the screen and, so I've been
told, can even cause long term damage to the panels over time.

In Linux, some panel drivers have tried to ensure a proper poweroff of
the panel by handling the shutdown() call themselves. However, this is
ugly and panel maintainers want panel drivers to stop doing it. We
have removed the code doing this from most panels now [1]. Instead the
assumption is that the DRM modeset drivers should be calling
drm_atomic_helper_shutdown() which will make sure panels get an
orderly shutdown.

For a lot more details, see the cover letter [2] which then contains
links to even more discussions about the topic.

[1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chromium.or=
g
[2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chromium.or=
g

