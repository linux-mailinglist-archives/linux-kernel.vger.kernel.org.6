Return-Path: <linux-kernel+bounces-574546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C43DA6E69F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682DF3B055A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D641E5B86;
	Mon, 24 Mar 2025 22:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V70CCbKg"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528119049B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855655; cv=none; b=HJdAHtgcw+EDmmkot1OFaD7CtkQ8Khlx+itz6SRWiPcEoPO1ovoRBVSBkKoV6ErI2r5iS4dA44SZY7MpEcrZVdoWdvSWoJvuyHxPLm4F2BcsOykraO8kiqVOFB0i+JTo7gFAWGh8V4CIJJ2ZrQIyw2TgC+PJDA4Ux1WzOD/mj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855655; c=relaxed/simple;
	bh=MSiI9gbj1+VQ8HHv6o1IiagRsxeKIMVRm3uQp9xMflw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXnrBxnI3qkHgY/vMHFMTCfIJM2wIAVNBfqLRthSEVbALs/zFCI0bA5C6r6U2bbhnN0bgr/anHX369hYl6kwBTObRPwSlu7mU2D2ScqXyemulFCMlcdzW2/5f9cCXg8QnQpEhditraeV1dZ6GR+Tobel4funGtbTH4NQ/S95MNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V70CCbKg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff1e375a47so43588967b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855653; x=1743460453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXW9Ba0yg/9do6JW2lVD4twSPOAKnKfAxL8vF9iY1Ls=;
        b=V70CCbKglbvFgS+FIugCyhz+6kynpRsoMcaIEYwwrb5Iz4QVhObt+Z8sHMUnPjMGYO
         UAAzOwA+heeE1jwOcAE8En2tzOZMnCaufWM2e4WegFuRfVJW4SQYSR5rR81EpP+zJD6g
         vIdNaoEYFd2SKZSMpSPVERYL8CB6PVJPSWz99StlEJC/5AFIELnlZwNn/ppj3K1pIX7+
         cvlwnfj+Z2sSC1SYSo6ZEF1jPoOnyBgXUatGxwGE7Nx9Hb2j+SDmRbtdJcHoo5tI4dsh
         NC568U9yLjriG9vwrzdTB1sVLUTWTdvkRgyZcq1JFmyN1zIbKjqWECO5ouPkacbGkAjd
         r0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855653; x=1743460453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXW9Ba0yg/9do6JW2lVD4twSPOAKnKfAxL8vF9iY1Ls=;
        b=nlKmODg3hEEmWpKi+rZlPaPGJSgV6lZUn3hetXiaVe7NdoUVM9RqRfY48GWHMRTflB
         64mwlujBqDp7rMU11CYInXM/SNGWgQvOnxXyXOH2LbGekuKoiSDqmrYppSBWqqQ/e+Bs
         8Gl1s3RHKZUC24YKU4DRvcvgjhlWXF8pcMlfr6Njqik+dCReksCdqN875AZabCCAz/dJ
         VptqgQwwqMEPriVWF/jrHwt9bK6Mkhjtv2OjjiylOv44qdcAR/L0/H7DiKjf2H1MS44v
         D77OhzERFJCMNjnhIlUABzgwLDLG+6YaXdGsXotGbLxsDEW0UXQ96fBOh5H0lSYum/uT
         fbUQ==
X-Gm-Message-State: AOJu0Yzt70ET6wXXUmMMw5GOtTkHdQBoCoH0NcZuJecg83cwcI3dD8U6
	ZP8fRLfL1svvMnmrxHz5/xE2wn20wSiadtFbbzgXAZdksKqnU0z7pwn3PFqo+VslFUISkr8BZHE
	runDUVGmr9uhCkskmJlZk3ZiJnfA=
X-Gm-Gg: ASbGncv7LQaUmXehMkYE42LPkB58KyR/3CMu8pVroYqnEK0AZZxdtUcdsSr/TKuHYln
	3QXOOQViG88vtT+thC+ddw9dhD9cSGx+FH0lGwHdip1mS330QpYXlHlK8Pn7cIvGGVyLNlCk3Zo
	z6coUhKMV5t4wbYBzmUyPZyzrl
X-Google-Smtp-Source: AGHT+IEAuhP7vvdOzarCdW0VuBfIcbVdJSz9H/zF3pCHpb16IT3KDy1crvUqwy7lhsLsmzsfQLcR6jkkbkjhhuB8rXs=
X-Received: by 2002:a05:690c:6d0c:b0:700:a6a0:1e2e with SMTP id
 00721157ae682-700ba9ba6camr198985667b3.0.1742855652804; Mon, 24 Mar 2025
 15:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320185238.447458-1-jim.cromie@gmail.com> <20250320185238.447458-11-jim.cromie@gmail.com>
 <b1615fb9-4689-4121-a7d1-7e9c5d10282b@bootlin.com>
In-Reply-To: <b1615fb9-4689-4121-a7d1-7e9c5d10282b@bootlin.com>
From: jim.cromie@gmail.com
Date: Mon, 24 Mar 2025 16:33:46 -0600
X-Gm-Features: AQ5f1JqVlYB97GtfUO_TrCYVCq0ZeJs8JZLkz_f5qfP4oh5XPxHDfUpsv0ShhA8
Message-ID: <CAJfuBxxRDpHSBY=AAbyT-gFSiaCkAbFtKap4NQ7MyQZ1CyR7EQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/59] dyndbg: replace classmap list with a vector
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, intel-gfx-trybot@lists.freedesktop.org, 
	jbaron@akamai.com, gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:08=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 20/03/2025 =C3=A0 19:51, Jim Cromie a =C3=A9crit :

> Thanks for your explanation of __outvar! It makes sense. I never seen
> this pattern anywhere in the kernel, maybe a simple doc comment is
> enough to carry the information:


Im gonna pull it - Ive decided its misleading,
since it looks like it does something that it cant do.

a plain old comment would be enough, if its needed at all.
__outvar was at least brief ;-)

In fact I did, but in a later patch. cleaning now.



>         /**
>          * ddebug_find_valid_class - Find a valid class for a
>          * given string
>          * @dt: debug table to inspect
>          * @class_string: string to match on
>          * @class_id: output pointer for the class_id value
>          *
>          * Returns: Pointer to the ddebug_class_map instance, if found.
>          * @class_id will be set to the id of this class. If no class
>          * matching @class_string is found, returns NULL and class_id is
>          * set to -ENOENT.
>          */
>
> Or at maybe change the documentation of __outvar to be a bit more
> explicit about how it works (I had difficulties to understand because a
> lot of "magic macro" exist in the kernel and sometimes carry information
> to the compiler, but this one is always empty):
>
>         /**
>          * __outvar - Denotes that an argument is used as an output
>          * value
>          * This macro does nothing apart clarify  for the reader that
>          * the parameter will be filled by the callee
>          */
>
> With any of the modifications (feel free to reword them as you want):
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
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
> > @@ -1122,9 +1124,10 @@ static void *ddebug_proc_next(struct seq_file *m=
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
> > @@ -1208,30 +1211,31 @@ static const struct proc_ops proc_fops =3D {
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
> > @@ -1263,10 +1267,9 @@ static int ddebug_add_module(struct _ddebug_info=
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
> > @@ -1379,8 +1382,8 @@ static void ddebug_remove_all_tables(void)
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
>

