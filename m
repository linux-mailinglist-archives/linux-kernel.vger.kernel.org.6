Return-Path: <linux-kernel+bounces-239826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28539265D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2344D1C227BB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB0181D02;
	Wed,  3 Jul 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5v8GxjN"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA6282E1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023410; cv=none; b=LSErSwCRZP58FkQ1K09dBKEitRBo4Cwy5mNuVD13o5XA2E79COiXrsjewiGsy67R62tSZxo5jFA9ES5sMkD+0Nf2L5SoNZ5j3ZpuHX4hXzCBcQTaxw4rRgoJgIHPkavITqH0+DfQRsq5dpbKH7SQgVoLlpn6wzuFFp3w+ecEV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023410; c=relaxed/simple;
	bh=Oa/V5VvIkG2lSsp1aSIThCKTUFpJG6OO+KnCPtPC7sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSqhQU2EuMIAqyP+i+XnkUIUerAfcRDoEH7pV995suTztpS1ztiAYzodiqwEIbaO+YsijWrckAyqEqeLYWpQtsOwOTua90HkTK9vgPKpNA/VFjCLq+YazJKXvhPB3GtHOubblrZ5BS9ZKx7lCq2OZitWosi171UDEBbWbW0rl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5v8GxjN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-651da7c1531so6054507b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720023408; x=1720628208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXeCBK6xBBxTM3ezoeQkU8YiFNckh1438wTBxrn2JME=;
        b=r5v8GxjNahS9U7MxgPFeiRFcTNMU9ElL+x0/toCcjed+l9l7xhVVFniIWpdDvVFAP8
         65Rea3MkMgtbhfikQIb3o4GSKhefkzGisyKVEQHgE0vW2iPTZaIEkZY7trL7HXGxfx6z
         YQJ7zMzqkTij/QnaBSNsQbY88g/MLeOHTHb4E8px3Izc2+UiiFB+M16fV38dlNq8aYoY
         KSxowi5YBWOQoyrqn2Z02mwejEOkTFR1KeLdsVYz8Xi6vP2wPwXF+X9bbhnGTWagKxRZ
         O+U5wpGdQB4HF6n/WlVPKJJUpgV7T8nyb8W1yDpYgJdkJFel3d5+Nqx7r3dW1yvv2wxL
         vhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023408; x=1720628208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VXeCBK6xBBxTM3ezoeQkU8YiFNckh1438wTBxrn2JME=;
        b=kAYsUkQk6mBy+rkJnWws79er8B44ApAPKzz4M1Uwy2OOFn56lt6KdfIwOVA6ZVKehO
         mcw4rH/g1cdUa0KGXjSWJLPwEScbdLYcQ0f3KR7gSRJCFRpLxqezdmg63yc5Q5Ekf3JK
         +IhVq14Y689bXvsEpGYLAE27HCaN09SjfwqqbGVGPTJlqJ9U0hplfKSMuMfafg5qEdH+
         BWr+SRLUHiChtNAbxn2wfC85ELBwOAzB/KORo15pzVhsv6IPxd5i6ksDDlZ+kP4l+ESv
         aIvuakoAa8sLcLPrkdsnuNZuZMtt6bj7qrqMPSdQb1VgqnCwIrFGTHOqZi/9/NTfCQ0A
         xaVA==
X-Forwarded-Encrypted: i=1; AJvYcCWozu9aTr+zR9Bu/ZUoUqGc2pcjbE4s8I6CpjgNMEW9e3M591JNDg68m0o7bEzzq5ChhCzfp+TpF2RlRVGHqkod5WOKjWiIzZJv/HyP
X-Gm-Message-State: AOJu0YyPyhqsMaSESbuRdiyKJ1BBnPl0+NmREZjreFRDUfUwnYb5hFTp
	Nr8Ofk9AVgf2+igrOTQyVSSRoWDI9KedIzkhPVZR0ImjLdKz86G0cAb1jhldwUTWvUG2t1mnHeC
	P6/aVIHu6a5fuXXUqSAqux/AtmFsf749HchyE
X-Google-Smtp-Source: AGHT+IHcvYoJzHzq6NPJxo48byZhuoc23xrfZJXsgV2ZEg04vdGcT3QFNtyAQKJcrv59lLV3h5fgiIXj1J8xchI2/KM=
X-Received: by 2002:a81:a24e:0:b0:62f:b04c:2442 with SMTP id
 00721157ae682-64c70c76533mr124349677b3.7.1720023407792; Wed, 03 Jul 2024
 09:16:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703015354.3370503-1-surenb@google.com> <be221a24-fec2-4ae4-9020-c684902870e7@suse.cz>
In-Reply-To: <be221a24-fec2-4ae4-9020-c684902870e7@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Jul 2024 09:16:34 -0700
Message-ID: <CAJuCfpEObdL2WhQfNgouJ6CZTB+fmwzCto5WQg6kNgW+ks8+hQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm, slab: move allocation tagging code in the alloc
 path into a hook
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, cl@linux.com, 
	penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com, 
	roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:47=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/3/24 3:53 AM, Suren Baghdasaryan wrote:
> > Move allocation tagging specific code in the allocation path into
> > alloc_tagging_slab_alloc_hook, similar to how freeing path uses
> > alloc_tagging_slab_free_hook. No functional changes, just code
> > cleanup.
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/slub.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 4927edec6a8c..99d53190cfcf 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -2033,11 +2033,18 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s=
, gfp_t flags, void *p)
> >       return slab_obj_exts(slab) + obj_to_index(s, slab, p);
> >  }
> >
> > +#ifdef CONFIG_MEM_ALLOC_PROFILING
>
> I think if you extract this whole #ifdef CONFIG_MEM_ALLOC_PROFILING secti=
on
> to go outside of CONFIG_SLAB_OBJ_EXT sections, i.e. below the final
>
> #endif /* CONFIG_SLAB_OBJ_EXT */
>
> then it wouldn't be necessary to have two instances of the empty hooks?
>
> > +
> > +static inline void
> > +alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned i=
nt size)
> > +{
> > +     alloc_tag_add(&obj_exts->ref, current->alloc_tag, size);
> > +}
> > +
> >  static inline void
> >  alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, =
void **p,
> >                            int objects)
> >  {
> > -#ifdef CONFIG_MEM_ALLOC_PROFILING
> >       struct slabobj_ext *obj_exts;
> >       int i;
> >
> > @@ -2053,9 +2060,23 @@ alloc_tagging_slab_free_hook(struct kmem_cache *=
s, struct slab *slab, void **p,
> >
> >               alloc_tag_sub(&obj_exts[off].ref, s->size);
> >       }
> > -#endif
> >  }
> >
> > +#else /* CONFIG_MEM_ALLOC_PROFILING */
> > +
> > +static inline void
> > +alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned i=
nt size)
> > +{
> > +}
> > +
> > +static inline void
> > +alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, =
void **p,
> > +                          int objects)
> > +{
> > +}
> > +
> > +#endif /* CONFIG_MEM_ALLOC_PROFILING*/
> > +
> >  #else /* CONFIG_SLAB_OBJ_EXT */
> >
> >  static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s=
,
> > @@ -2079,6 +2100,11 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s,=
 gfp_t flags, void *p)
> >       return NULL;
> >  }
> >
> > +static inline void
> > +alloc_tagging_slab_alloc_hook(struct slabobj_ext *obj_exts, unsigned i=
nt size)
> > +{
> > +}
> > +
> >  static inline void
> >  alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, =
void **p,
> >                            int objects)
> > @@ -3944,7 +3970,6 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
> >               kmemleak_alloc_recursive(p[i], s->object_size, 1,
> >                                        s->flags, init_flags);
> >               kmsan_slab_alloc(s, p[i], init_flags);
> > -#ifdef CONFIG_MEM_ALLOC_PROFILING
> >               if (need_slab_obj_ext()) {
> >                       struct slabobj_ext *obj_exts;
> >
> > @@ -3955,9 +3980,8 @@ bool slab_post_alloc_hook(struct kmem_cache *s, s=
truct list_lru *lru,
> >                        * check should be added before alloc_tag_add().
> >                        */
> >                       if (likely(obj_exts))
> > -                             alloc_tag_add(&obj_exts->ref, current->al=
loc_tag, s->size);
> > +                             alloc_tagging_slab_alloc_hook(obj_exts, s=
->size);
> >               }
>
> Could this whole "if (need_slab_obj_ext())" block be part of
> alloc_tagging_slab_alloc_hook()? That would match
> __memcg_slab_post_alloc_hook also taking care of calloing
> alloc_slab_obj_exts on its own. Maybe then we won't even need empty versi=
ons
> of prepare_slab_obj_exts_hook()

Yeah, since we don't have other slab_obj_ext users yet, we can
simplify the code that way. Originally I wanted to keep it more
generic and make it easy to add new slab_obj_ext users, but I'm fine
with this simplification. When there are other users we can change the
code back to be more generic. I'll post v2 shortly with your
suggestions.
Thanks,
Suren.

>
> > -#endif
> >       }
> >
> >       return memcg_slab_post_alloc_hook(s, lru, flags, size, p);
> >
> > base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
>

