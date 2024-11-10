Return-Path: <linux-kernel+bounces-403398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC309C351A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD76B21145
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 22:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DCF15855C;
	Sun, 10 Nov 2024 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fVhyML3V"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62CDDD9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731278069; cv=none; b=NLxXru1fA7L7G8hBTTlK4mNl7kwyykN7KFGsKrTF57+Pofruqu0eUcDq2Sl3uGM7Wh7DG+n1xUCuxWG2iXjy8RDtbwsqYgOHBfnrhTv9PJHHq8+6rimJsb/5G+Po+osl/AYsBvMii1zMnTeHfnYMb5dkWrgE+9Z9Wlb8uHZB6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731278069; c=relaxed/simple;
	bh=LEFXtkx6Vpagf6ucXz4e634qy4tfGRtIa7nlpXp8aH8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eHTFDdOtQn+wyAzzQkoNR0FHMilFHvE9+guGHIkkQgkLeLYmW0zkGRdndIMBzZpZaZaakft2/Jz2684RWaC5kuFSwoLleG1RTnTT9bmT/Amr6XMehrHPoV1Md0l3g/dDGuQdukZkLH+WpDil0UvII8jocIclJFZFqs8O6XCJr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fVhyML3V; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4825506a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731278065; x=1731882865; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+1x6utunfvgNzApR86eVp3YjlHW1HOakAjQZcyy9rDo=;
        b=fVhyML3V6KOBtk1bgQNsWtWqHc6EbnZEme63Fwyw3h3Y3X9YI3rnSAyAKouIKzOcxQ
         ppHUemBEQtGrLXUrUk7xyd9GlBTlJ+hXrc8VefgLJGgqOeuStRGhD9PGH0aGd6snRts5
         c5dzJ1tuGRAjQkwWH+qpLek4q1OA/6LbOe3LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731278065; x=1731882865;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1x6utunfvgNzApR86eVp3YjlHW1HOakAjQZcyy9rDo=;
        b=QViT1Ybj8jlNSFz3e4gn+Q98cIpeI9YLL0A5pCQu+uypK/KlX4M54WsxpZxx0BSEXP
         qeIga5yM4ddjK5HBuU7QWcLhWnn7YS8i18nzSdP7YsrTJgQRqDUJ3qyykhbpHFKfJ5q1
         k8gJiu4R0sjcTM3sp919tfdee9yIjl6pV4Y5KestfgWmR5aalDkUHppLV/AEU35PmU7d
         R6uy2+5v/2tAWVzJb5KepuOVNfpzAooq7abMfcBz+8izeVxNdz/SfJUYyWiLrM8RnsZ5
         7oalezavpl4PiQrr1yFB1Glhfrzsi562oXA2VLpXA3lRqnjB84Wjd+6AGIytwGBUbUGI
         +MuA==
X-Gm-Message-State: AOJu0YxHjaKbfV32IUBsGrExbJT2IaHshZQr0iTgGRAjdLFDkwd7LqGb
	65jj7CFQb8F20k64RSy4AyXoBwkqLSpeHBQsT/cekSLoWMNR+CeAtK1Jgt9XmrZ1L8OXPlS9YIA
	zbIM=
X-Google-Smtp-Source: AGHT+IGYlzqGPCgd/5zauYZFkCm6BSLU8MYqXS+WfnRHzgGYArS3SvSgVaNYsagrRmd94QBIiNLL3Q==
X-Received: by 2002:a05:6402:2549:b0:5cf:448a:53c5 with SMTP id 4fb4d7f45d1cf-5cf448a5618mr105443a12.9.1731278064704;
        Sun, 10 Nov 2024 14:34:24 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d763sm4281786a12.7.2024.11.10.14.34.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 14:34:23 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a99eb8b607aso572155866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 14:34:22 -0800 (PST)
X-Received: by 2002:a17:907:728d:b0:a99:eb94:3e37 with SMTP id
 a640c23a62f3a-a9ef002177amr1098124566b.58.1731278061932; Sun, 10 Nov 2024
 14:34:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Nov 2024 14:34:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWK-GCmFGNqknDZzWMZM-u58tmP=jZ9ooTo9b8NURvgQ@mail.gmail.com>
Message-ID: <CAHk-=wiWK-GCmFGNqknDZzWMZM-u58tmP=jZ9ooTo9b8NURvgQ@mail.gmail.com>
Subject: Linux 6.12-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

No big surprises, and I think everything is on track for a final 6.12
release next weekend.

We've got the usual random driver updates (with gpu and networking
dominating - no surprises there either). The arch updates are mostly
devicetree fixes, and we have some filesystem fixes (bcachefs, btrfs,
nfs,  smb).

Some core mm changes, mostly around error handling corner cases.

Please give this some final "kick the tires" love,

               Linus

---

Abel Vesa (3):
      arm64: dts: qcom: x1e80100: Add Broadcast_AND region in LLCC block
      arm64: dts: qcom: x1e80100: Fix PCIe 6a lanes description
      clk: qcom: gcc-x1e80100: Fix USB MP SS1 PHY GDSC pwrsts flags

Aleksandr Loktionov (1):
      i40e: fix race condition by adding filter's intermediate sync state

Alex Deucher (3):
      drm/amdgpu: Adjust debugfs register access permissions
      drm/amdgpu: Adjust debugfs eviction and IB access permissions
      drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()

Alexander H=C3=B6lzl (1):
      can: j1939: fix error in J1939 documentation.

Alexander Stein (1):
      arm64: dts: imx8-ss-vpu: Fix imx8qm VPU IRQs

Amelie Delaunay (1):
      ASoC: stm32: spdifrx: fix dma channel release in stm32_spdifrx_remove

Andrei Vagin (1):
      ucounts: fix counter leak in inc_rlimit_get_ucounts()

Andrew Kanner (1):
      ocfs2: remove entry once instead of null-ptr-dereference in
ocfs2_xa_remove()

Antonio Quartulli (1):
      drm/amdgpu: prevent NULL pointer dereference if ATIF is not supported

Aurabindo Pillai (1):
      drm/amd/display: parse umc_info or vram_info based on ASIC

Balasubramani Vivekanandan (2):
      drm/xe: Set mask bits for CCS_MODE register
      drm/xe: Use the filelist from drm for ccs_mode change

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (1):
      clk: qcom: clk-alpha-pll: Fix pll post div mask when width is not set

Bart Van Assche (1):
      scsi: ufs: core: Start the RTC update work later

Bartosz Golaszewski (1):
      firmware: qcom: scm: fix a NULL-pointer dereference

Ben Chuang (2):
      mmc: sdhci-pci-gli: GL9767: Fix low power mode on the set clock funct=
ion
      mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express proc=
ess

Beno=C3=AEt Monin (1):
      USB: serial: option: add Quectel RG650V

Bjorn Andersson (2):
      rpmsg: glink: Handle rejected intent request better
      soc: qcom: pmic_glink: Handle GLINK intent allocation rejections

Brendan King (2):
      drm/imagination: Add a per-file PVR context list
      drm/imagination: Break an object reference loop

Breno Leitao (1):
      nvme/host: Fix RCU list traversal to use SRCU primitive

Charles Han (1):
      soc: qcom: Add check devm_kasprintf() returned value

Chen Ridong (1):
      security/keys: fix slab-out-of-bounds in key_task_permission

ChiYuan Huang (1):
      regulator: rtq2208: Fix uninitialized use of regulator_config

Chuck Lever (1):
      NFSD: Fix READDIR on NFSv3 mounts of ext4 exports

Conor Dooley (3):
      firmware: microchip: auto-update: fix poll_complete() to not
report spurious timeout errors
      riscv: dts: starfive: disable unused csi/camss nodes
      MAINTAINERS: invert Misc RISC-V SoC Support's pattern

Corey Hickey (1):
      platform/x86/amd/pmc: Detect when STB is not available

Cristian Ciocaltea (1):
      arm64: dts: rockchip: Drop invalid clock-names from es8388 codec node=
s

Cristian Marussi (3):
      firmware: arm_scmi: Reject clear channel request on A2P
      dt-bindings: firmware: arm,scmi: Add missing vendor string
      firmware: arm_scmi: Use vendor string in max-rx-timeout-ms

Dan Carpenter (2):
      USB: serial: io_edgeport: fix use after free in debug printk
      usb: typec: fix potential out of bounds in
ucsi_ccg_update_set_new_cam_cmd()

Dario Binacchi (1):
      can: c_can: fix {rx,tx}_errors statistics

David Gstir (1):
      KEYS: trusted: dcp: fix NULL dereference in AEAD crypto operation

David Howells (1):
      rxrpc: Fix missing locking causing hanging calls

David Wang (1):
      proc/softirqs: replace seq_printf with seq_put_decimal_ull_width

Diederik de Haas (4):
      arm64: dts: rockchip: Remove hdmi's 2nd interrupt on rk3328
      arm64: dts: rockchip: Fix wakeup prop names on PineNote BT node
      arm64: dts: rockchip: Fix reset-gpios property on brcm BT nodes
      arm64: dts: rockchip: Correct GPIO polarity on brcm BT nodes

Diogo Silva (2):
      arm64: dts: imx8: Fix lvds0 device tree
      net: phy: ti: add PHY_RST_AFTER_CLK_EN flag

Dmitry Baryshkov (2):
      arm64: dts: qcom: sm8450 fix PIPE clock specification for pcie1
      thermal/drivers/qcom/lmh: Remove false lockdep backtrace

Dragan Simic (2):
      arm64: dts: rockchip: Move L3 cache outside CPUs in RK3588(S) SoC dts=
i
      arm64: dts: rockchip: Start cooling maps numbering from zero on ROCK =
5B

E Shattow (1):
      riscv: dts: starfive: Update ethernet phy0 delay parameter
values for Star64

Emil Dahl Juhl (1):
      tools/lib/thermal: Fix sampling handler context ptr

Eric Dumazet (1):
      net/smc: do not leave a dangling sk pointer in __smc_create()

Erik Schumacher (1):
      pwm: imx-tpm: Use correct MODULO value for EPWM mode

Fabien Parent (1):
      arm64: dts: qcom: msm8939: revert use of APCS mbox for RPM

Filipe Manana (1):
      btrfs: reinitialize delayed ref list after deleting it from the list

Florian Fainelli (1):
      MAINTAINERS: Remove self from DSA entry

Gautam Menghani (1):
      KVM: PPC: Book3S HV: Mask off LPCR_MER for a vCPU before running
it to avoid spurious interrupts

Geert Uytterhoeven (3):
      arm64: dts: rockchip: Fix rt5651 compatible value on rk3399-eaidk-610
      arm64: dts: rockchip: Fix rt5651 compatible value on
rk3399-sapphire-excavator
      can: rockchip_canfd: CAN_ROCKCHIP_CANFD should depend on ARCH_ROCKCHI=
P

Geliang Tang (1):
      mptcp: use sock_kfree_s instead of kfree

Haibo Chen (1):
      arm64: dts: imx8ulp: correct the flexspi compatible string

Haisu Wang (1):
      btrfs: fix the length of reserved qgroup to free

Hans Verkuil (2):
      media: dvb-core: add missing buffer index check
      media: vivid: fix buffer overwrite when using > 32 buffers

Hans de Goede (1):
      drm: panel-orientation-quirks: Make Lenovo Yoga Tab 3 X90F DMI
match less strict

Heiko Stuebner (13):
      arm64: dts: rockchip: fix i2c2 pinctrl-names property on anbernic-rg3=
53p/v
      arm64: dts: rockchip: Drop regulator-init-microvolt from two boards
      arm64: dts: rockchip: Fix bluetooth properties on rk3566 box demo
      arm64: dts: rockchip: Fix bluetooth properties on Rock960 boards
      arm64: dts: rockchip: Remove undocumented supports-emmc property
      arm64: dts: rockchip: Remove #cooling-cells from fan on Theobroma lio=
n
      arm64: dts: rockchip: Fix LED triggers on rk3308-roc-cc
      arm64: dts: rockchip: remove num-slots property from
rk3328-nanopi-r2s-plus
      arm64: dts: rockchip: remove orphaned pinctrl-names from pinephone pr=
o
      ARM: dts: rockchip: fix rk3036 acodec node
      ARM: dts: rockchip: drop grf reference from rk3036 hdmi
      ARM: dts: rockchip: Fix the spi controller on rk3036
      ARM: dts: rockchip: Fix the realtek audio codec on rk3036-kylin

Hongbo Li (1):
      bcachefs: check the invalid parameter for perf test

Hugh Dickins (2):
      mm/thp: fix deferred split queue not partially_mapped
      mm/thp: fix deferred split unqueue naming and locking

Icenowy Zheng (1):
      thermal/of: support thermal zones w/o trips subnode

Jack Wu (1):
      USB: serial: qcserial: add support for Sierra Wireless EM86xx

Jakub Kicinski (1):
      Revert "Merge branch 'there-are-some-bugfix-for-the-hns3-ethernet-dri=
ver'"

Jann Horn (1):
      drm/panthor: Be stricter about IO mapping flags

Jarkko Sakkinen (1):
      tpm: Lock TPM chip in tpm_pm_suspend() first

Jaros=C5=82aw Janik (1):
      Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"

Jean Delvare (1):
      can: rockchip_canfd: Drop obsolete dependency on COMPILE_TEST

Jinjie Ruan (2):
      ksmbd: Fix the missing xa_store error check
      net: wwan: t7xx: Fix off-by-one error in t7xx_dpmaif_rx_buf_alloc()

Jiri Kosina (1):
      HID: core: zero-initialize the report buffer

Johan Hovold (12):
      arm64: dts: qcom: x1e80100: fix PCIe4 and PCIe6a PHY clocks
      arm64: dts: qcom: x1e80100: fix PCIe5 PHY clocks
      firmware: qcom: scm: suppress download mode error
      clk: qcom: videocc-sm8350: use HW_CTRL_TRIGGER for vcodec GDSCs
      arm64: dts: qcom: x1e78100-t14s: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100-crd: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100-vivobook-s15: fix nvme regulator boot glit=
ch
      arm64: dts: qcom: x1e80100-yoga-slim7x: fix nvme regulator boot glitc=
h
      arm64: dts: qcom: x1e80100-microsoft-romulus: fix nvme regulator
boot glitch
      arm64: dts: qcom: x1e80100-qcp: fix nvme regulator boot glitch
      arm64: dts: qcom: x1e80100: fix PCIe4 interconnect
      arm64: dts: qcom: x1e80100: fix PCIe5 interconnect

Johan Jonker (2):
      net: arc: fix the device for dma_map_single/dma_unmap_single
      net: arc: rockchip: fix emac mdio node support

Johannes Thumshirn (1):
      scsi: sd_zbc: Use kvzalloc() to allocate REPORT ZONES buffer

Jyri Sarha (1):
      ASoC: SOF: sof-client-probes-ipc4: Set param_size extension bits

Kalesh Singh (3):
      tracing: Fix tracefs mount options
      tracing: Document tracefs gid mount option
      tracing/selftests: Add tracefs mount options test

Kenneth Feng (2):
      drm/amd/pm: always pick the pptable from IFWI
      drm/amd/pm: correct the workload setting

Kent Overstreet (7):
      bcachefs: Fix null ptr deref in bucket_gen_get()
      bcachefs: Fix error handling in bch2_btree_node_prefetch()
      bcachefs: Ancient versions with bad bkey_formats are no longer suppor=
ted
      bcachefs: Fix topology errors on split after merge
      bcachefs: Ensure BCH_FS_may_go_rw is set before exiting recovery
      bcachefs: btree_cache.freeable list fixes
      bcachefs: Fix UAF in __promote_alloc() error path

Koichiro Den (1):
      mm/slab: fix warning caused by duplicate kmem_cache creation in
kmem_buckets_create

Konrad Dybcio (1):
      arm64: dts: qcom: x1e80100: Fix up BAR spaces

Kuninori Morimoto (1):
      MAINTAINERS: Generic Sound Card section

Kuniyuki Iwashima (1):
      smb: client: Fix use-after-free of network namespace.

Kurt Borja (2):
      platform/x86: dell-smbios-base: Extends support to Alienware products
      platform/x86: dell-wmi-base: Handle META key Lock/Unlock events

Lijo Lazar (1):
      drm/amdgpu: Fix DPX valid mode check on GC 9.4.3

Linus Torvalds (1):
      Linux 6.12-rc7

Liu Peibao (1):
      i2c: designware: do not hold SCL low when I2C_DYNAMIC_TAR_UPDATE
is not set

Liu Ying (1):
      arm64: dts: imx8mp-skov-revb-mi1010ait-1cp1: Assign "media_isp" clock=
 rate

Liviu Dudau (1):
      drm/panthor: Lock XArray when getting entries for the VM

Lorenzo Stoakes (5):
      mm: avoid unsafe VMA hook invocation when error arises on mmap hook
      mm: unconditionally close VMAs on error
      mm: refactor map_deny_write_exec()
      mm: refactor arch_calc_vm_flag_bits() and arm64 MTE handling
      mm: resolve faulty mmap_region() error path behaviour

Lucas De Marchi (1):
      drm/xe: Stop accumulating LRC timestamp on job_free

Luo Yifan (2):
      ASoC: stm: Prevent potential division by zero in
stm32_sai_mclk_round_rate()
      ASoC: stm: Prevent potential division by zero in stm32_sai_get_clk_di=
v()

Manikanta Mylavarapu (1):
      soc: qcom: socinfo: fix revision check in qcom_socinfo_probe()

Marc Kleine-Budde (3):
      can: m_can: m_can_close(): don't call free_irq() for IRQ-less devices
      can: mcp251xfd: mcp251xfd_ring_alloc(): fix coalescing
configuration when switching CAN modes
      can: mcp251xfd: mcp251xfd_get_tef_len(): fix length calculation

Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-bac=
k

Marcin Szycik (1):
      ice: Fix use after free during unload with ports in bridge

Marek Vasut (1):
      arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1 frequency to 506.8=
 MHz

Mario Limonciello (1):
      ACPI: processor: Move arch_init_invariance_cppc() call later

Mark Brown (1):
      arm64/sve: Discard stale CPU state when handling SVE traps

Mark Rutland (2):
      arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
      arm64: Kconfig: Make SME depend on BROKEN for now

Markus Petri (1):
      ASoC: amd: yc: Support dmic on another model of Lenovo Thinkpad E14 G=
en 6

Masami Hiramatsu (Google) (1):
      objpool: fix to make percpu slot allocation more robust

Mateusz Polchlopek (1):
      ice: change q_index variable type to s16 to store -1 value

Matthew Brost (2):
      drm/xe: Fix possible exec queue leak in exec IOCTL
      drm/xe: Drop VM dma-resv lock on xe_sync_in_fence_get failure in
exec IOCTL

Matthieu Baerts (NGI0) (1):
      mptcp: no admin perm to list endpoints

Mauro Carvalho Chehab (14):
      media: v4l2-ctrls-api: fix error handling for v4l2_g_ctrl()
      media: v4l2-tpg: prevent the risk of a division by zero
      media: dvbdev: prevent the risk of out of memory access
      media: dvb_frontend: don't play tricks with underflow values
      media: mgb4: protect driver against spectre
      media: av7110: fix a spectre vulnerability
      media: s5p-jpeg: prevent buffer overflows
      media: ar0521: don't overflow when checking PLL values
      media: cx24116: prevent overflows on SNR calculus
      media: adv7604: prevent underflow condition when reporting colorspace
      media: stb0899_algo: initialize cfr before using it
      media: cec: extron-da-hd-4k-plus: don't use -1 as an error code
      media: pulse8-cec: fix data timestamp at pulse8_setup()
      media: dvbdev: fix the logic when DVB_DYNAMIC_MINORS is not set

Maya Matuszczyk (1):
      arm64: dts: qcom: x1e80100-crd Rename "Twitter" to "Tweeter"

Ma=C3=ADra Canal (1):
      mm: fix docs for the kernel parameter ``thp_anon=3D``

Michal Wajdeczko (1):
      drm/xe/pf: Fix potential GGTT allocation leak

Mika Westerberg (2):
      thunderbolt: Add only on-board retimers when
!CONFIG_USB4_DEBUGFS_MARGINING
      thunderbolt: Fix connection issue with Pluggable UD-4VPD dock

Mike Snitzer (2):
      nfs_common: fix localio to cope with racing nfs_local_probe()
      nfs: avoid i_lock contention in nfs_clear_invalid_mapping

Mikhail Rudenko (1):
      regulator: rk808: Add apply_bit for BUCK3 on RK809

Mikulas Patocka (2):
      dm: fix a crash if blk_alloc_disk fails
      dm-verity: don't crash if panic_on_corruption is not selected

Ming-Hung Tsai (5):
      dm cache: correct the number of origin blocks to match the target len=
gth
      dm cache: fix flushing uninitialized delayed_work on cache_ctr error
      dm cache: fix out-of-bounds access to the dirty bitset when resizing
      dm cache: optimize dirty bit checking with find_next_bit when resizin=
g
      dm cache: fix potential out-of-bounds access on the first resume

Mingcong Bai (1):
      ASoC: amd: yc: fix internal mic on Xiaomi Book Pro 14 2022

Muhammad Usama Anjum (1):
      selftests: hugetlb_dio: check for initial conditions to skip in the s=
tart

Murad Masimov (1):
      ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()

Namjae Jeon (3):
      ksmbd: fix slab-use-after-free in ksmbd_smb2_session_create
      ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp
      ksmbd: check outstanding simultaneous SMB operations

NeilBrown (2):
      sunrpc: handle -ENOTCONN in xs_tcp_setup_socket()
      NFSv3: only use NFS timeout for MOUNT when protocols are compatible

Nirmoy Das (3):
      drm/xe: Move LNL scheduling WA to xe_device.h
      drm/xe/ufence: Flush xe ordered_wq in case of ufence timeout
      drm/xe/guc/tlb: Flush g2h worker in case of tlb timeout

N=C3=ADcolas F. R. A. Prado (1):
      net: stmmac: Fix unbalanced IRQ wake disable warning on single irq ca=
se

Pablo Neira Ayuso (1):
      netfilter: nf_tables: wait for rcu grace period on net_device removal

Pavan Kumar Linga (2):
      idpf: avoid vport access in idpf_get_link_ksettings
      idpf: fix idpf_vc_core_init error path

Pei Xiao (1):
      bcachefs: add check NULL return of bio_kmalloc in journal_read_bucket

Peiyang Wang (1):
      net: hns3: fix kernel crash when uninstalling driver

Peng Fan (1):
      arm64: dts: imx8mp: correct sdhc ipg clk

Philo Lu (4):
      virtio_net: Support dynamic rss indirection table size
      virtio_net: Add hash_key_length check
      virtio_net: Sync rss config to device when virtnet_probe
      virtio_net: Update rss when set queue

Piotr Zalewski (1):
      bcachefs: Change OPT_STR max to be 1 less than the size of choices ar=
ray

Qi Xi (1):
      fs/proc: fix compile warning about variable 'vmcore_mmap_ops'

Qiang Yu (1):
      clk: qcom: gcc-x1e80100: Fix halt_check for pipediv2 clocks

Qingqing Zhou (1):
      firmware: qcom: scm: Return -EOPNOTSUPP for unsupported SHM
bridge enabling

Qu Wenruo (1):
      btrfs: fix per-subvolume RO/RW flags with new mount API

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Clear hybrid_max_perf_cpu before driver
registration
      cpufreq: intel_pstate: Update asym capacity for CPUs that were
offline initially

Rajendra Nayak (1):
      EDAC/qcom: Make irq configuration optional

Raju Rangoju (1):
      MAINTAINERS: update AMD SPI maintainer

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FG132 0x0112 composition

Renato Caldas (1):
      platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys

Rex Nie (1):
      usb: typec: qcom-pmic: init value of hdr_len/txbuf_len earlier

Roberto Sassu (1):
      nfs: Fix KMSAN warning in decode_getfattr_attrs()

Roger Quadros (3):
      usb: dwc3: fix fault at system suspend if device was already
runtime suspended
      net: ethernet: ti: am65-cpsw: Fix multi queue Rx on J7
      net: ethernet: ti: am65-cpsw: fix warning in
am65_cpsw_nuss_remove_rx_chns()

Roman Gushchin (1):
      signal: restore the override_rlimit logic

Sam Edwards (1):
      arm64: dts: rockchip: Designate Turing RK1's system power controller

SeongJae Park (3):
      mm/damon/core: handle zero {aggregation,ops_update} intervals
      mm/damon/core: handle zero schemes apply interval
      mm/damon/core: avoid overflow in damon_feed_loop_next_input()

Shenghao Ding (1):
      ASoC: tas2781: Add new driver version for tas2563 & tas2781 qfn chip

Shyam Sundar S K (1):
      platform/x86/amd/pmf: Add SMU metrics table support for 1Ah
family 60h model

Simon Horman (1):
      MAINTAINERS: Qualcomm SoC: Match reserved-memory bindings

Stefan Wahren (1):
      net: vertexcom: mse102x: Fix possible double free of TX skb

Suraj Gupta (2):
      dt-bindings: net: xlnx,axi-ethernet: Correct phy-mode property value
      net: xilinx: axienet: Enqueue Tx packets in dql before dmaengine star=
ts

Takashi Iwai (2):
      ALSA: ump: Don't enumeration invalid groups for legacy rawmidi
      ALSA: usb-audio: Add quirk for HP 320 FHD Webcam

Thomas M=C3=BChlbacher (1):
      can: {cc770,sja1000}_isa: allow building on x86_64

Thorsten Blum (1):
      mailmap: add entry for Thorsten Blum

Tom Chung (1):
      drm/amd/display: Fix brightness level not retained over reboot

Trevor Gamblin (1):
      MAINTAINERS: add self as reviewer for AXI PWM GENERATOR

Trond Myklebust (3):
      NFS: Fix attribute delegation behaviour on exclusive create
      NFS: Further fixes to attribute delegation a/mtime changes
      filemap: Fix bounds checking in filemap_read()

Tudor Ambarus (1):
      media: videobuf2-core: copy vb planes unconditionally

Umang Jain (2):
      staging: vchiq_arm: Use devm_kzalloc() for vchiq_arm_state allocation
      staging: vchiq_arm: Use devm_kzalloc() for drv_mgmt allocation

Uwe Kleine-K=C3=B6nig (1):
      riscv: dts: Replace deprecated snps,nr-gpios property for
snps,dw-apb-gpio-port devices

Venkata Prasad Potturu (1):
      ASoC: SOF: amd: Fix for incorrect DMA ch status register offset

Vishnu Sankar (1):
      platform/x86: thinkpad_acpi: Fix for ThinkPad's with ECFW
showing incorrect fan speed

Vitaly Lifshits (1):
      e1000e: Remove Meteor Lake SMBUS workarounds

Vladimir Oltean (1):
      net: dpaa_eth: print FD status in CPU endianness in dpaa_eth_fd trace=
point

Wei Fang (2):
      net: enetc: set MAC address to the VF net_device
      net: enetc: allocate vf_state during PF probes

Wei Yang (1):
      mm/mlock: set the correct prev on failure

Wenjia Zhang (1):
      net/smc: Fix lookup of netdev by using ib_device_get_netdev()

Wentao Liang (1):
      drivers: net: ionic: add missed debugfs cleanup to ionic_probe()
error path

Xin Long (1):
      sctp: properly validate chunk size in sctp_sf_ootb()

Xinqi Zhang (1):
      firmware: arm_scmi: Fix slab-use-after-free in scmi_bus_notifier()

Yang Yingliang (1):
      i2c: muxes: Fix return value check in mule_i2c_mux_probe()

Yu Zhao (1):
      mm/page_alloc: keep track of free highatomic

Zichen Xie (1):
      dm-unstriped: cast an operand to sector_t to prevent potential
uint32_t overflow

Zijun Hu (1):
      usb: musb: sunxi: Fix accessing an released usb phy

zhang jiao (1):
      tools/lib/thermal: Remove the thermal.h soft link when doing make cle=
an

