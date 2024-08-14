Return-Path: <linux-kernel+bounces-287182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A395245D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FCD1C21BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B61C68B6;
	Wed, 14 Aug 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hY+emgGc"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDA21BDAA5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669220; cv=none; b=VkpjPyJjfEjfSvLi3EypweIG1ptszyzSMllc+bl+kvA6c8q8pipUPlv2onBj8pi1J94KbkS0x1lvtr1yJdFbHcKrkF5FlTMYuH0nqxCZ4O5wghzaG9VaHZtLQseqCoQZYoNtMqbTrZ9Orxcog8F7GLK+FRyX83AEqQx+HmClDuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669220; c=relaxed/simple;
	bh=KE0J1m8ywXryGoAQ5n+c5f5pgdea94s4puJwLUHOtH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLqep+SEos62M2LZw1OIifbXOHzWn3LK1Uy7YXGd6kzMkqDT9EgCQSw46s3GsEAtt2qwDtcBoTUnddUZulYSeJxfoZMciUhy2LwWDSDtds5Ezz0wkP7DK6X+JDF1ClqoVY2t+nHOoBhUY6qjAJTeApceLhlyykUHvuVJHOUCQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hY+emgGc; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e115eb44752so387724276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669216; x=1724274016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBRix1wwOMh4arF0zGt6se8WJ5OdxF7B5CsJBNLT4jw=;
        b=hY+emgGcRG2X8wHLe26R37I0opyMpXo5LLh5IsPS3i0caKWEVMmoyESr8y2DgRV/pP
         9Ta997veYPqc+5/uHRY1VaUvwXbq6/f3O/IPhJ1TUquiHmZxrHpOI/ldf9zJVatcS6kB
         nHlPxZduYU50ODqub98Ho+hsM83dSRQgFKDRab88J5VTWq0vZ0RSNK8B+VMQ7dhONfpJ
         EpuqHLctyWM6OTQ0GjNpIn3xawunwI/INxfieHqKxM0JI/ZI8t1izMttJ6cy6VNhIEZT
         qYz+RAOB8k2BypL84fiCcjjnZEGxFY6IMhT2apsw5wlC6znzLNKgWVlDK3hKmvjgAkCF
         P06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669216; x=1724274016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBRix1wwOMh4arF0zGt6se8WJ5OdxF7B5CsJBNLT4jw=;
        b=lUUNNfeJC8UnfMFj/RuXkK45O5no57+Heoorn7YPxf/gRD9ffm4eehQRL9UEZi8UUf
         NteKlFbbMVVPKn64Y0LMKavwxfHnd+D0hPvAxhgfISsExEcblZWMg3l2fVQWG8eOq2RO
         +HF9fu+J9mPAWC1OU6VPg4phHLDo4FvtjUeZlkyTxFV8DMwbDZHVMvs/9fLWyNQT8uYE
         IzKlq32VyU8VkqTR1jJckj3Vkwb8YzM8Vo+e7OAnLgplZqEGeUTpIYMX25P15E42j5vZ
         tcVT6XFCBkEckW9fHZfDmT6auExO6PrCeKMWxBAVlaPXOTWkUPPdf6kOxxhTFLU+1PEa
         aSWg==
X-Forwarded-Encrypted: i=1; AJvYcCUFsPP87JFfFW83d+VVWhS30KYAvvzg4cKqpyZ/AAp+LAHOjUTW0dQG6Aj2dSyeH9VwbautR3ohI66NHlwUOBeOuymQEzxLtgBl2Rna
X-Gm-Message-State: AOJu0YzENuPOXORjFUv075uAJT611mmkNAcU+35FoQmFyIjp+XLIcCKa
	BJecg0ENx2p8ow5DJVQWFxnKkKSgJKTRNqTM1JSKEKlSJfSuWCDQotsCb5ZTrxnqM1mqI0Nsf33
	VXkKfQWutYEoXGxoZ+N+oCAzI8sGtEpDSrxR0
X-Google-Smtp-Source: AGHT+IEL2neSDQmMRmgI8aTlzUOZ/xklZeylZk3AG6/Zf9u+kVpogZQGc56kVsahQZFWMpFciwzX7ON3q+IoZZDvYxw=
X-Received: by 2002:a05:6902:188c:b0:e0b:d2da:2422 with SMTP id
 3f1490d57ef6-e1155adf686mr4709547276.25.1723669215863; Wed, 14 Aug 2024
 14:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814202825.2694077-1-shakeel.butt@linux.dev> <20240814202825.2694077-4-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-4-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 14:00:03 -0700
Message-ID: <CABdmKX2HvW3qZ9zrTq0Gz6q0Gg7_XubVY22o3GJoTOhQg=V+8Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] memcg: initiate deprecation of oom_control
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
> The oom_control provides functionality to disable memcg oom-killer,
> notifications on oom-kill and reading the stats regarding oom-kills.
> This interface was mainly introduced to provide functionality for
> userspace oom-killers. However it is not robust enough and only supports
> OOM handling in the page fault path.
>
> For v2, the users can use the combination of memory.events notifications
> and memory.high interface to provide userspace OOM-killing functionality.
> Let's start the deprecation process for v1 and gather the info on how
> the current users are using this interface and work on providing a more
> robust functionality in v2.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 7 +++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index afe5e95e9f7b..74cea6712d06 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -92,6 +92,8 @@ Brief summary of control files.
>                                       This knob is deprecated and shouldn=
't be
>                                       used.
>   memory.oom_control                 set/show oom controls.
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.numa_stat                   show the number of memory usage per =
numa
>                                      node
>   memory.kmem.limit_in_bytes          Deprecated knob to set and read the=
 kernel
> @@ -846,8 +848,10 @@ It's applicable for root and non-root cgroup.
>
>  .. _cgroup-v1-memory-oom-control:
>
> -10. OOM Control
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +10. OOM Control (DEPRECATED)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +THIS IS DEPRECATED!
>
>  memory.oom_control file is for OOM notification and other controls.
>
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index e0bb54e42011..07343e338e4e 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1907,6 +1907,9 @@ static ssize_t memcg_write_event_control(struct ker=
nfs_open_file *of,
>                 event->register_event =3D mem_cgroup_usage_register_event=
;
>                 event->unregister_event =3D mem_cgroup_usage_unregister_e=
vent;
>         } else if (!strcmp(name, "memory.oom_control")) {
> +               pr_warn_once("oom_control is deprecated and will be remov=
ed. "
> +                            "Please report your usecase to linux-mm-@kva=
ck.org"
> +                            " if you depend on this functionality. \n";

Missing close paren?

>                 event->register_event =3D mem_cgroup_oom_register_event;
>                 event->unregister_event =3D mem_cgroup_oom_unregister_eve=
nt;
>         } else if (!strcmp(name, "memory.pressure_level")) {
> @@ -2754,6 +2757,10 @@ static int mem_cgroup_oom_control_write(struct cgr=
oup_subsys_state *css,
>  {
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
>
> +       pr_warn_once("oom_control is deprecated and will be removed. "
> +                    "Please report your usecase to linux-mm-@kvack.org i=
f you "
> +                    "depend on this functionality. \n";
> +

Missing close paren?

>         /* cannot set to root cgroup and only 0 and 1 are allowed */
>         if (mem_cgroup_is_root(memcg) || !((val =3D=3D 0) || (val =3D=3D =
1)))
>                 return -EINVAL;
> --
> 2.43.5
>
>

