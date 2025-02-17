Return-Path: <linux-kernel+bounces-516999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770FCA37ACD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789733AF4AB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BFB187872;
	Mon, 17 Feb 2025 05:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C4DHXgiY"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5DE18C933
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739769096; cv=none; b=baATYvhsrZCJ7sOvUirv4DWdTX25htmT650daSu3Takf7WKmkcTNic8IdRKUqcotbaKpcGZCooqjeOKf8QGN/uViiF4DPL752Z5nIKqMiomomKD64zxPTgeFJoQaFKcLnTu+eInttggWIGDOrJaqGplvOvoX3eWQQImOM8iTCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739769096; c=relaxed/simple;
	bh=Hu5W/jpJpv+RTetb3YTMoPFNo+LXzPmSt4xkaSLDp20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Ce7gBlMl9EazTkMWMlSQsbcYeLDecqC+P8OSLhzw+7/OUWsyQUFyg9SLgVveX5/WC2BstzwOCKtHHxzvQbtrvHz6yYOKQOxhrEEKZRUspMEAptpXoek/r+WOXA0msFr8RehzMh+Bsly4KOZgJOtOXF2IYy5wzr+eOK1pJQ7x62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C4DHXgiY; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abb7f539c35so281840066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739769091; x=1740373891; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0W2zwwtQ+LJS1GM4Y7/DiWPfao2VEBGPpQbw/7fz/g=;
        b=C4DHXgiYHSbYJ6yyRqsdx5CHKvmCdUi/ioMWiCfBSsIU3MbMCMwGqO43CYWhFX5w5d
         cArvkIlqyn70A17TrymsltOSEePNYKnffSaeOa4ya/pLaYNuSAvwYLC0e8yVRIXxj9V3
         YvbiLhgD8pxVwx/G+qYuSQNr6mlmmTyDtiRPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739769091; x=1740373891;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0W2zwwtQ+LJS1GM4Y7/DiWPfao2VEBGPpQbw/7fz/g=;
        b=LCgSiF04At3UcpCHLmAiQ0b87C/A1/Nki0D3IvI+zdLFLpmcV5CJe/J7lEUb3+jlK4
         rVHomPOh9AeHkfmbGTMDogOat+hniqLCq4ELTLeMoUfSX/e1pQBMxEdeFMQgNurvMW1c
         Ara2O2YpkxIKdro2Bqo+c128uFDq8ojDdZHWOzKWmv5ZW6cQwnoBKkzdi+ln4wRji4Ma
         bdQj3bALmiopwQte8HetyAG0IsAK489P3dffzQePXxTQRSaBICaaN+fHMtMjqlg+QxpP
         3rzrDLP3Q5LzmlE1Xkiuxj6FPHOJe4q7eRYv+J0ThUl5rgcULiTDKGdjMxG57bX/VYHh
         zb0g==
X-Gm-Message-State: AOJu0Yz+BbA7X1oiblYS1y61rQLDyxrTgumuVcLHzgyqQ4cR4h0DH2UG
	ni/kPFpUaLZyEAcjj9JdVSdo/LC2v+Xapxae4Y67FmkrYEk1NjQVL47mrzptKHnfFTHxu7RP2qk
	dK9M=
X-Gm-Gg: ASbGncsWowXUDkLkzE9mf9cRbkMt1ORrNQirkFLOoELdFW8vBVscxrWhGpW/5gwsBLr
	MJgVYm7pFv8Byx8xMmelKlSIdH5dDW6dNVTSiOEkZpw5zsdVf/QpA9v8FJm0BoRRSTuDkQSIj20
	yxKx53jkTjCVet0yrhMQpythp82VlPezVx8VYPMCFM+vtazWZJNs83igr1OPE8ygy6IT+owiyJ/
	Fwi2iKGkFiiTYfi7QWIczunqwcD0LCb/ni2mAjxp7kvxIdg5oKPxD7Ct3qmP7R6I1m9755lr7oB
	r48xBnKZqhsWeUxrBBK3JQ/MIw6AAWQalUW4M0A+c6SYhO6VIV6E9rhSHrdTsrYW+w==
X-Google-Smtp-Source: AGHT+IHCG4t/GTA+nzOrKUAzvsGEcr0OliZ5laIbLsHRk4ZUHu8tsbL6Y7UOHYLfFbhR0gS9Wc6kpg==
X-Received: by 2002:a17:906:31d7:b0:ab6:d6c3:f1e2 with SMTP id a640c23a62f3a-abb70da1b1dmr722946066b.38.1739769090868;
        Sun, 16 Feb 2025 21:11:30 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba910e8b11sm538439766b.21.2025.02.16.21.11.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 21:11:30 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded1395213so6088592a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 21:11:29 -0800 (PST)
X-Received: by 2002:a17:906:6a0c:b0:aa6:7933:8b26 with SMTP id
 a640c23a62f3a-abb70a7c6f7mr852615466b.9.1739769088512; Sun, 16 Feb 2025
 21:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg1LBSvozQ03+EyB6j=Pwef1EL0Edu8uRz3fZaoZ0KtuA@mail.gmail.com>
In-Reply-To: <CAHk-=wg1LBSvozQ03+EyB6j=Pwef1EL0Edu8uRz3fZaoZ0KtuA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 16 Feb 2025 21:11:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiOtWb6Wn+1sS5YUiXwUrcLWhLGLndt-YmMc0bL--=ZYw@mail.gmail.com>
X-Gm-Features: AWEUYZky4tL4n8jo6sgzvX8wpS7Ujf0-xBFC0yQzX10eXXYl4TOtsB18uwhoqTY
Message-ID: <CAHk-=wiOtWb6Wn+1sS5YUiXwUrcLWhLGLndt-YmMc0bL--=ZYw@mail.gmail.com>
Subject: Linux 6.14-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Bah. I sent this out earlier, but it turns out that I sent it to the
  wrong list due to some messed-up autocompletion, so people didn't
  see it.

  So here's the 6.14-rc3 announcement on the proper mailing list ]

So the first few weeks of the 6.14 release development were
smaller-than-usual, but rc3 is actually right in line with normal
releases at this point. Probably just timing of pull requests, and
we'll see how next week goes. But nothing looks worrisome.

The diffstat is mostly normal, although we do have a few spikes in it:
there's a fair amount of fixes to arm64 kvm, mostly centered around
FP/SIMD/SVE. There's also some UML virtio updates, all making the
diffstat fairly architecture-heavy - about a third of the patch is in
architecture code.

And on the driver side, there's some new infrastructure for upcoming
platform device handling, and some drm and OF test updates, which also
show up in the diffstat as bigger spikes.

Other than that, it all looks pretty small and normal, with small
fixes all over (networking, core kernel, regular driver fixes, etc).

Please do keep testing,

               Linus

---

Aditya Garg (1):
      wifi: brcmfmac: use random seed flag for BCM4355 and BCM4364 firmware

Aditya Kumar Singh (1):
      wifi: ath12k: fix handling of 6 GHz rules

Alan Huang (3):
      bcachefs: Fix use after free
      bcachefs: Pass _orig_restart_count to trans_was_restarted
      bcachefs: Reuse transaction

Alan Stern (1):
      USB: hub: Ignore non-compliant devices with too many configs or inter=
faces

Alex Deucher (3):
      drm/amdgpu/pm: fix UVD handing in amdgpu_dpm_set_powergating_by_smu()
      drm/amdgpu/gfx9: manually control gfxoff for CS on RV
      drm/amdgpu: bump version for RV/PCO compute fix

Alex Henrie (1):
      HID: apple: fix up the F6 key on the Omoton KB066 keyboard

Alex Williamson (1):
      PCI: Fix BUILD_BUG_ON usage for old gcc

Alexander H=C3=B6lzl (1):
      can: j1939: j1939_sk_send_loop(): fix unable to send messages
with data length zero

Alexander Stein (1):
      usb: phy: generic: Use proper helper for property detection

Alexandra Winter (1):
      s390/qeth: move netif_napi_add_tx() and napi_enable() from under BH

Andre Werner (1):
      serial: sc16is7xx: Fix IRQ number check behavior

Andrea Righi (5):
      sched_ext: Include task weight in the error state dump
      selftests/sched_ext: Fix enum resolution
      tools/sched_ext: Add helper to check task migration state
      sched_ext: selftests/dsp_local_on: Fix selftest on UP systems
      sched_ext: Fix lock imbalance in dispatch_to_local_dsq()

Andrew Kreimer (1):
      iommu/exynos: Fix typos

Andy Shevchenko (12):
      pinctrl: cy8c95x0: Fix off-by-one in the regmap range settings
      pinctrl: cy8c95x0: Avoid accessing reserved registers
      pinctrl: cy8c95x0: Enable regmap locking for debug
      pinctrl: cy8c95x0: Rename PWMSEL to SELPWM
      pinctrl: cy8c95x0: Respect IRQ trigger settings from firmware
      serial: port: Assign ->iotype correctly when ->iobase is set
      serial: port: Always update ->iotype in __uart_read_properties()
      serial: port: Make ->iotype validation global in __uart_read_properti=
es()
      serial: 8250_of: Remove unneeded ->iotype assignment
      serial: 8250_platform: Remove unneeded ->iotype assignment
      serial: 8250_pnp: Remove unneeded ->iotype assignment
      gpiolib: Fix crash on error in gpiochip_get_ngpios()

Andy Strohman (1):
      batman-adv: fix panic during interface removal

Andy-ld Lu (1):
      mmc: mtk-sd: Fix register settings for hs400(es) mode

Anup Patel (1):
      genirq: Remove unused CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS

Ard Biesheuvel (3):
      arm64: Fix 5-level paging support in kexec/hibernate trampoline
      efi: Avoid cold plugged memory for placing the kernel
      efi: Use BIT_ULL() constants for memory attributes

Arnd Bergmann (3):
      HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE
      HID: intel-thc: fix CONFIG_HID dependency
      drm/hisilicon/hibmc: select CONFIG_DRM_DISPLAY_DP_HELPER

Artur Weber (3):
      gpio: bcm-kona: Fix GPIO lock/unlock for banks above bank 0
      gpio: bcm-kona: Make sure GPIO bits are unlocked when requesting IRQ
      gpio: bcm-kona: Add missing newline to dev_err format string

Ashish Kalra (1):
      x86/sev: Fix broken SNP support with KVM module built-in

Atul Kumar Pant (1):
      sched_ext: Fixes typos in comments

Bart Van Assche (1):
      iavf: Fix a locking bug in an error path

Beata Michalska (1):
      arm64: amu: Delay allocating cpumask for AMU FIE support

Bence Cs=C3=B3k=C3=A1s (1):
      spi: atmel-quadspi: Fix warning in doc-comment

Benjamin Berg (4):
      um: add back support for FXSAVE registers
      um: avoid copying FP state from init_task
      um: properly align signal stack on x86_64
      um: fix execve stub execution on old host OSs

Bharadwaj Raju (1):
      selftests/cgroup: use bash in test_cpuset_v1_hp.sh

Bibo Mao (3):
      LoongArch: KVM: Fix typo issue about GCFG feature detection
      LoongArch: KVM: Remove duplicated cache attribute setting
      LoongArch: KVM: Set host with kernel mode when switch to VM mode

Bjorn Helgaas (1):
      PCI: Avoid FLR for Mediatek MT7922 WiFi

Caleb Sander Mateos (2):
      io_uring/uring_cmd: don't assume io_uring_cmd_data layout
      io_uring/uring_cmd: switch sqe to async_data on EAGAIN

Changwoo Min (1):
      sched_ext: Fix incorrect time delta calculation in time_delta()

Charles Han (2):
      HID: winwing: Add NULL check in winwing_init_led()
      HID: multitouch: Add NULL check in mt_input_configured

Chester A. Unal (1):
      USB: serial: option: add MeiG Smart SLM828

Chia-Lin Kao (AceLan) (1):
      HID: ignore non-functional sensor in HP 5MP Camera

Chuck Lever (1):
      NFSD: Fix CB_GETATTR status fix

Chuyi Zhou (2):
      sched_ext: Fix the incorrect bpf_list kfunc API in common.bpf.h.
      sched_ext: Use SCX_CALL_OP_TASK in task_tick_scx

Claudiu Beznea (1):
      pinctrl: pinconf-generic: Print unsigned value if a format is registe=
red

Dai Ngo (1):
      NFSD: fix hang in nfsd4_shutdown_callback

Daniel Brackenbury (1):
      HID: topre: Fix n-key rollover on Realforce R3S TKL boards

Daniel Lezcano (1):
      thermal/cpufreq_cooling: Remove structure member documentation

David Howells (2):
      rxrpc: Fix alteration of headers whilst zerocopy pending
      rxrpc: Fix ipv6 path MTU discovery

David Woodhouse (1):
      ptp: vmclock: Add .owner to vmclock_miscdev_fops

Devaansh Kumar (1):
      sched_ext: selftests: Fix grammar in tests description

Devarsh Thakkar (1):
      dt-bindings: display: ti: Fix compatible for am62a7 dss

Dhananjay Ugwekar (1):
      perf/x86/rapl: Fix the error checking order

Dmitry Baryshkov (1):
      dt-bindings: nvmem: qcom,qfprom: Add SAR2130P compatible

Dmitry V. Levin (1):
      MIPS: fix mips_get_syscall_arg() for o32

Easwar Hariharan (1):
      iommu: Fix a spelling error

Elson Roy Serrao (1):
      usb: roles: set switch registered flag early on

Eric Dumazet (24):
      net: add dev_net_rcu() helper
      ipv4: add RCU protection to ip4_dst_hoplimit()
      ipv4: use RCU protection in ip_dst_mtu_maybe_forward()
      ipv4: use RCU protection in ipv4_default_advmss()
      ipv4: use RCU protection in rt_is_expired()
      ipv4: use RCU protection in inet_select_addr()
      ipv4: use RCU protection in __ip_rt_update_pmtu()
      ipv4: icmp: convert to dev_net_rcu()
      flow_dissector: use RCU protection to fetch dev_net()
      ipv6: use RCU protection in ip6_default_advmss()
      ipv6: icmp: convert to dev_net_rcu()
      ipv6: Use RCU in ip6_input()
      net: fib_rules: annotate data-races around rule->[io]ifindex
      ndisc: ndisc_send_redirect() must use dev_get_by_index_rcu()
      ndisc: use RCU protection in ndisc_alloc_skb()
      neighbour: use RCU protection in __neigh_notify()
      arp: use RCU protection in arp_xmit()
      openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      vrf: use RCU protection in l3mdev_l3_out()
      ndisc: extend RCU protection in ndisc_send_skb()
      ipv6: mcast: extend RCU protection in igmp6_send()
      vxlan: check vxlan_vnigroup_init() return value
      team: better TEAM_OPTION_TYPE_STRING validation
      ipv6: mcast: add RCU protection to mld_newpack()

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990B compositions
      USB: serial: option: fix Telit Cinterion FN990A name

Fabrice Gasnier (1):
      usb: dwc2: gadget: remove of_node reference upon udc_stop

Fedor Pchelkin (1):
      can: ctucanfd: handle skb allocation failure

Filipe Manana (2):
      btrfs: fix stale page cache after race between readahead and
direct IO write
      btrfs: fix hole expansion when writing at an offset beyond EOF

Frederic Weisbecker (1):
      usb: gadget: uvc: Fix unstarted kthread worker

Furong Xu (1):
      net: stmmac: Apply new page pool parameters when SPH is enabled

Greg Kroah-Hartman (1):
      driver core: add a faux bus for use when a simple device/bus is neede=
d

Guo Ren (1):
      usb: gadget: udc: renesas_usb3: Fix compiler warning

Heiko Carstens (1):
      s390/bitops: Disable arch_test_bit() optimization for PROFILE_ALL_BRA=
NCHES

Huacai Chen (2):
      LoongArch: Fix kernel_page_present() for KPRANGE/XKPRANGE
      USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI

Ievgen Vovk (1):
      HID: hid-apple: Apple Magic Keyboard a3203 USB-C support

Ilya Leoshkevich (1):
      s390/configs: Remove CONFIG_LSM

Imran Shaik (3):
      dt-bindings: clock: qcom: Add GPU clocks for QCS8300
      dt-bindings: clock: qcom: Add CAMCC clocks for QCS8300
      dt-bindings: clock: qcom: Add QCS8300 video clock controller

Imre Deak (1):
      drm: Fix DSC BPP increment decoding

Ivan Kokshaysky (3):
      alpha: replace hardcoded stack offsets with autogenerated ones
      alpha: make stack 16-byte aligned (most cases)
      alpha: align stack for page fault and user unaligned trap handlers

Jakub Kicinski (1):
      Reapply "net: skb: introduce and use a single page frag cache"

Jan Beulich (1):
      Xen/swiotlb: mark xen_swiotlb_fixup() __init

Jann Horn (4):
      sched: Clarify wake_up_q()'s write to task->wake_q.next
      usb: cdc-acm: Check control transfer buffer size before access
      usb: cdc-acm: Fix handling of oversized fragments
      partitions: mac: fix handling of bogus partition table

Jeff Layton (1):
      nfsd: validate the nfsd_serv pointer before calling svc_wake_up

Jens Axboe (4):
      io_uring/uring_cmd: remove dead req_has_async_data() check
      io_uring/waitid: setup async data in the prep handler
      block: cleanup and fix batch completion adding conditions
      io_uring/uring_cmd: unconditionally copy SQEs at prep time

Jerome Brunet (1):
      regulator: core: let dt properties override driver init_data

Jiang Liu (2):
      drm/amdgpu: bail out when failed to load fw in psp_init_cap_microcode=
()
      drm/amdgpu: avoid buffer overflow attach in smu_sys_set_pp_table()

Jiasheng Jiang (1):
      regmap-irq: Add missing kfree()

Jill Donahue (1):
      USB: gadget: f_midi: f_midi_complete to call queue_work

Jinghao Jia (2):
      samples/hid: remove unnecessary -I flags from libbpf EXTRA_CFLAGS
      samples/hid: fix broken vmlinux path for VMLINUX_BTF

Johan Hovold (1):
      USB: serial: option: drop MeiG Smart defines

Johannes Berg (3):
      um: virt-pci: don't use kmalloc()
      um: virtio_uml: use raw spinlock
      um: convert irq_lock to raw spinlock

John Keeping (2):
      usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      serial: 8250: Fix fifo underflow on flush

Jos Wang (1):
      usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters
ERROR_RECOVERY

Josh Poimboeuf (1):
      objtool: Ignore dangling jump table entries

Joshua Hay (1):
      idpf: call set_real_num_queues in idpf_open

Josua Mayer (1):
      Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch=
"

Juergen Gross (2):
      xen/swiotlb: relax alignment requirements
      x86/xen: allow larger contiguous memory regions in PV guests

Kalle Valo (2):
      MAINTAINERS: wifi: ath: remove Kalle
      MAINTAINERS: wifi: remove Kalle

Kan Liang (2):
      perf/x86/intel: Clean up PEBS-via-PT on hybrid
      perf/x86/intel: Fix ARCH_PERFMON_NUM_COUNTER_LEAF

Kent Overstreet (4):
      bcachefs: Fix marking reflink pointers to missing indirect extents
      bcachefs: Split out journal pins by btree level
      bcachefs: Fix want_new_bset() so we write until the end of the btree =
node
      bcachefs: CONFIG_BCACHEFS_INJECT_TRANSACTION_RESTARTS

Kiran K (1):
      Bluetooth: btintel_pcie: Fix a potential race condition

Kory Maincent (2):
      net: ethtool: tsconfig: Fix netlink type of hwtstamp flags
      net: pse-pd: Fix deadlock in current limit functions

Krzysztof Karas (1):
      drm/i915/selftests: avoid using uninitialized context

Krzysztof Kozlowski (1):
      can: c_can: fix unbalanced runtime PM disable in error path

Kunihiko Hayashi (1):
      spi: sn-f-ospi: Fix division by zero

Lai Jiangshan (1):
      workqueue: Put the pwq after detaching the rescuer from the pool

Lancelot SIX (1):
      drm/amdkfd: Ensure consistent barrier state saved in gfx12 trap handl=
er

Lei Huang (1):
      USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist

Li Lingfeng (1):
      nfsd: clear acl_access/acl_default after releasing them

Linus Torvalds (2):
      tegra210-adma: fix 32-bit x86 build
      Linux 6.14-rc3

Lu Baolu (2):
      iommu: Fix potential memory leak in iopf_queue_remove_device()
      iommu/vt-d: Make intel_iommu_drain_pasid_prq() cover faults for RID

Luiz Augusto von Dentz (2):
      Bluetooth: L2CAP: Fix slab-use-after-free Read in l2cap_send_cmd
      Bluetooth: L2CAP: Fix corrupted list in hci_chan_del

Lukas Bulwahn (1):
      arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL

Lukasz Majewski (1):
      dt-bindings: display: Add powertip,{st7272|hx8238a} as DT Schema
description

Lyude Paul (1):
      rust/kernel: Add faux device bindings

Maciej W. Rozycki (1):
      MIPS: Export syscall stack arguments properly for remote use

Marc Zyngier (4):
      KVM: arm64: Fix __pkvm_host_mkyoung_guest() return value
      KVM: arm64: Convert timer offset VA when accessed in HYP code
      KVM: arm64: timer: Drop warning on failed interrupt signalling
      KVM: arm64: vgic: Hoist SGI/PPI alloc from vgic_init() to
kvm_create_vgic()

Marcelo Ricardo Leitner (1):
      MAINTAINERS: Add sctp headers to the general netdev entry

Marco Crivellari (1):
      LoongArch: Fix idle VS timer enqueue

Marek Vasut (1):
      USB: cdc-acm: Fill in Renesas R-Car D3 USB Download mode quirk

Mario Limonciello (1):
      gpiolib: acpi: Add a quirk for Acer Nitro ANV14

Mark Brown (3):
      arm64/gcs: Fix documentation for HWCAP
      arm64/hwcap: Remove stray references to SF8MMx
      arm64: Add missing registrations of hwcaps

Mark Lord (1):
      spi: pxa2xx: Fix regression when toggling chip select on LPSS devices

Mark Pearson (2):
      platform/x86: thinkpad_acpi: Support for V9 DYTC platform profiles
      platform/x86: thinkpad_acpi: Fix registration of tpacpi platform driv=
er

Mark Rutland (9):
      KVM: arm64: Unconditionally save+flush host FPSIMD/SVE/SME state
      KVM: arm64: Remove host FPSIMD saving for non-protected KVM
      KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
      KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
      KVM: arm64: Refactor CPTR trap deactivation
      KVM: arm64: Refactor exit handlers
      KVM: arm64: Mark some header functions as inline
      KVM: arm64: Eagerly switch ZCR_EL{1,2}
      KVM: arm64: Simplify warning in kvm_arch_vcpu_load_fp()

Masahiro Yamada (2):
      tools: fix annoying "mkdir -p ..." logs when building tools in parall=
el
      kbuild: fix linux-headers package build when $(CC) cannot link usersp=
ace

Mathias Nyman (1):
      USB: Add USB_QUIRK_NO_LPM quirk for sony xperia xz1 smartphone

Matthew Wilcox (Oracle) (1):
      btrfs: fix two misuses of folio_shift()

Maxime Ripard (4):
      drm/tests: hdmi: Fix WW_MUTEX_SLOWPATH failures
      drm/tests: hdmi: Remove redundant assignments
      drm/tests: hdmi: Reorder DRM entities variables assignment
      drm/tests: hdmi: Fix recursive locking

Michal Luczaj (2):
      vsock: Orphan socket after transport release
      vsock/test: Add test for SO_LINGER null ptr deref

Michal Pecio (1):
      usb: xhci: Restore xhci_pci support for Renesas HCs

Miguel Ojeda (3):
      objtool/rust: add one more `noreturn` Rust function
      rust: rbtree: fix overindented list item
      arm64: rust: clean Rust 1.85.0 warning using softfloat target

Mika Westerberg (1):
      MAINTAINERS: Use my kernel.org address for I2C ACPI work

Muhammad Adeel (1):
      cgroup: Remove steal time from usage_usec

Mukesh Kumar Savaliya (1):
      MAINTAINERS: Add maintainer for Qualcomm's I2C GENI driver

Murad Masimov (1):
      ax25: Fix refcount leak caused by setting SO_BINDTODEVICE sockopt

Nathan Chancellor (1):
      arm64: Handle .ARM.attributes section in linker scripts

NeilBrown (1):
      nfsd: fix uninitialised slot info when a request is retried

Nicolas Dichtel (1):
      rtnetlink: fix netns leak with rtnl_setlink()

Niklas Schnelle (2):
      s390/pci: Pull search for parent PF out of zpci_iov_setup_virtfn()
      s390/pci: Fix handling of isolated VFs

Nirmoy Das (1):
      drm/xe: Carve out wopcm portion from the stolen memory

Olga Kornievskaia (1):
      nfsd: fix __fh_verify for localio

Oliver Upton (1):
      ACPI: GTDT: Relax sanity checking on Platform Timers array count

Pablo Neira Ayuso (1):
      Revert "netfilter: flowtable: teardown flow if cached mtu is stale"

Paolo Abeni (1):
      Revert "net: skb: introduce and use a single page frag cache"

Patrick Bellasi (1):
      x86/cpu/kvm: SRSO: Fix possible missing IBPB on VM-Exit

Pavel Begunkov (2):
      io_uring/waitid: don't abuse io_tw_state
      io_uring/kbuf: reallocate buf lists on upgrade

Peter Oberparleiter (1):
      s390/cio: Fix CHPID "configure" attribute caching

Peter Zijlstra (1):
      objtool: Move dodgy linker warn to verbose

Piotr Kwapulinski (1):
      ixgbe: Fix possible skb NULL pointer dereference

Quentin Perret (3):
      KVM: arm64: Improve error handling from check_host_shared_guest()
      KVM: arm64: Simplify np-guest hypercalls
      KVM: arm64: Fix alignment of kvm_hyp_memcache allocations

Radu Rendec (1):
      arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Remi Pommarel (1):
      batman-adv: Fix incorrect offset in batadv_tt_tvlv_ogm_handler_v1()

Reyders Morales (1):
      Documentation/networking: fix basic node example document ISO 15765-2

Rob Herring (Arm) (1):
      mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes

Robin van der Gracht (1):
      can: rockchip: rkcanfd_handle_rx_fifo_overflow_int(): bail out
if skb cannot be allocated

Roger Quadros (3):
      net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases
      net: ethernet: ti: am65-cpsw: fix RX & TX statistics for XDP_TX case
      net: ethernet: ti: am65_cpsw: fix tx_cleanup for XDP case

Roy Luo (1):
      usb: gadget: core: flush gadget workqueue after device removal

Rupinderjit Singh (1):
      gpu: host1x: Fix a use of uninitialized mutex

Russell King (Oracle) (1):
      net: phylink: make configuring clock-stop dependent on MAC support

Sakari Ailus (2):
      platform/x86: int3472: Use correct type for "polarity", call it gpio_=
flags
      platform/x86: int3472: Call "reset" GPIO "enable" for INT347E

Sean Christopherson (9):
      perf/x86/intel: Ensure LBRs are disabled when a CPU is starting
      KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if local APIC
isn't in-kernel
      KVM: selftests: Mark test_hv_cpuid_e2big() static in Hyper-V CPUID te=
st
      KVM: selftests: Manage CPUID array in Hyper-V CPUID test's core helpe=
r
      KVM: selftests: Add CPUID tests for Hyper-V features that need
in-kernel APIC
      KVM: nSVM: Enter guest mode before initializing nested NPT MMU
      KVM: x86: Load DR6 with guest value only before entering .vcpu_run() =
loop
      crypto: ccp: Add external API interface for PSP module initialization
      KVM: SVM: Ensure PSP module is initialized if KVM module is built-in

Selvarasu Ganesan (2):
      usb: gadget: f_midi: Fixing wMaxPacketSize exceeded issue during
MIDI bind retries
      usb: dwc3: Fix timeout issue during controller enter/exit from halt s=
tate

Shakeel Butt (1):
      cgroup: fix race between fork and cgroup.kill

Shyam Prasad N (1):
      cifs: pick channels for individual subrequests

Song Yoong Siang (1):
      igc: Set buffer type for empty frames in igc_init_empty_frame

Sridhar Samudrala (2):
      idpf: fix handling rsc packet with a single segment
      idpf: record rx queue in skb for RSC packets

Stefan Eichenberger (1):
      usb: core: fix pipe creation for get_bMaxPacketSize0

Steven Rostedt (5):
      ring-buffer: Unlock resize on mmap error
      tracing: Have the error of __tracing_resize_ring_buffer() passed to u=
ser
      ring-buffer: Validate the persistent meta data subbuf array
      tracing: Do not allow mmap() of persistent ring buffer
      ring-buffer: Update pages_touched to reflect persistent buffer conten=
t

Stuart Hayhurst (2):
      HID: corsair-void: Add missing delayed work cancel for headset status
      HID: corsair-void: Initialise memory for psy_cfg

Su Hui (1):
      drm/panthor: avoid garbage value in panthor_ioctl_dev_query()

Sven Eckelmann (2):
      batman-adv: Ignore neighbor throughput metrics in error case
      batman-adv: Drop unmanaged ELP metric worker

Sybil Isabel Dorsett (1):
      platform/x86: thinkpad_acpi: Fix invalid fan speed on ThinkPad X120e

Tanya Agarwal (1):
      tomoyo: fix spelling error

Tejas Upadhyay (1):
      drm/xe/client: bo->client does not need bos_lock

Tejun Heo (5):
      sched_ext: selftests/dsp_local_on: Fix sporadic failures
      sched_ext: Fix incorrect autogroup migration detection
      sched_ext: Implement auto local dispatching of migration disabled tas=
ks
      sched_ext: Fix migration disabled handling in targeted dispatches
      sched_ext: Fix incorrect assumption about migration disabled
tasks in task_can_run_on_remote_rq()

Tetsuo Handa (2):
      tomoyo: fix spelling errors
      tomoyo: use better patterns for procfs in learning mode

Thinh Nguyen (1):
      usb: dwc3: Document nostream_work

Thomas Wei=C3=9Fschuh (6):
      of: address: Add kunit test for __of_address_resource_bounds()
      ptp: vmclock: Set driver data before its usage
      ptp: vmclock: Don't unregister misc device if it was not registered
      ptp: vmclock: Clean up miscdev and ptp clock through devres
      ptp: vmclock: Remove goto-based cleanup logic
      kbuild: userprogs: fix bitsize and target detection on clang

Thorsten Blum (2):
      alpha: Replace one-element array with flexible array member
      alpha: Use str_yes_no() helper in pci_dac_dma_supported()

Tulio Fernandes (1):
      HID: hid-thrustmaster: fix stack-out-of-bounds read in
usb_check_int_endpoints()

Uwe Kleine-K=C3=B6nig (1):
      modpost: Fix a few typos in a comment

Varadarajan Narayanan (1):
      regulator: qcom_smd: Add l2, l5 sub-node to mp5496 regulator

Vasant Hegde (1):
      iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path

Vicki Pfau (3):
      HID: hid-steam: Fix issues with disabling both gamepad mode and
lizard mode
      HID: hid-steam: Move hidraw input (un)registering to work
      HID: hid-steam: Don't use cancel_delayed_work_sync in IRQ context

Vincent Mailhol (1):
      can: etas_es58x: fix potential NULL pointer dereference on udev->seri=
al

Wentao Liang (2):
      gpio: stmpe: Check return value of stmpe_reg_read in
stmpe_gpio_irq_sync_unlock
      mlxsw: Add return value check for mlxsw_sp_port_get_stats_raw()

Wolfram Sang (1):
      MAINTAINERS: delete entry for AXXIA I2C

Yuli Wang (3):
      LoongArch: Use str_yes_no() helper function for /proc/cpuinfo
      LoongArch: Remove the deprecated notifier hook mechanism
      LoongArch: csum: Fix OoB access in IP checksum code for negative leng=
ths

Zdenek Bouska (1):
      igc: Fix HW RX timestamp when passed by ZC XDP

Zhang Lixu (3):
      HID: intel-ish-hid: fix the length of MNG_SYNC_FW_CLOCK in doorbell
      HID: intel-ish-hid: Send clock sync message immediately after reset
      HID: intel-ish-hid: ipc: Add Panther Lake PCI device IDs

Zhang Rui (1):
      thermal/netlink: Prevent userspace segmentation fault by
adjusting UAPI header

Zhu Lingshan (1):
      amdkfd: properly free gang_ctx_bo when failed to init user queue

