Return-Path: <linux-kernel+bounces-247348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232A492CE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4825B24240
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C218FC61;
	Wed, 10 Jul 2024 09:37:32 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985817FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604252; cv=none; b=ipFzEvilTScx+BgQRbdJ1KxHcFzN5hbGyodGxvyjhlRynrtf5rKeLJib0puJsbkQ1vYtOuWi+3bHi0FBtqsZPgh3cNC/IWZm6eEnuslrGrW0P7BI6C6PE7k68tWGrTp6hdu9xG6vKEO536gLSnoq4ULXfEc0pCqyQHQ/tOOR8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604252; c=relaxed/simple;
	bh=d2IbN8qp2Srs2dL9JK0P+HCSHjt36Ahx9DAmJrnDBpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2loygUoLPLTJ5vlPYrPHteHwywqv+07eDiTGvmZh1BmIr0AyrOBioXopTox4Hdrh+wVW+pZlG/gQW6h17DphVeshsMy47bUf35KJWXnIKhQe/7Lpu9deHGZr0B/O7uNOqQ+uXwmkLByk9+6v+SQDVgTmvLcSB+9Ktt+ufpmLXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43C6121AC7;
	Wed, 10 Jul 2024 09:37:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD3B2137D2;
	Wed, 10 Jul 2024 09:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BRWFNFdWjmabWwAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 10 Jul 2024 09:37:27 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	xen-devel@lists.xenproject.org
Subject: [PATCH 1/2] x86/xen: make some functions static
Date: Wed, 10 Jul 2024 11:37:17 +0200
Message-ID: <20240710093718.14552-2-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710093718.14552-1-jgross@suse.com>
References: <20240710093718.14552-1-jgross@suse.com>
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
X-Rspamd-Queue-Id: 43C6121AC7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Some functions and variables in arch/x86/xen are used locally only,
make them static.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/mmu.h     |  4 ----
 arch/x86/xen/mmu_pv.c  | 11 ++++++-----
 arch/x86/xen/xen-ops.h |  1 -
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/xen/mmu.h b/arch/x86/xen/mmu.h
index 6e4c6bd62203..11fa577af6b4 100644
--- a/arch/x86/xen/mmu.h
+++ b/arch/x86/xen/mmu.h
@@ -17,10 +17,6 @@ bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn);
 
 void set_pte_mfn(unsigned long vaddr, unsigned long pfn, pgprot_t flags);
 
-pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
-void  xen_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
-				  pte_t *ptep, pte_t pte);
-
 unsigned long xen_read_cr2_direct(void);
 
 extern void xen_init_mmu_ops(void);
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 54e0d311dcc9..8924129e284c 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -128,7 +128,7 @@ static DEFINE_SPINLOCK(xen_reservation_lock);
  * looking at another vcpu's cr3 value, it should use this variable.
  */
 DEFINE_PER_CPU(unsigned long, xen_cr3);	 /* cr3 stored as physaddr */
-DEFINE_PER_CPU(unsigned long, xen_current_cr3);	 /* actual vcpu cr3 */
+static DEFINE_PER_CPU(unsigned long, xen_current_cr3);	/* actual vcpu cr3 */
 
 static phys_addr_t xen_pt_base, xen_pt_size __initdata;
 
@@ -305,16 +305,17 @@ static void xen_set_pte(pte_t *ptep, pte_t pteval)
 	__xen_set_pte(ptep, pteval);
 }
 
-pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma,
-				 unsigned long addr, pte_t *ptep)
+static pte_t xen_ptep_modify_prot_start(struct vm_area_struct *vma,
+					unsigned long addr, pte_t *ptep)
 {
 	/* Just return the pte as-is.  We preserve the bits on commit */
 	trace_xen_mmu_ptep_modify_prot_start(vma->vm_mm, addr, ptep, *ptep);
 	return *ptep;
 }
 
-void xen_ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
-				 pte_t *ptep, pte_t pte)
+static void xen_ptep_modify_prot_commit(struct vm_area_struct *vma,
+					unsigned long addr,
+					pte_t *ptep, pte_t pte)
 {
 	struct mmu_update u;
 
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 79cf93f2c92f..9f29229e25b8 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -23,7 +23,6 @@ void xen_copy_trap_info(struct trap_info *traps);
 
 DECLARE_PER_CPU_ALIGNED(struct vcpu_info, xen_vcpu_info);
 DECLARE_PER_CPU(unsigned long, xen_cr3);
-DECLARE_PER_CPU(unsigned long, xen_current_cr3);
 
 extern struct start_info *xen_start_info;
 extern struct shared_info xen_dummy_shared_info;
-- 
2.43.0


