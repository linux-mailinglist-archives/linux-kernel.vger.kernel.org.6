Return-Path: <linux-kernel+bounces-553429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52D8A58970
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 01:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B67C3A99D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2CF25760;
	Mon, 10 Mar 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W7Dl9qOn"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F349A29
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741564848; cv=none; b=ZbDnHIu5v/4QstTyfbSJGitnsXmr35jsrv93O0mZSG7tlSO1TSHrqRQD4ipNYdTXOxfIO598SZYNOWdIjzgrqKYeBIZS4JhVCjsremUk/EEQxc0BR75VcYugk5+3vos+TIa3K0r/R5wt1WZ874/mJgzgl9aW8/SKrz/y6K3dVtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741564848; c=relaxed/simple;
	bh=zx1geYpl6TnnrftU9G8ntbCywAI2ldBWZtrg0araP0M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aV0Y/lRYv0YF6OUGno5qvwCE9vNAcRVfZvi68bU9C2jU6RyLFJ4VM/bqYWEM90S2d0Zco5b1ik+F10hXKs23FlD3m6OlaBUQJYuPgjkIF9ppWqgP4gF8Vo+lXIe+RX7TwCpfn32cOy1mA5VlE5br204DR/wNdZni8VSVW1pXb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W7Dl9qOn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso4981070a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741564843; x=1742169643; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PdkLOk4cG0vTi+GDi81GLU1VDRn35VcCptzfVbCIPXs=;
        b=W7Dl9qOngA1yaMilJOIunv+kxrGTDvd6U42GItfdEuK/cZwD1gK7oCbB690gBAlEq+
         xSPiRTmvmY9OcdM0LIsD+mNVCO4lMbl6Q+/PXs6MK6kzlBcnuozn7uukUFgwvl90gMY/
         yB9e7qglG23kgvBrbkpPGD00Rdn4xGhTRexMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741564843; x=1742169643;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PdkLOk4cG0vTi+GDi81GLU1VDRn35VcCptzfVbCIPXs=;
        b=ErcHFuGv60sNObcalCWUuRJRKuTBtWT26ML3o5XIZLt+0aasyuUTtIrjDXR4FX0zeA
         dmHjo/LB22uAPaOsX+NSC6BkCGi0UH25lBmiEYFFnjTRN2cRt60ReDVwIDapaI8+2dRq
         +fiFXl3Q6oaJ57d2dNT0c65GVv8fqHpmVLI8GMjO5gLifJgcEHqCmCTCXFkKzyA8LSKr
         vj8JpMeDDLrQqiDaAnkwGcEubeAOqfrZnapYEQEGR7WEU45/u4vVXq9JhZUBGeI9ezPx
         AeNRA62/m+J0fHp5qCC6ZijkQgT0xDUC5jx/boAMo1iSfhFutIp5JS5gV/Z51BVyZ/Ok
         2+kQ==
X-Gm-Message-State: AOJu0YzLgmI8PE0TKBZo0fxTtp1gu5L1fCb57O85jIAtYP6kztzE0JfI
	a+3UUJ/5lFSDIrZuHyap487Nf939T3Tc328lSct0DdJIulscp09MS24h1/p4NLPLoDHutPQUZfq
	vaQo=
X-Gm-Gg: ASbGncv67YVf1qJzcHjRTIwQG16uizhlPcPkjXdR7wEAMpLGWrNO271+d+LHq9/mLEy
	18Lc84CP28ku2oreQW54a7FzZuQWDmAp7etZcXyQg9F7JTFhN+OfI48kmlp4TKmP1HWO2a5op3I
	AXciCeGUPfsun1FZDO+HRvQ9pm9S8M0UioFSKHKoUCWyr4/spVLkGPhhBwp4R7JECZkYlpfd2Cd
	MPbSicJ6DXH9uaC691iDOpft02/ciNSwN1IOi/UOxp4NQZFCaH3D1zu/5pnVvWQERaFpTScGvIr
	iX4ylaWxjCe+p04J35Fh2cALo7+96viO3BA4342vNUda2ek1uom8PAouRqUb8LZ4+M9GcHh4zyj
	07Yap5vvh25Tjn1ojYpc=
X-Google-Smtp-Source: AGHT+IFJnQ2k0dS6jAbLqOHeLMjXPEZtP3sMWGmSO439QrOOMehZdsSUi588/G+BI1T8rkI2b9iBQA==
X-Received: by 2002:a05:6402:34cf:b0:5e6:414b:525c with SMTP id 4fb4d7f45d1cf-5e6414b5457mr5766295a12.25.1741564842898;
        Sun, 09 Mar 2025 17:00:42 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768fa17sm5888047a12.72.2025.03.09.17.00.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 17:00:41 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso746468366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 17:00:41 -0700 (PDT)
X-Received: by 2002:a17:907:1b2a:b0:ac1:ff43:82ad with SMTP id
 a640c23a62f3a-ac2525de599mr1663495866b.12.1741564840320; Sun, 09 Mar 2025
 17:00:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Mar 2025 14:00:23 -1000
X-Gmail-Original-Message-ID: <CAHk-=whWKLW6k4NSCDq2SzfAKm4NM2fPj=+dgNwrceozd_cc9Q@mail.gmail.com>
X-Gm-Features: AQ5f1JrJQmAd8QJVs5iQVqh1NNT5w8E7vn4YeDluriuaWzdVheT1MD1w8Gqq_Jk
Message-ID: <CAHk-=whWKLW6k4NSCDq2SzfAKm4NM2fPj=+dgNwrceozd_cc9Q@mail.gmail.com>
Subject: Linux 6.14-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release remains on track, nothing special to report. The biggest
patch here is for the AMD microcode signing snafu, other than that it
all looks entirely regular with small fixes spread fairly normally
across the board.

Shortlog appended for people who want to get a flavor of the details,

                Linus

---

Ahmed Genidi (1):
      KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()

Ahmed S. Darwish (3):
      x86/cacheinfo: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Validate CPUID leaf 0x2 EDX output
      x86/cpu: Properly parse CPUID leaf 0x2 TLB descriptor 0x63

Aiden Ma (1):
      doc: correcting two prefix errors in idmappings.rst

Alessio Belle (1):
      drm/imagination: Fix timestamps in firmware traces

Alex Henrie (1):
      HID: apple: disable Fn key handling on the Omoton KB066

Alexander Shishkin (3):
      intel_th: msu: Fix less trivial kernel-doc warnings
      intel_th: pci: Add Panther Lake-H support
      intel_th: pci: Add Panther Lake-P/U support

Alexander Usyskin (1):
      mei: me: add panther lake P DID

Alexander Wetzel (3):
      wifi: mac80211: Cleanup sta TXQs on flush
      wifi: mac80211: remove debugfs dir for virtual monitor
      wifi: mac80211: Fix sparse warning for monitor_sdata

Alexey Kardashevskiy (1):
      virt: sev-guest: Move SNP Guest Request data pages handling
under snp_cmd_mutex

Andrei Kuchynski (1):
      usb: typec: ucsi: Fix NULL pointer access

Andrew Cooper (1):
      x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()

Andrew Martin (1):
      drm/amdkfd: Fix NULL Pointer Dereference in KFD queue

Andy Shevchenko (2):
      intel_th: msu: Fix kernel-doc warnings
      eeprom: digsy_mtc: Make GPIO lookup table match the device

Angelo Dureghello (3):
      iio: dac: ad3552r: clear reset status flag
      dt-bindings: iio: dac: adi-axi-adc: fix ad7606 pwm-names
      iio: adc: ad7606: fix wrong scale available

AngeloGioacchino Del Regno (1):
      usb: typec: tcpci_rt1711h: Unmask alert interrupts to fix functionali=
ty

Antheas Kapenekakis (2):
      ALSA: hda/realtek: Remove (revert) duplicate Ally X config
      ALSA: hda/realtek: Fix Asus Z13 2025 audio

Antoine Tenart (1):
      net: gso: fix ownership in __udp_gso_segment

Antonio Quartulli (1):
      mailmap: remove unwanted entry for Antonio Quartulli

Ard Biesheuvel (1):
      x86/boot: Sanitize boot params before parsing command line

Arnd Bergmann (3):
      vbox: add HAS_IOPORT dependency
      ALSA: hda: realtek: fix incorrect IS_REACHABLE() usage
      kbuild: hdrcheck: fix cross build with clang

Badhri Jagan Sridharan (1):
      usb: dwc3: gadget: Prevent irq storm when TH re-executes

Baolin Wang (1):
      mm: shmem: fix potential data corruption during shmem swapin

Barry Song (1):
      mm: fix kernel BUG when userfaultfd_move encounters swapcache

Bibo Mao (5):
      LoongArch: Set max_pfn with the PFN of the last page
      LoongArch: Set hugetlb mmap base address aligned with pmd size
      LoongArch: KVM: Add interrupt checking for AVEC
      LoongArch: KVM: Reload guest CSR registers after sleep
      LoongArch: KVM: Fix GPA size issue about VM

Borislav Petkov (AMD) (7):
      x86/microcode/AMD: Remove ugly linebreak in
__verify_patch_section() signature
      x86/microcode/AMD: Remove unused save_microcode_in_initrd_amd()
declarations
      x86/microcode/AMD: Merge early_apply_microcode() into its single call=
site
      x86/microcode/AMD: Get rid of the _load_microcode_amd() forward
declaration
      x86/microcode/AMD: Add get_patch_level()
      x86/microcode/AMD: Load only SHA256-checksummed patches
      x86/microcode/AMD: Add some forgotten models to the SHA check

Brendan King (3):
      drm/imagination: avoid deadlock on fence release
      drm/imagination: Hold drm_gem_gpuva lock for unmap
      drm/imagination: only init job done fences once

Breno Leitao (1):
      block: Name the RQF flags enum

Brian Geffon (1):
      mm: fix finish_fault() handling for large folios

Carlos Llamas (1):
      binderfs: fix use-after-free in binder_devices

Christian A. Ehrhardt (1):
      acpi: typec: ucsi: Introduce a ->poll_cci method

Christian Heusel (1):
      Revert "drivers/card_reader/rtsx_usb: Restore interrupt based detecti=
on"

Christoph Hellwig (4):
      xfs: reduce context switches for synchronous buffered I/O
      xfs: decouple buffer readahead from the normal buffer read path
      xfs: remove most in-flight buffer accounting
      xfs: remove the XBF_STALE check from xfs_buf_rele_cached

Claudiu Beznea (3):
      usb: renesas_usbhs: Call clk_put()
      usb: renesas_usbhs: Use devm_usb_get_phy()
      usb: renesas_usbhs: Flush the notify_hotplug_work

Colin Ian King (2):
      HID: debug: Fix spelling mistake "Messanger" -> "Messenger"
      HID: intel-thc-hid: Fix spelling mistake "intput" -> "input"

Dan Carpenter (1):
      nvme-tcp: fix signedness bug in nvme_tcp_init_connection()

Daniel B=C3=A1rta (1):
      ALSA: hda: Fix speakers on ASUS EXPERTBOOK P5405CSA 1.0

Daniil Dulov (1):
      HID: appleir: Fix potential NULL dereference at raw event handle

Dave Airlie (1):
      drm/nouveau: select FW caching

David E. Box (1):
      platform/x86/intel/vsec: Add Diamond Rapids support

Dheeraj Reddy Jonnalagadda (1):
      iio: proximity: Fix use-after-free in hx9023s_send_cfg()

Dmitry Panchenko (1):
      platform/x86: intel-hid: fix volume buttons on Microsoft Surface
Go 4 tablet

Eddie James (1):
      MAINTAINERS: change maintainer for FSI

Elizabeth Figura (1):
      ntsync: Check wait count based on byte size.

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't dump the firmware state upon RFKILL
while suspend
      wifi: iwlwifi: mvm: don't try to talk to a dead firmware
      wifi: iwlwifi: mvm: use the right version of the rate API

Eric Dumazet (1):
      llc: do not use skb_get() before dev_queue_xmit()

Eric Sandeen (1):
      exfat: short-circuit zero-byte writes in exfat_file_write_iter

Erik Schumacher (1):
      hwmon: (ad7314) Validate leading zero bits and return error

Even Xu (1):
      HID: Intel-thc-hid: Intel-quickspi: Correct device state after S4

Fabrizio Castro (1):
      gpio: rcar: Fix missing of_node_put() call

Fedor Pchelkin (1):
      usb: typec: ucsi: increase timeout for PPM reset operations

Gabriel Krisman Bertazi (1):
      Revert "mm/page_alloc.c: don't show protection in zone's
->lowmem_reserve[] for empty zone"

Ge Yang (1):
      mm/hugetlb: wait for hugetlb folios to be freed

Hans de Goede (1):
      mei: vsc: Use "wakeuphostint" when getting the host wakeup GPIO

Hao Zhang (1):
      mm/page_alloc: fix uninitialized variable

Haoxiang Li (6):
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_remote_name()
      Bluetooth: Add check for mgmt_alloc_skb() in mgmt_device_connected()
      m68k: sun3: add check for __pgd_alloc()
      rapidio: fix an API misues when rio_add_net() fails
      rapidio: add check for rio_add_net() in rio_scan_alloc_net()
      btrfs: fix a leaked chunk map issue in read_one_chunk()

Haoyu Li (1):
      drivers: virt: acrn: hsm: Use kzalloc to avoid info leak in pmcmd_ioc=
tl

Heiko Carstens (1):
      s390/traps: Fix test_monitor_call() inline assembly

Herbert Xu (1):
      cred: Fix RCU warnings in override/revert_creds

Hoku Ishibe (1):
      ALSA: hda: intel: Add Dell ALC3271 to power_save denylist

Huacai Chen (1):
      LoongArch: Use polling play_dead() when resuming from hibernation

Icenowy Zheng (2):
      nvme-pci: clean up CMBMSC when registering CMB fails
      nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

Ilan Peer (2):
      wifi: iwlwifi: Free pages allocated when failing to build A-MSDU
      wifi: iwlwifi: Fix A-MSDU TSO preparation

Ingo Molnar (1):
      x86/mm: Define PTRS_PER_PMD for assembly code too

Inochi Amaoto (1):
      kbuild: install-extmod-build: Fix build when specifying KBUILD_OUTPUT

Jakub Kicinski (1):
      net: dsa: rtl8366rb: don't prompt users for LED control

Jani Nikula (1):
      drm/i915/mst: update max stream count to match number of pipes

Jarkko Sakkinen (1):
      x86/sgx: Fix size overflows in sgx_encl_create()

Jason Xing (1):
      net-timestamp: support TCP GSO case for a few missing flags

Javier Carrasco (1):
      iio: light: apds9306: fix max_scale_nano values

Jens Axboe (1):
      io_uring/rw: ensure reissue path is correctly handled for IOPOLL

Jiayuan Chen (1):
      ppp: Fix KMSAN uninit-value warning with bpf

Johan Hovold (1):
      bus: simple-pm-bus: fix forced runtime PM use

Johannes Berg (6):
      wifi: iwlwifi: fw: allocate chained SG tables for dump
      wifi: iwlwifi: mvm: clean up ROC on failure
      wifi: iwlwifi: limit printed string from FW file
      wifi: mac80211: fix MLE non-inheritance parsing
      wifi: mac80211: fix vendor-specific inheritance
      wifi: nl80211: disable multi-link reconfiguration

John Hubbard (1):
      Revert "selftests/mm: remove local __NR_* definitions"

Justin Iurman (2):
      net: ipv6: fix dst ref loop in ila lwtunnel
      net: ipv6: fix missing dst ref drop in ila lwtunnel

K Prateek Nayak (1):
      include/linux/pipe_fs_i: Add htmldoc annotation for "head_tail" membe=
r

Kailang Yang (2):
      ALSA: hda/realtek - add supported Mic Mute LED for Lenovo platform
      ALSA: hda/realtek: update ALC222 depop optimize

Kees Cook (1):
      coredump: Only sort VMAs when core_sort_vma sysctl is set

Keith Busch (1):
      nvme-ioctl: fix leaked requests on mapping error

Kemeng Shi (3):
      mm: swap: add back full cluster when no entry is reclaimed
      mm: swap: use correct step in loop to wait all clusters in
wait_for_allocation()
      mm, swap: avoid BUG_ON in relocate_cluster()

Kenneth Feng (1):
      drm/amd/pm: always allow ih interrupt from fw

Kent Overstreet (3):
      bcachefs: Don't set BCH_FEATURE_incompat_version_field unless request=
ed
      bcachefs: Fix bch2_dev_journal_alloc() spuriously failing
      bcachefs: copygc now skips non-rw devices

Koichiro Den (1):
      gpio: aggregator: protect driver attr handlers against module unload

Krister Johansen (1):
      mptcp: fix 'scheduling while atomic' in mptcp_pm_nl_append_new_local_=
addr

Linus Torvalds (8):
      fs/pipe: Read pipe->{head,tail} atomically outside pipe->mutex
      fs/pipe: Fix pipe_occupancy() with 16-bit indexes
      fs/pipe: remove buggy and unused 'helper' function
      fs/pipe: express 'pipe_empty()' in terms of 'pipe_occupancy()'
      fs/pipe: do not open-code pipe head/tail logic in FIONREAD
      fs/pipe: fix pipe buffer index use in FUSE
      fs/pipe: add simpler helpers for common cases
      Linux 6.14-rc6

Lorenzo Bianconi (1):
      net: dsa: mt7530: Fix traffic flooding for MMIO devices

Lorenzo Stoakes (1):
      mm: abort vma_modify() on merge out of memory failure

Luca Ceresoli (1):
      drivers: core: fix device leak in __fw_devlink_relax_cycles()

Luca Weiss (3):
      net: ipa: Fix v4.7 resource group names
      net: ipa: Fix QSB data for v4.7
      net: ipa: Enable checksum for IPA_ENDPOINT_AP_MODEM_{RX,TX} for v4.7

Ma Ke (1):
      drm/amd/display: Fix null check for pipe_ctx->plane_state in
resource_build_scaling_params

Ma Wupeng (3):
      mm: memory-failure: update ttu flag inside unmap_poisoned_folio
      mm: memory-hotplug: check folio ref count first in do_migrate_range
      hwpoison, memory_hotplug: lock folio before unmap hwpoisoned folio

Maarten Lankhorst (1):
      drm/xe: Remove double pageflip

Manivannan Sadhasivam (1):
      bus: mhi: host: pci_generic: Use pci_try_reset_function() to
avoid deadlock

Marc Zyngier (1):
      xhci: Restrict USB4 tunnel detection for USB3 devices to Intel hosts

Marek Szyprowski (1):
      usb: gadget: Fix setting self-powered state on suspend

Mario Limonciello (4):
      platform/x86/amd/pmf: Initialize and clean up `cb_mutex`
      ACPI: platform_profile: Add support for hidden choices
      platform/x86/amd: pmf: Add 'quiet' to hidden choices
      platform/x86/amd: pmf: Add balanced-performance to hidden choices

Mark Rutland (1):
      KVM: arm64: Initialize HCR_EL2.E2H early

Markus Burri (1):
      iio: adc: ad7192: fix channel select

Masami Hiramatsu (Google) (4):
      tracing: tprobe-events: Fix a memory leak when tprobe with $retval
      tracing: tprobe-events: Reject invalid tracepoint name
      tracing: fprobe-events: Log error for exceeding the number of entry a=
rgs
      tracing: probe-events: Remove unused MAX_ARG_BUF_LEN macro

Matt Johnston (1):
      mctp i3c: handle NULL header address

Matthew Auld (1):
      drm/xe/userptr: properly setup pfn_flags_mask

Matthew Brost (1):
      drm/xe: Add staging tree for VM binds

Matthias Proske (1):
      wifi: brcmfmac: keep power during suspend if board requires it

Maud Spierings (1):
      hwmon: (ntc_thermistor) Fix the ncpXXxh103 sensor table

Maurizio Lombardi (3):
      nvmet: remove old function prototype
      nvme-tcp: Fix a C2HTermReq error message
      nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()

Maxime Chevallier (1):
      net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered a=
rch

Miao Li (1):
      usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage
Card Reader

Michal Koutn=C3=BD (1):
      pid: Do not set pid_max in new pid namespaces

Michal Pecio (2):
      usb: xhci: Enable the TRB overfetch quirk on VIA VL805
      usb: xhci: Fix host controllers "dying" after suspend and resume

Mike Lothian (1):
      ntsync: Set the permissions to be 0666

Mike Snitzer (1):
      NFS: fix nfs_release_folio() to not deadlock via kcompactd writeback

Mingcong Bai (1):
      platform/x86: thinkpad_acpi: Add battery quirk for ThinkPad X131e

Miri Korenblit (1):
      wifi: iwlwifi: fw: avoid using an uninitialized variable

Murad Masimov (1):
      ALSA: usx2y: validate nrpacks module parameter on probe

Namjae Jeon (9):
      MAINTAINERS: update email address in cifs and ksmbd entry
      ksmbd: fix out-of-bounds in parse_sec_desc()
      ksmbd: fix type confusion via race condition when using
ipc_msg_send_request
      ksmbd: fix use-after-free in smb2_lock
      ksmbd: fix bug on trap in smb2_lock
      smb: common: change the data type of num_aces to le16
      ksmbd: fix incorrect validation for num_aces field of smb_acl
      cifs: fix incorrect validation for num_aces field of smb_acl
      exfat: fix soft lockup in exfat_clear_bitmap

Naohiro Aota (1):
      btrfs: zoned: fix extent range end unlock in cow_file_range()

Nayab Sayed (1):
      iio: adc: at91-sama5d2_adc: fix sama7g5 realbits value

Nikita Zhandarovich (2):
      usb: atm: cxacru: fix a flaw in existing endpoint checks
      wifi: cfg80211: regulatory: improve invalid hints checking

Niklas S=C3=B6derlund (1):
      gpio: rcar: Use raw_spinlock to protect register access

Nikolay Aleksandrov (1):
      be2net: fix sleeping while atomic bugs in be_ndo_bridge_getlink

Nikunj A Dadhania (1):
      virt: sev-guest: Allocate request data dynamically

Olivier Gayot (1):
      block: fix conversion of GPT partition name to 7-bit

Oscar Maes (1):
      vlan: enforce underlying device type

Paul Fertser (1):
      hwmon: (peci/dimmtemp) Do not provide fake thresholds data

Pawan Gupta (2):
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC

Pawel Chmielewski (1):
      intel_th: pci: Add Arrow Lake support

Pawel Laszczak (1):
      usb: hub: lack of clearing xHC resources

Peiyang Wang (1):
      net: hns3: make sure ptp clock is unregister and freed if
hclge_ptp_get_cycle returns an error

Peter Zijlstra (2):
      perf/core: Fix pmus_lock vs. pmus_srcu ordering
      perf/core: Fix perf_pmu_register() vs. perf_init_event()

Philipp Stanner (2):
      stmmac: loongson: Pass correct arg to PCI function
      drm/sched: Fix preprocessor guard

Prashanth K (3):
      usb: gadget: u_ether: Set is_suspend flag if remote wakeup fails
      usb: gadget: Set self-powered based on MaxPower and bmAttributes
      usb: gadget: Check bmAttributes only if configuration is valid

Qi Zheng (1):
      arm: pgtable: fix NULL pointer dereference issue

Qiu-ji Chen (1):
      cdx: Fix possible UAF error in driver_override_show()

Ricardo Ca=C3=B1uelo Navarro (1):
      mm: shmem: remove unnecessary warning in shmem_writepage()

Ricardo Ribalda (1):
      iio: hid-sensor-prox: Split difference from multiple channels

Richard Thier (1):
      drm/radeon: Fix rs400_gpu_init for ATI mobility radeon Xpress 200M

Rob Herring (Arm) (1):
      Revert "of: reserved-memory: Fix using wrong number of cells to
get property 'alignment'"

Ryan McClelland (1):
      HID: nintendo: fix gencon button events map

Ryan Roberts (1):
      mm: don't skip arch_sync_kernel_mappings() in error paths

Sagi Grimberg (1):
      nvme-tcp: fix possible UAF in nvme_tcp_poll

Salah Triki (1):
      bluetooth: btusb: Initialize .owner field of force_poll_sync_fops

Sam Winchenbach (1):
      iio: filter: admv8818: Force initialization of SDO

Satoru Takeuchi (1):
      docs: Kconfig: fix defconfig description

Sean Christopherson (11):
      KVM: SVM: Set RFLAGS.IF=3D1 in C code, to get VMRUN out of the STI sh=
adow
      KVM: selftests: Assert that STI blocking isn't set after event inject=
ion
      KVM: SVM: Drop DEBUGCTL[5:2] from guest's effective value
      KVM: SVM: Suppress DEBUGCTL.BTF on AMD
      KVM: x86: Snapshot the host's DEBUGCTL in common x86
      KVM: SVM: Manually context switch DEBUGCTL if LBR virtualization
is disabled
      KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
      KVM: SVM: Save host DR masks on CPUs with DebugSwap
      KVM: SVM: Don't rely on DebugSwap to restore host DR0..DR3
      KVM: selftests: Ensure all vCPUs hit -EFAULT during initial RO stage
      KVM: selftests: Fix printf() format goof in SEV smoke test

Sebastian Andrzej Siewior (1):
      dma: kmsan: export kmsan_handle_dma() for modules

SeongJae Park (4):
      selftests/damon/damos_quota_goal: handle minimum quota that
cannot be further reduced
      selftests/damon/damos_quota: make real expectation of quota exceeds
      selftests/damon/damon_nr_regions: set ops update for merge
results check to 100ms
      selftests/damon/damon_nr_regions: sort collected regiosn before
checking with min/max boundaries

Shrikanth Hegde (2):
      sched/deadline: Use online cpus for validating runtime
      sched/rt: Update limit of sched_rt sysctl in documentation

Shyam Sundar S K (2):
      platform/x86/amd/pmf: Propagate PMF-TA return codes
      platform/x86/amd/pmf: Update PMF Driver for Compatibility with new PM=
F-TA

Simon Tatham (2):
      affs: generate OFS sequence numbers starting at 1
      affs: don't write overlarge OFS data block size fields

Stefan Binding (7):
      ALSA: hda/realtek: Add support for ASUS ROG Strix G814 Laptop
using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS ROG Strix GA603 Laptops
using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS ROG Strix G614 Laptops
using CS35L41 HDA
      ALSA: hda/realtek: Add support for various ASUS Laptops using CS35L41=
 HDA
      ALSA: hda/realtek: Add support for ASUS B3405 and B3605 Laptops
using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS B5405 and B5605 Laptops
using CS35L41 HDA
      ALSA: hda/realtek: Add support for ASUS Zenbook UM3406KA Laptops
using CS35L41 HDA

Stuart Hayhurst (1):
      HID: corsair-void: Update power supply values with a unified work han=
dler

Su Hui (1):
      include/linux/log2.h: mark is_power_of_2() with __always_inline

Sumanth Korikkar (1):
      s390/ftrace: Fix return address recovery of traced function

Sumit Garg (1):
      MAINTAINERS: .mailmap: update Sumit Garg's email address

Sun YangKai (1):
      mm: zswap: use ATOMIC_LONG_INIT to initialize zswap_stored_pages

Suren Baghdasaryan (2):
      userfaultfd: do not block on locking a large folio with raised refcou=
nt
      userfaultfd: fix PTE unmapping stack-allocated PTE copies

Takashi Iwai (2):
      ALSA: seq: Avoid module auto-load handling at event delivery
      drm/bochs: Fix DPMS regression

Thadeu Lima de Souza Cascardo (1):
      char: misc: deallocate static minor in error path

Thinh Nguyen (1):
      usb: dwc3: Set SUSPENDENABLE soon after phy init

Thomas Hellstr=C3=B6m (6):
      drm/xe/vm: Validate userptr during gpu vma prefetching
      drm/xe/vm: Fix a misplaced #endif
      drm/xe: Fix fault mode invalidation with unbind
      drm/xe/hmm: Style- and include fixes
      drm/xe/hmm: Don't dereference struct page pointers without notifier l=
ock
      drm/xe/userptr: Unmap userptrs in the mmu notifier

Thomas Wei=C3=9Fschuh (2):
      selftests/vDSO: Fix GNU hash table entry size for s390x
      kbuild: userprogs: use correct lld when linking through clang

Thorsten Blum (1):
      btrfs: replace deprecated strncpy() with strscpy()

Tiezhu Yang (1):
      LoongArch: Convert unreachable() to BUG()

Titus Rwantare (1):
      hwmon: (pmbus) Initialise page count in pmbus_identify()

Tvrtko Ursulin (1):
      drm/xe: Fix GT "for each engine" workarounds

Uday Shankar (1):
      ublk: set_params: properly check if parameters can be applied

Ujwal Kundur (1):
      Documentation: fix doc link to fault-injection.rst

Uladzislau Rezki (Sony) (1):
      mm/slab/kvfree_rcu: Switch to WQ_MEM_RECLAIM wq

Vicki Pfau (1):
      HID: hid-steam: Fix use-after-free when detaching device

Victor Duicu (1):
      iio: adc: pac1921: Move ACPI_FREE() to cover all branches

Visweswara Tanuku (1):
      slimbus: messaging: Free transaction ID in delayed interrupt scenario

Vitaliy Shevtsov (2):
      wifi: nl80211: reject cooked mode if it is set along with other flags
      caif_virtio: fix wrong pointer check in cfv_probe()

Wentao Guan (1):
      HID: i2c-hid: improve i2c_hid_get_report error message

Xiaoyao Li (1):
      KVM: x86: Explicitly zero EAX and EBX when PERFMON_V2 isn't
supported by KVM

Xinghuo Chen (1):
      hwmon: fix a NULL vs IS_ERR_OR_NULL() check in xgene_hwmon_probe()

Yu-Chun Lin (1):
      HID: google: fix unused variable warning under !CONFIG_ACPI

Yuezhang Mo (2):
      exfat: fix just enough dentries but allocate a new cluster to dir
      exfat: add a check for invalid data size

Yuli Wang (1):
      LoongArch: Eliminate superfluous get_numa_distances_cnt()

Zecheng Li (1):
      sched/fair: Fix potential memory corruption in child_cfs_rq_on_list

Zhang Lixu (2):
      HID: intel-ish-hid: Fix use-after-free issue in hid_ishtp_cl_remove()
      HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()

gao xu (1):
      mm: fix possible NULL pointer dereference in __swap_duplicate

