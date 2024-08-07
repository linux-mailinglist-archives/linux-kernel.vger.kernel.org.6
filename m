Return-Path: <linux-kernel+bounces-277904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495094A7ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF111F25D6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 12:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15AA1E7A3B;
	Wed,  7 Aug 2024 12:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Sg2C5rmU"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A711E6741
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034482; cv=none; b=bILkAXUe/H/9WcLWa5DZwlOFvcsieXf/8gYyeXa0MsXuG2jwNSXyc+pQnm264b6GFmbUh2gxeuqr1bvdiTmL0os9yMtNLeQtVnE4hfohdiQrlQXqKIfjw33CEXck2ZZsLutHXzhYOMia6P4DvMFieH/wOpw4XvSJY0IWi+TI71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034482; c=relaxed/simple;
	bh=KZOBwXMeTqYf9uEvqEpZvSolFwFcgHme74bk/4UkW6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3euobNEBDDCL9FVhkUHIr+AN3/VjjEFTutTbBo5yTOtDFcHb6kDXo8qnFR5iatZ1WTaeUGFrZyRXKqH5XuW2D9JVXKpfjTJnoxuBG723NRrv1wIPrDJiFd3B/X5OpiOf1mOlNd6asG6fdxLsX29Bc+TcSuPai6Wo3vKiVcOSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Sg2C5rmU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1723034478;
	bh=1aE2cbYKmjRRZKMb9FZa+Csx+YG7mtBDoiTvd1y2/SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sg2C5rmUsrFsqB+/CRJzTHnIP6xmWqhy/9TubY/RNKmKWWeTjgP+vaVt67AVzTZPf
	 iklksF8ozO1/pUEUnPh6yFOQ4I327udvpjuydImzJBygfquHjGxbehs4uMchmZHUFm
	 0A9i79ZQEyuCRkIwT5WeWMAzz03crWZEzk16n0H60TH6qjJrY5K15pdSvTt+F5/eSt
	 fgUAcvAO+iARo6Uob3f7RgSar6DyTvksewkHZlS4FkNuFQbMKDMRLhE9EBtKH1pqzy
	 Rx530mNH5cy0e7Ie65ib9m58MUjUmJ+UtOPA1ZtZU7aZ4hpc3sM4Gl4wURb8d+1XoK
	 5kyXGW/QLTpDg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Wf8tQ3Cp8z4x3J;
	Wed,  7 Aug 2024 22:41:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linux-mm@kvack.org>
Cc: <linuxppc-dev@lists.ozlabs.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	christophe.leroy@csgroup.eu,
	jeffxu@chromium.org,
	jeffxu@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	npiggin@gmail.com,
	oliver.sang@intel.com,
	pedro.falcato@gmail.com
Subject: [PATCH 4/4] powerpc/vdso: Refactor error handling
Date: Wed,  7 Aug 2024 22:41:03 +1000
Message-ID: <20240807124103.85644-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807124103.85644-1-mpe@ellerman.id.au>
References: <20240807124103.85644-1-mpe@ellerman.id.au>
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


