Return-Path: <linux-kernel+bounces-436603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C069E8832
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 23:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F041884EA6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC2118A922;
	Sun,  8 Dec 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UjiGwa8Q"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897A22C6F7
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733696141; cv=none; b=j7u3cgBApq89NrBtJDzr6mbJKnrxJbkVAio+wKdC7YzNN74HjxgE4+vbmeZoBoKULlH4Toqil6DiMVbUeb6/VTDTk0gQbo85pZIhoue5YJSNHipdzj8gy6+4G7dWYh2s1lZHzYkE7t5Xxuy2Yy1MJYCM6iQ26ykJR74mswo+X/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733696141; c=relaxed/simple;
	bh=9moUQwT2/TJV+TclF/MJSM1//U4UnNjnVkI54VCZyGs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qhw02wBuEi8qQrbmZpRhO3z0HtVbpZ+pLaNPfwC/BdGbmXfLn5PIey9C6c3N/yTnNHLiiwKU1JsX1E8q4UznbuNP9cM9rOnNsWVC4zMb27t93OecwqdyEdzED7nvQwGKLu1ZGl69RsEnFWpGswMhCsni2Pbgiysb6K38IycfWyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UjiGwa8Q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so878504a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 14:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1733696136; x=1734300936; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aU44poiUG7ERpArI9jj9rEZH9kd/Ql/k2eJBVvsZDbE=;
        b=UjiGwa8Qh6zQP3i7yjuspDmVERBRCCOCpAhuTJRXIVuKP7TkN7h8SOZn5eYGKBc6ft
         OA+mJJbAPgPin2NBT6RTDedpnjqGAcEHyWqVQg+iKNfLJhoxhlC4NcQ4tzhbaAyG1Ff0
         W4OXAXAF9E1Y+kZowWpzQH8zTZTT9bqCF3tEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733696136; x=1734300936;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aU44poiUG7ERpArI9jj9rEZH9kd/Ql/k2eJBVvsZDbE=;
        b=suekaCuHFAtZw7IK3cu8WaTUwVioYPRxQMq7a/yEIzEoz+e1vdVNwxaKpqg8GhAdpm
         aScQF2RQc7UjioudAFeLXBLQZUgCFyjmlTLZLyUo1RmTpB6dfvPrnrOValF673w9xpSv
         ND9NKVK7jiwvn5Zo5krz7XV2E4fatA6iD1nyjkgIEmRQLQJNCauTGVIqHf41vI3YK0T7
         JQ85g654hCvz2BOs1LigyEW+uyOvYEH1RZwTCf9PsFStfwzCltnTzBftLZduXDzTGDKM
         SChTfYhKHG8KBlb9inuDzeMTRe3zVSJT1lxgBf2alno0jEGEGGtEzyq/es7WaeMZ2xm5
         F8aw==
X-Gm-Message-State: AOJu0Yw2Ja0gBrYcm5oINwgJ5g+H/cPXP8gPwVdknavjvXJiTrxm1pPy
	BxcfnbXkxkSqTykesMwdnAHS7ujeGjlzm3f90c4Mqey2vs98y24dUeVsu8O4kXRviYjjMdQOv3q
	I5iqhqw==
X-Gm-Gg: ASbGnctdc8ysce7ZDENbr7EgLMSLAmQi69jtaWop/YnvwRE0USfbGrqxIA/+Ij1Nr+b
	hvvAKFeN37Q2HFMqZEOwelSM86ht2cV/WKgvAS+o/Htd4W9V6RWSGkB5cVqAkoz5jTPAGLfdEF9
	3/fQuEFMViqMV8yDlGN0ncHOOj866zcqdHIfj/h54aigmfIm26+MRuuz+ekLuOmNT86NeouGeGk
	URpVcO+J8VYezXytlV4hZrpVjbVIRxHMb9U8C+KX3NsDZEzA33J1rkWMJAruuYAmuszRFii9Sz9
	dnR7R9JUfiCjFqiWF5hPYakb
X-Google-Smtp-Source: AGHT+IGIM4Fier8p4m/DzjDpSBBZWQ5pLoU6TrmPdv7/fckUKpLfiLECUYgcIlbM1CMODRcUXZnc/A==
X-Received: by 2002:a05:6402:4005:b0:5d3:ba42:e9e3 with SMTP id 4fb4d7f45d1cf-5d3be680ec5mr29498883a12.13.1733696135852;
        Sun, 08 Dec 2024 14:15:35 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa653a95e90sm281022566b.173.2024.12.08.14.15.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 14:15:35 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so604556266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 14:15:34 -0800 (PST)
X-Received: by 2002:a05:6402:1ec2:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d3be7215damr27680888a12.32.1733696134048; Sun, 08 Dec 2024
 14:15:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 8 Dec 2024 14:15:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDe9JfGynY9KQ1exkL0DM-cyLYdeYdOxbCXNHm=qAgSQ@mail.gmail.com>
Message-ID: <CAHk-=wgDe9JfGynY9KQ1exkL0DM-cyLYdeYdOxbCXNHm=qAgSQ@mail.gmail.com>
Subject: Linux 6.13-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The diffstat looks a bit unusual with 80%+ drivers, and a lot of it
one-liners, but that's actually just because of a couple of automated
scripts that got run after -rc1 for some cleanups. Nothing
particularly interesting, but it makes for a lot of noise in the diff.

That said, there are real fixes in there too, but nothing that looks
hugely remarkable. The shortlog below gives a flavor of it all. That's
m ostly drivers too, but there's networking and bpf and some arch
updates too.

Please do keep testing, and then we can all take it a bit easier over
the holidays,

             Linus

---

Aapo Vienamo (1):
      spi: intel: Add Panther Lake SPI controller support

Adrian Huang (1):
      sched/numa: fix memory leak due to the overwritten vma->numab_state

Ajay Kaher (1):
      ptp: Add error handling for adjfine callback in ptp_clock_adjtime

Akinobu Mita (1):
      mm/damon: fix order of arguments in damos_before_apply tracepoint

Alex Deucher (9):
      drm/amdgpu/jpeg1.0: fix idle work handler
      drm/amdgpu/hdp4.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.0: do a posting read when flushing HDP
      drm/amdgpu/hdp5.2: do a posting read when flushing HDP
      drm/amdgpu/hdp6.0: do a posting read when flushing HDP
      drm/amdgpu/hdp7.0: do a posting read when flushing HDP
      Revert "drm/amd/pm: correct the workload setting"
      drm/amd/pm: fix and simplify workload handling
      drm/amdgpu: rework resume handling for display (v2)

Alexander Kozhinov (1):
      can: gs_usb: add usb endpoint address detection at driver probe step

Alexander Sverdlin (1):
      watchdog: rti: of: honor timeout-sec property

Amir Mohammadi (1):
      bpftool: fix potential NULL pointer dereferencing in prog_dump()

Andrew Morton (1):
      fs/proc/vmcore.c: fix warning when CONFIG_MMU=3Dn

Andrii Nakryiko (1):
      mm: fix vrealloc()'s KASAN poisoning logic

Anil Gurumurthy (1):
      scsi: qla2xxx: Supported speed displayed incorrectly for VPorts

Animesh Agarwal (1):
      dt-bindings: watchdog: fsl-imx-wdt: Add missing 'big-endian' property

Arkadiusz Kubalewski (1):
      ice: fix PHY Clock Recovery availability check

Armin Wolf (2):
      platform/x86: asus-wmi: Ignore return value when writing thermal poli=
cy
      platform/x86: asus-nb-wmi: Ignore unknown event 0xCF

Aruna Ramakrishna (2):
      x86/pkeys: Change caller of update_pkru_in_sigframe()
      x86/pkeys: Ensure updated PKRU value is XRSTOR'd

Asahi Lina (1):
      ALSA: usb-audio: Add extra PID for RME Digiface USB

Benjamin Tissoires (1):
      selftests/hid: fix kfunc inclusions with newer bpftool

Bernd Schubert (1):
      io_uring: Change res2 parameter type in io_uring_cmd_done

Bibo Mao (1):
      LoongArch: Add architecture specific huge_pte_clear()

Bj=C3=B6rn T=C3=B6pel (1):
      tools: Override makefile ARCH variable if defined, but empty

Brahmajit Das (1):
      smb: server: Fix building with GCC 15

Byoungtae Cho (2):
      dt-bindings: watchdog: Document ExynosAutoV920 watchdog bindings
      watchdog: s3c2410_wdt: add support for exynosautov920 SoC

Catalin Marinas (2):
      arm64: Ensure bits ASID[15:8] are masked out when the kernel
uses 8-bit ASIDs
      arm64: mte: Fix copy_highpage() warning on hugetlb folios

Cathy Avery (1):
      scsi: storvsc: Do not flag MAINTENANCE_IN return of
SRB_STATUS_DATA_OVERRUN as an error

Chris Chiu (1):
      ALSA: hda/realtek: fix micmute LEDs don't work on HP Laptops

Chris Park (1):
      drm/amd/display: Add hblank borrowing support

Christian K=C3=B6nig (1):
      dma-buf: fix dma_fence_array_signaled v4

Christian Marangi (2):
      dt-bindings: watchdog: airoha: document watchdog for Airoha EN7581
      watchdog: Add support for Airoha EN7851 watchdog

Christoph Hellwig (3):
      xfs: don't call xfs_bmap_same_rtgroup in xfs_bmap_add_extent_hole_del=
ay
      nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM is not suppor=
ted
      nvme-pci: don't use dma_alloc_noncontiguous with 0 merge boundary

Christophe JAILLET (2):
      scsi: message: fusion: Constify struct pci_device_id
      scsi: target: tcmu: Constify some structures

Chunguang.xu (4):
      nvme-tcp: fix the memleak while create new ctrl failed
      nvme-rdma: unquiesce admin_q before destroy it
      nvme-tcp: no need to quiesce admin_q in nvme_tcp_teardown_io_queues()
      nvme-tcp: simplify nvme_tcp_teardown_io_queues()

Claudiu Beznea (1):
      watchdog: rzg2l_wdt: Power on the watchdog domain in the restart hand=
ler

Colin Ian King (2):
      docs: ABI: Fix spelling mistake in pretimeout_avaialable_governors
      ALSA: hda/realtek: Fix spelling mistake "Firelfy" -> "Firefly"

Cong Wang (1):
      rtnetlink: fix double call of rtnl_link_get_net_ifla()

Cosmin Ratiu (2):
      net/mlx5: HWS: Fix memory leak in mlx5hws_definer_calc_layout
      net/mlx5: HWS: Properly set bwc queue locks lock classes

Cosmin Tanislav (1):
      regmap: detach regmap from dev on regmap_exit

Dan Carpenter (3):
      ALSA: hda/tas2781: Fix error code tas2781_read_acpi()
      ASoC: SOF: ipc3-topology: fix resource leaks in
sof_ipc3_widget_setup_comp_dai()
      ALSA: usb-audio: Fix a DMA to stack memory bug

Daniel Xu (2):
      bnxt_en: ethtool: Supply ntuple rss context action
      selftests: drv-net: rss_ctx: Add test for ntuple rule

Dario Binacchi (11):
      can: c_can: c_can_handle_bus_err(): update statistics if skb
allocation fails
      can: sun4i_can: sun4i_can_err(): call can_change_state() even if
cf is NULL
      can: hi311x: hi3110_can_ist(): fix potential use-after-free
      can: hi311x: hi3110_can_ist(): update state error statistics if
skb allocation fails
      can: m_can: m_can_handle_lec_err(): fix {rx,tx}_errors statistics
      can: ifi_canfd: ifi_canfd_handle_lec_err(): fix {rx,tx}_errors statis=
tics
      can: hi311x: hi3110_can_ist(): fix {rx,tx}_errors statistics
      can: sja1000: sja1000_err(): fix {rx,tx}_errors statistics
      can: sun4i_can: sun4i_can_err(): fix {rx,tx}_errors statistics
      can: ems_usb: ems_usb_rx_err(): fix {rx,tx}_errors statistics
      can: f81604: f81604_handle_can_bus_errors(): fix {rx,tx}_errors stati=
stics

Dave Chinner (3):
      xfs: fix sparse inode limits on runt AG
      xfs: delalloc and quota softlimit timers are incoherent
      xfs: prevent mount and log shutdown race

David Hildenbrand (2):
      mm/mempolicy: fix migrate_to_node() assuming there is at least
one VMA in a MM
      mm/filemap: don't call folio_test_locked() without a reference
in next_uptodate_folio()

David Wang (2):
      LoongArch/irq: Use seq_put_decimal_ull_width() for decimal values
      mm/codetag: swap tags when migrate pages

David Wei (3):
      bnxt_en: refactor tpa_info alloc/free into helpers
      bnxt_en: refactor bnxt_alloc_rx_rings() to call bnxt_alloc_rx_agg_bma=
p()
      bnxt_en: handle tpa_info in queue API implementation

David Woodhouse (2):
      x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page ta=
bles
      x86/kexec: Restore GDT on return from ::preserve_context kexec

David Yat Sin (1):
      drm/amdkfd: hard-code cacheline for gc943,gc944

Dillon Varone (1):
      drm/amd/display: Limit VTotal range to max hw cap minus fp

Dmitry Antipov (2):
      netfilter: x_tables: fix LED ID check in led_tg_check()
      can: j1939: j1939_session_new(): fix skb reference counting

Dong Chenchen (1):
      net: Fix icmp host relookup triggering ip_rt_bug

Dr. David Alan Gilbert (2):
      scsi: bfa: Remove unused structure builders
      scsi: bfa: Remove unused parsers

Eduard Zingerman (2):
      samples/bpf: Remove unnecessary -I flags from libbpf EXTRA_CFLAGS
      selftests/bpf: Introduce __caps_unpriv annotation for tests

Eric Dumazet (7):
      tcp: populate XPS related fields of timewait sockets
      selinux: use sk_to_full_sk() in selinux_ip_output()
      net: hsr: avoid potential out-of-bound access in fill_frame_info()
      ipv6: avoid possible NULL deref in modify_prefix_route()
      net: hsr: must allocate more bytes for RedBox support
      geneve: do not assume mac header is set in geneve_xmit_skb()
      net: avoid potential UAF in default_operstate()

FUJITA Tomonori (1):
      block: rnull: add missing MODULE_DESCRIPTION

Fabio Estevam (2):
      watchdog: da9063: Do not use a global variable
      watchdog: da9063: Remove __maybe_unused notations

Fei Shao (1):
      dt-bindings: power: mediatek: Add another nested power-domain layer

Fernando Fernandez Mancera (2):
      Revert "udp: avoid calling sock_def_readable() if possible"
      x86/cpu/topology: Remove limit of CPUs due to disabled IO/APIC

Filipe Manana (4):
      btrfs: fix deadlock between transaction commits and extent locks
      btrfs: sysfs: advertise experimental features only if
CONFIG_BTRFS_EXPERIMENTAL=3Dy
      btrfs: don't loop for nowait writes when checking for cross reference=
s
      btrfs: ref-verify: fix use-after-free after invalid ref action

Gal Pressman (1):
      ethtool: Fix access to uninitialized fields in set RXNFC command

Geert Uytterhoeven (1):
      irqchip/stm32mp-exti: CONFIG_STM32MP_EXTI should not default to
y when compile-testing

Geetha sowjanya (1):
      octeontx2-af: Fix SDP MAC link credits configuration

Gwendal Grignou (1):
      scsi: ufs: core: sysfs: Prevent div by zero

Hans de Goede (1):
      mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on Vexia Edu
Atla 10 tablet

Harini T (1):
      watchdog: xilinx_wwdt: Calculate max_hw_heartbeat_ms using clock freq=
uency

Hou Tao (9):
      bpf: Remove unnecessary check when updating LPM trie
      bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
      bpf: Handle BPF_EXIST and BPF_NOEXIST for LPM trie
      bpf: Handle in-place update for full LPM trie correctly
      bpf: Fix exact match conditions in trie_get_next_key()
      bpf: Switch to bpf mem allocator for LPM trie
      bpf: Use raw_spinlock_t for LPM trie
      selftests/bpf: Move test_lpm_map.c to map_tests
      selftests/bpf: Add more test cases for LPM trie

Huacai Chen (3):
      LoongArch: Fix reserving screen info memory for above-4G firmware
      LoongArch: KVM: Protect kvm_check_requests() with SRCU
      LoongArch: KVM: Protect kvm_io_bus_{read,write}() with SRCU

Ido Schimmel (1):
      mlxsw: spectrum_acl_flex_keys: Use correct key block on Spectrum-4

Imre Deak (8):
      drm/dp_mst: Fix MST sideband message body length check
      drm/dp_mst: Fix resetting msg rx state after topology removal
      drm/dp_mst: Verify request type in the corresponding down message rep=
ly
      drm/dp_mst: Simplify error path in drm_dp_mst_handle_down_rep()
      drm/dp_mst: Fix down request message timeout handling
      drm/dp_mst: Ensure mst_primary pointer is valid in
drm_dp_mst_handle_up_req()
      drm/dp_mst: Reset message rx state after OOM in drm_dp_mst_handle_up_=
req()
      drm/dp_mst: Use reset_msg_rx_state() instead of open coding it

Ivan Solodovnikov (1):
      dccp: Fix memory leak in dccp_feat_change_recv

Jacob Keller (2):
      ixgbevf: stop attempting IPSEC offload on Mailbox API 1.5
      ixgbe: downgrade logging of unsupported VF API version to debug

Jakob Hauser (1):
      iio: magnetometer: yas530: use signed integer type for clamp limits

Jakub Kicinski (1):
      MAINTAINERS: list PTP drivers under networking

James Hilliard (1):
      watchdog: it87_wdt: add PWRGD enable quirk for Qotom QCML04

Jan Kara (3):
      udf: Skip parent dir link count update if corrupted
      udf: Verify inode link counts before performing rename
      Revert "readahead: properly shorten readahead when falling back
to do_page_cache_ra()"

Jared Kangas (1):
      kasan: make report_lock a raw spinlock

Jason Gunthorpe (1):
      iommu/arm-smmu-v3: Improve uAPI comment for IOMMU_HW_INFO_TYPE_ARM_SM=
MUV3

Jean Delvare (1):
      watchdog: Delete the cpu5wdt driver

Jianbo Liu (1):
      net/mlx5e: Remove workaround to avoid syndrome for internal port

Jinghao Jia (1):
      ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init=
()

Jiri Wiesner (1):
      net/ipv6: release expired exception dst cached in socket

Joe Damato (1):
      net: Make napi_hash_lock irq safe

Johannes Thumshirn (1):
      btrfs: fix use-after-free in btrfs_encoded_read_endio()

John Garry (1):
      scsi: scsi_debug: Fix hrtimer support for ndelay

John Harrison (1):
      drm/xe: Move the coredump registration to the worker thread

John Hubbard (1):
      mm/gup: handle NULL pages in unpin_user_pages()

John Sperbeck (1):
      mm: memcg: declare do_memsw_account inline

Jordy Zomer (2):
      ksmbd: fix Out-of-Bounds Read in ksmbd_vfs_stream_read
      ksmbd: fix Out-of-Bounds Write in ksmbd_vfs_stream_write

Joshua Hay (1):
      idpf: set completion tag for "empty" bufs associated with a packet

Kalesh Singh (1):
      mm: respect mmap hint address when aligning for THP

Kees Cook (1):
      lib: stackinit: hide never-taken branch from compiler

Keith Busch (1):
      nvme-pci: remove two deallocate zeroes quirks

Kenny Levinsen (1):
      HID: i2c-hid: Revert to using power commands to wake on resume

Konstantin Shkolnyy (3):
      vsock/test: fix failures due to wrong SO_RCVLOWAT parameter
      vsock/test: fix parameter types in SO_VM_SOCKETS_* calls
      vsock/test: verify socket options after setting them

Kory Maincent (1):
      ethtool: Fix wrong mod state in case of verbose and no_mask bitset

Kuan-Wei Chiu (1):
      tracing: Fix cmp_entries_dup() to respect sort() comparison rules

Kumar Kartikeya Dwivedi (5):
      selftests/bpf: Add tests for iter arg check
      bpf: Zero index arg error string for dynptr and iter
      bpf: Don't mark STACK_INVALID as STACK_MISC in mark_stack_slot_misc
      selftests/bpf: Add test for reading from STACK_INVALID slots
      selftests/bpf: Add test for narrow spill into 64-bit spilled scalar

Kuniyuki Iwashima (1):
      tipc: Fix use-after-free of kernel socket in cleanup_bearer().

Larysa Zaremba (1):
      xsk: always clear DMA mapping information when unmapping the pool

Len Brown (1):
      x86/cpu: Add Lunar Lake to list of CPUs with a broken MONITOR
implementation

Liequan Che (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR again

Linus Torvalds (2):
      Get rid of 'remove_new' relic from platform driver struct
      Linux 6.13-rc2

Lion Ackermann (1):
      net: sched: fix ordering of qlen adjustment

Lizhi Xu (1):
      btrfs: add a sanity check for btrfs root in btrfs_search_slot()

Lo-an Chen (1):
      drm/amd/display: Correct prefetch calculation

Long Li (2):
      xfs: eliminate lockdep false positives in xfs_attr_shortform_list
      xfs: remove unknown compat feature check in superblock write validati=
on

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Fix irq_complete_ack() comment

Lorenzo Stoakes (1):
      mm: correct typo in MMAP_STATE() macro

Louis Leseur (1):
      net/qed: allow old cards not supporting "num_images" to work

Maciej Fijalkowski (2):
      xsk: fix OOB map writes when deleting elements
      bpf: fix OOB devmap writes when deleting elements

Magnus Lindholm (1):
      scsi: qla1280: Fix hw revision numbering for ISP1020/1040

Manivannan Sadhasivam (5):
      scsi: ufs: core: Cancel RTC work during ufshcd_remove()
      scsi: ufs: qcom: Only free platform MSIs when ESI is enabled
      scsi: ufs: pltfrm: Disable runtime PM during removal of glue drivers
      scsi: ufs: pltfrm: Drop PM runtime reference count after ufshcd_remov=
e()
      scsi: ufs: pltfrm: Dellocate HBA during ufshcd_pltfrm_remove()

Marc Kleine-Budde (2):
      can: dev: can_set_termination(): allow sleeping GPIOs
      can: mcp251xfd: mcp251xfd_get_tef_len(): work around erratum
DS80000789E 6.

Marc Zyngier (1):
      arch_numa: Restore nid checks before registering a memblock with a no=
de

Marcin Szycik (1):
      ice: Fix VLAN pruning in switchdev mode

Marco Elver (1):
      stackdepot: fix stack_depot_save_flags() in NMI context

Marek Maslanka (1):
      ASoC: Intel: avs: da7219: Remove suspend_pre() and resume_post()

Marek Vasut (1):
      watchdog: stm32_iwdg: Add pretimeout support

Marie Ramlow (1):
      ALSA: usb-audio: add mixer mapping for Corsair HS80

Mario Limonciello (2):
      drm/amd: Sanity check the ACPI EDID
      drm/amd/display: Fix programming backlight on OLED panels

Mark Brown (2):
      regmap: Use correct format specifier for logging range errors
      selftest: hugetlb_dio: fix test naming

Mark Harmstone (1):
      btrfs: fix lockdep warnings on io_uring encoded reads

Mark Rutland (5):
      arm64: patching: avoid early page_to_phys()
      arm64: ptrace: fix partial SETREGSET for NT_ARM_TAGGED_ADDR_CTRL
      arm64: ptrace: fix partial SETREGSET for NT_ARM_FPMR
      arm64: ptrace: fix partial SETREGSET for NT_ARM_POE
      arm64: ptrace: fix partial SETREGSET for NT_ARM_GCS

Martin Ottens (1):
      net/sched: tbf: correct backlog statistic for GSO packets

Masahiro Yamada (4):
      scripts/nsdeps: get 'make nsdeps' working again
      doc: module: revert misconversions for MODULE_IMPORT_NS()
      module: Convert default symbol namespace to string literal
      kbuild: deb-pkg: fix build error with O=3D

Matthew Wilcox (Oracle) (2):
      mm: open-code PageTail in folio_flags() and const_folio_flags()
      mm: open-code page_folio() in dump_page()

Maurizio Lombardi (1):
      nvme-fabrics: handle zero MAXCMD without closing the connection

Maximilian Heyne (2):
      selftests: hid: fix typo and exit code
      selftests/damon: add _damon_sysfs.py to TEST_FILES

Ma=C3=ADra Canal (1):
      drm/v3d: Enable Performance Counters before clearing them

Michal Luczaj (4):
      bpf, vsock: Fix poll() missing a queue
      selftest/bpf: Add test for af_vsock poll()
      bpf, vsock: Invoke proto::close on close()
      selftest/bpf: Add test for vsock removal from sockmap on close()

Mike Rapoport (Microsoft) (1):
      memblock: allow zero threshold in validate_numa_converage()

Ming Lei (3):
      virtio-blk: don't keep queue frozen during system suspend
      blk-mq: register cpuhp callback after hctx is added to xarray table
      blk-mq: move cpuhp callback registering out of q->sysfs_lock

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable mute and micmute LED on HP ProBook 430 G8

Nick Chan (2):
      watchdog: apple: Actually flush writes after requesting watchdog rest=
art
      watchdog: apple: Increase reset delay to 150ms

Nicolin Chen (2):
      iommufd: Fix out_fput in iommufd_fault_alloc()
      iommufd/selftest: Cover IOMMU_FAULT_QUEUE_ALLOC in iommufd_fail_nth

Nilay Shroff (1):
      nvmet: use kzalloc instead of ZERO_PAGE in nvme_execute_identify_ns_n=
vm()

Nilesh Javali (1):
      scsi: qla2xxx: Update version to 10.02.09.400-k

Norbert Szetei (1):
      ksmbd: align aux_payload_buf to avoid OOB reads in cryptographic
operations

N=C3=ADcolas F. R. A. Prado (1):
      ASoC: mediatek: mt8188-mt6359: Remove hardcoded dmic codec

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

Oleksandr Ocheretnyi (1):
      iTCO_wdt: mask NMI_NOW bit for update_no_reboot_bit() call

Oleksij Rempel (1):
      net: phy: microchip: Reset LAN88xx PHY to ensure clean link
state on LAN7800/7850

Pablo Neira Ayuso (3):
      netfilter: nft_socket: remove WARN_ON_ONCE on maximum cgroup level
      netfilter: nft_inner: incorrect percpu area handling under softirq
      netfilter: nft_set_hash: skip duplicated elements pending gc run

Paolo Abeni (1):
      ipmr: tune the ipmr_can_free_table() checks.

Patrisious Haddad (2):
      net/mlx5: E-Switch, Fix switching to switchdev mode with IB
device disabled
      net/mlx5: E-Switch, Fix switching to switchdev mode in MPV

Paulo Alcantara (1):
      smb: client: fix potential race in cifs_put_tcon()

Pei Xiao (2):
      drm/sti: Add __iomem for mixer_dbg_mxn's parameter
      spi: mpc52xx: Add cancel_work_sync before module remove

Peter Griffin (1):
      Revert "watchdog: s3c2410_wdt: use
exynos_get_pmu_regmap_by_phandle() for PMU regs"

Peter Wang (1):
      scsi: ufs: core: Add missing post notify for power mode change

Peter Zijlstra (1):
      module: Convert symbol namespace to string literal

Peterson Guo (1):
      drm/amd/display: Add a left edge pixel if in YCbCr422 or YCbCr420 and=
 odm

Phil Sutter (1):
      netfilter: ipset: Hold module reference while requesting a module

Pratap Nirujogi (1):
      drm/amdgpu: Fix ISP hw init issue

Przemyslaw Korba (1):
      ice: fix PHY timestamp extraction for ETH56G

Purushothama Siddaiah (1):
      spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enab=
led()

Qinxin Xia (1):
      ACPI/IORT: Add PMCG platform information for HiSilicon HIP09A

Quinn Tran (3):
      scsi: qla2xxx: Fix abort in bsg timeout
      scsi: qla2xxx: Fix use after free on unload
      scsi: qla2xxx: Fix NVMe and NPIV connect issue

Ralph Boehme (3):
      fs/smb/client: avoid querying SMB2_OP_QUERY_WSL_EA for SMB3 POSIX
      fs/smb/client: Implement new SMB3 POSIX type
      fs/smb/client: cifs_prime_dcache() for SMB3 POSIX reparse points

Randy Dunlap (2):
      iommufd: Fix typos in kernel-doc comments
      scatterlist: fix incorrect func name in kernel-doc

Ranjan Kumar (7):
      scsi: mpt3sas: Diag-Reset when Doorbell-In-Use bit is set during
driver load time
      scsi: mpt3sas: Update driver version to 51.100.00.00
      scsi: mpi3mr: Synchronize access to ioctl data buffer
      scsi: mpi3mr: Fix corrupt config pages PHY state is switched in sysfs
      scsi: mpi3mr: Start controller indexing from 0
      scsi: mpi3mr: Handling of fault code for insufficient power
      scsi: mpi3mr: Update driver version to 8.12.0.3.50

Ricardo Neri (2):
      cacheinfo: Allocate memory during CPU hotplug if not done from
the primary CPU
      x86/cacheinfo: Delete global num_cache_leaves

Richard Weinberger (1):
      jffs2: Fix rtime decompressor

Robin Murphy (1):
      arm64: cpufeature: Add GCS to cpucap_is_possible()

Rosen Penev (1):
      watchdog: armada_37xx_wdt: remove struct resource

Ryusuke Konishi (1):
      nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry=
()

Sahas Leelodharry (1):
      ALSA: hda/realtek: Add support for Samsung Galaxy Book3 360 (NP730QFG=
)

Sasha Finkelstein (1):
      spi: apple: Set use_gpio_descriptors to true

Saurav Kashyap (1):
      scsi: qla2xxx: Remove check req_sg_cnt should be equal to rsp_sg_cnt

Sean Christopherson (1):
      x86/CPU/AMD: WARN when setting EFER.AUTOIBRS if and only if the
WRMSR fails

Sebastian Andrzej Siewior (1):
      selftests/bpf: Check for PREEMPTION instead of PREEMPT

Sedat Dilek (1):
      platform/x86: samsung-laptop: Match MODULE_DESCRIPTION() to functiona=
lity

Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Adjust delay after power up handshake

Shradha Gupta (1):
      net :mana :Request a V2 response version for MANA_QUERY_GF_STAT

Sreekant Somasekharan (1):
      drm/amdkfd: add MEC version that supports no PCIe atomics for GFX12

Stefan Wahren (1):
      irqchip/bcm2836: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

Steve French (1):
      smb3.1.1: fix posix mounts to older servers

Steven Rostedt (1):
      tracing: Fix archs that still call tracepoints without RCU watching

Sung Lee (1):
      drm/amd/display: Add option to retrieve detile buffer size

Suraj Sonawane (1):
      scsi: sg: Fix slab-use-after-free read in sg_release()

Suzuki K Poulose (1):
      coco: virt: arm64: Do not enable cca guest driver by default

Takashi Iwai (7):
      ALSA: seq: ump: Fix seq port updates per FB info notify
      ALSA: ump: Don't open legacy substream for an inactive group
      ALSA: ump: Indicate the inactive group in legacy substream names
      ALSA: ump: Update legacy substream names upon FB info update
      ALSA: usb-audio: Notify xrun for low-latency mode
      ALSA: sh: Use standard helper for buffer accesses
      ALSA: ump: Shut up truncated string warning

Tao Lyu (2):
      bpf: Ensure reg is PTR_TO_STACK in process_iter_arg
      bpf: Fix narrow scalar spill onto 64-bit spilled scalar slots

Tariq Toukan (1):
      net/mlx5e: SD, Use correct mdev to build channel param

Tetsuo Handa (1):
      ocfs2: free inode when ocfs2_get_init_inode() fails

Thomas Gleixner (3):
      genirq/proc: Add missing space separator back
      clocksource: Make negative motion detection more robust
      modpost: Add .irqentry.text to OTHER_SECTIONS

Thomas Wei=C3=9Fschuh (3):
      bpf, lsm: Remove getlsmprop hooks BTF IDs
      HID: bpf: constify hid_ops
      HID: bpf: drop unneeded casts discarding const

Tiezhu Yang (1):
      LoongArch: BPF: Adjust the parameter of emit_jirl()

Tomas Henzl (1):
      scsi: megaraid_sas: Fix for a potential deadlock

Tore Amundsen (1):
      ixgbe: Correct BASE-BX10 compliance code

Tvrtko Ursulin (2):
      dma-fence: Fix reference leak on fence merge failure path
      dma-fence: Use kernel's sort for merging fences

Ulf Hansson (3):
      mmc: core: Further prevent card detect during shutdown
      pmdomain: core: Add missing put_device()
      pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fail=
s

Uros Bizjak (1):
      xfs: Use xchg() in xlog_cil_insert_pcp_aggregate()

Uwe Kleine-K=C3=B6nig (3):
      watchdog: ziirave_wdt: Drop explicit initialization of struct
i2c_device_id::driver_data to 0
      watchdog: Switch back to struct platform_driver::remove()
      scsi: ufs: Switch back to struct platform_driver::remove()

Vladimir Oltean (1):
      net: enetc: read TSN capabilities from port register, not SI

Vyshnav Ajith (1):
      docs: net: bareudp: fix spelling and grammar mistakes

WangYuli (1):
      HID: wacom: fix when get product name maybe null pointer

Wei Fang (1):
      net: enetc: Do not configure preemptible TCs if SIs do not support

Wen Gu (2):
      net/smc: initialize close_work early to avoid warning
      net/smc: fix LGR and link use-after-free issue

Wengang Wang (1):
      ocfs2: update seq_file index in ocfs2_dlm_seq_next

Will Deacon (2):
      drivers/virt: pkvm: Don't fail ioremap() call if MMIO_GUARD fails
      MAINTAINERS: Add CCA and pKVM CoCO guest support to the ARM64 entry

Wojciech Drewek (1):
      ice: Fix NULL pointer dereference in switchdev

Wolfram Sang (9):
      watchdog: always print when registering watchdog fails
      watchdog: da9055_wdt: don't print out if registering watchdog fails
      watchdog: gxp-wdt: don't print out if registering watchdog fails
      watchdog: iTCO_wdt: don't print out if registering watchdog fails
      watchdog: it87_wdt: don't print out if registering watchdog fails
      watchdog: octeon-wdt: don't print out if registering watchdog fails
      watchdog: rti_wdt: don't print out if registering watchdog fails
      watchdog: rza_wdt: don't print out if registering watchdog fails
      watchdog: sl28cpld_wdt: don't print out if registering watchdog fails

Xin Liu (1):
      dt-bindings: watchdog: Document Qualcomm QCS8300

Xin Long (1):
      net: sched: fix erspan_opt settings in cls_flower

Xingyu Wu (1):
      MAINTAINERS: Update the maintainer of StarFive watchdog driver

Yafang shao (1):
      audit: workaround a GCC bug triggered by task comm changes

Yan Zhen (1):
      watchdog: fix typo in the comment

Yang Shi (2):
      arm64: mte: set VM_MTE_ALLOWED for hugetlbfs at correct place
      arm64: mm: Fix zone_dma_limit calculation

Yassine Oudjana (2):
      watchdog: mediatek: Make sure system reset gets asserted in
mtk_wdt_restart()
      watchdog: mediatek: Add support for MT6735 TOPRGU/WDT

Yiqing Yao (1):
      drm/amdgpu: fix sriov reinit late orders

Yu-Chun Lin (1):
      nvmet: replace kmalloc + memset with kzalloc for data allocation

Yuan Can (1):
      igb: Fix potential invalid memory access in igb_init_module()

Zhanjun Dong (1):
      drm/xe/guc: Fix missing init value and add register order check

Zijian Zhang (2):
      tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg
      selftests/bpf: Add apply_bytes test to
test_txmsg_redir_wait_sndmem in test_sockmap

Ziqi Chen (1):
      scsi: ufs: core: Add ufshcd_send_bsg_uic_cmd() for UFS BSG

bo liu (1):
      ALSA: hda/conexant: fix Z60MR100 startup pop issue

lijuang (1):
      dt-bindings: watchdog: Document Qualcomm QCS615 watchdog

liujing (1):
      scsi: lpfc: Fix spelling errors 'asynchronously'

