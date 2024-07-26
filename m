Return-Path: <linux-kernel+bounces-263362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263C093D4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85895B24799
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE714A96;
	Fri, 26 Jul 2024 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVL9VrFr"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A21B662
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722003178; cv=none; b=NYN2hB4QjK5zHNtoedDRbveSxlF3PFPKGWaVslGutKbznDAbsq+EcG/avyuBJjHBE/1DFmYz4nsWxz9X/Ee18twL64+nLRo+/yLGEvqGJAvASm4PRq2X/ayZJMMMiLdl53ENY3rx7hH5U8md04VyNnjLAYtWSxPbskN0bMHgn/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722003178; c=relaxed/simple;
	bh=QSNSllcFv3HO0J5eV42d7Ph5IopiYUQ8qnIg3cG2bV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcX+1nU4v6Mi7Dz2Wc7MqFcjerZObYVslST/A2dtMIes9o9utGkSfhn63gVO+lA6fJLdF0wT2KkSeh5RZebkM24t9lGIyFtRxK3AKrHECSEgq1T90tdvG2VN3UiDWREwcEJ2YuyrmMUZtxQZ3zqBcTeI+/TwL7O90sKyMurd32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVL9VrFr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso15703a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722003175; x=1722607975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QsYsv/ZNLS2uwAP6W4x6DqGmZNcJZ9nt2gTTMFgcvkc=;
        b=UVL9VrFrvLv3/dVna7gi54MKI35KSrjXNzAQhJju2RjXWlCVIj+jE/14ro8VW9cfCm
         bD5I1RR37737SYabsA7DAEzgpM7hKuquODVKL9dkCW86xMTvyEoMCxRBnGpEbiuyl0X/
         qKaPKa0NfXzgoHRByDp3+mr6hqao6pZY1d/mvYm3Y3byGjZ+th3EaaOsfBhr/kHDjxx1
         N96c5kLC1uxBEDMEDkZwv3Zu4fc93Cyh0FuYhG8J0xtfZV1cUOuqhndb2O9v6jRKa4Qq
         qm6PvB9w6Kj0Nxn5MpbZ5vlmR+KT2+ZxScv7A0Ooh90enoOHqdqWvwthQTqsaly6ttwL
         DYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722003175; x=1722607975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsYsv/ZNLS2uwAP6W4x6DqGmZNcJZ9nt2gTTMFgcvkc=;
        b=CH7JLCHczHV/C7JCLXzDKZbZyEBRpmyTMAXuIjCcMCnSj0EXsV1zB7ioiS6nuEtLDY
         l0H7kVcvcJ5HvSnXj6sqwiHOmFWVgneP2G8zRo/D5rxXeLgt7rDrdk8/CHuzM6w/zMAF
         p7QnNsit4hIpYN8s6HaSm2uxcnpnFc1q9YmEZ/ePP2HlmKSbckl+8zsbBnl/dYuENjXT
         EC4g1nxhoxjMz4RdFQkXYQTq912V0kkSJtCIBPsdJXisUiAb41xAUIQ0KzOIdR2GS2AM
         xiSfJ5b4y0pWzfxGXYrl0+teh4G+XSg4NCICmVIGX8JFGZPZ/xyodaoe3MqW5tl3ud2B
         q7EA==
X-Forwarded-Encrypted: i=1; AJvYcCUDLrDILhMC1S7/SBP+35FCU8wM85N7dbmcDOj1HmwM2AGQKG2eiqoSI+UjVFOghTYZqMDhWBZJG7GjVpRbUy24Qgb7/OFjbofT9g5w
X-Gm-Message-State: AOJu0YytltNXh7HmtFI2hMp+9w0syfSRB/7VD1tEeTWytb91qZUZnlni
	/KgSq430U/xf8DkFLq/D/na7yG8NtMZczF2UE2koaL7HuzYJOIBu+mFxrUfxfm+l64u9AQxLCCz
	atrhxudkEqN0+4kegIgsObDMRJi51HOENEYvj
X-Google-Smtp-Source: AGHT+IGQM+S7/Pvgl2FgYdhY/QyheJVe+2Xoiu0HnyHJ18V5CG9DOaEw2COqLsG8dtIutZKeCjes9PINpZtnTUadhKM=
X-Received: by 2002:a05:6402:524f:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5aed9392d97mr171742a12.4.1722003174333; Fri, 26 Jul 2024
 07:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-kasan-tsbrcu-v3-0-51c92f8f1101@google.com>
 <20240725-kasan-tsbrcu-v3-2-51c92f8f1101@google.com> <CA+fCnZc1ct_Dg7_Zw+2z-EOv_oC4occ-ru-o6-83XYQneBxpwA@mail.gmail.com>
In-Reply-To: <CA+fCnZc1ct_Dg7_Zw+2z-EOv_oC4occ-ru-o6-83XYQneBxpwA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Jul 2024 16:12:17 +0200
Message-ID: <CAG48ez3FES1ySuuv9VtDqCxEfw7xPqdvOd4oTEdQ25+1NvSAsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Marco Elver <elver@google.com>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:44=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.=
com> wrote:
> On Thu, Jul 25, 2024 at 5:32=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > Currently, KASAN is unable to catch use-after-free in SLAB_TYPESAFE_BY_=
RCU
> > slabs because use-after-free is allowed within the RCU grace period by
> > design.
> >
> > Add a SLUB debugging feature which RCU-delays every individual
> > kmem_cache_free() before either actually freeing the object or handing =
it
> > off to KASAN, and change KASAN to poison freed objects as normal when t=
his
> > option is enabled.
[...]
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index afc72fde0f03..0c088532f5a7 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -70,6 +70,35 @@ config SLUB_DEBUG_ON
> >           off in a kernel built with CONFIG_SLUB_DEBUG_ON by specifying
> >           "slab_debug=3D-".
> >
> > +config SLUB_RCU_DEBUG
> > +       bool "Make use-after-free detection possible in TYPESAFE_BY_RCU=
 caches"
>
> Perhaps, it makes sense to point out that is related to KASAN's
> use-after-free detection in the option description.

Hmm, yeah, maybe I'll change it to
"Enable UAF detection in TYPESAFE_BY_RCU caches (for KASAN)"
and then we can change that in the future if the feature becomes
usable with other SLUB stuff.

> > +       depends on SLUB_DEBUG
>
> Do we need depends on KASAN?

My original thinking was: The feature is supposed to work basically
independently of KASAN. It doesn't currently do anything useful
without KASAN, but if we do something about constructor slabs in the
future, this should make it possible to let SLUB poison freed objects.
(Though that might also require going back to deterministically
RCU-delaying the freeing of objects in the future...)

But yeah, I guess for now the config option is useless without KASAN,
so it's reasonable to make it depend on KASAN for now. I'll change it
that way.

> > +       default KASAN_GENERIC || KASAN_SW_TAGS
> > +       help
> > +         Make SLAB_TYPESAFE_BY_RCU caches behave approximately as if t=
he cache
> > +         was not marked as SLAB_TYPESAFE_BY_RCU and every caller used
> > +         kfree_rcu() instead.
> > +
> > +         This is intended for use in combination with KASAN, to enable=
 KASAN to
> > +         detect use-after-free accesses in such caches.
> > +         (KFENCE is able to do that independent of this flag.)
> > +
> > +         This might degrade performance.
> > +         Unfortunately this also prevents a very specific bug pattern =
from
> > +         triggering (insufficient checks against an object being recyc=
led
> > +         within the RCU grace period); so this option can be turned of=
f even on
> > +         KASAN builds, in case you want to test for such a bug.
> > +
> > +         If you're using this for testing bugs / fuzzing and care abou=
t
> > +         catching all the bugs WAY more than performance, you might wa=
nt to
> > +         also turn on CONFIG_RCU_STRICT_GRACE_PERIOD.
> > +
> > +         WARNING:
> > +         This is designed as a debugging feature, not a security featu=
re.
> > +         Objects are sometimes recycled without RCU delay under memory=
 pressure.
> > +
> > +         If unsure, say N.
> > +
> >  config PAGE_OWNER
> >         bool "Track page owner"
> >         depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 7c7fc6ce7eb7..d92cb2e9189d 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -238,7 +238,8 @@ static enum free_validation_result check_slab_free(=
struct kmem_cache *cache,
> >  }
> >
> >  static inline bool poison_slab_object(struct kmem_cache *cache, void *=
object,
> > -                                     unsigned long ip, bool init)
> > +                                     unsigned long ip, bool init,
> > +                                     bool after_rcu_delay)
> >  {
> >         void *tagged_object =3D object;
> >         enum free_validation_result valid =3D check_slab_free(cache, ob=
ject, ip);
> > @@ -251,7 +252,8 @@ static inline bool poison_slab_object(struct kmem_c=
ache *cache, void *object,
> >         object =3D kasan_reset_tag(object);
> >
> >         /* RCU slabs could be legally used after free within the RCU pe=
riod. */
> > -       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
> > +       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU) &&
> > +           !after_rcu_delay)
>
> This can be kept on the same line.

ack, I'll change that

[...]
> > +       /* Free the object - this will internally schedule an RCU callb=
ack. */
> > +       kmem_cache_free(cache, p);
> > +
> > +       /* We should still be allowed to access the object at this poin=
t because
>
> Empty line after /* here and below.

ack, I'll change that

