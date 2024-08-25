Return-Path: <linux-kernel+bounces-300307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C2B95E22A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6353BB21523
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEDD39FFE;
	Sun, 25 Aug 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLDKqGik"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3644A2C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724565352; cv=none; b=UBwTPtJyANzh9MQcj7DoCh10aqVo4xSIcXaaVkG13HQRZv5KRQXbyElfz2iUrTBxCqmAawV41scCBHhLNwhuiS0lTUY5GyzEEsgj4YKlUEUaB/9L96eibVwNpSjYSCWAfifk8YOjkJhpykMKnxH+srjCghnNRSFovqJQHnORPr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724565352; c=relaxed/simple;
	bh=PzrvJYhW3UZqIsjsCUJa7OSCi0IB5v6uZ3dn7KJlE2w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qWAC30lx85+5pbKRIjuj2AdZhQgwiUeY9mI6hQNPb+crd5MvV+vb6f4VdcjVcmJBSbPAaHV1h2uIknSCBXKA4DEk2xvGuk/W0u9lmoCwc42JURVI4WAPqQBFVYg9ilz2zMZpTKar1/hEuuXN9zEPlZAoJ09FMe7qk2yQ269KEh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLDKqGik; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-533496017f8so4426925e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 22:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724565349; x=1725170149; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy/nw7t/EPWpHj/2tJHG8EOAT1AZQ6495BZsJFdNb5g=;
        b=PLDKqGikbe8oc1XoLZOmyFUmR6SwXZd02jwBfbofmJqmvEsXfNKCr1w6I3JQVK3MSQ
         GIZj45painvO2regFhpt6W7F9DwLGgWtL3fpzGAPgTdJ6AiA3wVAJmGibMwU6XDS4R6A
         eCB6akyp5NLo/rCkRRHVOdBk+GmxNhR25CQL8nYnWgpGr78FcTMUZnNnqjNchhUvZIYu
         nBE7oAOq5u6iqn7ltq3Ntvy9v3fN3muyhh2kJrpYwZwXb+XkUW/CG/NVts92eufZqpdd
         +yaUm/AjK1FXt3XhWjxETrjbilKtdq5eqiE/0RZq1kr4jrJC6me3eB+Y9ToZFrnxngCq
         QDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724565349; x=1725170149;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy/nw7t/EPWpHj/2tJHG8EOAT1AZQ6495BZsJFdNb5g=;
        b=Ml0qZJnf8Jf2CPKUqCrdIlo5Xd6qQTxIXPVitbY4DiDBoZ34RU675ANb9VjmTjaAmv
         fyLoTuOtsxt9QHyDOk7+p6PWbJ0RLAHBhE2SpgEZ/j7Jk3FBalGX3RHS65gXQYvHKh1V
         1Vb+CyyncmHwwv3ajc4Qx98TKNwvCmIvTbT25frJQrCJ9ddllmPs7kEg1w9LjYzfZkKu
         oBUMt4qZX+/yUbU+SCcpUc3VFcjj9w1hvlWlMn+FYwqFTs1Tqr9Ftvi8J4imMTpdLby3
         J3B1xofunxgay8MMjlnK/Pqo0kRL0dhWJK3Sbb3kuPhXxFVjcUFkGZ5FcqJXR9ysDanQ
         laKg==
X-Forwarded-Encrypted: i=1; AJvYcCUH43oDWJ6chGHAC7CtE0SfH+htngkp2Zg34hgCpVjvJMsW4KM3cDoQFM1V1RJ9Ur2zZbsX6whGVC0hksU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ9decgnrF9b2YjDCpuIjqhrnW52pjmLbxPtjOl/WGqf8u80s0
	iuE3FYmzqtWIb4q8+4EfCDJNEwX6hc3Cg1d3eeKOf9XfGM7FHSay
X-Google-Smtp-Source: AGHT+IF4K11lXxKlwj5zz7LjRKgtj7NCNB9m/f81pIOXIzC35tcs7XMyBsTm4daNe0//T/AYk3FGjQ==
X-Received: by 2002:a05:6512:3c81:b0:52c:9468:c991 with SMTP id 2adb3069b0e04-53438831bb7mr4771099e87.14.1724565348165;
        Sat, 24 Aug 2024 22:55:48 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea5d6e4sm1047447e87.225.2024.08.24.22.55.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Aug 2024 22:55:47 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
Date: Sun, 25 Aug 2024 07:55:36 +0200
Cc: Matthew Wilcox <willy@infradead.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Nhat Pham <nphamcs@gmail.com> w =
dniu 23.08.2024, o godz. 18:16:
>=20
>=20
> Have you tried with 6.9 yet? IIRC, there are two major changes to
> zswap architecture in recent versions.
>=20
> 1. In 6.9, we range-partition zswap's rbtrees to reduce lock =
contention.
>=20

Ok - after 32h of continuous compilation also on 6.9.12 I got series of =
oops (see below).

[68616.350398] watchdog: BUG: soft lockup - CPU#4 stuck for 596s! =
[kcompactd0:176]
[68616.350401] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common edac_mce_amd kvm_amd cfg80211 =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic =
gf128mul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 r8169 =
aesni_intel crypto_simd cryptd realtek mdio_devres sp5100_tco wmi_bmof =
k10temp libphy ccp pcspkr rapl i2c_piix4 acpi_cpufreq zenpower ryzen_smu =
gpio_amdpt gpio_generic mac_hid nfsd auth_rpcgss nfs_acl lockd grace =
nct6775 nct6775_core hwmon_vid sunrpc sg crypto_user fuse dm_mod loop =
nfnetlink bpf_preload ip_tables x_tables xfs libcrc32c crc32c_generic =
drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm drm_exec =
mxm_wmi nvme drm_display_helper crc32c_intel xhci_pci nvme_core cec =
xhci_pci_renesas wmi virtio_net net_failover failover virtio_blk =
virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev
[68616.350434]  [last unloaded: nouveau]
[68616.350448] CPU: 4 PID: 176 Comm: kcompactd0 Tainted: G      D W    L =
    6.9.12-12 #1 e59bce453550af16b12fd25785f4d449e921764e
[68616.350451] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[68616.350454] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2e0
[68616.350457] Code: 77 7f f0 0f ba 2b 08 0f 92 c2 8b 03 0f b6 d2 c1 e2 =
08 30 e4 09 d0 3d ff 00 00 00 77 5b 85 c0 74 10 0f b6 03 84 c0 74 09 f3 =
90 <0f> b6 03 84 c0 75 f7 b8 01 00 00 00 66 89 03 65 48 ff 05 f3 66 02
[68616.350461] RSP: 0018:ffffb268806db858 EFLAGS: 00000202
[68616.350463] RAX: 0000000000000001 RBX: fffffbc30722d4e8 RCX: =
0000000000000867
[68616.350465] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
fffffbc30722d4e8
[68616.350467] RBP: 00007f6af88b3000 R08: 0000008000000000 R09: =
0200000000000080
[68616.350469] R10: 0000000000000000 R11: ffffb268806db9e0 R12: =
ffff9388c7f63700
[68616.350471] R13: ffff938815651b00 R14: 0000000000000001 R15: =
ffffff8000000000
[68616.350473] FS:  0000000000000000(0000) GS:ffff938b2e800000(0000) =
knlGS:0000000000000000
[68616.350475] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[68616.350477] CR2: 000055c339a59150 CR3: 00000002c2c20000 CR4: =
0000000000350ef0
[68616.350479] Call Trace:
[68616.350480]  <IRQ>
[68616.350481]  ? watchdog_timer_fn+0x1dd/0x260
[68616.350484]  ? __pfx_watchdog_timer_fn+0x10/0x10
[68616.350487]  ? __hrtimer_run_queues+0x10f/0x2a0
[68616.350490]  ? hrtimer_interrupt+0xfa/0x230
[68616.350492]  ? __sysvec_apic_timer_interrupt+0x55/0x150
[68616.350494]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[68616.350497]  </IRQ>
[68616.350498]  <TASK>
[68616.350500]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[68616.350503]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
[68616.350506]  _raw_spin_lock+0x29/0x30
[68616.350509]  page_vma_mapped_walk+0x6a2/0x950
[68616.350511]  try_to_migrate_one+0x174/0xbf0
[68616.350515]  rmap_walk_anon+0xb6/0x190
[68616.350518]  try_to_migrate+0xf9/0x110
[68616.350520]  ? __pfx_try_to_migrate_one+0x10/0x10
[68616.350523]  ? __pfx_folio_not_mapped+0x10/0x10
[68616.350526]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
[68616.350528]  ? __pfx_invalid_migration_vma+0x10/0x10
[68616.350531]  migrate_pages_batch+0x545/0xb80
[68616.350534]  ? __pfx_compaction_free+0x10/0x10
[68616.350536]  ? __pfx_compaction_alloc+0x10/0x10
[68616.350540]  ? __pfx_remove_migration_pte+0x10/0x10
[68616.350542]  migrate_pages+0xada/0xd90
[68616.350545]  ? __pfx_compaction_alloc+0x10/0x10
[68616.350548]  ? __pfx_compaction_free+0x10/0x10
[68616.350551]  ? folio_add_lru+0x5f/0xb0
[68616.350553]  compact_zone+0x9e8/0x10c0
[68616.350556]  ? sched_clock_cpu+0xf/0x190
[68616.350559]  ? raw_spin_rq_lock_nested+0x1c/0x80
[68616.350561]  ? psi_group_change+0x213/0x3c0
[68616.350564]  compact_node+0xb7/0x130
[68616.350568]  kcompactd+0x355/0x430
[68616.350571]  ? __pfx_autoremove_wake_function+0x10/0x10
[68616.350573]  ? __pfx_kcompactd+0x10/0x10
[68616.350576]  kthread+0xcf/0x100
[68616.350578]  ? __pfx_kthread+0x10/0x10
[68616.350580]  ret_from_fork+0x31/0x50
[68616.350583]  ? __pfx_kthread+0x10/0x10
[68616.350585]  ret_from_fork_asm+0x1a/0x30
[68616.350588]  </TASK>
[68620.214362] watchdog: BUG: soft lockup - CPU#0 stuck for 663s! =
[cc1plus:2979523]
[68620.214367] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common edac_mce_amd kvm_amd cfg80211 =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic =
gf128mul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 r8169 =
aesni_intel crypto_simd cryptd realtek mdio_devres sp5100_tco wmi_bmof =
k10temp libphy ccp pcspkr rapl i2c_piix4 acpi_cpufreq zenpower ryzen_smu =
gpio_amdpt gpio_generic mac_hid nfsd auth_rpcgss nfs_acl lockd grace =
nct6775 nct6775_core hwmon_vid sunrpc sg crypto_user fuse dm_mod loop =
nfnetlink bpf_preload ip_tables x_tables xfs libcrc32c crc32c_generic =
drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm drm_exec =
mxm_wmi nvme drm_display_helper crc32c_intel xhci_pci nvme_core cec =
xhci_pci_renesas wmi virtio_net net_failover failover virtio_blk =
virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev
[68620.214402]  [last unloaded: nouveau]
[68620.214416] CPU: 0 PID: 2979523 Comm: cc1plus Tainted: G      D W    =
L     6.9.12-12 #1 e59bce453550af16b12fd25785f4d449e921764e
[68620.214420] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[68620.214422] RIP: 0010:native_queued_spin_lock_slowpath+0x21f/0x2e0
[68620.214426] Code: c5 01 41 c1 e4 10 41 c1 e5 12 45 09 ec 44 89 e0 c1 =
e8 10 66 87 43 02 89 c2 c1 e2 10 81 fa ff ff 00 00 77 5e 31 d2 eb 02 f3 =
90 <8b> 03 66 85 c0 75 f7 44 39 e0 0f 84 8e 00 00 00 c6 03 01 48 85 d2
[68620.214430] RSP: 0000:ffffb2688397fbe0 EFLAGS: 00000202
[68620.214432] RAX: 00000000000c0101 RBX: ffff9388140cf738 RCX: =
0000000000000008
[68620.214434] RDX: 0000000000000000 RSI: 0000000000000101 RDI: =
ffff9388140cf738
[68620.214436] RBP: ffff938b2e6373c0 R08: ffff938b2e6310c0 R09: =
000000000000000a
[68620.214438] R10: 0000000000000000 R11: 0000000000000000 R12: =
0000000000040000
[68620.214440] R13: 0000000000040000 R14: ffff9388140cf738 R15: =
ffff9388140cf730
[68620.214442] FS:  00007fc78bf83f00(0000) GS:ffff938b2e600000(0000) =
knlGS:0000000000000000
[68620.214445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[68620.214447] CR2: 00007fc75b53f264 CR3: 00000001797f4000 CR4: =
0000000000350ef0
[68620.214449] Call Trace:
[68620.214450]  <IRQ>
[68620.214451]  ? watchdog_timer_fn+0x1dd/0x260
[68620.214454]  ? __pfx_watchdog_timer_fn+0x10/0x10
[68620.214457]  ? __hrtimer_run_queues+0x10f/0x2a0
[68620.214460]  ? hrtimer_interrupt+0xfa/0x230
[68620.214462]  ? __sysvec_apic_timer_interrupt+0x55/0x150
[68620.214465]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[68620.214468]  </IRQ>
[68620.214469]  <TASK>
[68620.214470]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[68620.214474]  ? native_queued_spin_lock_slowpath+0x21f/0x2e0
[68620.214477]  _raw_spin_lock+0x29/0x30
[68620.214479]  zswap_load+0x6a/0x160
[68620.214482]  swap_read_folio+0x64/0x450
[68620.214484]  swapin_readahead+0x1ea/0x4e0
[68620.214487]  do_swap_page+0x403/0xd20
[68620.214490]  ? shmem_file_write_iter+0x5e/0x90
[68620.214492]  ? __pte_offset_map+0x1b/0x180
[68620.214494]  __handle_mm_fault+0x868/0xdd0
[68620.214498]  handle_mm_fault+0x18d/0x320
[68620.214500]  do_user_addr_fault+0x175/0x6b0
[68620.214503]  exc_page_fault+0x7e/0x180
[68620.214505]  asm_exc_page_fault+0x26/0x30
[68620.214508] RIP: 0033:0x330a353
[68620.214512] Code: e2 03 48 01 d0 48 8b 00 48 89 45 e8 48 83 7d e8 00 =
0f 84 11 01 00 00 48 83 7d e8 ff 75 08 8b 45 fc 89 45 f8 eb 42 48 8b 45 =
e8 <8b> 40 0c 39 45 84 75 36 48 8b 45 e8 8b 40 08 48 8b 55 88 39 d0 75
[68620.214515] RSP: 002b:00007ffc42ae0390 EFLAGS: 00010217
[68620.214517] RAX: 00007fc75b53f258 RBX: 00000000000003e9 RCX: =
00000000f9107c14
[68620.214519] RDX: 000000000003e0a0 RSI: 00007ffc42ae04f1 RDI: =
0000000027ef6180
[68620.214521] RBP: 00007ffc42ae0410 R08: 0000000000000000 R09: =
0000000000000000
[68620.214523] R10: 00007fc78c106ac0 R11: 00007fc78c1073c0 R12: =
0000000000000000
[68620.214525] R13: 00007ffc42ae1030 R14: 00007fc78c66f000 R15: =
0000000003df8e50
[68620.214528]  </TASK>
[68632.363664] watchdog: BUG: soft lockup - CPU#8 stuck for 648s! =
[cc1plus:2982130]
[68632.363668] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter =
iptable_filter xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 =
amd_atl intel_rapl_msr intel_rapl_common edac_mce_amd kvm_amd cfg80211 =
rfkill kvm crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic =
gf128mul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 r8169 =
aesni_intel crypto_simd cryptd realtek mdio_devres sp5100_tco wmi_bmof =
k10temp libphy ccp pcspkr rapl i2c_piix4 acpi_cpufreq zenpower ryzen_smu =
gpio_amdpt gpio_generic mac_hid nfsd auth_rpcgss nfs_acl lockd grace =
nct6775 nct6775_core hwmon_vid sunrpc sg crypto_user fuse dm_mod loop =
nfnetlink bpf_preload ip_tables x_tables xfs libcrc32c crc32c_generic =
drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_gpuvm drm_exec =
mxm_wmi nvme drm_display_helper crc32c_intel xhci_pci nvme_core cec =
xhci_pci_renesas wmi virtio_net net_failover failover virtio_blk =
virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev
[68632.363704]  [last unloaded: nouveau]
[68632.363719] CPU: 8 PID: 2982130 Comm: cc1plus Tainted: G      D W    =
L     6.9.12-12 #1 e59bce453550af16b12fd25785f4d449e921764e
[68632.363722] Hardware name: To Be Filled By O.E.M. B450M Pro4-F =
R2.0/B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
[68632.363724] RIP: 0010:native_queued_spin_lock_slowpath+0x2a1/0x2e0
[68632.363728] Code: c1 ea 12 83 e0 03 83 ea 01 48 c1 e0 05 48 63 d2 48 =
05 c0 73 03 00 48 03 04 d5 40 32 91 aa 48 89 28 8b 45 08 85 c0 75 09 f3 =
90 <8b> 45 08 85 c0 74 f7 48 8b 55 00 48 85 d2 0f 84 6a ff ff ff 0f 0d
[68632.363732] RSP: 0000:ffffb26885e1f450 EFLAGS: 00000246
[68632.363734] RAX: 0000000000000000 RBX: ffff9388140cf738 RCX: =
fffffbc30f2ad340
[68632.363736] RDX: 0000000000000014 RSI: 0000000000540101 RDI: =
ffff9388140cf738
[68632.363738] RBP: ffff938b2ea373c0 R08: ffff93876cc2aaa0 R09: =
0008c8130ae03aa0
[68632.363740] R10: 020f0008c8130ae0 R11: 0000000000501000 R12: =
0000000000240000
[68632.363741] R13: 0000000000240000 R14: 03ffffffffffffff R15: =
00000000000005fa
[68632.363743] FS:  00007fd929957f00(0000) GS:ffff938b2ea00000(0000) =
knlGS:0000000000000000
[68632.363746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[68632.363748] CR2: 00007fd923600000 CR3: 0000000162ba8000 CR4: =
0000000000350ef0
[68632.363750] Call Trace:
[68632.363751]  <IRQ>
[68632.363752]  ? watchdog_timer_fn+0x1dd/0x260
[68632.363755]  ? __pfx_watchdog_timer_fn+0x10/0x10
[68632.363758]  ? __hrtimer_run_queues+0x10f/0x2a0
[68632.363761]  ? hrtimer_interrupt+0xfa/0x230
[68632.363763]  ? __sysvec_apic_timer_interrupt+0x55/0x150
[68632.363766]  ? sysvec_apic_timer_interrupt+0x6c/0x90
[68632.363769]  </IRQ>
[68632.363770]  <TASK>
[68632.363771]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
[68632.363775]  ? native_queued_spin_lock_slowpath+0x2a1/0x2e0
[68632.363778]  _raw_spin_lock+0x29/0x30
[68632.363781]  zswap_store+0x623/0xc70
[68632.363783]  swap_writepage+0x33/0xe0
[68632.363786]  pageout+0xc9/0x250
[68632.363790]  shrink_folio_list+0x5e4/0xca0
[68632.363793]  ? vm_mmap_pgoff+0xec/0x1a0
[68632.363796]  ? do_syscall_64+0x82/0x170
[68632.363799]  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
[68632.363803]  evict_folios+0x27a/0x660
[68632.363807]  try_to_shrink_lruvec+0x1a7/0x280
[68632.363810]  shrink_one+0x10a/0x1f0
[68632.363812]  shrink_node+0xab9/0xc00
[68632.363815]  ? zone_reclaimable_pages+0x15c/0x190
[68632.363818]  do_try_to_free_pages+0xca/0x5d0
[68632.363822]  try_to_free_pages+0xdd/0x210
[68632.363825]  __alloc_pages_slowpath.constprop.0+0x316/0xd60
[68632.363828]  ? mmap_region+0x4fc/0x9c0
[68632.363831]  __alloc_pages+0x32d/0x360
[68632.363834]  alloc_pages_mpol+0xd9/0x1e0
[68632.363836]  ? __lruvec_stat_mod_folio+0x81/0xa0
[68632.363839]  mm_get_huge_zero_page+0x74/0x100
[68632.363841]  do_huge_pmd_anonymous_page+0x37f/0x6e0
[68632.363844]  ? syscall_exit_to_user_mode+0x72/0x200
[68632.363846]  __handle_mm_fault+0xb5f/0xdd0
[68632.363850]  handle_mm_fault+0x18d/0x320
[68632.363852]  do_user_addr_fault+0x175/0x6b0
[68632.363855]  exc_page_fault+0x7e/0x180
[68632.363857]  asm_exc_page_fault+0x26/0x30
[68632.363860] RIP: 0033:0xf19e9f
[68632.363864] Code: 08 5d c3 55 48 89 e5 48 89 7d f8 89 75 f4 89 55 f0 =
89 4d ec 8b 45 f4 25 ff ff ff 7f 89 c2 48 8b 45 f8 89 d1 81 e1 ff ff ff =
7f <8b> 10 81 e2 00 00 00 80 09 ca 89 10 8b 45 ec 83 e0 01 48 8b 55 f8
[68632.363868] RSP: 002b:00007ffc3532adf0 EFLAGS: 00010202
[68632.363870] RAX: 00007fd923600000 RBX: ffffffffffffffff RCX: =
0000000000000004
[68632.363872] RDX: 0000000000000004 RSI: 0000000000000004 RDI: =
00007fd923600000
[68632.363874] RBP: 00007ffc3532adf0 R08: 0000000000000040 R09: =
0000000000000060
[68632.363875] R10: 00000000365e5970 R11: 0000000000000000 R12: =
00007ffc3532c240
[68632.363877] R13: 00007ffc3532d690 R14: 00007fd92a043000 R15: =
0000000003df8e50
[68632.363880]  </TASK>=

