Return-Path: <linux-kernel+bounces-287181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9FB95245C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCF11C20E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8141E1C688D;
	Wed, 14 Aug 2024 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6qAyX8X"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DC1B86C1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669172; cv=none; b=h/CBTkW7aewc6YxHwdIAveQrOU5XbrTT2m/WBqGlqUOBRLFkxch7QEkqOKs087ucF9qYjDKEWPtrbjXIxVddek2ea2R40kKuVJfHJI6F7uGx2Uv9dC7jHo7zEv44cSmZ7DraXnWXx3sG+TuUBInklO6bK5K2VCmYD74fIno72G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669172; c=relaxed/simple;
	bh=z/++biqcPLbdFhnEZO3OZrkvvr7TgPxYik694Y2Qbm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE3trzGY53O0kxleKHvqVmEclScuLx3cqeYFBzzOBaZ0pcM5+ZNZjKaUb0HoWy9B3onqQQo+LVF9SLtOBbo3O5/JzFxNk8iB/UVrkm7m66PWpueZYrLmQNyMkMDvR0YRhE2Dhui8TeGSsHVueTegfY2qJcXS/uALi1JAaYqq5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6qAyX8X; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e05f25fb96eso362643276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669167; x=1724273967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KLTTn/hjmzFSkfe2zHJsLIOkpo44yYFx9b8AKrmGa4=;
        b=T6qAyX8XPpWSab7vsTRL+nThcPGMpMQwjoaer4d6d5P1rGGgXDmIj8a9mgYjS+gNV+
         fU2VYmzoV9qwTZbumLu5Imlwz8yMCbJjG0PtWcVEGDo/daZek0eR8GR5uPBGjBGRn8FK
         0n1tT/RRLgJsgz/jb7qbN6CZ+8FzR2w826eSmIoV0zDl+icRlRJtzi7zGo0u7TRN4j84
         Aki5Xcscojj3G3RSFOSWfuXF2ibGjn7njNcpFDLRahxgruUo6wLFlLF04ak6wSUfOzJj
         tgGxYhsnLUIH6cXAxdXNERg7QNPrdE3PksZCI5wt0DqGeGluTj6gFSI+8miRVo3XXjTx
         z4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669167; x=1724273967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KLTTn/hjmzFSkfe2zHJsLIOkpo44yYFx9b8AKrmGa4=;
        b=RmvsjkIbvRqld47s14jhwH6nPvU+B1DGDo4TVWJGqqGCn3IjvOPt0ccT4hVqrbiGoP
         YrfKAGjh3/uhZFlK9P2eena6LMnHiywLZ5abw4ctrlA9lvP2vIFjF3yMOHU06dIGC+zM
         TsrRrMem9yoCfMiGQXz67c6sbBifUlflOhKBKFchf4pjzwy8xkK/ZI5JItzbIBxPvSqU
         fBNL8d5cE9XuOoaB3k6FGUkOcfDMuAhJC/Tao67leBLHKIXGPI0X+SakfGCXbUjdGoze
         OtAOBjUFtzjKphIBOgss1yFjlaxfzQNh7XplXKp5VtKkkM5ryk+/lMP5ocrsoUHaqCAV
         Uu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwNzPRw8MYwlH39Ainz70NU00D8wohAGPiAA68dZMuO11z2jFDposhBYMmYjlG/vuJUQvJ7UOO8DLovPCUBUNgrZdvDkJYMYxnSTC9
X-Gm-Message-State: AOJu0YztDQjGbavctffQgQfWNsiOu0ZwstSBqkLI4gfGiX1QrqXFvIS7
	rJ94Ijf9Zs//5XYMLFc+BzEa1K41Ufa1FHafC8RAS4/VAkgOYAnBflZVSw1PI57BLbhGtanv7h4
	do1qI/D+iEDjcsL8EHL9kDFw61htwxWP5309cUnPhP47I8qF4PQ==
X-Google-Smtp-Source: AGHT+IG6u9xXVM5sR6V6akfNNtSjFrQtV99kTT+jKruHC8y3/HDjw2NnRNFY4ZhQmcIEGdS9c4P0PYvFzO2HxMdto5A=
X-Received: by 2002:a05:6902:2804:b0:e0b:9412:328f with SMTP id
 3f1490d57ef6-e1155bd1112mr3928570276.56.1723669167090; Wed, 14 Aug 2024
 13:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814202825.2694077-1-shakeel.butt@linux.dev> <20240814202825.2694077-2-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-2-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 13:59:15 -0700
Message-ID: <CABdmKX07o8ywPNoTDL_tM6qn46TXeLbhHoQEtBpFBXJkWdAc7A@mail.gmail.com>
Subject: Re: [PATCH 1/4] memcg: initiate deprecation of v1 tcp accounting
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:28=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Memcg v1 provides opt-in TCP memory accounting feature. However it is
> mostly unused due to its performance impact on the network traffic. In
> v2, the TCP memory is accounted in the regular memory usage and is
> transparent to the users but they can observe the TCP memory usage
> through memcg stats.
>
> Let's initiate the deprecation process of memcg v1's tcp accounting
> functionality and add warnings to gather if there are any users and if
> there are, collect how they are using it and plan to provide them better
> alternative in v2.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++++
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 9cde26d33843..fb6d3e2a6395 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -105,10 +105,18 @@ Brief summary of control files.
>   memory.kmem.max_usage_in_bytes      show max kernel memory usage record=
ed
>
>   memory.kmem.tcp.limit_in_bytes      set/show hard limit for tcp buf mem=
ory
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.kmem.tcp.usage_in_bytes      show current tcp buf memory allocat=
ion
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.kmem.tcp.failcnt             show the number of tcp buf memory u=
sage
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>                                      hits limits

Looks like you split the description (that has weird grammar) here.

>   memory.kmem.tcp.max_usage_in_bytes  show max tcp buf memory usage recor=
ded
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>  1. History
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 9725c731fb21..b8e2ee454eaa 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2447,6 +2447,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_=
file *of,
>                         ret =3D 0;
>                         break;
>                 case _TCP:
> +                       pr_warn_once("kmem.tcp.limit_in_bytes is deprecat=
ed and will be removed. "
> +                                    "Please report your usecase to linux=
-mm@kvack.org if you "
> +                                    "depend on this functionality.\n");
>                         ret =3D memcg_update_tcp_max(memcg, nr_pages);
>                         break;
>                 }
> --
> 2.43.5
>
Otherwise LGTM
Reviewed-by: T.J. Mercier <tjmercier@google.com>

