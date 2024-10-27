Return-Path: <linux-kernel+bounces-383881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDE99B215C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 00:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E66628150D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838818801A;
	Sun, 27 Oct 2024 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T5jwgKW4"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6488B130A54
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 23:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730071684; cv=none; b=PgwKM+T16qH3nSFMP+zvmnhuMgGmeSk2FXoV7pL0WybaEU0Stk2MJInLWO+p9/vQihLWEZ1escOfBMg+a//7Kze3GlTxIgSOvgq73TqwtxLlAxokjaNlG6QDx/fUCAkEmr31Nl2TgqkiL14NkRrGpzyX1QSlx6jjaVRpG6AP6Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730071684; c=relaxed/simple;
	bh=a0s42amufdeShbmzMtjY9wPEwLU4UKcddyCljh++YAA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=S4oA9oL69SMhH+Htcr6wdeMysVFfKy75iNytFVXPZW8OD8E48/lktUEdycXiv7iaKv2bmvWBi9wBqS+SRd3PyM/GOUckVZTg8s7HMtvzhxpf7KHTbuKTSk8j0rl87EBlKO+lWA5r8Fdxcf3VFqkGO47TMR+65L6xH8pYF/GqGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T5jwgKW4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9932aa108cso562348266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730071677; x=1730676477; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wo5kblkCMPd8klUTPDAY8cE//eFFPp25fAdKG+vAw9M=;
        b=T5jwgKW4r9HTWkvPLqATUowex5QXmCUWuIF2ukO+gAXfuxTl3HIKS9ieRy4Xdxp7oV
         D0KAemb60tLiCtSaC33ET72Ok9Bm3Liln9SvmgCEWieOH0mX4KgSKKJZK5Z8SGphhETm
         ew2y+Ruz4PcMPQj5M4JkD8qc8t7X1VbDv7bBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730071677; x=1730676477;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wo5kblkCMPd8klUTPDAY8cE//eFFPp25fAdKG+vAw9M=;
        b=hF4lxym1KFBz3h0eJ2l5eMMbcBSwU5Y9c8a4zzfwABsaMX/zfvyZQVXT8+RStA4mgI
         p57/+qsyae5Ku02PEN22JJIay/KXPLQkJeCz71HC455lC8gPPAZh43j35S6oqltwCcI8
         V4UwF7MrBuXxoeTWyW0PbjbkfpIisjP3BZPzhfuR6qZxlMpxZXEIrKP0M1HDg8ShvLKB
         xpyX1nZG6CBTLAxO5MIonP2pfHknTgJRpA3lU1T6rtBwjlj/MKt05/tz1gGldqwq6DRf
         jfhDLfL2Ioxxju54mvGGNUXh7WXUx/boxILYSzjThQEBeSafG1XcpmDXlRHcAmxfHUxo
         +AsA==
X-Gm-Message-State: AOJu0Yyl355XRKnMfpM6Fk7TwAtnSyrEwjZsYnas0sb6UVoEF9CbuoRX
	vPxLfo+FzdW3F3AwrghvL+IRBjmVOKDeLagcymj38eLWArMQtDS417uBIFg4EIsnbuiez2leKxU
	3bzw=
X-Google-Smtp-Source: AGHT+IE8w5v71tmpU6CEJZW5m5n4nVqjxNdk/vT0JBRUPpZrMJWy3/xuHwLMkm6scf/9P6WgkoieCw==
X-Received: by 2002:a17:907:2cc6:b0:a9a:423:3278 with SMTP id a640c23a62f3a-a9de619e3e9mr594752766b.49.1730071676992;
        Sun, 27 Oct 2024 16:27:56 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298319sm317048666b.105.2024.10.27.16.27.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Oct 2024 16:27:55 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a16b310f5so577687566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 16:27:54 -0700 (PDT)
X-Received: by 2002:a17:907:98b:b0:a9a:c57f:9666 with SMTP id
 a640c23a62f3a-a9de5cfd7ccmr510560066b.2.1730071673973; Sun, 27 Oct 2024
 16:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Oct 2024 13:27:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=whHB3RxR15Xk8Epah8ZrRJi-7ZevSu6kBp0MFtjXEvM-w@mail.gmail.com>
Message-ID: <CAHk-=whHB3RxR15Xk8Epah8ZrRJi-7ZevSu6kBp0MFtjXEvM-w@mail.gmail.com>
Subject: Linux 6.12-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So rc4 last week was larger than I was hoping for, but I
(optimistically) blamed just fluctuations due to random timing of pull
requests since the previous week had been small.

And that does indeed seem to be the case.

Because rc5 looks perfectly normal, and maybe even on the small side
of normal. The diffstat looks nice and flat too, with the exception of
the removal of the da8xx fbdev driver due to it having been replaced
by the tilcdc driver. And I'm sure we're all thinking the same thing:
"What lovely descriptive driver names we have".

Some of the biggest changes seem to be some 9p reverts, although we do
have all the usual suspects too: gpu and networking drivers, and
bcachefs fixes.

But hey, there's a smattering of smaller fixes all over, the shortlog
below gives some flavor of it all: arch fixes (arm64 kvm, x86,
loongarch), other filesystems (xfs, btrfs, nfsd), various drivers
(sound, x86 platform drivers, fbdev), and core networking and bpf.

               Linus

---

Abel Vesa (1):
      drm/bridge: Fix assignment of the of_node of the parent to aux bridge

Aleksa Sarai (1):
      openat2: explicitly return -E2BIG for (usize > PAGE_SIZE)

Aleksandr Mishin (4):
      octeon_ep: Implement helper for iterating packets in Rx queue
      octeon_ep: Add SKB allocation failures handling in __octep_oq_process=
_rx()
      fsl/fman: Save device references taken in mac_probe()
      fsl/fman: Fix refcount handling of fman-related devices

Alessandro Zanni (1):
      fs: Fix uninitialized value issue in from_kuid and from_kgid

Alex Deucher (1):
      drm/amdgpu: handle default profile on on devices without fullscreen 3=
D

Alexey Klimov (2):
      ASoC: qcom: sdm845: add missing soundwire runtime stream alloc
      ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for DSM_CTL
and SEC7 regs

Amadeusz S=C5=82awi=C5=84ski (2):
      ASoC: Intel: avs: Update stream status in a separate thread
      ASoC: topology: Bump minimal topology ABI version

Amir Goldstein (2):
      fs: pass offset and result to backing_file end_write() callback
      fuse: update inode size after extending passthrough write

Andrei Simion (1):
      MAINTAINERS: Update maintainer list for MICROCHIP ASOC, SSC and
MCP16502 drivers

Andrey Shumilin (1):
      ALSA: firewire-lib: Avoid division by zero in apply_constraint_to_siz=
e()

Andrii Nakryiko (1):
      bpf: fix do_misc_fixups() for bpf_get_branch_snapshot()

Armin Wolf (2):
      platform/x86: dell-wmi: Ignore suspend notifications
      platform/x86: asus-wmi: Fix thermal profile initialization

Arnd Bergmann (2):
      i915: fix DRM_I915_GVT_KVMGT dependencies
      fbdev: wm8505fb: select CONFIG_FB_IOMEM_FOPS

Ashish Kalra (1):
      x86/sev: Ensure that RMP table fixups are reserved

Aurabindo Pillai (2):
      drm/amd/display: temp w/a for dGPU to enter idle optimizations
      drm/amd/display: temp w/a for DP Link Layer compliance

Badal Nilawar (1):
      drm/xe/guc/ct: Flush g2h worker in case of g2h response timeout

Bartosz Golaszewski (4):
      PCI: Hold rescan lock while adding devices during host probe
      fbdev: da8xx: remove the driver
      MAINTAINERS: add a keyword entry for the GPIO subsystem
      PCI/pwrctl: Abandon QCom WCN probe on pre-pwrseq device-trees

Bart=C5=82omiej Mary=C5=84czak (1):
      HID: i2c-hid: Delayed i2c resume wakeup for 0x0d42 Goodix touchpad

Benjamin Bara (1):
      ASoC: dapm: avoid container_of() to get component

Bibo Mao (1):
      LoongArch: Set initial pte entry with PAGE_GLOBAL for kernel space

Binbin Zhou (1):
      ASoC: loongson: Fix component check failed on FDT systems

Boris Burkov (1):
      btrfs: fix read corruption due to race with extent map merging

Borislav Petkov (AMD) (2):
      x86/microcode/AMD: Pay attention to the stepping dynamically
      x86/microcode/AMD: Split load_microcode_amd()

Chancel Liu (1):
      ASoC: fsl_micfil: Add a flag to distinguish with different
volume control types

Christian Brauner (1):
      fs: don't try and remove empty rbtree node

Christian Heusel (2):
      ASoC: amd: yc: Add quirk for ASUS Vivobook S15 M3502RA
      ACPI: resource: Add LG 16T90SP to irq1_level_low_skip_override[]

Christian Loehle (1):
      cpufreq: docs: Reflect latency changes in docs

Christoph Hellwig (6):
      xfs: pass the exact range to initialize to xfs_initialize_perag
      xfs: merge the perag freeing helpers
      xfs: update the file system geometry after recoverying superblock buf=
fers
      xfs: error out when a superblock buffer update reduces the agcount
      xfs: don't use __GFP_RETRY_MAYFAIL in xfs_initialize_perag
      xfs: update the pag for the last AG at recovery time

Christophe JAILLET (1):
      fbdev: Constify struct sbus_mmap_map

Colin Ian King (1):
      ASoC: max98388: Fix missing increment of variable slot_found

Cyan Yang (1):
      RISCV: KVM: use raw_spinlock for critical section in imsic

Dan Carpenter (1):
      ACPI: PRM: Clean up guid type in struct prm_handler_info

Daniel Borkmann (5):
      bpf: Add MEM_WRITE attribute
      bpf: Fix overloading of MEM_UNINIT's meaning
      bpf: Remove MEM_UNINIT from skb/xdp MTU helpers
      selftests/bpf: Add test for writes to .rodata
      selftests/bpf: Add test for passing in uninit mtu_len

Darrick J. Wong (1):
      xfs: don't fail repairs on metadata files with no attr fork

Dave Kleikamp (1):
      jfs: Fix sanity check in dbMount

David Howells (3):
      netfs: In readahead, put the folio refs as soon extracted
      netfs: Downgrade i_rwsem for a buffered write
      afs: Fix lock recursion

Derek Fang (1):
      ASoC: Intel: soc-acpi: lnl: Add match entry for TM2 laptops

Dmitry Antipov (2):
      net: sched: fix use-after-free in taprio_change()
      net: sched: use RCU read-side critical section in taprio_dump()

Dominique Martinet (5):
      Revert "9p: Enable multipage folios"
      Revert " fs/9p: mitigate inode collisions"
      Revert "fs/9p: remove redundant pointer v9ses"
      Revert "fs/9p: fix uaf in in v9fs_stat2inode_dotl"
      Revert "fs/9p: simplify iget to remove unnecessary paths"

Dr. David Alan Gilbert (2):
      KVM: Remove unused kvm_vcpu_gfn_to_pfn
      KVM: Remove unused kvm_vcpu_gfn_to_pfn_atomic

Eric Biggers (1):
      ALSA: hda/tas2781: select CRC32 instead of CRC32_SARWATE

Eric Dumazet (1):
      net: fix races in netdev_tx_sent_queue()/dev_watchdog()

Eyal Birger (2):
      xfrm: extract dst lookup parameters into a struct
      xfrm: respect ip protocols rules criteria when performing dst lookups

Filipe Manana (1):
      btrfs: clear force-compress on remount when compress mount option is =
given

Florian Westphal (2):
      xfrm: policy: remove last remnants of pernet inexact list
      netfilter: bpf: must hold reference on net namespace

Frank Min (1):
      drm/amdgpu: fix random data corruption for sdma 7

Gonzalo Silvalde Blanco (1):
      fbdev: sstfb: Make CONFIG_FB_DEVICE optional

Haiyang Zhang (1):
      hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER eve=
nt

Hangbin Liu (1):
      MAINTAINERS: add samples/pktgen to NETWORKING [GENERAL]

Hans de Goede (1):
      HID: lenovo: Add support for Thinkpad X1 Tablet Gen 3 keyboard

Heiner Kallweit (1):
      r8169: avoid unsolicited interrupts

Henrique Carvalho (1):
      smb: client: Handle kstrdup failures for passwords

Hongbo Li (2):
      bcachefs: fix incorrect show_options results
      bcachefs: skip mount option handle for empty string.

Hou Tao (3):
      bpf: Preserve param->string when parsing mount options
      bpf: Add the missing BPF_LINK_TYPE invocation for sockmap
      bpf: Check validity of link->type in bpf_link_show_fdinfo()

Huacai Chen (5):
      LoongArch: Get correct cores_per_package for SMT systems
      LoongArch: Enable IRQ if do_ale() triggered in irq-enabled context
      LoongArch: Set correct size for vDSO code mapping
      LoongArch: Make KASAN usable for variable cpu_vabits
      LoongArch: KVM: Mark hrtimer to expire in hard interrupt context

Ilkka Koskinen (1):
      KVM: arm64: Fix shift-out-of-bounds bug

Ilya Dudikov (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS E1404FA

Jack Yu (1):
      ASoC: rt722-sdca: increase clk_stop_timeout to fix clock stop issue

Jakub Boehm (1):
      net: plip: fix break; causing plip to never transmit

Jakub Kicinski (1):
      MAINTAINERS: add Simon as an official reviewer

Javier Carrasco (1):
      drm/bridge: tc358767: fix missing of_node_put() in
for_each_endpoint_of_node()

Jesper Dangaard Brouer (1):
      mailmap: update entry for Jesper Dangaard Brouer

Jinjie Ruan (1):
      posix-clock: posix-clock: Fix unbalanced locking in pc_clock_settime(=
)

Jiri Olsa (1):
      bpf,perf: Fix perf_event_detach_bpf_prog error handling

Jonathan Corbet (1):
      netfs: fix documentation build error

Jos=C3=A9 Relvas (1):
      ALSA: hda/realtek: Add subwoofer quirk for Acer Predator G9-593

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda-loader: do not wait for HDaudio IOC

Kailang Yang (1):
      ALSA: hda/realtek: Update default depop procedure

Kenneth Albanowski (1):
      HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpa=
d

Kenneth Feng (3):
      drm/amd/pm: update the driver-fw interface file for smu v14.0.2/3
      drm/amd/pm: update overdrive function on smu v14.0.2/3
      drm/amd/pm: update deep sleep status on smu v14.0.2/3

Kent Overstreet (24):
      bcachefs: fix restart handling in bch2_rename2()
      bcachefs: fix bch2_hash_delete() error path
      bcachefs: fix restart handling in bch2_fiemap()
      bcachefs: fix missing restart handling in bch2_read_retry_nodecode()
      bcachefs: fix restart handling in bch2_do_invalidates_work()
      bcachefs: fix restart handling in bch2_alloc_write_key()
      bcachefs: fix restart handling in __bch2_resume_logged_op_finsert()
      bcachefs: handle restarts in bch2_bucket_io_time_reset()
      bcachefs: Don't use commit_do() unnecessarily
      bcachefS: ec: fix data type on stripe deletion
      bcachefs: fix disk reservation accounting in bch2_folio_reservation_g=
et()
      bcachefs: bch2_folio_reservation_get_partial() is now better behaved
      bcachefs: Fix data corruption on -ENOSPC in buffered write path
      bcachefs: Run in-kernel offline fsck without ratelimit errors
      bcachefs: INODE_STR_HASH() for bch_inode_unpacked
      bcachefs: Add hash seed, type to inode_to_text()
      bcachefs: Repair mismatches in inode hash seed, type
      bcachefs: bch2_hash_set_or_get_in_snapshot()
      bcachefs: fsck: Improve hash_check_key()
      bcachefs: Fix __bch2_fsck_err() warning
      bcachefs: Don't use wait_event_interruptible() in recovery
      bcachefs: Workaround for kvmalloc() not supporting > INT_MAX allocati=
ons
      bcachefs: Mark more errors as AUTOFIX
      bcachefs: Set bch_inode_unpacked.bi_snapshot in old inode path

Kirill A. Shutemov (1):
      x86/kvm: Override default caching mode for SEV-SNP and TDX

Kirill Marinushkin (1):
      ASoC: Change my e-mail to gmail

Koba Ko (1):
      ACPI: PRM: Find EFI_MEMORY_RUNTIME block for PRM handler and context

Kory Maincent (1):
      net: pse-pd: Fix out of bound for loop

Krzysztof Kozlowski (2):
      ASoC: qcom: Select missing common Soundwire module code on SDM845
      ASoC: qcom: sc7280: Fix missing Soundwire runtime stream alloc

Lad Prabhakar (1):
      ASoC: rsnd: Fix probe failure on HiHope boards due to endpoint parsin=
g

Leo Yan (1):
      tracing: Consider the NULL character when validating the event length

Li Huafei (1):
      fgraph: Fix missing unlock in register_ftrace_graph()

Li Nan (1):
      md: ensure child flush IO does not affect origin bio->bi_status

Lin Ma (1):
      net: wwan: fix global oob in wwan_rtnl_policy

Linus Torvalds (4):
      9p: fix slab cache name creation for real
      x86: fix user address masking non-canonical speculation issue
      x86: fix whitespace in runtime-const assembler output
      Linux 6.12-rc5

Luiz Augusto von Dentz (3):
      Bluetooth: hci_core: Disable works on hci_unregister_dev
      Bluetooth: SCO: Fix UAF on sco_sock_timeout
      Bluetooth: ISO: Fix UAF on iso_sock_timeout

Marc Zyngier (2):
      KVM: arm64: Don't eagerly teardown the vgic on init error
      KVM: arm64: Shave a few bytes from the EL2 idmap code

Marek Maslanka (1):
      platform/x86:intel/pmc: Revert "Enable the ACPI PM Timer to be
turned off when suspended"

Mario Limonciello (2):
      drm/amd: Guard against bad data for ATIF ACPI method
      drm/amd/display: Disable PSR-SU on Parade 08-01 TCON too

Mark Brown (2):
      KVM: arm64: Expose S1PIE to guests
      KVM: selftests: Fix build on on non-x86 architectures

Maxim Levitsky (1):
      KVM: VMX: reset the segment cache after segment init in vmx_vcpu_rese=
t()

Michael S. Tsirkin (1):
      virtio_net: fix integer overflow in stats

Michel Alex (1):
      net: phy: dp83822: Fix reset pin definitions

Mikel Rychliski (1):
      tracing/probes: Fix MAX_TRACE_ARGS limit handling

Miklos Szeredi (2):
      Revert "fuse: move initialization of fuse_file to
fuse_writepages() instead of in callback"
      fuse: remove stray debug line

Miquel Raynal (1):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupt properties

Naohiro Aota (1):
      btrfs: zoned: fix zone unusable accounting for freed reserved extent

Niklas Cassel (1):
      ata: libata: Set DID_TIME_OUT for commands that actually timed out

Nirmoy Das (2):
      drm/xe/ufence: Prefetch ufence addr to catch bogus address
      drm/xe: Don't restart parallel queues multiple times on GT reset

Olga Kornievskaia (1):
      nfsd: fix race between laundromat and free_stateid

Oliver Neukum (1):
      net: usb: usbnet: fix name regression

Oliver Upton (7):
      KVM: arm64: Unregister redistributor for failed vCPU creation
      KVM: arm64: nv: Keep reference on stage-2 MMU when scheduled out
      KVM: arm64: nv: Do not block when unmapping stage-2 if disallowed
      KVM: arm64: nv: Punt stage-2 recycling to a vCPU request
      KVM: arm64: nv: Clarify safety of allowing TLBI unmaps to reschedule
      KVM: arm64: vgic: Don't check for vgic_ready() when setting NR_IRQS
      KVM: arm64: Ensure vgic_ready() is ordered against MMIO registration

Pablo Neira Ayuso (1):
      netfilter: xtables: fix typo causing some targets not to load on IPv6

Pawan Gupta (1):
      x86/lam: Disable ADDRESS_MASKING in most cases

Peter Collingbourne (1):
      bpf, arm64: Fix address emission with tag-based KASAN enabled

Peter Rashleigh (1):
      net: dsa: mv88e6xxx: Fix error when setting port policy on mv88e6393x

Petr Vaganov (1):
      xfrm: fix one more kernel-infoleak in algo dumping

Qianqiang Liu (1):
      crypto: lib/mpi - Fix an "Uninitialized scalar variable" issue

Qiao Ma (1):
      uprobe: avoid out-of-bounds memory access of fetching args

Qu Wenruo (3):
      btrfs: qgroup: set a more sane default value for subtree drop thresho=
ld
      btrfs: fix the delalloc range locking if sector size < page size
      btrfs: reject ro->rw reconfiguration if there are hard ro requirement=
s

Ranjani Sridharan (4):
      ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
      ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
      soundwire: intel_ace2x: Send PDI stream number during prepare
      ASoC: SOF: Intel: hda: Always clean up link DMA during stop

Reinhard Speyerer (1):
      net: usb: qmi_wwan: add Fibocom FG132 0x0112 composition

Ryusuke Konishi (1):
      nilfs2: fix kernel bug due to missing clearing of buffer delay flag

Sabrina Dubroca (1):
      xfrm: validate new SA's prefixlen using SA family when sel.family is =
unset

Sean Christopherson (5):
      KVM: x86/mmu: Zap only SPs that shadow gPTEs when deleting memslot
      KVM: x86/mmu: Add lockdep assert to enforce safe usage of
kvm_unmap_gfn_range()
      KVM: x86: Clean up documentation for KVM_X86_QUIRK_SLOT_ZAP_ALL
      KVM: nSVM: Ignore nCR3[4:0] when loading PDPTEs from memory
      KVM: selftests: Fix out-of-bounds reads in CPUID test's array lookups

Shameer Kolothum (1):
      KVM: arm64: Make the exposed feature bits in AA64DFR0_EL1
writable from userspace

Shaoqin Huang (4):
      KVM: arm64: Disable fields that KVM doesn't know how to handle
in ID_AA64PFR1_EL1
      KVM: arm64: Use kvm_has_feat() to check if FEAT_SSBS is
advertised to the guest
      KVM: arm64: Allow userspace to change ID_AA64PFR1_EL1
      KVM: selftests: aarch64: Add writable test for ID_AA64PFR1_EL1

Shenghao Yang (3):
      net: dsa: mv88e6xxx: group cycle counter coefficients
      net: dsa: mv88e6xxx: read cycle counter period from hardware
      net: dsa: mv88e6xxx: support 4000ps cycle counter period

Shengjiu Wang (2):
      ASoC: fsl_esai: change dev_warn to dev_dbg in irq handler
      ASoC: fsl_micfil: Add sample rate constraint

Shubham Panwar (1):
      ACPI: button: Add DMI quirk for Samsung Galaxy Book2 to fix
initial lid detection issue

Shuicheng Lin (2):
      drm/xe: Enlarge the invalidation timeout from 150 to 500
      drm/xe: Handle unreliable MMIO reads during forcewake

Steven Rostedt (1):
      fgraph: Change the name of cpuhp state to "fgraph:online"

SurajSonawane2415 (1):
      fbdev: nvidiafb: fix inconsistent indentation warning

Takashi Sakamoto (1):
      firewire: core: fix invalid port index for parent device

Thomas Wei=C3=9Fschuh (1):
      LoongArch: Don't crash in stack_top() for tasks without vDSO

Thorsten Blum (1):
      proc: Fix W=3D1 build kernel-doc warning

Tim Harvey (1):
      net: dsa: microchip: disable EEE for KSZ879x/KSZ877x/KSZ876x

Vadim Fedorenko (1):
      bnxt_en: replace ptp_lock with irqsave variant

Vamsi Krishna Brahmajosyula (1):
      platform/x86/intel/pmc: Fix pmc_core_iounmap to call iounmap for
valid addresses

Venkata Prasad Potturu (2):
      ASoC: SOF: amd: Add error log for DSP firmware validation failure
      ASoC: SOF: amd: Fix for ACP SRAM addr for acp7.0 platform

Viktor Malik (1):
      objpool: fix choosing allocation for percpu slots

Vitaly Kuznetsov (1):
      KVM: selftests: x86: Avoid using SSE/AVX instructions

Vladimir Oltean (1):
      net/sched: act_api: deny mismatched skip_sw/skip_hw flags for
actions created by classifiers

Wang Hai (2):
      net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      be2net: fix potential memory leak in be_xmit()

Xinyu Zhang (1):
      block: fix sanity checks in blk_rq_map_user_bvec

Yang Erkun (1):
      nfsd: cancel nfsd_shrinker_work using sync mode in nfs4_state_shutdow=
n_net

Yanteng Si (1):
      LoongArch: Use "Exception return address" to comment ERA

Ye Bin (1):
      cifs: fix warning when destroy 'cifs_io_request_pool'

Yu Kuai (1):
      md/raid10: fix null ptr dereference in raid10_size()

Yuan Can (2):
      powercap: dtpm_devfreq: Fix error check against dev_pm_qos_add_reques=
t()
      mlxsw: spectrum_router: fix xa_store() error checking

Yue Haibing (1):
      btrfs: fix passing 0 to ERR_PTR in btrfs_search_dir_index_item()

Zhu Jun (1):
      ASoC: codecs: Fix error handling in aw_dev_get_dsp_status function

Zichen Xie (1):
      ASoC: qcom: Fix NULL Dereference in asoc_qcom_lpass_cpu_platform_prob=
e()

liwei (1):
      cpufreq: CPPC: fix perf_to_khz/khz_to_perf conversion exception

