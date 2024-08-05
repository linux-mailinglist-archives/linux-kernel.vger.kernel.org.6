Return-Path: <linux-kernel+bounces-274578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC576947A47
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4160AB225B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 11:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C613AD11;
	Mon,  5 Aug 2024 11:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vvtOSBt8"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8338155730
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856170; cv=none; b=jkDeHWY+wm23hhmzGdL2LQqXyO9BLDBDjpGMjEO7kTuZ5loSUwioF6IzRwnzfYHK1M75sCAo0b+0VwxE5qZhMJTl+YUhl+9cn2Kng4xCWKpSLzYvsu4NR8gsmqmyq8rb/CXpPPy/FvLHmX2pzW7tEsqIym+QMmEU9z2SDhCRMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856170; c=relaxed/simple;
	bh=CMrjytNlnDg8U2jHeWbZ90gwdBK8a42GFbXZHZPbHlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUJ0DkJzTtPVY6ehR2DLWWU0QxScTkhl/ZQ9AgYhIq5M2/490fS2JkNMlh1JQkIJnhgrZ2+QSijOTdGnQiT0luyl72ZEOYVXhCIuLGJjTY0zw9rg2+A5UmfsGjGuBFCn0SV7jeZkR+YvS1mWbnjch7S4gSyhTdPbYDEc2dJ60Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vvtOSBt8; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so11343a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722856167; x=1723460967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4Lfr7cWJZWVAHEZdC4tIJBE0idMw63JeT0pm5BZ7xI=;
        b=vvtOSBt8vIRCkdryWVTeez/1NAuo8vVgk6gYAcTKOvAdG5jy3ByBccPcfg5LdkyZqN
         sbRMlghyYYsojBdYgr7/vmDFvxCgL/ILjb3bzYNie3kw7vFBRbaiJo1tOWJ8Z1at3kPy
         STAIJGaHxc+oJTElTj9MTuv1OxnvxiwMQQzsdQ7BzakEqCiq8g6KDWCebQ4ZmTIO6y3Y
         i72O1k0U2uR6XHDr317c8Y5i62QduCEPcni9GPJaixQl/GYAaJqb67GPbYbD07u8rgy+
         XTgN/5LcnRLq/lxmxJwAmqINDWG8asK07YokYpWxebmrGA7CLx6oCxCSOIxLvbFl4faC
         HhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722856167; x=1723460967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4Lfr7cWJZWVAHEZdC4tIJBE0idMw63JeT0pm5BZ7xI=;
        b=Bnffm1AVKKTuDqMM/Dx0/t+PoND5du6b/lbuRv6ZVW2KIrCJxPOK5LIw5ASGGmIrJ0
         bo7JuBry5YcPDGRXseQXOgtaD7SrgZV2xBMMMqODjA8IAhV0hsgFdIcI5Sm9Ynxz7msh
         ntRtEwEUKZrMHMCa5aYvefsg3zU3wuC+/OD2uY+sQXuoB4cffJjeEg0xYWxerP4kKve2
         09iYIXKELDGJBS1LbOikt0pn9/gH1PhlXUAycTSKwo9mCMS9L7VgduOTrwqTSFdXSLwB
         3cayP40hfXNy1IMe3icZNPfrl+yLyn0Y+b+jK0Gyj0q3JKe6P0JXfN6J9Pe1h4BbF0/n
         TE2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOq/H1Y7teCDznuMQUCzZX/pVYs1IhmqBxEHKZnmbLY/1AnX5oy/n5LWlzLaXro+u+gcS9s0m4U7u6yG/pXoUlXjfOzYnDPm8XpqxQ
X-Gm-Message-State: AOJu0YwC2DKqzvyMptpHHXvZD7OFXYv9V0dQpy8ia8GYg54nyk7Rtapk
	LyXg8YSLvnO3Vx4FkEcWDHIyvdepoaggx1zt84TajUIbpKKjjbMrRiMEmKWqdVlkp6NJahq32cK
	XybD9mNl/O0HYOhUogaY8mndCpAwF6LpMf1ZQ
X-Google-Smtp-Source: AGHT+IFp87Hdx6GUQ1S1AEPzYYlgjbHanaDmgkICP7MLibR3DnxI+KS0tbUjMlWb5jGpuxF3ieM4UF/2QwlapV8GnpQ=
X-Received: by 2002:a05:6402:35d4:b0:5b4:df4a:48bb with SMTP id
 4fb4d7f45d1cf-5b9c1e5e74emr228803a12.0.1722856166424; Mon, 05 Aug 2024
 04:09:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-kasan-tsbrcu-v6-0-60d86ea78416@google.com>
 <20240802-kasan-tsbrcu-v6-2-60d86ea78416@google.com> <CANpmjNNadRtLijEZLgE3HpyCGW=gkhunsFZ9FmwFZrpyWGUrnA@mail.gmail.com>
In-Reply-To: <CANpmjNNadRtLijEZLgE3HpyCGW=gkhunsFZ9FmwFZrpyWGUrnA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 5 Aug 2024 13:08:50 +0200
Message-ID: <CAG48ez2Jsc2V1NfN1YOnx0e3-3BaVSdac7p_y9gnYL=9VW6cOw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To: Marco Elver <elver@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzbot+263726e59eab6b442723@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 11:02=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
> On Fri, 2 Aug 2024 at 22:32, Jann Horn <jannh@google.com> wrote:
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
> Acked-by: Marco Elver <elver@google.com>

Thanks!

> Looks good - let's see what the fuzzers will find with it. :-)
>
> Feel free to ignore the below comments if there isn't a v+1.
[...]
> > +config SLUB_RCU_DEBUG
> > +       bool "Enable UAF detection in TYPESAFE_BY_RCU caches (for KASAN=
)"
> > +       depends on SLUB_DEBUG
> > +       depends on KASAN # not a real dependency; currently useless wit=
hout KASAN
>
> This comment is odd. If it's useless without KASAN then it definitely
> depends on KASAN. I suppose the code compiles without KASAN, but I
> think that's secondary.

In my mind, SLUB_RCU_DEBUG is a mechanism on top of which you could
build several things - and currently only the KASAN integration is
built on top of it, but more stuff could be added in the future, like
some SLUB poisoning. So it's currently not useful unless you also
enable KASAN, but SLUB_RCU_DEBUG doesn't really depend on KASAN - it's
the other way around, KASAN has an optional dependency on
SLUB_RCU_DEBUG.

[...]
> > +#ifdef CONFIG_SLUB_RCU_DEBUG
> > +static void slab_free_after_rcu_debug(struct rcu_head *rcu_head)
> > +{
> > +       struct rcu_delayed_free *delayed_free =3D
> > +                       container_of(rcu_head, struct rcu_delayed_free,=
 head);
>
> Minor: Some of these line breaks are unnecessary (kernel allows 100+
> cols) - but up to you if you want to change it.

https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-l=
ong-lines-and-strings
says 80 columns is still preferred unless that makes the code less
readable, that's why I'm still usually breaking at 80 columns.

