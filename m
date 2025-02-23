Return-Path: <linux-kernel+bounces-527962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45776A411B8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEDC1890F28
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D952C1FDA6F;
	Sun, 23 Feb 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eioe2APm"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69353846F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740343785; cv=none; b=Ib3f+GB0ZHd/NHHRnj5++W6uDQkBtYJvz0kNCIMMwj4TVQ/8NsVUpoFmUX+xA9WbdNvE9wCymn5dEdWrFeGTDAo8rnKDjbvdM+jyw8vZpuwnYP1NmSLZ5cWP2ffwUfkPS/OEsTgdL03mH4rE3Zmq3xnPH61DXfT4j6NN1jqGwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740343785; c=relaxed/simple;
	bh=YRexoah1F+vqmEHzFmm1586gobiZZ55mP1x4lBfOPkE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=K7Th0rlP1GHigSPBvh7yIpoztxXrcAjcVDvYO6ETsY/kX6ufhpOhNoekmt3ssxfqGB9VFVKsU2I0IK1LLRLXFm2Im10tAZ9UJiYY/DOvgQKxMUnWQmAeWOrr9LBe/E4/gX8IWwuPVXWfY8ahYuYhX1dryBvrnsoG4p74MCTh5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eioe2APm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so614783866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740343780; x=1740948580; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ACL5+F2fQyrL0EC/HPKGA08eBsJUJV2FZvs6t7cA/K8=;
        b=eioe2APmOgjlOEDe5WtHtv3+19dFl/xPHvIetaDXAbjfjj15xvggOYTzaJXOTje7nC
         o9hBBQo7/FB7XcEvQQ1NW73qAi7pEDqInL80/+f4F8ziIsIP6ToGvdvQ/av7HNF8ihSD
         azjEmGST65e4C3+cicHikWCGhKWUAr21fBh5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740343780; x=1740948580;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACL5+F2fQyrL0EC/HPKGA08eBsJUJV2FZvs6t7cA/K8=;
        b=L8kzOIGbaUB8G758uBWAlOJUxBAeZOLbmQ6ubviJj0t1u2pSRFgXJ3xRWCA4i0Jnaa
         X25tOfYfqhil95GceIz0JOUUnyPIdfDIjh9IMQvb0pp1zsNwQW2zY/AaiqGR4VYzL+/h
         DNPHpaWtcVqznf5jfKMAlUDa2XkWL1/8mo8si4kyOtXlCOU/63LySNQHNL1OeUWLTae6
         uQgBkfmcwUK8yJgDeMSiLa9ZQv3PRSpzwSgbGF281QwUaV0SgZQLF/E/ZFhBim5rb0sO
         8CY803k9mkoEIii600s090w/z6qLvhnTMlZVzGCoJTbbH/i2FnZI/zvn4g3N4+Wc+E9a
         0hQA==
X-Gm-Message-State: AOJu0YxRnesKSVqEiPV2zbPcAocnAx3nHlE1/o3eJsZ5Hdk12J5rwL80
	xl8ZpnrOXXaUGcEkS4pdzB2B5GtD6n4e3vKb/1cHSZgc0GeFGDmS1fsNnnDMJKANgdlL+b8prZ6
	ecHs=
X-Gm-Gg: ASbGncsHn53sZQWV+iFds+Bh0bQLOPFOQJFimWS52LucmiDBq3eZtgdgk88hYKADGCP
	XU8MrX9iIGYLTUg1mjT9zvniJrCiB69Ygaw5rVJZlJPPFPO0UtQ0KDllxcRM20OgopRCOf2nn3A
	VY99jNFsPrtXXSlHRNNmBMKHGGNznjx+zfn2my6jgwskrPC5ySOnj4aFHyDuuiwyia1XfvOqkzl
	nFJvk7zQEQLneLMOFxpGmaB1O7ZqWest5Xv9xGlK2wnYMr1LMYcUDSLBu1q+1j6oNYFnEoA2kvb
	M3XcMnkn6pHuQOs42Z+doxrsYwIou6KNO9B2MuSoAaYca6JaJPlwBtXRtx8iSLrEbZPu1hgWyxT
	q
X-Google-Smtp-Source: AGHT+IGcBhiZmWGXk5MQ/2txRUcFka+ZazmP4CPBgUIe5XYWfxSEk+K6kyze0/jDOUELjObkLuoc3A==
X-Received: by 2002:a17:907:96a0:b0:aba:5f44:8822 with SMTP id a640c23a62f3a-abc099b838amr1102710066b.11.1740343780169;
        Sun, 23 Feb 2025 12:49:40 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb837378e7sm1625897866b.52.2025.02.23.12.49.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Feb 2025 12:49:39 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb8045c3f3so464547366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:49:39 -0800 (PST)
X-Received: by 2002:a17:907:7ea8:b0:ab7:eaf7:2bd6 with SMTP id
 a640c23a62f3a-abc09c26eb8mr1174832266b.49.1740343778409; Sun, 23 Feb 2025
 12:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Feb 2025 12:49:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi9Aa_sgCjSncJ7odZX_f=v5WZwWm+GuwXmVy1O+wiBsw@mail.gmail.com>
X-Gm-Features: AWEUYZm_Sm9e6BHgd4jNKYhIcTAtSYVr7aNaXKewviN4qesrqJe1Y5xjj6M8uXE
Message-ID: <CAHk-=wi9Aa_sgCjSncJ7odZX_f=v5WZwWm+GuwXmVy1O+wiBsw@mail.gmail.com>
Subject: Linux 6.14-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This continues to be the right kind of "boring" release: nothing in
particular stands out in rc4.

We've got all the usual driver fixes (ok, let networking than usual,
but gpu, sound, nvme, you name it, but it won't be huge), various
smaller filesystem fixes (xfs, smb, netfs, cachefs), core kernel and
networking fixes.

And all of it looks pretty small and non-threatening. The biggest
single patch is just a new self test.

So - knock wood - 6.14 looks to be on track, with everything looking good.

Please keep testing,

               Linus

---

Aaron Kling (1):
      drm/nouveau/pmu: Fix gp10b firmware guard

Abel Wu (1):
      bpf: Fix deadlock when freeing cgroup storage

Abhinav Kumar (1):
      drm/msm/dp: account for widebus and yuv420 during mode validation

Adrian Huang (1):
      tracing: Fix memory leak when reading set_event file

Alan Maguire (1):
      bpf: Fix softlockup in arena_map_free on 64k page kernel

Alexander Shiyan (1):
      arm64: dts: rockchip: Fix broken tsadc pinctrl names for rk3588

Amit Kumar Mahapatra (1):
      mtd: spi-nor: sst: Fix SST write failure

Andrew Jeffery (1):
      MAINTAINERS: Mark Andrew as M: for ASPEED MACHINE SUPPORT

Andrey Vatoropin (1):
      power: supply: da9150-fg: fix potential overflow

Andrii Nakryiko (2):
      bpf: unify VM_WRITE vs VM_MAYWRITE use in BPF map mmaping logic
      bpf: avoid holding freeze_mutex during mmap operation

Andy Yan (1):
      arm64: dts: rockchip: Fix lcdpwr_en pin for Cool Pi GenBook

Artur Rojek (1):
      irqchip/jcore-aic, clocksource/drivers/jcore: Fix jcore-pit
interrupt request

Baojun Xu (2):
      ALSA: hda/tas2781: Update tas2781 hda SPI driver
      ALSA: hda/tas2781: Fix index issue in tas2781 hda SPI driver

Bard Liao (2):
      ASoC: Intel: soc-acpi-intel-tgl-match: declare adr as ull
      ASoC: Intel: soc-acpi-intel-mtl-match: declare adr as ull

Bart Van Assche (2):
      md/raid*: Fix the set_queue_limits implementations
      procfs: fix a locking bug in a vmcore_add_device_dump() error path

Bartosz Golaszewski (3):
      gpiolib: check the return value of gpio_chip::get_direction()
      gpiolib: protect gpio_chip with SRCU in array_info paths in multi get=
/set
      gpiolib: don't bail out if get_direction() fails in gpiochip_add_data=
()

Breno Leitao (2):
      net: Add non-RCU dev_getbyhwaddr() helper
      arp: switch to dev_getbyhwaddr() in arp_req_set_public()

Brian Ochoa (1):
      docs: arch/x86/sva: Fix two grammar errors under Background and FAQ

Caleb Sander Mateos (4):
      block/merge: remove unnecessary min() with UINT_MAX
      nvme-tcp: fix connect failure on receiving partial ICResp PDU
      nvme/ioctl: add missing space in err message
      io_uring/rsrc: remove unused constants

Carlos Maiolino (1):
      xfs: Do not allow norecovery mount with quotacheck

Chen Ridong (1):
      memcg: avoid dead loop when setting memory.max

Chris Morgan (1):
      power: supply: axp20x_battery: Fix fault handling for AXP717

Christian Brauner (2):
      acct: perform last write from workqueue
      acct: block access to kernel internal filesystems

Christian Marangi (1):
      mtd: rawnand: qcom: fix broken config in qcom_param_page_type_exec

Christoph Hellwig (2):
      xfs: rename xfs_iomap_swapfile_activate to xfs_vm_swap_activate
      xfs: flush inodegc before swapon

Christophe Leroy (3):
      powerpc/code-patching: Disable KASAN report during patching via
temporary mm
      powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inli=
ne
      powerpc/code-patching: Fix KASAN hit by not flagging text
patching area as VM_ALLOC

Christopher Lentocha (1):
      nvme-pci: quirk Acer FA100 for non-uniqueue identifiers

Cong Wang (4):
      flow_dissector: Fix handling of mixed port and port-range keys
      selftests/net/forwarding: Add a test case for tc-flower of mixed
port and port-range
      flow_dissector: Fix port range key handling in BPF conversion
      selftests/bpf: Add a specific dst port matching

Cristian Ciocaltea (4):
      ASoC: SOF: amd: Add post_fw_run_delay ACP quirk
      ASoC: SOF: amd: Drop unused includes from Vangogh driver
      ASoC: SOF: amd: Handle IPC replies before FW_BOOT_COMPLETE
      ASoC: SOF: amd: Add branch prediction hint in ACP IRQ handler

Damien Le Moal (7):
      ata: libahci_platform: Do not set mask_port_map when not needed
      nvmet: pci-epf: Correctly initialize CSTS when enabling the controlle=
r
      nvmet: pci-epf: Do not uselessly write the CSTS register
      nvmet: pci-epf: Avoid RCU stalls under heavy workload
      nvme: tcp: Fix compilation warning with W=3D1
      nvme: Cleanup the definition of the controller config register fields
      nvmet: Use enum definitions instead of hardcoded values

Daniel Wagner (2):
      nvme-fc: rely on state transitions to handle connectivity loss
      nvme: only allow entering LIVE from CONNECTING state

Daniel Xu (3):
      bpf: verifier: Do not extract constant map keys for irrelevant maps
      bpf: selftests: Test constant key extraction on irrelevant maps
      bpf: verifier: Disambiguate get_constant_map_key() errors

Darrick J. Wong (2):
      xfs: fix online repair probing when CONFIG_XFS_ONLINE_REPAIR=3Dn
      xfs: fix data fork format filtering during inode repair

David Hildenbrand (2):
      nouveau/svm: fix missing folio unlock + put after
make_device_exclusive_range()
      mm/migrate_device: don't add folio to be freed to LRU in
migrate_device_finalize()

David Howells (3):
      netfs: Fix a number of read-retry hangs
      netfs: Add retry stat counters
      netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs queu=
ed

Dmitry Baryshkov (3):
      drm/msm/dpu: skip watchdog timer programming through TOP on >=3D SM84=
50
      drm/msm/dpu: enable DPU_WB_INPUT_CTRL for DPU 5.x
      drm/msm/dpu: correct LM pairing for SM6150

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on Positivo ARN50

Eric Biggers (1):
      x86/cpufeatures: Make AVX-VNNI depend on AVX

Ethan Carter Edwards (1):
      drm/msm/dpu: Fix uninitialized variable

Feng Tang (1):
      mailmap: add entry for Feng Tang

Fenghua Yu (1):
      MAINTAINERS: Change maintainer for RDT

Florian Fainelli (1):
      tools/mm: fix build warnings with musl-libc

Friedrich Vock (1):
      cgroup/dmem: Don't open-code css_for_each_descendant_pre

Gavrilov Ilia (1):
      drop_monitor: fix incorrect initialization order

Geert Uytterhoeven (3):
      firmware: imx: IMX_SCMI_MISC_DRV should depend on ARCH_MXC
      platform: cznic: CZNIC_PLATFORMS should depend on ARCH_MVEBU
      i2c: core: Allocate temporary client dynamically

Gustavo A. R. Silva (1):
      smb: client, common: Avoid multiple
-Wflex-array-member-not-at-end warnings

Hannes Reinecke (1):
      nvmet: Fix crash when a namespace is disabled

Hans de Goede (1):
      power: supply: core: Fix extension related lockdep warning

Haoxiang Li (3):
      nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      smb: client: Add check for next_buffer in receive_encrypted_standard(=
)
      soc: loongson: loongson2_guts: Add check for devm_kstrdup()

Hector Martin (2):
      apple-nvme: Release power domains when probe fails
      apple-nvme: Support coprocessors left idle

Heiko Carstens (2):
      s390: Update defconfigs
      s390/boot: Fix ESSA detection

Heiko Stuebner (1):
      arm64: dts: rockchip: fix fixed-regulator renames on rk3399-gru devic=
es

Hugo Villeneuve (1):
      drm: panel: jd9365da-h3: fix reset signal polarity

Hyeonggon Yoo (1):
      mm/zswap: fix inconsistency when zswap_store_page() fails

Imre Deak (4):
      drm/i915/dsi: Use TRANS_DDI_FUNC_CTL's own port width macro
      drm/i915/ddi: Fix HDMI port width programming in DDI_BUF_CTL
      drm/i915/dp: Fix error handling during 128b/132b link training
      drm/i915/dp: Fix disabling the transcoder function in 128b/132b mode

Jakub Kicinski (3):
      MAINTAINERS: create entry for ethtool MAC merge
      tcp: adjust rcvq_space after updating scaling ratio
      MAINTAINERS: trim the GVE entry

Janne Grunau (1):
      MAINTAINERS: arm: apple: Add Janne as maintainer

Jared Kangas (1):
      bpf: Remove unnecessary BTF lookups in bpf_sk_storage_tracing_allowed

Jeff Johnson (1):
      .mailmap: add entries for Jeff Johnson

Jens Axboe (1):
      io_uring: fix spelling error in uapi io_uring.h

Jeroen de Borst (1):
      gve: Update MAINTAINERS

Jessica Zhang (2):
      drm/msm/dpu: Disable dither in phys encoder cleanup
      drm/msm/dpu: Drop extraneous return in dpu_crtc_reassign_planes()

Jiayuan Chen (5):
      strparser: Add read_sock callback
      bpf: Fix wrong copied_seq calculation
      bpf: Disable non stream socket for strparser
      selftests/bpf: Fix invalid flag of recv()
      selftests/bpf: Add strparser test for bpf

Johan Korsnes (1):
      gpio: vf610: add locking to gpio direction functions

John Keeping (1):
      ASoC: rockchip: i2s-tdm: fix shift config for SND_SOC_DAIFMT_DSP_[AB]

John Veness (1):
      ALSA: hda/conexant: Add quirk for HP ProBook 450 G4 mute LED

Joshua Washington (1):
      gve: set xdp redirect target only when it is available

Jos=C3=A9 Roberto de Souza (1):
      drm/xe: Make GUC binaries dump consistent with other binaries in
devcoredump

Julian Ruess (1):
      s390/ism: add release function for struct device

Junnan Wu (1):
      vsock/virtio: fix variables initialization during resuming

Kailang Yang (1):
      ALSA: hda/realtek: Fixup ALC225 depop procedure

Kan Liang (1):
      perf/x86/intel: Fix event constraints for LNC

Karol Herbst (1):
      MAINTAINERS: Remove myself

Kemeng Shi (1):
      test_xarray: fix failure in check_pause when CONFIG_XARRAY_MULTI
is not defined

Kent Overstreet (3):
      bcachefs: Fix fsck directory i_size checking
      bcachefs: Fix bch2_indirect_extent_missing_error()
      bcachefs: Fix srcu lock warning in btree_update_nodes_written()

Komal Bajaj (1):
      EDAC/qcom: Correct interrupt enable register configuration

Konrad Dybcio (1):
      drm/msm/a6xx: Only print the GMU firmware version once

Kory Maincent (1):
      net: pse-pd: pd692x0: Fix power limit retrieval

Krzysztof Karas (1):
      drm/i915/gt: Use spin_lock_irqsave() in interruptible context

Krzysztof Kozlowski (3):
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG0 updated from driver side
      drm/msm/dsi/phy: Protect PHY_CMN_CLK_CFG1 against clock driver
      drm/msm/dsi/phy: Do not overwite PHY_CMN_CLK_CFG1 when choosing
bitclk source

Kumar Kartikeya Dwivedi (1):
      bpf: Handle allocation failure in acquire_lock_state

Kuninori Morimoto (4):
      ASoC: simple-card-utils.c: add missing dlc->of_node
      ASoC: rsnd: indicate unsupported clock rate
      ASoC: rsnd: don't indicate warning on rsnd_kctrl_accept_runtime()
      ASoC: rsnd: adjust convert rate limitation

Kuniyuki Iwashima (7):
      net: Add rx_skb of kfree_skb to raw_tp_null_args[].
      geneve: Fix use-after-free in geneve_find_dev().
      net: Add net_passive_inc() and net_passive_dec().
      net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net()=
.
      dev: Use rtnl_net_dev_lock() in unregister_netdev().
      gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      geneve: Suppress list corruption splat in geneve_destroy_tunnels().

Kurt Borja (1):
      ACPI: platform_profile: Fix memory leak in profile_class_is_visible()

Linus Torvalds (1):
      Linux 6.14-rc4

Lucas De Marchi (2):
      drm/xe: Fix error handling in xe_irq_install()
      drm/xe/guc: Fix size_t print format

Luiz Capitulino (1):
      mm: hugetlb: avoid fallback for specific node allocation of 1G pages

Lukas Herbolt (1):
      xfs: do not check NEEDSREPAIR if ro,norecovery mount.

Lukasz Czechowski (2):
      arm64: dts: rockchip: Move uart5 pin configuration to px30 ringneck S=
oM
      arm64: dts: rockchip: Disable DMA for uart5 on px30-ringneck

Marc Zyngier (1):
      irqchip/gic-v3: Fix rk3399 workaround when secure interrupts are enab=
led

Marijn Suijten (1):
      drm/msm/dpu: Don't leak bits_per_component into random DSC_ENC fields

Mark Brown (1):
      selftests/mm: fix check for running THP tests

Mathieu Desnoyers (1):
      sched: Compact RSEQ concurrency IDs with reduced threads and affinity

Maurizio Lombardi (1):
      nvme-tcp: add basic support for the C2HTermReq PDU

Michael Jeanson (1):
      rseq: Fix rseq registration with CONFIG_DEBUG_RSEQ

Michal Luczaj (4):
      sockmap, vsock: For connectible sockets allow only connected
      vsock/bpf: Warn on socket without transport
      selftest/bpf: Adapt vsock_delete_on_close to sockmap rejecting unconn=
ected
      selftest/bpf: Add vsock test for sockmap rejecting unconnected

Ming Lei (1):
      block: fix NULL pointer dereferenced within __blk_rq_map_sg

Nam Cao (1):
      ALSA: Switch to use hrtimer_setup()

Nick Child (1):
      ibmvnic: Don't reference skb after sending to VIOS

Nick Desaulniers (2):
      mailmap: update Nick's entry
      MAINTAINERS: update Nick's contact info

Nick Hu (1):
      net: axienet: Set mac_managed_pm

Nikita Zhandarovich (1):
      ASoC: fsl_micfil: Enable default case in micfil_set_quality()

Niklas Cassel (1):
      arm64: dts: rockchip: disable IOMMU when running rk3588 in PCIe
endpoint mode

Niravkumar L Rabara (5):
      mtd: rawnand: cadence: fix error code in cadence_nand_init()
      mtd: rawnand: cadence: use dma_map_resource for sdma address
      mtd: rawnand: cadence: fix incorrect device in dma_unmap_single
      dt-bindings: mtd: cadence: document required clock-names
      mtd: rawnand: cadence: fix unchecked dereference

Pali Roh=C3=A1r (2):
      cifs: Throw -EOPNOTSUPP error on unsupported reparse point type
from parse_reparse_point()
      cifs: Treat unhandled directory name surrogate reparse points as
mount directory nodes

Paolo Abeni (2):
      net: allow small head cache usage with large MAX_SKB_FRAGS values
      Revert "net: skb: introduce and use a single page frag cache"

Patrick Wildt (1):
      arm64: dts: rockchip: adjust SMMU interrupt type on rk3588

Paulo Alcantara (1):
      smb: client: fix chmod(2) regression with ATTR_READONLY

Pavel Begunkov (6):
      io_uring: prevent opcode speculation
      lib/iov_iter: fix import_iovec_ubuf iovec management
      io_uring/rw: forbid multishot async reads
      io_uring/rw: don't directly use ki_complete
      io_uring/rw: move ki_complete init into prep
      io_uring/rw: clean up mshot forced sync mode

Peng Fan (1):
      firmware: arm_scmi: imx: Correct tx size of scmi_imx_misc_ctrl_set

Peter Ujfalusi (6):
      ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data(=
)
      ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
      ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
      ASoC: SOF: Intel: pci-ptl: Add support for PTL-H
      ASoC: Intel: soc-acpi-intel-ptl-match: revise typo of rt712_vb +
rt1320 support
      ASoC: Intel: soc-acpi-intel-ptl-match: revise typo of
rt713_vb_l2_rt1320_l13

Pierre Riteau (1):
      net/sched: cls_api: fix error handling causing NULL dereference

Pierre-Louis Bossart (3):
      PCI: pci_ids: add INTEL_HDA_PTL_H
      ALSA: hda: intel-dsp-config: Add PTL-H support
      ALSA: hda: hda-intel: add Panther Lake-H support

Qi Zheng (1):
      mm: pgtable: fix incorrect reclaim of non-empty PTE pages

Ricardo Ca=C3=B1uelo Navarro (1):
      mm,madvise,hugetlb: check for 0-length range after end address adjust=
ment

Richard Fitzgerald (2):
      ASoC: Intel: sof_sdw: Add lookup of quirk using PCI subsystem ID
      ASoC: Intel: sof_sdw: Add quirk for Asus Zenbook S14

Rob Clark (1):
      drm/msm: Avoid rounding up to one jiffy

Rob Herring (Arm) (1):
      dt-bindings: rockchip: pmu: Ensure all properties are defined

Ruozhu Li (1):
      nvmet-rdma: recheck queue state is LIVE in state lock in recv done

Sabrina Dubroca (1):
      tcp: drop secpath at the same time as we currently drop dst

Sami Tolvanen (1):
      s390/purgatory: Use -D__DISABLE_EXPORTS

Sebastian Andrzej Siewior (1):
      ftrace: Correct preemption accounting for function tracing.

Shenghao Ding (1):
      ASoC: tas2781: drop a redundant code

Shengjiu Wang (1):
      ASoC: imx-audmix: remove cpu_mclk which is from cpu dai device

Shigeru Yoshida (2):
      bpf, test_run: Fix use-after-free issue in eth_skb_pkt_type()
      selftests/bpf: Adjust data size to have ETH_HLEN

Stefan Binding (2):
      ASoC: cs35l41: Fallback to using HID for system_name if no SUB
is available
      ASoC: cs35l41: Fix acpi_device_hid() not found

Stefano Garzarella (1):
      virtio_snd.h: clarify that `controls` depends on VIRTIO_SND_F_CTLS

Stephan Gerhold (2):
      net: wwan: mhi_wwan_mbim: Silence sequence number glitch errors
      irqchip/qcom-pdc: Workaround hardware register bug on X1E80100

Steve French (1):
      smb311: failure to open files of length 1040 when mounting with
SMB3.1.1 POSIX extensions

Steven Rostedt (5):
      ftrace: Fix accounting of adding subops to a manager ops
      ftrace: Do not add duplicate entries in subops manager ops
      fprobe: Always unregister fgraph function from ops
      fprobe: Fix accounting of when to unregister from function graph
      selftests/ftrace: Update fprobe test to check enabled_functions file

Su Hui (1):
      accel/amdxdna: Add missing include linux/slab.h

Sumit Garg (1):
      tee: optee: Fix supplicant wait loop

Takashi Iwai (1):
      ALSA: seq: Drop UMP events when no UMP-conversion is set

Terry Cheong (1):
      ASoC: SOF: Intel: hda: add softdep pre to snd-hda-codec-hdmi module

Thomas Wei=C3=9Fschuh (1):
      uprobes: Don't use %pK through printk

Tianling Shen (1):
      arm64: dts: rockchip: change eth phy mode to rgmii-id for
orangepi r1 plus lts

Uday M Bhat (1):
      ASoC: Intel: sof_sdw: Add support for Fatcat board with BT
offload enabled in PTL platform

Uday Shankar (1):
      io-wq: backoff when retrying worker creation

Vaishnav Achath (1):
      arm64: defconfig: Enable TISCI Interrupt Router and Aggregator

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Make sure all planes in use by the joiner have their
crtc included

Vitaly Rodionov (3):
      ASoC: arizona/madera: use fsleep() in up/down DAPM event delays.
      ALSA: hda/cirrus: Correct the full scale volume set logic
      ALSA: hda/cirrus: Reduce codec resume time

Waiman Long (1):
      kasan: don't call find_vm_area() in a PREEMPT_RT kernel

Wang Yaxin (2):
      getdelays: fix error format characters
      taskstats: modify taskstats version

Wentao Liang (1):
      ALSA: hda: Add error check for snd_ctl_rename_id() in
snd_hda_create_dig_out_ctls()

Yan Zhai (2):
      bpf: skip non exist keys in generic_map_lookup_batch
      selftests: bpf: test batch lookup on array of maps with holes

Yu-Chun Lin (1):
      sctp: Fix undefined behavior in left shift operation

