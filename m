Return-Path: <linux-kernel+bounces-251956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB9930C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 01:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA401C20E06
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F213CFBC;
	Sun, 14 Jul 2024 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SvNWX19G"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4729474
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720999184; cv=none; b=h+D/ZZI9nv8vzIIdmYkoUWilyVP7ox3Lt0yBXf+DAjDjDuzb4YLmlWquaLqdRh9UjiBH4/krljOFHcRzGQIeOA+ZbBq/gUiqGotzPwRzOd3TjSC2tqBzrasWkE7Y9YZkGLf+sl5qQIk8zOWHFRrNHpOJSV3FCrpgfEP+AicHOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720999184; c=relaxed/simple;
	bh=QEelpeaZpwdMKBRJjLrf6cLNqy3EUtmsNDnFIUXsd3g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O6RndSoZbX84FoGc1Xu2pEt3QrDntFmmdtm/7650F9GAhaB1+4R+C4655T7Lg2P3OIpD1Hi63yHujqaQvhRwB/KRzg5NzTKSJjvg0zcF8FY+fnCiRj7oqwLZC/MivxRIspv5Md0eQZGJ1DB/qIAQWbwGW+YFIlZafjq2KXpH3Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SvNWX19G; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-59a47d5c22aso3217853a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720999179; x=1721603979; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4oW5ejWH0AIk6xBatkqwjbpyzssB55nlL3aF9xh2cF4=;
        b=SvNWX19Gm6wfobznUF2J5pmDIYUneenjf8c6/DR2ksWLRk+I7jU51yXqWc/xk0f7zz
         aMKhxe+8DL+dExScXtuGMEwSVHiRCGEXJL67yZB4oTrVgME7SxVUgu7kEs/u5SuuObRw
         g2Cvc6XOulelSmbUJnWyXftqcgSOBqYqQ4EWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720999179; x=1721603979;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oW5ejWH0AIk6xBatkqwjbpyzssB55nlL3aF9xh2cF4=;
        b=H7D3KeZnF/6RrMz6aWdDIAEPKTpvDPlrKc6pDumWTIndHNy2QHhvJ2lavwmt2z41ie
         /w1N7uwVLrw4xS1Hbvk9cWohRKSnsh//l2gqRSvmY45DhTUtuA1ZiPDe6q86iL4Q5jq9
         Z0oc78qi1pjKIL3ud5VaCj5nqZfOfzY961WmtD5KULf5Xqx+/Cs/3OWw+m0rw3cUy8UK
         6717v+IDlQaIm1mGiY34Koz1ti9K1IYqQ7AomiZg8507kKd9KjVUrL+NchYqEiLym1hy
         B5agX4Myiopa9YN4+l3WWWE37J/t+ykpZFlcdU/pG4kxF4AZ1H15G0FYrORgOX3fnkFZ
         6LwQ==
X-Gm-Message-State: AOJu0YyLucLK0fI59xlimL4YY5IIhLlyY+c2UcKt5TQIuomrAvRD+cha
	/IWiwpqlz3uR+PJL9/DpO4bPlp4Clxwpwy0hwP8PSS0ajVLee1MmZydcnif2iP9q9i6PRi1zU0P
	VHA5oaw==
X-Google-Smtp-Source: AGHT+IEUEfTJJG8pdri16XTCuKhNrXzlVhZSoPD496FwupiuadZFFaUeDTf7Hh7VIX3x/gNO4nILeA==
X-Received: by 2002:a17:906:c319:b0:a77:c5a5:f652 with SMTP id a640c23a62f3a-a780b6b308bmr1069026866b.26.1720999179131;
        Sun, 14 Jul 2024 16:19:39 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1bffsm165551866b.135.2024.07.14.16.19.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jul 2024 16:19:38 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so4535717a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:19:38 -0700 (PDT)
X-Received: by 2002:a05:6402:d0d:b0:57c:f091:f607 with SMTP id
 4fb4d7f45d1cf-594bc7c832cmr12553844a12.29.1720999177864; Sun, 14 Jul 2024
 16:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 14 Jul 2024 16:19:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjV_O2g_K19McjGKrxFxMFDqex+fyGcKc3uac1ft_O2gg@mail.gmail.com>
Message-ID: <CAHk-=wjV_O2g_K19McjGKrxFxMFDqex+fyGcKc3uac1ft_O2gg@mail.gmail.com>
Subject: Linux 6.10
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So the final week was perhaps not quote as quiet as the preceding
ones, which I don't love - but it also wasn't noisy enough to warrant
an extra rc. And much of the noise this last week was bcachefs again
(with netfs a close second), so it was all pretty compartmentalized.

In fact, about a third of the patch for the last week was
filesystem-related (there were also some btrfs latency fixes and other
noise), which is unusual, but none of it looks particularly scary.

Another third was drivers, and the rest is "random".

Anyway, this obviously means that the merge window for 6.11 opens up
tomorrow. Let's see how that goes, with much of Europe probably making
ready for summer vacation.

And the shortlog below is - as always - just the last week, not some
kind of "what happened this release".

               Linus

---

Abel Vesa (1):
      arm64: dts: qcom: x1e80100: Fix PCIe 6a reg offsets and add MHI

Adrian Hunter (1):
      mmc: sdhci: Fix max_seg_size for 64KiB PAGE_SIZE

Alan Stern (1):
      USB: core: Fix duplicate endpoint bug by clearing reserved bits
in the descriptor

Aleksander Jan Bajkowski (1):
      net: ethernet: lantiq_etop: fix double free in detach

Aleksandr Loktionov (1):
      i40e: fix: remove needless retries of NVM update

Aleksandr Mishin (1):
      octeontx2-af: Fix incorrect value output on error path in
rvu_check_rsrc_availability()

Alexandre Chartre (1):
      x86/bhi: Avoid warning in #DB handler due to BHI mitigation

Andre Przywara (1):
      arm64: dts: allwinner: Fix PMIC interrupt number

Armin Wolf (1):
      platform/x86: toshiba_acpi: Fix array out-of-bounds access

Audra Mitchell (1):
      Fix userfaultfd_api to return EINVAL as expected

Baokun Li (7):
      netfs, fscache: export fscache_put_volume() and add
fscache_try_get_volume()
      cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
      cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
      cachefiles: propagate errors from vfs_getxattr() to avoid infinite lo=
op
      cachefiles: stop sending new request when dropping object
      cachefiles: cancel all requests for the object that is being dropped
      cachefiles: cyclic allocation of msg_id to avoid reuse

Bard Liao (1):
      ASoC: rt711-sdw: add missing readable registers

Bastien Curutchet (2):
      spi: davinci: Unset POWERDOWN bit when releasing resources
      mmc: davinci_mmc: Prevent transmitted data size from exceeding
sgm's length

Bjorn Andersson (1):
      arm64: dts: qcom: sc8180x: Fix LLCC reg property again

Bj=C3=B8rn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Brian Foster (1):
      vfs: don't mod negative dentry count when on shrinker list

Bruce Johnston (1):
      dm vdo: replace max_discard_sectors with max_hw_discard_sectors

Caleb Connolly (1):
      arm64: dts: qcom: sm6115: add iommu for sdhc_1

Chen Ni (1):
      ARM: davinci: Convert comma to semicolon

Chengen Du (1):
      net/sched: Fix UAF when resolving a clash

Chris Packham (1):
      docs: networking: devlink: capitalise length value

Christian Eggers (1):
      dsa: lan9303: Fix mapping between DSA port number and PHY address

Christophe Leroy (1):
      MAINTAINERS: Update FREESCALE SOC DRIVERS and QUICC ENGINE LIBRARY

Chunyan Zhang (1):
      MAINTAINERS: Move myself from SPRD Maintainer to Reviewer

Cong Zhang (1):
      arm64: dts: qcom: sa8775p: Correct IRQ number of EL2 non-secure
physical timer

Damien Le Moal (1):
      scsi: sd: Do not repeat the starting disk message

Dan Carpenter (1):
      net: bcmasp: Fix error code in probe()

Daniel Borkmann (3):
      bpf: Fix too early release of tcx_entry
      selftests/bpf: Extend tcx tests to cover late tcx_entry release
      net, sunrpc: Remap EPERM in case of connection failure in
xs_tcp_setup_socket

Daniele Palmas (2):
      USB: serial: option: add Telit FN912 rmnet compositions
      USB: serial: option: add Telit generic core-dump composition

David Lechner (4):
      spi: axi-spi-engine: fix sleep calculation
      spi: don't unoptimize message in spi_async()
      spi: add defer_optimize_message controller flag
      spi: mux: set ctlr->bits_per_word_mask

Dmitry Antipov (1):
      ppp: reject claimed-as-LCP but actually malformed packets

Dmitry Savin (1):
      ALSA: hda: cs35l41: Fix swapped l/r audio channels for Lenovo
ThinBook 13x Gen4

Dmitry Smirnov (1):
      USB: serial: mos7840: fix crash on resume

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Limit mic boost on VAIO PRO PX

Edward Adam Davis (1):
      hfsplus: fix uninit-value in copy_name

Ekansh Gupta (6):
      misc: fastrpc: Fix DSP capabilities request
      misc: fastrpc: Copy the complete capability structure to user
      misc: fastrpc: Avoid updating PD type for capability request
      misc: fastrpc: Fix memory leak in audio daemon attach operation
      misc: fastrpc: Fix ownership reassignment of remote heap
      misc: fastrpc: Restrict untrusted app to attach to privileged PD

Eric Dumazet (1):
      tcp: avoid too many retransmit packets

Filipe Manana (3):
      btrfs: use delayed iput during extent map shrinking
      btrfs: stop extent map shrinker if reschedule is needed
      btrfs: avoid races when tracking progress for extent map shrinking

Florian Westphal (2):
      netfilter: nfnetlink_queue: drop bogus WARN_ON
      netfilter: nf_tables: prefer nft_chain_validate

Gavin Shan (4):
      mm/filemap: make MAX_PAGECACHE_ORDER acceptable to xarray
      mm/readahead: limit page cache size in page_cache_ra_order()
      mm/filemap: skip to create PMD-sized page cache if needed
      mm/shmem: disable PMD-sized page cache if needed

Geliang Tang (1):
      skmsg: Skip zero length skb in sk_msg_recvmsg

He Zhe (1):
      hpet: Support 32-bit userspace

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Panther Lake

Heiko Carstens (1):
      s390/mm: Add NULL pointer check to crst_table_free() base_crst_free()

Helge Deller (1):
      wireguard: allowedips: avoid unaligned 64-bit memory accesses

Hobin Woo (1):
      ksmbd: discard write access to the directory open

Hou Tao (1):
      cachefiles: wait for ondemand_object_worker to finish when dropping o=
bject

Hugh Dickins (2):
      mm: fix crashes from deferred split racing folio migration
      net: fix rc7's __skb_datagram_iter()

Ian Rogers (2):
      perf comm str: Avoid sort during insert
      perf dsos: When adding a dso into sorted dsos maintain the sort order

Ilya Dryomov (1):
      libceph: fix race between delayed_work() and ceph_monc_stop()

Jacky Huang (1):
      tty: serial: ma35d1: Add a NULL check for of_node

Jakub Kicinski (1):
      bnxt: fix crashes when reducing ring count with active RSS contexts

Jason A. Donenfeld (3):
      wireguard: selftests: use acpi=3Doff instead of -no-acpi for recent Q=
EMU
      wireguard: queueing: annotate intentional data race in cpu round robi=
n
      wireguard: send: annotate intentional data race in checking empty que=
ue

Javier Carrasco (1):
      usb: core: add missing of_node_put() in usb_of_has_devices_or_graph

Jeff Johnson (2):
      libceph: suppress crush_choose_indep() kernel-doc warnings
      libceph: fix crush_choose_firstn() kernel-doc warnings

Jeff Layton (1):
      filelock: fix potential use-after-free in posix_lock_inode

Jian Hui Lee (1):
      net: ethernet: mtk-star-emac: set mac_managed_pm when probing

Jingbo Xu (1):
      cachefiles: add missing lock protection when polling

Johan Hovold (7):
      arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on
      arm64: dts: qcom: sc8280xp-crd: use external pull up for touch reset
      arm64: defconfig: enable Elan i2c-hid driver
      soc: qcom: pmic_glink: disable UCSI on sc8280xp
      serial: qcom-geni: fix soft lockup on sw flow control and suspend
      serial: qcom-geni: fix hard lockup on buffer flush
      serial: qcom-geni: do not kill the machine on fifo underrun

John Hubbard (4):
      selftest/timerns: fix clang build failures for abs() calls
      selftests/vDSO: fix clang build errors and warnings
      selftests/vDSO: remove partially duplicated "all:" target in Makefile
      selftests/vDSO: remove duplicate compiler invocations from Makefile

John Stultz (1):
      sched: Move psi_account_irqtime() out of update_rq_clock_task() hotpa=
th

Jose Ignacio Tornos Martinez (1):
      kbuild: rpm-pkg: avoid the warnings with dtb's listed twice

Josh Don (1):
      Revert "sched/fair: Make sure to try to detach at least one movable t=
ask"

Joy Chakraborty (3):
      misc: microchip: pci1xxxx: Fix return value of nvmem callbacks
      nvmem: rmem: Fix return value of rmem_read()
      nvmem: meson-efuse: Fix return value of nvmem callbacks

Jo=C3=A3o Paulo Gon=C3=A7alves (1):
      iio: trigger: Fix condition for own trigger

Kai Vehmanen (1):
      ASoC: SOF: Intel: hda: fix null deref on system suspend entry

Kent Overstreet (27):
      bcachefs: Switch online_reserved shutdown assert to WARN()
      bcachefs: Delete old faulty bch2_trans_unlock() call
      bcachefs: Change bch2_fs_journal_stop() BUG_ON() to warning
      bcachefs: Fix shift greater than integer size
      bcachefs: Don't use the new_fs() bucket alloc path on an initialized =
fs
      bcachefs: Fix bch2_read_retry_nodecode()
      bcachefs: Fix loop restart in bch2_btree_transactions_read()
      bcachefs: Add missing printbuf_tabstops_reset() calls
      bcachefs: bch2_btree_write_buffer_maybe_flush()
      bcachefs: add check for missing fragmentation in check_alloc_to_lru_r=
ef()
      bcachefs: Repair fragmentation_lru in alloc_write_key()
      bcachefs: io clock: run timer fns under clock lock
      bcachefs: Fix journal getting stuck on a flush commit
      closures: fix closure_sync + closure debugging
      bcachefs: Fix bch2_inode_insert() race path for tmpfiles
      bcachefs: Fix undefined behaviour in eytzinger1_first()
      bcachefs: Log mount failure error code
      bcachefs: bch2_data_update_to_text()
      bcachefs: Warn on attempting a move with no replicas
      bcachefs: Fix missing error check in journal_entry_btree_keys_validat=
e()
      bcachefs: Add missing bch2_trans_begin()
      bcachefs: Fix RCU splat
      bcachefs: fix scheduling while atomic in break_cycle()
      Revert "bcachefs: Mark bch_inode_info as SLAB_ACCOUNT"
      bcachefs; Use trans_unlock_long() when waiting on allocator
      bcachefs: Set PF_MEMALLOC_NOFS when trans->locked
      bcachefs: bch2_gc_btree() should not use btree_root_lock

Kiran Kumar K (1):
      octeontx2-af: fix issue with IPv6 ext match for RSS

Komal Bajaj (2):
      arm64: dts: qcom: qdu1000: Fix LLCC reg property
      Revert "dt-bindings: cache: qcom,llcc: correct QDU1000 reg entries"

Konrad Dybcio (2):
      arm64: dts: qcom: x1e80100-*: Allocate some CMA buffers
      arm64: dts: qcom: sc8280xp: Set status =3D "reserved" on PSHOLD

Krzysztof Kozlowski (2):
      arm64: dts: qcom: x1e80100-crd: fix WCD audio codec TX port mapping
      arm64: dts: qcom: x1e80100-crd: fix DAI used for headset recording

Kuan-Wei Chiu (1):
      ACPI: processor_idle: Fix invalid comparison with insertion sort
for latency

Kumar Kartikeya Dwivedi (3):
      bpf: Fail bpf_timer_cancel when callback is being cancelled
      bpf: Defer work in bpf_timer_cancel_and_free
      selftests/bpf: Add timer lockup selftest

Kuniyuki Iwashima (1):
      udp: Set SOCK_RCU_FREE earlier in udp_lib_get_port().

Lee Jones (1):
      usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()

Linus Torvalds (1):
      Linux 6.10

Lorenzo Stoakes (1):
      MAINTAINERS: mailmap: update Lorenzo Stoakes's email address

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 series modules

Marc Zyngier (1):
      of/irq: Disable "interrupt-map" parsing for PASEMI Nemo

Mario Limonciello (2):
      cpufreq: Allow drivers to advertise boost enabled
      cpufreq: ACPI: Mark boost policy as enabled when setting boost

Mark Brown (1):
      spi: omap2-mcspi: Revert multi mode support

Masahiro Yamada (1):
      fortify: fix warnings in fortify tests with KASAN

Mathias Nyman (1):
      xhci: always resume roothubs if xHC was reset during resume

Matthew Wilcox (Oracle) (1):
      minixfs: Fix minixfs_rename with HIGHMEM

Miaohe Lin (2):
      mm/hugetlb: fix potential race in __update_and_free_hugetlb_folio()
      mm/hugetlb: fix kernel NULL pointer dereference when migrating
hugetlb folio

Michael Chan (1):
      bnxt_en: Fix crash in bnxt_get_max_rss_ctx_ring()

Michal Kubiak (1):
      i40e: Fix XDP program unloading while removing the driver

Michal Mazur (1):
      octeontx2-af: fix detection of IP layer

Micha=C5=82 Kope=C4=87 (1):
      ALSA: hda/realtek: add quirk for Clevo V5[46]0TU

Mohammad Shehar Yaar Tausif (1):
      bpf: fix order of args in call to bpf_map_kvcalloc

Mudit Sharma (1):
      iio: light: apds9306: Fix error handing

Namjae Jeon (1):
      ksmbd: return FILE_DEVICE_DISK instead of super magic

Nathan Chancellor (1):
      kbuild: Make ld-version.sh more robust against version string changes

Nazar Bilinskyi (1):
      ALSA: hda/realtek: Enable Mute LED on HP 250 G7

Neal Cardwell (1):
      tcp: fix incorrect undo caused by DSACK of TLP retransmit

Nhat Pham (1):
      cachestat: do not flush stats in recency check

Nithin Dabilpuram (1):
      octeontx2-af: replace cpt slot with lf id on reg write

N=C3=ADcolas F. R. A. Prado (1):
      thermal: gov_power_allocator: Return early in manage if trip_max is N=
ULL

Oleksij Rempel (2):
      net: phy: microchip: lan87xx: reinit PHY after cable test
      ethtool: netlink: do not return SQI value if link is down

Paul Menzel (1):
      lib/build_OID_registry: avoid non-destructive substitution for
Perl < 5.13.2 compat

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-pcm: Limit the maximum number of periods
by MAX_BDL_ENTRIES

Peter Wang (2):
      scsi: ufs: core: Fix ufshcd_clear_cmd racing issue
      scsi: ufs: core: Fix ufshcd_abort_one racing issue

Rafael J. Wysocki (2):
      thermal: core: Call monitor_thermal_zone() if zone temperature is inv=
alid
      thermal: core: Fix list sorting in __thermal_zone_device_update()

Rasmus Villemoes (1):
      serial: imx: ensure RTS signal is not left active after shutdown

Richard Fitzgerald (5):
      firmware: cs_dsp: Fix overflow checking of wmfw header
      firmware: cs_dsp: Return error if block header overflows file
      firmware: cs_dsp: Validate payload length before processing block
      firmware: cs_dsp: Prevent buffer overrun when processing V2 alg heade=
rs
      firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw files

Ronald Wahl (2):
      net: ks8851: Fix deadlock with the SPI chip variant
      net: ks8851: Fix potential TX stall after interface reopen

Ryusuke Konishi (1):
      nilfs2: fix kernel bug on rename operation of broken directory

Saeed Mahameed (1):
      net: ethtool: Fix RSS setting

Satheesh Paul (1):
      octeontx2-af: fix issue with IPv4 match for RSS

SeongJae Park (1):
      mm/damon/core: merge regions aggressively when max_nr_regions is unme=
t

Slark Xiao (1):
      USB: serial: option: add support for Foxconn T99W651

Srujana Challa (1):
      octeontx2-af: fix a issue with cpt_lf_alloc mailbox

Stefan Eichenberger (1):
      serial: imx: only set receiver level if it is zero

Steve French (1):
      cifs: fix setting SecurityFlags to true

Suren Baghdasaryan (2):
      sched.h: always_inline alloc_tag_{save|restore} to fix modpost warnin=
gs
      arch/xtensa: always_inline get_current() and current_thread_info()

Taniya Das (1):
      pmdomain: qcom: rpmhpd: Skip retention level for Power Domains

Thomas Wei=C3=9Fschuh (2):
      nvmem: core: only change name to fram for current attribute
      nvmem: core: limit cell sysfs permissions to main attribute ones

Tony Lindgren (1):
      MAINTAINERS: Add more maintainers for omaps

Udit Kumar (1):
      serial: 8250_omap: Fix Errata i2310 with RX FIFO level check

Uladzislau Rezki (Sony) (1):
      mm: vmalloc: check if a hash-index is in cpu_possible_mask

Uwe Kleine-K=C3=B6nig (2):
      netfs: Switch debug logging to pr_debug()
      spi: imx: Don't expect DMA for i.MX{25,35,50,51,53} cspi devices

Vanillan Wang (1):
      USB: serial: option: add Rolling RW350-GL variants

Vitaly Lifshits (1):
      e1000e: fix force smbus during suspend flow

Waiman Long (1):
      mm: prevent derefencing NULL ptr in pfn_section_valid()

Wander Lairson Costa (1):
      sched/deadline: Fix task_struct reference leak

WangYuli (1):
      USB: Add USB_QUIRK_NO_SET_INTF quirk for START BP-850k

Wentong Wu (5):
      mei: vsc: Enhance IVSC chipset stability during warm reboot
      mei: vsc: Prevent timeout error with added delay post-firmware downlo=
ad
      mei: vsc: Utilize the appropriate byte order swap function
      mei: vsc: Enhance SPI transfer of IVSC ROM
      mei: vsc: Fix spelling error

Wolfram Sang (8):
      i2c: rcar: bring hardware to known state when probing
      i2c: rcar: clear NO_RXDMA flag after resetting
      MAINTAINERS: delete entries for Thor Thayer
      MAINTAINERS: VIRTIO I2C loses a maintainer, gains a reviewer
      i2c: testunit: correct Kconfig description
      i2c: mark HostNotify target address as used
      i2c: rcar: ensure Gen3+ reset does not disturb local targets
      i2c: testunit: avoid re-issued work after read message

Yang Shi (2):
      mm: page_ref: remove folio_try_get_rcu()
      mm: gup: stop abusing try_grab_folio

Yi Liu (1):
      vfio/pci: Init the count variable in collecting hot-reset devices

Youling Tang (1):
      bcachefs: Mark bch_inode_info as SLAB_ACCOUNT

Yu Zhao (1):
      mm/hugetlb_vmemmap: fix race with speculative PFN walkers

ZhangPeng (1):
      filemap: replace pte_offset_map() with pte_offset_map_nolock()

