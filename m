Return-Path: <linux-kernel+bounces-298926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC10995CD80
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED68B2200A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C418661C;
	Fri, 23 Aug 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WPMZBEfT"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5216BE14;
	Fri, 23 Aug 2024 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418840; cv=none; b=dg5nZB4gHVu8huCabCtsObIM9T1V0ZKQaKpavdK2DWNldhnhEO/bSWce/lEBurApmHzgJvs6lttau1BP8RfjzwnyJUVrtJQgsmXx/s1k+H98Fp9nbuwDkT7YpZb2NDCKWxfTiXkHCczz8QmiqwxodDtjEKjS3lQ2cJKswpBbmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418840; c=relaxed/simple;
	bh=2VuDKw6RUPYujJc7Sf3gzS0RKCRZL8yvENymR6FhGtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQvUHN3b3T7s2j5tu7pyjdDCpkG25MoQsri4Zuf6MgyBuqe+5/mJx4P3ue4ZCAb/ITJGnHzf9DcNWHDx950Eozjkl6INNI4JuXEB7JGig68X128Uj5fkUNbuwCsTLNUjx5uCx4XAhmkxsl9gmbb0mMO9OrEmbgbKouxhctEyomc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WPMZBEfT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=9726wI1YFeYjjadz1bBiL0sJk6KSJthMPP/V0eOLo+U=; b=WPMZBEfTjYTWmHK21FPmiWIQDt
	UnAUn4IlG6u1J1iLAbFEJgyQ5HL+xGZyaaxhbskMZ4+GC/E3txGwMabwAn2GPqw1uLGmd+A4MdHkP
	Af/xyNFztys6U1eiabpesK/yXl5G+CZqrfax/gC9KDAMljgLmxyCyLD9ES7j3rIE1E/YlgAvAF8Zr
	WUiWYfRfgab/yxUppG1dmgucb3GZIQcunJfNjGxkcX5shj+eQfSJPHslFB+Hqg1K3puSY+2yVipzb
	2TQbILkR3S3EM7OucPA/mfuHO9BivW0qka6/H+hVUA3cVMl97QGe95LljjRl6kIM2mJF8XejrQ70l
	84UqDBMg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shU71-0000000Bkr0-0Rtt;
	Fri, 23 Aug 2024 13:13:55 +0000
Date: Fri, 23 Aug 2024 14:13:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
Message-ID: <ZsiLElTykamcYZ6J@casper.infradead.org>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>

On Fri, Aug 23, 2024 at 01:51:41PM +0200, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> > [75864.693223] br0: port 1(enp5s0) entered blocking state
> > [75864.693226] br0: port 1(enp5s0) entered forwarding state
> > [86041.349844] ------------[ cut here ]------------
> > [86041.349850] kernel BUG at mm/zswap.c:1005!

This is:

        BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &ac=
omp_ctx->wait));

so crypto_acomp_decompress() returned an error, and zswap did not handle
it.  I wouldn't be surprised if this were dodgy ram.

That said, zswap could handle this better.  There's no need to panic the
entire machine over being unable to read a page from swap.  Killing just
the process that needed this page is sufficient.

Suggested patch at end after the oops.

> > [86041.349862] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > [86041.349867] CPU: 5 PID: 2798071 Comm: llvm-tblgen Not tainted 6.10.6=
-12 #1 349ceb515693b41153483eac7819a5fb2832d2bf
> > [86041.349872] Hardware name: To Be Filled By O.E.M. B450M Pro4-F R2.0/=
B450M Pro4-F R2.0, BIOS P10.08 01/19/2024
> > [86041.349876] RIP: 0010:zswap_decompress+0x1ef/0x200
> > [86041.349884] Code: ef e8 95 2a ce ff 84 c0 0f 85 1f ff ff ff e9 fb fe=
 ff ff 0f 0b 48 8d 7b 10 e8 0d a9 a4 00 c7 43 10 00 00 00 00 8b 43 30 eb 86=
 <0f> 0b 0f 0b e8 f8 9b a3 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
> > [86041.349889] RSP: 0000:ffffb98f823ebb90 EFLAGS: 00010282
> > [86041.349892] RAX: 00000000ffffffea RBX: ffff9bf22e8c1e08 RCX: ffff9be=
f137774ba
> > [86041.349894] RDX: 0000000000000002 RSI: 0000000000000438 RDI: ffff9bf=
22e8b2af0
> > [86041.349897] RBP: ffff9bef58cd2b98 R08: ffff9bee8baf07e0 R09: ffff9be=
f13777080
> > [86041.349899] R10: 0000000000000022 R11: ffff9bee8baf1000 R12: fffff78=
2422ebc00
> > [86041.349902] R13: ffff9bef13777080 R14: ffff9bef01e3d6e0 R15: ffff9bf=
22e8c1e48
> > [86041.349904] FS:  00007f4bda31d280(0000) GS:ffff9bf22e880000(0000) kn=
lGS:0000000000000000
> > [86041.349908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [86041.349910] CR2: 000000001665d010 CR3: 0000000191a2c000 CR4: 0000000=
000350ef0
> > [86041.349914] Call Trace:
> > [86041.349918]  <TASK>
> > [86041.349920]  ? die+0x36/0x90
> > [86041.349925]  ? do_trap+0xdd/0x100
> > [86041.349929]  ? zswap_decompress+0x1ef/0x200
> > [86041.349932]  ? do_error_trap+0x6a/0x90
> > [86041.349935]  ? zswap_decompress+0x1ef/0x200
> > [86041.349938]  ? exc_invalid_op+0x50/0x70
> > [86041.349943]  ? zswap_decompress+0x1ef/0x200
> > [86041.349946]  ? asm_exc_invalid_op+0x1a/0x20
> > [86041.349951]  ? zswap_decompress+0x1ef/0x200
> > [86041.349955]  zswap_load+0x109/0x120
> > [86041.349958]  swap_read_folio+0x64/0x450
> > [86041.349963]  swapin_readahead+0x463/0x4e0
> > [86041.349967]  do_swap_page+0x436/0xd70
> > [86041.349972]  ? __pte_offset_map+0x1b/0x180
> > [86041.349976]  __handle_mm_fault+0x85d/0x1070
> > [86041.349979]  ? sched_tick+0xee/0x2f0
> > [86041.349985]  handle_mm_fault+0x18d/0x320
> > [86041.349988]  do_user_addr_fault+0x177/0x6a0
> > [86041.349993]  exc_page_fault+0x7e/0x180
> > [86041.349996]  asm_exc_page_fault+0x26/0x30
> > [86041.350000] RIP: 0033:0x7453b9
> > [86041.350019] Code: 00 48 8d 0c 49 4c 8d 04 ca 48 8b 0f 4c 39 c2 75 19=
 e9 7f 00 00 00 66 66 2e 0f 1f 84 00 00 00 00 00 48 83 c2 18 49 39 d0 74 6b=
 <48> 39 0a 75 f2 48 89 84 24 90 00 00 00 4c 39 73 10 0f 84 2f 02 00
> > [86041.350024] RSP: 002b:00007ffe67b93c80 EFLAGS: 00010206
> > [86041.350027] RAX: 0000000016659250 RBX: 00007ffe67b93db0 RCX: 0000000=
00f1aad40
> > [86041.350030] RDX: 000000001665d010 RSI: 00007ffe67b93cd8 RDI: 00007ff=
e67b93cd0
> > [86041.350032] RBP: 0000000000000001 R08: 000000001665d088 R09: 0000000=
000000000
> > [86041.350035] R10: 00007f4bda030610 R11: 00007f4bda0d6200 R12: 0000000=
016661210
> > [86041.350038] R13: 00007ffe67b94a58 R14: 000000000ba280a8 R15: 0000000=
000000006
> > [86041.350041]  </TASK>
> > [86041.350043] Modules linked in: tls rpcsec_gss_krb5 nfsv4 dns_resolve=
r nfs netfs rpcrdma rdma_cm iw_cm ib_cm ib_core br_netfilter iptable_filter=
 xt_physdev tun bridge stp llc ext4 crc16 mbcache jbd2 amd_atl intel_rapl_m=
sr intel_rapl_common cfg80211 edac_mce_amd kvm_amd rfkill kvm crct10dif_pcl=
mul crc32_pclmul polyval_clmulni r8169 polyval_generic gf128mul ghash_clmul=
ni_intel sha512_ssse3 realtek sha256_ssse3 sha1_ssse3 aesni_intel mdio_devr=
es crypto_simd sp5100_tco k10temp gpio_amdpt cryptd wmi_bmof pcspkr ccp lib=
phy i2c_piix4 acpi_cpufreq rapl zenpower ryzen_smu gpio_generic mac_hid nfs=
d auth_rpcgss nfs_acl lockd grace nct6775 nct6775_core hwmon_vid sg sunrpc =
crypto_user fuse dm_mod loop nfnetlink bpf_preload ip_tables x_tables xfs l=
ibcrc32c crc32c_generic drm_ttm_helper ttm video gpu_sched i2c_algo_bit drm=
_gpuvm drm_exec mxm_wmi nvme crc32c_intel drm_display_helper xhci_pci nvme_=
core xhci_pci_renesas wmi virtio_net net_failover failover dimlib virtio_bl=
k virtio_pci virtio_pci_legacy_dev virtio_pci_modern_dev
> > [86041.350106]  [last unloaded: nouveau]
> > [86041.350125] ---[ end trace 0000000000000000 ]---

diff --git a/mm/zswap.c b/mm/zswap.c
index df66ab102d27..186aa4282c93 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -958,12 +958,13 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
 	return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
 }
=20
-static void zswap_decompress(struct zswap_entry *entry, struct folio *foli=
o)
+static int zswap_decompress(struct zswap_entry *entry, struct folio *folio)
 {
 	struct zpool *zpool =3D entry->pool->zpool;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src;
+	int err;
=20
 	acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
 	mutex_lock(&acomp_ctx->mutex);
@@ -989,12 +990,17 @@ static void zswap_decompress(struct zswap_entry *entr=
y, struct folio *folio)
 	sg_init_table(&output, 1);
 	sg_set_folio(&output, folio, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, =
PAGE_SIZE);
-	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ct=
x->wait));
-	BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
+	err =3D crypto_acomp_decompress(acomp_ctx->req);
+	err =3D crypto_wait_req(err, &acomp_ctx->wait);;
+	if (WARN_ONCE(err, "Decompression error %d -- corrupted RAM?\n", err))
+		return err;
+	if (acomp_ctx->req->dlen !=3D PAGE_SIZE)
+		return -EIO;
 	mutex_unlock(&acomp_ctx->mutex);
=20
 	if (src !=3D acomp_ctx->buffer)
 		zpool_unmap_handle(zpool, entry->handle);
+	return 0;
 }
=20
 /*********************************
@@ -1020,6 +1026,7 @@ static int zswap_writeback_entry(struct zswap_entry *=
entry,
 	struct folio *folio;
 	struct mempolicy *mpol;
 	bool folio_was_allocated;
+	int err;
 	struct writeback_control wbc =3D {
 		.sync_mode =3D WB_SYNC_NONE,
 	};
@@ -1060,7 +1067,12 @@ static int zswap_writeback_entry(struct zswap_entry =
*entry,
 		return -ENOMEM;
 	}
=20
-	zswap_decompress(entry, folio);
+	err =3D zswap_decompress(entry, folio);
+	if (err < 0) {
+		folio_unlock(folio);
+		folio_put(folio);
+		return err;
+	}
=20
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
@@ -1601,6 +1613,7 @@ bool zswap_load(struct folio *folio)
 	bool swapcache =3D folio_test_swapcache(folio);
 	struct xarray *tree =3D swap_zswap_tree(swp);
 	struct zswap_entry *entry;
+	int err;
=20
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
=20
@@ -1638,10 +1651,13 @@ bool zswap_load(struct folio *folio)
 	if (!entry)
 		return false;
=20
-	if (entry->length)
-		zswap_decompress(entry, folio);
-	else
+	if (entry->length) {
+		err =3D zswap_decompress(entry, folio);
+		if (err)
+			return false;
+	} else {
 		zswap_fill_folio(folio, entry->value);
+	}
=20
 	count_vm_event(ZSWPIN);
 	if (entry->objcg)

