Return-Path: <linux-kernel+bounces-243392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF879295AF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 00:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD161C20B41
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 22:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6C43DBB7;
	Sat,  6 Jul 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yBUOv9Ju"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDF28DA5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720305816; cv=none; b=nDKxHwL0dFu0bI0b60y7p3egiwsKCwcZhF5i6sQSOLDtpGfMkWKDq4glfeZ2dfajuRt5QmRvbPyvaP5ohDxecWMkxKwjZq4S9AxYj/s4YV1VHAqH5igQ/wortHiLDhJW+OENRhCgOEF2Mu//HaLdJ2VEW4dMG9dcKWLLVoxk4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720305816; c=relaxed/simple;
	bh=kUyq8sVoedtR3VHzsWRQARm9bzYyaRWO+SYPWzScqSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=upZ88zgh9HnTO5ew4/jdb8GCEDlkPAhL4SsisAKGK7xkrp9hTKo9NKph1rcftMWqdgPlc40RtgZ2OpU+gb+dr5Wk9EsmzOZFs1MAv679inOTea9iANBwis439FkAsL4N+LTTZk5rtQO/W7p66Rq26U1dDOyV7zuQAReqkh4aFb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yBUOv9Ju; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447df43324fso190371cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720305813; x=1720910613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mtPZfVdsm2WUV7DljjlEMJ5z3/1SkRV8dVNqKvxYdXI=;
        b=yBUOv9JuplwnEk/B3jf43NeIkyXTFomOOdVW0Mgi9XC2cwHYZ1Rl7uoc6jS6Z9+6jv
         MJqHlZ5eAU6XowhCIEUIhNPJBRjgToyh7xY+99vBTqFSJ183Lu5wORnbH3CP2sFK+eAa
         tIVwWYgl2u1SWTodc66LTspIaoVXC+UqkcCwc5I2CVJBRbe8LFuEvAFDDVQgwIQeF7GJ
         imxg3QBiXJEFag1S6KX4FaiO7D/hzeRt7Ht+VeOW8WVQPWXEmlh7Z7+KWQnk8UP2oC1l
         UDha3mDwdVgimRaZvJxJFS1T08fcuSAMfJXIXUqXitXEWSQ4uEHeEeyNjcITSGN5sVFa
         S5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720305813; x=1720910613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtPZfVdsm2WUV7DljjlEMJ5z3/1SkRV8dVNqKvxYdXI=;
        b=YSq6bd17EGg+UWwCvfXdzQso1It4QUM53PJBmHZK/Aqx8g5zlOFCCPdzfeAzbUIiNs
         +unCQgWjI7tqWNE+95nTvWeVQqSlzbyB4TDHiap4vONU6oTfRDlJSLUv1LGoP/ygkz+D
         dS3/LHCS2C15mCV2C+8CCH+nBH9JeM71qH3QLeQPCk4ixfqrHioE34pUWFKwvdDV9CgM
         8CyVMD7FNG68heSZ0qBpqtKCS6mp2bqU5DJ30pjFuSSnmkOKXRTVG+u4maJzwXJgUAVM
         JuxBS6CKra0ldNAofaEzZT0L1Y18nzwoITV+me7BQlmQbydeL5vlN6S6lOp4OFv9dHzV
         hzzA==
X-Forwarded-Encrypted: i=1; AJvYcCWJUMBabvIWiHWcXViondVc+oA2dsXg2QEPUHCS9VUcm2NT99+4RWBpUCAVuiIudYOxYkvlsBLT7M3DH305p26RoAP9VqxipcARtd+Y
X-Gm-Message-State: AOJu0YzWWukIVu7+ZlvUYnWxRU1ZPqmGOD32SsS4IZRRzqX9eXerDPaa
	8hpbt08VCg3YtGWGmMdOFGqX0+iNPf4Q1eqzTWbG2XsN9qn2X8+EOy8Ytf3WMhJF0cFY9v2yuEN
	uac+sCaI4go/Fz8sMmnT8S5TMzxyYTbcq6yJ/
X-Google-Smtp-Source: AGHT+IFpvQEh/olpIhsP6TJGXpZALlmbXq9RULlDf2hveUQvZpNcTWayPPEEFvKu7J/vpXURD/4FqIHMwjLn6mi+JHE=
X-Received: by 2002:ac8:6213:0:b0:447:c12a:6ee9 with SMTP id
 d75a77b69052e-447ca2387ffmr6055701cf.5.1720305813200; Sat, 06 Jul 2024
 15:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
In-Reply-To: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com>
From: Yu Zhao <yuzhao@google.com>
Date: Sat, 6 Jul 2024 16:42:54 -0600
Message-ID: <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Bharata B Rao <bharata@amd.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, nikunj@amd.com, 
	"Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, willy@infradead.org, vbabka@suse.cz, kinseyho@google.com, 
	Mel Gorman <mgorman@suse.de>
Content-Type: multipart/mixed; boundary="000000000000e79143061c9be878"

--000000000000e79143061c9be878
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bharata,

On Wed, Jul 3, 2024 at 9:11=E2=80=AFAM Bharata B Rao <bharata@amd.com> wrot=
e:
>
> Many soft and hard lockups are seen with upstream kernel when running a
> bunch of tests that include FIO and LTP filesystem test on 10 NVME
> disks. The lockups can appear anywhere between 2 to 48 hours. Originally
> this was reported on a large customer VM instance with passthrough NVME
> disks on older kernels(v5.4 based). However, similar problems were
> reproduced when running the tests on bare metal with latest upstream
> kernel (v6.10-rc3). Other lockups with different signatures are seen but
> in this report, only those related to MM area are being discussed.
> Also note that the subsequent description is related to the lockups in
> bare metal upstream (and not VM).
>
> The general observation is that the problem usually surfaces when the
> system free memory goes very low and page cache/buffer consumption hits
> the ceiling. Most of the times the two contended locks are lruvec and
> inode->i_lock spinlocks.
>
> - Could this be a scalability issue in LRU list handling and/or page
> cache invalidation typical to a large system configuration?
> - Are there any MM/FS tunables that could help here?
>
> Hardware configuration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dual socket  AMD EPYC 128 Core processor (256 cores, 512 threads)
> Memory: 1.5 TB
> 10 NVME - 3.5TB each
> available: 2 nodes (0-1)
> node 0 cpus: 0-127,256-383
> node 0 size: 773727 MB
> node 1 cpus: 128-255,384-511
> node 1 size: 773966 MB
>
> Workload details
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Workload includes concurrent runs of FIO and a few FS tests from LTP.
>
> FIO is run with a size of 1TB on each NVME partition with different
> combinations of ioengine/blocksize/mode parameters and buffered-IO.
> Selected FS tests from LTP are run on 256GB partitions of all NVME
> disks. This is the typical NVME partition layout.
>
> nvme2n1      259:4   0   3.5T  0 disk
> =E2=94=9C=E2=94=80nvme2n1p1  259:6   0   256G  0 part /data_nvme2n1p1
> =E2=94=94=E2=94=80nvme2n1p2  259:7   0   3.2T  0 part
>
> Though many different runs exist in the workload, the combination that
> results in the problem is buffered-IO run with sync engine.
>
> fio -filename=3D/dev/nvme1n1p2 -direct=3D0 -thread -size=3D1024G \
> -rwmixwrite=3D30  --norandommap --randrepeat=3D0 -ioengine=3Dsync -bs=3D4=
k \
> -numjobs=3D400 -runtime=3D25000 --time_based -group_reporting -name=3Dmyt=
est
>
> Watchdog threshold was reduced to 5s to reproduce the problem early and
> all CPU backtrace enabled.
>
> Problem details and analysis
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> One of the hard lockups which was observed and analyzed in detail is this=
:
>
> kernel: watchdog: Watchdog detected hard LOCKUP on cpu 284
> kernel: CPU: 284 PID: 924096 Comm: cat Not tainted 6.10.0-rc3-lruvec #9
> kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel: Call Trace:
> kernel:  <NMI>
> kernel:  ? show_regs+0x69/0x80
> kernel:  ? watchdog_hardlockup_check+0x19e/0x360
> <SNIP>
> kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel:  </NMI>
> kernel:  <TASK>
> kernel:  ? __pfx_lru_add_fn+0x10/0x10
> kernel: _raw_spin_lock_irqsave+0x42/0x50
> kernel: folio_lruvec_lock_irqsave+0x62/0xb0
> kernel: folio_batch_move_lru+0x79/0x2a0
> kernel: folio_add_lru+0x6d/0xf0
> kernel: filemap_add_folio+0xba/0xe0
> kernel: __filemap_get_folio+0x137/0x2e0
> kernel: ext4_da_write_begin+0x12c/0x270
> kernel: generic_perform_write+0xbf/0x200
> kernel: ext4_buffered_write_iter+0x67/0xf0
> kernel: ext4_file_write_iter+0x70/0x780
> kernel: vfs_write+0x301/0x420
> kernel: ksys_write+0x67/0xf0
> kernel: __x64_sys_write+0x19/0x20
> kernel: x64_sys_call+0x1689/0x20d0
> kernel: do_syscall_64+0x6b/0x110
> kernel: entry_SYSCALL_64_after_hwframe+0x76/0x7e        kernel: RIP:
> 0033:0x7fe21c314887
>
> With all CPU backtraces enabled, many CPUs are waiting for lruvec_lock
> acquisition. We measured the lruvec spinlock start, end and hold
> time(htime) using sched_clock(), along with a BUG() if the hold time was
> more than 10s. The below case shows that lruvec spin lock was held for ~2=
5s.
>
> kernel: vmscan: unlock_page_lruvec_irq: stime 27963327514341, etime
> 27963324369895, htime 25889317166
> kernel: ------------[ cut here ]------------
> kernel: kernel BUG at include/linux/memcontrol.h:1677!
> kernel: Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> kernel: CPU: 21 PID: 3211 Comm: kswapd0 Tainted: G        W
> 6.10.0-rc3-qspindbg #10
> kernel: RIP: 0010:shrink_active_list+0x40a/0x520
>
> And the corresponding trace point for the above:
> kswapd0-3211    [021] dN.1. 27963.324332: mm_vmscan_lru_isolate:
> classzone=3D0 order=3D0 nr_requested=3D1 nr_scanned=3D156946361
> nr_skipped=3D156946360 nr_taken=3D1 lru=3Dactive_file
>
> This shows that isolate_lru_folios() is scanning through a huge number
> (~150million) of folios (order=3D0) with lruvec spinlock held. This is
> happening because a large number of folios are being skipped to isolate
> a few ZONE_DMA folios. Though the number of folios to be scanned is
> bounded (32), there exists a genuine case where this can become
> unbounded, i.e. in case where folios are skipped.
>
> Meminfo output shows that the free memory is around ~2% and page/buffer
> cache grows very high when the lockup happens.
>
> MemTotal:       1584835956 kB
> MemFree:        27805664 kB
> MemAvailable:   1568099004 kB
> Buffers:        1386120792 kB
> Cached:         151894528 kB
> SwapCached:        30620 kB
> Active:         1043678892 kB
> Inactive:       494456452 kB
>
> Often times, the perf output at the time of the problem shows heavy
> contention on lruvec spin lock. Similar contention is also observed with
> inode i_lock (in clear_shadow_entry path)
>
> 98.98%  fio    [kernel.kallsyms]   [k] native_queued_spin_lock_slowpath
>     |
>      --98.96%--native_queued_spin_lock_slowpath
>         |
>          --98.96%--_raw_spin_lock_irqsave
>                    folio_lruvec_lock_irqsave
>                    |
>                     --98.78%--folio_batch_move_lru
>                         |
>                          --98.63%--deactivate_file_folio
>                                    mapping_try_invalidate
>                                    invalidate_mapping_pages
>                                    invalidate_bdev
>                                    blkdev_common_ioctl
>                                    blkdev_ioctl
>                                    __x64_sys_ioctl
>                                    x64_sys_call
>                                    do_syscall_64
>                                    entry_SYSCALL_64_after_hwframe
>
> Some experiments tried
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1) When MGLRU was enabled many soft lockups were observed, no hard
> lockups were seen for 48 hours run. Below is once such soft lockup.

This is not really an MGLRU issue -- can you please try one of the
attached patches? It (truncate.patch) should help with or without
MGLRU.

> kernel: watchdog: BUG: soft lockup - CPU#29 stuck for 11s! [fio:2701649]
> kernel: CPU: 29 PID: 2701649 Comm: fio Tainted: G             L
> 6.10.0-rc3-mglru-irqstrc #24
> kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel: Call Trace:
> kernel:  <IRQ>
> kernel:  ? show_regs+0x69/0x80
> kernel:  ? watchdog_timer_fn+0x223/0x2b0
> kernel:  ? __pfx_watchdog_timer_fn+0x10/0x10
> <SNIP>
> kernel:  </IRQ>
> kernel:  <TASK>
> kernel:  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
> kernel:  ? native_queued_spin_lock_slowpath+0x2b4/0x300
> kernel:  _raw_spin_lock+0x38/0x50
> kernel:  clear_shadow_entry+0x3d/0x100
> kernel:  ? __pfx_workingset_update_node+0x10/0x10
> kernel:  mapping_try_invalidate+0x117/0x1d0
> kernel:  invalidate_mapping_pages+0x10/0x20
> kernel:  invalidate_bdev+0x3c/0x50
> kernel:  blkdev_common_ioctl+0x5f7/0xa90
> kernel:  blkdev_ioctl+0x109/0x270
> kernel:  x64_sys_call+0x1215/0x20d0
> kernel:  do_syscall_64+0x7e/0x130
>
> This happens to be contending on inode i_lock spinlock.
>
> Below preemptirqsoff trace points to preemption being disabled for more
> than 10s and the lock in picture is lruvec spinlock.

Also if you could try the other patch (mglru.patch) please. It should
help reduce unnecessary rotations from deactivate_file_folio(), which
in turn should reduce the contention on the LRU lock for MGLRU.

>      # tracer: preemptirqsoff
>      #
>      # preemptirqsoff latency trace v1.1.5 on 6.10.0-rc3-mglru-irqstrc
>      # ------------------------------------------------------------------=
--
>      # latency: 10382682 us, #4/4, CPU#128 | (M:desktop VP:0, KP:0, SP:0
> HP:0 #P:512)
>      #    -----------------
>      #    | task: fio-2701523 (uid:0 nice:0 policy:0 rt_prio:0)
>      #    -----------------
>      #  =3D> started at: deactivate_file_folio
>      #  =3D> ended at:   deactivate_file_folio
>      #
>      #
>      #                    _------=3D> CPU#
>      #                   / _-----=3D> irqs-off/BH-disabled
>      #                  | / _----=3D> need-resched
>      #                  || / _---=3D> hardirq/softirq
>      #                  ||| / _--=3D> preempt-depth
>      #                  |||| / _-=3D> migrate-disable
>      #                  ||||| /     delay
>      #  cmd     pid     |||||| time  |   caller
>      #     \   /        ||||||  \    |    /
>           fio-2701523 128...1.    0us$: deactivate_file_folio
> <-deactivate_file_folio
>           fio-2701523 128.N.1. 10382681us : deactivate_file_folio
> <-deactivate_file_folio
>           fio-2701523 128.N.1. 10382683us : tracer_preempt_on
> <-deactivate_file_folio
>           fio-2701523 128.N.1. 10382691us : <stack trace>
>       =3D> deactivate_file_folio
>       =3D> mapping_try_invalidate
>       =3D> invalidate_mapping_pages
>       =3D> invalidate_bdev
>       =3D> blkdev_common_ioctl
>       =3D> blkdev_ioctl
>       =3D> __x64_sys_ioctl
>       =3D> x64_sys_call
>       =3D> do_syscall_64
>       =3D> entry_SYSCALL_64_after_hwframe
>
> 2) Increased low_watermark_threshold to 10% to prevent system from
> entering into extremely low memory situation. Although hard lockups
> weren't seen, but soft lockups (clear_shadow_entry()) were still seen.
>
> 3) AMD has a BIOS setting called NPS (Nodes per socket), using which a
> socket can be further partitioned into smaller NUMA nodes. With NPS=3D4,
> there will be four NUMA nodes in one socket, and hence 8 NUMA nodes in
> the system. This was done to check if having more number of kswapd
> threads working on lesser number of folios per node would make a
> difference. However here too, multiple  soft lockups were seen (in
> clear_shadow_entry() as seen in MGLRU case). No hard lockups were observe=
d.
>
> Any insights/suggestion into these lockups and suggestions are welcome!

Thanks!

--000000000000e79143061c9be878
Content-Type: application/octet-stream; name="mglru.patch"
Content-Disposition: attachment; filename="mglru.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyapmw8d0>
X-Attachment-Id: f_lyapmw8d0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1faW5saW5lLmggYi9pbmNsdWRlL2xpbnV4L21t
X2lubGluZS5oCmluZGV4IGQ5YThhNGFmZmFhZi4uN2QyNGQwNjVhZWQ4IDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L21tX2lubGluZS5oCisrKyBiL2luY2x1ZGUvbGludXgvbW1faW5saW5lLmgK
QEAgLTE4Miw2ICsxODIsMTYgQEAgc3RhdGljIGlubGluZSBib29sIGxydV9nZW5faXNfYWN0aXZl
KHN0cnVjdCBscnV2ZWMgKmxydXZlYywgaW50IGdlbikKIAlyZXR1cm4gZ2VuID09IGxydV9nZW5f
ZnJvbV9zZXEobWF4X3NlcSkgfHwgZ2VuID09IGxydV9nZW5fZnJvbV9zZXEobWF4X3NlcSAtIDEp
OwogfQogCitzdGF0aWMgaW5saW5lIGJvb2wgbHJ1X2dlbl9zaG91bGRfcm90YXRlKHN0cnVjdCBm
b2xpbyAqZm9saW8pCit7CisJaW50IGdlbiA9IGZvbGlvX2xydV9nZW4oZm9saW8pOworCWludCB0
eXBlID0gZm9saW9faXNfZmlsZV9scnUoZm9saW8pOworCXN0cnVjdCBscnV2ZWMgKmxydXZlYyA9
IGZvbGlvX2xydXZlYyhmb2xpbyk7CisJc3RydWN0IGxydV9nZW5fZm9saW8gKmxydWdlbiA9ICZs
cnV2ZWMtPmxydWdlbjsKKworCXJldHVybiBnZW4gIT0gbHJ1X2dlbl9mcm9tX3NlcShSRUFEX09O
Q0UobHJ1Z2VuLT5taW5fc2VxW3R5cGVdKSk7Cit9CisKIHN0YXRpYyBpbmxpbmUgdm9pZCBscnVf
Z2VuX3VwZGF0ZV9zaXplKHN0cnVjdCBscnV2ZWMgKmxydXZlYywgc3RydWN0IGZvbGlvICpmb2xp
bywKIAkJCQkgICAgICAgaW50IG9sZF9nZW4sIGludCBuZXdfZ2VuKQogewpkaWZmIC0tZ2l0IGEv
bW0vc3dhcC5jIGIvbW0vc3dhcC5jCmluZGV4IDgwMjY4MWIzYzg1Ny4uZTNkZDA5MjIyNGJhIDEw
MDY0NAotLS0gYS9tbS9zd2FwLmMKKysrIGIvbW0vc3dhcC5jCkBAIC02OTIsNyArNjkyLDcgQEAg
dm9pZCBkZWFjdGl2YXRlX2ZpbGVfZm9saW8oc3RydWN0IGZvbGlvICpmb2xpbykKIAlzdHJ1Y3Qg
Zm9saW9fYmF0Y2ggKmZiYXRjaDsKIAogCS8qIERlYWN0aXZhdGluZyBhbiB1bmV2aWN0YWJsZSBm
b2xpbyB3aWxsIG5vdCBhY2NlbGVyYXRlIHJlY2xhaW0gKi8KLQlpZiAoZm9saW9fdGVzdF91bmV2
aWN0YWJsZShmb2xpbykpCisJaWYgKGZvbGlvX3Rlc3RfdW5ldmljdGFibGUoZm9saW8pIHx8ICFs
cnVfZ2VuX3Nob3VsZF9yb3RhdGUoZm9saW8pKQogCQlyZXR1cm47CiAKIAlmb2xpb19nZXQoZm9s
aW8pOwo=
--000000000000e79143061c9be878
Content-Type: application/octet-stream; name="truncate.patch"
Content-Disposition: attachment; filename="truncate.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lyapn0xy1>
X-Attachment-Id: f_lyapn0xy1

ZGlmZiAtLWdpdCBhL21tL3RydW5jYXRlLmMgYi9tbS90cnVuY2F0ZS5jCmluZGV4IGU5OTA4NWJm
M2QzNC4uNTQ1MjExY2Y2MDYxIDEwMDY0NAotLS0gYS9tbS90cnVuY2F0ZS5jCisrKyBiL21tL3Ry
dW5jYXRlLmMKQEAgLTM5LDEyICszOSwyNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19jbGVhcl9z
aGFkb3dfZW50cnkoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJeGFzX3N0b3JlKCZ4
YXMsIE5VTEwpOwogfQogCi1zdGF0aWMgdm9pZCBjbGVhcl9zaGFkb3dfZW50cnkoc3RydWN0IGFk
ZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIHBnb2ZmX3QgaW5kZXgsCi0JCQkgICAgICAgdm9pZCAqZW50
cnkpCitzdGF0aWMgdm9pZCBjbGVhcl9zaGFkb3dfZW50cnkoc3RydWN0IGFkZHJlc3Nfc3BhY2Ug
Km1hcHBpbmcsCisJCQkgICAgICAgc3RydWN0IGZvbGlvX2JhdGNoICpmYmF0Y2gsIHBnb2ZmX3Qg
KmluZGljZXMpCiB7CisJaW50IGk7CisKKwlpZiAoc2htZW1fbWFwcGluZyhtYXBwaW5nKSB8fCBk
YXhfbWFwcGluZyhtYXBwaW5nKSkKKwkJcmV0dXJuOworCiAJc3Bpbl9sb2NrKCZtYXBwaW5nLT5o
b3N0LT5pX2xvY2spOwogCXhhX2xvY2tfaXJxKCZtYXBwaW5nLT5pX3BhZ2VzKTsKLQlfX2NsZWFy
X3NoYWRvd19lbnRyeShtYXBwaW5nLCBpbmRleCwgZW50cnkpOworCisJZm9yIChpID0gMDsgaSA8
IGZvbGlvX2JhdGNoX2NvdW50KGZiYXRjaCk7IGkrKykgeworCQlzdHJ1Y3QgZm9saW8gKmZvbGlv
ID0gZmJhdGNoLT5mb2xpb3NbaV07CisKKwkJaWYgKHhhX2lzX3ZhbHVlKGZvbGlvKSkKKwkJCV9f
Y2xlYXJfc2hhZG93X2VudHJ5KG1hcHBpbmcsIGluZGljZXNbaV0sIGZvbGlvKTsKKwl9CisKIAl4
YV91bmxvY2tfaXJxKCZtYXBwaW5nLT5pX3BhZ2VzKTsKIAlpZiAobWFwcGluZ19zaHJpbmthYmxl
KG1hcHBpbmcpKQogCQlpbm9kZV9hZGRfbHJ1KG1hcHBpbmctPmhvc3QpOwpAQCAtMTA1LDM2ICsx
MTcsNiBAQCBzdGF0aWMgdm9pZCB0cnVuY2F0ZV9mb2xpb19iYXRjaF9leGNlcHRpb25hbHMoc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJZmJhdGNoLT5uciA9IGo7CiB9CiAKLS8qCi0g
KiBJbnZhbGlkYXRlIGV4Y2VwdGlvbmFsIGVudHJ5IGlmIGVhc2lseSBwb3NzaWJsZS4gVGhpcyBo
YW5kbGVzIGV4Y2VwdGlvbmFsCi0gKiBlbnRyaWVzIGZvciBpbnZhbGlkYXRlX2lub2RlX3BhZ2Vz
KCkuCi0gKi8KLXN0YXRpYyBpbnQgaW52YWxpZGF0ZV9leGNlcHRpb25hbF9lbnRyeShzdHJ1Y3Qg
YWRkcmVzc19zcGFjZSAqbWFwcGluZywKLQkJCQkJcGdvZmZfdCBpbmRleCwgdm9pZCAqZW50cnkp
Ci17Ci0JLyogSGFuZGxlZCBieSBzaG1lbSBpdHNlbGYsIG9yIGZvciBEQVggd2UgZG8gbm90aGlu
Zy4gKi8KLQlpZiAoc2htZW1fbWFwcGluZyhtYXBwaW5nKSB8fCBkYXhfbWFwcGluZyhtYXBwaW5n
KSkKLQkJcmV0dXJuIDE7Ci0JY2xlYXJfc2hhZG93X2VudHJ5KG1hcHBpbmcsIGluZGV4LCBlbnRy
eSk7Ci0JcmV0dXJuIDE7Ci19Ci0KLS8qCi0gKiBJbnZhbGlkYXRlIGV4Y2VwdGlvbmFsIGVudHJ5
IGlmIGNsZWFuLiBUaGlzIGhhbmRsZXMgZXhjZXB0aW9uYWwgZW50cmllcyBmb3IKLSAqIGludmFs
aWRhdGVfaW5vZGVfcGFnZXMyKCkgc28gZm9yIERBWCBpdCBldmljdHMgb25seSBjbGVhbiBlbnRy
aWVzLgotICovCi1zdGF0aWMgaW50IGludmFsaWRhdGVfZXhjZXB0aW9uYWxfZW50cnkyKHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAotCQkJCQkgcGdvZmZfdCBpbmRleCwgdm9pZCAqZW50
cnkpCi17Ci0JLyogSGFuZGxlZCBieSBzaG1lbSBpdHNlbGYgKi8KLQlpZiAoc2htZW1fbWFwcGlu
ZyhtYXBwaW5nKSkKLQkJcmV0dXJuIDE7Ci0JaWYgKGRheF9tYXBwaW5nKG1hcHBpbmcpKQotCQly
ZXR1cm4gZGF4X2ludmFsaWRhdGVfbWFwcGluZ19lbnRyeV9zeW5jKG1hcHBpbmcsIGluZGV4KTsK
LQljbGVhcl9zaGFkb3dfZW50cnkobWFwcGluZywgaW5kZXgsIGVudHJ5KTsKLQlyZXR1cm4gMTsK
LX0KLQogLyoqCiAgKiBmb2xpb19pbnZhbGlkYXRlIC0gSW52YWxpZGF0ZSBwYXJ0IG9yIGFsbCBv
ZiBhIGZvbGlvLgogICogQGZvbGlvOiBUaGUgZm9saW8gd2hpY2ggaXMgYWZmZWN0ZWQuCkBAIC00
OTQsNiArNDc2LDcgQEAgdW5zaWduZWQgbG9uZyBtYXBwaW5nX3RyeV9pbnZhbGlkYXRlKHN0cnVj
dCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAogCXVuc2lnbmVkIGxvbmcgcmV0OwogCXVuc2lnbmVk
IGxvbmcgY291bnQgPSAwOwogCWludCBpOworCWJvb2wgeGFfaGFzX3ZhbHVlcyA9IGZhbHNlOwog
CiAJZm9saW9fYmF0Y2hfaW5pdCgmZmJhdGNoKTsKIAl3aGlsZSAoZmluZF9sb2NrX2VudHJpZXMo
bWFwcGluZywgJmluZGV4LCBlbmQsICZmYmF0Y2gsIGluZGljZXMpKSB7CkBAIC01MDMsOCArNDg2
LDggQEAgdW5zaWduZWQgbG9uZyBtYXBwaW5nX3RyeV9pbnZhbGlkYXRlKHN0cnVjdCBhZGRyZXNz
X3NwYWNlICptYXBwaW5nLAogCQkJLyogV2UgcmVseSB1cG9uIGRlbGV0aW9uIG5vdCBjaGFuZ2lu
ZyBmb2xpby0+aW5kZXggKi8KIAogCQkJaWYgKHhhX2lzX3ZhbHVlKGZvbGlvKSkgewotCQkJCWNv
dW50ICs9IGludmFsaWRhdGVfZXhjZXB0aW9uYWxfZW50cnkobWFwcGluZywKLQkJCQkJCQkgICAg
IGluZGljZXNbaV0sIGZvbGlvKTsKKwkJCQl4YV9oYXNfdmFsdWVzID0gdHJ1ZTsKKwkJCQljb3Vu
dCsrOwogCQkJCWNvbnRpbnVlOwogCQkJfQogCkBAIC01MjIsNiArNTA1LDEwIEBAIHVuc2lnbmVk
IGxvbmcgbWFwcGluZ190cnlfaW52YWxpZGF0ZShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGlu
ZywKIAkJCX0KIAkJCWNvdW50ICs9IHJldDsKIAkJfQorCisJCWlmICh4YV9oYXNfdmFsdWVzKQor
CQkJY2xlYXJfc2hhZG93X2VudHJ5KG1hcHBpbmcsICZmYmF0Y2gsIGluZGljZXMpOworCiAJCWZv
bGlvX2JhdGNoX3JlbW92ZV9leGNlcHRpb25hbHMoJmZiYXRjaCk7CiAJCWZvbGlvX2JhdGNoX3Jl
bGVhc2UoJmZiYXRjaCk7CiAJCWNvbmRfcmVzY2hlZCgpOwpAQCAtNjE2LDYgKzYwMyw3IEBAIGlu
dCBpbnZhbGlkYXRlX2lub2RlX3BhZ2VzMl9yYW5nZShzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFw
cGluZywKIAlpbnQgcmV0ID0gMDsKIAlpbnQgcmV0MiA9IDA7CiAJaW50IGRpZF9yYW5nZV91bm1h
cCA9IDA7CisJYm9vbCB4YV9oYXNfdmFsdWVzID0gZmFsc2U7CiAKIAlpZiAobWFwcGluZ19lbXB0
eShtYXBwaW5nKSkKIAkJcmV0dXJuIDA7CkBAIC02MjksOCArNjE3LDkgQEAgaW50IGludmFsaWRh
dGVfaW5vZGVfcGFnZXMyX3JhbmdlKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAogCQkJ
LyogV2UgcmVseSB1cG9uIGRlbGV0aW9uIG5vdCBjaGFuZ2luZyBmb2xpby0+aW5kZXggKi8KIAog
CQkJaWYgKHhhX2lzX3ZhbHVlKGZvbGlvKSkgewotCQkJCWlmICghaW52YWxpZGF0ZV9leGNlcHRp
b25hbF9lbnRyeTIobWFwcGluZywKLQkJCQkJCWluZGljZXNbaV0sIGZvbGlvKSkKKwkJCQl4YV9o
YXNfdmFsdWVzID0gdHJ1ZTsKKwkJCQlpZiAoZGF4X21hcHBpbmcobWFwcGluZykgJiYKKwkJCQkg
ICAgIWRheF9pbnZhbGlkYXRlX21hcHBpbmdfZW50cnlfc3luYyhtYXBwaW5nLCBpbmRpY2VzW2ld
KSkKIAkJCQkJcmV0ID0gLUVCVVNZOwogCQkJCWNvbnRpbnVlOwogCQkJfQpAQCAtNjY2LDYgKzY1
NSwxMCBAQCBpbnQgaW52YWxpZGF0ZV9pbm9kZV9wYWdlczJfcmFuZ2Uoc3RydWN0IGFkZHJlc3Nf
c3BhY2UgKm1hcHBpbmcsCiAJCQkJcmV0ID0gcmV0MjsKIAkJCWZvbGlvX3VubG9jayhmb2xpbyk7
CiAJCX0KKworCQlpZiAoeGFfaGFzX3ZhbHVlcykKKwkJCWNsZWFyX3NoYWRvd19lbnRyeShtYXBw
aW5nLCAmZmJhdGNoLCBpbmRpY2VzKTsKKwogCQlmb2xpb19iYXRjaF9yZW1vdmVfZXhjZXB0aW9u
YWxzKCZmYmF0Y2gpOwogCQlmb2xpb19iYXRjaF9yZWxlYXNlKCZmYmF0Y2gpOwogCQljb25kX3Jl
c2NoZWQoKTsK
--000000000000e79143061c9be878--

