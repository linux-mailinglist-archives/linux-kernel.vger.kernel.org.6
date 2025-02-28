Return-Path: <linux-kernel+bounces-538336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51944A49749
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 11:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564BC3B98BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98CF266EF4;
	Fri, 28 Feb 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZLMUzuM"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9C266198
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738375; cv=none; b=RkBBnhbdCdjp+OFwtgZrzfg11hkG6kAPOX0M+Hdt8cI7NxtJPVhj2njs2tewFKCJm558OABOF084C6is2ssVCQrcyMiSOZAraPuGLHrK9KTKgzofF/0zKgA2g2B6PkcPYh56xQeyhH8hLpX335jYeNb4BsR7BIzsFU1b4+LTTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738375; c=relaxed/simple;
	bh=whyGc5aGHwNKn0mfmuFzvWSs8yNUHY/ZhnQubB+H94o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LkS/Qufob5ReadF8KTiR3KXm0lWCjAUoJc+Ysqmzu5FMNj3r+PM1F3jAOjDLbdEZeDTf7ur62kjdyxpkbEfXtcG7BTTQpbkWuRHswhqkQ8kZYCtZiMVCM6bWdNOSr5DvcPBSL6el5B41Ss8PwXJZvQO8r8GhMB27ayzQfEa9pAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZLMUzuM; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4393b6763a3so8266275e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740738372; x=1741343172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRMnVBqxbNr0g4BbhZbbaQ06EF+wmwJkU+0Xf25VfM4=;
        b=qZLMUzuM0Mlu8/s1K2xvgWD0Q6chaLtQs4heFMRwG0aw5odoX68J8ORfvvazAeZHhT
         BRKGB7vdiDTrarDWmZ3y7dsOFYGYJFsN7YZ0OyNJFniaZvPOkHoxUQunnyQ6/4H2JtYy
         yYIP2aXuqdNTm2+zVvNlJ6r8TVrmNTI7cZkURKhDLZ/c9anWCkp73HXl7EljW7H4nBWv
         UchCcUFsL7KP96j4PSazW/CRWXE4YExfp0LsPFFpTPlaYBn9yzWUB+LDo79FikvEWYGs
         F7v/GnlS84n0AGBC3PR+O4rJR9u3xJipizBiMCvJsqMei7A8GlviMaO6LzFQgAOFqQ12
         sKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738372; x=1741343172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yRMnVBqxbNr0g4BbhZbbaQ06EF+wmwJkU+0Xf25VfM4=;
        b=s7gVBQBoysSYuKxd47QBGm8x2zQN1r3LR14ybv7+uQ9opn7pqXUSsYZMAlbkWOE0Wn
         RdU3GDeRbMcPDM8Xh2F4x34vBf12BX/hc6a5lesxD45bqjRvjveYT7VBszzoIcxgih/E
         zfv22M2uPhQnjsCRGaMtuL/X5D+CRlE6U+oGnRUJP9HorCZWM2d9ZV4SxiElqgnYAAr/
         zvHZ0030UMtCn1Ggw8Mz9/p3PSjMas/5vy4wc8Y1H4V3Vtis9WxqVHMqdQ0YMlAYmUba
         WqqcovkEModblAm6rDbFI4RNhWuCW3qQfgMcrMm/ImRVckezHlrwNJQnjKKt1ElhG0S6
         9/pA==
X-Forwarded-Encrypted: i=1; AJvYcCWpcSYLIFYAeI41ReLXcmYpioSw+hSNI8r2wA1VwtSeQ/eCAHs7uWsz35p/OAf/xUFZ1aG6l6kUXiZNaLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOnHbcG3BNBKLJ36ET6emXvPmhMwZmTP0W8YWgROxMfHBZ4bv
	fQXx+HxY5z2KeaKeFi85l7FBF+oLOMoEo22x3vLxP9KyRVbISgG2Ff1MERHuuJ6evJWuqkIgwUe
	bkf267QyPAdoDo6lvUA==
X-Google-Smtp-Source: AGHT+IH0fwtXCTDeJhT/l/khwHsuYplMhcSCRFECxM5q7EjwmroI+BdQCjojPmRxAfbH2kPDmDbv1a422TO5a1h/
X-Received: from wmqe15.prod.google.com ([2002:a05:600c:4e4f:b0:439:9fd1:8341])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1387:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-43ba6760305mr20891625e9.29.1740738372225;
 Fri, 28 Feb 2025 02:26:12 -0800 (PST)
Date: Fri, 28 Feb 2025 10:25:29 +0000
In-Reply-To: <20250228102530.1229089-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228102530.1229089-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228102530.1229089-14-vdonnefort@google.com>
Subject: [PATCH 8/9] KVM: arm64: Stage-2 huge mappings for np-guests
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Now np-guests hypercalls with range are supported, we can let the
hypervisor to install block mappings whenever the Stage-1 allows it,
that is when backed by either Hugetlbfs or THPs. The size of those block
mappings is limited to PMD_SIZE.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 25944d3f8203..271893eff021 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -167,7 +167,7 @@ int kvm_host_prepare_stage2(void *pgt_pool_base)
 static bool guest_stage2_force_pte_cb(u64 addr, u64 end,
 				      enum kvm_pgtable_prot prot)
 {
-	return true;
+	return false;
 }
 
 static void *guest_s2_zalloc_pages_exact(size_t size)
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1f55b0c7b11d..3143f3b52c93 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1525,7 +1525,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * logging_active is guaranteed to never be true for VM_PFNMAP
 	 * memslots.
 	 */
-	if (logging_active || is_protected_kvm_enabled()) {
+	if (logging_active) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
@@ -1535,7 +1535,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	switch (vma_shift) {
 #ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SHIFT:
-		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+		if (is_protected_kvm_enabled() ||
+		    fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
 			break;
 		fallthrough;
 #endif
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 9c9833f27fe3..b40bcdb1814d 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -342,7 +342,7 @@ int pkvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 	u64 pfn = phys >> PAGE_SHIFT;
 	int ret;
 
-	if (size != PAGE_SIZE)
+	if (size != PAGE_SIZE && size != PMD_SIZE)
 		return -EINVAL;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
-- 
2.48.1.711.g2feabab25a-goog


