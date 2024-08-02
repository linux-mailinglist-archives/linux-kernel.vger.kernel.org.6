Return-Path: <linux-kernel+bounces-272502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7343D945D34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0E1C20928
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6871E2126;
	Fri,  2 Aug 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcSRJc66"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FB7EF04
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722597785; cv=none; b=utzBFhlQdp0KTkCE/DdXGPFsd1VPMUoQ5RMeLFha0d5gyIdeRrCnvGGUJiO2M9NRw4Y8/AkeCkkDQjTavfvPxPoYnw07p/QZRvnXZQk9tuRsJp7cYUOGYYMdhUoOBRHQQKvaIlf1PdvlimYH2ECu0Zph3JPqT5P9smmXcu0uTZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722597785; c=relaxed/simple;
	bh=dgFaGVtCxEZqoesPGJfE/71Li1BgMOZz8+4+SICVZWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmO7LeLv5j5qTwg3oOVh7si8BYKtPMTsg/2IeUB8JlaiXVFtrivR9dOF3Zdo3EQTzwmEG7M4RH9709xbMRC8fnoZMRF/Pkmds9IKbR+v/6Swqwe0bFefpuLnv0+SnKueH9Eb1DSuljn3VixMF/LTiXD1J4lzCN9hdvIQx7rfPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcSRJc66; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so49808a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722597782; x=1723202582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXuC7eL0okWOe+3ruv5rtgdzN2mMwl0ZfQ5u9zC8B54=;
        b=hcSRJc66oI6Rc2F+x+z5b/W1C6AV3KB8jAvnDixdWsgsWmttaG9y/3jn92d+k8hgDW
         bjjV/0QDT5bIqcb4+KY6C9UT7mLBuuWpc6kgeiDUi8WB8FYATvjvQhhDEvGtVkzq4itM
         Txd9xi02XBjfepHLf8bmimJWWBxX4q2r2vXIbY9l72Qd9To4Lxakv6yqDnudn2V72Rtf
         b/O+O6czFBI3mNXZys4IKDcm0q2TXQxbQDO40k4bt8MnUb7WO6W35cSIJL+fOkxVv4kA
         e9tZun6Oo2xhSPw3UP4pZSwirAY5YsoY9WSjcs8NfBicxhwONVfXMcAF1exghIy9jXtb
         rUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722597782; x=1723202582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXuC7eL0okWOe+3ruv5rtgdzN2mMwl0ZfQ5u9zC8B54=;
        b=SyWVWzZulu16A/wJ1u+KaOPsftvUPvFojZHEuNe9L0Guw2a30sHKcxK8MGSqLM0yvu
         WqCSRGy1ES40i8tXauU2ulEZ6I+oooVzY6yBOvh4dPmntaNRXsjaAssusZXOhXMNFe7l
         tQnFRI3OxYVkkwzcEVqJX3lG9odz6GJ4MUbqqxKZZ7SD2W8LMr4GNfu+sGaWCcz/+qQY
         7lLe2rhoY1gAAlsmf2K/jW23+IwBW/vB2e7E7y99wpPC9Cwz3M0EkOGzZirHkzLs3oND
         1YASX9BjdYVsYt2G052X4g8Oz4gZzWFIoHREhPTzIDW7Wr58/D0M0mWJuwevk6Cj5Ypv
         AGwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCWSiUye/Q/kp43G0BZTc63vHnSCXCLsxCN1peS2Q9M5OWpVRhJaW2paCcoEnSEMJTzt+yZYPgfApTMvm9eTgibvWeHC8ZFHWZtpCw
X-Gm-Message-State: AOJu0YylT00V8vwWtvC6EuG6Z9o5g6nIUMP0T8O4La6im65jbyKIWjUQ
	U1hT2gtrqs4KOWtxBYTs3wfxBVAK+6s5NAMIAzIMahnq97QRoSzK+ol31ta7mFcWiJ+DSnZuvZI
	7EcMiud3jNu1vM5a2xnkZV6hy8CFm452orrU1
X-Google-Smtp-Source: AGHT+IEdePClV7Jvqw70Ip55InNeH7ZpGzuDQIu2n1gbdG50BV+x8Jh6WjYdxKBCFXgtjGe6LPugeYAsGgDfbVtUUXU=
X-Received: by 2002:a05:6402:40cf:b0:5ac:4ce3:8f6a with SMTP id
 4fb4d7f45d1cf-5b86bf8e337mr112549a12.6.1722597781429; Fri, 02 Aug 2024
 04:23:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com> <CA+fCnZeq8JGSkFwGitwSc3DbeuoXnoyvC7RgWh6XSG1CoWH=Zg@mail.gmail.com>
 <CAG48ez1guHcQaZtGoap7MG1sac5F3PmMA7XKUH03pEaibvaFJw@mail.gmail.com>
In-Reply-To: <CAG48ez1guHcQaZtGoap7MG1sac5F3PmMA7XKUH03pEaibvaFJw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 13:22:23 +0200
Message-ID: <CAG48ez2bqYMPS2D7gFZ-9V3p3-NJUYmYNA113QbMg0JRG+pNEQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
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

On Fri, Aug 2, 2024 at 11:09=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
> I guess I could also change the API to pass something different - like
> a flag meaning "the object is guaranteed to no longer be in use".
> There is already code in slab_free_hook() that computes this
> expression, so we could easily pass that to KASAN and then avoid doing
> the same logic in KASAN again... I think that would be the most
> elegant approach?

Regarding this, I think I'll add something like this on top of this patch i=
n v6:

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index b63f5351c5f3..50bad011352e 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -201,16 +201,17 @@ bool __kasan_slab_free(struct kmem_cache *s,
void *object, bool init,
 /**
  * kasan_slab_free - Possibly handle slab object freeing.
  * @object: Object to free.
+ * @still_accessible: Whether the object contents are still accessible.
  *
  * This hook is called from the slab allocator to give KASAN a chance to t=
ake
  * ownership of the object and handle its freeing.
  * kasan_slab_pre_free() must have already been called on the same object.
  *
  * @Return true if KASAN took ownership of the object; false otherwise.
  */
 static __always_inline bool kasan_slab_free(struct kmem_cache *s,
                                                void *object, bool init,
-                                               bool after_rcu_delay)
+                                               bool still_accessible)
 {
        if (kasan_enabled())
                return __kasan_slab_free(s, object, init, after_rcu_delay);
@@ -410,7 +411,7 @@ static inline bool kasan_slab_pre_free(struct
kmem_cache *s, void *object)
 }

 static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
-                                  bool init, bool after_rcu_delay)
+                                  bool init, bool still_accessible)
 {
        return false;
 }
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 71a20818b122..ed4873e18c75 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -230,14 +230,14 @@ static bool check_slab_allocation(struct
kmem_cache *cache, void *object,
 }

 static inline void poison_slab_object(struct kmem_cache *cache, void *obje=
ct,
-                                     bool init, bool after_rcu_delay)
+                                     bool init, bool still_accessible)
 {
        void *tagged_object =3D object;

        object =3D kasan_reset_tag(object);

        /* RCU slabs could be legally used after free within the RCU period=
. */
-       if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_del=
ay)
+       if (unlikely(still_accessible))
                return;

        kasan_poison(object, round_up(cache->object_size, KASAN_GRANULE_SIZ=
E),
@@ -256,12 +256,12 @@ bool __kasan_slab_pre_free(struct kmem_cache
*cache, void *object,
 }

 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
-                      bool after_rcu_delay)
+                      bool still_accessible)
 {
        if (!kasan_arch_is_ready() || is_kfence_address(object))
                return false;

-       poison_slab_object(cache, object, init, after_rcu_delay);
+       poison_slab_object(cache, object, init, still_accessible);

        /*
         * If the object is put into quarantine, do not let slab put the ob=
ject
diff --git a/mm/slub.c b/mm/slub.c
index 49571d5ded75..a89f2006d46e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2221,31 +2221,34 @@ static __always_inline
 bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
                    bool after_rcu_delay)
 {
+       /* Are the object contents still accessible? */
+       bool still_accessible =3D (s->flags & SLAB_TYPESAFE_BY_RCU) &&
!after_rcu_delay;
+
        kmemleak_free_recursive(x, s->flags);
        kmsan_slab_free(s, x);

        debug_check_no_locks_freed(x, s->object_size);

        if (!(s->flags & SLAB_DEBUG_OBJECTS))
                debug_check_no_obj_freed(x, s->object_size);

        /* Use KCSAN to help debug racy use-after-free. */
-       if (!(s->flags & SLAB_TYPESAFE_BY_RCU) || after_rcu_delay)
+       if (!still_accessible)
                __kcsan_check_access(x, s->object_size,
                                     KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSE=
RT);

        if (kfence_free(x))
                return false;

        /*
         * Give KASAN a chance to notice an invalid free operation before w=
e
         * modify the object.
         */
        if (kasan_slab_pre_free(s, x))
                return false;

 #ifdef CONFIG_SLUB_RCU_DEBUG
-       if ((s->flags & SLAB_TYPESAFE_BY_RCU) && !after_rcu_delay) {
+       if (still_accessible) {
                struct rcu_delayed_free *delayed_free;

                delayed_free =3D kmalloc(sizeof(*delayed_free), GFP_NOWAIT)=
;
@@ -2289,7 +2292,7 @@ bool slab_free_hook(struct kmem_cache *s, void
*x, bool init,
                       s->size - inuse - rsize);
        }
        /* KASAN might put x into memory quarantine, delaying its reuse. */
-       return !kasan_slab_free(s, x, init, after_rcu_delay);
+       return !kasan_slab_free(s, x, init, still_accessible);
 }

 static __fastpath_inline

