Return-Path: <linux-kernel+bounces-329918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3892979769
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14BD1C20C44
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 15:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354B1C8FAB;
	Sun, 15 Sep 2024 15:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="abe7bm68"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257B1C3F14
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726413223; cv=none; b=axSJsQTrhcQCGeO/JrGlibpeDvbvez7RPjnyfFxWmppEBxl9WNXseA601kW+z6alvZ/jAXUXsUZrFzYXzBQSQ9eAgMv+q/WZGIzfwJ4hEa5aWOkI+oGhjzSS8oAzoqXiqSDBuvUztp2VprNVeRcRw2i6GxeMIT4ceFbMptueE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726413223; c=relaxed/simple;
	bh=xacSxg5HpEC5NeOzl+hpmAEk58Nqu0KoPqWKX5dhNRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CWk+VCZZpTFE0uz4Lv6WW2xq5NYSTs29ik3rc0JyZcs7NT3TAWTIzRxxn2pKTEsslWyhuyvV9nJ3RhwPUSf5Tzk1D/9FCujoXzo6BWxrcK8BjKuRP/jufhPmw64+Czin/w7IsKGZ252YZ7wAJSYVsbd3xa8jOdNUiWAGQ5/g2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=abe7bm68; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32974fso4284349a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726413218; x=1727018018; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KW0PeyUD14Sf+uUhb8xxOkVzD+42RbmD67lSvVLIFAo=;
        b=abe7bm68dqEzEOW3MJ/GpNPbA4p155ungb0abvCpND+z6Xh3pjJzkHdcPaOe3Q2kGh
         2f3zopj935ObcHItXRGkwPntt/INRzMxH0TBjFYph/9LSb1dkc/tOHwVeuBmFrWYH03I
         nZjN9hUmnjcBwgzuGWYWLKoqtQx/e71oBPTbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726413218; x=1727018018;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KW0PeyUD14Sf+uUhb8xxOkVzD+42RbmD67lSvVLIFAo=;
        b=C0p0pmuRqwuJTGQTiyb4zezTgpWKvZFUSQZWmdMCM9ZTFUNapWfDj6JulP4vFUFNSZ
         a+mirZ8c8IFuiBMjBX3QIwDi8X8DhCtB2cjdhjX3wXZN7diP4e9PbxNc7kC4qVqluIfq
         EwHTvWuSQ4+Kb87GM3lElyMotgDRyG1PPmwHI+OoV8kSxZu7F6RhYiThTZuF4sYGN3t2
         KIF+S6nI65LkereSbFat4x/gaGYTrE2VKT1esJgeMVAxvc7rMerkMbnZc2BXbY8uwYCb
         sVC/xdIujopZ2L/zSGr7VF3m/QaY06TIwYs+vBuMkMXqI9C93YiVTTte2Hzo3ZQ590Cq
         kpNw==
X-Gm-Message-State: AOJu0YzMhfJgYxZGnlH7Jeyzm8BszAJJOwusAxpgonmdQ6GM3x0TBnoZ
	yMOLo6CXosP5gxGSC9TozcvY4OZk9lIiHaDYHvht1w91p3CuYaxpX+4MIncUTxFFkMQiLLEXOqn
	n0Ih0mg==
X-Google-Smtp-Source: AGHT+IFgH7eRsODZbz7R3eKaNnEOW46OExZsUbgOS+ZwKqN6SYx8CtN3RsG+AhhTJx/HF4bM/i+ETg==
X-Received: by 2002:a05:6402:5207:b0:5c2:5251:bae5 with SMTP id 4fb4d7f45d1cf-5c413e11b60mr11009133a12.9.1726413217725;
        Sun, 15 Sep 2024 08:13:37 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb94a01sm1728356a12.91.2024.09.15.08.13.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 08:13:36 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so4083769a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 08:13:35 -0700 (PDT)
X-Received: by 2002:a50:c94b:0:b0:5a2:68a2:ae57 with SMTP id
 4fb4d7f45d1cf-5c413e522ddmr9440428a12.31.1726413214634; Sun, 15 Sep 2024
 08:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Sep 2024 17:13:18 +0200
X-Gmail-Original-Message-ID: <CAHk-=whVpSHw9+4ov=oLevfv8sPYbh59T_9VKif-6Vqkr41jQA@mail.gmail.com>
Message-ID: <CAHk-=whVpSHw9+4ov=oLevfv8sPYbh59T_9VKif-6Vqkr41jQA@mail.gmail.com>
Subject: Linux 6.11
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm once again on the road and not in my normal timezone, but it's
Sunday afternoon here in Vienna, and 6.11 is out.

The last week was actually pretty quiet and calm, which is nice to
see. The shortlog is below for anybody who wants to look at the
details, but it really isn't very many patches, and the patches are
all pretty small. Nothing in particular stands out - the biggest patch
in here is for Hyper-V Confidential Computing documentation.

Anyway, with this, the merge window will obviously open tomorrow, and
I already have 40+ pull requests pending. That said, exactly _because_
I'm on the road, it will probably be a fairly slow start to the merge
window, since not only am I on my laptop, there's OSS Europe starting
tomorrow and then the kernel maintainer summit on Tuesday. So if I
don't get to your pull request immediately, please be patient.

But before that merge window activity, please do give the latest release a =
try!

                  Linus

---

Alex Deucher (1):
      drm/amdgpu/atomfirmware: Silence UBSAN warning

Alexander Shiyan (1):
      arm64: dts: rockchip: Remove broken tsadc pinctrl binding for rk356x

Alexandre Ghiti (1):
      drivers: perf: Fix smp_processor_id() use in preemptible code

Andy Shevchenko (1):
      tracing: Drop unused helper function to fix the build

Anirudh Rayabharam (Microsoft) (1):
      x86/hyperv: fix kexec crash due to VP assist page corruption

Anthony Nandaa (1):
      tools: hv: lsvmbus: change shebang to use python3

Arnd Bergmann (2):
      drm/stm: add COMMON_CLK dependency
      platform: cznic: turris-omnia-mcu: fix HW_RANDOM dependency

Arseniy Krasnov (1):
      ASoC: meson: axg-card: fix 'use-after-free'

Asbj=C3=B8rn Sloth T=C3=B8nnesen (1):
      netlink: specs: mptcp: fix port endianness

Ashutosh Dixit (1):
      drm/xe/oa: Enable Xe2+ PES disaggregation

Bard Liao (2):
      ASoC: Intel: soc-acpi-intel-lnl-match: add missing empty item
      ASoC: Intel: soc-acpi-intel-mtl-match: add missing empty item

Bas Nieuwenhuizen (1):
      platform/x86: asus-wmi: Disable OOBE experience on Zenbook S 16

Ben Skeggs (1):
      drm/nouveau/fb: restore init() for ramgp102

Benjamin Poirier (1):
      net/mlx5: Fix bridge mode operations when there are no VFs

Carolina Jubran (3):
      net/mlx5: Explicitly set scheduling element and TSAR type
      net/mlx5: Add missing masks and QoS bit masks for scheduling elements
      net/mlx5: Verify support for scheduling element and TSAR type

Charlie Jenkins (1):
      riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF

Cristian Ciocaltea (2):
      dt-bindings: soc: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF
      arm64: dts: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF

Damien Le Moal (1):
      block: Prevent deadlocks when switching elevators

Dan Carpenter (1):
      firmware: qcom: uefisecapp: Fix deadlock in qcuefi_acquire()

David (Ming Qiang) Wu (2):
      drm/amd/amdgpu: apply command submission parser for JPEG v2+
      drm/amd/amdgpu: apply command submission parser for JPEG v1

David Belanger (1):
      drm/amdkfd: Add cache line size info

David Howells (1):
      cifs: Fix signature miscalculation

Dexuan Cui (1):
      clocksource: hyper-v: Use lapic timer in a TDX VM without paravisor

Edward Adam Davis (1):
      mptcp: pm: Fix uaf in __timer_delete_sync

Eric Dumazet (1):
      net: hsr: remove seqnr_lock

FUKAUMI Naoki (1):
      arm64: dts: rockchip: fix PMIC interrupt pin in pinctrl for ROCK Pi E

Florian Westphal (2):
      netfilter: nft_socket: fix sk refcount leaks
      netfilter: nft_socket: make cgroupsv2 matching work with namespaces

Han Xu (1):
      spi: nxp-fspi: fix the KASAN report out-of-bounds bug

Hans de Goede (2):
      platform/x86: panasonic-laptop: Fix SINF array out of bounds accesses
      platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf ar=
ray

Hongbo Li (1):
      hv: vmbus: Constify struct kobj_type and struct attribute_group

Jacky Chou (1):
      net: ftgmac100: Enable TX interrupt to avoid TX timeout

Jacob Keller (1):
      ice: fix accounting for filters shared by multiple VSIs

Jani Nikula (1):
      drm/xe/display: fix compat IS_DISPLAY_STEP() range end

Jeongjun Park (1):
      net: hsr: prevent NULL pointer dereference in hsr_proxy_announce()

Jiawen Wu (1):
      net: libwx: fix number of Rx and Tx descriptors

Jinjie Ruan (2):
      spi: geni-qcom: Undo runtime PM changes at driver exit time
      spi: geni-qcom: Fix incorrect free_irq() sequence

Kenneth Feng (2):
      drm/amd/pm: update the features set on smu v14.0.2/3
      drm/amd/pm: fix the pp_dpm_pcie issue on smu v14.0.2/3

Kent Overstreet (6):
      bcachefs: Fix ca->io_ref usage
      bcachefs: Add a cond_resched() to __journal_keys_sort()
      bcachefs: Simplify bch2_bkey_drop_ptrs()
      bcachefs: More BCH_SB_MEMBER_INVALID support
      bcachefs: fix btree_key_cache sysfs knob
      bcachefs: Don't delete open files in online fsck

Kory Maincent (1):
      MAINTAINERS: Add ethtool pse-pd to PSE NETWORK DRIVER

Krzysztof Kozlowski (1):
      soundwire: stream: Revert "soundwire: stream: fix programming
slave ports for non-continous port maps"

Lai Jiangshan (1):
      workqueue: Clear worker->pool in the worker thread context

Leo Li (2):
      drm/amd/display: Do not reset planes based on crtc zpos_changed
      drm/amd/display: Add all planes on CRTC to state for overlay cursor

Linus Torvalds (2):
      mm: avoid leaving partial pfn mappings around in error case
      Linux 6.11

Lorenzo Bianconi (1):
      net: netfilter: move nf flowtable bpf initialization in
nf_flow_table_module_init()

Lorenzo Stoakes (1):
      minmax: reduce min/max macro expansion in atomisp driver

Lu Baolu (2):
      drm/rockchip: Use iommu_paging_domain_alloc()
      drm/tegra: Use iommu_paging_domain_alloc()

Lucas De Marchi (1):
      drm/xe/gt: Remove double include

Maher Sanalla (1):
      net/mlx5: Update the list of the PCI supported devices

Martyna Szapar-Mudlaw (1):
      ice: Fix lldp packets dropping after changing the number of channels

Matthew Auld (2):
      drm/xe/client: fix deadlock in show_meminfo()
      drm/xe/client: add missing bo locking in show_meminfo()

Matthew Brost (2):
      drm/xe: Remove fence check from send_tlb_invalidation
      drm/xe: Fix possible UAF in guc_exec_queue_process_msg

Matthieu Baerts (NGI0) (3):
      selftests: mptcp: join: restrict fullmesh endp on 1st sf
      selftests: mptcp: include lib.sh file
      selftests: mptcp: include net_helper.sh file

Michael Kelley (2):
      Documentation: hyperv: Add overview of Confidential Computing VM supp=
ort
      x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides freq=
uency

Michal Schmidt (1):
      ice: fix VSI lists confusion when adding VLANs

Mika Westerberg (1):
      pinctrl: meteorlake: Add Arrow Lake-H/U ACPI ID

Mikulas Patocka (1):
      dm-integrity: fix a race condition when accessing recalc_sector

Muhammad Usama Anjum (1):
      fou: fix initialization of grc

Naveen Mamindlapalli (1):
      octeontx2-af: Modify SMQ flush sequence to drop packets

Nikita Zhandarovich (1):
      drm/i915/guc: prevent a possible int overflow in wq offsets

Nirmoy Das (1):
      drm/xe: Fix access_ok check in user_fence_create

Paolo Bonzini (1):
      Revert "KVM: VMX: Always honor guest PAT on CPUs that support self-sn=
oop"

Patrick Rudolph (1):
      pinctrl: pinctrl-cy8c95x0: Fix regcache

Patryk Biel (1):
      hwmon: (pmbus) Conditionally clear individual status bits for
pmbus rev >=3D 1.2

Philipp Stanner (1):
      PCI: Fix potential deadlock in pcim_intx()

Pierre-Louis Bossart (1):
      MAINTAINERS: update Pierre Bossart's email and role

Przemek Kitszel (1):
      ice: stop calling pci_disable_device() as we use pcim

Quentin Schulz (2):
      arm64: dts: rockchip: fix eMMC/SPI corruption when audio has
been used on RK3399 Puma
      arm64: dts: rockchip: override BIOS_DISABLE signal via GPIO hog
on RK3399 Puma

Rachel Menge (1):
      Drivers: hv: Remove deprecated hv_fcopy declarations

Roman Kisel (1):
      Drivers: hv: vmbus: Fix the misplaced function description

Satya Priya Kakitapalli (1):
      clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()

Sean Anderson (2):
      selftests: net: csum: Fix checksums for packets with non-zero padding
      net: dpaa: Pad packets to ETH_ZLEN

Shahar Shitrit (2):
      net/mlx5e: Add missing link modes to ptys2ethtool_map
      net/mlx5e: Add missing link mode to ptys2ext_ethtool_map

Shenghao Ding (1):
      ASoC: tas2781: fix to save the dsp bin file name into the
correct array in case name_prefix is not NULL

Sriram Yagnaraman (1):
      igb: Always call igb_xdp_ring_update_tail() under Tx lock

Steven Rostedt (1):
      tracing/osnoise: Fix build when timerlat is not enabled

Su Hui (1):
      ASoC: codecs: avoid possible garbage value in peb2466_reg_read()

T.J. Mercier (2):
      dma-buf: heaps: Fix off-by-one in CMA heap fault handler
      drm/syncobj: Fix syncobj leak in drm_syncobj_eventfd_ioctl

Tobias Jakobi (2):
      drm/amd/display: Avoid race between dcn10_set_drr() and
dc_state_destruct()
      drm/amd/display: Avoid race between dcn35_set_drr() and
dc_state_destruct()

Tomas Paukrt (1):
      net: phy: dp83822: Fix NULL pointer dereference on DP83825 devices

Wei Fang (1):
      dt-bindings: net: tja11xx: fix the broken binding

Willem de Bruijn (1):
      net: tighten bad gso csum offset check in virtio_net_hdr

Xiaoliang Yang (1):
      net: dsa: felix: ignore pending status of TAS module when it's disabl=
ed

Xingyu Wu (1):
      riscv: dts: starfive: jh7110-common: Fix lower rate of CPUfreq
by setting PLL0 rate to 1.5GHz

Xuan Zhuo (3):
      Revert "virtio_net: rx remove premapped failover code"
      Revert "virtio_net: big mode skip the unmap check"
      virtio_net: disable premapped mode by default

Yu Liao (1):
      printk: Export match_devname_and_update_preferred_console()

zhang jiao (1):
      tools: hv: rm .*.cmd when make clean

