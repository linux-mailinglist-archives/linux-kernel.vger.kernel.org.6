Return-Path: <linux-kernel+bounces-551005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E953A566D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9229E3AA824
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DA218AD4;
	Fri,  7 Mar 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j62tgaCi"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4897021885C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347267; cv=none; b=TCrREMH/tJlSKSpksmuktb6y+0WYTPtHhZfdl3WdXB9gRMStYOcR6dvMvHpLUcgicaAwg9vQsPyfFDbgTQKoEj/9XDASd0j4xrN0ty+DTRkteme6VA6SMqkuThsflSEBBig8e/jJymMhqU3m+6tYCHS60i7p002aNtjwGybHfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347267; c=relaxed/simple;
	bh=HH6yLXJUvxDiJ1cSfj8yphZfz5sICSe4TnVL3hkc6bA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Enz3ErPKC+CHEN13zE4SZfBNGhGArp0d8buUuVoTwQL+NtKiV5FiOGMRgrheIZaRmYQefPemoQaDcB5T8ZA8VRbnfx+nSJcimXZSLO3VOTBK+u4x5NkOviFixv1aBew+hf+hFCSIioPNRCk6jnmkFx1PURFLpDlcqT5CKkd1yOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j62tgaCi; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bcddbe609so15618135e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741347263; x=1741952063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ntuubx8ETsO6TTIOT42EyExqJBNP9f2/d8qVb4BOX4=;
        b=j62tgaCiKIGUGSyCK7zCoE7dQhixMORaRzrL5ocEkgb5vpCx6Q0yuZ6WA5XgNrsEzn
         whYHBylT1JVpy/ofNnHGLEaZhzxu4J4w59qpXmYIYtnvILNWOv5Au2YzAt1//ypJqCeK
         avdkdxqTPSl6ZV1Llx56aSIja6ku9rBy47KdxlbRvZg/lq4pLXWCzl8M1ymXN1bj3rJM
         gEE0yqhzVZfwBsShJ67T59e1Im/pF6nudUI6qqclJ2CoDFnWewkFSL0RslK8b06skqDy
         cF8DKq/5Q5paGFu3jsygJSLTY86Wfj+rsT5+ugX+vW5Wg4NsMowPgw/jR6UgBZXuO7l7
         MnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347263; x=1741952063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ntuubx8ETsO6TTIOT42EyExqJBNP9f2/d8qVb4BOX4=;
        b=lFzI9fmj3LQR3Mmh0h9vHIYFrOI6c9uPBVjFl0GQT1EV7UwyjdyXOswzk/EE+bVkzK
         92ul/eJGnUzJ4lh7akkXHiU84FPcwE298A4SH1YMzxHjUcfLGj8AQ7EcRpzLL8JGZYse
         ogZy1Sq8MExnz2OUlS7rUWrqjiNIby0NGoWmixDQ9uGTN92RA+rozPOWoS3dX2xE/nOZ
         rsw5D4DjCeOqWxlms9/EHxyb6Dn7v6lL17nigQXgpB3lSGFyWdByM0nG3t8Kj2GfNL4O
         wc9N3ljnoUE6lr+Ihbv/OyuCjSwqKon0wJB/PZ7bXE4faQemhLJFGi8MgoEnh1slkLhs
         gBdw==
X-Forwarded-Encrypted: i=1; AJvYcCV6d3iXYGm8alFNo8hTXSht8G54+DUD+Y+X+V8PyZaW4XZTWqgytucK4xxi9hNvV9u+itRrpLlYeY+QsWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTfH7H3Z6F24GO1SdZAYJ6uqt4Cyg9rc2feFMe6TRD5XkILbVH
	+EE0lwMs1hEbAi28TMo8nvlKHZdmMxxsev5FNBO87PFb9fCJshddUxPQuv3wXUGCgV3wxAFo5Pk
	glTvjz4GVMjtKBqSHQg==
X-Google-Smtp-Source: AGHT+IHklc9pmH21U3YbDQ5Gwc1RGIuSlYKt8XLy0tqeyn/MaP9krs7wUaI3Q0qrAvYZEPn9BnOr0sZM8eUcQbxr
X-Received: from wmbja12.prod.google.com ([2002:a05:600c:556c:b0:43b:d8f9:568a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310c:b0:43b:d72d:368 with SMTP id 5b1f17b1804b1-43c5a630260mr27416035e9.2.1741347263644;
 Fri, 07 Mar 2025 03:34:23 -0800 (PST)
Date: Fri,  7 Mar 2025 11:34:11 +0000
In-Reply-To: <20250307113411.469018-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307113411.469018-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307113411.469018-4-vdonnefort@google.com>
Subject: [PATCH v3 3/3] KVM: arm64: Count pKVM stage-2 usage in secondary
 pagetable stats
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Count the pages used by pKVM for the guest stage-2 in memory stats under
secondary pagetable, similarly to what the VHE mode does.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ace3969e8106..51754a354b7a 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -86,6 +86,8 @@ struct kvm_hyp_memcache {
 	phys_addr_t head;
 	unsigned long nr_pages;
 	struct pkvm_mapping *mapping; /* only used from EL1 */
+
+#define	HYP_MEMCACHE_ACCOUNT_STAGE2	BIT(1)
 	unsigned long flags;
 };
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c01ad4430729..73b44f1200c7 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1088,12 +1088,24 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 
 static void hyp_mc_free_fn(void *addr, void *mc)
 {
+	struct kvm_hyp_memcache *memcache = mc;
+
+	if (memcache->flags & HYP_MEMCACHE_ACCOUNT_STAGE2)
+		kvm_account_pgtable_pages(addr, -1);
+
 	free_page((unsigned long)addr);
 }
 
 static void *hyp_mc_alloc_fn(void *mc)
 {
-	return (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+	struct kvm_hyp_memcache *memcache = mc;
+	void *addr;
+
+	addr = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
+	if (addr && memcache->flags & HYP_MEMCACHE_ACCOUNT_STAGE2)
+		kvm_account_pgtable_pages(addr, 1);
+
+	return addr;
 }
 
 void free_hyp_memcache(struct kvm_hyp_memcache *mc)
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 19921ca407c6..7e6e3b0518f8 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -165,12 +165,16 @@ static int __pkvm_create_hyp_vm(struct kvm *host_kvm)
 	handle = ret;
 
 	host_kvm->arch.pkvm.handle = handle;
+	host_kvm->arch.pkvm.stage2_teardown_mc.flags |= HYP_MEMCACHE_ACCOUNT_STAGE2;
+	kvm_account_pgtable_pages(pgd, PAGE_ALIGN(pgd_sz) >> PAGE_SHIFT);
 
 	/* Donate memory for the vcpus at hyp and initialize it. */
 	hyp_vcpu_sz = PAGE_ALIGN(PKVM_HYP_VCPU_SIZE);
 	kvm_for_each_vcpu(idx, host_vcpu, host_kvm) {
 		void *hyp_vcpu;
 
+		host_vcpu->arch.pkvm_memcache.flags |= HYP_MEMCACHE_ACCOUNT_STAGE2;
+
 		/* Indexing of the vcpus to be sequential starting at 0. */
 		if (WARN_ON(host_vcpu->vcpu_idx != idx)) {
 			ret = -EINVAL;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


