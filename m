Return-Path: <linux-kernel+bounces-216471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB859909FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 22:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA15C1C213E7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 20:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7F60263;
	Sun, 16 Jun 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVjFjRFb"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D95381A1
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718571170; cv=none; b=rKOhpEXUQmym21PeT+uRVkq0IU9GzbWGzNRSbyJZUIzYB3HXzgsj5q2tH0ueF/BCCh7Fe+ZqveOHtvZe3rIXg0g9FZgDznR1vr5u9lneSScThCCdVLS6mb+knvKoiolU/W98dq32QkPQsSisSVtZwLTYm9PCs/d+u1tNLcidQBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718571170; c=relaxed/simple;
	bh=9n0wi8dlhk+X7OcAmwjFgnyS1Fap3aIVRmg3LjOW3cQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iG3lncGzFYkyVQHSA9/jO1n/jpByVRrMEnL3CcyNN+loKdx1pUnL7ZmpWh7DJHgLT5Bz7kEp10iz0RFKbjlf07979UAyh49QyoL0QEqMPtRAA/boNwJLDTMoI2VgECBLxvejXRr4p/9ZON49yQWDk3iGIQUbRL61M+tt1rPoCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TVjFjRFb; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so42460761fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718571166; x=1719175966; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a0sgr4+I2ylccyQcf4sH46E76WPGXC2fli3mZi6uYlE=;
        b=TVjFjRFb5+joLg397gWz55gsWbqVlDlkomwCQCjJM3SjnzjKpzBZJSdmVF2eTcsVs6
         788IZedGp2Dcor4IwQToRo0CfCE68zWVg5lVTJoCuZ86qqJSa1hcKggi0gppkAK6GjHa
         C/I5Ia+QHnwKxHEFwvYGRl09nU+NEQjFDNMtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718571166; x=1719175966;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0sgr4+I2ylccyQcf4sH46E76WPGXC2fli3mZi6uYlE=;
        b=T74JvZY3925/yaJYa/Ho1UpsF/owBz3eIoYTj13XtsjSN/ZBAAWwTcEf+hPhNQUjTI
         6uyGnNXtdxsFjFRdurhL9Jzeq4gw/rOHTw+1Byo5Z9B9bDRl08sXol6K9K86neXllKXz
         /3nQc+nKPin7OaJzHQIptLQGjYcFwWwgIyZYcicPoRy7HbbMPpy9aLoSOkxv1h0oXnFI
         jOpLXdoLugjqneH/ORhKFBMABmZGoQcwBurOs7AAgrZPgrMSHl9gUw5Ndy4nPsxjQ258
         WRpo0rYZnl/7JlW2WvhVpt1OKWd1DeJJWs5je6kkrTIA+MuD7Jns2zOmaDE8ROx6iRsW
         cJSg==
X-Gm-Message-State: AOJu0YxjA3kmWCLTjqFGH9tCef7+vudVIIgLAAjyAmc7rMS7Axlri7dY
	4mL8hc/JUVNJHVpnVWAB9PCq9BiRariz4rEaXwQC2+N31c6s94jke72uY5+JWKoshig4XVLoBfi
	oFNafAw==
X-Google-Smtp-Source: AGHT+IHJ0BvfZ0Voi71Cs7cRW3sHo0ZV2er6O2VKGPmK5KqPnkD7aAArUaySFyWmbcCCAsdq4NPcUQ==
X-Received: by 2002:a2e:9807:0:b0:2eb:d7f0:5edd with SMTP id 38308e7fff4ca-2ec0e5d15femr63777171fa.27.1718571165058;
        Sun, 16 Jun 2024 13:52:45 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c05f56sm12029731fa.42.2024.06.16.13.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 13:52:44 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so41950671fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 13:52:44 -0700 (PDT)
X-Received: by 2002:a2e:87da:0:b0:2ec:1dd1:b3ae with SMTP id
 38308e7fff4ca-2ec1dd1b5e3mr41058141fa.32.1718571163445; Sun, 16 Jun 2024
 13:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 16 Jun 2024 13:52:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkq+TvS9DiZBpuvZBGBjZeyxHwsLcPH-H5W5pUn42S+w@mail.gmail.com>
Message-ID: <CAHk-=wgkq+TvS9DiZBpuvZBGBjZeyxHwsLcPH-H5W5pUn42S+w@mail.gmail.com>
Subject: Linux 6.10-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apart from a rather unusual spike in the diffstat due to a parisc fix,
things look normal and pretty small.

The bulk is - as always - driver fixes, and it's spread out pretty
much everywhere. A fix to the vfio pci memory mapping code stands out
a bit, but also removes more lines than it adds. And some firewire
tracepoint updates also spike the diffstat.

Outside of drivers, we've got some more bcachefs fixes, and some
cachefiles fixes.

The rest is small random changes spread out.

Shortlog appended for people who want to see more of the details,

              Linus

---

Aapo Vienamo (1):
      thunderbolt: debugfs: Fix margin debugfs node creation condition

Adam Miotk (1):
      drm/bridge/panel: Fix runtime warning on panel bridge release

Adam Rizkalla (1):
      iio: pressure: bmp280: Fix BMP580 temperature reading

Alan Stern (1):
      USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

Aleksandr Mishin (2):
      liquidio: Adjust a NULL pointer handling path in lio_vf_rep_copy_pack=
et
      bnxt_en: Adjust logging of firmware messages in case of released
token in __hwrm_send()

Alex Williamson (3):
      vfio: Create vfio_fs_type with inode per device
      vfio/pci: Use unmap_mapping_range()
      vfio/pci: Insert full vma on mmap'd MMIO fault

Alexander Gordeev (2):
      s390/mm: Allow large pages only for aligned physical addresses
      s390/mm: Restore mapping of kernel image using large pages

Alexander Usyskin (1):
      mei: demote client disconnect warning on suspend to debug

Amit Sunil Dhamne (1):
      usb: typec: tcpm: fix use-after-free case in tcpm_register_source_cap=
s

Amjad Ouled-Ameur (1):
      drm/komeda: check for error-valued pointer

Andrey Konovalov (1):
      kcov, usb: disable interrupts in kcov_remote_start_usb_softirq

Andrzej Hajda (1):
      drm/xe: flush engine buffers before signalling user fence on all engi=
nes

Andy Shevchenko (4):
      serial: 8250_dw: Don't use struct dw8250_data outside of 8250_dw
      serial: 8250_dw: Revert "Move definitions to the shared header"
      net dsa: qca8k: fix usages of device_get_named_child_node()
      mailmap: Add my outdated addresses to the map file

Angelo Dureghello (1):
      dt-bindings: iio: dac: fix ad354xr output range

Anuj Gupta (1):
      block: unmap and free user mapped integrity via submitter

Ard Biesheuvel (1):
      ARM: 9405/1: ftrace: Don't assume stack frames are contiguous in memo=
ry

Arunpravin Paneer Selvam (1):
      drm/amdgpu: Fix the BO release clear memory warning

Baokun Li (11):
      cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
      cachefiles: remove requests from xarray during flushing requests
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_rea=
d()
      cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_rea=
d()
      cachefiles: add consistency check for copen/cread
      cachefiles: add spin_lock for cachefiles_ondemand_info
      cachefiles: never get a new anonymous fd if ondemand_id is valid
      cachefiles: defer exposing anon_fd until after copy_to_user() succeed=
s
      cachefiles: flush all requests after setting CACHEFILES_DEAD
      cachefiles: make on-demand read killable

Benjamin Segall (1):
      x86/boot: Don't add the EFI stub to targets, again

Breno Leitao (1):
      scsi: mpt3sas: Avoid test/set_bit() operating in non-allocated memory

Chen Hanxiao (1):
      SUNRPC: return proper error from gss_wrap_req_priv

Chengming Zhou (1):
      block: fix request.queuelist usage in flush

Christian Brauner (2):
      debugfs: continue to ignore unknown mount options
      netfs: fix kernel doc for nets_wait_for_outstanding_io()

Christoph Hellwig (1):
      nbd: Remove __force casts

Chunguang Xu (1):
      nvme: avoid double free special payload

Cs=C3=B3k=C3=A1s, Bence (1):
      net: sfp: Always call `sfp_sm_mod_remove()` on remove

Cyril Hrubis (1):
      loop: Disable fallocate() zero and discard if not supported

Damien Le Moal (4):
      scsi: core: Disable CDL by default
      scsi: mpi3mr: Fix ATA NCQ priority support
      block: Optimize disk zone resource cleanup
      ata: libata-scsi: Set the RMB bit only for removable media devices

Daniel Wagner (2):
      nvmet-passthru: propagate status from id override functions
      nvmet: always initialize cqe.result

David Lechner (1):
      iio: adc: ad9467: fix scan type sign

David Wei (1):
      netdevsim: fix backwards compatibility in nsim_get_iflink()

Davide Ornaghi (1):
      netfilter: nft_inner: validate mandatory meta and payload

Dimitri Sivanich (1):
      iommu/amd: Fix panic accessing amd_iommu_enable_faulting

Dirk Behme (1):
      drivers: core: synchronize really_probe() and dev_uevent()

Dmitry Mastykin (1):
      NFSv4: Fix memory leak in nfs4_set_security_label

Doug Brown (1):
      serial: 8250_pxa: Configure tx_loadsz to match FIFO IRQ level

Douglas Anderson (3):
      serial: port: Don't block system suspend even if bytes are left to xm=
it
      drm: renesas: shmobile: Call drm_atomic_helper_shutdown() at shutdown=
 time
      drm/mediatek: Call drm_atomic_helper_shutdown() at shutdown time

Dr. David Alan Gilbert (1):
      drm/nouveau: remove unused struct 'init_exec'

Dumitru Ceclan (5):
      iio: adc: ad7173: fix buffers enablement for ad7176-2
      iio: adc: ad7173: Add ad7173_device_info names
      iio: adc: ad7173: Remove index from temp channel
      iio: adc: ad7173: Clear append status bit
      iio: adc: ad7173: Fix sampling frequency setting

Eric Dumazet (2):
      tcp: fix race in tcp_v6_syn_recv_sock()
      tcp: use signed arithmetic in tcp_rtx_probe0_timed_out()

Florian Westphal (1):
      netfilter: Use flowlabel flow key when re-routing mangled packets

Gal Pressman (2):
      geneve: Fix incorrect inner network header offset when
innerprotoinherit is set
      net/mlx5e: Fix features validation check for tunneled UDP
(non-VXLAN) packets

Gao Xiang (1):
      cachefiles: remove unneeded include of <linux/fdtable.h>

Geliang Tang (1):
      mailmap: map Geliang's new email address

Greg Kroah-Hartman (3):
      driver core: remove devm_device_add_groups()
      jfs: xattr: fix buffer overflow for invalid xattr
      .editorconfig: remove trim_trailing_whitespace option

Hans de Goede (2):
      mei: vsc: Fix wrong invocation of ACPI SID method
      leds: class: Revert: "If no default trigger is given, make
hw_control trigger the default trigger"

Harshit Mogalapalli (1):
      iio: temperature: mlx90635: Fix ERR_PTR dereference in mlx90635_probe=
()

Hector Martin (1):
      xhci: Handle TD clearing for multiple streams case

Heikki Krogerus (1):
      usb: typec: ucsi: Ack also failed Get Error commands

Heiko Carstens (1):
      s390: Update defconfigs

Hongbo Li (1):
      bcachefs: fix the display format for show-super

Hugo Villeneuve (2):
      serial: sc16is7xx: rename Kconfig CONFIG_SERIAL_SC16IS7XX_CORE
      serial: sc16is7xx: re-add Kconfig SPI or I2C dependency

Ilpo J=C3=A4rvinen (1):
      tty: n_tty: Fix buffer offsets when lookahead is used

Jan Beulich (2):
      memblock: make memblock_set_node() also warn about use of MAX_NUMNODE=
S
      x86/mm/numa: Use NUMA_NO_NODE when calling memblock_set_node()

Jan Kara (1):
      nfs: Avoid flushing many pages with NFS_FILE_SYNC

Jani Nikula (2):
      drm: have config DRM_WERROR depend on !WERROR
      drm/exynos/vidi: fix memory leak in .get_modes()

Jean Delvare (2):
      i2c: at91: Fix the functionality flags of the slave-only interface
      i2c: designware: Fix the functionality flags of the slave-only interf=
ace

Jean-Baptiste Maneyrol (4):
      iio: invensense: fix odr switching to same value
      iio: imu: inv_icm42600: stabilized timestamp in interrupt
      iio: imu: inv_icm42600: delete unneeded update watermark call
      iio: imu: inv_mpu6050: stabilized timestamping in interrupt

Jie Wang (1):
      net: hns3: add cond_resched() to hns3 ring buffer init process

Johan Hovold (2):
      iio: inkern: fix channel read regression
      usb: typec: ucsi: glink: increase max ports for x1e80100

Johannes Berg (1):
      net/sched: initialize noop_qdisc owner

John David Anglin (1):
      parisc: Try to fix random segmentation faults in package builds

John Ernberg (1):
      USB: xen-hcd: Traverse host/ when CONFIG_USB_XEN_HCD is selected

John Garry (1):
      statx: Update offset commentary for struct statx

Joshua Washington (1):
      gve: ignore nonrelevant GSO type bits when processing TSO headers

Jozsef Kadlecsik (1):
      netfilter: ipset: Fix race between namespace cleanup and gc in
the list:set type

Kees Cook (1):
      x86/uaccess: Fix missed zeroing of ia32 u64 get_user() range checking

Keith Busch (1):
      nvme: fix namespace removal list

Kent Overstreet (16):
      bcachefs: Split out btree_write_submit_wq
      bcachefs: Fix incorrect error handling found_btree_node_is_readable()
      bcachefs: Delete incorrect BTREE_ID_NR assertion
      bcachefs: fix stack frame size in fsck.c
      bcachefs: Enable automatic shrinking for rhashtables
      bcachefs: increase key cache shrinker batch size
      bcachefs: set sb->s_shrinker->seeks =3D 0
      bcachefs: Fix reporting of freed objects from key cache shrinker
      bcachefs: Leave a buffer in the btree key cache to avoid lock thrashi=
ng
      bcachefs: Fix refcount leak in check_fix_ptrs()
      bcachefs: Fix snapshot_create_lock lock ordering
      bcachefs: Replace bucket_valid() asserts in bucket lookup with
proper checks
      bcachefs: Check for invalid bucket from bucket_gen(), gc_bucket()
      bcachefs: Add missing synchronize_srcu_expedited() call when shutting=
 down
      bcachefs: Add missing bch_inode_info.ei_flags init
      bcachefs: Fix rcu_read_lock() leak in drop_extra_replicas

Kory Maincent (1):
      net: pse-pd: Use EOPNOTSUPP error code instead of ENOTSUPP

Krzysztof Kozlowski (1):
      drm/exynos: dp: drop driver owner initialization

Kuangyi Chiang (2):
      xhci: Apply reset resume quirk to Etron EJ188 xHCI host
      xhci: Apply broken streams quirk to Etron EJ188 xHCI host

Kyle Tso (1):
      usb: typec: tcpm: Ignore received Hard Reset in TOGGLING state

Linus Torvalds (1):
      Linux 6.10-rc4

Luiz Augusto von Dentz (2):
      Bluetooth: hci_sync: Fix not using correct handle
      Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ

Lukas Wunner (1):
      sysfs: Unbreak the build around sysfs_bin_attr_simple_read()

Marc Ferland (1):
      iio: dac: ad5592r: fix temperature channel scaling value

Marek Szyprowski (1):
      drm/exynos: hdmi: report safe 640x480 mode as a fallback when no
EDID found

Mario Limonciello (1):
      ACPI: x86: Force StorageD3Enable on more products

Martin K. Petersen (1):
      scsi: sd: Use READ(16) when reading block zero on large capacity disk=
s

Mathias Nyman (1):
      xhci: Set correct transferred length for cancelled bulk transfers

Michael Chan (1):
      bnxt_en: Cap the size of HWRM_PORT_PHY_QCFG forwarded response

Michal Wajdeczko (1):
      drm/xe/pf: Assert LMEM provisioning is done only on DGFX

Namjae Jeon (2):
      ksmbd: move leading slash check to smb2_get_name()
      ksmbd: fix missing use of get_write in in smb2_set_ea()

NeilBrown (2):
      NFS: abort nfs_atomic_open_v23 if name is too long.
      NFS: add barriers when testing for NFS_FSDATA_BLOCKED

Nikolay Aleksandrov (2):
      net: bridge: mst: pass vlan group directly to br_mst_vlan_set_state
      net: bridge: mst: fix suspicious rcu usage in br_mst_set_state

Oded Gabbay (1):
      MAINTAINERS: update Xe driver maintainers

Oleg Nesterov (1):
      tick/nohz_full: Don't abuse smp_call_function_single() in
tick_setup_device()

Olga Kornievskaia (1):
      NFSv4.1 enforce rootpath check in fs_location query

Paolo Abeni (1):
      mptcp: ensure snd_una is properly initialized on connect

Pauli Virtanen (1):
      Bluetooth: fix connection setup in l2cap_connect

Pavel Begunkov (2):
      io_uring/rsrc: don't lock while !TASK_RUNNING
      io_uring: fix cancellation overwriting req->flags

Peter Chen (1):
      Revert "usb: chipidea: move ci_ulpi_init after the phy initialization=
"

Petr Pavlu (1):
      net/ipv6: Fix the RT cache flush via sysctl using a previous delay

Rafael J. Wysocki (5):
      thermal: core: Do not fail cdev registration because of invalid
initial state
      thermal: ACPI: Invalidate trip points with temperature of 0 or below
      thermal: gov_step_wise: Restore passive polling management
      cpufreq: intel_pstate: Check turbo_is_disabled() in store_no_turbo()
      ACPI: EC: Evaluate orphan _REG under EC device

Rao Shoaib (1):
      af_unix: Read with MSG_PEEK loops if the first unread byte is OOB

Riana Tauro (2):
      drm/xe/xe_gt_idle: use GT forcewake domain assertion
      drm/xe: move disable_c6 call

Ritesh Harjani (IBM) (1):
      iomap: Fix iomap_adjust_read_range for plen calculation

Rob Herring (Arm) (1):
      dt-bindings: usb: realtek,rts5411: Add missing
"additionalProperties" on child nodes

Russell King (Oracle) (1):
      clkdev: don't fail clkdev_alloc() if over-sized

Sagar Cheluvegowda (1):
      net: stmmac: dwmac-qcom-ethqos: Configure host DMA width

Sagi Grimberg (1):
      nfs: propagate readlink errors in nfs_symlink_filler

Sasha Neftin (1):
      Revert "igc: fix a log entry using uninitialized netdev"

Scott Mayhew (1):
      nfs: don't invalidate dentries on transient errors

Shichao Lai (1):
      usb-storage: alauda: Check whether the media is initialized

Stefan Wahren (1):
      staging: vchiq_debugfs: Fix NPD in vchiq_dump_state

Su Hui (1):
      block: sed-opal: avoid possible wrong address reference in
read_sed_opal_key()

Taehee Yoo (1):
      ionic: fix use after netif_napi_del()

Takashi Sakamoto (9):
      firewire: fix website URL in Kconfig
      firewire: core: record card index in tracepoinrts events derived
from async_outbound_complete_template
      firewire: core: record card index in tracepoinrts events derived
from async_outbound_initiate_template
      firewire: core: record card index in tracepoinrts events derived
from async_inbound_template
      firewire: core: record card index in async_phy_outbound_initiate
tracepoints event
      firewire: core: record card index in async_phy_outbound_complete
tracepoints event
      firewire: core: record card index in async_phy_inbound tracepoints ev=
ent
      firewire: core: record card index in tracepoinrts events derived
from bus_reset_arrange_template
      firewire: core: record card index in bus_reset_handle tracepoints eve=
nt

Tetsuo Handa (1):
      serial: drop debugging WARN_ON_ONCE() from uart_write()

Thomas Hellstr=C3=B6m (1):
      MAINTAINERS: Update Xe driver maintainers

Tobias Jakobi (1):
      drm: panel-orientation-quirks: Add quirk for Aya Neo KUN

Tomas Winkler (1):
      mei: me: release irq in mei_me_pci_resume error path

Trond Myklebust (1):
      MAINTAINERS: Change email address for Trond Myklebust

Udit Kumar (1):
      dt-bindings: net: dp8386x: Add MIT license along with GPL-2.0

Uwe Kleine-K=C3=B6nig (1):
      parport: amiga: Mark driver struct with __refdata to prevent
section mismatch

Vasileios Amoiridis (1):
      iio: imu: bmi323: Fix trigger notification in case of error

Vasily Khoruzhick (1):
      drm/nouveau: don't attempt to schedule hpd_work on headless cards

Wengang Wang (1):
      xfs: make sure sb_fdblocks is non-negative

Wentong Wu (1):
      mei: vsc: Don't stop/restart mei device during system suspend/resume

Xiaolei Wang (1):
      net: stmmac: replace priv->speed with the portTransmitRate from
the tc-cbs parameters

Yazen Ghannam (2):
      RAS/AMD/ATL: Fix MI300 bank hash
      RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized
address translation

Yonglong Liu (1):
      net: hns3: fix kernel crash problem in concurrent scenario

YonglongLi (2):
      mptcp: pm: inc RmAddr MIB counter once per RM_ADDR ID
      mptcp: pm: update add_addr counters after connect

Yongzhi Liu (2):
      misc: microchip: pci1xxxx: fix double free in the error handling
of gp_aux_bus_probe()
      misc: microchip: pci1xxxx: Fix a memory leak in the error
handling of gp_aux_bus_probe()

Yuntao Wang (1):
      fs/file: fix the check in find_next_fd()

Zhang Yi (1):
      iomap: keep on increasing i_size in iomap_write_end()

Ziqi Chen (1):
      scsi: ufs: core: Quiesce request queues before checking pending cmds

Ziwei Xiao (1):
      gve: Clear napi->skb before dev_kfree_skb_any()

Zizhi Wo (1):
      cachefiles: Set object to close if ondemand_id < 0 in copen

pengfuyuan (1):
      arm/komeda: Remove all CONFIG_DEBUG_FS conditional compilations

