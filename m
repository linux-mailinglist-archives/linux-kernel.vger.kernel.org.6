Return-Path: <linux-kernel+bounces-544024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED58A4DC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2900E3A64B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBA1FE471;
	Tue,  4 Mar 2025 11:27:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EAC81EEA36
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087640; cv=none; b=SXGdL+5yrvBiayzuuNTIluPLbhLyjUXQTTDF3GhLEzepKEmNO7nr0kg/K72go8grFyUqmeheDQ5onnvO/6lfxz9uyciOS0agBKsPsJBpIz+Tb0WLZEghKLCoWF0bAjnmQvJvoGTS111JbgR12d6RHxKH/mPF8Uv6YrDXXg36wRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087640; c=relaxed/simple;
	bh=hiIB1N+s1XFxEywNqs8B9ezlzbJTEbWPLwCvwYFYtFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5vjcFyYUfVZaW3vmbUMooXeVlklOByNzaYlt4iLEEgd6VCNBpsA0C+qY8PiCeOG52KCmNjFUxs2OyIqqIx+p7PFzq7RF/1hwJ3t3ypNnsu0YzWvWclo9ER+nKuaOgf1CZhNcE87xkbO/GQhaVT1vYBfcrRvASpjnQ/C6R1e6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Ax3eKM48ZnCwuKAA--.184S3;
	Tue, 04 Mar 2025 19:27:08 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDxH+WM48ZnhII1AA--.2682S2;
	Tue, 04 Mar 2025 19:27:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: mm: Set max_pfn with the PFN of the last page
Date: Tue,  4 Mar 2025 19:27:08 +0800
Message-Id: <20250304112708.1810033-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxH+WM48ZnhII1AA--.2682S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

The current max_pfn equals to zero. In this case, it caused users cannot
get some page information through /proc such as kpagecount. The following
message is displayed by stress-ng test suite with the command
"stress-ng --verbose --physpage 1 -t 1".

 # stress-ng --verbose --physpage 1 -t 1
 stress-ng: error: [1691] physpage: cannot read page count for address 0x134ac000 in /proc/kpagecount, errno=22 (Invalid argument)
 stress-ng: error: [1691] physpage: cannot read page count for address 0x7ffff207c3a8 in /proc/kpagecount, errno=22 (Invalid argument)
 stress-ng: error: [1691] physpage: cannot read page count for address 0x134b0000 in /proc/kpagecount, errno=22 (Invalid argument)
 ...

After applying this patch, the kernel can pass the test.
 # stress-ng --verbose --physpage 1 -t 1
 stress-ng: debug: [1701] physpage: [1701] started (instance 0 on CPU 3)
 stress-ng: debug: [1701] physpage: [1701] exited (instance 0 on CPU 3)
 stress-ng: debug: [1700] physpage: [1701] terminated (success)

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/numa.c  | 2 +-
 arch/loongarch/kernel/setup.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 84fe7f854820..002dbe62b329 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -356,7 +356,7 @@ int __init init_numa_memory(void)
 		node_mem_init(node);
 		node_set_online(node);
 	}
-	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
+	max_low_pfn = max_pfn = PHYS_PFN(memblock_end_of_DRAM());
 
 	setup_nr_node_ids();
 	loongson_sysconf.nr_nodes = nr_node_ids;
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index edcfdfcad7d2..ab8c9336d8f5 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -294,7 +294,7 @@ static void __init fdt_setup(void)
 	early_init_dt_scan(fdt_pointer, __pa(fdt_pointer));
 	early_init_fdt_reserve_self();
 
-	max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());
+	max_low_pfn = max_pfn = PFN_PHYS(memblock_end_of_DRAM());
 #endif
 }
 
-- 
2.39.3


