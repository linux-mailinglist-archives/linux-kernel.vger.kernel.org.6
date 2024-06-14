Return-Path: <linux-kernel+bounces-214301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD78D90827A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C091F23E70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0A82C76;
	Fri, 14 Jun 2024 03:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTYobvXz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE2383
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718335888; cv=none; b=XggTmpMOsOieT1HV+rOYsaoBObYI296CKJ4TXQfZSGvPJkcHXzTFIjB1RiIiBsVn6AFZqAzYpkEkrW2P/zZowN4O3sP1xBuUHpUSk6bj2fEI/vxvaZILgSYOW/4En2o0aCUhvLEpuLibxj8Yh1tViYpVUxftrw0oFLs7uNoh1RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718335888; c=relaxed/simple;
	bh=8rFw9qMsMH5LfC5bPa2f2ePPP8Oc4ZIgkZdN6Jvnh3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMeDm+OV4JgmuY9LyYb9dihpHHwijgrJKbCcKQxJ/lPtMjJQWoFk8GZA1J0OJ9mw0FYK3FJOVKTwl2WlVUlc58MlOGhxf7yV92h6j2jbRhzT6CGXjgv7lQeyaOwgnM5y6GXAu2KiEQmnjAirz7eqNjv/0SAqLQyDEoU3BV8A93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTYobvXz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e78fe9fc2bso20205321fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718335885; x=1718940685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ6udnD39dCm4AVi83klDXXN0/OUvxCDSDYNMIZLgYo=;
        b=GTYobvXz62H0rdHDfcfawgDKArsYqTE3FCCRnA2GMbwxZoNMJMlzUUvNxDe8LvfQjl
         ex+/ZaPPXfNuT35Lp7FBIMvHKxzZXxZdcs2F24lmApwxsGrpgNl8xY9ee9tcHHxe8Uxo
         xLUqY2cZOxQ9JpM1N05Km9zcTMuNChCOjrPKyYNHdq50DuoFMK+lMXalo48nHbMvViPb
         Of9OXKQ5/rp+3xzdWZbk/2qgSTLJdsl9T/ydP2dG/Yg6Qd6jbhWvaONNfDMtr3DE58o3
         dCCcbiIP+GY2zni9PNbUqDDJSNlFnqQmz1w2rdcn9I10yzLn8/QnbNtS53CYfEtHA314
         LN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718335885; x=1718940685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ6udnD39dCm4AVi83klDXXN0/OUvxCDSDYNMIZLgYo=;
        b=rnsnnotP9ptTncNa2rQwrlCIXWgy8waYjJJ4FRr/2q0s4KRi78WT622s0ji/rQUzcE
         FqoEdy7U9Q+mzJMNaAldDt2v53RBFpU2DxkUfVBnMAKM3AJnM8TOWGlAlRi3RzeDywZZ
         7RfPtSn9xFv8ACj17RFCVsdrL/HE60BUo8pPhZnThKn0BuQ/f8u4zFySL7ilywrYjvcE
         IyXemvVF8dlpmg59QmH1gxGtD4kst5SYSPqXe/zs863ZKEU1YCa9P6+va6StgqhRe44Q
         8yJi2vk+ajq+w6JksEYTr2fCj10HbF6Q21LoiBwpVwK3xCVzAVn5H7dj0s45luiFrOdE
         0VIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWArukrq8WQdNG6UUP2e8glxzCG7w2gJq6pBztn2yOGusS7dGOZC0qMx1jS7/MKKo+saT1aGYRwHXWMW0lnzqOz7H3NGFjLiPuTbGV
X-Gm-Message-State: AOJu0Yz/1Rpig//C+pVf/zm4YVG+ZrM7K77o8ymcJzLigrxmlxkgxldX
	yQlngtdYpNuMUAmIf1RrhVo6fbPRNkU0c9cH0M2wqGWiHoyuMKWnod2EcfVv5JIOSo61A4jnne4
	aq2voIq+n1EbT2LIFx1s9rWb9n2U=
X-Google-Smtp-Source: AGHT+IHXdtc9K5SUE8A5VPLgvrL9c6Lb8Si5GZnrAkoQ9bdtRJrgRvkcG9b9CD5cWW0o1zvpiJ2+gFbGUVVpEbx985I=
X-Received: by 2002:a2e:9e95:0:b0:2ec:1a6:71ad with SMTP id
 38308e7fff4ca-2ec0e5c661fmr9185191fa.19.1718335884522; Thu, 13 Jun 2024
 20:31:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412064353.133497-1-zhaoyang.huang@unisoc.com>
 <20240412143457.5c6c0ae8f6df0f647d7cf0be@linux-foundation.org>
 <CAGWkznHRyZDuumF=70DncgPHFM0+pgxuONh98Bykz5b-=rCjCQ@mail.gmail.com>
 <ZhxwIh2M8jr6IZaF@dread.disaster.area> <CAGWkznHDpw5Sw5pAfB=TdgRqsf=bmwUQ6+kvvLht3=wumNNo6Q@mail.gmail.com>
 <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl> <CAGWkznESMXeOhWnK93q1JJxhP0r4wR16cRJxiVzKZmM47GiEWw@mail.gmail.com>
 <CAGWkznEG78ppUXyoM2HKoo9MCOBJQaW=vSdSKDYXJj6kWH6zjA@mail.gmail.com>
 <2652f0c1-acc9-4288-8bca-c95ee49aa562@marcinwanat.pl> <CAGWkznE0psiqZYSRjF+Joq73--Yo-xUhGD0gnBa42fYC55BFdA@mail.gmail.com>
 <b4883f83-9f5d-46b2-b30e-f2e78506bf30@marcinwanat.pl> <5f989315-e380-46aa-80d1-ce8608889e5f@marcinwanat.pl>
In-Reply-To: <5f989315-e380-46aa-80d1-ce8608889e5f@marcinwanat.pl>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Fri, 14 Jun 2024 11:31:13 +0800
Message-ID: <CAGWkznEmnL8Xpg96RG-LUNsejfKuGwEtL3U+5cfXj=vMkzo5BQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Marcin Wanat <private@marcinwanat.pl>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Alex Shi <alexs@kernel.org>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 4:22=E2=80=AFPM Marcin Wanat <private@marcinwanat.p=
l> wrote:
>
> On 22.05.2024 12:13, Marcin Wanat wrote:
> > On 22.05.2024 07:37, Zhaoyang Huang wrote:
> >> On Tue, May 21, 2024 at 11:47=E2=80=AFPM Marcin Wanat <private@marcinw=
anat.pl>
> >> wrote:
> >>>
> >>> On 21.05.2024 03:00, Zhaoyang Huang wrote:
> >>>> On Tue, May 21, 2024 at 8:58=E2=80=AFAM Zhaoyang Huang
> >>>> <huangzhaoyang@gmail.com> wrote:
> >>>>>
> >>>>> On Tue, May 21, 2024 at 3:42=E2=80=AFAM Marcin Wanat
> >>>>> <private@marcinwanat.pl> wrote:
> >>>>>>
> >>>>>> On 15.04.2024 03:50, Zhaoyang Huang wrote:
> >>>>>> I have around 50 hosts handling high I/O (each with 20Gbps+ uplink=
s
> >>>>>> and multiple NVMe drives), running RockyLinux 8/9. The stock RHEL
> >>>>>> kernel 8/9 is NOT affected, and the long-term kernel 5.15.X is NOT
> >>>>>> affected.
> >>>>>> However, with long-term kernels 6.1.XX and 6.6.XX,
> >>>>>> (tested at least 10 different versions), this lockup always appear=
s
> >>>>>> after 2-30 days, similar to the report in the original thread.
> >>>>>> The more load (for example, copying a lot of local files while
> >>>>>> serving 20Gbps traffic), the higher the chance that the bug will
> >>>>>> appear.
> >>>>>>
> >>>>>> I haven't been able to reproduce this during synthetic tests,
> >>>>>> but it always occurs in production on 6.1.X and 6.6.X within 2-30
> >>>>>> days.
> >>>>>> If anyone can provide a patch, I can test it on multiple machines
> >>>>>> over the next few days.
> >>>>> Could you please try this one which could be applied on 6.6
> >>>>> directly. Thank you!
> >>>> URL: https://lore.kernel.org/linux-mm/20240412064353.133497-1-
> >>>> zhaoyang.huang@unisoc.com/
> >>>>
> >>>
> >>> Unfortunately, I am unable to cleanly apply this patch against the
> >>> latest 6.6.31
> >> Please try below one which works on my v6.6 based android. Thank you
> >> for your test in advance :D
> >>
> >> mm/huge_memory.c | 22 ++++++++++++++--------
> >>   1 file changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >
> > I have compiled 6.6.31 with this patch and will test it on multiple
> > machines over the next 30 days. I will provide an update after 30 days
> > if everything is fine or sooner if any of the hosts experience the same
> > soft lockup again.
> >
>
> First server with 6.6.31 and this patch hang today. Soft lockup changed
> to hard lockup:
>
> [26887.389623] watchdog: Watchdog detected hard LOCKUP on cpu 21
> [26887.389626] Modules linked in: nft_limit xt_limit xt_hashlimit
> ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_connlimit
> nf_conncount tls xt_set ip_set_hash_net ip_set xt_CT xt_conntrack
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables
> nfnetlink rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequency
> intel_uncore_frequency_common isst_if_common skx_edac nfit libnvdimm
> x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass
> rapl intel_cstate ipmi_ssif irdma ext4 mbcache ice iTCO_wdt jbd2 mgag200
> intel_pmc_bxt iTCO_vendor_support ib_uverbs i2c_algo_bit acpi_ipmi
> intel_uncore mei_me drm_shmem_helper pcspkr ib_core i2c_i801 ipmi_si
> drm_kms_helper mei lpc_ich i2c_smbus ioatdma intel_pch_thermal
> ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter joydev tcp_bbr
> drm fuse xfs libcrc32c sd_mod t10_pi sg crct10dif_pclmul crc32_pclmul
> crc32c_intel ixgbe polyval_clmulni ahci polyval_generic libahci mdio
> i40e libata megaraid_sas dca ghash_clmulni_intel wmi
> [26887.389682] CPU: 21 PID: 264 Comm: kswapd0 Kdump: loaded Tainted: G
>       W          6.6.31.el9 #3
> [26887.389685] Hardware name: FUJITSU PRIMERGY RX2540 M4/D3384-A1, BIOS
> V5.0.0.12 R1.22.0 for D3384-A1x                    06/04/2018
> [26887.389687] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389696] Code: 08 0f 92 c2 8b 45 00 0f b6 d2 c1 e2 08 30 e4 09 d0
> a9 00 01 ff ff 0f 85 ea 01 00 00 85 c0 74 12 0f b6 45 00 84 c0 74 0a f3
> 90 <0f> b6 45 00 84 c0 75 f6 b8 01 00 00 00 66 89 45 00 5b 5d 41 5c 41
> [26887.389698] RSP: 0018:ffffb3e587a87a20 EFLAGS: 00000002
> [26887.389700] RAX: 0000000000000001 RBX: ffff9ad6c6f67050 RCX:
> 0000000000000000
> [26887.389701] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff9ad6c6f67050
> [26887.389703] RBP: ffff9ad6c6f67050 R08: 0000000000000000 R09:
> 0000000000000067
> [26887.389704] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000046
> [26887.389705] R13: 0000000000000200 R14: 0000000000000000 R15:
> ffffe1138aa98000
> [26887.389707] FS:  0000000000000000(0000) GS:ffff9ade20340000(0000)
> knlGS:0000000000000000
> [26887.389708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [26887.389710] CR2: 000000002912809b CR3: 000000064401e003 CR4:
> 00000000007706e0
> [26887.389711] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [26887.389712] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [26887.389713] PKRU: 55555554
> [26887.389714] Call Trace:
> [26887.389717]  <NMI>
> [26887.389720]  ? watchdog_hardlockup_check+0xac/0x150
> [26887.389725]  ? __perf_event_overflow+0x102/0x1d0
> [26887.389729]  ? handle_pmi_common+0x189/0x3e0
> [26887.389735]  ? set_pte_vaddr_p4d+0x4a/0x60
> [26887.389738]  ? flush_tlb_one_kernel+0xa/0x20
> [26887.389742]  ? native_set_fixmap+0x65/0x80
> [26887.389745]  ? ghes_copy_tofrom_phys+0x75/0x110
> [26887.389751]  ? __ghes_peek_estatus.isra.0+0x49/0xb0
> [26887.389755]  ? intel_pmu_handle_irq+0x10b/0x230
> [26887.389756]  ? perf_event_nmi_handler+0x28/0x50
> [26887.389759]  ? nmi_handle+0x58/0x150
> [26887.389764]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389768]  ? default_do_nmi+0x6b/0x170
> [26887.389770]  ? exc_nmi+0x12c/0x1a0
> [26887.389772]  ? end_repeat_nmi+0x16/0x1f
> [26887.389777]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389780]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389784]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389787]  </NMI>
> [26887.389788]  <TASK>
> [26887.389789]  __raw_spin_lock_irqsave+0x3d/0x50
> [26887.389793]  folio_lruvec_lock_irqsave+0x5e/0x90
> [26887.389798]  __page_cache_release+0x68/0x230
> [26887.389801]  ? remove_migration_ptes+0x5c/0x80
> [26887.389807]  __folio_put+0x24/0x60
> [26887.389808]  __split_huge_page+0x368/0x520
> [26887.389812]  split_huge_page_to_list+0x4b3/0x570
> [26887.389816]  deferred_split_scan+0x1c8/0x290
> [26887.389819]  do_shrink_slab+0x12f/0x2d0
> [26887.389824]  shrink_slab_memcg+0x133/0x1d0
> [26887.389829]  shrink_node_memcgs+0x18e/0x1d0
> [26887.389832]  shrink_node+0xa7/0x370
> [26887.389836]  balance_pgdat+0x332/0x6f0
> [26887.389842]  kswapd+0xf0/0x190
> [26887.389845]  ? balance_pgdat+0x6f0/0x6f0
> [26887.389848]  kthread+0xee/0x120
> [26887.389851]  ? kthread_complete_and_exit+0x20/0x20
> [26887.389853]  ret_from_fork+0x2d/0x50
> [26887.389857]  ? kthread_complete_and_exit+0x20/0x20
> [26887.389859]  ret_from_fork_asm+0x11/0x20
> [26887.389864]  </TASK>
> [26887.389865] Kernel panic - not syncing: Hard LOCKUP
> [26887.389867] CPU: 21 PID: 264 Comm: kswapd0 Kdump: loaded Tainted: G
>       W          6.6.31.el9 #3
> [26887.389869] Hardware name: FUJITSU PRIMERGY RX2540 M4/D3384-A1, BIOS
> V5.0.0.12 R1.22.0 for D3384-A1x                    06/04/2018
> [26887.389870] Call Trace:
> [26887.389871]  <NMI>
> [26887.389872]  dump_stack_lvl+0x44/0x60
> [26887.389877]  panic+0x241/0x330
> [26887.389881]  nmi_panic+0x2f/0x40
> [26887.389883]  watchdog_hardlockup_check+0x119/0x150
> [26887.389886]  __perf_event_overflow+0x102/0x1d0
> [26887.389889]  handle_pmi_common+0x189/0x3e0
> [26887.389893]  ? set_pte_vaddr_p4d+0x4a/0x60
> [26887.389896]  ? flush_tlb_one_kernel+0xa/0x20
> [26887.389899]  ? native_set_fixmap+0x65/0x80
> [26887.389902]  ? ghes_copy_tofrom_phys+0x75/0x110
> [26887.389906]  ? __ghes_peek_estatus.isra.0+0x49/0xb0
> [26887.389909]  intel_pmu_handle_irq+0x10b/0x230
> [26887.389911]  perf_event_nmi_handler+0x28/0x50
> [26887.389913]  nmi_handle+0x58/0x150
> [26887.389916]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389920]  default_do_nmi+0x6b/0x170
> [26887.389922]  exc_nmi+0x12c/0x1a0
> [26887.389923]  end_repeat_nmi+0x16/0x1f
> [26887.389926] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389930] Code: 08 0f 92 c2 8b 45 00 0f b6 d2 c1 e2 08 30 e4 09 d0
> a9 00 01 ff ff 0f 85 ea 01 00 00 85 c0 74 12 0f b6 45 00 84 c0 74 0a f3
> 90 <0f> b6 45 00 84 c0 75 f6 b8 01 00 00 00 66 89 45 00 5b 5d 41 5c 41
> [26887.389931] RSP: 0018:ffffb3e587a87a20 EFLAGS: 00000002
> [26887.389933] RAX: 0000000000000001 RBX: ffff9ad6c6f67050 RCX:
> 0000000000000000
> [26887.389934] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffff9ad6c6f67050
> [26887.389935] RBP: ffff9ad6c6f67050 R08: 0000000000000000 R09:
> 0000000000000067
> [26887.389936] R10: 0000000000000000 R11: 0000000000000000 R12:
> 0000000000000046
> [26887.389937] R13: 0000000000000200 R14: 0000000000000000 R15:
> ffffe1138aa98000
> [26887.389940]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389943]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
> [26887.389946]  </NMI>
> [26887.389947]  <TASK>
> [26887.389947]  __raw_spin_lock_irqsave+0x3d/0x50
> [26887.389950]  folio_lruvec_lock_irqsave+0x5e/0x90
> [26887.389953]  __page_cache_release+0x68/0x230
> [26887.389955]  ? remove_migration_ptes+0x5c/0x80
> [26887.389958]  __folio_put+0x24/0x60
> [26887.389960]  __split_huge_page+0x368/0x520
> [26887.389963]  split_huge_page_to_list+0x4b3/0x570
> [26887.389967]  deferred_split_scan+0x1c8/0x290
> [26887.389971]  do_shrink_slab+0x12f/0x2d0
> [26887.389974]  shrink_slab_memcg+0x133/0x1d0
> [26887.389978]  shrink_node_memcgs+0x18e/0x1d0
> [26887.389982]  shrink_node+0xa7/0x370
> [26887.389985]  balance_pgdat+0x332/0x6f0
> [26887.389991]  kswapd+0xf0/0x190
> [26887.389994]  ? balance_pgdat+0x6f0/0x6f0
> [26887.389997]  kthread+0xee/0x120
> [26887.389998]  ? kthread_complete_and_exit+0x20/0x20
> [26887.390000]  ret_from_fork+0x2d/0x50
> [26887.390003]  ? kthread_complete_and_exit+0x20/0x20
> [26887.390004]  ret_from_fork_asm+0x11/0x20
> [26887.390009]  </TASK>
>
Hi Marcin. Sorry for this late reply. I think the above hard lockup is
caused by a recursive deadlock as [1] and has been fixed by [2] which
is on v6.8+. I would like to know if your regression test is still
going on? Thanks very much.

[1]
static void __split_huge_page(struct page *page, struct list_head *list,
                pgoff_t end, unsigned int new_order)
{
        /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
        lruvec =3D folio_lruvec_lock(folio);
                                                 //take lruvec_lock
here 1st

        for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
                __split_huge_page_tail(folio, i, lruvec, list, new_order);
                /* Some pages can be beyond EOF: drop them from page cache =
*/
                if (head[i].index >=3D end) {
                        folio_put(tail);
                            __page_cache_release
                                  folio_lruvec_lock_irqsave
                                                  //hanged by 2nd try

[2]
commit f1ee018baee9f4e724e08859c2559323be768be3
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Tue Feb 27 17:42:42 2024 +0000

    mm: use __page_cache_release() in folios_put()

    Pass a pointer to the lruvec so we can take advantage of the
    folio_lruvec_relock_irqsave().  Adjust the calling convention of
    folio_lruvec_relock_irqsave() to suit and add a page_cache_release()
    wrapper.

