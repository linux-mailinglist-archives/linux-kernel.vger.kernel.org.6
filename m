Return-Path: <linux-kernel+bounces-226456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE91913E94
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 23:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135901F21255
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359911849FB;
	Sun, 23 Jun 2024 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fiih0RfE"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A564085D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719178902; cv=none; b=NLegYsWIUH8QtMpWwSZjTVfUiPhbobIaCmgUu02Qs/vHlYkWiD7woB963ldZV7gNwD1jYudb/HKxPMe9Sq5+LKxYuj/ys4DBNAFh7lqQM2zlvAQMI3l9fUYn17j3OyAUlWT7yzefRlDb3jJUsi+bEBOek2BFxW4QM2ehykmjsJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719178902; c=relaxed/simple;
	bh=R59DoyZqdam0vMPX1tdcud6s3TAvYND31fI8Aox3s9M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pJ3SawMPZRZmsYlRu9q8Q9EXCby3UBvxGMySSxvjqTSuxNNTxoLeozUW7N5III0+LZu19J8Rou2t0SDIA/Wc1vO4/8f8r91SyMd1AccQQJJuagu3mczLW2e8I58vFh+dGqGVJJl04lHFgf6NU6xP5CLCY9qAhHCEuhQYaPJ2y9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fiih0RfE; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso3051581a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719178897; x=1719783697; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oHr35bV3Eme1X56XHlYiPrcFsTZijlFm6HVEcrngGjQ=;
        b=Fiih0RfE1K8DKlusufbWm9l+AaFq3syfE/cmWmwdfD7+DitzLl7Jp00sjouyS1lSmt
         nc86fB2TnRPKGJK7G3qKxvpppmrvx4yf83F2OqbYbdxQdK0Y0Qw+gCoVgksxqLClzViw
         oZx1WvXoTr+/PiMD9154VXlAYWaDudQZsvups=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719178897; x=1719783697;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oHr35bV3Eme1X56XHlYiPrcFsTZijlFm6HVEcrngGjQ=;
        b=rYS5nxgbm6N7MGudj8uUzinZx4lAub7NGK9X4EY4d1QYcoojs/tcHN6iOO+zNspPon
         V5VeLWxUQZMFPxllDCMxtt+RNsOSakG00m0ifnvr87QKd+vGRBI27PWJhRvGJjdFJ+gD
         coFcK+njkIgED5C5RNIpiAYcbInvaCLBLoD7A/RKtCCXy/ial9xAD0Oy1+D1CwiD6MnD
         WriiOKFBtZQXaKKFP5dyrRgPvc69TTFdlyOCz2gW2JndbO64XCK8ggr2Ifh1vvJfPoVE
         n9pkGLVyxa/r8waSqQkNm5ja7UgIZVWor0eMpWJuTnxuZLs2iEJHPfn5iw2VYlY5IaEO
         8Z5Q==
X-Gm-Message-State: AOJu0YzOrIGPrKCDQJ2VBc72Jse3ASDPGkjBTT2ZrRqHvQ4ubMu/6Do4
	ZzPlFuHsKtHcj78HN9Rdu/7TEgUNNl2fajJv4AQon2JktjxCWGx5N8FoO+bEMc27Q3hhLqPv+OK
	BFhpYVw==
X-Google-Smtp-Source: AGHT+IFYLUpWhT0k3yhopuL4BDphMnqCXTAUBSdYglKPbfDmEnTDVrEzFIqugyBVnSffVvi0hnbf6Q==
X-Received: by 2002:a50:bae1:0:b0:57c:a701:2311 with SMTP id 4fb4d7f45d1cf-57d4bdbfcafmr1992267a12.26.1719178897248;
        Sun, 23 Jun 2024 14:41:37 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30562ef3sm3902133a12.91.2024.06.23.14.41.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 14:41:36 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a72459d8d6aso88535166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:41:36 -0700 (PDT)
X-Received: by 2002:a17:906:3bc4:b0:a6f:e36:abae with SMTP id
 a640c23a62f3a-a7245b73b4emr162535166b.42.1719178895584; Sun, 23 Jun 2024
 14:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 17:41:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=wiMMT-2pfJZ8ckbnGTbSHy5mvvE=+-MyA_ARPUqiy_C1w@mail.gmail.com>
Message-ID: <CAHk-=wiMMT-2pfJZ8ckbnGTbSHy5mvvE=+-MyA_ARPUqiy_C1w@mail.gmail.com>
Subject: Linux 6.10-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another week, another release candidate.

So far, the 6.10 release cycle has been fairly calm, and rc5 continues
that trend. Let's hope things stay that way.

For once, the driver changes don't dominate the diffs, although it's
still about a third of it. But even that third is to some degree due
to just a couple of larger driver changes (hv_balloon, broadcom bnxt
network driver, and a qualcomm phy driver). There are certainly other
driver changes in there, but nothing very big.

The rest is just a fairly random collection of stuff. Yes, there's the
requisite bcachefs fixes, but also some networking selftests, some
documentation fixes, some random VM fixes, core networking, and a
smattering of architecture fixes.

But nothing strange, and nothing that makes me worry for 6.10.

Shortlog - as always - appended for people who want to get a feel for
the details.

              Linus

---

Abel Vesa (3):
      phy: qcom-qmp: qserdes-txrx: Add missing registers offsets
      phy: qcom-qmp: pcs: Add missing v6 N4 register offsets
      phy: qcom: qmp-combo: Switch from V6 to V6 N4 register offsets

Aditya Nagesh (1):
      Drivers: hv: Cosmetic changes for hv.c and balloon.c

Adrian Moreno (1):
      selftests: openvswitch: Set value to nla flags.

Ajrat Makhmutov (1):
      ALSA: hda/realtek: Enable headset mic on IdeaPad 330-17IKB 81DM

Aleksandr Nogikh (1):
      kcov: don't lose track of remote references during softirqs

Alex Deucher (2):
      drm/radeon: fix UBSAN warning in kv_dpm.c
      drm/amdgpu: fix UBSAN warning in kv_dpm.c

Alexey Dobriyan (1):
      kvm: do not account temporary allocations to kmem

Alexey Makhalov (1):
      drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency

Amer Al Shanawany (2):
      selftests: filesystems: fix warn_unused_result build warnings
      selftests: seccomp: fix format-zero-length warnings

Amit Kumar Mahapatra (1):
      spi: Fix SPI slave probe failure

Andre Przywara (2):
      regulator: axp20x: AXP717: fix LDO supply rails and off-by-ones
      mfd: axp20x: AXP717: Fix missing IRQ status registers range

Andrew Jones (1):
      KVM: selftests: Fix RISC-V compilation

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for ProBook
445/465 G11.

Ard Biesheuvel (2):
      efi/arm: Disable LPAE PAN when calling EFI runtime services
      efi/x86: Free EFI memory map only when installing a new one.

Arnd Bergmann (2):
      dmaengine: fsl-edma: avoid linking both modules
      mips: fix compat_sys_lseek syscall

Aryan Srivastava (1):
      net: mvpp2: use slab_build_skb for oversized frames

Ayala Beker (1):
      wifi: iwlwifi: scan: correctly check if PSC listen period is needed

Babu Moger (1):
      KVM: Stop processing *all* memslots when "null" mmu_notifier
handler is found

Baolin Wang (1):
      mm: shmem: fix getting incorrect lruvec when replacing a shmem folio

Barry Song (1):
      cifs: drop the incorrect assertion in cifs_swap_rw()

Bart Van Assche (2):
      scsi: core: Introduce the BLIST_SKIP_IO_HINTS flag
      scsi: usb: uas: Do not query the IO Advice Hints Grouping mode
page for USB/UAS devices

Bibo Mao (1):
      KVM: Discard zero mask with function kvm_dirty_ring_reset

Biju Das (1):
      regulator: core: Fix modpost error "regulator_get_regmap" undefined

Boris Burkov (1):
      btrfs: retry block group reclaim without infinite loop

Breno Leitao (1):
      KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()

Charles Keepax (2):
      spi: cs42l43: Correct SPI root clock speed
      spi: cs42l43: Drop cs35l56 SPI speed down to 11MHz

Chenliang Li (1):
      io_uring/rsrc: fix incorrect assignment of iter->nr_segs in
io_import_fixed

Christian G=C3=B6ttsche (1):
      yama: document function parameter

Christian K=C3=B6nig (2):
      drm/amdgpu: revert "take runtime pm reference when we attach a buffer=
" v2
      drm/amdgpu: cleanup MES11 command submission

Christian Marangi (1):
      mips: bmips: BCM6358: make sure CBR is correctly set

Colin Ian King (1):
      KVM: selftests: Fix shift of 32 bit unsigned int more than 32 bits

Dan Carpenter (1):
      ptp: fix integer overflow in max_vclocks_store

Daniel Borkmann (3):
      bpf: Fix reg_set_min_max corruption of fake_reg
      bpf: Reduce stack consumption in check_stack_write_fixed_off
      selftests/bpf: Add test coverage for reg_set_min_max handling

Daniel Miess (1):
      drm/amd/display: Change dram_clock_latency to 34us for dcn351

Dave Chinner (1):
      xfs: fix unlink vs cluster buffer instantiation race

Dave Martin (1):
      x86/resctrl: Don't try to free nonexistent RMIDs

David Hildenbrand (1):
      Revert "mm: init_mlocked_on_free_v3"

David Howells (3):
      cifs: Defer read completion
      cifs: Only pick a channel once per read request
      cifs: Move the 'pid' from the subreq to the req

David Ruth (1):
      net/sched: act_api: fix possible infinite loop in tcf_idr_check_alloc=
()

Dmitry Antipov (1):
      wifi: cfg80211: wext: add extra SIOCSIWSCAN data check

Dmitry Safonov (1):
      net/tcp_ao: Don't leak ao_info on error-path

Dustin L. Howett (1):
      ALSA: hda/realtek: Remove Framework Laptop 16 from quirks

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on N14AP7

En-Wei Wu (1):
      ice: avoid IRQ collision to fix init failure on ACPI S3 resume

Eric Dumazet (4):
      tcp: clear tp->retrans_stamp in tcp_rcv_fastopen_synack()
      ipv6: prevent possible NULL deref in fib6_nh_init()
      ipv6: prevent possible NULL dereference in rt6_probe()
      xfrm6: check ip6_dst_idev() return value in xfrm6_get_saddr()

Fabio Estevam (1):
      arm64: dts: imx93-11x11-evk: Remove the 'no-sdio' property

Florian Westphal (1):
      bpf: Avoid splat in pskb_pull_reason

Frank Li (1):
      arm64: dts: imx8qm-mek: fix gpio number for reg_usdhc2_vmmc

GUO Zihua (1):
      ima: Avoid blocking in RCU read-side critical section

Gavrilov Ilia (1):
      netrom: Fix a memory leak in nr_heartbeat_expiry()

Geetha sowjanya (1):
      octeontx2-pf: Fix linking objects into multiple modules

Gergely Meszaros (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14ARP8

Grygorii Tertychnyi (1):
      i2c: ocores: set IACK bit after core is enabled

Hamza Mahfooz (1):
      drm/amd/display: prevent register access while in IPS

Hans de Goede (2):
      ACPI: scan: Ignore camera graph port nodes on all Dell Tiger,
Alder and Raptor Lake models
      ACPI: mipi-disco-img: Switch to new Intel CPU model defines

Harish Kasiviswanathan (1):
      drm/amdgpu: Indicate CU havest info to CP

Haylen Chu (1):
      riscv: dts: sophgo: disable write-protection for milkv duo

Heng Qi (2):
      virtio_net: checksum offloading handling fix
      virtio_net: fixing XDP for fully checksummed packets handling

Honggang LI (2):
      RDMA/rxe: Fix data copy for IB_SEND_INLINE
      RDMA/rxe: Fix responder length checking for UD request packets

Hugh Dickins (1):
      mm/migrate: fix kernel BUG at mm/compaction.c:2761!

Hui Li (3):
      LoongArch: Fix watchpoint setting error
      LoongArch: Trigger user-space watchpoints correctly
      LoongArch: Fix multiple hardware watchpoint issues

Ignat Korchagin (1):
      net: do not leave a dangling sk pointer, when socket creation fails

Ilpo J=C3=A4rvinen (1):
      MIPS: Routerboard 532: Fix vendor retry check code

Jakub Kicinski (2):
      netdev-genl: fix error codes when outputting XDP features
      ipv6: bring NLM_DONE out to a separate recv() again

Jani Nikula (1):
      drm/i915/mso: using joiner is not possible with eDP MSO

Jason Gunthorpe (3):
      RDMA/mlx5: Remove extra unlock on error path
      RDMA/mlx5: Follow rb_key.ats when creating new mkeys
      RDMA/mlx5: Ensure created mkeys always have a populated rb_key

Jean-Philippe Brucker (1):
      mm/util: Swap kmemdup_array() arguments

Jeff Johnson (1):
      sound/oss/dmasound: add missing MODULE_DESCRIPTION() macro

Jeff Layton (1):
      nfsd: fix oops when reading pool_stats before server is started

Jeff Xu (1):
      mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC

Jianguo Wu (4):
      seg6: fix parameter passing when calling NF_HOOK() in End.DX4
and End.DX6 behaviors
      netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core
      selftests: add selftest for the SRv6 End.DX4 behavior with netfilter
      selftests: add selftest for the SRv6 End.DX6 behavior with netfilter

Jiaxun Yang (1):
      MIPS: mipsmtregs: Fix target register for MFTC0

Jiri Pirko (1):
      selftests: virtio_net: add forgotten config options

Joao Paulo Goncalves (1):
      arm64: dts: freescale: imx8mm-verdin: Fix GPU speed

Joel Slebodnick (1):
      scsi: ufs: core: Free memory allocated for model before reinit

Johannes Berg (2):
      wifi: cfg80211: wext: set ssids=3DNULL for passive scans
      wifi: mac80211: fix monitor channel with chanctx emulation

Johannes Thumshirn (1):
      btrfs: zoned: allocate dummy checksums for zoned NODATASUM writes

John Hubbard (2):
      selftests/openat2: fix clang build failures: -static-libasan, LOCAL_H=
DRS
      selftests/fchmodat2: fix clang build failure due to -static-libasan

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve reset check

Joseph Qi (2):
      ocfs2: fix NULL pointer dereference in ocfs2_journal_dirty()
      ocfs2: fix NULL pointer dereference in ocfs2_abort_trigger()

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix suspicious rcu_dereference_protected()

Julien Panis (2):
      thermal/drivers/mediatek/lvts_thermal: Remove filtered mode for mt818=
8
      thermal/drivers/mediatek/lvts_thermal: Return error in case of
invalid efuse data

Kailang Yang (1):
      ALSA: hda/realtek: Add more codec ID to no shutup pins list

Kalle Niemi (1):
      regulator: bd71815: fix ramp values

Kees Cook (2):
      kunit/overflow: Adjust for __counted_by with DEFINE_RAW_FLEX()
      MAINTAINERS: Update entries for Kees Cook

Kefeng Wang (1):
      mm: fix possible OOB in numa_rebuild_large_mapping()

Kent Overstreet (20):
      bcachefs: Fix initialization order for srcu barrier
      bcachefs: Fix array-index-out-of-bounds
      bcachefs: Fix a locking bug in the do_discard_fast() path
      bcachefs: Fix shift overflow in read_one_super()
      bcachefs: Fix btree ID bitmasks
      bcachefs: Check for invalid btree IDs
      bcachefs: Fix early init error path in journal code
      bcachefs: delete_dead_snapshots() doesn't need to go RW
      bcachefs: Guard against overflowing LRU_TIME_BITS
      bcachefs: Handle cached data LRU wraparound
      bcachefs: Fix bch2_sb_downgrade_update()
      bcachefs: set_worker_desc() for delete_dead_snapshots
      bcachefs: Fix bch2_trans_put()
      bcachefs: Fix safe errors by default
      closures: Change BUG_ON() to WARN_ON()
      bcachefs: Fix missing alloc_data_type_set()
      bcachefs: Replace bare EEXIST with private error codes
      bcachefs: Fix I_NEW warning in race path in bch2_inode_insert()
      bcachefs: Use bch2_print_string_as_lines for long err
      bcachefs: Fix a UAF after write_super()

Kenton Groombridge (1):
      wifi: mac80211: Avoid address calculations via out of bounds
array indexing

Konstantin Taranov (1):
      RDMA/mana_ib: Ignore optional access flags for MRs

Krzysztof Kozlowski (3):
      dt-bindings: dma: fsl-edma: fix dma-channels constraints
      dt-bindings: i2c: atmel,at91sam: correct path to i2c-controller schem=
a
      dt-bindings: i2c: google,cros-ec-i2c-tunnel: correct path to
i2c-controller schema

Li RongQing (1):
      dmaengine: idxd: Fix possible Use-After-Free in irq_process_work_list

Likun Gao (1):
      drm/amdgpu: init TA fw for psp v14

Linus Torvalds (3):
      Revert "mm: mmap: allow for the maximum number of bits for
randomizing mmap_base by default"
      cpumask: limit FORCE_NR_CPUS to just the UP case
      Linux 6.10-rc5

Liu Ying (1):
      arm: dts: imx53-qsb-hdmi: Disable panel instead of deleting node

Lorenzo Bianconi (1):
      NFSD: grab nfsd_mutex in nfsd_nl_rpc_status_get_dumpit()

Lorenzo Stoakes (1):
      MAINTAINERS: remove Lorenzo as vmalloc reviewer

Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix data synchronisation in xdma_channel_isr=
()

Maciej =C5=BBenczykowski (1):
      bpf: fix UML x86_64 compile failure

Marc Kleine-Budde (1):
      spi: spi-imx: imx51: revert burst length calculation back to bits_per=
_word

Marc Zyngier (1):
      KVM: arm64: Disassociate vcpus from redistributor region on teardown

Marcin Szycik (1):
      ice: Fix VSI list rule with ICE_SW_LKUP_LAST type

Marek Vasut (1):
      arm64: dts: imx8mp: Fix TC9595 input clock on DH i.MX8M Plus DHCOM So=
M

Mark Brown (1):
      selftests: mm: make map_fixed_noreplace test names stable

Martin Schiller (1):
      MIPS: pci: lantiq: restore reset gpio polarity

Masami Hiramatsu (Google) (1):
      tracing: Build event generation tests only as modules

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: userspace_pm: fixed subtest names

Max Krummenacher (1):
      arm64: dts: freescale: imx8mm-verdin: enable hysteresis on slow input=
 pin

Michael Chan (2):
      bnxt_en: Update firmware interface to 1.10.3.44
      bnxt_en: Set TSO max segs on devices with limits

Michael Ellerman (1):
      KVM: PPC: Book3S HV: Prevent UAF in kvm_spapr_tce_attach_iommu_group(=
)

Michael Kelley (4):
      hv_balloon: Use kernel macros to simplify open coded sequences
      hv_balloon: Enable hot-add for memblock sizes > 128 MiB
      Documentation: hyperv: Update spelling and fix typo
      Documentation: hyperv: Improve synic and interrupt handling descripti=
on

Michael Roth (1):
      KVM: SEV-ES: Fix svm_get_msr()/svm_set_msr() for KVM_SEV_ES_INIT gues=
ts

Michael Strauss (1):
      drm/amd/display: Attempt to avoid empty TUs when endpoint is DPIA

Michal Wajdeczko (1):
      drm/xe/vf: Don't touch GuC irq registers if using memory irqs

Miguel Ojeda (1):
      rust: avoid unused import warning in `rusttest`

Mike Rapoport (IBM) (1):
      memblock: use numa_valid_node() helper to check for invalid node ID

Miklos Szeredi (2):
      ovl: fix copy-up in tmpfile
      ovl: fix encoding fid for lower only root

Nathan Chancellor (1):
      drm/amd/display: Disable CONFIG_DRM_AMD_DC_FP for RISC-V with clang

Nathan Lynch (1):
      powerpc/crypto: Add generated P8 asm to .gitignore

Nikita Shubin (4):
      dmaengine: ioatdma: Fix leaking on version mismatch
      dmaengine: ioatdma: Fix error path in ioat3_dma_probe()
      dmaengine: ioatdma: Fix kmemleak in ioat_pci_probe()
      dmaengine: ioatdma: Fix missing kmem_cache_destroy()

Niklas Cassel (1):
      ata: ahci: Do not enable LPM if no LPM states are supported by the HB=
A

Oleg Nesterov (1):
      zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDI=
NG

Oleksij Rempel (3):
      net: phy: dp83tg720: wake up PHYs in managed mode
      net: phy: dp83tg720: get master/slave configuration in link down stat=
e
      net: stmmac: Assign configured channel value to EXTTS event

Oliver Neukum (1):
      net: usb: rtl8150 fix unintiatilzed variables in
rtl8150_get_link_ksettings

Ondrej Mosnacek (2):
      cipso: fix total option length computation
      cipso: make cipso_v4_skbuff_delattr() fully remove the CIPSO options

Pablo Ca=C3=B1o (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9

Paolo Bonzini (1):
      virt: guest_memfd: fix reference leak on hwpoisoned page

Patrice Chotard (3):
      spi: stm32: qspi: Fix dual flash mode sanity test in stm32_qspi_setup=
()
      spi: stm32: qspi: Clamp stm32_qspi_get_mode() output to CCR_BUSWIDTH_=
4
      spi: Fix OCTAL mode support

Patrisious Haddad (1):
      RDMA/mlx5: Add check for srq max_sge attribute

Paul Greenwalt (1):
      ice: fix 200G link speed message log

Paul Hsieh (1):
      drm/amd/display: change dram_clock_latency to 34us for dcn35

Pavan Chebbi (1):
      bnxt_en: Restore PTP tx_avail count in case of skb_pad() error

Peter Oberparleiter (1):
      gcov: add support for GCC 14

Peter Ujfalusi (1):
      ALSA/hda: intel-dsp-config: Document AVS as dsp_driver option

Peter Xu (2):
      mm/page_table_check: fix crash on ZONE_DEVICE
      mm/debug_vm_pgtable: drop RANDOM_ORVALUE trick

Pierre-Louis Bossart (1):
      soundwire: fix usages of device_get_named_child_node()

Rafael Aquini (1):
      mm: mmap: allow for the maximum number of bits for randomizing
mmap_base by default

Rafael J. Wysocki (2):
      thermal: core: Synchronize suspend-prepare and post-suspend actions
      thermal: core: Change PM notifier priority to the minimum

Raju Lakkaraju (3):
      net: lan743x: disable WOL upon resume to restore full data path opera=
tion
      net: lan743x: Support WOL at both the PHY and MAC appropriately
      net: phy: mxl-gpy: Remove interrupt mask clearing from config_init

Raju Rangoju (1):
      ACPICA: Revert "ACPICA: avoid Info: mapping multiple BARs. Your
kernel is fine."

Ran Xiaokai (1):
      mm: huge_memory: fix misused mapping_large_folio_support() for anon f=
olios

Remi Pommarel (1):
      wifi: mac80211: Recalc offload when monitor stop

Roman Li (1):
      drm/amd/display: Remove redundant idle optimization check

Sakari Ailus (1):
      i2c: Add nop fwnode operations

Saurabh Sengar (1):
      tools: hv: suppress the invalid warning for packed member alignment

Sean Christopherson (2):
      KVM: x86: Always sync PIR to IRR prior to scanning I/O APIC routes
      MAINTAINERS: Drop Wanpeng Li as a Reviewer for KVM Paravirt support

Selvin Xavier (1):
      RDMA/bnxt_re: Fix the max msix vectors macro

Shaul Triebitz (2):
      wifi: iwlwifi: mvm: unlock mvm mutex
      wifi: iwlwifi: mvm: fix ROC version check

Siddharth Vadapalli (1):
      dmaengine: ti: k3-udma-glue: Fix of_k3_udma_glue_parse_chn_by_id()

Simon Horman (2):
      selftests: openvswitch: Use bash as interpreter
      octeontx2-pf: Add error handling to VLAN unoffload handling

Simon Trimmer (6):
      ALSA: hda: cs35l56: Fix lifecycle of codec pointer
      ALSA: hda: cs35l41: Possible null pointer dereference in
cs35l41_hda_unbind()
      ALSA: hda: cs35l56: Component should be unbound before deconstruction
      ALSA: hda: cs35l41: Component should be unbound before deconstruction
      ALSA: hda: tas2781: Component should be unbound before deconstruction
      ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE

Srinivas Pandruvada (1):
      thermal: int340x: processor_thermal: Support shared interrupts

Stanislav Fomichev (1):
      MAINTAINERS: mailmap: Update Stanislav's email address

Stefan Binding (4):
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P Gen 5
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 13x Gen 4
      ALSA: hda/realtek: Support Lenovo Thinkbook 16P Gen 5
      ALSA: hda/realtek: Support Lenovo Thinkbook 13x Gen 4

Stefan Wahren (1):
      qca_spi: Make interrupt remembering atomic

Steve French (1):
      cifs: fix typo in module parameter enable_gcm_256

Sudeep Holla (1):
      firmware: psci: Fix return value from psci_system_suspend()

Suren Baghdasaryan (2):
      lib/alloc_tag: do not register sysctl interface when CONFIG_SYSCTL=3D=
n
      lib/alloc_tag: fix RCU imbalance in pgalloc_tag_get()

Takashi Iwai (2):
      ALSA: seq: ump: Fix missing System Reset message handling
      ALSA: hda: Use imply for suggesting CONFIG_SERIAL_MULTI_INSTANTIATE

Tao Su (1):
      KVM: selftests: x86: Prioritize getting max_gfn from GuestPhysBits

Thomas Bogendoerfer (1):
      Revert "MIPS: pci: lantiq: restore reset gpio polarity"

Thomas Richard (1):
      regulator: tps6594-regulator: Fix the number of irqs for
TPS65224 and TPS6594

Tim Harvey (1):
      arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix BT shutdown GPIO

Tony Ambardar (2):
      compiler_types.h: Define __retain for __attribute__((__retain__))
      bpf: Harden __bpf_kfunc tag against linker kfunc removal

Uwe Kleine-K=C3=B6nig (3):
      pwm: stm32: Refuse too small period requests
      pwm: stm32: Fix calculation of prescaler
      pwm: stm32: Fix error message to not describe the previous error path

Vincent Donnefort (1):
      KVM: arm64: FFA: Release hyp rx buffer

Waiman Long (1):
      efi/arm64: Fix kmemleak false positive in arm64_efi_rt_init()

Wojciech Drewek (1):
      ice: implement AQ download pkg retry

Wolfram Sang (6):
      docs: i2c: summary: start sentences consistently.
      docs: i2c: summary: update I2C specification link
      docs: i2c: summary: update speed mode description
      docs: i2c: summary: document use of inclusive language
      docs: i2c: summary: document 'local' and 'remote' targets
      docs: i2c: summary: be clearer with 'controller/target' and
'adapter/client' pairs

Xi Ruoyao (1):
      LoongArch: Only allow OBJTOOL & ORC unwinder if toolchain
supports -mthin-add-sub

Xiaolei Wang (1):
      net: stmmac: No need to calculate speed divider when offload is disab=
led

Xin Long (2):
      tipc: force a dst refcount before doing decryption
      sched: act_ct: add netns into the key of tcf_ct_flow_table

Yang Li (1):
      LoongArch: KVM: Remove an unneeded semicolon

Yishai Hadas (1):
      RDMA/mlx5: Fix unwind flow as part of mlx5_ib_stage_init_init

Youling Tang (2):
      bcachefs: fix alignment of VMA for memory mapped files on THP
      bcachefs: Move the ei_flags setting to after initialization

Yue Haibing (1):
      netns: Make get_net_ns() handle zero refcount net

Yunxiang Li (1):
      drm/amdgpu: fix locking scope when flushing tlb

Yury Norov (1):
      gcc: disable '-Warray-bounds' for gcc-9

