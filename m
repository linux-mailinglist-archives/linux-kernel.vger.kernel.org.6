Return-Path: <linux-kernel+bounces-381065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB09AF9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39F50283768
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960351925BF;
	Fri, 25 Oct 2024 06:18:48 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E71B0F11
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837128; cv=none; b=uDzoRxS8GwZjIGmD2n/Au8ZsAh4IFmwt27lVBjz7MyxFEgECNTX5sUVoGdH5OiVWTSI8YcR1nARetkLFeQhjl7kbLxEROG/pnDJc0BEwcdjMVLsom9tscbvoD17RFxZd3YkoCrFphC947Hn4N9XCcAo8ctJ66uhkAtrNU2Ddf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837128; c=relaxed/simple;
	bh=GGJrLc6k/IoLknH7t+/8lJ/6J/h6bBy1zYotpMDFG7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=THVrm4EVKEtNvBWsJ8XbbWnBH9V7KR/lBPWAI+tU9xUBK5IAJDXBG5VnPcY/L7H0HsKwXHQ7qE7qkxipI8tL4T3zxgeaGEQfSkqYtHHNg0wSS2/WInNErcsIQq+eWzLFkRYn7bH9AUwaNGwbhvWsKwhj4xDK3dK5ANKR+jkcq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XZXf66glQz4f3jRC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:18:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6E26C1A07B6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:18:40 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCXy8cjOBtndSE+FA--.48420S2;
	Fri, 25 Oct 2024 14:18:40 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	anshuman.khandual@arm.com,
	vbabka@suse.cz,
	kirill@shutemov.name
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v3] mm: shrinker: avoid memleak in alloc_shrinker_info
Date: Fri, 25 Oct 2024 06:09:42 +0000
Message-Id: <20241025060942.1049263-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXy8cjOBtndSE+FA--.48420S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF13Cr4rur4Dtr4UGr17Wrg_yoW5JF43pF
	45GFyUGF4rAr45Wr47KF98XFyrta1UC3W7G393XFy0vw4Sg3W7Xr17Jr4jyrWDu3Z3AFy7
	trWqqrWjgFyUAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

A memleak was found as bellow:

unreferenced object 0xffff8881010d2a80 (size 32):
  comm "mkdir", pid 1559, jiffies 4294932666
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    40 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  @...............
  backtrace (crc 2e7ef6fa):
    [<ffffffff81372754>] __kmalloc_node_noprof+0x394/0x470
    [<ffffffff813024ab>] alloc_shrinker_info+0x7b/0x1a0
    [<ffffffff813b526a>] mem_cgroup_css_online+0x11a/0x3b0
    [<ffffffff81198dd9>] online_css+0x29/0xa0
    [<ffffffff811a243d>] cgroup_apply_control_enable+0x20d/0x360
    [<ffffffff811a5728>] cgroup_mkdir+0x168/0x5f0
    [<ffffffff8148543e>] kernfs_iop_mkdir+0x5e/0x90
    [<ffffffff813dbb24>] vfs_mkdir+0x144/0x220
    [<ffffffff813e1c97>] do_mkdirat+0x87/0x130
    [<ffffffff813e1de9>] __x64_sys_mkdir+0x49/0x70
    [<ffffffff81f8c928>] do_syscall_64+0x68/0x140
    [<ffffffff8200012f>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

In the alloc_shrinker_info function, when shrinker_unit_alloc return
err, the info won't be freed. Just fix it.

Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for shrinker_info::{map, nr_deferred}")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Acked-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/shrinker.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/shrinker.c b/mm/shrinker.c
index dc5d2a6fcfc4..4a93fd433689 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -76,19 +76,21 @@ void free_shrinker_info(struct mem_cgroup *memcg)
 
 int alloc_shrinker_info(struct mem_cgroup *memcg)
 {
-	struct shrinker_info *info;
 	int nid, ret = 0;
 	int array_size = 0;
 
 	mutex_lock(&shrinker_mutex);
 	array_size = shrinker_unit_size(shrinker_nr_max);
 	for_each_node(nid) {
-		info = kvzalloc_node(sizeof(*info) + array_size, GFP_KERNEL, nid);
+		struct shrinker_info *info = kvzalloc_node(sizeof(*info) + array_size,
+							   GFP_KERNEL, nid);
 		if (!info)
 			goto err;
 		info->map_nr_max = shrinker_nr_max;
-		if (shrinker_unit_alloc(info, NULL, nid))
+		if (shrinker_unit_alloc(info, NULL, nid)) {
+			kvfree(info);
 			goto err;
+		}
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
 	mutex_unlock(&shrinker_mutex);
-- 
2.34.1


