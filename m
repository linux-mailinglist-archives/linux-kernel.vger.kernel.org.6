Return-Path: <linux-kernel+bounces-538335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DC5A4973E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684A6168C03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B425E83E;
	Fri, 28 Feb 2025 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1mXI9a7"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4376264A91
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738373; cv=none; b=GS9rba4o6umSSVRGTv7gzYbzv1OJtsazPNEHoDdcOmguB7ZGYnGYLvFXU+KFxDZW2W6rznJSrZHvvRTtm2VhHFjzD2X+9V+DrgUc/Wow4a5zi6CUZXjryZTQbqAP7rEqwPnRrhDmmR7WtI9qjM6sE2pqCEuNlHL6pM9m/k3eHXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738373; c=relaxed/simple;
	bh=8CXJzd3bdWnUUiUgEqvdbCvJOrcXmt4cgq1d60RfuSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2NXHu2W6dkQKUiDM/Rrllpl0g+mzfsh9kyCbrVJ2h13S5+LO5w6W2IkEPFpwi/S261wPDBaG5ny/dxWpsfZCzQ9nptku50zDnVaQ5zO5Q2+wUThvrG9QIPayR0cDG3ektRk1R//1/ILgt0iwOQuJQHf0EX7kl89i5wP5SUVguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1mXI9a7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so10359295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738370; x=1741343170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXik8AjbYyPYjDFsjvp2RmgmvxUrFId1oBHnRgszILo=;
        b=r1mXI9a7PY7kV0nxdWYB4aIgnFW5MXtk2aoLFfh6yHdN6zYKtc20APWGzfYg4Cpg3w
         ayUeoRMy8x5GIWCP5uqVT2gjG2+TEeoiTMC93j3Z5BWUyAFtcmoPZKCKCoRYs2ni/Yqj
         MKTjACyjGuzdKZrX7DvQEXkdktOptdMjXymuH9qJpoDv+BzjSwvOAYsxWJBiTxDnYdqQ
         1oXGYX+mGsEz8Nh9xazeBTXIHmx3qO9cMMra9rjG9WHwHSfdlC92R0CyeBjpC3cKRM6W
         NV4hhZ0/ATiEMGro1avhJrQGzarR/tGkSaqL8HAhuZnyyX5i7nlz68PQNlEgBa3JE+7Z
         ewvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738370; x=1741343170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXik8AjbYyPYjDFsjvp2RmgmvxUrFId1oBHnRgszILo=;
        b=f2gySRdTxhdXpivaj0avwZfWvVsJtO8ZZtCIV+X9I8PTN/FUJM1pNNlopkxUAyYhZJ
         Nfb0ZWGCDD4J0fMh8clT1YkLDwhpTdZj6n6YBsAF/4FV7ReVXYJzIdpBJyiBgV0FHhH+
         Q2xjGI/EDeuKczA/O7AVSl10FCcT/SzeHZKyWVc8n36SuYVcKKRiWZoLKI1GXeGMu0z+
         Q+HnbPVrUHR7PDtMAtfI0fde85pdcf/pBiwWQgKmGMp9UgHDtj3TiqLq2KswvjPmeyLa
         E9OSXxYC3lPmJu2XTrCamQN8m95jDZ4ebe5ABAI4akwdADLX2xkmk8OpfyUSZ1K4QHGL
         4Ycw==
X-Forwarded-Encrypted: i=1; AJvYcCVx0vrlRqu3Yvi33uiVUH0OeTZzcvDymQMQPWzoYnUgF9Fki7bDFYUW4nKwW9olFIOlSR2MQoACk1D2aWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+/5aJCD1biGyy9O7e8FC1NVTdFb+8SvghAlwKR0tDS/WL9He
	GmyYGB3gnA9JOlqdMyVs70c30ZTgMiX90w4/7WyJTJVp9MsZhlgsb7vEfEeccZjx1OHaH/65uMI
	o4YyvD+aa0lgSIMb3oQ==
X-Google-Smtp-Source: AGHT+IEAPz/RAXYnzFohN9Raf5YNtkybSVaVQHUTq3+jLbWVdd15Teg4OP5zmX13qptaA5oh6JZSNMjkf/9AO9S4
X-Received: from wrbcc18.prod.google.com ([2002:a5d:5c12:0:b0:390:ec9b:c31f])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1ac9:b0:390:ea2f:92a5 with SMTP id ffacd0b85a97d-390ec9bbfefmr2318524f8f.31.1740738370197;
 Fri, 28 Feb 2025 02:26:10 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:28 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-13-vdonnefort@google.com>
Subject: [PATCH 7/9] KVM: arm64: Add range to pkvm_mappings
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Quentin Perret <qperret@google.com>

In preparation for supporting stage-2 huge mappings for np-guest, add a
nr_pages member for pkvm_mappings to allow EL1 to track the size of the
stage-2 mapping.

Signed-off-by: Quentin Perret <qperret@google.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_pkvm.h b/arch/arm64/include/asm/kvm_pkvm.h
index f0d52efb858e..0e944a754b96 100644
--- a/arch/arm64/include/asm/kvm_pkvm.h
+++ b/arch/arm64/include/asm/kvm_pkvm.h
@@ -166,6 +166,7 @@ struct pkvm_mapping {
 	struct rb_node node;
 	u64 gfn;
 	u64 pfn;
+	u64 nr_pages;
 	u64 __subtree_last;	/* Internal member for interval tree */
 };
 
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index da637c565ac9..9c9833f27fe3 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -278,7 +278,7 @@ static u64 __pkvm_mapping_start(struct pkvm_mapping *m)
 
 static u64 __pkvm_mapping_end(struct pkvm_mapping *m)
 {
-	return (m->gfn + 1) * PAGE_SIZE - 1;
+	return (m->gfn + m->nr_pages) * PAGE_SIZE - 1;
 }
 
 INTERVAL_TREE_DEFINE(struct pkvm_mapping, node, u64, __subtree_last,
@@ -315,7 +315,8 @@ static int __pkvm_pgtable_stage2_unmap(struct kvm_pgtable *pgt, u64 start, u64 e
 		return 0;
 
 	for_each_mapping_in_range_safe(pgt, start, end, mapping) {
-		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn, 1);
+		ret = kvm_call_hyp_nvhe(__pkvm_host_unshare_guest, handle, mapping->gfn,
+					mapping->nr_pages);
 		if (WARN_ON(ret))
 			return ret;
 		pkvm_mapping_remove(mapping, &pgt->pkvm_mappings);
@@ -345,16 +346,32 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 		return -EINVAL;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
-	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, 1, prot);
-	if (ret) {
-		/* Is the gfn already mapped due to a racing vCPU? */
-		if (ret == -EPERM)
+
+	/*
+	 * Calling stage2_map() on top of existing mappings is either happening because of a race
+	 * with another vCPU, or because we're changing between page and block mappings. As per
+	 * user_mem_abort(), same-size permission faults are handled in the relax_perms() path.
+	 */
+	mapping = pkvm_mapping_iter_first(&pgt->pkvm_mappings, addr, addr + size - 1);
+	if (mapping) {
+		if (size == (mapping->nr_pages * PAGE_SIZE))
 			return -EAGAIN;
+
+		/* Remove _any_ pkvm_mapping overlapping with the range, bigger or smaller. */
+		ret = __pkvm_pgtable_stage2_unmap(pgt, addr, addr + size);
+		if (ret)
+			return ret;
+		mapping = NULL;
 	}
 
+	ret = kvm_call_hyp_nvhe(__pkvm_host_share_guest, pfn, gfn, size / PAGE_SIZE, prot);
+	if (WARN_ON(ret))
+		return ret;
+
 	swap(mapping, cache->mapping);
 	mapping->gfn = gfn;
 	mapping->pfn = pfn;
+	mapping->nr_pages = size / PAGE_SIZE;
 	pkvm_mapping_insert(mapping, &pgt->pkvm_mappings);
 
 	return ret;
@@ -376,7 +393,8 @@ int pkvm_pgtable_stage2_wrprotect(struct kvm_pgtable *pgt, u64 addr, u64 size)
 
 	lockdep_assert_held(&kvm->mmu_lock);
 	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping) {
-		ret = kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn, 1);
+		ret = kvm_call_hyp_nvhe(__pkvm_host_wrprotect_guest, handle, mapping->gfn,
+					mapping->nr_pages);
 		if (WARN_ON(ret))
 			break;
 	}
@@ -391,7 +409,8 @@ int pkvm_pgtable_stage2_flush(struct kvm_pgtable *pgt, u64 addr, u64 size)
 
 	lockdep_assert_held(&kvm->mmu_lock);
 	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping)
-		__clean_dcache_guest_page(pfn_to_kaddr(mapping->pfn), PAGE_SIZE);
+		__clean_dcache_guest_page(pfn_to_kaddr(mapping->pfn),
+					  PAGE_SIZE * mapping->nr_pages);
 
 	return 0;
 }
@@ -406,7 +425,7 @@ bool pkvm_pgtable_stage2_test_clear_young(struct kvm_pgtable *pgt, u64 addr, u64
 	lockdep_assert_held(&kvm->mmu_lock);
 	for_each_mapping_in_range_safe(pgt, addr, addr + size, mapping)
 		young |= kvm_call_hyp_nvhe(__pkvm_host_test_clear_young_guest, handle, mapping->gfn,
-					   1, mkold);
+					   mapping->nr_pages, mkold);
 
 	return young;
 }
-- 
2.48.1.711.g2feabab25a-goog


