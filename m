Return-Path: <linux-kernel+bounces-282402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1873E94E365
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 23:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67244B20E3E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997EA15B98F;
	Sun, 11 Aug 2024 21:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DOt8vuF+"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B3E22615
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723412131; cv=none; b=EbXpy0UITnuoganOb0rV3FLXU8ROcMOyOK8++tB57tcHxxR7Y0S7EckX4+imTz4rBAKoz7zZlSzXzL7i5OusK7UnA2LKXLUshDdiKuZyg2XJJZnIdHBybx1tHV/jBV5TIs9UEu+DyP7fJKm5azQEXCuAFZ//4Bv92LDLifpSCUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723412131; c=relaxed/simple;
	bh=ZvMYAsN0oCGEEHG57jszL2fT+Sraypuz/UkyflhJQ9w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JZYHqIqgCf8IMUoFVlNr1VZoMRdyBqDBYfi25Y5j+DNSuTpc/oAr3gJSFaQZ/YsZgSKfuWSEVDMAFQrQPicmtnDERpLb7CNWszCQrB1Jo9RYnoBebE5ZeB/efydq+hGaVGnxBpHhkqd4Mj51fnukJt04LRpye7acyzkkAjzSCqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DOt8vuF+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so4079364a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723412127; x=1724016927; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wz/U6LCKEe5XvhuDJANx7R14CJNeWtfBu/OzWCJsLzw=;
        b=DOt8vuF+sHvMMxq4CemVWszqvLhwDjqR4lHZsP7h7+qCQM76PhuC/4e6FV2CsgCjkW
         0YgA4zAPsS23oaUbz1VjW9yU1yGRUuS4biivOX1+JACl7WMhaWEDV9dSfQ4kxhUb+Ruw
         8UVeJiy15OzRb8FzHP8qKb+L5NCojHZQSQW1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723412127; x=1724016927;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wz/U6LCKEe5XvhuDJANx7R14CJNeWtfBu/OzWCJsLzw=;
        b=NZ4RxKZQMvPzEJo73qgYne7V8GdNJiGfRZNVQAR8JC9F7bPSpa2T/Hdkj4NODMF6n0
         DqDzOItRuyLJoqKGrC5iVBJcNyhUf6WFOf9d4Z3ozBBrmjk5OHGI2zm/U8JG/qnSwZWY
         qEW7hHNVjSLTaXQ3xl9Tqoa4ZanACI3VMeIvQmKDe9GB1AvLB7/THqo5g9x1XYjMx/sn
         wYeqyeMzwfetm7Lg1msRfMD1kCe33fbK5fqJg+/ZK8TRv7Wjup4/UwskOqg//SDcY5sm
         dK1PZLkFlG0A/1Abj8D7yUqZOm0eDEc3YFrMau67ScRTxZLQCtsphiKDaPi+G4p3iDrD
         6Jaw==
X-Gm-Message-State: AOJu0YzYwdsGXd105ggeKC/RZPRNnlUOSKTmf3Vqdoybeirz0CaZiSb3
	AX5ltAukfwvv1w/mo3KJyiSkgGa+rUQqinDV+i8vhMPgtiLs3wO/HFkUop+LhcAr36F7OJBx4TK
	pvUU=
X-Google-Smtp-Source: AGHT+IE2o8TiOeBnpXqPJZ52Xt1T5AJkk2c1dIXXHijg0FiwEoP2R/LTD66tJwhgNcQiVjYsAlh1xw==
X-Received: by 2002:a05:6402:d0e:b0:57d:72e:5b3a with SMTP id 4fb4d7f45d1cf-5bd0a641b3amr5842142a12.33.1723412126771;
        Sun, 11 Aug 2024 14:35:26 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a3258sm1608163a12.41.2024.08.11.14.35.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:35:25 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so4079347a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 14:35:25 -0700 (PDT)
X-Received: by 2002:a17:906:6a04:b0:a79:8318:288f with SMTP id
 a640c23a62f3a-a80aa598a4amr633831166b.16.1723412124876; Sun, 11 Aug 2024
 14:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 11 Aug 2024 14:35:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7_w1E0kMiUeskhBRrcCz3bejjegteGmM6-TES8bQURg@mail.gmail.com>
Message-ID: <CAHk-=wj7_w1E0kMiUeskhBRrcCz3bejjegteGmM6-TES8bQURg@mail.gmail.com>
Subject: Linux 6.11-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Nothing particularly strange or interesting going on, things look normal.

Half the changes are to drivers (all the usual suspects: sound, gpu,
and networking are big, but we have usb and other misc driver fixes
there too).

The rest is the usual random mix, with filesystem fixes (bcachefs,
btrfs, smb), architecture fixes (arm64, loongarch, x86),
documentation, and networking. And some core kernel and tooling
fixlets too.

Please do keep testing,

           Linus

---

Alexander Lobakin (2):
      idpf: fix memory leaks and crashes while performing a soft reset
      idpf: fix UAFs when destroying the queues

Alexander Stein (1):
      dt-bindings: usb: microchip,usb2514: Add USB2517 compatible

Andi Kleen (1):
      x86/mtrr: Check if fixed MTRRs exist before saving them

Andi Shyti (2):
      drm/i915/gem: Adjust vma offset for framebuffer mmap offset
      drm/i915/gem: Fix Virtual Memory mapping boundaries calculation

Andrew Ballance (1):
      rust: firmware: fix invalid rustdoc link

Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0 and 1 to PCIe1
      arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0 references

Andrey Konovalov (1):
      kcov: properly check for softirq context

Anton Khirnov (1):
      Bluetooth: hci_sync: avoid dup filtering when passive scanning
with adv monitor

Armin Wolf (1):
      eeprom: ee1004: Fix locking issues in ee1004_probe()

Arnd Bergmann (6):
      sunrpc: avoid -Wformat-security warning
      misc: mrvl-cn10k-dpi: add PCI_IOV dependency
      drm/omap: add CONFIG_MMU dependency
      syscalls: fix fstat() entry again
      syscalls: add back legacy __NR_nfsservctl macro
      net: pse-pd: tps23881: include missing bitfield.h header

Arunpravin Paneer Selvam (3):
      drm/buddy: Add start address support to trim function
      drm/amdgpu: Add address alignment support to DCC buffers
      drm/amdgpu: Add DCC GFX12 flag to enable address alignment

Baolin Wang (2):
      mm: shmem: avoid allocating huge pages larger than
MAX_PAGECACHE_ORDER for shmem
      mm: shmem: fix incorrect aligned index when checking conflicts

Bartosz Golaszewski (3):
      Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
      Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
      Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown

Boris Burkov (2):
      btrfs: implement launder_folio for clearing dirty page reserve
      btrfs: fix qgroup reserve leaks in cow_file_range

Bruno Ancona (1):
      ASoC: amd: yc: Support mic on HP 14-em0002la

Carlos Llamas (1):
      binder: fix descriptor lookup for context manager

Charles Keepax (5):
      ASoC: cs42l43: Remove redundant semi-colon at end of function
      ASoC: soc-component: Add new snd_soc_component_get_kcontrol() helpers
      ASoC: cs35l45: Use new snd_soc_component_get_kcontrol_locked() helper
      ASoC: cs42l43: Cache shutter IRQ control pointers
      MAINTAINERS: Update Cirrus Logic parts to linux-sound mailing list

Chen Yu (1):
      x86/paravirt: Fix incorrect virt spinlock setting on bare metal

Chris Wulff (2):
      usb: gadget: u_audio: Check return codes from usb_ep_enable and
config_ep_by_speed.
      usb: gadget: core: Check for unset descriptor

Cristian Ciocaltea (1):
      drm/bridge-connector: Fix double free in error handling paths

Cs=C3=B3k=C3=A1s, Bence (1):
      net: fec: Stop PPS on driver remove

Curtis Malainey (1):
      ASoC: SOF: Remove libraries from topology lookups

Dan Carpenter (1):
      usb: typec: tcpci: Fix error code in tcpci_check_std_output_cap()

Dan Williams (1):
      driver core: Fix uevent_show() vs driver detach race

Dandan Zhang (1):
      LoongArch: KVM: Remove undefined a6 argument comment for kvm_hypercal=
l()

Daniele Palmas (1):
      net: usb: qmi_wwan: fix memory leak for not ip packets

Dave Airlie (1):
      drm/test: fix the gem shmem test to map the sg table.

David Collins (1):
      spmi: pmic-arb: add missing newline in dev_err format strings

David Gow (2):
      drm/i915: Allow evicting to use the requested placement
      drm/i915: Attempt to get pages without eviction first

David Heidelberg (1):
      mailmap: update entry for David Heidelberg

Devyn Liu (2):
      spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
      spi: hisi-kunpeng: Add verification for the max_frequency
provided by the firmware

Dmitry Antipov (1):
      Bluetooth: l2cap: always unlock channel in l2cap_conless_channel()

Dmitry Safonov (1):
      net/tcp: Disable TCP-AO static key after RCU grace period

Dmitry Torokhov (1):
      ARM: pxa/gumstix: fix attaching properties to vbus gpio device

Dnyaneshwar Bhadane (1):
      drm/i915/display: correct dual pps handling for MTL_PCH+

Dr. David Alan Gilbert (2):
      USB: serial: spcp8x5: remove unused struct 'spcp8x5_usb_ctrl_arg'
      blk-throttle: remove more latency dead-code

Dustin L. Howett (1):
      ALSA: hda/realtek: Add Framework Laptop 13 (Intel Core Ultra) to quir=
ks

Edward Cree (1):
      net: ethtool: fix off-by-one error in max RSS context IDs

Eric Dumazet (1):
      net: linkwatch: use system_unbound_wq

Fangzhi Zuo (1):
      drm/amd/display: Skip Recompute DSC Params if no Stream on Link

Filipe Manana (1):
      btrfs: fix double inode unlock for direct IO sync writes

Florian Fainelli (1):
      net: bcmgenet: Properly overlay PHY and MAC Wake-on-LAN capabilities

Francesco Dolcini (2):
      ASoC: nau8822: Lower debug print priority
      arm64: dts: ti: k3-am62-verdin-dahlia: Keep CTRL_SLEEP_MOCI# regulato=
r on

Frank Min (2):
      drm/amdgpu: change non-dcc buffer copy configuration
      drm/amdgpu: correct sdma7 max dw

Gal Pressman (1):
      ethtool: Fix context creation with no parameters

Gaosheng Cui (2):
      i2c: qcom-geni: Add missing clk_disable_unprepare in
geni_i2c_runtime_resume
      i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resu=
me

Gavin Shan (1):
      cpumask: Fix crash on updating CPU enabled mask

Geert Uytterhoeven (1):
      spi: spidev: Add missing spi_device_id for bh2228fv

George Kennedy (1):
      serial: core: check uartclk for zero to avoid divide by zero

Gleb Korobeynikov (1):
      cifs: cifs_inval_name_dfs_link_error: correct the check for fullpath

Greg Kroah-Hartman (2):
      Documentation: embargoed-hardware-issues.rst: minor cleanups and fixe=
s
      Documentation: embargoed-hardware-issues.rst: add a section
documenting the "early access" process

Grzegorz Nitka (2):
      ice: Fix reset handler
      ice: Skip PTP HW writes during PTP reset procedure

Guenter Roeck (2):
      i2c: smbus: Improve handling of stuck alerts
      i2c: smbus: Send alert notifications to all devices if source not fou=
nd

Hans de Goede (3):
      power: supply: axp288_charger: Fix constant_charge_voltage writes
      power: supply: axp288_charger: Round constant_charge_voltage writes d=
own
      platform/x86: intel-vbtn: Protect ACPI notify handler against recursi=
on

Harshit Mogalapalli (2):
      usb: typec: tipd: Fix dereferencing freeing memory in
tps6598x_apply_patch()
      usb: typec: tipd: Delete extra semi-colon

Heikki Krogerus (1):
      usb: typec: ucsi: Fix a deadlock in ucsi_send_command_common()

Heng Qi (2):
      virtio-net: check feature before configuring the vq coalescing comman=
d
      virtio-net: unbreak vq resizing when coalescing is not negotiated

Huacai Chen (1):
      LoongArch: Use accessors to page table entries instead of direct
dereference

Hugo Villeneuve (2):
      serial: sc16is7xx: fix TX fifo corruption
      serial: sc16is7xx: fix invalid FIFO access with special register set

James Chapman (1):
      l2tp: fix lockdep splat

Jared McArthur (3):
      arm64: dts: ti: k3-am62p: Add gpio-ranges for mcu_gpio0
      arm64: dts: ti: k3-am62p: Fix gpio-range for main_pmx0
      arm64: dts: ti: k3-j722s: Fix gpio-range for main_pmx0

Jason Wang (1):
      vhost-vdpa: switch to use vmf_insert_pfn() in the fault handler

Javier Carrasco (2):
      USB: serial: garmin_gps: annotate struct garmin_packet with __counted=
_by
      USB: serial: garmin_gps: use struct_size() to allocate pkt

Jeff Johnson (3):
      USB: serial: add missing MODULE_DESCRIPTION() macros
      fsi: add missing MODULE_DESCRIPTION() macros
      char: add missing NetWinder MODULE_DESCRIPTION() macros

Jeff Layton (1):
      nfsd: don't set SVC_SOCK_ANONYMOUS when creating nfsd sockets

Jens Axboe (3):
      io_uring/net: ensure expanded bundle recv gets marked for cleanup
      io_uring/net: ensure expanded bundle send gets marked for cleanup
      io_uring/net: don't pick multiple buffers for non-bundle send

Jerome Audu (1):
      ASoC: sti: add missing probe entry for player and reader

Jerome Brunet (1):
      ASoC: meson: axg-fifo: fix irq scheduling issue with PREEMPT_RT

Jianhui Zhou (1):
      ring-buffer: Remove unused function ring_buffer_nr_pages()

Joe Hattori (1):
      net: dsa: bcm_sf2: Fix a possible memory leak in bcm_sf2_mdio_registe=
r()

Johan Hovold (1):
      ASoC: codecs: lpass-macro: fix missing codec version

Josef Bacik (1):
      btrfs: emit a warning about space cache v1 being deprecated

Joshua Ashton (1):
      drm/amdgpu: Forward soft recovery errors to userspace

Justin Stitt (2):
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Kanchan Joshi (4):
      nvme: remove unused parameter
      nvme: remove a field from nvme_ns_head
      nvme: change data type of lba_shift
      nvme: reorganize nvme_ns_head fields

Karthik Poosa (1):
      drm/xe/hwmon: Fix PL1 disable flow in xe_hwmon_power_max_write

Kenneth Feng (1):
      drm/amd/pm: update powerplay structure on smu v14.0.2/3

Kent Overstreet (14):
      bcachefs: Fix double free of ca->buckets_nouse
      lockdep: Fix lockdep_set_notrack_class() for CONFIG_LOCK_STAT
      bcachefs: Don't rely on implicit unsigned -> signed integer conversio=
n
      bcachefs: Add a comment for bucket helper types
      bcachefs: Add missing bch2_trans_begin() call
      bcachefs: Improved allocator debugging for ec
      bcachefs: ec should not allocate from ro devs
      bcachefs: Add missing path_traverse() to btree_iter_next_node()
      bcachefs: Make allocator stuck timeout configurable, ratelimit messag=
es
      bcachefs: Use bch2_wait_on_allocator() in btree node alloc path
      bcachefs: Switch to .get_inode_acl()
      bcachefs: bch2_accounting_invalid()
      bcachefs: improve bch2_dev_usage_to_text()
      bcachefs: bcachefs_metadata_version_disk_accounting_v3

Konrad Dybcio (2):
      usb: typec: fsa4480: Check if the chip is really there
      spmi: pmic-arb: Pass the correct of_node to irq_domain_add_tree

Krzysztof Kozlowski (10):
      ASoC: codecs: wcd937x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd938x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wcd939x-sdw: Correct Soundwire ports mask
      ASoC: codecs: wsa881x: Correct Soundwire ports mask
      ASoC: codecs: wsa883x: Correct Soundwire ports mask
      ASoC: codecs: wsa884x: Correct Soundwire ports mask
      ASoC: dt-bindings: qcom,wcd937x: Correct reset GPIO polarity in examp=
le
      ASoC: dt-bindings: qcom,wcd934x: Correct reset GPIO polarity in examp=
le
      ASoC: dt-bindings: qcom,wcd938x: Correct reset GPIO polarity in examp=
le
      ASoC: dt-bindings: qcom,wcd939x: Correct reset GPIO polarity in examp=
le

Krzysztof St=C4=99pniak (1):
      ASoC: amd: yc: Support mic on Lenovo Thinkpad E14 Gen 6

Kuniyuki Iwashima (1):
      sctp: Fix null-ptr-deref in reuseport_add_sock().

Kuppuswamy Sathyanarayanan (1):
      platform/x86/intel/ifs: Initialize union ifs_status to zero

Kyle Swenson (1):
      net: pse-pd: tps23881: Fix the device ID check

Laura Nao (1):
      selftests: ksft: Fix finished() helper exit code on skipped tests

Li Feng (1):
      scsi: sd: Keep the discard mode stable

Likun Gao (2):
      drm/amdgpu: force to use legacy inv in mmhub
      drm/amdgpu: add golden setting for gc v12

Linus Torvalds (3):
      module: warn about excessively long module waits
      module: make waiting for a concurrent module loader interruptible
      Linux 6.11-rc3

Lucas De Marchi (1):
      drm/xe/rtp: Fix off-by-one when processing rules

Luis Felipe Hernandez (1):
      platform/x86: msi-wmi-platform: Fix spelling mistakes

Luke D. Jones (1):
      platform/x86/amd: pmf: Add quirk for ROG Ally X

Ma Ke (1):
      drm/client: fix null pointer dereference in drm_client_modeset_probe

Marek Beh=C3=BAn (6):
      platform: cznic: turris-omnia-mcu: Make watchdog code optional
      platform: cznic: turris-omnia-mcu: Make TRNG code optional
      platform: cznic: turris-omnia-mcu: Make poweroff and wakeup code opti=
onal
      platform: cznic: turris-omnia-mcu: Make GPIO code optional
      doc: platform: cznic: turris-omnia-mcu: Fix sphinx-build warning
      doc: platform: cznic: turris-omnia-mcu: Use double backticks for
attribute value

Marek Marczykowski-G=C3=B3recki (1):
      USB: serial: debug: do not echo input by default

Martin Whitaker (1):
      net: dsa: microchip: disable EEE for KSZ8567/KSZ9567/KSZ9896/KSZ9897.

Masami Hiramatsu (Google) (1):
      kprobes: Fix to check symbol prefixes correctly

Mateusz Polchlopek (1):
      ice: Fix incorrect assigns of FEC counts

Mathias Krause (3):
      tracefs: Fix inode allocation
      eventfs: Don't return NULL in eventfs_create_dir()
      eventfs: Use SRCU for freeing eventfs_inodes

Matthew Brost (2):
      drm/xe: Use dma_fence_chain_free in chain fence unused as a sync
      drm/xe: Take ref to VM in delayed snapshot

Matthieu Baerts (NGI0) (7):
      mptcp: fully established after ADD_ADDR echo on MPJ
      mptcp: pm: deny endp with signal + subflow + port
      mptcp: pm: reduce indentation blocks
      mptcp: pm: don't try to create sf if alloc failed
      mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set
      selftests: mptcp: join: ability to invert ADD_ADDR check
      selftests: mptcp: join: test both signal & subflow

Max Krummenacher (1):
      tty: vt: conmakehash: cope with abs_srctree no longer in env

Menglong Dong (1):
      bpf: kprobe: remove unused declaring of bpf_kprobe_override

Miao Wang (1):
      LoongArch: Enable general EFI poweroff method

Michael Chan (1):
      bnxt_en : Fix memory out-of-bounds in bnxt_fill_hw_rss_tbl()

Michal Kubiak (1):
      idpf: fix memleak in vport interrupt configuration

Muchun Song (1):
      mm: list_lru: fix UAF for memory cgroup

Mukesh Ojha (1):
      binder_alloc: Fix sleeping function called from invalid context

Neil Armstrong (1):
      power: supply: qcom_battmgr: return EAGAIN when firmware service is n=
ot up

Nico Pache (1):
      selftests: mm: add s390 to ARCH check

Nikita Travkin (1):
      power: supply: rt5033: Bring back i2c_set_clientdata

Nikolay Aleksandrov (1):
      net: bridge: mcast: wait for previous gc cycles when removing port

Oliver Neukum (1):
      usb: vhci-hcd: Do not drop references before new references are gaine=
d

Parth Pancholi (1):
      arm64: dts: ti: k3-j784s4-main: Correct McASP DMAs

Paul Handrigan (1):
      ASoC: cs530x: Change IN HPF Select kcontrol name

Pedro Henrique Kopper (1):
      cpufreq: intel_pstate: Update Balance performance EPP for Emerald Rap=
ids

Petr Pavlu (1):
      function_graph: Fix the ret_stack used by ftrace_graph_ret_addr()

Petr Vorel (1):
      MAINTAINERS: Update LTP members and web

Prashanth K (1):
      usb: gadget: u_serial: Set start_delayed during suspend

Praveen Kaligineedi (1):
      gve: Fix use of netif_carrier_ok()

Qu Wenruo (3):
      btrfs: factor out stripe length calculation into a helper
      btrfs: scrub: update last_physical after scrubbing one stripe
      btrfs: avoid using fixed char array size for tree names

Radhey Shyam Pandey (1):
      irqchip/xilinx: Fix shift out of bounds

Richard Fitzgerald (3):
      i2c: Fix conditional for substituting empty ACPI functions
      ASoC: cs-amp-lib: Fix NULL pointer crash if efi.get_variable is NULL
      ASoC: cs35l56: Handle OTP read latency over SoundWire

Rik van Riel (2):
      mm, slub: do not call do_slab_free for kfence object
      dma-debug: avoid deadlock between dma debug vs printk and netconsole

Rob Clark (1):
      dt-bindings: display: panel: samsung,atna45dc02: Document ATNA45DC02

Rodrigo Siqueira (6):
      drm/amd/display: Replace dm_execute_dmub_cmd with
dc_wake_and_execute_dmub_cmd
      drm/amd/display: Add missing DET segments programming
      drm/amd/display: Add dcc propagation value
      drm/amd/display: Add missing mcache registers
      drm/amd/display: Add missing DCN314 to the DML Makefile
      drm/amd/display: Add missing program DET segment call to pipe init

Russell King (Oracle) (1):
      net: stmmac: dwmac4: fix PCS duplex mode decode

Shakeel Butt (1):
      memcg: protect concurrent access to mem_cgroup_idr

Shay Drory (1):
      genirq/irqdesc: Honor caller provided affinity in alloc_desc()

Shengjiu Wang (2):
      ASoC: fsl_micfil: Expand the range of FIFO watermark mask
      ASoC: fsl_micfil: Differentiate register access permission for platfo=
rms

Shin'ichiro Kawasaki (1):
      scsi: sd: Move sd_read_cpr() out of the q->limits_lock region

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Send OS_HINT command for new AMD platform
      platform/x86/amd/pmf: Add new ACPI ID AMDI0107

Simon Ser (1):
      drm/atomic: allow no-op FB_ID updates for async flips

Simon Trimmer (4):
      ALSA: hda: cs35l56: Stop creating ALSA controls for firmware coeffici=
ents
      ASoC: wm_adsp: Add control_add callback and export wm_adsp_control_ad=
d()
      ASoC: cs35l56: Stop creating ALSA controls for firmware coefficients
      ASoC: cs35l56: Patch CS35L56_IRQ1_MASK_18 to the default value

Stefan Binding (1):
      ALSA: hda: cs35l41: Stop creating ALSA Controls for firmware coeffici=
ents

Stefan Wahren (1):
      spi: spi-fsl-lpspi: Fix scldiv calculation

Stephan Gerhold (1):
      power: supply: qcom_battmgr: Ignore extra __le32 in info payload

Stephen Hemminger (1):
      MAINTAINERS: update status of sky2 and skge drivers

Steve French (1):
      smb3: fix setting SecurityFlags when encryption is required

Steven 'Steve' Kendall (1):
      ALSA: hda: Add HP MP9 G4 Retail System AMS to force connect list

Steven Rostedt (3):
      tracing: Have format file honor EVENT_FILE_FL_FREED
      tracing: Use refcount for trace_event_file reference counter
      tracefs: Use generic inode RCU for synchronizing freeing

Takashi Iwai (5):
      usb: gadget: midi2: Fix the response for FB info with block 0xff
      ALSA: line6: Fix racy access to midibuf
      ALSA: hda/hdmi: Yet more pin fix for HP EliteDesk 800 G4
      ALSA: usb-audio: Re-add ScratchAmp quirk entries
      ASoC: amd: yc: Add quirk entry for OMEN by HP Gaming Laptop 16-n0xxx

Thomas Gleixner (2):
      timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()
      x86/mm: Fix PTI for i386 some more

Tristram Ha (1):
      net: dsa: microchip: Fix Wake-on-LAN check to not return an error

Tudor Ambarus (2):
      usb: gadget: f_fs: restore ffs_func_disable() functionality
      usb: gadget: f_fs: pull out f->disable() from ffs_func_set_alt()

Tze-nan Wu (1):
      tracing: Fix overflow in get_free_elt()

Vamshi Gajjela (1):
      scsi: ufs: core: Fix hba->last_dme_cmd_tstamp timestamp updating logi=
c

Waiman Long (1):
      padata: Fix possible divide-by-0 panic in padata_mt_helper()

Wolfram Sang (1):
      i2c: testunit: match HostNotify test name with docs

Xiaxi Shen (1):
      Fix spelling errors in Server Message Block

Xu Yang (1):
      usb: typec: tcpm: avoid sink goto SNK_UNATTACHED state if not
received source capability message

Yong-Xuan Wang (1):
      irqchip/riscv-aplic: Retrigger MSI interrupt on source configuration

Yuli Wang (1):
      LoongArch: KVM: Remove unnecessary definition of KVM_PRIVATE_MEM_SLOT=
S

ZHANG Yuntian (1):
      net: usb: qmi_wwan: add MeiG Smart SRM825L

Zhang Yi (1):
      ASoC: codecs: ES8326: button detect issue

Zhengchao Shao (1):
      net/smc: add the max value of fallback reason count

Zhiquan Li (1):
      x86/acpi: Remove __ro_after_init from acpi_mp_wake_mailbox

