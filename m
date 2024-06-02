Return-Path: <linux-kernel+bounces-198465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842748D78EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBB11F2134B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113243EA7B;
	Sun,  2 Jun 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DpRLh+7o"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19783207
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717368664; cv=none; b=dVCDvdTrh81uiyq7lVgk0PKNmWTBn34cwC59r7JjKSna2Ol372b2WZJ0bHG/QfcX+jSoU3m8RI/29dg+duqvtHFpNfEf5EqdXUm8NLMEvWC/1G5W+jG+1h+EZBLfW6L6bBN/uhcASF70gs6D6R1y764qiddMQX8bSKYyOmAZHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717368664; c=relaxed/simple;
	bh=RNjV1D/giM5lmsN4zSbph6PJLVw10IpAX6CPxuJ8RK0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=S7hBjlUVXZ/IvWaI7McB3krJjk9jcHD+TxOZygSFHrnR0p2qxqN2saoPGc6PzKpveSJowLRxleu+A23x3cZQvZpRBPH9eMbAaB8g2pAMZpDClQyN1OKimfXiZGp+LdobdPL3L+/mCMRvRWOO9cHXGJh9OwZOv4YOym92/pbRcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DpRLh+7o; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a68ca4d6545so162613166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717368660; x=1717973460; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mh9+2CrML1T/my+lKHgLLpOmUtGNUm8k9nK80RNl4Ac=;
        b=DpRLh+7oHe6XTJ223zzh++6mB4CE80UEVWmI2yHGRall7aarz9yqnA8tJ1H0mvNTRX
         41S+hdKuN0+VKtluUgfo+PNjC8QGsm6UZoRdGBSn2VHoYMAnVZHvuUyDn2XbfHf8GMog
         PJ8CcZt/MLYAgN9Re7HW7DeZN2IPQ+0zeoNcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717368660; x=1717973460;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mh9+2CrML1T/my+lKHgLLpOmUtGNUm8k9nK80RNl4Ac=;
        b=H2iVF42qHDYRieAqPsX5Oez2XA0lGjl3O2uI23eYYUOFgoDVHmItebLDV0feymXz55
         v5b4KSQS0t5zdNMzDFUZcpIhsfyZj+SUuH8/1GYg2TNbWfJ4rCFZ3u5BKRe4P0bWDDj9
         eN9Jd1zK0nxbAp5CRTUY9hMr2ZPmPLNFpAHa8HT8AX9kD5cjnZdq8bBPsgGWnNb2j1U1
         J+qzdFPwZVEvUZOJc7GfLWKUXOjBjB9J3v4x1Js7SKMwDYGdki/SbrBaiMo5WxQo7m6k
         eHYVQQIGf3ZF5kaZTrcus3VOGyqAgnFnK/A+iRQgjxQrNQwo1cep+tqA8h40noJpYFPY
         65GQ==
X-Gm-Message-State: AOJu0YzgdWBCOFBDOBzlO8K2LtaqATdRjWHF67Fek3Evp+tMYe44dToH
	ydl8KmK4H50VJ7YiWHrgC0omCK+6xg4me+U7ER/wdsXJa3+KGdkkkuIzue0Y9ppXV+MHM/B5bmw
	u6VI=
X-Google-Smtp-Source: AGHT+IE4QtLKxOT8Tm2EDkNsjkQgSo6iso/AzTfcYhGkXIbeJ2LuDEtzKChDfPOMKIfDAY/saCP10w==
X-Received: by 2002:a17:906:6547:b0:a68:a1ec:ef41 with SMTP id a640c23a62f3a-a68a1ecef9amr417407466b.17.1717368659599;
        Sun, 02 Jun 2024 15:50:59 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fb54esm396037666b.61.2024.06.02.15.50.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jun 2024 15:50:59 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a2f27090aso4485804a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 15:50:58 -0700 (PDT)
X-Received: by 2002:a17:906:1ed1:b0:a59:a85c:a5ca with SMTP id
 a640c23a62f3a-a6818672754mr678876866b.7.1717368658264; Sun, 02 Jun 2024
 15:50:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 2 Jun 2024 15:50:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
Message-ID: <CAHk-=wisJ8bS3qe6iBPwL9x=PqJA5oE7tum-E9oZfyPgd2mmrw@mail.gmail.com>
Subject: Linux 6.10-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One third driver fixes, one third filesystems, and one third "random leftov=
ers".

The driver side is sound, networking, nvme, gpu and "misc". The
filesystem fixes are mostly bcachefs, but there's some other noise in
there too. And the random stuff is the usual mix of arch updates, core
networking, seltftests, io_uring, header file fixes etc etc.

Nothing feels particularly odd, but rc2 is usually fairly small and
people are only starting to find regressions.

So please go test some more,

             Linus

---

Abhinav Kumar (1):
      drm/msm: remove python 3.9 dependency for compiling msm

Adri=C3=A1n Larumbe (3):
      drm/panfrost: Fix dma_resv deadlock at drm object pin time
      drm/lima: Fix dma_resv deadlock at drm object pin time
      drm/gem-shmem: Add import attachment warning to locked pin function

Alex Deucher (4):
      drm/amdgpu: Adjust logic in amdgpu_device_partner_bandwidth()
      drm/amdgpu: silence UBSAN warning
      Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices=
"
      drm/amdkfd: simplify APU VRAM handling

Alexander Lobakin (2):
      page_pool: fix &page_pool_params kdoc issues
      idpf: don't enable NAPI and interrupts prior to allocating Rx buffers

Alexander Maltsev (1):
      netfilter: ipset: Add list flush to cancel_gc

Alexander Mikhalitsyn (1):
      ipv4: correctly iterate over the target netns in inet_dump_ifaddr()

Alexandre Belloni (1):
      ALSA: pcm: fix typo in comment

Alexandre Ghiti (1):
      riscv: Fix fully ordered LR/SC xchg[8|16]() implementations

Alina Yu (1):
      regulator: rtq2208: Fix invalid memory access when
devm_of_regulator_put_matches is called

Andi Shyti (1):
      drm/i915/gt: Fix CCS id's calculation for CCS mode setting

Andrii Nakryiko (6):
      uprobes: prevent mutex_lock() under rcu_read_lock()
      bpf: fix multi-uprobe PID filtering logic
      bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe
attach logic
      libbpf: detect broken PID filtering logic for multi-uprobe
      selftests/bpf: extend multi-uprobe tests with child thread case
      selftests/bpf: extend multi-uprobe tests with USDTs

Andy Shevchenko (3):
      spi: Don't mark message DMA mapped when no transfer in it is
      spi: Check if transfer is mapped before calling DMA sync APIs
      spi: Assign dummy scatterlist to unidirectional transfers

Armin Wolf (1):
      hwmon: (dell-smm) Add Dell G15 5511 to fan control whitelist

Arnd Bergmann (2):
      drm/i915/guc: avoid FIELD_PREP warning
      mailbox: zynqmp-ipi: drop irq_to_desc() call

Breno Leitao (1):
      io_uring/rw: Free iovec before cleaning async data

Carlos L=C3=B3pez (1):
      tracing/probes: fix error check in parse_btf_field()

Carolina Jubran (1):
      net/mlx5e: Use rx_missed_errors instead of rx_dropped for
reporting buffer exhaustion

Charles Keepax (3):
      ASoC: cs42l43: Only restrict 44.1kHz for the ASP
      ASoC: wm_adsp: Add missing MODULE_DESCRIPTION()
      MAINTAINERS: Remove James Schulman from Cirrus audio maintainers

Chen-Yu Tsai (1):
      scripts/make_fit: Drop fdt image entry compatible string

Chris Wilson (1):
      drm/i915/gt: Disarm breadcrumbs if engines are already idle

Christian Brauner (1):
      swap: yield device immediately

Christoph Hellwig (6):
      block: remove blk_queue_max_integrity_segments
      dm: move setting zoned_enabled to dm_table_set_restrictions
      dm: remove dm_check_zoned
      dm: make dm_set_zones_restrictions work on the queue limits
      sd: also set max_user_sectors when setting max_sectors
      block: stack max_user_sectors

Coly Li (2):
      bcache: call force_wake_up_gc() if necessary in check_should_bypass()
      bcache: code cleanup in __bch_bucket_alloc_set()

Damien Le Moal (5):
      null_blk: Fix return value of nullb_device_power_store()
      null_blk: Print correct max open zones limit in null_init_zoned_dev()
      null_blk: Do not allow runt zone with zone capacity smaller then zone=
 size
      block: Fix validation of zoned device with a runt zone
      block: Fix zone write plugging handling of devices with a runt zone

Daniel Borkmann (4):
      netkit: Fix setting mac address in l2 mode
      netkit: Fix pkt_type override upon netkit pass verdict
      selftests/bpf: Add netkit tests for mac address
      selftests/bpf: Add netkit test for pkt_type

Darrick J. Wong (4):
      xfs: drop xfarray sortinfo folio on error
      xfs: fix xfs_init_attr_trans not handling explicit operation codes
      xfs: allow symlinks with short remote targets
      xfs: don't open-code u64_to_user_ptr

Dave Ertman (1):
      ice: check for unregistering correct number of devlink params

Dave Hansen (1):
      x86/cpu: Provide default cache line size if not enumerated

David Howells (4):
      netfs: Fix io_uring based write-through
      netfs: Fix AIO error handling when doing write-through
      netfs: Fix setting of BDP_ASYNC from iocb flags
      netfs, 9p: Fix race between umount and async request completion

Dmitry Baryshkov (2):
      drm/panel/lg-sw43408: select CONFIG_DRM_DISPLAY_DP_HELPER
      drm/panel/lg-sw43408: mark sw43408_backlight_ops as static

Dominique Martinet (1):
      9p: add missing locking around taking dentry fid list

Dongsheng Yang (1):
      bcache: allow allocator to invalidate bucket in gc

Douglas Anderson (1):
      kbuild: scripts/gdb: Replace missed $(srctree)/$(src) w/ $(src)

Edward Adam Davis (1):
      nfc/nci: Add the inconsistency check between the input data
length and count

Eric Dumazet (3):
      netfilter: nfnetlink_queue: acquire rcu_read_lock() in
instance_destroy_rcu()
      tcp: reduce accepted window in NEW_SYN_RECV state
      net: fix __dst_negative_advice() race

Eric Garver (1):
      netfilter: nft_fib: allow from forward/input without iif selector

Fedor Pchelkin (7):
      dma-mapping: benchmark: fix up kthread-related error handling
      dma-mapping: benchmark: avoid needless copy_to_user if benchmark fail=
s
      dma-mapping: benchmark: fix node id validation
      dma-mapping: benchmark: handle NUMA_NO_NODE correctly
      signalfd: fix error return code
      signalfd: drop an obsolete comment
      dma-buf: handle testing kthreads creation failure

Florian Westphal (1):
      netfilter: tproxy: bail out if IP has been disabled on the device

Friedrich Vock (1):
      bpf: Fix potential integer overflow in resolve_btfids

Gal Pressman (2):
      net/mlx5: Fix MTMP register capability offset in MCAM register
      net/mlx5e: Fix UDP GSO for encapsulated packets

Geliang Tang (1):
      selftests: hsr: Fix "File exists" errors for hsr_ping

Gerald Loacker (3):
      drm/panel: sitronix-st7789v: fix timing for jt240mhqs_hwt_ek_e3 panel
      drm/panel: sitronix-st7789v: tweak timing for jt240mhqs_hwt_ek_e3 pan=
el
      drm/panel: sitronix-st7789v: fix display size for
jt240mhqs_hwt_ek_e3 panel

Greg Kroah-Hartman (1):
      Revert "VT: Use macros to define ioctls"

Guenter Roeck (2):
      drm/nouveau/nvif: Avoid build error due to potential integer overflow=
s
      hwmon: (shtc1) Fix property misspelling

Hannes Reinecke (1):
      block: check for max_hw_sectors underflow

Hans de Goede (2):
      platform/x86: x86-android-tablets: Add "select LEDS_CLASS"
      platform/x86: touchscreen_dmi: Add support for setting
touchscreen properties from cmdline

Hariprasad Kelam (1):
      Octeontx2-pf: Free send queue buffers incase of leaf to inner

Harshit Mogalapalli (1):
      platform/x86: ISST: fix use-after-free in tpmi_sst_dev_remove()

Hawking Zhang (1):
      drm/amdgpu: correct hbm field in boot status

Heiner Kallweit (1):
      drm/amd/pm: remove deprecated I2C_CLASS_SPD support from newly
added SMU_14_0_2

Herbert Xu (1):
      hwrng: core - Remove add_early_randomness

Himal Prasad Ghimiray (1):
      drm/xe: Change pcode timeout to 50msec while polling again

Horatiu Vultur (1):
      net: micrel: Fix lan8841_config_intr after getting out of sleep mode

Hui Wang (1):
      e1000e: move force SMBUS near the end of enable_ulp function

Ido Schimmel (1):
      ipv4: Fix address dump when IPv4 is disabled on an interface

Imre Deak (1):
      drm/i915: Fix audio component initialization

Jacob Keller (1):
      ice: fix accounting if a VLAN already exists

Jakub Kicinski (1):
      netdev: add qstat for csum complete

Jakub Sitnicki (3):
      bpf: Allow delete from sockmap/sockhash only if update is allowed
      Revert "bpf, sockmap: Prevent lock inversion deadlock in map delete e=
lem"
      selftests/bpf: Cover verifier checks for mutating sockmap/sockhash

Janusz Krzysztofik (1):
      Revert "drm/i915: Remove extra multi-gt pm-references"

Jarkko Sakkinen (3):
      tpm: Open code tpm_buf_parameters()
      tpm: Rename TPM2_OA_TMPL to TPM2_OA_NULL_KEY and make it local
      tpm: Enable TCG_TPM2_HMAC by default only for X86_64

Jason Nader (1):
      ata: ahci: Do not apply Intel PCS quirk on Intel Alder Lake

Javier Carrasco (1):
      hwmon: (ltc2992) Fix memory leak in ltc2992_parse_dt()

Jeff Johnson (5):
      firewire: add missing MODULE_DESCRIPTION() to test modules
      fs: smb: common: add missing MODULE_DESCRIPTION() macros
      bcachefs: add missing MODULE_DESCRIPTION()
      perf/x86/rapl: Add missing MODULE_DESCRIPTION() line
      perf/x86/intel: Add missing MODULE_DESCRIPTION() lines

Jens Axboe (2):
      io_uring: don't attempt to mmap larger than what the user asks for
      io_uring/net: assign kmsg inq/flags before buffer selection

Jesse Zhang (1):
      drm/amdgpu: fix dereference null return value for the function
amdgpu_vm_pt_parent

Jim Wylder (1):
      regmap-i2c: Subtract reg size from max_write

John Garry (2):
      xfs: Clear W=3D1 warning in xfs_iwalk_run_callbacks()
      xfs: Stop using __maybe_unused in xfs_alloc.c

Kanchan Joshi (1):
      nvme: remove sgs and sws

Kees Cook (3):
      scsi: mpt3sas: Avoid possible run-time warning with long
manufacturer strings
      mailmap: update entry for Kees Cook
      kunit/fortify: Remove __kmalloc_node() test

Keith Busch (3):
      nvme: fix multipath batched completion accounting
      nvme-multipath: fix io accounting on failover
      nvme: use srcu for iterating namespace list

Kent Overstreet (19):
      bcachefs: Fix debug assert
      bcachefs: Fix sb-downgrade validation
      bcachefs: Plumb bkey into __btree_err()
      bcachefs: Fix lookup_first_inode() when inode_generations are present
      bcachefs: Fix locking assert
      bcachefs: Refactor delete_dead_snapshots()
      bcachefs: Run check_key_has_snapshot in snapshot_delete_keys()
      bcachefs: Fix setting of downgrade recovery passes/errors
      bcachefs: btree_gc can now handle unknown btrees
      bcachefs: Better fsck error message for key version
      bcachefs: split out sb-members_format.h
      bcachefs: split out sb-downgrade_format.h
      bcachefs: Split out disk_groups_format.h
      bcachefs: Split out replicas_format.h
      bcachefs: Split out journal_seq_blacklist_format.h
      bcachefs: Split out sb-errors_format.h
      bcachefs: Fix uninitialized var warning
      bcachefs: Don't return -EROFS from mount on inconsistency error
      bcachefs: Fix failure to return error on misaligned dio write

Kundan Kumar (1):
      nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset

Kuniyuki Iwashima (2):
      af_unix: Annotate data-race around unix_sk(sk)->addr.
      af_unix: Read sk->sk_hash under bindlock during bind().

Linus Torvalds (2):
      Revert "vfs: Delete the associated dentry when deleting a file"
      Linux 6.10-rc2

Lukas Bulwahn (1):
      Documentation/core-api: correct reference to SWIOTLB_DYNAMIC

Luke D. Jones (1):
      ALSA: hda/realtek: Adjust G814JZR to use SPI init for amp

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix start counter for ft1 filter

Maher Sanalla (1):
      net/mlx5: Lag, do bond only if slaves agree on roce state

Marc Dionne (1):
      afs: Don't cross .backup mountpoint from backup volume

Mario Limonciello (1):
      drm/amd/display: Enable colorspace property for MST connectors

Masahiro Yamada (7):
      kconfig: remove unused expr_is_no()
      kconfig: fix comparison to constant symbols, 'm', 'n'
      kconfig: remove redundant check in expr_join_or()
      kbuild: avoid unneeded kallsyms step 3
      kbuild: change scripts/mksysmap into sed script
      kbuild: fix short log for AS in link-vmlinux.sh
      kbuild: remove a stale comment about cleaning in link-vmlinux.sh

Mathieu Othacehe (1):
      net: phy: micrel: set soft_reset callback to genphy_soft_reset for KS=
Z8061

Matt Jan (1):
      connector: Fix invalid conversion in cn_proc.h

Matthew Auld (2):
      drm/buddy: stop using PAGE_SIZE
      drm/tests/buddy: stop using PAGE_SIZE

Matthew Brost (1):
      drm/xe: Only use reserved BCS instances for usm migrate exec queue

Matthew R. Ochs (1):
      tpm_tis_spi: Account for SPI header when allocating TPM SPI xfer buff=
er

Matthew Wilcox (Oracle) (1):
      bcachefs: Use copy_folio_from_iter_atomic()

Matthias Maennich (1):
      kheaders: explicitly define file modes for archived headers

Matthieu Baerts (NGI0) (4):
      selftests: mptcp: lib: support flaky subtests
      selftests: mptcp: simult flows: mark 'unbalanced' tests as flaky
      selftests: mptcp: join: mark 'fastclose' tests as flaky
      selftests: mptcp: join: mark 'fail' tests as flaky

Michael Ellerman (2):
      powerpc/uaccess: Fix build errors seen with GCC 13/14
      powerpc/uaccess: Use YZ asm constraint for ld

Micka=C3=ABl Sala=C3=BCn (2):
      landlock: Fix d_parent walk
      selftests/landlock: Add layout1.refer_mount_root

Miguel Ojeda (1):
      kheaders: use `command -v` to test for existence of `cpio`

Minda Chen (1):
      MAINTAINERS: dwmac: starfive: update Maintainer

Mohamed Ahmed (1):
      drm/nouveau: use tile_mode and pte_kind for VM_BIND bo allocations

Nam Cao (1):
      riscv: enable HAVE_ARCH_HUGE_VMAP for XIP kernel

Nathan Lynch (1):
      powerpc/pseries/lparcfg: drop error message from guest name lookup

Nikita Zhandarovich (1):
      net/9p: fix uninit-value in p9_client_rpc()

Niklas Cassel (3):
      ata: libata-core: Add ATA_HORKAGE_NOLPM for Crucial CT240BX500SSD1
      ata: libata-core: Add ATA_HORKAGE_NOLPM for AMD Radeon S3 SSD
      ata: libata-core: Add ATA_HORKAGE_NOLPM for Apacer AS340

Nilay Shroff (1):
      nvme-multipath: find NUMA path only for online numa-node

Niranjana Vishwanathapura (1):
      drm/xe: Properly handle alloc_guc_id() failure

Nirmoy Das (1):
      drm/i915/selftests: Set always_coherent to false when reading from CP=
U

Pablo Neira Ayuso (2):
      netfilter: nft_payload: restore vlan q-in-q match support
      netfilter: nft_payload: skbuff vlan metadata mangle support

Palmer Dabbelt (1):
      Documentation: RISC-V: uabi: Only scalar misaligned loads are support=
ed

Parthiban Veerasooran (1):
      net: usb: smsc95xx: fix changing LED_SEL bit value updated from EEPRO=
M

Paul Greenwalt (1):
      ice: fix 200G PHY types to link speed mapping

Peter Colberg (1):
      hwmon: (intel-m10-bmc-hwmon) Fix multiplier for N6000 board power sen=
sor

Peter Ujfalusi (6):
      ASoC: SOF: ipc4-topology: Fix input format query of process
modules without base extension
      ASoC: SOF: ipc4-topology: Add support for NHLT with 16-bit only DMIC =
blob
      ASoC: SOF: ipc4-topology: Print out the channel count in
sof_ipc4_dbg_audio_format
      ASoC: SOF: ipc4-topology/pcm: Rename sof_ipc4_copier_is_single_format=
()
      ASoC: SOF: ipc4-topology: Improve readability of
sof_ipc4_prepare_dai_copier()
      ASoC: SOF: ipc4-topology: Adjust the params based on DAI formats

Phil Auld (1):
      sched/x86: Export 'percpu arch_freq_scale'

Pierre-Louis Bossart (6):
      ASoC: SOF: stream-ipc: remove unnecessary MODULE_LICENSE
      ASoC: SOF: AMD: group all module related information
      ASoC: SOF: reorder MODULE_ definitions
      ASoC: SOF: add missing MODULE_DESCRIPTION()
      ALSA/hda: intel-dsp-config: reduce log verbosity
      ASoC: Intel: sof-sdw: fix missing SPI_MASTER dependency

Puranjay Mohan (1):
      powerpc/bpf: enforce full ordering for ATOMIC operations with BPF_FET=
CH

Rahul Rameshbabu (3):
      net/mlx5: Use mlx5_ipsec_rx_status_destroy to correctly delete
status rules
      net/mlx5e: Fix IPsec tunnel mode offload feature check
      net/mlx5e: Do not use ptp structure for tx ts stats when not initiali=
zed

Rajneesh Bhardwaj (1):
      drm/amdgpu: Make CPX mode auto default in NPS4

Ritesh Harjani (IBM) (1):
      xfs: Add cond_resched to block unmap range and reflink remap path

Rob Herring (Arm) (3):
      dt-bindings: net: pse-pd: microchip,pd692x0: Fix missing
"additionalProperties" constraints
      dt-bindings: net: pse-pd: ti,tps23881: Fix missing
"additionalProperties" constraints
      dt-bindings: kbuild: Fix dt_binding_check on unconfigured build

Roded Zats (1):
      enic: Validate length of nl attributes in enic_set_vf_port

Sagi Grimberg (2):
      nvmet: fix ns enable/disable possible hang
      nvmet: fix a possible leak when destroy a ctrl during qp establishmen=
t

Samuel Holland (1):
      powerpc: Limit ARCH_HAS_KERNEL_FPU_SUPPORT to PPC64

Sergey Matyukevich (1):
      riscv: prevent pt_regs corruption for secondary idle threads

Shahab Vahedi (1):
      ARC, bpf: Fix issues reported by the static analyzers

Shay Agroskin (1):
      net: ena: Fix redundant device NUMA node override

Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Add delay after power up handshake

Steve French (1):
      cifs: fix creating sockets when using sfu mount options

Steven Rostedt (Google) (1):
      platform/x86: thinkpad_acpi: Select INPUT_SPARSEKMAP in Kconfig

Takashi Iwai (9):
      ALSA: core: Remove debugfs at disconnection
      ALSA: seq: Fix missing bank setup between MIDI1/MIDI2 UMP conversion
      ALSA: seq: Don't clear bank selection at event -> UMP MIDI2 conversio=
n
      ALSA: seq: Fix incorrect UMP type for system messages
      ALSA: ump: Don't clear bank selection after sending a program change
      ALSA: ump: Don't accept an invalid UMP protocol number
      ALSA: ump: Set default protocol when not given explicitly
      ALSA: seq: Fix yet another spot for system message conversion
      ALSA: seq: ump: Fix swapped song position pointer data

Tariq Toukan (1):
      net/mlx5: Do not query MPIR on embedded CPU function

Tetsuo Handa (1):
      dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Thadeu Lima de Souza Cascardo (1):
      sock_map: avoid race between sock_map_close and sk_psock_put

Thinh Tran (2):
      i40e: factoring out i40e_suspend/i40e_resume
      i40e: Fully suspend and resume IO operations in EEH case

Thomas Gleixner (2):
      x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on
family 0x17 and greater
      x86/topology/intel: Unlock CPUID before evaluating anything

Thorsten Blum (1):
      docs: netdev: Fix typo in Signed-off-by tag

Tristram Ha (1):
      net: dsa: microchip: fix RGMII error in KSZ DSA driver

Uwe Kleine-K=C3=B6nig (2):
      spi: stm32: Revert change that enabled controller before asserting CS
      spi: stm32: Don't warn about spurious interrupts

Vidya Srinivas (1):
      drm/i915/dpt: Make DPT object unshrinkable

Vladimir Oltean (2):
      net/sched: taprio: make q->picos_per_byte available to fill_sched_ent=
ry()
      net/sched: taprio: extend minimum interval restriction to entire cycl=
e too

Wachowski, Karol (1):
      drm/shmem-helper: Fix BUG_ON() on mmap(PROT_WRITE, MAP_PRIVATE)

Waiman Long (1):
      blk-throttle: Fix incorrect display of io.max

Willem de Bruijn (1):
      net: gro: initialize network_offset in network layer

Witold Sadowski (1):
      spi: cadence: Ensure data lines set to low during dummy-cycle period

Xiaolei Wang (1):
      net:fec: Add fec_enet_deinit()

Xu Kuohai (1):
      MAINTAINERS: Add myself as reviewer of ARM64 BPF JIT

Xu Yang (2):
      filemap: add helper mapping_max_folio_size()
      iomap: fault in smaller chunks for non-large folio mappings

Yue Haibing (1):
      ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

hexue (1):
      block: delete redundant function declaration

hmtheboy154 (2):
      platform/x86: touchscreen_dmi: Add info for GlobalSpace SolT IVW
11.6" tablet
      platform/x86: touchscreen_dmi: Add info for the EZpad 6s Pro

