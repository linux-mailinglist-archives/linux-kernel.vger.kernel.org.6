Return-Path: <linux-kernel+bounces-273997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB0947092
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7251C20B96
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE5D137C37;
	Sun,  4 Aug 2024 21:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HRjmmIPL"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96153BB47
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722805280; cv=none; b=JBM/hYfYcy5j39Kjf1CNFVZIu32wFEEMnWtzIjqyW2a+ZOl173fYEIj0v8gPFdqN4IF6I113WN8ZhgVDTpNFhbHlkfCTFJw//eeDfeQH+Q3zH4ASicU8a7ATeUKD5WzwuI+CaJ2Sd6zRxMnDwArhWEWHvNbUGyiyl7mT1nSd7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722805280; c=relaxed/simple;
	bh=VUqn6Yjok9YQS33e5NwlMXuSMOI5ZMwUcXPC6x+37IE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BgU6tZ2HW8ZAa3uXnXApF7UIoCGKPJmpPkCfr4t6tZA8nUCaymleTGJMHr+KK8oFf8As9VlDiWqBTDcG0xc+9ttbdBTJ/h4TI5kuEb0VENGVLEti/Y0bOErVC5GvJw7Q1A7gU4+4iOQP6qUzj6at9nQz4eopC0dpu4PVaCYfHns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HRjmmIPL; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso12296673a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722805276; x=1723410076; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WPgpDf5ERYhTys+3jUVyoFKYUykWikkEhYbg5eMpFI=;
        b=HRjmmIPL41uA59vtIl+cvqR0mbbA8IfmflE14uhHipv+7tiWguEjUfGnUJRHcPJIUu
         swkIhHUzJ4EyYZhYHZZg3ZaCTWcGz/SgAo4kIdDIiGX7Yhu3enbzOVbAGLHJcsf66BOM
         jypYG29K4FF8eltumy2fGEKGi4xecNVflS9NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722805276; x=1723410076;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WPgpDf5ERYhTys+3jUVyoFKYUykWikkEhYbg5eMpFI=;
        b=gGs7AwHKtLxllilRnP2fq+2QtViAQujj9xBiP6M+aqrgcr68KA7WLAH4Q4HSCE6OOy
         svZEdc0vsejdLwBTjd17dpouAhwH77k7zAOrXCpIwPn+JuDpMKOncZIX73jsCC1l5GeD
         i9vhXdnqYI+bdIxo6/QOL3vZEx4hvXiRJAZpehnA1rl3ejdcsA9amM+FAbV5KqjTJQRd
         AmxlVzdPQjdzOD1VCpUEroWRXd84BnxF16FeF5hnjwpHIJkEqFz94TpUiMujdxQxEk/l
         8Cd80+HyURAaS0novNvO9P1YGfSEYm3T9CWzb+QCplpZyniJxwWckJBEgIajAWCUy74E
         jLRA==
X-Gm-Message-State: AOJu0Yywz1GaUP6QAIeyHmxd25NEj+WhwzzixM5tPL9W857iL16j6FGJ
	bNTRn6trp6Dgj2UuXPJG1sj3o+YPcgtqmDcPAt2L5IjyM7N1EN015ySkTd2aaJMkCn4wTzO4KF4
	jZp5adQ==
X-Google-Smtp-Source: AGHT+IEDPugHgbM7D9NglG6fd94kWVDN0ujN3H0/TCpUNFzb/V5xEnLWfDQxctKwhyyvmj/GsroBiA==
X-Received: by 2002:a05:6402:3417:b0:58e:4088:ed2 with SMTP id 4fb4d7f45d1cf-5b7f3eb5f2cmr6131393a12.16.1722805275563;
        Sun, 04 Aug 2024 14:01:15 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a03b403sm4053014a12.42.2024.08.04.14.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Aug 2024 14:01:15 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a728f74c23dso1262391166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:01:15 -0700 (PDT)
X-Received: by 2002:a17:906:6a29:b0:a7a:9f0f:ab26 with SMTP id
 a640c23a62f3a-a7dc4de2f92mr676436066b.23.1722805274343; Sun, 04 Aug 2024
 14:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Aug 2024 14:00:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>
Message-ID: <CAHk-=wh01xPAWUT_=J1TehFOu3SST12UTNuB=QQTeRw+1N4pDQ@mail.gmail.com>
Subject: Linux 6.11-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So rc1 had a fair number of annoying small build or test failures on
Guenter's test matrix, which never looks good. But most of them seemed
to be of the "stupid and trivial" variety, which obviously doesn't
instill confidence in the process, but also isn't exactly scary. When
the microblaze tinyconfig doesn't build cleanly, it may not be a great
look, but it's also probably not a showstopper for actual use.

Hopefully we've gotten rid of the bulk of the silly noise here in rc2,
and not added too much new noise, so that we can get on with the
process of finding more meaningful issues.

         Linus

---

Ackerley Tng (1):
      KVM: x86/mmu: fix determination of max NPT mapping level for private =
pages

Al Viro (1):
      protect the fetch of ->fd[fd] in do_dup2() from mispredictions

Alex Deucher (1):
      drm/amdgpu: Fix APU handling in amdgpu_pm_load_smu_firmware()

Alexander Duyck (1):
      fbnic: Change kconfig prompt from S390=3Dn to !S390

Alexandra Winter (1):
      net/iucv: fix use after free in iucv_sock_close()

Alice Ryhl (1):
      rust: SHADOW_CALL_STACK is incompatible with Rust

Andr=C3=A9 Almeida (2):
      drm/atomic: Allow userspace to use explicit sync with atomic async fl=
ips
      drm/atomic: Allow userspace to use damage clips with async flips

Andy Chiu (1):
      net: axienet: start napi before enabling Rx/Tx

Arnd Bergmann (7):
      hid: bpf: add BPF_JIT dependency
      Bluetooth: btmtk: Fix btmtk.c undefined reference build error harder
      Bluetooth: btmtk: remove #ifdef around declarations
      media: ipu-bridge: fix ipu6 Kconfig dependencies
      alpha: fix ioread64be()/iowrite64be() helpers
      uretprobe: change syscall number, again
      syscalls: fix syscall macros for newfstat/newfstatat

Arseniy Krasnov (1):
      irqchip/meson-gpio: Convert meson_gpio_irq_controller::lock to
'raw_spinlock_t'

Baochen Qiang (1):
      wifi: ath12k: fix reusing outside iterator in ath12k_wow_vif_set_wake=
ups()

Bartosz Golaszewski (1):
      net: phy: aquantia: only poll GLOBAL_CFG regs on aqr113, aqr113c
and aqr115c

Basavaraj Natikar (1):
      HID: amd_sfh: Move sensor discovery before HID device initialization

Benjamin Tissoires (4):
      selftests/hid: fix bpf_wq new API
      selftests/hid: disable struct_ops auto-attach
      HID: bpf: prevent the same struct_ops to be attached more than once
      selftests/hid: add test for attaching multiple time the same struct_o=
ps

Bingbu Cao (1):
      media: intel/ipu6: select AUXILIARY_BUS in Kconfig

Blazej Kucman (1):
      PCI: pciehp: Retain Power Indicator bits for userspace indicators

Boris Burkov (1):
      btrfs: make cow_file_range_inline() honor locked_page on error

Borislav Petkov (AMD) (1):
      x86/setup: Parse the builtin command line before merging

Breno Leitao (1):
      net: Add skbuff.h to MAINTAINERS

Casey Chen (1):
      perf tool: fix dereferencing NULL al->maps

Chang Yu (1):
      KVM: Documentation: Fix title underline too short warning

Chen Ni (2):
      xfs: convert comma to semicolon
      xfs: convert comma to semicolon

Chris Lu (2):
      Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend
      Bluetooth: btmtk: Fix btmtk.c undefined reference build error

Chris Mi (1):
      net/mlx5e: Fix CT entry update leaks of modify header context

Christian K=C3=B6nig (1):
      drm/amdgpu: fix contiguous handling for IB parsing v2

D. Wythe (1):
      net/smc: prevent UAF in inet_create()

Damien Le Moal (2):
      scsi: mpi3mr: Avoid IOMMU page faults on REPORT ZONES
      scsi: mpt3sas: Avoid IOMMU page faults on REPORT ZONES

Dan Carpenter (3):
      vdpa/octeon_ep: Fix error code in octep_process_mbox()
      drm/client: Fix error code in drm_client_buffer_vmap_local()
      net: mvpp2: Don't re-use loop iterator

Daniel Maslowski (1):
      riscv/purgatory: align riscv_kernel_entry

Danilo Krummrich (2):
      drm/gpuvm: fix missing dependency to DRM_EXEC
      drm/nouveau: prime: fix refcount underflow

Darrick J. Wong (2):
      xfs: fix a memory leak
      xfs: fix file_path handling in tracepoints

Dave Airlie (2):
      nouveau: set placement to original placement on uvmm validate.
      Revert "nouveau: rip out busy fence waits"

David Gow (1):
      x86/uaccess: Zero the 8-byte get_range case on failure on 32-bit

David Howells (1):
      cifs: Remove cifs_aio_ctx

David Sterba (1):
      btrfs: initialize location to fix -Wmaybe-uninitialized in
btrfs_lookup_dentry()

Dmitry Osipenko (1):
      drm/virtio: Fix type of dma-fence context variable

Dr. David Alan Gilbert (1):
      ARM: 9400/1: Remove unused struct 'mod_unwind_map'

Edmund Raile (2):
      Revert "ALSA: firewire-lib: obsolete workqueue for period update"
      Revert "ALSA: firewire-lib: operate for period elapse event in
process context"

Eric Biggers (1):
      scsi: ufs: exynos: Don't resume FMP when crypto support is disabled

Eric Dumazet (1):
      sched: act_ct: take care of padding in struct zones_ht_key

Eric Lin (1):
      perf arch events: Fix duplicate RISC-V SBI firmware event name

Eric Sandeen (1):
      xfs: allow SECURE namespace xattrs to use reserved block pool

Faizal Rahim (1):
      igc: Fix double reset adapter triggered from a single taprio cmd

Filipe Manana (2):
      btrfs: fix corrupt read due to bad offset of a compressed extent map
      btrfs: fix corruption after buffer fault in during direct IO append w=
rite

Geert Uytterhoeven (2):
      ARM: 9402/1: Kconfig: Spelling s/Cortex A-/Cortex-A/
      ARM: 9403/1: Alpine: Spelling s/initialiing/initializing/

Heiko Carstens (8):
      s390/fpu: Re-add exception handling in load_fpu_state()
      s390/alternatives: Remove unused empty header file
      s390/mm/ptdump: Fix handling of identity mapping area
      s390/mm/ptdump: Add support for relocated lowcore mapping
      s390/mm/ptdump: Improve sorting of markers
      s390/mm: Get rid of RELOC_HIDE()
      s390/vmlinux.lds.S: Move ro_after_init section behind rodata section
      s390: Keep inittext section writable

Heiko Stuebner (1):
      dt-bindings: ata: rockchip-dwc-ahci: add missing power-domains

Heiner Kallweit (1):
      r8169: don't increment tx_dropped in case of NETDEV_TX_BUSY

Herve Codina (2):
      net: wan: fsl_qmc_hdlc: Convert carrier_lock spinlock to a mutex
      net: wan: fsl_qmc_hdlc: Discard received CRC

Huacai Chen (1):
      irqchip/loongarch-cpu: Fix return value of lpic_gsi_to_irq()

Ian Forbes (2):
      drm/vmwgfx: Fix overlay when using Screen Targets
      drm/vmwgfx: Trigger a modeset when the screen moves

Jakub Kicinski (7):
      netlink: specs: correct the spec of ethtool
      ethtool: rss: echo the context number back
      eth: bnxt: reject unsupported hash functions
      eth: bnxt: populate defaults in the RSS context struct
      ethtool: fix setting key and resetting indir at once
      ethtool: fix the state of additional contexts with old API
      selftests: drv-net: rss_ctx: check for all-zero keys

Jammy Huang (1):
      drm/ast: Fix black screen after resume

Jean-Michel Hautbois (1):
      media: v4l: Fix missing tabular column hint for Y14P format

Jeff Johnson (2):
      virtio: add missing MODULE_DESCRIPTION() macro
      s390/cio: Add missing MODULE_DESCRIPTION() macros

Jeongjun Park (1):
      tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()

Jim Mattson (1):
      KVM: x86: Eliminate log spam from limited APIC timer periods

Jinjie Ruan (2):
      ARM: 9406/1: Fix callchain_trace() return value
      ARM: 9407/1: Add support for STACKLEAK gcc plugin

Jiri Olsa (1):
      bpf/selftests: Fix ASSERT_OK condition check in uprobe_syscall test

Jiri Pirko (13):
      virtio_pci: push out single vq find code to vp_find_one_vq_msix()
      virtio_pci: simplify vp_request_msix_vectors() call a bit
      virtio_pci: pass vector policy enum to vp_find_vqs_msix()
      virtio_pci: pass vector policy enum to vp_find_one_vq_msix()
      virtio_pci: introduce vector allocation fallback for slow path virtqu=
eues
      virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
      virtio: push out code to vp_avq_index()
      virtio_pci: pass vq info as an argument to vp_setup_vq()
      virtio: create admin queues alongside other virtqueues
      virtio_pci_modern: create admin queue of queried size
      virtio_pci_modern: pass cmd as an identification token
      virtio_pci_modern: use completion instead of busy loop to wait
on admin cmd result
      virtio_pci_modern: remove admin queue serialization lock

Johan Hovold (2):
      scsi: Revert "scsi: sd: Do not repeat the starting disk message"
      wifi: ath12k: fix soft lockup on suspend

Johannes Berg (2):
      wifi: mac80211: use monitor sdata with driver only if desired
      wifi: cfg80211: correct S1G beacon length calculation

Jonathan Cameron (1):
      x86/aperfmperf: Fix deadlock on cpu_hotplug_lock

Julian Sun (1):
      xfs: remove unused parameter in macro XFS_DQUOT_LOGRES

Kenneth Feng (1):
      drm/amdgpu/pm: support gpu_metrics sysfs interface for smu v14.0.2/3

Kiran K (1):
      Bluetooth: btintel: Fail setup on error

Krzysztof Kozlowski (1):
      net: MAINTAINERS: Demote Qualcomm IPA to "maintained"

Kuniyuki Iwashima (3):
      rtnetlink: Don't ignore IFLA_TARGET_NETNSID when ifname is
specified in rtnl_dellink().
      netfilter: iptables: Fix null-ptr-deref in iptable_nat_table_init().
      netfilter: iptables: Fix potential null-ptr-deref in
ip6table_nat_table_init().

Kyoungrul Kim (1):
      scsi: ufs: core: Check LSDBS cap when !mcq

Leo Yan (6):
      perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
      perf: build: Set Python configuration for cross compilation
      perf: build: Only link libebl.a for old libdw
      perf: build: Link lib 'lzma' for static build
      perf: build: Link lib 'zstd' for static build
      perf docs: Document cross compilation

Li Huafei (1):
      perf/x86: Fix smp_processor_id()-in-preemptible warnings

Linus Torvalds (11):
      minmax: make generic MIN() and MAX() macros available everywhere
      minmax: scsi: fix mis-use of 'clamp()' in sr.c
      minmax: don't use max() in situations that want a C constant expressi=
on
      minmax: simplify min()/max()/clamp() implementation
      profiling: attempt to remove per-cpu profile flip buffer
      task_work: make TWA_NMI_CURRENT handling conditional on IRQ_WORK
      profiling: remove stale percpu flip buffer variables
      minmax: improve macro expansion and type checking
      minmax: fix up min3() and max3() too
      runtime constants: deal with old decrepit linkers
      Linux 6.11-rc2

Linus Walleij (1):
      ARM: 9408/1: mm: CFI: Fix some erroneous reset prototypes

Liu Jing (1):
      selftests: mptcp: always close input's FD if opened

Luca Ceresoli (1):
      irqchip/irq-pic32-evic: Add missing 'static' to internal function

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix suspending with wrong filter policy
      Bluetooth: hci_event: Fix setting DISCOVERY_FINDING for passive scann=
ing

Ma Ke (1):
      net: usb: sr9700: fix uninitialized variable use in sr_mdio_read

Maciej Fijalkowski (7):
      ice: don't busy wait for Rx queue disable in ice_qp_dis()
      ice: replace synchronize_rcu with synchronize_net
      ice: modify error handling when setting XSK pool in ndo_bpf
      ice: toggle netif_carrier when setting up XSK pool
      ice: improve updating ice_{t,r}x_ring::xsk_pool
      ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
      ice: xsk: fix txq interrupt mapping

Maciej =C5=BBenczykowski (1):
      ipv6: fix ndisc_is_useropt() handling for PIO

Manivannan Sadhasivam (1):
      scsi: ufs: core: Do not set link to OFF state while waking up
from hibernation

Mark Bloch (1):
      net/mlx5: Lag, don't use the hardcoded value of the first port

Mark Mentovai (1):
      net: phy: realtek: add support for RTL8366S Gigabit PHY

Mark Rutland (3):
      arm64: cputype: Add Cortex-X1C definitions
      arm64: cputype: Add Cortex-A725 definitions
      arm64: errata: Expand speculative SSBS workaround (again)

Matthieu Baerts (NGI0) (7):
      mptcp: sched: check both directions for backup
      mptcp: distinguish rcv vs sent backup flag in requests
      mptcp: pm: only set request_bkup flag when sending MP_PRIO
      mptcp: mib: count MPJ with backup flag
      selftests: mptcp: join: validate backup in MPJ
      mptcp: pm: fix backup support in signal endpoints
      selftests: mptcp: join: check backup support in signal endp

Mavroudis Chatzilazaridis (1):
      ALSA: hda/realtek: Add quirk for Acer Aspire E5-574G

Michael Chen (1):
      drm/amdgpu: increase mes log buffer size for gfx12

Michal Kubiak (1):
      ice: respect netif readiness in AF_XDP ZC related ndo's

Mikulas Patocka (2):
      parisc: fix unaligned accesses in BPF
      parisc: fix a possible DMA corruption

Moshe Shemesh (1):
      net/mlx5: Fix missing lock on sync reset reload

Naohiro Aota (2):
      btrfs: do not subtract delalloc from avail bytes
      btrfs: zoned: fix zone_unusable accounting on making block group
read-write again

Nick Hu (1):
      RISC-V: Enable the IPI before workqueue_online_cpu()

Nikita Zhandarovich (1):
      drm/i915: Fix possible int overflow in skl_ddi_calculate_wrpll()

Olivier Langlois (2):
      io_uring: keep multishot request NAPI timeout current
      io_uring: remove unused local list heads in NAPI functions

Palmer Dabbelt (1):
      cache: StarFive: Require a 64-bit system

Paolo Abeni (6):
      mptcp: fix user-space PM announced address accounting
      mptcp: fix NL PM announced address accounting
      selftests: mptcp: add explicit test case for remove/readd
      selftests: mptcp: fix error path
      mptcp: fix bad RCVPRUNED mib accounting
      mptcp: fix duplicate data handling

Paolo Bonzini (14):
      KVM: x86: disallow pre-fault for SNP VMs before initialization
      KVM: guest_memfd: return folio from __kvm_gmem_get_pfn()
      KVM: guest_memfd: delay folio_mark_uptodate() until after
successful preparation
      KVM: guest_memfd: do not go through struct page
      KVM: rename CONFIG_HAVE_KVM_GMEM_* to CONFIG_HAVE_KVM_ARCH_GMEM_*
      KVM: guest_memfd: return locked folio from __kvm_gmem_get_pfn
      KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the
memory is passed to the guest
      KVM: guest_memfd: make kvm_gmem_prepare_folio() operate on a
single struct kvm
      KVM: remove kvm_arch_gmem_prepare_needed()
      KVM: guest_memfd: move check for already-populated page to common cod=
e
      KVM: cleanup and add shortcuts to kvm_range_has_memory_attributes()
      KVM: extend kvm_range_has_memory_attributes() to check subset of
attributes
      KVM: guest_memfd: let kvm_gmem_populate() operate only on private gfn=
s
      KVM: guest_memfd: abstract how prepared folios are recorded

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Lock device when updating MKBP versio=
n

Paul E. McKenney (1):
      clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()

Paulo Alcantara (2):
      smb: client: handle lack of FSCTL_GET_REPARSE_POINT support
      smb: client: fix FSCTL_GET_REPARSE_POINT against NetApp

Pavan Chebbi (1):
      bnxt_en: Fix RSS logic in __bnxt_reserve_rings()

Pavan Kumar Paluri (1):
      x86/sev: Fix __reserved field in sev_config

Perry Yuan (1):
      x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range

Peter Wang (2):
      scsi: ufs: core: Bypass quick recovery if force reset is needed
      scsi: ufs: core: Fix deadlock during RTC update

Peter Zijlstra (3):
      jump_label: Fix the fix, brown paper bags galore
      x86/mm: Fix pti_clone_pgtable() alignment assumption
      x86/mm: Fix pti_clone_entry_text() for i386

Philip Mueller (1):
      drm: panel-orientation-quirks: Add quirk for OrangePi Neo

Philipp Stanner (1):
      PCI: Fix devres regression in pci_intx()

Qiuxu Zhuo (1):
      drm/fb-helper: Don't schedule_work() to flush frame buffer during pan=
ic()

Qu Wenruo (1):
      btrfs: tree-checker: validate dref root and objectid

Rafael J. Wysocki (2):
      thermal: trip: Avoid skipping trips in thermal_zone_set_trips()
      thermal: core: Update thermal zone registration documentation

Rahul Rameshbabu (1):
      net/mlx5e: Require mlx5 tc classifier action support for IPsec
prio capability

Raju Lakkaraju (1):
      net: phy: micrel: Fix the KSZ9131 MDI-X status issue

Ricardo Ribalda (1):
      media: uvcvideo: Fix custom control mapping probing

Rob Herring (Arm) (1):
      arm: dts: arm: versatile-ab: Fix duplicate clock node name

Samuel Holland (1):
      riscv: cpufeature: Do not drop Linux-internal extensions

Sean Wang (1):
      wifi: mt76: mt7921: fix null pointer access in mt792x_mac_link_bss_re=
move

Shahar Shitrit (1):
      net/mlx5e: Add a check for the return value from mlx5_port_set_eth_pt=
ys

Shay Drory (2):
      net/mlx5: Always drain health in shutdown callback
      net/mlx5: Fix error handling in irq_pool_request_irq

Shifrin Dmitry (1):
      perf: riscv: Fix selecting counters in legacy mode

Srinivas Pandruvada (3):
      thermal: intel: int340x: Fix kernel warning during MSI cleanup
      thermal: intel: int340x: Allow limited thermal MSI support
      thermal: intel: int340x: Free MSI IRQ vectors on module exit

Stanislav Fomichev (1):
      selftests/bpf: Filter out _GNU_SOURCE when compiling test_cpp

Steve French (2):
      smb3: add dynamic tracepoints for shutdown ioctl
      cifs: update internal version number

Stuart Menefy (1):
      riscv: Fix linear mapping checks for non-contiguous memory regions

Subash Abhinov Kasiviswanathan (1):
      tcp: Adjust clamping window for applications specifying SO_RCVBUF

Suraj Kandpal (1):
      drm/i915/hdcp: Fix HDCP2_STREAM_STATUS macro

Takashi Iwai (10):
      ALSA: hda/generic: Add a helper to mute speakers at suspend/shutdown
      ALSA: hda/conexant: Mute speakers at suspend / shutdown
      ALSA: seq: ump: Optimize conversions from SysEx to UMP
      ALSA: ump: Transmit RPN/NRPN message at each MSB/LSB data reception
      ALSA: ump: Explicitly reset RPN with Null RPN
      ALSA: seq: ump: Use the common RPN/bank conversion context
      ALSA: seq: ump: Transmit RPN/NRPN message at each MSB/LSB data recept=
ion
      ALSA: seq: ump: Explicitly reset RPN with Null RPN
      ALSA: usb-audio: Correct surround channels in UAC1 channel map
      ALSA: hda: Conditionally use snooping for AMD HDMI

Tatsunosuke Tobita (2):
      HID: wacom: Modify pen IDs
      HID: wacom: more appropriate tool type categorization

Tetsuo Handa (3):
      Input: MT - limit max slots
      profiling: remove prof_cpu_mask
      profiling: remove profile=3Dsleep support

Thomas Gleixner (1):
      tick/broadcast: Move per CPU pointer access into the atomic section

Thomas Zimmermann (1):
      drm/ast: astdp: Wake up during connector status detection

Tvrtko Ursulin (5):
      drm/v3d: Prevent out of bounds access in performance query extensions
      drm/v3d: Fix potential memory leak in the timestamp extension
      drm/v3d: Fix potential memory leak in the performance extension
      drm/v3d: Validate passed in drm syncobj handles in the timestamp exte=
nsion
      drm/v3d: Validate passed in drm syncobj handles in the
performance extension

Umesh Nerlige Ramappa (1):
      i915/perf: Remove code to update PWR_CLK_STATE for gen12

Uros Bizjak (1):
      locking/pvqspinlock: Correct the type of "old" variable in pv_kick_no=
de()

Veerendranath Jakkam (1):
      wifi: cfg80211: fix reporting failed MLO links status with
cfg80211_connect_done

Will Deacon (1):
      arm64: jump_label: Ensure patched jump_labels are visible to all CPUs

Willem de Bruijn (1):
      net: drop bad gso csum_start and offset in virtio_net_hdr

Xiubo Li (1):
      ceph: force sending a cap update msg back to MDS for revoke op

Yang Yingliang (4):
      sched/smt: Introduce sched_smt_present_inc/dec() helper
      sched/smt: Fix unbalance sched_smt_present dec/inc
      sched/core: Introduce sched_set_rq_on/offline() helper
      sched/core: Fix unbalance set_rq_online/offline() in
sched_cpu_deactivate()

Yevgeny Kliteynik (1):
      net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule

Yipeng Zou (1):
      irqchip/mbigen: Fix mbigen node address layout

Yong-Xuan Wang (1):
      KVM: riscv: selftests: Fix compile error

Yuntao Liu (1):
      ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION

Zack Rusin (4):
      drm/vmwgfx: Fix a deadlock in dma buf fence polling
      drm/vmwgfx: Make sure the screen surface is ref counted
      drm/vmwgfx: Fix handling of dumb buffers
      drm/vmwgfx: Add basic support for external buffers

Zenghui Yu (1):
      kselftests: dmabuf-heaps: Ensure the driver name is null-terminated

Zhe Qiao (1):
      riscv/mm: Add handling for VM_FAULT_SIGSEGV in mm_fault_error()

Zheng Zucheng (1):
      sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime

Zhenyu Wang (1):
      perf/x86/intel/cstate: Add pkg C2 residency counter for Sierra Forest

songxiebing (1):
      ALSA: hda: conexant: Fix headset auto detect fail in the polling mode

