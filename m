Return-Path: <linux-kernel+bounces-240504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB2926E61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 06:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC25E1F23E88
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 04:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4300013CFAA;
	Thu,  4 Jul 2024 04:32:10 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47F413C8FE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 04:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720067529; cv=none; b=KlTlWwrnf/rDQhM1xpPBGB+lbkwMvrsXo9FMUEzbOHJ6+ikYFZ3rZpaFkx2azVOfw8wdrRw202rgPDw9Okf/j+9P2pjOrCKZ8Jj3XzGP6Lyl2qQTMhe0HL+8iLVl78Ebn7uSr9FsISg9Um6h8lKUSh/B5y3uXd4Fkfk2Jef+at0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720067529; c=relaxed/simple;
	bh=Y2eKlpTRqw2tQSuejatAyQ/lGCV+ROCKXY1uSbuxfuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bP2qiV1UpbL2IrRU6EsX4laQGm4apAhD7oB69chWx9eb63jcVs+mhI+SU1ctPlpxoFYH6nxVwWR7vJ71IqHmkqMx/nxhFm+k1mr10zSi+p0Ti6tuYfiThAG3vc12sY3HKozwnVJSbGT4dnxWH+CGQ0AfOWfvLQvFbaZyP4a63/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2DFBF1FCF9;
	Thu,  4 Jul 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC78E13889;
	Thu,  4 Jul 2024 04:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MJ1iNMQlhmbnDAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 04 Jul 2024 04:32:04 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	SeongJae Park <sj@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 13/45] mm: Implement pud-version uffd functions
Date: Thu,  4 Jul 2024 06:31:00 +0200
Message-ID: <20240704043132.28501-14-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240704043132.28501-1-osalvador@suse.de>
References: <20240704043132.28501-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2DFBF1FCF9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

HugeTLB pages will be handled on pud level as well, so we need to
implement pud-versions of uffd functions in order to properly handle
it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/include/asm/pgtable.h   |   7 ++
 arch/x86/include/asm/pgtable.h     | 158 +++++++++++++++++------------
 include/asm-generic/pgtable_uffd.h |  30 ++++++
 include/linux/pgtable.h            |   5 +
 4 files changed, 136 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index f8efbc128446..936ed3a915a3 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -556,6 +556,9 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
 #define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+#define pud_uffd_wp(pud)	pte_uffd_wp(pud_pte(pud))
+#define pud_mkuffd_wp(pud)	pte_pud(pte_mkuffd_wp(pud_pte(pud)))
+#define pud_clear_uffd_wp(pud)	pte_pud(pte_clear_uffd_wp(pud_pte(pud)))
 #define pmd_uffd_wp(pmd)	pte_uffd_wp(pmd_pte(pmd))
 #define pmd_mkuffd_wp(pmd)	pte_pmd(pte_mkuffd_wp(pmd_pte(pmd)))
 #define pmd_clear_uffd_wp(pmd)	pte_pmd(pte_clear_uffd_wp(pmd_pte(pmd)))
@@ -563,6 +566,10 @@ static inline int pmd_trans_huge(pmd_t pmd)
 #define pmd_swp_mkuffd_wp(pmd)	pte_pmd(pte_swp_mkuffd_wp(pmd_pte(pmd)))
 #define pmd_swp_clear_uffd_wp(pmd) \
 				pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)))
+#define pud_swp_uffd_wp(pud)	pte_swp_uffd_wp(pud_pte(pud))
+#define pud_swp_mkuffd_wp(pud)	pte_pud(pte_swp_mkuffd_wp(pud_pte(pud)))
+#define pud_swp_clear_uffd_wp(pud) \
+				pte_pud(pte_swp_clear_uffd_wp(pud_pte(pud)))
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 772f778bac06..640edc31962f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -512,70 +512,6 @@ static inline pmd_t pmd_wrprotect(pmd_t pmd)
 	return pmd_mksaveddirty(pmd);
 }
 
-#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-static inline int pmd_uffd_wp(pmd_t pmd)
-{
-	return pmd_flags(pmd) & _PAGE_UFFD_WP;
-}
-
-static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
-{
-	return pmd_wrprotect(pmd_set_flags(pmd, _PAGE_UFFD_WP));
-}
-
-static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
-{
-	return pmd_clear_flags(pmd, _PAGE_UFFD_WP);
-}
-#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
-
-static inline pmd_t pmd_mkold(pmd_t pmd)
-{
-	return pmd_clear_flags(pmd, _PAGE_ACCESSED);
-}
-
-static inline pmd_t pmd_mkclean(pmd_t pmd)
-{
-	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
-}
-
-static inline pmd_t pmd_mkdirty(pmd_t pmd)
-{
-	pmd = pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
-
-	return pmd_mksaveddirty(pmd);
-}
-
-static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
-{
-	pmd = pmd_clear_flags(pmd, _PAGE_RW);
-
-	return pmd_set_flags(pmd, _PAGE_DIRTY);
-}
-
-static inline pmd_t pmd_mkdevmap(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_DEVMAP);
-}
-
-static inline pmd_t pmd_mkhuge(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_PSE);
-}
-
-static inline pmd_t pmd_mkyoung(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_ACCESSED);
-}
-
-static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
-{
-	return pmd_set_flags(pmd, _PAGE_RW);
-}
-
-pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
-#define pmd_mkwrite pmd_mkwrite
-
 static inline pud_t pud_set_flags(pud_t pud, pudval_t set)
 {
 	pudval_t v = native_pud_val(pud);
@@ -659,6 +595,85 @@ static inline pud_t pud_mkwrite(pud_t pud)
 	return pud_clear_saveddirty(pud);
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pud_uffd_wp(pud_t pud)
+{
+	return pud_flags(pud) & _PAGE_UFFD_WP;
+}
+
+static inline pud_t pud_mkuffd_wp(pud_t pud)
+{
+	return pud_wrprotect(pud_set_flags(pud, _PAGE_UFFD_WP));
+}
+
+static inline pud_t pud_clear_uffd_wp(pud_t pud)
+{
+	return pud_clear_flags(pud, _PAGE_UFFD_WP);
+}
+
+static inline int pmd_uffd_wp(pmd_t pmd)
+{
+	return pmd_flags(pmd) & _PAGE_UFFD_WP;
+}
+
+static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
+{
+	return pmd_wrprotect(pmd_set_flags(pmd, _PAGE_UFFD_WP));
+}
+
+static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_UFFD_WP);
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
+static inline pmd_t pmd_mkold(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_ACCESSED);
+}
+
+static inline pmd_t pmd_mkclean(pmd_t pmd)
+{
+	return pmd_clear_flags(pmd, _PAGE_DIRTY_BITS);
+}
+
+static inline pmd_t pmd_mkdirty(pmd_t pmd)
+{
+	pmd = pmd_set_flags(pmd, _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+
+	return pmd_mksaveddirty(pmd);
+}
+
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pmd)
+{
+	pmd = pmd_clear_flags(pmd, _PAGE_RW);
+
+	return pmd_set_flags(pmd, _PAGE_DIRTY);
+}
+
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_DEVMAP);
+}
+
+static inline pmd_t pmd_mkhuge(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_PSE);
+}
+
+static inline pmd_t pmd_mkyoung(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_ACCESSED);
+}
+
+static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_RW);
+}
+
+pmd_t pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
+#define pmd_mkwrite pmd_mkwrite
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline int pte_soft_dirty(pte_t pte)
 {
@@ -1574,6 +1589,21 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 {
 	return pmd_clear_flags(pmd, _PAGE_SWP_UFFD_WP);
 }
+
+static inline pud_t pud_swp_mkuffd_wp(pud_t pud)
+{
+	return pud_set_flags(pud, _PAGE_SWP_UFFD_WP);
+}
+
+static inline int pud_swp_uffd_wp(pud_t pud)
+{
+	return pud_flags(pud) & _PAGE_SWP_UFFD_WP;
+}
+
+static inline pud_t pud_swp_clear_uffd_wp(pud_t pud)
+{
+	return pud_clear_flags(pud, _PAGE_SWP_UFFD_WP);
+}
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
index 828966d4c281..453118eb2161 100644
--- a/include/asm-generic/pgtable_uffd.h
+++ b/include/asm-generic/pgtable_uffd.h
@@ -12,6 +12,11 @@ static __always_inline int pmd_uffd_wp(pmd_t pmd)
 	return 0;
 }
 
+static __always_inline int pud_uffd_wp(pud_t pud)
+{
+	return 0;
+}
+
 static __always_inline pte_t pte_mkuffd_wp(pte_t pte)
 {
 	return pte;
@@ -22,6 +27,11 @@ static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
 	return pmd;
 }
 
+static __always_inline pud_t pud_mkuffd_wp(pud_t pud)
+{
+	return pmd;
+}
+
 static __always_inline pte_t pte_clear_uffd_wp(pte_t pte)
 {
 	return pte;
@@ -32,6 +42,11 @@ static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
 	return pmd;
 }
 
+static __always_inline pud_t pud_clear_uffd_wp(pud_t pud)
+{
+	return pmd;
+}
+
 static __always_inline pte_t pte_swp_mkuffd_wp(pte_t pte)
 {
 	return pte;
@@ -61,6 +76,21 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 {
 	return pmd;
 }
+
+static inline pud_t pud_swp_mkuffd_wp(pud_t pud)
+{
+	return pud;
+}
+
+static inline int pud_swp_uffd_wp(pud_t pud)
+{
+	return 0;
+}
+
+static inline pud_t pud_swp_clear_uffd_wp(pud_t pud)
+{
+	return pud;
+}
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
 #endif /* _ASM_GENERIC_PGTABLE_UFFD_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 991137dab87e..a2e2ebb93f21 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1433,6 +1433,11 @@ static inline int pmd_soft_dirty(pmd_t pmd)
 	return 0;
 }
 
+static inline int pud_soft_dirty(pud_t pud)
+{
+	return 0;
+}
+
 static inline pte_t pte_mksoft_dirty(pte_t pte)
 {
 	return pte;
-- 
2.26.2


