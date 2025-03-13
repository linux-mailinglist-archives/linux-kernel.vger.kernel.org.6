Return-Path: <linux-kernel+bounces-558696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FCBA5E990
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B633A850C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666597405A;
	Thu, 13 Mar 2025 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlM9vd7E"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01834C6C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741830616; cv=none; b=TR+wARHkV+hdShqtzhq86M134ybxBqkF7lbm1YJ1VFikuIZB9exn2LiU0jGJG2Uihz7MpuZOqQTW2F11Y4m9+0jglcSMq/pG5hjqdvcfVYy8+KwIfkbs3G+T5/GgkKexyLiR/I76NPpaMJtdJgKa0NKhTmd0bKPgbuZZLwkE3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741830616; c=relaxed/simple;
	bh=41AczRiNyc4mn1z+SuV//JXGz0lYt/dC7rUHxIupShE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2pfDc6vCvAMvW535ePVgNc2gcZcC1MCV2HGFve38k3DpekrmW/gUyhRdLYzhZ4Jdo2SgO5NZvI4vDhaK5Naxb4pYFuK7tKBMpGEFxBCl9fVrVc4wyajsc54g84b8pj8bTHuyTRDOXIMFubnIVt2WkKBtDHYcsK+vVrmMX2/a5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlM9vd7E; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so496574e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741830613; x=1742435413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rhnTdC4msVOGkRqdQCpgRtVWxEKnxMJbPpV2vd+gws=;
        b=BlM9vd7EzYygTFRBb/onUbcWoMxHW3hyCj3S/tLzRUsXsXRACw6r4ooHWRgiLjgXqi
         zyKoU3xggmD0FB2/gEF+mMFO+Eu3a6yDQQB1XKvLCWWJBzzIpeFaEO+VWBUfSuA0oxJZ
         306FhdE6Xzxdcv27Ciu3yZHU+XJHcHbWGeWy8RDcvGi2K/8TsBqBmLbaZFWCY+a1sGWY
         KFxdco0URfjmeG+kYWCQSCmbfKUN/6ph6kJ2rwWSDXSaCgAR2YsRluB1LZw6b4CPTYVM
         OBm+MjnncyHnibOweTvo6px1KaaeXK2+a2iA9jzMHKrHp8tkx6Oy3RauOLj+Ikp4Sj3M
         czlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741830613; x=1742435413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rhnTdC4msVOGkRqdQCpgRtVWxEKnxMJbPpV2vd+gws=;
        b=dIYPlKMrUa+N3SxfpX6WH+mIylMLkIDvseuj9ZaB9B3OMZuCN+a2ko9r1VcDFesLfs
         fQwm9mzLgtWWyvQEw2ylgSA+h67gzWSVuDznd1+8iv7YKTeNHX7oosZpcxFS/LDZcn4T
         XW+Oh6oEVpMpGx27ZRvDNdgOUMEOiRWne4jW+8KIMDc0bqMw/h5kFrdWX/JMkPU9gBIR
         /5OWTrkI0XdTq0bT+CcVMM79Cf0jUWlXgw+9GH+nYI+aJsO21+OyUsia82Nekb4ptKZy
         XZEt9/EMnxnPN+mq2B0xsqM7OkuhJ2AxGY8DTCH6Z426tL5CTl4HSEC6HhjrfIwuAOER
         oYFg==
X-Forwarded-Encrypted: i=1; AJvYcCXwvsXdP7VLnuFSbuBWXqCOXkrMvNMchDB/G4WUHXpWntTWXyy3okipeZrkdd9BHyd9LWBQkiVM9/iDEI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys89BAGjtJMhtaJDpLTr+caqJmLO8avHTc6KJL6zq2LhGOkyNs
	t6P3nOdnXnxnREE5ZLNb2llpTCjXD+P473R7AGdfUYxO8Q8jUA0WHOqmQnEl0GoTf6spN7UZB3r
	c5Jgco4B8tTSXJq4mLu96627L/8Ql41m1iiW/
X-Gm-Gg: ASbGncu59x1d3JsbPFNeHfqqDIcjpe8wguIScnI7xEy280DfBC41T3EJjtPP4pcbz6f
	EzUSVh/VUuKbU9zB5Rm7zwo+luiM6rV6TLHx5uCJjEB0HDblT8lzg0uHNT4Ys0i5t6OywiSpccv
	Ur/J13jaDCQxDh7HoR2jENnAOayTRPGc7jX3BXGyYitNoXQC0uvSrW
X-Google-Smtp-Source: AGHT+IFMUtlnzYcbytb8yU8Bu3i7ST+jbM6zWRM1rfI1C2MhEYrUzZr7z46qnooeSHU0twUyuT1E1JDN0et4biqdQUY=
X-Received: by 2002:a05:6512:1245:b0:545:5d:a5cd with SMTP id
 2adb3069b0e04-54990e2c073mr7803758e87.6.1741830612786; Wed, 12 Mar 2025
 18:50:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <CAJZ5v0grG7eSJ7_c73i9-bXaFhm5rfE2WmxtR6yLB-MGkd7sVg@mail.gmail.com>
 <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com>
In-Reply-To: <CAJZ5v0i42ZczVpDWQD4_OuduuHb3LDMmn0FJ9_XoqL8Frx9MEw@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 12 Mar 2025 18:49:36 -0700
X-Gm-Features: AQ5f1JpeqZsD8iihTHZ2xPjQCBSbgVweLRKkornpnC9Uki24vODyoMydcmMSRpM
Message-ID: <CAGETcx83c2bDROcNWOiL9Dry4k2BWVzftncObCAzdftHY0u_NQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ben Segall <bsegall@google.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:47=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Dec 4, 2024 at 1:53=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > Trim CC list.
> >
> > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@goo=
gle.com> wrote:
> > >
> > > Some devices might have their is_suspended flag set to false. In thes=
e
> > > cases, dpm_resume() should skip doing anything for those devices.
> >
> > Not really.  This is particularly untrue for devices with
> > power.direct_complete set that have power.is_suspended clear.
> >
> > > However, runtime PM enable and a few others steps are done before
> > > checking for this flag. Fix it so that we do things in the right orde=
r.
> >
> > I don't see the bug this is fixing, but I can see bugs introduced by it=
.
>
> So AFAICS the bug is in the error path when dpm_suspend() fails in
> which case some devices with direct_complete set may not have been
> handled by device_suspend().  Since runtime PM has not been disabled
> for those devices yet, it doesn't make sense to re-enable runtime PM
> for them (and if they had runtime PM disabled to start with, this will
> inadvertently enable runtime PM for them).
>
> However, two changes are needed to fix this issue:
> (1) power.is_suspended needs to be set for the devices with
> direct_complete set in device_suspend().
> (2) The power.is_suspended check needs to be moved after the
> power.syscore one in device_resume().
>
> The patch below only does (2) which is insufficient and it introduces
> a functional issue for the direct_complete devices with runtime PM
> disabled because it will cause runtime PM to remain disabled for them
> permanently.
>
> > I think that you want power.is_suspended to be checked before waiting
> > for the superiors.  Fair enough, since for devices with
> > power.is_suspended clear, there should be no superiors to wait for, so
> > the two checks can be done in any order and checking
> > power.is_suspended first would be less overhead.  And that's it
> > AFAICS.
> >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/power/main.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 4a67e83300e1..86e51b9fefab 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_=
message_t state, bool async)
> > >         if (dev->power.syscore)
> > >                 goto Complete;
> > >
> > > +       if (!dev->power.is_suspended)
> > > +               goto Unlock;
>
> And this should be "goto Complete" because jumping to Unlock
> introduces a device locking imbalance.
>
> > > +
> > >         if (dev->power.direct_complete) {
> > >                 /* Match the pm_runtime_disable() in __device_suspend=
(). */
> > >                 pm_runtime_enable(dev);
> > > @@ -931,9 +934,6 @@ static void device_resume(struct device *dev, pm_=
message_t state, bool async)
> > >          */
> > >         dev->power.is_prepared =3D false;
> > >
> > > -       if (!dev->power.is_suspended)
> > > -               goto Unlock;
> > > -
> > >         if (dev->pm_domain) {
> > >                 info =3D "power domain ";
> > >                 callback =3D pm_op(&dev->pm_domain->ops, state);
> > > --
>
> If you want to submit a new version of this patch, please do so by the
> end of the week or I will send my fix because I want this issue to be
> addressed in 6.15.

Please do ahead with the fix for this. I'm not too comfortable with
the direct_complete logic yet.

-Saravana

>
> BTW, please note that this is orthogonal to the recent async
> suspend-resume series
>
> https://lore.kernel.org/linux-pm/13709135.uLZWGnKmhe@rjwysocki.net/
>
> so there is no reason why it should be addressed in that series.

