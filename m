Return-Path: <linux-kernel+bounces-446643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D667C9F277C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9AA188582D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A210F4;
	Mon, 16 Dec 2024 00:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S/KXfKXO"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B278182
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734307849; cv=none; b=jMdDcfdoATDucBiE0/UEnXZg9W9IqJkJZpZpJRO45xRaUDJ1lGzrUzL0lx4RVZ1VKyPqwXm9iERWOggXkUu+zSuFX51kf3wCGQl/eogazsZwRAJf+5hACNUCbvUur1+5PaIu/nhZMTgwBxxW6R70D/ijmctxTZadCXIurC56NpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734307849; c=relaxed/simple;
	bh=G1oss8MyQY+P3fUrgoXDRhUj8l8XIZe+BeAFsW5yX4k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=jXaoakePzV6+T8zTxVUyievteM0fI6c6kR+1eekf+2/mi/np71x3d/LF2scI33LKKutBWbQepRXm6ES9H6WLaz+es6bzCsAGaIranNlnCsFBXPvlNz5XrTpivxzPvCUtq8HdCIHDu3OAwaeaRYUmZXntZWwoNaV1PK06pHBgl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S/KXfKXO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso603180666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734307844; x=1734912644; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Pbq7+PUPSjrX4ocnqCH7gQj8iJGapnJuhJ44iF1vA=;
        b=S/KXfKXOEUh9KVbhJQWPg9vdLAPipa+epK3dLzePWAEw08LuwT8MCqxqbNEuFWRk7m
         8TCI4HseFdoHJbVKjfEJk28rAssmCrr/yY0cnzFbobUdI06rEfz/g9v5rLeKdIYBc28K
         zniD1wRJDreIms+GORspXKhR8IZjfnyvYAQTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734307844; x=1734912644;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Pbq7+PUPSjrX4ocnqCH7gQj8iJGapnJuhJ44iF1vA=;
        b=vrg9zPkC+SobhBjEJ+qGx1VhuxnKTXFcml2XFbo85GRqodTMFresebT7PG/K9CPlPL
         YKtdxtFeo1ItP5NVI4YOCA9JV5rcbWJvxARxODDZ3nGo0Th017tlgNY8qjwVlNPTO2te
         ssjoqjSLkX8bBFMmG+08s28wwiP7pVUNDHOYplR+5uI776f+1MjiXgOk2zLKi2zVVtrr
         4+G2O3fUFGqdaCYsnfL2lPPWOPedSTGWogg0XrRtGgsAU3W+aEBT3tpLRdfqzTAv8hIC
         xeUiKcAFkTnh8jOXbmtdB+h4I99IhR37Fm43vDGbK1GZcDg97eIGFuGIIMBUOyUmF28o
         GCYw==
X-Gm-Message-State: AOJu0YxsDgLg0UOqb9Mnc4P4BbJEUPgLPpf3bHFXhL1yCcMZ9pJLecxE
	UbZQsxLgwpgTFcFKS3eE/U+q6oyVUYtNn51EQoRnuQsHHLa3SyfOxo3/LZqOtHj9hkPlhDo9fLi
	H9xI=
X-Gm-Gg: ASbGncvVCAdd7N9yqsYDmlE6zJtrvOyTArXE3nYtfJZ9JuMiDp2CJ47z5PUNob56TPi
	Ql6ie0ZlkQvErgggwekgWzuGRofoqAezWDgkUtLe1uuNdFQ2HdxX8DvacG5wbWnif11MaZjvnIt
	2HdUEy6hwWs1vYXzsHNPiK80trQDy6+dfMJfnSbDyckyOW8UJpal3rkG4ZOTw7lgSK4ikEsR+/1
	8ywqFXmURkhO+UNJw9O6u8bZb28r5y4hzHqKvHI6Y+hHqRuBNwZfKr3v20JwXRzVIlJbw3/wo1+
	y3G5OtkHaP6vf5T3sckJcwJrgjMTOqk=
X-Google-Smtp-Source: AGHT+IGOOBjxLjS5XcIde9aR/fyui+jdcxZP5XBO/p4SOBPOEbcD3AIH74WLqF26KPAG2et1j0A6BA==
X-Received: by 2002:a17:907:2ce5:b0:aa5:44a8:9ae7 with SMTP id a640c23a62f3a-aab77e9d22cmr983762066b.47.1734307844166;
        Sun, 15 Dec 2024 16:10:44 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963cca7fsm260525766b.191.2024.12.15.16.10.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 16:10:42 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa5f1909d6fso603176866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:10:42 -0800 (PST)
X-Received: by 2002:a17:907:1c08:b0:aa5:225f:47d9 with SMTP id
 a640c23a62f3a-aab779ceb5cmr1178693866b.29.1734307841296; Sun, 15 Dec 2024
 16:10:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 15 Dec 2024 16:10:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7Wjqo_e1bLeEijGkDaw7XcD3+F5kLZYkJfah8wS=evg@mail.gmail.com>
Message-ID: <CAHk-=wh7Wjqo_e1bLeEijGkDaw7XcD3+F5kLZYkJfah8wS=evg@mail.gmail.com>
Subject: Linux 6.13-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Earlier this week it felt to me like things might have already started
to quiet down in prep for the holidays, but doing the statistics on
rc3 that doesn't actually seem to be the case - this looks very
regular both in number of commits and in diff size. In fact, the diff
is  a bit on the larger side, but that is admittedly almost entirely
due to the revert of a unicode change that then makes the diff large
due to a generated data file.

So everything looks normal so far. xfs may stand out in the shortlog
below, but the bulk of the diff (ignoring that generated unicode
table) is still mostly random driver updates.

            Linus

---

Aditya Kumar Singh (1):
      wifi: cfg80211: clear link ID from bitmap during link delete
after clean up

Adrian Ratiu (2):
      sound: usb: enable DSD output for ddHiFi TC44C
      sound: usb: format: don't warn that raw DSD is unsupported

Akira Yokosawa (1):
      scripts/kernel-doc: Get -export option working again

Alan Borzeszkowski (5):
      gpio: graniterapids: Fix vGPIO driver crash
      gpio: graniterapids: Fix incorrect BAR assignment
      gpio: graniterapids: Determine if GPIO pad can be used by driver
      gpio: graniterapids: Check if GPIO line can be used for IRQs
      gpio: graniterapids: Fix GPIO Ack functionality

Alexandre Ghiti (2):
      riscv: Fix wrong usage of __pa() on a fixmap address
      riscv: Fix IPIs usage in kfence_protect_page()

Andrew Martin (1):
      drm/amdkfd: Dereference null return value

Anton Protopopov (1):
      bpf: fix potential error return

Anumula Murali Mohan Reddy (1):
      cxgb4: use port number to set mac addr

Ard Biesheuvel (1):
      efi/zboot: Limit compression options to GZIP and ZSTD

Arnaldo Carvalho de Melo (1):
      perf machine: Initialize machine->env to address a segfault

Bart Van Assche (3):
      mq-deadline: Remove a local variable
      blk-mq: Clean up blk_mq_requeue_work()
      block: Fix queue_iostats_passthrough_show()

Benjamin Lin (1):
      wifi: mac80211: fix station NSS capability initialization order

Benjamin Sz=C5=91ke (1):
      arc: rename aux.h to arc_aux.h

Bj=C3=B6rn T=C3=B6pel (1):
      riscv: mm: Do not call pmd dtor on vmemmap page table teardown

Borislav Petkov (AMD) (1):
      EDAC/amd64: Simplify ECC check on unified memory controllers

Charles Keepax (1):
      ASoC: Intel: sof_sdw: Add space for a terminator into DAIs array

Chenghai Huang (1):
      crypto: hisilicon/debugfs - fix the struct pointer incorrectly
offset problem

Christian K=C3=B6nig (2):
      drm/amdgpu: fix UVD contiguous CS mapping problem
      drm/amdgpu: fix when the cleaner shader is emitted

Christian Loehle (1):
      spi: rockchip: Fix PM runtime count on no-op cs

Christian Marangi (1):
      clk: en7523: Fix wrong BUS clock for EN7581

Christophe JAILLET (1):
      spi: aspeed: Fix an error handling path in aspeed_spi_[read|write]_us=
er()

Claudiu Beznea (1):
      serial: sh-sci: Check if TX data was written to device in .tx_empty()

Coly Li (1):
      MAINTAINERS: update Coly Li's email address

Damien Le Moal (5):
      x86: Fix build regression with CONFIG_KEXEC_JUMP enabled
      block: Use a zone write plug BIO work for REQ_NOWAIT BIOs
      block: Ignore REQ_NOWAIT for zone reset and zone finish operations
      dm: Fix dm-zoned-reclaim zone write pointer alignment
      block: Prevent potential deadlocks in zone write plug error recovery

Dan Carpenter (2):
      net/mlx5: DR, prevent potential error pointer dereference
      rtnetlink: fix error code in rtnl_newlink()

Daniel Borkmann (5):
      net, team, bonding: Add netdev_base_features helper
      bonding: Fix initial {vlan,mpls}_feature set in bond_compute_features
      bonding: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL
      team: Fix initial vlan_feature set in __team_compute_features
      team: Fix feature propagation of NETIF_F_GSO_ENCAP_ALL

Daniel Machon (5):
      net: lan969x: fix cyclic dependency reported by depmod
      net: lan969x: fix the use of spin_lock in PTP handler
      net: sparx5: fix FDMA performance issue
      net: sparx5: fix default value of monitor ports
      net: sparx5: fix the maximum frame length register

Daniele Ceraolo Spurio (1):
      drm/xe: Call invalidation_fence_fini for PT inval fences in error sta=
te

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FE910C04 compositions

Danielle Ratson (3):
      selftests: mlxsw: sharedbuffer: Remove h1 ingress test case
      selftests: mlxsw: sharedbuffer: Remove duplicate test cases
      selftests: mlxsw: sharedbuffer: Ensure no extra packets are counted

Daniil Tatianin (1):
      ACPICA: events/evxfregn: don't release the ContextMutex that was
never acquired

Darrick J. Wong (28):
      xfs: fix off-by-one error in fsmap's end_daddr usage
      xfs: metapath scrubber should use the already loaded inodes
      xfs: keep quota directory inode loaded
      xfs: return a 64-bit block count from xfs_btree_count_blocks
      xfs: don't drop errno values when we fail to ficlone the entire range
      xfs: separate healthy clearing mask during repair
      xfs: set XFS_SICK_INO_SYMLINK_ZAPPED explicitly when zapping a symlin=
k
      xfs: mark metadir repair tempfiles with IRECOVERY
      xfs: fix null bno_hint handling in xfs_rtallocate_rtg
      xfs: fix error bailout in xfs_rtginode_create
      xfs: update btree keys correctly when _insrec splits an inode root bl=
ock
      xfs: fix scrub tracepoints when inode-rooted btrees are involved
      xfs: unlock inodes when erroring out of xfs_trans_alloc_dir
      xfs: only run precommits once per transaction object
      xfs: avoid nested calls to __xfs_trans_commit
      xfs: don't lose solo superblock counter update transactions
      xfs: don't lose solo dquot update transactions
      xfs: separate dquot buffer reads from xfs_dqflush
      xfs: clean up log item accesses in xfs_qm_dqflush{,_done}
      xfs: attach dquot buffer to dquot log item buffer
      xfs: convert quotacheck to attach dquot buffers
      xfs: fix sb_spino_align checks for large fsblock sizes
      xfs: don't move nondir/nonreg temporary repair files to the
metadir namespace
      xfs: don't crash on corrupt /quotas dirent
      xfs: check pre-metadir fields correctly
      xfs: fix zero byte checking in the superblock scrubber
      xfs: return from xfs_symlink_verify early on V4 filesystems
      xfs: port xfs_ioc_start_commit to multigrain timestamps

Dave Penkler (3):
      staging: gpib: Workaround for ppc build failure
      staging: gpib: Fix faulty workaround for assignment in if
      staging: gpib: Fix i386 build issue

David (Ming Qiang) Wu (1):
      amdgpu/uvd: get ring reference from rq scheduler

David Howells (1):
      cifs: Fix rmdir failure due to ongoing I/O on deleted file

Eduard Zingerman (10):
      bpf: add find_containing_subprog() utility function
      bpf: refactor bpf_helper_changes_pkt_data to use helper number
      bpf: track changes_pkt_data property for global functions
      selftests/bpf: test for changing packet data from global functions
      bpf: check changes_pkt_data property for extension programs
      selftests/bpf: freplace tests for tracking of changes_packet_data
      bpf: consider that tail calls invalidate packet pointers
      selftests/bpf: validate that tail call invalidates packet pointers
      bpf: fix null dereference when computing changes_pkt_data of
prog w/o subprogs
      selftests/bpf: extend changes_pkt_data with cases w/o subprograms

Emmanuel Grumbach (2):
      wifi: mac80211: wake the queues in case of failure in resume
      wifi: mac80211: fix a queue stall in certain cases of CSA

Enzo Matsumiya (1):
      smb: client: destroy cfid_put_wq on module exit

Eric Dumazet (3):
      tipc: fix NULL deref in cleanup_bearer()
      net: lapb: increase LAPB_HEADER_LEN
      net: defer final 'struct net' free in netns dismantle

Eugene Kobyak (1):
      drm/i915: Fix NULL pointer dereference in capture_engine

Felix Fietkau (1):
      wifi: mac80211: fix vif addr when switching from monitor to station

Filipe Manana (2):
      btrfs: fix missing snapshot drew unlock when root is dead during
swap activation
      btrfs: flush delalloc workers queue before stopping cleaner
kthread during unmount

Florian Westphal (1):
      netfilter: nf_tables: do not defer rule destruction via call_rcu

Frederik Deweerdt (1):
      splice: do not checksum AF_UNIX sockets

Fr=C3=A9d=C3=A9ric Danis (1):
      Bluetooth: SCO: Add support for 16 bits transparent voice setting

Geert Uytterhoeven (4):
      gpio: GPIO_MVEBU should not default to y when compile-testing
      openrisc: Fix misalignments in head.S
      i2c: nomadik: Add missing sentinel to match table
      i2c: riic: Always round-up when calculating bus period

Geetha sowjanya (1):
      octeontx2-af: Fix installation of PF multicast rule

Guenter Roeck (1):
      tty: serial: Work around warning backtrace in serial8250_set_defaults

Guo Ren (1):
      riscv: Fixup boot failure when CONFIG_DEBUG_RT_MUTEXES=3Dy

Haoyu Li (4):
      wifi: mac80211: init cnt before accessing elem in
ieee80211_copy_mbssid_beacon
      clk: en7523: Initialize num before accessing hws in
en7523_register_clocks()
      wifi: cfg80211: sme: init n_channels before channels[] access
      gpio: ljca: Initialize num before accessing item in ljca_gpio_config

Hardevsinh Palaniya (1):
      ARC: bpf: Correct conditional check in 'check_jmp_32'

Hari Bathini (1):
      selftests/ftrace: adjust offset for kprobe syntax error test

Harish Kasiviswanathan (2):
      drm/amdkfd: hard-code cacheline size for gfx11
      drm/amdkfd: hard-code MALL cacheline size for gfx11, gfx12

Herbert Xu (1):
      crypto: rsassa-pkcs1 - Copy source data for SG list

Hobin Woo (1):
      ksmbd: retry iterate_dir in smb2_query_dir

Hongguang Gao (1):
      bnxt_en: Fix potential crash when dumping FW log coredump

Hridesh MG (1):
      ALSA: hda/realtek: Fix headset mic on Acer Nitro 5

Ian Rogers (3):
      perf hwmon_pmu: Use openat rather than dup to refresh directory
      perf test hwmon_pmu: Fix event file location
      perf test expr: Fix system_tsc_freq for only x86

Ilpo J=C3=A4rvinen (1):
      ACPI: resource: Fix memory resource type union access

Ingo Molnar (1):
      headers/cleanup.h: Remove the if_not_guard() facility

Issam Hamdi (1):
      wifi: mac80211: fix mbss changed flags corruption on 32 bit systems

Iulia Tanasescu (4):
      Bluetooth: iso: Always release hdev at the end of iso_listen_bis
      Bluetooth: iso: Fix recursive locking warning
      Bluetooth: iso: Fix circular lock in iso_listen_bis
      Bluetooth: iso: Fix circular lock in iso_conn_big_sync

Jaakko Salo (1):
      ALSA: usb-audio: Add implicit feedback quirk for Yamaha THR5

James Bottomley (1):
      efivarfs: Fix error on non-existent file

James Clark (4):
      arm64: Fix usage of new shifted MDCR_EL2 values
      perf test: Don't signal all processes on system when interrupting tes=
ts
      libperf: evlist: Fix --cpu argument on hybrid platform
      perf probe: Fix uninitialized variable

Janaki Ramaiah Thota (1):
      regulator: dt-bindings: qcom,qca6390-pmu: document wcn6750-pmu

Jann Horn (2):
      bpf: Fix UAF via mismatching bpf_prog/attachment RCU flavors
      bpf: Fix theoretical prog_array UAF in __uprobe_perf_func()

Jason Gunthorpe (2):
      iommu/amd: Put list_add/del(dev_data) back under the domain->lock
      iommu/amd: Add lockdep asserts for domain->dev_list

Jens Axboe (1):
      io_uring/rsrc: don't put/free empty buffers

Jerome Brunet (1):
      clk: amlogic: axg-audio: revert reset implementation

Jesse Van Gavere (1):
      net: dsa: microchip: KSZ9896 register regmap alignment to 32 bit
boundaries

Jesse.zhang@amd.com (1):
      drm/amdkfd: pause autosuspend when creating pdd

Jiasheng Jiang (1):
      drm/i915: Fix memory leak by correcting cache object name in error ha=
ndler

Jiri Olsa (1):
      bpf,perf: Fix invalid prog_array access in perf_event_detach_bpf_prog

Jiri Slaby (SUSE) (1):
      efi/esrt: remove esre_attribute::store()

Joe Hattori (3):
      usb: typec: anx7411: fix fwnode_handle reference leak
      usb: typec: anx7411: fix OF node reference leaks in
anx7411_typec_switch_probe()
      ata: sata_highbank: fix OF node reference leak in
highbank_initialize_phys()

Johan Hovold (1):
      Revert "clk: Fix invalid execution of clk_set_rate"

Johannes Thumshirn (1):
      btrfs: handle bio_split() errors

John Garry (1):
      block: Make bio_iov_bvec_set() accept pointer to const iov_iter

John Stultz (1):
      locking: rtmutex: Fix wake_q logic in task_blocks_on_rt_mutex

Josh Don (1):
      sched: fix warning in sched_setaffinity

Juri Lelli (1):
      sched/deadline: Fix replenish_dl_new_period dl_server condition

K Prateek Nayak (5):
      softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT ker=
nel
      sched/core: Remove the unnecessary need_resched() check in nohz_csd_f=
unc()
      sched/fair: Check idle_cpu() before need_resched() to detect ilb
CPU turning busy
      sched/core: Prevent wakeup of ksoftirqd during idle load balance
      sched/fair: Fix NEXT_BUDDY

Kan Liang (2):
      perf/x86/intel: Add Arrow Lake U support
      perf/x86/intel/ds: Unconditionally drain PEBS DS when changing
PEBS_DATA_CFG

Keisuke Nishimura (1):
      KVM: arm64: vgic-its: Add error handling in vgic_its_cache_translatio=
n

Kenneth Feng (1):
      drm/amd/pm: Set SMU v13.0.7 default workload type

Kevin Brodsky (1):
      arm64: signal: Ensure signal delivery failure is recoverable

Koichiro Den (6):
      virtio_net: correct netdev_tx_reset_queue() invocation point
      virtio_net: replace vq2rxq with vq2txq where appropriate
      virtio_ring: add a func argument 'recycle_done' to virtqueue_resize()
      virtio_net: ensure netdev_tx_reset_queue is called on tx ring resize
      virtio_ring: add a func argument 'recycle_done' to virtqueue_reset()
      virtio_net: ensure netdev_tx_reset_queue is called on bind xsk for tx

Kuan-Wei Chiu (1):
      perf ftrace: Fix undefined behavior in cmp_profile_data()

Kumar Kartikeya Dwivedi (5):
      bpf: Check size for BTF-based ctx access of pointer members
      selftests/bpf: Add test for narrow ctx load for pointer args
      bpf: Revert "bpf: Mark raw_tp arguments with PTR_MAYBE_NULL"
      bpf: Augment raw_tp arguments with PTR_MAYBE_NULL
      selftests/bpf: Add tests for raw_tp NULL args

Kuniyuki Iwashima (1):
      ip: Return drop reason if in_dev is NULL in ip_route_input_rcu().

Leon Romanovsky (1):
      ARC: build: Try to guess GCC variant of cross compiler

Lianqin Hu (1):
      usb: gadget: u_serial: Fix the issue that gs_start_io crashed
due to accessing null pointer

Lijo Lazar (1):
      drm/amd/pm: Initialize power profile mode

Lin Ma (1):
      wifi: nl80211: fix NL80211_ATTR_MLO_LINK_ID off-by-one

Linus Torvalds (3):
      futex: fix user access on powerpc
      Revert "unicode: Don't special case ignorable code points"
      Linux 6.13-rc3

LongPing Wei (1):
      block: get wp_offset by bdev_offset_from_zone_start

Lu Baolu (2):
      iommu/vt-d: Remove cache tags before disabling ATS
      iommu/vt-d: Avoid draining PRQ in sva mm release path

Lucas De Marchi (2):
      usb: typec: ucsi: Fix connector status writing past buffer size
      drm/xe/reg_sr: Remove register pool

Luis Claudio R. Goncalves (1):
      iommu/tegra241-cmdqv: do not use smp_processor_id in preemptible cont=
ext

Luiz Augusto von Dentz (2):
      Bluetooth: hci_core: Fix sleeping function called from invalid contex=
t
      Bluetooth: hci_event: Fix using rcu_read_(un)lock while iterating

Lukas Bulwahn (1):
      ARC: fix reference of dependency for PAE40 config

Marc Zyngier (3):
      KVM: arm64: Fix S1/S2 combination when FWB=3D=3D1 and S2 has Device
memory type
      KVM: arm64: Do not allow ID_AA64MMFR0_EL1.ASIDbits to be overridden
      irqchip/gic-v3: Work around insecure GIC integrations

Mark Rutland (2):
      arm64: stacktrace: Skip reporting LR at exception boundaries
      arm64: stacktrace: Don't WARN when unwinding other tasks

Mark Tomlinson (1):
      usb: host: max3421-hcd: Correctly abort a USB request.

Martin Ottens (1):
      net/sched: netem: account for backlog updates from child qdisc

Masahiro Yamada (1):
      openrisc: place exception table at the head of vmlinux

Masami Hiramatsu (Google) (1):
      tracing/eprobe: Fix to release eprobe when failed to add dyn_event

Maxim Levitsky (2):
      net: mana: Fix memory leak in mana_gd_setup_irqs
      net: mana: Fix irq_contexts memory leak in mana_gd_setup_irqs

Michael Chan (2):
      bnxt_en: Fix GSO type for HW GRO packets on 5750X chips
      bnxt_en: Fix aggregation ID mask to prevent oops on 5760X chips

Michael Neuling (1):
      RISC-V: KVM: Fix csr_write -> csr_set for HVIEN PMU overflow bit

Michal Luczaj (4):
      bpf, sockmap: Fix update element with same
      bpf, sockmap: Fix race between element replace and close()
      selftests/bpf: Extend test for sockmap update with same
      Bluetooth: Improve setsockopt() handling of malformed user input

Miguel Ojeda (2):
      drm/panic: remove spurious empty line to clean warning
      rust: kbuild: set `bindgen`'s Rust target version

Mirsad Todorovac (1):
      drm/xe: fix the ERR_PTR() returned on failure to allocate tiny pt

MoYuanhao (1):
      tcp: check space before adding MPTCP SYN options

Namhyung Kim (13):
      perf tools: Fix build-id event recording
      tools headers: Sync uapi/drm/drm.h with the kernel sources
      tools headers: Sync uapi/linux/perf_event.h with the kernel sources
      tools headers: Sync uapi/linux/kvm.h with the kernel sources
      tools headers: Sync x86 kvm and cpufeature headers with the kernel
      tools headers: Sync arm64 kvm header with the kernel sources
      tools headers: Sync *xattrat syscall changes with the kernel sources
      tools headers: Sync uapi/asm-generic/mman.h with the kernel sources
      tools headers: Sync uapi/linux/fcntl.h with the kernel sources
      tools headers: Sync uapi/linux/mount.h with the kernel sources
      tools headers: Sync uapi/linux/prctl.h with the kernel sources
      perf tools: Fix build error on generated/fs_at_flags_array.c
      perf tools: Fix precise_ip fallback logic

Namjae Jeon (2):
      ksmbd: fix racy issue from session lookup and expire
      ksmbd: set ATTR_CTIME flags when setting mtime

Nathan Chancellor (2):
      staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT
      blk-iocost: Avoid using clamp() on inuse in __propagate_weights()

Neal Frager (1):
      usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mo=
de

Nikita Yushchenko (6):
      net: renesas: rswitch: fix possible early skb release
      net: renesas: rswitch: fix race window between tx start and complete
      net: renesas: rswitch: fix leaked pointer on error path
      net: renesas: rswitch: avoid use-after-put for a device tree node
      net: renesas: rswitch: handle stop vs interrupt race
      net: renesas: rswitch: fix initial MPIC register setting

Nilay Shroff (1):
      block: Fix potential deadlock while freezing queue and acquiring
sysfs_lock

Niravkumar L Rabara (1):
      spi: spi-cadence-qspi: Disable STIG mode for Altera SoCFPGA.

Paolo Abeni (1):
      udp: fix l4 hash after reconnect

Paul Barker (1):
      Documentation: PM: Clarify pm_runtime_resume_and_get() return value

Paul E. McKenney (1):
      ARC: build: Use __force to suppress per-CPU cmpxchg warnings

Peter Zijlstra (1):
      sched/eevdf: More PELT vs DELAYED_DEQUEUE

Petr Machata (1):
      Documentation: networking: Add a caveat to nexthop_compat_mode sysctl

Phil Sutter (2):
      selftests: netfilter: Stabilize rpath.sh
      netfilter: IDLETIMER: Fix for possible ABBA deadlock

Philippe Simons (1):
      regulator: axp20x: AXP717: set ramp_delay

Pratap Nirujogi (2):
      Revert "drm/amdgpu: Fix ISP hw init issue"
      drm/amdgpu: Fix ISP HW init issue

Prike Liang (1):
      drm/amdkfd: Correct the migration DMA map direction

Priya Bala Govindasamy (1):
      bpf: Avoid deadlock caused by nested kprobe and fentry bpf programs

Qu Wenruo (2):
      btrfs: fix mount failure due to remount races
      btrfs: properly wait for writeback before buffered write

Radhey Shyam Pandey (1):
      usb: misc: onboard_usb_dev: skip suspend/resume sequence for
USB5744 SMBus support

Remi Pommarel (3):
      batman-adv: Do not send uninitialized TT changes
      batman-adv: Remove uninitialized data in full table TT response
      batman-adv: Do not let TT changes list grows indefinitely

Robert Hodaszi (1):
      net: dsa: tag_ocelot_8021q: fix broken reception

Russell King (Oracle) (1):
      net: stmmac: fix TSO DMA API usage causing oops

Sean Christopherson (1):
      KVM: x86: Cache CPUID.0xD XSTATE offsets+sizes during module init

Sebastian Andrzej Siewior (1):
      sched/core: Update kernel boot parameters for LAZY preempt.

Shakeel Butt (1):
      memcg: slub: fix SUnreclaim for post charged objects

Shankar Bandal (2):
      gpio: graniterapids: Fix invalid GPI_IS register offset
      gpio: graniterapids: Fix invalid RXEVCFG register bitmask

Shenghao Ding (1):
      ASoC: tas2781: Fix calibration issue in stress test

Shengjiu Wang (2):
      ASoC: fsl_xcvr: change IFACE_PCM to IFACE_MIXER
      ASoC: fsl_spdif: change IFACE_PCM to IFACE_MIXER

Simon Horman (1):
      MAINTAINERS: Add ethtool.h to NETWORKING [GENERAL]

Simon Trimmer (1):
      ALSA: hda: cs35l56: Remove calls to
cs35l56_force_sync_asp1_registers_from_cache()

Stefan Wahren (5):
      usb: dwc2: Fix HCD resume
      usb: dwc2: hcd: Fix GetPortStatus & SetPortFeature
      usb: dwc2: Fix HCD port connection race
      qca_spi: Fix clock speed for multiple QCA7000
      qca_spi: Make driver probing reliable

Stephen Gordon (1):
      ASoC: audio-graph-card: Call of_node_put() on correct node

Steve French (1):
      smb3: fix compiler warning in reparse code

Suraj Sonawane (1):
      acpi: nfit: vmalloc-out-of-bounds Read in acpi_nfit_ctl

Takashi Iwai (3):
      usb: gadget: midi2: Fix interpretation of is_midi1 bits
      ALSA: hda/ca0132: Use standard HD-audio quirk matching helpers
      ALSA: control: Avoid WARN() for symlink errors

Tejun Heo (1):
      blk-cgroup: Fix UAF in blkcg_unpin_online()

Thadeu Lima de Souza Cascardo (1):
      Bluetooth: btmtk: avoid UAF in btmtk_process_coredump

Thomas Hellstr=C3=B6m (1):
      locking/ww_mutex: Fix ww_mutex dummy lockdep map selftest warnings

Thomas Wei=C3=9Fschuh (1):
      ptp: kvm: x86: Return EOPNOTSUPP instead of ENODEV from
kvm_arch_ptp_init()

Thorsten Blum (1):
      cifs: Use str_yes_no() helper in cifs_ses_add_channel()

Uros Bizjak (1):
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic=
_base

Uwe Kleine-K=C3=B6nig (2):
      gpio: idio-16: Actually make use of the GPIO_IDIO_16 symbol namespace
      ARC: dts: Replace deprecated snps,nr-gpios property for
snps,dw-apb-gpio-port devices

Vasiliy Kovalev (2):
      ALSA: hda/realtek - Add support for ASUS Zen AIO 27 Z272SD_A272SD aud=
io
      ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model

Venkata Prasad Potturu (1):
      ASoC: amd: yc: Fix the wrong return value

Victor Zhao (1):
      drm/amdgpu: use sjt mec fw on gfx943 for sriov

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/dsb: Don't use indexed register writes needlessly
      drm/i915/color: Stop using non-posted DSB writes for legacy LUT

Vincent Guittot (1):
      sched/fair: Fix sched_can_stop_tick() for fair tasks

Vineet Gupta (1):
      ARC: build: disallow invalid PAE40 + 4K page config

Vineeth Pillai (Google) (2):
      sched/dlserver: Fix dlserver double enqueue
      sched/dlserver: Fix dlserver time accounting

Vitalii Mordan (1):
      usb: ehci-hcd: fix call balance of clocks handling routines

Vladimir Oltean (6):
      net: mscc: ocelot: fix memory leak on ocelot_port_add_txtstamp_skb()
      net: mscc: ocelot: improve handling of TX timestamp for unknown skb
      net: mscc: ocelot: ocelot->ts_id_lock and
ocelot_port->tx_skbs.lock are IRQ-safe
      net: mscc: ocelot: be resilient to loss of PTP packets during transmi=
ssion
      net: mscc: ocelot: perform error cleanup in ocelot_hwstamp_set()
      net: dsa: felix: fix stuck CPU-injected packets with short taprio win=
dows

Vladimir Riabchun (1):
      i2c: pnx: Fix timeout in wait functions

Wander Lairson Costa (1):
      sched/deadline: Fix warning in migrate_enable for boosted tasks

Weizhao Ouyang (1):
      kselftest/arm64: abi: fix SVCR detection

Xu Yang (3):
      dt-bindings: phy: imx8mq-usb: correct reference to usb-switch.yaml
      usb: dwc3: imx8mp: fix software node kernel dump
      usb: core: hcd: only check primary hcd skip_phy_initialization

Yi Liu (1):
      iommu/vt-d: Fix qi_batch NULL pointer with nested parent domain

Yishai Hadas (1):
      vfio/mlx5: Align the page tracking max message size with the
device capability

liuderong (1):
      scsi: ufs: core: Update compl_time_stamp_local_clock after
completing a cqe

=C5=81ukasz Bartosik (1):
      usb: typec: ucsi: Fix completion notifications

