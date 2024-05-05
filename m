Return-Path: <linux-kernel+bounces-169154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7858BC3EE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 23:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EEF6282144
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EC3762EF;
	Sun,  5 May 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KHUXAoOV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C332555B
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714943898; cv=none; b=Ad20Jxdfr+FQMYh1UT+MPIUIvm9LLFUM2alEMK1NunTo3ZAthuiwJe0LAY9RKHgzMStY4QSU7R3yoUSnoxvM+imnv7vO6KT24gaFFETG2YPjozmJVPnZ9epuV236ZqgrGIYKEkAhrptwbpjUb9yMvVtT8fkGySAaFLl5V6352Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714943898; c=relaxed/simple;
	bh=98YAnIUmLyy7x0oyQLwZaiIcUoQKzFh8mRj0vVCf4p8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p9fN+i8eum9vGYrB/JYn1NalOO3pGZFxmbvA0EtmWzQTlf315TTJzL6ra3VRmYgkkvNWCOjqDWIEODmh5QRGwa9bPlAygygCpfQiOYQJuFToBlVd2WkAyka9skHR9lT5rbU3tKKJkJ7UJg1zkD6vdgHVkS0aKqoIQNZKUQdhQS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KHUXAoOV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a599a298990so318035766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714943893; x=1715548693; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQeR4wkB8MS50lIR0mhvWifvKyrkPG1puSYRjhVAhRM=;
        b=KHUXAoOVYmJwtJzTFuupasP6igvaBcm8Ae5JprhWCBBStH38KdR6QYXLkxEVE16Hcj
         WKgnnyDGAq08QeyQsBD96b3Ky4BeE1AqIPCv1qG/+M3d4VLmeIp0kpb0IhTIMTMqsrjL
         GqRiEwHeRn2QK6TuRLK9tf+IzY5rTLIA1wUoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714943893; x=1715548693;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pQeR4wkB8MS50lIR0mhvWifvKyrkPG1puSYRjhVAhRM=;
        b=QctW2NkR5m/ZlI8MiqmFhz86daDmpE/0cmnULRPKUPbli9hQNRJ8ta3T2Qr1mkRvoK
         c2Lm+FuFWm9bGcvxFa2qMKODP78cuWh8u35uEPJMQreMk8Yp17eifjx4REYU53PDgLH2
         AZ1fJNRkrVypj5rrjAsR45B5AzgnaV7653daaVP2dQiEbmvzt7SdlIJTWBcVqBVoGXWf
         yw+uA5H1yHQXFnd8952AP4iv4tT5QD2Q/HwGmBjbjHcNm3apyZhbb5oiDdTVDfM5NThb
         UevCkvMR9IWqmR+yfKE/pHK/RvE1NhDStmVlrFOwlB/4MMYYfCXnox3b6OpAEQc8Hf4M
         oKPg==
X-Gm-Message-State: AOJu0YwUOtg3B272XAGVnRfzqJO6YNhNPhza9BfkwZ3Ji1pF63vrHLIz
	Ust9cSwBGMmXs8hDsMkD1p+rR5A9DPvEigxhpVOY++qWKtzLaMGKEpfUyAKCUyeoCDiwMGkMEUa
	ti0bIkA==
X-Google-Smtp-Source: AGHT+IH9gkRPWsKch4CaZ+zfE3mWkFFvHCKXVJeX7srRm7gr97/WU/7SFCGr1lnGprzS0lugl3KiZA==
X-Received: by 2002:a17:906:bc42:b0:a51:a288:5af9 with SMTP id s2-20020a170906bc4200b00a51a2885af9mr4654954ejv.51.1714943893347;
        Sun, 05 May 2024 14:18:13 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id gc3-20020a170906c8c300b00a59afbbab7dsm1786031ejb.49.2024.05.05.14.18.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 14:18:12 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59c0a6415fso167451066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2024 14:18:12 -0700 (PDT)
X-Received: by 2002:a17:906:a145:b0:a58:832d:c3e8 with SMTP id
 bu5-20020a170906a14500b00a58832dc3e8mr5533368ejb.58.1714943892184; Sun, 05
 May 2024 14:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 5 May 2024 14:17:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiT0EJV+X-=-dMmL+q3_kyQCxV-WPxb8m8Q6dtWOxjCcg@mail.gmail.com>
Message-ID: <CAHk-=wiT0EJV+X-=-dMmL+q3_kyQCxV-WPxb8m8Q6dtWOxjCcg@mail.gmail.com>
Subject: Linux 6.9-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The stats for 6.9 continue to look very normal, and nothing looks
particularly alarming.

Most of the changes are to drivers, as is proper and tradition. Sound
stands out, but not in some scary way, and we've got the usual DRM
updates and various random other subsystems (usb, pincontrol,
networking, nvme..).

Outside of drivers it's mostly random other smaller changes:
filesystems (erofs and tracefs), some arch updates (mostly x86, but a
smattering of fixes elsewhere too), some documentation updates, small
core networking fixes, and some selftests.

                           Linus

---

Adam Skladowski (1):
      clk: qcom: smd-rpm: Restore msm8976 num_clk

Alan Stern (2):
      USB: core: Fix access violation during port device removal
      usb: Fix regression caused by invalid ep0 maxpacket in virtual
SuperSpeed device

Alexander Usyskin (1):
      mei: me: add lunar lake point M DID

Alexandra Winter (1):
      s390/qeth: Fix kernel panic after setting hsuid

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: Intel: avs: Set name of control as in topology

Aman Dhoot (1):
      ALSA: hda/realtek: Fix mute led of HP Laptop 15-da3001TU

Amit Sunil Dhamne (1):
      usb: typec: tcpm: unregister existing source caps before re-registrat=
ion

Andrii Nakryiko (1):
      bpf, kconfig: Fix DEBUG_INFO_BTF_MODULES Kconfig definition

Andy Shevchenko (3):
      drm/panel: ili9341: Correct use of device property APIs
      drm/panel: ili9341: Respect deferred probe
      drm/panel: ili9341: Use predefined error codes

AngeloGioacchino Del Regno (2):
      regulator: mt6360: De-capitalize devicetree regulator subnodes
      power: supply: mt6360_charger: Fix of_match for usb-otg-vbus regulato=
r

Anton Protopopov (1):
      bpf: Fix a verifier verbose message

Arnd Bergmann (1):
      power: rt9455: hide unused rt9455_boost_voltage_values

Asbj=C3=B8rn Sloth T=C3=B8nnesen (4):
      net: qede: sanitize 'rc' in qede_add_tc_flower_fltr()
      net: qede: use return from qede_parse_flow_attr() for flower
      net: qede: use return from qede_parse_flow_attr() for flow_spec
      net: qede: use return from qede_parse_actions()

Ashish Kalra (2):
      x86/e820: Add a new e820 table update helper
      x86/sev: Add callback to apply RMP table fixups for kexec

Audra Mitchell (1):
      Documentation/core-api: Update events_freezable_power references.

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Check for port partner validity before consuming it

Baokun Li (1):
      erofs: get rid of erofs_fs_context

Barry Song (1):
      xtensa: remove redundant flush_dcache_page and
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros

Billy Tsai (1):
      pinctrl: pinctrl-aspeed-g6: Fix register offset for pinconf of GPIOR-=
T

Bj=C3=B6rn T=C3=B6pel (1):
      MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64 reviewers

Bui Quang Minh (4):
      ice: ensure the copied buf is NUL terminated
      bna: ensure the copied buf is NUL terminated
      octeontx2-af: avoid off-by-one read from userspace
      s390/cio: Ensure the copied buf is NUL terminated

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix debug window description

Chen Yu (1):
      efi/unaccepted: touch soft lockup during memory accept

Chen-Yu Tsai (2):
      pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readbac=
k
      pinctrl: mediatek: paris: Rework support for
PIN_CONFIG_{INPUT,OUTPUT}_ENABLE

Chris Wulff (1):
      usb: gadget: f_fs: Fix a race condition when processing setup packets=
.

Christian Brauner (1):
      erofs: reliably distinguish block based and fscache mode

Christian K=C3=B6nig (1):
      drm/amdgpu: once more fix the call oder in amdgpu_ttm_move() v2

Chuck Lever (1):
      NFSD: Fix nfsd4_encode_fattr4() crasher

Claudio Imbrenda (2):
      s390/mm: Fix storage key clearing for guest huge pages
      s390/mm: Fix clearing storage keys for huge pages

Claudiu Beznea (2):
      pinctrl: renesas: rzg2l: Execute atomically the interrupt configurati=
on
      pinctrl: renesas: rzg2l: Configure the interrupt type on resume

Dan Carpenter (1):
      pinctrl: core: delete incorrect free in pinctrl_enable()

Daniele Ceraolo Spurio (1):
      mei: pxp: match against PCI_CLASS_DISPLAY_OTHER

Dave Jiang (1):
      cxl: Fix cxl_endpoint_get_perf_coordinate() support for RCH

David Bauer (1):
      net l2tp: drop flow hash on forward

David Howells (1):
      Fix a potential infinite loop in extract_user_to_sg()

David Lechner (1):
      spi: axi-spi-engine: fix version format string

Derek Fang (2):
      ASoC: rt5645: Fix the electric noise due to the CBJ contacts floating
      ASoC: dt-bindings: rt5645: add cbj sleeve gpio property

Devyn Liu (1):
      spi: hisi-kunpeng: Delete the dump interface of data registers in deb=
ugfs

Dominique Martinet (1):
      btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()

Doug Berger (3):
      net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
      net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
      net: bcmgenet: synchronize UMAC_CMD access

Felix Fietkau (2):
      net: bridge: fix multicast-to-unicast with fraglist GSO
      net: core: reject skb_copy(_expand) for fraglist GSO skbs

Frank Oltmanns (2):
      clk: sunxi-ng: common: Support minimum and maximum rate
      clk: sunxi-ng: a64: Set minimum and maximum rate for PLL-MIPI

Gabe Teeger (1):
      drm/amd/display: Atom Integrated System Info v2_2 for DCN35

Gaurav Batra (1):
      powerpc/pseries/iommu: LPAR panics during boot up with a frozen PE

George Shen (1):
      drm/amd/display: Handle Y carry-over in VCP X.Y calculation

Guenter Roeck (1):
      usb: ohci: Prevent missed ohci interrupts

Guillaume Nault (3):
      vxlan: Fix racy device stats updates.
      vxlan: Add missing VNI filter counter update in arp_reduce().
      vxlan: Pull inner IP header in vxlan_rcv().

Hannes Reinecke (1):
      nvme-tcp: strict pdu pacing to avoid send stalls on TLS

Hans de Goede (5):
      iio: accel: mxc4005: Interrupt handling fixes
      iio: accel: mxc4005: Reset chip on probe() and resume()
      ASoC: Intel: bytcr_rt5640: Apply Asus T100TA quirk to Asus T100TAM to=
o
      pinctrl: baytrail: Fix selecting gpio pinctrl state
      pinctrl: baytrail: Add pinconf group for uart3

Harald Freudenberger (4):
      s390/zcrypt: Fix wrong format string in debug feature printout
      s390/zcrypt: Handle ep11 cprb return code
      s390/zcrypt: Use EBUSY to indicate temp unavailability
      s390/paes: Reestablish retry loop in paes

Hersen Wu (1):
      drm/amd/display: Fix incorrect DSC instance for MST

Hongbo Li (1):
      erofs: modify the error message when prepare_ondemand_read failed

Ian Forbes (1):
      drm/vmwgfx: Fix Legacy Display Unit

Ivan Avdeev (1):
      usb: gadget: uvc: use correct buffer size when parsing configfs lists

Jack Yu (4):
      ASoC: rt722-sdca: modify channel number to support 4 channels
      ASoC: rt722-sdca: add headset microphone vrefo setting
      ASoC: rt715: add vendor clear control register
      ASoC: rt715-sdca: volume step modification

Jakub Kicinski (3):
      MAINTAINERS: add an explicit entry for YNL
      MAINTAINERS: remove Ariel Elior
      MAINTAINERS: mark MYRICOM MYRI-10G as Orphan

Jan Dakinevich (1):
      pinctrl/meson: fix typo in PDM's pin name

Jason Xing (1):
      bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqu=
eue

Javier Carrasco (1):
      dt-bindings: iio: health: maxim,max30102: fix compatible check

Jeffrey Altman (1):
      rxrpc: Clients must accept conn from any address

Jens Remus (1):
      s390/vdso: Add CFI for RA register to asm macro vdso_func

Jernej Skrabec (1):
      clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Jerome Brunet (5):
      ASoC: meson: axg-fifo: use threaded irq to check periods
      ASoC: meson: axg-card: make links nonatomic
      ASoC: meson: axg-tdm-interface: manage formatters in trigger
      ASoC: meson: axg-tdm: add continuous clock support
      ASoC: meson: cards: select SND_DYNAMIC_MINORS

Jim Cromie (1):
      dyndbg: fix old BUG_ON in >control parser

Joao Paulo Goncalves (1):
      ASoC: ti: davinci-mcasp: Fix race condition during probe

Johan Hovold (3):
      clk: qcom: gdsc: treat optional supplies as optional
      usb: typec: qcom-pmic: fix use-after-free on late probe errors
      usb: typec: qcom-pmic: fix pdphy start() error handling

John Garry (1):
      scsi: sd: Only print updates to permanent stream count

Josef Bacik (1):
      btrfs: take the cleaner_mutex earlier in qgroup disable

Juergen Gross (1):
      x86/xen: return a sane initial apic id when running as PV guest

Kailang Yang (1):
      ALSA: hda/realtek - Set GPIO3 to default at S4 state for
Thinkpad with ALC1318

Kent Overstreet (3):
      bcachefs: Remove accidental debug assert
      bcachefs: btree node scan now fills in sectors_written
      bcachefs: fix integer conversion bug

Krzysztof Kozlowski (2):
      regulator: qcom-refgen: fix module autoloading
      regulator: vqmmc-ipq4019: fix module autoloading

Kuniyuki Iwashima (2):
      nfs: Handle error of rpc_proc_register() in nfs_net_init().
      nsh: Restore skb->{protocol,data,mac_header} for outer header in
nsh_gso_segment().

Lad Prabhakar (1):
      dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and
'output-enable' properties

Lai Jiangshan (1):
      workqueue: Fix divide error in wq_update_node_max_active()

Lancelot SIX (1):
      drm/amdkfd: Flush the process wq before creating a kfd_process

Leo Ma (1):
      drm/amd/display: Fix DC mode screen flickering on DCN321

Linus Torvalds (3):
      x86/mm: Remove broken vsyscall emulation code from the page fault cod=
e
      epoll: be better about file lifetimes
      Linux 6.9-rc7

LuMingYin (1):
      tracing/probes: Fix memory leak in traceprobe_parse_probe_arg_body()

Lucas De Marchi (1):
      drm/xe/display: Fix ADL-N detection

Lyude Paul (2):
      drm/nouveau/firmware: Fix SG_DEBUG error with nvkm_firmware_ctor()
      drm/nouveau/gsp: Use the sg allocator for level 2 of radix3

Mans Rullgard (1):
      spi: fix null pointer dereference within spi_sync

Marek Beh=C3=BAn (1):
      net: dsa: mv88e6xxx: Fix number of databases for 88E6141 / 88E6341

Marek Szyprowski (1):
      clk: samsung: Revert "clk: Use device_get_match_data()"

Mario Limonciello (1):
      drm/amd/display: Disable panel replay by default for now

Matt Coster (1):
      drm/imagination: Ensure PVR_MIPS_PT_PAGE_COUNT is never zero

Matthew Auld (1):
      drm/xe/vm: prevent UAF in rebind_work_func()

Matthew Wilcox (Oracle) (1):
      bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS

Matti Vaittinen (3):
      regulator: irq_helpers: duplicate IRQ name
      regulator: change stubbed devm_regulator_get_enable to return Ok
      regulator: change devm_regulator_get_enable_optional() stub to return=
 Ok

Maurizio Lombardi (2):
      nvmet-auth: return the error code to the nvmet_auth_host_hash() calle=
rs
      nvmet-auth: replace pr_debug() with pr_err() to report an error.

Max Filippov (1):
      xtensa: fix MAKE_PC_FROM_RA second argument

Meenakshikumar Somasundaram (1):
      drm/amd/display: Allocate zero bw after bw alloc enable

Mukul Joshi (1):
      drm/amdgpu: Fix VRAM memory accounting

Nayna Jain (1):
      powerpc/pseries: make max polling consistent for longer H_CALLs

Nilay Shroff (2):
      nvme: find numa distance only if controller has valid numa id
      nvme: cancel pending I/O if nvme controller is in terminal state

Olga Kornievskaia (1):
      SUNRPC: add a missing rpc_stat for TCP TLS

Oliver Upton (2):
      KVM: arm64: vgic-v2: Check for non-NULL vCPU in vgic_v2_parse_attr()
      KVM: selftests: Add test for uaccesses to non-existent vgic-v2 CPUIF

Oswald Buddenhagen (6):
      ALSA: emu10k1: fix E-MU card dock presence monitoring
      ALSA: emu10k1: factor out snd_emu1010_load_dock_firmware()
      ALSA: emu10k1: move the whole GPIO event handling to the workqueue
      ALSA: emu10k1: use mutex for E-MU FPGA access locking
      ALSA: emu10k1: fix E-MU dock initialization
      ALSA: emu10k1: make E-MU FPGA writes potentially more reliable

Paolo Abeni (2):
      mptcp: ensure snd_nxt is properly initialized on connect
      tipc: fix UAF in error path

Peter Colberg (1):
      fpga: dfl-pci: add PCI subdevice ID for Intel D5005 card

Peter Korsgaard (1):
      usb: gadget: composite: fix OS descriptors w_value logic

Peter Ujfalusi (5):
      ASoC: SOF: ipc4-pcm: Use consistent name for snd_sof_pcm_stream point=
er
      ASoC: SOF: ipc4-pcm: Use consistent name for
sof_ipc4_timestamp_info pointer
      ASoC: SOF: ipc4-pcm: Introduce generic sof_ipc4_pcm_stream_priv
      ASoC: SOF: ipc4-pcm: Do not reset the ChainDMA if it has not
been allocated
      ASoC: SOF: Core: Handle error returned by sof_select_ipc_and_paths

Pierre-Louis Bossart (6):
      ASoC: SOF: Intel: add default firmware library path for LNL
      ASoC: SOF: debug: show firmware/topology prefix/names
      ASoC: da7219-aad: fix usage of device_get_named_child_node()
      ASoC: cs35l56: fix usages of device_get_named_child_node()
      ALSA: hda: intel-dsp-config: harden I2C/I2S codec detection
      ALSA: hda: intel-sdw-acpi: fix usage of device_get_named_child_node()

Puranjay Mohan (5):
      MAINTAINERS: Update email address for Puranjay Mohan
      arm32, bpf: Reimplement sign-extension mov instruction
      bpf: verifier: prevent userspace memory access
      bpf, x86: Fix PROBE_MEM runtime load check
      selftests/bpf: Test PROBE_MEM of VSYSCALL_ADDR on x86-64

Qu Wenruo (1):
      btrfs: set correct ram_bytes when splitting ordered extent

RD Babiera (3):
      usb: typec: tcpm: queue correct sop type in tcpm_queue_vdm_unlocked
      usb: typec: tcpm: clear pd_event queue in PORT_RESET
      usb: typec: tcpm: enforce ready state when queueing alt mode vdm

Rafael J. Wysocki (3):
      thermal/debugfs: Free all thermal zone debug memory on zone removal
      thermal/debugfs: Fix two locking issues with thermal zone debug
      thermal/debugfs: Prevent use-after-free from occurring after cdev rem=
oval

Ramona Gradinariu (1):
      iio:imu: adis16475: Fix sync mode setting

Ranjani Sridharan (1):
      ASoC: SOF: pcm: Restrict DSP D0i3 during S0ix to IPC3

Richard Fitzgerald (4):
      regmap: Add regmap_read_bypassed()
      ALSA: hda: cs35l56: Exit cache-only after cs35l56_wait_for_firmware_b=
oot()
      ASoC: cs35l56: Fix unintended bus access while resetting amp
      ASoC: cs35l56: Prevent overwriting firmware ASP config

Richard Gobert (2):
      net: gro: fix udp bad offset in socket lookup by adding
{inner_}network_offset to napi_gro_cb
      net: gro: add flush check in udp_gro_receive_segment

Rodrigo Siqueira (2):
      drm/amd/display: Ensure that dmcub support flag is set for DCN20
      drm/amd/display: Add VCO speed parameter for DCN31 FPU

Sagi Grimberg (2):
      nvmet-tcp: fix possible memory leak when tearing down a controller
      nvmet: fix nvme status code when namespace is disabled

Sameer Pujar (1):
      ASoC: tegra: Fix DSPK 16-bit playback

Sebastian Andrzej Siewior (1):
      cxgb4: Properly lock TX queue for the selftest.

Shashank Sharma (1):
      drm/amdgpu: fix doorbell regression

Shigeru Yoshida (1):
      ipv4: Fix uninit-value access in __ip_make_skb()

Shubhrajyoti Datta (3):
      EDAC/versal: Do not register for NOC errors
      EDAC/versal: Check user-supplied data before injecting an error
      EDAC/versal: Do not log total error counts

Simon Trimmer (1):
      ASoC: cs35l56: Avoid static analysis warning of uninitialised variabl=
e

Srinivas Kandagatla (1):
      ASoC: codecs: wsa881x: set clk_stop_mode1 flag

Srinivas Pandruvada (1):
      platform/x86: ISST: Add Grand Ridge to HPM CPU list

Stefan Binding (1):
      ASoC: cs35l41: Update DSP1RX5/6 Sources for DSP config

Steven Rostedt (Google) (7):
      eventfs/tracing: Add callback for release of an eventfs_inode
      eventfs: Free all of the eventfs_inode after RCU
      tracefs: Reset permissions on remount if permissions are options
      tracefs: Still use mount point as default permissions for instances
      eventfs: Do not differentiate the toplevel events directory
      eventfs: Do not treat events directory different than other directori=
es
      eventfs: Have "events" directory get permissions from its parent

Sung Joon Kim (1):
      drm/amd/display: Disable seamless boot on 128b/132b encoding

Sven Schnelle (2):
      workqueue: Fix selection of wake_cpu in kick_pool()
      s390/3270: Fix buffer assignment

Swapnil Patel (1):
      drm/amd/display: Add dtbclk access to dcn315

Takashi Iwai (2):
      ALSA: hda/realtek: Fix conflicting PCI SSID 17aa:386f for Lenovo
Legion models
      ALSA: hda/realtek: Fix build error without CONFIG_PM

Takashi Sakamoto (1):
      firewire: ohci: fulfill timestamp for some local asynchronous transac=
tion

Tejun Heo (1):
      workqueue: The default node_nr_active should have its max set to
max_active

Thanassis Avgerinos (1):
      firewire: nosy: ensure user_length is taken into account when
fetching packet contents

Thinh Nguyen (2):
      usb: xhci-plat: Don't include xhci.h
      usb: dwc3: core: Prevent phy suspend during init

Thomas Gleixner (2):
      x86/apic: Don't access the APIC when disabling x2APIC
      x86/xen/smp_pv: Register the boot CPU APIC properly

Thomas Wei=C3=9Fschuh (1):
      misc/pvpanic-pci: register attributes via pci_driver

Thorsten Blum (1):
      tty: xtensa/iss: Use min() to fix Coccinelle warning

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      xdp: use flags field to disambiguate broadcast redirect

Uday Shankar (1):
      ublk: remove segment count and size limits

Uwe Kleine-K=C3=B6nig (1):
      Input: amimouse - mark driver struct with __refdata to prevent
section mismatch

Vasileios Amoiridis (2):
      iio: pressure: Fixes BME280 SPI driver data
      iio: pressure: Fixes SPI support for BMP3xx devices

Vicki Pfau (1):
      Input: xpad - add support for ASUS ROG RAIKIRI

Viken Dadhaniya (1):
      slimbus: qcom-ngd-ctrl: Add timeout for wait operation

Vitaly Lifshits (1):
      e1000e: change usleep_range to udelay in PHY mdic access

Wesley Cheng (1):
      usb: gadget: f_fs: Fix race between aio_cancel() and AIO request comp=
lete

Will Deacon (1):
      swiotlb: initialise restricted pool list_head when SWIOTLB_DYNAMIC=3D=
y

Xin Long (1):
      tipc: fix a possible memleak in tipc_buf_append

Xingyou Chen (1):
      docs/zh_CN: core-api: Update translation of workqueue.rst to 6.9-rc1

Xu Kuohai (2):
      bpf, arm64: Fix incorrect runtime stats
      riscv, bpf: Fix incorrect runtime stats

Yi Zhang (1):
      nvme: fix warn output about shared namespaces without
CONFIG_NVME_MULTIPATH

Yunsheng Lin (1):
      rxrpc: Fix using alignmask being zero for __page_frag_alloc_align()

Zack Rusin (2):
      drm/ttm: Print the memory decryption status just once
      drm/vmwgfx: Fix invalid reads in fence signaled events

Zeng Heng (1):
      pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

Zqiang (1):
      softirq: Fix suspicious RCU usage in __do_softirq()

end.to.start (1):
      ASoC: acp: Support microphone from device Acer 315-24p

