Return-Path: <linux-kernel+bounces-373492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9289A575F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 00:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7D4281F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46686198A01;
	Sun, 20 Oct 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X9B7CAqP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97CD15E90
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 22:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729464240; cv=none; b=szPwCoeerVvl1v6SSVyeboug1a8qITFBznqwwp8am8Wpcs4Rij+R/+jtdA5omtyG7K53rBhtkEBX3mv0T/hvDdkqyuqtlYVzJ5Liy5mM8Wb34iavzhGRQKKZ9aw8nMpJC7UCLOnxlqxv8ClKh76PwvyqQwnUhM6VpCNINszcjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729464240; c=relaxed/simple;
	bh=ik+ifMLnGfB8POH+I8VX5fQXVWpHYkxL2voUbJGxiq0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fboXa1tkL3dnEIP/NK2lGjkiA8SutDNHCyy0gYSKZQhFZK7C1qh5gTN5lQFAnarcEYrrNM9/4eZB/0kXlCV5fVOcq+wZTNq7nwzSHRnnnPMEYTsM8dRvqKOiDJ9aSkIKwbNBss0E+eJ6WsChaovoZvi6q+GReezKx+I4nWlLhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X9B7CAqP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d51055097so2687804f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729464235; x=1730069035; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=omzDGdVt6153YkTezoECOWeS2FyQScNhWP3iB/X+xPw=;
        b=X9B7CAqPRerhxlQAat2T3zkHmd0BLtFsPZVF2mX/DIXhqtV2cHm9f8g5kJm8nzh9fP
         XkRzE8tJhntq7MX44VWYGrUY8+vRzKBDlu0H/7XcOtcUCKhouAgNsFAW7FkhfK+4VR++
         9ueHMb80QYOEZfXbsD6d9AcUCcIBPubWxgLGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729464235; x=1730069035;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omzDGdVt6153YkTezoECOWeS2FyQScNhWP3iB/X+xPw=;
        b=W5CR6VKz7OZX0L4bo5kGRsCI0xIwbA8gXQvFxOwfrTUk3pwbpaI98N91NZXhsEHJ/B
         W7JSty2GB/dtOwvp1ANy4AYTwuDAHVwDjMRAmBLzl6CfRJG1m/M4cbW0vnI/vchEaysv
         lsO4OZJ02punKQY7HPI8iQAgH25WBEK/FY5WzpxbslEr6RmTcJjc1ss+NzBeh8C+aFJh
         UyOuklgfKlk6QGFTTuXJvc2t8H6/0k3jvrY6fn6BToK2O2raFkxlToEHpmROZ84B0zdZ
         gXDy3zl+G/0aCqMLELcwBLrU3ROM14xzuj+TXkEEDrpuYvFGRE10OHRyMFXi3GYenaXd
         IWkQ==
X-Gm-Message-State: AOJu0Yw/2HadPJMJYXibEH3KrCWiKcNx6YOhEv+Y/npq5UX3ANZ7SSq3
	AA7EHPS+C9L+Lbnc1EHOlt78Xd/gxG69JEmF2EgDwS10U3IXzc8fAalyaXVt9bIRFbT6AwuuQ++
	RXhYZwQ==
X-Google-Smtp-Source: AGHT+IHtGW5Zf9qboUyKkdzsmnS5iIrG0MRRmyKlQMvNtlDHIHSfxCphBOXdJjDhg6NaMtLmdXOviQ==
X-Received: by 2002:a5d:4e49:0:b0:37d:3301:9891 with SMTP id ffacd0b85a97d-37ea2164d8bmr6101841f8f.17.1729464234280;
        Sun, 20 Oct 2024 15:43:54 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725dfsm1283791a12.81.2024.10.20.15.43.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 15:43:53 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a628b68a7so475644566b.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 15:43:52 -0700 (PDT)
X-Received: by 2002:a17:907:728b:b0:a99:e5d5:5654 with SMTP id
 a640c23a62f3a-a9a69773f30mr1066292466b.6.1729464231189; Sun, 20 Oct 2024
 15:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 20 Oct 2024 15:43:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4OfH8kHmsss97bRvUo=GUEcRSGTYFwqNUL-8x_h-ROA@mail.gmail.com>
Message-ID: <CAHk-=wi4OfH8kHmsss97bRvUo=GUEcRSGTYFwqNUL-8x_h-ROA@mail.gmail.com>
Subject: Linux 6.12-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm. I'm not happy with how big this is - it's probably far from the
biggest rc4 ever, but it _is_ the biggest rc4 we've had in the 6.x
series at least in number of commits.

Yeah, yeah, it's quite likely to be due to just random timing of pull
requests, where things have just happened to bunch up. Last week, rc3
was on the smaller side, so maybe that's all it is. But still, it
doesn't give me the warm and fuzzies. Let's hope next week is calm.

That said, while we have a fair number of commits in here, I don't
think there is anything _particularly_ scary going on. A lot of it
really is just very small fixes, and the diffstat shows a lot of one-
and few-liners (but there are certainly bigger things going on too -
it's not *all* those).

The changes are all over, with about a third being drivers (GPU and
networking as always, but there really is a bit of everything in
there). The rest is filesystems (bcachefs dominates, but smb and xfs
show up too), some core kernel (scheduler, networking, bpf, tracing),
and the usual random smattering all over (bpf settests show up, for
example, some doc fixes, some arch fixes). Shortlog appended as
always.

Please give it a whirl,

             Linus

---

Aaron Thompson (3):
      Bluetooth: ISO: Fix multiple init when debugfs is disabled
      Bluetooth: Call iso_exit() on module unload
      Bluetooth: Remove debugfs directory on module init failure

Abhishek Mohapatra (1):
      RDMA/bnxt_re: Fix the max CQ WQEs for older adapters

Advait Dhamorikar (1):
      smb/client: Fix logically dead code

Alan Huang (2):
      bcachefs: Release transaction before wake up
      bcachefs: Fix state lock involved deadlock

Alan Stern (1):
      USB: gadget: dummy-hcd: Fix "task hung" problem

Alessandro Zanni (2):
      selftests: net/rds: add module not found
      selftests: drivers: net: fix name not defined

Alex Deucher (4):
      drm/amdgpu: enable enforce_isolation sysfs node on VFs
      drm/amdgpu/smu13: always apply the powersave optimization
      drm/amdgpu/swsmu: Only force workload setup on init
      drm/amdgpu/swsmu: default to fullscreen 3D profile for dGPUs

Alexander Sverdlin (2):
      dmaengine: cirrus: ERR_CAST() ioremap error
      dmaengine: cirrus: check that output may be truncated

Alexander Zubkov (1):
      RDMA/irdma: Fix misspelling of "accept*"

Alice Ryhl (2):
      kbuild: fix issues with rustc-option
      cfi: fix conditions for HAVE_CFI_ICALL_NORMALIZE_INTEGERS

Andrea Parri (1):
      riscv, bpf: Make BPF_CMPXCHG fully ordered

Andrew Jones (1):
      irqchip/riscv-imsic: Fix output text of base address

Andrey Konovalov (2):
      MAINTAINERS: usb: raw-gadget: add bug tracker link
      MAINTAINERS: kasan, kcov: add bugzilla links

Andrii Nakryiko (1):
      lib/buildid: Handle memfd_secret() files in build_id_parse()

Andy Chiu (1):
      mailmap: add an entry for Andy Chiu

Andy Shevchenko (2):
      pinctrl: intel: platform: Add Panther Lake to the list of supported
      mm: remove unused stub for can_swapin_thp()

Anumula Murali Mohan Reddy (2):
      RDMA/core: Fix ENODEV error for iWARP test over vlan
      RDMA/cxgb4: Fix RDMA_CM_EVENT_UNREACHABLE error for iWARP

Aradhya Bhatia (1):
      drm/xe/xe2lpg: Extend Wa_15016589081 for xe2lpg

Arnd Bergmann (1):
      firmware: arm_ffa: Avoid string-fortify warning in export_uuid()

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo, ASUS, Dell projects

Baolin Wang (1):
      mm: khugepaged: fix the incorrect statistics when collapsing
large file folios

Bart Van Assche (1):
      RDMA/srpt: Make slab cache names unique

Basavaraj Natikar (1):
      HID: amd_sfh: Switch to device-managed dmam_alloc_coherent()

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Bhargava Chenna Marreddy (1):
      RDMA/bnxt_re: Fix a bug while setting up Level-2 PBL pages

Bj=C3=B6rn T=C3=B6pel (1):
      selftests: sched_ext: Add sched_ext as proper selftest target

Brahmajit Das (1):
      fs/proc: fix build with GCC 15 due to
-Werror=3Dunterminated-string-initialization

Breno Leitao (2):
      elevator: do not request_module if elevator exists
      elevator: Remove argument from elevator_find_get

Chandramohan Akula (1):
      RDMA/bnxt_re: Change the sequence of updating the CQ toggle value

Changhuang Liang (1):
      reset: starfive: jh71x0: Fix accessing the empty member on JH7110 SoC

Charlie Jenkins (1):
      irqchip/sifive-plic: Return error code on failure

Chen Ni (1):
      iommu/arm-smmu-v3: Convert comma to semicolon

Chen Yu (1):
      sched/eevdf: Fix wakeup-preempt by checking cfs_rq->nr_running

Christian Heusel (1):
      btrfs: send: cleanup unneeded return variable in changed_verity()

Christoph Hellwig (10):
      iomap: factor out a iomap_last_written_block helper
      iomap: remove iomap_file_buffered_write_punch_delalloc
      iomap: move locking out of iomap_write_delalloc_release
      xfs: factor out a xfs_file_write_zero_eof helper
      xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
      xfs: IOMAP_ZERO and IOMAP_UNSHARE already hold invalidate_lock
      xfs: support the COW fork in xfs_bmap_punch_delalloc_range
      xfs: share more code in xfs_buffered_write_iomap_begin
      xfs: set IOMAP_F_SHARED for all COW fork allocations
      xfs: punch delalloc extents from the COW fork for COW writes

Christophe JAILLET (1):
      iio: hid-sensors: Fix an error handling path in
_hid_sensor_set_report_latency()

Colin Ian King (1):
      octeontx2-af: Fix potential integer overflows on integer shifts

Cong Yang (1):
      drm/panel: himax-hx83102: Adjust power and gamma to optimize brightne=
ss

Cosmin Ratiu (4):
      net/mlx5: HWS, don't destroy more bwc queue locks than allocated
      net/mlx5: HWS, use lock classes for bwc locks
      net/mlx5: Unregister notifier on eswitch init failure
      net/mlx5e: Don't call cleanup on profile rollback failure

Dan Carpenter (2):
      iio: bmi323: fix copy and paste bugs in suspend resume
      iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume(=
)

Daniel Borkmann (5):
      bpf: Sync uapi bpf.h header to tools directory
      vmxnet3: Fix packet corruption in vmxnet3_xdp_xmit_frame
      bpf: Fix incorrect delta propagation between linked registers
      bpf: Fix print_reg_state's constant scalar dump
      selftests/bpf: Add test case for delta propagation

Daniel Machon (1):
      net: sparx5: fix source port register when mirroring

Daniel Mentz (1):
      iommu/arm-smmu-v3: Fix last_sid_idx calculation for sid_bits=3D=3D32

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Darrick J. Wong (1):
      xfs: fix integer overflow in xrep_bmap

David Hildenbrand (1):
      mm: don't install PMD mappings when THPs are disabled by the
hw/process/vma

David Howells (1):
      9p: Enable multipage folios

David Lechner (1):
      iio: adc: ad4695: Add missing Kconfig select

David Vernet (1):
      sched_ext: Remove unnecessary cpu_relax()

Dhananjay Ugwekar (1):
      cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory syste=
ms

Dimitar Kanaliev (3):
      bpf: Fix truncation bug in coerce_reg_to_size_sx()
      selftests/bpf: Add test for truncation after sign extension in
coerce_reg_to_size_sx()
      selftests/bpf: Add test for sign extension in coerce_subreg_to_size_s=
x()

Dmitry Baryshkov (4):
      drm/msm/dpu: make sure phys resources are properly initialized
      drm/msm/dpu: move CRTC resource assignment to
dpu_encoder_virt_atomic_check
      drm/msm/dpu: check for overflow in _dpu_crtc_setup_lm_bounds()
      drm/msm/hdmi: drop pll_cmp_to_fdata from hdmi_phy_8998

Dominique Martinet (1):
      9p: v9fs_fid_find: also lookup by inode if not found dentry

Douglas Anderson (2):
      drm/msm: Avoid NULL dereference in msm_disp_state_print_regs()
      drm/msm: Allocate memory for disp snapshot with kvzalloc()

Dr. David Alan Gilbert (2):
      drbd: Remove unused conn_lowest_minor
      cifs: Remove unused functions

Eduard Zingerman (2):
      bpf: sync_linked_regs() must preserve subreg_def
      selftests/bpf: Verify that sync_linked_regs preserves subreg_def

Edward Liaw (2):
      selftests/mm: replace atomic_bool with pthread_barrier_t
      selftests/mm: fix deadlock for fork after pthread_create on ARM

Emil Gedenryd (1):
      iio: light: opt3001: add missing full-scale range value

Eric Dumazet (2):
      netdevsim: use cond_resched() in nsim_dev_trap_report_work()
      genetlink: hold RCU in genlmsg_mcast()

Fabrizio Castro (1):
      irqchip/renesas-rzg2l: Fix missing put_device

Fan Wu (1):
      MAINTAINERS: update IPE tree url and Fan Wu's email

Felix Fietkau (1):
      net: ethernet: mtk_eth_soc: fix memory corruption during fq dma init

Filipe Manana (1):
      btrfs: use sector numbers as keys for the dirty extents xarray

Florian Fainelli (1):
      firmware: arm_scmi: Give SMC transport precedence over mailbox

Florian Kauer (2):
      bpf: devmap: provide rxq after redirect
      bpf: selftests: send packet to devmap redirect XDP

Florian Klink (1):
      ARM: dts: bcm2837-rpi-cm3-io3: Fix HDMI hpd-gpio pin

Florian Westphal (1):
      lib: alloc_tag_module_unload must wait for pending kfree_rcu calls

Gao Xiang (3):
      erofs: ensure regular inodes for file-backed mounts
      erofs: get rid of z_erofs_try_to_claim_pcluster()
      erofs: get rid of kaddr in `struct z_erofs_maprecorder`

Gary Guo (1):
      kbuild: rust: add `CONFIG_RUSTC_LLVM_VERSION`

Gavin Shan (1):
      firmware: arm_ffa: Avoid string-fortify warning caused by memcpy()

Geert Uytterhoeven (1):
      soc: fsl: cpm1: qmc: Do not use IS_ERR_VALUE() on error pointers

Greg Joyce (1):
      nvme: disable CC.CRIME (NVME_CC_CRIME)

Greg Kroah-Hartman (1):
      MAINTAINERS: Remove some entries due to various compliance requiremen=
ts.

Guixin Liu (1):
      nvmet-rdma: use sbitmap to replace rsp free list

Hannes Reinecke (1):
      nvme: tcp: avoid race between queue_lock lock and destroy

Harald Freudenberger (1):
      s390/ap: Fix CCA crypto card behavior within protected execution
environment

Harshit Mogalapalli (2):
      pinctrl: sophgo: fix double free in cv1800_pctrl_dt_node_to_map()
      pinctrl: nuvoton: fix a double free in ma35_pinctrl_dt_node_to_map_fu=
nc()

Heiko Carstens (2):
      s390: Initialize psw mask in perf_arch_fetch_caller_regs()
      s390: Update defconfigs

Heiko Thiery (2):
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for
EEPROM device
      misc: microchip: pci1xxxx: add support for NVMEM_DEVID_AUTO for OTP d=
evice

Henry Lin (1):
      xhci: tegra: fix checked USB2 port number

Herbert Xu (3):
      crypto: api - Fix liveliness check in crypto_alg_tested
      crypto: testmgr - Hide ENOENT errors better
      crypto: marvell/cesa - Disable hash algorithms

Herve Codina (1):
      soc: fsl: cpm1: qmc: Fix unused data compilation warning

Holger Dengler (1):
      s390/pkey_pckmo: Return with success for valid protected key types

Honglei Wang (1):
      sched_ext: use correct function name in pick_task_scx() warning messa=
ge

Hou Tao (2):
      bpf: Check the remaining info_cnt before repeating btf fields
      selftests/bpf: Add more test case for field flattening

Ian Forbes (2):
      drm/vmwgfx: Limit display layout ioctl array size to
VMWGFX_NUM_DISPLAY_UNITS
      drm/vmwgfx: Handle possible ENOMEM in vmw_stdu_connector_atomic_check

Imre Deak (2):
      drm/i915/dp_mst: Handle error during DSC BW overhead/slice calculatio=
n
      drm/i915/dp_mst: Don't require DSC hblank quirk for a non-DSC
compatible mode

Jaegeuk Kim (1):
      f2fs: allow parallel DIO reads

Jakub Kicinski (1):
      MAINTAINERS: add Andrew Lunn as a co-maintainer of all networking dri=
vers

Jakub Sitnicki (1):
      udp: Compute L4 checksum as usual when not segmenting the skb

Jann Horn (2):
      mm/mremap: fix move_normal_pmd/retract_page_tables race
      MAINTAINERS: add Jann as memory mapping/VMA reviewer

Jason Gerecke (1):
      HID: wacom: Hardcode (non-inverted) AES pens as BTN_TOOL_PEN

Javier Carrasco (26):
      iio: light: veml6030: fix IIO device retrieval from embedded device
      iio: light: veml6030: fix ALS sensor resolution
      pinctrl: intel: platform: fix error path in device_for_each_child_nod=
e()
      pinctrl: intel: platform: use semicolon instead of comma in
ncommunities assignment
      iio: accel: kx022a: add missing select IIO_(TRIGGERED_)BUFFER in Kcon=
fig
      iio: adc: ad7944: add missing select IIO_(TRIGGERED_)BUFFER in Kconfi=
g
      iio: adc: ti-ads124s08: add missing select
IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: adc: ti-lmp92064: add missing select REGMAP_SPI in Kconfig
      iio: adc: ti-lmp92064: add missing select IIO_(TRIGGERED_)BUFFER
in Kconfig
      iio: dac: ad3552r: add missing select IIO_(TRIGGERED_)BUFFER in Kconf=
ig
      iio: dac: ad5766: add missing select IIO_(TRIGGERED_)BUFFER in Kconfi=
g
      iio: chemical: ens160: add missing select IIO_(TRIGGERED_)BUFFER
in Kconfig
      iio: light: bu27008: add missing select IIO_(TRIGGERED_)BUFFER in Kco=
nfig
      iio: magnetometer: af8133j: add missing select
IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: pressure: bm1390: add missing select IIO_(TRIGGERED_)BUFFER
in Kconfig
      iio: proximity: mb1232: add missing select
IIO_(TRIGGERED_)BUFFER in Kconfig
      iio: resolver: ad2s1210 add missing select REGMAP in Kconfig
      iio: resolver: ad2s1210: add missing select (TRIGGERED_)BUFFER in Kco=
nfig
      iio: frequency: adf4377: add missing select REMAP_SPI in Kconfig
      iio: amplifiers: ada4250: add missing select REGMAP_SPI in Kconfig
      iio: dac: ad5770r: add missing select REGMAP_SPI in Kconfig
      iio: dac: ltc1660: add missing select REGMAP_SPI in Kconfig
      iio: dac: stm32-dac-core: add missing select REGMAP_MMIO in Kconfig
      iio: adc: ti-ads8688: add missing select IIO_(TRIGGERED_)BUFFER in Kc=
onfig
      iio: frequency: {admv4420,adrf6780}: format Kconfig entries
      iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig

Jean Delvare (1):
      [PATCH} hwmon: (jc42) Properly detect TSE2004-compliant devices again

Jens Axboe (4):
      io_uring/sqpoll: close race on waiting for sqring entries
      io_uring/rsrc: ignore dummy_ubuf for buffer cloning
      io_uring/sqpoll: ensure task state is TASK_RUNNING when running task_=
work
      io_uring/rw: fix wrong NOWAIT check in io_rw_init_file()

Jeongjun Park (2):
      vt: prevent kernel-infoleak in con_font_get()
      mm: swap: prevent possible data-race in __try_to_reclaim_swap

Jessica Zhang (2):
      drm/msm/dpu: Don't always set merge_3d pending flush
      drm/msm/dpu: don't always program merge_3d block

Jim Mattson (1):
      x86/cpufeatures: Define X86_FEATURE_AMD_IBPB_RET

Jinjie Ruan (6):
      clk: samsung: Fix out-of-bound access of of_match_node()
      posix-clock: Fix missing timespec64 check in pc_clock_settime()
      net: lan743x: Remove duplicate check
      net: microchip: vcap api: Fix memory leaks in vcap_api_encode_rule_te=
st()
      clk: test: Fix some memory leaks
      mm/damon/tests/sysfs-kunit.h: fix memory leak in
damon_sysfs_test_add_targets()

Jiqian Chen (1):
      xen: Remove dependency between pciback and privcmd

Jiri Olsa (1):
      bpf: Fix memory leak in bpf_core_apply

Joey Gouly (2):
      arm64: set POR_EL0 for kernel threads
      Documentation/protection-keys: add AArch64 to documentation

Johan Hovold (9):
      serial: qcom-geni: fix polled console initialisation
      serial: qcom-geni: revert broken hibernation support
      serial: qcom-geni: fix shutdown race
      serial: qcom-geni: fix dma rx cancellation
      serial: qcom-geni: fix receiver enable
      serial: qcom-geni: fix rx cancel dma status bit
      serial: qcom-geni: drop flip buffer WARN()
      serial: qcom-geni: drop unused receive parameter
      serial: qcom-geni: rename suspend functions

Johannes Weiner (1):
      sched/psi: Fix mistaken CPU pressure indication after corrupted
task state bug

Johannes Wikner (4):
      x86/cpufeatures: Add a IBPB_NO_RET BUG flag
      x86/entry: Have entry_ibpb() invalidate return predictions
      x86/bugs: Skip RSB fill at VMEXIT
      x86/bugs: Do not use UNTRAIN_RET with IBPB on entry

John Allen (1):
      x86/CPU/AMD: Only apply Zenbleed fix for Zen2 during late microcode l=
oad

John Edwards (1):
      Input: xpad - add support for MSI Claw A1M

Jon Hunter (1):
      gpu: host1x: Fix boot regression for Tegra

Jonathan Cameron (1):
      iio: pressure: sdp500: Add missing select CRC8

Jonathan Marek (3):
      drm/msm/dsi: improve/fix dsc pclk calculation
      drm/msm/dsi: fix 32-bit signed integer extension in pclk_rate calcula=
tion
      usb: typec: qcom-pmic-typec: fix sink status being overwritten with R=
P_DEF

Jordan Rome (2):
      bpf: Fix iter/task tid filtering
      bpf: Properly test iter/task tid filtering

Josh Poimboeuf (1):
      cdrom: Avoid barrier_nospec() in cdrom_ioctl_media_changed()

Josua Mayer (1):
      arm64: dts: marvell: cn9130-sr-som: fix cp0 mdio pin numbers

Juha-Pekka Heikkila (1):
      drm/i915/display: Don't allow tile4 framebuffer to do hflip on
display20 or greater

Julian Vetter (1):
      sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML

Justin Chen (1):
      firmware: arm_scmi: Queue in scmi layer for mailbox implementation

Kai Shen (1):
      net/smc: Fix memory leak when using percpu refs

Kalesh AP (7):
      RDMA/bnxt_re: Fix a possible memory leak
      RDMA/bnxt_re: Add a check for memory allocation
      RDMA/bnxt_re: Fix out of bound check
      RDMA/bnxt_re: Return more meaningful error
      RDMA/bnxt_re: Fix a possible NULL pointer dereference
      RDMA/bnxt_re: Fix an error path in bnxt_re_add_device
      RDMA/bnxt_re: Fix the GID table length

Karol Kosik (1):
      ALSA: usb-audio: Fix NULL pointer deref in snd_usb_power_domain_set()

Kashyap Desai (1):
      RDMA/bnxt_re: Fix incorrect dereference of srq in async event

Kefeng Wang (1):
      mm: huge_memory: add vma_thp_disabled() and thp_disabled_by_hw()

Keith Busch (2):
      block: fix blk_rq_map_integrity_sg kernel-doc
      nvme-multipath: defer partition scanning

Kent Overstreet (23):
      bcachefs: Fix lockdep splat in bch2_accounting_read
      bcachefs: Split out check_unreachable_inodes() pass
      bcachefs: reattach_inode() now correctly handles interior snapshot no=
des
      bcachefs: btree_iter_peek_upto() now handles BTREE_ITER_all_snapshots
      bcachefs: Delete vestigal check_inode() checks
      bcachefs: bcachefs_metadata_version_inode_has_child_snapshots
      bcachefs: Kill bch2_propagate_key_to_snapshot_leaves()
      bcachefs: bch2_inode_or_descendents_is_open()
      bcachefs: Disk accounting device validation fixes
      closures: Add closure_wait_event_timeout()
      bcachefs: Check if stuck in journal_res_get()
      bcachefs: __wait_for_freeing_inode: Switch to wait_bit_queue_entry
      bcachefs: Fix bch2_have_enough_devs() for BCH_SB_MEMBER_INVALID
      bcachefs: Fix invalid shift in member_to_text()
      bcachefs: Fix accounting replay flags
      bcachefs: Fix bkey_nocow_lock()
      bcachefs: Improve check_snapshot_exists()
      bcachefs: fix uaf in bch2_dio_write_done()
      bcachefs: Fix missing bounds checks in bch2_alloc_read()
      bcachefs: Add missing validation for bch_stripe.csum_granularity_bits
      bcachefs: Fix kasan splat in new_stripe_alloc_buckets()
      bcachefs: Handle race between stripe reuse, invalidate_stripe_to_dev
      bcachefs: Fix sysfs warning in fstests generic/730,731

Kevin Groeneveld (1):
      usb: gadget: f_uac2: fix return value for UAC2_ATTRIBUTE_STRING store

Konstantin Ryabitsev (1):
      MAINTAINERS: use the canonical soc mailing list address and mark it a=
s L:

Krzysztof Kozlowski (1):
      Documentation/process: maintainer-soc: clarify submitting patches

Kuniyuki Iwashima (1):
      tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().

Li RongQing (1):
      net/smc: Fix searching in list of known pnetids in smc_pnet_add_pneti=
d

Linus Torvalds (2):
      mm: fix follow_pfnmap API lockdep assert
      Linux 6.12-rc4

Linus Walleij (2):
      dt-bindings: net: brcm,unimac-mdio: Add bcm6846-mdio
      net: phy: mdio-bcm-unimac: Add BCM6846 support

Liu Shixin (1):
      mm/swapfile: skip HugeTLB pages for unuse_vma

Longlong Xia (1):
      tty: n_gsm: Fix use-after-free in gsm_cleanup_mux

Lorenzo Stoakes (4):
      mm/mmap: correct error handling in mmap_region()
      MAINTAINERS: add memory mapping/VMA co-maintainers
      maple_tree: correct tree corruption on spanning store
      maple_tree: add regression test for spanning store bug

Lu Baolu (1):
      iommu/vt-d: Fix incorrect pci_for_each_dma_alias() for non-PCI device=
s

Luca Boccassi (4):
      ipe: return -ESTALE instead of -EINVAL on update when new policy
has a lower version
      ipe: also reject policy updates with the same version
      ipe: allow secondary and platform keyrings to install/update policies
      ipe: fallback to platform keyring also if key in trusted keyring
is rejected

Lucas De Marchi (1):
      drm/xe/query: Increase timestamp width

Luiz Augusto von Dentz (2):
      Bluetooth: btusb: Fix not being able to reconnect after suspend
      Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001

Lukas Bulwahn (1):
      irqchip: Remove obsolete config ARM_GIC_V3_ITS_PCI

Ma Ke (2):
      pinctrl: apple: check devm_kasprintf() returned value
      pinctrl: stm32: check devm_kasprintf() returned value

Maher Sanalla (1):
      net/mlx5: Check for invalid vector index on EQ creation

Marc Zyngier (1):
      irqchip/gic-v4: Don't allow a VMOVP on a dying VPE

Marek Vasut (1):
      serial: imx: Update mctrl old_status on RTSD interrupt

Mario Limonciello (1):
      cpufreq/amd-pstate: Use nominal perf for limits when boost is disable=
d

Mark Rutland (3):
      arm64: probes: Remove broken LDR (literal) uprobe support
      arm64: probes: Fix simulate_ldr*_literal()
      arm64: probes: Fix uprobes for big-endian kernels

Markus Grabner (1):
      ALSA: line6: update contact information

Martin Kletzander (1):
      x86/resctrl: Avoid overflow in MB settings in bw_validate()

Masahiro Yamada (1):
      kbuild: refactor cc-option-yn, cc-disable-warning, rust-option-yn mac=
ros

Mathias Nyman (3):
      xhci: Fix incorrect stream context type macro
      xhci: Mitigate failed set dequeue pointer commands
      xhci: dbc: honor usb transfer size boundaries.

Matthew Auld (4):
      drm/xe: fix unbalanced rpm put() with fence_fini()
      drm/xe: fix unbalanced rpm put() with declare_wedged()
      drm/xe/xe_sync: initialise ufence.signalled
      drm/xe/bmg: improve cache flushing behaviour

Matthew Brost (3):
      drm/xe: Take job list lock in xe_sched_add_pending_job
      drm/xe: Don't free job in TDR
      drm/xe: Use bookkeep slots for external BO's in exec IOCTL

Matthieu Baerts (NGI0) (1):
      mptcp: pm: fix UaF read in mptcp_pm_nl_rm_addr_or_subflow

Maurizio Lombardi (1):
      nvme-pci: fix race condition between reset and nvme_dev_disable()

Michael Chen (1):
      drm/amdgpu/mes: fix issue of writing to the same log buffer from
2 MES pipes

Michael Ellerman (1):
      powerpc/powernv: Free name on error in opal_event_init()

Michael Mueller (1):
      KVM: s390: Change virtual to physical address access in diag 0x258 ha=
ndler

Michal Luczaj (4):
      bpf, sockmap: SK_DROP on attempted redirects of unsupported af_vsock
      vsock: Update rx_bytes on read_skb()
      vsock: Update msg_count on read_skb()
      bpf, vsock: Drop static vsock_bpf_prot initialization

Michal Pecio (1):
      usb: xhci: Fix handling errors mid TD followed by other errors

Mike Galbraith (1):
      sched: Fix sched_delayed vs cfs_bandwidth

Mikhail Lobanov (1):
      iio: accel: bma400: Fix uninitialized variable field_value in
tap event handling.

Ming Lei (2):
      blk-mq: setup queue ->tag_set before initializing hctx
      ublk: don't allow user copy for unprivileged device

Mohammed Anees (3):
      iioc: dac: ltc2664: Fix span variable usage in ltc2664_channel_config=
()
      bcachefs: Fix NULL pointer dereference in bch2_opt_to_text
      drm/amdgpu: prevent BO_HANDLES error from being overwritten

Murad Masimov (1):
      ALSA: hda/cs8409: Fix possible NULL dereference

Nam Cao (1):
      irqchip/sifive-plic: Unmask interrupt in plic_irq_enable()

Namjae Jeon (2):
      ksmbd: fix user-after-free from session log off
      ksmbd: add support for supplementary groups

Nanyong Sun (1):
      selftests: mm: fix the incorrect usage() info of khugepaged

Nathan Chancellor (2):
      iio: bmi323: Drop CONFIG_PM guards around runtime functions
      x86/resctrl: Annotate get_mem_config() functions as __init

Nico Boehr (1):
      KVM: s390: gaccess: Check if guest address is in memslot

Nikita Travkin (1):
      Input: zinitix - don't fail if linux,keycodes prop is absent

Niklas Schnelle (1):
      s390/pci: Handle PCI error codes other than 0x3a

Niklas S=C3=B6derlund (1):
      net: ravb: Only advertise Rx/Tx timestamps if hardware supports it

Nikolay Kuratov (1):
      drm/vmwgfx: Handle surface check failure correctly

Nilay Shroff (4):
      nvmet-passthru: clear EUID/NGUID/UUID while using loop target
      nvme-loop: flush off pending I/O while shutting down loop controller
      nvme: make keep-alive synchronous operation
      nvme: use helper nvme_ctrl_state in nvme_keep_alive_finish function

Nirmoy Das (1):
      drm/xe/ufence: ufence can be signaled right after wait_woken

OGAWA Hirofumi (1):
      fat: fix uninitialized variable

Oleksij Rempel (1):
      net: macb: Avoid 20s boot delay by skipping MDIO bus
registration for fixed-link PHY

Oliver Neukum (1):
      net: usb: usbnet: fix race in probe failure

Omar Sandoval (1):
      blk-rq-qos: fix crash on rq_qos_wait vs. rq_qos_wake_function race

Paolo Abeni (2):
      mptcp: prevent MPC handshake on port-based signal endpoints
      selftests: mptcp: join: test for prohibited MPC to port-based endp

Paritosh Dixit (1):
      net: stmmac: dwmac-tegra: Fix link bring-up sequence

Paulo Alcantara (1):
      smb: client: fix OOBs when building SMB2_IOCTL request

Pawan Gupta (3):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return
      x86/bugs: Use code segment selector for VERW operand

Pedro Falcato (1):
      9p: Avoid creating multiple slab caches with the same name

Peter Rashleigh (1):
      net: dsa: mv88e6xxx: Fix the max_vid definition for the MV88E6361

Peter Wang (2):
      scsi: ufs: core: Fix the issue of ICU failure
      scsi: ufs: core: Requeue aborted request

Peter Zijlstra (3):
      sched: Fix delayed_dequeue vs switched_from_fair()
      sched/core: Dequeue PSI signals for blocked tasks that are delayed
      sched/fair: Fix external p->on_rq users

Petr Pavlu (1):
      ring-buffer: Fix reader locking when changing the sub buffer order

Phil Auld (1):
      sched/deadline: Use hrtick_enabled_dl() before start_hrtick_dl()

Philip Yang (1):
      drm/amdkfd: Accounting pdd vram_usage for svm

Pierre-Louis Bossart (4):
      ALSA/hda: intel-sdw-acpi: cleanup sdw_intel_scan_controller
      ALSA/hda: intel-sdw-acpi: fetch fwnode once in sdw_intel_scan_control=
ler()
      ALSA/hda: intel-sdw-acpi: simplify sdw-master-count property read
      ALSA/hda: intel-sdw-acpi: add support for sdw-manager-list property r=
ead

Piotr Zalewski (1):
      bcachefs: add check for btree id against max in try read node

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix the for loop used to walk SG table

Prashanth K (1):
      usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG

Pu Lehui (1):
      riscv, bpf: Fix possible infinite tailcall when CONFIG_CFI_CLANG
is enabled

Qianqiang Liu (1):
      RDMA/nldev: Fix NULL pointer dereferences issue in rdma_nl_notify_eve=
nt

Ranjan Kumar (1):
      scsi: mpi3mr: Validate SAS port assignments

Richard Gong (1):
      x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h

Rik van Riel (1):
      bpf: use kvzmalloc to allocate BPF verifier environment

Rob Clark (1):
      drm/msm/a6xx+: Insert a fence wait before SMMU table update

Rob Herring (Arm) (1):
      dt-bindings: iio: dac: adi,ad56xx: Fix duplicate compatible strings

Robin Murphy (1):
      iommu/arm-smmu: Clarify MMU-500 CPRE workaround

Roger Quadros (1):
      usb: dwc3: core: Fix system suspend on TI AM62 platforms

Roi Martin (2):
      btrfs: fix uninitialized pointer free in add_inode_ref()
      btrfs: fix uninitialized pointer free on read_alloc_one_name() error

Rosen Penev (1):
      pinctrl: aw9523: add missing mutex_destroy

Ryusuke Konishi (1):
      nilfs2: propagate directory read errors from nilfs_find_entry()

Sabrina Dubroca (1):
      macsec: don't increment counters for an unrelated SA

Sakari Ailus (1):
      MAINTAINERS: Add an entry for the LJCA drivers

Saravanan Vajravel (1):
      RDMA/bnxt_re: Fix incorrect AVID type in WQE structure

Sean Anderson (1):
      dma-mapping: fix tracing dma_alloc/free with vmalloc'd memory

Sebastian Andrzej Siewior (2):
      mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on certain builds.
      MAINTAINERS: Add an entry for PREEMPT_RT.

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the max WQEs used in Static WQE mode
      RDMA/bnxt_re: Avoid CPU lockups due fifo occupancy check loop

SeongJae Park (2):
      Docs/damon/maintainer-profile: add missing '_' suffixes for
external web links
      Docs/damon/maintainer-profile: update deprecated awslabs GitHub URLs

Sergey Matsievskiy (3):
      irqchip/ocelot: Fix trigger register address
      irqchip/ocelot: Comment sticky register clearing code
      pinctrl: ocelot: fix system hang on level based interrupts

Seunghwan Baek (1):
      scsi: ufs: core: Set SDEV_OFFLINE when UFS is shut down

Shay Drory (1):
      net/mlx5: Fix command bitmask initialization

Showrya M N (1):
      RDMA/siw: Add sendpage_ok() check to disable MSG_SPLICE_PAGES

Sidhartha Kumar (1):
      maple_tree: check for MA_STATE_BULK on setting wr_rebalance

Simon Sundberg (2):
      selftests/bpf: Provide a generic [un]load_module helper
      selftests/bpf: Add test for kfunc module order

Srinivas Pandruvada (1):
      powercap: intel_rapl_msr: Add PL4 support for ArrowLake-H

Srinivasan Shanmugam (1):
      drm/amd/amdgpu: Fix double unlock in amdgpu_mes_add_ring

Stefan Blum (1):
      HID: multitouch: Add support for B2402FVA track point

Stefan Kerkmann (1):
      Input: xpad - add support for 8BitDo Ultimate 2C Wireless Controller

Steven Rostedt (3):
      ring-buffer: Fix refcount setting of boot mapped buffers
      fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks
      fgraph: Allocate ret_stack_list with proper size

Su Hui (2):
      firmware: arm_scmi: Fix the double free in scmi_debugfs_common_setup(=
)
      smb: client: fix possible double free in smb2_set_ea()

Sunil V L (1):
      irqchip/riscv-intc: Fix SMP=3Dn boot with ACPI

SurajSonawane2415 (2):
      hid: intel-ish-hid: Fix uninitialized variable 'rv' in
ish_fw_xfer_direct_dma
      block: Fix elevator_get_default() checking for NULL q->tag_set

Takashi Iwai (1):
      parport: Proper fix for array out-of-bounds access

Tejun Heo (6):
      Revert "sched_ext: Use shorter slice while bypassing"
      sched_ext: Start schedulers with consistent p->scx.slice values
      sched_ext: Move scx_buildin_idle_enabled check to scx_bpf_select_cpu_=
dfl()
      sched_ext: bypass mode shouldn't depend on ops.select_cpu()
      sched_ext: Move scx_tasks_lock handling into scx_task_iter helpers
      sched_ext: Don't hold scx_tasks_lock for too long

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

Thierry Reding (1):
      gpu: host1x: Set up device DMA parameters

Thomas Wei=C3=9Fschuh (3):
      bpf, lsm: Remove bpf_lsm_key_free hook
      s390/sclp: Deactivate sclp after all its users
      s390/sclp_vt220: Convert newlines to CRLF instead of LFCR

Thomas Zimmermann (3):
      Revert "drm/mgag200: Add vblank support"
      drm/ast: sil164: Clear EDID if no display is connected
      drm/ast: vga: Clear EDID if no display is connected

Thorsten Blum (1):
      drm/vmwgfx: Remove unnecessary NULL checks before kvfree()

Timo Grautstueck (1):
      lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW

Toke H=C3=B8iland-J=C3=B8rgensen (2):
      bpf: Make sure internal and UAPI bpf_redirect flags don't overlap
      bpf: fix kfunc btf caching for modules

Tokunori Ikegami (1):
      nvme: delete unnecessary fallthru comment

Tony Ambardar (2):
      selftests/bpf: Fix error compiling cgroup_ancestor.c with musl libc
      selftests/bpf: Fix cross-compiling urandom_read

Tyrone Wu (6):
      bpf: fix unpopulated name_len field in perf_event link info
      selftests/bpf: fix perf_event link info name_len assertion
      bpf: Fix unpopulated path_size when uprobe_multi fields unset
      selftests/bpf: Assert link info uprobe_multi count & path_size if uns=
et
      bpf: Fix link info netfilter flags to populate defrag flag
      selftests/bpf: Add asserts for netfilter link info

Vasiliy Kovalev (2):
      ALSA: hda/conexant - Fix audio routing for HP EliteOne 1000 G2
      ALSA: hda/conexant - Use cached pin control for Node 0x1d on HP
EliteOne 1000 G2

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/radeon: Fix encoder->possible_clones

Vladimir Oltean (1):
      net: dsa: vsc73xx: fix reception from VLAN-unaware bridges

Wade Wang (1):
      HID: plantronics: Workaround for an unexcepted opposite volume key

Waiman Long (1):
      sched/core: Disable page allocation in task_tick_mm_cid()

Wander Lairson Costa (1):
      bpf: Use raw_spinlock_t in ringbuf

Wang Hai (6):
      net: ethernet: aeroflex: fix potential memory leak in
greth_start_xmit_gbit()
      net: xilinx: axienet: fix potential memory leak in axienet_start_xmit=
()
      net: ethernet: rtsn: fix potential memory leak in rtsn_start_xmit()
      net: systemport: fix potential memory leak in bcm_sysport_xmit()
      net: bcmasp: fix potential memory leak in bcmasp_xmit()
      scsi: target: core: Fix null-ptr-deref in target_alloc_device()

WangYuli (1):
      HID: multitouch: Add quirk for HONOR MagicBook Art 14 touchpad

Wei Fang (5):
      net: enetc: remove xdp_drops statistic from enetc_xdp_drop()
      net: enetc: block concurrent XDP transmissions during ring reconfigur=
ation
      net: enetc: disable Tx BD rings after they are empty
      net: enetc: disable NAPI after all rings are disabled
      net: enetc: add missing static descriptor and inline keyword

Wei Xu (1):
      mm/mglru: only clear kswapd_failures if reclaimable

Will Deacon (1):
      kasan: Disable Software Tag-Based KASAN with GCC

Xin Long (1):
      ipv4: give an IPv4 dev to blackhole_netdev

Yan Zhen (1):
      reset: npcm: convert comma to semicolon

Yang Shi (1):
      mm: khugepaged: fix the arguments order in
khugepaged_collapse_file trace point

Yao Zi (1):
      clk: rockchip: fix finding of maximum clock ID

Ye Bin (1):
      Bluetooth: bnep: fix wild-memory-access in proto_unregister

Yevgeny Kliteynik (2):
      net/mlx5: HWS, removed wrong access to a number of rules variable
      net/mlx5: HWS, fixed double free in error flow of definer layout

Yo-Jung (Leo) Lin (1):
      misc: rtsx: list supported models in Kconfig help

Yun Lu (1):
      selftest: hid: add the missing tests directory

Zack Rusin (1):
      drm/vmwgfx: Cleanup kms setup without 3d

Zhang Rui (1):
      x86/apic: Always explicitly disarm TSC-deadline timer

Zhu Jun (1):
      ALSA: scarlett2: Add error check after retrieving PEQ filter values

christoph.plattner (1):
      ALSA: hda: Sound support for HP Spectre x360 16 inch model 2024

