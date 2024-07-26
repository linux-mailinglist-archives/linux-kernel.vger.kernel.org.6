Return-Path: <linux-kernel+bounces-263646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD793D8A7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDA8B242FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4499D14A4DB;
	Fri, 26 Jul 2024 18:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GeY3j9Q3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2839149C78
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019932; cv=none; b=VBnVEp00v8kx9VZduNlKIFwpSaXVQFWMMpRVbhmcJlWIXw32YqVvdEd83sS3JVsrP2IIFimAbwuci3jNUaeSKbTglcnqHh0N0at2rUwTdIWdo8xwdtXOdPTfimm4RRmcCdSOaIYF2GMfpzLRCxJaetI55wrW9m/fBfAcEeWId2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019932; c=relaxed/simple;
	bh=1HnlQBL0vOBZ84lrHA6yeyQdIFc95bnX4c16QrKV+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGzrJYX9VovR30AutXmrDNpTWuS9AsNR6NNdEis6xVwIwBTD0Ow0lDbS8ickEC5pXWlvN8cGR+Rm+tWoxsuMkKoZzBH5V+BWtIICFPHacN6g2KNn2CvsMoVPETFGXUOuv5OFmA6MwyssenF1IKF348P3Fua560RkINHHNHRWJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GeY3j9Q3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722019930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SuhCap/2b9IgG9yLnMTDbfY/3XP60mbxoJ9OrpN+C8M=;
	b=GeY3j9Q3DPfqcqhe9I76JpgN1xCZ5pzZQ76/XQL9fBNXlr5XU8UeE7csNY13vN1QM4gaRE
	Q7OM8/ph4r+qKe7Mv2ygzePRu9onFPnDNEQBcCVg/SgzaRaw1digk1zbzjl9zH1vsLIE0R
	pLL1BW70NN0j/e2ER5HBTb9UY7orttY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-FQ18fmSdNFObSzQ2RjgnNg-1; Fri,
 26 Jul 2024 14:52:05 -0400
X-MC-Unique: FQ18fmSdNFObSzQ2RjgnNg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AB8B1955D4D;
	Fri, 26 Jul 2024 18:52:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AEE43000197;
	Fri, 26 Jul 2024 18:52:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	michael.roth@amd.com
Subject: [PATCH v2 05/14] KVM: rename CONFIG_HAVE_KVM_GMEM_* to CONFIG_HAVE_KVM_ARCH_GMEM_*
Date: Fri, 26 Jul 2024 14:51:48 -0400
Message-ID: <20240726185157.72821-6-pbonzini@redhat.com>
In-Reply-To: <20240726185157.72821-1-pbonzini@redhat.com>
References: <20240726185157.72821-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add "ARCH" to the symbols; shortly, the "prepare" phase will include both
the arch-independent step to clear out contents left in the page by the
host, and the arch-dependent step enabled by CONFIG_HAVE_KVM_GMEM_PREPARE.
For consistency do the same for CONFIG_HAVE_KVM_GMEM_INVALIDATE as well.

Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/Kconfig     | 4 ++--
 arch/x86/kvm/x86.c       | 4 ++--
 include/linux/kvm_host.h | 4 ++--
 virt/kvm/Kconfig         | 4 ++--
 virt/kvm/guest_memfd.c   | 6 +++---
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 4287a8071a3a..472a1537b7a9 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -141,8 +141,8 @@ config KVM_AMD_SEV
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
 	select KVM_GENERIC_PRIVATE_MEM
-	select HAVE_KVM_GMEM_PREPARE
-	select HAVE_KVM_GMEM_INVALIDATE
+	select HAVE_KVM_ARCH_GMEM_PREPARE
+	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	help
 	  Provides support for launching Encrypted VMs (SEV) and Encrypted VMs
 	  with Encrypted State (SEV-ES) on AMD processors.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 52778689cef4..4db18924b2f2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13644,7 +13644,7 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_arch_no_poll);
 
-#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 bool kvm_arch_gmem_prepare_needed(struct kvm *kvm)
 {
 	return kvm->arch.vm_type == KVM_X86_SNP_VM;
@@ -13656,7 +13656,7 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 }
 #endif
 
-#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end)
 {
 	kvm_x86_call(gmem_invalidate)(start, end);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 689e8be873a7..344d90771844 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2445,7 +2445,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_PRIVATE_MEM */
 
-#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
 bool kvm_arch_gmem_prepare_needed(struct kvm *kvm);
 #endif
@@ -2477,7 +2477,7 @@ typedef int (*kvm_gmem_populate_cb)(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 long kvm_gmem_populate(struct kvm *kvm, gfn_t gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
 
-#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 #endif
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index b14e14cdbfb9..fd6a3010afa8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -113,10 +113,10 @@ config KVM_GENERIC_PRIVATE_MEM
        select KVM_PRIVATE_MEM
        bool
 
-config HAVE_KVM_GMEM_PREPARE
+config HAVE_KVM_ARCH_GMEM_PREPARE
        bool
        depends on KVM_PRIVATE_MEM
 
-config HAVE_KVM_GMEM_INVALIDATE
+config HAVE_KVM_ARCH_GMEM_INVALIDATE
        bool
        depends on KVM_PRIVATE_MEM
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 5221b584288f..76139332f2f3 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -27,7 +27,7 @@ static inline kvm_pfn_t folio_file_pfn(struct folio *folio, pgoff_t index)
 
 static int kvm_gmem_prepare_folio(struct inode *inode, pgoff_t index, struct folio *folio)
 {
-#ifdef CONFIG_HAVE_KVM_GMEM_PREPARE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
 	struct list_head *gmem_list = &inode->i_mapping->i_private_list;
 	struct kvm_gmem *gmem;
 
@@ -353,7 +353,7 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 static void kvm_gmem_free_folio(struct folio *folio)
 {
 	struct page *page = folio_page(folio, 0);
@@ -368,7 +368,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 	.free_folio = kvm_gmem_free_folio,
 #endif
 };
-- 
2.43.0



