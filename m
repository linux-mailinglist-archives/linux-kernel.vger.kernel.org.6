Return-Path: <linux-kernel+bounces-367899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FD9A081F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E433F1F22733
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC62076A9;
	Wed, 16 Oct 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="tWF8V+uS"
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBDA18C920
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077235; cv=none; b=BCHCxwyt2ViDjRvmHThihxlC64cqwray6titTHQfiK0fzIVQK2EtgXF4LaLA8ZwwPf+GZQwxxpuNccm6IjbOmXivysFriTrOa+1zju93H946mHMkbNT1DH9PLoNfOMj8NVh7fyqSgMIpcOzA5y9WRzPNuYE6xZNnNzX5/c1ewY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077235; c=relaxed/simple;
	bh=Cym9k5YlG7MkxGTDpK6LrrZkim1QhFb6BtXygPQM6UQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=INyW02b36QDQ4C+3aGWkXuQBS+AikwySg2NO190OMLjdVliYfqEeBQxcYG1CR/et3+PgZ5encXvdsH+ehEZUq9jnl7SeSlJs8YjGRYslHtvUQrKjGeCxJOkAApaPa9VMZD56/53m3Asz/bhg0PsDZ1vKjeQqdfVfsKkvPAEpS+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=tWF8V+uS; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 49G9MQL83120632; Wed, 16 Oct 2024 18:22:26 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=
	1729070518;x=1730280118;bh=Cym9k5YlG7MkxGTDpK6LrrZkim1QhFb6BtXygPQM6UQ=;b=tWF
	8V+uSiuBsOFAQwXeWq+TFr3+fTCX32f5FPEQXLx5gILWCTiIXG+SdxkxnpIkqQGzQGuFyPvCJrRod
	qrJGcqIQdhzdnTctxCmamcwSpJHHGAgdb//u9uHr/hzeNI8VNlymE4xORcazywoUemRpS7xYnhOyZ
	aR1IpSewF2GZKJ8RulxecmofQk1R5MfO/imjySRrmsrZCgLaUF/ISpqmHTiQ2HwZY2gZgtKGEOSwj
	48a0wMiRkK0qwecSZmw2TR6TsmaWMV+XCYAdRvvrEI/YBzkzA6CYvagUcMmW/PQcWNmzRo0WcjNBa
	0NOVv08LEHvx4zfLsbfFo1pbkULUxlA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 49G9LwN91420583; Wed, 16 Oct 2024 18:21:58 +0900
X-Iguazu-Qid: 2rWgO3UeIOptYH2MiI
X-Iguazu-QSIG: v=2; s=0; t=1729070517; q=2rWgO3UeIOptYH2MiI; m=+NNF/1Z/awk1aCmrD9LSgbn+Q1A5ZEvAqYYheHqgI3k=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 49G9Lupo013598
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 18:21:56 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2] mm: numa_clear_kernel_node_hotplug: Add NUMA_NO_NODE check for node id
Date: Wed, 16 Oct 2024 18:21:01 +0900
X-TSB-HOP2: ON
Message-Id: <1729070461-13576-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The acquired memory blocks for reserved may include blocks outside of
memory management. In this case, the nid variable is set to NUMA_NO_NODE
(-1), so an error occurs in node_set().
This adds a check using numa_valid_node() to numa_clear_kernel_node_hotplug()
that skips node_set() when nid is set to NUMA_NO_NODE.

Fixes: 87482708210f ("mm: introduce numa_memblks")
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Suggested-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 mm/numa_memblks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2:
  - Use numa_valid_node() instead of check.
  - Add Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
  - Update description.
  - Drop RFC from subject.

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index be52b93a9c58..a3877e9bc878 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -349,7 +349,7 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	for_each_reserved_mem_region(mb_region) {
 		int nid = memblock_get_region_node(mb_region);
 
-		if (nid != MAX_NUMNODES)
+		if (numa_valid_node(nid))
 			node_set(nid, reserved_nodemask);
 	}
 
-- 
2.45.2



