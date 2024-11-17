Return-Path: <linux-kernel+bounces-412270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0B9D06AA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 23:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0D0B21B72
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF921DDC02;
	Sun, 17 Nov 2024 22:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IZ20/aU+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264751DA2F1
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 22:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731882421; cv=none; b=KEMCM755VYG2DMp20TTckiqgfzSi1tyUvsrvKaZjP3qkjRnLOTLtb5Y7kLX9vKR1E5KGoPkQgTfgkGwTSs3uFkpgyVzmOHyuZLIVtXxsGlAqrVf3vYCCDlg8BlG1ESaiiRmerpjI+qtmxM1XE4EqkZxgDunDBuo/hF3FCYk4Y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731882421; c=relaxed/simple;
	bh=dphqcuz7FHV734yEoiaa4UksCifCCACZ2Gf1v1zmRGk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dqNvgmhG7FXAR0ksxyr5hEuga0ZM1F0OuQK1j6qeCoCudlf5O+lAjuNHCHKu9nFk6DDe0qRvGBMhimbPHe8lIqk1ha77yLQWbqobhlYD3U0VbxnYyC69OYv2/1rzXsg483Bfs9SwunUx/JAwwrBo3AbuA0YB4E9klbuEzJDnBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IZ20/aU+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a9acafdb745so682845666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731882416; x=1732487216; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GK8HPamOcP3b60qlpXqP44n9iCwo4U7L7X9/WmcU+o=;
        b=IZ20/aU+SjQPcH9rHJmTRWM46omufk5jJYxfevznwcDpSeMLbpX210cj4/QgUzdq3p
         +bauP5WEHbAUT/G/HwAR1C8ZSUx2uSIXm2asPwf2Kpr+qoH5SwaKe6R0KQNTXJLPML1x
         4tshYpvWQ/GRMOYsd89om5ygcsAAXQQ4ah3pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731882416; x=1732487216;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GK8HPamOcP3b60qlpXqP44n9iCwo4U7L7X9/WmcU+o=;
        b=KwWWCfnuJgD1zJ+LCjXekriZN8jR4EMXL5kcrhmt1xoSTMh56oin2nSVvE7oe9k2dU
         Uqb4cOQJjomTADx+Xvng64Mve0HKTqWTerihl0dZ9ADTaQH5tSX0ijBxcE9e6BDQgoGz
         anvl5mRPXZawIoG/PpBVhzsTPnqgwtV7s5xE7QpCWKDCU/fXnXP16J92BPEiztnPWOq2
         Unv38G7+2wplbl5e0pGWZ6BEcS7YFNpF816cothSUyl2F+4aPcxvaz/WI2208BsD70VR
         RWBv1wgzI4GsbOpWlRjS7NYUaLvcB2m2dBAvc/4LAaCo7Uf3kDECPX2CV/9sBCprgTB2
         ruww==
X-Gm-Message-State: AOJu0YxfK6xxz+ow13LrVPqoT64PC8cOKFalUBf3zCQ+ttCH842G1Gjr
	nhEItAal78gHa2lWxJ1YPj9IBFJBhiEGMu2hDpVHgIHm3hwUVuqsTB1oT/wdnxSOC7bG1qAhGpx
	cOPPZkw==
X-Google-Smtp-Source: AGHT+IGBiJ+6A6BVVklc0+6w5wsz2fNQ05jNi0fqExcIWCZBbWJBfLYL/K1e1sq1k5vICFMJ7G7V9A==
X-Received: by 2002:a17:907:1c9d:b0:a9e:670f:9485 with SMTP id a640c23a62f3a-aa481a5cecfmr831794466b.30.1731882416083;
        Sun, 17 Nov 2024 14:26:56 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df56b31sm460257666b.72.2024.11.17.14.26.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 14:26:55 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e8522c10bso567160666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 14:26:55 -0800 (PST)
X-Received: by 2002:a17:906:ef09:b0:a99:6265:ed35 with SMTP id
 a640c23a62f3a-aa4818a4a70mr1040768866b.10.1731882414785; Sun, 17 Nov 2024
 14:26:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 14:26:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
Message-ID: <CAHk-=wgtGkHshfvaAe_O2ntnFBH3EprNk1juieLmjcF2HBwBgQ@mail.gmail.com>
Subject: Linux 6.12
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No strange surprises this last week, so we're sticking to the regular
release schedule, and that obviously means that the merge window opens
tomorrow. I already have two dozen+ pull requests in my mailbox, kudos
to all the early birds.

But before the merge window opens, please give this a quick test to
make sure we didn't mess anything up. The shortlog below gives you the
summary for the last week, and nothing really jumps out at me. A
number of last-minute reverts, and some random fairly small fixes
fairly spread out in the tree.

             Linus

---

Akash Goel (1):
      drm/panthor: Fix handling of partial GPU mapping of BOs

Alex Deucher (2):
      Revert "drm/amd/display: parse umc_info or vram_info based on ASIC"
      Revert "drm/amd/pm: correct the workload setting"

Alexandre Ferrieux (2):
      net: sched: cls_u32: Fix u32's systematic failure to free IDR
entries for hnodes.
      net: sched: u32: Add test case for systematic hnode IDR leaks

Alexandre Ghiti (1):
      drivers: perf: Fix wrong put_cpu() placement

Andre Przywara (1):
      mmc: sunxi-mmc: Fix A100 compatible description

Andrew Morton (1):
      mm: revert "mm: shmem: fix data-race in shmem_getattr()"

Andy Yan (1):
      drm/rockchip: vop: Fix a dereferenced before check warning

Ard Biesheuvel (1):
      x86/stackprotector: Work around strict Clang TLS symbol requirements

Ashutosh Dixit (1):
      drm/xe/oa: Fix "Missing outer runtime PM protection" warning

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

Baoquan He (1):
      x86/mm: Fix a kdump kernel failure on SME system when CONFIG_IMA_KEXE=
C=3Dy

Barry Song (1):
      mm: count zeromap read and set for swapout and swapin

Bibo Mao (1):
      LoongArch: Fix AP booting issue in VM mode

Breno Leitao (1):
      ipmr: Fix access to mfc_cache_list without lock held

Carolina Jubran (1):
      net/mlx5e: Disable loopback self-test on multi-PF netdev

Chen Ridong (1):
      drm/vmwgfx: avoid null_ptr_deref in vmw_framebuffer_surface_create_ha=
ndle

Chiara Meiohas (1):
      net/mlx5: E-switch, unload IB representors when unloading ETH represe=
ntors

Christian K=C3=B6nig (2):
      drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()
      drm/amdgpu: enable GTT fallback handling for dGPUs only

Christophe JAILLET (2):
      RDMA/bnxt_re: Fix some error handling paths in bnxt_re_probe()
      RDMA/bnxt_re: Remove some dead code

Cristian Marussi (1):
      firmware: arm_scmi: Skip opp duplicates

Dan Carpenter (1):
      fs/proc/task_mmu: prevent integer overflow in pagemap_scan_get_args()

Daniel Burgener (1):
      landlock: Fix grammar issues in documentation

Daniele Ceraolo Spurio (1):
      drm/i915/gsc: ARL-H and ARL-U need a newer GSC FW.

Dave Airlie (3):
      nouveau: fw: sync dma after setup is called.
      nouveau: handle EBUSY and EAGAIN for GSP aux errors.
      nouveau/dp: handle retries for AUX CH transfers with GSP.

Dave Vasilevsky (1):
      crash, powerpc: default to CRASH_DUMP=3Dn on PPC_BOOK3S_32

David Rosca (1):
      drm/amdgpu: Fix video caps for H264 and HEVC encode maximum size

Deep Harsora (1):
      ASoC: intel: sof_sdw: add quirk for Dell SKU

Dillon Varone (1):
      drm/amd/display: Require minimum VBlank size for stutter optimization

Dionna Glaze (1):
      kvm: svm: Fix gctx page leak on invalid inputs

Dmitry Antipov (2):
      ocfs2: fix UBSAN warning in ocfs2_verify_volume()
      ocfs2: uncache inode which has failed entering the group

Donet Tom (1):
      selftests: hugetlb_dio: fixup check for initial conditions to
skip in the start

Dragos Tatulea (2):
      vdpa/mlx5: Fix error path during device add
      net/mlx5e: kTLS, Fix incorrect page refcounting

Eric Biggers (1):
      crypto: mips/crc32 - fix the CRC32C implementation

Eric Dumazet (1):
      sctp: fix possible UAF in sctp_v6_available()

Eryk Zagorski (1):
      ALSA: usb-audio: Fix Yamaha P-125 Quirk Entry

Feng Liu (1):
      virtio_pci: Fix admin vq cleanup by using correct info pointer

Francesco Dolcini (1):
      drm/bridge: tc358768: Fix DSI command tx

Geert Uytterhoeven (1):
      MAINTAINERS: Re-add cancelled Renesas driver sections

Geliang Tang (2):
      mptcp: update local address flags when setting it
      mptcp: hold pm lock when deleting entry

Gustavo A. R. Silva (1):
      integrity: Use static_assert() to check struct sizes

Hajime Tazaki (1):
      nommu: pass NULL argument to vma_iter_prealloc()

Hamish Claxton (1):
      drm/amd/display: Fix failure to read vram info due to static BP_RESUL=
T

Hangbin Liu (2):
      bonding: add ns target multicast address to slave device
      selftests: bonding: add ns multicast group testing

Harith G (2):
      ARM: 9419/1: mm: Fix kernel memory mapping for xip kernels
      ARM: 9420/1: smp: Fix SMP for xip kernels

Hou Tao (1):
      selftests/bpf: Use -4095 as the bad address for bits iterator

Huacai Chen (4):
      LoongArch: For all possible CPUs setup logical-physical CPU mapping
      LoongArch: Fix early_numa_add_cpu() usage for FDT systems
      LoongArch: Make KASAN work with 5-level page-tables
      LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits

Hugh Dickins (1):
      mm/thp: fix deferred split queue not partially_mapped: fix

Hyunwoo Kim (1):
      vsock/virtio: Initialization of the dangling pointer occurring
in vsk->trans

Jack Xiao (1):
      drm/amdgpu/mes12: correct kiq unmap latency

Jakub Kicinski (3):
      netlink: terminate outstanding dump on socket close
      selftests: net: add a test for closing a netlink socket ith dump
in progress
      selftests: net: add netlink-dumps to .gitignore

Jann Horn (1):
      mm/mremap: fix address wraparound in move_page_tables()

Jarkko Sakkinen (2):
      tpm: Opt-in in disable PCR integrity protection
      tpm: Disable TPM on tpm2_create_primary() failure

Jiawei Ye (1):
      bpf: Fix mismatched RCU unlock flavour in bpf_out_neigh_v6

Jinjiang Tu (1):
      mm: fix NULL pointer dereference in alloc_pages_bulk_noprof

Johannes Weiner (1):
      mm: swapfile: fix cluster reclaim work crash on rotational devices

John Hubbard (1):
      mm/gup: avoid an unnecessary allocation call for FOLL_LONGTERM cases

John Sperbeck (1):
      KVM: selftests: use X86_MEMTYPE_WB instead of VMX_BASIC_MEM_TYPE_WB

John Watts (1):
      ASoC: audio-graph-card2: Purge absent supplies for device tree nodes

Josef Bacik (1):
      btrfs: fix incorrect comparison for delayed refs

Kailang Yang (2):
      ALSA: hda/realtek - Fixed Clevo platform headset Mic issue
      ALSA: hda/realtek - update set GPIO3 to default for Thinkpad with ALC=
1318

Kairui Song (1):
      mm, swap: fix allocation and scanning race with swapoff

Kanglong Wang (1):
      LoongArch: Add WriteCombine shadow mapping in KASAN

Kent Overstreet (9):
      bcachefs: bch2_btree_write_buffer_flush_going_ro()
      bcachefs: Fix bch_member.btree_bitmap_shift validation
      bcachefs: Fix missing validation for bch_backpointer.level
      bcachefs: Fix validate_bset() repair path
      bcachefs: Fix hidden btree errors when reading roots
      bcachefs: Fix assertion pop in topology repair
      bcachefs: Allow for unknown key types in backpointers fsck
      bcachefs: Fix journal_entry_dev_usage_to_text() overrun
      bcachefs: Fix assertion pop in bch2_ptr_swab()

Kiran K (1):
      Bluetooth: btintel: Direct exception event to bluetooth stack

Leon Romanovsky (1):
      Revert "RDMA/core: Fix ENODEV error for iWARP test over vlan"

Linus Torvalds (1):
      Linux 6.12

Linus Walleij (1):
      ARM: 9434/1: cfi: Fix compilation corner case

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix calling mgmt_device_connected

Maksym Glubokiy (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP EliteBook 645 G10

Mario Limonciello (1):
      x86/CPU/AMD: Clear virtualized VMLOAD/VMSAVE on Zen4 client

Mark Bloch (1):
      net/mlx5: fs, lock FTE when checking if active

Mark Brown (1):
      ASoC: max9768: Fix event generation for playback mute

Mateusz Guzik (1):
      evm: stop avoidably reading i_writecount in evm_file_release

Matthew Auld (2):
      drm/xe: improve hibernation on igpu
      drm/xe: handle flat ccs during hibernation on igpu

Matthew Brost (2):
      drm/xe: Ensure all locks released in exec IOCTL
      drm/xe: Restore system memory GGTT mappings

Matthieu Baerts (NGI0) (1):
      mptcp: pm: use _rcu variant under rcu_read_lock

Matthieu Buffet (3):
      samples/landlock: Fix port parsing in sandboxer
      samples/landlock: Refactor help message
      samples/landlock: Clarify option parsing behaviour

Maxim Levitsky (1):
      KVM: selftests: memslot_perf_test: increase guest sync timeout

Meghana Malladi (1):
      net: ti: icssg-prueth: Fix 1 PPS sync

Michal Luczaj (4):
      virtio/vsock: Fix accept_queue memory leak
      vsock: Fix sk_error_queue memory leak
      virtio/vsock: Improve MSG_ZEROCOPY error handling
      net: Make copy_safe_from_sockptr() match documentation

Micka=C3=ABl Sala=C3=BCn (4):
      landlock: Improve documentation of previous limitations
      landlock: Refactor filesystem access mask management
      landlock: Refactor network access mask management
      landlock: Optimize scope enforcement

Mikulas Patocka (2):
      dm-bufio: fix warnings about duplicate slab caches
      dm-cache: fix warnings about duplicate slab caches

Mina Almasry (2):
      net: fix SO_DEVMEM_DONTNEED looping too long
      net: clarify SO_DEVMEM_DONTNEED behavior in documentation

Moshe Shemesh (1):
      net/mlx5e: CT: Fix null-ptr-deref in add rule err flow

Motiejus Jak=C3=85`tys (1):
      tools/mm: fix compile error

N=C3=ADcolas F. R. A. Prado (1):
      net: stmmac: dwmac-mediatek: Fix inverted handling of mediatek,mac-wo=
l

Paolo Abeni (2):
      mptcp: error out earlier on disconnect
      mptcp: cope racing subflow creation in mptcp_rcv_space_adjust

Parav Pandit (1):
      net/mlx5: Fix msix vectors to respect platform limit

Patrick Roy (1):
      KVM: selftests: fix unintentional noop test in guest_memfd_test.c

Peng Fan (1):
      pmdomain: imx93-blk-ctrl: correct remove path

Philipp Stanner (1):
      vdpa: solidrun: Fix UB bug with devres

Qun-Wei Lin (1):
      sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Rearrange locking in
hybrid_init_cpu_capacity_scaling()

Rodrigo Siqueira (1):
      drm/amd/display: Adjust VSDB parser for replay feature

Roman Gushchin (1):
      mm: page_alloc: move mlocked flag clearance into free_pages_prepare()

Russell King (Oracle) (2):
      ARM: fix cacheflush with PAN
      net: phylink: ensure PHY momentary link-fails are handled

Ryan Seto (1):
      drm/amd/display: Handle dml allocation failure to avoid crash

Ryusuke Konishi (2):
      nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint

Samasth Norway Ananda (1):
      ima: fix buffer overrun in ima_eventdigest_init_common

Sean Christopherson (6):
      KVM: selftests: Disable strict aliasing
      KVM: selftests: Don't force -march=3Dx86-64-v2 if it's unsupported
      KVM: nVMX: Treat vpid01 as current if L2 is active, but with VPID dis=
abled
      KVM: SVM: Propagate error from snp_guest_req_init() to userspace
      KVM: x86: Unconditionally set irr_pending when updating APICv state
      KVM: VMX: Bury Intel PT virtualization (guest/host mode) behind
CONFIG_BROKEN

Shivam Chaudhary (1):
      Fix typo in vringh_test.c

Si-Wei Liu (1):
      vdpa/mlx5: Fix PA offset with unaligned starting iotlb map

Sibi Sankar (4):
      pmdomain: core: Add GENPD_FLAG_DEV_NAME_FW flag
      pmdomain: arm: Use FLAG_DEV_NAME_FW to ensure unique names
      firmware: arm_scmi: Report duplicate opps as firmware bugs
      mailbox: qcom-cpucp: Mark the irq with IRQF_NO_SUSPEND flag

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix tx_bytes calculation

Steven Rostedt (2):
      Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hot=
plug"
      tracing/ring-buffer: Clear all memory mapped CPU ring buffers on
first recording

Tejun Heo (4):
      sched_ext: Add a missing newline at the end of an error message
      sched_ext: Update scx_show_state.py to match
scx_ops_bypass_depth's new type
      sched_ext: Handle cases where pick_task_scx() is called without
preceding balance_scx()
      sched_ext: ops.cpu_acquire() should be called with SCX_KF_REST

Tim Huang (1):
      drm/amd/pm: print pp_dpm_mclk in ascending order on SMU v14.0.0

Tom Chung (2):
      drm/amd/display: Change some variable name of psr
      drm/amd/display: Fix Panel Replay not update screen correctly

Vijendar Mukunda (1):
      drm/amd: Fix initialization mistake for NBIO 7.7.0

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Grab intel_display from the encoder to avoid potential oops=
ies

Vitalii Mordan (1):
      stmmac: dwmac-intel-plat: fix call balance of tx_clk handling routine=
s

Wander Lairson Costa (1):
      Revert "igb: Disable threaded IRQ for igb_msix_other"

Wang Liang (1):
      net: fix data-races around sk->sk_forward_alloc

WangYuli (1):
      ARM: 9435/1: ARM/nommu: Fix typo "absence"

Wei Fang (1):
      samples: pktgen: correct dev to DEV

William Tu (1):
      net/mlx5e: clear xdp features on non-uplink representors

Xiaoguang Wang (1):
      vp_vdpa: fix id_table array not null terminated error

Yafang Shao (1):
      mm, doc: update read_ahead_kb for MADV_HUGEPAGE

Yuan Can (1):
      vDPA/ifcvf: Fix pci_read_config_byte() return code handling

Yuli Wang (1):
      LoongArch: Define a default value for VM_DATA_DEFAULT_FLAGS

Zijian Zhang (1):
      bpf: Add sk_is_inet and IS_ICSK check in tls_sw_has_ctx_tx/rx

