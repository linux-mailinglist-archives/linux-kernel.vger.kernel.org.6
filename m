Return-Path: <linux-kernel+bounces-220362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA8890E03A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAA4B21B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410317A92C;
	Tue, 18 Jun 2024 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oc27qbop"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667A11CA9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754808; cv=none; b=TmpngJTLeAJTMkS0BLz+L7sqhkjmsuaswZ67pkKEkcavt4CRLF4NVdV/1IqKPRgadk82NlEyuUU4D16eSNI9Jbrg320xDZ26FigjrAjM4xz30Hl8uHEUtBskW3HZx08KYm1IrHLMf7wU33LzR3p0WdfBvz79mFJmKYn4c09wEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754808; c=relaxed/simple;
	bh=YRHlZxjSB9epKg6EhesYExgtZHbS1Rn9uChDyqKpAvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1qTht6uYqvd9mT/Zi5VFM24+zZJ/NBlPJrBTsld77qxqvk/WAIZisGxdV16dcG2xLpbaOAe6ao3sCgWszFmGDnMESgFZvBCFXJUmN88tsZaYGRRyMW8GB5U8UVteEdTY49GpeFCbJ7KCCqfRwcPzqm2NT2mzXTAayNhpDpinww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oc27qbop; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-705b9a89e08so5249379b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718754803; x=1719359603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSMpbX3YjY+n1K6XdU7KZ18fAHLxIUowLHHewo9pUPw=;
        b=oc27qbopTRDIckl4hYc2qlHGnLNYmd4ZxYelcRJfmQE/jL7AY1H8OnxP3FaMkIuWr3
         W+EAkd8PxyPAs3wXJkwt7DeYrIaaIP9vHlM9o/tl8QYVJgZPjwc7iWeTWdZqozDlipTT
         5o91e/5aP4nZbSNQRiwk3jcU/f6B3Nztv0P1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718754803; x=1719359603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSMpbX3YjY+n1K6XdU7KZ18fAHLxIUowLHHewo9pUPw=;
        b=fJ0gf0JASUKU71R+JvTUPc2CXejFkTsIN4joFHYxN7683HYJR8vgfbPvHuzJQ9tK2V
         XKwk70CO9SrYMU3gyfc4wbDGVNRrlLLHyH19+9hice6TTuolj6rUiy5SnaC8XL7KJriJ
         znz1UV4KuQe16swn0Hf2u3NEpoxMjz/8ZlqXN2xElqUFOZdfq1yHx9zeO7WfKP9EQYB4
         SOjfx1tpxBrr8RMhoQhIdm8UV9SRUzI6dud1/VrV3Kqu6NMebmnebz4L21xLLJ2AqEJN
         xf5nilauQvZpmxGCQy0r9HYYJiXHqMXKo48nLTFft8Mp7bbftu/bNFJ7OpC/t1scRamU
         /yqg==
X-Forwarded-Encrypted: i=1; AJvYcCVc4kHeXv1odQVNlCxawb4PNV/0XfESWmGlMJuwoyTOltRb7nU0F000lFMLbAgxYfymsN5ZdPf7vdmaxSUCStQVQvhqZLh3O+P0nw0h
X-Gm-Message-State: AOJu0YwM7whwcLXHfnV/NBoITS1nKXLGQIeq7AiPIvKa41aoC+b3qds6
	29upHm5UYhCiKaPQpLzfhO0fPh16ECqRZYCMhK4yI+I7VPyaSr370wBOj0CSONMdyFrTUfo/oOY
	=
X-Google-Smtp-Source: AGHT+IFrxI6AYvBvO2qDlbfPrpfNFcorw5HsqNH/SKUa0sxFyksDSHXGtvbMYhU64RYpyOK6omCOKQ==
X-Received: by 2002:a05:6a20:4f8f:b0:1b1:d31d:c0c5 with SMTP id adf61e73a8af0-1bcbb5cd527mr999668637.37.1718754803049;
        Tue, 18 Jun 2024 16:53:23 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f868b83afesm84699775ad.156.2024.06.18.16.53.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 16:53:22 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f70ec6ff8bso83715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 16:53:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOCo3sKK9iBdxpqv309e07iPQmjY0j8Zyg0/gerHjpVuybQLlKHP6SnZOpWHSglq0OYndnnEVvMWHzq3Suayiis+tRKjio+SjZDg0W
X-Received: by 2002:a05:622a:14cc:b0:444:9ac8:7 with SMTP id
 d75a77b69052e-444a8e53305mr1522311cf.16.1718754781471; Tue, 18 Jun 2024
 16:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612222435.3188234-1-dianders@chromium.org>
 <20240612152752.v2.8.I27914059cc822b52db9bf72b4013b525b60e06fd@changeid>
 <CADnq5_PbqE0E2pP26mGD94cdc=tLZZsF10e7ZZWeC5AU-LS8vw@mail.gmail.com>
 <CAD=FV=XJAiVGFn_Tqs_JNo1fQKFys3m=hH9MwmMot93gkdg=Qw@mail.gmail.com> <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
In-Reply-To: <CADnq5_M+H_h1Me_O3u=R3q52PgYcCwwY9Mr8_R1eX0G7HvBp2w@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 18 Jun 2024 16:52:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
Message-ID: <CAD=FV=X=9PV+zbmd2S-TBBxq+yQZ2D+-cCHjFX-gm-f+DyXXiQ@mail.gmail.com>
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

On Tue, Jun 18, 2024 at 3:00=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Jun 18, 2024 at 5:40=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> >
> > On Mon, Jun 17, 2024 at 8:01=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Wed, Jun 12, 2024 at 6:37=E2=80=AFPM Douglas Anderson <dianders@ch=
romium.org> wrote:
> > > >
> > > > Based on grepping through the source code this driver appears to be
> > > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > > time. Among other things, this means that if a panel is in use that=
 it
> > > > won't be cleanly powered off at system shutdown time.
> > > >
> > > > The fact that we should call drm_atomic_helper_shutdown() in the ca=
se
> > > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > > instance overview" in drm_drv.c.
> > > >
> > > > Suggested-by: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > Cc: Xinhui Pan <Xinhui.Pan@amd.com>
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > > This commit is only compile-time tested.
> > > >
> > > > ...and further, I'd say that this patch is more of a plea for help
> > > > than a patch I think is actually right. I'm _fairly_ certain that
> > > > drm/amdgpu needs this call at shutdown time but the logic is a bit
> > > > hard for me to follow. I'd appreciate if anyone who actually knows
> > > > what this should look like could illuminate me, or perhaps even jus=
t
> > > > post a patch themselves!
> > >
> > > I'm not sure this patch makes sense or not.  The driver doesn't reall=
y
> > > do a formal tear down in its shutdown routine, it just quiesces the
> > > hardware.  What are the actual requirements of the shutdown function?
> > > In the past when we did a full driver tear down in shutdown, it
> > > delayed the shutdown sequence and users complained.
> >
> > The "inspiration" for this patch is to handle panels properly.
> > Specifically, panels often have several power/enable signals going to
> > them and often have requirements that these signals are powered off in
> > the proper order with the proper delays between them. While we can't
> > always do so when the system crashes / reboots in an uncontrolled way,
> > panel manufacturers / HW Engineers get upset if we don't power things
> > off properly during an orderly shutdown/reboot. When panels are
> > powered off badly it can cause garbage on the screen and, so I've been
> > told, can even cause long term damage to the panels over time.
> >
> > In Linux, some panel drivers have tried to ensure a proper poweroff of
> > the panel by handling the shutdown() call themselves. However, this is
> > ugly and panel maintainers want panel drivers to stop doing it. We
> > have removed the code doing this from most panels now [1]. Instead the
> > assumption is that the DRM modeset drivers should be calling
> > drm_atomic_helper_shutdown() which will make sure panels get an
> > orderly shutdown.
> >
> > For a lot more details, see the cover letter [2] which then contains
> > links to even more discussions about the topic.
> >
> > [1] https://lore.kernel.org/r/20240605002401.2848541-1-dianders@chromiu=
m.org
> > [2] https://lore.kernel.org/r/20240612222435.3188234-1-dianders@chromiu=
m.org
>
> I don't think it's an issue.  We quiesce the hardware as if we were
> about to suspend the system (e.g., S3).  For the display hardware we
> call drm_atomic_helper_suspend() as part of that sequence.

OK. It's no skin off my teeth and we can drop this patch if you're
convinced it's not needed. From the point of view of someone who has
no experience with this driver it seems weird to me that it would use
drm_atomic_helper_suspend() at shutdown time instead of the documented
drm_atomic_helper_shutdown(), but if it works for everyone then I'm
not gonna complain.

-Doug

