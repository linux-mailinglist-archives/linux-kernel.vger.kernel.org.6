Return-Path: <linux-kernel+bounces-310146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFDF967580
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D585282877
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F313B143736;
	Sun,  1 Sep 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d5B0169H"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50271136643
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 08:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725177777; cv=none; b=qLyuqUwiyL1MXCWHe3D/+Xa0Wm1ucMzd3/2bYLgJQDEyPc4vpELkusvxKiu/V6nFhZM9PvjlVT0ns0fXstAcqJp0b4ByPZUCpQAM0ZHTB9u5m+VPGUuTeyo1P+bQoFn1JyJX4CtJ0voUiNoLklCyuIIVseIoFEubxj3w7W5pCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725177777; c=relaxed/simple;
	bh=rIUVZH1TkNG7I8/R4FJtOxvjZlPXjwAlo1hrKrQXP48=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=smh2t9E/ue0qJvH8lsq6QFciled5Y0f0WMw6XpMVL/KPQcVdXZc9WkerH8oELMoWIqJmyqaFtFvZASmZPMH+hLvr5/R6vHUPm7B3Ljlzae6ispN+Zo0r3OKbm5GhdMzvUVLpdUUSn9oZsUm1Ll3dd72ZhuFdfe1xubzxtKYqdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=d5B0169H; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a868b739cd9so375036066b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725177772; x=1725782572; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9u56EFtqZoT1aFDLMLHEbgABMZFjjbxRpLCnr7ixtjQ=;
        b=d5B0169HYP8JpFW/jZnqx0RzadEmiB/LMEeu2520VcJE190ArS9X3J3noOtqQbnE6E
         eBWs8pvYBuawIaoC7rG4bEF/I+4mOe0bHP0oWRltHiAjWRD05jXIgEQ/jpa3zJs2M2q6
         0+rTxnp5JZnhS3LhAxokEou5V0+/IBn+YCBM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725177772; x=1725782572;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9u56EFtqZoT1aFDLMLHEbgABMZFjjbxRpLCnr7ixtjQ=;
        b=enHWsMb403uMjx1jlR84EnfiHLFaCxQDKAaTKOj8lhUt4EhMwcbXWCyxv30eeeprOC
         uf3yEBvot1zwVc/p9NOEv4cJU1WftON1PKGkyICdbEL24ucI+dO7SzXzWST6CIm+yM9L
         HbuK8/Xahiu21TaD4jtzwnsW5wrPLy0fvAhm7ZbILfZjhdGwI0XHkZCKroXdsiaUTPUU
         EMKVXhj6sZIZKBeXjcoCUwTcPxHpnB+w5GjnuYpntudVj774lSMPDL23wmJBzAzUNHrl
         OZlcX3kH94scW/lrquhMsiT2xTG9gzVnYUPHbTljy285p8prDWIg7Kj8zbscMozFCOan
         AOtw==
X-Gm-Message-State: AOJu0YzyaIxq3cxjJe0kRicyEXSOKnwLOSd58SJ2TXbKOMvlKU99Alce
	uvVGjURzsl0cGqY/fX2VkZxqZA/EnshhPJuwudzVb+F9hO4jiWaKuTAAgN0fHd4sf+HpjGoDY4e
	2+gRfog==
X-Google-Smtp-Source: AGHT+IHzNFOano/h1fQVDkhQSxDjEu/AQ5xLrXAvQXAmFyphgxHxYiUmA+L2jE2HJm7JbhmBdYChAA==
X-Received: by 2002:a17:907:7e94:b0:a7a:a3f7:389e with SMTP id a640c23a62f3a-a897f78daccmr892041966b.6.1725177771556;
        Sun, 01 Sep 2024 01:02:51 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196968sm408764266b.139.2024.09.01.01.02.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2024 01:02:50 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso3392477a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 01:02:50 -0700 (PDT)
X-Received: by 2002:a05:6402:320f:b0:5c2:3f0a:944a with SMTP id
 4fb4d7f45d1cf-5c23f0a9518mr4123845a12.18.1725177769491; Sun, 01 Sep 2024
 01:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Sep 2024 20:02:32 +1200
X-Gmail-Original-Message-ID: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>
Message-ID: <CAHk-=wgumCUwjVkGREh1WwZ2ia5EqSjAQ_4wjUDw3-m0aT7KFA@mail.gmail.com>
Subject: Linux 6.11-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm still in an unusual timezone, but next week everything should be
back to normal.

Anyway, it's definitely well past Sunday afternoon here, and thus time
for the weekly rc release.

Things look pretty normal, although we have perhaps unusually many
filesystem fixes here, spread out over smb, xfs, bcachefs and netfs.
That said, driver fixes obviously still dominate the diffstat - "more
than perhaps usual" still doesn't make the filesystem changes _that_
big. I suspect they stand out more mainly because the rest is fairly
small.

Outside of drivers (all the usual suspects) and filesystems, we have
various architecture fixes (although honestly, that's mostly arm64 dts
files), some core networking, and some selftest updates related to
that.

Nothing particularly odd stands out, please do keep testing,

              Linus

---

Abel Vesa (1):
      phy: qcom: qmp-pcie: Fix X1E80100 PCIe Gen4 PHY initialisation

Adam Ford (1):
      arm64: dts: imx8mp-beacon-kit: Fix Stereo Audio on WM8962

Albert Jakie=C5=82a (1):
      ASoC: SOF: mediatek: Add missing board compatible

Aleksandr Mishin (1):
      nfc: pn533: Add poll mod list filling check

Alex Deucher (6):
      Revert "drm/ttm: increase ttm pre-fault value to PMD size"
      video/aperture: optionally match the device in sysfb_disable()
      drm/amdgpu: align pp_power_profile_mode with kernel docs
      drm/amdgpu/smu13.0.7: print index for profiles
      drm/amdgpu/swsmu: always force a state reprogram on init
      drm/amdgpu/gfx12: set UNORD_DISPATCH in compute MQDs

Alexander Stein (1):
      dt-bindings: usb: microchip,usb2514: Fix reference USB device schema

Alexander Sverdlin (1):
      wifi: wfx: repair open network AP mode

Andrei Simion (1):
      MAINTAINERS: Update DTS path for ARM/Microchip (AT91) SoC

Andrew Halaney (1):
      soc: qcom: pd-mapper: Depend on ARCH_QCOM || COMPILE_TEST

Anjaneyulu (1):
      wifi: iwlwifi: fw: fix wgds rev 3 exact size

Arnd Bergmann (1):
      soc: qcom: pd-mapper: mark qcom_pdm_domains as __maybe_unused

Avraham Stern (1):
      wifi: iwlwifi: mvm: allow 6 GHz channels in MLO scan

Bartosz Golaszewski (3):
      firmware: qcom: tzmem: fix virtual-to-physical address conversion
      firmware: qcom: qseecom: remove unused functions
      power: sequencing: qcom-wcn: set the wlan-enable GPIO to output

Ben Hutchings (1):
      scsi: aacraid: Fix double-free on probe failure

Benjamin Berg (1):
      wifi: iwlwifi: lower message level for FW buffer destination

Bibo Mao (1):
      LoongArch: KVM: Invalidate guest steal time address on vCPU reset

Bjorn Andersson (4):
      soc: qcom: pmic_glink: Fix race during initialization
      usb: typec: ucsi: Move unregister out of atomic section
      soc: qcom: pmic_glink: Actually communicate when remote goes down
      soc: qcom: pd-mapper: Fix singleton refcount

Brett Creeley (1):
      ionic: Prevent tx_timeout due to frequent doorbell ringing

Candice Li (1):
      drm/amd/pm: Drop unsupported features on smu v14_0_2

Christian Brauner (3):
      romfs: fix romfs_read_folio()
      Revert "pidfd: prevent creation of pidfds for kthreads"
      ovl: pass string to ovl_parse_layer()

Chuck Lever (1):
      MAINTAINERS: Update Olga Kornievskaia's email address

Cong Wang (1):
      gtp: fix a potential NULL pointer dereference

Cosmo Chou (1):
      hwmon: (pt5161l) Fix invalid temperature reading

Dan Carpenter (2):
      phy: exynos5-usbdrd: fix error code in probe()
      cpufreq: amd-pstate: Fix uninitialized variable in
amd_pstate_cpu_boost_update()

Daniel Gabay (3):
      wifi: mac80211: fix beacon SSID mismatch handling
      wifi: iwlwifi: mvm: fix iwl_mvm_scan_fits() calculation
      wifi: iwlwifi: mvm: fix iwl_mvm_max_scan_ie_fw_cmd_room()

Darrick J. Wong (7):
      xfs: fix di_onlink checking for V1/V2 inodes
      xfs: fix folio dirtying for XFILE_ALLOC callers
      xfs: don't bother reporting blocks trimmed via FITRIM
      xfs: use XFS_BUF_DADDR_NULL for daddrs in getfsmap code
      xfs: take m_growlock when running growfsrt
      xfs: reset rootdir extent size hint after growfsrt
      block: fix detection of unsupported WRITE SAME in
blkdev_issue_write_zeroes

Dave Chinner (1):
      xfs: xfs_finobt_count_blocks() walks the wrong btree

David Howells (12):
      netfs, ceph: Partially revert "netfs: Replace PG_fscache by
setting folio->private and marking dirty"
      mm: Fix missing folio invalidation calls during truncation
      afs: Fix post-setattr file edit to do truncation correctly
      netfs: Fix netfs_release_folio() to say no if folio dirty
      netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
      netfs: Fix missing iterator reset on retry of short read
      netfs: Fix interaction of streaming writes with zero-point tracker
      cifs: Fix FALLOC_FL_PUNCH_HOLE support
      cifs: Fix lack of credit renegotiation on read retry
      netfs, cifs: Fix handling of short DIO read
      cifs: Fix copy offload to flush destination region
      cifs: Fix FALLOC_FL_ZERO_RANGE to preflush buffered part of target re=
gion

David Sterba (1):
      btrfs: initialize last_extent_end to fix -Wmaybe-uninitialized
warning in extent_fiemap()

Dmitry Antipov (1):
      wifi: mac80211: free skb on error path in ieee80211_beacon_get_ap()

Dmitry Baryshkov (3):
      ASoC: codecs: lpass-macro: fix version strings returned for 1.x codec=
s
      ASoC: codecs: lpass-va-macro: warn on unknown version
      arm64: dts: qcom: disable GPU on x1e80100 by default

Dmitry Torokhov (1):
      Input: cypress_ps2 - fix waiting for command response

Ed Tsai (1):
      backing-file: convert to using fops->splice_write

Emmanuel Grumbach (5):
      wifi: iwlwifi: mvm: fix hibernation
      wifi: iwlwifi: mvm: take the mutex before running link selection
      wifi: iwlwifi: mvm: pause TCM when the firmware is stopped
      wifi: iwlwifi: mvm: don't wait for tx queues if firmware is dead
      wifi: iwlwifi: clear trans->state earlier upon error

Eric Dumazet (3):
      pktgen: use cpus_read_lock() in pg_net_init()
      net_sched: sch_fq: fix incorrect behavior for small weights
      net: busy-poll: use ktime_get_ns() instead of local_clock()

Filipe Manana (1):
      btrfs: fix uninitialized return value from btrfs_reclaim_sweep()

Frank Li (2):
      arm64: dts: imx8mm-phygate: fix typo pinctrcl-0
      MAINTAINERS: PCI: Add NXP PCI controller mailing list imx@lists.linux=
.dev

Gautham R. Shenoy (1):
      cpufreq/amd-pstate: Use topology_logical_package_id() instead of
logical_die_id()

Guenter Roeck (2):
      Revert "MIPS: csrc-r4k: Apply verification clocksource flags"
      apparmor: fix policy_unpack_test on big endian systems

Haiyang Zhang (1):
      net: mana: Fix race of mana_hwc_post_rx_wqe and new hwc response

Hal Feng (1):
      pinctrl: starfive: jh7110: Correct the level trigger
configuration of iev register

Hans de Goede (2):
      platform/x86: x86-android-tablets: Make Lenovo Yoga Tab 3 X90F
DMI match less strict
      drm/i915/dsi: Make Lenovo Yoga Tab 3 X90F DMI match less strict

Hendrik Borghorst (1):
      ALSA: hda/realtek: support HP Pavilion Aero 13-bg0xxx Mute LED

Hongbo Li (2):
      ASoC: allow module autoloading for table db1200_pids
      ASoC: allow module autoloading for table board_ids

Huacai Chen (1):
      LoongArch: Define ARCH_IRQ_INIT_FLAGS as IRQ_NOPROBE

Huang-Huang Bao (1):
      pinctrl: rockchip: correct RK3328 iomux width flag for GPIO2-B pins

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Imre Deak (1):
      drm/i915/dp_mst: Fix MST state after a sink reset

Jacky Chou (1):
      net: ftgmac100: Ensure tx descriptor updates are visible

Jamie Bainbridge (1):
      ethtool: check device is present when getting link settings

Jason Gunthorpe (2):
      iommufd: Do not allow creating areas without READ or WRITE
      iommu: Do not return 0 from map_pages if it doesn't do anything

Jeff Layton (4):
      nfsd: ensure that nfsd4_fattr_args.context is zeroed out
      nfsd: hold reference to delegation when updating it for cb_getattr
      nfsd: fix potential UAF in nfsd4_cb_getattr_release
      fs/nfsd: fix update of inode attrs in CB_GETATTR

Jens Axboe (2):
      io_uring/rsrc: ensure compat iovecs are copied correctly
      io_uring/kbuf: return correct iovec count from classic buffer peek

Jianbo Liu (3):
      bonding: implement xdo_dev_state_free and call it after deletion
      bonding: extract the use of real_device into local variable
      bonding: change ipsec_lock from spin lock to mutex

Johan Hovold (18):
      arm64: dts: qcom: x1e80100-crd: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100: fix PCIe domain numbers
      arm64: dts: qcom: x1e80100: add missing PCIe minimum OPP
      arm64: dts: qcom: x1e80100-crd: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-crd: disable PCIe6a perst pull down
      arm64: dts: qcom: x1e80100-crd: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-qcp: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-qcp: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-qcp: disable PCIe6a perst pull down
      arm64: dts: qcom: x1e80100-qcp: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-vivobook-s15: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-vivobook-s15: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-vivobook-s15: disable PCIe6a perst pull do=
wn
      arm64: dts: qcom: x1e80100-vivobook-s15: fix missing PCIe4 gpios
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix PCIe4 PHY supply
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix up PCIe6a pinctrl node
      arm64: dts: qcom: x1e80100-yoga-slim7x: disable PCIe6a perst pull dow=
n
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix missing PCIe4 gpios

Johannes Berg (1):
      net: drop special comment style

John Harrison (1):
      drm/i915: ARL requires a newer GSC firmware

John Sweeney (1):
      ALSA: hda/realtek: Enable mute/micmute LEDs on HP Laptop 14-ey0xxx

Josef Bacik (1):
      btrfs: run delayed iputs when flushing delalloc

Kailang Yang (2):
      ALSA: hda/realtek - Fixed ALC256 headphone no sound
      ALSA: hda/realtek - FIxed ALC285 headphone no sound

Karthik Poosa (1):
      drm/xe/hwmon: Fix WRITE_I1 param from u32 to u16

Kees Cook (2):
      dmaengine: ti: omap-dma: Initialize sglen after allocation
      dmaengine: stm32-dma3: Set lli_size after allocation

Kenneth Feng (1):
      drm/amd/pm: update message interface for smu v14.0.2/3

Kent Overstreet (4):
      bcachefs: Fix failure to return error in data_update_index_update()
      bcachefs: Fix bch2_extents_match() false positive
      bcachefs: Revert lockless buffered IO path
      bcachefs: Mark more errors as autofix

Kiran K (1):
      Bluetooth: btintel: Allow configuring drive strength of BRI

Konrad Dybcio (5):
      mailmap: Add an entry for Konrad Dybcio
      MAINTAINERS: Update Konrad Dybcio's email address
      pinctrl: qcom: x1e80100: Update PDC hwirq map
      arm64: dts: qcom: x1e80100: Fix Adreno SMMU global interrupt
      pinctrl: qcom: x1e80100: Fix special pin offsets

Krzysztof Kozlowski (8):
      arm64: dts: layerscape: fix thermal node names length
      ASoC: MAINTAINERS: Drop Banajit Goswami from Qualcomm sound drivers
      ASoC: codecs: wcd937x: Fix missing de-assert of reset GPIO
      soundwire: stream: fix programming slave ports for non-continous port=
 maps
      usb: dwc3: omap: add missing depopulate in probe error path
      usb: dwc3: xilinx: add missing depopulate in probe error path
      usb: dwc3: st: fix probed platform device ref count on probe error pa=
th
      usb: dwc3: st: add missing depopulate in probe error path

Laurent Pinchart (1):
      MAINTAINERS: Mark UVC gadget driver as orphan

Lijo Lazar (1):
      drm/amd/pm: Add support for new P2S table revision

Likun Gao (1):
      drm/amdgpu: support for gc_info table v1.3

Linus Torvalds (1):
      Linux 6.11-rc6

Lu Baolu (1):
      iommu/vt-d: Fix incorrect domain ID in context flush helper

Luca Weiss (1):
      usb: typec: fsa4480: Relax CHIP_ID check

Luiz Augusto von Dentz (1):
      Bluetooth: hci_core: Fix not handling hibernation actions

MD Danish Anwar (1):
      net: ti: icssg-prueth: Fix 10M Link issue on AM64x

Ma Ke (2):
      pinctrl: single: fix potential NULL dereference in pcs_get_function()
      drm/amd/display: avoid using null object of framebuffer

Manivannan Sadhasivam (3):
      MAINTAINERS: Add Manivannan Sadhasivam as Reviewer for PCI
native host bridge and endpoint drivers
      PCI: qcom-ep: Disable MHI RAM data parity error interrupt for SA8775P=
 SoC
      PCI: qcom: Use OPP only if the platform supports it

Mario Limonciello (1):
      cpufreq/amd-pstate-ut: Don't check for highest perf matching on prefc=
ore

Markus Niebel (2):
      arm64: dts: freescale: imx93-tqma9352: fix CMA alloc-ranges
      arm64: dts: freescale: imx93-tqma9352-mba93xxla: fix typo

Mathieu Fenniak (1):
      platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA

Matthew Brost (1):
      drm/xe: Invalidate media_gt TLBs

Matthieu Baerts (NGI0) (19):
      mptcp: close subflow when receiving TCP+FIN
      selftests: mptcp: join: cannot rm sf if closed
      mptcp: sched: check both backup in retrans
      mptcp: pr_debug: add missing \n at the end
      mptcp: pm: reuse ID 0 after delete and re-add
      mptcp: pm: fix RM_ADDR ID for the initial subflow
      selftests: mptcp: join: check removing ID 0 endpoint
      mptcp: pm: send ACK on an active subflow
      mptcp: pm: skip connecting to already established sf
      mptcp: pm: reset MPC endp ID when re-added
      selftests: mptcp: join: check re-adding init endp with !=3D id
      selftests: mptcp: join: no extra msg if no counter
      mptcp: pm: do not remove already closed subflows
      mptcp: pm: fix ID 0 endp usage after multiple re-creations
      selftests: mptcp: join: check re-re-adding ID 0 endp
      mptcp: avoid duplicated SUB_CLOSED events
      selftests: mptcp: join: validate event numbers
      mptcp: pm: ADD_ADDR 0 is not a new address
      selftests: mptcp: join: check re-re-adding ID 0 signal

Max Filippov (1):
      binfmt_elf_fdpic: fix AUXV size calculation when ELF_HWCAP2 is define=
d

Miao Wang (1):
      LoongArch: Remove the unused dma-direct.h

Michael Grzeschik (1):
      usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)

Michal Vok=C3=A1=C4=8D (1):
      ARM: dts: imx6dl-yapp43: Increase LED current to match the yapp4 HW d=
esign

Mike Rapoport (1):
      microblaze: don't treat zero reserved memory regions as error

Mrinmay Sarkar (2):
      dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
      dmaengine: dw-edma: Do not enable watermark interrupts for HDMA

Murali Nalajala (1):
      firmware: qcom: scm: Mark get_wq_ctx() as atomic call

Neeraj Sanjay Kale (1):
      Bluetooth: btnxpuart: Fix random crash seen while removing driver

NeilBrown (1):
      nfsd: fix nfsd4_deleg_getattr_conflict in presence of third party lea=
se

N=C3=ADcolas F. R. A. Prado (1):
      pinctrl: mediatek: common-v2: Fix broken bias-disable for
PULL_PU_PD_RSEL_TYPE

Olga Kornievskaia (1):
      nfsd: prevent panic for nfsv4.0 closed files in nfs4_show_open

Ondrej Mosnacek (1):
      sctp: fix association labeling in the duplicate COOKIE-ECHO case

Pablo Neira Ayuso (2):
      netfilter: nf_tables: restore IP sanity checks for netdev/egress
      netfilter: nf_tables_ipv6: consider network offset in
netdev/egress validation

Patrick Wildt (1):
      arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant

Pawel Laszczak (2):
      usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq function
      usb: cdnsp: fix for Link TRB with TC

Peng Fan (2):
      arm64: dts: imx95: correct a55 power-domains
      arm64: dts: imx95: correct L3Cache cache-sets

Petr Machata (2):
      selftests: forwarding: no_forwarding: Down ports on cleanup
      selftests: forwarding: local_termination: Down ports on cleanup

Piyush Mehta (1):
      phy: xilinx: phy-zynqmp: Fix SGMII linkup failure on resume

Pranjal Shrivastava (1):
      iommu: Handle iommu faults for a bad iopf setup

Qu Wenruo (1):
      btrfs: fix a use-after-free when hitting errors inside
btrfs_submit_chunk()

Richard Acayan (1):
      firmware: qcom: tzmem: disable sdm670 platform

Richard Fitzgerald (3):
      ASoC: cs-amp-lib-test: Force test calibration blob entries to be vali=
d
      ASoC: cs-amp-lib: Ignore empty UEFI calibration entries
      ALSA: hda: hda_component: Fix mutex crash if nothing ever binds

Ross Brown (1):
      hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING

Ryan Sullivan (1):
      selftests/livepatch: wait for atomic replace to occur

Sascha Hauer (2):
      arm64: dts: freescale: tqma9352: Fix watchdog reset
      wifi: mwifiex: duplicate static structs used in driver instances

Scott Mayhew (1):
      selinux,smack: don't bypass permissions check in inode_setsecctx hook

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Serge Semin (6):
      dmaengine: dw: Add peripheral bus width verification
      dmaengine: dw: Add memory bus width verification
      dmaengine: dw: Simplify prepare CTL_LO methods
      dmaengine: dw: Define encode_maxburst() above prepare_ctllo() callbac=
ks
      dmaengine: dw: Simplify max-burst calculation procedure
      dmaengine: dw: Unify ret-val local variables naming

Shenwei Wang (1):
      arm64: dts: imx93: update default value for snps,clk-csr

Sherry Yang (1):
      scsi: lpfc: Fix overflow build issue

Shyam Sundar S K (2):
      platform/x86/amd/pmc: Fix SMU command submission path on new AMD plat=
form
      platform/x86/amd/pmc: Extend support for PMC features on new AMD plat=
form

Sicelo A. Mhlongo (1):
      ARM: dts: omap3-n900: correct the accelerometer orientation

Simon Trimmer (1):
      ALSA: hda: cs35l56: Don't use the device index as a calibration index

Sriram Yagnaraman (1):
      mailmap: update entry for Sriram Yagnaraman

Stefan Berger (1):
      tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support

Stefan Metzmacher (3):
      smb/client: avoid dereferencing rdata=3DNULL in smb2_new_read_req()
      smb/client: remove unused rq_iter_size from struct smb_rqst
      smb/client: fix rdma usage in smb2_async_writev()

Stephan Gerhold (2):
      arm64: defconfig: Add CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20
      arm64: dts: qcom: x1e80100-crd: Fix backlight

Stephen Brennan (1):
      dcache: keep dentry_hashtable or d_hash_shift even when not used

Steve Wilkins (1):
      firmware: microchip: fix incorrect error report of
programming:timeout on success

Takashi Iwai (1):
      ALSA: seq: Skip event type filtering for UMP events

Thomas Blocher (1):
      pinctrl: at91: make it work with current gpiolib

Tiezhu Yang (1):
      LoongArch: Add ifdefs to fix LSX and LASX related warnings

Tvrtko Ursulin (1):
      drm/v3d: Disable preemption while updating GPU stats

Varadarajan Narayanan (1):
      arm64: dts: qcom: ipq5332: Fix interrupt trigger type for usb

Vijendar Mukunda (3):
      ASoC: SOF: amd: move iram-dram fence register programming sequence
      ASoC: SOF: amd: Fix for incorrect acp error register offsets
      ASoC: SOF: amd: Fix for acp init sequence

Volodymyr Babchuk (1):
      soc: qcom: cmd-db: Map shared memory as WC, not WB

Will Deacon (1):
      MAINTAINERS: Add Jean-Philippe as SMMUv3 SVA reviewer

Xu Yang (2):
      phy: fsl-imx8mq-usb: fix tuning parameter name
      usb: gadget: uvc: queue pump work in uvcg_video_enable()

Xueming Feng (1):
      tcp: fix forever orphan socket caused by tcp_abort

YOUNGJIN JOO (1):
      ALSA: hda/realtek: Fix the speaker output on Samsung Galaxy Book3 Ult=
ra

YR Yang (1):
      ASoC: mediatek: mt8188: Mark AFE_DAC_CON0 register as volatile

Yann Droneaud (1):
      random: vDSO: reject unknown getrandom() flags

Yihang Li (1):
      scsi: sd: Ignore command SYNCHRONIZE CACHE error if format in progres=
s

Yuntao Liu (1):
      ASoC: amd: acp: fix module autoloading

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zack Rusin (3):
      drm/vmwgfx: Prevent unmapping active read buffers
      drm/vmwgfx: Fix prime with external buffers
      drm/vmwgfx: Disable coherent dumb buffers without 3d

Zhihao Cheng (2):
      ovl: fix wrong lowerdir number check for parameter Opt_lowerdir
      ovl: ovl_parse_param_lowerdir: Add missed '\n' for pr_err

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in
remove_power_attributes()

Zizhi Wo (2):
      xfs: Fix the owner setting issue for rmap query in xfs fsmap
      xfs: Fix missing interval for missing_owner in xfs fsmap

