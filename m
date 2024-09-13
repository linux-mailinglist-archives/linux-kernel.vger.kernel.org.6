Return-Path: <linux-kernel+bounces-328638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12DB9786C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2648B1C21634
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C846083A17;
	Fri, 13 Sep 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8eBjZa9"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D1B77F2F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248541; cv=none; b=iuEs7f05hWe5AWIndiv1ARehl/DBN/e7/c1KEvEnL7zQYddM1GdgZYXkOWFGMpgez5Ap+CTsZJb5E0TcZjiIB4ybkROHrRY/A/tz1yomSbec4cQm/mGP3fU2L2BV5+NnVO1FwEojjE3TwzDCK0jgBwgxR63/XWBIf5HEPKyVgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248541; c=relaxed/simple;
	bh=Dh2huT3jtyZY7aIpGjSTeQAfUC71P2va5TA5XWctJW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAF0ZI0gFxLdtTHdeti3drF9vPigGzZAWEXe4VPmRM1dIS5DKtqmMKV9CwfHwWjzIpcseq0RO2Z4uBAcdwUamwyOhztvdwv5I3TxFACG6rxZOJu3z812tC5bDfmsd3VEpP3hHP8ipy44GvtPGSz22jRw1WH9aK/QLz2I7ryqDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8eBjZa9; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39f4fed788bso4788815ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726248538; x=1726853338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxOXBnMiL21PBJM6uKoe7HLZ86EpzfC5VehNtOteI+g=;
        b=F8eBjZa91V7751+z4hEus1slKYr3gE1cf9QkczIGY7+GHSGLsxGcjbTo/sXRPEEqLX
         nNLYFuQTNdBQbMx9txnuLiAlqmCFOO0rOBtr7rG8Zlruz+U4tgJ1QtY4FuFo7YbH3hF6
         qJCV/xYJ5UOZ/TiGdrchE74yWQgNyPlaXiRugcb3qDg1QFIojhjkCEoUvdhPL+LxGXtx
         tLFBa8yMfYRGCuAYdLBi/oRtDkyMcT8wNK2uHk682T6o37sQS0pou0OUogpkxbqnNCWa
         qzQVO/w1S9K1BrgWUxGkiiMfXdQuUYxhSvLXNpzmtGq5czAYMlk7sS3zgNLjlRf/Al1m
         PVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726248538; x=1726853338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxOXBnMiL21PBJM6uKoe7HLZ86EpzfC5VehNtOteI+g=;
        b=XIe6/3UVZAUC0lo8PxAwHVK0pEwWulm8hNXEPUFtksH3Q2mRx8r9PfOe5FX+FeNdZm
         5QQcB1mBcHScwoGkDnts8bzVs0jzN5maGLCn+gxc5quanzTVJdbgXRoYYrflXTcdayxy
         nmnF0UNqYYdA0N/OrnuzGWO3sg0q4HFLJiwLSAIq921JH1jVIMpOya7z2zbPPvwKU2Ua
         d5WKFHT6Q2EFA2x3FwjT4g+RsFGCpCov27uNUNxRf09Ck9+uwnIvWiFnBHef2Ev7OWO4
         UZBkujMFiTXGgYnahbBMIQ1bEiBmuEjynxnng+8RVCiBF9+H87RIwuB85qi3WZ8ReqrZ
         x5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNDO3RkXcKf0EgdgtNFSw872llWUQsltWrVGTgX17Wm8YJ67eWtwcYWlfC5wWizu9b9NbuWiTjbmGTsXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvh5r71CH1LG5w2h9qKe5YnHogFvJ4irw19lUiFjYl1Cwm8KzO
	N34G+FxWg12EvEHloScE9XtiI5T/fWG0VqfVbbApISrYD8VMrjaJ1EYsg+99FV2UgvfcZdt9+ca
	9Bvz6Hv1PPKhWWpRQpi5W+sT3JTI=
X-Google-Smtp-Source: AGHT+IEKX2EIDXwhlSkFf4Al7/dq4lAUUmNHq96waCVvHxlWAdUIptNZ7AMZnQS7FMl3hYwUP2PcTwOAHigWf/TpBXo=
X-Received: by 2002:a92:c548:0:b0:3a0:8dcb:b033 with SMTP id
 e9e14a558f8ab-3a08dcbb224mr22846555ab.24.1726248538452; Fri, 13 Sep 2024
 10:28:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913165326.8856-1-robdclark@gmail.com> <fa243d3e-abe2-47d9-928f-70e24065baf1@mailbox.org>
In-Reply-To: <fa243d3e-abe2-47d9-928f-70e24065baf1@mailbox.org>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 13 Sep 2024 10:28:46 -0700
Message-ID: <CAF6AEGtFJu5DEuA+Urv7zdrsO-zV-y0o0wQnTdGojTNjwwRqNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sched: Fix dynamic job-flow control race
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, Rob Clark <robdclark@chromium.org>, 
	Asahi Lina <lina@asahilina.net>, Luben Tuikov <ltuikov89@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Danilo Krummrich <dakr@redhat.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 10:03=E2=80=AFAM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 2024-09-13 18:53, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Fixes a race condition reported here: https://github.com/AsahiLinux/lin=
ux/issues/309#issuecomment-2238968609
> >
> > The whole premise of lockless access to a single-producer-single-
> > consumer queue is that there is just a single producer and single
> > consumer.  That means we can't call drm_sched_can_queue() (which is
> > about queueing more work to the hw, not to the spsc queue) from
> > anywhere other than the consumer (wq).
> >
> > This call in the producer is just an optimization to avoid scheduling
> > the consuming worker if it cannot yet queue more work to the hw.  It
> > is safe to drop this optimization to avoid the race condition.
> >
> > Suggested-by: Asahi Lina <lina@asahilina.net>
> > Fixes: a78422e9dff3 ("drm/sched: implement dynamic job-flow control")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/scheduler/sched_main.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/s=
cheduler/sched_main.c
> > index ab53ab486fe6..1af1dbe757d5 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -1020,8 +1020,7 @@ EXPORT_SYMBOL(drm_sched_job_cleanup);
> >  void drm_sched_wakeup(struct drm_gpu_scheduler *sched,
> >                     struct drm_sched_entity *entity)
> >  {
> > -     if (drm_sched_can_queue(sched, entity))
> > -             drm_sched_run_job_queue(sched);
> > +     drm_sched_run_job_queue(sched);
> >  }
> >
> >  /**
>
> The entity parameter is unused now.

Right.. and we probably should collapse drm_sched_wakeup() and
drm_sched_run_job_queue()..

But this fix needs to be cherry picked back to a bunch of release
branches, so I intentionally avoided refactoring as part of the fix.

BR,
-R

>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast

