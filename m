Return-Path: <linux-kernel+bounces-272345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE86945A85
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8368A1F242F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54F1D362A;
	Fri,  2 Aug 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MeCQGLUs"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7611EB4B6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722589834; cv=none; b=qdpZsbfp5pQTffpnMj82xp72CyKnxibFsk00BdkD61QeLaRniLF33UIN6hS2SuSkMG/3emtNyw+awkdFmIYXD8SBHu+D/dr/Gv6K2kaXZ/5FWhFpfFsIbzlUn7gS7Mi+cWU9ihsvv2eryE7xQJIG9hxsrW2SIZRZxN2sgiYQKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722589834; c=relaxed/simple;
	bh=YyMU+wWdCaQSGzF5f2vwq7ciyShz22vrxzx8w4f7VVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUhrC8p/ERyWm6bwivFTkMTCqftfXwzLbMQs4SnQJrGh4PR0k3CfT5aNHJj3Q7NDZtp7LMm03QeVVZBkmsmJBkncvFAcFdnRV+H+Me5XT+bs7Zd/1IBEPV4XbnLa8z5c1YgGR1dtBtNDiGZ5YZqRHCIb155Ucbr2/6Wt1DCqbuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MeCQGLUs; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a869e3e9dfso49230a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722589831; x=1723194631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdfVeEEYqxRlg+wsbTTfgEpqIH6PLQRg/ETvJe3ixN4=;
        b=MeCQGLUsyszy43rnnwtqKWGZzmzp5SnNSuGj3GXYMvaqXmyIuQIXcbK+dFZbhWU+Bz
         7UIGRS8FDgxjRufMrNQhd5ssWCROnT4AS9dbng62Fl1b9e+a7p5XLdPxRt5wqw4Gwezs
         Cn34DaDIAVoUUZ2zDZB7aDYzL4L4f8tzbH3mf8KdSd4ZRwAPZVUq++LnLNyaSgbHS1YV
         PeI84jqqeHtKaPq5rJWvmPRfaFzgEWYJL2wmAIgVzNuRZ8nhIoTSKqn70yZj0+uoWQs0
         EUFyqRQ+mF2jwWfESb9i6hDCMLMIlbwRshkM4Jcuc4kcwor4t9VDDs1BdsY3BTsvJZxA
         L/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722589831; x=1723194631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdfVeEEYqxRlg+wsbTTfgEpqIH6PLQRg/ETvJe3ixN4=;
        b=szl3pCbnL5pNUKUTgVirKlNBkaJTt+KXzW4HGFyTweQrTho7ngUw+nXjv+WjcBGX5S
         +Qe6ex6bOckpQeiHC8P7O+pyQwNObMndsewSjIEKMUzaumeRtGBn1SQNBSUviHq2d2cd
         UQHC6kPrkwUBm5gMf1bNj6dr8vj91rNY0CTlCGajU8ag62vNaqHjUvhzgGFUVIwDIl5d
         BtSez/T0XedkI9WAPd/KZSjFuvkRNBgUGbFENOA/IU3fqUqmkmvOnNBnxGBgMkXA+P6w
         +7/6FLT+KRzDbwCdAZCf+Ep9/GDD0ofqQ/ZdmtwIYONDqfWYrC51LLea2Yo8nExOUxik
         uZJg==
X-Forwarded-Encrypted: i=1; AJvYcCW4Q8GxDjxEjttK1E0XLTf4jY7Wj52AJnMjI9IEEaixUyr1VasGyzycNcFgcGdEjrv6jHxJouxNn+Inc5s08Jn0Cj19MCn0GwUGvm/0
X-Gm-Message-State: AOJu0YzX6kKnGKFARcws/cNbBTlCDNk9hHZ5Wp3rVEyl7srqVwMoLCXn
	eNnCoJf0lQU8T+ObhoVqUTSDYHmzWjQSUb8yvMyO0fJyPzZwmkNeBVWbpvHjBA32iWnu83yERis
	qq9X1k5yy+xmsSQHgkQHjbihyl6ZfZEdRtuek
X-Google-Smtp-Source: AGHT+IGugm+hPfyfakoQaLgMekarHdSbFiVnUtaejE1K1ZAA7bomT9rRqhXgPo0o8RdCEcX65x57QeQ+/tw0S8F9fiM=
X-Received: by 2002:a05:6402:1747:b0:5b8:ccae:a8b8 with SMTP id
 4fb4d7f45d1cf-5b8ccaeab1bmr32772a12.3.1722589830338; Fri, 02 Aug 2024
 02:10:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730-kasan-tsbrcu-v5-0-48d3cbdfccc5@google.com>
 <20240730-kasan-tsbrcu-v5-2-48d3cbdfccc5@google.com> <CA+fCnZeq8JGSkFwGitwSc3DbeuoXnoyvC7RgWh6XSG1CoWH=Zg@mail.gmail.com>
In-Reply-To: <CA+fCnZeq8JGSkFwGitwSc3DbeuoXnoyvC7RgWh6XSG1CoWH=Zg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 2 Aug 2024 11:09:52 +0200
Message-ID: <CAG48ez1guHcQaZtGoap7MG1sac5F3PmMA7XKUH03pEaibvaFJw@mail.gmail.com>
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

On Thu, Aug 1, 2024 at 2:23=E2=80=AFAM Andrey Konovalov <andreyknvl@gmail.c=
om> wrote:
> On Tue, Jul 30, 2024 at 1:06=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
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
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> But see a comment below.
>
> > ---
> >  include/linux/kasan.h | 11 +++++---
> >  mm/Kconfig.debug      | 30 ++++++++++++++++++++
> >  mm/kasan/common.c     | 11 ++++----
> >  mm/kasan/kasan_test.c | 46 +++++++++++++++++++++++++++++++
> >  mm/slab_common.c      | 12 ++++++++
> >  mm/slub.c             | 76 +++++++++++++++++++++++++++++++++++++++++++=
++------
> >  6 files changed, 169 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 34cb7a25aacb..0b952e11c7a0 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -194,28 +194,30 @@ static __always_inline bool kasan_slab_pre_free(s=
truct kmem_cache *s,
> >  {
> >         if (kasan_enabled())
> >                 return __kasan_slab_pre_free(s, object, _RET_IP_);
> >         return false;
> >  }
> >
> > -bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init);
> > +bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init,
> > +                      bool after_rcu_delay);
>
> What do you think about renaming this argument to poison_rcu? I think
> it makes the intention more clear from the KASAN's point of view.

Hm - my thinking here was that the hook is an API between SLUB and
KASAN, and so the hook definition should reflect the API contract that
both SLUB and KASAN have to know - and in my head, this contract is
that the parameter says whether SLUB guarantees that an RCU delay has
happened after kmem_cache_free() was called.
In my mind, SLUB tells KASAN what is going on and gives KASAN a chance
to take ownership of the object, but doesn't instruct KASAN to do
anything specific.

And "poison" is ambiguous - in SLUB, "poison" normally refers to
overwriting object contents with a poison value, which currently
wouldn't be allowed here due to constructor slabs.

I guess another way to describe the meaning of the argument with its
current value would be something like "even though the object is an
object with RCU lifetime, the object is guaranteed to no longer be in
use". But I think the simplest way to describe the argument as
currently defined is "an RCU grace period has passed since
kmem_cache_free() was called" (which I guess I'll add to the
kasan_slab_free doc comment if we keep the current naming).

I guess I could also change the API to pass something different - like
a flag meaning "the object is guaranteed to no longer be in use".
There is already code in slab_free_hook() that computes this
expression, so we could easily pass that to KASAN and then avoid doing
the same logic in KASAN again... I think that would be the most
elegant approach?

> >  /**
> >   * kasan_slab_free - Possibly handle slab object freeing.
> >   * @object: Object to free.
>
> @poison_rcu - Whether to skip poisoning for SLAB_TYPESAFE_BY_RCU caches.
>
> And also update the reworded comment from the previous patch:
>
> This function poisons a slab object and saves a free stack trace for
> it, except for SLAB_TYPESAFE_BY_RCU caches when @poison_rcu is false.

I think that's a KASAN implementation detail, so I would prefer not
putting that in this header.

