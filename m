Return-Path: <linux-kernel+bounces-317974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB32696E699
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB001C22D1F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D618BF0;
	Fri,  6 Sep 2024 00:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPNIu3b/"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1118D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725580868; cv=none; b=b0vg0QA5XLIYtY+9ur7W+ETBMGj/fxBixlfaOlfw/Pfa0hFIcbefN53yPuf1qurRkPsuuyFDLmoKDgHVmMFEy8lEyA8JdiU7/xAN5MswuTpSQWrWmhgN63BamJlDrE9y8oPxFbJqXFczlqB3KaLvTvs/eyRnyy8GNP44b6usU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725580868; c=relaxed/simple;
	bh=fpfMJbvCMTbmXggAXAPgiMEos6uWDzVmbGo8vC1dmbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXLv7VdnoVSj8K/xQjl0rHOUUCSKCIr892AFexKWIf4ZM1yqQN0vu2yO4rYpWQdrcwdcH0oGBwkvG3WdbhtTWP3k0/DlYcpGQc/XMkg7zeRJtMjvhrfZ1WhzDB+Syxw1PPsLD2qgtCU0Oaa0NEzSKLr5sLCoo+0axEJ1If+GHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aPNIu3b/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso10568955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 17:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725580864; x=1726185664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zbiIE5f0ijyM2F94C8pzvs+v46It1WxJmu/JDnwdjw=;
        b=aPNIu3b/DkRdFxv2/8Tv/CwaqEy5mogFS5DZVUuORzdVU3IB5bBxZ5AvHUm+ZQTvNt
         cf4KnY3IL5Tt0khQKR7c43/3HqHsJNjAoMIZrFHlVPEtydtpZjYj9hcWdSRCedCShojb
         LIqcIVOSr1niqv4qibsfHYdrsRrWMNEyG1qYeFItmxyrSFWt6fPwAv8hQUgtqBUcBzQ6
         +4uddP8cJ5RRgEnDbtj77lo4Ui9rA5SPjD4qaJWm8Tfn2K/A2ek655blJFu7QYqCXzEj
         BYDKKAAsCHxwadIBL5z9ePoiptvKyiuep9VPWrHVVSY7qSQpy7i2rh1vakRq+8UKRz8W
         ZHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725580864; x=1726185664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zbiIE5f0ijyM2F94C8pzvs+v46It1WxJmu/JDnwdjw=;
        b=s3JrtcJcY+K5bT7vBBmngAlQNV+QWonlP9CdTfCiOw6KigFQGsSWZeShVSI32//zbj
         a7VQGW5lnc1D6ohEjgDjMoeCJD1gadC4Drt8Pfo2maZJL5+UOHN8K+CqjKcOfWn1k9V/
         4Za2VdgSDt28MMUc+48laHrMHGwfF0dVV5mqtu6ys8L2hmWEMxIbmOdA0IuE7/f1f52F
         IEZGLG3C3m/2oUIsKmn7BgNVZP2WCSw9AB12bcvkIGYYCurbjMG9CYpm6xtCybyRmaoy
         hgRxxMit4YOvJq3Zvesy5hXG5NELCcrQpfLDqephlzKpiMedO65ykzQW+u+qrySFBeT2
         8UCA==
X-Forwarded-Encrypted: i=1; AJvYcCXpn1D+ceyP/6kDakkAqMNOH1HCvMzPxnKY70O9UL9KxWDsOn2itQQ6//BE9aP6uVbg58YZzC49ifZyotw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI4/n3KW78YJ7CYRUXO93E9FA/U7e6O3pY7J9wdWlCcbPV+2cH
	VwdAadU+H8UWqnFrqUb3KIXI4ET+DaHv3e35rgw0EtDch4ag77tsbs4T/QkOtSRxe8ShUOPfHw8
	60BmNOfLA8oSujcHpItBnFl880tW+PEsKG04dBV11WID8xbkpgPXk
X-Google-Smtp-Source: AGHT+IGVXtxRG+yYgtoUzZFo9L/X25W9Q/t5h7V6MToEk/e7asHXKKxligC6oCoRrHdVLVYKwitQgwT1nX7qG5GYB7c=
X-Received: by 2002:a05:600c:4e46:b0:426:60bc:8f4e with SMTP id
 5b1f17b1804b1-42c9f97b524mr4515845e9.5.1725580863110; Thu, 05 Sep 2024
 17:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240829102543.189453-1-jingxiangzeng.cas@gmail.com>
From: Wei Xu <weixugc@google.com>
Date: Thu, 5 Sep 2024 17:00:40 -0700
Message-ID: <CAAPL-u-ERAfjg+RP01QE1XfvQqPHn4ngKAwb_XZA2Cy8KTsVwg@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Yu Zhao <yuzhao@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:25=E2=80=AFAM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Zeng Jingxiang <linuszeng@tencent.com>
>
> Commit 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> removed the opportunity to wake up flushers during the MGLRU page
> reclamation process can lead to an increased likelihood of triggering
> OOM when encountering many dirty pages during reclamation on MGLRU.
>
> This leads to premature OOM if there are too many dirty pages in cgroup:
> Killed

Thanks for the patch. We have encountered a similar problem.

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
> MGLRU still suffers OOM issue on latest mm tree, so the test is done
> with another fix merged [1].
>
> Link: https://lore.kernel.org/linux-mm/CAOUHufYi9h0kz5uW3LHHS3ZrVwEq-kKp8=
S6N-MZUmErNAXoXmw@mail.gmail.com/ [1]
>
> Fixes: 14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle")
> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/vmscan.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f27792e77a0f..9cd8c42f67cb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4447,6 +4447,7 @@ static int scan_folios(struct lruvec *lruvec, struc=
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
> @@ -4919,6 +4920,14 @@ static void lru_gen_shrink_lruvec(struct lruvec *l=
ruvec, struct scan_control *sc
>         if (try_to_shrink_lruvec(lruvec, sc))
>                 lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
>
> +       /*
> +        * If too many pages failed to evict due to page being dirty,
> +        * memory pressure have pushed dirty pages to oldest gen,
> +        * wake up flusher.
> +        */
> +       if (sc->nr.unqueued_dirty >=3D sc->nr.taken)

Any reason not to use a strict =3D=3D check as in shrink_inactive_list()?

Also, this check allows the wakeup of the flusher threads when both
sc->nr.unqueued_dirty and sc->nr.taken are 0, which is undesirable.

If we skip the wakeup for the cases where both counters are 0, then I
think we need to handle the situation where only dirty file pages are
left for reclaim in the oldest gen. This means that
sc->nr.unqueued_dirty needs to be updated in sort_folios() (in
addition to shrink_folio_list()) as well because sort_folios() doesn't
send dirty file pages to shrink_folio_list() for eviction.

> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>         clear_mm_walk();
>
>         blk_finish_plug(&plug);
> --
> 2.43.5
>

