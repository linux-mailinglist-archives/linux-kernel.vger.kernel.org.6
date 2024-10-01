Return-Path: <linux-kernel+bounces-345284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA45F98B417
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8F5282790
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949E1BBBDB;
	Tue,  1 Oct 2024 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaTcoT0I"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88203201
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762754; cv=none; b=c3bciBhdCwO7I0M3gdC++KFR2d/KRZ6pAQVBp0qK+orfNShGm0xvoQFVOYdq7I4aBR4cPEgLjbjwrxCuNmwSeTm4rRbKYtqY7RgsdLLHdKWjTTWsr7PWRCMnBHfdkozK4/VIdTbjTGVcuvf8cBLSqv1aESd2uaf0IPJ8qoTB6iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762754; c=relaxed/simple;
	bh=vQexvvhk5fJr2dXH4vbsL8BRDbhC51Ft5X2lyUzfzs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZqpGWvYZSPxeeejkVa5XF1HQvfSg0jO5yNoVO5OECUTVjkrgL++5qiaqREB1um0gDtjrsdchPLuQQ/tUS8kKm3nR2wIOfEi7Bp6wszwgrfEgspR2sDRtELkHHNZVTNJfdf81lXGLsrgWvg1uUFPnWQDOowuClovm69C0wuiEP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaTcoT0I; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53988c54ec8so4050224e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762750; x=1728367550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDX300SfQ8XSrIseTiWT0bT/7uJ6lLhpLAjt+5qtDPM=;
        b=AaTcoT0IlOB33PkHCf+y0t12ukA6R2NvfcRHXdaxVaw/AMlwphOrLv5bIIRv5A/6Ex
         N4/B9ytuhsoc2IbNRrd/T+RBkrp9DLh4UXCKa1erxruNbxHwDzc19IgWh4kMdLTjMJSX
         h2OrBT3oM2a//hCItpwKoQeg2+kRNjBL7T31Lmz9E96wRQWW9WsFkPesoZkjb/1Xf3GI
         Qu+/6g8aNIDL57uAiHEuCW4eF3c5juuWa5xaQPygKK9LdLl/aAESk37gJ8W6qbRoZlEG
         /rMcZjZDNqD1lvuax66UbEJqoT0uYvTPpKd1zbojzt30i02b1mU2/XXNh+nweG5MOFXv
         o+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762750; x=1728367550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDX300SfQ8XSrIseTiWT0bT/7uJ6lLhpLAjt+5qtDPM=;
        b=rQ0qosuRcOluVtcg/ThC26fAauBwqNSY6bKzOn9vaIXhvwt1HBQAZ//5GxpoOatwYc
         jee1LyyULEwkMIm1tP5bVHzzo5aEcfp8ygauz+ZHSZGX4j6GM/I8UGPkBDr6x/0oPgFB
         BqflZO3xfTZwnhUqay19HqGyAUzwdKBT3WgXF30rsR+oQz5Uaf1DRJrxbLb452jr57Bz
         oJCtdMozNw7UbjYchGskMDCfLudvwc7izacYVyPtk8MSbztT4I77FOCaPUwdkdnIZdRf
         MHcTfz1wsFgPzxURTYBepwUb6cNpZKTCWBek4+RyPd4mALZVaP1SbOjyolueSSUc4Rt4
         v0pg==
X-Forwarded-Encrypted: i=1; AJvYcCW+WyVgHvc2xgH9MINYiAA1dDSir1YRsnVMlz2oY3FIthinF4EEzQeRLqG8qST+t6HnUFb1VuxUdHf8lKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuXdEggQkKlWIVrgMl2sCROJzr0ELR850CIDk/8yNZHKtliEyW
	33g5JNZ12zKlyRgWNvW8+Y3IOJOnggrQqM+H3P1gSqMR9eJhlpNU0KZkiqfBu0sdoTBsrR4UiMu
	HkfPc3D2KkmMYWtkFgj5B0v/1dNM=
X-Google-Smtp-Source: AGHT+IFbcvAwj92GwWG0q111tl4frudVTrCcrvbq6hNYm5bc5VJf4uoHjMb2dhPhlED70BX0sCtzSED5DSplo+sEXKs=
X-Received: by 2002:a05:6512:3ba6:b0:538:9e1e:b068 with SMTP id
 2adb3069b0e04-5389fc3bd6fmr7170466e87.15.1727762750129; Mon, 30 Sep 2024
 23:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz> <20240930-b4-slub-kunit-fix-v1-1-32ca9dbbbc11@suse.cz>
In-Reply-To: <20240930-b4-slub-kunit-fix-v1-1-32ca9dbbbc11@suse.cz>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 1 Oct 2024 15:05:37 +0900
Message-ID: <CAB=+i9QOrgKcp24i_O9nFkxnySWdO0Yv6NjjDwXopDWbT3RJQw@mail.gmail.com>
Subject: Re: [PATCH slab hotfixes 1/2] mm, slab: suppress warnings in
 test_leak_destroy kunit test
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel test robot <oliver.sang@intel.com>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 5:37=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> The test_leak_destroy kunit test intends to test the detection of stray
> objects in kmem_cache_destroy(), which normally produces a warning. The
> other slab kunit tests suppress the warnings in the kunit test context,
> so suppress warnings and related printk output in this test as well.
> Automated test running environments then don't need to learn to filter
> the warnings.
>
> Also rename the test's kmem_cache, the name was wrongly copy-pasted from
> test_kfree_rcu.
>
> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_des=
troy()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202408251723.42f3d902-oliver.sang@=
intel.com
> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Closes: https://lore.kernel.org/all/CAB=3D+i9RHHbfSkmUuLshXGY_ifEZg9vCZi3=
fqr99+kmmnpDus7Q@mail.gmail.com/
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@=
roeck-us.net/
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/slub_kunit.c | 4 ++--
>  mm/slab.h        | 6 ++++++
>  mm/slab_common.c | 5 +++--
>  mm/slub.c        | 5 +++--
>  4 files changed, 14 insertions(+), 6 deletions(-)

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 6e3a1e5a7142f797fe20a28967657f50a466d4ee..85d51ec09846d4fa219db6bda=
336c6f0b89e98e4 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -177,13 +177,13 @@ static void test_kfree_rcu(struct kunit *test)
>
>  static void test_leak_destroy(struct kunit *test)
>  {
> -       struct kmem_cache *s =3D test_kmem_cache_create("TestSlub_kfree_r=
cu",
> +       struct kmem_cache *s =3D test_kmem_cache_create("TestSlub_leak_de=
stroy",
>                                                         64, SLAB_NO_MERGE=
);
>         kmem_cache_alloc(s, GFP_KERNEL);
>
>         kmem_cache_destroy(s);
>
> -       KUNIT_EXPECT_EQ(test, 1, slab_errors);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
>  }
>
>  static int test_init(struct kunit *test)
> diff --git a/mm/slab.h b/mm/slab.h
> index f22fb760b2866124d9d873d28b5a7fa6867aeb90..5cf0fbab0b0554ee70f537177=
2bc37b290893b8a 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -546,6 +546,12 @@ static inline bool kmem_cache_debug_flags(struct kme=
m_cache *s, slab_flags_t fla
>         return false;
>  }
>
> +#if IS_ENABLED(CONFIG_SLUB_DEBUG) && IS_ENABLED(CONFIG_KUNIT)
> +bool slab_in_kunit_test(void);
> +#else
> +static inline bool slab_in_kunit_test(void) { return false; }
> +#endif
> +
>  #ifdef CONFIG_SLAB_OBJ_EXT
>
>  /*
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 7443244656150325fb2a7d0158a71821e1418062..3d26c257ed8b57c336ec5c38d=
4bbd5f5e51d50ff 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -508,8 +508,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
>         kasan_cache_shutdown(s);
>
>         err =3D __kmem_cache_shutdown(s);
> -       WARN(err, "%s %s: Slab cache still has objects when called from %=
pS",
> -            __func__, s->name, (void *)_RET_IP_);
> +       if (!slab_in_kunit_test())
> +               WARN(err, "%s %s: Slab cache still has objects when calle=
d from %pS",
> +                    __func__, s->name, (void *)_RET_IP_);
>
>         list_del(&s->list);
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 21f71cb6cc06d951a657290421f41170bb3c76cf..5b832512044e3ead8ccde2c02=
308bd8954246db5 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -827,7 +827,7 @@ static bool slab_add_kunit_errors(void)
>         return true;
>  }
>
> -static bool slab_in_kunit_test(void)
> +bool slab_in_kunit_test(void)
>  {
>         struct kunit_resource *resource;
>
> @@ -843,7 +843,6 @@ static bool slab_in_kunit_test(void)
>  }
>  #else
>  static inline bool slab_add_kunit_errors(void) { return false; }
> -static inline bool slab_in_kunit_test(void) { return false; }
>  #endif
>
>  static inline unsigned int size_from_object(struct kmem_cache *s)
> @@ -5436,6 +5435,8 @@ static void list_slab_objects(struct kmem_cache *s,=
 struct slab *slab,
>         for_each_object(p, s, addr, slab->objects) {
>
>                 if (!test_bit(__obj_to_index(s, addr, p), object_map)) {
> +                       if (slab_add_kunit_errors())
> +                               continue;
>                         pr_err("Object 0x%p @offset=3D%tu\n", p, p - addr=
);
>                         print_tracking(s, p);
>                 }
>
> --
> 2.46.1
>

