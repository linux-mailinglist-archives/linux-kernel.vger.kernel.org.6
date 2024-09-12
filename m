Return-Path: <linux-kernel+bounces-326903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B32976E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC936B22F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABCE19599C;
	Thu, 12 Sep 2024 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4pTY9p/"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B971B9B3E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156749; cv=none; b=MRUE0XdmtBBOCp04vPDhbimVCHjmoq6pCvcAMMq/L9XnhKzU2vD8m+hD35jYEpgNice4aClduSOioKBbbcEMKZSmgNmNxcYPrkbZFleKZev2zMXtFfjGgSy/8qMM41jllUMFJFEmeHtb/EeloU4jXdCNvm+jlRimlPEkwkmsFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156749; c=relaxed/simple;
	bh=ZRaI2PSJ/nRX+fPnK4kI2jK3HRbntl97iav/M7nPcHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqO3z1+Obr6cEWBH2nT6O/xrI9+8xSTuR2C8i46yPwUc/W6mBJLwFfwo5LFghiOXzsvsigWKCa3Vm5A0DZUmpScAwip3yk92Mtxwa3KbRrdm0mNFTgAA6L8qTxfK/FMC8m6LLmcpK49iAzgPU7kpYOM6rBvIFSYJBBs+3qEq4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4pTY9p/; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so19332a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726156745; x=1726761545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzkSOjtlRgEJBE0QzC4qfBZck+h9F5FrZHcRFt4ekK8=;
        b=q4pTY9p/wUQTKZYqIyxX822+/rIbrjZWnJ8MdRWbcA3SGucp7oTZdlAT8CYp4krXGd
         mJPBniLyldP2pl6LAyReMb5zWhfJ53hnO84gvFumouNV7L/w8Gds+7iLEkGIuSMfWrPX
         xk427oxUeAUhHjVtviSDZBXtEtGt63unbkKHM7ZdjkqPG3T2+9pCK/heUTaSM9S87uLN
         7sRgN7VoDKtZeElOsfyTVE+rUNL0DvjJO14CvU/h90PaeYK7d2S3Z8Y/GJDrVu1CfaC4
         XGqiSQbPNyVE83jv9Pc7fjqd5woX9BeWR+cqWK/lhVUmwPXhiMazx6P0Jv6PG75KDsLY
         VLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726156745; x=1726761545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzkSOjtlRgEJBE0QzC4qfBZck+h9F5FrZHcRFt4ekK8=;
        b=JnNecgMnx+hwDZsd0LWYtkaS4I5vyGsH1pBNmMF+DMVFymZJgMNXXJX2qimz0PuDMJ
         N2bxiDjh7IjZ40cm61v1OHa+PYhDgov0soorJxovwfusWEPuCKfhOMc4tONinpihirDJ
         Rhym/iVfEqoOZvuOEZrKtpWQYg429KL6hVoS+NW8bJrBtTnkdALMYgQdinUDpzhVV81Y
         FzUUQUFdkNphv7j46QlN1CD1k3O5Dq0PQcjmcyHLFUEtzNXqtAJoMVZV9SUb1vOQ/O9P
         SH4SBaNzpXLOxKbSvIa5uNY4L2xGr9QC+YLyblYh7fYVDSQmdgGGLDg0EsDcmYH5vzfQ
         kBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/yEBBFw1FVEE/TKHsmL5+JlD8lV0EUS0zR7Ez9/RyZR1g5gZ92vNODB1M+AVbW1D3PLwq3ZK8HxA4zxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWy3wNPY6h4YoZCpKkjPsw3LO/PAwp9/5jC2kFH2zB8geePRc
	Pgi0wpofc/EPD3gLWsb1adjOZZCeGJSuQUd0JKIC7TJ1SN+AGNJ6J+75fX6fnDYt7I/5Fpm69X+
	1gQP1c8HgN/GiHWoCh/pdsKnp6twrEl01WuDV
X-Google-Smtp-Source: AGHT+IHsTcSdl2wYCab3UQ1UwOoblz6Kyhoy04ecJapJrovEhl/+EJxUnbtQa5b/7UIj3ct3VL+haxAvOyHQNaUBk2A=
X-Received: by 2002:a05:6402:1d48:b0:5c2:5251:ba5c with SMTP id
 4fb4d7f45d1cf-5c41439fd9dmr529985a12.0.1726156744526; Thu, 12 Sep 2024
 08:59:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809072532.work.266-kees@kernel.org> <20240809073309.2134488-5-kees@kernel.org>
 <CAJuCfpHOqKPzbbkULpWU5g1-8mTLXraQM4taHzajY_cJ-YFWgQ@mail.gmail.com> <202409111523.AEAEE48@keescook>
In-Reply-To: <202409111523.AEAEE48@keescook>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Sep 2024 08:58:48 -0700
Message-ID: <CAJuCfpEw1fsuQjDcS23yZ-WE+WoA0oKArs=Q=G14Bh-509AYgA@mail.gmail.com>
Subject: Re: [PATCH 5/5] slab: Allocate and use per-call-site caches
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>, Jann Horn <jannh@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, jvoisin <julien.voisin@dustri.org>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 3:30=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 10:03:56AM -0700, Suren Baghdasaryan wrote:
> > On Fri, Aug 9, 2024 at 12:33=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > >
> > > Use separate per-call-site kmem_cache or kmem_buckets. These are
> > > allocated on demand to avoid wasting memory for unused caches.
> > >
> > > A few caches need to be allocated very early to support allocating th=
e
> > > caches themselves: kstrdup(), kvasprintf(), and pcpu_mem_zalloc(). An=
y
> > > GFP_ATOMIC allocations are currently left to be allocated from
> > > KMALLOC_NORMAL.
> > >
> > > With a distro config, /proc/slabinfo grows from ~400 entries to ~2200=
.
> > >
> > > Since this feature (CONFIG_SLAB_PER_SITE) is redundant to
> > > CONFIG_RANDOM_KMALLOC_CACHES, mark it a incompatible. Add Kconfig hel=
p
> > > text that compares the features.
> > >
> > > Improvements needed:
> > > - Retain call site gfp flags in alloc_tag meta field to:
> > >   - pre-allocate all GFP_ATOMIC caches (since their caches cannot
> > >     be allocated on demand unless we want them to be GFP_ATOMIC
> > >     themselves...)
> >
> > I'm currently working on a feature to identify allocations with
> > __GFP_ACCOUNT known at compile time (similar to how you handle the
> > size in the previous patch). Might be something you can reuse/extend.
>
> Great, yes! I'd love to check it out.
>
> > >   - Separate MEMCG allocations as well
> >
> > Do you mean allocations with __GFP_ACCOUNT or something else?
>
> I do, yes.
>
> > > +static void alloc_tag_site_init_early(struct codetag *ct)
> > > +{
> > > +       /* Explicitly initialize the caches needed to initialize cach=
es. */
> > > +       if (strcmp(ct->function, "kstrdup") =3D=3D 0 ||
> > > +           strcmp(ct->function, "kvasprintf") =3D=3D 0 ||
> > > +           strcmp(ct->function, "pcpu_mem_zalloc") =3D=3D 0)
> >
> > I hope we can find a better way to distinguish these allocations.
> > Maybe have a specialized hook for them, like alloc_hooks_early() which
> > sets a bit inside ct->flags to distinguish them?
>
> That might be possible. I'll see how that ends up looking. I don't want
> to even further fragment the alloc_hooks_... variants.
>
> >
> > > +               alloc_tag_site_init(ct, false);
> > > +
> > > +       /* TODO: pre-allocate GFP_ATOMIC caches here. */
> >
> > You could pre-allocate GFP_ATOMIC caches during
> > alloc_tag_module_load() only if gfp_flags are known at compile time I
> > think. I guess for the dynamic case choose_slab() will fall back to
> > kmalloc_slab()?
>
> Right, yes. I'd do it like the size checking: if we know at compile
> time, we can depend on it, otherwise it's a run-time fallback.
>
> >
> > > @@ -175,8 +258,21 @@ static bool alloc_tag_module_unload(struct codet=
ag_type *cttype,
> > >
> > >                 if (WARN(counter.bytes,
> > >                          "%s:%u module %s func:%s has %llu allocated =
at module unload",
> > > -                        ct->filename, ct->lineno, ct->modname, ct->f=
unction, counter.bytes))
> > > +                        ct->filename, ct->lineno, ct->modname, ct->f=
unction, counter.bytes)) {
> > >                         module_unused =3D false;
> > > +               }
> > > +#ifdef CONFIG_SLAB_PER_SITE
> > > +               else if (tag->meta.sized) {
> > > +                       /* Remove the allocated caches, if possible. =
*/
> > > +                       void *p =3D READ_ONCE(tag->meta.cache);
> > > +
> > > +                       WRITE_ONCE(tag->meta.cache, NULL);
> >
> > I'm guessing you are not using try_cmpxchg() the same way you did in
> > alloc_tag_site_init() because a race with any other user is impossible
> > at the module unload time? If so, a comment mentioning that would be
> > good.
>
> Correct. It should not be possible. But yes, I will add a comment.
>
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 855c63c3270d..4f01cb6dd32e 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -302,7 +302,20 @@ config SLAB_PER_SITE
> > >         default SLAB_FREELIST_HARDENED
> > >         select SLAB_BUCKETS
> > >         help
> > > -         Track sizes of kmalloc() call sites.
> > > +         As a defense against shared-cache "type confusion" use-afte=
r-free
> > > +         attacks, every kmalloc()-family call allocates from a separ=
ate
> > > +         kmem_cache (or when dynamically sized, kmem_buckets). Attac=
kers
> > > +         will no longer be able to groom malicious objects via simil=
arly
> > > +         sized allocations that share the same cache as the target o=
bject.
> > > +
> > > +         This increases the "at rest" kmalloc slab memory usage by
> > > +         roughly 5x (around 7MiB), and adds the potential for greate=
r
> > > +         long-term memory fragmentation. However, some workloads
> > > +         actually see performance improvements when single allocatio=
n
> > > +         sites are hot.
> >
> > I hope you provide the performance and overhead data in the cover
> > letter when you post v1.
>
> That's my plan. It's always odd choosing workloads, but we do seem to
> have a few 'regular' benchmarks (hackbench, kernel builds, etc). Is
> there anything in particular you'd want to see?

I have a stress test implemented as a loadable module to benchmark
slab and page allocation times (just a tight loop and timing it). I
can clean it up a bit and share with you.

>
> > > +static __always_inline
> > > +struct kmem_cache *choose_slab(size_t size, kmem_buckets *b, gfp_t f=
lags,
> > > +                              unsigned long caller)
> > > +{
> > > +#ifdef CONFIG_SLAB_PER_SITE
> > > +       struct alloc_tag *tag =3D current->alloc_tag;
> > > +
> > > +       if (!b && tag && tag->meta.sized &&
> > > +           kmalloc_type(flags, caller) =3D=3D KMALLOC_NORMAL &&
> > > +           (flags & GFP_ATOMIC) !=3D GFP_ATOMIC) {
> >
> > What if allocation is GFP_ATOMIC but a previous allocation from the
> > same location (same tag) happened without GFP_ATOMIC and
> > tag->meta.cache was allocated. Why not use that existing cache?
> > Same if the tag->meta.cache was pre-allocated.
>
> Maybe I was being too conservative in my understanding -- I thought that
> I couldn't use those caches on the chance that they may already be full?
> Or is that always the risk, ad GFP_ATOMIC deals with that? If it would
> be considered safe attempt the allocation from the existing cache, then
> yeah, I can adjust this check.

Well, you fall back to kmalloc_slab() which also might be full. So,
how would using an existing cache be different?

>
> Thanks for looking these over!
>
> -Kees
>
> --
> Kees Cook

