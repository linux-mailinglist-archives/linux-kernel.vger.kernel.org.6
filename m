Return-Path: <linux-kernel+bounces-287184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5176952464
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CF61F22047
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F81C7B78;
	Wed, 14 Aug 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/Nwcb8J"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F61C68B4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669287; cv=none; b=MNDvPrC2GuaxpmC9WevnutJlCkYSNEeajmWIfZBhVcFkep9iBuK7SM3BkGOqS3HGrli8QfJ/SMCGWdqyaNUjTCD9qLoF9NL0BKKtzYC6xFnr2xxb+QO/6sdFo+Oyb7gaOx3FcdggU4O3NJmOKtYuoKK8ettrJuVjcEvk9dC3aQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669287; c=relaxed/simple;
	bh=QFUMlwKJJ22GxYAqA6y3hNWVCyOLZH77nEyNH3dVRVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oBYlMgPKrnVKPlraPaqInvZPANkEgvgidQnhC7II1hc9jM43E60Q98j3ETXdD49/YPTFhCJ8XO/B9PxAeaKYNlQQjKtvfw3tzJENWtZvZ93wv0XYxfT+OG/4OL2RCTFAZOmyCCTxYTh9RE4i2Kje4JotNKp6n8qevnml8w6DOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/Nwcb8J; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so540791a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669281; x=1724274081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtSWn6D+L1i0S8D9pk47VhJVmM2hM2e0bEFMHwPQzZo=;
        b=g/Nwcb8J1eH6FtKoBGBgheeUSE9s8w9ugmA+ABJSCJJmg1Rs9nVw+0tp3HRmFgXp/b
         EmnIX6AcUCLvPaZTHrjEnH2CijGpTbMLPwGW8AmQMdU88EbYzmiYlW24oCBypsexIrCy
         1Chs+TuOgaFbWkIj8bcafatNVbe4lpYYV39pyjWqukVhK4dZvIVWaOhwX53GBFNA0ADK
         Fz9vEECNix4AJWdQ3nylXt4S5BvexYgw6CqLui8oYOsvMcgUD3pzqTyguADdGj02QqXE
         6dVVcfGAfGNNwkKavyFkPzrnq0JKFJfMoFz5bG/O1rsiW39rc6Z5kej2JpAn6p7J+gWv
         Qw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669281; x=1724274081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtSWn6D+L1i0S8D9pk47VhJVmM2hM2e0bEFMHwPQzZo=;
        b=dvT4eo6c7KaWZrgdh8mx2AGTsp1GrV29KskKFAdEtqXejPnhzjcGRFaTg5I04sOBP+
         ucYxjUq8whci3wVKKRiCost/ORNaexSD6b3uscqQ8xobfIcS9tlEEOcmwe8tFHruZ4dj
         Fu95IxGddWSAanRyTZnsvzZl6JT1sCbcBwlIQ0Xa3ewSNulVRZ4PDR1uxBNaVrUoMPnm
         ckcA5ul97MmT2t6JyGjvNSJa7B9ZqM3MqsWkOUCgyCU24yGZ1UpPBORG+7EV2Rlh5ker
         1IJbUSofvLpy72Qiq1VZKVm44t5hrZ5KjaBZ/SArF+H+mPk1+G/l6qGlyQl5rzTlA95e
         zIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa5Kc+Zoe4iAf9QYnaQCjBSJueMd+4f07/yTSZgN0eNBXftKUimNuU0szICL0qvTHIE/bX2/RcWqWKbu8iAImVUmPDbdW5BykCgX9y
X-Gm-Message-State: AOJu0YwKjETsx0GDZ4STS0OeQO2gKu2hMeFHt+Ci047vFhOvDdorfQiE
	EbKgXQeyBVfn9znYxf+W5Gsuwxxmol2RKZBtoSX2DKqg//bIVnmL3LHWeIBCCmNwoiYBPEvZLR5
	50EvpymXSqk3s6UN2msCDxV7ZttpL5tC1sG+5
X-Google-Smtp-Source: AGHT+IGRA6vdncRy2nz6tiF7hG9ZotPO8yndJSxBHfEImNy31+XsN/M4EX4g0JuPoNUaluTpzizpWso7xAtF766k5Fw=
X-Received: by 2002:a05:6402:3514:b0:57c:7471:a0dd with SMTP id
 4fb4d7f45d1cf-5bea1c739c4mr2561925a12.12.1723669281004; Wed, 14 Aug 2024
 14:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814202825.2694077-1-shakeel.butt@linux.dev> <20240814202825.2694077-5-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-5-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 14:01:06 -0700
Message-ID: <CABdmKX1adgyideAM+hggM2vYSQqoXVPNPDicAi2iGHL2MG-SMA@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg: initiate deprecation of pressure_level
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The pressure_level in memcg v1 provides memory pressure notifications to
> the user space. At the moment it provides notifications for three levels
> of memory pressure i.e. low, medium and critical, which are defined
> based on internal memory reclaim implementation details. More
> specifically the ratio or scanned and reclaimed pages during a memory
> reclaim. However this is not robust as there are workloads with mostly
> unreclaimable user memory or kernel memory.
>
> For v2, the users can use PSI for memory pressure status of the system
> or the cgroup. Let's start the deprecation process for pressure_level
> and add warnings to gather the info on how the current users are using
> this interface and how they can be used to PSI.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 74cea6712d06..8ec1faf08b6b 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -86,6 +86,8 @@ Brief summary of control files.
>                                       used.
>   memory.force_empty                 trigger forced page reclaim
>   memory.pressure_level              set memory pressure notifications
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.swappiness                  set/show swappiness parameter of vms=
can
>                                      (See sysctl's vm.swappiness)
>   memory.move_charge_at_immigrate     set/show controls of moving charges
> @@ -898,8 +900,10 @@ At reading, current status of OOM is shown.
>            The number of processes belonging to this cgroup killed by any
>            kind of OOM killer.
>
> -11. Memory Pressure
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +11. Memory Pressure (DEPRECATED)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +THIS IS DEPRECATED!
>
>  The pressure level notifications can be used to monitor the memory
>  allocation cost; based on the pressure, applications can implement
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 07343e338e4e..420c7d15f12a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1913,6 +1913,9 @@ static ssize_t memcg_write_event_control(struct ker=
nfs_open_file *of,
>                 event->register_event =3D mem_cgroup_oom_register_event;
>                 event->unregister_event =3D mem_cgroup_oom_unregister_eve=
nt;
>         } else if (!strcmp(name, "memory.pressure_level")) {
> +               pr_warn_once("pressure_level is deprecated and will be re=
moved. "
> +                            "Please report your usecase to linux-mm-@kva=
ck.org "
> +                            "if you depend on this functionality. \n";

Missing close paren? Extra space at the end too.

>                 event->register_event =3D vmpressure_register_event;
>                 event->unregister_event =3D vmpressure_unregister_event;
>         } else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> --
> 2.43.5
>
>

