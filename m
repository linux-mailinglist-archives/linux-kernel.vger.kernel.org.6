Return-Path: <linux-kernel+bounces-282782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7894694E886
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAED21C2148A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D1916BE36;
	Mon, 12 Aug 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="fFPHXE1d"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89555896
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451176; cv=none; b=kFRq/FOUMIFnXVqFpT8mZjPvjCLtCwSRLNYjcFjuXOKw7GCKXRY8JHa9w3FhokWtaVg1O/sEbrxk+ua82GJ/FSqIuJzpcPPCpzN9yibKZDqmV0QQCfAmrrJK+HFO7maSNyk7afARioJqLx9Eid63hna59Z2ZglZvYIAYYsl118w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451176; c=relaxed/simple;
	bh=crOHtHdT9cEVC6cLJumkPaCR2CqeRcIZ53w3hQq9vYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR7hNwL6KsqPg0JUeiyh0Y3RrPSpFlPmE/E0TUDGoC6vnQM5vE7A9Gg9pmg6fL7Db8n4DB++PzMRv83BL2eGB+fFSLiUkoEHXfQaf0m/uE2vM+NS2UTlMzOwxon0zvrPfEl5s6Q4t86Rk59RX72D7rk2Vz3/oncGku/AQi2CBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=fFPHXE1d; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723451171;
	bh=90PGWBEPImYbqdKWstTCR2/CnGQLSesaZNbFieveKuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFPHXE1dOvj+bKatKB56csNqaldo10qmfdXwB1reponcEmik+TvrSRPKhatzXSHSx
	 wSbXA5pkgkbvxhDr6zSSvFQvnSDu+1oJErPK+JPOsOUZur2lv/ndnIqPxMc8HyxMjH
	 XN95VVCbSnJRNpFyLmuBWBUzmwADAyxkNtqaWmYpunfu4p5z7Zg0u5fPeMVuH5Hok/
	 mFcKZgybv4Zx8Q8guL83cj7gAwLZmUwBrL9ZzgTi64YSYhfhdZdn+TRgNvBMhtEpRn
	 oUYqRjmf0fWRjTlu2BtTD5vHgOShzNnppXzHKFJvbRd7ZradwBPOHQNgO/ABDbGAKX
	 nKLrIq6sdYBhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wj6zl3y2Sz4x8w;
	Mon, 12 Aug 2024 18:26:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-mm@kvack.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	jeffxu@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	npiggin@gmail.com,
	oliver.sang@intel.com,
	pedro.falcato@gmail.com
Subject: [PATCH v2 2/4] powerpc/mm: Handle VDSO unmapping via close() rather than arch_unmap()
Date: Mon, 12 Aug 2024 18:26:03 +1000
Message-ID: <20240812082605.743814-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812082605.743814-1-mpe@ellerman.id.au>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a close() callback to the VDSO special mapping to handle unmapping
of the VDSO. That will make it possible to remove the arch_unmap() hook
entirely in a subsequent patch.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/include/asm/mmu_context.h |  4 ----
 arch/powerpc/kernel/vdso.c             | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

v2: Unchanged except for collecting tags.

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 37bffa0f7918..9b8c1555744e 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -263,10 +263,6 @@ extern void arch_exit_mmap(struct mm_struct *mm);
 static inline void arch_unmap(struct mm_struct *mm,
 			      unsigned long start, unsigned long end)
 {
-	unsigned long vdso_base = (unsigned long)mm->context.vdso;
-
-	if (start <= vdso_base && vdso_base < end)
-		mm->context.vdso = NULL;
 }
 
 #ifdef CONFIG_PPC_MEM_KEYS
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 7a2ff9010f17..220a76cae7c1 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -81,6 +81,21 @@ static int vdso64_mremap(const struct vm_special_mapping *sm, struct vm_area_str
 	return vdso_mremap(sm, new_vma, &vdso64_end - &vdso64_start);
 }
 
+static void vdso_close(const struct vm_special_mapping *sm, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = vma->vm_mm;
+
+	/*
+	 * close() is called for munmap() but also for mremap(). In the mremap()
+	 * case the vdso pointer has already been updated by the mremap() hook
+	 * above, so it must not be set to NULL here.
+	 */
+	if (vma->vm_start != (unsigned long)mm->context.vdso)
+		return;
+
+	mm->context.vdso = NULL;
+}
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf);
 
@@ -92,11 +107,13 @@ static struct vm_special_mapping vvar_spec __ro_after_init = {
 static struct vm_special_mapping vdso32_spec __ro_after_init = {
 	.name = "[vdso]",
 	.mremap = vdso32_mremap,
+	.close = vdso_close,
 };
 
 static struct vm_special_mapping vdso64_spec __ro_after_init = {
 	.name = "[vdso]",
 	.mremap = vdso64_mremap,
+	.close = vdso_close,
 };
 
 #ifdef CONFIG_TIME_NS
-- 
2.45.2


