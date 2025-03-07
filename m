Return-Path: <linux-kernel+bounces-551003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC39A566D2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20C27A7E68
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CAB218593;
	Fri,  7 Mar 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJzYXCbB"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248A21767C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347262; cv=none; b=hFGNnpIwouQHV2XRFwD+HiFnfwodcAfua0IT46XBdk3HYHWJv+K6ebvz/P/OVLReJ3SC655yFeG5v9b8qcVIFcr7QNnQeWx4KcF6xtfIPEL3H3FfMzBGELaw4v+IePv2XalJw9aJMLwww0fIq6M0MoAIq6DeT0lB3LS9WwWZd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347262; c=relaxed/simple;
	bh=dAOYkLLFHOymrTr6TpeE0Wl2p2/V2JWcE5kJsjBx6rg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FFM+r7nxGVHilb2sEFbI8QPpWZAGp3Jsh7aQ/GtBwRNdzJ7ilKkssutQDuS2Z+pAd+Z3dG0u//bXIhj2PSCJcBRlImYd3FRWOk3O6WjNBnAOO/nEx0kyrlF6/xhZdeduDd8k5foMS6hXDC5Ice1LqWSx13/mUq7o8leJjFCIv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJzYXCbB; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bce8882d4so8015625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741347259; x=1741952059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOQy/PNkKkoEowxNbThyv2leDUZfqMcfcwikaBspss8=;
        b=qJzYXCbBwBBtdsbaQ2GGOnPrHM7oF7l16skuzIaCxPqPShfN0MOjZ1n9toZOzGrH+p
         DmyoyleRQyjVLkxFmNTuMNVpOGDjApGBraMj4iR4qw3jWofPMry/45UmfMlr7e6ypZMv
         UgYFHKkuyLocfcPdgw/LwkhoLmWwdu2VACanI1+04G6+TVCDpZkK9MEqt44XzKV5WoKE
         kY6QDWeP6wr+ogwqYwZxv8t4J5REoJr3hR20WbqF6I/8j4Ekli5cPTT0HKVNYhmZYTq7
         SEki+TdzmQsNewlcKKlNUFkbeunnnoFcm99zdgmOnnAGAx9ji5aNFw8dnFpuH+dvOJVf
         v5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347259; x=1741952059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOQy/PNkKkoEowxNbThyv2leDUZfqMcfcwikaBspss8=;
        b=UXr2Mm50x9ngy04xU39F3juoI5d5UzwbqB2WBJ5kNKCoc5h+ZLNTUPYFxLWh3EX4YJ
         EypK/gu5/mUOz2p0vsLY+WDWVMvVbC1h64zW60ESyLXp8Jo1rwvKTuBib3Ym9PO7T0ez
         ljOBAjdN8HOnLNnB+aYnqbeYG3E9ApDx+i5D854DuTH+GEkoF4bGphkDq4Y3EbKCOHv2
         yUN3F1kUzxPdxOT9JLDCtjP+/7kCLGJLPnMJdHnBT7lqCSUJWn521CblLZEhKKqSrUs7
         +JonGRcOAa+c8mZ6TpnNyja5q4A/OuDx8NX14UimhzuwKtfALNAn124Z1x1h85RdCkRD
         pBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHS0+u4RL0JuI4/DfD8dcYqk+gG5GZjqL2fXZyeCuvV9VcYwtFvpEZwMEfsXCiITToDnfR5Cxp5CaekVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0fTp8fNvd858VO1GN69RFOrqtVz5EGZ9Mj2cBi/RqKjtbyu2w
	LIK+S5qJMbQGeH4cxmVdg/Xr0jjtnByWGPm0H0vCHeXn5tTUqjANLK17famcffWXfAcR7flKzxe
	6zbsPnZKqpigHHnFNTw==
X-Google-Smtp-Source: AGHT+IEufDVmieTtOmTjD0ozshwtJsjGuKwUjK5sVkafXGyepALDAzCQ7cNYVDR3nM3liRfh3n/pBfr+E6zRFIsK
X-Received: from wmgg5.prod.google.com ([2002:a05:600d:5:b0:43b:bd03:5d2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1a:b0:43b:cc87:374a with SMTP id 5b1f17b1804b1-43c601e1294mr21499365e9.18.1741347259383;
 Fri, 07 Mar 2025 03:34:19 -0800 (PST)
Date: Fri,  7 Mar 2025 11:34:09 +0000
In-Reply-To: <20250307113411.469018-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307113411.469018-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307113411.469018-2-vdonnefort@google.com>
Subject: [PATCH v3 1/3] KVM: arm64: Add flags to kvm_hyp_memcache
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add flags to kvm_hyp_memcache and propagate the latter to the allocation
and free callbacks. This will later allow to account for memory, based
on the memcache configuration.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3a7ec98ef123..12691ae23d4c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -86,6 +86,7 @@ struct kvm_hyp_memcache {
 	phys_addr_t head;
 	unsigned long nr_pages;
 	struct pkvm_mapping *mapping; /* only used from EL1 */
+	unsigned long flags;
 };
 
 static inline void push_hyp_memcache(struct kvm_hyp_memcache *mc,
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 1f55b0c7b11d..c01ad4430729 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1086,12 +1086,12 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 	}
 }
 
-static void hyp_mc_free_fn(void *addr, void *unused)
+static void hyp_mc_free_fn(void *addr, void *mc)
 {
 	free_page((unsigned long)addr);
 }
 
-static void *hyp_mc_alloc_fn(void *unused)
+static void *hyp_mc_alloc_fn(void *mc)
 {
 	return (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 }
@@ -1102,7 +1102,7 @@ void free_hyp_memcache(struct kvm_hyp_memcache *mc)
 		return;
 
 	kfree(mc->mapping);
-	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, NULL);
+	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, (void *)mc);
 }
 
 int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
@@ -1117,7 +1117,7 @@ int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
 	}
 
 	return __topup_hyp_memcache(mc, min_pages, hyp_mc_alloc_fn,
-				    kvm_host_pa, NULL);
+				    kvm_host_pa, (void *)mc);
 }
 
 /**
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


