Return-Path: <linux-kernel+bounces-567199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8494EA68330
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55ED1189758D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69FA24DFF6;
	Wed, 19 Mar 2025 02:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="brdzoaIZ"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8922F19
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742351736; cv=none; b=q/tlCZDxCtt9Rietr8Ds2EFJMZ8dDdzE0ORRnIEY4jbC7IjZFgXO7pilOiwUgQDuBW4Xvg/k3DVPyjbrTF8g0mNk7Abnj+V43FOD408kY9UakG8QCHkDeSyuC9/GaBtoerDLnVY7cwfOLES0FQuQ6LUqIEE9/v1/7aJ8ljO1HN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742351736; c=relaxed/simple;
	bh=/e7ppF4BqBUFLoYPE3wW5INIzRFFAW67CgR+H04nK6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUMhEEJUS+hjFu6kxHWdJoe1dTRp4SEGViguXbfktefBi7qjYbsRpZbFossHZRnX6NRYcpLKGHZhFK5Psth9yIu9IbntBpTjFI7LKa38GyZ/Xp6nHbnj8fjp4wrtCPVAK3XSvTlJFLWN2s5IPYWeTIdxsjvZWeXUjEMY13+GIC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=brdzoaIZ; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30c0517142bso55862841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742351731; x=1742956531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNDDNF8aCnqSxf5FZFdewOlEPZTLJmOK+unVNUewuCQ=;
        b=brdzoaIZSQ9tcyXOlAnYxfP0xLCjTxPtbnz6MxPjFWCrXqViuAcjiUmz2UopHWO9Nq
         4imc3pXq0DVnbCWUpKmNDSeJQKfo3egliQebNiwKW144pPNmXCAE4GBbGcmTAyRSOJeI
         feJ5Y7hd2bo/5H0oFQgG5U89VsKIj68HDiYReSbnjWsZQJ9hc2ssXNL+MVDbeCDjbJZC
         nBtDP1Mzvk/zI59h7smn/wPimfYiIRbzLrjqo3iLUI6y38Y/XvfM1B/VWr1t1aUURrqz
         TOXgCsbSgXD1wYy8KISTo29L1+AaCWgK5roB6uDVrmgjRtTj9awypo/FDx2xbvIJj54h
         Kb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742351731; x=1742956531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNDDNF8aCnqSxf5FZFdewOlEPZTLJmOK+unVNUewuCQ=;
        b=B/gxt08QTCr08dCDxDLeVq3rH5uRatXr/QDhOFuSdi1SHB9SEhByZgZixq3fCkEGMg
         kjgwibYeDe5IP6dwqkpPeFt6qYWr3PM5J+kahug8OBRv534rfNVwWLOgfXYte4RayW8S
         nTuQZpJiHJzpjg5iWc3xj7vZEiUnZdfreHkvVuYPWFdd7e+WL6ayghs9aTur+7iD7ynf
         v506VU3GIjcFseP2u4o/gd48K0E1Fykyre9RhgN/r3kPEMTRp8PCgKVD08cxYG5BqACL
         V131hATwGcgD50661/L32GLB+Al6P+3PTrsRmYJhIPjvsvIQzaZjJ8jfDDdTkhwMUFlx
         fAPw==
X-Forwarded-Encrypted: i=1; AJvYcCW22hOCjUcq7rfq7yNlNKTaH0LUdWn1xp5pyrntsIDZrwxFvIw5YWoZJuogn0n8g6soJTFTkUhax6F7F1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYT6vK61rckopzPJ/N3VqcTEGb2FssDRnA2ltcIVM7c7lMUPjK
	/Yl9oI1zOvH07wY2X51FE8d3XOz/nrATNafyb20RPfjfjKrpg1DosamZvWf/dRbJzUXv2vTdwJP
	/iODCGlZ0fqHYj5He7EHTNwVOHEqTgQPCJseb3w==
X-Gm-Gg: ASbGnctL0+BLfkD1AQ8AS7lPy9aL05VivGY9Wo0rroVUTaT2jaGpd/+smyWpwaPFxkf
	76FgwZWoFlj5AK0XEkD+xNn3t40+q+D2M36OisRa8AFULIKIExG1P6j3eol8pAA9AHR+8ESMdQ4
	NPRVPfbsjvk5oNVQUepwAguacB7UAHJ+3WPSo7lHdIAnbBZg29RT8=
X-Google-Smtp-Source: AGHT+IGdtVm6Bqx7M3YzZ1f0mDz/H5tgrBcE5uuf325Gvnvr62PB2XzSF/KXWtyeOFveND5pUCsOFXbNJUQFLtEC1fg=
X-Received: by 2002:a05:6512:b1f:b0:549:7394:2ce5 with SMTP id
 2adb3069b0e04-54acb205b22mr299695e87.41.1742351731370; Tue, 18 Mar 2025
 19:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318135330.3358345-1-hezhongkun.hzk@bytedance.com> <Z9l-x-b9W32vE8Qn@google.com>
In-Reply-To: <Z9l-x-b9W32vE8Qn@google.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 19 Mar 2025 10:34:54 +0800
X-Gm-Features: AQ5f1Jomcet91R-UxIGnSDO0si2b5Ui89tzxcKFLDXZ8iJaVmGNN16MHY4Fw0cQ
Message-ID: <CACSyD1PZVVep7Do6WWOMTFr_qhzskxZtXEaqpCtk9JcR3X1L-A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: add swappiness=max arg to
 memory.reclaim for only anon reclaim
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yuzhao@google.com, 
	mhocko@suse.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 10:10=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev=
> wrote:
>
> On Tue, Mar 18, 2025 at 09:53:30PM +0800, Zhongkun He wrote:
> > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> > memory.reclaim")', we can submit an additional swappiness=3D<val> argum=
ent
> > to memory.reclaim. It is very useful because we can dynamically adjust
> > the reclamation ratio based on the anonymous folios and file folios of
> > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > from file folios.
> >
> > However,we have also encountered a new issue: when swappiness is set to
> > the MAX_SWAPPINESS, it may still only reclaim file folios.
> >
> > So, we hope to add a new arg 'swappiness=3Dmax' in memory.reclaim where
> > proactive memory reclaim only reclaims from anonymous folios when
> > swappiness is set to max. The swappiness semantics from a user
> > perspective remain unchanged.
> >
> > For example, something like this:
> >
> > echo "2M swappiness=3Dmax" > /sys/fs/cgroup/memory.reclaim
> >
> > will perform reclaim on the rootcg with a swappiness setting of 'max' (=
a
> > new mode) regardless of the file folios. Users have a more comprehensiv=
e
> > view of the application's memory distribution because there are many
> > metrics available. For example, if we find that a certain cgroup has a
> > large number of inactive anon folios, we can reclaim only those and ski=
p
> > file folios, because with the zram/zswap, the IO tradeoff that
> > cache_trim_mode or other file first logic is making doesn't hold -
> > file refaults will cause IO, whereas anon decompression will not.
> >
> > With this patch, the swappiness argument of memory.reclaim has a new
> > mode 'max', means reclaiming just from anonymous folios both in traditi=
onal
> > LRU and MGLRU.
>
> Is MGLRU handled in this patch?

Yes, The value of ONLY_ANON_RECLAIM_MODE is 201, and the MGLRU select the
evictable type like this:

#define evictable_min_seq(min_seq, swappiness)              \
    min((min_seq)[!(swappiness)], (min_seq)[(swappiness) <=3D MAX_SWAPPINES=
S])

#define for_each_evictable_type(type, swappiness)           \
    for ((type) =3D !(swappiness); (type) <=3D ((swappiness) <=3D
MAX_SWAPPINESS); (type)++)

if the swappiness=3D0, the type is LRU_GEN_FILE(1);

if the swappiness=3D201 (>MAX_SWAPPINESS),
  for ((type) =3D 0; (type) <=3D 0); (type)++)
The type is always LRU_GEN_ANON(0).

>
> >
> > Here is the previous discussion:
> > https://lore.kernel.org/all/20250314033350.1156370-1-hezhongkun.hzk@byt=
edance.com/
> > https://lore.kernel.org/all/20250312094337.2296278-1-hezhongkun.hzk@byt=
edance.com/
> >
> > Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  4 ++++
> >  include/linux/swap.h                    |  4 ++++
> >  mm/memcontrol.c                         |  5 +++++
> >  mm/vmscan.c                             | 10 ++++++++++
> >  4 files changed, 23 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index cb1b4e759b7e..c39ef4314499 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1343,6 +1343,10 @@ The following nested keys are defined.
> >       same semantics as vm.swappiness applied to memcg reclaim with
> >       all the existing limitations and potential future extensions.
> >
> > +     If set swappiness=3Dmax, memory reclamation will exclusively
> > +     target the anonymous folio list for both traditional LRU and
> > +     MGLRU reclamation algorithms.
> > +
>
> I don't think we need to specify LRU and MGLRU here. What about:
>
> Setting swappiness=3Dmax exclusively reclaims anonymous memory.
>

Agree, thanks.

> >    memory.peak
> >       A read-write single value file which exists on non-root cgroups.
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index b13b72645db3..a94efac10fe5 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -419,6 +419,10 @@ extern unsigned long try_to_free_pages(struct zone=
list *zonelist, int order,
> >  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> >  #define MIN_SWAPPINESS 0
> >  #define MAX_SWAPPINESS 200
> > +
> > +/* Just recliam from anon folios in proactive memory reclaim */
> > +#define ONLY_ANON_RECLAIM_MODE (MAX_SWAPPINESS + 1)
> > +
>
> This is a swappiness value so let's keep that clear, e.g.
> SWAPPINESS_ANON_ONLY or similar.
>

OK.

> >  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *m=
emcg,
> >                                                 unsigned long nr_pages,
> >                                                 gfp_t gfp_mask,
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4de6acb9b8ec..0d0400f141d1 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -4291,11 +4291,13 @@ static ssize_t memory_oom_group_write(struct ke=
rnfs_open_file *of,
> >
> >  enum {
> >       MEMORY_RECLAIM_SWAPPINESS =3D 0,
> > +     MEMORY_RECLAIM_ONLY_ANON_MODE,
> >       MEMORY_RECLAIM_NULL,
> >  };
> >
> >  static const match_table_t tokens =3D {
> >       { MEMORY_RECLAIM_SWAPPINESS, "swappiness=3D%d"},
> > +     { MEMORY_RECLAIM_ONLY_ANON_MODE, "swappiness=3Dmax"},
>
> MEMORY_RECLAIM_SWAPPINESS_MAX?
>

OK.

> >       { MEMORY_RECLAIM_NULL, NULL },
> >  };
> >
> > @@ -4329,6 +4331,9 @@ static ssize_t memory_reclaim(struct kernfs_open_=
file *of, char *buf,
> >                       if (swappiness < MIN_SWAPPINESS || swappiness > M=
AX_SWAPPINESS)
> >                               return -EINVAL;
> >                       break;
> > +             case MEMORY_RECLAIM_ONLY_ANON_MODE:
> > +                     swappiness =3D ONLY_ANON_RECLAIM_MODE;
> > +                     break;
> >               default:
> >                       return -EINVAL;
> >               }
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c767d71c43d7..779a9a3cf715 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec=
, struct scan_control *sc,
> >               goto out;
> >       }
> >
> > +     /*
> > +      * Do not bother scanning file folios if the memory reclaim
> > +      * invoked by userspace through memory.reclaim and set
> > +      * 'swappiness=3Dmax'.
> > +      */
>
> /* Proactive reclaim initiated by userspace for anonymous memory only */
>

Looks clearer.

> > +     if (sc->proactive && (swappiness =3D=3D ONLY_ANON_RECLAIM_MODE)) =
{
>
> Do we need to check sc->proactive here? Supposedly this swappiness value
> can only be passed in from proactive reclaim. Instead of silently
> ignoring the value from other paths, I wonder if we should WARN on
> !sc->proactive instead.
>

I'm also hesitating on how to handle this judgment. WARN looks good.

> > +             scan_balance =3D SCAN_ANON;
> > +             goto out;
> > +     }
> > +
> >       /*
> >        * Do not apply any pressure balancing cleverness when the
> >        * system is close to OOM, scan both anon and file equally
> > --
> > 2.39.5
> >

