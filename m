Return-Path: <linux-kernel+bounces-207515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC21F90184C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 23:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4EC1C20CE6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2324DA0C;
	Sun,  9 Jun 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aOUvvXVq"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249C18C22
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717968445; cv=none; b=YaQU51+bdLTWw3WGHwKz51YcvQCNBuqrcnT38YPjJfjbD3DAuR8fa9dojScf1bf6htEv3ucnRqH9UAaCoUm/1YOHTRt8ic8Qxo8YSo07DWFNK83NxVWI4bt+dLlFmvqtlbqaRpXnH4sHlHdD1/fx0Wk0ouzVylnU0O4KML40p40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717968445; c=relaxed/simple;
	bh=qw26Rh944yHbSxmUhUHG80a8C8gvkVdDtx5DHHxaei8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IkxIZs6xHmdrFWUF99if26kX/AnWtt5wIKrEdOwYsqyTs26Q09jiFVv+s/+MDw9Fy1n1Cd9/jfZikARwQG7y04xhm0vvshe1Rdgn6bhKdHLQayxTqCb5CaNHHpqCry3HPtzP1Y4sP7lfJGnLzCbualKLDtbt89ODJEfLzwg8Kws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aOUvvXVq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso2441777e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 14:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717968440; x=1718573240; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZK9TbA5uZ2g+oiphcewNtBOdx+OcpgjCQsrxRZp2eNM=;
        b=aOUvvXVqaOjSxHsyM02iKrU6+XvchPHWPfi9I1Za8GNDoKF9wM8kB4LS3tPTEFohaq
         64AV58Hj1iR12+W7QQjc9IyLI4nABN8i4bPDEPady2oc0CHZ/Xf5YIIyQ2/JXAfCZ3hp
         pcaYrLoB8w8nw+mPwnNaOkcUZCpaSmVl6s1W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717968440; x=1718573240;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK9TbA5uZ2g+oiphcewNtBOdx+OcpgjCQsrxRZp2eNM=;
        b=B9CI4X23XKN+qC6hGkdUBlzquWqUL+zkqiMRvnvfOw6nCW0oOMFNbYfQ1gB8qR6eiy
         /n/C+rXpuNH4FWI7fJo3K1P9Ez8Krr3WEzAkT4NQtDj4WRP2fo9ezge3gytW3FH5QSho
         eoi3byMSdqwavMQmXf1QcHoqAylDVDGU+XZ1yDIIW4KVH7jejWVzR5RjqWYNgnXEhqpA
         dWlM2zdPxyNYpv2I5HSdaUd2NpUbogu1nLiAhNT3sBunJ+7mJXl/yze36Wm48thYrrjP
         LfkuRsbubvZ2z/r6HEC2hKgr45ZRVRqUxpjksT5Tj40RPzZszzJVlTyIRpArBHucHdpS
         +etw==
X-Gm-Message-State: AOJu0YxQquRcPuEjQk8aQm5gDIO8Shw2I9OsV4HiEP5uKGNxvAaGOwNK
	UCC08JOL2Ha2AIWe0D7I/fG6zvgSBm2ToLffz+BLSt4/T6SghGyaSWP6n7h2on9vN0B7UZtqO3f
	aFqg=
X-Google-Smtp-Source: AGHT+IHMUDyIooumoTKlcTldfKVoNDQJQXea1HyCkUdViAUw8v2DnRh++3YiJ77WSuyS4lZgIwhEMQ==
X-Received: by 2002:a05:6512:234f:b0:52b:9545:85ff with SMTP id 2adb3069b0e04-52bb9fc5db8mr7502785e87.44.1717968439688;
        Sun, 09 Jun 2024 14:27:19 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c84cba425sm399386e87.74.2024.06.09.14.27.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jun 2024 14:27:19 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so76057451fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 14:27:19 -0700 (PDT)
X-Received: by 2002:a2e:2c0f:0:b0:2e9:8b8c:88a6 with SMTP id
 38308e7fff4ca-2eadce3df96mr60193691fa.13.1717968438048; Sun, 09 Jun 2024
 14:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Jun 2024 14:27:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
Message-ID: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com>
Subject: Linux 6.10-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm. Absolutely nothing stands out here.

We've got driver fixes (networking, gpu, HID and x86 platform drivers
account for the bulk of it), architecture fixes (mostly kvm-related),
and some core kernel updates (filesystems, mm, core networking). And
just the regular random fixes.

IOW, nothing looks particularly odd, and size-wise this is also pretty
much right where you'd expect for an rc3.

So things look good, the water is warm, please jump right in and keep testi=
ng,

              Linus

---

Aditya Kumar Singh (1):
      wifi: mac80211: pass proper link id for channel switch started
notification

Aleksandr Mishin (2):
      net/mlx5: Fix tainted pointer delete is case of flow rules creation f=
ail
      net: wwan: iosm: Fix tainted pointer delete is case of region
creation fail

Alexander Gordeev (1):
      s390/crash: Do not use VM info if os_info does not have it

Alexander Potapenko (1):
      kmsan: do not wipe out origin when doing partial unpoisoning

Alexis Lothor=C3=A9 (3):
      Revert "wifi: wilc1000: convert list management to RCU"
      Revert "wifi: wilc1000: set atomic flag on kmemdup in srcu
critical section"
      wifi: wilc1000: document SRCU usage instead of SRCU

Andreas Hindborg (1):
      null_blk: fix validation of block size

Andrew Ballance (1):
      hid: asus: asus_report_fixup: fix potential read out of bounds

Andrii Nakryiko (2):
      selftests/bpf: fix inet_csk_accept prototype in test_sk_storage_traci=
ng.c
      libbpf: don't close(-1) in multi-uprobe feature detector

Andy Shevchenko (3):
      PNP: Make dev_is_pnp() to be a function and export it for modules
      PNP: Hide pnp_bus_type from the non-PNP code
      platform/x86: touchscreen_dmi: Use 2-argument strscpy()

Ard Biesheuvel (1):
      efi: Add missing __nocfi annotations to runtime wrappers

Armin Wolf (4):
      ACPI: EC: Abort address space access upon error
      ACPI: EC: Avoid returning AE_OK on errors in address space handler
      platform/x86: dell-smbios: Fix wrong token data in sysfs
      platform/x86: dell-smbios: Simplify error handling

Arnaldo Carvalho de Melo (12):
      tools include UAPI: Sync linux/stat.h with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync fcntl.h with the kernel sources to pick
F_DUPFD_QUERY
      perf beauty: Update copy of linux/socket.h with the kernel sources
      perf trace beauty: Update the arch/x86/include/asm/irq_vectors.h
copy with the kernel sources to pick POSTED_MSI_NOTIFICATION
      tools headers: Update the syscall tables and unistd.h, mostly to
support the new 'mseal' syscall
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync kvm headers with the kernel sources
      tools headers UAPI: Update i915_drm.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources to
pick STATX_SUBVOL
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      Revert "perf record: Reduce memory for recording
PERF_RECORD_LOST_SAMPLES event"

Arnd Bergmann (4):
      cpufreq: amd-pstate: remove global header file
      platform/x86: yt2-1380: add CONFIG_EXTCON dependency
      HID: intel-ish-hid: fix endian-conversion
      arm64/io: add constant-argument check

Aseda Aboagye (2):
      input: Add event code for accessibility key
      input: Add support for "Do Not Disturb"

Ayala Beker (1):
      wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option

Baochen Qiang (1):
      wifi: ath11k: move power type check to ASSOC stage when
connecting to 6 GHz AP

Baolin Wang (1):
      mm: drop the 'anon_' prefix for swap-out mTHP counters

Barry Song (2):
      mm: huge_mm: fix undefined reference to `mthp_stats' for CONFIG_SYSFS=
=3Dn
      mm: arm64: fix the out-of-bounds issue in contpte_clear_young_dirty_p=
tes

Benjamin Berg (1):
      wifi: iwlwifi: mvm: remove stale STA link data during restart

Bingbu Cao (3):
      media: intel/ipu6: fix the buffer flags caused by wrong parentheses
      media: intel/ipu6: update the maximum supported csi2 port number to 6
      media: intel/ipu6: add csi2 port sanity check in notifier bound

Bitterblue Smith (1):
      wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS

Breno Leitao (1):
      wifi: ath11k: Fix error path in ath11k_pcic_ext_irq_config

Carl Huang (1):
      wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs

Carlos Llamas (1):
      locking/atomic: scripts: fix ${atomic}_sub_and_test() kerneldoc

Chanwoo Lee (1):
      scsi: ufs: mcq: Fix error output and clean up ufshcd_mcq_abort()

Chen Ni (2):
      HID: nvidia-shield: Add missing check for input_ff_create_memless
      drm/panel: sitronix-st7789v: Add check for of_drm_get_panel_orientati=
on

Chengming Zhou (2):
      mm/ksm: fix ksm_pages_scanned accounting
      mm/ksm: fix ksm_zero_pages accounting

Christophe JAILLET (5):
      i2c: synquacer: Remove a clk reference from struct synquacer_i2c
      media: intel/ipu6: Fix some redundant resources freeing in
ipu6_pci_remove()
      media: intel/ipu6: Move isys_remove() close to isys_probe()
      media: intel/ipu6: Fix an error handling path in isys_probe()
      HID: nintendo: Fix an error handling path in nintendo_hid_probe()

Chuck Lever (1):
      SUNRPC: Fix loop termination condition in gss_free_in_token_pages()

Chunguang Xu (1):
      nvme-fabrics: use reserved tag for reg read/write command

Cong Wang (2):
      bpf: Fix a potential use-after-free in bpf_link_free()
      vmalloc: check CONFIG_EXECMEM in is_vmalloc_or_module_addr()

Dan Williams (2):
      ACPI: APEI: EINJ: Fix einj_dev release leak
      PCI: Revert the cfg_access_lock lockdep mechanism

Daniel Borkmann (1):
      vxlan: Fix regression when dropping packets due to invalid src addres=
ses

Dave Jiang (1):
      cxl/test: Add missing vmalloc.h for tools/testing/cxl/test/mem.c

David Hildenbrand (1):
      KVM: s390x: selftests: Add shared zeropage test

David Howells (1):
      cifs: Don't advance the I/O iterator before terminating subrequest

David Kaplan (1):
      x86/kexec: Fix bug with call depth tracking

DelphineCCChiu (1):
      net/ncsi: Fix the multi thread manner of NCSI driver

Deming Wang (1):
      scsi: mpt3sas: Add missing kerneldoc parameter descriptions

Dhananjay Ugwekar (2):
      tools/power/cpupower: Fix Pstate frequency reporting on AMD
Family 1Ah CPUs
      cpufreq: amd-pstate: Fix the inconsistency in max frequency units

Dmitry Antipov (1):
      wifi: mac80211: fix UBSAN noise in ieee80211_prep_hw_scan()

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

Dmitry Safonov (1):
      net/tcp: Don't consider TCP_CLOSE in TCP_AO_ESTABLISHED

Dr. David Alan Gilbert (2):
      drm/komeda: remove unused struct 'gamma_curve_segment'
      drm/vmwgfx: remove unused struct 'vmw_stdu_dma'

Duoming Zhou (1):
      ax25: Replace kfree() in ax25_dev_free() with ax25_dev_put()

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: fix a crash on 7265
      wifi: iwlwifi: mvm: don't read past the mfuart notifcation

Enzo Matsumiya (1):
      smb: client: fix deadlock in smb2_find_smb_tcon()

Eric Dumazet (7):
      ipv6: ioam: block BH from ioam6_output()
      net: ipv6: rpl_iptunnel: block BH in rpl_output() and rpl_input()
      ipv6: sr: block BH in seg6_output_core() and seg6_input_core()
      ila: block BH in ila_output()
      net: dst_cache: add two DEBUG_NET warnings
      net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
      ipv6: fix possible race in __fib6_drop_pcpu_from()

Filipe Manana (2):
      btrfs: ensure fast fsync waits for ordered extents after a write fail=
ure
      btrfs: fix leak of qgroup extent records after transaction abort

Frank Wunderlich (1):
      net: ethernet: mtk_eth_soc: handle dma buffer size soc specific

Fuad Tabba (9):
      KVM: arm64: Reintroduce __sve_save_state
      KVM: arm64: Fix prototype for __sve_save_state/__sve_restore_state
      KVM: arm64: Abstract set/clear of CPTR_EL2 bits behind helper
      KVM: arm64: Specialize handling of host fpsimd state on trap
      KVM: arm64: Allocate memory mapped at hyp for host sve state in pKVM
      KVM: arm64: Eagerly restore host fpsimd/sve state in pKVM
      KVM: arm64: Consolidate initializing the host data's
fpsimd_state/sve in pKVM
      KVM: arm64: Refactor CPACR trap bit setting/clearing to use ELx forma=
t
      KVM: arm64: Ensure that SME controls are disabled in protected mode

Gregor Herburger (1):
      gpio: tqmx86: fix typo in Kconfig label

Guilherme G. Piccoli (1):
      efi: pstore: Return proper errors on UEFI failures

Hagar Hemdan (2):
      irqchip/gic-v3-its: Fix potential race condition in its_vlpi_prop_upd=
ate()
      io_uring: fix possible deadlock in io_register_iowq_max_workers()

Haifeng Xu (1):
      perf/core: Fix missing wakeup when waiting for context reference

Hangbin Liu (1):
      selftests: hsr: add missing config for CONFIG_BRIDGE

Hangyu Hua (1):
      net: sched: sch_multiq: fix possible OOB write in multiq_tune()

Hans de Goede (2):
      Input: silead - Always support 10 fingers
      platform/x86: touchscreen_dmi: Drop "silead,max-fingers" property

Heiner Kallweit (1):
      i2c: Remove I2C_CLASS_SPD

Heng Qi (3):
      virtio_net: fix missing lock protection on control_buf access
      virtio_net: fix possible dim status unrecoverable
      virtio_net: fix a spurious deadlock issue

Huacai Chen (1):
      LoongArch: Fix GMAC's phy-mode definitions in dts

Ian Forbes (6):
      drm/vmwgfx: Filter modes which exceed graphics memory
      drm/vmwgfx: 3D disabled should not effect STDU memory limits
      drm/vmwgfx: Remove STDU logic from generic mode_valid function
      drm/vmwgfx: Standardize use of kibibytes when logging
      drm/vmwgfx: Don't destroy Screen Target when CRTC is enabled but inac=
tive
      drm/vmwgfx: Don't memcmp equivalent pointers

Ilan Peer (1):
      wifi: iwlwifi: mvm: Fix scan abort handling with HW rfkill

Ilpo J=C3=A4rvinen (2):
      EDAC/amd64: Convert PCIBIOS_* return codes to errnos
      EDAC/igen6: Convert PCIBIOS_* return codes to errnos

Isaku Yamahata (1):
      KVM: x86/mmu: Use SHADOW_NONPRESENT_VALUE for atomic zap in TDP MMU

Jacob Keller (2):
      ice: fix iteration of TLVs in Preserved Fields Area
      ice: fix reads from NVM Shadow RAM on E830 and E825-C devices

Jakub Kicinski (2):
      net: tls: fix marking packets as decrypted
      rtnetlink: make the "split" NLM_DONE handling generic

Jan Beulich (1):
      tpm_tis: Do *not* flush uninitialized work

Jason Xing (3):
      net: rps: fix error when CONFIG_RFS_ACCEL is off
      tcp: count CLOSE-WAIT sockets for TCP_MIB_CURRESTAB
      mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB

Jeff Johnson (4):
      of: of_test: add MODULE_DESCRIPTION()
      lib/test_rhashtable: add missing MODULE_DESCRIPTION() macro
      HID: logitech-hidpp: add missing MODULE_DESCRIPTION() macro
      gpio: add missing MODULE_DESCRIPTION() macros

Jens Axboe (2):
      io_uring: check for non-NULL file pointer in io_file_can_poll()
      io_uring/napi: fix timeout calculation

Jiaxun Yang (4):
      LoongArch: Fix built-in DTB detection
      LoongArch: Add all CPUs enabled by fdt to NUMA node 0
      LoongArch: Fix entry point in kernel image header
      LoongArch: Override higher address bits in JUMP_VIRT_ADDR

Jiri Olsa (2):
      bpf: Fix bpf_session_cookie BTF_ID in special_kfunc_set list
      bpf: Set run context for rawtp test_run callback

Johan Hovold (4):
      dt-bindings: HID: i2c-hid: add dedicated Ilitek ILI2901 schema
      dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
      dt-bindings: HID: i2c-hid: elan: add 'no-reset-on-power-off' property
      HID: i2c-hid: elan: fix reset suspend current leakage

Johannes Berg (8):
      wifi: cfg80211: validate HE operation element parsing
      wifi: cfg80211: fully move wiphy work to unbound workqueue
      wifi: mac80211: apply mcast rate only if interface is up
      wifi: mac80211: handle tasklet frames before stopping
      wifi: cfg80211: fix 6 GHz scan request building
      wifi: iwlwifi: mvm: revert gen2 TX A-MPDU size to 64
      wifi: iwlwifi: mvm: handle BA session teardown in RF-kill
      wifi: mt76: mt7615: add missing chanctx ops

Johannes Weiner (1):
      mm: page_alloc: fix highatomic typing in multi-block buddies

John Hubbard (3):
      selftests/futex: pass _GNU_SOURCE without a value to the compiler
      selftests/futex: don't redefine .PHONY targets (all, clean)
      selftests/futex: don't pass a const char* to asprintf(3)

Jos=C3=A9 Exp=C3=B3sito (1):
      HID: logitech-dj: Fix memory leak in logi_dj_recv_switch_to_dj_mode()

Justin Stitt (1):
      scsi: sr: Fix unintentional arithmetic wraparound

Karol Kolacinski (1):
      ptp: Fix error message on failed pin verification

Kent Overstreet (3):
      bcachefs: Fix GFP_KERNEL allocation in break_cycle()
      bcachefs: Rereplicate now moves data off of durability=3D0 devices
      bcachefs: Fix trans->locked assert

Kun(llfl) (1):
      iommu/amd: Fix sysfs leak in iommu init

Kuniyuki Iwashima (15):
      af_unix: Set sk->sk_state under unix_state_lock() for truly
disconencted peer.
      af_unix: Annodate data-races around sk->sk_state for writers.
      af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
      af_unix: Annotate data-races around sk->sk_state in
unix_write_space() and poll().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
      af_unix: Annotate data-race of sk->sk_state in unix_accept().
      af_unix: Annotate data-races around sk->sk_state in sendmsg()
and recvmsg().
      af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb()=
.
      af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
      af_unix: Annotate data-races around sk->sk_sndbuf.
      af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
      af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
      af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
      af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
      af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().

Lars Kellogg-Stedman (1):
      ax25: Fix refcount imbalance on inbound connections

Larysa Zaremba (3):
      ice: remove af_xdp_zc_qps bitmap
      ice: add flag to distinguish reset from .ndo_bpf in XDP rings config
      ice: map XDP queues to vectors in ice_vsi_map_rings_to_vectors()

Li Zhijian (1):
      cxl/region: Fix memregion leaks in devm_cxl_add_region()

Lin Ma (1):
      wifi: cfg80211: pmsr: use correct nla_get_uX functions

Lingbo Kong (2):
      wifi: mac80211: fix Spatial Reuse element size check
      wifi: mac80211: correctly parse Spatial Reuse Parameter Set element

Linus Torvalds (1):
      Linux 6.10-rc3

Louis Dalibard (1):
      HID: Ignore battery for ELAN touchscreens 2F2C and 4116

Lu Baolu (1):
      iommu: Return right value in iommu_sva_bind_device()

Magnus Karlsson (2):
      Revert "xsk: Support redirect to any socket bound to the same umem"
      Revert "xsk: Document ability to redirect to any socket bound to
the same umem"

Marc Zyngier (6):
      KVM: arm64: Fix AArch32 register narrowing on userspace write
      KVM: arm64: Allow AArch32 PSTATE.M to be restored as System mode
      KVM: arm64: AArch32: Fix spurious trapping of conditional instruction=
s
      KVM: arm64: nv: Fix relative priorities of exceptions generated by ER=
ETAx
      KVM: arm64: nv: Expose BTI and CSV_frac to a guest hypervisor
      of: property: Fix fw_devlink handling of interrupt-map

Mario Limonciello (1):
      drm/amd: Fix shutdown (again) on some SMU v13.0.4/11 platforms

Mark Brown (1):
      kselftest/alsa: Ensure _GNU_SOURCE is defined

Martin K. Petersen (1):
      scsi: core: Handle devices which return an unusually large VPD page c=
ount

Martin T=C5=AFma (1):
      media: mgb4: Fix double debugfs remove

Martin Wilck (1):
      scsi: core: alua: I/O errors for ALUA state transitions

Masahiro Yamada (6):
      kconfig: remove unneeded code for user-supplied values being out of r=
ange
      kconfig: gconf: give a proper initial state to the Save button
      kconfig: doc: fix a typo in the note about 'imply'
      kconfig: doc: document behavior of 'select' and 'imply' followed by '=
if'
      kconfig: remove wrong expr_trans_bool()
      modpost: do not warn about missing MODULE_DESCRIPTION() for vmlinux.o

Masami Hiramatsu (Google) (3):
      selftests/ftrace: Fix to check required event file
      selftests/ftrace: Update required config
      selftests/tracing: Fix event filter test to retry up to 10 times

Matthias Schiffer (3):
      gpio: tqmx86: introduce shadow register for GPIO output value
      gpio: tqmx86: store IRQ trigger type and unmask status separately
      gpio: tqmx86: fix broken IRQ_TYPE_EDGE_BOTH interrupt type

Matthias Stocker (1):
      vmxnet3: disable rx data ring on dma allocation failure

Matthieu Baerts (NGI0) (3):
      selftests: net: lib: support errexit with busywait
      selftests: net: lib: avoid error removing empty netns name
      selftests: net: lib: set 'i' as local

Michael Ellerman (4):
      selftests: cachestat: Fix build warnings on ppc64
      selftests/openat2: Fix build warnings on ppc64
      selftests/overlayfs: Fix build error on ppc64
      ata: pata_macio: Fix max_segment_size with PAGE_SIZE =3D=3D 64K

Michal Wajdeczko (1):
      drm/xe/pf: Update the LMTT when freeing VF GT config

Miri Korenblit (2):
      wifi: iwlwifi: mvm: don't initialize csa_work twice
      wifi: iwlwifi: mvm: check n_ssids before accessing the ssids

Mordechay Goodstein (1):
      wifi: iwlwifi: mvm: set properly mac header

Moshe Shemesh (1):
      net/mlx5: Stop waiting for PCI if pci channel is offline

Nam Cao (1):
      riscv: fix overlap of allocated page and PTR_ERR

Namhyung Kim (1):
      perf bpf: Fix handling of minimal vmlinux.h file when
interrupting the build

Nathan Chancellor (2):
      scsi: mpi3mr: Use proper format specifier in mpi3mr_sas_port_add()
      efi/libstub: zboot.lds: Discard .discard sections

Nicolas Escande (2):
      wifi: mac80211: mesh: Fix leak of mesh_preq_queue objects
      wifi: mac80211: mesh: init nonpeer_pm to active by default in mesh sd=
ata

Nikita Zhandarovich (1):
      HID: core: remove unnecessary WARN_ON() in implement()

Nikunj A Dadhania (1):
      KVM: SEV-ES: Prevent MSR access post VMSA encryption

Omar Sandoval (1):
      btrfs: fix crash on racing fsync and size-extending write into preall=
oc

Oscar Salvador (1):
      mm/hugetlb: do not call vma_add_reservation upon ENOMEM

Palmer Dabbelt (1):
      Revert "riscv: mm: accelerate pagefault when badaccess"

Peter Geis (1):
      MAINTAINERS: remove Peter Geis

Qu Wenruo (1):
      btrfs: protect folio::private when attaching extent buffer folios

Quan Zhou (1):
      RISC-V: KVM: Fix incorrect reg_subtype labels in
kvm_riscv_vcpu_set_reg_isa_ext function

Rafael J. Wysocki (4):
      thermal/debugfs: Print initial trip temperature and hysteresis
in tze_seq_show()
      thermal/debugfs: Allow tze_seq_show() to print statistics for
invalid trips
      thermal: core: Introduce thermal_trip_crossed()
      thermal: trip: Trigger trip down notifications when trips
involved in mitigation become invalid

Ravi Bangoria (2):
      KVM: SEV-ES: Disallow SEV-ES guests when X86_FEATURE_LBRV is absent
      KVM: SEV-ES: Delegate LBR virtualization to the processor

Remi Pommarel (2):
      wifi: mac80211: Fix deadlock in ieee80211_sta_ps_deliver_wakeup()
      wifi: cfg80211: Lock wiphy in cfg80211_get_station

Richard Acayan (1):
      kbuild: explicitly run mksysmap as sed script from link-vmlinux.sh

Rob Herring (Arm) (3):
      dt-bindings: arm: sunxi: Fix incorrect '-' usage
      dt-bindings: arm: stm32: st,mlahb: Drop spurious "reg" property
from example
      of/irq: Factor out parsing of interrupt-map parent phandle+args
from of_irq_parse_raw()

Robin Murphy (1):
      iommu/dma: Fix domain init

Ryusuke Konishi (2):
      nilfs2: fix potential kernel bug due to lack of writeback flag waitin=
g
      nilfs2: fix nilfs_empty_dir() misjudgment and long loop on I/O errors

Sakari Ailus (3):
      media: Documentation: v4l: Fix ACTIVE route flag
      media: mei: csi: Put the IPU device reference
      media: mei: csi: Warn less verbosely of a missing device fwnode

Samuel Holland (2):
      clk: sifive: Do not register clkdevs for PRCI clocks
      irqchip/sifive-plic: Chain to parent IRQ after handlers are ready

Sasha Neftin (1):
      igc: Fix Energy Efficient Ethernet support declaration

Saurav Kashyap (3):
      scsi: qedf: Don't process stag work during unload and recovery
      scsi: qedf: Wait for stag work during unload
      scsi: qedf: Set qed_slowpath_params to zero before use

Sean Christopherson (11):
      KVM: VMX: Don't kill the VM on an unexpected #VE
      KVM: nVMX: Initialize #VE info page for vmcs02 when proving #VE suppo=
rt
      KVM: nVMX: Always handle #VEs in L0 (never forward #VEs from L2 to L1=
)
      KVM: x86/mmu: Add sanity checks that KVM doesn't create EPT #VE SPTEs
      KVM: VMX: Dump VMCS on unexpected #VE
      KVM: x86/mmu: Print SPTEs on unexpected #VE
      KVM: VMX: Enumerate EPT Violation #VE support in /proc/cpuinfo
      KVM: x86: Disable KVM_INTEL_PROVE_VE by default
      KVM: x86: Force KVM_WERROR if the global WERROR is enabled
      KVM: SVM: WARN on vNMI + NMI window iff NMIs are outright masked
      KVM: x86: Drop support for hand tuning APIC timer advancement
from userspace

Sebastian Andrzej Siewior (1):
      memcg: remove the lockdep assert from __mod_objcg_mlstate()

Shahar S Matityahu (1):
      wifi: iwlwifi: dbg_ini: move iwl_dbg_tlv_free outside of debugfs ifde=
f

Shaul Triebitz (1):
      wifi: iwlwifi: mvm: always set the TWT IE offset

Shay Drory (1):
      net/mlx5: Always stop health timer during driver removal

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix unchecked HWP MSR access

Steven Rostedt (Google) (1):
      tracing/selftests: Fix kprobe event name test for .isra. functions

Su Hui (2):
      io_uring/io-wq: avoid garbage value of 'match' in io_wq_enqueue()
      net: ethtool: fix the error condition in ethtool_get_phy_stats_ethtoo=
l()

Subbaraya Sundeep (1):
      octeontx2-af: Always allocate PF entries from low prioriy zone

Suma Hegde (1):
      platform/x86/amd/hsmp: Check HSMP support on AMD family of processors

Sunil V L (1):
      irqchip/riscv-intc: Prevent memory leak when
riscv_intc_init_common() fails

Suren Baghdasaryan (1):
      mm: fix xyz_noprof functions calling profiled functions

Taehee Yoo (1):
      ionic: fix kernel panic in XDP_TX action

Tao Su (1):
      KVM: x86/mmu: Don't save mmu_invalidate_seq after checking private at=
tr

Tasos Sahanidis (1):
      drm/amdgpu/pptable: Fix UBSAN array-index-out-of-bounds

Tetsuo Handa (1):
      tomoyo: update project links

Thadeu Lima de Souza Cascardo (1):
      codetag: avoid race at alloc_slab_obj_exts

Thomas Wei=C3=9Fschuh (1):
      ACPI: AC: Properly notify powermanagement core about changes

Thorsten Blum (1):
      bpf, devmap: Remove unnecessary if check in for loop

Tiezhu Yang (1):
      LoongArch: Remove CONFIG_ACPI_TABLE_UPGRADE in platform_init()

Tony Luck (1):
      tpm: Switch to new Intel CPU model defines

Tristram Ha (2):
      net: phy: micrel: fix KSZ9477 PHY issues after suspend/resume
      net: phy: Micrel KSZ8061: fix errata solution not taking effect probl=
em

Vadim Fedorenko (1):
      ethtool: init tsinfo stats if requested

Vasant Hegde (3):
      iommu/amd: Fix workqueue name
      iommu/amd: Check EFR[EPHSup] bit before enabling PPR
      iommu/amd: Fix Invalid wait context issue

Wei Li (1):
      arm64: armv8_deprecated: Fix warning in isndep cpuhp starting process

Weiwen Hu (1):
      nvme: fix nvme_pr_* status code parsing

Wen Gu (1):
      net/smc: avoid overwriting when adjusting sock bufsizes

Yazen Ghannam (1):
      x86/amd_nb: Check for invalid SMN reads

Yedidya Benshimol (2):
      wifi: iwlwifi: mvm: d3: fix WoWLAN command version lookup
      wifi: iwlwifi: mvm: Handle BIGTK cipher in kek_kck cmd

Yong-Xuan Wang (1):
      RISC-V: KVM: No need to use mask when hart-index-bit is 0

Zhang Lixu (1):
      HID: intel-ish-hid: Fix build error for COMPILE_TEST

