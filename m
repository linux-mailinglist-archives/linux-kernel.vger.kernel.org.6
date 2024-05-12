Return-Path: <linux-kernel+bounces-177030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3728C389D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 23:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C8DB20D67
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 21:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E35476B;
	Sun, 12 May 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YWrBQUb3"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828894D5B0
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715549722; cv=none; b=BObfHZUiKSPFaDIoOzVrjwM9Xk9JkcwPFUtq+yUcVp+UQgUsQzCmaAstz2Oomaav8O9xDPBDsaRIAsceUYvfwjpY3YZJ8kbKyRCBMkRjPTyoTi3ynNPAP46yXqwRmGtDi+2eUxajIsfeQdUZgs+zxal13aZD/9M7v5aDM/0jB28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715549722; c=relaxed/simple;
	bh=860LfEoQuKrC2XxJQADc1oYDX1uCQWhg1c6bOAOy8gM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PVBgPfxG7FgViS1Z+vOjd5fca18hl8dL0dqirKWYqTOtLIJrSrZlIUiEO1fC/WD2ukvFXX6/XSCe2xfuhbTybcTM+607/jZ61YfLYRBTY8K4GdJq2yBNe3UJ/7Bxj6ZnqqmXKrVHj8hraxChhsJTav/V66BjhzJLggCGLerPKQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YWrBQUb3; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so150108466b.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715549717; x=1716154517; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwObQNQ5ZTnmivttxdNqOa380y+C40Jvl10eJ376l6A=;
        b=YWrBQUb3q8UPM4cNyw4ZvAE2516ci2hz8e7jMsr0Uv/6FLqGyUERsnfyuq9KapAxfq
         pJTGeDuZlAXi3pyPIhqBwoi3MXsThR8bQ5ZauzxoO8TS1ucq8+Hx6/0ua7ZpLtZV4bQE
         e/gK1FbcMLyu0gIgqp4nC2BEQF1XQjdor73Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715549717; x=1716154517;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwObQNQ5ZTnmivttxdNqOa380y+C40Jvl10eJ376l6A=;
        b=qKw2jCPCqIKqzlaTfski38ZZhsbA4yV6icx7/aTCh/9aQQLX5BABJ+NUd3rVvitZDe
         IkoMiWFyanDBnUe6AebOyZJeDCwdm2tjm0/JDapmZpBNOa1XBNy8plTPtgnx3TH3zvjp
         azj7NX2mM6CW1dwNU9LhMSJKIXj7FpQJz6fddRqe/vTEZjGAsaspBtfwwqZhnvOFpyaW
         VBFU8JWYk8eN1tZTEOes768qvhXFYu/XWBR8MNhutoSL6ljlCGdZGwEMRYb4tSb+clgl
         MF+nL8MGxhhNZbcmALLrcudQgLPX1DZQZSUdN7o7X3cZGAdC0RJT/6JgNap9HD/qAdEw
         S58Q==
X-Gm-Message-State: AOJu0YyvASl0xuuU19kte34Wg1Gn0Pih4PPxI6zKTreQI+eVhh3sc8Bs
	ccICTi0qTV4TbXbVoU5e78cO1ML3WNO+hKPLOEwcwLeBz4qB5xrd7iGgEVu+Oa/iOkSJSqWi3hL
	M/2g=
X-Google-Smtp-Source: AGHT+IEc36sQQmLk+311FYNpjyoPopgctifOcN+tQHWRAAPioAbJxkPrdcl8RyyragV8wrR4JWYTWw==
X-Received: by 2002:a17:906:17c5:b0:a59:c9ad:bd26 with SMTP id a640c23a62f3a-a5a2d54c601mr508694566b.12.1715549717328;
        Sun, 12 May 2024 14:35:17 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d5afsm503035666b.3.2024.05.12.14.35.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 14:35:16 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59c448b44aso959138366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 14:35:16 -0700 (PDT)
X-Received: by 2002:a17:906:b2d3:b0:a59:cf0a:4e46 with SMTP id
 a640c23a62f3a-a5a2d5d53a0mr522331666b.42.1715549716163; Sun, 12 May 2024
 14:35:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 May 2024 14:34:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnKYL-WARzrZhVTZ8RP3WZc24C9_DT7JMJooONNT2udQ@mail.gmail.com>
Message-ID: <CAHk-=whnKYL-WARzrZhVTZ8RP3WZc24C9_DT7JMJooONNT2udQ@mail.gmail.com>
Subject: Linux 6.9
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So Thorsten is still reporting a few regression fixes that haven't
made it to me yet, but none of them look big or worrisome enough to
delay the release for another week.  We'll have to backport them when
they get resolved and hit upstream.

So 6.9 is now out, and last week has looked quite stable (and the
whole release has felt pretty normal).  Below is the shortlog for the
last week, with the changes mostly being dominated by some driver
updates (gpu and networking being the big ones, but "big" is still
pretty small, and there's various other driver noise in there too).

Outside of drivers, it's some filesystem fixes (bcachefs still stands
out, but ksmbd shows up too), some late selftest fixes, and some core
networking fixes.

And I now have a more powerful arm64 machine (thanks to Ampere), so
the last week I've been doing almost as many arm64 builds as I have
x86-64, and that should obviously continue during the upcoming merge
window too. The M2 laptop I have has been more of a "test builds
weekly" rather than "continuously".

Not that I really expect that to really show any issues - the laptop
builds never did - but I feel happier having a bit more coverage.

Anyway, please keep testing, and obviously this means that tomorrow
the merge window for 6.10 opens. I already have a few dozen pull
requests pending, I appreciate the early birds,

                  Linus

---

Agustin Gutierrez (2):
      drm/amd/display: Fix DSC-re-computing
      drm/amd/display: MST DSC check for older devices

Al Viro (1):
      qibfs: fix dentry leak

Aleksa Savic (3):
      hwmon: (corsair-cpro) Use a separate buffer for sending commands
      hwmon: (corsair-cpro) Use complete_all() instead of complete()
in ccp_raw_event()
      hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock

Alex Deucher (1):
      drm/amdkfd: don't allow mapping the MMIO HDP page with large pages

Alexander Potapenko (1):
      kmsan: compiler_types: declare __no_sanitize_or_inline

Alina Yu (1):
      regulator: rtq2208: Fix the BUCK ramp_delay range to maximum of
16mVstep/us

Amir Goldstein (1):
      fuse: verify zero padding in fuse_backing_map

Andi Shyti (1):
      drm/i915/gt: Automate CCS Mode setting during engine resets

Andy Shevchenko (3):
      auxdisplay: linedisp: Group display drivers together
      auxdisplay: charlcd: Add missing MODULE_DESCRIPTION()
      auxdisplay: charlcd: Don't rebuild when CONFIG_PANEL_BOOT_MESSAGE=3Dy

Antony Antony (2):
      xfrm: fix possible derferencing in error path
      xfrm: Correct spelling mistake in xfrm.h comment

Barry Song (1):
      mailmap: add entry for Barry Song

Bartosz Golaszewski (2):
      gpiolib: fix the speed of descriptor label setting with SRCU
      gpiolib: use a single SRCU struct for all GPIO descriptors

Ben Wolsieffer (1):
      spi: stm32: enable controller before asserting CS

Bjorn Helgaas (1):
      PCI/ASPM: Clarify that pcie_aspm=3Doff means leave ASPM untouched

Boy.Wu (1):
      ARM: 9381/1: kasan: clear stale stack poison

Brian Foster (1):
      virtiofs: include a newline in sysfs tag

Chaitanya Kumar Borah (1):
      drm/i915/audio: Fix audio time stamp programming for DP

Chen-Yu Tsai (1):
      arm64: dts: mediatek: mt8183-pico6: Fix bluetooth node

Christoph Hellwig (1):
      mm,page_owner: don't remove __GFP_NOLOCKDEP in add_stack_record_to_li=
st

Conor Dooley (3):
      firmware: microchip: don't unconditionally print validation success
      firmware: microchip: clarify that sizes and addresses are in hex
      spi: microchip-core-qspi: fix setting spi bus clock rate

Dan Carpenter (2):
      mm/slab: make __free(kfree) accept error pointers
      nvmet: prevent sprintf() overflow in nvmet_subsys_nsid_exists()

Daniel Golle (1):
      dt-bindings: net: mediatek: remove wrongly added clocks and SerDes

Daniele Ceraolo Spurio (1):
      drm/xe/guc: Check error code when initializing the CT mutex

Dave Airlie (1):
      Revert "drm/nouveau/firmware: Fix SG_DEBUG error with
nvkm_firmware_ctor()"

David Howells (2):
      rxrpc: Fix congestion control algorithm
      rxrpc: Only transmit one ACK per jumbo packet received

Donald Hunter (1):
      netlink: specs: Add missing bridge linkinfo attrs

Douglas Anderson (1):
      drm/connector: Add \n to message about demoting connector force-probe=
s

Duoming Zhou (2):
      Bluetooth: Fix use-after-free bugs caused by sco_sock_timeout
      Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_timeout

Eric Dumazet (4):
      tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
      phonet: fix rtm_phonet_notify() skb allocation
      ipv6: fib6_rules: avoid possible NULL dereference in fib6_rule_action=
()
      ipv6: prevent NULL dereference in ip6_output()

Felix Fietkau (1):
      net: bridge: fix corrupted ethernet header on multicast-to-unicast

Gregor Herburger (1):
      net: phy: marvell-88q2xxx: add support for Rev B1 and B2

Gregory Detal (1):
      mptcp: only allow set existing scheduler for net.mptcp.scheduler

Hailong.Liu (1):
      mm/vmalloc: fix return value of vb_alloc if size is 0

Ido Schimmel (1):
      selftests: test_bridge_neigh_suppress.sh: Fix failures due to
duplicate MAC

Jarkko Sakkinen (1):
      MAINTAINERS: update URL's for KEYS/KEYRINGS_INTEGRITY and TPM
DEVICE DRIVER

Jason Gunthorpe (1):
      iommu/arm-smmu: Use the correct type in nvidia_smmu_context_fault()

Jean-Philippe Brucker (1):
      KVM: s390: Check kvm pointer when testing KVM_CAP_S390_HPAGE_1M

Jerome Brunet (2):
      drm/meson: dw-hdmi: power up phy on device init
      drm/meson: dw-hdmi: add bandgap setting for g12

Jian Shen (1):
      net: hns3: direct return when receive a unknown mailbox message

Johan Hovold (8):
      Bluetooth: qca: fix wcn3991 device address check
      Bluetooth: qca: add missing firmware sanity checks
      Bluetooth: qca: fix NVM configuration parsing
      Bluetooth: qca: generalise device address check
      Bluetooth: qca: fix info leak when fetching fw build id
      Bluetooth: qca: fix info leak when fetching board id
      Bluetooth: qca: fix firmware check error path
      regulator: core: fix debugfs creation regression

John Garry (1):
      mailmap: add entry for John Garry

Josef Bacik (1):
      btrfs: make sure that WRITTEN is set on all metadata blocks

Kai-Heng Feng (1):
      PCI/ASPM: Restore parent state to parent, child state to child

Karthikeyan Ramasubramanian (1):
      drm/i915/bios: Fix parsing backlight BDB data

Kefeng Wang (1):
      mm: use memalloc_nofs_save() in page_cache_ra_order()

Kent Gibson (1):
      gpiolib: cdev: fix uninitialised kfifo

Kent Overstreet (19):
      bcachefs: Fix a scheduler splat in
__bch2_next_write_buffer_flush_journal_buf()
      bcachefs: don't free error pointers
      bcachefs: bucket_pos_to_bp_noerror()
      bcachefs: Fix early error path in bch2_fs_btree_key_cache_exit()
      bcachefs: Inodes need extra padding for varint_decode_fast()
      bcachefs: Fix refcount put in sb_field_resize error path
      bcachefs: Initialize bch_write_op->failed in inline data path
      bcachefs: Fix bch2_dev_lookup() refcounting
      bcachefs: Fix lifetime issue in device iterator helpers
      bcachefs: Add a better limit for maximum number of buckets
      bcachefs: Fix assert in bch2_alloc_v4_invalid()
      bcachefs: Add missing validation for superblock section clean
      bcachefs: Guard against unknown k.k->type in __bkey_invalid()
      bcachefs: Fix shift-by-64 in bformat_needs_redo()
      bcachefs: Fix snapshot_t() usage in bch2_fs_quota_read_inode()
      bcachefs: Add missing skcipher_request_set_callback() call
      bcachefs: BCH_SB_LAYOUT_SIZE_BITS_MAX
      bcachefs: Fix race in bch2_write_super()
      bcachefs: Add missing sched_annotate_sleep() in
bch2_journal_flush_seq_async()

Kuniyuki Iwashima (1):
      tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Lakshmi Yadlapati (1):
      hwmon: (pmbus/ucd9000) Increase delay from 250 to 500us

Levi Yun (1):
      timers/migration: Prevent out of bounds access on failure

Liam R. Howlett (1):
      maple_tree: fix mas_empty_area_rev() null pointer dereference

Lijo Lazar (1):
      Revert "drm/amdkfd: Add partition id field to location_id"

Linus Torvalds (2):
      Reapply "drm/qxl: simplify qxl_fence_wait"
      Linux 6.9

Lucas De Marchi (1):
      drm/xe/ads: Use flexible-array

Luis Chamberlain (2):
      tools: fix userspace compilation with new test_xarray changes
      lib/test_xarray.c: fix error assumptions on check_xa_multi_store_adv_=
add()

Lukasz Majewski (1):
      hsr: Simplify code for announcing HSR nodes timer setup

Maninder Singh (1):
      mm: page_owner: fix wrong information in dump_page_owner

Marek Vasut (1):
      net: ks8851: Queue RX packets in IRQ handler instead of disabling BHs

Mario Limonciello (1):
      dm/amd/pm: Fix problems with reboot/shutdown for some SMU
13.0.4/13.0.11 users

Matthew Brost (1):
      drm/xe: Use ordered WQ for G2H handler

Matthew Wilcox (Oracle) (1):
      XArray: set the marks correctly when splitting an entry

Maurizio Lombardi (1):
      nvmet-auth: return the error code to the nvmet_auth_ctrl_hash() calle=
rs

Michael Ellerman (1):
      selftests/mm: fix powerpc ARCH check

Michel D=C3=A4nzer (1):
      drm/amdgpu: Fix comparison in amdgpu_res_cpu_visible

Micka=C3=ABl Sala=C3=BCn (10):
      selftests/pidfd: Fix config for pidfd_setns_test
      selftests/landlock: Fix FS tests when run on a private mount point
      selftests/harness: Fix fixture teardown
      selftests/harness: Fix interleaved scheduling leading to race conditi=
ons
      selftests/landlock: Do not allocate memory in fixture data
      selftests/harness: Constify fixture variants
      selftests/pidfd: Fix wrong expectation
      selftests/harness: Share _metadata between forked processes
      selftests/harness: Fix vfork() side effects
      selftests/harness: Handle TEST_F()'s explicit exit codes

Ming Lei (1):
      block: set default max segment size in case of virt_boundary

Namjae Jeon (5):
      ksmbd: fix uninitialized symbol 'share' in smb2_tree_connect()
      ksmbd: off ipv6only for both ipv4/ipv6 binding
      ksmbd: avoid to send duplicate lease break notifications
      ksmbd: use rwsem instead of rwlock for lease break
      ksmbd: do not grant v2 lease if parent lease key and epoch are not se=
t

Nicholas Kazlauskas (1):
      drm/amd/display: Fix idle optimization checks for multi-display
and dual eDP

Nicholas Susanto (1):
      drm/amd/display: Enable urgent latency adjustments for DCN35

Nicolas Bouchinet (1):
      mm/slub: avoid zeroing outside-object freepointer for single free

Paul Davey (1):
      xfrm: Preserve vlan tags for transport mode software GRO

Peiyang Wang (4):
      net: hns3: using user configure after hardware reset
      net: hns3: change type of numa_node_mask as nodemask_t
      net: hns3: release PTP resources if pf initialization failed
      net: hns3: use appropriate barrier function after setting a bit value

Peter Xu (1):
      mm/userfaultfd: reset ptes when close() for wr-protected ones

Potnuri Bharat Teja (1):
      MAINTAINERS: update cxgb4 and cxgb3 network drivers maintainer

Qu Wenruo (1):
      btrfs: qgroup: do not check qgroup inherit if qgroup is disabled

Reed Riley (1):
      bcachefs: fix overflow in fiemap

Roded Zats (1):
      rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Ryan Roberts (2):
      fs/proc/task_mmu: fix loss of young/dirty bits during pagemap scan
      fs/proc/task_mmu: fix uffd-wp confusion in pagemap_scan_pmd_entry()

Sagi Grimberg (2):
      nvmet: make nvmet_wq unbound
      nvmet-rdma: fix possible bad dereference when freeing rsps

Samuel Holland (1):
      cache: sifive_ccache: Silence unused variable warning

Sean Anderson (1):
      nvme-pci: Add quirk for broken MSIs

Serge Semin (1):
      EDAC/synopsys: Fix ECC status and IRQ control race condition

Shigeru Yoshida (1):
      ipv6: Fix potential uninit-value access in __ip6_make_skb()

Shyam Sundar S K (1):
      x86/amd_nb: Add new PCI IDs for AMD family 0x1a

Steffen B=C3=A4tz (2):
      net: dsa: mv88e6xxx: add phylink_get_caps for the mv88e6320/21 family
      net: dsa: mv88e6xxx: read cmode on mv88e6320/21 serdes only ports

Sungwoo Kim (3):
      Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()
      Bluetooth: msft: fix slab-use-after-free in msft_do_close()
      Bluetooth: HCI: Fix potential null-ptr-deref

Tetsuo Handa (1):
      nfc: nci: Fix kcov check in nci_rx_work()

Thadeu Lima de Souza Cascardo (1):
      net: fix out-of-bounds access in ops_init

Thomas Gleixner (1):
      x86/topology/amd: Ensure that LLC ID is initialized

Tiezhu Yang (2):
      selftests/vDSO: fix building errors on LoongArch
      selftests/vDSO: fix runtime errors on LoongArch

Uwe Kleine-K=C3=B6nig (1):
      auxdisplay: seg-led-gpio: Convert to platform remove callback
returning void

Vasant Hegde (1):
      iommu/amd: Enhance def_domain_type to handle untrusted device

Vincent Duvert (1):
      appletalk: Improve handling of broadcast packets

Volodymyr Babchuk (1):
      arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration

Wen Gu (1):
      net/smc: fix neighbour and rtable leak in smc_ib_find_route()

Yonglong Liu (2):
      net: hns3: fix port vlan filter not disabled issue
      net: hns3: fix kernel crash when devlink reload during initialization

Yuezhang Mo (2):
      exfat: fix timing of synchronizing bitmap and inode
      exfat: zero the reserved fields of file and stream extension dentries

Zhongqiu Han (1):
      gpiolib: cdev: Fix use after free in lineinfo_changed_notify

