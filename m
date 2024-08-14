Return-Path: <linux-kernel+bounces-287296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65695260E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B994C283574
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EB14D433;
	Wed, 14 Aug 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE/MFm5w"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4114B97E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676312; cv=none; b=eniOCdmFm0WjNm/Ls4HDuJaMyaakoLPbJuI/fI+Jnt8KR5FZ+sEjmq/PmPcC5+zupNi8EMpw2u1mmlE/mVgwGF4E9t8U93yt51s0VXs/IA6J0ZxfK/xfJi+w0vswkxt9OPJfFwwchSs6JssK2HgzLjTIS+ui1jcxAxGnuSc1LTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676312; c=relaxed/simple;
	bh=sEi7TbGO5Ntmfn1pMdHe8wajqxgmYCz4bKVOA5JfU/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RzV3CNdi7ocVZdZpMDYc6WKM9cZagYELbA2FJqc1pvnoO3Rw53qja5E3oestCQOK/LcrLRlxRNbheaJFMo/jwKvEo7ZlcaKA6NBnlobRNwL4lcTOilQeJ/BtCicB7wFeirJSvKRk1/yv43SYPnAtGaRoZocvEMz1LhO1w6bugTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE/MFm5w; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6659e81bc68so5646077b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723676310; x=1724281110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUWhNpMZkVm29wzcKzyvQXZAILOf6Dv4XUMwNXkvgdM=;
        b=lE/MFm5ws8bJAKH4HcVUqvlxk56e5Mc/rjdt7xJVKVcSaqH3GsxaspWUvHKRusE1Ru
         pf/eYRayXZ6IaHQe/dy1xhPSBvDb/2KedDKPFqbvoGFBxt2bKtLj9jcT/MZF9/4wmFtA
         /yIHMVzd0D5Eh8BLdTOwPFbiY9fwbDXM+bEJeBgxwDZq/ok3XFDKsSQfAo+92760EoaP
         XWjRX9eYFgooqh0XzbHozG+4NKe6ownpRznGBD4REz3AxcnaDVnj6+qpakPlu/HyWu1/
         qyor267bS3r99LDTNYE1AJoNti9vwQMFWZ805mPXt8xEC93QkjJ8KDFZwXuVI015V3/E
         Q20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676310; x=1724281110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUWhNpMZkVm29wzcKzyvQXZAILOf6Dv4XUMwNXkvgdM=;
        b=k2N+K3TMRRFcUx9qIJaiWuTi1SRUSi+mxcuBPPxhZO62BUSKjeJUrOHJwHAATRBX8N
         Gsan9fNn1HE/Mn8wrSRTvl9Xt1qF5n/vTUwfLqHYbcTysPW/YmpNwl5FW4YTnopgevbG
         TCDCtdEP3SdNr0TnFbZSpY6lidbu6Z9YUBz6oRk1cUkgr2mlAlfoDp4gXoQdv7kCRct6
         GZ+qBfI74uV9DXFYmYcM5UanrMnYDoWdlS3W6+EoZg8dA+h9T9nicc8EkojusP6BdPvx
         Zf1Gt/Au5BoEnGXzAY9oKm6k3qbn9Rtqm2idV7TGotWSWtLcSAFfBzkkwGs7vDKi2TE5
         oyiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd7J6Tc5bhjv1EWT2PM+tsX6Fpxc/pLE+2vrsKhPmciZnTijca7leuV4byiW+0VtZ+tYoZe7RPInuNiwId9O4RHzypPqKNI5F7NRjn
X-Gm-Message-State: AOJu0Yzij47qJui6p1FFBZ980iT8mdDNicXz3Cm7d8GGKWHEJJlx3AwW
	aVy2f91kbD4roSPb92in0lHOl+iwDp/avpntWHQrhPHI0rtk1iB3L3t5YCf5rN6t1rq0620/mw6
	T4Yv7s+RZIu3ZVC079nh13C8/XAZv1zx4FYLx
X-Google-Smtp-Source: AGHT+IH159x/1XCLV9wWews52LhEjNNWRHC/963OVVJzDAiE2ggKEqH5sqJkpLLbOepWnA2AvwREk7Iozx3FPc4qEkk=
X-Received: by 2002:a5b:60c:0:b0:e11:67d7:e7cb with SMTP id
 3f1490d57ef6-e1167d7ed0emr2635021276.19.1723676309851; Wed, 14 Aug 2024
 15:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814220021.3208384-1-shakeel.butt@linux.dev> <20240814220021.3208384-5-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-5-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 15:58:18 -0700
Message-ID: <CABdmKX0Kv57Lo2xC7mJXOePObFhkCDdr1mAK71nurXZOQNVDPg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] memcg: initiate deprecation of pressure_level
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The pressure_level in memcg v1 provides memory pressure notifications to
> the user space. At the moment it provides notifications for three levels
> of memory pressure i.e. low, medium and critical, which are defined
> based on internal memory reclaim implementation details. More
> specifically the ratio or scanned and reclaimed pages during a memory

"ratio of"

> reclaim. However this is not robust as there are workloads with mostly
> unreclaimable user memory or kernel memory.
>
> For v2, the users can use PSI for memory pressure status of the system
> or the cgroup. Let's start the deprecation process for pressure_level
> and add warnings to gather the info on how the current users are using
> this interface and how they can be used to PSI.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>


> ---
> Changes since v1:
> - Fix build (T.J. Mercier)
>
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 0042206414c8..270501db9f4e 100644
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
> index 334a02597d9a..52aecdae2c28 100644
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
> +                            "if you depend on this functionality. \n");
>                 event->register_event =3D vmpressure_register_event;
>                 event->unregister_event =3D vmpressure_unregister_event;
>         } else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> --
> 2.43.5
>

