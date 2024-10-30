Return-Path: <linux-kernel+bounces-388302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1C69B5D68
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E68284257
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AC81E0DCE;
	Wed, 30 Oct 2024 08:11:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7331E0DAA;
	Wed, 30 Oct 2024 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275890; cv=none; b=QTcNGNqIt+2069lJAHc83Sk92nWdYU2/hapsIk15Ep70HTrt3L0YIy4lomzeMrnWs+0KBdawsuCcueNugdNLCUILWDB4dn2RlpWlMQ32nGj5bQ4J9zzBJa8V7R7Thu8IsYZVw9iPLkGvMex7/3SN5cv82vI+Rte/6GuC1jqjTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275890; c=relaxed/simple;
	bh=XhV9UrwVIGvAFbIzChNXqwcg7YBkeK9gDdCl5wro+jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYJXNikIELwsNG66HiG5KXM7mNy+N0pjfvLUhQPpC2rhq96lRT84W/d3zQDVzbz8+BSv0nI7V8490rvqV7iIwae7GfyRf7EexmqAQD3DxM6vp4P/EEcdvpJ68EfZZ6u6eEny9OtHG0H6NsRQCpOHnNcIbfe/FtAV+eiq39xSDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D1AC4CEE4;
	Wed, 30 Oct 2024 08:11:27 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Disable KASAN if PGDIR_SIZE is too large for cpu_vabits
Date: Wed, 30 Oct 2024 16:11:10 +0800
Message-ID: <20241030081110.3431220-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
overflow UINTPTR_MAX because KASAN_SHADOW_START/KASAN_SHADOW_END are
aligned up by PGDIR_SIZE. And then the overflowed KASAN_SHADOW_END looks
like a user space address.

For example, PGDIR_SIZE of CONFIG_4KB_4LEVEL is 2^39, which is too large
for Loongson-2K series whose cpu_vabits = 39.

Since CONFIG_4KB_4LEVEL is completely legal for CPUs with cpu_vabits <=
39, we just disable KASAN via early return in kasan_init(). Otherwise we
get a boot failure.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/mm/kasan_init.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 4a0d1880dd71..6bdcc8751d4e 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -262,6 +262,17 @@ void __init kasan_init(void)
 	u64 i;
 	phys_addr_t pa_start, pa_end;
 
+	/*
+	 * If PGDIR_SIZE is too large for cpu_vabits, KASAN_SHADOW_END will
+	 * overflow UINTPTR_MAX and then looks like a user space address.
+	 * For example, PGDIR_SIZE of CONFIG_4KB_4LEVEL is 2^39, which is too
+	 * large for Loongson-2K series whose cpu_vabits = 39.
+	 */
+	if (KASAN_SHADOW_END < vm_map_base) {
+		pr_warn("PGDIR_SIZE too large for cpu_vabits, KernelAddressSanitizer disabled.\n");
+		return;
+	}
+
 	/*
 	 * PGD was populated as invalid_pmd_table or invalid_pud_table
 	 * in pagetable_init() which depends on how many levels of page
-- 
2.43.5


