Return-Path: <linux-kernel+bounces-282783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245294E887
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB0A1F223B3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018F16C695;
	Mon, 12 Aug 2024 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GxaYRoj1"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6293F16B38D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451176; cv=none; b=MMyxcI5Lfx9uSW6wOKls/GO0QbMeN85rW31HK+CNNE5/Ca/XjyJaU8Ie8x7TETGRG2ClBbm1XR1xYkzawJm6rcy+I+oE0BfCvFsGZ6OuXhekoT/jKPcoybhZQxRefd6WFnG652Eb8RHgxIGMGYacFABHdLd7yXcKyNS36p/rBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451176; c=relaxed/simple;
	bh=2yiG1YmnNycpGMG0/npUNTghkT7avueXJwST+O2pm3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBN2io26MNCkpy2VX7flWaTflr3toDx4+HzCx/L2WpZf5no4gOW1kiyCTxq21JA7Ns8/eAwgdf1MJd+O8lDcshBwQRgf1jy6lA8zzp+8UW/ljVUH2v9br5ClUxn+hUv23hFxK1bCELJF0Ypc2fQbBgLPCnN/GLxBerFklptex6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=GxaYRoj1; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723451172;
	bh=pcjuiNWGJBthoyZQ3qFWTiFyzLganh8gT8cFhrjWhRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GxaYRoj1O/6aMLky2vBn7var5Mtg8nUn123C1LWdhey7cpaSrl22XRNgO3S74rjOT
	 ZVdnqLzZpTrwc5zGQPLVlpOLrV5GY8SC9oNSfrz6d6o5hXos8HivWGEF5KH8y5yQ4H
	 GgVBKrX93hPoPl2fq849JAdVmKJBjG7vY6KadJcvD56pHe4eEttCoqzO5swg8CnXL0
	 ci2cttEjTH/LdvJLKjKx1S5N8dD1O7LZL/N4R3yoAvnR2ZhhqRe4tMosg/0GMwVeGR
	 0w54rRaOGgz1DilunTkuNlHaC9cVrV+nI3hApdE0h+e32H+p10/bHiY7vuGu4w/lrR
	 b5pZFaVZL6dVg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wj6zm3CHMz4x92;
	Mon, 12 Aug 2024 18:26:12 +1000 (AEST)
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
Subject: [PATCH v2 4/4] powerpc/vdso: Refactor error handling
Date: Mon, 12 Aug 2024 18:26:05 +1000
Message-ID: <20240812082605.743814-4-mpe@ellerman.id.au>
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

Linus noticed that the error handling in __arch_setup_additional_pages()
fails to clear the mm VDSO pointer if _install_special_mapping()
fails. In practice there should be no actual bug, because if there's an
error the VDSO pointer is cleared later in arch_setup_additional_pages().

However it's no longer necessary to set the pointer before installing
the mapping. Commit c1bab64360e6 ("powerpc/vdso: Move to
_install_special_mapping() and remove arch_vma_name()") reworked the
code so that the VMA name comes from the vm_special_mapping.name, rather
than relying on arch_vma_name().

So rework the code to only set the VDSO pointer once the mappings have
been installed correctly, and remove the stale comment.

Depends-on: c1bab64360e6 ("powerpc/vdso: Move to _install_special_mapping() and remove arch_vma_name()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/vdso.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

v2: Unchanged.

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 220a76cae7c1..ee4b9d676cff 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -214,13 +214,6 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	/* Add required alignment. */
 	vdso_base = ALIGN(vdso_base, VDSO_ALIGNMENT);
 
-	/*
-	 * Put vDSO base into mm struct. We need to do this before calling
-	 * install_special_mapping or the perf counter mmap tracking code
-	 * will fail to recognise it as a vDSO.
-	 */
-	mm->context.vdso = (void __user *)vdso_base + vvar_size;
-
 	vma = _install_special_mapping(mm, vdso_base, vvar_size,
 				       VM_READ | VM_MAYREAD | VM_IO |
 				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
@@ -240,10 +233,15 @@ static int __arch_setup_additional_pages(struct linux_binprm *bprm, int uses_int
 	vma = _install_special_mapping(mm, vdso_base + vvar_size, vdso_size,
 				       VM_READ | VM_EXEC | VM_MAYREAD |
 				       VM_MAYWRITE | VM_MAYEXEC, vdso_spec);
-	if (IS_ERR(vma))
+	if (IS_ERR(vma)) {
 		do_munmap(mm, vdso_base, vvar_size, NULL);
+		return PTR_ERR(vma);
+	}
 
-	return PTR_ERR_OR_ZERO(vma);
+	// Now that the mappings are in place, set the mm VDSO pointer
+	mm->context.vdso = (void __user *)vdso_base + vvar_size;
+
+	return 0;
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
@@ -257,8 +255,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	rc = __arch_setup_additional_pages(bprm, uses_interp);
-	if (rc)
-		mm->context.vdso = NULL;
 
 	mmap_write_unlock(mm);
 	return rc;
-- 
2.45.2


