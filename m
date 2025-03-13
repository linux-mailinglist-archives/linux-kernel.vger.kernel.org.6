Return-Path: <linux-kernel+bounces-559360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC42AA5F2A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391883BD9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023D2676D1;
	Thu, 13 Mar 2025 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ntmROK0/"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954061EF09A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866055; cv=none; b=p1rXx1MhpkHD04endZDCVfDyQJbQv94byt+Nmzk/V5YItIA4rQVQppJSeAun8c3K2qyMSw0slX76fqc8+QssspPLq/Op4Vl/F3ZgD9VkdHIpgFA6VSe3ZP6bTTAryAPv5k0hNxaUV7Vsg65c7FFb0FO/seDol7NrGhBJGzgVcUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866055; c=relaxed/simple;
	bh=WxD7H79bfqHbk248m4tbUoiXB5nNdhMAZv90fFI+hdA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r6chhIw+P1I5/RVqEDOzaDzNfADmmghd5BFls+oFBiNWmQuSSBMsYKgpU34DRxFJI1qxlBdrpSEbqaPmGejwSGG7w56RJw5cQKKPEbQ9N3AQURPJ15IaYmT9d584yfWRJ2ItY1w7KxytCR9GDr1XRyCPT0aVZp+1S58eyvMvme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ntmROK0/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so4349285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741866052; x=1742470852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDWqfNf0Ci0kqTl0GDSnxlhwnncAHfDpHJ3DMUVydnk=;
        b=ntmROK0/HVlp2aO20HkkbkVFMUgPjShSAVxbYMONiFnTkaWIJLnJjXLgSYr2Hhhz0M
         wtW+N8Sebhk3PKzsU+n6RVvZfLL0wTx8HvfqR3IU+/8pa0qgBZoRq99n5RXOi/fULnlO
         Lu56uBQQxOqCzfu8EV0UZvUpVfMMH8t/Z1fmBJHzAqHO9UWMZEPLthE8AUvrTkvXiPvy
         YpObOAiC7n3Xh5wktjVmOijX6uTE8zLh5+HoOQcCCafZAaEHGm/ddB8xRji/Zdhr5K3q
         kfiLaE47KxhKRbsWY+HiZlc1nPe/IFJAT4aLCvp2C75UVor0hdWDb20YoPRvH69dvNJG
         gaag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866052; x=1742470852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDWqfNf0Ci0kqTl0GDSnxlhwnncAHfDpHJ3DMUVydnk=;
        b=L3vd3H68gFOts9vbBEZ3Pt6NZHWOeVUa86rO65dKcEKqAVJW0m/O4Jp40W7/8faEJR
         OhIrkTxpoT91AJrQZFrkaQvjIQKj9V0o5FDg/oPcAmxWjlNYRORZS+b4oAmMK5rRdMp+
         cd/pyFP73AGRmVveFv2GhcRFWgDJFTAnm5ttpBT+vQYI9N0rhIfeWeLYsKcyOuz+LeTm
         ctuRs22wN8z3IIoDvYNSpzb+zCkspONOB/toRPDZPZ2bY1zcFkSiYDBvxvIbgE7tcwS4
         V3VcvtL2FN1fa7Nq2eY1qbRiKOhMy1TbVcGO+QVkeW8nSWAukKdqktnF4j/UzdESzOrh
         i1pg==
X-Forwarded-Encrypted: i=1; AJvYcCVgZDWcOhrbhfdl5/YFfeCoVWMCqulVyPvjvzaSQcU7K2S6JWn5Nng9YuX9ssMsM8oJKgIvEyRHCtnIWgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmlcGbTk7qx4L5JwfI2pY7dPjdr2E7jHJtjUM/545vNSPb4lrM
	cZDmI//vN079HEEaUmiMMfs7vvUIDd0suU4uxs0UEnJyo9Sg5mDfY7MhMOWW2iWred6aZb9gaxR
	XUtwQjLxcXwbh0GJ9DA==
X-Google-Smtp-Source: AGHT+IFKKo1u7bMMw5ZxGIjRt9SaBMTtCTn1z/fHmkTMPIsujAZAFsyBOCACwf96nv+XqVJo4hWsVe0aFo0TzDK4
X-Received: from wmbgz9-n2.prod.google.com ([2002:a05:600c:8889:20b0:43c:fcbd:f2eb])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f4f:b0:43d:d06:3798 with SMTP id 5b1f17b1804b1-43d0d063a25mr31305935e9.20.1741866052022;
 Thu, 13 Mar 2025 04:40:52 -0700 (PDT)
Date: Thu, 13 Mar 2025 11:40:37 +0000
In-Reply-To: <20250313114038.1502357-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313114038.1502357-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250313114038.1502357-3-vdonnefort@google.com>
Subject: [PATCH v4 2/3] KVM: arm64: Distinct pKVM teardown memcache for stage-2
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In order to account for memory dedicated to the stage-2 page-tables, use
a separated memcache when tearing down the VM. Meanwhile rename
reclaim_guest_pages to reflect the fact it only reclaim page-table
pages.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 12691ae23d4c..ace3969e8106 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -246,6 +246,7 @@ typedef unsigned int pkvm_handle_t;
 struct kvm_protected_vm {
 	pkvm_handle_t handle;
 	struct kvm_hyp_memcache teardown_mc;
+	struct kvm_hyp_memcache stage2_teardown_mc;
 	bool enabled;
 };
 
diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 978f38c386ee..ea0a704da9b8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -56,7 +56,7 @@ void handle_host_mem_abort(struct kvm_cpu_context *host_ctxt);
 
 int hyp_pin_shared_mem(void *from, void *to);
 void hyp_unpin_shared_mem(void *from, void *to);
-void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc);
+void reclaim_pgtable_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc);
 int refill_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages,
 		    struct kvm_hyp_memcache *host_mc);
 
diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 19c3c631708c..f34f11c720d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -266,7 +266,7 @@ int kvm_guest_prepare_stage2(struct pkvm_hyp_vm *vm, void *pgd)
 	return 0;
 }
 
-void reclaim_guest_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
+void reclaim_pgtable_pages(struct pkvm_hyp_vm *vm, struct kvm_hyp_memcache *mc)
 {
 	struct hyp_page *page;
 	void *addr;
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 3927fe52a3dd..ac85bc51b8d3 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -678,7 +678,7 @@ teardown_donated_memory(struct kvm_hyp_memcache *mc, void *addr, size_t size)
 
 int __pkvm_teardown_vm(pkvm_handle_t handle)
 {
-	struct kvm_hyp_memcache *mc;
+	struct kvm_hyp_memcache *mc, *stage2_mc;
 	struct pkvm_hyp_vm *hyp_vm;
 	struct kvm *host_kvm;
 	unsigned int idx;
@@ -706,10 +706,10 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
 
 	/* Reclaim guest pages (including page-table pages) */
 	mc = &host_kvm->arch.pkvm.teardown_mc;
-	reclaim_guest_pages(hyp_vm, mc);
+	stage2_mc = &host_kvm->arch.pkvm.stage2_teardown_mc;
+	reclaim_pgtable_pages(hyp_vm, stage2_mc);
 	unpin_host_vcpus(hyp_vm->vcpus, hyp_vm->nr_vcpus);
 
-	/* Push the metadata pages to the teardown memcache */
 	for (idx = 0; idx < hyp_vm->nr_vcpus; ++idx) {
 		struct pkvm_hyp_vcpu *hyp_vcpu = hyp_vm->vcpus[idx];
 		struct kvm_hyp_memcache *vcpu_mc = &hyp_vcpu->vcpu.arch.pkvm_memcache;
@@ -717,7 +717,7 @@ int __pkvm_teardown_vm(pkvm_handle_t handle)
 		while (vcpu_mc->nr_pages) {
 			void *addr = pop_hyp_memcache(vcpu_mc, hyp_phys_to_virt);
 
-			push_hyp_memcache(mc, addr, hyp_virt_to_phys);
+			push_hyp_memcache(stage2_mc, addr, hyp_virt_to_phys);
 			unmap_donated_memory_noclear(addr, PAGE_SIZE);
 		}
 
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 930b677eb9b0..19921ca407c6 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -111,6 +111,7 @@ static void __pkvm_destroy_hyp_vm(struct kvm *host_kvm)
 
 	host_kvm->arch.pkvm.handle = 0;
 	free_hyp_memcache(&host_kvm->arch.pkvm.teardown_mc);
+	free_hyp_memcache(&host_kvm->arch.pkvm.stage2_teardown_mc);
 }
 
 /*
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


