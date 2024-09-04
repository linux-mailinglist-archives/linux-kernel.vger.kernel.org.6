Return-Path: <linux-kernel+bounces-315974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADA96C956
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C051C2245C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED75018592C;
	Wed,  4 Sep 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEpB5GXx"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A044153824
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484246; cv=none; b=AJ7olJX2Z5FOd7j7PhQXUc/K+fOH8zigfJhx04ZeluEvmGEfmmark3BqBsAQXKw2H/N15rzqfCQ/GkDUvje4UjoobJXsdxDQDfb9bab75Kx+tbjt5HIq9Gcy2+ctTUQ6IGO+fwkYB9MxdW2AhWzfti4v9IVwWQrLlci26S3Vc1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484246; c=relaxed/simple;
	bh=aRIZejtk8tNIqYtjJOu+2Ot1ObUSineg7/SBviLFU5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g0nZW4iKB5EAFsDRIiT66UjS8D2ccpVS2LBt0Mtllx3JSeuCII9maSLKBhIXZTLP/09PHZT9dE+SJNqWT1kPjxnEom2ZTC1LhRfcW1FMxn9/dP5WeDtXNkbRI2XHkb4I/ieROtni7WSC4XIEspSlTeK5VPezkrny4vv0t4zZDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WEpB5GXx; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so7504536e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725484242; x=1726089042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP8HEjcvcsSjCqyyJiUYtMj75FT90mtxfvTOuGNKzpc=;
        b=WEpB5GXxQ8htQJq30i35x8I8S0dkNwabsYxoMkSdDdPKHAVi+1cBPOAklQL/xZkx3Z
         fyhqb9UYNdm6NNSaSKAOWmUcaPJ48LfsNVh2HC+Smw5EhhzcH7+j9n5IL8fNy493jC76
         bjDoRjohCCf5SNwsjZj3sr1MP2nr59+cOaCORMFAB7hu0yWT8SpF3Ylgbf4xi7JG1iFM
         RuF81fet/EifB/C1Kr0ehkyBjSenwX9bB08HcVRKUcdICRSJBkJiO9huwbbatHDA4CUx
         gsfRkC24byxp++peYsKdjwMLHhKMv29kIC9b96A8fzia+ZuGWzHcE1Ztj37uCP6CwP5k
         zbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484242; x=1726089042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XP8HEjcvcsSjCqyyJiUYtMj75FT90mtxfvTOuGNKzpc=;
        b=g8lP1Jk+GnXuPL5vlEfonRtXcQBjWeMu5Z9mtxDgTIEekb2h2/56oT8EMomLza25tO
         qQXq7AgBMyTjmZxswbwi5MwqMFCEqc9JMY+tQVGjJj2LSQkLSTY4UVPrfmMdoAUgfFe1
         n6d3R/Xcqp5bIG6eE0trl+SCIy+JK7uPpEFQi2UtQzpV19Ha1Vfy6hfISJZo1RoF4Mqf
         nY+1Acnjzgw7a5J+Tx9u67pZt/DANx18Qgcr44n2EJhWp80MmdDHPOlbXoxm5gO4ztDJ
         tUYcyfMp83UAWbW/IdCmvDAdV+XrF35g1s2FSJ0zrW4fl4O7yDir1/K4btEUdt4YOMrM
         vsKg==
X-Forwarded-Encrypted: i=1; AJvYcCV2yCYZXqNXa+AcyF29/OtErcF4L98k1MnHzbN1MPd1ygPL7VGYyw9g90wTGZnl0phdslMlG4hICh81tUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZzWO65CP56I20eBTGAJCI/4SZsYA+lYGnkrapyfIKWWvpq8B
	e6YFLh0eE4YpKJdLHCcUpu4DUhbUUHzprdmphgDen+8eGiVPpNOQTLfHA8/0g2zPNObeOsMVV5f
	qy3p6otZXAl9VH6/ln4/XOCydgJB3o5xPM4Py
X-Google-Smtp-Source: AGHT+IHWolUXkuWL//rhfaUvkN/zThvDPlsWG88X63zP37akORnLDoixS2Ft+XAO3y3JFu8SwbH6T6Q9UATa2h6DvsQ=
X-Received: by 2002:a05:6512:1286:b0:533:e4d:3374 with SMTP id
 2adb3069b0e04-53546ba8fdamr12344003e87.57.1725484241758; Wed, 04 Sep 2024
 14:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
In-Reply-To: <172547884995.206112.808619042206173396.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 14:10:03 -0700
Message-ID: <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 12:41=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> This patch reintroduces and generalizes the "stats_flush_ongoing" concept=
 to
> avoid redundant flushes if there is an ongoing flush at cgroup root level=
,
> addressing production lock contention issues on the global cgroup rstat l=
ock.
>
> At Cloudflare, we observed significant performance degradation due to
> lock contention on the rstat lock, primarily caused by kswapd. The
> specific mem_cgroup_flush_stats() call inlined in shrink_node, which
> takes the rstat lock, is particularly problematic.
>
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node, w=
e
> noted severe lock contention on the rstat lock, causing 12 CPUs to waste
> cycles spinning every time kswapd runs. Fleet-wide stats (/proc/N/schedst=
at)
> for kthreads revealed that we are burning an average of 20,000 CPU cores
> fleet-wide on kswapd, primarily due to spinning on the rstat lock.
>
> Here's a brief overview of the issue:
> - __alloc_pages_slowpath calls wake_all_kswapds, causing all kswapdN thre=
ads
>   to wake up simultaneously.
> - The kswapd thread invokes shrink_node (via balance_pgdat), triggering t=
he
>   cgroup rstat flush operation as part of its work.
> - balance_pgdat() has a NULL value in target_mem_cgroup, causing
>   mem_cgroup_flush_stats() to flush with root_mem_cgroup.
>
> The kernel previously addressed this with a "stats_flush_ongoing" concept=
,
> which was removed in commit 7d7ef0a4686a ("mm: memcg: restore subtree sta=
ts
> flushing"). This patch reintroduces and generalizes the concept to apply =
to
> all users of cgroup rstat, not just memcg.
>
> In this patch only a root cgroup can become the ongoing flusher, as this =
solves
> the production issue. Letting other levels becoming ongoing flusher cause=
 root
> cgroup to contend on the lock again.
>
> Some in-kernel users of the cgroup_rstat_flush() API depend on waiting fo=
r the
> flush to complete before continuing. This patch introduce the call
> cgroup_rstat_flush_relaxed() and use it in those cases that can live with
> slightly inaccurate flushes.
>
> This change significantly reduces lock contention, especially in
> environments with multiple NUMA nodes, thereby improving overall system
> performance.
>
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

I am honestly not happy with this patch, see below.

> ---
>

Please include a brief delta vs the previous version here to save
reviewers the duplicated effort of figuring it out.

> V9: https://lore.kernel.org/all/172245504313.3147408.12138439169548255896=
.stgit@firesoul/
> V8: https://lore.kernel.org/all/172139415725.3084888.13770938453137383953=
.stgit@firesoul
> V7: https://lore.kernel.org/all/172070450139.2992819.13210624094367257881=
.stgit@firesoul
> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.=
stgit@firesoul/
> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.=
stgit@firesoul/
> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077=
.stgit@firesoul/
> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.=
stgit@firesoul/
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.=
stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519=
.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252=
.stgit@firesoul/
[..]
> @@ -299,6 +301,67 @@ static inline void __cgroup_rstat_unlock(struct cgro=
up *cgrp, int cpu_in_loop)
>         spin_unlock_irq(&cgroup_rstat_lock);
>  }
>
> +static inline bool cgroup_is_root(struct cgroup *cgrp)
> +{
> +       return cgroup_parent(cgrp) =3D=3D NULL;
> +}
> +
> +/**
> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flu=
sher
> + * @cgrp: target cgroup
> + *
> + * Function return value follow trylock semantics. Returning true when l=
ock is
> + * obtained. Returning false when not locked and it detected flushing ca=
n be
> + * skipped as another ongoing flusher is taking care of the flush.
> + *
> + * For callers that depend on flush completing before returning a strict=
 option
> + * is provided.
> + */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool stric=
t)
> +{
> +       struct cgroup *ongoing;
> +
> +       if (strict)
> +               goto lock;
> +
> +       /*
> +        * Check if ongoing flusher is already taking care of this.  Desc=
endant
> +        * check is necessary due to cgroup v1 supporting multiple root's=
.
> +        */
> +       ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing))
> +               return false;

Why did we drop the agreed upon method of waiting until the flushers
are done? This is now a much more intrusive patch which makes all
flushers skip if a root is currently flushing. This causes
user-visible problems and is something that I worked hard to fix. I
thought we got good results with waiting for the ongoing flusher as
long as it is a root? What changed?

You also never addressed my concern here about 'ongoing' while we are
accessing it, and never responded to my question in v8 about expanding
this to support non-root cgroups once we shift to a mutex.

I don't appreciate the silent yet drastic change made in this version
and without addressing concerns raised in previous versions. Please
let me know if I missed something.

> +
> +       /* Grab right to be ongoing flusher */
> +       if (!ongoing && cgroup_is_root(cgrp)) {
> +               struct cgroup *old;
> +
> +               old =3D cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
> +               if (old) {
> +                       /* Lost race for being ongoing flusher */
> +                       if (cgroup_is_descendant(cgrp, old))
> +                               return false;
> +               }
> +               /* Due to lock yield combined with strict mode record ID =
*/
> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);

I am not sure I understand why we need this, do you mind elaborating?

