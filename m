Return-Path: <linux-kernel+bounces-287295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865AF95260D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0CD283937
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E2114B08E;
	Wed, 14 Aug 2024 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KU2Zm+yT"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4466414EC73
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676297; cv=none; b=c2J+SCSj7FZJmsEtgj/G5HKho+MdXeiGBVQW3SxfT0a1q7sGNu9mA+OIGDtTDjNIPyyhPf+fqUxnUeRzVTBEQbLRuDKY6kExyPgbhbWP55R6cymHHulAfWx1imA2X1ZfPa5eCenHhHeZvmiEd48Ncfe3aNRHM56U94vVSi26gzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676297; c=relaxed/simple;
	bh=esJkp6pzrDl7pn0Vhi+Sf5H4Ge/O5im0wu9OPiZHzxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAJ7LDOJSuxSxEDpbMtq7A6mPG18BYRIrED+KAKgDQmxF4hSMsiU/3ZMHuI+u/miVICoaDDYeIo+xbvlOAXb6E1YtnlGn128vhEnJBFmc6TgW2+TJus3bMN12zotAfVqv6+twM7wOTdqkRc3gJYlpbZAdoXPmwtJtOJipFvpsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KU2Zm+yT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e115eb44752so474972276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723676295; x=1724281095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LH9IZekz4kND2PuGVCdvgpQgNSIkQ3LAaUsAOTaDg8=;
        b=KU2Zm+yTf+hNIvw6XXQG0kWQG34wVo5ru1OfTnFa0/CH9JNFLv0wRHnBLe79+MO0ns
         q3EcNtCXRgdqVm4VqcgzQN875afO7wRhUvuBCmhOhx55HXV7v9+8PrFAQI1QoJkx8AIo
         7SS844nEpR3XGUZ/SVrz+QC0qIsVm52ALVwvm/d1o037rXoTutpUmBx9sgbLiP1vNO7U
         Lhz808fk0vKwQXYz8CdRazDX8E+WxfAgZz8oc8WlDfQVs0AA9Z95ISjH1f7H2r+wcaXj
         3yqkN0TEYNuvY2+09vvJPoFvOy6BwF2achYvyeUECL2YbwJCjRqGUdTDApI+T08pLHP0
         GvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676295; x=1724281095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LH9IZekz4kND2PuGVCdvgpQgNSIkQ3LAaUsAOTaDg8=;
        b=mZlnAgcn7Z3xDyTox3mTkQr42RuxohlhVXQZu/+DkpiB8ED6gaat5RdICKung+SzA3
         XvUo+Ut+6LNEIlotXgr/2OQyPXQyGvYNET9Xt1L0KtEvOb37rX3m4v2G9U0eZoL6eLTf
         UXjFYKiLEYB2irC5C1LriXSCmsr29XEF9QnACooabBMbKkmB0uVrRibu0IXPlYx0C0e+
         g4XMXj+uP6aTnSOd6PdYgEDn/GqcPXoB5BQOpgwIBtFcHTuJEmLy7Qb8niQPWBTMnQlL
         ePNUYnnq4p046yVjai92QBvuYT9G9CfAjppqyycWltqU8msbebMzCBLYUl8PZgZh6C44
         ia5w==
X-Forwarded-Encrypted: i=1; AJvYcCWiIPfIzJnBajIpzmpqw3Rygh48qFSv0WJxfEyKRN8BTWccoZdz4Qcv65wS1XKX8phMJEndN2/geSeIS+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVradKzc1tw8QBbdw7PnCWwic0vTsHeizentaCOl1goiQxfxj
	5NHU2YR1HrysWLhl+OowDzSXf4GK3lbh0AnMbq4FNzdRkPBtxrvf3tx908Ri22haRbNU4pK0a/E
	cgAC/qQ6TVszsxlgdbPWKzqg6xlvKqw+s4+16
X-Google-Smtp-Source: AGHT+IGMh670qk/wVX9LikwlOg/tM7AX9HaJJ+9M/wLsONwxycfHG8idh1uP1XZ/P7iHetg0R2VUp1EhYjZ/V33KXSw=
X-Received: by 2002:a05:6902:1021:b0:e08:5bd7:6bdb with SMTP id
 3f1490d57ef6-e1155a426eemr5238466276.3.1723676294551; Wed, 14 Aug 2024
 15:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814220021.3208384-1-shakeel.butt@linux.dev> <20240814220021.3208384-4-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-4-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 15:58:03 -0700
Message-ID: <CABdmKX3cqsFBe3dA2P3MrNjFbwg4zH9wLuE=W0FrzuT0cOiY7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] memcg: initiate deprecation of oom_control
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
> The oom_control provides functionality to disable memcg oom-killer,
> notifications on oom-kill and reading the stats regarding oom-kills.
> This interface was mainly introduced to provide functionality for
> userspace oom-killers. However it is not robust enough and only supports
> OOM handling in the page fault path.
>
> For v2, the users can use the combination of memory.events notifications
> and memory.high interface to provide userspace OOM-killing functionality.

Might be worth it to mention PSI here too for userspace OOM-killing?
(It's what LMKD does for Android.)

> Let's start the deprecation process for v1 and gather the info on how
> the current users are using this interface and work on providing a more
> robust functionality in v2.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>




> ---
> Changes since v1:
> - Fix build (T.J. Mercier)
>
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 7 +++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 6831c6c16e3f..0042206414c8 100644
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
> index e0bb54e42011..334a02597d9a 100644
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
> +                            " if you depend on this functionality. \n");
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
> +                    "depend on this functionality. \n");
> +
>         /* cannot set to root cgroup and only 0 and 1 are allowed */
>         if (mem_cgroup_is_root(memcg) || !((val =3D=3D 0) || (val =3D=3D =
1)))
>                 return -EINVAL;
> --
> 2.43.5
>

