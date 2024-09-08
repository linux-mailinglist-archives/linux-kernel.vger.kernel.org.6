Return-Path: <linux-kernel+bounces-320434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DC970A51
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 00:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848CC1F21E17
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B017ADE7;
	Sun,  8 Sep 2024 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="danb2xyn"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A18178367
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 22:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725833120; cv=none; b=bsR3Sw67k8aUrxrlLLNLx0kRJrWlDTIC7PXbhVB65EFkwTVC8gkCYheAzREkM+CQcnTN/EWdR8pMIE0IN30QFH5D8J8wD8jJ1KvotoF4B5oMEA8aDN8ctqTu8D4OsL7y2IGki09zAJ5RKCLUwTFdyGyaD3sNbIqhX1DhHlSzFlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725833120; c=relaxed/simple;
	bh=dYN+CdnoDIIluMtBNdJQXcG/QYaHPVBRxiQDxL3JJTI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fjChXenxjyH5fra2JIm4APucDZwj3EEHO6Ovcy9vUP891GZl6AiN8Xs3izDNGBSZLv+6dszyHlm3SuDNIM/KpvnnK6cPXTi+Gwfug6lg5jxEgyTpa9e4KFEkljJpTN8G0aWcILCcO5qH0FRaZMWiTnU4x4bApQHPKSlFa9yHUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=danb2xyn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c1963cb6so2201753f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 15:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725833116; x=1726437916; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTCOyis40nlNptniJZ89yfVa1EAXJF6su2h7LbSxh1c=;
        b=danb2xynEcQp/WA8YEsmkGMxgBpCCs5LY6GeFgsjEGnQYZ5kfe+JZywNsWy07np4uB
         l/WZEsvSLz4DWJb3c5Ty6N1EOrq4DrRwZqFJHp2PJzmk7YgtwO9hwHENhno/PKHIiwMR
         bX19dBDirwbiBzbRyHjzN51vNzo9FcRWuRLAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725833116; x=1726437916;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTCOyis40nlNptniJZ89yfVa1EAXJF6su2h7LbSxh1c=;
        b=tQL2cR2EnniFI9FR1m92kvlyGXvaAcLxAmvJvthesM3neIHvWSdSkHgY9fnJd9I+SW
         FbtpaPpVs9PdJadCzqGpP56+kX3UGKt9zdqutREWY3HxszQjUei5XZ/HAOE8KSsSBA6j
         v0DOv7jxMQS+mPBBga+wPa+AcVNA2Pbov13++alqTOpJ77ZH38CbIS+lx1FV/LsMk2PB
         +9umCB9iBN6MT60jWE/rsv+RlUpGiM98XqDWgLgAYDnUQDqQegpeB+h3bTDtfeAsVz4B
         sDPRxcNAsIcdlj4fzXAG7BGyC5q5IaekKpb6K6lTlz6IBFGF0kApg8ieADDTPy2f01Rt
         5sEg==
X-Gm-Message-State: AOJu0YzV73rXeuwhGRbEgHyjdUTxY1PJjAB1NIolJRRkxcSktciubAPi
	AaJcCYgNcD3dTDQ5N2iCEPE8qIaMX8OhK14mkpyCrMaKTyzuY3PDpeEWU1zguVrDYdOaH4SwkX1
	8yek=
X-Google-Smtp-Source: AGHT+IFTbnyh0T5+8yf45Vjl0ibiT0LRh/NBfnNEDHyWzzg9cHU28ioS3CGivJVPpWoV6MbFeouIgQ==
X-Received: by 2002:adf:eb92:0:b0:374:c42f:bac1 with SMTP id ffacd0b85a97d-378895c28camr4948777f8f.8.1725833114542;
        Sun, 08 Sep 2024 15:05:14 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd76f27sm2231745a12.66.2024.09.08.15.05.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 15:05:13 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c260b19f71so3625444a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 15:05:13 -0700 (PDT)
X-Received: by 2002:a05:6402:34c8:b0:5be:fadc:e13c with SMTP id
 4fb4d7f45d1cf-5c3dc77ff52mr6021094a12.4.1725833112628; Sun, 08 Sep 2024
 15:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Sep 2024 15:04:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
Message-ID: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
Subject: Linux 6.11-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So I'm back in my regular timezone, and rc7 is done the usual Sunday
afternoon time.

And I wish I could say that things have calmed down, but I can't
really say that. In fact, rc7 is slightly bigger than both rc6 and rc5
were, both in number of commits, and in actual diff size. That's not
really how it should work out.

That said, there's nothing *scary* in here. I got quite a lot of pull
requests with one or two trivial fixes the last week, and that tends
to be a good sign. The fixes are also spread out fairly widely, so
it's not like there's some problem spot. It's just that there's still
a fair number of patches in here.

And while it hasn't quite calmed down as I would have preferred, it's
also not in any way hugely large or out of line. So I don't think
there's any real reason to actually delay 6.11 unless something odd
comes up.

Of course, if I release 6.11 according to the normal schedule next
weekend, that means that the merge window will open while I (and many
other core maintainers) are traveling for the yearly kernel maintainer
summit. That in itself might be a reason to delay, although not a
particularly strong one. All the actual work should be done before the
merge window, and while tend to try to avoid doing the merge window on
the road with a laptop, it's not usually actually all that
problematic.

So we'll see. I'm still waffling about it.

In the meantime, please do give this rc7 a good shakedown, ok?

                       Linus

---

Abel Vesa (1):
      clk: qcom: gcc-x1e80100: Fix USB 0 and 1 PHY GDSC pwrsts flags

Adam Queler (1):
      ALSA: hda/realtek: Enable Mute Led for HP Victus 15-fb1xxx

Adrian Huang (1):
      mm: vmalloc: optimize vmap_lazy_nr arithmetic when purging each vmap_=
area

Adri=C3=A1n Larumbe (1):
      drm/panthor: flush FW AS caches in slow reset path

Aleksandr Mishin (2):
      staging: iio: frequency: ad9834: Validate frequency parameter value
      platform/x86: dell-smbios: Fix error path in dell_smbios_init()

Alex Deucher (2):
      drm/amdgpu: always allocate cleared VRAM for GEM allocations
      Revert "drm/amdgpu: align pp_power_profile_mode with kernel docs"

Alexandre Ghiti (2):
      riscv: Do not restrict memory size because of linear mapping on nommu
      riscv: Fix RISCV_ALTERNATIVE_EARLY

Andreas Hindborg (3):
      rust: kbuild: fix export of bss symbols
      rust: block: fix wrong usage of lockdep API
      MAINTAINERS: update Andreas Hindborg's email address

Andy Shevchenko (2):
      drm/i915/fence: Mark debug_fence_init_onstack() with __maybe_unused
      drm/i915/fence: Mark debug_fence_free() with __maybe_unused

Anton Blanchard (1):
      riscv: Fix toolchain vector detection

Anup Patel (1):
      irqchip/sifive-plic: Probe plic driver early for Allwinner D1 platfor=
m

Arkadiusz Kubalewski (1):
      tools/net/ynl: fix cli.py --subscribe feature

Armin Wolf (1):
      hwmon: (hp-wmi-sensors) Check if WMI event data exists

Arnaldo Carvalho de Melo (1):
      perf daemon: Fix the build on more 32-bit architectures

Baochen Qiang (3):
      wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_pow=
er()
      Revert "wifi: ath11k: restore country code during resume"
      Revert "wifi: ath11k: support hibernation"

Baokun Li (1):
      fscache: delete fscache_cookie_lru_timer when fscache exits to avoid =
UAF

Bartosz Golaszewski (2):
      PCI: Don't rely on of_platform_depopulate() for reused OF-nodes
      PCI/pwrctl: Rescan bus on a separate thread

Bernd Schubert (1):
      fuse: disable the combination of passthrough and writeback cache

Boqun Feng (1):
      rust: macros: provide correct provenance when constructing THIS_MODUL=
E

Breno Leitao (1):
      net: dqs: Do not use extern for unused dql_group

Brian Norris (1):
      spi: rockchip: Resolve unbalanced runtime PM / system PM handling

Bryan O'Donoghue (1):
      clk: qcom: gcc-x1e80100: Don't use parking clk_ops for QUPs

Carlos Llamas (1):
      binder: fix UAF caused by offsets overwrite

Charles Han (1):
      spi: intel: Add check devm_kasprintf() returned value

Charlie Jenkins (3):
      Revert "RISC-V: mm: Document mmap changes"
      riscv: selftests: Remove mmap hint address checks
      riscv: mm: Do not restrict mmap address based on hint

Chen-Yu Tsai (1):
      ASoc: SOF: topology: Clear SOF link platform name upon unload

Christian Brauner (1):
      libfs: fix get_stashed_dentry()

Christoffer Sandberg (1):
      ALSA: hda/conexant: Add pincfg quirk to enable top speakers on
Sirius devices

Christoph Hellwig (1):
      nvme: set BLK_FEAT_ZONED for ZNS multipath disks

Christophe Leroy (3):
      powerpc/64e: Define mmu_pte_psize static
      powerpc/vdso: Don't discard rela sections
      powerpc/mm: Fix return type of pgd_val()

Cong Wang (1):
      tcp_bpf: fix return value of tcp_bpf_sendmsg()

Daiwei Li (1):
      igb: Fix not clearing TimeSync interrupts for 82580

Dan Carpenter (3):
      irqchip/riscv-aplic: Fix an IS_ERR() vs NULL bug in probe()
      ksmbd: Unlock on in ksmbd_tcp_set_interfaces()
      igc: Unlock on error in igc_io_resume()

Daniel Lezcano (1):
      clocksource/drivers/timer-of: Remove percpu irq related code

Daniele Ceraolo Spurio (2):
      drm/i915: Do not attempt to load the GSC multiple times
      drm/xe/gsc: Do not attempt to load the GSC multiple times

Dave Airlie (1):
      nouveau: fix the fwsec sb verification register.

David Fernandez Gonzalez (1):
      VMCI: Fix use-after-free when removing resource in vmci_resource_remo=
ve()

David Gow (2):
      kunit: Device wrappers should also manage driver name
      kunit: Fix missing kerneldoc comment

David Howells (4):
      mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_ran=
ge()
      cifs: Fix zero_point init on inode initialisation
      cifs: Fix SMB1 readv/writev callback in the same way as SMB2/3
      netfs, cifs: Improve some debugging bits

David Lechner (1):
      iio: buffer-dmaengine: fix releasing dma channel on error

Dawid Osuchowski (1):
      ice: Add netif_device_attach/detach into PF reset flow

Dillon Varone (1):
      drm/amd/display: Block timing sync for different signals in PMO

Dmitry Baryshkov (3):
      drm/display: stop depending on DRM_DISPLAY_HELPER
      drm/bridge-connector: move to DRM_DISPLAY_HELPER module
      drm/bridge-connector: reset the HDMI connector state

Douglas Anderson (2):
      regulator: core: Stub devm_regulator_bulk_get_const() if !CONFIG_REGU=
LATOR
      Bluetooth: qca: If memdump doesn't work, re-enable IBS

Dumitru Ceclan (5):
      iio: adc: ad7173: Fix incorrect compatible string
      iio: adc: ad7124: fix chip ID mismatch
      iio: adc: ad7124: fix config comparison
      iio: adc: ad7124: fix DT configuration parsing
      iio: adc: ad7173: fix GPIO device info

Eric Dumazet (1):
      ila: call nf_unregister_net_hooks() sooner

Fabio Estevam (1):
      spi: spidev: Add an entry for elgin,jg10309-01

Faisal Hassan (1):
      usb: dwc3: core: update LC timer as per USB Spec V3.2

Fedor Pchelkin (1):
      btrfs: qgroup: don't use extent changeset when not needed

Filipe Manana (1):
      btrfs: fix race between direct IO write and fsync when using same fd

Francesco Dolcini (1):
      iio: adc: ads1119: Fix IRQ flags

Frank Li (2):
      MAINTAINERS: SPI: Add freescale lpspi maintainer information
      MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi dr=
ivers

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Remove warning for X86_FEATURE_CPPC on
certain Zen models

Geert Uytterhoeven (2):
      nvmem: Fix return type of devm_nvmem_device_get() in kerneldoc
      spi: spidev: Add missing spi_device_id for jg10309-01

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Samsung 990 Evo

Gerhard Engleder (1):
      misc: keba: Fix sysfs group creation

Guillaume Nault (1):
      bareudp: Fix device stats updates.

Guillaume Stols (1):
      iio: adc: ad7606: remove frstdata check for serial mode

Hans de Goede (2):
      ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards harder
      ASoC: Intel: soc-acpi-cht: Make Lenovo Yoga Tab 3 X90F DMI match
less strict

Hao Ge (2):
      mm/slub: add check for s->flags in the alloc_tagging_slab_free_hook
      codetag: debug: mark codetags for poisoned page as empty

Hayes Wang (1):
      r8152: fix the firmware doesn't work

Heikki Krogerus (2):
      usb: typec: ucsi: Fix the partner PD revision
      usb: typec: ucsi: Fix cable registration

Helge Deller (1):
      parisc: Delay write-protection until mark_rodata_ro() call

Imre Deak (1):
      drm/xe: Suspend/resume user access only during system s/r

Jack Xiao (1):
      drm/amdgpu/mes: add mes mapping legacy queue switch

Jacky Bai (2):
      clocksource/drivers/imx-tpm: Fix return -ETIME when delta exceeds INT=
_MAX
      clocksource/drivers/imx-tpm: Fix next event not taking effect sometim=
e

Jakub Kicinski (2):
      MAINTAINERS: exclude bluetooth and wireless DT bindings from netdev M=
L
      docs: netdev: document guidance on cleanup.h

Jamie Bainbridge (1):
      selftests: net: enable bind tests

Jan Kuliga (1):
      mailmap: update entry for Jan Kuliga

Jann Horn (3):
      fuse: use unsigned type for getxattr/listxattr size truncation
      userfaultfd: fix checks for huge PMDs
      userfaultfd: don't BUG_ON() if khugepaged yanks our page table

Jean-Baptiste Maneyrol (1):
      iio: imu: inv_mpu6050: fix interrupt status read for old buggy chips

Jens Emil Schulz =C3=98stergaard (1):
      net: microchip: vcap: Fix use-after-free error in kunit test

Jeongjun Park (3):
      net/smc: prevent NULL pointer dereference in txopt_get
      bpf: add check for invalid name in btf_name_valid_section()
      selftests/bpf: Add a selftest to check for incorrect names

Jinjie Ruan (2):
      nvmet: Make nvmet_debugfs static
      net: phy: Fix missing of_node_put() for leds

Joanne Koong (2):
      fuse: check aborted connection before adding requests to pending
list for resending
      fuse: update stats for pages in dropped aux writeback list

Johan Hovold (1):
      clk: qcom: gcc-sc8280xp: don't use parking clk_ops for QUPs

John Thomson (1):
      nvmem: u-boot-env: error if NVMEM device is too small

Jon Mulder (1):
      docs: rust: remove unintended blockquote in Quick Start

Jonas Gorski (1):
      net: bridge: br_fdb_external_learn_add(): always set EXT_LEARN

Jonathan Bell (1):
      mmc: core: apply SD quirks earlier during probe

Jouni H=C3=B6gander (2):
      drm/i915/display: Add mechanism to use sink model when applying quirk
      drm/i915/display: Increase Fast Wake Sync length as a quirk

Jubilee Young (1):
      rust: alloc: eschew `Box<MaybeUninit<T>>::write`

Kai Vehmanen (1):
      ALSA: hda: add HDMI codec ID for Intel PTL

Kan Liang (1):
      perf/x86/intel: Limit the period on Haswell

Keith Busch (2):
      nvme: use better description for async reset reason
      nvme-pci: allocate tagset on reset if necessary

Kent Overstreet (2):
      bcachefs: fix rebalance accounting
      bcachefs: BCH_SB_MEMBER_INVALID

Kirill A. Shutemov (1):
      x86/tdx: Fix data leak in mmio_read()

Krzysztof Kozlowski (1):
      gpio: rockchip: fix OF node leak in probe()

Kuniyuki Iwashima (2):
      can: bcm: Remove proc entry when dev is unregistered.
      fou: Fix null-ptr-deref in GRO.

Larysa Zaremba (6):
      ice: move netif_queue_set_napi to rtnl-protected sections
      ice: protect XDP configuration with a mutex
      ice: check for XDP rings instead of bpf program when unconfiguring
      ice: check ICE_VSI_DOWN under rtnl_lock when preparing for reset
      ice: remove ICE_CFG_BUSY locking from AF_XDP code
      ice: do not bring the VSI up, if it was down before the XDP setup

Laurentiu Mihalcea (1):
      ASoC: SOF: ipc: replace "enum sof_comp_type" field with "uint32_t"

Leo Li (2):
      drm/amd/display: Determine IPS mode by ASIC and PMFW versions
      drm/amd/display: Lock DC and exit IPS when changing backlight

Leonardo Bras (1):
      kvm: Note an RCU quiescent state on guest exit

Li Nan (1):
      ublk_drv: fix NULL pointer dereference in ublk_ctrl_start_recovery()

Liam R. Howlett (1):
      maple_tree: remove rcu_read_lock() from mt_validate()

Liao Chen (7):
      ASoC: intel: fix module autoloading
      ASoC: google: fix module autoloading
      ASoC: tda7419: fix module autoloading
      ASoC: fix module autoloading
      mmc: sdhci-of-aspeed: fix module autoloading
      spi: bcm63xx: Enable module autoloading
      gpio: modepin: Enable module autoloading

Linus Torvalds (2):
      KVM: x86: don't fall through case statements without annotations
      Linux 6.11-rc7

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Introduce hci_cmd_sync_run/hci_cmd_sync_run_once
      Bluetooth: MGMT: Fix not generating command complete for
MGMT_OP_DISCONNECT
      Revert "Bluetooth: MGMT/SMP: Fix address type when using SMP
over BREDR/LE"
      Bluetooth: MGMT: Ignore keys being loaded with invalid type

Luke D. Jones (1):
      platform/x86/amd: pmf: Make ASUS GA403 quirk generic

Ma Ke (1):
      irqchip/gic-v2m: Fix refcount leak in gicv2m_of_init()

Maarten Lankhorst (1):
      drm/xe/display: Match i915 driver suspend/resume sequences better

Marc Kleine-Budde (2):
      can: mcp251xfd: fix ring configuration when switching from
CAN-CC to CAN-FD mode
      can: mcp251xfd: mcp251xfd_ring_init(): check TX-coalescing configurat=
ion

Marc Zyngier (2):
      irqchip/gic-v4: Fix ordering between vmapp and vpe locks
      scripts: fix gfp-translate after ___GFP_*_BITS conversion to an enum

Marek Marczykowski-G=C3=B3recki (1):
      ALSA: hda/realtek: extend quirks for Clevo V5[46]0

Mark Rutland (1):
      irqchip/gic-v3: Init SRE before poking sysregs

Markus Schneider-Pargmann (7):
      can: m_can: Reset coalescing during suspend/resume
      can: m_can: Remove coalesing disable in isr during suspend
      can: m_can: Remove m_can_rx_peripheral indirection
      can: m_can: Do not cancel timer from within timer
      can: m_can: disable_all_interrupts, not clear active_interrupts
      can: m_can: Reset cached active_interrupts on start
      can: m_can: Limit coalescing to peripheral instances

Markuss Broks (1):
      ASoC: amd: yc: Add a quirk for MSI Bravo 17 (D7VEK)

Martin Jocic (1):
      can: kvaser_pciefd: Use a single write when releasing RX buffers

Martin KaFai Lau (1):
      bpf: Fix a crash when btf_parse_base() returns an error pointer

Mary Guillemard (2):
      scsi: ufs: ufs-mediatek: Add UFSHCD_QUIRK_BROKEN_LSDBS_CAP
      drm/panthor: Restrict high priorities on group_create

Masami Hiramatsu (Google) (2):
      tracing: fgraph: Fix to add new fgraph_ops to array after
ftrace_startup_subops()
      tracing: Fix memory leak in fgraph storage selftest

Matt Coster (1):
      drm/imagination: Free pvr_vm_gpuva after unlink

Matt Johnston (2):
      net: mctp-serial: Add kunit test for next_chunk_len()
      net: mctp-serial: Fix missing escapes on transmit

Matt Roper (1):
      drm/xe/pcode: Treat pcode as per-tile rather than per-GT

Matteo Martelli (2):
      iio: fix scale application in iio_convert_raw_to_processed_unlocked
      ASoC: sunxi: sun4i-i2s: fix LRCLK polarity in i2s mode

Maurizio Lombardi (2):
      nvmet-tcp: fix kernel crash if commands allocation fails
      nvmet: Identify-Active Namespace ID List command should reject
invalid nsid

Maxim Levitsky (1):
      KVM: SVM: fix emulation of msr reads/writes of MSR_FS_BASE and MSR_GS=
_BASE

Maxime Chevallier (1):
      irqchip/irq-msi-lib: Check for NULL ops in msi_lib_irq_domain_select(=
)

Maximilien Perreault (1):
      ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx

Michael Vetter (1):
      rust: kernel: fix typos in code comments

Michal Simek (1):
      dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem

Miguel Ojeda (1):
      rust: allow `stable_features` lint

Mike Yuan (1):
      mm/memcontrol: respect zswap.writeback setting from parent cg too

Miklos Szeredi (1):
      fuse: clear PG_uptodate when using a stolen page

Mikulas Patocka (1):
      bio-integrity: don't restrict the size of integrity metadata

Mitchell Levy (1):
      x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

Mohan Kumar (1):
      ASoC: tegra: Fix CBB error during probe()

Muhammad Usama Anjum (1):
      selftests: mm: fix build errors on armhf

Naman Jain (1):
      Drivers: hv: vmbus: Fix rescind handling in uio_hv_generic

Namhyung Kim (1):
      perf lock contention: Fix spinlock and rwlock accounting

Namjae Jeon (1):
      ksmbd: unset the binding mark of a reused connection

Naohiro Aota (1):
      btrfs: zoned: handle broken write pointer on zones

Neil Armstrong (1):
      clk: qcom: gcc-sm8650: Don't use shared clk_ops for QUPs

Nuno Sa (1):
      iio: adc: ad_sigma_delta: fix irq_flags on irq request

Nysal Jan K.A. (1):
      powerpc/qspinlock: Fix deadlock in MCS queue

Oliver Neukum (1):
      usbnet: modern method to get random MAC

Paulo Alcantara (3):
      smb: client: fix hang in wait_for_response() for negproto
      smb: client: fix double put of @cfile in smb2_rename_path()
      smb: client: fix double put of @cfile in smb2_set_path_size()

Pawel Dembicki (2):
      hwmon: ltc2991: fix register bits defines
      net: dsa: vsc73xx: fix possible subblocks range of CAPT block

Pawel Laszczak (1):
      usb: cdns2: Fix controller reset issue

Peter Newman (1):
      x86/resctrl: Fix arch_mbm_* array overrun on SNC

Peter Zijlstra (1):
      perf/aux: Fix AUX buffer serialization

Petr Tesarik (1):
      kexec_file: fix elfcorehdr digest exclusion when CONFIG_CRASH_HOTPLUG=
=3Dy

Prashanth K (1):
      usb: dwc3: Avoid waking up gadget during startxfer

Puranjay Mohan (1):
      arm64: stacktrace: fix the usage of ftrace_graph_ret_addr()

Ravi Bangoria (1):
      KVM: SVM: Don't advertise Bus Lock Detect to guest if SVM
support is missing

Rodrigo Vivi (2):
      drm/xe: Add missing runtime reference to wedged upon gt_reset
      drm/xe/display: Avoid encoder_suspend at runtime suspend

Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: fix XDP_DROP, XDP_TX and XDP_REDIRECT
      net: ethernet: ti: am65-cpsw: Fix NULL dereference on XDP_TX
      net: ethernet: ti: am65-cpsw: Fix RX statistics for XDP_TX and
XDP_REDIRECT

Roland Xu (1):
      rtmutex: Drop rt_mutex::wait_lock before scheduling

Ryan Walklin (2):
      dt-bindings: display: panel: Rename WL-355608-A8 panel to rg35xx-*-pa=
nel
      drm: panel: nv3052c: Correct WL-355608-A8 panel compatible

Ryusuke Konishi (3):
      nilfs2: protect references to superblock parameters exposed in sysfs
      nilfs2: fix missing cleanup on rollforward recovery error
      nilfs2: fix state management in error path of log writing function

Sam Protsenko (1):
      mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K

Samuel Holland (1):
      riscv: misaligned: Restrict user access to kernel memory

Satya Priya Kakitapalli (4):
      clk: qcom: clk-alpha-pll: Fix the pll post div mask
      clk: qcom: clk-alpha-pll: Fix the trion pll postdiv set rate API
      clk: qcom: clk-alpha-pll: Fix zonda set_rate failure when PLL is disa=
bled
      clk: qcom: clk-alpha-pll: Update set_rate for Zonda PLL

Saurabh Sengar (1):
      uio_hv_generic: Fix kernel NULL pointer dereference in hv_uio_rescind

Sean Anderson (1):
      net: xilinx: axienet: Fix race in axienet_stop

Sean Christopherson (2):
      KVM: x86/mmu: Check that root is valid/loaded when pre-faulting SPTEs
      KVM: x86: Acquire kvm->srcu when handling KVM_SET_VCPU_EVENTS

Seunghwan Baek (1):
      mmc: cqhci: Fix checking of CQHCI_HALT state

Simon Arlott (1):
      can: mcp251x: fix deadlock if an interrupt occurs during mcp251x_open

Simon Horman (2):
      can: m_can: Release irq on error in m_can_open
      MAINTAINERS: wifi: cw1200: add net-cw1200.h

Souradeep Chakrabarti (1):
      net: mana: Fix error handling in mana_create_txq/rxq's NAPI cleanup

Srinivas Kandagatla (1):
      ASoC: codecs: lpass-va-macro: set the default codec version for sm825=
0

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix off-by-one in prescale max

Stephan Gerhold (1):
      pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now

Stephen Boyd (2):
      clk: qcom: gcc-sm8550: Don't use parking clk_ops for QUPs
      clk: qcom: gcc-sm8550: Don't park the USB RCG at registration time

Stephen Hemminger (1):
      sch/netem: fix use after free in netem_dequeue

Steven Rostedt (5):
      eventfs: Use list_del_rcu() for SRCU protected list variable
      tracing/osnoise: Use a cpumask to know what threads are kthreads
      tracing/timerlat: Only clear timer if a kthread exists
      tracing/timerlat: Add interface_lock around clearing of kthread
in stop_kthread()
      KVM: Remove HIGH_RES_TIMERS dependency

Sukrut Bellary (1):
      misc: fastrpc: Fix double free of 'buf' in error path

Suren Baghdasaryan (1):
      alloc_tag: fix allocation tag reporting when CONFIG_MODULES=3Dn

Sven Schnelle (1):
      uprobes: Use kzalloc to allocate xol area

Terry Cheong (1):
      ALSA: hda/realtek: add patch for internal mic in Lenovo V145

Thomas Gleixner (1):
      x86/kaslr: Expose and use the end of the physical memory address spac=
e

Thomas Zimmermann (1):
      drm/fbdev-dma: Only install deferred I/O if necessary

Thorsten Blum (1):
      smb: Annotate struct xattr_smb_acl with __counted_by()

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      sched: sch_cake: fix bulk flow accounting logic for host fairness

Tom Dohrmann (1):
      KVM: x86: Only advertise KVM_CAP_READONLY_MEM when supported by VM

Tze-nan Wu (1):
      bpf, net: Fix a potential race in do_sock_getsockopt()

Ulf Hansson (1):
      OPP: Fix support for required OPPs for multiple PM domains

Usama Arif (1):
      Revert "mm: skip CMA pages when they are not available"

Uwe Kleine-K=C3=B6nig (1):
      pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable()

Vadim Fedorenko (4):
      ptp: ocp: convert serial ports to array
      ptp: ocp: adjust sysfs entries to expose tty information
      docs: ABI: update OCP TimeCard sysfs entries
      MAINTAINERS: fix ptp ocp driver maintainers address

Vasiliy Kovalev (1):
      ALSA: hda/realtek - Fix inactive headset mic jack for ASUS
Vivobook 15 X1504VAP

Veronika Molnarova (1):
      perf test pmu: Set uninitialized PMU alias to null

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix readout degamma_lut mismatch on ilk/snb

Vincent Woltmann (1):
      docs: rust: remove unintended blockquote in Coding Guidelines

Vitaly Kuznetsov (1):
      KVM: SEV: Update KVM_AMD_SEV Kconfig entry and mention SEV-SNP

Wedson Almeida Filho (1):
      MAINTAINERS: Remove Wedson as Rust maintainer

Will Deacon (1):
      mm: vmalloc: ensure vmap_block is initialised before adding to queue

Xingyu Wu (1):
      clk: starfive: jh7110-sys: Add notifier for PLL0 clock

Xu Yang (1):
      perf python: include "util/sample.h"

Yan Zhao (1):
      KVM: x86/mmu: Fixup comments missed by the
REMOVED_SPTE=3D>FROZEN_SPTE rename

Yuntao Liu (1):
      ARM: 9414/1: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION

Yuntao Wang (1):
      x86/apic: Make x2apic_disable() work correctly

Zhang Yi (1):
      ASoC: mediatek: mt8188-mt6359: Modify key

Zheng Qixing (1):
      ata: libata: Fix memory leak for error path in ata_host_alloc()

Zheng Yejian (1):
      tracing: Avoid possible softlockup in tracing_iter_reset()

devi priya (1):
      clk: qcom: ipq9574: Update the alpha PLL type for GPLLs

hongchi.peng (1):
      drm: komeda: Fix an issue related to normalized zpos

robelin (1):
      ASoC: dapm: Fix UAF for snd_soc_pcm_runtime object

yangyun (1):
      fuse: fix memory leak in fuse_create_open

