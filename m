Return-Path: <linux-kernel+bounces-563036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D54A635FC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 15:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C2D7A7B16
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 14:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471A5C603;
	Sun, 16 Mar 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hG71n7hH"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98958F4A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133907; cv=none; b=iVknsmNYpixWnhiT+oEbRINWG2Iz6/WVUXrDu3r5cOhhiCda2mRfteGh5TszJmVoUIJ9fOQaUmopqsN60uNnK9ejIvjnXruoWfKsu37P4SRiWNZ6urdkjlmOm13JBD/17dOpyfyKTnrFFpOHadxhNYx73t37m1+cGOBr8M51MuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133907; c=relaxed/simple;
	bh=BlUxoIMf+xKNQTYv7AL90BZz1MufnVS8V8pbVhXZR1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nrLIVzp9kpfMhZNnGC8+sETL02Io95lNAVYlULEvlz/vteCBKwuMwaQmrdolT8XQoFunrZLBBTPR1WrWcuy9ZpWA4IYzqsL2MHoO2HzrBBdn2P5eUb8txBNmehdhtKAPDh57C6IHRZJZpKi1wODESyM0KZboa4Yd4CGV9dcnuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hG71n7hH; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e60b75f87aaso2726599276.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742133905; x=1742738705; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDeTtb50k9P9LzzadEe61v2QwU9luKmDuJ/im9ef0So=;
        b=hG71n7hHOClUdNTUuFlD+TY047BUPhvDc6FMoouspcO+Nsc+aDvecgibk57hYBpyJL
         X4mfg6NdMOu8CsKyv9Mm3P6tFtwO7WhfL3w4ZWpdd+w6Yyz7XYLmdda2heT8bw5RLMqc
         afR9lIdf1CIjCgT4z+w37e/0aOpVXu3cmWtpVr5Y9DlMjEs0853P5n0YnbpUeX0eHa18
         mC4qp8hZGlAouc494l0I5TB54nztGUgMBGBbVnU/m1RTowD48AtDOStupRMJGGi6h278
         iminlDQOEH/ylukHQOU8OT7APGyJ2ZUdERy6UAz8+WHOi4ZqvxiINZ8COaaxM/t/NH3i
         edJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742133905; x=1742738705;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDeTtb50k9P9LzzadEe61v2QwU9luKmDuJ/im9ef0So=;
        b=d0gQ6PpdiTSl9Y2Qqru7/ZP5iRgA7dRxyLUbWuU/Y2rlAElZwmKrzP6ytUrneDT5PG
         LaLkInOQT7wePHQgbsU2TG0Xq7hhi2823Td2BWWC3noe4Jz6s9aPnRLuifWqUAlO1Tg8
         sAkCTPyRVM3kCRPKcShvHxuGvKIgLwl+LbgEetjcAZNv0mnc2ppN++3qNCmerQ0InKV0
         CjMDF3uE1DQEE4pQ31LFftF9CJDM+QcfLMUn0O6yLitpCJJK4JXsKysRWTBoY5uTdAnv
         Af5+EV7gLJ74TCt2a6R8qp8nlo0L+csiIxFiDCfovZDVGBddKrvmle58JdSM6EcaBfSQ
         PrNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7rhoTcO8UxsMALgL/gNQFOLwCw6ELcQzB7TpLmWmttpk31fQKI8GAcLOR6u+B26RPZxp/zxI8Vx+ZDek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqaqA9KOSArAWxsR3OPM9kRY+ZBxF26l6hlceA2DcZJPXyX9RQ
	OeRBvU1+9CHQtwz2iW+vnyLCsGGkpuaW8dYgIhAhG00ekhWS3FVeSwVD1igU+Fnyt/ZqpQ7IoU+
	ok9avaKmjmD8kp0O227mof+iJoac=
X-Gm-Gg: ASbGncuIvJyouNIdqa6LVNy45WZh+FGJHZ5B5iWafxNQM3DIz8WAydpaqv4yh+rpEFm
	T9tzpS1qH7mbUFUQbLDJ453KlAKGhl66xwQ/WGqe9bDtUaOmKYGe0k+5VWregcczqM6rpG2dvDB
	3zsaxKqF2lpAIxCedLiC+aLnzD
X-Google-Smtp-Source: AGHT+IEkq0dikkwQqGeY8g4W1TxCVsud54HevqibVi+N74RIzgXFQiUIQt5fFhsqwqaLI+C0E5rHPBZDIZmWrCBrDAM=
X-Received: by 2002:a05:690c:700d:b0:6fe:bff2:3a6d with SMTP id
 00721157ae682-6ff45f1564dmr119778087b3.1.1742133904715; Sun, 16 Mar 2025
 07:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-6-jim.cromie@gmail.com>
 <22989ed1-90a4-4acd-9ca0-00f65677ad4f@bootlin.com>
In-Reply-To: <22989ed1-90a4-4acd-9ca0-00f65677ad4f@bootlin.com>
From: jim.cromie@gmail.com
Date: Sun, 16 Mar 2025 08:04:38 -0600
X-Gm-Features: AQ5f1JrrEoFY2QvB7Q2c4QZCzcvKITkF-RuKV8wOT8kqpn_6ZcJ2YIMcZ80jx6o
Message-ID: <CAJfuBxyYGUpF+n1nHNUS-GtTU9ROi9vx_RQj6kOP1zSMHgM45Q@mail.gmail.com>
Subject: Re: [PATCH 05/63] dyndbg: replace classmap list with a vector
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 7:08=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 25/01/2025 =C4=85 07:45, Jim Cromie a =C3=A9crit :
> > Classmaps are stored in an elf section/array, but are individually
> > list-linked onto dyndbg's per-module ddebug_table for operation.
> >
> > This is unnecessary; even when ddebug_attach_classmap() is handling
> > the builtin section (with classmaps for multiple builtin modules), its
> > contents are ordered, so a module's possibly multiple classmaps will
> > be consecutive in the section, and could be treated as a vector/block,
> > since both start-address and subrange length are in the ddebug_info arg=
.
> >
> > IOW, this treats classmaps similarly to _ddebugs, which are already
> > kept as vector-refs (address+len).
> >
> > So this changes:
> >
> > struct ddebug_class_map drops list-head link.
> >
> > struct ddebug_table drops the list-head maps, and gets: classes &
> > num_classes for the start-address and num_classes, placed to improve
> > struct packing.
> >
> > The loading: in ddebug_attach_module_classes(), replace the
> > for-the-modname list-add loop, with a forloop that finds the module's
> > subrange (start,length) of matching classmaps within the possibly
> > builtin classmaps vector, and saves those to the ddebug_table.
> >
> > The reading/using: change list-foreach loops in ddebug_class_name() &
> > ddebug_find_valid_class() to walk the array from start to length.
> >
> > Also:
> > Move #define __outvar up, above an added use in a fn-prototype.
> > Simplify ddebug_attach_module_classes args, ref has both address & len.
> >
> > no functional changes
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >   include/linux/dynamic_debug.h |  1 -
> >   lib/dynamic_debug.c           | 61 ++++++++++++++++++----------------=
-
> >   2 files changed, 32 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index b9afc7731b7c..2b0057058ecf 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -83,7 +83,6 @@ enum class_map_type {
> >   };
> >
> >   struct ddebug_class_map {
> > -     struct list_head link;
> >       struct module *mod;
> >       const char *mod_name;   /* needed for builtins */
> >       const char **class_names;
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 55df35df093b..41cbaa96f83d 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_cla=
sses[];
> >   extern struct ddebug_class_map __stop___dyndbg_classes[];
> >
> >   struct ddebug_table {
> > -     struct list_head link, maps;
> > +     struct list_head link;
> >       const char *mod_name;
> > -     unsigned int num_ddebugs;
> >       struct _ddebug *ddebugs;
> > +     struct ddebug_class_map *classes;
> > +     unsigned int num_ddebugs, num_classes;
> >   };
> >
> >   struct ddebug_query {
> > @@ -147,13 +148,15 @@ static void vpr_info_dq(const struct ddebug_query=
 *query, const char *msg)
> >                 query->first_lineno, query->last_lineno, query->class_s=
tring);
> >   }
> >
> > +#define __outvar /* filled by callee */
>
> Hi Jim,
>
> What is the goal of this __outvar define? I can't find any other #define
> of it in the kernel.

its basically a comment, trying to be more important.

if its misleading or overwrought, I can yank it :-)

>
> >   static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug=
_table const *dt,
> > -                                                       const char *cla=
ss_string, int *class_id)
> > +                                                     const char *class=
_string,
> > +                                                     __outvar int *cla=
ss_id)
>
> The order between __outvar and int is not important? Here you have
> __outvar before int, but later [1] the __outvar is after int.
>


I intended no difference, I used it where I thought it communicated best
in each case, and since the macro is empty, it makes none.



> [1]:https://elixir.bootlin.com/linux/v6.14-rc3/source/lib/dynamic_debug.c=
#L183
>
> Thanks,
> Louis Chauvet
>
> >   {
> >       struct ddebug_class_map *map;
> > -     int idx;
> > +     int i, idx;
> >
> > -     list_for_each_entry(map, &dt->maps, link) {
> > +     for (map =3D dt->classes, i =3D 0; i < dt->num_classes; i++, map+=
+) {
> >               idx =3D match_string(map->class_names, map->length, class=
_string);
> >               if (idx >=3D 0) {
> >                       *class_id =3D idx + map->base;
> > @@ -164,7 +167,6 @@ static struct ddebug_class_map *ddebug_find_valid_c=
lass(struct ddebug_table cons
> >       return NULL;
> >   }
> >
> > -#define __outvar /* filled by callee */
> >   /*
> >    * Search the tables for _ddebug's which match the given `query' and
> >    * apply the `flags' and `mask' to them.  Returns number of matching
> > @@ -1114,9 +1116,10 @@ static void *ddebug_proc_next(struct seq_file *m=
, void *p, loff_t *pos)
> >
> >   static const char *ddebug_class_name(struct ddebug_iter *iter, struct=
 _ddebug *dp)
> >   {
> > -     struct ddebug_class_map *map;
> > +     struct ddebug_class_map *map =3D iter->table->classes;
> > +     int i, nc =3D iter->table->num_classes;
> >
> > -     list_for_each_entry(map, &iter->table->maps, link)
> > +     for (i =3D 0; i < nc; i++, map++)
> >               if (class_in_range(dp->class_id, map))
> >                       return map->class_names[dp->class_id - map->base]=
;
> >
> > @@ -1200,30 +1203,31 @@ static const struct proc_ops proc_fops =3D {
> >       .proc_write =3D ddebug_proc_write
> >   };
> >
> > -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> > -                                      struct ddebug_class_map *classes=
,
> > -                                      int num_classes)
> > +static void ddebug_attach_module_classes(struct ddebug_table *dt, stru=
ct _ddebug_info *di)
> >   {
> >       struct ddebug_class_map *cm;
> > -     int i, j, ct =3D 0;
> > +     int i, nc =3D 0;
> >
> > -     for (cm =3D classes, i =3D 0; i < num_classes; i++, cm++) {
> > +     /*
> > +      * Find this module's classmaps in a subrange/wholerange of
> > +      * the builtin/modular classmap vector/section.  Save the start
> > +      * and length of the subrange at its edges.
> > +      */
> > +     for (cm =3D di->classes, i =3D 0; i < di->num_classes; i++, cm++)=
 {
> >
> >               if (!strcmp(cm->mod_name, dt->mod_name)) {
> > -
> > -                     v2pr_info("class[%d]: module:%s base:%d len:%d ty=
:%d\n", i,
> > -                               cm->mod_name, cm->base, cm->length, cm-=
>map_type);
> > -
> > -                     for (j =3D 0; j < cm->length; j++)
> > -                             v3pr_info(" %d: %d %s\n", j + cm->base, j=
,
> > -                                       cm->class_names[j]);
> > -
> > -                     list_add(&cm->link, &dt->maps);
> > -                     ct++;
> > +                     if (!nc) {
> > +                             v2pr_info("start subrange, class[%d]: mod=
ule:%s base:%d len:%d ty:%d\n",
> > +                                       i, cm->mod_name, cm->base, cm->=
length, cm->map_type);
> > +                             dt->classes =3D cm;
> > +                     }
> > +                     nc++;
> >               }
> >       }
> > -     if (ct)
> > -             vpr_info("module:%s attached %d classes\n", dt->mod_name,=
 ct);
> > +     if (nc) {
> > +             dt->num_classes =3D nc;
> > +             vpr_info("module:%s attached %d classes\n", dt->mod_name,=
 nc);
> > +     }
> >   }
> >
> >   /*
> > @@ -1256,10 +1260,9 @@ static int ddebug_add_module(struct _ddebug_info=
 *di, const char *modname)
> >       dt->num_ddebugs =3D di->num_descs;
> >
> >       INIT_LIST_HEAD(&dt->link);
> > -     INIT_LIST_HEAD(&dt->maps);
> >
> >       if (di->classes && di->num_classes)
> > -             ddebug_attach_module_classes(dt, di->classes, di->num_cla=
sses);
> > +             ddebug_attach_module_classes(dt, di);
> >
> >       mutex_lock(&ddebug_lock);
> >       list_add_tail(&dt->link, &ddebug_tables);
> > @@ -1372,8 +1375,8 @@ static void ddebug_remove_all_tables(void)
> >       mutex_lock(&ddebug_lock);
> >       while (!list_empty(&ddebug_tables)) {
> >               struct ddebug_table *dt =3D list_entry(ddebug_tables.next=
,
> > -                                                   struct ddebug_table=
,
> > -                                                   link);
> > +                                                  struct ddebug_table,
> > +                                                  link);
> >               ddebug_table_free(dt);
> >       }
> >       mutex_unlock(&ddebug_lock);
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

