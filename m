Return-Path: <linux-kernel+bounces-330894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932897A5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D915E1F22CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200B15920B;
	Mon, 16 Sep 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iNCp2Ww"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA96158A1F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726503083; cv=none; b=hmIxQ3BTYR26jCvCzo0BmsQ/PkuAWguquW6UoNRNNahXOPgtm2nwU6cIzT0h6FIchshWxguMQm2ki+QzuPr5jtcFzpl3g7wcBeRk5wzh6BqfzaCZVILf66DeUa8B+6pSOj5kPCMXi8Ci9t6ThWwAViNWrJ26aoB4wkUR2PCWA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726503083; c=relaxed/simple;
	bh=juiViXrpR3GA3MTg+3FQnCytbqe+phi2i4TFd9RH7SI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAmy+5G7g01DBjd1Mdt/o6dc69N6h+byegwQ0gFboAacipva3/sDB5mLnK1vL/sTZC+RKW80N+EbMK9uLINIWpQOVCNsMTtnfrAPws8O3FnIuLzarSbg45s/xn6LkbmVLljktgH9RtFBHuZrsPWDSEKrsqBKi4kMPh8w84Ff+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iNCp2Ww; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e040388737so2288293b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726503081; x=1727107881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=werckLu2qABNnMsCoJq0wayuYhQhq8fQBYHljQK5Yds=;
        b=3iNCp2WwZtLLCR4VQAZiTDw98o4dJ6dCFkZzp7iTO1sovT4BhjSeJZOYiGp1+9uNuM
         xTrb0v6flVrn32lEw5z4LH2mUeN8hWnZTr0Rh1UhjM2d/DfYQxNCmZkoDwJJm5MPOXtr
         TntYEM/zAOgPP/+FMh1/wOXkjmawhYtkkETLWz9gl4n9Qf82PzLNQrOCNYneTUu/s68M
         4lKdjkruKaXkWE/28pCJYCwvFnhoOqsjjkOpRmn9OMA8Kc0vFaml+M9dfs6rMw7cbHmL
         or/cA9trT3cl+VAT53Ru9y+cEN3pWqO9aoAoaSHUfilzp2T2cqTYgZH8ChISQJGDaRt5
         JScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726503081; x=1727107881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=werckLu2qABNnMsCoJq0wayuYhQhq8fQBYHljQK5Yds=;
        b=LU1mkY1GsT4k+TNqm7fS4sKtvNd/zUMGeYu17IudYjeyP3l4Na54TTHfqnSdXD2KQD
         LHcNuCiLebJsuWtEYFKsZ60TFdM1njfdWYrqbQF/Uf2TltDMx1kfDbQFwL2vY/6dZfsr
         S7eFxyB3CPomDgOg0IqCW/vHpLRGfwapBr9bYNQYBjXUdROwF9qeQccjLW2w1LPQiBu4
         IjM0wn9mKNw9uesDmmcu05RjFac4TjlxtooJGHm42q8DFdUYYpJi1k/RRhg7zn36qGyn
         krcSRkJoNFugodMp1mjGfKHTg5hlveZx7VF+e3A/NsDChscKDiIGkZwVA5+aLgYXfWl/
         1Dlg==
X-Forwarded-Encrypted: i=1; AJvYcCUBrS3oxdM5LXG6AL7SFEAlIuJoaofdE0+ag3CtqYChB2qbFQbtlHlzGXYU5mM21NTgmZ0Ud3ctkuEs24Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSD45dmon+fubAjXZsvVSTCueVQ+9WT1nUO/qmMwannW0ekro
	T+mg4i589io9TrQbRuM8chX4yUjDM2TPlujY6PQ/wTpzp0MeRcFgEEQWyb+Eus7Y+/9s602RShr
	cGKxJqVNcGICel/PZZ5cB9E908HYTA+emq/ov
X-Google-Smtp-Source: AGHT+IG2paECrHCwX7g5IwKKYKo3FCiS9Keilpk2/8MMysEQ09W4ONACdDMzunXhFuD2rjnRQo8ev2HDFlwqsLIDb8g=
X-Received: by 2002:a05:6808:3994:b0:3e0:3946:b92 with SMTP id
 5614622812f47-3e071b28ccbmr8946972b6e.45.1726503080489; Mon, 16 Sep 2024
 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <linuszeng@tencent.com> <20240913084506.3606292-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240913084506.3606292-1-jingxiangzeng.cas@gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Mon, 16 Sep 2024 09:11:08 -0700
Message-ID: <CAAPL-u8s+mc1bY-DJ_zDJ1PLrhP_2w2MQXxdteN4z_U=qE6jfw@mail.gmail.com>
Subject: Re: [PATCH V2] mm/vmscan: wake up flushers conditionally to avoid
 cgroup OOM
To: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, kasong@tencent.com, 
	linuszeng@tencent.com, linux-kernel@vger.kernel.org, tjmercier@google.com, 
	yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 1:45=E2=80=AFAM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering OOM
> when encountering many dirty pages during reclamation on MGLRU.
>
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed
>
> dd invoked oom-killer: gfp_mask=3D0x101cca(GFP_HIGHUSER_MOVABLE|__GFP_WRI=
TE),
> order=3D0, oom_score_adj=3D0
>
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5f/0x80
>   dump_stack+0x14/0x20
>   dump_header+0x46/0x1b0
>   oom_kill_process+0x104/0x220
>   out_of_memory+0x112/0x5a0
>   mem_cgroup_out_of_memory+0x13b/0x150
>   try_charge_memcg+0x44f/0x5c0
>   charge_memcg+0x34/0x50
>   __mem_cgroup_charge+0x31/0x90
>   filemap_add_folio+0x4b/0xf0
>   __filemap_get_folio+0x1a4/0x5b0
>   ? srso_return_thunk+0x5/0x5f
>   ? __block_commit_write+0x82/0xb0
>   ext4_da_write_begin+0xe5/0x270
>   generic_perform_write+0x134/0x2b0
>   ext4_buffered_write_iter+0x57/0xd0
>   ext4_file_write_iter+0x76/0x7d0
>   ? selinux_file_permission+0x119/0x150
>   ? srso_return_thunk+0x5/0x5f
>   ? srso_return_thunk+0x5/0x5f
>   vfs_write+0x30c/0x440
>   ksys_write+0x65/0xe0
>   __x64_sys_write+0x1e/0x30
>   x64_sys_call+0x11c2/0x1d50
>   do_syscall_64+0x47/0x110
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>  memory: usage 308224kB, limit 308224kB, failcnt 2589
>  swap: usage 0kB, limit 9007199254740988kB, failcnt 0
>
>   ...
>   file_dirty 303247360
>   file_writeback 0
>   ...
>
> oom-kill:constraint=3DCONSTRAINT_MEMCG,nodemask=3D(null),cpuset=3Dtest,
> mems_allowed=3D0,oom_memcg=3D/test,task_memcg=3D/test,task=3Ddd,pid=3D440=
4,uid=3D0
> Memory cgroup out of memory: Killed process 4404 (dd) total-vm:10512kB,
> anon-rss:1152kB, file-rss:1824kB, shmem-rss:0kB, UID:0 pgtables:76kB
> oom_score_adj:0
>
> The flusher wake up was removed to decrease SSD wearing, but if we are
> seeing all dirty folios at the tail of an LRU, not waking up the flusher
> could lead to thrashing easily. So wake it up when a mem cgroups is
> about to OOM due to dirty caches.
>
> Link: https://lkml.kernel.org/r/20240829102543.189453-1-jingxiangzeng.cas=
@gmail.com
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: T.J. Mercier <tjmercier@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 749cdc110c74..ce471d686a88 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4284,6 +4284,7 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>                        int tier_idx)
>  {
>         bool success;
> +       bool dirty, writeback;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -4332,6 +4333,9 @@ static bool sort_folio(struct lruvec *lruvec, struc=
t folio *folio, struct scan_c
>         /* waiting for writeback */
>         if (folio_test_locked(folio) || folio_test_writeback(folio) ||
>             (type =3D=3D LRU_GEN_FILE && folio_test_dirty(folio))) {
> +               folio_check_dirty_writeback(folio, &dirty, &writeback);

We cannot simply call folio_check_dirty_writeback() here because
folio_check_dirty_writeback() assumes that the folio is locked (e.g.
see buffer_check_dirty_writeback()).

> +               if (dirty && !writeback)
> +                       sc->nr.unqueued_dirty +=3D delta;
>                 gen =3D folio_inc_gen(lruvec, folio, true);
>                 list_move(&folio->lru, &lrugen->folios[gen][type][zone]);
>                 return true;
> @@ -4448,6 +4452,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
t scan_control *sc,
>                                 scanned, skipped, isolated,
>                                 type ? LRU_INACTIVE_FILE : LRU_INACTIVE_A=
NON);
>
> +       sc->nr.taken +=3D isolated;
>         /*
>          * There might not be eligible folios due to reclaim_idx. Check t=
he
>          * remaining to prevent livelock if it's not making progress.
> @@ -4920,6 +4925,14 @@ static void lru_gen_shrink_lruvec(struct lruvec *l=
ruvec, struct scan_control *sc
>         if (try_to_shrink_lruvec(lruvec, sc))
>                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
>
> +       /*
> +        * If too many pages failed to evict due to page being dirty,
> +        * memory pressure have pushed dirty pages to oldest gen,
> +        * wake up flusher.
> +        */
> +       if (sc->nr.unqueued_dirty > sc->nr.taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +

The wakeups will be much more often than intended because
sc->nr.unqueued_dirty includes the drity file pages now, but
sc->nr.taken doesn't.

>         clear_mm_walk();
>
>         blk_finish_plug(&plug);
> --
> 2.43.5
>

