Return-Path: <linux-kernel+bounces-394052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C76919BA9BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 01:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7F71C209F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 00:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B8379FD;
	Mon,  4 Nov 2024 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DbAJefBt"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C623C2F
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 00:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730679607; cv=none; b=msaxnPThurgTOC3N2BpasoYX/qUFNmGoQt0UF1R+ve4Dtn57t0FRou7142xSbEi/4R9f0VnnlpzLh2DWEDaubFurXdvDRk/v3C81JnOFIdcLj7w7nFQQx4aCx9MGNa35LpgxpNwr82lMTT24Pqrf49GhfDMeeGlYAbZMd32B9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730679607; c=relaxed/simple;
	bh=mKQ18Hlj3xARtheriAIObC/5AvGfLD1IbFVhtD+6nh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lt6DnpYIpbGwAzCqwp63xJsr2TyFjSVRie9r8QE4I5JMgVwoYyv/w48x9+y67Ai+YDl1BKiK5OeyaE17tSgznsGyxynTsk7JJoek3ihbZpsNLy1RhejjWDRI7PMNJDHzC/9Q9WchiV/16mF8IFpi912204+tY2DAUWtm9BY6PAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DbAJefBt; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cecbddb574so1479459a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730679602; x=1731284402; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LNRHlBtHXRuNBRUvAvmFCuCcshM/d2PLATA5PD+wmcE=;
        b=DbAJefBtctckrcBqY9s+afkhbUggtdfN6sAZ/dliSOE98e5+IQ3xaIEgFHDsZtvBEU
         BK75ONaAii7pmxgsGllKVdqNR9rfRRYW0ZTOJF69mnEsYgb2bfSyVLYdyE/6mNV0UfO2
         AiLdQ16KNvaerWKs6W7Q1YHX8nbDNc9tMaMc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730679602; x=1731284402;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNRHlBtHXRuNBRUvAvmFCuCcshM/d2PLATA5PD+wmcE=;
        b=myLE/gjhtSwPNmvc91n1t+EvkIyCgGcsalHuaFH44FUUKTmmQlmXlaTcxWsagbwT4n
         DEOta+5rGRnal6bOlwlhPFw/q322nH/FCtmKnIMKfRbReWELG6dAv+2zXSiJPAXxDbPf
         Qhmwbuw5giEqBjSDbO0DkvBGvRyKtUUHA9ZjrFFV0ZIurPJS3zFMSvxP1kw/765RwBjP
         GmIotn9QhFenw7R9UennWfwXtSWOjQhA4OgKcKusJijzc3LOrBplUCXSDxN4VhHtMWeB
         2TPGzWzaJYOu6aMj+5FxY1I0J10dCOE/2Cet8f2S9jnOY3BmWaRpye35GRzls2Kq347H
         rldA==
X-Gm-Message-State: AOJu0Yy4nfkTRwhWxFokHVWvIH8NMcjPliFcyfhhYoA+iSGC5qUWmk1i
	F51r+DLH6UK2/lXTha0EPPQCJDQRXg75ygJC+MqIV5DcFHz6ct7R+5Likk4Y67jcrQn98Gcq/mG
	1
X-Google-Smtp-Source: AGHT+IE8m7WrWEoSYZ7jj2CzOXD6XioeSBNkDe8VeQ1Lb7wyMFVTahoIj+0B+a/NgxCCWZBcTU6+qA==
X-Received: by 2002:a05:6402:5249:b0:5ca:14f3:2883 with SMTP id 4fb4d7f45d1cf-5cbbf8884famr23361142a12.4.1730679601998;
        Sun, 03 Nov 2024 16:20:01 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac78cd18sm3881690a12.52.2024.11.03.16.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 16:20:00 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9abe139088so558416866b.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 16:19:59 -0800 (PST)
X-Received: by 2002:a17:906:478f:b0:a99:f56e:ce40 with SMTP id
 a640c23a62f3a-a9de6166952mr2947118166b.47.1730679598950; Sun, 03 Nov 2024
 16:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Nov 2024 14:19:42 -1000
X-Gmail-Original-Message-ID: <CAHk-=whORbp07SkmAUbXTRtjk7imEgWXReGMaeteMg-gAFU_cA@mail.gmail.com>
Message-ID: <CAHk-=whORbp07SkmAUbXTRtjk7imEgWXReGMaeteMg-gAFU_cA@mail.gmail.com>
Subject: Linux 6.12-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another week, another rc. Nothing odd or special seems to be going on
- this may be a bit on the bigger side for an rc6, but not hugely so,
and nothing stands out.

We've got about 40% of the diff being drivers (networking, gpu, clx,
sound, iio..) with the rest being a mix of a bit of everything:
tooling, documentation, core MM and networking, filesystems (bcachefs,
xfs, btrfs, afs) and some tiny arch fixes.

Shortlog appended in case you need to read something to fall asleep to.

For rc6, boring is good.

               Linus

---

Abel Vesa (1):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix X1E80100 resets ent=
ries

Aboorva Devarajan (1):
      sched: Pass correct scheduling policy to __setscheduler_class

Abylay Ospan (1):
      MAINTAINERS: add netup_unidvb maintainer

Alain Volmat (1):
      spi: stm32: fix missing device mode capability in stm32mp25

Aleksei Vetrov (1):
      ASoC: dapm: fix bounds checker error in dapm_widget_list_create

Alessandro Zanni (2):
      selftests/intel_pstate: fix operand expected error
      selftests/intel_pstate: check if cpupower is installed

Alex Deucher (1):
      drm/amdgpu/smu13: fix profile reporting

Alexander Usyskin (1):
      mei: use kvmalloc for read buffer

Alexandre Ghiti (2):
      riscv: vdso: Prevent the compiler from inserting calls to memset()
      riscv: Do not use fortify in early code

Alexey Klimov (2):
      ASoC: codecs: wcd937x: add missing LO Switch control
      ASoC: codecs: wcd937x: relax the AUX PDM watchdog

Alice Ryhl (1):
      cfi: tweak llvm version for HAVE_CFI_ICALL_NORMALIZE_INTEGERS

Amit Cohen (3):
      mlxsw: spectrum_ptp: Add missing verification before pushing Tx heade=
r
      mlxsw: pci: Sync Rx buffers for CPU
      mlxsw: pci: Sync Rx buffers for device

Amit Sunil Dhamne (1):
      usb: typec: tcpm: restrict SNK_WAIT_CAPABILITIES_TIMEOUT
transitions to non self-powered devices

Andrey Konovalov (1):
      kasan: remove vmalloc_percpu test

Andrzej Kacprowski (1):
      accel/ivpu: Fix NOC firewall interrupt handling

Andy Shevchenko (1):
      gpio: sloppy-logic-analyzer: Check for error code from
devm_mutex_init() call

Anjaneyulu (1):
      wifi: iwlwifi: mvm: SAR table alignment

Arkadiusz Kubalewski (1):
      ice: fix crash on probe for DPLL enabled E810 LOM

Arnaldo Carvalho de Melo (9):
      tools headers UAPI: Sync linux/const.h with the kernel headers
      perf trace: The return from 'write' isn't a pid
      perf trace augmented_raw_syscalls: Add extra array index bounds
checking to satisfy some BPF verifiers
      tools headers UAPI: Sync kvm headers with the kernel sources
      perf python: Fix up the build on architectures without
HAVE_KVM_STAT_SUPPORT
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers: Synchronize {uapi/}linux/bits.h with the kernel source=
s
      tools headers arm64: Sync arm64's cputype.h with the kernel sources
      tools headers: Update the linux/unaligned.h copy with the kernel sour=
ces

Arnd Bergmann (1):
      x86/amd_nb: Fix compile-testing without CONFIG_AMD_NB

Barry Song (2):
      mm: avoid unconditional one-tick sleep when swapcache_prepare fails
      mm: fix PSWPIN counter for large folios swap-in

Bartosz Golaszewski (1):
      spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()

Bartosz Wawrzyniak (1):
      phy: cadence: Sierra: Fix offset of DEQ open eye algorithm
control register

Basavaraj Natikar (1):
      xhci: Use pm_runtime_get to prevent RPM on unsupported systems

Ben Greear (2):
      wifi: mac80211: Fix setting txpower with emulate_chanctx
      mac80211: fix user-power when emulating chanctx

Ben Hutchings (1):
      wifi: iwlegacy: Fix "field-spanning write" warning in il_enqueue_hcmd=
()

Benjamin Gro=C3=9Fe (1):
      usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 dr=
iver

Benjamin Segall (1):
      posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

Beno=C3=AEt Monin (2):
      net: usb: qmi_wwan: add Quectel RG650V
      net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains exten=
sion

Bitterblue Smith (2):
      wifi: rtw88: Fix the RX aggregation in USB 3 mode
      wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171

Boris Brezillon (3):
      drm/panthor: Fix firmware initialization on systems with a page size =
> 4k
      drm/panthor: Fail job creation when the group is dead
      drm/panthor: Report group as timedout when we fail to properly suspen=
d

Byeonguk Jeong (2):
      bpf: Fix out-of-bounds write in trie_get_next_key()
      selftests/bpf: Add test for trie_get_next_key()

Chen Ridong (2):
      cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction
      mm: shrinker: avoid memleak in alloc_shrinker_info

Chenming Huang (1):
      wifi: cfg80211: Do not create BSS entries for unsupported channels

Chi Zhiling (1):
      xfs: Reduce unnecessary searches when searching for the best extents

Christoffer Sandberg (2):
      ALSA: hda/realtek: Fix headset mic on TUXEDO Gemini 17 Gen3
      ALSA: hda/realtek: Fix headset mic on TUXEDO Stellaris 16 Gen6 mb1

Christoph Hellwig (4):
      iomap: turn iomap_want_unshare_iter into an inline function
      block: fix queue limits checks in blk_rq_map_user_bvec for real
      xfs: fix finding a last resort AG in xfs_filestream_pick_ag
      xfs: streamline xfs_filestream_pick_ag

Christophe JAILLET (1):
      ASoC: cs42l51: Fix some error handling paths in cs42l51_probe()

Chuck Lever (3):
      NFSD: Initialize struct nfsd4_copy earlier
      NFSD: Never decrement pending_async_copies on error
      rpcrdma: Always release the rpcrdma_device's xa_array

Chunyan Zhang (2):
      riscv: Remove unused GENERATING_ASM_OFFSETS
      riscv: Remove duplicated GET_RM

Cong Wang (1):
      sock_map: fix a NULL pointer dereference in sock_map_link_update_prog=
()

Conor Dooley (1):
      RISC-V: disallow gcc + rust builds

Cristian Ciocaltea (1):
      phy: phy-rockchip-samsung-hdptx: Depend on CONFIG_COMMON_CLK

Dan Carpenter (2):
      drm/mediatek: Fix potential NULL dereference in mtk_crtc_destroy()
      drm/tegra: Fix NULL vs IS_ERR() check in probe()

Dan Williams (6):
      cxl/port: Fix CXL port initialization order when the subsystem is bui=
lt-in
      cxl/port: Fix cxl_bus_rescan() vs bus_rescan_devices()
      cxl/acpi: Ensure ports ready at cxl_acpi_probe() return
      cxl/port: Fix use-after-free, permit out-of-order decoder shutdown
      cxl/port: Prevent out-of-order decoder allocation
      cxl/test: Improve init-order fidelity relative to real-world systems

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Use the sync timepoint API in suspend
      wifi: iwlwifi: mvm: Fix response handling in iwl_mvm_send_recovery_cm=
d()

Daniel Golle (1):
      net: ethernet: mtk_wed: fix path of MT7988 WO firmware

Darrick J. Wong (4):
      xfs: don't allocate COW extents when unsharing a hole
      iomap: share iomap_unshare_iter predicate code with fsdax
      fsdax: remove zeroing code from dax_unshare_iter
      fsdax: dax_unshare_iter needs to copy entire blocks

David Hildenbrand (1):
      mm/pagewalk: fix usage of pmd_leaf()/pud_leaf() without present check

David Howells (2):
      afs: Fix missing subdir edit when renamed between parent dirs
      iov_iter: Fix iov_iter_get_pages*() for folio_queue

David Sterba (1):
      MIPS: export __cmpxchg_small()

David Vernet (2):
      scx: Fix exit selftest to use custom DSQ
      scx: Fix raciness in scx_ops_bypass()

Dipendra Khadka (1):
      phy: tegra: xusb: Add error pointer check in xusb.c

Dmitry Torokhov (3):
      Input: edt-ft5x06 - fix regmap leak when probe fails
      Input: adp5588-keys - do not try to disable interrupt 0
      Input: fix regression when re-registering input handlers

Dmitry Yashin (1):
      ASoC: dt-bindings: rockchip,rk3308-codec: add port property

Dong Chenchen (1):
      netfilter: Fix use-after-free in get_info()

Eduard Zingerman (3):
      bpf: Force checkpoint when jmp history is too long
      selftests/bpf: Test with a very short loop
      bpf: disallow 40-bytes extra stack for bpf_fastcall patterns

Edward Adam Davis (1):
      ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow

Edward Liaw (3):
      Revert "selftests/mm: fix deadlock for fork after pthread_create on A=
RM"
      Revert "selftests/mm: replace atomic_bool with pthread_barrier_t"
      selftests/mm: fix deadlock for fork after pthread_create with atomic_=
bool

Elena Salomatkina (1):
      sumversion: Fix a memory leak in get_src_version()

Emmanuel Grumbach (3):
      wifi: iwlwifi: mvm: don't leak a link on AP removal
      wifi: iwlwifi: mvm: don't add default link in fw restart flow
      Revert "wifi: iwlwifi: remove retry loops in start"

Eric Dumazet (1):
      netfilter: nf_reject_ipv6: fix potential crash in nf_send_reset6()

Eugen Hristev (1):
      .mailmap: update e-mail address for Eugen Hristev

Faisal Hassan (1):
      xhci: Fix Link TRB DMA in command ring stopped completion event

Felix Fietkau (3):
      wifi: mt76: do not increase mcu skb refcount if retry is not supporte=
d
      wifi: mac80211: do not pass a stopped vif to the driver in .get_txpow=
er
      wifi: mac80211: skip non-uploaded keys in ieee80211_iter_keys

Filipe Manana (2):
      btrfs: fix extent map merging not happening for adjacent extents
      btrfs: fix defrag not merging contiguous extents due to merged extent=
 maps

Florian Westphal (1):
      selftests: netfilter: nft_flowtable.sh: make first pass deterministic

Frank Li (1):
      spi: spi-fsl-dspi: Fix crash when not using GPIO chip select

Furong Xu (1):
      net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data

Gao Xiang (2):
      fs/super.c: introduce get_tree_bdev_flags()
      erofs: use get_tree_bdev_flags() to avoid misleading messages

Gaosheng Cui (1):
      bcachefs: fix possible null-ptr-deref in __bch2_ec_stripe_head_get()

Geert Uytterhoeven (2):
      mac80211: MAC80211_MESSAGE_TRACING should depend on TRACING
      wifi: brcm80211: BRCM_TRACING should depend on TRACING

Georgi Djakov (1):
      spi: geni-qcom: Fix boot warning related to pm_runtime and devres

Gianfranco Trad (1):
      bcachefs: Fix invalid shift in validate_sb_layout()

Gil Fine (1):
      thunderbolt: Honor TMU requirements in the domain when setting TMU mo=
de

Greg Kroah-Hartman (1):
      Revert "driver core: Fix uevent_show() vs driver detach race"

Gregory Price (2):
      resource,kexec: walk_system_ram_res_rev must retain resource flags
      vmscan,migrate: fix page count imbalance on node stats when demoting =
pages

Gustavo A. R. Silva (2):
      wifi: radiotap: Avoid -Wflex-array-member-not-at-end warnings
      wifi: mac80211: ieee80211_i: Fix memory corruption bug in struct
ieee80211_chanctx

Hans de Goede (5):
      ASoC: codecs: rt5640: Always disable IRQs from rt5640_cancel_work()
      ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated code=
c
      ASoC: Intel: bytcr_rt5640: Add DMI quirk for Vexia Edu Atla 10 tablet
      ASoC: Intel: sst: Support LPE0F28 ACPI HID
      ASoC: Intel: sst: Fix used of uninitialized ctx to log an error

Hao Ge (1):
      mm/codetag: fix null pointer check logic for ref and tag

Hao Lan (4):
      net: hns3: fixed reset failure issues caused by the incorrect reset t=
ype
      net: hns3: fix missing features due to dev->features
configuration too early
      net: hns3: Resolved the issue that the debugfs query result is
inconsistent.
      net: hns3: fixed hclge_fetch_pf_reg accesses bar space out of bounds =
issue

Heinrich Schuchardt (1):
      riscv: efi: Set NX compat flag in PE/COFF header

Hongbo Li (1):
      doc: correcting the debug path for cachefiles

Hou Tao (5):
      bpf: Free dynamically allocated bits in bpf_iter_bits_destroy()
      bpf: Add bpf_mem_alloc_check_size() helper
      bpf: Check the validity of nr_words in bpf_iter_bits_new()
      bpf: Use __u64 to save the bits in bits iterator
      selftests/bpf: Add three test cases for bits_iter

Howard Chu (2):
      perf trace augmented_raw_syscalls: Add more checks to pass the verifi=
er
      perf build: Change the clang check back to 12.0.1

Hsin-Te Yuan (1):
      drm/mediatek: Fix color format MACROs in OVL

Huang Ying (1):
      resource: remove dependency on SPARSEMEM from GET_FREE_REGION

Hugh Dickins (1):
      iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP

Ian Kent (1):
      autofs: fix thinko in validate_dev_ioctl()

Ian Rogers (1):
      perf cap: Add __NR_capget to arch/x86 unistd

Ido Schimmel (4):
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_f=
low()
      ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
      mlxsw: spectrum_ipip: Fix memory leak when changing remote IPv6 addre=
ss
      selftests: forwarding: Add IPv6 GRE remote change tests

Ihor Solodrai (1):
      selftests/sched_ext: add order-only dependency of runner.o on BPFOBJ

Imre Deak (2):
      drm/xe/display: Separate the d3cold and non-d3cold runtime PM handlin=
g
      drm/xe/display: Add missing HPD interrupt enabling during
non-d3cold RPM resume

Jai Luthra (1):
      dmaengine: ti: k3-udma: Set EOP for all TRs in cyclic BCDMA transfer

Jan Kiszka (1):
      phy: starfive: jh7110-usb: Fix link configuration to controller

Jan Sch=C3=A4r (1):
      ALSA: usb-audio: Add quirks for Dell WD19 dock

Jann Horn (1):
      mm: mark mas allocation in vms_abort_munmap_vmas as __GFP_NOFAIL

Jarkko Sakkinen (4):
      tpm: Return tpm2_sessions_init() when null key creation fails
      tpm: Rollback tpm2_load_null()
      tpm: Lazily flush the auth session
      mailmap: update Jarkko's email addresses

Jason Gunthorpe (1):
      PCI: Fix pci_enable_acs() support for the ACS quirks

Jason-JH.Lin (5):
      drm/mediatek: ovl: Fix XRGB format breakage for blend_modes
unsupported SoCs
      drm/mediatek: ovl: Refine ignore_pixel_alpha comment and placement
      drm/mediatek: ovl: Remove the color format comment for ovl_fmt_conver=
t()
      drm/mediatek: ovl: Add blend_modes to driver data
      drm/mediatek: Add blend_modes to mtk_plane_init() for different SoCs

Javier Carrasco (5):
      iio: light: veml6030: fix microlux value calculation
      usb: typec: qcom-pmic-typec: use fwnode_handle_put() to release fwnod=
es
      usb: typec: qcom-pmic-typec: fix missing fwnode removal in error path
      usb: typec: fix unreleased fwnode_handle in typec_port_register_altmo=
des()
      usb: typec: use cleanup facility for 'altmodes_node'

Jeff Xu (1):
      mseal: update mseal.rst

Jens Axboe (1):
      io_uring/rw: fix missing NOWAIT check for O_DIRECT start write

Jeongjun Park (3):
      bcachefs: fix shift oob in alloc_lru_idx_fragmentation
      bcachefs: fix null-ptr-deref in have_stripes()
      mm: shmem: fix data-race in shmem_getattr()

Jian Shen (3):
      net: hns3: add sync command to sync io-pgtable
      net: hns3: don't auto enable misc vector
      net: hns3: initialize reset_timer before hclgevf_misc_irq_init()

Jianbo Liu (1):
      macsec: Fix use-after-free while sending the offloading packet

Jiayuan Chen (1):
      bpf: fix filed access without lock

Jie Wang (1):
      net: hns3: fix kernel crash when 1588 is sent on HIP08 devices

Jinjie Ruan (7):
      iio: gts-helper: Fix memory leaks in iio_gts_build_avail_scale_table(=
)
      iio: gts-helper: Fix memory leaks for the error path of
iio_gts_build_avail_scale_table()
      iio: dac: Kconfig: Fix build error for ltc2664
      genirq/msi: Fix off-by-one error in msi_domain_alloc()
      drm/tests: helpers: Add helper for drm_display_mode_from_cea_vic()
      drm/connector: hdmi: Fix memory leak in drm_display_mode_from_cea_vic=
()
      drm/tests: hdmi: Fix memory leaks in drm_display_mode_from_cea_vic()

Jiri Slaby (1):
      perf trace: Fix non-listed archs in the syscalltbl routines

Johan Hovold (8):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: add missing
x1e80100 pipediv2 clocks
      phy: qcom: qmp-usb: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usb-legacy: fix NULL-deref on runtime suspend
      phy: qcom: qmp-usbc: fix NULL-deref on runtime suspend
      phy: qcom: qmp-combo: move driver data initialisation earlier
      phy: qcom: qmp-pcie: drop bogus x1e80100 qref supplies
      gpiolib: fix debugfs newline separators
      gpiolib: fix debugfs dangling chip separator

Johannes Berg (2):
      wifi: cfg80211: clear wdev->cqm_config pointer on free
      wifi: iwlwifi: mvm: fix 6 GHz scan construction

John Garry (1):
      scsi: scsi_debug: Fix do_device_access() handling of unexpected
SG copy length

John Hubbard (1):
      mm/gup: stop leaking pinned pages in low memory conditions

Julien Stephan (5):
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
      iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7380: add missing supplies
      iio: adc: ad7380: fix supplies for ad7380-4
      docs: iio: ad7380: fix supply for ad7380-4

Justin Chen (1):
      phy: usb: disable COMMONONN for dual mode

Kailang Yang (1):
      ALSA: hda/realtek: Limit internal Mic boost on Dell platform

Kairui Song (1):
      mm, swap: avoid over reclaim of full clusters

Kan Liang (1):
      perf: Fix missing RCU reader protection in perf_event_clear_cpumask()

Keith Busch (3):
      nvme: enhance cns version checking
      nvme: module parameter to disable pi with offsets
      nvme: re-fix error-handling for io_uring nvme-passthrough

Kent Overstreet (5):
      bcachefs: Fix UAF in bch2_reconstruct_alloc()
      bcachefs: Fix unhandled transaction restart in fallocate
      bcachefs: Don't keep tons of cached pointers around
      bcachefs: Don't filter partial list buckets in open_buckets_to_text()
      bcachefs: Fix deadlock on -ENOSPC w.r.t. partial open buckets

Kevin Brodsky (1):
      arm64: signal: Improve POR_EL0 handling to avoid uaccess failures

Kirill A. Shutemov (1):
      mm: split critical region in remap_file_pages() and invoke LSMs in be=
tween

Leon Romanovsky (1):
      RDMA/cxgb4: Dump vendor specific QP details

Levi Zim (1):
      docs: networking: packet_mmap: replace dead links with archive.org li=
nks

Ley Foon Tan (1):
      net: stmmac: dwmac4: Fix high address display by updating
reg_space[] from register values

Li Zhijian (2):
      cxl/core: Return error when cxl_endpoint_gather_bandwidth()
handles a non-PCI device
      selftests/watchdog-test: Fix system accidentally reset after watchdog=
-test

Liam R. Howlett (1):
      mm/mmap: fix race in mmap_region() with ftruncate()

Liankun Yang (1):
      drm/mediatek: Fix get efuse issue for MT8188 DPTX

Linus Torvalds (2):
      x86/uaccess: Avoid barrier_nospec() in 64-bit copy_from_user()
      Linux 6.12-rc6

Liu Jing (1):
      selftests: netfilter: remove unused parameter

Lorenzo Stoakes (4):
      fork: do not invoke uffd on fork if error occurs
      fork: only invoke khugepaged, ksm hooks if no error
      mm/vma: add expand-only VMA merge mode and optimise do_brk_flags()
      tools: testing: add expand-only mode VMA test

Maarten Lankhorst (1):
      drm/xe: Remove runtime argument from display s/r functions

Macpaul Lin (1):
      dt-bindings: display: mediatek: dpi: correct power-domains property

Manikanta Pubbisetty (1):
      wifi: ath10k: Fix memory leak in management tx

Marc Zyngier (1):
      irqchip/gic-v4: Correctly deal with set_affinity on lazily-mapped VPE=
s

Marco Elver (2):
      kasan: Fix Software Tag-Based KASAN with GCC
      Revert "kasan: Disable Software Tag-Based KASAN with GCC"

Masahiro Yamada (6):
      kbuild: rpm-pkg: disable kernel-devel package when cross-compiling
      kbuild: deb-pkg: add pkg.linux-upstream.nokernelheaders build profile
      kbuild: deb-pkg: add pkg.linux-upstream.nokerneldbg build profile
      kconfig: show sub-menu entries even if the prompt is hidden
      modpost: fix acpi MODULE_DEVICE_TABLE built with mismatched endiannes=
s
      modpost: fix input MODULE_DEVICE_TABLE() built for 64-bit on 32-bit h=
ost

Mathias Nyman (1):
      usb: acpi: fix boot hang due to early incorrect 'tunneled' USB3
device links

Matt Fleming (1):
      mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserv=
es

Matt Johnston (1):
      mctp i2c: handle NULL header address

Matthew Brost (3):
      drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM
      drm/xe: Add mmio read before GGTT invalidate
      drm/xe: Don't short circuit TDR on jobs not started

Matthieu Baerts (NGI0) (2):
      mptcp: init: protect sched with rcu_read_lock
      selftests: mptcp: list sysctl data

Michal Swiatkowski (1):
      ice: block SF port creation in legacy mode

Miguel Ojeda (1):
      kbuild: rust: avoid errors with old `rustc`s without LLVM patch versi=
on

Mika Westerberg (1):
      thunderbolt: Fix KASAN reported stack out-of-bounds read in
tb_retimer_scan()

Miquel Sabat=C3=A9 Sol=C3=A0 (1):
      riscv: Prevent a bad reference count on CPU nodes

Miri Korenblit (1):
      wifi: iwlwifi: mvm: really send iwl_txpower_constraints_cmd

Moudy Ho (1):
      dt-bindings: display: mediatek: split: add subschema property constra=
ints

Naohiro Aota (1):
      btrfs: fix error propagation of split bios

Nobuhiro Iwamatsu (1):
      mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE check for node i=
d

Ojaswin Mujoo (1):
      xfs: Check for delayed allocations before setting extsize

Ovidiu Bunea (1):
      Revert "drm/amd/display: update DML2 policy
EnhancedPrefetchScheduleAccelerationFinal DCN35"

Pablo Neira Ayuso (2):
      gtp: allow -1 to be specified as file description from userspace
      netfilter: nft_payload: sanitize offset and length before
calling skb_checksum()

Patrisious Haddad (1):
      RDMA/mlx5: Round max_rd_atomic/max_dest_rd_atomic up instead of down

Pedro Tammela (1):
      net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Pei Xiao (1):
      slub/kunit: fix a WARNING due to unwrapped __kmalloc_cache_noprof

Peiyang Wang (1):
      net: hns3: default enable tx bounce buffer when smmu enabled

Peter Wang (1):
      scsi: ufs: core: Fix another deadlock during RTC update

Peter Zijlstra (2):
      sched: Fix pick_next_task_fair() vs try_to_wake_up() race
      sched/ext: Fix scx vs sched_delayed

Phillip Lougher (1):
      Squashfs: fix variable overflow in squashfs_readpage_block

Pierre Gondois (1):
      ACPI: CPPC: Make rmw_lock a raw_spin_lock

Ping-Ke Shih (2):
      wifi: rtw89: coex: add debug message of link counts on 2/5GHz
bands for wl_info v7
      wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI =
hosts

Piotr Zalewski (2):
      bcachefs: init freespace inited bits to 0 in bch2_fs_initialize
      bcachefs: Fix NULL ptr dereference in btree_node_iter_and_journal_pee=
k

Piyush Raj Chouhan (1):
      ALSA: hda/realtek: Add subwoofer quirk for Infinix ZERO BOOK 13

Qun-Wei Lin (1):
      mm: krealloc: Fix MTE false alarm in __do_krealloc

Remi Pommarel (3):
      wifi: cfg80211: Add wiphy_delayed_work_pending()
      wifi: mac80211: Convert color collision detection to wiphy work
      wifi: ath11k: Fix invalid ring usage in full monitor mode

Richard Zhu (1):
      phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check

Ryusuke Konishi (2):
      nilfs2: fix kernel bug due to missing clearing of checked flag
      nilfs2: fix potential deadlock with newly created symlinks

Sabyrzhan Tasbolatov (1):
      x86/traps: move kmsan check after instrumentation_begin

Sam Edwards (1):
      phy: usb: Fix missing elements in BCM4908 USB init array

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the usage of control path spin locks
      RDMA/bnxt_re: synchronize the qp-handle table array

Shawn Wang (1):
      sched/numa: Fix the potential null pointer dereference in task_numa_w=
ork()

Shiju Jose (1):
      cxl/events: Fix Trace DRAM Event Record

Siddharth Vadapalli (1):
      phy: ti: phy-j721e-wiz: fix usxgmii configuration

Stefan Wahren (1):
      Revert "usb: dwc2: Skip clock gating on Broadcom SoCs"

Sungwoo Kim (1):
      Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs

Suraj Sonawane (1):
      gpio: fix uninit-value in swnode_find_gpio

Tejun Heo (2):
      sched_ext: Make cast_mask() inline
      sched_ext: Fix enq_last_no_enq_fails selftest

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      bpf, test_run: Fix LIVE_FRAME frame update after a page has been recy=
cled

Tvrtko Ursulin (1):
      drm/amd/pm: Vangogh: Fix kernel memory out of bounds write

Veronika Molnarova (1):
      perf test: Handle perftool-testsuite_probe failure due to broken DWAR=
F

Ville Syrj=C3=A4l=C3=A4 (1):
      wifi: iwlegacy: Clear stale interrupts before resuming device

Vishal Chourasia (1):
      sched_ext: Fix function pointer type mismatches in BPF selftests

Vitaliy Shevtsov (1):
      nvmet-auth: assign dh_key to NULL after kfree_sensitive

Vladimir Oltean (1):
      net/sched: sch_api: fix xa_insert() error path in tcf_block_get_ext()

Vlastimil Babka (1):
      mm, mmap: limit THP alignment of anonymous mappings to PMD-aligned si=
zes

Wander Lairson Costa (1):
      igb: Disable threaded IRQ for igb_msix_other

Wang Liang (1):
      net: fix crash when config small gso_max_size/gso_ipv4_max_size

WangYuli (1):
      riscv: Use '%u' to format the output of 'cpu'

Wladislav Wiebe (1):
      tools/mm: -Werror fixes in page-types/slabinfo

Wolfram Sang (1):
      dmaengine: sh: rz-dmac: handle configs where one address is zero

Xiongfeng Wang (1):
      firmware: arm_sdei: Fix the input parameter of cpuhp_remove_state()

Xiu Jianfeng (1):
      cgroup: Fix potential overflow issue when checking max_depth

Yu Zhao (3):
      mm: allow set/clear page_type again
      mm: multi-gen LRU: remove MM_LEAF_OLD and MM_NONLEAF_TOTAL stats
      mm: multi-gen LRU: use {ptep,pmdp}_clear_young_notify()

Yunhui Cui (1):
      RISC-V: ACPI: fix early_ioremap to early_memremap

Zhihao Cheng (1):
      btrfs: fix use-after-free of block device file in
__btrfs_free_extra_devids()

Zi Yan (1):
      mm: avoid VM_BUG_ON when try to map an anon large folio to zero page.

Zichen Xie (1):
      netdevsim: Add trailing zero to terminate the string in
nsim_nexthop_bucket_activity_write()

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in
ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

Zijun Hu (1):
      usb: phy: Fix API devm_usb_put_phy() can not release the phy

Zongmin Zhou (1):
      usbip: tools: Fix detach_port() invalid port error path

zhouyuhang (1):
      selftests/mount_setattr: fix idmap_mount_tree_invalid failed to run

