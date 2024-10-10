Return-Path: <linux-kernel+bounces-358211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C0997B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009781F245A9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A924192D9C;
	Thu, 10 Oct 2024 03:50:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C991714AC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532254; cv=none; b=OvYs1Wp0qsHUufcjKxFc3LW8cgrRmXuZTOoQecMlVXQ5BzHINVjpcNyHaI0yvG6RaejiILGY+jLt78AXzgczL7fhtdyCxzgKGXekQxX9EuZ19cJXMh2tR1pnbwXxwqy28vqHpiQB+UExua/gSRKJ/gDJ2DgvEH/keX5C2oBCSpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532254; c=relaxed/simple;
	bh=Qkbz+z4hukSRfHCBvlzyQN6Lp+Oa2mzck/NCLGqgku8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7fP+B7QO9mH9rznmgU0nrmEDpndoqtYGyNNxfDQ8uughFlxtB9UEbyNjWK6OWFofTPCvfccpZ2T2uHSCq2OhLthl8cLZZ+3e5b1wjSOFKfiOc7PFKDK5bV+LmHTvvxjTpcvPs9PNwI4n7/K4pjbucPKLe4c3rFKWFk96N+eF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx67IbTwdn17sRAA--.26403S3;
	Thu, 10 Oct 2024 11:50:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDx7tUZTwdnFP8hAA--.52915S4;
	Thu, 10 Oct 2024 11:50:50 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/sparse-vmemmap: set pte_init when vmemmap is created
Date: Thu, 10 Oct 2024 11:50:46 +0800
Message-Id: <20241010035048.3422527-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241010035048.3422527-1-maobibo@loongson.cn>
References: <20241010035048.3422527-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx7tUZTwdnFP8hAA--.52915S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Like pmd_init(), a weak function kernel_pte_init() is added and it
is only effective on LoongArch system. When pte table is created for
vmemmap kernel space, function kernel_pte_init() is called here.

It has no any effective on other architectures.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 mm/sparse-vmemmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index edcc7a6b0f6f..c0388b2e959d 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -184,6 +184,10 @@ static void * __meminit vmemmap_alloc_block_zero(unsigned long size, int node)
 	return p;
 }
 
+void __weak __meminit kernel_pte_init(void *addr)
+{
+}
+
 pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
@@ -191,6 +195,7 @@ pmd_t * __meminit vmemmap_pmd_populate(pud_t *pud, unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
+		kernel_pte_init(p);
 		pmd_populate_kernel(&init_mm, pmd, p);
 	}
 	return pmd;
-- 
2.39.3


