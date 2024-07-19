Return-Path: <linux-kernel+bounces-257671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF5937D48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698A11C2142E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF5A1482FC;
	Fri, 19 Jul 2024 20:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bic+FkvK"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03D4696
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721420518; cv=none; b=W40FVDy5VcUUuqHRBHPHUcKAopH0vKCPOo+UErCI6xnjx59JhFwaYDtd9d8jMwB+5oSMsmtUszxUd+VMzvA25EenpDp3rdvWh1Td7MW1vkK8BsHa8wOi876G80ajjToLWX8N3oBGvYhNEaYarYb3OyJKLJWFicNtJ+oBOv7FivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721420518; c=relaxed/simple;
	bh=VEDocWuv5lKZKxbHiJQRcvqe8yr5WwG0uvEPg0ieLX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emm9Xq3WwXp9dsn4r7UwqOTe2PJAt5OrRyR0g7pGhyClHJzmQnOv04ifZJkF5CLWRp3sS2FXnaFwcUVwm11VNn6reazUH+IaaNX2gBfRA1SfAxBgwFt/V0SbTu9C3RGxPOHbFhGMBqW/4Qk8YUMyRbkCyqVyQotyQaNaJ+vKrDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bic+FkvK; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44f9d7cb5c5so273661cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721420516; x=1722025316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdws4MyNnhAs5gi9zsaWYzhNp75XrkQajWxb10oUwCg=;
        b=Bic+FkvKk57R8NaYqTLaBxHbsQpsAJ8BDcWiMWR2O1eXoJsUNoypNbb0wZxN6CgX/w
         V1ACrAYWJPmWm6qt91nzfgRRBxgenjiFPc5mYXLL8bKZJs9rgLw05rXkvoAdmH+WvUKJ
         cshpzeK80ACh75cT2v5mjH76eFWjPTdLmcQdfB1HRQDThBrdGAVT2+O4e55FNZLd1rlB
         EEQbySISTYOyoaRcnXKNkSh0EDGiTEeErEx1Qnn+4CD2PMicHmI09gRbFhJjl25e46YQ
         weGsZNrxS8BAk1eDlnw6mNF1/2s7vTwaiLm/aboXs+LD2Es7IRzZb071XJW4ZYx9i88f
         hSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721420516; x=1722025316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdws4MyNnhAs5gi9zsaWYzhNp75XrkQajWxb10oUwCg=;
        b=W1t07HFjDg2fN+tf2uMAKk0G+iDHaU43zcj0bn9cMv6gqyu9t0lBhz8qxm9h26W9WA
         tKCv9bOcKJvQ4VLmBoumAfhHduGvufExdmckrf3mK/YP/NHwIjKCgHOa0R8AiopjV/qa
         +zHv0H8Qcedr0bdwMhBeHb0zuPgq+a0k+yGCUhGcsGhToIl2PSdLCwH4+He5OCgbdZes
         ybqrlAKEgSTTUfgBorddZpzqNK3pedAejvj+TVwiH75Z0T3+Dvz29XtHxe4IeVcWNb8C
         VOjLoVLwuZ+ETsNP+qb+Pym6HFALA+5PG5V8MoBwJETWdgeXixw7bvSc51z9Pwf5O1m/
         6yHg==
X-Forwarded-Encrypted: i=1; AJvYcCWD7UwU6wzZAbtrq26Dl444R0hB0whMMBYVprGqndCfplQAWmZom8WsEQc+zllXjxMiiu6SdkDubQ6NAxccJ4Ou1kPm1Bqkf70ell4/
X-Gm-Message-State: AOJu0YyeDb3h7aWXeEsOcjcUcZrGx+NL5MGJeimIC04yjWTE6rDNU+FI
	669R2bA4ncLa/eBvLnjy5NqIMWWfzbzxvr0DEDNVg/a1WfxpGjjYM1iLdyOdVmnoYr5BX0vJ89d
	RFPa0ScmIRgJ6+897QzVtZhDnkj5ABQyjRIL4qf0NmRMO1W6mzYgm
X-Google-Smtp-Source: AGHT+IGn2uWxsFNxJk0mzfVjqtT5lV4S7DxPzbKyGp8z+OHNXT7r6FlMUUDayXvxx0KOG9uRtLFAQVIQOBTHumtUVgw=
X-Received: by 2002:a05:622a:120f:b0:447:f108:f80e with SMTP id
 d75a77b69052e-44f9acae1c5mr4564931cf.16.1721420515530; Fri, 19 Jul 2024
 13:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com> <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com> <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
 <b68e43d4-91f2-4481-80a9-d166c0a43584@amd.com> <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
In-Reply-To: <893a263a-0038-4b4b-9031-72567b966f73@amd.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 19 Jul 2024 14:21:17 -0600
Message-ID: <CAOUHufbkhMZYz20aM_3rHZ3OcK4m2puji2FGpUpn_-DevGk3Kg@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>, mjguzik@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 14, 2024 at 11:20=E2=80=AFPM Bharata B Rao <bharata@amd.com> wr=
ote:
>
> On 11-Jul-24 11:13 AM, Bharata B Rao wrote:
> > On 09-Jul-24 11:28 AM, Yu Zhao wrote:
> >> On Mon, Jul 8, 2024 at 10:31=E2=80=AFPM Bharata B Rao <bharata@amd.com=
> wrote:
> >>>
> >>> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
> >>>> On Mon, Jul 8, 2024 at 8:34=E2=80=AFAM Bharata B Rao <bharata@amd.co=
m> wrote:
> >>>>>
> >>>>> Hi Yu Zhao,
> >>>>>
> >>>>> Thanks for your patches. See below...
> >>>>>
> >>>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> >>>>>> Hi Bharata,
> >>>>>>
> >>>>>> On Wed, Jul 3, 2024 at 9:11=E2=80=AFAM Bharata B Rao <bharata@amd.=
com> wrote:
> >>>>>>>
> >>>>> <snip>
> >>>>>>>
> >>>>>>> Some experiments tried
> >>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >>>>>>> 1) When MGLRU was enabled many soft lockups were observed, no har=
d
> >>>>>>> lockups were seen for 48 hours run. Below is once such soft locku=
p.
> >>>>>>
> >>>>>> This is not really an MGLRU issue -- can you please try one of the
> >>>>>> attached patches? It (truncate.patch) should help with or without
> >>>>>> MGLRU.
> >>>>>
> >>>>> With truncate.patch and default LRU scheme, a few hard lockups are
> >>>>> seen.
> >>>>
> >>>> Thanks.
> >>>>
> >>>> In your original report, you said:
> >>>>
> >>>>     Most of the times the two contended locks are lruvec and
> >>>>     inode->i_lock spinlocks.
> >>>>     ...
> >>>>     Often times, the perf output at the time of the problem shows
> >>>>     heavy contention on lruvec spin lock. Similar contention is
> >>>>     also observed with inode i_lock (in clear_shadow_entry path)
> >>>>
> >>>> Based on this new report, does it mean the i_lock is not as contende=
d,
> >>>> for the same path (truncation) you tested? If so, I'll post
> >>>> truncate.patch and add reported-by and tested-by you, unless you hav=
e
> >>>> objections.
> >>>
> >>> truncate.patch has been tested on two systems with default LRU scheme
> >>> and the lockup due to inode->i_lock hasn't been seen yet after 24
> >>> hours run.
> >>
> >> Thanks.
> >>
> >>>>
> >>>> The two paths below were contended on the LRU lock, but they already
> >>>> batch their operations. So I don't know what else we can do surgical=
ly
> >>>> to improve them.
> >>>
> >>> What has been seen with this workload is that the lruvec spinlock is
> >>> held for a long time from shrink_[active/inactive]_list path. In this
> >>> path, there is a case in isolate_lru_folios() where scanning of LRU
> >>> lists can become unbounded. To isolate a page from ZONE_DMA, sometime=
s
> >>> scanning/skipping of more than 150 million folios were seen. There is
> >>> already a comment in there which explains why nr_skipped shouldn't be
> >>> counted, but is there any possibility of re-looking at this condition=
?
> >>
> >> For this specific case, probably this can help:
> >>
> >> @@ -1659,8 +1659,15 @@ static unsigned long
> >> isolate_lru_folios(unsigned long nr_to_scan,
> >>                  if (folio_zonenum(folio) > sc->reclaim_idx ||
> >>                                  skip_cma(folio, sc)) {
> >>                          nr_skipped[folio_zonenum(folio)] +=3D nr_page=
s;
> >> -                       move_to =3D &folios_skipped;
> >> -                       goto move;
> >> +                       list_move(&folio->lru, &folios_skipped);
> >> +                       if (spin_is_contended(&lruvec->lru_lock)) {
> >> +                               if (!list_empty(dst))
> >> +                                       break;
> >> +                               spin_unlock_irq(&lruvec->lru_lock);
> >> +                               cond_resched();
> >> +                               spin_lock_irq(&lruvec->lru_lock);
> >> +                       }
> >> +                       continue;
> >>                  }
> >
> > Thanks, this helped. With this fix, the test ran for 24hrs without any
> > lockups attributable to lruvec spinlock. As noted in this thread,
> > earlier isolate_lru_folios() used to scan millions of folios and spend =
a
> > lot of time with spinlock held but after this fix, such a scenario is n=
o
> > longer seen.
>
> However during the weekend mglru-enabled run (with above fix to
> isolate_lru_folios() and also the previous two patches: truncate.patch
> and mglru.patch and the inode fix provided by Mateusz), another hard
> lockup related to lruvec spinlock was observed.

Thanks again for the stress tests.

I can't come up with any reasonable band-aid at this moment, i.e.,
something not too ugly to work around a more fundamental scalability
problem.

Before I give up: what type of dirty data was written back to the nvme
device? Was it page cache or swap?

> Here is the hardlock up:
>
> watchdog: Watchdog detected hard LOCKUP on cpu 466
> CPU: 466 PID: 3103929 Comm: fio Not tainted
> 6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
> RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> Call Trace:
>    <NMI>
>    ? show_regs+0x69/0x80
>    ? watchdog_hardlockup_check+0x1b4/0x3a0
> <SNIP>
>    ? native_queued_spin_lock_slowpath+0x2b4/0x300
>    </NMI>
>    <IRQ>
>    _raw_spin_lock_irqsave+0x5b/0x70
>    folio_lruvec_lock_irqsave+0x62/0x90
>    folio_batch_move_lru+0x9d/0x160
>    folio_rotate_reclaimable+0xab/0xf0
>    folio_end_writeback+0x60/0x90
>    end_buffer_async_write+0xaa/0xe0
>    end_bio_bh_io_sync+0x2c/0x50
>    bio_endio+0x108/0x180
>    blk_mq_end_request_batch+0x11f/0x5e0
>    nvme_pci_complete_batch+0xb5/0xd0 [nvme]
>    nvme_irq+0x92/0xe0 [nvme]
>    __handle_irq_event_percpu+0x6e/0x1e0
>    handle_irq_event+0x39/0x80
>    handle_edge_irq+0x8c/0x240
>    __common_interrupt+0x4e/0xf0
>    common_interrupt+0x49/0xc0
>    asm_common_interrupt+0x27/0x40
>
> Here is the lock holder details captured by all-cpu-backtrace:
>
> NMI backtrace for cpu 75
> CPU: 75 PID: 3095650 Comm: fio Not tainted
> 6.10.0-rc3-trnct_nvme_lruvecresched_sirq_inode_mglru #32
> RIP: 0010:folio_inc_gen+0x142/0x430
> Call Trace:
>    <NMI>
>    ? show_regs+0x69/0x80
>    ? nmi_cpu_backtrace+0xc5/0x130
>    ? nmi_cpu_backtrace_handler+0x11/0x20
>    ? nmi_handle+0x64/0x180
>    ? default_do_nmi+0x45/0x130
>    ? exc_nmi+0x128/0x1a0
>    ? end_repeat_nmi+0xf/0x53
>    ? folio_inc_gen+0x142/0x430
>    ? folio_inc_gen+0x142/0x430
>    ? folio_inc_gen+0x142/0x430
>    </NMI>
>    <TASK>
>    isolate_folios+0x954/0x1630
>    evict_folios+0xa5/0x8c0
>    try_to_shrink_lruvec+0x1be/0x320
>    shrink_one+0x10f/0x1d0
>    shrink_node+0xa4c/0xc90
>    do_try_to_free_pages+0xc0/0x590
>    try_to_free_pages+0xde/0x210
>    __alloc_pages_noprof+0x6ae/0x12c0
>    alloc_pages_mpol_noprof+0xd9/0x220
>    folio_alloc_noprof+0x63/0xe0
>    filemap_alloc_folio_noprof+0xf4/0x100
>    page_cache_ra_unbounded+0xb9/0x1a0
>    page_cache_ra_order+0x26e/0x310
>    ondemand_readahead+0x1a3/0x360
>    page_cache_sync_ra+0x83/0x90
>    filemap_get_pages+0xf0/0x6a0
>    filemap_read+0xe7/0x3d0
>    blkdev_read_iter+0x6f/0x140
>    vfs_read+0x25b/0x340
>    ksys_read+0x67/0xf0
>    __x64_sys_read+0x19/0x20
>    x64_sys_call+0x1771/0x20d0
>    do_syscall_64+0x7e/0x130
>
> Regards,
> Bharata.

