Return-Path: <linux-kernel+bounces-184891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DB38CAD81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D301C2211D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD8A6EB6E;
	Tue, 21 May 2024 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mpjwAs0c"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483DC57CB2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716291936; cv=none; b=gHhlhhmEdnsZaO6+f4nqg+OLsHXCevBex+ftgkhiiLJutlIyyYMF0nnX0dtSygDoms6g0nTkCf/nz1fwayTJK+uoN9gw0xdtuf4Eg7/xUzhCYAZ1kWpsr8HwqXgAKm0UctQD2wGg4jIdy+cfzk8It/hM+nSYmVHh5+kLu9d4m34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716291936; c=relaxed/simple;
	bh=WI+W2XMBjZIyfWvlk7MSYFGVtNnqzAUQKLonrzifA5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nq1e4uLuuZE+5yDdxWp6n6X399L/hgpqOenMFuF8KHEXGNqUR3jQAt2btUG7dTsKZThkRb7e8ZDfDRuo37XsukrQKwOX3NlkJRMd41sYw3rkY/Y7N6jjxSLzHpX1OR2fZCpc7aJBQRmwHDQxU5w6oDpi4AgPtZAnIJhZYn/emNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mpjwAs0c; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so4809937e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716291932; x=1716896732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8Qd+SRRVTsjkfzy+IjSnlZiFTGS0/2MNpa9Ko1nWh0=;
        b=mpjwAs0cZoWdkPExouzD2090ENGfKDvteewRLj0vQbmHqtE++cxQzWhA6KyRRx+JXs
         usMbU+zgCnnFKO5+YP/nOiizc3DzN5huOIzXWE7GAexVk1zfe1JYYyFerWUXeC/5ATbI
         KTztMtlyAXPg3lZuxOHMNT0nqTxC2l3r97ffI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716291932; x=1716896732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8Qd+SRRVTsjkfzy+IjSnlZiFTGS0/2MNpa9Ko1nWh0=;
        b=RamVpzSOmrBGhnNGSvSRpwm2E7GcuxJxGOed68u74nIp9bGzHrHASGeG15xtulPLcs
         +q5K2NC3+6ZbxHfT6NULeeLr+K7wPwPALolLn7WPmJ09lKLpe0OscP2InVcvRLnemV6l
         yS2OJ6/50dMBXVOY7iMS/adOuHUDbrJGxEbO0EN/oU3r57yPbXyaUCTYVx2PeIuWbyYz
         p6+1aFFiNjtDX24HhRYv/DvRAIQCKAdl11dibEX3ctWFwMPSG9rKgp4orr1bGtdsYPNI
         IgHmORovLOECLMafDYTCZf8DMK743AQGPeWLYNfUULND+Zg0yfJA1RlEcq5/IAhmNuhs
         f8yA==
X-Forwarded-Encrypted: i=1; AJvYcCW0JA+a0CZ1+cC2EG3OihDqh7FFt+FUeIZkU13Px/YREOq5mp1S0Fc+I/loKD71HqiwljlyafOWnEuNeQDgDIlVW9mnfm+vzx98BaRz
X-Gm-Message-State: AOJu0YzymefTivrpsKbWO3Af8LaT8SMqX8plmRNQ9B4XrDJz7OquzmXl
	t1Ca4LdrL2JhxrOf16rdlPlZaw+3OHrl+KtbuPvgD+dhgNs88RhVp0iTYvYKeFJC0fVs91l0pSW
	PIKr+MyM7O1yTV+j7lpEcNf4Qk0723P5dQWY=
X-Google-Smtp-Source: AGHT+IH3rKqy1XmZb5uBs/FFnL2Rny/bG0aGjPCEM48ItqeHRqIiuaFB6NqaDBz5DvvJi70o5T0c6/G8VykaKG9GU8A=
X-Received: by 2002:a19:2d4e:0:b0:51f:9a88:be2a with SMTP id
 2adb3069b0e04-52407cde448mr2310900e87.23.1716291932397; Tue, 21 May 2024
 04:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-6-jim.cromie@gmail.com>
In-Reply-To: <20240516174357.26755-6-jim.cromie@gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Tue, 21 May 2024 13:45:21 +0200
Message-ID: <CALwA+NahLwNXapUogMGvBX1LavVKMoipLwN7v1DdjtJzayEkNQ@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 05/33] dyndbg: replace classmap list with a vector
To: Jim Cromie <jim.cromie@gmail.com>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com> w=
rote:
>
> Classmaps are stored in an elf section/array, but are individually
> list-linked onto dyndbg's per-module ddebug_table for operation.
>
> This is unnecessary; even when ddebug_attach_classmap() is handling
> the builtin section (with classmaps for multiple builtin modules), its
> contents are ordered, so a module's possibly multiple classmaps will
> be consecutive in the section, and could be treated as a vector/block,
> since both start-addy and subrange length are in the ddebug_info arg.

Should it be start-addr instead of start-addy ?

>
> IOW, this treats classmaps similarly to _ddebugs, which are already
> kept as vector-refs (address+len).
>
> So this changes:
>
> struct ddebug_class_map drops list-head link.
>
> struct ddebug_table drops the list-head maps, and gets: classes &
> num_classes for the start-addy and num_classes, placed to improve

The same here. Should it be start-addr instead of start-addy ?

> struct packing.
>
> The loading: in ddebug_attach_module_classes(), replace the
> for-the-modname list-add loop, with a forloop that finds the module's

Please add space forloop -> for loop

> subrange (start,length) of matching classmaps within the possibly
> builtin classmaps vector, and saves those to the ddebug_table.
>
> The reading/using: change list-foreach loops in ddebug_class_name() &
> ddebug_find_valid_class() to walk the array from start to length.
>
> Also:
> Move #define __outvar up, above an added use in a fn-prototype.
> Simplify ddebug_attach_module_classes args, ref has both addy,len.

addy,len -> addr,len ?


>
> no functional changes
>
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/linux/dynamic_debug.h |  1 -
>  lib/dynamic_debug.c           | 61 ++++++++++++++++++-----------------
>  2 files changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.=
h
> index 5231aaf361c4..b53217e4b711 100644
> --- a/include/linux/dynamic_debug.h
> +++ b/include/linux/dynamic_debug.h
> @@ -83,7 +83,6 @@ enum class_map_type {
>  };
>
>  struct ddebug_class_map {
> -       struct list_head link;
>         struct module *mod;
>         const char *mod_name;   /* needed for builtins */
>         const char **class_names;
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index 152b04c05981..46e4cdd8e6be 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_class=
es[];
>  extern struct ddebug_class_map __stop___dyndbg_classes[];
>
>  struct ddebug_table {
> -       struct list_head link, maps;
> +       struct list_head link;
>         const char *mod_name;
> -       unsigned int num_ddebugs;
>         struct _ddebug *ddebugs;
> +       struct ddebug_class_map *classes;
> +       unsigned int num_ddebugs, num_classes;
>  };
>
>  struct ddebug_query {
> @@ -147,13 +148,15 @@ static void vpr_info_dq(const struct ddebug_query *=
query, const char *msg)
>                   query->first_lineno, query->last_lineno, query->class_s=
tring);
>  }
>
> +#define __outvar /* filled by callee */
>  static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_ta=
ble const *dt,
> -                                                         const char *cla=
ss_string, int *class_id)
> +                                                       const char *class=
_string,
> +                                                       __outvar int *cla=
ss_id)
>  {
>         struct ddebug_class_map *map;
> -       int idx;
> +       int i, idx;
>
> -       list_for_each_entry(map, &dt->maps, link) {
> +       for (map =3D dt->classes, i =3D 0; i < dt->num_classes; i++, map+=
+) {
>                 idx =3D match_string(map->class_names, map->length, class=
_string);
>                 if (idx >=3D 0) {
>                         *class_id =3D idx + map->base;
> @@ -164,7 +167,6 @@ static struct ddebug_class_map *ddebug_find_valid_cla=
ss(struct ddebug_table cons
>         return NULL;
>  }
>
> -#define __outvar /* filled by callee */
>  /*
>   * Search the tables for _ddebug's which match the given `query' and
>   * apply the `flags' and `mask' to them.  Returns number of matching
> @@ -1114,9 +1116,10 @@ static void *ddebug_proc_next(struct seq_file *m, =
void *p, loff_t *pos)
>
>  static const char *ddebug_class_name(struct ddebug_iter *iter, struct _d=
debug *dp)
>  {
> -       struct ddebug_class_map *map;
> +       struct ddebug_class_map *map =3D iter->table->classes;
> +       int i, nc =3D iter->table->num_classes;
>
> -       list_for_each_entry(map, &iter->table->maps, link)
> +       for (i =3D 0; i < nc; i++, map++)
>                 if (class_in_range(dp->class_id, map))
>                         return map->class_names[dp->class_id - map->base]=
;
>
> @@ -1200,30 +1203,31 @@ static const struct proc_ops proc_fops =3D {
>         .proc_write =3D ddebug_proc_write
>  };
>
> -static void ddebug_attach_module_classes(struct ddebug_table *dt,
> -                                        struct ddebug_class_map *classes=
,
> -                                        int num_classes)
> +static void ddebug_attach_module_classes(struct ddebug_table *dt, struct=
 _ddebug_info *di)
>  {
>         struct ddebug_class_map *cm;
> -       int i, j, ct =3D 0;
> +       int i, nc =3D 0;
>
> -       for (cm =3D classes, i =3D 0; i < num_classes; i++, cm++) {
> +       /*
> +        * Find this module's classmaps in a subrange/wholerange of
> +        * the builtin/modular classmap vector/section.  Save the start
> +        * and length of the subrange at its edges.
> +        */
> +       for (cm =3D di->classes, i =3D 0; i < di->num_classes; i++, cm++)=
 {
>
>                 if (!strcmp(cm->mod_name, dt->mod_name)) {
> -
> -                       v2pr_info("class[%d]: module:%s base:%d len:%d ty=
:%d\n", i,
> -                                 cm->mod_name, cm->base, cm->length, cm-=
>map_type);
> -
> -                       for (j =3D 0; j < cm->length; j++)
> -                               v3pr_info(" %d: %d %s\n", j + cm->base, j=
,
> -                                         cm->class_names[j]);
> -
> -                       list_add(&cm->link, &dt->maps);
> -                       ct++;
> +                       if (!nc) {
> +                               v2pr_info("start subrange, class[%d]: mod=
ule:%s base:%d len:%d ty:%d\n",
> +                                         i, cm->mod_name, cm->base, cm->=
length, cm->map_type);
> +                               dt->classes =3D cm;
> +                       }
> +                       nc++;
>                 }
>         }
> -       if (ct)
> -               vpr_info("module:%s attached %d classes\n", dt->mod_name,=
 ct);
> +       if (nc) {
> +               dt->num_classes =3D nc;
> +               vpr_info("module:%s attached %d classes\n", dt->mod_name,=
 nc);
> +       }
>  }
>
>  /*
> @@ -1256,10 +1260,9 @@ static int ddebug_add_module(struct _ddebug_info *=
di, const char *modname)
>         dt->num_ddebugs =3D di->num_descs;
>
>         INIT_LIST_HEAD(&dt->link);
> -       INIT_LIST_HEAD(&dt->maps);
>
>         if (di->classes && di->num_classes)
> -               ddebug_attach_module_classes(dt, di->classes, di->num_cla=
sses);
> +               ddebug_attach_module_classes(dt, di);
>
>         mutex_lock(&ddebug_lock);
>         list_add_tail(&dt->link, &ddebug_tables);
> @@ -1372,8 +1375,8 @@ static void ddebug_remove_all_tables(void)
>         mutex_lock(&ddebug_lock);
>         while (!list_empty(&ddebug_tables)) {
>                 struct ddebug_table *dt =3D list_entry(ddebug_tables.next=
,
> -                                                     struct ddebug_table=
,
> -                                                     link);
> +                                                    struct ddebug_table,
> +                                                    link);
>                 ddebug_table_free(dt);
>         }
>         mutex_unlock(&ddebug_lock);
> --
> 2.45.0
>

