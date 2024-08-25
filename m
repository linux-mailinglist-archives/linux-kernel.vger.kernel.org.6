Return-Path: <linux-kernel+bounces-300328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116795E26C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03651C20A01
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDA352F62;
	Sun, 25 Aug 2024 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cq9dhdIo"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1588128382
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724570862; cv=none; b=Bix1ZieJCRfM/YZT3vbDXqM4L0/Su9f3c8LkmSota9WsusR78WRdgKGiNzfS8IrqEtkMIdz5AOFlhHe1B/g66t2ra68w6uObE1lolNHvUiimxvsRlPbIQrmXtcNk6KlgMNmFqb0e16HIKhmZasbatf215VF3Cus+DTh3S/S9i+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724570862; c=relaxed/simple;
	bh=KR/lRKShYg0XqlVCSjWCWPN8GX3Na3H7V0Xo//MaIcg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b/vPQAU6zoCcnJZtIqb5CLmWXW5sTmrzW/KUMTvt4HSYXBZKc3MiMbnM3mZYoX4tc5ouMAvVIlrWP3UCYRavzzVUON41Oz4AusjaNFYnBEs/emf9FPw3s0WSfjibPNLdH16zlR7EEHBRHgKR2vs6uNlLD9TEqmiIqEl0jUJ2Z5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cq9dhdIo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-533488ffaddso4255702e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724570857; x=1725175657; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=97os52zcitS6qErBNoXSZh5a3Br8dOjcCTHJBeN4ZPc=;
        b=cq9dhdIoO+4l5RjvMOyP4Ih5lcvxSiacjB6pdqp2RIbhJkRqPeEd+wXXArXoYmWRLl
         9hPq38Dkzi835Hfis4lntEVmEBeP405VoFYCpf3+ANxTqeuGeqNuA130pSnhTqQkk2a6
         vzjwdt/e/DsZ9GqEFU748lglgtsqSGA9u8uSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724570857; x=1725175657;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97os52zcitS6qErBNoXSZh5a3Br8dOjcCTHJBeN4ZPc=;
        b=rcJ7mH1MDd43qniZk0Zwreqw+rUfGLmMe9AgtCMJvf9YdvmggQQeOksxmq8xgLRq1P
         z/PehGnzH7drNBHNWDYAEC4obLa+xs0SKKQ69ae97yhw01foAYbJu6vSVf22P33e8bI9
         PEYF8AvqsAEgHJIQPbe3nwGkc//HgUzl88WmADrbKCXIFRXzNmIyYv71I3h4KGH692ss
         bjuqCU1gLiC11tCqvVreEHHzrujcwWzGVW9GdQgJdlQkVNVCBJMVUryv4VnVaP12MtlW
         iXIa8Yh3Y+IY6/iFegTfKPg6mAB41mBAq3kSVY+c/6STelzN3Kj/2n4BABCGZPcYWCyQ
         F7cg==
X-Gm-Message-State: AOJu0YyDQUT0zH3Nib7fX3s+DWo4a6i3sRcBrwILJ4zPmMd4cDPhn24z
	G6sEHiCdaQ6hItw5qI7e6nzQkTDnGAAcJ7C/DjhIMxnWtPRGX7zbG7wvThaJy3iMlzw2FgNnWM0
	eP8DfeQ==
X-Google-Smtp-Source: AGHT+IFQ/9k5IcLuUH1ZW2OAgFPb7odPNyQ95uYn9ZlymjoCUAgTWFaf+PxtMzyw87SmK1URBCeIdw==
X-Received: by 2002:a05:6512:308c:b0:52c:dac3:392b with SMTP id 2adb3069b0e04-53438785436mr5376214e87.33.1724570856187;
        Sun, 25 Aug 2024 00:27:36 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ec5c0a2sm1066101e87.202.2024.08.25.00.27.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 00:27:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f3edb2d908so34139511fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:27:35 -0700 (PDT)
X-Received: by 2002:a2e:a26c:0:b0:2ef:2f19:a8b3 with SMTP id
 38308e7fff4ca-2f4f49473cemr37530401fa.41.1724570853837; Sun, 25 Aug 2024
 00:27:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Aug 2024 19:27:16 +1200
X-Gmail-Original-Message-ID: <CAHk-=wh599movdAyCHfVmYakq8rqKQD9wCvUAgBqbF3znEu_2g@mail.gmail.com>
Message-ID: <CAHk-=wh599movdAyCHfVmYakq8rqKQD9wCvUAgBqbF3znEu_2g@mail.gmail.com>
Subject: Linux 6.11-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So I normally do the releases on a Sunday early afternoon, but I'm in
an unusual timezone, and that would have been almost a full day
earlier than usual. So I delayed things to the point where it was at
least Sunday back home, even if not even remotely afternoon.

Other than the timing, there's not a whole lot unusual here. The
diffstat looks fairly flat, which means "mostly pretty small changes".
There's a couple of bumps here and there, but nothing worrisome: the
biggest of them is in fact just a selftest update. The bulk of the
(non-selftest) patches are in drivers (networking and gpu dominating -
as is tradition), with some filesystem updates (bcachefs, but also smb
and erofs), and the rest being mostly core networking and some
architecture updates.

For details, see the appended shortlog, or just go dig even deeper in
the git tree itself.

So please do go forth and test, it all looks safe,

          Linus "famous last words" Torvalds

---

Abhinav Kumar (4):
      drm/msm/dp: fix the max supported bpp logic
      drm/msm/dpu: move dpu_encoder's connector assignment to atomic_enable()
      drm/msm/dp: reset the link phy params before link training
      drm/msm: fix the highest_bank_bit for sc7180

Alex Deucher (2):
      drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1
      drm/amdgpu: fix eGPU hotplug regression

Alexander Gordeev (4):
      s390/mm: Prevent lowcore vs identity mapping overlap
      s390/mm: Pin identity mapping base to zero
      s390/boot: Avoid possible physmem_info segment corruption
      s390/boot: Fix KASLR base offset off by __START_KERNEL bytes

Alexander Stein (1):
      pmdomain: imx: scu-pd: Remove duplicated clocks

Alexandra Winter (1):
      s390/iucv: Fix vargs handling in iucv_alloc_device()

Alexandre Courbot (1):
      Makefile: add $(srctree) to dependency of compile_commands.json target

Anders Roxell (1):
      scripts: kconfig: merge_config: config files: add a trailing newline

Andy Shevchenko (2):
      spi: pxa2xx: Do not override dev->platform_data on probe
      spi: pxa2xx: Move PM runtime handling to the glue drivers

Ashutosh Dixit (1):
      drm/xe/observation: Drop empty sysctl table entry

Bartosz Golaszewski (1):
      power: sequencing: request the WLAN enable GPIO as-is

Ben Whitten (1):
      mmc: dw_mmc: allow biu and ciu clocks to defer

Bharat Bhushan (1):
      octeontx2-af: Fix CPT AF register offset calculation

Bommu Krishnaiah (1):
      drm/xe/xe2lpg: Extend workaround 14021402888

Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Candice Li (1):
      drm/amdgpu: Validate TA binary size

Carlos Song (1):
      spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register

Carolina Jubran (1):
      net/mlx5e: XPS, Fix oversight of Multi-PF Netdev changes

Chaotian Jing (1):
      scsi: core: Fix the return value of scsi_logical_block_count()

Chen Ridong (1):
      cgroup/cpuset: fix panic caused by partcmd_update

ChenXiaoSong (5):
      smb/server: fix return value of smb2_open()
      smb/server: fix potential null-ptr-deref of lease_ctx_info in smb2_open()
      smb/server: remove useless assignment of 'file_present' in smb2_open()
      smb/server: update misguided comment of smb2_allocate_rsp_buf()
      smb/client: fix typo: GlobalMid_Sem -> GlobalMid_Lock

Chuck Lever (3):
      rpcrdma: Device kref is over-incremented on error from xa_alloc
      rpcrdma: Use XA_FLAGS_ALLOC instead of XA_FLAGS_ALLOC1
      rpcrdma: Trace connection registration and unregistration

Dan Carpenter (2):
      mmc: mmc_test: Fix NULL dereference on allocation failure
      dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()

Daniele Ceraolo Spurio (3):
      drm/xe: fix WA 14018094691
      drm/xe: use devm instead of drmm for managed bo
      drm/xe/uc: Use devm to register cleanup that includes exec_queues

Dave Airlie (1):
      nouveau/firmware: use dma non-coherent allocator

Dmitry Baryshkov (5):
      drm/msm/dpu: don't play tricks with debug macros
      drm/msm/dpu: cleanup FB if dpu_format_populate_layout fails
      drm/msm/dpu: limit QCM2290 to RGB formats only
      drm/msm/dpu: relax YUV requirements
      drm/msm/dpu: take plane rotation into account for wide planes

Dmitry Savin (1):
      HID: multitouch: Add support for GT7868Q

Dmitry Torokhov (2):
      Input: uinput - reject requests with unreasonable number of slots
      Input: himax_hx83112b - fix incorrect size when reading product ID

Dragos Tatulea (2):
      net/mlx5e: SHAMPO, Fix page leak
      net/mlx5e: SHAMPO, Release in progress headers

Eric Dumazet (4):
      netpoll: do not export netpoll_poll_[disable|enable]()
      ipv6: prevent UAF in ip6_send_skb()
      ipv6: fix possible UAF in ip6_finish_output2()
      ipv6: prevent possible UAF in ip6_xmit()

Felix Fietkau (1):
      udp: fix receiving fraglist GSO packets

Felix Kaechele (2):
      dt-bindings: input: touchscreen: edt-ft5x06: Document FT8201 support
      Input: edt-ft5x06 - add support for FocalTech FT8201

Florian Westphal (1):
      tcp: prevent concurrent execution of tcp_sk_exit_batch

Gao Xiang (2):
      erofs: allow large folios for compressed files
      erofs: fix out-of-bound access when z_erofs_gbuf_growsize()
partially fails

Geert Uytterhoeven (1):
      drm/xe/oa/uapi: Make bit masks unsigned

Griffin Kroah-Hartman (1):
      Bluetooth: MGMT: Add error handling to pair_device()

Hangbin Liu (2):
      selftests: udpgro: report error when receive failed
      selftests: udpgro: no need to load xdp for gro

Hans de Goede (3):
      ACPI: video: Add Dell UART backlight controller detection
      platform/x86: dell-uart-backlight: Use acpi_video_get_backlight_type()
      ACPI: video: Add backlight=native quirk for Dell OptiPlex 7760 AIO

Harald Freudenberger (1):
      s390/ap: Refine AP bus bindings complete processing

Hongzhen Luo (2):
      erofs: simplify readdir operation
      erofs: get rid of check_layout_compatibility()

Ido Schimmel (1):
      selftests: mlxsw: ethtool_lanes: Source ethtool lib from correct path

Jakub Kicinski (1):
      MAINTAINERS: add selftests to network drivers

Jason Gerecke (1):
      HID: wacom: Defer calculation of resolution until resolution_code is known

Javier Carrasco (1):
      Documentation/llvm: turn make command for ccache into code block

Jeff Layton (2):
      nfs: fix the fetch of FATTR4_OPEN_ARGUMENTS
      nfs: fix bitmap decoder to handle a 3rd word

Jens Axboe (1):
      io_uring/kbuf: sanitize peek buffer setup

Jeremy Kerr (1):
      net: mctp: test: Use correct skb for route input check

Jiaxun Yang (2):
      MIPS: Loongson64: Set timer mode in cpu-probe
      MIPS: cevt-r4k: Don't call get_c0_compare_int if timer irq is installed

Jinjie Ruan (1):
      iommufd/selftest: Make dirty_ops static

Jiri Pirko (1):
      virtio_net: move netdev_tx_reset_queue() call before RX napi enable

John Garry (2):
      block: Read max write zeroes once for __blkdev_issue_write_zeroes()
      block: Drop NULL check in bdev_write_zeroes_sectors()

John Keeping (1):
      Input: adc-joystick - fix optional value handling

Jonathan Denose (1):
      Input: synaptics - enable SMBus for HP Elitebook 840 G2

Joseph Huang (1):
      net: dsa: mv88e6xxx: Fix out-of-bound access

Kent Overstreet (27):
      bcachefs: Reallocate table when we're increasing size
      bcachefs: fix field-spanning write warning
      bcachefs: Fix incorrect gfp flags
      bcachefs: Extra debug for data move path
      bcachefs: bch2_data_update_init() cleanup
      bcachefs: Fix "trying to move an extent, but nr_replicas=0"
      bcachefs: setting bcachefs_effective.* xattrs is a noop
      bcachefs: Fix failure to relock in btree_node_get()
      bcachefs: Fix bch2_trigger_alloc assert
      bcachefs: Fix bch2_bucket_gens_init()
      bcachefs: fix time_stats_to_text()
      bcachefs: fix missing bch2_err_str()
      bcachefs: unlock_long() before resort in journal replay
      bcachefs: fix failure to relock in bch2_btree_node_mem_alloc()
      bcachefs: fix failure to relock in btree_node_fill()
      bcachefs: Fix locking in bch2_ioc_setlabel()
      bcachefs: Fix replay_now_at() assert
      bcachefs: Fix missing validation in bch2_sb_journal_v2_validate()
      fs/super.c: improve get_tree() error message
      bcachefs: Fix warning in bch2_fs_journal_stop()
      bcachefs: Fix compat issue with old alloc_v4 keys
      bcachefs: Fix refcounting in discard path
      bcachefs: clear path->should_be_locked in bch2_btree_key_cache_drop()
      bcachefs: add missing inode_walker_exit()
      bcachefs: don't use rht_bucket() in btree_key_cache_scan()
      bcachefs: Fix failure to flush moves before sleeping in copygc
      bcachefs: Fix rebalance_work accounting

Krzysztof Kozlowski (3):
      thermal: of: Fix OF node leak in thermal_of_trips_init() error path
      thermal: of: Fix OF node leak in thermal_of_zone_register()
      thermal: of: Fix OF node leak in of_thermal_zone_find() error paths

Kuniyuki Iwashima (1):
      kcm: Serialise kcm_sendmsg() for the same socket.

Lai Jiangshan (1):
      workqueue: Remove incorrect
"WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker

Li Ming (2):
      cxl/pci: Get AER capability address from RCRB only for RCH dport
      cxl/test: Skip cxl_setup_parent_dport() for emulated dports

Linus Torvalds (1):
      Linux 6.11-rc5

Lucas De Marchi (1):
      drm/xe: Fix opregion leak

Luiz Augusto von Dentz (3):
      Bluetooth: HCI: Invert LE State quirk to be opt-out rather then opt-in
      Bluetooth: hci_core: Fix LE quote calculation
      Bluetooth: SMP: Fix assumption of Central always being Initiator

Luke D. Jones (2):
      hid-asus: add ROG Ally X prod ID to quirk list
      platform/x86: asus-wmi: Add quirk for ROG Ally X

Maarten Lankhorst (1):
      drm/xe/display: Make display suspend/resume work on discrete

Maciej Fijalkowski (3):
      ice: fix page reuse when PAGE_SIZE is over 8k
      ice: fix ICE_LAST_OFFSET formula
      ice: fix truesize operations for PAGE_SIZE >= 8192

Manivannan Sadhasivam (2):
      scsi: ufs: core: Add a quirk for handling broken LSDBS field in
controller capabilities register
      scsi: ufs: qcom: Add UFSHCD_QUIRK_BROKEN_LSDBS_CAP for SM8550 SoC

Marc Zyngier (2):
      KVM: arm64: vgic: Don't hold config_lock while unregistering
redistributors
      KVM: arm64: Make ICC_*SGI*_EL1 undef in the absence of a vGICv3

Marek Vasut (1):
      Input: ads7846 - ratelimit the spi_sync error message

Martin K. Petersen (1):
      scsi: sd: Do not attempt to configure discard unless LBPME is set

Martin Whitaker (1):
      net: dsa: microchip: fix PTP config failure when using multiple ports

Masahiro Yamada (4):
      kbuild: clean up code duplication in cmd_fdtoverlay
      treewide: remove unnecessary <linux/version.h> inclusion
      kbuild: avoid scripts/kallsyms parsing /dev/null
      kbuild: fix typos "prequisites" to "prerequisites"

Matthew Auld (2):
      drm/xe: prevent UAF around preempt fence
      drm/xe/bmg: implement Wa_16023588340

Matthew Brost (4):
      drm/xe: Move VM dma-resv lock from xe_exec_queue_create to
__xe_exec_queue_init
      drm/xe: Fix tile fini sequence
      drm/xe: Drop HW fence pointer to HW fence ctx
      drm/xe: Free job before xe_exec_queue_put

Matthieu Baerts (NGI0) (14):
      mptcp: pm: re-using ID of unused removed ADD_ADDR
      selftests: mptcp: join: check re-using ID of unused ADD_ADDR
      mptcp: pm: re-using ID of unused removed subflows
      selftests: mptcp: join: check re-using ID of closed subflow
      mptcp: pm: re-using ID of unused flushed subflows
      selftests: mptcp: join: test for flush/re-add endpoints
      mptcp: pm: remove mptcp_pm_remove_subflow()
      mptcp: pm: only mark 'subflow' endp as available
      mptcp: pm: only decrement add_addr_accepted for MPJ req
      mptcp: pm: check add_addr_accept_max before accepting new ADD_ADDR
      mptcp: pm: only in-kernel cannot have entries with ID 0
      mptcp: pm: fullmesh: select the right ID later
      selftests: mptcp: join: validate fullmesh endp on 1st sf
      mptcp: pm: avoid possible UaF when selecting endp

Maximilian Luz (6):
      platform/surface: aggregator_registry: Add Support for Surface Pro 10
      platform/surface: aggregator_registry: Add support for Surface Laptop Go 3
      platform/surface: aggregator_registry: Add support for Surface
Laptop Studio 2
      platform/surface: aggregator_registry: Add fan and thermal
sensor support for Surface Laptop 5
      platform/surface: aggregator_registry: Add support for Surface Laptop 6
      platform/surface: aggregator: Fix warning when controller is
destroyed in probe

Menglong Dong (1):
      net: ovs: fix ovs_drop_reasons error

Mengqi Zhang (1):
      mmc: mtk-sd: receive cmd8 data when hs400 tuning fail

Mengyuan Lou (1):
      net: ngbe: Fix phy mode set to external phy

Michael Ellerman (2):
      ata: pata_macio: Fix DMA table overflow
      ata: pata_macio: Use WARN instead of BUG

Michal Swiatkowski (1):
      ice: use internal pf id instead of function number

Ming Lei (1):
      nvme: move stopping keep-alive into nvme_uninit_ctrl()

Namjae Jeon (3):
      ksmbd: Use unsafe_memcpy() for ntlm_negotiate
      ksmbd: fix race condition between destroy_previous_session() and
smb2 operations()
      ksmbd: the buffer of smb2 query dir response has at least 1 byte

Ngai-Mint Kwan (1):
      drm/xe/xe2lpm: Extend Wa_16021639441

Nicolin Chen (1):
      iommufd/device: Fix hwpt at err_unresv in iommufd_device_do_replace()

Nikita Shubin (1):
      workqueue: doc: Fix function name, remove markers

Nikolay Aleksandrov (4):
      bonding: fix bond_ipsec_offload_ok return type
      bonding: fix null pointer deref in bond_ipsec_offload_ok
      bonding: fix xfrm real_dev null pointer dereference
      bonding: fix xfrm state handling when clearing active slave

Nikolay Kuratov (1):
      cxgb4: add forgotten u64 ivlan cast before shift

Nilay Shroff (1):
      nvme: Remove unused field

Oliver Upton (1):
      KVM: arm64: Ensure canonical IPA is hugepage-aligned when handling fault

Olivier Sobrie (1):
      HID: amd_sfh: free driver_data after destroying hid device

Pablo Neira Ayuso (1):
      netfilter: flowtable: validate vlan header

Paolo Abeni (1):
      igb: cope with large MAX_SKB_FRAGS

Patrisious Haddad (1):
      net/mlx5: Fix IPsec RoCE MPV trace call

Paulo Alcantara (1):
      smb: client: ignore unhandled reparse tags

Pavan Chebbi (1):
      bnxt_en: Don't clear ntuple filters and rss contexts during ethtool ops

Peng Fan (1):
      pmdomain: imx: wait SSAR when i.MX93 power domain on

Rob Clark (1):
      drm/msm/adreno: Fix error return if missing firmware-name

Ryo Takakura (1):
      printk/panic: Allow cpu backtraces to be written into ringbuffer
during panic

Sava Jakovljev (1):
      net: phy: realtek: Fix setting of PHY LEDs Mode B bit on RTL8211F

Sean Anderson (3):
      spi: zynqmp-gqspi: Scale timeout by data size
      net: xilinx: axienet: Always disable promiscuous mode
      net: xilinx: axienet: Fix dangling multicast addresses

Sebastian Andrzej Siewior (2):
      netfilter: nft_counter: Disable BH in nft_counter_offload_stats().
      netfilter: nft_counter: Synchronize nft_counter_reset() against reader.

Simon Horman (7):
      tc-testing: don't access non-existent variable on exception
      scsi: MAINTAINERS: Add header files to SCSI SUBSYSTEM
      MAINTAINERS: Add sonet.h to ATM section of MAINTAINERS
      MAINTAINERS: Add net_tstamp.h to SOCKET TIMESTAMPING section
      MAINTAINERS: Add limited globs for Networking headers
      MAINTAINERS: Add header files to NETWORKING sections
      MAINTAINERS: Mark JME Network Driver as Odd Fixes

Somnath Kotur (1):
      bnxt_en: Fix double DMA unmapping for XDP_REDIRECT

Srinivas Pandruvada (1):
      platform/x86: ISST: Fix return value on last invalid resource

Stephen Hemminger (1):
      netem: fix return value if duplicate enqueue fails

Steve French (2):
      smb3: fix broken cached reads when posix locks
      smb3: fix problem unloading module due to leaked refcount on shutdown

Stuart Summers (1):
      drm/xe: Fix missing workqueue destroy in xe_gt_pagefault

Suraj Kandpal (1):
      drm/i915/hdcp: Use correct cp_irq_count

Takashi Iwai (1):
      Input: i8042 - add Fujitsu Lifebook E756 to i8042 quirk table

Tejas Upadhyay (3):
      drm/xe/xe2: Make subsequent L2 flush sequential
      drm/xe/xe2: Add Wa_15015404425
      drm/xe/xe2hpg: Add Wa_14021821874

Tejun Heo (1):
      workqueue: Fix spruious data race in __flush_work()

Thomas Bogendoerfer (1):
      ip6_tunnel: Fix broken GRO

Thorsten Blum (1):
      ksmbd: Replace one-element arrays with flexible-array members

Trond Myklebust (3):
      NFSv4: Add missing rescheduling points in
nfs_client_return_marked_delegations
      NFSv4: Fix clearing of layout segments in layoutreturn
      NFS: Avoid unnecessary rescanning of the per-server delegation list

Uros Bizjak (1):
      workqueue: Correct declaration of cpu_pwq in struct workqueue_struct

Victor Timofei (1):
      ksmbd: fix spelling mistakes in documentation

Vignesh Raghavendra (1):
      spi: spi-cadence-quadspi: Fix OSPI NOR failures during system resume

Vladimir Oltean (14):
      selftests: net: local_termination: refactor macvlan creation/deletion
      selftests: net: local_termination: parameterize sending interface
      selftests: net: local_termination: parameterize test name
      selftests: net: local_termination: add one more test for
VLAN-aware bridges
      selftests: net: local_termination: introduce new tests which
capture VLAN behavior
      selftests: net: local_termination: don't use xfail_on_veth()
      selftests: net: local_termination: add PTP frames to the mix
      selftests: net: bridge_vlan_aware: test that other TPIDs are
seen as untagged
      net: mscc: ocelot: use ocelot_xmit_get_vlan_info() also for FDMA
and register injection
      net: mscc: ocelot: fix QoS class for injected packets with "ocelot-8021q"
      net: mscc: ocelot: serialize access to the injection/extraction groups
      net: dsa: provide a software untagging function on RX for
VLAN-aware bridges
      net: dsa: felix: fix VLAN tag loss on CPU reception with ocelot-8021q
      net: mscc: ocelot: treat 802.1ad tagged traffic as 802.1Q-untagged

Waiman Long (2):
      cgroup/cpuset: Clear effective_xcpus on cpus_allowed clearing
only if cpus.exclusive not set
      cgroup/cpuset: Eliminate unncessary sched domains rebuilds in hotplug

Werner Sembach (2):
      Input: i8042 - add forcenorestore quirk to leave controller
untouched even on s3
      Input: i8042 - use new forcenorestore quirk to replace old buggy
quirk combination

Will Deacon (1):
      workqueue: Fix UBSAN 'subtraction overflow' error in shift_and_mask()

Yang Ruibin (1):
      thermal/debugfs: Fix the NULL vs IS_ERR() confusion in
debugfs_create_dir()

Yang Wang (1):
      drm/amdgpu: fixing rlc firmware loading failure issue

Yihang Li (1):
      scsi: MAINTAINERS: Update HiSilicon SAS controller driver maintainer

Yuesong Li (1):
      bcachefs: Fix double assignment in check_dirent_to_subvol()

Zenghui Yu (1):
      KVM: arm64: vgic-debug: Don't put unmarked LPIs

