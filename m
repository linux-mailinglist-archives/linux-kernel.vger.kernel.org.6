Return-Path: <linux-kernel+bounces-540761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3373A4B494
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97943188F091
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA161EB5D7;
	Sun,  2 Mar 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c/KllWCL"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20F70821
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740945388; cv=none; b=CvHDIV+zJ95glXMBUMRWDLOmaPrD/jYx1mKcTae4tUdL27sfrCyoBmNv5AdL6kRfqF1V6RCKtBY6ModytlM/b0Lk1dLc2Tku5RlTZuPq18CQvd1Q/M8SRTm5H7OUA5kU6+tlrapcqn0cgOVe6IpjV6K1L6Dyq7spxwrcdM+YePE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740945388; c=relaxed/simple;
	bh=/y8+l+TS9vg2AdPO5YgV5uH4D+6APN+i+U44Hic2oGI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=svS1EBr8fT2NpyrXV7oAe/fRSIQyd/YvA8Ckvc1N9B9LY9/nIwYAop7GhNkDzBbGMT7oYV4FwXfvaVD6PV0idsrxylCCGBQFs/zBfHOqJtU7Yk6Cu0seXksJyFtmtPkphq1EU5d8cqr6EwIBKgVRK+z6YctO1SdKKtQGii1X4w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c/KllWCL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abf4d756135so228051366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740945383; x=1741550183; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M0rOrX62heUZ3+itwbKRpWrvkcaRqdrf2GHW8+sVViQ=;
        b=c/KllWCLw3YtmwSjsy7baY29PrtVQqO27jjzLeP1DDftPTNxMupd99wdwyprnIphgf
         V28k1B8RvCUYD53fcnMIA94b6TJUfFI8FR+mWRSghMHMY5GoR8S70CfIhpJp3BO4GW2L
         TJNHw8MJ7d/NAEVxOjBMzQTMIdnRZXy3hNXUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740945383; x=1741550183;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M0rOrX62heUZ3+itwbKRpWrvkcaRqdrf2GHW8+sVViQ=;
        b=n9OwEogbRw23ih7xRYq0KKukBlF/QljpYq1xFlSujPYhVz6Aun/K3v6u5I0WgoRg4k
         XNPTHT7pEqlLav4CUZLRgRby9bpKSNEM2LFFOmDqF7bjxn5Q+OFAilBdutSw05hhkaGM
         R8EMzuGYHGPu3blhGSc+vVD4p4PPLf7lYQ4hVmbVmOlDjPq9bxRGYrPZBT1KNjJUKnGV
         O25yj8f5m6TGx24N++4PrwGOuWsUX9Ddt8eOPk7uMXVNVBYsIi6KTgl4/yiReGlrn+DE
         W6ovCDx0WhH1yGoXmA2M9HJQShyHJj+WdXdMgAtPqV+QE6t86uZmV1cjdxPtiWD7utIA
         PT/Q==
X-Gm-Message-State: AOJu0YyUl6HgsfVg4h2LY0yYKflFs9+0St/tn+VbA2No0t7Hc96TduLP
	Eq/qLgBkkF6Xlv3NVn/+uHHX7cVQUCf0EJSkRwvwdmvs6JfgTPk9epAeam+LQDoHlt0nlJRsi78
	kap4=
X-Gm-Gg: ASbGncsP1c3JL6OUY8rQN4cEp8AQIXwuA9WCUtQyUfKeyIAz4kmVDcq5sKoeHQbsB0K
	Mf71E1yC2IKj52Z8kyvW8EGJLizFt+OcXlEDBjS84sjeZwXaDi7KyKeXRMv1nPGsBP2cf8JrPVv
	l5nEbOl35CUhZGNk8wqE1qAL+lJB942RJ6WhE2+kwjAyEFQeyo9kGKHHomAVQsXXegJgGgF34yW
	XSuDHso9/PKmvdh31TG+8v3NtjRBVu8Iu7Aww7V+wrs5hrrifxaSYCbu3xsA4tW3SkIz5lveAvp
	KxFjtHXrr6I+fAHbgrregCJsg7ho0McUlpKmtvrZhWu0SwB5Wp+yABZcVT+p7P7emiJTFNbMfY7
	9nOja+yZbxDXkT6LnTvc=
X-Google-Smtp-Source: AGHT+IHUSHf9agotRWHDN0Sl22MPkqdccgVOZAPVObUxWlsXv25pkbwnExnr59sx2zEvwLJky3RKhA==
X-Received: by 2002:a17:907:988:b0:abe:ff13:d0c4 with SMTP id a640c23a62f3a-abf261cd53cmr1481879766b.32.1740945383380;
        Sun, 02 Mar 2025 11:56:23 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf42c16af2sm428227866b.116.2025.03.02.11.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 11:56:22 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso3740504a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 11:56:22 -0800 (PST)
X-Received: by 2002:a17:907:781:b0:abe:f6f5:93fa with SMTP id
 a640c23a62f3a-abf261d3b82mr1410856666b.33.1740945381360; Sun, 02 Mar 2025
 11:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Mar 2025 11:56:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiB9Pwwv--oDW_BURx9_F-tNGZFWNi7Lqfm3REGa7PcEw@mail.gmail.com>
X-Gm-Features: AQ5f1Jp4WrjzWwKVr4ABYaZaSl6gb3VcnBfvvBI13H0QeIYQSBEgF35trWRl8bg
Message-ID: <CAHk-=wiB9Pwwv--oDW_BURx9_F-tNGZFWNi7Lqfm3REGa7PcEw@mail.gmail.com>
Subject: Linux 6.14-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another normal week, nothing strange stands out, and both the shortlog
and diffstat look very regular.

About half the patch is drivers (networking and drm dominate, but rdma
and sound show up with random noise elsewhere). The rest is fairly
spread out - architecture, filesystem, core networking, and more
selftests.

Nothing looks particularly big or worrisome.

               Linus

---

Aaron Ma (1):
      perf/x86/rapl: Add support for Intel Arrow Lake U

Adrian Huang (1):
      af_unix: Fix memory leak in unix_dgram_sendmsg()

Adrien Verg=C3=A9 (1):
      ALSA: hda/realtek: Fix microphone regression on ASUS N705UD

Alan Huang (2):
      bcachefs: Fix memmove when move keys down
      bcachefs: Fix deadlock

Alejandro Jimenez (1):
      iommu/amd: Preserve default DTE fields when updating Host Page Table =
Root

Alex Deucher (4):
      drm/amdgpu: disable BAR resize on Dell G5 SE
      MAINTAINERS: update amdgpu maintainers list
      drm/amdgpu/gfx: only call mes for enforce isolation if supported
      drm/amdgpu/mes: keep enforce isolation up to date

Alexandre Ghiti (1):
      MAINTAINERS: Add myself as a riscv reviewer

Andreas Schwab (2):
      riscv/atomic: Do proper sign extension also for unsigned in arch_cmpx=
chg
      riscv/futex: sign extend compare value in atomic cmpxchg

Andrew Davis (1):
      phy: ti: gmii-sel: Do not use syscon helper to build regmap

Andrew Donnellan (1):
      cxl: Fix cross-reference in documentation and add deprecation warning

Andrew Jones (5):
      riscv: KVM: Fix hart suspend status check
      riscv: KVM: Fix hart suspend_type use
      riscv: KVM: Fix SBI IPI error generation
      riscv: KVM: Fix SBI TIME error generation
      riscv: KVM: Fix SBI sleep_type use

Andrii Nakryiko (1):
      uprobes: Remove too strict lockdep_assert() condition in hprobe_expir=
e()

Andr=C3=A9 Draszik (1):
      phy: exynos5-usbdrd: gs101: ensure power is gated to SS phy in phy_ex=
it()

Ard Biesheuvel (4):
      efivarfs: Defer PM notifier registration until .fill_super
      vmlinux.lds: Ensure that const vars with relocations are mapped R/O
      objtool: Fix C jump table annotations for Clang
      efi/mokvar-table: Avoid repeated map/unmap of the same page

Arnd Bergmann (3):
      phy: rockchip: fix Kconfig dependency more
      sunrpc: suppress warnings for unused procfs functions
      x86/irq: Define trace events conditionally

Arthur Simchaev (1):
      scsi: ufs: core: bsg: Fix crash when arpmb command fails

Aurabindo Pillai (1):
      MAINTAINERS: Update AMDGPU DML maintainers info

BH Hsieh (1):
      phy: tegra: xusb: reset VBUS & ID OVERRIDE

Bard Liao (2):
      ASoC: SOF: Intel: don't check number of sdw links when set dmic_fixup
      ASoC: Intel: sof_sdw: warn both sdw and pch dmic are used

Bart Van Assche (1):
      scsi: ufs: core: Fix ufshcd_is_ufs_dev_busy() and ufshcd_eh_timed_out=
()

Benjamin Coddington (1):
      SUNRPC: Handle -ETIMEDOUT return from tlshd

Bharadwaj Raju (1):
      selftests/landlock: Add binaries to .gitignore

BillXiang (1):
      riscv: KVM: Remove unnecessary vcpu kick

Binbin Zhou (1):
      i2c: ls2x: Fix frequency division register access

Breno Leitao (1):
      perf/core: Add RCU read lock protection to perf_iterate_ctx()

Caleb Connolly (1):
      dmaengine: Revert "dmaengine: qcom: bam_dma: Avoid writing
unavailable register"

Carolina Jubran (2):
      net/mlx5: Fix vport QoS cleanup on error
      net/mlx5: Restore missing trace event when enabling vport QoS

Chancel Liu (1):
      ASoC: fsl: Rename stream name of SAI DAI driver

Charlie Jenkins (2):
      tools: Unify top-level quiet infrastructure
      tools: Remove redundant quiet setup

Christian Brauner (2):
      pidfs: remove d_op->d_delete
      nsfs: remove d_op->d_delete

Christian Bruel (1):
      phy: stm32: Fix constant-value overflow assertion

Christoph Hellwig (2):
      configfs: update MAINTAINERS
      dma-mapping: update MAINTAINERS

Chukun Pan (1):
      phy: rockchip: naneng-combphy: compatible reset with old DT

Cl=C3=A9ment L=C3=A9ger (1):
      riscv: cpufeature: use bitmap_equal() instead of memcmp()

Damien Le Moal (1):
      block: Remove zone write plugs when handling native zone append write=
s

Dan Carpenter (1):
      gpiolib: Fix Oops in gpiod_direction_input_nonotify()

Daniel Sneddon (1):
      x86/entry: Fix kernel-doc warning

David Disseldorp (1):
      btrfs: selftests: fix btrfs_test_delayed_refs() leak of transaction

David Howells (6):
      rxrpc: rxperf: Fix missing decoding of terminal magic cookie
      rxrpc: peer->mtu_lock is redundant
      rxrpc: Fix locking issues with the peer record hash
      afs: Fix the server_list to unuse a displaced server rather than
putting it
      afs: Give an afs_server object a ref on the afs_cell object it points=
 to
      cifs: Fix the smb1 readv callback to correctly call netfs

David Yat Sin (1):
      drm/amdkfd: Preserve cp_hqd_pq_control on update_mqd

Dmitry Panchenko (1):
      ALSA: usb-audio: Re-add sample rate quirk for Pioneer DJM-900NXS2

Dmytro Maluka (1):
      x86/of: Don't use DTB for SMP setup if ACPI is enabled

Eric Dumazet (3):
      net: better track kernel sockets lifetime
      ipvlan: ensure network headers are in skb linear part
      idpf: fix checksums set in idpf_rx_rsc()

Filipe Manana (3):
      btrfs: fix use-after-free on inode when scanning root during em shrin=
king
      btrfs: skip inodes without loaded extent maps when shrinking extent m=
aps
      btrfs: do regular iput instead of delayed iput during extent map shri=
nking

Frederic Weisbecker (1):
      net: Handle napi_schedule() calls from non-interrupt

George Moussalem (1):
      net: phy: qcom: qca807x fix condition for DAC_DSP_BIAS_CURRENT

G=C3=BCnther Noack (1):
      landlock: Minor typo and grammar fixes in IPC scoping documentation

Harry Wentland (1):
      drm/vkms: Round fixp2int conversion in lerp_u16

Harshal Chaudhari (1):
      net: mvpp2: cls: Fixed Non IP flow, with vlan tag flow defination.

Harshitha Ramamurthy (1):
      gve: unlink old napi when stopping a queue using queue API

Hector Martin (3):
      ASoC: tas2770: Fix volume scale
      ASoC: tas2764: Fix power control mask
      ASoC: tas2764: Set the SDOUT polarity correctly

Heiko Carstens (1):
      selftests/ftrace: Let fprobe test consider already enabled functions

Hsin-chen Chuang (1):
      Bluetooth: Always allow SCO packets for user channel

Ido Schimmel (1):
      net: loopback: Avoid sending IP packets without an Ethernet header

Imre Deak (1):
      drm/i915/dp_mst: Fix encoder HW state readout for UHBR MST

Jacob Keller (1):
      iavf: fix circular lock dependency with netdev_lock

Jakub Kicinski (3):
      MAINTAINERS: fix DWMAC S32 entry
      net: ethtool: fix ioctl confusing drivers about desired HDS user conf=
ig
      selftests: drv-net: test XDP, HDS auto and the ioctl path

James Bottomley (1):
      efivarfs: allow creation of zero length files

Jerry Snitselaar (1):
      iommu/vt-d: Remove device comparison in context_setup_pass_through_cb

Jingbo Xu (2):
      mm/filemap: fix miscalculated file range for
filemap_fdatawrite_range_kick()
      mm/truncate: don't skip dirty page in folio_unmap_invalidate()

Jiri Slaby (SUSE) (1):
      net: set the minimum for net_hotdata.netdev_budget_usecs

Joanne Koong (1):
      fuse: revert back to __readahead_folio() for readahead

Joe Damato (1):
      selftests: drv-net: Check if combined-count exists

John Garry (1):
      iomap: Minor code simplification in iomap_dio_bio_iter()

Junxian Huang (1):
      RDMA/hns: Fix mbox timing out by adding retry mechanism

Justin Iurman (2):
      net: ipv6: fix dst ref loop on input in seg6 lwt
      net: ipv6: fix dst ref loop on input in rpl lwt

Kalesh AP (3):
      RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier
      RDMA/bnxt_re: Add sanity checks on rdev validity
      RDMA/bnxt_re: Fix issue in the unload path

Kan Liang (3):
      perf/x86: Fix low freqency setting issue
      perf/core: Fix low freq setting via IOC_PERIOD
      perf/x86/intel: Use better start period for frequency mode

Kashyap Desai (1):
      RDMA/bnxt_re: Fix the page details for the srq created by kernel cons=
umers

Kaustabh Chakraborty (1):
      phy: exynos5-usbdrd: fix MPLL_MULTIPLIER and SSC_REFCLKSEL masks in r=
efclk

Keith Busch (2):
      vhost: return task creation error instead of NULL
      kvm: retry nx_huge_page_recovery_thread creation

Ken Raeburn (1):
      dm vdo: add missing spin_lock_init

Kent Overstreet (5):
      bcachefs: print op->nonce on data update inconsistency
      bcachefs: fix bch2_extent_ptr_eq()
      bcachefs: Revert directory i_size
      bcachefs: Check for -BCH_ERR_open_buckets_empty in journal resize
      bcachefs: Fix truncate sometimes failing and returning 1

Konstantin Taranov (1):
      RDMA/mana_ib: Allocate PAGE aligned doorbell index

Kuniyuki Iwashima (1):
      net: Use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net()=
.

Linus Torvalds (1):
      Linux 6.14-rc5

Linus Walleij (1):
      net: dsa: rtl8366rb: Fix compilation problem

Long Li (1):
      MAINTAINERS: update maintainer for Microsoft MANA RDMA driver

Lu Baolu (1):
      iommu/vt-d: Fix suspicious RCU usage

Luiz Augusto von Dentz (1):
      Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response

Luo Gengkun (1):
      perf/core: Order the PMU list to fix warning about unordered pmu_ctx_=
list

Maarten Lankhorst (1):
      MAINTAINERS: Add entry for DMEM cgroup controller

Manivannan Sadhasivam (1):
      scsi: ufs: core: Set default runtime/system PM levels before
ufshcd_hba_init()

Marcin Szycik (2):
      ice: Fix deinitializing VF in error path
      ice: Avoid setting default Rx VSI twice in switchdev setup

Mark Zhang (1):
      IB/mlx5: Set and get correct qp_num for a DCT QP

Masahiro Yamada (1):
      drm/imagination: remove unnecessary header include path

Matthew Auld (2):
      drm/xe/userptr: restore invalidation list on error
      drm/xe/userptr: fix EFAULT handling

Matthieu Baerts (NGI0) (2):
      mptcp: reset when MPTCP opts are dropped after join
      mptcp: safety check before fallback

Meghana Malladi (1):
      net: ti: icss-iep: Reject perout generation request

Melissa Wen (1):
      drm/amd/display: restore edid reading from a given i2c adapter

Micka=C3=ABl Sala=C3=BCn (1):
      selftests/landlock: Enable the new CONFIG_AF_UNIX_OOB

Mikhail Ivanov (3):
      landlock: Fix non-TCP sockets restriction
      selftests/landlock: Test TCP accesses with protocol=3DIPPROTO_TCP
      selftests/landlock: Test that MPTCP actions are not restricted

Miklos Szeredi (1):
      fuse: don't truncate cached, mutated symlink

Milan Broz (2):
      dm-integrity: Avoid divide by zero in table status in Inline mode
      dm-integrity: Do not emit journal configuration in DM table for
Inline mode

Ming Lei (2):
      block: make segment size limit workable for > 4K PAGE_SIZE
      block: fix 'kmem_cache of name 'bio-108' already exists'

Mingcong Bai (1):
      drm/xe/regs: remove a duplicate definition for RING_CTL_SIZE(size)

Mohammad Heib (1):
      net: Clear old fragment checksum value in napi_reuse_skb

Mohan Kumar D (2):
      dmaengine: tegra210-adma: Use div_u64 for 64 bit division
      dmaengine: tegra210-adma: check for adma max page

Nicolas Frattaroli (2):
      ASoC: es8328: fix route from DAC to output
      ASoC: dapm-graph: set fill colour of turned on nodes

Nikita Zhandarovich (1):
      usbnet: gl620a: fix endpoint checking in genelink_bind()

Niklas Cassel (2):
      ata: ahci: Make ahci_ignore_port() handle empty mask_port_map
      Revert "ata: libata-core: Add ATA_QUIRK_NOLPM for Samsung SSD
870 QVO drives"

Nikolay Kuratov (1):
      ftrace: Avoid potential division by zero in function_stat_show()

Oliver Upton (1):
      KVM: arm64: Ensure a VMID is allocated before programming VTTBR_EL2

Paolo Abeni (1):
      mptcp: always handle address removal under msk socket lock

Patrick Rudolph (2):
      efi/cper: Fix cper_ia_proc_ctx alignment
      efi/cper: Fix cper_arm_ctx_info alignment

Patrisious Haddad (2):
      RDMA/mlx5: Fix AH static rate parsing
      RDMA/mlx5: Fix bind QP error cleanup flow

Pavel Begunkov (1):
      io_uring/net: save msg_control for compat

Pei Xiao (1):
      phy: freescale: fsl-samsung-hdmi: Limit PLL lock detection clock
divider to valid range

Peter Jones (1):
      efi: Don't map the entire mokvar table to determine its size

Philo Lu (1):
      ipvs: Always clear ipvs_property flag in skb_scrub_packet()

Pierre-Eric Pelloux-Prayer (1):
      drm/amdgpu: init return value in amdgpu_ttm_clear_buffer

Piotr Kwapulinski (1):
      ixgbe: fix media cage present detection for E610 device

Qu Wenruo (2):
      btrfs: output an error message if btrfs failed to find the seed fsid
      btrfs: fix data overwriting bug during buffered write when block
size < page size

Qunqin Zhao (1):
      net: stmmac: dwmac-loongson: Add fix_soc_reset() callback

Rafael J. Wysocki (1):
      thermal/of: Fix cdev lookup in thermal_of_should_bind()

Richard Fitzgerald (2):
      firmware: cs_dsp: Remove async regmap writes
      ASoC: cs35l56: Prevent races when soft-resetting using SPI control

Rob Herring (1):
      riscv: cacheinfo: Use of_property_present() for non-boolean propertie=
s

Roberto Sassu (1):
      ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr

Rodrigo Siqueira (2):
      MAINTAINERS: Change my role from Maintainer to Reviewer
      mailmap: Add entry for Rodrigo Siqueira

Roman Li (1):
      drm/amd/display: Fix HPD after gpu reset

Russell Senior (1):
      x86/CPU: Fix warm boot hang regression on AMD SC1100 SoC systems

Ryan Roberts (4):
      arm64/mm: Fix Boot panic on Ampere Altra
      mm: hugetlb: Add huge page size param to huge_ptep_get_and_clear()
      arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
      arm64: hugetlb: Fix flush_hugetlb_tlb_range() invalidation level

Sascha Hauer (1):
      net: ethernet: ti: am65-cpsw: select PAGE_POOL

Sean Anderson (1):
      net: cadence: macb: Synchronize stats calculations

Sean Christopherson (2):
      KVM: x86: Free vCPUs before freeing VM state
      KVM: nVMX: Process events on nested VM-Exit if injectable IRQ or
NMI is pending

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the statistics for Gen P7 VF

Shay Drory (1):
      net/mlx5: IRQ, Fix null string in debug print

Shyam Sundar S K (1):
      i2c: amd-asf: Fix EOI register write to enable successive interrupts

Stafford Horne (1):
      rseq/selftests: Fix riscv rseq_offset_deref_addv inline asm

Stanislav Fomichev (1):
      tcp: devmem: don't write truncated dmabuf CMSGs to userspace

Stephen Smalley (1):
      lsm,nfs: fix memory leak of lsm_context

Steven Rostedt (1):
      tracing: Fix bad hist from corrupting named_triggers list

Takashi Iwai (2):
      ALSA: usb-audio: Avoid dropping MIDI events at closing multiple ports
      ALSA: hda/realtek: Fix wrong mic setup for ASUS VivoBook 15

Tanya Agarwal (2):
      integrity: fix typos and spelling errors
      landlock: Fix grammar error

Tejas Upadhyay (1):
      drm/xe: cancel pending job timer before freeing scheduler

Tejun Heo (1):
      sched_ext: Fix pick_task_scx() picking non-queued tasks when
it's called without balance()

Thomas Gleixner (3):
      rcuref: Plug slowpath race in rcuref_put()
      sched/core: Prevent rescheduling when interrupts are disabled
      intel_idle: Handle older CPUs, which stop the TSC in deeper C
states, correctly

Thomas Zimmermann (2):
      drm/nouveau: Do not override forced connector status
      drm/fbdev-dma: Add shadow buffering for deferred I/O

Tom Chung (1):
      drm/amd/display: Disable PSR-SU on eDP panels

Tong Tiangen (1):
      uprobes: Reject the shared zeropage in uprobe_write_opcode()

Trond Myklebust (4):
      NFS: O_DIRECT writes must check and adjust the file length
      NFS: Adjust delegated timestamps for O_DIRECT reads and writes
      SUNRPC: Prevent looping due to rpc_signal_task() races
      NFSv4: Fix a deadlock when recovering state on a sillyrenamed file

Tyrone Ting (1):
      i2c: npcm: disable interrupt enable bit before devm_request_irq

Umesh Nerlige Ramappa (1):
      drm/xe/oa: Allow oa_exponent value of 0

Vasiliy Kovalev (1):
      ovl: fix UAF in ovl_dentry_update_reval by moving dput() in ovl_link_=
up

Wang Hai (1):
      tcp: Defer ts_recent changes until req is owned

Wei Fang (8):
      net: enetc: fix the off-by-one issue in enetc_map_tx_buffs()
      net: enetc: keep track of correct Tx BD count in enetc_map_tx_tso_buf=
fs()
      net: enetc: correct the xdp_tx statistics
      net: enetc: VFs do not support HWTSTAMP_TX_ONESTEP_SYNC
      net: enetc: update UDP checksum when updating originTimestamp field
      net: enetc: add missing enetc4_link_deinit()
      net: enetc: remove the mm_lock from the ENETC v4 driver
      net: enetc: fix the off-by-one issue in enetc_map_tx_tso_buffs()

Will Deacon (2):
      workqueue: Log additional details when rejecting work
      KVM: arm64: Fix tcr_el2 initialisation in hVHE mode

Willem de Bruijn (1):
      MAINTAINERS: socket timestamping: add Jason Xing as reviewer

Xi Ruoyao (1):
      MIPS: Ignore relocs against __ex_table for relocatable kernel

Ye Bin (1):
      scsi: core: Clear driver private data when retrying request

Yilin Chen (1):
      drm/amd/display: add a quirk to enable eDP0 on DP1

Yishai Hadas (4):
      RDMA/mlx5: Fix the recovery flow of the UMR QP
      RDMA/mlx5: Fix a race for DMABUF MR which can lead to CQE with error
      RDMA/mlx5: Fix a WARN during dereg_mr for DM type
      RDMA/mlx5: Fix implicit ODP hang on parent deregistration

Yong-Xuan Wang (2):
      riscv: signal: fix signal frame size
      riscv: signal: fix signal_minsigstksz

Youling Tang (1):
      objtool: Add bch2_trans_unlocked_or_in_restart_error() to
bcachefs noreturns

Yu-Che Cheng (2):
      thermal: gov_power_allocator: Fix incorrect calculation in
divvy_up_power()
      thermal: gov_power_allocator: Update total_weight on bind and cdev up=
dates

chr[] (1):
      amdgpu/pm/legacy: fix suspend/resume issues

