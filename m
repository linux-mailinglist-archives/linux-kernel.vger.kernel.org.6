Return-Path: <linux-kernel+bounces-563136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCF0A6376A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A136A16B070
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D338B19DF4C;
	Sun, 16 Mar 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQhWoSIe"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7595E18A6A8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742158282; cv=none; b=a5VZrRvXS7tm4RibSa2txdx4pzohGD+BM8aTQgc7cYCSO0ZFqHxtbea9Kb4MRcPNnnT0Eol5G9jMp/B3+k6UejbZihI7jqqGPRhi16WV/HeEGCHfn8PocVzz6ZaGdZEO8szUHrkfI2LfPrFks0L4DobfD2xG0LJqyq3lDVU4z0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742158282; c=relaxed/simple;
	bh=sE/gYU7yS0Hms1LxtaEHS/kfTqOr+3eccVk50q8v/Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FurxsMX+0dDWWZUxSDoTpzIwsKB+XDRuk+1AKLyXc/EBM4gtGXvvv5oc18gj4piAkhss57g5icQHs+QWEP/jAqCXZPFLfkIzf8cP+hFfuQuJbECEv69JajokarJZJy+BK3iarjED/9UXYHjrDkKf/Sdhibbbopot+My4YDbMsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQhWoSIe; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fead015247so26589777b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 13:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742158279; x=1742763079; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11D4pPzLAX9lQnZzbCliu3sFwyUhHgj3Q88AGfEQt30=;
        b=EQhWoSIeWtpmpbTcXr9AY9CNY1Uui9ZPls70Xnfx5vcFfIMAASfEkK2xi11tu3dok4
         gwq7wn4c2LQMty/nu/OPg9ZIBJUPQkTXO2sudK9NE9hFBg5VdTiWaUoQfhoRUNiEjVrG
         Xz0sLSeCy8XyWi5Hgp8ezk6YDtC1CoLIYDqg9fbdoHW1riJy/UP9RA1uEx/a/H7SwqN5
         6EIO9H6QrOaKxQVvPJBjb5JcQzlAkVw9JVoxrFyn6oqagL6bdykecmMVCJbndMtlqw4p
         56YKtnyuOPzip/OPva5RHVX6WE/u0g3EextkJ96GuoP10qrnpNP8t+pzWEmsIhPPi/Us
         F81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742158279; x=1742763079;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11D4pPzLAX9lQnZzbCliu3sFwyUhHgj3Q88AGfEQt30=;
        b=a8Q3YIziyobDHgaqGghJx5dOJiy3nhCrCX2CpaTemnFLXsDvsCzxOr7vddV7EESH40
         3HOmpnxjPRPdDF1L8BYUvjyoXZ4iASM5Rd1WZOO5eWZfvRX3oObP7KtxHCcbUvCsqpmx
         sut8ngwyl5C9uWrz8XNWoyUoKharJirRORf1r34rHc7fzJSOkZPwHdVn4CmZGx6ZUb9k
         6Ra0GIu08aG8GdZFVhoS+oHrUSCNee5m0ABkwIFDYQp/6dpP+esS5NsM/IRgR36jdOYF
         VOqG4tCqTsHr2uIA6sNmT8126JPAWfowmO/e+eNg5DOsy5kczlR9Zefvqbd+JwiM+GXv
         uc8A==
X-Forwarded-Encrypted: i=1; AJvYcCXMp5XQNEhfuv53G1VGi+GaGfScv2iE3U524cNzMmY0No2BGDsStsW9ON4MXuwMG5W4NxqOaOY02gaXrgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDFcQkmjvoD0KlvuzHgIbUD6NR76EQ5BRkZ3QhyiUcJ9U96EH
	FiOViP6RhgzLJ4h+E0yDrkuzb+LNj0Qk43VnFB84WDeWB294zBKGFWjt4Dq6ygokDKNrWlrYB5K
	C68W4mGNJLDB7P/wh0oUpvV+g4wU=
X-Gm-Gg: ASbGncsiZUUj47Jph72IlnorSaJDDsSLQsVAcJL/pBXORspJbSJXnFUKibgYRhijeME
	HrOVBoIYRAxFUVCsSynBb7SYR/qxStWtLG2aeDQflDgbswsM4A9d05/qfGbOYSX/s1edV9dYMYa
	peujEBpWT+cnIbYYfTOLwvdbia
X-Google-Smtp-Source: AGHT+IG09/hi3MWmZ5hXI5cFNStCtCXVSwoKZTPmX0FpXqU/1r4YevvC42k15kjCrt+L/Qd4ciu27ip6+SLn6v+K42s=
X-Received: by 2002:a05:690c:3589:b0:6ef:6536:bb6f with SMTP id
 00721157ae682-6ff45ef8e68mr133675927b3.22.1742158279351; Sun, 16 Mar 2025
 13:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-19-jim.cromie@gmail.com>
 <1a0034df-292b-49f5-bc90-709bcd5af9a9@bootlin.com>
In-Reply-To: <1a0034df-292b-49f5-bc90-709bcd5af9a9@bootlin.com>
From: jim.cromie@gmail.com
Date: Sun, 16 Mar 2025 14:50:53 -0600
X-Gm-Features: AQ5f1JpRQbL7Kh3EhTVw1my5Ym8uTbp3MrpYCs-8HOghT6Dic3lqwx4ocejIakU
Message-ID: <CAJfuBxwwcXPuaievcJ6Hg0JhS2vraoTV8=r=rrh9X7XiM9tcNw@mail.gmail.com>
Subject: Re: [PATCH 18/63] dyndbg: add/use for_subvec() to reduce boilerplate
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:18=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 25/01/2025 =C3=A0 07:45, Jim Cromie a =C3=A9crit :
> > add for_subvec() macro to encapsulate a for-loop pattern thats used
> > repeatedly to iterate over a boxed.vector of N elements.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
>
> Hi Jim,
>
> Do you think it is possible to move this patch earlier in the series, so
> you can use it when introducing class_users.
>

Yup. :-)

> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> Thanks,
> Louis Chauvet
>
> > ---
> >   lib/dynamic_debug.c | 30 ++++++++++++++++++++++--------
> >   1 file changed, 22 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 6bca0c6727d4..08b6e4e7489f 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -158,20 +158,34 @@ static void vpr_info_dq(const struct ddebug_query=
 *query, const char *msg)
> >                 _dt->num_class_users);                                \
> >       })
> >
> > +/*
> > + * simplify a repeated for-loop pattern walking N steps in a T _vec
> > + * member inside a struct _box.  It expects int i and T *_sp to be
> > + * declared in the caller.
> > + * @_i:  caller provided counter.
> > + * @_sp: cursor into _vec, to examine each item.
> > + * @_box: ptr to a struct containing @_vec member
> > + * @_vec: name of a sub-struct member in _box, with array-ref and leng=
th
> > + */
> > +#define for_subvec(_i, _sp, _box, _vec)                               =
      \
> > +     for ((_i) =3D 0, (_sp) =3D (_box)->_vec;                         =
  \
> > +          (_i) < (_box)->num_##_vec;                                \
> > +          (_i)++, (_sp)++)
> > +
> >   static int ddebug_find_valid_class(struct ddebug_table const *dt, con=
st char *class_string)
> >   {
> >       struct ddebug_class_map *map;
> >       struct ddebug_class_user *cli;
> >       int i, idx;
> >
> > -     for (i =3D 0, map =3D dt->classes; i < dt->num_classes; i++, map+=
+) {
> > +     for_subvec(i, map, dt, classes) {
> >               idx =3D match_string(map->class_names, map->length, class=
_string);
> >               if (idx >=3D 0) {
> >                       vpr_dt_info(dt, "good-class: %s.%s ", map->mod_na=
me, class_string);
> >                       return idx + map->base;
> >               }
> >       }
> > -     for (i =3D 0, cli =3D dt->class_users; i < dt->num_class_users; i=
++, cli++) {
> > +     for_subvec(i, cli, dt, class_users) {
> >               idx =3D match_string(cli->map->class_names, cli->map->len=
gth, class_string);
> >               if (idx >=3D 0) {
> >                       vpr_dt_info(dt, "class-ref: %s -> %s.%s ",
> > @@ -1190,7 +1204,7 @@ static void ddebug_apply_params(const struct ddeb=
ug_class_map *cm, const char *m
> >       if (cm->mod) {
> >               vpr_cm_info(cm, "loaded classmap: %s", modnm);
> >               /* ifdef protects the cm->mod->kp deref */
> > -             for (i =3D 0, kp =3D cm->mod->kp; i < cm->mod->num_kp; i+=
+, kp++)
> > +             for_subvec(i, kp, cm->mod, kp)
> >                       ddebug_match_apply_kparam(kp, cm, modnm);
> >       }
> >   #endif
> > @@ -1212,7 +1226,7 @@ static void ddebug_attach_module_classes(struct d=
debug_table *dt,
> >       struct ddebug_class_map *cm;
> >       int i, nc =3D 0;
> >
> > -     for (i =3D 0, cm =3D di->classes; i < di->num_classes; i++, cm++)=
 {
> > +     for_subvec(i, cm, di, classes) {
> >               if (!strcmp(cm->mod_name, dt->mod_name)) {
> >                       vpr_cm_info(cm, "classes[%d]:", i);
> >                       if (!nc++)
> > @@ -1225,7 +1239,7 @@ static void ddebug_attach_module_classes(struct d=
debug_table *dt,
> >       vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
> >       dt->num_classes =3D nc;
> >
> > -     for (i =3D 0, cm =3D dt->classes; i < dt->num_classes; i++, cm++)
> > +     for_subvec(i, cm, dt, classes)
> >               ddebug_apply_params(cm, cm->mod_name);
> >   }
> >
> > @@ -1245,7 +1259,7 @@ static void ddebug_attach_user_module_classes(str=
uct ddebug_table *dt,
> >        * module's refs, save to dt.  For loadables, this is the
> >        * whole array.
> >        */
> > -     for (i =3D 0, cli =3D di->class_users; i < di->num_class_users; i=
++, cli++) {
> > +     for_subvec(i, cli, di, class_users) {
> >               if (WARN_ON_ONCE(!cli || !cli->map || !cli->mod_name))
> >                       continue;
> >               if (!strcmp(cli->mod_name, dt->mod_name)) {
> > @@ -1261,7 +1275,7 @@ static void ddebug_attach_user_module_classes(str=
uct ddebug_table *dt,
> >       dt->num_class_users =3D nc;
> >
> >       /* now iterate dt */
> > -     for (i =3D 0, cli =3D dt->class_users; i < dt->num_class_users; i=
++, cli++)
> > +     for_subvec(i, cli, di, class_users)
> >               ddebug_apply_params(cli->map, cli->mod_name);
> >
> >       vpr_dt_info(dt, "attach-client-module: ");
> > @@ -1299,7 +1313,7 @@ static int ddebug_add_module(struct _ddebug_info =
*di, const char *modname)
> >
> >       INIT_LIST_HEAD(&dt->link);
> >
> > -     for (i =3D 0, iter =3D di->descs; i < di->num_descs; i++, iter++)
> > +     for_subvec(i, iter, di, descs)
> >               if (iter->class_id !=3D _DPRINTK_CLASS_DFLT)
> >                       class_ct++;
> >
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

