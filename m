Return-Path: <linux-kernel+bounces-235344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C544691D432
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 23:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB7E281366
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 21:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA24F215;
	Sun, 30 Jun 2024 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="URxnTwza"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B662C1BA
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719784538; cv=none; b=AdaPWRrSP8xmfrBdBkmDM/Lczmr6QLeQGiubiTZG/dhfqPtu9w1gEhzJIQfCeeQScQuDBMmvAzQJPt+BjnElb3jOMtN2yGJXywT5Bjpw8ui96pRWcOrIiKZp6fj5fq34HQVV+Z8UkJeq+hi+ztxWrs0GMKmmjuiIesAwxiezmEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719784538; c=relaxed/simple;
	bh=g4i3PKjjIiGjhWzRyZUmSfcdgKOocUbJ7pFmLd20owc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=sJWEutv8htd8aWFhKU15J5tJUZqzWsJGkg0SsGJ/N4RfbDH+P0TaNgKmm52so+XCr06XYHKQsy6F8KLUHLricqoDEOjViQwnFbdGMkF/LvGbEAqPRdZahmFNZaThN9gEWfJGmSwCZ16ontgUG52BQh91/Z8PUK3B+Gi6pUP18LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=URxnTwza; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso2703208a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719784534; x=1720389334; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1G+Hm4UnPcLeTLptrXv874dISpz8ZijWtl0fh55ljos=;
        b=URxnTwzaj6JhlNaexXDL+hSkNhfAQlCCc+lbxjAGbw683+wqY9OP/T3dF7SOayxRgN
         gHHnE3ij0Y2SPwmY4AX2rFDJ/0XcW2g09udxCiYD5K4xw8oopuwgezcBuvO2zvsmgUW3
         elamVBKZYvUioldFqULbYLQ93Su/agzThtHpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719784534; x=1720389334;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1G+Hm4UnPcLeTLptrXv874dISpz8ZijWtl0fh55ljos=;
        b=OIfE0gPUpHJAcZscRf8Mwp1e2oI/AMN5ylRxYgrAtuaeEqxV3NFCQrEWZ+lRku5q4I
         JzAj/gtvogHyUdx9ikt8hHeeCSMTSUz1nuzGwMxU2etxTUCDffkjd7moSJzcEzBKEeXi
         fEz9gzsBUYnIRqRew7sZwrOuVb/lGfpLc3r+w5MPqdrhf4TTV09WSczEdkM1VFp7e0xX
         IsZSIgz6fltb0PB8vtTIfEkGpVsSVHoTKzL+gw1cDtjU+NvsLx4BBkJPKS+jON0Qfo7G
         Ug3MPcm4GQ+P58gOcvF2SJqg9LsT4PmCdMNDX5d9WfSCeXZHnQg5NOW37uIi0ho4wet6
         zKHQ==
X-Gm-Message-State: AOJu0Yw5vb5nPRNPVmN5TrCBKUwNknXFEms98xz+5358vxrKWrBETZWp
	cInr9HFIHBlLCZLsipNXUzTbv4kupnz7HUHy/4NYjb8gUi4mBiYdpLaLKcO9YATFAbwoeGHEozR
	B3tFgwg==
X-Google-Smtp-Source: AGHT+IHZQi+iEnSwkcyS5ydJa98rM9yLu1sMqgeije1uVJig7jG2pB0t6fpooDSVRBxARKcVM3kiUw==
X-Received: by 2002:a17:907:971d:b0:a72:6fc3:9946 with SMTP id a640c23a62f3a-a75142d87bcmr283215566b.16.1719784533334;
        Sun, 30 Jun 2024 14:55:33 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ae84b3d8sm257853266b.121.2024.06.30.14.55.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 14:55:32 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a725282b926so239904866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:55:32 -0700 (PDT)
X-Received: by 2002:a17:907:ea6:b0:a72:7c0d:8fd6 with SMTP id
 a640c23a62f3a-a75142d8567mr307824466b.2.1719784532142; Sun, 30 Jun 2024
 14:55:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Jun 2024 14:55:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com>
Message-ID: <CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com>
Subject: Linux 6.10-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This release continues to be fairly calm, and rc6 looks pretty small.
It's also entirely just random small fixes spread all over, with no
bigger pattern.

Mostly drivers, but we've got some random arch fixlets from Arnd
(mostly compat syscall stuff), we've got some filesystem fixes (yes,
bcachefs again), some bpf stuff with selftests etc.

Nothing really stands out, with the possible exception of a series of
tty/serial reverts ("not ready yet, revert and we'll try again
later").

             Linus

---

Aapo Vienamo (1):
      gpio: graniterapids: Add missing raw_spinlock_init()

Adam Hawley (1):
      tools/power turbostat: Fix unc freq columns not showing with '-q' or =
'-l'

Adrian Hunter (2):
      mmc: sdhci: Do not invert write-protect twice
      mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()

Aivaz Latypov (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15-gw0xxx

Aleksandr Mishin (1):
      gpio: davinci: Validate the obtained number of IRQs

Alex Deucher (1):
      drm/amdgpu/atomfirmware: fix parsing of vram_info

Alexander Stein (1):
      Input: ads7846 - use spi_device_id table

Alexander Sverdlin (1):
      iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF

Alexandre Ghiti (1):
      riscv: patch: Flush the icache right after patching to avoid illegal =
insns

Alexei Starovoitov (5):
      bpf: Fix remap of arena.
      bpf: Fix the corner case with may_goto and jump to the 1st insn.
      selftests/bpf: Tests with may_goto and jumps to the 1st insn
      bpf: Fix may_goto with negative offset.
      selftests/bpf: Add tests for may_goto with negative offset.

Alibek Omarov (1):
      ASoC: rockchip: i2s-tdm: Fix trcm mode by setting clock on right mclk

Amadeusz S=C5=82awi=C5=84ski (5):
      ASoC: topology: Fix references to freed memory
      ASoC: Intel: avs: Fix route override
      ASoC: topology: Do not assign fields that are already set
      ASoC: topology: Clean up route loading
      ASoC: topology: Fix route memory corruption

Andrei Simion (1):
      ASoC: atmel: atmel-classd: Re-add dai_link->platform to fix card init

Andrew Bresticker (1):
      mm/memory: don't require head page for do_set_pmd()

Andrey Konovalov (1):
      kasan: fix bad call to unpoison_slab_object

Andy Chiu (1):
      riscv: stacktrace: convert arch_stack_walk() to noinstr

Armin Wolf (4):
      platform/x86: wireless-hotkey: Add support for LG Airplane Button
      platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
      platform/x86: lg-laptop: Change ACPI device id
      platform/x86: lg-laptop: Use ACPI device handle when evaluating WMAB/=
WMBB

Arnd Bergmann (16):
      watchdog: lenovo_se10_wdt: add HAS_IOPORT dependency
      ftruncate: pass a signed offset
      syscalls: fix compat_sys_io_pgetevents_time64 usage
      sparc: fix old compat_sys_select()
      sparc: fix compat recv/recvfrom syscalls
      parisc: use correct compat recv/recvfrom syscalls
      parisc: use generic sys_fanotify_mark implementation
      powerpc: restore some missing spu syscalls
      sh: rework sync_file_range ABI
      csky, hexagon: fix broken sys_sync_file_range
      hexagon: fix fadvise64_64 calling conventions
      s390: remove native mmap2() syscall
      syscalls: mmap(): use unsigned offset type consistently
      linux/syscalls.h: add missing __user annotations
      i2c: viai2c: turn common code into a proper module
      kallsyms: rework symbol lookup return codes

Aryan Srivastava (1):
      net: mvpp2: fill-in dev_port attribute

Bard Liao (2):
      ASoC: SOF: Intel: hda-dai: skip tlv for dspless mode
      ASoC: SOF: Intel: hda-dai: remove skip_tlv label

Bernhard Rosenkr=C3=A4nzer (1):
      staging: vchiq_debugfs: Fix build if CONFIG_DEBUG_FS is not set

Boyang Yu (1):
      nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LB=
A.

Chen Ni (2):
      can: kvaser_usb: fix return value for hif_usb_send_regout
      platform/mellanox: nvsw-sn2201: Add check for
platform_device_add_resources

Chen-Yu Tsai (1):
      ASoC: mediatek: mt8195: Add platform entry for ETDM1_OUT_BE dai link

Christoph Hellwig (2):
      nfs: drop the incorrect assertion in nfs_swap_rw()
      xfs: fix freeing speculative preallocations for preallocated files

Chuck Lever (1):
      SUNRPC: Fix backchannel reply, again

Claudiu Beznea (1):
      pinctrl: renesas: rzg2l: Use spin_{lock,unlock}_irq{save,restore}

Crescent Hsieh (1):
      tty: serial: 8250: Fix port count mismatch with the device

Dan Carpenter (1):
      usb: musb: da8xx: fix a resource leak in probe()

Daniel Borkmann (2):
      bpf: Fix overrunning reservations in ringbuf
      selftests/bpf: Add more ring buffer test coverage

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN912 compositions

Daniil Dulov (1):
      xdp: Remove WARN() from __xdp_reg_mem_model()

Darrick J. Wong (4):
      xfs: restrict when we try to align cow fork delalloc to cowextsz hint=
s
      xfs: allow unlinked symlinks and dirs with zero size
      xfs: fix direction in XFS_IOC_EXCHANGE_RANGE
      xfs: honor init_xattrs in xfs_init_new_inode for !ATTR fs

David Arcari (1):
      tools/power turbostat: option '-n' is ambiguous

David Lechner (1):
      counter: ti-eqep: enable clock at probe

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix hysteresis representation

Diogo Ivo (1):
      usb: typec: ucsi_acpi: Add LG Gram quirk

Dirk Su (1):
      ALSA: hda/realtek: fix mute/micmute LEDs don't work for
EliteBook 645/665 G11.

Dmitry Baryshkov (1):
      MAINTAINERS: copy linux-arm-msm for sound/qcom changes

Doug Brown (1):
      Revert "serial: core: only stop transmit when HW fifo is empty"

Dragan Simic (1):
      kbuild: Install dtb files as 0644 in Makefile.dtbinst

Elinor Montmasson (1):
      ASoC: fsl-asoc-card: set priv->pdev before using it

Enguerrand de Ribaucourt (3):
      net: phy: micrel: add Microchip KSZ 9477 to the device table
      net: dsa: microchip: use collision based back pressure mode
      net: dsa: microchip: monitor potential faults in half-duplex mode

Eric Dumazet (1):
      net: add softirq safety to netdev_rename_lock

Fabrice Gasnier (1):
      usb: ucsi: stm32: fix command completion handling

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Ferry Toth (2):
      Revert "usb: gadget: u_ether: Re-attach netif device to mirror detach=
ment"
      Revert "usb: gadget: u_ether: Replace netif_stop_queue with
netif_device_detach"

Filipe Manana (2):
      btrfs: use NOFS context when getting inodes during logging and log re=
play
      btrfs: qgroup: fix quota root leak after quota disable failure

Frank Li (1):
      dt-bindings: net: fman: remove ptp-timer from required list

Greg Kroah-Hartman (9):
      Revert "serial: core: Fix ifdef for serial base console functions"
      Revert "serial: 8250: Fix add preferred console for
serial8250_isa_init_ports()"
      Revert "Documentation: kernel-parameters: Add DEVNAME:0.0 format
for serial ports"
      Revert "serial: 8250: Add preferred console in
serial8250_isa_init_ports()"
      Revert "serial: core: Handle serial console options"
      Revert "serial: core: Add support for DEVNAME:0.0 style naming
for kernel console"
      Revert "printk: Flag register_console() if console is set on command =
line"
      Revert "printk: Don't try to parse DEVNAME:0.0 console options"
      Revert "printk: Save console options for add_preferred_console_match(=
)"

Guillaume Nault (1):
      vxlan: Pull inner IP header in vxlan_xmit_one().

Hagar Hemdan (1):
      pinctrl: fix deadlock in create_pinctrl() when handling -EPROBE_DEFER

Halil Pasic (1):
      s390/virtio_ccw: Fix config change notifications

Hangbin Liu (1):
      bonding: fix incorrect software timestamping report

Hannes Reinecke (3):
      nvmet: do not return 'reserved' for empty TSAS values
      nvme: fixup comment for nvme RDMA Provider Type
      nvmet: make 'tsas' attribute idempotent for RDMA

Heiko Carstens (1):
      s390/sclp: Fix sclp_init() cleanup on failure

Hsin-Te Yuan (1):
      ASoC: mediatek: mt8183-da7219-max98357: Fix kcontrol name collision

Huacai Chen (3):
      irqchip/loongson-eiointc: Use early_cpu_to_node() instead of cpu_to_n=
ode()
      irqchip/loongson-liointc: Set different ISRs for different cores
      cpu: Fix broken cmdline "nosmp" and "maxcpus=3D0"

Huang-Huang Bao (4):
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO2-B pins
      pinctrl: rockchip: fix pinmux bits for RK3328 GPIO3-B pins
      pinctrl: rockchip: use dedicated pinctrl type for RK3328
      pinctrl: rockchip: fix pinmux reset in rockchip_pmx_set

Ian Ray (1):
      gpio: pca953x: fix pca953x_irq_bus_sync_unlock race

Ido Schimmel (2):
      mlxsw: pci: Fix driver initialization with Spectrum-4
      mlxsw: spectrum_buffers: Fix memory corruptions on Spectrum-4 systems

Ilpo J=C3=A4rvinen (2):
      mmc: sdhci-pci: Convert PCIBIOS_* return codes to errnos
      mmc: sdhci-pci-o2micro: Convert PCIBIOS_* return codes to errnos

Jack Yu (3):
      ASoC: rt722-sdca-sdw: add silence detection register as volatile
      ASoC: rt722-sdca-sdw: add debounce time for type detection
      ASoC: rt5645: fix issue of random interrupt from push-button

Jai Luthra (2):
      ALSA: dmaengine: Synchronize dma channel after drop()
      ASoC: ti: davinci-mcasp: Set min period size using FIFO config

Jan Kara (1):
      ocfs2: fix DIO failure due to insufficient transaction credits

Jan Sokolowski (1):
      ice: Rebuild TC queues on VSI queue reconfiguration

Jann Horn (1):
      drm/drm_file: Fix pid refcounting race

Janusz Krzysztofik (1):
      drm/i915/gt: Fix potential UAF by revoke of fence registers

Jarkko Sakkinen (1):
      MAINTAINERS: TPM DEVICE DRIVER: update the W-tag

Javier Carrasco (1):
      usb: typec: ucsi: glink: fix child node release in probe function

Jean-Michel Hautbois (1):
      tty: mcf: MCF54418 has 10 UARTS

Jeff Johnson (9):
      ASoC: mxs: add missing MODULE_DESCRIPTION() macro
      ASoC: fsl: add missing MODULE_DESCRIPTION() macro
      ASoC: qcom: add missing MODULE_DESCRIPTION() macro
      watchdog: add missing MODULE_DESCRIPTION() macros
      nvme-apple: add missing MODULE_DESCRIPTION()
      platform/x86/siemens: add missing MODULE_DESCRIPTION() macros
      platform/x86/intel: add missing MODULE_DESCRIPTION() macros
      platform/x86: add missing MODULE_DESCRIPTION() macros
      string: kunit: add missing MODULE_DESCRIPTION() macros

Jeff Xu (1):
      /proc/pid/smaps: add mseal info for vma

Jens Axboe (2):
      io_uring: remove dead struct io_submit_state member
      io_uring: signal SQPOLL task_work with TWA_SIGNAL_NO_IPI

Jens Remus (1):
      s390/boot: Do not adjust GOT entries for undef weak sym

Jeremy Kerr (1):
      usb: gadget: aspeed_udc: fix device address configuration

Jesse Taube (1):
      RISC-V: fix vector insn load/store width mask

Jianguo Wu (1):
      netfilter: fix undefined reference to 'netfilter_lwtunnel_*'
when CONFIG_SYSCTL=3Dn

Joel Granados (1):
      kbuild: scripts/gdb: bring the "abspath" back

Joerg Roedel (1):
      MAINTAINERS: Update IOMMU tree location

Johan Hovold (2):
      pinctrl: qcom: spmi-gpio: drop broken pm8008 support
      dt-bindings: pinctrl: qcom,pmic-gpio: drop pm8008

John Keeping (1):
      Input: ili210x - fix ili251x_read_touch_data() return value

Jonas Gorski (2):
      serial: core: introduce uart_port_tx_limited_flags()
      serial: bcm63xx-uart: fix tx after conversion to uart_port_tx_limited=
()

Jonathan Denose (1):
      Input: elantech - fix touchpad state on resume for Lenovo N24

Jos Wang (1):
      usb: dwc3: core: Workaround for CSR read timeout

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: improve link status logs

Julia Zhang (1):
      drm/amdgpu: avoid using null object of framebuffer

Kamal Dasu (1):
      mmc: sdhci-brcmstb: check R1_STATUS for erase/trim/discard

Ke Sun (1):
      iio: dac: fix ad9739a random config compile error

Kees Cook (1):
      randomize_kstack: Remove non-functional per-arch entropy filtering

Kent Gibson (2):
      gpiolib: cdev: Disallow reconfiguration without direction (uAPI v1)
      gpiolib: cdev: Ignore reconfiguration without direction

Kent Overstreet (10):
      bcachefs: Fix freeing of error pointers
      bcachefs: fix seqmutex_relock()
      bcachefs: Make btree_deadlock_to_text() clearer
      closures: closure_get_not_zero(), closure_return_sync()
      bcachefs: Fix race between trans_put() and btree_transactions_read()
      bcachefs: Fix btree_trans list ordering
      bcachefs: Add missing recalc_capacity() call
      bcachefs: Fix null ptr deref in journal_pins_to_text()
      bcachefs: Add missing bch2_journal_do_writes() call
      bcachefs: Discard, invalidate workers are now per device

Kieran Bingham (1):
      staging: vc04_services: vchiq_arm: Fix initialisation check

Kory Maincent (2):
      net: pse-pd: Kconfig: Fix missing firmware loader config select
      netlink: specs: Fix pse-set command attributes

Kuniyuki Iwashima (12):
      selftest: af_unix: Add Kconfig file.
      selftest: af_unix: Remove test_unix_oob.c.
      selftest: af_unix: Add msg_oob.c.
      af_unix: Stop recv(MSG_PEEK) at consumed OOB skb.
      af_unix: Don't stop recv(MSG_DONTWAIT) if consumed OOB skb is at the =
head.
      selftest: af_unix: Add non-TCP-compliant test cases in msg_oob.c.
      af_unix: Don't stop recv() at consumed ex-OOB skb.
      selftest: af_unix: Add SO_OOBINLINE test cases in msg_oob.c
      selftest: af_unix: Check SIGURG after every send() in msg_oob.c
      selftest: af_unix: Check EPOLLPRI after every send()/recv() in msg_oo=
b.c
      af_unix: Fix wrong ioctl(SIOCATMARK) when consumed OOB skb is at the =
head.
      selftest: af_unix: Check SIOCATMARK after every send()/recv() in
msg_oob.c.

Li Ma (1):
      drm/amd/swsmu: add MALL init support workaround for smu_v14_0_1

Lijo Lazar (2):
      drm/amdgpu: Fix pci state save during mode-1 reset
      drm/amdgpu: Don't show false warning for reg list

Linus L=C3=BCssing (1):
      Revert "batman-adv: prefer kfree_rcu() over call_rcu() with
free-only callbacks"

Linus Torvalds (3):
      x86: stop playing stack games in profile_pc()
      x86-32: fix cmpxchg8b_emu build error with clang
      Linux 6.10-rc6

Linus Walleij (1):
      Revert "mmc: moxart-mmc: Use sg_miter for PIO"

Liu Ying (1):
      drm/panel: simple: Add missing display timing flags for KOE TX26D202V=
M0BWA

Lu Baolu (1):
      iommu/vt-d: Fix missed device TLB cache tag

Luke D. Jones (1):
      Input: xpad - add support for ASUS ROG RAIKIRI PRO

Ma Ke (3):
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_hd_=
modes
      drm/nouveau/dispnv04: fix null pointer dereference in nv17_tv_get_ld_=
modes
      net: mana: Fix possible double free in error handling path

Maciej Strozek (1):
      ASoC: cs42l43: Increase default type detect time and button delay

Mark-PK Tsai (1):
      kbuild: doc: Update default INSTALL_MOD_DIR from extra to updates

Masahiro Yamada (1):
      kbuild: rpm-pkg: fix build error with CONFIG_MODULES=3Dn

Matt Bobrowski (1):
      bpf: Update BPF LSM maintainer list

Meng Li (1):
      usb: dwc3: core: remove lock of otg mode during gadget
suspend/resume to avoid deadlock

Michael Strauss (1):
      drm/amd/display: Send DP_TOTAL_LTTPR_CNT during detection if
LTTPR is present

Mostafa Saleh (1):
      PCI/MSI: Fix UAF in msi_capability_init

Naohiro Aota (1):
      btrfs: zoned: fix initial free space detection

Nathan Chancellor (2):
      nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[]
      tty: mxser: Remove __counted_by from mxser_board.ports[]

Neal Cardwell (1):
      tcp: fix tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TF=
O

NeilBrown (2):
      nfsd: initialise nfsd_info.mutex early.
      Revert "nfsd: fix oops when reading pool_stats before server is start=
ed"

Nick Child (2):
      ibmvnic: Free any outstanding tx skbs during scrq reset
      ibmvnic: Add tx check to prevent skb leak

Nicolas Schier (1):
      kbuild: Use $(obj)/%.cc to fix host C++ module builds

Nikita Zhandarovich (1):
      usb: atm: cxacru: fix endpoint checking in cxacru_bind()

Niklas Cassel (5):
      ata: libata-core: Add ATA_HORKAGE_NOLPM for all Crucial BX SSD1 model=
s
      ata: libata-core: Fix null pointer dereference on error
      ata,scsi: libata-core: Do not leak memory for ata_port struct members
      ata: libata-core: Fix double free on error
      ata: ahci: Clean up sysfs file on error

Niklas Schnelle (1):
      s390/pci: Add missing virt_to_phys() for directed DIBV

Oleksij Rempel (2):
      net: can: j1939: enhanced error handling for tightly received
RTS messages in xtp_rx_rts_session_new
      net: can: j1939: recover socket queue on CAN bus error during
BAM transmission

Oliver Neukum (2):
      usb: gadget: printer: SS+ support
      usb: gadget: printer: fix races against disable

Pablo Neira Ayuso (1):
      netfilter: nf_tables: fully validate NFT_DATA_VALUE on store to
data registers

Patryk Wlazlyn (1):
      tools/power turbostat: Add local build_bug.h header for snapshot targ=
et

Pei Li (3):
      bcachefs: slab-use-after-free Read in bch2_sb_errors_from_cpu
      bcachefs: Fix shift-out-of-bounds in bch2_blacklist_entries_gc
      bcachefs: Fix kmalloc bug in __snapshot_t_mut

Peter Ujfalusi (1):
      ASoC: SOF: sof-audio: Skip unprepare for in-use widgets on error roll=
back

Phil Chang (1):
      hrtimer: Prevent queuing of hrtimer without a function callback

Primoz Fiser (1):
      ASoC: ti: omap-hdmi: Fix too long driver name

Qu Wenruo (1):
      btrfs: scrub: handle RST lookup error correctly

Rafael J. Wysocki (2):
      cpufreq: intel_pstate: Use HWP to initialize ITMT if CPPC is missing
      thermal: gov_step_wise: Go straight to instance->lower when
mitigation is over

Ratheesh Kannoth (1):
      octeontx2-pf: Fix coverity and klockwork issues in octeon PF driver

Richard Fitzgerald (1):
      ASoC: cs35l56: Disconnect ASP1 TX sources when ASP1 DAI is hooked up

Ryan Roberts (1):
      arm64: mm: Permit PTE SW bits to change in live mappings

Sean Anderson (1):
      iio: xilinx-ams: Don't include ams_ctrl_channels in scan_mask

Shannon Nelson (2):
      net: remove drivers@pensando.io from MAINTAINERS
      ionic: use dev_consume_skb_any outside of napi

Shengjiu Wang (1):
      ALSA: dmaengine_pcm: terminate dmaengine before synchronize

Shigeru Yoshida (1):
      net: can: j1939: Initialize unused data in j1939_send_one()

Shuming Fan (1):
      ASoC: Intel: soc-acpi: mtl: fix speaker no sound on Dell SKU 0C64

Srinivas Kandagatla (1):
      ASoC: q6apm-lpass-dai: close graph on prepare errors

Stefan Eichenberger (1):
      serial: imx: set receiver level before starting uart

Stefan Wahren (1):
      pinctrl: bcm2835: Fix permissions of persist_gpio_outputs

Stephen Brennan (1):
      mm: convert page type macros to enum

Suren Baghdasaryan (2):
      mm/slab: fix 'variable obj_exts set but not used' warning
      mm: handle profiling for fake memory allocations during compaction

Sven Eckelmann (1):
      batman-adv: Don't accept TT entries for out-of-spec VIDs

Taehee Yoo (1):
      ionic: fix kernel panic due to multi-buffer handling

Takashi Iwai (4):
      ALSA: seq: Fix missing channel at encoding RPN/NRPN MIDI2 messages
      ALSA: PCM: Allow resume only for suspended streams
      ALSA: hda/realtek: Fix conflicting quirk for PCI SSID 17aa:3820
      ALSA: seq: Fix missing MSB in MIDI2 SPP conversion

Tejun Heo (1):
      workqueue: Refactor worker ID formatting and make
wq_worker_comm() use full ID string

Thayne Harbaugh (1):
      kbuild: Fix build target deb-pkg: ln: failed to create hard link

Thomas GENTY (1):
      bytcr_rt5640 : inverse jack detect for Archos 101 cesium

Thomas Richard (1):
      pinctrl: tps6594: add missing support for LP8764 PMIC

Thomas Zimmermann (1):
      drm/fbdev-dma: Only set smem_start is enable per module option

Tobias Jakobi (1):
      Input: i8042 - add Ayaneo Kun to i8042 quirk table

Tristram Ha (2):
      net: dsa: microchip: fix initial port flush problem
      net: dsa: microchip: fix wrong register write when masking interrupt

Udit Kumar (1):
      serial: 8250_omap: Implementation of Errata i2310

Vasant Hegde (2):
      iommu/amd: Invalidate cache before removing device from domain list
      iommu/amd: Fix GT feature enablement again

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

Vijendar Mukunda (3):
      ASoC: amd: acp: add a null check for chip_pdev structure
      ASoC: amd: acp: remove i2s configuration check in acp_i2s_probe()
      ASoC: amd: acp: move chip->flag variable assignment

Vitor Soares (1):
      can: mcp251xfd: fix infinite loop when xmit fails

Vyacheslav Frantsishko (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS M5602RA

Wenchao Hao (1):
      workqueue: Increase worker desc's length to 32

Wolfram Sang (2):
      i2c: testunit: don't erase registers after STOP
      i2c: testunit: discard write requests while old command is running

Xin Long (1):
      openvswitch: get related ct labels from its master if it is not confi=
rmed

Xin Zeng (1):
      crypto: qat - fix linking errors when PCI_IOV is disabled

Yonghong Song (3):
      bpf: Add missed var_off setting in set_sext32_default_val()
      bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
      selftests/bpf: Add a few tests to cover

Yunseong Kim (1):
      tracing/net_sched: NULL pointer dereference in perf_trace_qdisc_reset=
()

Yuntao Wang (1):
      cpu/hotplug: Fix dynstate assignment in __cpuhp_setup_state_cpuslocke=
d()

Zenghui Yu (1):
      arm64: Clear the initial ID map correctly before remapping

Zhang Yi (1):
      ASoC: codecs: ES8326: Solve headphone detection issue

Zhaoyang Huang (1):
      mm: fix incorrect vbq reference in purge_fragmented_block

Zi Yan (1):
      mm/migrate: make migrate_pages_batch() stats consistent

aigourensheng (1):
      selftests/mm:fix test_prctl_fork_exec return failure

luoxuanqiang (1):
      Fix race for duplicate reqsk on identical SYN

yangge (1):
      mm/page_alloc: Separate THP PCP into movable and non-movable categori=
es

