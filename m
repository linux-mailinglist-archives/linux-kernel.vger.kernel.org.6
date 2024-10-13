Return-Path: <linux-kernel+bounces-363000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6AD99BC57
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B571C2083E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D629C14D6ED;
	Sun, 13 Oct 2024 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WwskLLU4"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB612CDAE
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728856007; cv=none; b=hUeSRFH8gDlUaujjLGGukgdRy487u2quQeZwan6SALDUqUN/N1FWNQ8Ege+ADu2zaQoC8BISQKNRbkfLmMIgO5ZhutUECs95XaD7ZKcbIiL+XuIE36Z6ISAJSTV7SIWONnNxqzY74M8cs8agd3+RPF5SY3XbRBJ9cDY8q7SIFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728856007; c=relaxed/simple;
	bh=VMg9tq/p6l117s+j8bP4+bItlK7dcIwWHSU4RP7PrRQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SurnN+lDOQWZNxfBLiFoqH9HQ1bsn3isEgGF9q5jFXiF1snEbbr8NAL57AE9Tu9U2wiwG/NMq9dxNCe68h47wR0dqc2RQtIVLUvyczJ2enphMuto8MJuJwCGAptpIjnPvBwQB7+dQLg/Qxr7sJR+e1LbcO4Jd2EeBuyj0DM9LEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WwskLLU4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99fa009adcso119266866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 14:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728856002; x=1729460802; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gquRNBZod7R5ql/s7iTjNvLyPab/5sD3XBknh3KO+Hk=;
        b=WwskLLU4Rr3r/E1P/9SyLyMxI2DSmCALPOtXQtgmojcNn65HYZo5srCg8W5vmvZmO9
         Ws+Ats7Yj91O55famx0TXeBgBMt73StjW80NA1brTgy70BgH6DYli0ZQOzVM2X0x1RKn
         8MhXx97WbxvZo7w2Rm1RpwVIzNsBnRb3oiRic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728856002; x=1729460802;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gquRNBZod7R5ql/s7iTjNvLyPab/5sD3XBknh3KO+Hk=;
        b=AT+BN8f6d0L6cVnRAJlPdw82u871dfZWjokEY1RhCh2/4/3RQi33prLSBam7SXp79Q
         WXczUnLCLB7DVDYDIKYObsNC/jBxeW/TdnOWOyhOD1kHke59tVgzsS1Cf0CCx7yrrAch
         7WkAOwEPVsOeSnG6BC/mrrZSpsopPtZ0Ss/9v2UdBpS/PFfr2fSjFGnN9ONXqLSFYybk
         y/XJIZWiWENfCk4R0G0N5i2nwb6iUP+W+ZZn1lAueN+xGBO/BRXQvQRm8BvhwZZO4EIh
         rthIlCORDq5kGEkDjHHiSrqp7P17CtLo0f4zvA8pkdNGd9RNv1FQXkyF6LGhumjBAM9k
         1Tzg==
X-Gm-Message-State: AOJu0YyivLR8AAEzUjZNWRgaWvw8JlMYI3tGMo+5txFjIcWVl+XtdfV9
	ETK0eed/VOqK9yaVhd3kiUJ1XMjCurXBn4wIg+m4aTziUV25KHsxC47LbK4XdNPzi/vA4YvXOHN
	C0m4=
X-Google-Smtp-Source: AGHT+IGOzpZn0hOMPrclIoNrtjSyvjTAGl7lJ4yOGr4iFu5A2Z3fwj0P2zvKkEKjsVF0VwO1yVFbxA==
X-Received: by 2002:a50:8dc5:0:b0:5c9:4631:c47e with SMTP id 4fb4d7f45d1cf-5c95ac17722mr8595878a12.13.1728856002307;
        Sun, 13 Oct 2024 14:46:42 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93726051esm4143970a12.59.2024.10.13.14.46.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 14:46:41 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so1724868a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 14:46:40 -0700 (PDT)
X-Received: by 2002:a05:6402:354b:b0:5c9:48df:713c with SMTP id
 4fb4d7f45d1cf-5c95ac0992emr11928569a12.2.1728856000156; Sun, 13 Oct 2024
 14:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 13 Oct 2024 14:46:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
Message-ID: <CAHk-=wg061j_0+a0wen8E-wxSzKx_TGCkKw-r1tvsp5fLeT0pA@mail.gmail.com>
Subject: Linux 6.12-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So the diffstat looks a bit odd, because one of the fixes here caused
the UTF tables to be regenerated, and an effective one-liner change
turned into 6703 lines of diff.

But if you ignore that effect, everything looks normal. We've got all
the usual driver updates (gpu and networking dominating as usual, but
there's some minor updates in USB, fbdev, mmc, thermal...), some
filesystem fixes (xfs, smb client, and ntfs3), some core networking,
and some tooling (selftests and some perf trace include file refresh).

And the usual random noise elsewhere (io_uring, scheduler, some MM noise)

Shortlog appended for people who want to quickly scroll through the
details. It may not be exciting, but it's better than doomscrolling
...

             Linus

---

Abhishek Chauhan (2):
      net: phy: aquantia: AQR115c fix up PMA capabilities
      net: phy: aquantia: remove usage of phy_set_max_speed

Ahmed Zaki (1):
      idpf: fix VF dynamic interrupt ctl register initialization

Aleksandr Loktionov (1):
      i40e: Fix macvlan leak by synchronizing access to mac_filter_hash

Alex Deucher (1):
      drm/amdgpu: partially revert powerplay `__counted_by` changes

Alexander Gordeev (1):
      fs/proc/kcore.c: allow translation of physical memory addresses

Anastasia Kovaleva (1):
      net: Fix an unsafe loop on the list

Anatolij Gustschin (1):
      net: dsa: lan9303: ensure chip reset and wait for READY status

Andrew Ballance (1):
      fs/ntfs3: Check if more than chunk-size bytes are written

Andrew Kreimer (1):
      xfs: fix a typo

Andy Roulin (2):
      netfilter: br_netfilter: fix panic with metadata_dst skb
      selftests: add regression test for br_netfilter panic

Arkadiusz Kubalewski (1):
      ice: disallow DPLL_PIN_STATE_SELECTABLE for dpll output pins

Arnaldo Carvalho de Melo (10):
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools include UAPI: Sync linux/sched.h copy with the kernel sources
      tools include UAPI: Sync linux/fcntl.h copy with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      perf trace beauty: Update the arch/x86/include/asm/irq_vectors.h
copy with the kernel sources
      tools headers UAPI: Sync the linux/in.h with the kernel sources
      perf beauty: Update copy of linux/socket.h with the kernel sources
      tools check_headers.sh: Add check variant that excludes some hunks
      perf tools: Cope with differences for lib/list_sort.c copy from the k=
ernel
      tools headers arm64: Sync arm64's cputype.h with the kernel sources

Avri Altman (1):
      scsi: ufs: Use pre-calculated offsets in ufshcd_init_lrb()

Benjamin Marzinski (1):
      scsi: scsi_transport_fc: Allow setting rport state to current state

Billy Tsai (2):
      gpio: aspeed: Add the flush write to ensure the write complete.
      gpio: aspeed: Use devm_clk api to manage clock source

Breno Leitao (1):
      net: netconsole: fix wrong warning

Brian Foster (2):
      xfs: skip background cowblock trims on inodes open for write
      xfs: don't free cowblocks from under dirty pagecache on unshare

Chandan Babu R (1):
      MAINTAINERS: add Carlos Maiolino as XFS release manager

Christian K=C3=B6nig (1):
      drm/radeon: always set GEM function pointer

Christian Marangi (1):
      net: phy: Remove LED entry from LEDs list on unregister

Christoph Hellwig (8):
      xfs: merge xfs_attr_leaf_try_add into xfs_attr_leaf_addname
      xfs: return bool from xfs_attr3_leaf_add
      xfs: distinguish extra split from real ENOSPC from xfs_attr3_leaf_spl=
it
      xfs: distinguish extra split from real ENOSPC from
xfs_attr_node_try_addname
      xfs: fold xfs_bmap_alloc_userdata into xfs_bmapi_allocate
      xfs: don't ifdef around the exact minlen allocations
      xfs: call xfs_bmap_exact_minlen_extent_alloc from xfs_bmap_btalloc
      xfs: support lowmode allocations in xfs_bmap_exact_minlen_extent_allo=
c

Christophe JAILLET (2):
      net: phy: bcm84881: Fix some error handling paths
      net: ethernet: adi: adin1110: Fix some error handling path in
adin1110_read_fifo()

Christophe Leroy (1):
      powerpc/8xx: Fix kernel DTLB miss on dcbz

Chuck Lever (1):
      NFSD: Mark filecache "down" if init fails

Colin Ian King (1):
      drm/nouveau/gsp: remove extraneous ; after mutex

D. Wythe (1):
      net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC

Dai Ngo (1):
      NFS: remove revoked delegation from server's delegation list

Damien Le Moal (1):
      ata: libata: Update MAINTAINERS file

Dan Carpenter (2):
      OPP: fix error code in dev_pm_opp_set_config()
      SUNRPC: Fix integer overflow in decode_rc_list()

Daniel Palmer (2):
      scsi: wd33c93: Don't use stale scsi_pointer value
      net: amd: mvme147: Fix probe banner message

Dave Ertman (1):
      ice: fix VLAN replay after reset

David Hildenbrand (1):
      mm/huge_memory: check pmd_special() only after pmd_present()

David Howells (2):
      rxrpc: Fix a race between socket set up and I/O thread creation
      rxrpc: Fix uninitialised variable in rxrpc_send_data()

Devaansh-Kumar (1):
      sched_ext: Documentation: Update instructions for running
example schedulers

Dimitri Sivanich (1):
      misc: sgi-gru: Don't disable preemption in GRU driver

Diogo Jahchan Koike (1):
      ntfs3: Change to non-blocking allocation in ntfs_d_hash

Donet Tom (1):
      selftests/mm: fix incorrect buffer->mirror size in hmm2 double_map te=
st

Dr. David Alan Gilbert (1):
      fs/ntfs3: Remove unused al_delete_le

Eric Dumazet (4):
      net/sched: accept TCA_STAB only for root qdisc
      net: do not delay dst_entries_add() in dst_release()
      ppp: fix ppp_async_encode() illegal access
      slip: make slhc_remember() more robust against malicious packets

Fabio Estevam (1):
      dt-bindings: display: elgin,jg10309-01: Add own binding

Fangrui Song (1):
      .mailmap: update Fangrui's email

Filipe Manana (2):
      btrfs: fix missing error handling when adding delayed ref with
qgroups enabled
      btrfs: zoned: fix missing RCU locking in error message when
loading zone info

Fiona Behrens (1):
      mailmap: update mail for Fiona Behrens

Florian Westphal (3):
      netfilter: xtables: avoid NFPROTO_UNSPEC where needed
      netfilter: fib: check correct rtable in vrf setups
      selftests: netfilter: conntrack_vrf.sh: add fib test case

Frank Li (2):
      dt-bindings: misc: fsl,qoriq-mc: remove ref for msi-parent
      dt-bindings: interrupt-controller: fsl,ls-extirq: workaround
wrong interrupt-map number

Frederic Weisbecker (2):
      kthread: unpark only parked kthread
      rcu/nocb: Fix rcuog wake-up from offline softirq

Gabriel Krisman Bertazi (1):
      unicode: Don't special case ignorable code points

Greg Thelen (1):
      selftests: make kselftest-clean remove libynl outputs

Guenter Roeck (2):
      mmc: core: Only set maximum DMA segment size if DMA is supported
      hwmon: (tmp513) Add missing dependency on REGMAP_I2C

Gui-Dong Han (2):
      ice: Fix improper handling of refcount in ice_dpll_init_rclk_pins()
      ice: Fix improper handling of refcount in ice_sriov_set_msix_vec_coun=
t()

Guilherme Giacomo Simoes (1):
      rust: device: change the from_raw() function

Hamza Mahfooz (1):
      drm/amd/display: fix hibernate entry for DCN35+

Hans de Goede (4):
      ACPI: resource: Make Asus ExpertBook B2402 matches cover more models
      ACPI: resource: Make Asus ExpertBook B2502 matches cover more models
      ACPI: resource: Fold Asus ExpertBook B1402C* and B1502C* DMI
quirks together
      ACPI: resource: Fold Asus Vivobook Pro N6506M* DMI quirks together

Haoran Zhang (1):
      vhost/scsi: null-ptr-dereference in vhost_scsi_get_req()

Heiner Kallweit (1):
      net: phy: realtek: Fix MMD access on RTL8126A-integrated PHY

Huang Ying (1):
      resource, kunit: fix user-after-free in resource_test_region_intersec=
ts()

Ian Rogers (1):
      perf vdso: Missed put on 32-bit dsos

Icenowy Zheng (1):
      usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip

Ignat Korchagin (1):
      net: explicitly clear the sk pointer, when pf->create fails

Ilkka Koskinen (1):
      perf cs-etm: Fix the assert() to handle captured and unprocessed cpu =
trace

Ingo van Lil (1):
      net: phy: dp83869: fix memory corruption when enabling fiber

Jacky Chou (1):
      net: ftgmac100: fixed not check status from fixed phy

Jakub Kicinski (1):
      Revert "net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled"

James Clark (1):
      perf dwarf-aux: Fix build with !HAVE_DWARF_GETLOCATIONS_SUPPORT

Jani Nikula (1):
      drm/i915/hdcp: fix connector refcounting

Janne Grunau (1):
      drm/fbdev-dma: Only cleanup deferred I/O if necessary

Jason A. Donenfeld (3):
      selftests: vDSO: unconditionally build chacha test
      selftests: vDSO: unconditionally build getrandom test
      selftests: vDSO: improve getrandom and chacha error messages

Javier Carrasco (9):
      hwmon: (adt7475) Fix memory leak in adt7475_fan_pwm_config()
      hwmon: (mc34vr500) Add missing dependency on REGMAP_I2C
      hwmon: (adm9240) Add missing dependency on REGMAP_I2C
      hwmon: (adt7470) Add missing dependency on REGMAP_I2C
      hwmon: (ltc2991) Add missing dependency on REGMAP_I2C
      hwmon: (max1668) Add missing dependency on REGMAP_I2C
      selftests: net: add msg_oob to gitignore
      selftests: net: rds: add include.sh to EXTRA_CLEAN
      selftests: net: rds: add gitignore file for include.sh

Jens Axboe (2):
      io_uring/rw: fix cflags posting for single issue multishot read
      io_uring/rw: allow pollable non-blocking attempts for !FMODE_NOWAIT

Jijie Shao (1):
      net: hns3/hns: Update the maintainer for the HNS3/HNS ethernet driver

Jinjie Ruan (2):
      net/9p/usbg: Fix build error
      of: Fix unbalanced of node refcount and memory leaks

John Keeping (1):
      usb: gadget: core: force synchronous registration

Jonas Gorski (5):
      net: dsa: b53: fix jumbo frame mtu check
      net: dsa: b53: fix max MTU for 1g switches
      net: dsa: b53: fix max MTU for BCM5325/BCM5365
      net: dsa: b53: allow lower MTUs on BCM5325/5365
      net: dsa: b53: fix jumbo frames on 10/100 ports

Jose Alberto Reguero (1):
      usb: xhci: Fix problem with xhci resume from suspend

Joshua Hay (1):
      idpf: use actual mbx receive payload length

Josip Pavic (1):
      drm/amd/display: Clear update flags after update has been applied

Juergen Gross (1):
      x86/xen: mark boot CPU of PV guest in MSR_IA32_APICBASE

Kacper Ludwinski (1):
      selftests: net: no_forwarding: fix VID for $swp2 in
one_bridge_two_pvids() test

Kanchana P Sridhar (1):
      mm: zswap: delete comments for "value" member of 'struct zswap_entry'=
.

Konstantin Komarov (20):
      fs/ntfs3: Do not call file_modified if collapse range failed
      fs/ntfs3: Optimize large writes into sparse file
      fs/ntfs3: Separete common code for file_read/write iter/splice
      fs/ntfs3: Fix sparse warning for bigendian
      fs/ntfs3: Fix warning possible deadlock in ntfs_set_state
      fs/ntfs3: Fix sparse warning in ni_fiemap
      fs/ntfs3: Refactor enum_rstbl to suppress static checker
      fs/ntfs3: Stale inode instead of bad
      fs/ntfs3: Add rough attr alloc_size check
      fs/ntfs3: Make checks in run_unpack more clear
      fs/ntfs3: Implement fallocate for compressed files
      fs/ntfs3: Add support for the compression attribute
      fs/ntfs3: Replace fsparam_flag_no -> fsparam_flag
      fs/ntfs3: Rename ntfs3_setattr into ntfs_setattr
      fs/ntfs3: Fix possible deadlock in mi_read
      fs/ntfs3: Additional check in ni_clear()
      fs/ntfs3: Sequential field availability check in mi_enum_attr()
      fs/ntfs3: Fix general protection fault in run_is_mapped_full
      fs/ntfs3: Additional check in ntfs_file_release
      fs/ntfs3: Format output messages like others fs in kernel

Kory Maincent (1):
      net: pse-pd: Fix enabled status mismatch

Krzysztof Kozlowski (1):
      CREDITS: sort alphabetically by name

Kun(llfl) (1):
      device-dax: correct pgoff align in dax_set_mapping()

Kuniyuki Iwashima (6):
      rtnetlink: Add bulk registration helpers for rtnetlink message handle=
rs.
      vxlan: Handle error of rtnl_register_module().
      bridge: Handle error of rtnl_register_module().
      mctp: Handle error of rtnl_register_module().
      mpls: Handle error of rtnl_register_module().
      phonet: Handle error of rtnl_register_module().

Lang Yu (1):
      drm/amdkfd: Fix an eviction fence leak

Larysa Zaremba (1):
      idpf: deinit virtchnl transaction manager after vport and vectors

Leo Stone (1):
      Documentation: networking/tcp_ao: typo and grammar fixes

Linus Torvalds (1):
      Linux 6.12-rc3

Linus Walleij (1):
      Revert "mmc: mvsdio: Use sg_miter for PIO"

Lorenzo Bianconi (1):
      net: airoha: Update tx cpu dma ring idx at the end of xmit loop

Luca Stefani (2):
      btrfs: split remaining space to discard in chunks
      btrfs: add cancellation points to trim loops

Luiz Augusto von Dentz (3):
      Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      Bluetooth: hci_conn: Fix UAF in hci_enhanced_setup_sync
      Bluetooth: btusb: Don't fail external suspend requests

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix race condition for VLAN table access

Marcin Szycik (3):
      ice: Fix entering Safe Mode
      ice: Fix netif_is_ice() in Safe Mode
      ice: Fix increasing MSI-X on VF

Martin Wilck (1):
      scsi: fnic: Move flush_work initialization out of if block

Mathieu Desnoyers (1):
      selftests/rseq: Fix mm_cid test failure

Matt Roper (1):
      drm/xe: Make wedged_mode debugfs writable

Matthew Auld (3):
      drm/xe/ct: prevent UAF in send_recv()
      drm/xe/ct: fix xa_store() error checking
      drm/xe/guc_submit: fix xa_store() error checking

Matthew Brost (2):
      drm/sched: Use drm sched lockdep map for submit_wq
      drm/xe: Drop GuC submit_wq pool

Matthieu Baerts (NGI0) (2):
      mptcp: fallback when MPTCP opts are dropped after 1st data
      mptcp: pm: do not remove closing subflows

Ma=C3=ADra Canal (2):
      drm/v3d: Stop the active perfmon before being destroyed
      drm/vc4: Stop the active perfmon before being destroyed

Michael S. Tsirkin (3):
      virtio_ring: tag event_triggered as racy for KCSAN
      virtio_console: fix misc probe bugs
      vsock/virtio: use GFP_ATOMIC under RCU read lock

Michal Hocko (2):
      bcachefs: do not use PF_MEMALLOC_NORECLAIM
      Revert "mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"

Michal Swiatkowski (2):
      ice: set correct dst VSI in only LAN filters
      ice: clear port vlan config during reset

Michal Wilczynski (1):
      mmc: sdhci-of-dwcmshc: Prevent stale command interrupt handling

Mike Snitzer (3):
      nfs_common: fix race in NFS calls to nfsd_file_put_local() and
nfsd_serv_put()
      nfs_common: fix Kconfig for NFS_COMMON_LOCALIO_SUPPORT
      nfsd/localio: fix nfsd_file tracepoints to handle NULL rqstp

Mohamed Khalfella (1):
      igb: Do not bring the device up after non-fatal error

Namhyung Kim (1):
      perf symbol: Set binary_type of dso when loading

Naohiro Aota (1):
      btrfs: fix clear_dirty and writeback ordering in submit_one_sector()

Neal Cardwell (3):
      tcp: fix to allow timestamp undo if no retransmits were sent
      tcp: fix tcp_enter_recovery() to zero retrans_stamp when it's safe
      tcp: fix TFO SYN_RECV to not zero retrans_stamp with retransmits out

NeilBrown (2):
      nfsd: nfsd_destroy_serv() must call svc_destroy() even if
nfsd_startup_net() failed
      sunrpc: fix prog selection loop in svc_process_common

Nick Child (1):
      ibmvnic: Inspect header requirements before using scrq direct

Nicolas Pitre (2):
      net: ethernet: ti: am65-cpsw: prevent WARN_ON upon module removal
      net: ethernet: ti: am65-cpsw: avoid devm_alloc_etherdev, fix
module removal

Niklas Cassel (1):
      ata: libata: avoid superfluous disk spin down + spin up during hibern=
ation

Olga Kornievskaia (1):
      nfsd: fix possible badness in FREE_STATEID

Oliver Neukum (2):
      Revert "usb: yurex: Replace snprintf() with the safer scnprintf() var=
iant"
      USB: yurex: kill needless initialization in yurex_read

Pali Roh=C3=A1r (2):
      cifs: Improve creating native symlinks pointing to directory
      cifs: Fix creating native symlinks pointing to current or parent dire=
ctory

Paolo Abeni (2):
      mptcp: handle consistently DSS corruption
      tcp: fix mptcp DSS corruption due to large pmtu xmit

Patrick Roy (1):
      secretmem: disable memfd_secret() if arch cannot set direct map

Peter Colberg (1):
      hwmon: intel-m10-bmc-hwmon: relabel Columbiaville to CVL Die Temperat=
ure

Przemek Kitszel (1):
      ice: fix memleak in ice_init_tx_topology()

Radhey Shyam Pandey (1):
      usb: misc: onboard_usb_dev: introduce new config symbol for
usb5744 SMBus support

Rafael J. Wysocki (2):
      thermal: core: Reference count the zone in thermal_zone_get_by_id()
      thermal: core: Free tzp copy along with the thermal zone

Rosen Penev (2):
      net: ibm: emac: mal: fix wrong goto
      net: ibm: emac: mal: add dcr_unmap to _remove

Roy Luo (1):
      usb: dwc3: re-enable runtime PM after failed resume

Sebastian Andrzej Siewior (1):
      sfc: Don't invoke xdp_do_flush() from netpoll.

Selvarasu Ganesan (1):
      usb: dwc3: core: Stop processing of pending events if controller is h=
alted

Simon Horman (3):
      docs: netdev: document guidance on cleanup patches
      MAINTAINERS: consistently exclude wireless files from NETWORKING [GEN=
ERAL]
      MAINTAINERS: Add headers and mailing list to UDP section

Srujana Challa (1):
      vdpa/octeon_ep: Fix format specifier for pointers in debug messages

Stephen Boyd (1):
      of: Skip kunit tests when arm64+ACPI doesn't populate root node

Steven Rostedt (2):
      ring-buffer: Do not have boot mapped buffers hook to CPU hotplug
      ftrace/selftest: Test combination of function_graph tracer and
function profiler

Sumeet Pawnikar (1):
      powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U

Tejun Heo (5):
      sched_ext: Improve error reporting during loading
      sched_ext: scx_cgroup_exit() may be called without successful
scx_cgroup_init()
      sched/core: Make select_task_rq() take the pointer to wake_flags
instead of value
      sched/core: Add ENQUEUE_RQ_SELECTED to indicate whether
->select_task_rq() was called
      sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED

Thorsten Blum (1):
      fs/ntfs3: Use swap() to improve code

Ulf Hansson (2):
      Revert "drm/tegra: gr3d: Convert into dev_pm_domain_attach|detach_lis=
t()"
      PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list()

Uros Bizjak (1):
      xfs: Use try_cmpxchg() in xlog_cil_insert_pcp_aggregate()

Uwe Kleine-K=C3=B6nig (1):
      fbdev: Switch back to struct platform_driver::remove()

Vinay Belgaumkar (1):
      drm/xe: Restore GT freq on GSC load error

Vishal Chourasia (1):
      sched_ext: Add __weak markers to BPF helper function decalarations

Vitaly Lifshits (1):
      e1000e: change I219 (19) devices to ADP

Vladimir Oltean (2):
      net: dsa: sja1105: fix reception from VLAN-unaware bridges
      net: dsa: refuse cross-chip mirroring operations

Wei Fang (1):
      net: fec: don't save PTP state if PTP is unsupported

Wojciech Drewek (1):
      ice: Flush FDB entries before reset

Wu Hoi Pok (1):
      drm/radeon: add late_register for connector

Xin Long (1):
      sctp: ensure sk_state is set to CLOSED if hashing fails in
sctp_listen_start

Yan Zhen (1):
      xfs: scrub: convert comma to semicolon

Yang Jihong (2):
      perf build: Fix static compilation error when libdw is not installed
      perf build: Fix build feature-dwarf_getlocations fail for old libdw

Yang Li (1):
      nfs: Remove duplicated include in localio.c

Yanjun Zhang (1):
      NFSv4: Prevent NULL-pointer dereference in nfs42_complete_copies()

Yonatan Maman (2):
      nouveau/dmem: Fix privileged error in copy engine channel
      nouveau/dmem: Fix vulnerability in migrate_to_ram upon copy error

Yu Liao (1):
      selftests: vDSO: Explicitly include sched.h

Zhang Rui (5):
      powercap: intel_rapl_tpmi: Fix bogus register reading
      thermal: intel: int340x: processor: Fix warning during module unload
      powercap: intel_rapl_tpmi: Ignore minor version change
      thermal: intel: int340x: processor: Remove MMIO RAPL CPU hotplug supp=
ort
      thermal: intel: int340x: processor: Add MMIO RAPL PL4 support

Zhang Zekun (2):
      pmdomain: qcom-cpr: Fix the return of uninitialized variable
      xfs: Remove empty declartion in header file

lei lu (1):
      ntfs3: Add bounds checking to mi_enum_attr()

