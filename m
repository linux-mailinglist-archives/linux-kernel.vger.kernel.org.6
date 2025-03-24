Return-Path: <linux-kernel+bounces-573853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EF9A6DD27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA792164EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8270B25F7B2;
	Mon, 24 Mar 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O57Dmmal"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07F469D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827013; cv=none; b=UkKBk/bcUHNRW5gUKDdBqhdqybKQ79sdvALARKkMWW6FgqGtBf2y+UaLBUoxRSY2f42D5VLKhuduoLCZk1TvlPkLyR7qQkjAOmw/h9NU0iVWJOLdsj19c6BaFzlpQqPJsppUb/hEWQTJVlqeQ9g7kXu9TNdIPTIETRO93UaRFlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827013; c=relaxed/simple;
	bh=ee5FO1TAa4I/BbxdA0HewgnnXiA+gs1kgApfWEQayos=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T+TxvyJiUA3z+ysK4zDY2aULUt5rhpKAB9Zr0AjNOgYLflyMCYCGIp0TjpZjA+20XKHNaYKbFpVY53sh3gaeoawcyDcx+H9YNwYAULN5/lH3LgLKJPxvsjsZpzau8Sq/PNkiUeKxP6rGx8PXId2TGRU8VQsL9lTSrpOaINV/TOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O57Dmmal; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so6770837a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742827009; x=1743431809; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T9caplKUvCwim1wr9ojc5QJ1mkjre3pn3h5fcDZksbw=;
        b=O57DmmalPbg5kic8XuK4fpsTcxlkXQlVY2SLG5i/Dhf1hf+pLEsK84+6ONBVikzAIe
         YUZRV+8UjY0wjntYHpKWLNLnizOhFrioK10XLPJHUQRoItLQ5tTq6Bj1jZ1qtM2Fka4A
         U2+JsFhZbRPtXYEzeHk6zW9qMCO9Jc0qvpGu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742827009; x=1743431809;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9caplKUvCwim1wr9ojc5QJ1mkjre3pn3h5fcDZksbw=;
        b=hjq2/2242d9WbNk3NEzTbKRQ7A3RlhowWRkSW5qXXkZb/hRVVEhHxPRwBfGArIkFp3
         o8Dho6X/OMYoqiknJm4hcyA3SoJZiXoo8rsIJZGVX24vkLv4LuaRV/RfIE8Z0LFEUr0e
         sW8Dh1/XQlPHNZ/0hK8M2wGUd/JXUeFZp2wwwBmtrUlmiRpiJ0TZHG++PC8KkWXCCFOr
         f+7Vt2zQc3IOQbif2mpms/at070NU85mMr+gW5/kBaYmSRKlMhxnqVCJs385SaTILJUY
         tbBk4v3x5q7FGOnOxXF10WsDIvdxYz5JJj77EUoFB0Hu3o/mt+QPibK/AoS37RXtAN/D
         nNQg==
X-Gm-Message-State: AOJu0YwDk4PEAMAkL2dYgnJl/3dr4I/e2Gc2jN5bD/b5ea5x5XU1hCgN
	inriO14MAXjrbjJnIP6riMX58odxEN8Vly59vuDXN1SWtCmZuVNJnIgx8MgSNzCR9SvjbenPgkU
	CDd8=
X-Gm-Gg: ASbGnctb1UCL9DRZzrwW7tTDgDr7mjKYWqc39hnPP17rgLKrdnJUvCDUKVaTCHVQ4zz
	jZRJd8bRTFmVLYqAemxMXw8L8XOGo80gME3RY/Ta1wgiq1G6dIe05ncC4eP2Hu2wxzOgXaiUGHl
	RSoSZno2tJ8oa+CVVk7NS97bSxvR10WBNfv2xBd5isI0dob5XaAqn4XJVm19knRMJ6rmKePryEA
	8ANPj9aEo4CpOTcq5vLCrRSLpT2N2Lu1ZWkarlcadWnw+Pr/Gb2PVkpEoXREE4sz5OkOF3oBDVw
	zgi0c13E8JWLCsYPKZa+fVgvQOMtVfYMFxT70VejSWyoa8EPlHcWSH9Jng20xxg/HWvoYixJf+c
	mleo1UEqudBaPR2Z8l14=
X-Google-Smtp-Source: AGHT+IF+7vibclgBKu1PGmf+iWktRinJH1uxfq+C69w+YJvptgPEgtWkJ0NoYg047B58XuZZJeJu+w==
X-Received: by 2002:a05:6402:27c6:b0:5e6:1842:1346 with SMTP id 4fb4d7f45d1cf-5ebcd520333mr12170627a12.30.1742827008374;
        Mon, 24 Mar 2025 07:36:48 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0c6f25sm6158586a12.57.2025.03.24.07.36.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 07:36:47 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac298c8fa50so789546866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:36:47 -0700 (PDT)
X-Received: by 2002:a17:907:944d:b0:ac3:8a3a:e924 with SMTP id
 a640c23a62f3a-ac3f26aee53mr1143462666b.39.1742827006970; Mon, 24 Mar 2025
 07:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Mar 2025 07:36:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7TO09Si5tTPyhdrLLvyYtVmCf+GGN4kVJ0=Xk=5TE3g@mail.gmail.com>
X-Gm-Features: AQ5f1Jp1e1OXJnwPzjdPolYZXWS63NLtTm8al4-g7WrVvqw4EQ-kZTlwvQqiYjk
Message-ID: <CAHk-=wg7TO09Si5tTPyhdrLLvyYtVmCf+GGN4kVJ0=Xk=5TE3g@mail.gmail.com>
Subject: Linux 6.14
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So it's early Monday morning (well - early for me, I'm not really a
morning person), and I'd love to have some good excuse for why I
didn't do the 6.14 release yesterday on my regular Sunday afternoon
release schedule.

I'd like to say that some important last-minute thing came up and
delayed things.

But no. It's just pure incompetence.

Because absolutely nothing last-minute happened yesterday, and I was
just clearing up some unrelated things in order to be ready for the
merge window. And in the process just entirely forgot to actually ever
cut the release. D'oh.

So yes, a little delayed for no good reason at all, and obviously that
means that the merge window has opened. No rest for the wicked (or the
incompetent).

Below is the shortlog for the last week. It's nice and small - not
only was there no last-minute issue yesterday, the whole last week was
pretty calm. The patch is dominated by some amd gpu updates, and even
those are pretty small. The rest is random small changes all over.

Judging by my pending pile of pull requests, 6.15 will be much busier.

          Linus

---

Alex Deucher (1):
      drm/amdgpu/pm: wire up hwmon fan speed for smu 14.0.2

Alexander Mikhalitsyn (1):
      tools headers: Sync uapi/asm-generic/socket.h with the kernel sources

Alexander Stein (1):
      arm64: dts: freescale: tqma8mpql: Fix vqmmc-supply

Alexandre Cassen (1):
      xfrm: fix tunnel mode TX datapath in packet offload mode

Ard Biesheuvel (2):
      efi/libstub: Avoid physical address 0x0 when doing random allocation
      efivarfs: use I_MUTEX_CHILD nested lock to traverse variables on resu=
me

Arkadiusz Bokowy (1):
      Bluetooth: hci_event: Fix connection regression between LE and
non-LE adapters

Arnd Bergmann (1):
      ARM: OMAP1: select CONFIG_GENERIC_IRQ_CHIP

Arthur Mongodin (1):
      mptcp: Fix data stream corruption in the address announcement

Baochen Qiang (1):
      dma-mapping: fix missing clear bdr in check_ram_in_range_map()

Biju Das (2):
      dt-bindings: can: renesas,rcar-canfd: Fix typo in pattern
properties for R-Car V4M
      can: rcar_canfd: Fix page entries in the AFL list

Chester A. Unal (2):
      ARM: dts: BCM5301X: Fix switch port labels of ASUS RT-AC5300
      ARM: dts: BCM5301X: Fix switch port labels of ASUS RT-AC3200

ChiYuan Huang (2):
      regulator: rtq2208: Fix incorrect buck converter phase mapping
      regulator: rtq2208: Fix the LDO DVS capability

Christian Eggers (2):
      regulator: dummy: force synchronous probing
      regulator: check that dummy regulator has been probed before using it

Claudio Imbrenda (1):
      KVM: s390: pv: fix race when making a page secure

Cosmin Ratiu (1):
      xfrm_output: Force software GSO only in tunnel mode

Dan Carpenter (4):
      firmware: qcom: scm: Fix error code in probe()
      Bluetooth: Fix error code in chan_alloc_skb_cb()
      accel/qaic: Fix integer overflow in qaic_validate_req()
      net: atm: fix use after free in lec_send()

Dave Hansen (1):
      filemap: move prefaulting out of hot write path

David Ahern (1):
      MAINTAINERS: Add Andrea Mayer as a maintainer of SRv6

David Belanger (1):
      drm/amdgpu: Restore uncached behaviour on GFX12

David Howells (5):
      afs: Fix afs_atcell_get_link() to check if ws_cell is unset first
      netfs: Fix collection of results during pause when collection offload=
ed
      netfs: Fix rolling_buffer_load_from_ra() to not clear mark bits
      netfs: Fix netfs_unbuffered_read() to return ssize_t rather than int
      keys: Fix UAF in key_put()

David Lechner (1):
      ARM: davinci: da850: fix selecting ARCH_DAVINCI_DA8XX

David Rosca (3):
      drm/amdgpu: Fix MPEG2, MPEG4 and VC1 video caps max size
      drm/amdgpu: Fix JPEG video caps max size for navi1x and raven
      drm/amdgpu: Remove JPEG from vega and carrizo video caps

Dev Jain (1):
      mm/vma: do not register private-anon mappings with khugepaged during =
mmap

Dhananjay Ugwekar (1):
      perf/x86/rapl: Fix error handling in init_rapl_pmus()

Dietmar Eggemann (1):
      Revert "sched/core: Reduce cost of sched_move_task when config autogr=
oup"

Dragan Simic (2):
      arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board dtsi
      arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dt=
si

E Shattow (1):
      riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function
definitions

Eric W. Biederman (1):
      MAINTAINERS: Remove myself

Felix Fietkau (1):
      net: ipv6: fix TCP GSO segmentation with NAT

Gavrilov Ilia (1):
      xsk: fix an integer overflow in xp_create_and_assign_umem()

Geert Uytterhoeven (2):
      ARM: shmobile: smp: Enforce shmobile_smp_* alignment
      pinctrl: spacemit: PINCTRL_SPACEMIT_K1 should not default to y
unconditionally

Gu Bowen (1):
      mmc: atmel-mci: Add missing clk_disable_unprepare()

Guillaume Nault (2):
      Revert "selftests: Add IPv6 link-local address generation tests
for GRE devices."
      Revert "gre: Fix IPv6 link-local address generation."

Haibo Chen (2):
      can: flexcan: only change CAN state when link up in system PM
      can: flexcan: disable transceiver during system PM

Haiyang Zhang (1):
      net: mana: Support holes in device list reply msg

Harish Kasiviswanathan (1):
      drm/amd/pm: add unique_id for gfx12

Hector Martin (1):
      MAINTAINERS: Add apple-spi driver & binding files

Heiko Stuebner (2):
      arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
      arm64: dts: rockchip: remove supports-cqe from rk3588 tiger

Horatiu Vultur (1):
      reset: mchp: sparx5: Fix for lan966x

Huisong Li (1):
      soc: hisilicon: kunpeng_hccs: Fix incorrect string assembly

Jakub Kicinski (1):
      selftests: drv-net: use defer in the ping test

James Bottomley (1):
      efivarfs: fix NULL dereference on resume

Jason Gunthorpe (1):
      gpu: host1x: Do not assume that a NULL domain means no DMA IOMMU

Jay Cornwall (1):
      drm/amdkfd: Fix instruction hazard in gfx12 trap handler

Jeffrey Hugo (1):
      accel/qaic: Fix possible data corruption in BOs > 2G

Jens Axboe (1):
      io_uring/net: don't clear REQ_F_NEED_CLEANUP unconditionally

Jianfeng Liu (1):
      arm64: dts: rockchip: slow down emmc freq for rock 5 itx

Jinjiang Tu (1):
      mm/hugetlb: fix surplus pages in dissolve_free_huge_page()

Joanne Koong (1):
      fuse: fix uring race condition for null dereference of fc

Joe Hattori (1):
      firmware: imx-scu: fix OF node leak in .probe()

Johan Hovold (1):
      firmware: qcom: uefisecapp: fix efivars registration race

Junxian Huang (6):
      RDMA/hns: Fix soft lockup during bt pages loop
      RDMA/hns: Fix unmatched condition in error path of alloc_user_qp_db()
      RDMA/hns: Fix invalid sq params not being blocked
      RDMA/hns: Fix a missing rollback in error path of
hns_roce_create_qp_common()
      RDMA/hns: Fix missing xa_destroy()
      RDMA/hns: Fix wrong value of max_sge_rd

Justin Iurman (3):
      net: lwtunnel: fix recursion loops
      net: ipv6: ioam6: fix lwtunnel_output() loop
      selftests: net: test for lwtunnel dst ref loops

Justin Klaassen (1):
      arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S

Kamal Dasu (1):
      mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops

Kashyap Desai (2):
      RDMA/bnxt_re: Fix allocation of QP table
      RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Kirill A. Shutemov (1):
      mm/page_alloc: fix memory accept before watermarks gets initialized

Konrad Dybcio (1):
      Revert "arm64: dts: qcom: sdm845: Affirm IDR0.CCTW on apps_smmu"

Krzysztof Kozlowski (1):
      soc: qcom: pmic_glink: Drop redundant pg assignment before taking loc=
k

Kuniyuki Iwashima (2):
      ipv6: Fix memleak of nhc_pcpu_rth_output in fib_check_nh_v6_gw().
      ipv6: Set errno after ip_fib_metrics_init() in ip6_route_info_create(=
).

Lin Ma (1):
      net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES

Linus Torvalds (1):
      Linux 6.14

Lo-an Chen (1):
      drm/amd/display: Fix incorrect fw_state address in dmub_srv

Ludvig P=C3=A4rsson (1):
      regulator: core: Fix deadlock in create_regulator()

Luis Henriques (1):
      fuse: fix possible deadlock if rings are never initialized

MD Danish Anwar (1):
      net: ti: icssg-prueth: Add lock to stats

Mario Limonciello (1):
      drm/amd/display: Use HW lock mgr for PSR1 when only one eDP

Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix to clean up tprobe correctly when
module unload
      tracing: tprobe-events: Fix leakage of module refcount

Matthew Wilcox (Oracle) (1):
      mm: decline to manipulate the refcount on a slab page

Max Kellermann (1):
      netfs: Call `invalidate_cache` only if implemented

Ma=C3=ADra Canal (2):
      drm/v3d: Don't run jobs that have errors flagged in its fence
      drm/v3d: Set job pointer to NULL when the job's fence has an error

Miaoqian Lin (1):
      spi: Fix reference count leak in slave_show()

Michal Swiatkowski (3):
      devlink: fix xa_alloc_cyclic() error handling
      dpll: fix xa_alloc_cyclic() error handling
      phy: fix xa_alloc_cyclic() error handling

Muchun Song (1):
      mm: memcontrol: fix swap counter leak from offline cgroup

Namhyung Kim (2):
      perf/x86: Check data address for IBS software filter
      perf/amd/ibs: Prevent leaking sensitive data to userspace

Neal Gompa (1):
      MAINTAINERS: Add myself (Neal Gompa) as a reviewer for ARM Apple supp=
ort

Nikita Zhandarovich (1):
      drm/radeon: fix uninitialized size issue in radeon_vce_cs_parse()

Niklas Cassel (1):
      ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain Samsung SSD=
s

Oliver Hartkopp (1):
      can: statistics: use atomic access in hot path

Paulo Alcantara (1):
      smb: client: don't retry IO on failed negprotos with soft mounts

Pavel Begunkov (1):
      io_uring/net: fix sendzc double notif flush

Peng Fan (1):
      soc: imx8m: Unregister cpufreq and soc dev in cleanup path

Phil Elwell (3):
      ARM: dts: bcm2711: PL011 UARTs are actually r1p5
      arm64: dts: bcm2712: PL011 UARTs are actually r1p5
      ARM: dts: bcm2711: Don't mark timer regs unconfigured

Philip Yang (1):
      drm/amdkfd: Fix user queue validation on Gfx7/8

Preethi G (1):
      RDMA/bnxt_re: Fix reporting maximum SRQs on P7 chips

Qasim Ijaz (1):
      RDMA/mlx5: Handle errors returned from mlx5r_ib_rate()

Quentin Schulz (2):
      arm64: dts: rockchip: fix pinmux of UART0 for PX30 Ringneck on Haikou
      arm64: dts: rockchip: fix pinmux of UART5 for PX30 Ringneck on Haikou

Rafael Aquini (1):
      selftests/mm: run_vmtests.sh: fix half_ufd_size_MB calculation

Raphael S. Carvalho (1):
      mm: fix error handling in __filemap_get_folio() with FGP_NOWAIT

Roger Quadros (1):
      memory: omap-gpmc: drop no compatible check

Russell King (Oracle) (1):
      net: stmmac: dwc-qos-eth: use devm_kzalloc() for AXI data

Saranya R (1):
      soc: qcom: pdr: Fix the potential deadlock

Saravanan Vajravel (1):
      RDMA/bnxt_re: Avoid clearing VLAN_ID mask in modify qp path

SeongJae Park (2):
      mm/damon: respect core layer filters' allowance decision on ops layer
      mm/damon/core: initialize damos->walk_completed in damon_new_scheme()

Shakeel Butt (1):
      memcg: drain obj stock on cpu hotplug teardown

Stefan Eichenberger (3):
      ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
      arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack
to sound card
      arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack
to sound card

Stefan Wahren (1):
      ARM: dts: bcm2711: Fix xHCI power-domain

Sven Eckelmann (1):
      batman-adv: Ignore own maximum aggregation size during RX

Tasos Sahanidis (1):
      hwmon: (nct6775-core) Fix out of bounds access for NCT679{8,9}

Tomasz Paku=C5=82a (1):
      drm/amdgpu/pm: Handle SCLK offset correctly in overdrive for smu 14.0=
.2

Tomasz Rusinowicz (1):
      drm/xe: Fix exporting xe buffers multiple times

Vignesh Raghavendra (1):
      net: ethernet: ti: am65-cpsw: Fix NAPI registration sequence

Vincent Mailhol (1):
      can: ucan: fix out of bound read in strscpy() source

Wentao Liang (1):
      drm/amdgpu/gfx12: correct cleanup of 'me' field with gfx_v12_0_me_fin=
i()

Wolfram Sang (1):
      MAINTAINERS: correct list and scope of LTC4286 HARDWARE MONITOR

Xianwei Zhao (1):
      pmdomain: amlogic: fix T7 ISP secpower

Yang Yingliang (1):
      i2c: amd-mp2: drop free_irq() of devm_request_irq() allocated irq

Yao Zi (1):
      arm64: dts: rockchip: Remove undocumented sdmmc property from lubanca=
t-1

Ye Bin (1):
      proc: fix UAF in proc_get_inode()

Yilin Chen (1):
      drm/amd/display: Fix message for support_edp0_on_dp1

Yongjian Sun (1):
      libfs: Fix duplicate directory entry in offset_dir_lookup

Zhiyu Zhang (1):
      squashfs: fix invalid pointer dereference in squashfs_cache_delete

Zhu Yanjun (1):
      RDMA/rxe: Fix the failure of ibv_query_device() and
ibv_query_device_ex() tests

Zi Yan (2):
      mm/migrate: fix shmem xarray update during migration
      mm/huge_memory: drop beyond-EOF folios with the right number of refs

qianyi liu (1):
      drm/sched: Fix fence reference count leak

