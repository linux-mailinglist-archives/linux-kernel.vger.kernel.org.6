Return-Path: <linux-kernel+bounces-273046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5559463F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1991F22A00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882F481DB;
	Fri,  2 Aug 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6xgNWV+"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03141ABEA5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627319; cv=none; b=NvnjZwRnj4yIJma6xzreOb/XWXnQpoUVaQVno2WFCCJAjRmAyThvAhDvwUQxUfNhfZrV17Mh/VUe8weNquM50WPtWIAAcJBbKltSGLsYLupcZ1fH6HcdbSPgwhCJPsfcg8/j/AOFKyFKa2rJN4xNOr9rCoO2i+4qb/5QOaY2tHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627319; c=relaxed/simple;
	bh=5oLiqaitihQSNXgz5f78HG44TyzFMAf/LHbh+J7eSpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhL5YVEHQkkU42eI5xQ+KIwzPKesQnk0Y8feKBVCZHp2n+judxDE/CuLgVVksOeEvKZ4azj6O5DvFfEslnORHMmP7EHOAKpBbfzuxzojSK7a0lxylVeG7CokCe3z73y7CmgQZK0mx/PkuVZEW2zr1TB5bw1dLF1HWYQArF7znQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6xgNWV+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3687f8fcab5so4198301f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722627316; x=1723232116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oLiqaitihQSNXgz5f78HG44TyzFMAf/LHbh+J7eSpw=;
        b=J6xgNWV+fUKnu1cPQV1AOiEu5mB5aR0R702EecCxwN8OWQKMJU3F4DRhq7DuBcTPNY
         B3ZbOIZYBzHRr74QaoyqkZYPDdxBdthV/JNj0lfGFGXzqXA+BAUyR33l/BjSj9NQGrBF
         izDi2Tu3XpUBIbveARmZoEuYfinKrCh1xuw5cS2ms4zomxCfyex+4tURLkJmpFLDjMBB
         yC/EfbK1YtRZ81TYElXOxh8S6u4ImVZDNW22h5gzpjYFY0b9fUQ0Civi2W4Neu9Q9it8
         VeWPruLYQ4fn2traV2a/Ps9dBJUB5aEkj+FXRFzf7iiIgfD7jN08bVSYI+r1Soob1Z7q
         PxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722627316; x=1723232116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oLiqaitihQSNXgz5f78HG44TyzFMAf/LHbh+J7eSpw=;
        b=HF1TtLtLvQSy0ftWrb4wL0iQytxaKsAoeWgW95XbR7AzK7x7C55cbJMJky5JDkOi+0
         ZpB7QaAalXMIMdGT8R47okrFhDpuEnzzzAK61L66ja2hHVJJTP4448Cby4YEdCdbGCPM
         yT/kPqLKvcCUyRNF0EqulYoFtuGS03QPHEOZByJd8jfqAwOI8iqcaYDLTI5IqLq3lsN3
         DSXrS0n5jhicVytjNuTndYeKeoewvK4UezX3/h16Sw750Frhr+sCZR6DbXopv3k8BHeK
         lypWpH3ldrrJgjTwkWWKcxP4HVP+M5WkhYe9gl6JV2+uEkDYbQ1yJn6FsD5aD3+f1hlS
         UAJw==
X-Forwarded-Encrypted: i=1; AJvYcCXyFMgPkIblSm+ix0lGOlzrl9bAnyJIdP0davJj1p0w3XgCbJFW/seM42cD+KvpvG0zcr4RZ6YkwhCKkOQhdcn4MCvZ4nmHGQQ8Nxuu
X-Gm-Message-State: AOJu0YwOcwio7bMiF9mNv1Ncrz5OLf7Ee06nZzWAsJ93UfV7jFEzxtCf
	6LQR+3bPtosZ6rKkujp10n1h8fapibV+Y4nSf0m+O4I4fHbZpNgXhataR0KrHQdQW2jeyeDibnC
	gjjQSs97UiEC4T+qt8hhwbSF3xok=
X-Google-Smtp-Source: AGHT+IHO+//mhJ7UiWBtmHs82HOupg+ipvayXga/iMIPnWbZbIW4TL/ZcwEKFYqcreRFfc3EVp3FFMLUEsLyKO2hFtA=
X-Received: by 2002:a5d:508c:0:b0:366:ebd1:3bc1 with SMTP id
 ffacd0b85a97d-36bbc0a8493mr2388276f8f.3.1722627315779; Fri, 02 Aug 2024
 12:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com> <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
 <CAG48ez0frEi5As0sJdMk1rfpnKRqNo=b7fF77Zf0cBHTFO_bjQ@mail.gmail.com>
In-Reply-To: <CAG48ez0frEi5As0sJdMk1rfpnKRqNo=b7fF77Zf0cBHTFO_bjQ@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 2 Aug 2024 21:35:04 +0200
Message-ID: <CA+fCnZc1HSSD0eNgg=KXGPOspmYHLbEExPHZASJ45AXSM1L83A@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Jann Horn <jannh@google.com>
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

On Fri, Aug 2, 2024 at 11:57=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> >
> > Let's reword this to:
> >
> > kasan_slab_pre_free - Check whether freeing a slab object is safe.
> > @object: Object to be freed.
> >
> > This function checks whether freeing the given object is safe. It
> > performs checks to detect double-free and invalid-free bugs and
> > reports them.
> >
> > This function is intended only for use by the slab allocator.
> >
> > @Return true if freeing the object is not safe; false otherwise.
>
> Ack, will apply this for v6. But I'll replace "not safe" with
> "unsafe", and change "It performs checks to detect double-free and
> invalid-free bugs and reports them" to "It may check for double-free
> and invalid-free bugs and report them.", since KASAN only sometimes
> performs such checks (depending on CONFIG_KASAN, kasan_enabled(),
> kasan_arch_is_ready(), and so on).

Ok!

> > kasan_slab_free - Poison, initialize, and quarantine a slab object.
> > @object: Object to be freed.
> > @init: Whether to initialize the object.
> >
> > This function poisons a slab object and saves a free stack trace for
> > it, except for SLAB_TYPESAFE_BY_RCU caches.
> >
> > For KASAN modes that have integrated memory initialization
> > (kasan_has_integrated_init() =3D=3D true), this function also initializ=
es
> > the object's memory. For other modes, the @init argument is ignored.
>
> As an aside: Is this actually reliably true? It would be false for
> kfence objects, but luckily we can't actually get kfence objects
> passed to this function (which I guess maybe we should maybe document
> here as part of the API). It would also be wrong if
> __kasan_slab_free() can be reached while kasan_arch_is_ready() is
> false, which I guess would happen if you ran a CONFIG_KASAN=3Dy kernel
> on a powerpc machine without radix or something like that?
>
> (And similarly I wonder if the check of kasan_has_integrated_init() in
> slab_post_alloc_hook() is racy, but I haven't checked in which phase
> of boot KASAN is enabled for HWASAN.)
>
> But I guess that's out of scope for this series.

Yeah, valid concerns. Documenting all of them is definitely too much, thoug=
h.

> > For the Generic mode, this function might also quarantine the object.
> > When this happens, KASAN will defer freeing the object to a later
> > stage and handle it internally then. The return value indicates
> > whether the object was quarantined.
> >
> > This function is intended only for use by the slab allocator.
> >
> > @Return true if KASAN quarantined the object; false otherwise.
>
> Same thing as I wrote on patch 2/2: To me this seems like too much
> implementation detail for the documentation of an API between
> components of the kernel? I agree that the meaning of the "init"
> argument is important to document here, and it should be documented
> that the hook can take ownership of the object (and I guess it's fine
> to mention that this is for quarantine purposes), but I would leave
> out details about differences in behavior between KASAN modes.
> Basically my heuristic here is that in my opinion, this header comment
> should mostly describe as much of the function as SLUB has to know to
> properly use it.
>
> So I'd do something like:
>
> <<<
> kasan_slab_free - Poison, initialize, and quarantine a slab object.
> @object: Object to be freed.
> @init: Whether to initialize the object.
>
> This function informs that a slab object has been freed and is not
> supposed to be accessed anymore, except for objects in
> SLAB_TYPESAFE_BY_RCU caches.
>
> For KASAN modes that have integrated memory initialization
> (kasan_has_integrated_init() =3D=3D true), this function also initializes
> the object's memory. For other modes, the @init argument is ignored.
>
> This function might also take ownership of the object to quarantine it.
> When this happens, KASAN will defer freeing the object to a later
> stage and handle it internally until then. The return value indicates
> whether KASAN took ownership of the object.
>
> This function is intended only for use by the slab allocator.
>
> @Return true if KASAN took ownership of the object; false otherwise.
> >>>

Looks good to me.

