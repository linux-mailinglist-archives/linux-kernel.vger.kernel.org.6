Return-Path: <linux-kernel+bounces-243741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4096C9299D9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EAA28158C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B236BFA3;
	Sun,  7 Jul 2024 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZlRqSDLY"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D60D8814
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720389238; cv=none; b=P9ws0fjgpczB+GBKQTvnPP3KZuOXAvbEhlOq+eZ63kKojEbkQOKpMiMyl5U6BYkpWivq3pb2XGG41U9Mv3XP7OT0NQS6nElEyf/g7nYHzWz5enBvPlijJFPkL+isIX8Q9fwzWsm1Ot7vy9TG8e67OgfvK8AziyEDt6LS+90c45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720389238; c=relaxed/simple;
	bh=S0RMjlmnIAyyPfA99PWZXhvLkkdJhTssrMgSO3idmT0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NHpChbBhjbxQ50tLT4aAnisfmVgTwTBL1Ko5nL7hW7bLvK6XPFWbV+qg6NbgAg9BYPMrszamAZArXnAJEW12vRI93TwpBERnIT2+ioCYxTPHMcLnPxrVfYJcSL3SOtgbHMSHbh3WTkvRpchacvsk51gjOJWFrxDYSC82c8rutXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZlRqSDLY; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77b60cafecso359961166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720389233; x=1720994033; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tru6JQoq17oa00pXPrrN1JxcyWmbJEy+AgrFmva9JP0=;
        b=ZlRqSDLYSZ4CpnYEusAIQ8hOd2nPfrImrmsaMCOES5bmZFK4PK2N0lAs+Bhk/xWfui
         iUtnYpJ9l3R/aNsYVUC1tYRT28avPoXVPiiRG4S5ZjDkdoZYm8uDk2D3NIxuacGuBFYZ
         YVCH981sHXwSBYRFmI/IwOlewbX63YxBihjHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720389233; x=1720994033;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tru6JQoq17oa00pXPrrN1JxcyWmbJEy+AgrFmva9JP0=;
        b=sSLc6QDHr/fCiu4+yRihu1EwrPJRCAuoCMYtQJAMeBRsbPAny7P93b/tK5tQyoXY0c
         L78hmc+awVjjS0Q0bFvKAZRK/tV66u4QoIvYgh86UDEZ9eH5GjH5U8bIPMEg8viLMw52
         blz/KhFT+AsynDvkv2mlLgknrfBlEmvw1Mt+9OUWv7JLQidI9sxMLgexiqM+4TlFDFnn
         m6HwceDtSGOmWMUvy7dqXOjloNqbvmO5L64/V/AucqX0CC/ATyvb8B405IGMiTgGN/Mt
         2N+/8BHXYGH/Mf8H/sj8w05u3jELVD5AT2W0DCX7kR3q7NO/JMKF/H1zs+3/UHxckXD2
         q5JA==
X-Gm-Message-State: AOJu0YxYARIXNX1MFxRd9cHeA7KmW1UVGUK6DBv24WOto7rjiYSlgTL9
	bhq4hV1CYGkaTMvuy1JZST7G5JHj5MJomiuUBeNrIR2bzCsLVKlhSFnzqkW9iqsKwgqjGjjAEiZ
	0ss7UIA==
X-Google-Smtp-Source: AGHT+IEDeCs5nclkdH1oIGq9G8PRrh9gHwBA/WDVzGAuK5uPEtPpucAGrQU4SE9Mx21LyPnvJmk29Q==
X-Received: by 2002:a17:907:3342:b0:a72:840d:9ef3 with SMTP id a640c23a62f3a-a77ba711881mr614533766b.48.1720389233309;
        Sun, 07 Jul 2024 14:53:53 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08cfc1sm870844866b.163.2024.07.07.14.53.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 14:53:52 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77b60cafecso359959266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 14:53:52 -0700 (PDT)
X-Received: by 2002:a17:907:9813:b0:a77:e0ed:8b9 with SMTP id
 a640c23a62f3a-a77e0ed09eamr377842766b.6.1720389231540; Sun, 07 Jul 2024
 14:53:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 14:53:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv_HoF-5Y5QuNqMfiumwMyNZt63ajO44uKce4dWOeU8Q@mail.gmail.com>
Message-ID: <CAHk-=wjv_HoF-5Y5QuNqMfiumwMyNZt63ajO44uKce4dWOeU8Q@mail.gmail.com>
Subject: Linux 6.10-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things remain calm, although I do suspect that part of it is that it's
been the July 4th week in the US, and a lot of Europe is starting to
go away on summer vacation.

But hey, let's not look a gift horse too closely in the mouth. Maybe
it's really just that 6.10 is shaping up well. Right? RIGHT?

                   Linus

---

Aleksandr Mishin (1):
      mlxsw: core_linecards: Fix double memory deallocation in case of
invalid INI file

Alex Bee (1):
      arm64: dts: rockchip: Add sound-dai-cells for RK3368

Alex Deucher (1):
      drm/amdgpu/atomfirmware: silence UBSAN warning

Alison Schofield (1):
      cxl/region: Avoid null pointer dereference in region lookup

Alvin Lee (1):
      drm/amd/display: Account for cursor prefetch BW in DML1 mode support

Andy Yan (1):
      arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi 4B

Anjali K (1):
      powerpc/pseries: Whitelist dtl slub object for copying to userspace

Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix quickstart quirk handling

Arnd Bergmann (1):
      syscalls: fix sys_fanotify_mark prototype

Atish Patra (1):
      drivers/perf: riscv: Do not update the event data if uptodate

Babu Moger (1):
      selftests/resctrl: Fix non-contiguous CBM for AMD

Bartosz Golaszewski (1):
      net: phy: aquantia: add missing include guards

Bjorn Helgaas (2):
      MAINTAINERS: Orphan Synopsys DesignWare xData traffic generator
      CREDITS: Add Synopsys DesignWare eDMA driver for Gustavo Pimentel

Boris Brezillon (2):
      drm/panthor: Don't check the array stride on empty uobj arrays
      drm/panthor: Fix sync-only jobs

Boris Burkov (2):
      btrfs: fix folio refcount in btrfs_do_encoded_write()
      btrfs: fix folio refcount in __alloc_dummy_extent_buffer()

Charlie Jenkins (2):
      documentation: Fix riscv cmodx example
      riscv: selftests: Fix vsetivli args for clang

Chen Ni (1):
      afs: Convert comma to semicolon

Chris Mi (1):
      net/mlx5: E-switch, Create ingress ACL when needed

Christian Borntraeger (1):
      KVM: s390: fix LPSWEY handling

Christian Brauner (2):
      fs: don't misleadingly warn during thaw operations
      fs: better handle deep ancestor chains in is_subdir()

Daniel Gabay (1):
      wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK

Daniel Jurgens (3):
      net/mlx5: IFC updates for changing max EQs
      net/mlx5: Use max_num_eqs_24b capability if set
      net/mlx5: Use max_num_eqs_24b when setting max_io_eqs

Dave Jiang (1):
      net: ntb_netdev: Move ntb_netdev_rx_handler() to call netif_rx()
from __netif_rx()

David Howells (6):
      netfs: Fix io_uring based write-through
      netfs: Fix early issue of write op on partial write to folio tail
      netfs: Delete some xarray-wangling functions that aren't used
      netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
      netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait
      cifs: Fix read-performance regression by dropping readahead expansion

Dima Ruinskiy (1):
      e1000e: Fix S0ix residency on corporate systems

Dmitry Antipov (1):
      mac802154: fix time calculation in ieee802154_configure_durations()

Dmitry Torokhov (2):
      gpiolib: of: fix lookup quirk for MIPS Lantiq
      gpiolib: of: add polarity quirk for TSC2005

Dragan Simic (1):
      arm64: dts: rockchip: Fix the DCDC_REG2 minimum voltage on
Quartz64 Model B

Edward Adam Davis (2):
      Bluetooth: Ignore too large handle values in BIG
      bluetooth/l2cap: sync sock recv cb and release

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't wake up rx_sync_waitq upon RFKILL

Enrico Bravi (1):
      ima: fix wrong zero-assignment during securityfs dentry remove

Eric Dumazet (1):
      wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values

Eric Farman (1):
      s390/vfio_ccw: Fix target addresses of TIC CCWs

FUKAUMI Naoki (3):
      Revert "arm64: dts: rockchip: remove redundant cd-gpios from
rk3588 sdmmc nodes"
      arm64: dts: rockchip: make poweroff(8) work on Radxa ROCK 5A
      arm64: dts: rockchip: fix PMIC interrupt pin on ROCK Pi E

Fangzhi Zuo (1):
      drm/amd/display: Update efficiency bandwidth for dcn351

Filipe Manana (1):
      btrfs: fix uninitialized return value in the ref-verify tool

Florian Westphal (1):
      netfilter: nf_tables: unconditionally flush pending work before notif=
ier

Frank Oltmanns (1):
      clk: sunxi-ng: common: Don't call hw_to_ccu_common on hw without comm=
on

Furong Xu (1):
      net: stmmac: enable HW-accelerated VLAN stripping for gmac4 only

Gabor Juhos (2):
      clk: qcom: clk-alpha-pll: set ALPHA_EN bit for Stromer Plus PLLs
      clk: qcom: apss-ipq-pll: remove 'config_ctl_hi_val' from Stromer
pll configs

Ganesh Goudar (1):
      powerpc/eeh: avoid possible crash when edev->pdev changes

Gao Xiang (1):
      erofs: ensure m_llen is reset to 0 if metadata is invalid

Geert Uytterhoeven (2):
      riscv: dts: canaan: Clean up serial aliases
      riscv: dts: canaan: Disable I/O devices unless used

Ghadi Elie Rahme (1):
      bnx2x: Fix multiple UBSAN array-index-out-of-bounds

Hao Ge (1):
      media: intel/ipu6: Fix a null pointer dereference in
ipu6_isys_query_stream_by_source

Hector Martin (1):
      Bluetooth: hci_bcm4377: Fix msgid release

Heiko Carstens (1):
      s390: Update defconfigs

Heiko Stuebner (1):
      arm64: dts: rockchip: set correct pwm0 pinctrl on rk3588-tiger

Hsin-Te Yuan (1):
      arm64: dts: rockchip: Fix the value of `dlg,jack-det-rate`
mismatch on rk3399-gru

Huang Xiaojia (1):
      erofs: convert to use super_set_uuid to support for FS_IOC_GETFSUUID

Imre Deak (1):
      drm/i915/display: For MTL+ platforms skip mg dp programming

Iulia Tanasescu (1):
      Bluetooth: ISO: Check socket flag instead of hcon

Jacob Keller (2):
      ice: Don't process extts if PTP is disabled
      ice: Reject pin requests with unsupported flags

Jakub Kicinski (1):
      tcp_metrics: validate source addr length

Jan Kara (3):
      fsnotify: Do not generate events for O_PATH file descriptors
      Revert "mm/writeback: fix possible divide-by-zero in
wb_dirty_limits(), again"
      mm: avoid overflows in dirty throttling logic

Jann Horn (1):
      filelock: Remove locks reliably when fcntl/close race is detected

Jarkko Sakkinen (3):
      tpm: Address !chip->auth in tpm2_*_auth_session()
      tpm: Address !chip->auth in tpm_buf_append_name()
      tpm: Address !chip->auth in tpm_buf_append_hmac_session*()

Jean Delvare (1):
      drivers/soc/litex: drop obsolete dependency on COMPILE_TEST

Jeff Johnson (1):
      reset: hisilicon: hi6220: add missing MODULE_DESCRIPTION() macro

Jens Axboe (1):
      io_uring/net: don't clear msg_inq before io_recv_buf_select() needs i=
t

Jianbo Liu (1):
      net/mlx5e: Add mqprio_rl cleanup and free in mlx5e_priv_cleanup()

Jiawen Wu (4):
      net: txgbe: initialize num_q_vectors for MSI/INTx interrupts
      net: txgbe: remove separate irq request for MSI and INTx
      net: txgbe: add extra handle for MSI/INTx into thread irq handle
      net: txgbe: free isb resources at the right time

Jimmy Assarsson (1):
      can: kvaser_usb: Explicitly initialize family in leafimx
driver_info struct

Jinglin Wen (1):
      powerpc/64s: Fix unnecessary copy to 0 when kernel is booted at addre=
ss 0

Jinliang Zheng (1):
      mm: optimize the redundant loop of mm_update_owner_next()

Jisheng Zhang (1):
      MAINTAINERS: thead: update Maintainer

Johan Jonker (1):
      ARM: dts: rockchip: rk3066a: add #sound-dai-cells to hdmi node

Johannes Berg (3):
      wifi: mac80211: disable softirqs for queued frame handling
      wifi: mac80211: fix BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
      wifi: iwlwifi: mvm: avoid link lookup in statistics

John Schoenick (1):
      drm: panel-orientation-quirks: Add quirk for Valve Galileo

Jonas Karlman (3):
      arm64: dts: rockchip: Fix rk3308 codec@ff560000 reset-names
      arm64: dts: rockchip: Fix SD NAND and eMMC init on rk3308-rock-pi-s
      arm64: dts: rockchip: Rename LED related pinctrl nodes on rk3308-rock=
-pi-s

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Kalle Valo (2):
      MAINTAINERS: Remembering Larry Finger
      MAINTAINERS: wifi: update ath.git location

Kuniyuki Iwashima (2):
      selftest: af_unix: Add test case for backtrack after finalising SCC.
      tcp: Don't flag tcp_sk(sk)->rx_opt.saw_unknown for TCP AO.

Leon Romanovsky (2):
      net/mlx5e: Present succeeded IPsec SA bytes and packet
      net/mlx5e: Approximate IPsec per-SA payload data bytes count

Li Ming (1):
      cxl/mem: Fix no cxl_nvd during pmem region auto-assembling

Linus Torvalds (1):
      Linux 6.10-rc7

Luca Weiss (1):
      clk: qcom: gcc-sm6350: Fix gpll6* & gpll7 parents

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix setting of unicast qos interval
      Bluetooth: L2CAP: Fix deadlock

Ma Ke (1):
      drm/nouveau: fix null pointer dereference in nouveau_connector_get_mo=
des

Marek Vasut (1):
      net: phy: phy_device: Fix PHY LED blinking code comment

Mark Brown (1):
      reset: gpio: Fix missing gpiolib dependency for GPIO reset controller

Mark-PK Tsai (1):
      tee: optee: ffa: Fix missing-field-initializers warning

Matt Roper (1):
      drm/xe/mcr: Avoid clobbering DSS steering

Matthew Auld (1):
      drm/xe: fix error handling in xe_migrate_update_pgtables

Matthew Schwartz (1):
      drm: panel-orientation-quirks: Add labels for both Valve Steam
Deck revisions

Md Sadre Alam (1):
      clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag

Michael Ellerman (1):
      selftests/powerpc: Fix build with USERCFLAGS set

Micka=C3=ABl Sala=C3=BCn (1):
      selftests/harness: Fix tests timeout and race condition

Milena Olech (1):
      ice: Fix improper extts handling

Ming Lei (1):
      scsi: scsi_debug: Fix create target debugfs failure

Miquel Raynal (3):
      mtd: rawnand: Ensure ECC configuration is propagated to upper layers
      mtd: rawnand: Fix the nand_read_data_op() early check
      mtd: rawnand: Bypass a couple of sanity checks during NAND identifica=
tion

Miri Korenblit (1):
      wifi: iwlwifi: mvm: check vif for NULL/ERR_PTR before dereference

Naohiro Aota (2):
      btrfs: fix adding block group to a reclaim list and the unused
list during reclaim
      btrfs: zoned: fix calc_available_free_space() for zoned mode

Neal Cardwell (1):
      UPSTREAM: tcp: fix DSACK undo in fast recovery to call tcp_try_to_ope=
n()

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Enable Power Save feature on startup

NeilBrown (1):
      vfs: generate FS_CREATE before FS_OPEN when ->atomic_open used.

Nicholas Piggin (1):
      powerpc/pseries: Fix scv instruction crash with kexec

Pavan Chebbi (1):
      bnxt_en: Fix the resource check condition for RSS contexts

Pavel Skripkin (1):
      bluetooth/hci: disallow setting handle bigger than HCI_CONN_HANDLE_MA=
X

Petr Oros (1):
      ice: use proper macro for testing bit

Pierre-Eric Pelloux-Prayer (1):
      drm/radeon: check bo_va->bo is non-NULL before using it

Pin-yen Lin (1):
      clk: mediatek: mt8183: Only enable runtime PM on mt8183-mfgcfg

Piotr Wojtaszczyk (1):
      i2c: pnx: Fix potential deadlock warning from del_timer_sync() call i=
n isr

Puranjay Mohan (1):
      riscv: stacktrace: fix usage of ftrace_graph_ret_addr()

Qu Wenruo (1):
      btrfs: always do the basic checks for btrfs_qgroup_inherit structure

Radu Rendec (1):
      net: rswitch: Avoid use-after-free in rswitch_poll()

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dml2/FCLKChangeSupp=
ort

Russell King (Oracle) (1):
      wifi: wlcore: fix wlcore AP mode

Ryusuke Konishi (3):
      nilfs2: fix inode number range checks
      nilfs2: add missing check for inode numbers on directory entries
      nilfs2: fix incorrect inode allocation from reserved inodes

Sagi Grimberg (1):
      net: allow skb_datagram_iter to be called from any context

Sakari Ailus (2):
      media: ipu6: Use the ISYS auxdev device as the V4L2 device's device
      media: ivsc: Depend on IPU_BRIDGE or not IPU_BRIDGE

Sam Sun (1):
      bonding: Fix out-of-bounds read in bond_option_arp_ip_targets_set()

Samuel Holland (2):
      drivers/perf: riscv: Reset the counter to hpmevent mapping while
starting cpus
      perf: RISC-V: Check standard event availability

Sandeep Dhavale (1):
      erofs: fix possible memory leak in z_erofs_gbuf_exit()

Shengyu Qu (1):
      riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on
JH7110 boards

Shigeru Yoshida (2):
      af_unix: Fix uninit-value in __unix_walk_scc()
      inet_diag: Initialize pad field in struct inet_diag_req_v2

Shiji Yang (1):
      gpio: mmio: do not calculate bgpio_bits via "ngpios"

Song Shuai (1):
      riscv: kexec: Avoid deadlock in kexec crash path

Stefan Haberland (1):
      s390/dasd: Fix invalid dereferencing of indirect CCW data pointer

Steven Rostedt (Google) (1):
      tracing: Have memmapped ring buffer use ioctl of "R" range 0x20-2F

Sven Peter (1):
      Bluetooth: Add quirk to ignore reserved PHY bits in LE Extended Adv R=
eport

Tetsuo Handa (1):
      Bluetooth: hci_core: cancel all works upon hci_unregister_dev()

Thomas Hellstr=C3=B6m (1):
      drm/ttm: Always take the bo delayed cleanup path for imported bos

Thomas Huth (1):
      drm/fbdev-generic: Fix framebuffer on big endian devices

Thomas Zimmermann (1):
      firmware: sysfb: Fix reference count of sysfb parent device

Tom Chung (3):
      drm/amd/display: Reset freesync config before update new state
      drm/amd/display: Add refresh rate range check
      drm/amd/display: Fix refresh rate range for some panel

Val Packett (1):
      mtd: rawnand: rockchip: ensure NVDDR timings are rejected

Vijay Satija (1):
      Bluetooth: btintel_pcie: Fix REVERSE_INULL issue reported by coverity

Xingui Yang (1):
      scsi: libsas: Fix exp-attached device scan after probe failure
scanned in again after probe failed

Yao Xingtao (2):
      cxl/region: check interleave capability
      cxl: documentation: add missing files to cxl driver-api

Yijie Yang (1):
      net: stmmac: dwmac-qcom-ethqos: fix error array size

Yunshui Jiang (1):
      net: mac802154: Fix racy device stats updates by DEV_STATS_INC()
and DEV_STATS_ADD()

Zijian Zhang (2):
      selftests: fix OOM in msg_zerocopy selftest
      selftests: make order checking verbose in msg_zerocopy selftest

Zijun Hu (1):
      Bluetooth: qca: Fix BT enable failure again for QCA6390 after warm re=
boot

