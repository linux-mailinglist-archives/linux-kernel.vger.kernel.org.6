Return-Path: <linux-kernel+bounces-563179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF8A637ED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC916162F20
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E8199FAF;
	Sun, 16 Mar 2025 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WkA1YdAN"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5813C9A3
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742166192; cv=none; b=A+jUfLpxSv1A9pcjdo5Li6DxF4aLSoYEOSt6JwOnwgBmofW48Pfoteiui9YyDHwtXGN/2sv7Tp+9ls2VG8e1LIzqZVz0mRsCden2hC2wmE0xtPYXmKyTHocLjP0lNqjEHeXQcVpkmB7nk/ezmrDlKX10NFWQzqkTySplFEU8BK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742166192; c=relaxed/simple;
	bh=gGYKqzQ+dMLxt6e1Id33e0NcCq2hGQaQZ8sGUCn5xOI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gY/EygHlOp7TZS9UCML/xED2Wnt6cHrnmYh5XtUo48sVIdgsVh6YZigQhnXNJ0flaRqREf69XTv5bsh+A+hWRnJAtl6mSGymJqKqeFueR/2Dn2vQI9+8hQZApNGS9TjdfbT5kBtsbsxUjNYy6z3g1GCl28qLD7+UG55ykyNdwNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WkA1YdAN; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5b572e45cso7171534a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742166187; x=1742770987; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQRnq+E36ce1jio4N7aPESakCdFx8NSJkitoPibp4mg=;
        b=WkA1YdAN0Sv1Zr0NaYmcQ6hQjZIMkxojNs81/nUh7WTHhciqr+iRP3oL9sCGokBVKL
         ag3iBQOZHxSmE9yAXouYGwVxM2BN7GN8xRjNauiMN49H91FU8CCtZdecy046V4MWBOM6
         PjJU4ypkmHZPlcRK7TwheuMnmC9X2gI27SWNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742166187; x=1742770987;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQRnq+E36ce1jio4N7aPESakCdFx8NSJkitoPibp4mg=;
        b=O03Sp8cC4Qn3hBeuILEjzyV51wo/6n7AYbdf2OxHqIoqcf94NSX/ukY8j0GraBa9Uf
         IlXwixiOG/wLwcEg7qq9QQRLwZ2kc6dDd9AZd+/+JH64Djxq9oWeMAOpcm9MPMj/dkzJ
         hS60lbCQhwiho7Hs6MgQjyoJ8e6OY9IWjmw1z7bZdE+AkTKWYuczJu+coiLPzqIGCNG3
         Q+Z6cyvBwV+D0ccMZrucSVKahzbEr71SwBoKINMXCiGaAmvnwTi3l5qoupPI6my/ikda
         Okza/hcnPmxecuOz5+ePapS1Wk+j37MDBiZmJbmafW38bj2N4YMbh11hd0SmVtj7ufj4
         /9Ug==
X-Gm-Message-State: AOJu0YxoI3LRn6Gv4HKGm4e1w9eACmSLmsfaRBEGbPuTMGKdhV7cagci
	HFbqnpUX3Z7CxpGxP/RZyVc6Qu6FaGBBWS7XJWqxP6P8I1SfKDvLeeAOkHTfT5Opa+pRQGy7n1O
	lsTs=
X-Gm-Gg: ASbGnct7wbT2xPuu0u34pq5zKhaSE6tScmntuNPWzFLgnCeH3t6OanadVwTmpFkd8VK
	fzsXaxA1l93D1Q97s9eetGB3eCe/vmPcPXQPPWSTHSvhOb79I2u9gBPNKuuO2xCvrAmLN2ffzyw
	C8JOhW0sGDpWDjiugb623/rdusPuqztSoVXxeLx8rIYEpsDspN94MzaTOCM1xJqZjMeipw6JkKL
	b7oSPNXVIV+gMUiIHN9pLorehdy7q/TWTJufDZdQK2lEZy/T5WKWZH73a7pLCcQwMGKqErXLxCd
	feeCYgSCSNLtZ5IgRxw8K0sHNxtxpjAV2s3/yl+QO98MgKV6DNQDr7O9HDu2B30vukKcYpiJRJf
	HeqaiAoztONYjLQv7rYs=
X-Google-Smtp-Source: AGHT+IGYBSG+go5qjdMYhRmuuCN0IH2SLnP/vTQdWj3STv1bPfYEll5laqDeAL46g0avc0n6AfOo6g==
X-Received: by 2002:a05:6402:1e90:b0:5e6:44d9:57f7 with SMTP id 4fb4d7f45d1cf-5e8a09f77abmr9711713a12.26.1742166187223;
        Sun, 16 Mar 2025 16:03:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816afe201sm4877415a12.68.2025.03.16.16.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Mar 2025 16:03:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso6719491a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 16:03:05 -0700 (PDT)
X-Received: by 2002:a05:6402:5206:b0:5e6:1867:3f7e with SMTP id
 4fb4d7f45d1cf-5e8a0c10255mr11629163a12.32.1742166185011; Sun, 16 Mar 2025
 16:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 16 Mar 2025 13:02:48 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg3c47t+iY8V-EyQKQPj8dLXZw1JWKVtj25uhQB98Ksmg@mail.gmail.com>
X-Gm-Features: AQ5f1JouFC71KSDqETqVP3vebH27x59Rt-SwkbgIaffzAERAM9I0HIMoQHcujJE
Message-ID: <CAHk-=wg3c47t+iY8V-EyQKQPj8dLXZw1JWKVtj25uhQB98Ksmg@mail.gmail.com>
Subject: Linux 6.14-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things continue to look quite calm, and I expect to release the final
6.14 next weekend unless something very surprising happens.

In the meantime, I've pushed out rc7, and while it all looks nice and
small and safe (the biggest patches in here are some selftest updates,
and a few smallish reverts - but there's tiny noise all over the
place), it would be good to get one final week of good testing in. So
please give it a whirl.

        Linus

---

Ajay Kaher (1):
      x86/vmware: Parse MP tables for SEV-SNP enabled guests under
VMware hypervisors

Alan Huang (1):
      bcachefs: Fix b->written overflow

Alban Kurti (5):
      rust: docs: add missing newline to printing macro examples
      rust: error: add missing newline to pr_warn! calls
      rust: init: add missing newline to pr_info! calls
      rust: sync: add missing newline in locked_by log example
      rust: workqueue: add missing newline to pr_info! examples

Alex Deucher (1):
      drm/amdgpu/vce2: fix ip block reference

Alex Hung (1):
      drm/amd/display: Assign normalized_pix_clk when color depth =3D 14

Alexey Kashavkin (1):
      netfilter: nft_exthdr: fix offset with ipv4_find_option()

Alexey Klimov (1):
      ASoC: codecs: wsa884x: report temps to hwmon in millidegree of Celsiu=
s

Aliaksei Urbanski (1):
      drm/amd/display: fix missing .is_two_pixels_per_container

Amir Goldstein (6):
      fsnotify: add pre-content hooks on mmap()
      Revert "ext4: add pre-content fsnotify hook for DAX faults"
      Revert "xfs: add pre-content fsnotify hook for DAX faults"
      Revert "fsnotify: generate pre-content permission event on page fault=
"
      Revert "mm: don't allow huge faults for files with pre content watche=
s"
      Revert "fanotify: disable readahead if we have pre-content watches"

Amit Cohen (1):
      net: switchdev: Convert blocking notification chain to a raw one

Amit Sunil Dhamne (1):
      usb: typec: tcpm: fix state transition for SNK_WAIT_CAPABILITIES
state in run_state_machine()

Andras Sebok (2):
      dt-bindings: input/touchscreen: imagis: add compatible for ist3038h
      Input: imagis - add support for imagis IST3038H

Andrea Righi (1):
      sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()

Andreas Kemnade (1):
      i2c: omap: fix IRQ storms

Andrei Botila (2):
      net: phy: nxp-c45-tja11xx: add TJA112X PHY configuration errata
      net: phy: nxp-c45-tja11xx: add TJA112XB SGMII PCS restart errata

Antheas Kapenekakis (3):
      Input: xpad - add support for ZOTAC Gaming Zone
      Input: xpad - add support for TECNO Pocket Go
      Input: xpad - rename QH controller to Legion Go S

Arnd Bergmann (1):
      ASoC: cs42l43: convert to SYSTEM_SLEEP_PM_OPS

Artur Weber (1):
      pinctrl: bcm281xx: Fix incorrect regmap max_registers value

Bard Liao (2):
      ASoC: rt1320: set wake_capable =3D 0 explicitly
      ASoC: rt722-sdca: add missing readable registers

Bartosz Golaszewski (2):
      gpiolib: don't check the retval of get_direction() when registering a=
 chip
      gpio: cdev: use raw notifier for line state events

Bastien Nocera (1):
      MAINTAINERS: Remove myself from the goodix touchscreen maintainers

Benjamin Berg (1):
      wifi: mac80211: fix MPDU length parsing for EHT 5/6 GHz

Benno Lossin (1):
      rust: init: fix `Zeroable` implementation for
`Option<NonNull<T>>` and `Option<KBox<T>>`

Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Breno Leitao (1):
      netpoll: hold rcu read lock in __netpoll_send_skb()

Carolina Jubran (1):
      net/mlx5e: Prevent bridge link show failure for
non-eswitch-allowed devices

Charles Han (1):
      pinctrl: nuvoton: npcm8xx: Add NULL check in npcm8xx_gpio_fw

Charles Keepax (2):
      ASoC: ops: Consistently treat platform_max as control value
      ASoC: cs42l43: Fix maximum ADC Volume

Christophe JAILLET (4):
      ASoC: codecs: wm0010: Fix error handling path in wm0010_spi_probe()
      i2c: ali1535: Fix an error handling path in ali1535_probe()
      i2c: ali15x3: Fix an error handling path in ali15x3_probe()
      i2c: sis630: Fix an error handling path in sis630_probe()

Claudiu Beznea (1):
      spi: atmel-quadspi: remove references to runtime PM on error path

Cong Wang (2):
      net_sched: Prevent creation of classes with TC_H_ROOT
      selftests/tc-testing: Add a test case for DRR class with TC_H_ROOT

Conor Dooley (1):
      spi: microchip-core: prevent RX overflows when transmit size > FIFO s=
ize

Damien Le Moal (2):
      nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully create=
d
      nvmet: pci-epf: Do not add an IRQ vector if not needed

Dan Carpenter (2):
      platform/x86/amd/pmf: fix cleanup in amd_pmf_init_smart_pc()
      ipvs: prevent integer overflow in do_ip_vs_get_ctl()

David Howells (1):
      afs: Fix afs_atcell_get_link() to handle RCU pathwalk

David Rosca (1):
      drm/amdgpu/display: Allow DCC for video formats on GFX12

Edward Cree (1):
      MAINTAINERS: sfc: remove Martin Habets

Emmanuel Grumbach (2):
      wifi: iwlwifi: mvm: fix PNVM timeout for non-MSI-X platforms
      wifi: mac80211: flush the station before moving it to UN-AUTHORIZED s=
tate

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name

Florent Revest (1):
      x86/microcode/AMD: Fix out-of-bounds on systems with CPU-less NUMA no=
des

Florian Westphal (2):
      netfilter: nf_tables: make destruction work queue pernet
      selftests: netfilter: skip br_netfilter queue tests if kernel is tain=
ted

Grzegorz Nitka (1):
      ice: fix memory leak in aRFS after reset

Guillaume Nault (2):
      gre: Fix IPv6 link-local address generation.
      selftests: Add IPv6 link-local address generation tests for GRE devic=
es.

H. Nikolaus Schaller (1):
      Input: ads7846 - fix gpiod allocation

Hangbin Liu (2):
      bonding: fix incorrect MAC address setting to receive NS messages
      selftests: bonding: fix incorrect mac address

Hans Verkuil (1):
      media: rtl2832_sdr: assign vb2 lock before vb2_queue_init

Haoxiang Li (1):
      qlcnic: fix memory leak issues in qlcnic_sriov_common.c

Henrique Carvalho (1):
      smb: client: Fix match_session bug preventing session reuse

Hsin-chen Chuang (1):
      Bluetooth: btusb: Configure altsetting for HCI_USER_CHANNEL

Ike Panhc (1):
      MAINTAINERS: Update Ike Panhc's email address

Ilan Peer (1):
      wifi: iwlwifi: pcie: Fix TSO preparation

Ilpo J=C3=A4rvinen (1):
      <linux/cleanup.h>: Allow the passing of both iomem and non-iomem
pointers to no_free_ptr()

Ilya Maximets (1):
      net: openvswitch: remove misbehaving actions length check

Imre Deak (1):
      drm/dp_mst: Fix locking when skipping CSN before topology probing

Ivan Abramov (1):
      drm/gma500: Add NULL check for pci_gfx_root in mid_get_vbt_data()

Jeff LaBundy (1):
      Input: iqs7222 - preserve system status register

Jianbo Liu (1):
      net/mlx5: Bridge, fix the crash caused by LAG state check

Jiri Pirko (1):
      net/mlx5: Fill out devlink dev info only for PFs

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

Johannes Berg (3):
      wifi: rework MAINTAINERS entries a bit
      wifi: nl80211: fix assoc link handling
      wifi: mac80211: fix SA Query processing in MLO

Joseph Huang (1):
      net: dsa: mv88e6xxx: Verify after ATU Load ops

Jos=C3=A9 Roberto de Souza (1):
      drm/i915: Increase I915_PARAM_MMAP_GTT_VERSION version to
indicate support for partial mmaps

Jun Yang (1):
      sched: address a potential NULL pointer dereference in the GRED sched=
uler.

Justin Lai (1):
      rtase: Fix improper release of ring list entries in rtase_sw_reset

Kees Cook (1):
      vboxsf: Add __nonstring annotations for unterminated strings

Keith Busch (1):
      nvme-pci: fix stuck reset on concurrent DPC and HP

Kent Overstreet (7):
      bcachefs: Make sure trans is unlocked when submitting read IO
      bcachefs: fix tiny leak in bch2_dev_add()
      bcachefs: target_congested -> get_random_u32_below()
      bcachefs: bch2_get_random_u64_below()
      dm-flakey: Fix memory corruption in optional corrupt_bio_byte feature
      bcachefs: Change btree wb assert to runtime error
      bcachefs: fix build on 32 bit in get_random_u64_below()

Kohei Enju (1):
      netfilter: nf_conncount: Fully initialize struct
nf_conncount_tuple in insert_tree()

Kory Maincent (1):
      net: ethtool: tsinfo: Fix dump command

Krzysztof Kozlowski (1):
      clk: qcom: dispcc-sm8750: Drop incorrect CLK_SET_RATE_PARENT on
byte intf parent

Larysa Zaremba (1):
      ice: do not configure destination override for switchdev

Leo Li (1):
      drm/amd/display: Disable unneeded hpd interrupts during dm_init

Linus Torvalds (1):
      Linux 6.14-rc7

Luca Weiss (2):
      Input: goodix-berlin - fix comment referencing wrong regulator
      Input: goodix-berlin - fix vddio regulator references

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix enabling passive scanning
      Revert "Bluetooth: hci_core: Fix sleeping function called from
invalid context"

Lukas Hetzenecker (1):
      platform/surface: aggregator_registry: Add Support for Surface Pro 11

Maciej Strozek (1):
      ASoC: cs42l43: Add jack delay debounce after suspend

Manuel Fombuena (1):
      leds: leds-st1202: Fix NULL pointer access on race condition

Marcin Szycik (1):
      ice: Fix switchdev slow-path in LAG

Mario Limonciello (5):
      drm/amd: Keep display off while going into S4
      drm/amd/display: fix default brightness
      drm/amd/display: Restore correct backlight brightness after a GPU res=
et
      drm/amd/display: Fix slab-use-after-free on hdcp_work
      platform/x86/amd: pmf: Fix missing hidden options for Smart PC

Matt Johnston (3):
      net: mctp i3c: Copy headers if cloned
      net: mctp i2c: Copy headers if cloned
      net: mctp: unshare packets when reassembling

Matthew Maurer (1):
      rust: Disallow BTF generation with Rust + LTO

Matthew Wilcox (Oracle) (1):
      xfs: Use abs_diff instead of XFS_ABSDIFF

Michael Kelley (5):
      fbdev: hyperv_fb: iounmap() the correct memory when removing a device
      drm/hyperv: Fix address space leak when Hyper-V DRM device is removed
      fbdev: hyperv_fb: Fix hang in kdump kernel when on Hyper-V Gen 2 VMs
      x86/hyperv: Fix output argument to hypercall that changes page visibi=
lity
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio=
()

Miguel Ojeda (3):
      rust: remove leftover mentions of the `alloc` crate
      drm/panic: use `div_ceil` to clean Clippy warning
      drm/panic: fix overindented list items in documentation

Mika Westerberg (1):
      thunderbolt: Prevent use-after-free in resume from hibernate

Mina Almasry (1):
      netmem: prevent TX of unreadable skbs

Miri Korenblit (3):
      wifi: iwlwifi: trans: cancel restart work on op mode leave
      wifi: mac80211: don't queue sdata::work for a non-running sdata
      wifi: cfg80211: cancel wiphy_work before freeing wiphy

Mitchell Levy (1):
      rust: lockdep: Remove support for dynamically allocated LockClassKeys

Murad Masimov (4):
      cifs: Fix integer overflow while processing acregmax mount option
      cifs: Fix integer overflow while processing acdirmax mount option
      cifs: Fix integer overflow while processing actimeo mount option
      cifs: Fix integer overflow while processing closetimeo mount option

Naman Jain (1):
      x86/hyperv/vtl: Stop kernel from probing VTL0 low memory

Namjae Jeon (2):
      ksmbd: fix use-after-free in ksmbd_free_work_struct
      ksmbd: prevent connection release during oplock break notification

Natalie Vock (1):
      drm/amdgpu: NULL-check BO's backing store when determining GFX12 PTE =
flags

Navon John Lukose (1):
      ALSA: hda/realtek: Add mute LED quirk for HP Pavilion x360 14-dy1xxx

Nicklas Bo Jensen (1):
      netfilter: nf_conncount: garbage collection is not skipped when
jiffies wrap around

Nilton Perim Neto (1):
      Input: xpad - add 8BitDo SN30 Pro, Hyperkin X91 and Gamesir G7
SE controllers

Oleksij Rempel (1):
      net: usb: lan78xx: Sanitize return values of register read/write func=
tions

Panagiotis Foliadis (1):
      rust: task: fix `SAFETY` comment in `Task::wake_up`

Pauli Virtanen (1):
      Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready

Paulo Alcantara (1):
      smb: client: fix regression with guest option

Pavel Rojtberg (1):
      Input: xpad - add multiple supported devices

Peter Griffin (1):
      clk: samsung: gs101: fix synchronous external abort in samsung_clk_sa=
ve()

Peter Ujfalusi (1):
      ASoC: Intel: sof_sdw: Fix unlikely uninitialized variable use in
create_sdw_dailinks()

Piotr Jaroszynski (1):
      Fix mmu notifiers for range-based invalidates

Przemek Kitszel (1):
      ice: register devlink prior to creating health reporters

Randy Dunlap (1):
      locking/rtmutex: Use the 'struct' keyword in kernel-doc comment

Rodrigo Vivi (2):
      drm/xe/pm: Temporarily disable D3Cold on BMG
      drm/xe/guc_pc: Retry and wait longer for GuC PC start

Roxana Nicolescu (1):
      bcachefs: Initialize from_inode members for bch_io_opts

Saurabh Sengar (2):
      fbdev: hyperv_fb: Simplify hvfb_putmem
      fbdev: hyperv_fb: Allow graceful removal of framebuffer

Sebastian Andrzej Siewior (1):
      netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_templ=
ate.

Shay Drory (2):
      net/mlx5: Fix incorrect IRQ pool usage when releasing IRQs
      net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch

Shin'ichiro Kawasaki (2):
      nvme: move error logging from nvme_end_req() to __nvme_end_req()
      block: change blk_mq_add_to_batch() third argument type to bool

Shradha Gupta (1):
      net: mana: cleanup mana struct after debugfs_remove()

Taehee Yoo (8):
      eth: bnxt: fix truesize for mb-xdp-pass case
      eth: bnxt: return fail if interface is down in bnxt_queue_mem_alloc()
      eth: bnxt: do not use BNXT_VNIC_NTUPLE unconditionally in queue
restart logic
      eth: bnxt: do not update checksum in bnxt_xdp_build_skb()
      eth: bnxt: fix kernel panic in the bnxt_get_queue_stats{rx | tx}
      eth: bnxt: fix memory leak in queue reset
      net: devmem: do not WARN conditionally after netdev_rx_queue_restart(=
)
      selftests: drv-net: add xdp cases for ping.py

Tamir Duberstein (4):
      rust: alloc: satisfy POSIX alignment requirement
      scripts: generate_rust_analyzer: add missing macros deps
      scripts: generate_rust_analyzer: add missing include_dirs
      scripts: generate_rust_analyzer: add uapi crate

Tejas Upadhyay (1):
      drm/xe: Release guc ids before cancelling work

Tengda Wu (1):
      tracing: Correct the refcount if the hist/hist_debug file fails to op=
en

Thomas Hellstr=C3=B6m (1):
      drm/xe/userptr: Fix an incorrect assert

Thomas Mizrahi (1):
      ASoC: amd: yc: Support mic on another Lenovo ThinkPad E16 Gen 2 model

Thorsten Blum (1):
      ASoC: tegra: Fix ADX S24_LE audio format

Tudor Ambarus (1):
      MAINTAINERS: add tambarus as R for Samsung SPI

Varada Pavani (1):
      clk: samsung: update PLL locktime for PLL142XX used on FSD platform

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915/cdclk: Do cdclk post plane programming later
      drm/atomic: Filter out redundant DPMS calls

Vlad Dogaru (1):
      net/mlx5: HWS, Rightsize bwc matcher priority

Vladis Dronov (1):
      x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled

Waiman Long (1):
      locking/semaphore: Use wake_q to wake up processes outside lock
critical section

Wentao Liang (1):
      net/mlx5: handle errors in mlx5_chains_create_table()

Werner Sembach (4):
      Input: i8042 - swap old quirk combination with new quirk for NHxxRZQ
      Input: i8042 - add required quirks for missing old boardnames
      Input: i8042 - swap old quirk combination with new quirk for
several devices
      Input: i8042 - swap old quirk combination with new quirk for more dev=
ices

Xin Long (1):
      Revert "openvswitch: switch to per-action label counting in conntrack=
"

Xin Wang (1):
      drm/xe: remove redundant check in xe_vm_create_ioctl()

Yafang Shao (1):
      sched/clock: Don't define sched_clock_irqtime as static key

Yevgeny Kliteynik (1):
      net/mlx5: DR, use the right action structs for STEv3

Yifan Zha (1):
      drm/amd/amdkfd: Evict all queues even HWS remove queue failed

Yixun Lan (1):
      pinctrl: spacemit: enable config option

Yu-Chun Lin (1):
      Input: wdt87xx_i2c - fix compiler warning

Zhenhua Huang (1):
      arm64: mm: Populate vmemmap at the page level if not section aligned

