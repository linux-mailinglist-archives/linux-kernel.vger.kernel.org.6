Return-Path: <linux-kernel+bounces-441647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A181B9ED175
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161681888E04
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6C31DC1B7;
	Wed, 11 Dec 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ktgtvp/1"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AA1DC19E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934415; cv=none; b=pEBi07ApuU+NjtZQx7dfWSZ6mekZe3maNYHUPRz/qhP082wpOMQOR367rae/iNEpPN8qiBAzOzEfgelXLTDPWIeb36XWCdpS00LajKgrCmgGfepDdrJekNAXlbLhtl9J1o1U8B3Y3MSABhimMD4nSzQPboNJACmW24skYJBi04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934415; c=relaxed/simple;
	bh=ShhdYxV8zR6qkEZNaZDMdE03lN1uAff7+JisyXxmeAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KORoChayyEljyeXt9mia59WBalUC9NEP4w63lL+fQS+8muqUyk3zM4GPw7jNNHGGee7sc6ku1NwhVUV1yA0YIgs2YMAVPyMYTxW556h9HO8qo7MTtEXNwiSiU8Xch0XRHd79dgYUab+yXF4X1WAYmfVVqazpHi+y+bbz16SHg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ktgtvp/1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d8e773ad77so40618346d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 08:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733934412; x=1734539212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmF7B4UdiNqGoqgVNbUdDqAU3iWrVv8dqPWk1iyMjhc=;
        b=ktgtvp/1spCj9VlipIPZ0pXDHV/b6QB+gXhQM3hqDYIyZguyvpxe12v6gOG93QIfz7
         NiCrKebC7q7jLQlU9CrMPAsDrstW4TNgbV0EUSVlPNvhaHfFMQOLt/VTZJe+dSYZwV4+
         O3u3hIuVxQIxurbLIEQgKfAc/Kn+C8Pt0dx/qp5JWTHk5jMH/mx2lUgmYQcsjDceGzXf
         60tAaOVG5+CdKcLaTfEn2hpVCFQpjXElPnqSJFLmaVQJehc0HelxJh8cB8QqHCBmyooC
         BSf5ibhfJYshm9UzSZS7T7/FUdF9Om7sny/g8b+2V6JH7YF0BlwC0Dq99hjad6Cv7+nY
         3ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733934412; x=1734539212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmF7B4UdiNqGoqgVNbUdDqAU3iWrVv8dqPWk1iyMjhc=;
        b=c3zoyPLsH8dsM6cVnwx9hC80xoNNw+WJygnXnTK8sfKvsKq5V+E/KOpXNy5XQHTcHl
         +b7Ficf4qhzORU750x5aRKX95Ss5TITPYMFcm7BHQrsSG21Vh5cIAS/HNxuiDO9oIQoS
         hFaefWIxDnDfLdos5yfB9XioSRspF0s7fvX1S/XsoGTuqzs8xpW/5CfqkSZGPVIUcHdm
         IEmoIZjWD3kzwoqmFSSLUbLC3Xtw/ZJy/ARNh9WMycxxlrHpKnB+i7i5fz32AXoChBQU
         tTHU1Sr8AEa1Bls9Fkgmqm/VSYQ5+hUKgVM3EAzyEyQSMurrmObv8Jox50L05M2eTXqB
         Yn0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN64k6IoDoAUCjRim9zeQOxZx+0kCxcDVi6MJk/N3eFlOCyImkLqpNUwJjVnBLdZKFEUktkK8wwVaGBlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7b8H+g3FZ3zeAqw/twVWttOjRtQbbYVBeLMpnfm36OZgaTYS
	e6zKVcQVlOSou7455sxsCCimU66q794PUj+9vKI6wkxqfkhSUPY4bci4bZaOKxkY7KSdr5v/PlO
	VIFJtMOvZPqhVNerRQAh/8OY/P1q+gYNehm29
X-Gm-Gg: ASbGnctQRqfSwvjglsQvr0l3f8m0eVUkAOa4j/Squ6Q1abAB5EP5I8bCUIqw5StKOtT
	RebeRRji5xtnAJ8URGenkO3XsAYMT91Ye
X-Google-Smtp-Source: AGHT+IE7hqAxeY1BamlWjBEdDx9LHupCMPUOLWWQnkrSePi0bDITuoK8qiLThq9KLPMhxghkKeLR+aQPtsiS3x8RJ6U=
X-Received: by 2002:a05:6214:27e4:b0:6d4:36ff:4356 with SMTP id
 6a1803df08f44-6d934ae9b33mr52733116d6.19.1733934412169; Wed, 11 Dec 2024
 08:26:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105336.380cb545@fangorn>
In-Reply-To: <20241211105336.380cb545@fangorn>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 11 Dec 2024 08:26:15 -0800
X-Gm-Features: AbW1kvbRB3RiEDwpv3a-k_lbcdWn-0ivQPHXBpRrjUl4XTlgbAVnAmY8nCI6va4
Message-ID: <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
To: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 7:54=E2=80=AFAM Rik van Riel <riel@surriel.com> wro=
te:
>
> A task already in exit can get stuck trying to allocate pages, if its
> cgroup is at the memory.max limit, the cgroup is using zswap, but
> zswap writeback is enabled, and the remaining memory in the cgroup is
> not compressible.
>
> This seems like an unlikely confluence of events, but it can happen
> quite easily if a cgroup is OOM killed due to exceeding its memory.max
> limit, and all the tasks in the cgroup are trying to exit simultaneously.
>
> When this happens, it can sometimes take hours for tasks to exit,
> as they are all trying to squeeze things into zswap to bring the group's
> memory consumption below memory.max.
>
> Allowing these exiting programs to push some memory from their own
> cgroup into swap allows them to quickly bring the cgroup's memory
> consumption below memory.max, and exit in seconds rather than hours.
>
> Loading this fix as a live patch on a system where a workload got stuck
> exiting allowed the workload to exit within a fraction of a second.
>
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/memcontrol.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..03d77e93087e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5371,6 +5371,15 @@ bool mem_cgroup_zswap_writeback_enabled(struct mem=
_cgroup *memcg)
>         if (!zswap_is_enabled())
>                 return true;
>
> +       /*
> +        * Always allow exiting tasks to push data to swap. A process in
> +        * the middle of exit cannot get OOM killed, but may need to push
> +        * uncompressible data to swap in order to get the cgroup memory
> +        * use below the limit, and make progress with the exit.
> +        */
> +       if ((current->flags & PF_EXITING) && memcg =3D=3D mem_cgroup_from=
_task(current))
> +               return true;
> +

I have a few questions:
(a) If the task is being OOM killed it should be able to charge memory
beyond memory.max, so why do we need to get the usage down below the
limit?

Looking at the other thread with Michal, it looks like it's because we
have to go into reclaim first before we get to the point of force
charging for dying tasks, and we spend too much time in reclaim. Is
that correct?

If that's the case, I am wondering if the real problem is that we
check  mem_cgroup_zswap_writeback_enabled() too late in the process.
Reclaim ages the LRUs, isolates pages, unmaps them, allocates swap
entries, only to realize it cannot swap in swap_writepage().

Should we check for this in can_reclaim_anon_pages()? If zswap
writeback is disabled and we are already at the memcg limit (or zswap
limit for that matter), we should avoid scanning anon memory to begin
with. The problem is that if we race with memory being freed we may
have some extra OOM kills, but I am not sure how common this case
would be.

(b) Should we use mem_cgroup_is_descendant() or mm_match_memcg() in
case we are reclaiming from an ancestor and we hit the limit of that
ancestor?

(c) mem_cgroup_from_task() should be called in an RCU read section (or
we need something like rcu_access_point() if we are not dereferencing
the pointer).


>         for (; memcg; memcg =3D parent_mem_cgroup(memcg))
>                 if (!READ_ONCE(memcg->zswap_writeback))
>                         return false;
> --
> 2.47.0
>
>
>

