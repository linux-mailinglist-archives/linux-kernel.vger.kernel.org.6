Return-Path: <linux-kernel+bounces-548727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C0A548A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3636B1896146
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85020B1F9;
	Thu,  6 Mar 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gL6v1IX"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069F820B7F2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258863; cv=none; b=NLLPaarNHExDstAs3sYkTi6aA6YA6Es0+YM+vOK37P1gTfTKV48j9BDTvBEDbCiZViO+obgiSlBynTw9c5v0f6/ZNtJHJ4hsTwhPJukYBLKhFQj7y9h3L074zyB5VWu+0rl1wEjewMlGEi8R0ZUYYgmvjhd3urGw4NLM1RyCIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258863; c=relaxed/simple;
	bh=8CXJzd3bdWnUUiUgEqvdbCvJOrcXmt4cgq1d60RfuSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TbD0/6aR1VFw0J7G27ojiy9htwu3ebo8u4GykFlRT3zQBLY4L+6L6ORqV/mrWmxw+rBK8IZry1ECM6TsZ4qho2ACkSJuBPksOAyQMFVg+1Q7l296iSJVopopIo1zz8vAZbOVE/mvJ+pN93qNQm/mq7/kKmY+2reiR9RMlPRji4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gL6v1IX; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd92233acso5041385e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741258860; x=1741863660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXik8AjbYyPYjDFsjvp2RmgmvxUrFId1oBHnRgszILo=;
        b=3gL6v1IXNE+tcFhq8vj7dhwczAD96zxhsBrBf6YzbqIGEyRZHRejR129/hCwzbjDXC
         ahC+HfDUhHREm0r50TzB0FJPHddVaEr9h93ninY6laMhJZC7Uy7UWqYDbnNBalCce2H8
         P+gGRN+lzSD18HBelxVJfh7EQZS2dL162LXZrUIUDZ7YQbQPZzCv8uKxyFllkrZL+j6i
         v87lZotdedtBO4DUtEmjqyhCeb/AR0LlM2RPCJzYlSJHTCqTXLzmEsdVuT6q+FRWSbEH
         JomX+7iJUudnLHMfXXkc4elgNEpmFewrjJv7oAsGGb5DMNr9v8lOdB2TFdU6OFyeDD9K
         TDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741258860; x=1741863660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXik8AjbYyPYjDFsjvp2RmgmvxUrFId1oBHnRgszILo=;
        b=Kq22l6zSC4cQFWmHAnq3lghFh9eITmgU+3EsM1PZL5r0EziucPsxfO9E8xNZJv2Xql
         DTc4Y6CXw2wZncHMyrghRikyba6SlSu89f7xtc0HGjBFeyhQjhw5UPPmQXahpBZe6Qkj
         08LlvJjV35gUcmKSh3XldOQMEIrzVHija4GCAZ4bXR9WJKvULSS5qmEL9QMZJy9GEZhe
         F5tTuBezbnTBVVhQCuSQWvvI8Jyhr3rQFoGn2W0dJ/Ax96lNAVyHRfXVjIhAkl1fR7GT
         hWnwq2GHo1jTnAWPnq8hVbtqtZICq/JkLUGPKa6Az8Q37xG2yuh/HbdNv+cNHE8UbiD2
         7oZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa/66bFsGiuvQ/LzyqTLbDIuZ/7BR2EDossoNTRz2Z5N5+5jH0dCyOkBJSLX5c/Ei5G7fkJpQ/6gaZr3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtxU+BXuKDsq091XCngReOxwPC0a0TiI7FUHu9kYSM0DxkhgQ
	IGzjE2GOSANDS9mX5uvt7sAIPisOKS+uS9sGDDiqXmlBGJIQ0KfBNi8GpLgK6hOHf5nEZsY9Xt9
	8to+SOpdJmxhFyf//iQ==
X-Google-Smtp-Source: AGHT+IG1zpmCoE47NgJOQQ1JcAF2Bl3oBRwYgO4WaRdecPq4Be2Q4d+PX+LTxNRaXoONJrSQGsIXYlKSmDSqbhOe
X-Received: from wmbfp6.prod.google.com ([2002:a05:600c:6986:b0:43b:cf2d:8027])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:198f:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43bd294309bmr67065855e9.7.1741258860152;
 Thu, 06 Mar 2025 03:01:00 -0800 (PST)
Date: Thu,  6 Mar 2025 11:00:36 +0000
In-Reply-To: <20250306110038.3733649-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250306110038.3733649-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250306110038.3733649-8-vdonnefort@google.com>
Subject: [PATCH v2 7/9] KVM: arm64: Add a range to pkvm_mappings
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


