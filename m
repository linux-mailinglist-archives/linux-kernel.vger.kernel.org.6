Return-Path: <linux-kernel+bounces-272485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAAB945CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798D72858A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CF91DE85F;
	Fri,  2 Aug 2024 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svYwLzs5"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593114A4E0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722596798; cv=none; b=ZVGKgExeW10N7e0ZJRVY8IMNIO14S7HXbdDoIevyqn6AWss8TAEDihiFFPEr7KeqrnUhH/ej6Opiv+JdoGoYRm8VUyrv9v1gB8M12kUSHvcQS/s0yhRkuOY/wns5GZNL8ou9DBpPycJzdOtah9uya+khrGZpT7RSbEWHz3ve8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722596798; c=relaxed/simple;
	bh=5IRTHivLq34T2ykcvHTl38UxamPXQC1eW6nlYjQae8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qg+J3TlmkYM5ppsLhbQt5dPvmhu/02L5wcMS+MhBqtUR8cg5+H1MvHob0ZCUDtMy7uCC97Soi7PTSGLI8jzOvr9WDyGr5dFO571LNmIrKclIUOQFcTUjoHaoLUVxE1+ZbXKboL+uBhBq0Ppm1cKV0n0X4tjtPH0Og8Pzv30w7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svYwLzs5; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so49676a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722596795; x=1723201595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRR6BpufkDTMSbKYLs5P5x4tc4mghVB2+YjYQfPNLdg=;
        b=svYwLzs5R42ikJjopDJ59+vulEBIKQyHMJwzK+duhtuelxFZM15eWBNBZjZ8Ma6CBb
         vglqugod5qCtUpNfwa3sx6JvrjvWrnU61Vl6GBtkekXT4PgG+4Aho1KAl110MF+yKIz1
         Vv+FXjp4EbgTzfFT1dZxw5OHUdlWr/tYyYd8CByuWirTfCkuLZjsPS6E9ZKKujWBl+vd
         IkaumGFFoZ2ez09U7/nYurmYsWpWOY83UvudqumzZCYe8P5JkIMSelyR+F/TjIZR/Z8v
         sI2M0i6BR8FB8SuGeinFua0yKPht8JDhdm1jcxLLHRSxf8ZMz9IYzglcpL/uD52mpx41
         2Emw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722596795; x=1723201595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRR6BpufkDTMSbKYLs5P5x4tc4mghVB2+YjYQfPNLdg=;
        b=vaotQo5E3RBsizdtBa3I87P5EMdCL2TfoMryI8mtSOpf6mY0xYbFUtsUJpjlMnme3x
         keiBxqqFDDhXVPEpcWwEs+YYrqKIpUVzYuP4kcyhu4rO9Ay5gZyWhwcO7Cs6wx1eca3z
         5ienm1pJa/Lf4sDEOee3d7kLK3cLe+UXlO4LKjUcm1O1v3bJIUdJUQoUjkf4XqGCE2YT
         1HbwcdwM6IJP7RHWUXjJRIzXtomnF0vwafW3cnXbBLQ7u1HvEruwS2C4GIk8CHCnMAEQ
         YUP0gLYVq8ATeCtvWZSVptPtieTCgYbtzTA6c7+QfuMLdRC5QDP95iVRgkQYL1/lVyMu
         CX8A==
X-Forwarded-Encrypted: i=1; AJvYcCVhLpWfFIwHQximySeYNPEKQ5gncNt+Hhedql3G1A9G492lAX9BVyGWGcxGnj8RH8oLGj3Tr4lyJ5GmHo4KQKhu3cX+H5A27BqGrDOr
X-Gm-Message-State: AOJu0Yw61Nzf41IC8P98N5x1Uwj0z3WcRuJBYW+NgnlE/Qa1DxlqLMLu
	WT1dBQ5/Ew5ss4w/+D0VhKThAsaNue5I1rGeofEkPLJeHfjUKVPsTCdGzu6OlW1dw7Dx+2c0w7d
	CsKOHvNid1vVQEaiAKpVg4GGLyHQP4u94zK+1
X-Google-Smtp-Source: AGHT+IGWFqch3T7ul+u9DuiIi+aNMgGuXM7yxoPAhtJNXlh8CEGVVKTP3eKfrIKv3A6mn7sHx0ibWwdH19lgz2vXcKE=
X-Received: by 2002:a05:6402:5206:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5b8713605e3mr112092a12.7.1722596794707; Fri, 02 Aug 2024
 04:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-1-48d3cbdfccc5@google.com> <CA+fCnZfURBYNM+o6omuTJyCtL4GpeudpErEd26qde296ciVYuQ@mail.gmail.com>
 <CAG48ez12CMh2wM90EjF45+qvtRB41eq0Nms9ykRuf5-n7iBevg@mail.gmail.com> <CA+fCnZf++VKo-VKYTJsuiYeP9LJoxHdd3nk1DL+tZP1TOQ9xrw@mail.gmail.com>
In-Reply-To: <CA+fCnZf++VKo-VKYTJsuiYeP9LJoxHdd3nk1DL+tZP1TOQ9xrw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 13:05:58 +0200
Message-ID: <CAG48ez0NZYOwafGfXw6pN91zeFH60CSdeQrTLgJffrbu1xPTBA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] kasan: catch invalid free before SLUB
 reinitializes the object
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:54=E2=80=AFPM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
> On Thu, Aug 1, 2024 at 6:01=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> >
> > > > @@ -503,15 +509,22 @@ bool __kasan_mempool_poison_object(void *ptr,=
 unsigned long ip)
> > > >                 kasan_poison(ptr, folio_size(folio), KASAN_PAGE_FRE=
E, false);
> > > >                 return true;
> > > >         }
> > > >
> > > >         if (is_kfence_address(ptr))
> > > >                 return false;
> > > > +       if (!kasan_arch_is_ready())
> > > > +               return true;
> > >
> > > Hm, I think we had a bug here: the function should return true in bot=
h
> > > cases. This seems reasonable: if KASAN is not checking the object, th=
e
> > > caller can do whatever they want with it.
> >
> > But if the object is a kfence allocation, we maybe do want the caller
> > to free it quickly so that kfence can catch potential UAF access? So
> > "return false" in that case seems appropriate.
>
> Return false would mean: allocation is buggy, do not use it and do not
> free it (note that the return value meaning here is inverse compared
> to the newly added check_slab_allocation()). And this doesn't seem
> like something we want for KFENCE-managed objects. But regardless of
> the return value here, the callers tend not to free these allocations
> to the slab allocator, that's the point of mempools. So KFENCE won't
> catch a UAF either way.

Oooh, right, I misunderstood the semantics of the function. I'll
change it in v6.

