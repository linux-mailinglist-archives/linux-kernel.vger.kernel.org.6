Return-Path: <linux-kernel+bounces-262807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EF093CCF9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 05:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7283A1F21887
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025F22261D;
	Fri, 26 Jul 2024 03:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIYcPTHJ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA380B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964400; cv=none; b=ucIrwRiBuORTE/+YWpXAcXVacCH5cQ9Gev80cxvjem9smbaplp6msvifMfUVBnLSAARKnBrvdw6+sMVdcCDEV1z1sISmFjtqFJ15683z82pscByGaurW3FoURn5TVlwGwpSfBiC5/8DNxsGOIbO/W8O6FreUz4TBcAQFSxKnPGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964400; c=relaxed/simple;
	bh=oQWL3PgQFh1f3LqsWQV0K66fqdhrjha/qfdkktYSMIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4s5Z9Dxu4yaosSMnLgKHDX0ofxwOY8tX5y55SI9WELmjDrGT00BE9A4A1EHq5A0ZHwXxEY6lS9D2p6tyEKblBsMjqN0OekKTP+HZXhvIq0kqicjCg1YXGpBJFjgXmYtfzy8JnbSzXqCiE7W/uDO9TwvPulSVen8VNv5P6LIflw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIYcPTHJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f035ae1083so9888131fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721964396; x=1722569196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHUvOD+14kqRnwgKMazSRJYb1Aq7AL/1ITfsjHBPJ88=;
        b=AIYcPTHJCbdF3QZWyAV/DD7QabrEMi0vDOjqCl46flVmbvWqWSboxL94Lc23GgfZHA
         fQ9P54tGr4RL3eaaRoycArlMTeF7vEwtsvUopYJdT9MUJYDAhH0UqX+Gzi7MM4eGWPij
         hgWaeu6LV0cPeivBuT8tpRB82ACUjum6DLv9xjW7BdSXMLIjZQAFWg1PZJNpDZmusFTF
         c26RDYR0OnjaMcsiJtW137CuBwFEsDLZr2cVxR0Wnm2KtqSnW0ygEq7XxTi2Q9ArCB90
         Uc/IcLOgG/GznUxSotuCME4bmHGpHxuaG1mCQgeChUBVIXXD24Jt7gYIDV0jNbYVHadS
         vIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721964396; x=1722569196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHUvOD+14kqRnwgKMazSRJYb1Aq7AL/1ITfsjHBPJ88=;
        b=JIOEGn8qJp4O9QjuojE9Mcn+LUHF17spcZBrsgeSjoyGjk0M63mmZthWGNivUIhj+F
         HIPPvl1Sz0c2ERA5SOsrfGj5oFHOZghY2cRl1Rv0e3bCSNNwgu0EAGKqt2h04GV+xISh
         3GgQ6q+FU3y9MrA7kyk7CmxzJlCSJfLOnbc1MNuVXifE7k0ifyClUeYxCER9skIC5HH5
         +qepgASKS5rBqZqw5tJyDUiC3TGn/ygQ8jVxACPZdCiGDd15HctpWsjRn8m0FAirGJsp
         A2gb8n1Sg1H2wRYSiExwD4B+PCh7bnd4+r/bXsBOu1FY9g0HGOV0zFYLKdUxYkptyApE
         qLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB5Vp0PLlLjs0eyHd9o0BhDG21K8/vr5uOwVYaE+6tjOM9kzdgSx30JD9I3kN5umew0VGuLxPcc6RCnDhx4fjRxYGMWI6E70hPdbEJ
X-Gm-Message-State: AOJu0Yyzc+oXu0bxM28ApOayTu+IqwQIWi9YKZGX5wouiiMIxKEuCdsg
	0vEyfIugnelAOgKrMz+GJ9Zibk9f3PVeh+ns6DwRhuN6lxqKqwA0Xs4CFp06WouBHevBORGQ4cL
	W4QorMqI0HmWr4MMILiXhfZc5Bgw=
X-Google-Smtp-Source: AGHT+IEVdb2kWbTyl5lOxCyh+I+0YNrxwQWzr0uz/UXHePR6/adnQOLkKegn0cBFOXl4QHCJu0ymBmRCOAKhCKqeFf4=
X-Received: by 2002:a2e:9808:0:b0:2ef:2543:45a2 with SMTP id
 38308e7fff4ca-2f03dba5687mr24586431fa.25.1721964395656; Thu, 25 Jul 2024
 20:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <893a263a-0038-4b4b-9031-72567b966f73@amd.com> <20240725095933.2640875-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240725095933.2640875-1-zhaoyang.huang@unisoc.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 26 Jul 2024 11:26:23 +0800
Message-ID: <CAGWkznHHEmQaVKT+QnA9p7WYz4BRo3XpHfuSY6VADNx_4ELtUw@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: bharata@amd.com, Neeraj.Upadhyay@amd.com, akpm@linux-foundation.org, 
	david@redhat.com, kinseyho@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mgorman@suse.de, mjguzik@gmail.com, nikunj@amd.com, 
	vbabka@suse.cz, willy@infradead.org, yuzhao@google.com, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 6:00=E2=80=AFPM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> >However during the weekend mglru-enabled run (with above fix to
> >isolate_lru_folios() and also the previous two patches: truncate.patch
> >and mglru.patch and the inode fix provided by Mateusz), another hard
> >lockup related to lruvec spinlock was observed.
> >
> >Here is the hardlock up:
> >
> >watchdog: Watchdog detected hard LOCKUP on cpu 466
> >CPU: 466 PID: 3103929 Comm: fio Not tainted
> >6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
> >RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> >Call Trace:
> >   <NMI>
> >   ? show_regs+0x69/0x80
> >   ? watchdog_hardlockup_check+0x1b4/0x3a0
> ><SNIP>
> >   ? native_queued_spin_lock_slowpath+0x2b4/0x300
> >   </NMI>
> >   <IRQ>
> >   _raw_spin_lock_irqsave+0x5b/0x70
> >   folio_lruvec_lock_irqsave+0x62/0x90
> >   folio_batch_move_lru+0x9d/0x160
> >   folio_rotate_reclaimable+0xab/0xf0
> >   folio_end_writeback+0x60/0x90
> >   end_buffer_async_write+0xaa/0xe0
> >   end_bio_bh_io_sync+0x2c/0x50
> >   bio_endio+0x108/0x180
> >   blk_mq_end_request_batch+0x11f/0x5e0
> >   nvme_pci_complete_batch+0xb5/0xd0 [nvme]
> >   nvme_irq+0x92/0xe0 [nvme]
> >   __handle_irq_event_percpu+0x6e/0x1e0
> >   handle_irq_event+0x39/0x80
> >   handle_edge_irq+0x8c/0x240
> >   __common_interrupt+0x4e/0xf0
> >   common_interrupt+0x49/0xc0
> >   asm_common_interrupt+0x27/0x40
> >
> >Here is the lock holder details captured by all-cpu-backtrace:
> >
> >NMI backtrace for cpu 75
> >CPU: 75 PID: 3095650 Comm: fio Not tainted
> >6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
> >RIP: 0010:folio_inc_gen+0x142/0x430
> >Call Trace:
> >   <NMI>
> >   ? show_regs+0x69/0x80
> >   ? nmi_cpu_backtrace+0xc5/0x130
> >   ? nmi_cpu_backtrace_handler+0x11/0x20
> >   ? nmi_handle+0x64/0x180
> >   ? default_do_nmi+0x45/0x130
> >   ? exc_nmi+0x128/0x1a0
> >   ? end_repeat_nmi+0xf/0x53
> >   ? folio_inc_gen+0x142/0x430
> >   ? folio_inc_gen+0x142/0x430
> >   ? folio_inc_gen+0x142/0x430
> >   </NMI>
> >   <TASK>
> >   isolate_folios+0x954/0x1630
> >   evict_folios+0xa5/0x8c0
> >   try_to_shrink_lruvec+0x1be/0x320
> >   shrink_one+0x10f/0x1d0
> >   shrink_node+0xa4c/0xc90
> >   do_try_to_free_pages+0xc0/0x590
> >   try_to_free_pages+0xde/0x210
> >   __alloc_pages_noprof+0x6ae/0x12c0
> >   alloc_pages_mpol_noprof+0xd9/0x220
> >   folio_alloc_noprof+0x63/0xe0
> >   filemap_alloc_folio_noprof+0xf4/0x100
> >   page_cache_ra_unbounded+0xb9/0x1a0
> >   page_cache_ra_order+0x26e/0x310
> >   ondemand_readahead+0x1a3/0x360
> >   page_cache_sync_ra+0x83/0x90
> >   filemap_get_pages+0xf0/0x6a0
> >   filemap_read+0xe7/0x3d0
> >   blkdev_read_iter+0x6f/0x140
> >   vfs_read+0x25b/0x340
> >   ksys_read+0x67/0xf0
> >   __x64_sys_read+0x19/0x20
> >   x64_sys_call+0x1771/0x20d0
> >   do_syscall_64+0x7e/0x130
>
> From the callstack of lock holder, it is looks like a scability issue rat=
her than a deadlock. Unlike legacy LRU management, there is no throttling m=
echanism for global reclaim under mglru so far.Could we apply the similar m=
ethod to throttle the reclaim when it is too aggresive. I am wondering if t=
his patch which is a rough version could help on this?
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2e34de9cd0d4..827036e21f24 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4520,6 +4520,50 @@ static int isolate_folios(struct lruvec *lruvec, s=
truct scan_control *sc, int sw
>         return scanned;
>  }
>
> +static void lru_gen_throttle(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +       struct lruvec *target_lruvec =3D mem_cgroup_lruvec(sc->target_mem=
_cgroup, pgdat);
> +
> +       if (current_is_kswapd()) {
> +               if (sc->nr.writeback && sc->nr.writeback =3D=3D sc->nr.ta=
ken)
> +                       set_bit(PGDAT_WRITEBACK, &pgdat->flags);
> +
> +               /* Allow kswapd to start writing pages during reclaim.*/
> +               if (sc->nr.unqueued_dirty =3D=3D sc->nr.file_taken)
> +                       set_bit(PGDAT_DIRTY, &pgdat->flags);
> +
> +               if (sc->nr.immediate)
> +                       reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK=
);
> +       }
> +
> +       /*
> +        * Tag a node/memcg as congested if all the dirty pages were mark=
ed
> +        * for writeback and immediate reclaim (counted in nr.congested).
> +        *
> +        * Legacy memcg will stall in page writeback so avoid forcibly
> +        * stalling in reclaim_throttle().
> +        */
> +       if (sc->nr.dirty && (sc->nr.dirty / 2 < sc->nr.congested)) {
> +               if (cgroup_reclaim(sc) && writeback_throttling_sane(sc))
> +                       set_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->=
flags);
> +
> +               if (current_is_kswapd())
> +                       set_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->fl=
ags);
> +       }
> +
> +       /*
> +        * Stall direct reclaim for IO completions if the lruvec is
> +        * node is congested. Allow kswapd to continue until it
> +        * starts encountering unqueued dirty pages or cycling through
> +        * the LRU too quickly.
> +        */
> +       if (!current_is_kswapd() && current_may_throttle() &&
> +           !sc->hibernation_mode &&
> +           (test_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags) ||
> +            test_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags)))
> +               reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
> +}
> +
>  static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, =
int swappiness)
>  {
>         int type;
> @@ -4552,6 +4596,16 @@ static int evict_folios(struct lruvec *lruvec, str=
uct scan_control *sc, int swap
>  retry:
>         reclaimed =3D shrink_folio_list(&list, pgdat, sc, &stat, false);
>         sc->nr_reclaimed +=3D reclaimed;
> +       sc->nr.dirty +=3D stat.nr_dirty;
> +       sc->nr.congested +=3D stat.nr_congested;
> +       sc->nr.unqueued_dirty +=3D stat.nr_unqueued_dirty;
> +       sc->nr.writeback +=3D stat.nr_writeback;
> +       sc->nr.immediate +=3D stat.nr_immediate;
> +       sc->nr.taken +=3D scanned;
> +
> +       if (type)
> +               sc->nr.file_taken +=3D scanned;
> +
>         trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
>                         scanned, reclaimed, &stat, sc->priority,
>                         type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
> @@ -5908,6 +5962,7 @@ static void shrink_node(pg_data_t *pgdat, struct sc=
an_control *sc)
>
>         if (lru_gen_enabled() && root_reclaim(sc)) {
>                 lru_gen_shrink_node(pgdat, sc);
> +               lru_gen_throttle(pgdat, sc);
>                 return;
>         }
Hi Bharata,
This patch arised from a regression Android test case failure which
allocated 1GB virtual memory by each over 8 threads on an 5.5GB RAM
system. This test could pass on legacy LRU management while failing
under MGLRU as a watchdog monitor detected abnormal system-wide
schedule status(watchdog can't be scheduled within 60 seconds). This
patch with a slight change as below got passed in the test whereas has
not been investigated deeply for how it was done. Theoretically, this
patch enrolled the similar reclaim throttle mechanism as legacy do
which could reduce the contention of lruvec->lru_lock. I think this
patch is quite naive for now=EF=BC=8C but I am hoping it could help you as
your case seems like a scability issue of memory pressure rather than
a deadlock issue. Thank you!

the change of the applied version(try to throttle the reclaim before
instead of after)
         if (lru_gen_enabled() && root_reclaim(sc)) {
 +               lru_gen_throttle(pgdat, sc);
                 lru_gen_shrink_node(pgdat, sc);
 -               lru_gen_throttle(pgdat, sc);
                 return;
         }
>
> --
> 2.25.1
>

