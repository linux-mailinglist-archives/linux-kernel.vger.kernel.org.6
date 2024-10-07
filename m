Return-Path: <linux-kernel+bounces-353088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BC992845
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BE4283708
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3818E37D;
	Mon,  7 Oct 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="B+56ATgP"
Received: from ec2-44-216-146-164.compute-1.amazonaws.com (ec2-44-216-146-164.compute-1.amazonaws.com [44.216.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D535B41C69
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.216.146.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728293837; cv=none; b=mDbzao0vVLBSpDlehkNvboNMXjSBjJgrU518DPk3HY7GThq+m71m1zf2nGT4W5U/a60R66SM1L80Es74Q2oS8QSZMqZJzNX9DZRldV1AcqA3lWDM6hugs8R6zQG5Zn3QOUdXB2G/tVURANkJkKIzTiBFJyVRoH9Caiq3uiXXams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728293837; c=relaxed/simple;
	bh=K9a7FMz7SvNCmK218E8gq/h12qdJfUpcGOy/IORBRfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oyZCOUbyqNqxeCTK0j1iAqsac/Og6IgyHn7I6kLDyJ8k41DUxhAAgfF5tJ3cAnFJ3CRKdy3U4syU7fxUerov/Q20RJSAPlFNmSRe+bHPO0RE4ugDEsLzuOLHnAs/+OJhsUOctzjFHoHdGwLd/RUeC0TgOVatvRbxWysgxNBhiAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=none smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=B+56ATgP; arc=none smtp.client-ip=44.216.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ucloud.cn
DKIM-Signature: a=rsa-sha256;
	b=B+56ATgPYsColIFjbF6E2igJ+ddrlaYvhEg7yMEzJB+hIg1z+RiZ5g5Su2O+NMFCw98BZKryovPdg0H4YnGgZtv/bGm4xqh2iGkFyAb7Zoe9poTW8bWhhpGOJeNdq0DCR6QlNHD9N88YNywmcornQuXBiohVqbq16Z44ob7fYuk=; s=default; c=relaxed/relaxed; d=ucloud.cn; v=1;
	bh=CJxluDCdlvSWSf6TQdEXqcR9qZO7r70ls/cHCmcBZQk=;
	h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [101.93.48.31])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 71B9774047E;
	Mon,  7 Oct 2024 17:18:54 +0800 (CST)
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yuan.gao@ucloud.cn
Subject: [PATCH v2] mm/slub: Avoid list corruption when removing a slab from the full list
Date: Mon,  7 Oct 2024 17:18:50 +0800
Message-Id: <20241007091850.16959-1-yuan.gao@ucloud.cn>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkhCVkhMThpOQhhKQ0NDHlYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0pVQkhVT0NVSEpZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSktLVU
	pCS0tZBg++
X-HM-Tid: 0a92664647d80236kunm71b9774047e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mgg6Lww4NDchS0whTD5ODlEu
	SAoaCjdVSlVKTElDSUJJTEhOTUhLVTMWGhIXVQIOGhVVHBoUOw4YFxQOH1UYFUVZV1kSC1lBWUpL
	SlVCSFVPQ1VISllXWQgBWUFOSUhNNwY+

boot with slub_debug=UFPZ.

If allocated object failed in alloc_consistency_checks, all objects of
the slab will be marked as used, and then the slab will be removed from
the partial list.

When an object belonging to the slab got freed later, the remove_full()
function is called. Because the slab is neither on the partial list nor
on the full list, it eventually lead to a list corruption.

So we need to add the slab to full list in this case.

[ 4277.385669] list_del corruption, ffffea00044b3e50->next is LIST_POISON1 (dead000000000100)
[ 4277.387023] ------------[ cut here ]------------
[ 4277.387880] kernel BUG at lib/list_debug.c:56!
[ 4277.388680] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[ 4277.389562] CPU: 5 PID: 90 Comm: kworker/5:1 Kdump: loaded Tainted: G           OE      6.6.1-1 #1
[ 4277.392113] Workqueue: xfs-inodegc/vda1 xfs_inodegc_worker [xfs]
[ 4277.393551] RIP: 0010:__list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.394518] Code: 48 91 82 e8 37 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 28 49 91 82 e8 26 f9 9a ff 0f 0b 48 89 fe 48 c7 c7 58 49 91
[ 4277.397292] RSP: 0018:ffffc90000333b38 EFLAGS: 00010082
[ 4277.398202] RAX: 000000000000004e RBX: ffffea00044b3e50 RCX: 0000000000000000
[ 4277.399340] RDX: 0000000000000002 RSI: ffffffff828f8715 RDI: 00000000ffffffff
[ 4277.400545] RBP: ffffea00044b3e40 R08: 0000000000000000 R09: ffffc900003339f0
[ 4277.401710] R10: 0000000000000003 R11: ffffffff82d44088 R12: ffff888112cf9910
[ 4277.402887] R13: 0000000000000001 R14: 0000000000000001 R15: ffff8881000424c0
[ 4277.404049] FS:  0000000000000000(0000) GS:ffff88842fd40000(0000) knlGS:0000000000000000
[ 4277.405357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4277.406389] CR2: 00007f2ad0b24000 CR3: 0000000102a3a006 CR4: 00000000007706e0
[ 4277.407589] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 4277.408780] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 4277.410000] PKRU: 55555554
[ 4277.410645] Call Trace:
[ 4277.411234]  <TASK>
[ 4277.411777]  ? die+0x32/0x80
[ 4277.412439]  ? do_trap+0xd6/0x100
[ 4277.413150]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.414158]  ? do_error_trap+0x6a/0x90
[ 4277.414948]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.415915]  ? exc_invalid_op+0x4c/0x60
[ 4277.416710]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.417675]  ? asm_exc_invalid_op+0x16/0x20
[ 4277.418482]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.419466]  ? __list_del_entry_valid_or_report+0x7b/0xc0
[ 4277.420410]  free_to_partial_list+0x515/0x5e0
[ 4277.421242]  ? xfs_iext_remove+0x41a/0xa10 [xfs]
[ 4277.422298]  xfs_iext_remove+0x41a/0xa10 [xfs]
[ 4277.423316]  ? xfs_inodegc_worker+0xb4/0x1a0 [xfs]
[ 4277.424383]  xfs_bmap_del_extent_delay+0x4fe/0x7d0 [xfs]
[ 4277.425490]  __xfs_bunmapi+0x50d/0x840 [xfs]
[ 4277.426445]  xfs_itruncate_extents_flags+0x13a/0x490 [xfs]
[ 4277.427553]  xfs_inactive_truncate+0xa3/0x120 [xfs]
[ 4277.428567]  xfs_inactive+0x22d/0x290 [xfs]
[ 4277.429500]  xfs_inodegc_worker+0xb4/0x1a0 [xfs]
[ 4277.430479]  process_one_work+0x171/0x340
[ 4277.431227]  worker_thread+0x277/0x390
[ 4277.431962]  ? __pfx_worker_thread+0x10/0x10
[ 4277.432752]  kthread+0xf0/0x120
[ 4277.433382]  ? __pfx_kthread+0x10/0x10
[ 4277.434134]  ret_from_fork+0x2d/0x50
[ 4277.434837]  ? __pfx_kthread+0x10/0x10
[ 4277.435566]  ret_from_fork_asm+0x1b/0x30
[ 4277.436280]  </TASK>

v2:
* Call remove_partial() and add_full() only for slab folios.

v1:
https://lore.kernel.org/linux-mm/20241006044755.79634-1-yuan.gao@ucloud.cn/

Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
---
 mm/slub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 21f71cb6cc06..2992388c00f4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2745,7 +2745,10 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	slab->inuse++;
 
 	if (!alloc_debug_processing(s, slab, object, orig_size)) {
-		remove_partial(n, slab);
+		if (folio_test_slab(slab_folio(slab))) {
+			remove_partial(n, slab);
+			add_full(s, n, slab);
+		}
 		return NULL;
 	}
 
-- 
2.32.0


