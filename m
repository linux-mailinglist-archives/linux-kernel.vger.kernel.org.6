Return-Path: <linux-kernel+bounces-278751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A653094B44C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C90283233
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDA333F7;
	Thu,  8 Aug 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIJmLyDc"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E520ED
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723077881; cv=none; b=tacxoxF9o38RzGuu5JGR0WeWt5qVquQCKYYoQ8vKy/oGLqHkCfDnewEyHTtb52m1SwonCgOXVnIaRBE+AXYiWSZLdCjeLyAAck5rICU+MzvSyJ6mFiVbQwAoCWQEmHX2fGTrmECCNO3PWAc8chTkAfNxLmphKS5iMaV2gxWahzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723077881; c=relaxed/simple;
	bh=tkB/yxMfi9tH2MYGu9S+eSvgA1ZmBxOUJIsSG4B72Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdArQAySdP8MN+acNC7B3bPtZggyLzVSnfbOGYTi9X6IEg5tYpMuNPlrKZW7A8rOC2bjr57c0up+W5FVUlbpR1j5jKk2PeqjooX4SsknUMVO8o0abXasjSL8aRVP/IyF8Ip1GV+33/SC6W8h1aB2s56p9u8Yus/EN7GO5ZWt+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIJmLyDc; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso8308a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723077878; x=1723682678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBshlEm/hRezkXwc4E0KD/35MsKepvejjcK36JSLpHw=;
        b=jIJmLyDcl9wHMMZFVZBljdw8wVohyPXWVD+c16bSXqjTMPSuVDOA8Ofp8sPr/qBypb
         PoDzjFlYpbiyBJGkunq5/cwZPOe09cmhnOFWGWbS9uGTFz/xbWi28ztdfKm9kViWQyAp
         YxnC4iPLF1jNB7ny0IgdDEvTkzlgYY7N3DTZfIu8CF+GoxOED9PnL2FgA5K2oalX/P2s
         znjluJOImPDP1dGiJKiSdTa9Yw9l3UNuD6GpOd27htBbq/9jfS2yAkwFFNwb93+3DFEQ
         CvrMnQWLXf8cqvXyQTbI9LUqQUomWTytcWykTJSKbRBaA5aMwyuGIrpaZGDvTrZB4yOd
         +HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723077878; x=1723682678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBshlEm/hRezkXwc4E0KD/35MsKepvejjcK36JSLpHw=;
        b=Upq1cgXTaF2Bx1O//bkoIf3CZDaiKClIDNMW5bFp7+JMOOyxrvSu4FAMyR7nNgby9B
         MF4KeBWoRtXXZAbHj6BC5x4mbyGgRQg6HgjxNYEOUEu7vWZswLWTGepUIO4VYL748usz
         4n7cXylT4d9tsDtTR8KBVgYZfKG8oTXIidKBG0ewqQjcYVVkD74/MAUEKRMG3wO13xTY
         /w0Amn9oW2eO+zNmOaJbhCvkGL+T5HNSEFPGMV62fsBBKJ+cYgiY7P9LEU2J+rAZPKLP
         Iqx9+pgepzXk0yyGo1rTb9SdB0TyWWZ/di9zMQLHGKYCmE5bqETLIqQD9LMA+E+Avdta
         9hfg==
X-Forwarded-Encrypted: i=1; AJvYcCXegksvpBzYXEwxixi9GCUfh0/tAnEHsdfbTEUK5d9Tp/oQVmkpFZ1ZNIIQd02WrcM+4a+JoYSqXrzOtqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySMZ0DiUJH7DgPj0BkST2M7qLV57YiLBGawpJhXsXaAO6+p+ym
	iB01kvdbxpBDKPjvrum0XqwMpzK8Xpc5xtnkKq6LtftwuuiNzjapcu0K5KSqz6g+IozZW54M12v
	Cl1NGDeJe+y6UWyE9FJIQzZH4IN3N93PieCKu
X-Google-Smtp-Source: AGHT+IFpSNLTowScUK0fEebUg+Q3Xnxts9HFjMWAOTXuidhtMpb/V16+i/w5kNL0GLm3kG2zTXSX+ecuI5sC7wHI46U=
X-Received: by 2002:a05:6402:3496:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5bbb1797fd1mr44545a12.5.1723077877633; Wed, 07 Aug 2024
 17:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
 <20240802-kasan-tsbrcu-v6-2-60d86ea78416@google.com> <c41afd73-97b4-4683-96a1-0da4a4dfeb2b@suse.cz>
In-Reply-To: <c41afd73-97b4-4683-96a1-0da4a4dfeb2b@suse.cz>
From: Jann Horn <jannh@google.com>
Date: Thu, 8 Aug 2024 02:44:00 +0200
Message-ID: <CAG48ez0VHMFNAFGKV5yPCrJw16-_avDHJB+YTJaxaXuC6+WSYw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, David Sterba <dsterba@suse.cz>, Marco Elver <elver@google.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 11:26=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
> On 8/2/24 22:31, Jann Horn wrote:
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
> >
> > For now I've configured Kconfig.debug to default-enable this feature in=
 the
> > KASAN GENERIC and SW_TAGS modes; I'm not enabling it by default in HW_T=
AGS
> > mode because I'm not sure if it might have unwanted performance degrada=
tion
> > effects there.
> >
> > Note that this is mostly useful with KASAN in the quarantine-based GENE=
RIC
> > mode; SLAB_TYPESAFE_BY_RCU slabs are basically always also slabs with a
> > ->ctor, and KASAN's assign_tag() currently has to assign fixed tags for
> > those, reducing the effectiveness of SW_TAGS/HW_TAGS mode.
> > (A possible future extension of this work would be to also let SLUB cal=
l
> > the ->ctor() on every allocation instead of only when the slab page is
> > allocated; then tag-based modes would be able to assign new tags on eve=
ry
> > reallocation.)
> >
> > Tested-by: syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Actually, wait a second...
>
> > +#ifdef CONFIG_SLUB_RCU_DEBUG
> > +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
> > +{
> > +     struct rcu_delayed_free *delayed_free =3D
> > +                     container_of(rcu_head, struct rcu_delayed_free, h=
ead);
> > +     void *object =3D delayed_free->object;
> > +     struct slab *slab =3D virt_to_slab(object);
> > +     struct kmem_cache *s;
> > +
> > +     if (WARN_ON(is_kfence_address(object)))
> > +             return;
> > +
> > +     /* find the object and the cache again */
> > +     if (WARN_ON(!slab))
> > +             return;
> > +     s =3D slab->slab_cache;
> > +     if (WARN_ON(!(s->flags & SLAB_TYPESAFE_BY_RCU)))
> > +             return;
> > +
> > +     /* resume freeing */
> > +     if (!slab_free_hook(s, object, slab_want_init_on_free(s), true))
> > +             return;
> > +     do_slab_free(s, slab, object, object, 1, _THIS_IP_);
> > +     kfree(delayed_free);
>
> This will leak memory of delayed_free when slab_free_hook() returns false
> (such as because of KASAN quarantine), the kfree() needs to happen always=
.
> Even in the WARN_ON cases but that's somewhat less critical.

... oh. Indeed. I guess really I can just move the kfree(delayed_free)
up before the first bailout, we're not accessing anything in it after
loading the ->object member...

> Thanks to David Sterba for making me look again, as he's been asking me
> about recent OOMs in -next with heavy kmalloc-32 cache usage (delayed_fre=
e
> is 24 bytes) and CONFIG_SLUB_RCU_DEBUG was so far almost certainly confir=
med.

Nice catch...

I guess I'll get to send a v7 of the series.

