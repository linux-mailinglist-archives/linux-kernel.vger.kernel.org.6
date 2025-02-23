Return-Path: <linux-kernel+bounces-527570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415AAA40CB1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 05:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4EF17C24D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 04:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA171C860F;
	Sun, 23 Feb 2025 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oTs7604J"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144221C84CD
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 04:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740284700; cv=none; b=cPix2v+yxdnk/72uwaQEY1dnjvfdqJosk/aFQkXCoPR/EZO9/87HfeqGQGTh9P1ddGYS0ihwWkizNKUK4Wmo0L8l6JHR61LekVkRFXMjx8fibMYqgm8cKIOVvrh8X9hm2EpBP8V8b/4YeKrSR1SLqU8u9HIC5so0OZSKGgXN0b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740284700; c=relaxed/simple;
	bh=9GP2lBa/7rb4R1z1gLFL28iPgxNWPnJIHbpv1+3wKHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byS5hW+3JyKCMlYz0vC7kD1VCwOzzdQi/fd9jovmzyspArfpJbXR7g9Crnig9dLOyn6zMIBNGkSlsJcSrMkr2ruFHUSdAjOeAPMyQMJIXtDDaIoXRG3UaIeyom/gkMNliP/1L9Y+DZIA6cIsOru3mGQApNeLSdAMFI6M3Z2KVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oTs7604J; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471f1dd5b80so165371cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740284698; x=1740889498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpuQrwj5kn8T28pwd/be4/nwdyPl0g5tN+YxiK2nm1I=;
        b=oTs7604JlwUsnwbwrsAwr/w20A4mJPhk08S3GNxXWAM8SXu2oPBTg99OhytbmEa7S1
         Oymje22A4lIM68MzpULZxuYY3jCJYPShiUXQEEu/r2SYVkaytelgZeqNC2sQf8YfF9Oc
         TsJ9YEzB8j2pntQrNP6gdJrxWAsPJQCLqTAEbBg5K9VM5olI5ldOxEBcrR0/HY7QgalY
         OMIsO4m+ASxUVSO5p4r+F1+BR5OOCXHd2SCMb4HyhAsH8x7EYhi31gfROwjz5J7LOTC0
         xUWHZV53McJTa54UeCG4rP1ybeN+rBim+L2VN6efrPc/pKDGdp/0FI6Zj60Kt9GB8P4G
         GmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740284698; x=1740889498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpuQrwj5kn8T28pwd/be4/nwdyPl0g5tN+YxiK2nm1I=;
        b=jvyGdca7NxBNa/BJRjzz2f+Fo2UGcpN26Y1itZ/mV73esGVtEFcS9EhTOWZKLZs7/O
         /uplcDLiB29vpdMKij7saoVMqd9y6hnZrPEZL73o7p9CppsB6DjGSXHfstmYBIsOlRT6
         xQgMkpCBW6Tl7HWnI4QxLLwbjkhvTQoJ4MejvpBn0ssaUAryP3xcIPTvdFTtMxsOqAVH
         xS7XfjVzAy1L6FRL6WlSMSXjnn0sfthXVeE1q1yF+IYG3oDu3PhZKWJdxMc21QEymv9e
         Vi3k9RqS0Efq757mVQmt/FWgJAQ7h5pRBCPuCgGz+X+KVadf4F1Q/50wqL9dHdbg8pG/
         ioQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/ozth8+osVaXmYTdXqgh6bobnYo2tdgidALVr4lkPn6vnL+pCfm0kozi7Ugks14j4kG94Jb+2fdLHrZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMYuwDZS0uz4D7l9ir46QH+2m4eGc7U3r7zNNpVFD1nqXEESc
	vk/cUxEIzC3kukYg6AD9xnn2sN+g68nU2ExEg96itBXepiqabqYX2dgeXFHW2dtU2NC9hIaBYE+
	0KqXFvG6FxwOfPCPt/fBAnvxwioA7TlNROovw
X-Gm-Gg: ASbGnct8yRDr0oE6d2zfR1nNDCJqrlHs0Lh40wbeBQ+aVptyiCAtma8GUrqqIhG6saw
	3KrJVvBloA9noGaAc4CTh3f9ERI2xKhK1BAxQLVBat++Qmo4aPsuZYCyBEPqDt8zZhnmzWpiho2
	Hn3m3eGvA=
X-Google-Smtp-Source: AGHT+IHqlzzGDmchqwuv8tYa4UkHB33x2EQ4/CZTGjQcdIRYOou0hG8nG/b3fkWrYXhGj3FEx8URbFUtx3hdrLHzmmQ=
X-Received: by 2002:ac8:7c49:0:b0:471:eab0:ef21 with SMTP id
 d75a77b69052e-47234bc7c92mr2878751cf.13.1740284697438; Sat, 22 Feb 2025
 20:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz> <20250214-slub-percpu-caches-v2-8-88592ee0966a@suse.cz>
In-Reply-To: <20250214-slub-percpu-caches-v2-8-88592ee0966a@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 22 Feb 2025 20:24:46 -0800
X-Gm-Features: AWEUYZkeoIfRGvLjXhEb5mYFlAdmLxCXFljBSmvRWT3okNr4_KEdDGtF6irOEXA
Message-ID: <CAJuCfpGOwZY=MSizk-xx9R4cBBP0MgYA0MQhAv9Svf0Yt1DgjQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/10] tools: Add testing support for changes to
 rcu and slab for sheaves
To: Vlastimil Babka <vbabka@suse.cz>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:27=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Make testing work for the slab and rcu changes that have come in with
> the sheaves work.
>
> This only works with one kmem_cache, and only the first one used.
> Subsequent setting of keme_cache will not update the active kmem_cache

s/keme_cache/kmem_cache


> and will be silently dropped because there are other tests which happen
> after the kmem_cache of interest is set.
>
> The saved active kmem_cache is used in the rcu callback, which passes
> the object to be freed.
>
> The rcu call takes the rcu_head, which is passed in as the field in the
> struct (in this case rcu in the maple tree node), which is calculated by
> pointer math.  The offset of which is saved (in a global variable) for
> restoring the node pointer on the callback after the rcu grace period
> expires.
>
> Don't use any of this outside of testing, please.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  tools/include/linux/slab.h            | 41 +++++++++++++++++++++++++++++=
+++---
>  tools/testing/shared/linux.c          | 24 ++++++++++++++++----
>  tools/testing/shared/linux/rcupdate.h | 22 +++++++++++++++++++
>  3 files changed, 80 insertions(+), 7 deletions(-)
>
> diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
> index 51b25e9c4ec7b66bdf4c68cc1353c6faf1ca7bb8..a475364cfd9fcdb10db252aab=
18ea3a620326b6b 100644
> --- a/tools/include/linux/slab.h
> +++ b/tools/include/linux/slab.h
> @@ -22,6 +22,12 @@ enum slab_state {
>         FULL
>  };
>
> +struct kmem_cache_args {
> +       unsigned int align;
> +       unsigned int sheaf_capacity;
> +       void (*ctor)(void *);
> +};
> +
>  static inline void *kzalloc(size_t size, gfp_t gfp)
>  {
>         return kmalloc(size, gfp | __GFP_ZERO);
> @@ -36,9 +42,38 @@ static inline void *kmem_cache_alloc(struct kmem_cache=
 *cachep, int flags)
>  }
>  void kmem_cache_free(struct kmem_cache *cachep, void *objp);
>
> -struct kmem_cache *kmem_cache_create(const char *name, unsigned int size=
,
> -                       unsigned int align, unsigned int flags,
> -                       void (*ctor)(void *));
> +
> +struct kmem_cache *
> +__kmem_cache_create_args(const char *name, unsigned int size,
> +               struct kmem_cache_args *args, unsigned int flags);
> +
> +/* If NULL is passed for @args, use this variant with default arguments.=
 */
> +static inline struct kmem_cache *
> +__kmem_cache_default_args(const char *name, unsigned int size,
> +               struct kmem_cache_args *args, unsigned int flags)
> +{
> +       struct kmem_cache_args kmem_default_args =3D {};
> +
> +       return __kmem_cache_create_args(name, size, &kmem_default_args, f=
lags);
> +}
> +
> +static inline struct kmem_cache *
> +__kmem_cache_create(const char *name, unsigned int size, unsigned int al=
ign,
> +               unsigned int flags, void (*ctor)(void *))
> +{
> +       struct kmem_cache_args kmem_args =3D {
> +               .align  =3D align,
> +               .ctor   =3D ctor,
> +       };
> +
> +       return __kmem_cache_create_args(name, size, &kmem_args, flags);
> +}
> +
> +#define kmem_cache_create(__name, __object_size, __args, ...)           =
\
> +       _Generic((__args),                                              \
> +               struct kmem_cache_args *: __kmem_cache_create_args,     \
> +               void *: __kmem_cache_default_args,                      \
> +               default: __kmem_cache_create)(__name, __object_size, __ar=
gs, __VA_ARGS__)
>
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list);
>  int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t s=
ize,
> diff --git a/tools/testing/shared/linux.c b/tools/testing/shared/linux.c
> index 66dbb362385f3c3d923233448cc591adfe6dc9e7..9f5fd722f27f1d3877be8927b=
e30409cd74ab3c3 100644
> --- a/tools/testing/shared/linux.c
> +++ b/tools/testing/shared/linux.c
> @@ -20,6 +20,7 @@ struct kmem_cache {
>         pthread_mutex_t lock;
>         unsigned int size;
>         unsigned int align;
> +       unsigned int sheaf_capacity;
>         int nr_objs;
>         void *objs;
>         void (*ctor)(void *);
> @@ -31,6 +32,8 @@ struct kmem_cache {
>         void *private;
>  };
>
> +static struct kmem_cache *kmem_active =3D NULL;
> +
>  void kmem_cache_set_callback(struct kmem_cache *cachep, void (*callback)=
(void *))
>  {
>         cachep->callback =3D callback;
> @@ -147,6 +150,14 @@ void kmem_cache_free(struct kmem_cache *cachep, void=
 *objp)
>         pthread_mutex_unlock(&cachep->lock);
>  }
>
> +void kmem_cache_free_active(void *objp)
> +{
> +       if (!kmem_active)
> +               printf("WARNING: No active kmem_cache\n");
> +
> +       kmem_cache_free(kmem_active, objp);
> +}
> +
>  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void *=
*list)
>  {
>         if (kmalloc_verbose)
> @@ -234,23 +245,28 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep=
, gfp_t gfp, size_t size,
>  }
>
>  struct kmem_cache *
> -kmem_cache_create(const char *name, unsigned int size, unsigned int alig=
n,
> -               unsigned int flags, void (*ctor)(void *))
> +__kmem_cache_create_args(const char *name, unsigned int size,
> +                         struct kmem_cache_args *args,
> +                         unsigned int flags)
>  {
>         struct kmem_cache *ret =3D malloc(sizeof(*ret));
>
>         pthread_mutex_init(&ret->lock, NULL);
>         ret->size =3D size;
> -       ret->align =3D align;
> +       ret->align =3D args->align;
> +       ret->sheaf_capacity =3D args->sheaf_capacity;
>         ret->nr_objs =3D 0;
>         ret->nr_allocated =3D 0;
>         ret->nr_tallocated =3D 0;
>         ret->objs =3D NULL;
> -       ret->ctor =3D ctor;
> +       ret->ctor =3D args->ctor;
>         ret->non_kernel =3D 0;
>         ret->exec_callback =3D false;
>         ret->callback =3D NULL;
>         ret->private =3D NULL;
> +       if (!kmem_active)
> +               kmem_active =3D ret;

This kmem_active and kfree_cb_offset look like bad hacks... Could we
maybe modify kmem_cache_alloc() to allocate a small metadata at the
beginning to store a pointer to kmem_cache and kfree_cb_offset value?

> +
>         return ret;
>  }
>
> diff --git a/tools/testing/shared/linux/rcupdate.h b/tools/testing/shared=
/linux/rcupdate.h
> index fed468fb0c78db6f33fb1900c7110ab5f3c19c65..c95e2f0bbd93798e544d7d34e=
0823ed68414f924 100644
> --- a/tools/testing/shared/linux/rcupdate.h
> +++ b/tools/testing/shared/linux/rcupdate.h
> @@ -9,4 +9,26 @@
>  #define rcu_dereference_check(p, cond) rcu_dereference(p)
>  #define RCU_INIT_POINTER(p, v) do { (p) =3D (v); } while (0)
>
> +void kmem_cache_free_active(void *objp);
> +static unsigned long kfree_cb_offset =3D 0;
> +
> +static inline void kfree_rcu_cb(struct rcu_head *head)
> +{
> +       void *objp =3D (void *) ((unsigned long)head - kfree_cb_offset);
> +
> +       kmem_cache_free_active(objp);
> +}
> +
> +#ifndef offsetof
> +#define offsetof(TYPE, MEMBER) __builtin_offsetof(TYPE, MEMBER)
> +#endif
> +
> +#define kfree_rcu(ptr, rhv)                                            \
> +do {                                                                   \
> +       if (!kfree_cb_offset)                                           \
> +               kfree_cb_offset =3D offsetof(typeof(*(ptr)), rhv);       =
 \
> +                                                                       \
> +       call_rcu(&ptr->rhv, kfree_rcu_cb);                              \
> +} while (0)
> +
>  #endif
>
> --
> 2.48.1
>

