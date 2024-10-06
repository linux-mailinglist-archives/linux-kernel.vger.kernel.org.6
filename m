Return-Path: <linux-kernel+bounces-352660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFF992249
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242531F21545
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 23:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF37C18BBA3;
	Sun,  6 Oct 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VEw+ERu/"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D41A716
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 23:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257345; cv=none; b=PPFzMuGQYj1hNRYGzvfU4qu8UyRUnoqpyX9gioDfd0miBAdkb/rV/+fK3fTD70Wc7Y5iaTwf6+O5hiKagL1QYWjmN3FQhsaMUaJBUMoJeuxT1gl6nzOSrxNfJ8qS3pimlrR1SjRbULGt2OdF0r8B/uIVU5XexjtDmAee0CgaQWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257345; c=relaxed/simple;
	bh=+J3rEkHWTUBLvCpsBist8aujxd6rfx0KmN2mJto2n1U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qxJrQFccRDVIWkfexRUTvCh0kV9BlQ4jvzeRV4COCDulZlkkuWWv/78O1FDNWd78lfwy0iQCrMQ4syzob4Cg2PD4E86quYG0Qt/xBVuGkADRfab4ljBtGxfVc6wdbTokbXbxAtR0DJlaLWX9iQj+XUJB0J4sjjLvxCdgwfTE7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VEw+ERu/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a995627a0daso45746166b.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 16:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728257336; x=1728862136; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LxYv4Qq1248Uny/0DE+vOrwKmzkKa6I2iAagmMvlLjQ=;
        b=VEw+ERu/g7xQkECouUCtQPUp5NuOGvMHrGVDI0zahxmd//WkURXg2x6uS/kvtUQcYq
         /utWp2zbeGI0NHM1rjshEhJ3hqBvxP/7lxk3rMXwg2afGVhn+0FpfDsUJJgpCIulSp0O
         8/LpB+stSGfJCAeo3nVn/uBtqyKxbJ6ozhQXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728257336; x=1728862136;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxYv4Qq1248Uny/0DE+vOrwKmzkKa6I2iAagmMvlLjQ=;
        b=IgC66OWW7l9AuNW+FNbY3ojhA2fYNgaV5wpzDLb9k2kNuSovN4Q9Ko3A3RO5daxZYY
         6HVuTfs6BgZE0081PszquMnQSsBAbu5fxw5Yj8/TYrNEdSbQ+vo5hjZNMG/DyZNUzxWo
         WDTUh37a4c+rko5H/GmuSBGwO2K7U/fQznwtkSMwZXPHtxZs4SQ6vtz3v8JN04eEI1w6
         gswQJ1B82f9wIYnC0Y7M1ScSaU0UxqReSAgE1/pc4yjPB+kqOkQpYGFPWOM03+I7Ie/e
         MaGHUR0Ikm66VdaO9ftXGTa2fUYZJB9NfrYFYcQvf5jPbeMkU1Y/JvBkfbW/rf9S27SW
         sV2g==
X-Gm-Message-State: AOJu0YwxR3UoNHIrUu9yR5Nd6Wr60IRg3bYZDI2LhR+/VzTu8UbnhI4R
	rjoit3qr3/vCHXa+y/8ybNmR04WIr9L9vaXd4IDOiJlSwQ4ROIfMs9Ijq0PUpJmJm4i70WaugoJ
	5N2Y=
X-Google-Smtp-Source: AGHT+IG1hTxvrOcZ6qv3zkSv+4G9Vdl5fHDT450467BfPYj6tbDObXzlMO/VjOGHSu/BKhU30IgPEg==
X-Received: by 2002:a17:907:7e8d:b0:a86:ac91:a571 with SMTP id a640c23a62f3a-a991c072851mr1200400366b.56.1728257336106;
        Sun, 06 Oct 2024 16:28:56 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9950a8b530sm100352466b.197.2024.10.06.16.28.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 16:28:54 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a99543ab209so61314766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 16:28:53 -0700 (PDT)
X-Received: by 2002:a17:907:3f18:b0:a99:be1:2d60 with SMTP id
 a640c23a62f3a-a991bd052c7mr1098667566b.13.1728257332762; Sun, 06 Oct 2024
 16:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 6 Oct 2024 16:28:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
Message-ID: <CAHk-=wgMS-TBfirwuxf+oFA3cTMWVLik=w+mA5KdT9dAvcvhTA@mail.gmail.com>
Subject: Linux 6.12-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm. I have had this mental picture that usually rc2 tends to be one
of the smaller rc's because people take a breather after the merge
window, and/or because it takes a while before people start finding
issues.

But at least this release doesn't seem to show that pattern, and I
went back and did some stats on older 6.x releases, and from a quick
look it looks like it's really only true about half the time. Some
rc2's are indeed fairly small, but not all are. I guess I should have
run the numbers before.

Anyway, this isn't one of the small rc2's. But looking at historical
trends, being a bigger rc2 isn't _that_ unusual, and nothing in here
looks all that odd. Yes, the diffstat may look a bit unusual, in that
we had a global header renaming (asm/unaligned.h -> linux/unaligned.h)
and we had a couple of reverts that stand out as spikes in the stats,
but everything else looks nice and small. In fact, one other
noticeably bigger spike in the diffstat is just due to some folio
documentation updates, not any code changes.

At about a quarter of the diffs, the filesystem changes are a bit
bigger than usual (and would actually have been bigger than the driver
changes if it wasn't for one of those reverts), but that's probably
just a random timing effect. I expect I'll be getting more driver
updates next week.

Anyway, on a completely different note: I try to make my merge commit
messages be somewhat "cohesive", and so I often edit the pull request
language to match a more standard layout and language. It's not a big
deal, and often it's literally just about whitespace so that we don't
have fifteen different indentation models and bullet syntaxes. I
generally do it as I read through the text anyway, so it's not like it
makes extra work for me.

But what *does* make extra work is when some maintainers use passive
voice, and then I try to actively rewrite the explanation (or,
admittedly, sometimes I just decide I don't care quite enough about
trying to make the messages sound the same).

So I would ask maintainers to please use active voice, and preferably
just imperative.

Put another way: I'd love it if people would avoid writing their
descriptions as "In this pull request, the Xyzzy driver error handling
was fixed to avoid a NULL pointer dereference".

Instead write it as "This fixes a NULL pointer dereference in .." or
particularly if you just list bullet points, make the bullet point
just be "Fix NULL pointer dereference in ..".

This is not a big deal, I realize. But I happened to try to rewrite a
few of these cases the last week, and I think simple and to-the-point
language is better. The imperative version of just "Fix X" is about as
clear as it gets.

              Linus

---

Aakash Menon (1):
      net: sparx5: Fix invalid timestamps

Aaron Thompson (1):
      kbuild: deb-pkg: Remove blank first line from maint scripts

Abdul Rahim (1):
      selftest: alsa: check if user has alsa installed

Abhishek Tamboli (1):
      ALSA: hda/realtek: Add a quirk for HP Pavilion 15z-ec200

Ai Chao (1):
      ALSA: hda/realtek: Add quirk for Huawei MateBook 13 KLV-WX9

Al Viro (5):
      close_range(): fix the logics in descriptor table trimming
      parisc: get rid of private asm/unaligned.h
      ufs_rename(): fix bogus argument of folio_release_kmap()
      arc: get rid of private asm/unaligned.h
      move asm/unaligned.h to linux/unaligned.h

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix memory disclosure

Alessandro Zanni (1):
      kselftest/devices/probe: Fix SyntaxWarning in regex strings for Pytho=
n3

Alex Hung (1):
      drm/amd/display: Add HDR workaround for specific eDP

Alexander Dahl (1):
      spi: atmel-quadspi: Fix wrong register value written to MR

Alexandre Ghiti (1):
      riscv: Fix kernel stack size when KASAN is enabled

Alexey Klimov (3):
      ASoC: codecs: lpass-rx-macro: add missing
CDC_RX_BCL_VBAT_RF_PROC2 to default regs values
      ASoC: dt-bindings: qcom,sm8250: add qrb4210-rb2-sndcard
      ASoC: qcom: sm8250: add qrb4210-rb2-sndcard compatible string

Alice Ryhl (3):
      rust: sync: require `T: Sync` for `LockedBy::access`
      rust: KASAN+RETHUNK requires rustc 1.83.0
      cfi: encode cfi normalized integers + kasan/gcov bug in Kconfig

Anaswara T Rajan (1):
      platform/x86: dell-ddv: Fix typo in documentation

Andrei Simion (1):
      ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream
runtime is uninitialized

Anton Danilov (1):
      ipv4: ip_gre: Fix drops of small packets in ipgre_xmit

Armin Wolf (4):
      ACPI: battery: Simplify battery hook locking
      ACPI: battery: Fix possible crash when unregistering a battery hook
      platform/x86: dell-laptop: Do not fail when encountering
unsupported batteries
      platform/x86: wmi: Update WMI driver API documentation

Ba Jing (1):
      clone3: clone3_cap_checkpoint_restore: remove unused
MAX_PID_NS_LEVEL macro

Baojun Xu (1):
      ALSA: hda/tas2781: Add new quirk for Lenovo Y990 Laptop

Baokun Li (2):
      cachefiles: fix dentry leak in cachefiles_open_file()
      ext4: fix off by one issue in alloc_flex_gd()

Bard Liao (1):
      ASoC: Intel: soc-acpi-intel-rpl-match: add missing empty item

Ben Cheatham (1):
      EINJ, CXL: Fix CXL device SBDF calculation

Ben Dooks (1):
      spi: s3c64xx: fix timeout counters in flush_fifo

Ben Hutchings (1):
      tools/rtla: Fix installation from out-of-tree build

Benjamin Tissoires (1):
      HID: bpf: fix cfi stubs for hid_bpf_ops

Boris Brezillon (4):
      drm/panthor: Lock the VM resv before calling
drm_gpuvm_bo_obtain_prealloc()
      drm/panthor: Fix access to uninitialized variable in tick_ctx_cleanup=
()
      drm/panthor: Don't declare a queue blocked if deferred
operations are pending
      drm/panthor: Don't add write fences to the shared BOs

Chang Yu (1):
      netfs: Fix a KMSAN uninit-value error in netfs_clear_buffer

Charlene Liu (1):
      drm/amd/display: avoid set dispclk to 0

Charles Han (1):
      ASoC: intel: sof_sdw: Add check devm_kasprintf() returned value

Charles Keepax (1):
      ASoC: Intel: soc-acpi: arl: Fix some missing empty terminators

Christian Brauner (3):
      pidfs: check for valid pid namespace
      folio_queue: fix documentation
      Documentation: add missing folio_queue entry

Christian K=C3=B6nig (1):
      drm/sched: revert "Always increment correct scheduler score"

Christophe JAILLET (2):
      ALSA: mixer_oss: Remove some incorrect kfree_const() usages
      ALSA: gus: Fix some error handling paths related to get_bpos() usage

Chun-Yi Lee (1):
      aoe: fix the potential use-after-free problem in more places

Crag Wang (1):
      platform/x86: dell-sysman: add support for alienware products

Cs=C3=B3k=C3=A1s, Bence (2):
      net: fec: Restart PPS after link state change
      net: fec: Reload PTP registers after link-state change

Dan Carpenter (3):
      ALSA: silence integer wrapping warning
      blk_iocost: remove some duplicate irq disable/enables
      net: ethernet: ti: am65-cpsw: Fix forever loop in cleanup code

Daniel Borkmann (2):
      net: Add netif_get_gro_max_size helper for GRO
      net: Fix gso_features_check to check for both dev->gso_{ipv4_,}max_si=
ze

Darrick J. Wong (2):
      iomap: don't bother unsharing delalloc extents
      iomap: constrain the file range passed to iomap_file_unshare

David Howells (6):
      afs: Fix missing wire-up of afs_retry_request()
      afs: Fix the setting of the server responding flag
      netfs: Advance iterator correctly rather than jumping it
      netfs: Add folio_queue API documentation
      netfs: Fix the netfs_folio tracepoint to handle NULL mapping
      netfs: Fix missing wakeup after issuing writes

David Lawrence Glanzman (1):
      ASoC: amd: yc: Add quirk for HP Dragonfly pro one

Derek Foreman (1):
      drm/connector: hdmi: Fix writing Dynamic Range Mastering infoframes

Dirk Behme (1):
      rust: mutex: fix __mutex_init() usage in case of PREEMPT_RT

Dmitry Baryshkov (1):
      drm/display: fix kerneldocs references

Dmitry Torokhov (1):
      Revert "Input: Add driver for PixArt PS/2 touchpad"

Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix overflow of hd_per_wq

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to erratum 3194386

Eddie James (1):
      net/ncsi: Disable the ncsi work before freeing the associated structu=
re

Eder Zulian (1):
      rtla: Fix the help text in osnoise and timerlat top tools

Elena Salomatkina (1):
      net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Emanuele Ghidoli (1):
      gpio: davinci: fix lazy disable

Eric Dumazet (5):
      netfilter: nf_tables: prevent nf_skb_duplicated corruption
      net: avoid potential underflow in qdisc_pkt_len_init() with UFO
      net: add more sanity checks to qdisc_pkt_len_init()
      net: test for not too small csum_start in virtio_net_hdr_to_skb()
      ppp: do not assume bh is held in ppp_channel_bridge_input()

FUJITA Tomonori (1):
      net: phy: qt2025: Fix warning: unused import DeviceId

Fangzhi Zuo (1):
      drm/amd/display: Restore Optimized pbn Value if Failed to Disable DSC

Felix Fietkau (1):
      net: gso: fix tcp fraglist segmentation after pull from frag_list

Filipe Manana (4):
      btrfs: send: fix buffer overflow detection when copying path to
cache entry
      btrfs: tracepoints: end assignment with semicolon at
btrfs_qgroup_extent event class
      btrfs: send: fix invalid clone operation for file that got its
size decreased
      btrfs: wait for fixup workers before stopping cleaner kthread
during umount

Gary Guo (1):
      rust: fix `ARCH_SLAB_MINALIGN` multiple definition error

Geert Uytterhoeven (1):
      net: microchip: Make FDMA config symbol invisible

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Gianfranco Trad (1):
      udf: fix uninit-value use in udf_get_fileshortad

Guenter Roeck (1):
      bcachefs: rename version -> bversion for big endian builds

Guixin Liu (1):
      io_uring: fix memory leak when cache init fail

Gustavo Sousa (3):
      drm/xe/mcr: Use Xe2_LPM steering tables for Xe2_HPM
      drm/xe/xe2: Extend performance tuning to media GT
      drm/xe/xe2: Add performance tuning for L3 cache flushing

Hangbin Liu (1):
      selftests: rds: move include.sh to TEST_FILES

Hans P. Moller (1):
      ALSA: line6: add hw monitor volume control to POD HD500X

Hans de Goede (8):
      drm/vboxvideo: Replace fake VLA at end of
vbva_mouse_pointer_shape with real VLA
      ACPI: resource: Remove duplicate Asus E1504GAB IRQ override
      ACPI: resource: Loosen the Asus E1404GAB DMI match to also cover
the E1404GA
      ACPI: resource: Add Asus Vivobook X1704VAP to
irq1_level_low_skip_override[]
      ACPI: resource: Add Asus ExpertBook B2502CVA to
irq1_level_low_skip_override[]
      ACPI: video: Add backlight=3Dnative quirk for Dell OptiPlex 5480 AIO
      platform/x86:intel/pmc: Disable ACPI PM Timer disabling on Sky
and Kaby Lake
      platform/x86: x86-android-tablets: Fix use after free on
platform_device_register() errors

He Lugang (1):
      drm/xe: use devm_add_action_or_reset() helper

Hui Wang (2):
      ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=3D=
m
      net: phy: realtek: Check the index value in led_hw_control_get

Ido Schimmel (1):
      bridge: mcast: Fail MDB get request on empty entry

Imre Deak (1):
      drm/dp_mst: Fix DSC decompression detection in Synaptics branch devic=
es

Jan Kara (1):
      fsnotify: Avoid data race between fsnotify_recalc_mask() and
fsnotify_object_watched()

Jan Lalinsky (1):
      ALSA: usb-audio: Add native DSD support for Luxman D-08u

Jani Nikula (1):
      drm/i915/gem: fix bitwise and logical AND mixup

Jaroslav Kysela (3):
      ALSA: hda: fix trigger_tstamp_latched
      MAINTAINERS: ALSA: use linux-sound@vger.kernel.org list
      ALSA: core: add isascii() check to card ID generator

Jason A. Donenfeld (2):
      powerpc/vdso: allow r30 in vDSO code generation of getrandom
      selftests: vDSO: align getrandom states to cache line

Javier Carrasco (2):
      selftests: core: add unshare_test to gitignore
      selftests: exec: update gitignore for load_address

Jens Axboe (1):
      io_uring/net: harden multishot termination case for recv

Jianbo Liu (1):
      net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice

Jiawei Ye (1):
      mac802154: Fix potential RCU dereference issue in mac802154_scan_work=
er

Jiawen Wu (1):
      net: pcs: xpcs: fix the wrong register that was written back

Jinjie Ruan (7):
      ieee802154: Fix build error
      net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
      net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
      Bluetooth: btmrvl: Use IRQF_NO_AUTOEN flag in request_irq()
      spi: spi-imx: Fix pm_runtime_set_suspended() with runtime pm enabled
      spi: spi-cadence: Fix pm_runtime_set_suspended() with runtime pm enab=
led
      spi: spi-cadence: Fix missing spi_controller_is_target() check

Jithu Joseph (1):
      MAINTAINERS: Update Intel In Field Scan(IFS) entry

Johannes Thumshirn (1):
      btrfs: also add stripe entries for NOCOW writes

Johannes Weiner (1):
      sched: psi: fix bogus pressure spikes from aggregation race

Josef Bacik (1):
      btrfs: drop the backref cache during relocation if we commit

Joseph Jang (1):
      selftest: rtc: Check if could access /dev/rtc0 before testing

Jos=C3=A9 Roberto de Souza (1):
      drm/xe/oa: Don't reset OAC_CONTEXT_ENABLE on OA stream close

Julia Lawall (1):
      ALSA: Reorganize kerneldoc parameter names

Kees Cook (1):
      MAINTAINERS: Add unsafe_memcpy() to the FORTIFY review list

Keith Busch (1):
      block: fix blk_rq_map_integrity_sg kernel-doc

Kent Overstreet (18):
      bcachefs: Fix bad shift in bch2_read_flag_list()
      bcachefs: Fix return type of dirent_points_to_inode_nowarn()
      bcachefs: Fix bch2_inode_is_open() check
      bcachefs: Fix trans_commit disk accounting revert
      bcachefs: Add missing wakeup to bch2_inode_hash_remove()
      bcachefs: Fix reattach_inode()
      bcachefs: Create lost+found in correct snapshot
      bcachefs: bkey errors are only AUTOFIX during read
      bcachefs: Make sure we print error that causes fsck to bail out
      bcachefs: Mark more errors AUTOFIX
      bcachefs: minor lru fsck fixes
      bcachefs: Kill alloc_v4.fragmentation_lru
      bcachefs: Check for directories with no backpointers
      bcachefs: Check for unlinked inodes with dirents
      bcachefs: Check for unlinked, non-empty dirs in check_inode()
      bcachefs: Kill snapshot arg to fsck_write_inode()
      bcachefs: Add warn param to subvol_get_snapshot, peek_inode
      bcachefs: Rework logged op error handling

Lad Prabhakar (1):
      gpiolib: Fix potential NULL pointer dereference in gpiod_get_label()

Leo Li (1):
      drm/amd/display: Enable idle workqueue for more IPS modes

Leo Martins (1):
      btrfs: disable rate limiting when debug enabled

Lianqin Hu (1):
      ALSA: usb-audio: Add delay quirk for VIVO USB-C HEADSET

Liao Chen (1):
      zonefs: add support for FS_IOC_GETFSSYSFSPATH

Linus Torvalds (1):
      Linux 6.12-rc2

Liviu Dudau (1):
      drm/panthor: Add FOP_UNSIGNED_OFFSET to fop_flags

Lizhi Xu (1):
      inotify: Fix possible deadlock in fsnotify_destroy_mark

Luis Henriques (SUSE) (2):
      ext4: use handle to mark fc as ineligible in __track_dentry_update()
      ext4: mark fc as ineligible using an handle in ext4_xattr_set()

Luiz Augusto von Dentz (3):
      Bluetooth: MGMT: Fix possible crash on mgmt_index_removed
      Bluetooth: L2CAP: Fix uaf in l2cap_connect
      Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

Lukas Bulwahn (1):
      xen: Fix config option reference in XEN_PRIVCMD definition

Marc Dionne (1):
      afs: Fix possible infinite loop with unresponsive servers

Marc Zyngier (2):
      KVM: arm64: Another reviewer reshuffle
      KVM: arm64: Fix kvm_has_feat*() handling of negative features

Marek Vasut (1):
      i2c: stm32f7: Do not prepare/unprepare clock during runtime suspend/r=
esume

Mark Brown (2):
      KVM: arm64: Constrain the host to the maximum shared SVE VL with pKVM
      KVM: selftests: Fix build on architectures other than x86_64

Mark Rutland (4):
      arm64: Force position-independent veneers
      arm64: cputype: Add Neoverse-N3 definitions
      arm64: errata: Expand speculative SSBS workaround once more
      arm64: fix selection of HAVE_DYNAMIC_FTRACE_WITH_ARGS

Masahiro Yamada (5):
      kbuild: move non-boot built-in DTBs to .rodata section
      kconfig: fix infinite loop in sym_calc_choice()
      kconfig: clear expr::val_is_valid when allocated
      kconfig: qconf: move conf_read() before drawing tree pain
      kconfig: qconf: fix buffer overflow in debug links

Matthew Auld (4):
      drm/xe/guc_submit: add missing locking in wedged_fini
      drm/xe: fix UAF around queue destruction
      drm/xe/vm: move xa_alloc to prevent UAF
      drm/xe/queue: move xa_alloc to prevent UAF

Matthew Brost (5):
      drm/xe: Convert to USM lock to rwsem
      drm/xe: Use helper for ASID -> VM in GPU faults and access counters
      drm/xe: Resume TDR after GT reset
      drm/xe: Clean up VM / exec queue file lock usage.
      drm/xe: Fix memory leak when aborting binds

Miguel Ojeda (3):
      rust: kernel: sort Rust modules
      rust: cfi: fix `patchable-function-entry` starting version
      rust: kunit: use C-string literals to clean warning

Mikulas Patocka (2):
      Revert: "dm-verity: restart or panic on an I/O error"
      dm-verity: introduce the options restart_on_error and panic_on_error

Min-Hua Chen (1):
      io_uring: fix casts to io_req_flags_t

Miquel Raynal (1):
      ASoC: dt-bindings: davinci-mcasp: Fix interrupts property

Miquel Sabat=C3=A9 Sol=C3=A0 (1):
      cpufreq: Avoid a bad reference count on CPU node

Mohamed Khalfella (1):
      net/mlx5: Added cond_resched() to crdump collection

Nathan Chancellor (2):
      hardening: Adjust dependencies in selection of MODVERSIONS
      MAINTAINERS: Add security/Kconfig.hardening to hardening section

Nikolai Afanasenkov (1):
      ALSA: hda/realtek: fix mute/micmute LED for HP mt645 G8

Nilay Shroff (1):
      mm, slab: fix use of SLAB_SUPPORTS_SYSFS in kmem_cache_release()

Nuno Sa (2):
      Input: adp5589-keys - fix NULL pointer dereference
      Input: adp5589-keys - fix adp5589_gpio_get_value()

Oder Chiou (1):
      ALSA: hda/realtek: Fix the push button function for the ALC257

Oldherl Oh (1):
      ALSA: hda/conexant: fix some typos

Oleg Nesterov (1):
      uprobes: fix kernel info leak via "[uprobes]" vma

Omar Sandoval (1):
      iov_iter: fix advancing slot in iter_folioq_get_pages()

Pali Roh=C3=A1r (6):
      cifs: Check for UTF-16 null codepoint in SFU symlink target location
      smb: Update comments about some reparse point tags
      cifs: Remove intermediate object of failed create reparse call
      cifs: Fix buffer overflow when parsing NFS reparse points
      cifs: Validate content of NFS reparse point buffer
      cifs: Do not convert delimiter when parsing NFS-style symlinks

Paolo Bonzini (3):
      KVM: x86/mmu: fix KVM_X86_QUIRK_SLOT_ZAP_ALL for shadow MMU
      KVM: x86: leave kvm.ko out of the build if no vendor module is reques=
ted
      x86/reboot: emergency callbacks are now registered by common KVM code

Patrick Donnelly (1):
      ceph: fix cap ref leak via netfs init_request

Paul Moore (1):
      tomoyo: revert CONFIG_SECURITY_TOMOYO_LKM support

Phil Sutter (2):
      netfilter: uapi: NFTA_FLOWTABLE_HOOK is NLA_NESTED
      selftests: netfilter: Fix nft_audit.sh for newer nft binaries

Philipp Stanner (1):
      MAINTAINERS: drm/sched: Add new maintainers

Pu Lehui (1):
      drivers/perf: riscv: Align errno for unsupported perf event

Qu Wenruo (1):
      btrfs: fix a NULL pointer dereference when failed to start a new
trasacntion

Ravikanth Tuniki (1):
      dt-bindings: net: xlnx,axi-ethernet: Add missing reg minItems

Ricardo Rivera-Matos (1):
      ASoC: cs35l45: Corrects cs35l45_get_clk_freq_id function data type

Rob Clark (1):
      drm/sched: Fix dynamic job-flow control race

Rodrigo Vivi (1):
      drm/xe: Restore pci state upon resume

Roger Quadros (1):
      net: ethernet: ti: cpsw_ale: Fix warning on some platforms

Sami Tolvanen (2):
      x86/ftrace: Include <asm/ptrace.h>
      scripts: import more list macros

Sean Anderson (1):
      doc: net: napi: Update documentation for napi_schedule_irqoff

Shen Lichuan (1):
      smb: client: Correct typos in multiple comments across various files

Shengjiu Wang (1):
      ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit

Shenwei Wang (1):
      net: stmmac: dwmac4: extend timeout for VLAN Tag register busy bit ch=
eck

Shuah Khan (1):
      selftests:timers: posix_timers: Fix warn_unused_result in __fatal_err=
or()

Srinivas Pandruvada (2):
      platform/x86: ISST: Add Diamond Rapids to support list
      platform/x86/intel: power-domains: Add Diamond Rapids support

Steve French (1):
      Revert "smb: client: make SHA-512 TFM ephemeral"

Steven Price (1):
      drm/panthor: Fix race when converting group handle to group object

Steven Rostedt (1):
      tracing: Fix trace_check_vprintf() when tp_printk is used

Takashi Iwai (5):
      ALSA: hda/generic: Unconditionally prefer preferred_dacs pairs
      ALSA: hda/generic: Drop obsoleted obey_preferred_dacs flag
      Revert "ALSA: hda: Conditionally use snooping for AMD HDMI"
      ALSA: hda: Add missing parameter description for
snd_hdac_stream_timecounter_init()
      ALSA: hda/conexant: Fix conflicting quirk for System76 Pangolin

Tang Bin (1):
      ASoC: topology: Fix incorrect addressing assignments

Tejun Heo (16):
      sched_ext: Build fix for !CONFIG_SMP
      sched_ext: Add __COMPAT helpers for features added during v6.12
devel cycle
      tools/sched_ext: Receive misc updates from SCX repo
      scx_flatcg: Use a user DSQ for fallback instead of SCX_DSQ_GLOBAL
      sched_ext: Allow only user DSQs for scx_bpf_consume(),
scx_bpf_dsq_nr_queued() and bpf_iter_scx_dsq_new()
      sched_ext: Relocate find_user_dsq()
      sched_ext: Split the global DSQ per NUMA node
      sched_ext: Use shorter slice while bypassing
      sched_ext: Relocate check_hotplug_seq() call in scx_ops_enable()
      sched_ext: Remove SCX_OPS_PREPPING
      sched_ext: Initialize in bypass mode
      sched_ext: Fix SCX_TASK_INIT -> SCX_TASK_READY transitions in
scx_ops_enable()
      sched_ext: Enable scx_ops_init_task() separately
      sched_ext: Add scx_cgroup_enabled to gate cgroup operations and
fix scx_tg_online()
      sched_ext: Decouple locks in scx_ops_disable_workfn()
      sched_ext: Decouple locks in scx_ops_enable()

Thomas Zimmermann (2):
      drm: Consistently use struct drm_mode_rect for FB_DAMAGE_CLIPS
      firmware/sysfb: Disable sysfb for firmware buffers with unknown paren=
t

Thorsten Blum (5):
      afs: Remove unused struct and function prototype
      ksmbd: Use struct_size() to improve get_file_alternate_info()
      ksmbd: Annotate struct copychunk_ioctl_req with __counted_by_le()
      ksmbd: Use struct_size() to improve smb_direct_rdma_xmit()
      ceph: use struct_size() helper in __ceph_pool_perm_get()

Tom Chung (1):
      drm/amd/display: Fix system hang while resume with TBT monitor

Tvrtko Ursulin (3):
      drm/sched: Add locking to drm_sched_entity_modify_sched
      drm/sched: Always wake up correct scheduler in drm_sched_entity_push_=
job
      drm/sched: Always increment correct scheduler score

Uladzislau Rezki (Sony) (1):
      rcu/kvfree: Refactor kvfree_rcu_queue_batch()

Uwe Kleine-K=C3=B6nig (2):
      ALSA: Drop explicit initialization of struct
i2c_device_id::driver_data to 0
      cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock

Vignesh Raghavendra (1):
      gpio: davinci: Fix condition for irqchip registration

Vijendar Mukunda (1):
      ASoC: amd: acp: don't set card long_name

Vincent Donnefort (1):
      KVM: arm64: Fix __pkvm_init_vcpu cptr_el2 error path

Vladimir Oltean (1):
      net: dsa: improve shutdown sequence

Vlastimil Babka (2):
      mm, slab: suppress warnings in test_leak_destroy kunit test
      slub/kunit: skip test_kfree_rcu when the slub kunit test is built-in

Wei Li (4):
      tracing/timerlat: Fix duplicated kthread creation due to CPU
online/offline
      tracing/timerlat: Drop interface_lock in stop_kthread()
      tracing/timerlat: Fix a race during cpuhp processing
      tracing/hwlat: Fix a race during cpuhp processing

Willem de Bruijn (2):
      vrf: revert "vrf: Remove unnecessary RCU-bh critical section"
      gso: fix udp gso fraglist segmentation after pull from frag_list

Wolfram Sang (1):
      ASoC: dt-bindings: renesas,rsnd: correct reg-names for R-Car Gen1

Xin Long (1):
      sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_st=
art

Xu Yang (1):
      kbuild: fix a typo dt_binding_schema -> dt_binding_schemas

Yevgeny Kliteynik (3):
      net/mlx5: Fix wrong reserved field in hca_cap_2 in mlx5_ifc
      net/mlx5: HWS, fixed double-free in error flow of creating SQ
      net/mlx5: HWS, changed E2BIG error to a negative return code

Yifei Liu (1):
      selftests: breakpoints: use remaining time to check if suspend succee=
d

Yihan Zhu (1):
      drm/amd/display: update DML2 policy
EnhancedPrefetchScheduleAccelerationFinal DCN35

Yu Jiaoliang (1):
      ALSA: Fix typos in comments across various files

Yun Lu (1):
      selftest: hid: add missing run-hid-tools-tests.sh

Zach Wade (1):
      platform/x86: ISST: Fix the KASAN report slab-out-of-bounds bug

Zhang Qiao (1):
      sched_ext: Remove redundant p->nr_cpus_allowed checker

Zhanjun Dong (1):
      drm/xe: Prevent null pointer access in xe_migrate_copy

Zhao Mengmeng (3):
      udf: refactor udf_current_aext() to handle error
      udf: refactor udf_next_aext() to handle error
      udf: refactor inode_bmap() to handle error

wangrong (1):
      smb: client: use actual path when queryfs

zhang jiao (1):
      selftests: netfilter: Add missing return value

