Return-Path: <linux-kernel+bounces-186977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE938CCB69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245521F21D10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 04:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957A3CF63;
	Thu, 23 May 2024 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jWhyIpF"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA620DF7
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438999; cv=none; b=OkIn1NgI0zX+eZzUa2G8ayQlDnTXYSm79GxQUufN63Og7Y4XFNX0iO3Ag6izwQ5ZsTgqO8sUMFdFf0sJ0cy59JcpIW3wfO3qMXP/n6AsR1QQ7UXEd+AxpcyRWf9QnI/Pa/ffqddMe2p1lF6crYq0tH+KviFnekiQc8LpXHvzXvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438999; c=relaxed/simple;
	bh=eHvoAfHG2xGz9eY4zHLjeanhH4uGlmzPu8XUrx2qTIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJa8IlSTrhhDZnUZx0JFBbT9NMvv+Kn062xSqnl4OzBdEEKe1Ap+pHMiJ3BL5S+RyqZxxy6HvzdvJYhDbKnV7Rw2hKjc3e31ZGngVcOp26RQLKHxYcHBBLN6ajJug4Cw5zTqRzSPCJNMPW1z2FyzQpl0afytfaR62ie7llec9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0jWhyIpF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a620a28e95cso340223666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716438995; x=1717043795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8VUWfVL8PhvcfZC2Me8qhrGsq05o4Pd2dAFMPy1yHI=;
        b=0jWhyIpFn9/9dFmfOrY/KDbr32bmxel9eMeNdCw/1nQKqNR29u+X1lY40dFWk+db/I
         iPiZzAZg3veDXp3rSlPYsNpX4q8QZxpfGXQix2jkWx/5DPSaafU/KljrtLgup4mYn2l3
         NlrAE6gwRNhFh5/D4gFc1UmV1CEjf+SzHTiEyGqpWXfVHFSW9AhIJMV519Jmhkxg+Tne
         4THz/OJp5am3yoCzaC1oYzqA4YswMzPK13MHERCMzzV4wsRy/KwObpyadgowRfGd1Bmd
         vJmWG54MQQVFcNPFPvNPfhHH+oW30R9ANoUh8X0CRAa4XxZV4Q71dXXORIaqikgJkxM7
         WPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438995; x=1717043795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8VUWfVL8PhvcfZC2Me8qhrGsq05o4Pd2dAFMPy1yHI=;
        b=vSj2s2scu7pAh8KTIFWMfIx6OXluOHHXUq2skTgWfQvDIKfwZbv0JO+BJADQevmcu4
         70cJFBknk8Qrt77dGu73kYQBae2KmA6aTNdPDU0xcdvSTG/3Rx8+9vc9RmzkYKAAPJL1
         LalBg6Rl9oH5zr1x+2oq6u6Gp8Fsbfr7qCxUwIxj4ph6rRKShH19uL8pFP4UJH+i0ryY
         tG/pskfrVmQUgyg7v6kH/2o9FTt+H1s8RvmsWhD/EuVAHRjLaI0oTb2MLUGn1GdwWpJO
         TF+qRpKqIUO9W8LPD7mDgrm6yaj6INCvuWXu0iZTuuj5s+EBY12x95ZX4LQiS/XhjHf0
         Op1A==
X-Forwarded-Encrypted: i=1; AJvYcCWbLRl9IU0G08EbPyX9XrKWDYLUApkDTIPhi7HO0dSGyHB03K+66Qebnbeygcm4OY/dVu254n1DQBbB8Vbnx0FEIPjBx9pHk0iaNHfN
X-Gm-Message-State: AOJu0Ywq+0Et2vrWPpzq8b+3b8IYFvXXsqnAt/bRLHKzNtfd3IJtpOig
	/fuB5tWA/6eyPRoGg9qrWzQx/aLm//LA77Mi9Glue6ShEhtugfhlnz/cSMaHtQ3cSpWUvY42XQr
	t3RnQ0EkPY1ai2wR6THtsbvbXpp1vy6lLbn5R
X-Google-Smtp-Source: AGHT+IHWV+3Dho0vc85opVqlQ8AvB8hTnKlFzG4tNs7U0+6OlilQoHDG8ftHGifzquFyG3EHQW0C9/DfXRx8MBRZuPI=
X-Received: by 2002:a17:907:30d0:b0:a58:a0b8:2a64 with SMTP id
 a640c23a62f3a-a6228029215mr209555566b.5.1716438995175; Wed, 22 May 2024
 21:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523034824.1255719-1-shakeel.butt@linux.dev>
In-Reply-To: <20240523034824.1255719-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 22 May 2024 21:35:57 -0700
Message-ID: <CAJD7tkaaEn+2G46taRD1V1W=okBfZtPPOFFyj5A+MVfGzqPDqw@mail.gmail.com>
Subject: Re: [PATCH] memcg: rearrage fields of mem_cgroup_per_node
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, ying.huang@intel.com, feng.tang@intel.com, 
	fengwei.yin@intel.com, oliver.sang@intel.com, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 8:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Kernel test robot reported [1] performance regression for will-it-scale
> test suite's page_fault2 test case for the commit 70a64b7919cb ("memcg:
> dynamically allocate lruvec_stats"). After inspection it seems like the
> commit has unintentionally introduced false cache sharing.
>
> After the commit the fields of mem_cgroup_per_node which get read on the
> performance critical path share the cacheline with the fields which
> get updated often on LRU page allocations or deallocations. This has
> caused contention on that cacheline and the workloads which manipulates
> a lot of LRU pages are regressed as reported by the test report.
>
> The solution is to rearrange the fields of mem_cgroup_per_node such that
> the false sharing is eliminated. Let's move all the read only pointers
> at the start of the struct, followed by memcg-v1 only fields and at the
> end fields which get updated often.
>
> Experiment setup: Ran fallocate1, fallocate2, page_fault1, page_fault2
> and page_fault3 from the will-it-scale test suite inside a three level
> memcg with /tmp mounted as tmpfs on two different machines, one a single
> numa node and the other one, two node machine.
>
>  $ ./[testcase]_processes -t $NR_CPUS -s 50
>
> Results for single node, 52 CPU machine:
>
> Testcase        base        with-patch
>
> fallocate1      1031081     1431291  (38.80 %)
> fallocate2      1029993     1421421  (38.00 %)
> page_fault1     2269440     3405788  (50.07 %)
> page_fault2     2375799     3572868  (50.30 %)
> page_fault3     28641143    28673950 ( 0.11 %)
>
> Results for dual node, 80 CPU machine:
>
> Testcase        base        with-patch
>
> fallocate1      2976288     3641185  (22.33 %)
> fallocate2      2979366     3638181  (22.11 %)
> page_fault1     6221790     7748245  (24.53 %)
> page_fault2     6482854     7847698  (21.05 %)
> page_fault3     28804324    28991870 ( 0.65 %)

Great analysis :)

>
> Fixes: 70a64b7919cb ("memcg: dynamically allocate lruvec_stats")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202405171353.b56b845-oliver.sang@i=
ntel.com
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..16efd9737be9 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -96,23 +96,25 @@ struct mem_cgroup_reclaim_iter {
>   * per-node information in memory controller.
>   */
>  struct mem_cgroup_per_node {
> -       struct lruvec           lruvec;
> +       /* Keep the read-only fields at the start */
> +       struct mem_cgroup       *memcg;         /* Back pointer, we canno=
t */
> +                                               /* use container_of      =
  */
>
>         struct lruvec_stats_percpu __percpu     *lruvec_stats_percpu;
>         struct lruvec_stats                     *lruvec_stats;
> -
> -       unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS]=
;
> -
> -       struct mem_cgroup_reclaim_iter  iter;
> -
>         struct shrinker_info __rcu      *shrinker_info;
>
> +       /* memcg-v1 only stuff in middle */
> +
>         struct rb_node          tree_node;      /* RB tree node */
>         unsigned long           usage_in_excess;/* Set to the value by wh=
ich */
>                                                 /* the soft limit is exce=
eded*/
>         bool                    on_tree;
> -       struct mem_cgroup       *memcg;         /* Back pointer, we canno=
t */
> -                                               /* use container_of      =
  */

Do we need CACHELINE_PADDING() here (or maybe make struct lruvec
cache-aligned) to make sure the false cacheline sharing doesn't happen
again with the fields below, or is the idea that the fields that get
read in hot paths (memcg, lruvec_stats_percpu, lruvec_stats) are far
at the top, and the memcg v1 elements in the middle act as a buffer?

IOW, is sharing between the fields below and memcg v1 fields okay
because they are not read in the hot path? If yes, I believe it's
worth a comment. It can be easily missed if the memcg v1 soft limit is
removed later for example.

> +
> +       /* Fields which get updated often at the end. */
> +       struct lruvec           lruvec;
> +       unsigned long           lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS]=
;
> +       struct mem_cgroup_reclaim_iter  iter;
>  };
>
>  struct mem_cgroup_threshold {
> --
> 2.43.0
>

