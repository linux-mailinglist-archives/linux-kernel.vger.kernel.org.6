Return-Path: <linux-kernel+bounces-300472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7639095E40D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E48B281ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384CA15667D;
	Sun, 25 Aug 2024 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsiXIPZo"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871F3C24
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724598335; cv=none; b=dC05Qsjln3u7MtobA8WBro5SIVJXoSloeRHFVPWZJpboz3WgZ1MgrolBAlXsnBEMQvdVBh5M+5qvviYJb2z9/psme0VSRzC5PA9UmZ0tS19wnW3UNCphAmmIm6sMZzYRQ8yF4K5W1OpMSBfA27pgANUxdKMgQ1GkPcU4Ks7Lngk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724598335; c=relaxed/simple;
	bh=x9XZj+2QVK7S6rGnJgroP7f+2A3bAx40/TzKDdroHW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrVaktgKAxbQIJ2aYxAouIvoZelitkURqqL+3a10Z6xeXeCUNM63lbWiFkIGFG/S1o+zhaD6bGeVGnMShb4fcTG0OC+uDbtP6EKUfuxu4VfPbkRBri6qH9heYRSKq/iIR5Vq9Jm0CSDX/+X/gNK6hI/MBzfFBAE+n/XuhPDYou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsiXIPZo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3718c176ed7so1938537f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 08:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724598332; x=1725203132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rRwQw9C33FiIRakw6tM5T98dS41FiRx5uyWXQePoqU0=;
        b=IsiXIPZoiCTUY716dyNnKpdQ2h8siqQG9wBTnCmuzDkL4K0fvU24YL6sL5OR6LXXvN
         k6z0iqJICwnXxWjYKuzmAYwSOfNZpJ9oz/PH9OxEu9sI5+uheBnOeHPPMwDzU7HjHWMH
         zDDvlovLoGtV8xEpjcBGI4nODLEFBF99RRtywopEwYsW/NPRxx63XW7LFSVdtq1YOWuL
         B8hzzMWxwW9TIXWq1PUHQSOUQDa++jNZNeUOpxlCQiFRr3EIj8OgaBRHk626YYit0OU1
         kaplgaCbCO1p3Sj8xd6wpGugMnZcQo27op26qF4fBCnEy6bKCkirHwtAJREVhdWh5ji6
         vY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724598332; x=1725203132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rRwQw9C33FiIRakw6tM5T98dS41FiRx5uyWXQePoqU0=;
        b=M0BjBZToHa2K2tMvt2p/UPTZDqqn4ssAF1PpAWGuwFcdb3qzB0rEVhk9eLZBAuB3LM
         hyGlAb+0WyBv8YtzHHQGGi3NfbiXrUinTVT1sfdeweeJCHD1XTBG3r6Ep2APHIHj13w6
         /M9u3CamRWbx/Ti8EJakXmy2EyjxtV6jO1cXG9cVxzz8z/hiswx9bYQJ7f0BxvMoGKl0
         XVBW0ysGaYzpleliRwRXRo9x9vZJAcc8cQT5GS1vQsNFDi+G0JfE7eNb7eIhUpdavhzg
         D6h9LbIA/qLvaI57gzPIgzM3QdRrNj0eUW0WpjyYlQn2D70SAQ4d2nuHgxs3ZywTGLx+
         Htsw==
X-Forwarded-Encrypted: i=1; AJvYcCUFf/FHUmO/VRF+IdQUpPYSbutgtKUQ6rks7H8oSBAeSCatDthblwhhsANnN3zc1kZGGmTA0jIdPtI3FUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Lhi7vfcLIo8CwpPV5Jo6Jyy9eNvpRDZLyFHljfEF2XpTpkOi
	CI0fMDe2Akr80MhQtEKg8igljkz+RnluCnlTu6Jy1+GctFSQfgub
X-Google-Smtp-Source: AGHT+IFZ2c3B6yNqs8uu6qTU8c+yCN+Sz4X6w3hW32d7eEOgQcIPU9gC5rxJ2k8lhsdYysFqLGdNbQ==
X-Received: by 2002:adf:f151:0:b0:371:7cd1:86ec with SMTP id ffacd0b85a97d-373118587f9mr4711405f8f.21.1724598330951;
        Sun, 25 Aug 2024 08:05:30 -0700 (PDT)
Received: from PC-PEDRO-ARCH ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ab87f26c0sm158478755e9.1.2024.08.25.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 08:05:30 -0700 (PDT)
Date: Sun, 25 Aug 2024 16:05:28 +0100
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
Message-ID: <oophwj3aj2fnfi57ebzjuc536iltilmcpoucyms6nfk2alwvtr@pdj4cn4rvpdn>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
 <CAKEwX=N-10A=C_Cp_m8yxfeTigvmZp1v7TrphcrHuRkHJ8837g@mail.gmail.com>
 <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <A512FD59-63DF-48D3-BCB3-83DF8505E7E0@gmail.com>

On Sun, Aug 25, 2024 at 07:55:36AM GMT, Piotr Oniszczuk wrote:
>=20
>=20
> > Wiadomo=C5=9B=C4=87 napisana przez Nhat Pham <nphamcs@gmail.com> w dniu=
 23.08.2024, o godz. 18:16:
> >=20
> >=20
> > Have you tried with 6.9 yet? IIRC, there are two major changes to
> > zswap architecture in recent versions.
> >=20
> > 1. In 6.9, we range-partition zswap's rbtrees to reduce lock contention.
> >=20
>=20
> Ok - after 32h of continuous compilation also on 6.9.12 I got series of o=
ops (see below).
>

Since you have a reliable-ish repro: Could you compile a KASAN kernel and r=
un that? Note that
KASAN has a very real performance hit (if you're using this for prod) but i=
t'll probably help
shake out the bug.

> [68616.350398] watchdog: BUG: soft lockup - CPU#4 stuck for 596s! [kcompa=
ctd0:176]
<snip>
> [68616.350490]  ? hrtimer_interrupt+0xfa/0x230
> [68616.350492]  ? __sysvec_apic_timer_interrupt+0x55/0x150
> [68616.350494]  ? sysvec_apic_timer_interrupt+0x6c/0x90
> [68616.350497]  </IRQ>
> [68616.350498]  <TASK>
> [68616.350500]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [68616.350503]  ? native_queued_spin_lock_slowpath+0x6e/0x2e0
> [68616.350506]  _raw_spin_lock+0x29/0x30
> [68616.350509]  page_vma_mapped_walk+0x6a2/0x950

I don't understand what this is spinning on here. Page table lock?
Could you get the file/line number from this address?

> [68616.350511]  try_to_migrate_one+0x174/0xbf0
> [68616.350515]  rmap_walk_anon+0xb6/0x190
> [68616.350518]  try_to_migrate+0xf9/0x110
> [68616.350520]  ? __pfx_try_to_migrate_one+0x10/0x10
> [68616.350523]  ? __pfx_folio_not_mapped+0x10/0x10
> [68616.350526]  ? __pfx_folio_lock_anon_vma_read+0x10/0x10
> [68616.350528]  ? __pfx_invalid_migration_vma+0x10/0x10
> [68616.350531]  migrate_pages_batch+0x545/0xb80
> [68616.350534]  ? __pfx_compaction_free+0x10/0x10
> [68616.350536]  ? __pfx_compaction_alloc+0x10/0x10
> [68616.350540]  ? __pfx_remove_migration_pte+0x10/0x10
> [68616.350542]  migrate_pages+0xada/0xd90
> [68616.350545]  ? __pfx_compaction_alloc+0x10/0x10
> [68616.350548]  ? __pfx_compaction_free+0x10/0x10
> [68616.350551]  ? folio_add_lru+0x5f/0xb0
> [68616.350553]  compact_zone+0x9e8/0x10c0
<snip>
> [68620.214430] RSP: 0000:ffffb2688397fbe0 EFLAGS: 00000202
> [68620.214432] RAX: 00000000000c0101 RBX: ffff9388140cf738 RCX: 000000000=
0000008
> [68620.214434] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff93881=
40cf738
> [68620.214436] RBP: ffff938b2e6373c0 R08: ffff938b2e6310c0 R09: 000000000=
000000a
> [68620.214438] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0040000
> [68620.214440] R13: 0000000000040000 R14: ffff9388140cf738 R15: ffff93881=
40cf730
> [68620.214442] FS:  00007fc78bf83f00(0000) GS:ffff938b2e600000(0000) knlG=
S:0000000000000000
> [68620.214445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [68620.214447] CR2: 00007fc75b53f264 CR3: 00000001797f4000 CR4: 000000000=
0350ef0
> [68620.214449] Call Trace:
> [68620.214450]  <IRQ>
> [68620.214451]  ? watchdog_timer_fn+0x1dd/0x260
> [68620.214454]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [68620.214457]  ? __hrtimer_run_queues+0x10f/0x2a0
> [68620.214460]  ? hrtimer_interrupt+0xfa/0x230
> [68620.214462]  ? __sysvec_apic_timer_interrupt+0x55/0x150
> [68620.214465]  ? sysvec_apic_timer_interrupt+0x6c/0x90
> [68620.214468]  </IRQ>
> [68620.214469]  <TASK>
> [68620.214470]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [68620.214474]  ? native_queued_spin_lock_slowpath+0x21f/0x2e0
> [68620.214477]  _raw_spin_lock+0x29/0x30
> [68620.214479]  zswap_load+0x6a/0x160

=2E.. and I don't how a zswap lock could be related to a page table lock (i=
n case it is one).

> [68620.214482]  swap_read_folio+0x64/0x450
> [68620.214484]  swapin_readahead+0x1ea/0x4e0
> [68620.214487]  do_swap_page+0x403/0xd20
> [68620.214490]  ? shmem_file_write_iter+0x5e/0x90
> [68620.214492]  ? __pte_offset_map+0x1b/0x180
> [68620.214494]  __handle_mm_fault+0x868/0xdd0
> [68620.214498]  handle_mm_fault+0x18d/0x320
> [68620.214500]  do_user_addr_fault+0x175/0x6b0
> [68620.214503]  exc_page_fault+0x7e/0x180
> [68620.214505]  asm_exc_page_fault+0x26/0x30
<snip>
> [68620.214508] RIP: 0033:0x330a353
> [68620.214512] Code: e2 03 48 01 d0 48 8b 00 48 89 45 e8 48 83 7d e8 00 0=
f 84 11 01 00 00 48 83 7d e8 ff 75 08 8b 45 fc 89 45 f8 eb 42 48 8b 45 e8 <=
8b> 40 0c 39 45 84 75 36 48 8b 45 e8 8b 40 08 48 8b 55 88 39 d0 75
> [68620.214515] RSP: 002b:00007ffc42ae0390 EFLAGS: 00010217
> [68620.214517] RAX: 00007fc75b53f258 RBX: 00000000000003e9 RCX: 00000000f=
9107c14
> [68620.214519] RDX: 000000000003e0a0 RSI: 00007ffc42ae04f1 RDI: 000000002=
7ef6180
> [68620.214521] RBP: 00007ffc42ae0410 R08: 0000000000000000 R09: 000000000=
0000000
> [68620.214523] R10: 00007fc78c106ac0 R11: 00007fc78c1073c0 R12: 000000000=
0000000
> [68620.214525] R13: 00007ffc42ae1030 R14: 00007fc78c66f000 R15: 000000000=
3df8e50
> [68620.214528]  </TASK>
> [68632.363664] watchdog: BUG: soft lockup - CPU#8 stuck for 648s! [cc1plu=
s:2982130]
> [68632.363668] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolver =
nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter iptable_filter x=
t_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 amd_atl intel_rapl_msr=
 intel_rapl_common edac_mce_amd kvm_amd cfg80211 rfkill kvm crct10dif_pclmu=
l crc32_pclmul polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel=
 sha512_ssse3 sha256_ssse3 sha1_ssse3 r8169 aesni_intel crypto_simd cryptd =
realtek mdio_devres sp5100_tco wmi_bmof k10temp libphy ccp pcspkr rapl i2c_=
piix4 acpi_cpufreq zenpower ryzen_smu gpio_amdpt gpio_generic mac_hid nfsd =
auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmon_vid sunrpc sg cr=
ypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tables x_tables xfs lib=
crc32c crc32c_generic drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm_g=
puvm drm_exec mxm_wmi nvme drm_display_helper crc32c_intel xhci_pci nvme_co=
re cec xhci_pci_renesas wmi virtio_net net_failover failover virtio_blk vir=
tio_pci virtio_pci_legacy_dev virtio_pci_modern_dev
> [68632.363704]  [last unloaded: nouveau]
> [68632.363719] CPU: 8 PID: 2982130 Comm: cc1plus Tainted: G      D W    L=
     6.9.12-12 #1 e59bce453550af16b12fd25785f4d449e921764e
> [68632.363722] Hardware name: To Be Filled By O.E.M. B450M Pro4-F R2.0/B4=
50M Pro4-F R2.0, BIOS P10.08 01/19/2024
> [68632.363724] RIP: 0010:native_queued_spin_lock_slowpath+0x2a1/0x2e0
> [68632.363728] Code: c1 ea 12 83 e0 03 83 ea 01 48 c1 e0 05 48 63 d2 48 0=
5 c0 73 03 00 48 03 04 d5 40 32 91 aa 48 89 28 8b 45 08 85 c0 75 09 f3 90 <=
8b> 45 08 85 c0 74 f7 48 8b 55 00 48 85 d2 0f 84 6a ff ff ff 0f 0d
> [68632.363732] RSP: 0000:ffffb26885e1f450 EFLAGS: 00000246
> [68632.363734] RAX: 0000000000000000 RBX: ffff9388140cf738 RCX: fffffbc30=
f2ad340
> [68632.363736] RDX: 0000000000000014 RSI: 0000000000540101 RDI: ffff93881=
40cf738
> [68632.363738] RBP: ffff938b2ea373c0 R08: ffff93876cc2aaa0 R09: 0008c8130=
ae03aa0
> [68632.363740] R10: 020f0008c8130ae0 R11: 0000000000501000 R12: 000000000=
0240000
> [68632.363741] R13: 0000000000240000 R14: 03ffffffffffffff R15: 000000000=
00005fa
> [68632.363743] FS:  00007fd929957f00(0000) GS:ffff938b2ea00000(0000) knlG=
S:0000000000000000
> [68632.363746] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [68632.363748] CR2: 00007fd923600000 CR3: 0000000162ba8000 CR4: 000000000=
0350ef0
> [68632.363750] Call Trace:
> [68632.363751]  <IRQ>
> [68632.363752]  ? watchdog_timer_fn+0x1dd/0x260
> [68632.363755]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [68632.363758]  ? __hrtimer_run_queues+0x10f/0x2a0
> [68632.363761]  ? hrtimer_interrupt+0xfa/0x230
> [68632.363763]  ? __sysvec_apic_timer_interrupt+0x55/0x150
> [68632.363766]  ? sysvec_apic_timer_interrupt+0x6c/0x90
> [68632.363769]  </IRQ>
> [68632.363770]  <TASK>
> [68632.363771]  ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [68632.363775]  ? native_queued_spin_lock_slowpath+0x2a1/0x2e0
> [68632.363778]  _raw_spin_lock+0x29/0x30
> [68632.363781]  zswap_store+0x623/0xc70

FWIW this is the same zswap lock as above.

Also, could you try a memtest86 on your machine, to shake out potential har=
dware problems?

All-in-all if the above is a page table lock then this is a weird bug, beca=
use I don't see
how a zswap lock could be related to a ptlock through memory corruption, si=
nce ptdescs are just
struct pages... Either this is has to be a different bug than the one I rep=
orted back then, or
there's some side effect that's non-obvious to me.

--=20
Pedro

