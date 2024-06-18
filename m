Return-Path: <linux-kernel+bounces-218546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2204690C1B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D17281B07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8118B1A;
	Tue, 18 Jun 2024 02:10:44 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8411CD00
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718676643; cv=none; b=hWvp+dYocHpTM744pCT+ObCrSTtFJ5ZYzw3q7yaopH5nPaRVYw2/4QIMXCqO3/5d0Y0Rn+YxaDb9wcgjftuqJictAj+/BBz7nEtrB2CxdBNtg2mpn1JlcLVuMPgXPMRIPz3/Fk4X2mXWSDWv+IVnKIguuz+8z9NpkuuMfd7DUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718676643; c=relaxed/simple;
	bh=q5a0ite6n7zpBMQ97+BxoR6JUlhGWO8XsoFM4djECr4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DxYwcyTewRoNtjnOvkWCmz5NxxNdGTw1oGye401DVbxo6X2kR51xYpFEc+OGR9mnxOdI0J5Wq6Hcz6LYfoijNRLngWKQdeGgRHKLwKzHtI4JjdQalyFnokO/qQGSdg7jo+EhsGfl+DLT7WqVjN1v8jXVsgX7VqIapFumNe9lUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 45I29XaZ076616;
	Tue, 18 Jun 2024 10:09:33 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4W397R213mz2Qv7yJ;
	Tue, 18 Jun 2024 10:05:07 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 18 Jun 2024 10:09:31 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox
	<willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] mm: fix hard lockup in __split_huge_page
Date: Tue, 18 Jun 2024 10:09:26 +0800
Message-ID: <20240618020926.1911903-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 45I29XaZ076616

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Hard lockup[2] is reported which should be caused by recursive
lock contention of lruvec->lru_lock[1] within __split_huge_page.

[1]
static void __split_huge_page(struct page *page, struct list_head *list,
                pgoff_t end, unsigned int new_order)
{
        /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
//1st lock here
        lruvec = folio_lruvec_lock(folio);

        for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
                __split_huge_page_tail(folio, i, lruvec, list, new_order);
                /* Some pages can be beyond EOF: drop them from page cache */
                if (head[i].index >= end) {
                        folio_put(tail);
                            __page_cache_release
//2nd lock here
                               folio_lruvec_relock_irqsave

[2]
[26887.389623] watchdog: Watchdog detected hard LOCKUP on cpu 21
[26887.389682] CPU: 21 PID: 264 Comm: kswapd0 Kdump: loaded Tainted: G
      W          6.6.31.el9 #3
[26887.389685] Hardware name: FUJITSU PRIMERGY RX2540 M4/D3384-A1, BIOS
V5.0.0.12 R1.22.0 for D3384-A1x                    06/04/2018
[26887.389687] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389696] Code: 08 0f 92 c2 8b 45 00 0f b6 d2 c1 e2 08 30 e4 09 d0
a9 00 01 ff ff 0f 85 ea 01 00 00 85 c0 74 12 0f b6 45 00 84 c0 74 0a f3
90 <0f> b6 45 00 84 c0 75 f6 b8 01 00 00 00 66 89 45 00 5b 5d 41 5c 41
[26887.389698] RSP: 0018:ffffb3e587a87a20 EFLAGS: 00000002
[26887.389700] RAX: 0000000000000001 RBX: ffff9ad6c6f67050 RCX:
0000000000000000
[26887.389701] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff9ad6c6f67050
[26887.389703] RBP: ffff9ad6c6f67050 R08: 0000000000000000 R09:
0000000000000067
[26887.389704] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000046
[26887.389705] R13: 0000000000000200 R14: 0000000000000000 R15:
ffffe1138aa98000
[26887.389707] FS:  0000000000000000(0000) GS:ffff9ade20340000(0000)
knlGS:0000000000000000
[26887.389708] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[26887.389710] CR2: 000000002912809b CR3: 000000064401e003 CR4:
00000000007706e0
[26887.389711] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[26887.389712] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[26887.389713] PKRU: 55555554
[26887.389714] Call Trace:
[26887.389717]  <NMI>
[26887.389720]  ? watchdog_hardlockup_check+0xac/0x150
[26887.389725]  ? __perf_event_overflow+0x102/0x1d0
[26887.389729]  ? handle_pmi_common+0x189/0x3e0
[26887.389735]  ? set_pte_vaddr_p4d+0x4a/0x60
[26887.389738]  ? flush_tlb_one_kernel+0xa/0x20
[26887.389742]  ? native_set_fixmap+0x65/0x80
[26887.389745]  ? ghes_copy_tofrom_phys+0x75/0x110
[26887.389751]  ? __ghes_peek_estatus.isra.0+0x49/0xb0
[26887.389755]  ? intel_pmu_handle_irq+0x10b/0x230
[26887.389756]  ? perf_event_nmi_handler+0x28/0x50
[26887.389759]  ? nmi_handle+0x58/0x150
[26887.389764]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389768]  ? default_do_nmi+0x6b/0x170
[26887.389770]  ? exc_nmi+0x12c/0x1a0
[26887.389772]  ? end_repeat_nmi+0x16/0x1f
[26887.389777]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389780]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389784]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389787]  </NMI>
[26887.389788]  <TASK>
[26887.389789]  __raw_spin_lock_irqsave+0x3d/0x50
[26887.389793]  folio_lruvec_lock_irqsave+0x5e/0x90
[26887.389798]  __page_cache_release+0x68/0x230
[26887.389801]  ? remove_migration_ptes+0x5c/0x80
[26887.389807]  __folio_put+0x24/0x60
[26887.389808]  __split_huge_page+0x368/0x520
[26887.389812]  split_huge_page_to_list+0x4b3/0x570
[26887.389816]  deferred_split_scan+0x1c8/0x290
[26887.389819]  do_shrink_slab+0x12f/0x2d0
[26887.389824]  shrink_slab_memcg+0x133/0x1d0
[26887.389829]  shrink_node_memcgs+0x18e/0x1d0
[26887.389832]  shrink_node+0xa7/0x370
[26887.389836]  balance_pgdat+0x332/0x6f0
[26887.389842]  kswapd+0xf0/0x190
[26887.389845]  ? balance_pgdat+0x6f0/0x6f0
[26887.389848]  kthread+0xee/0x120
[26887.389851]  ? kthread_complete_and_exit+0x20/0x20
[26887.389853]  ret_from_fork+0x2d/0x50
[26887.389857]  ? kthread_complete_and_exit+0x20/0x20
[26887.389859]  ret_from_fork_asm+0x11/0x20
[26887.389864]  </TASK>
[26887.389865] Kernel panic - not syncing: Hard LOCKUP
[26887.389867] CPU: 21 PID: 264 Comm: kswapd0 Kdump: loaded Tainted: G
      W          6.6.31.el9 #3
[26887.389869] Hardware name: FUJITSU PRIMERGY RX2540 M4/D3384-A1, BIOS
V5.0.0.12 R1.22.0 for D3384-A1x                    06/04/2018
[26887.389870] Call Trace:
[26887.389871]  <NMI>
[26887.389872]  dump_stack_lvl+0x44/0x60
[26887.389877]  panic+0x241/0x330
[26887.389881]  nmi_panic+0x2f/0x40
[26887.389883]  watchdog_hardlockup_check+0x119/0x150
[26887.389886]  __perf_event_overflow+0x102/0x1d0
[26887.389889]  handle_pmi_common+0x189/0x3e0
[26887.389893]  ? set_pte_vaddr_p4d+0x4a/0x60
[26887.389896]  ? flush_tlb_one_kernel+0xa/0x20
[26887.389899]  ? native_set_fixmap+0x65/0x80
[26887.389902]  ? ghes_copy_tofrom_phys+0x75/0x110
[26887.389906]  ? __ghes_peek_estatus.isra.0+0x49/0xb0
[26887.389909]  intel_pmu_handle_irq+0x10b/0x230
[26887.389911]  perf_event_nmi_handler+0x28/0x50
[26887.389913]  nmi_handle+0x58/0x150
[26887.389916]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389920]  default_do_nmi+0x6b/0x170
[26887.389922]  exc_nmi+0x12c/0x1a0
[26887.389923]  end_repeat_nmi+0x16/0x1f
[26887.389926] RIP: 0010:native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389930] Code: 08 0f 92 c2 8b 45 00 0f b6 d2 c1 e2 08 30 e4 09 d0
a9 00 01 ff ff 0f 85 ea 01 00 00 85 c0 74 12 0f b6 45 00 84 c0 74 0a f3
90 <0f> b6 45 00 84 c0 75 f6 b8 01 00 00 00 66 89 45 00 5b 5d 41 5c 41
[26887.389931] RSP: 0018:ffffb3e587a87a20 EFLAGS: 00000002
[26887.389933] RAX: 0000000000000001 RBX: ffff9ad6c6f67050 RCX:
0000000000000000
[26887.389934] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff9ad6c6f67050
[26887.389935] RBP: ffff9ad6c6f67050 R08: 0000000000000000 R09:
0000000000000067
[26887.389936] R10: 0000000000000000 R11: 0000000000000000 R12:
0000000000000046
[26887.389937] R13: 0000000000000200 R14: 0000000000000000 R15:
ffffe1138aa98000
[26887.389940]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389943]  ? native_queued_spin_lock_slowpath+0x6e/0x2c0
[26887.389946]  </NMI>
[26887.389947]  <TASK>
[26887.389947]  __raw_spin_lock_irqsave+0x3d/0x50
[26887.389950]  folio_lruvec_lock_irqsave+0x5e/0x90
[26887.389953]  __page_cache_release+0x68/0x230
[26887.389955]  ? remove_migration_ptes+0x5c/0x80
[26887.389958]  __folio_put+0x24/0x60
[26887.389960]  __split_huge_page+0x368/0x520
[26887.389963]  split_huge_page_to_list+0x4b3/0x570
[26887.389967]  deferred_split_scan+0x1c8/0x290
[26887.389971]  do_shrink_slab+0x12f/0x2d0
[26887.389974]  shrink_slab_memcg+0x133/0x1d0
[26887.389978]  shrink_node_memcgs+0x18e/0x1d0
[26887.389982]  shrink_node+0xa7/0x370
[26887.389985]  balance_pgdat+0x332/0x6f0
[26887.389991]  kswapd+0xf0/0x190
[26887.389994]  ? balance_pgdat+0x6f0/0x6f0
[26887.389997]  kthread+0xee/0x120
[26887.389998]  ? kthread_complete_and_exit+0x20/0x20
[26887.390000]  ret_from_fork+0x2d/0x50
[26887.390003]  ? kthread_complete_and_exit+0x20/0x20
[26887.390004]  ret_from_fork_asm+0x11/0x20
[26887.390009]  </TASK>

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..ea504df46d3b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2925,7 +2925,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
 			__filemap_remove_folio(tail, NULL);
+			unlock_page_lruvec(lruvec);
 			folio_put(tail);
+			folio_lruvec_lock(folio);
 		} else if (!PageAnon(page)) {
 			__xa_store(&folio->mapping->i_pages, head[i].index,
 					head + i, 0);
-- 
2.25.1


