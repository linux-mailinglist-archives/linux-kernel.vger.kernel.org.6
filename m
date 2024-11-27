Return-Path: <linux-kernel+bounces-423841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1608D9DAD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A261663AA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FBE201278;
	Wed, 27 Nov 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hwA8++2g"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07113D508
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734246; cv=none; b=c6kZLY7G4k0e6I1FHp0tsUPHjjQZuISTO4Uuw5armSVK6NYRqR7ObuiKL6iGLNTXzOROs1z4HGCmpluevp8rdghwAanvktR3RRj5iuWfJoHO2gLMI8d4OEAvj/bdfsxCAXr2W0x/qPjlUellq06SOrfJl756sn3TrgrwEWNgi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734246; c=relaxed/simple;
	bh=YJXrns6qDSqiRjj29QGazSPtjrIYWURjaZhzu/au2Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub0W4DMSu/6jfC0zkHrrwlCgg/7ZJ8a82WNGcF/jy9aUjvGDNQtLhqYwBxRHUw2SjJKBEsnVsNJ59jxNLkqE6bcdXOdDiKat3hmZEe+qIQdxW012H6Fl2hlHIEeITkZeHwhXikCrjg7+rYs5H5QIMPokibkhggxKcbh6dwQjhXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hwA8++2g; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3+iHS09x/bUbYczSnY4CdvRzG4X74WBD5o3VDFQQU2k=; b=hwA8++2g3fZuKG6TcF6+2Z8MXR
	vv1srmp07bw1OZBEmjW7Nyr999NAwYCUCnBgDbKLTc47bA6aMV6nYY66kYP/E6YX5OktmHI8d9+2M
	ylzFzpUUlQMsmPpOo5VuK1/W/gHWLtDZ71xcC1aZwmdsSZvnYKsNM/4kyces0cIZhgcZ0/8R4smES
	AYvF/9fSPjO+/xXh0XV01Pv8TpinHEuBzZIZVupR2ZVfLTQGOzQNa/podDMGBjImaHGQ1hzwYJ7Cv
	n/iDPvNfHCONX2ddihN7KZ+VeOB2Lx1EpKxp5Cp8bQr24l96y0WyqCNNXc5S8ItYHFmp2x3wf/CZL
	ZoVwJzgA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKF-00000001Sue-188L;
	Wed, 27 Nov 2024 19:03:47 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000BiQ-0B6E;
	Wed, 27 Nov 2024 19:03:46 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v4 05/20] x86/mm: Add _PAGE_NOPTISHADOW bit to avoid updating userspace page tables
Date: Wed, 27 Nov 2024 19:00:19 +0000
Message-ID: <20241127190343.44916-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The set_p4d() and set_pgd() functions (in 4-level or 5-level page table setups
respectively) assume that the root page table is actually a 8KiB allocation,
with the userspace root immediately after the kernel root page table (so that
the former can enforce NX on on all the subordinate pages, which are actually
shared).

However, users of the kernel_ident_mapping_init() code do not give it an 8KiB
allocation for its PGD. Both swsusp_arch_resume() and acpi_mp_setup_reset()
allocate only a single 4KiB page. The kexec code on x86_64 currently gets
away with it purely by chance, because it allocates 8KiB for its "control
code page" and then actually uses the first half for the PGD, then copies the
actual trampoline code into the second half only after the identmap code has
finished scribbling over it.

Fix this by defining a _PAGE_NOPTISHADOW bit (which can use the same bit as
_PAGE_SAVED_DIRTY since one is only for the PGD/P4D root and the other is
exclusively for leaf PTEs.). This instructs __pti_set_user_pgtbl() not to
write to the userspace 'shadow' PGD.

Strictly, the _PAGE_NOPTISHADOW bit doesn't need to be written out to the
actual page tables; since __pti_set_user_pgtbl() returns the value to be
written to the kernel page table, it could be filtered out. But there seems
to be no benefit to actually doing so.

Cc: stable@kernel.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/pgtable_types.h | 8 ++++++--
 arch/x86/mm/ident_map.c              | 6 +++---
 arch/x86/mm/pti.c                    | 2 +-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 6f82e75b6149..4b804531b03c 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -36,10 +36,12 @@
 #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
 
 #ifdef CONFIG_X86_64
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW5 /* Saved Dirty bit (leaf) */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW5 /* No PTI shadow (root PGD) */
 #else
 /* Shared with _PAGE_BIT_UFFD_WP which is not supported on 32 bit */
-#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit */
+#define _PAGE_BIT_SAVED_DIRTY	_PAGE_BIT_SOFTW2 /* Saved Dirty bit (leaf) */
+#define _PAGE_BIT_NOPTISHADOW	_PAGE_BIT_SOFTW2 /* No PTI shadow (root PGD) */
 #endif
 
 /* If _PAGE_BIT_PRESENT is clear, we use these: */
@@ -139,6 +141,8 @@
 
 #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
 
+#define _PAGE_NOPTISHADOW (_AT(pteval_t, 1) << _PAGE_BIT_NOPTISHADOW)
+
 /*
  * Set of bits not changed in pte_modify.  The pte's
  * protection key is treated like _PAGE_RW, for
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 437e96fb4977..5ab7bd2f1983 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -174,7 +174,7 @@ static int ident_p4d_init(struct x86_mapping_info *info, p4d_t *p4d_page,
 		if (result)
 			return result;
 
-		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag));
+		set_p4d(p4d, __p4d(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 	}
 
 	return 0;
@@ -218,14 +218,14 @@ int kernel_ident_mapping_init(struct x86_mapping_info *info, pgd_t *pgd_page,
 		if (result)
 			return result;
 		if (pgtable_l5_enabled()) {
-			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(p4d) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		} else {
 			/*
 			 * With p4d folded, pgd is equal to p4d.
 			 * The pgd entry has to point to the pud page table in this case.
 			 */
 			pud_t *pud = pud_offset(p4d, 0);
-			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag));
+			set_pgd(pgd, __pgd(__pa(pud) | info->kernpg_flag | _PAGE_NOPTISHADOW));
 		}
 	}
 
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 851ec8f1363a..5f0d579932c6 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -132,7 +132,7 @@ pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
 	 * Top-level entries added to init_mm's usermode pgd after boot
 	 * will not be automatically propagated to other mms.
 	 */
-	if (!pgdp_maps_userspace(pgdp))
+	if (!pgdp_maps_userspace(pgdp) || (pgd.pgd & _PAGE_NOPTISHADOW))
 		return pgd;
 
 	/*
-- 
2.47.0


