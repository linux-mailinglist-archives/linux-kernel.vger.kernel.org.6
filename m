Return-Path: <linux-kernel+bounces-195089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3728D4776
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B3A1F236DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426876F316;
	Thu, 30 May 2024 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX7vJ/0o"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DA01761BF
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717058968; cv=none; b=qzOTaQZd5hjeGLcJwhKHQUl/CFmYTUHngrVD1exBSyipXBPu6/TmHEvO46QKKMyodOzvCIqqRs84VPYMECogFgFvbG33BPsBZAv/rOmVi8yB2sXfsuGVyl0ykHFguV/9/rq/iSnyJdIV0SqlkRCEqsrj9Eq6bSC6tRoSm4h2z68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717058968; c=relaxed/simple;
	bh=+y3/gRPevLrtTRV1nY3A/ZB62XOMtFSPJDz9MbuLUgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHRlfd/GtatzBCHKU3I+sTZV7w8i/t8u7UxIYI57x2mmDipJdNpftt3RZnkWKpgh8bzBJltf3j8dfmIduuh51wasyLJH+PX80yP4g9mCgiQLt2/S3n7XDYryxmO0saLVj0t4spibhfFhFmJBd6l+MSev6M9HfWFxlzs+fdi2bbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX7vJ/0o; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6ad935156fdso3160436d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717058965; x=1717663765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ftIuhWfs+Mxz048UVnAoWIC6fVw6vdY8fyEsIsg924=;
        b=XX7vJ/0o563kZa7ejDqyL38E3VTFFGwFrkuzYdbYGAHNHEKbFeTP9H+7DRhdOVz+4Z
         91cmA2sFj4/EkUXzBXbq5vA0ZpmwmImkpi2Kp4aEHLOa5rlp58uopum8ahgwzoNohF7u
         EKdHDLVXq5DlDU2i6Hl/pa6cRt0pJJNJQrTcEuxKd3E0WWRDPKl+PV0lhFnKNKTgSN8F
         n1duPg7c4WfoWppshG52GU3C8nZr7EsW8OmYG7xYJTNrdG6N3Pph0AiGQnEy6LRRgkyo
         P5Vtn6RnbmFt7t1r5uosRwQEPiEFb0oGxrfzXwDsz0+/o4nvpn+yGF17bDTXmKZaz4ZK
         fr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717058965; x=1717663765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ftIuhWfs+Mxz048UVnAoWIC6fVw6vdY8fyEsIsg924=;
        b=tB7nEWzNS51SIvcAHI3J+i/uDzYQ0EvyVMukEBI0wtUQvQxasuyAIhqLitUB63wKj4
         Mf5/D33w9J7IXykOad9tx1oE9GAU3aIn8BQa9KCRX5volwiNnqQLbKsVEvajfbDpmjU8
         52Fqbbna8NbFxlGBhKsEKYW2p29ZbbmQIAob9Qbl1A4quzVwnu5IPCMmQMB7bRTczMNu
         /mHsi6yfnjwPV7QrWoiXgt8vodprel7B4zd4uvGJX3pfw3der0qG6rEI6G3XaSet76P1
         WTJWd9vJ0dCriSwoXxgJASodBw9R6rSNMQ92BGkWxmVRn2L5hOv41ZYHOiMamPaFNmGU
         9fCg==
X-Forwarded-Encrypted: i=1; AJvYcCUQyJqctytL1+1+1dNdwsyhz/KHotX8cvo/MsEbwVbiybcCTlQ3D9ZCoEGKb8PT1vGdg5zGlKhQA2COOeCEbRyV2kNM7cLBcT2DzNMB
X-Gm-Message-State: AOJu0YxLuCJlAyn2pll9UHtceXSJs6WyUCB5PBQAxHTwheONRwDxdIBa
	XCuUJQOFvdlEL9ng/t8JqmrUnP45Rv20gja5fqPZ3K17JbeTU8kjyZWMGgwhhDmQQolRVoNQ/YI
	ENjxJ6etccMmHnmVnhH+wGfwG6gg=
X-Google-Smtp-Source: AGHT+IEJ5TAI0FO2DoBTmKfH6BPuobxnrXjOxLP6Sf/9F6QQxpijnEJ+Wcx0WH0vWcEKklH3M9mpIlo2uxDaL1E2ncA=
X-Received: by 2002:a05:6214:3288:b0:6ab:8db1:8223 with SMTP id
 6a1803df08f44-6ae0cafc324mr15189446d6.13.1717058964800; Thu, 30 May 2024
 01:49:24 -0700 (PDT)
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
 <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl>
In-Reply-To: <d9f7c779-acc0-4b8b-993e-e56e9475438e@marcinwanat.pl>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 30 May 2024 16:48:48 +0800
Message-ID: <CALOAHbBQJfP5mXtuUf6gzsNziWkHapK2936-ZvH7_C=QdzXi8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: protect xa split stuff under lruvec->lru_lock
 during migration
To: Marcin Wanat <private@marcinwanat.pl>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, 
	Alex Shi <alexs@kernel.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 3:42=E2=80=AFAM Marcin Wanat <private@marcinwanat.p=
l> wrote:
>
> On 15.04.2024 03:50, Zhaoyang Huang wrote:
> > On Mon, Apr 15, 2024 at 8:09=E2=80=AFAM Dave Chinner <david@fromorbit.c=
om> > wrote: >> >> On Sat, Apr 13, 2024 at 10:01:27AM +0800, Zhaoyang
> Huang wrote: >>> loop Dave, since he has ever helped set up an
> reproducer in >>> https://lore.kernel.org/linux- >>>
> mm/20221101071721.GV2703033@dread.disaster.area/ @Dave Chinner , >>> I
> would like to ask for your kindly help on if you can verify >>> this
> patch on your environment if convenient. Thanks a lot. >> >> I don't
> have the test environment from 18 months ago available any >> more.
> Also, I haven't seen this problem since that specific test >>
> environment tripped over the issue. Hence I don't have any way of >>
> confirming that the problem is fixed, either, because first I'd >> have
> to reproduce it... > Thanks for the information. I noticed that you
> reported another soft > lockup which is related to xas_load since
> NOV.2023. This patch is > supposed to be helpful for this. With regard
> to the version timing, > this commit is actually a revert of <mm/thp:
> narrow lru locking> > b6769834aac1d467fa1c71277d15688efcbb4d76 which is
> merged before > v5.15. > > For saving your time, a brief description
> below. IMO, b6769834aa > introduce a potential stall between freeze the
> folio's refcnt and > store it back to 2, which have the
> xas_load->folio_try_get_rcu loops > as livelock if it stalls the
> lru_lock's holder. > > b6769834aa split_huge_page_to_list -
> spin_lock(lru_lock) > xas_split(&xas, folio,order)
> folio_refcnt_freeze(folio, 1 + > folio_nr_pages(folio0) +
> spin_lock(lru_lock) xas_store(&xas, > offset++, head+i)
> page_ref_add(head, 2) spin_unlock(lru_lock) > > Sorry in advance if the
> above doesn't make sense, I am just a > developer who is also suffering
> from this bug and trying to fix it
> I am experiencing a similar error on dozens of hosts, with stack traces
> that are all similar:
>
> [627163.727746] watchdog: BUG: soft lockup - CPU#77 stuck for 22s!
> [file_get:953301]
> [627163.727778] Modules linked in: xt_set ip_set_hash_net ip_set xt_CT
> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat
> nf_tables nfnetlink sr_mod cdrom rfkill vfat fat intel_rapl_msr
> intel_rapl_common intel_uncore_frequency intel_uncore_frequency_common
> isst_if_common skx_edac nfit libnvdimm x86_pkg_temp_thermal
> intel_powerclamp coretemp ipmi_ssif kvm_intel kvm irqbypass mlx5_ib rapl
> iTCO_wdt intel_cstate intel_pmc_bxt ib_uverbs iTCO_vendor_support
> dell_smbios dcdbas i2c_i801 intel_uncore uas ses mei_me ib_core
> dell_wmi_descriptor wmi_bmof pcspkr enclosure lpc_ich usb_storage
> i2c_smbus acpi_ipmi mei intel_pch_thermal ipmi_si ipmi_devintf
> ipmi_msghandler acpi_power_meter joydev tcp_bbr fuse xfs libcrc32c raid1
> sd_mod sg mlx5_core crct10dif_pclmul crc32_pclmul crc32c_intel
> polyval_clmulni mgag200 polyval_generic drm_kms_helper mlxfw
> drm_shmem_helper ahci nvme mpt3sas tls libahci ghash_clmulni_intel
> nvme_core psample drm igb t10_pi raid_class pci_hyperv_intf dca libata
> scsi_transport_sas i2c_algo_bit wmi
> [627163.727841] CPU: 77 PID: 953301 Comm: file_get Kdump: loaded
> Tainted: G             L     6.6.30.el9 #2
> [627163.727844] Hardware name: Dell Inc. PowerEdge R740xd/08D89F, BIOS
> 2.21.2 02/19/2024
> [627163.727847] RIP: 0010:xas_descend+0x1b/0x70
> [627163.727857] Code: 57 10 48 89 07 48 c1 e8 20 48 89 57 08 c3 cc 0f b6
> 0e 48 8b 47 08 48 d3 e8 48 89 c1 83 e1 3f 89 c8 48 83 c0 04 48 8b 44 c6
> 08 <48> 89 77 18 48 89 c2 83 e2 03 48 83 fa 02 74 0a 88 4f 12 c3 48 83
> [627163.727859] RSP: 0018:ffffc90034a67978 EFLAGS: 00000206
> [627163.727861] RAX: ffff888e4f971242 RBX: ffffc90034a67a98 RCX:
> 0000000000000020
> [627163.727863] RDX: 0000000000000002 RSI: ffff88a454546d80 RDI:
> ffffc90034a67990
> [627163.727865] RBP: fffffffffffffffe R08: fffffffffffffffe R09:
> 0000000000008820
> [627163.727867] R10: 0000000000008820 R11: 0000000000000000 R12:
> ffffc90034a67a20
> [627163.727868] R13: ffffc90034a67a18 R14: ffffea00873e8000 R15:
> ffffc90034a67a18
> [627163.727870] FS:  00007fc5e503b740(0000) GS:ffff88bfefd80000(0000)
> knlGS:0000000000000000
> [627163.727871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [627163.727873] CR2: 000000005fb87b6e CR3: 00000022875e8006 CR4:
> 00000000007706e0
> [627163.727875] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [627163.727876] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [627163.727878] PKRU: 55555554
> [627163.727879] Call Trace:
> [627163.727882]  <IRQ>
> [627163.727886]  ? watchdog_timer_fn+0x22a/0x2a0
> [627163.727892]  ? softlockup_fn+0x70/0x70
> [627163.727895]  ? __hrtimer_run_queues+0x10f/0x2a0
> [627163.727903]  ? hrtimer_interrupt+0x106/0x240
> [627163.727906]  ? __sysvec_apic_timer_interrupt+0x68/0x170
> [627163.727913]  ? sysvec_apic_timer_interrupt+0x9d/0xd0
> [627163.727917]  </IRQ>
> [627163.727918]  <TASK>
> [627163.727920]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [627163.727927]  ? xas_descend+0x1b/0x70
> [627163.727930]  xas_load+0x2c/0x40
> [627163.727933]  xas_find+0x161/0x1a0
> [627163.727937]  find_get_entries+0x77/0x1d0
> [627163.727944]  truncate_inode_pages_range+0x244/0x3f0
> [627163.727950]  truncate_pagecache+0x44/0x60
> [627163.727955]  xfs_setattr_size+0x168/0x490 [xfs]
> [627163.728074]  xfs_vn_setattr+0x78/0x140 [xfs]
> [627163.728153]  notify_change+0x34f/0x4f0
> [627163.728158]  ? _raw_spin_lock+0x13/0x30
> [627163.728165]  ? do_truncate+0x80/0xd0
> [627163.728169]  do_truncate+0x80/0xd0
> [627163.728172]  do_open+0x2ce/0x400
> [627163.728177]  path_openat+0x10d/0x280
> [627163.728181]  do_filp_open+0xb2/0x150
> [627163.728186]  ? check_heap_object+0x34/0x190
> [627163.728189]  ? __check_object_size.part.0+0x5a/0x130
> [627163.728194]  do_sys_openat2+0x92/0xc0
> [627163.728197]  __x64_sys_openat+0x53/0x90
> [627163.728200]  do_syscall_64+0x35/0x80
> [627163.728206]  entry_SYSCALL_64_after_hwframe+0x4b/0xb5
> [627163.728210] RIP: 0033:0x7fc5e493e7fb
> [627163.728213] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18
> 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f
> 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
> [627163.728215] RSP: 002b:00007ffdd4e300e0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000101
> [627163.728218] RAX: ffffffffffffffda RBX: 00007ffdd4e30180 RCX:
> 00007fc5e493e7fb
> [627163.728220] RDX: 0000000000000241 RSI: 00007ffdd4e30180 RDI:
> 00000000ffffff9c
> [627163.728221] RBP: 00007ffdd4e30180 R08: 00007fc5e4600040 R09:
> 0000000000000001
> [627163.728223] R10: 00000000000001b6 R11: 0000000000000246 R12:
> 0000000000000241
> [627163.728224] R13: 0000000000000000 R14: 00007fc5e4662fa8 R15:
> 0000000000000000
> [627163.728227]  </TASK>
>
> I have around 50 hosts handling high I/O (each with 20Gbps+ uplinks
> and multiple NVMe drives), running RockyLinux 8/9. The stock RHEL
> kernel 8/9 is NOT affected, and the long-term kernel 5.15.X is NOT affect=
ed.
> However, with long-term kernels 6.1.XX and 6.6.XX,
> (tested at least 10 different versions), this lockup always appears
> after 2-30 days, similar to the report in the original thread.
> The more load (for example, copying a lot of local files while
> serving 20Gbps traffic), the higher the chance that the bug will appear.
>
> I haven't been able to reproduce this during synthetic tests,
> but it always occurs in production on 6.1.X and 6.6.X within 2-30 days.

We encountered a similar issue several months ago. Some of our
production servers crashed within days after deploying the 6.1.y
stable kernel. The soft lock info as follows,

[282879.612238] watchdog: BUG: soft lockup - CPU#65 stuck for 101s!
[container-execu:1572375]
[282879.612513] Modules linked in: ebtable_filter ebtables xt_DSCP
iptable_mangle iptable_raw xt_CT cls_bpf sch_ingress raw_diag
unix_diag tcp_diag udp_diag inet_diag iptable_filter bpfilter
xt_conntrack nf_nat nf_conntrack_netlink nfnetlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 bpf_preload binfmt_misc cuse fuse
overlay af_packet bonding intel_rapl_msr intel_rapl_common
64_edac kvm_amd kvm irqbypass crct10dif_pclmul crc32_pclmul
polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3
aesni_intel crypto_simd cryptd rapl pcspkr vfat fat xfs mlx5_ib(O)
ib_uverbs(O) input_leds ib_core(O) sg ccp ptdma i2c_piix4 k10temp
acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq ip_tables
ext4 mbcache crc32c_intel jbd2 mlx5_core(O) mlxfw(O) pci_hyperv_intf
psample mlxdevm(O) mlx_compat(O) tls nvme ptp pps_core nvme_core
sd_mod t10_pi ahci libahci libata
[282879.612571] CPU: 65 PID: 1572375 Comm: container-execu Kdump:
loaded Tainted: G        W  O L     6.1.38-rc3 #rc3.pdd
[282879.612574] Hardware name: New H3C Technologies Co., Ltd. H3C
UniServer R4950 G5/RS45M2C9S, BIOS 5.30 06/30/2021
[282879.612576] RIP: 0010:xas_descend+0x18/0x80
[282879.612583] Code: b6 e8 ec de 05 00 cc cc cc cc cc cc cc cc cc cc
cc cc 0f b6 0e 48 8b 57 08 48 d3 ea 83 e2 3f 89 d0 48 83 c0 04 48 8b
44 c6 08 <48> 89 77 18 48 89 c1 83 e1 03 48 83 f9 02 75 08 48 3d fd 00
00 00
[282879.612586] RSP: 0018:ffffad700b247c40 EFLAGS: 00000202
[282879.612588] RAX: ffff91d247a75d8a RBX: fffffffffffffffe RCX:
0000000000000006
[282879.612589] RDX: 0000000000000026 RSI: ffff91d473cb7b30 RDI:
ffffad700b247c68
[282879.612591] RBP: ffffad700b247c48 R08: 0000000000000003 R09:
fffffffffffffffe
[282879.612592] R10: 0000000000001990 R11: 0000000000000003 R12:
ffffad700b247cf8
[282879.612593] R13: ffffad700b247d70 R14: ffffad700b247cf8 R15:
ffffdfcd2c778000
[282879.612594] FS:  00007f5f576fb740(0000) GS:ffff922df0840000(0000)
knlGS:0000000000000000
[282879.612596] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[282879.612597] CR2: 00007fe797100600 CR3: 0000002b2468e000 CR4:
0000000000350ee0
[282879.612599] Call Trace:
[282879.612601]  <IRQ>
[282879.612605]  ? show_regs.cold+0x1a/0x1f
[282879.612610]  ? watchdog_timer_fn+0x1c4/0x220
[282879.612614]  ? softlockup_fn+0x30/0x30
[282879.612616]  ? __hrtimer_run_queues+0xa2/0x2b0
[282879.612620]  ? hrtimer_interrupt+0x109/0x220
[282879.612622]  ? __sysvec_apic_timer_interrupt+0x5e/0x110
[282879.612625]  ? sysvec_apic_timer_interrupt+0x7b/0x90
[282879.612629]  </IRQ>
[282879.612630]  <TASK>
[282879.612631]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[282879.612640]  ? xas_descend+0x18/0x80
[282879.612641]  ? xas_load+0x35/0x40
[282879.612643]  xas_find+0x197/0x1d0
[282879.612645]  find_get_entries+0x6e/0x170
[282879.612649]  truncate_inode_pages_range+0x294/0x4c0
[282879.612655]  ? __xfs_trans_commit+0x13c/0x3e0 [xfs]
[282879.612787]  ? kvfree+0x2c/0x40
[282879.612791]  ? trace_hardirqs_off+0x36/0xf0
[282879.612795]  truncate_inode_pages_final+0x44/0x50
[282879.612798]  evict+0x177/0x190
[282879.612802]  iput.part.0+0x183/0x1e0
[282879.612804]  iput+0x1c/0x30
[282879.612806]  do_unlinkat+0x1c7/0x2c0
[282879.612810]  __x64_sys_unlinkat+0x38/0x70
[282879.612812]  do_syscall_64+0x38/0x90
[282879.612815]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[282879.612818] RIP: 0033:0x7f5f56cf120d
[282879.612827] Code: 69 5c 2d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e
0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 63 d2 48 63 ff b8 07 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 02 f3 c3 48 8b 15 32 5c 2d 00 f7 d8 64
89 02
[282879.612828] RSP: 002b:00007fff30375c48 EFLAGS: 00000206 ORIG_RAX:
0000000000000107
[282879.612830] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
00007f5f56cf120d
[282879.612831] RDX: 0000000000000000 RSI: 0000000001640403 RDI:
0000000000000003
[282879.612832] RBP: 0000000001640403 R08: 0000000000000000 R09:
0000000001640403
[282879.612833] R10: 0000000000000100 R11: 0000000000000206 R12:
0000000000000003
[282879.612834] R13: 000000000163c5c0 R14: 00007fff30375c80 R15:
0000000000000000
[282879.612836]  </TASK>


Unfortunately, we couldn't reproduce the issue on our test servers. We
worked around it by disabling CONFIG_XARRAY_MULTI. Since then, these
production servers have been running smoothly for several months.

> If anyone can provide a patch, I can test it on multiple machines
> over the next few days.
>


--
Regards
Yafang

