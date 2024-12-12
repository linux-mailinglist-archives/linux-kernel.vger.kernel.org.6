Return-Path: <linux-kernel+bounces-442345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17999EDB62
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600562832A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5D51F8687;
	Wed, 11 Dec 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1umiCUIJ"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896291F37A7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959692; cv=none; b=qcnMzV9ZIQEj5dQNl5BvtJDYbR+XlR9cOZB+pPVtefm15QJ2GiGfCIkxqvl21jkhT85SOSUWkTbC3hvF9nKz9ZMj0bun7iyj/o4HluNoG5SqQw8AUvGeo/Us1h86jkFrU/aJE3/eYQ26eR/2tUgDsBRe07plRqMZb3YfHFxsqMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959692; c=relaxed/simple;
	bh=OABjfOtbfmCcY7qx3gEUORn5iMVfTmN9C0DEpRCjQaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gF17NEREcv0aLBwwJmqnAtnCD6YwiFQ63An2b2XDDvSuGclv06Z7101El+mmMqiXTxs/Z83zqN0wZ19pYTvgQXKyqLG3zYDEHqCezygr1PeVImuxyjd5e3xdNet1ZkFLdNsfiEOPaaCMlX1G/tbaKkubTdxPFvGnHv08lhQuX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1umiCUIJ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725e3c6ad0dso46299b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 15:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959689; x=1734564489; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=My9IlOPq9ns5P/NZxzKqYlKU2U5PkE8SqDXKTXIHc1k=;
        b=1umiCUIJXXrwMzFakb0c0O/Owq7AyGBooM89qAg+AulPQYCTi3UxU3Zsya7zhx4eor
         LzieFlxrxhi+XKfVc59cl+B6h245L5CLopdq//H4KdlJ09V2OLMxyHx5c8aXtDrz7Z4X
         ixx4SRKQ77wHrBKXVuXkGS+f44de91rrIPRmK/YmMSxFzSr7dvcfDkVAzWPQifDqPJBO
         zybFPRDoYiVX7plxkIEDaUI8lg0qBFHj/pkzzQFgH5CiryyoEKugYePbhDcmPfHXt6ss
         UCZ6A3IdJOanzEXEceVpXcaWHRf0asu4bpAayHMaWxZZaQ2dGiZrpFpo7RSQZrwVqEOh
         Ndkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959689; x=1734564489;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=My9IlOPq9ns5P/NZxzKqYlKU2U5PkE8SqDXKTXIHc1k=;
        b=lk1ixSLG38Ls897U/B5CU5PA1E88LFoQYObNbrXgIK4ShRODRWKxL22/IbmQ1oou0j
         fz3WlDKdHkIDTCxTGw+XMWc+kUQv8uui/2TdRWoDA50uXgCoDZmGHPdCFv3jOtw0bZ7W
         HZ7xxli/H5R/yp2+ioGYfeByQgjdASLUcWUIIoMTars8jj0GWqhRYYL4WA5aXRNpkQUK
         ZPnQeVhnWU6cz3UsPB9QEteNcO50tlbcUDscpzhjXdkakc6NHgD+6iBGZ68HEZbeo66w
         o0BsXh4t4BnVLTzMJi4DD5yvgBTuwVI+gdbPwZwBr9KnrfKhFyNlaBj9ytX5XoexDJOE
         W06w==
X-Forwarded-Encrypted: i=1; AJvYcCWxEIok0CfvQbV/HdUCRTruOfnyQGWo/CFBaftMRa4oy/U4ule8FKFzTWh5Qn/iGVizAU17rzab01l5vMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQOiqrslUI5S4EXwfdF6hDPrxX5mFmpEJDQkhOqp4kJLjQpZq
	XVyxQVTicUT9E0CUW+1yHpQo8bs1zuiWwGwRgtOXFFZjauAAW3Bua8PgmSNvpUkre7TfpsIKvv1
	2GEkoro5eiXW70v+jUHtmDw==
X-Google-Smtp-Source: AGHT+IHgv+hz6lUV53h1smjsDXGUMrAdu+yMyNI0Y1qN6skLJAQw6jBsC8TmY8m6/oNaMxzzcfOLndyqCxWrzR4uSQ==
X-Received: from pgbee13.prod.google.com ([2002:a05:6a02:458d:b0:7fd:4d08:df94])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7890:b0:1db:e40d:5f89 with SMTP id adf61e73a8af0-1e1cebb5277mr1761320637.28.1733959689528;
 Wed, 11 Dec 2024 15:28:09 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:44 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-7-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 06/16] mm: csky: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce csky arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate error handling in arch_mmap_hint().

 arch/csky/abiv1/inc/abi/pgtable-bits.h |  1 +
 arch/csky/abiv1/mmap.c                 | 68 ++++++++++++++------------
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index ae7a2f76dd42..c346a9fcb522 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -51,5 +51,6 @@
 					((offset) << 10)})
 
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index 1047865e82a9..0c5c51a081e4 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -13,6 +13,39 @@
 	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
 	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	bool do_align;
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+
+	/*
+	 * We only need to do colour alignment if either the I or D
+	 * caches alias.
+	 */
+	do_align = filp || (flags & MAP_SHARED);
+
+	/*
+	 * We enforce the MAP_FIXED case.
+	 */
+	if (flags & MAP_FIXED) {
+		if (flags & MAP_SHARED &&
+		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (do_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 /*
  * We need to ensure that shared mappings are correctly aligned to
  * avoid aliasing issues with VIPT caches.  We need to ensure that
@@ -27,8 +60,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	int do_align = 0;
+	bool do_align;
 	struct vm_unmapped_area_info info = {
 		.length = len,
 		.low_limit = mm->mmap_base,
@@ -36,37 +68,11 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		.align_offset = pgoff << PAGE_SHIFT
 	};
 
-	/*
-	 * We only need to do colour alignment if either the I or D
-	 * caches alias.
-	 */
-	do_align = filp || (flags & MAP_SHARED);
-
-	/*
-	 * We enforce the MAP_FIXED case.
-	 */
-	if (flags & MAP_FIXED) {
-		if (flags & MAP_SHARED &&
-		    (addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1))
-			return -EINVAL;
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
 		return addr;
-	}
-
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	if (addr) {
-		if (do_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
 
+	do_align = filp || (flags & MAP_SHARED);
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
 	return vm_unmapped_area(&info);
 }
-- 
2.47.0.338.g60cca15819-goog


