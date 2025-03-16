Return-Path: <linux-kernel+bounces-563140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DAA63778
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666DD16C71D
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99519DF4C;
	Sun, 16 Mar 2025 21:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBQ+b4sq"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC834A1D
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742159075; cv=none; b=oHs2Kdg0G4PWM6PxXcG2J+Uw0LQ/Gadb53F1jdmhHmHAcsLK3itHgdK69YtbhDZpDb+Ip+IAkaFXOD7jN8S0UN9lnNQ8dhiL1aOpImGuecROI+6nWEONv3xP6NuRS2VnYAtYAR8ftJ3UTRDOo6khWBpjOF68kIEds/uHkZHWZJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742159075; c=relaxed/simple;
	bh=oIvD7vuTyo+TsqATqIM4EPZr52RHJ2FI71/rALHfDGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PEqxdWZQnaeNfZAq5u9CPKaTcRdN7Ypik9WEST278UQu9VvjclwyWOGIUsWonwEjgbgUloaNBWZMxXdzbS/Y5K+zfxQybDnCAObrxmBljNad5FR4JvRMUe8TaHmYrjZ6+PWQ4/VOzR8AGiMDO+5ADiy7j2de68U8iQcTcAsZ0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBQ+b4sq; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e63c966fe37so2595722276.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742159073; x=1742763873; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md11oMIZiDywb0aY7tjjNzmPg1FQkiTZGW/PqfpLY2s=;
        b=CBQ+b4sqjL8Q0XIzUVkfYjLGeHL7HtAXGltmwJ8Zt28RbTjkI/ThR8o95OaHieTC2A
         NmQYSwNflFkPwFkgMqiP1TcswbV6N/GYsbqF4Gbjkh8OBrrNChMpyGPmYynmjWPsLJPU
         oE9D48/hpX9TwfyKxIETYLdyl+DjtdgABeGyzfdS2I+TDsV53cJjJ+OBbkEJn2MNY8EQ
         W7HFdEG3LDcUFNwxWVkGTMxHo0B7OLspW119c+8W52DCDmLeEBPnHwLuNW58rZ8CCqPj
         A8M4sC+fv3qILjDVg6Vg5a2sKM2nQSnoUy/p4tAJjy1w06ALWAzU6mBLj4h5NktS+T6w
         Q9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742159073; x=1742763873;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md11oMIZiDywb0aY7tjjNzmPg1FQkiTZGW/PqfpLY2s=;
        b=VuQFn3+438JvrzLld1bw15UOvJvF1Ry8zAXE7IHVTmWXdyYsKpGuuaibIkLydSrMaO
         8K+j7MNvG3ir64h9GdThnzInJsad5aB/1F/Uc6QCwGTywwuIXa8HjssdOkIpHQnvVdU1
         WN4i3jCzrdOgoS3bP2+i6PPNXh55Wi620x2Ir8gnPibWSgioqZP324Gnm1pmF4sOJxGt
         pRqEV6I456apxRzWnVY7/OQyWEV65kz2zdO+FucP4u+tzo3MhDX6AFWGrmF2wEeg+XqB
         FXNyLITydm8xOXYrv9tdaX7eDnom5M41fhEF3ZMWjinXBdZ8kSiGju13af6i70n7O+QE
         F9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUWk6JSjdnLB8B0Q3LFo6HliwGBs8S43MiSaehTZzar+GrSUhjf6hm4fV6qk0o9Fv5nOmlc2E79dRTUFwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YybXEELOpTvd/CZGb2IEOYLUbeg7nhWJBUQhDPq/69Q8/JarIK7
	NCL8XCJpQTcVuA5ClcgCr9SSWyZd3VnRob01TuWLAM0ZBcc6m+368DKw4dGzV0T2AmDctAeDAAW
	tVqbWHjYkTOnTg8ak33tyQPvLTmk=
X-Gm-Gg: ASbGncuAnAImhl4mvzb36uYRkBk1kA3IFfVJfc8PNMTt5p7fy023VW/vpbgedw6WlMe
	aY/DsfJcWW9gWGAKq4rzAJDKDMk85e3m/tmSyEIipOzLsLsoOqRmpnZTDhJHcMykKxtO7tOmYI/
	brc1UvGAY2aE4CjrklSq56B7UlR9W3j92Gt3c=
X-Google-Smtp-Source: AGHT+IH7NTlevocEsFCUsFAJkBJ8eedsf6LuBGDOgJsThKUoWmcfKtIOiaGA86wc6HMeYJIo6S6O4wjQS49carLMfdY=
X-Received: by 2002:a05:690c:7408:b0:6fe:bfb9:549c with SMTP id
 00721157ae682-6ff45eea8a2mr127867937b3.1.1742159073078; Sun, 16 Mar 2025
 14:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-22-jim.cromie@gmail.com>
 <497016b0-9e72-4374-a19b-967df8ed9b44@bootlin.com>
In-Reply-To: <497016b0-9e72-4374-a19b-967df8ed9b44@bootlin.com>
From: jim.cromie@gmail.com
Date: Sun, 16 Mar 2025 15:04:07 -0600
X-Gm-Features: AQ5f1JrQW-ChxEX-mDqp_TgiMFS1z1VACJr_say5FF-oBu6y4_4Lr7pMTHi9qhM
Message-ID: <CAJfuBxxGUk8KdyEuPUoVY3ftWNE8d6GEyG3me85xYetuysFGfQ@mail.gmail.com>
Subject: Re: [PATCH 21/63] dyndbg: allow ddebug_add_module to fail
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:26=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 25/01/2025 =C3=A0 07:45, Jim Cromie a =C3=A9crit :
> > To prep for failing modprobe on classid conflicts, upgrade the
> > call-chain around ddebug_add_module(), in 2 ways:
> >
> > 1. in ddebug_add_module() add local reserved_ids to accumulate
> > reservations, pass it by ref to ddebug_attach_{,user_}module_classes()
> > so they can examine the reservations as they work.
> >
> > 2. return int from both ddebug_attach_{,user_}module_classes(), up to
> > ddebug_add_module(), then to ddebug_module_notify().
> >
> > No conflicts are currently detected or returned.
> >
> > TBD: This is updated further by hoisting the reservation-check, which
> > obsoletes part of 2, creating churn, maybe squash it away.
>

this now done locally as
05b0eed12dcc dyndbg: hoist classmap-filter-by-modname up to ddebug_add_modu=
le
sha will change yet..

Though Ive dropped the fail-on-modprobe,
I didn't want to open up another failure mode

Some WARN or pr_error should suffice for now.


> Hi Jim,
>
> It could be very nice to squash when possible yes!
>
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> > ---
> >   lib/dynamic_debug.c | 40 +++++++++++++++++++++++++++++-----------
> >   1 file changed, 29 insertions(+), 11 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 16c9b752822b..0ef243e30663 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1216,8 +1216,9 @@ static void ddebug_apply_params(const struct ddeb=
ug_class_map *cm, const char *m
> >    * modular classmap vector/section.  Save the start and length of the
> >    * subrange at its edges.
> >    */
> > -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> > -                                      const struct _ddebug_info *di)
> > +static int ddebug_attach_module_classes(struct ddebug_table *dt,
> > +                                     const struct _ddebug_info *di,
> > +                                     u64 *reserved_ids)
> >   {
> >       struct ddebug_class_map *cm;
> >       int i, nc =3D 0;
> > @@ -1230,13 +1231,14 @@ static void ddebug_attach_module_classes(struct=
 ddebug_table *dt,
> >               }
> >       }
> >       if (!nc)
> > -             return;
> > +             return 0;
> >
> >       vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
> >       dt->info.maps.len =3D nc;
> >
> >       for_subvec(i, cm, &dt->info, maps)
> >               ddebug_apply_params(cm, cm->mod_name);
> > +     return 0;
> >   }
> >
> >   /*
> > @@ -1244,8 +1246,9 @@ static void ddebug_attach_module_classes(struct d=
debug_table *dt,
> >    * means a query against the dt/module, which means it must be on the
> >    * list to be seen by ddebug_change.
> >    */
> > -static void ddebug_attach_user_module_classes(struct ddebug_table *dt,
> > -                                           const struct _ddebug_info *=
di)
> > +static int ddebug_attach_user_module_classes(struct ddebug_table *dt,
> > +                                           const struct _ddebug_info *=
di,
> > +                                           u64 *reserved_ids)
> >   {
> >       struct ddebug_class_user *cli;
> >       int i, nc =3D 0;
> > @@ -1266,7 +1269,7 @@ static void ddebug_attach_user_module_classes(str=
uct ddebug_table *dt,
> >               }
> >       }
> >       if (!nc)
> > -             return;
> > +             return 0;
> >
> >       dt->info.users.len =3D nc;
> >
> > @@ -1275,6 +1278,7 @@ static void ddebug_attach_user_module_classes(str=
uct ddebug_table *dt,
> >               ddebug_apply_params(cli->map, cli->mod_name);
> >
> >       vpr_dt_info(dt, "attach-client-module: ");
> > +     return 0;
> >   }
> >
> >   /*
> > @@ -1284,6 +1288,8 @@ static void ddebug_attach_user_module_classes(str=
uct ddebug_table *dt,
> >   static int ddebug_add_module(struct _ddebug_info *di, const char *mod=
name)
> >   {
> >       struct ddebug_table *dt;
> > +     u64 reserved_ids =3D 0;
> > +     int rc;
> >
> >       if (!di->descs.len)
> >               return 0;
> > @@ -1306,16 +1312,23 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di, const char *modname)
> >
> >       INIT_LIST_HEAD(&dt->link);
> >
> > -     if (di->maps.len)
> > -             ddebug_attach_module_classes(dt, di);
> > -
> > +     if (di->maps.len) {
> > +             rc =3D ddebug_attach_module_classes(dt, di, &reserved_ids=
);
> > +             if (rc) {
> > +                     kfree(dt);
> > +                     return rc;
> > +             }
> > +     }
> >       mutex_lock(&ddebug_lock);
> >       list_add_tail(&dt->link, &ddebug_tables);
> >       mutex_unlock(&ddebug_lock);
> >
> > -     if (di->users.len)
> > -             ddebug_attach_user_module_classes(dt, di);
> >
> > +     if (di->users.len) {
> > +             rc =3D ddebug_attach_user_module_classes(dt, di, &reserve=
d_ids);
> > +             if (rc)
> > +                     return rc;
> > +     }
> >       vpr_info("%3u debug prints in module %s\n", di->descs.len, modnam=
e);
> >       return 0;
> >   }
> > @@ -1400,6 +1413,11 @@ static int ddebug_module_notify(struct notifier_=
block *self, unsigned long val,
> >       switch (val) {
> >       case MODULE_STATE_COMING:
> >               ret =3D ddebug_add_module(&mod->dyndbg_info, mod->name);
> > +             if (ret =3D=3D -EINVAL) {
> > +                     pr_err("conflicting dyndbg-classmap reservations\=
n");
> > +                     ddebug_remove_module(mod->name);
> > +                     break;
> > +             }
> >               if (ret)
> >                       WARN(1, "Failed to allocate memory: dyndbg may no=
t work properly.\n");
> >               break;
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

