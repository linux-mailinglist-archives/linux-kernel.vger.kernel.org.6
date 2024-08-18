Return-Path: <linux-kernel+bounces-291206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E090955EF3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8AF1F2111B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 20:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D1514F11E;
	Sun, 18 Aug 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VkAk/DzL"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDA433B1
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724013148; cv=none; b=B4Ycnx3iVq2jjhfDpoPM1/sQvEq9B3PcPKGMhtdFnQZnE0CXfrGu6l+sgyGsw/GQaONXhTVGPgavMRKSOlyImkPNq2BFf9mMK50FkpH/fAekq0ilX5ORV+3GuYSf4duGMF3yyCOcP/g6U3O8GpQ7spq3/aq3f+ee9SWrJ8LcPAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724013148; c=relaxed/simple;
	bh=CchLL1Hofn4s/CYb4Y4KLU48UONQBky/KS0WaTqnWZM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=X+id5uIlpB1n2iz1rra7wcC6Zo5etDfJJ2HtOkNEzgKOlJ244k5Hkk70mBgJTPsTRUffsEtwiNdR/bsJNAGhZkBTIo25i//gFt8CmUj6F21m/r7BXS/L9PXK/lJx0OEzKQtKcYmW7EcsIelNnB2DABYyfvS3+z6yvTIyYeHPxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VkAk/DzL; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-530e22878cfso3909251e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 13:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724013143; x=1724617943; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I/fjCkuNw8PXGgAFw4BmA1WjU6xdgHpWwlVtfwvuhIY=;
        b=VkAk/DzLomJvrc2C2tY/ZVqVS7Ml2NVopH+Hv68chsZZ0oy2V+yG14mUitoMb0vbP/
         wNl6HAZKnTkMphHcFtaL4fBBMlkevvr3LLMcJLoWGYd0nWVuboCwCVsF79B0gfn1fVPY
         /keSNRbnLFInol+KixEu4ECS5dSQ6BTuk1eFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724013143; x=1724617943;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/fjCkuNw8PXGgAFw4BmA1WjU6xdgHpWwlVtfwvuhIY=;
        b=chD8POqIyFptJe34b4AB8Ks7J64Xt/snTbHOd8HMqF2TgqG69t5fFJ30Rl6rQD0prj
         vKQUOg42Ibw7rW+8ls8a/S7ZkiLdGcZ+ebM2uhhDGkTpomw8v+n2GzocxCSMUOVhwL3C
         sY1bqvCes30KsERoKuZ0NoQAq/tnBBW3+xr0jAbwgWjhkovz+DIesKvk+IiyPgW1PeaK
         U1ykQK3U6BYLlc2UdTIxpo7gurx+2Vgcr3nloGAU0l6omFo4IdsizhpWUTmeXrvbaTRv
         3kLbUggP87U5N6ZaQZjs0S6YMEi1bf3K1D5e1KYy25TX7DIKMYcRTbWaySLfgpT+XC6o
         YH5w==
X-Gm-Message-State: AOJu0YxkgEK8m98QaZVP4zCx1mRNgbnGBG2S4f8tV7lrjt8YNxweAE6Q
	TNpc+kqP5xrXjVFWn+LlS5lMbROO+W26juKGVIutrnHE/6QTDZ3eb7RzozrVRbotDW9jBS9ZKtb
	GuksKOw==
X-Google-Smtp-Source: AGHT+IH69n/qcypZqW6+rNS9iEIZ5btONsYKCfMz6XYEYwV998xbynoNrycsKee9q7EgduP142TVAQ==
X-Received: by 2002:a05:6512:110c:b0:533:e83:c414 with SMTP id 2adb3069b0e04-5331c6edea5mr4841619e87.59.1724013141979;
        Sun, 18 Aug 2024 13:32:21 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c66d7sm555031766b.39.2024.08.18.13.32.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 13:32:21 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5beb6ea9ed6so3453914a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 13:32:21 -0700 (PDT)
X-Received: by 2002:a05:6402:3590:b0:5be:e832:7bbd with SMTP id
 4fb4d7f45d1cf-5bee8327e30mr2663969a12.14.1724013140468; Sun, 18 Aug 2024
 13:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Aug 2024 13:32:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP=qzODR60Xxzem5LQi6sH+6EFCDMOApAgBy37SQ59hA@mail.gmail.com>
Message-ID: <CAHk-=wgP=qzODR60Xxzem5LQi6sH+6EFCDMOApAgBy37SQ59hA@mail.gmail.com>
Subject: Linux 6.11-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The diffstat looks a bit odd this time around, with almost a third of
it being in the tools directory. But that's almost entirely just due
to a header file sync, which picked up the largish x86 feature flag
cleanup and some other header file noise.

If you ignore the tooling header updates, it's roughly one third
filesystems (bcachefs dominates, but there's btrfs and netfs fixes
too), one third drivers (gpu, networking, and misc), and one third
'the rest" (MM, arch updates, core networking, documentation, etc).

But it all looks fairly normal. rc4 is bigger than either rc2 or rc3
were, but not hugely so, and it's actually a normal pattern, where it
takes a while before people find some issues. So nothing feels all
that odd.  I have some travel coming up, so I hope things will start
to calm down a bit.

                Linus

---

Aapo Vienamo (1):
      thunderbolt: Fix memory leaks in {port|retimer}_sb_regs_write()

Abhinav Jain (1):
      selftest: af_unix: Fix kselftest compilation warnings

Al Viro (2):
      fix bitmap corruption on close_range() with CLOSE_RANGE_UNSHARE
      memcg_write_event_control(): fix a user-triggerable oops

Alex Bee (1):
      drm/rockchip: inno-hdmi: Fix infoframe upload

Alex Deucher (2):
      drm/amdgpu/jpeg2: properly set atomics vmid field
      drm/amdgpu/jpeg4: properly set atomics vmid field

Alexandre Ghiti (2):
      riscv: Re-introduce global icache flush in patch_text_XXX()
      riscv: Fix out-of-bounds when accessing Andes per hart vendor
extension array

Amit Shah (1):
      KVM: SEV: uapi: fix typo in SEV_RET_INVALID_CONFIG

Andi Shyti (1):
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resu=
me

AngeloGioacchino Del Regno (1):
      drm/mediatek: Set sensible cursor width/height values to fix crash

Arnaldo Carvalho de Melo (1):
      perf daemon: Fix the build on 32-bit architectures

Asmaa Mnebhi (1):
      gpio: mlxbf3: Support shutdown() function

Baochen Qiang (1):
      wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850

Baojun Xu (1):
      ALSA: hda/tas2781: fix wrong calibrated data order

Barak Biber (1):
      iommu: Restore lost return in iommu_report_device_fault()

Bart Van Assche (2):
      ARM: riscpc: ecard: Fix the build
      mips: sgi-ip22: Fix the build

Bas Nieuwenhuizen (1):
      drm/amdgpu: Actually check flags for all context ops.

Benjamin Berg (1):
      wifi: iwlwifi: correctly lookup DMA address in SG table

Bert Karwatzki (1):
      wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_chang=
e

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192du: Initialise value32 in
_rtl92du_init_queue_reserved_page

Bouke Sybren Haarsma (2):
      drm: panel-orientation-quirks: Add quirk for Ayn Loki Zero
      drm: panel-orientation-quirks: Add quirk for Ayn Loki Max

Breno Leitao (1):
      i2c: tegra: Do not mark ACPI devices as irq safe

Caleb Sander Mateos (1):
      io_uring: fix user_data field name in comment

Celeste Liu (1):
      riscv: entry: always initialize regs->a0 to -ENOSYS

Christian Brauner (2):
      nsfs: fix ioctl declaration
      pidfd: prevent creation of pidfds for kthreads

Christophe Leroy (2):
      powerpc/mm: Fix size of allocated PGDIR
      powerpc/mm: Fix boot warning with hugepages and CONFIG_DEBUG_VIRTUAL

Claudio Imbrenda (1):
      s390/uv: Panic for set and remove shared access UVC errors

Cong Wang (1):
      vsock: fix recursive ->recvmsg calls

Cosmin Ratiu (1):
      net/mlx5e: Correctly report errors for ethtool rx flows

Dan Carpenter (5):
      rtla/osnoise: Prevent NULL dereference in error handling
      atm: idt77252: prevent use after free in dequeue_rx()
      KVM: SVM: Fix uninitialized variable bug
      KVM: SVM: Fix an error code in sev_gmem_post_populate()
      selftests/mm: compaction_test: fix off by one in check_compaction()

Daniel Yang (1):
      Documentation: dm-crypt.rst warning + error fix

Danielle Ratson (1):
      net: ethtool: Allow write mechanism of LPL and both LPL and EPL

Danilo Krummrich (1):
      KVM: arm64: free kvm->arch.nested_mmus with kvfree()

Darrick J. Wong (3):
      xfs: attr forks require attr, not attr2
      xfs: revert AIL TASK_KILLABLE threshold
      xfs: conditionally allow FS_XFLAG_REALTIME changes if S_DAX is set

David (Ming Qiang) Wu (1):
      drm/amd/amdgpu: command submission parser for JPEG

David Gstir (2):
      KEYS: trusted: fix DCP blob payload length assignment
      KEYS: trusted: dcp: fix leak of blob encryption key

David Hildenbrand (1):
      mm/hugetlb: fix hugetlb vs. core-mm PT locking

David Howells (2):
      netfs, ceph: Revert "netfs: Remove deprecated use of
PG_private_2 as a second writeback flag"
      netfs: Fix handling of USE_PGPRIV2 and WRITE_TO_CACHE flags

David Thompson (1):
      mlxbf_gige: disable RX filters until RX path initialized

Dominique Martinet (1):
      9p: Fix DIO read through netfs

Donald Hunter (2):
      netfilter: nfnetlink: Initialise extack before use in ACKs
      netfilter: flowtable: initialise extack before use

Douglas Anderson (1):
      dt-bindings: display: panel: samsung,atna45dc02: Fix indentation

Dr. David Alan Gilbert (1):
      soc: fsl: qbman: remove unused struct 'cgr_comp'

Dragos Tatulea (2):
      net/mlx5e: SHAMPO, Increase timeout to improve latency
      net/mlx5e: Take state lock during tx timeout reporter

Drew Fustini (1):
      clk: thead: fix dependency on clk_ignore_unused

Eli Billauer (3):
      char: xillybus: Don't destroy workqueue from work item running on it
      char: xillybus: Refine workqueue handling
      char: xillybus: Check USB endpoints when probing device

Eric Dumazet (1):
      gtp: pull network headers in gtp_dev_xmit()

Eric Farman (1):
      s390/dasd: Remove DMA alignment

Eugene Syromiatnikov (1):
      mptcp: correct MPTCP_SUBFLOW_ATTR_SSN_OFFSET reserved size

Evan Green (2):
      RISC-V: hwprobe: Add MISALIGNED_PERF key
      RISC-V: hwprobe: Add SCALAR to misaligned perf defines

Faizal Rahim (4):
      igc: Fix packet still tx after gate close by reducing i226 MAC
retry buffer
      igc: Fix qbv_config_change_errors logics
      igc: Fix reset adapter logics when tx mode change
      igc: Fix qbv tx latency by setting gtxoffset

Fangzhi Zuo (1):
      drm/amd/display: Fix MST BW calculation Regression

Filipe Manana (2):
      btrfs: only run the extent map shrinker from kswapd tasks
      btrfs: send: allow cloning non-aligned extent if it ends at i_size

Florian Westphal (2):
      netfilter: nf_queue: drop packets with cloned unconfirmed conntracks
      selftests: netfilter: add test for br_netfilter+conntrack+queue
combination

Foster Snowhill (4):
      usbnet: ipheth: remove extraneous rx URB length check
      usbnet: ipheth: drop RX URBs with no payload
      usbnet: ipheth: do not stop RX on failing RX callback
      usbnet: ipheth: fix carrier detection in modes 1 and 4

Francesco Dolcini (1):
      dt-bindings: eeprom: at25: add fujitsu,mb85rs256 compatible

Frank Li (1):
      dt-bindings: net: fsl,qoriq-mc-dpmac: add missed property phys

Fuad Tabba (1):
      KVM: arm64: Tidying up PAuth code in KVM

Gal Pressman (1):
      net/mlx5e: Fix queue stats access to non-existing channels splat

Gao Xiang (1):
      mm/migrate: fix deadlock in migrate_pages_batch() on large folios

Gergo Koteles (3):
      platform/x86: ideapad-laptop: introduce a generic notification chain
      platform/x86: ideapad-laptop: move ymc_trigger_ec from lenovo-ymc
      platform/x86: ideapad-laptop: add a mutex to synchronize VPC commands

Griffin Kroah-Hartman (2):
      Revert "serial: 8250_omap: Set the console genpd always on if no
console suspend"
      Revert "misc: fastrpc: Restrict untrusted app to attach to privileged=
 PD"

Gustavo A. R. Silva (1):
      smb: smb2pdu.h: Use static_assert() to check struct sizes

Haibo Xu (2):
      arm64: ACPI: NUMA: initialize all values of acpi_early_node_map
to NUMA_NO_NODE
      RISC-V: ACPI: NUMA: initialize all values of acpi_early_node_map
to NUMA_NO_NODE

Hailong Liu (1):
      mm/vmalloc: fix page mapping if vm_area_alloc_pages() with high
order fallback to order 0

Haiyang Zhang (1):
      net: mana: Fix RX buf alloc_size alignment and atomic op panic

Hamza Mahfooz (1):
      drm/amd/display: fix s2idle entry for DCN3.5+

Hans de Goede (2):
      usb: misc: ljca: Add Lunar Lake ljca GPIO HID to ljca_gpio_hids[]
      media: atomisp: Fix streaming no longer working on BYT / ISP2400 devi=
ces

Heikki Krogerus (1):
      usb: typec: ucsi: Fix the return value of ucsi_run_command()

Isaku Yamahata (1):
      KVM: x86: Use this_cpu_ptr() instead of per_cpu_ptr(smp_processor_id(=
))

Ivan Orlov (1):
      kunit/overflow: Fix UB in overflow_allocation_test

Jack Xiao (9):
      drm/amdgpu/mes: fix mes ring buffer overflow
      drm/amdgpu/mes12: update mes_v12_api_def.h
      drm/amdgpu/mes: add multiple mes ring instances support
      drm/amdgpu/mes12: load unified mes fw on pipe0 and pipe1
      drm/amdgpu/mes12: add mes pipe switch support
      drm/amdgpu/mes12: adjust mes12 sw/hw init for multiple pipes
      drm/amdgpu/mes12: configure two pipes hardware resources
      drm/amdgpu/mes12: sw/hw fini for unified mes
      drm/amdgpu/mes12: fix suspend issue

Jakub Sitnicki (3):
      net: Make USO depend on CSUM offload
      udp: Fall back to software USO if IPv6 extension headers are present
      selftests/net: Add coverage for UDP GSO with IPv6 extension headers

Jann Horn (1):
      fuse: Initialize beyond-EOF page contents before setting uptodate

Janne Grunau (1):
      wifi: brcmfmac: cfg80211: Handle SSID based pmksa deletion

Jeff Layton (1):
      btrfs: update target inode's ctime on unlink

Jens Axboe (1):
      io_uring/sqpoll: annotate debug task =3D=3D current with data_race()

Jie Wang (2):
      net: hns3: fix wrong use of semaphore up
      net: hns3: fix a deadlock problem when config TC during resetting

Jinjie Ruan (1):
      crash: fix riscv64 crash memory reserve dead loop

Josef Bacik (1):
      btrfs: check delayed refs when we're checking if a ref exists

Juan Jos=C3=A9 Arboleda (1):
      ALSA: usb-audio: Support Yamaha P-125 quirk entry

Kees Cook (2):
      binfmt_flat: Fix corruption when not offsetting data start
      exec: Fix ToCToU between perm check and set-uid/gid usage

Kenneth Feng (1):
      drm/amd/amdgpu: add HDP_SD support on gc 12.0.0/1

Kent Overstreet (19):
      bcachefs: delete faulty fastpath in bch2_btree_path_traverse_cached()
      bcachefs: Fix bch2_trigger_alloc when upgrading from old versions
      bcachefs: bch2_accounting_invalid() fixup
      bcachefs: disk accounting: ignore unknown types
      bcachefs: Add missing downgrade table entry
      bcachefs: Convert for_each_btree_node() to lockrestart_do()
      lib/generic-radix-tree.c: Fix rare race in __genradix_ptr_alloc()
      bcachefs: Add hysteresis to waiting on btree key cache flush
      bcachefs: Improve trans_blocked_journal_reclaim tracepoint
      bcachefs: Add a time_stat for blocked on key cache flush
      bcachefs: Fix warning in __bch2_fsck_err() for trans not passed in
      bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()
      bcachefs: Kill __bch2_accounting_mem_mod()
      bcachefs: bcachefs_metadata_version_disk_accounting_inum
      bcachefs: Increase size of cuckoo hash table on too many rehashes
      bcachefs: Fix forgetting to pass trans to fsck_err()
      bcachefs: avoid overflowing LRU_TIME_BITS for cached data lru
      bcachefs: fix incorrect i_state usage
      bcachefs: Fix locking in __bch2_trans_mark_dev_sb()

Khazhismel Kumykov (1):
      dm resume: don't return EINVAL when signalled

Kirill A. Shutemov (1):
      mm: fix endless reclaim on machines with unaccepted memory

Konrad Dybcio (1):
      dt-bindings: Batch-update Konrad Dybcio's email

Kuniyuki Iwashima (1):
      net: macb: Use rcu_dereference() for idev->ifa_list in macb_suspend()=
.

Kyle Huey (1):
      perf/bpf: Don't call bpf_overflow_handler() for tracing events

Leon Hwang (1):
      bpf: Fix updating attached freplace prog in prog_array map

Li Lingfeng (1):
      block: Fix lockdep warning in blk_mq_mark_tag_wait

Li RongQing (1):
      KVM: eventfd: Use synchronize_srcu_expedited() on shutdown

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C-XE710 HEADSET

Linus Torvalds (1):
      Linux 6.11-rc4

Loan Chen (1):
      drm/amd/display: Enable otg synchronization logic for DCN321

Long Li (1):
      net: mana: Fix doorbell out of order violation and avoid
unnecessary doorbell rings

Lukas Bulwahn (1):
      netfs: clean up after renaming FSCACHE_DEBUG config

Marc Zyngier (4):
      KVM: arm64: Enforce dependency on an ARMv8.4-aware toolchain
      KVM: arm64: vgic: Hold config_lock while tearing down a CPU interface
      usb: xhci: Check for xhci->interrupters being allocated in
xhci_mem_clearup()
      net: thunder_bgx: Fix netdev structure allocation

Mark Brown (1):
      KVM: selftests: arm64: Correct feature test for S1PIE in get-reg-list

Mark Rutland (1):
      arm64: uaccess: correct thinko in __get_mem_asm()

Masahiro Yamada (3):
      rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEX=
T
      rust: fix the default format for CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
      tty: vt: conmakehash: remove non-portable code printing comment heade=
r

Mathias Krause (1):
      file: fix typo in take_fd() comment

Mathias Nyman (1):
      xhci: Fix Panther point NULL pointer deref at full-speed re-enumerati=
on

Mathieu Othacehe (1):
      tty: atmel_serial: use the correct RTS flag.

Matthew Brost (5):
      drm/xe: Validate user fence during creation
      drm/xe: Build PM into GuC CT layer
      drm/xe: Add xe_gt_tlb_invalidation_fence_init helper
      drm/xe: Drop xe_gt_tlb_invalidation_wait
      drm/xe: Hold a PM ref when GT TLB invalidations are inflight

Matthew Wilcox (Oracle) (1):
      netfs: Fault in smaller chunks for non-large folio mappings

Matthieu Baerts (NGI0) (1):
      selftests: net: lib: kill PIDs before del netns

Max Kellermann (1):
      fs/netfs/fscache_cookie: add missing "n_accesses" check

Ma=C3=ADra Canal (1):
      drm/v3d: Fix out-of-bounds read in `v3d_csd_job_run()`

Melissa Wen (1):
      drm/amd/display: fix cursor offset on rotation 180

Michael Mueller (1):
      KVM: s390: fix validity interception issue when gisa is switched off

Michal Luczaj (1):
      KVM: selftests: Add a testcase to verify x2APIC is fully readonly

Michal Wajdeczko (2):
      drm/xe/vf: Fix register value lookup
      drm/xe/pf: Fix VF config validation on multi-GT platforms

Miguel Ojeda (4):
      rust: macros: indent list item in `module!`'s docs
      rust: add intrinsics to fix `-Os` builds
      kbuild: rust-analyzer: mark `rust_is_available.sh` invocation as recu=
rsive
      rust: x86: remove `-3dnow{,a}` from target features

Mika Westerberg (1):
      thunderbolt: Mark XDomain as unplugged when router is removed

Mikulas Patocka (2):
      dm suspend: return -ERESTARTSYS instead of -EINTR
      dm persistent data: fix memory allocation failure

Moon Yeounsu (1):
      net: ethernet: use ip_hdrlen() instead of bit shift

Muhammad Usama Anjum (1):
      selftests: memfd_secret: don't build memfd_secret test on
unsupported arches

Nam Cao (1):
      riscv: change XIP's kernel_map.size to be size of the entire kernel

Namhyung Kim (10):
      perf tools: Add tools/include/uapi/README
      tools/include: Sync uapi/drm/i915_drm.h with the kernel sources
      tools/include: Sync uapi/linux/kvm.h with the kernel sources
      tools/include: Sync uapi/linux/perf.h with the kernel sources
      tools/include: Sync uapi/sound/asound.h with the kernel sources
      tools/include: Sync uapi/asm-generic/unistd.h with the kernel sources
      tools/include: Sync network socket headers with the kernel sources
      tools/include: Sync filesystem headers with the kernel sources
      tools/include: Sync x86 headers with the kernel sources
      tools/include: Sync arm64 headers with the kernel sources

Namjae Jeon (2):
      ksmbd: override fsids for share path check
      ksmbd: override fsids for smb2_query_info()

Naohiro Aota (2):
      btrfs: fix invalid mapping of extent xarray state
      btrfs: zoned: properly take lock to read/update block group's
zoned variables

Niklas Cassel (1):
      Revert "ata: libata-scsi: Honor the D_SENSE bit for CK_COND=3D1
and no error"

Niklas Neronin (1):
      usb: xhci: fix duplicate stall handling in handle_tx_event()

Nysal Jan K.A (2):
      cpu/SMT: Enable SMT only if a core is online
      powerpc/topology: Check if a core is online

Oleksij Rempel (1):
      pse-core: Conditionally set current limit during PI regulator registr=
ation

Oliver Neukum (1):
      usbnet: ipheth: race between ipheth_close and error handling

Olivier Langlois (2):
      io_uring/napi: check napi_enabled in io_napi_add() before proceeding
      io_uring/napi: remove duplicate io_napi_entry timeout assignation

Omar Sandoval (1):
      filelock: fix name of file_lease slab cache

Parsa Poorshikhian (1):
      ALSA: hda/realtek: Fix noise from speakers on Lenovo IdeaPad 3 15IAU7

Pasha Tatashin (3):
      mm: don't account memmap on failure
      mm: add system wide stats items category
      mm: don't account memmap per-node

Paul Moore (1):
      selinux: revert our use of vma_is_initial_heap()

Pawel Dembicki (5):
      net: dsa: vsc73xx: fix port MAC configuration in full duplex mode
      net: dsa: vsc73xx: pass value in phy_write operation
      net: dsa: vsc73xx: check busy flag in MDIO operations
      net: dsa: vsc73xx: allow phy resetting
      net: phy: vitesse: repair vsc73xx autonegotiation

Pedro Falcato (1):
      mseal: fix is_madv_discard()

Peiyang Wang (3):
      net: hns3: use the user's cfg after reset
      net: hns3: void array out of bound when loop tnl_num
      net: hns3: use correct release function during uninitialization

Peng Fan (1):
      tty: serial: fsl_lpuart: mark last busy before uart_add_one_port

Petr Pavlu (1):
      refcount: Report UAF for refcount_sub_and_test(0) when counter=3D=3D0

Phil Sutter (3):
      netfilter: nf_tables: Audit log dump reset after the fact
      netfilter: nf_tables: Introduce nf_tables_getobj_single
      netfilter: nf_tables: Add locking for NFT_MSG_GETOBJ_RESET requests

Phillip Lougher (1):
      Squashfs: sanity check symbolic link size

Qu Wenruo (3):
      btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type
      btrfs: tree-checker: add dev extent item checks
      btrfs: only enable extent map shrinker for DEBUG builds

Radhey Shyam Pandey (1):
      net: axienet: Fix register defines comment description

Rafael J. Wysocki (7):
      Revert "ACPI: EC: Evaluate orphan _REG under EC device"
      ACPICA: Add a depth argument to acpi_execute_reg_methods()
      ACPI: EC: Evaluate _REG outside the EC scope more carefully
      thermal: gov_bang_bang: Call __thermal_cdev_update() directly
      thermal: gov_bang_bang: Split bang_bang_control()
      thermal: gov_bang_bang: Add .manage() callback
      thermal: gov_bang_bang: Use governor_data to reduce overhead

Richard Fitzgerald (4):
      spi: Add empty versions of ACPI functions
      ALSA: hda: cs35l56: Remove redundant call to hda_cs_dsp_control_remov=
e()
      ALSA: hda: cs35l41: Remove redundant call to hda_cs_dsp_control_remov=
e()
      i2c: Use IS_REACHABLE() for substituting empty ACPI functions

Rodrigo Siqueira (1):
      drm/amd/display: Adjust cursor position

Samuel Holland (1):
      arm64: Fix KASAN random tag seed initialization

Sarthak Singh (1):
      rust: Support latest version of `rust-analyzer`

Sean Christopherson (2):
      KVM: x86: Make x2APIC ID 100% readonly
      KVM: x86: Disallow read-only memslots for SEV-ES and SEV-SNP (and TDX=
)

Sean Young (1):
      media: Revert "media: dvb-usb: Fix unexpected infinite loop in
dvb_usb_read_remote_control()"

Sebastian Ott (3):
      KVM: arm64: fix override-init warnings in W=3D1 builds
      KVM: arm64: fix kdoc warnings in W=3D1 builds
      KVM: arm64: vgic: fix unexpected unlock sparse warnings

Shin'ichiro Kawasaki (2):
      scsi: mpi3mr: Add missing spin_lock_init() for mrioc->trigger_lock
      scsi: mpi3mr: Avoid MAX_PAGE_ORDER WARNING for buffer allocations

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Fix to Update HPD Data When ALS is Disabled

Simon Trimmer (1):
      ALSA: hda/realtek: Add support for new HP G12 laptops

Song Liu (2):
      kallsyms: Do not cleanup .llvm.<hash> suffix before sorting symbols
      kallsyms: Match symbols exactly with CONFIG_LTO_CLANG

Stefan Haberland (1):
      s390/dasd: fix error recovery leading to data corruption on ESE devic=
es

Stefan Wiehler (1):
      of/irq: Prevent device address out-of-bounds read in interrupt map wa=
lk

Steve French (1):
      smb3: fix lock breakage for cached writes

Steven Rostedt (1):
      tracing: Return from tracing_buffers_read() if the file has been clos=
ed

Su Hui (1):
      smb/client: avoid possible NULL dereference in cifs_free_subrequest()

Subash Abhinov Kasiviswanathan (1):
      tcp: Update window clamping condition

Suren Baghdasaryan (2):
      alloc_tag: introduce clear_page_tag_ref() helper function
      alloc_tag: mark pages reserved during CMA activation as not tagged

Takahiro Itazuri (1):
      docs: KVM: Fix register ID of SPSR_FIQ

Takashi Iwai (2):
      ALSA: timer: Relax start tick time check for slave timer elements
      ALSA: hda/tas2781: Use correct endian conversion

Tariq Toukan (1):
      net/mlx5: SD, Do not query MPIR register if no sd_group

Thorsten Blum (2):
      gcc-plugins: randstruct: Remove GCC 4.7 or newer requirement
      btrfs: send: annotate struct name_cache_entry with __counted_by()

Tom Hughes (1):
      netfilter: allow ipv6 fragments to arrive on different devices

Umesh Nerlige Ramappa (4):
      drm/xe: Move part of xe_file cleanup to a helper
      drm/xe: Add ref counting for xe_file
      drm/xe: Take a ref to xe file when user creates a VM
      drm/xe: Fix use after free when client stats are captured

Waiman Long (1):
      mm/memory-failure: use raw_spinlock_t in struct memory_failure_cpu

Xu Yang (1):
      Revert "usb: typec: tcpm: clear pd_event queue in PORT_RESET"

Yinjie Yao (1):
      drm/amdgpu: Update kmd_fw_shared for VCN5

Yonghong Song (2):
      bpf: Fix a kernel verifier crash in stacksafe()
      selftests/bpf: Add a test to verify previous stacksafe() fix

Yu Kuai (1):
      md/raid1: Fix data corruption for degraded array with slow disk

Yue Haibing (2):
      iommu: Remove unused declaration iommu_sva_unbind_gpasid()
      KVM: x86: hyper-v: Remove unused inline function kvm_hv_free_pa_page(=
)

Zehui Xu (1):
      kbuild: rust: skip -fmin-function-alignment in bindgen flags

Zenghui Yu (1):
      KVM: arm64: vgic-debug: Exit the iterator properly w/o LPI

Zhen Lei (2):
      selinux: fix potential counting error in avc_add_xperms_decision()
      selinux: add the processing of the failure of avc_add_xperms_decision=
()

Zheng Zhang (1):
      net: ethernet: mtk_wed: fix use-after-free panic in
mtk_wed_setup_tc_block_cb()

Zhihao Cheng (2):
      nvdimm/pmem: Set dax flag for all 'PFN_MAP' cases
      vfs: Don't evict inode under the inode lru traversing context

Zi Yan (2):
      mm/numa: no task_numa_fault() call if PTE is changed
      mm/numa: no task_numa_fault() call if PMD is changed

yangerkun (1):
      libfs: fix infinite directory reads for offset dir

