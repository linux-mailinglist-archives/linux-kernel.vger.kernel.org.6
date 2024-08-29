Return-Path: <linux-kernel+bounces-305957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528EA96370F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11562286158
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9651B7F4;
	Thu, 29 Aug 2024 00:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqU1Bx7Z"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DBCDDC5
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724892592; cv=none; b=HNyDE6PlmIKUl4RJjr8eE0jfjjwOevdOFmDETiq6Mi0Gm0g+kVGV/rQvpVc5vMlb3H7e5jBOo3udfk30ClHIUr7zvTJmiNV0w5yuDNT2avMxjrPlhshQe/D2QN0H5VKQ4jm2x7FrbWEf8RiKTjdeo86gUHoPj/xLFZD/Aix/X+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724892592; c=relaxed/simple;
	bh=U4veOOUlCcB/bJrp/tF/bns+tvPzVcDIUb4yeIgaxd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhvqPw1GFYPvqaE1vNeoRPJ2y53WPod2fSCeohWYsPg0KFsSQp34+ySFdTttWTwhsRdTO1qOSvsLaocHoOwalSvykGsVKZTS9U8GbvCtZBCD5N1UwCk6/uoNdYe2U09e6tistVu/eBzDlUfbRLQ69kl+JJ5mkN/U2doEEVhRMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nqU1Bx7Z; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5343617fdddso135062e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724892589; x=1725497389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgNhr2hOvaIzUB9HOdlqFWv+1peGGJauE+dQeJtfJwg=;
        b=nqU1Bx7Z9Ewj4pVsb6Kd0ttmLNtzDPIZ7EaypoDriFwv8sxszA33HdF+RbZDncVU/b
         UfL7UEQJWF2Y/dCNyN0DYeWvHFv41uCzdSha2ozYw/TEopu+3volfGyaOwVnBT1iCtI0
         seO8sJWpHPF6rocHy35KSQTrwTYAqpYUM5xR8NOL7BuybnyKCLjbsEp0L5K1iJkr71/v
         qWXsbGA0ynIIRl0OPJ5Q0Ip1QrPa1Jgg2O5OOXH46ajYwfRGVcHQz32gGQWqL0vjiObs
         UhxGw9eRumidFonF//2aIsF5fJ1vbcVH+de4dnVUu/nTSB88ktICKEmEWtUIvfuKcUqe
         TPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724892589; x=1725497389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgNhr2hOvaIzUB9HOdlqFWv+1peGGJauE+dQeJtfJwg=;
        b=rt45reW292kapXuXjJ6AYSyxzEtz0R231nxs08Vp8Q+YpzD+jFY1BClAXiwH2xYbrI
         CDKrnyPFLSz3yjpLdcmQwNg5DKixRhFGPGWNbywWuFD3Xw/IX5ukZ8vKhC0L+TXQxqp5
         Ysd9p0ZgHYW+7cgI4uhpGZmD0YtBPYS7dbCQ8DAXt1MVUmxVl/uwHrnlynxp8PXN5WE9
         nRvGDHu1whWrQaukVZT2Vw8lU4A9frmdIPyDmJjum7P3MaVqaFa3tRD1hxWfg3ZbYQT1
         +5C/sDU7TnouFdc9tL8HFve5Ibpb1BnanNv0gbCQZRqrnP1iqvsVel3iQI2kG8YBgBBz
         PJvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf935rhq6yFQRGtcDDKiu3eLGMh+oAQSthAk531enZWd4nsKgcadASjw8u96ne3GKQebig2/G3rQ/HsYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIwkufe3HnPCLQvzI5d0wXWVzUBXhlhecK9k8aIQBk6BCFkwD
	z3GccFpF8yvYAqcV1pmfrd9Wr29tptmy6PwiiqcLU1jgWCWy8LBULZ0fnaIZ4yhKCHef+kTi4V/
	EgURI9UWJdx4q0C7S8cD85eNBRbyuGmaKoqsH
X-Google-Smtp-Source: AGHT+IFbLJO1WrEKaTu56WQixgXfjvPLXB5l+59RZUZ1w2d/9xDAjb08PsiI9Y3aJjgbC9IsdbZBpL9Av59w0rMtU9M=
X-Received: by 2002:a05:6512:220f:b0:533:483f:9562 with SMTP id
 2adb3069b0e04-5353e5acc64mr700179e87.42.1724892588520; Wed, 28 Aug 2024
 17:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com> <txl7l7vp6qy3udxlgmjlsrayvnj7sizjaopftyxnzlklza3n32@geligkrhgnvu>
In-Reply-To: <txl7l7vp6qy3udxlgmjlsrayvnj7sizjaopftyxnzlklza3n32@geligkrhgnvu>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 28 Aug 2024 17:49:12 -0700
Message-ID: <CAJD7tkY88cAnGFy2zAcjaU_8AC_P5CwZo0PSjr0JRDQDu308Wg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:20=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Aug 28, 2024 at 04:25:30PM GMT, Yosry Ahmed wrote:
> > On Tue, Aug 27, 2024 at 4:52=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> [...]
> > > +
> > > +       /* Ignore KMALLOC_NORMAL cache to avoid circular dependency. =
*/
> > > +       if ((s->flags & KMALLOC_TYPE) =3D=3D SLAB_KMALLOC)
> > > +               return true;
> >
> > Taking a step back here, why do we need this? Which circular
> > dependency are we avoiding here?
>
> commit 494c1dfe855ec1f70f89552fce5eadf4a1717552
> Author: Waiman Long <longman@redhat.com>
> Date:   Mon Jun 28 19:37:38 2021 -0700
>
>     mm: memcg/slab: create a new set of kmalloc-cg-<n> caches
>
>     There are currently two problems in the way the objcg pointer array
>     (memcg_data) in the page structure is being allocated and freed.
>
>     On its allocation, it is possible that the allocated objcg pointer
>     array comes from the same slab that requires memory accounting. If th=
is
>     happens, the slab will never become empty again as there is at least
>     one object left (the obj_cgroup array) in the slab.
>
>     When it is freed, the objcg pointer array object may be the last one
>     in its slab and hence causes kfree() to be called again. With the
>     right workload, the slab cache may be set up in a way that allows the
>     recursive kfree() calling loop to nest deep enough to cause a kernel
>     stack overflow and panic the system.
>     ...

Thanks for the reference, this makes sense.

Wouldn't it be easier to special case the specific slab cache used for
the objcg vector or use a dedicated cache for it instead of using
kmalloc caches to begin with?

Anyway, I am fine with any approach you and/or the slab maintainers
prefer, as long as we make things clear. If you keep the following
approach as-is, please expand the comment or refer to the commit you
just referenced.

Personally, I prefer either explicitly special casing the slab cache
used for the objcgs vector, explicitly tagging KMALLOC_NORMAL
allocations, or having a dedicated documented helper that finds the
slab cache kmalloc type (if any) or checks if it is a KMALLOC_NORMAL
cache.

