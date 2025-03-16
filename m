Return-Path: <linux-kernel+bounces-563141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D530A6377B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283327A511F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5916C69F;
	Sun, 16 Mar 2025 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2spLHgR"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482F161320
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742159300; cv=none; b=ZPbFLSkHFTJccJUFkyc3NRw5bh3YgBuTNWreUHiMY8SuuBCxZtSsC1NkiAsYiDdTP4v0PK6Y1LVbcmdXkWRd/4kjArKPK7FaR+FnzTvuiNNYEUYefTJUrKtbcHIE7PdCPxxFTzFEedAagQzvIg6cpDUyX35xW8C0ecrffA3QxiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742159300; c=relaxed/simple;
	bh=1uoZyaCsV6iGz5yLYlXREyjs52TQflk3Czcu/X8ptdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hx+SLMQJkPdjLWlge9akk8SkSD1YDLEPlx3ujIo4QkupBSosp+xboDSPiMAtCxkcBsmb22S0rgaX77nvqdwLZGLn1xrCHZyMEcOLmuEucTZu96a/pn+MF/UVhI9cgG6ZmBFZnPVWfpM38Il01N8K+V0CdEHOtAVPZrjI9YDtoxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2spLHgR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6fda22908d9so25441527b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742159297; x=1742764097; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8LVTXm8apFDWNBob0/3Y8MF8vabt+AVUTSggQKCHJA=;
        b=E2spLHgRcgIa00u2I6FabzPSRC1q3bZQj+i7Esuye7ahyI1HelinfAqDJVoc3yi2rE
         wH6p1zI60Ras7jlyE1HGGUdEIJIawEp4m6W8pwDDcx5M4lXrswSSK5wZUez45uqJ4dnV
         6YYHRxEGx6cpuFSj4U7obneWMuqrQd5qBa039l4fKOOO4mPRurzSJX1yHtFf6tGQNhWs
         ouCyVHe3Q09c89eWJoNt/iwTT2aJlPqBwFAF2cPHSrvjHc0jS9cSRcKi3GAYWfyZtCgm
         bKuQ9vmLNhslM09GS8rsjJIfNBdnpxf25ywXA3iGOcfHMPF14x88MPgoO94eKOHIfvoH
         pG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742159297; x=1742764097;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8LVTXm8apFDWNBob0/3Y8MF8vabt+AVUTSggQKCHJA=;
        b=dVvOjLVkOb+rtGlAPIVkSFxLPn++vklvzvjLM655zYBnrp3OgWUQ+GP+CS6LBZmLh+
         QhTKWefeNrSjPS/yJwXvI9W3gVtFLL6Bcxj+l7JmD+IYI713BZDWIEPOGbBbkXb9JEii
         KbqNBiId8nMq4s+a0fZ7Nr3VCigyBSegl5WMix2RBPvZYdcW4EVLwFrifxJfNZqQSh+L
         MaHumzh4LRj34NYaXbbiFQSBR79uAPcpfuQ9o0yLwxV75YzU+2vHzS1wpu5xBttx443x
         hMajnsqYYU3dOqRfYYQ7XmHwEDwU6zDu7/rQuS5poCaGHSHyRrIxvwNVVsJ93IRiEQSV
         gCmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoaKW+6NtbcnLDjieb4j+Tfjl2aPe3jiDRgJApUxX6CrsRQ3aT2hqZVwVkWFcZhbatPoKUVNQPSqXG5bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPpKlt+RYedNShmV07eQ7+8ZfLgwqnlbPGcA7Syxug99HdLHmx
	yiwP5BiBBV04x9CgLLiiIpmeeGqbEBGH6MhDTqCYK+MQLldO4b8lfm5GqNKGWtXN7YJuA2C96s9
	b9Pm9lmNbqEhRm0soOxiRSvVSc0I=
X-Gm-Gg: ASbGnctQlZTWCWp4IEvrAx6S/hqpXGq0XaJMUkcd//Oc2EsXZS8fY8NPsm1Al1eUdvx
	6IVv3h2HrCl9qyqqRZ5Eh+bTG3c5BoxF15JrgJeKU31WLsTE5qwkGlAk1gzKuwHXG9HKZIBoLYf
	2CUnCj0AJ9xLk7BSsrttuIcC5P
X-Google-Smtp-Source: AGHT+IFZXmb8McwnECxEGjMOi3vOH7PTm7p0Z3I8oSYu65mifRnIL1f1QazmVQ2D7VMf/UTBnDjrxjOX5/KYKXBbQ74=
X-Received: by 2002:a05:690c:7308:b0:6fd:44a5:5b68 with SMTP id
 00721157ae682-6ff460f44ecmr138482327b3.35.1742159297114; Sun, 16 Mar 2025
 14:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125064619.8305-1-jim.cromie@gmail.com> <20250125064619.8305-24-jim.cromie@gmail.com>
 <6234628f-4085-40ad-b521-4590db2cb5f5@bootlin.com>
In-Reply-To: <6234628f-4085-40ad-b521-4590db2cb5f5@bootlin.com>
From: jim.cromie@gmail.com
Date: Sun, 16 Mar 2025 15:07:51 -0600
X-Gm-Features: AQ5f1Jq_ALg0uSLYSl6DjhnMDW3WqAm38tBeiIZYEK2KAbe2YCDTg1pstyAzluQ
Message-ID: <CAJfuBxymeGJ7QtcoN+eO3CcN9+UmnuNBPf1CTAyXT6Brym02MQ@mail.gmail.com>
Subject: Re: [PATCH 23/63] dyndbg: fail modprobe on ddebug_class_range_overlap()
To: Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, 
	intel-gfx-trybot@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch, 
	tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com, 
	ville.syrjala@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Im dropping the fail-on-modprobe.

theres some unrelated test-mod touches I'll examine and separate if theyre =
good

On Tue, Feb 25, 2025 at 7:27=E2=80=AFAM Louis Chauvet <louis.chauvet@bootli=
n.com> wrote:
>
>
>
> Le 25/01/2025 =C3=A0 07:45, Jim Cromie a =C3=A9crit :
> > 1. All classes used by a module (declared DYNDBG_CLASSMAP_{DEFINE,USE}
> > by module code) must share 0..62 class-id space; ie their respective
> > base,+length reservations shouldn't overlap.  Overlaps would lead to
> > unintended changes in ddebug enablements.
> >
> > Detecting these class-id range overlaps at compile-time would be ideal
> > but is not obvious how; failing at modprobe at least insures that the
> > developer sees and fixes the conflict.
> >
> > ddebug_class_range_overlap() implements the range check, accumulating
> > the reserved-ids as it examines each class.  It probably should use
> > bitmaps.
> >
> > A previous commit reworked the modprobe callchain to allow failure,
> > now call ddebug_class_range_overlap() to check when classid conflicts
> > happen, and signal that failure.
> >
> > NB: this can only happen when a module defines+uses several classmaps,
> >
> > TBD: failing modprobe is kinda harsh, maybe warn and proceed ?
> >
> > test_dynamic_debug*.ko:
> >
> > If built with -DFORCE_CLASSID_CONFLICT_MODPROBE, the modules get 2 bad
> > DYNDBG_CLASS_DEFINE declarations, into parent and the _submod.  These
> > conflict with one of the good ones in the parent (D2_CORE..etc),
> > causing the modprobe(s) to fail.  TODO: do in submod only, since fail
> > of parent prevents submod from ever trying.
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> > ---
> >   lib/dynamic_debug.c      | 30 ++++++++++++++++++++++++------
> >   lib/test_dynamic_debug.c | 11 ++++++++++-
> >   2 files changed, 34 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 8afcd4111531..8e1e087e07c3 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1211,6 +1211,21 @@ static void ddebug_apply_params(const struct dde=
bug_class_map *cm, const char *m
> >       }
> >   }
> >
> > +static int ddebug_class_range_overlap(struct ddebug_class_map *cm,
> > +                                   u64 *reserved_ids)
> > +{
> > +     u64 range =3D (((1ULL << cm->length) - 1) << cm->base);
> > +
> > +     if (range & *reserved_ids) {
> > +             pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
> > +                    cm->base + cm->length - 1, cm->class_names[0],
> > +                    *reserved_ids);
> > +             return -EINVAL;
> > +     }
> > +     *reserved_ids |=3D range;
> > +     return 0;
> > +}
> > +
> >   /*
> >    * scan the named array: @_vec, ref'd from inside @_box, for the
> >    * start,len of the sub-array of elements matching on ->mod_name;
> > @@ -1242,9 +1257,11 @@ static int ddebug_module_apply_class_maps(struct=
 ddebug_table *dt,
> >       struct ddebug_class_map *cm;
> >       int i;
> >
> > -     for_subvec(i, cm, &dt->info, maps)
> > +     for_subvec(i, cm, &dt->info, maps) {
> > +             if (ddebug_class_range_overlap(cm, reserved_ids))
> > +                     return -EINVAL;
> >               ddebug_apply_params(cm, cm->mod_name);
> > -
> > +     }
> >       vpr_info("module:%s attached %d classmaps\n", dt->mod_name, dt->i=
nfo.maps.len);
> >       return 0;
> >   }
> > @@ -1255,10 +1272,11 @@ static int ddebug_module_apply_class_users(stru=
ct ddebug_table *dt,
> >       struct ddebug_class_user *cli;
> >       int i;
> >
> > -     /* now iterate dt */
> > -     for_subvec(i, cli, &dt->info, users)
> > +     for_subvec(i, cli, &dt->info, users) {
> > +             if (ddebug_class_range_overlap(cli->map, reserved_ids))
> > +                     return -EINVAL;
> >               ddebug_apply_params(cli->map, cli->mod_name);
> > -
> > +     }
> >       vpr_info("module:%s attached %d classmap uses\n", dt->mod_name, d=
t->info.users.len);
> >       return 0;
> >   }
> > @@ -1311,11 +1329,11 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di, const char *modname)
> >                       return rc;
> >               }
> >       }
> > +
> >       mutex_lock(&ddebug_lock);
> >       list_add_tail(&dt->link, &ddebug_tables);
> >       mutex_unlock(&ddebug_lock);
> >
> > -
>
> Hi Jim,
>
> Strange line issues, can you squash it with the correct patch?
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> Thanks,
>
> >       if (dt->info.users.len) {
> >               rc =3D ddebug_module_apply_class_users(dt, &reserved_ids)=
;
> >               if (rc)
> > diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
> > index b1555b0a2bb1..74b98adc4ed0 100644
> > --- a/lib/test_dynamic_debug.c
> > +++ b/lib/test_dynamic_debug.c
> > @@ -81,7 +81,7 @@ enum cat_disjoint_bits {
> >       D2_DRMRES };
> >
> >   /* numeric verbosity, V2 > V1 related */
> > -enum cat_level_num { V0 =3D 14, V1, V2, V3, V4, V5, V6, V7 };
> > +enum cat_level_num { V0 =3D 16, V1, V2, V3, V4, V5, V6, V7 };
> >
> >   /* recapitulate DRM's parent(drm.ko) <-- _submod(drivers,helpers) */
> >   #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
> > @@ -90,6 +90,7 @@ enum cat_level_num { V0 =3D 14, V1, V2, V3, V4, V5, V=
6, V7 };
> >    * classmaps on the client enums above, and then declares the PARAMS
> >    * ref'g the classmaps.  Each is exported.
> >    */
> > +
> >   DYNDBG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS=
,
> >                      D2_CORE,
> >                      "D2_CORE",
> > @@ -113,6 +114,14 @@ DYNDBG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYP=
E_LEVEL_NUM,
> >   DYNDBG_CLASSMAP_PARAM(disjoint_bits, p);
> >   DYNDBG_CLASSMAP_PARAM(level_num, p);
> >
> > +#ifdef FORCE_CLASSID_CONFLICT_MODPROBE
> > +/*
> > + * Enable with -Dflag on compile to test overlapping class-id range
> > + * detection.  This should break on modprobe.
> > + */
> > +DYNDBG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_COR=
E");
> > +#endif
> > +
> >   #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
> >
> >   /*
>
> --
> Louis Chauvet, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

