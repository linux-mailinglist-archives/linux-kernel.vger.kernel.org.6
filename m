Return-Path: <linux-kernel+bounces-544272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95FA4DF8A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F3F1898CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E62046B7;
	Tue,  4 Mar 2025 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Duyf9Jjl"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959E204683
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095836; cv=none; b=b13l0hYBrxyGyRKcEla9HdSsFmBqbHWIoVebhvog8RX0/zpupmp+TO05+Om2ikGNvmHg4DBR/PEU68yP63dVcZcXakQ3+ART1J+QbNYwyMnR3QMjPQmUWco3YbKPS/weD9W1rqdnf7S0G3DgRdZDF9M2jOpw+SzqWEevkj9PD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095836; c=relaxed/simple;
	bh=Mgo4/DO8OD8GZn9j7UQxKW6LhjTLRQV1hFx41dH7LJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QhIePQcUBESbwuNk2/eZeoPSVQn58cj/bywLKX9TDeFDHnzkKt5jAmF6EdJqpjp2sQDwoN8kWz3Eh4VWDtnQfP4B7aqufJ73MDXASJygNftIgePp0mk5rN3xz00A5NRPY0XfDAAD+JaEMHJ5CO3PhMUBj/M4ZlXiYtzmZnf+DdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Duyf9Jjl; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c489babso31128155e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741095833; x=1741700633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ciUEmziHwKoR8EZ15kFmNQQUeftjWJUBtJzEaxlx9Y=;
        b=Duyf9JjlKJw/WWzJi2WWl6RSdb/1NAsNAdl6MREX8WKXJj3Ua2RXh9tAsEA8N+sVKN
         oS3GfK7c/0AJTjvjOHmr3BT2DwvJ74h2Nwd6L0yavjGcgHNOdSrkFS1mSHlQ2BUcrp1I
         NgchD6AICpaILqNE3HrnrPVUPs8qg9y9K7kIZlcl9E+GyXg/dIdsUZzPlKVbeKF3t2lT
         jEREjIg8H01PSJ8mRPs0kaYvK9kRxas3IkDxE2+s8RlMeuytNTVf/+YaKU/7X47AUkyN
         S5BUPhKoZdOAt01NuxrWanyaPOKZbN24cl72I5TYC6ex9WRWRqF3hltIM76l1IeN58ID
         mFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741095833; x=1741700633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ciUEmziHwKoR8EZ15kFmNQQUeftjWJUBtJzEaxlx9Y=;
        b=d8eXE4Hpf/r6Blj7ylE9LbeUcKrzE/EHG5K9VSprtzNuvJVPhyJLZ57kaJwVSkbXiJ
         6qrh7HjbKVu2p1o1JEhqPOy9VtWotjYmcIsjxefrrWEztDrR5ZDmV/Ts21JfyMVZEVUk
         P/NPdMsLpcPgZoDAcejygr6sxBUze6AtRwpm1VnYuaCDMt/CQfTfxpmV5HGGsTMlHeP5
         K3EqwL/KywIM4l+uojAB8CmLvl3ORLoaS6jxpX4hN11fLI8+frlyEt2/KOtbpkTsbEPK
         gweOa/SyMZJqVxU+Bv4UT960SXkA5j66m2k5cUuXTNTWDWxGaLroPe3njWCJJAr22W8l
         bQkg==
X-Forwarded-Encrypted: i=1; AJvYcCXSMSIzVAncWaE82f9vu2F9PWIPIRPn0bBX7AaU9lgOujXHLyhkxzkZAFnpMWWo7588HnoNynkaJ8EEtT8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NCCUs4zh/vbSNczaQdLm6LaF4lKVePvEe/muqhqjMZHMlnHb
	UPVTUrkBmw5NH4RTfJXFIXoxkFy1XbdsJrP7AwJvQDltaABjgM07xPYkAdKoYAd3ST1UgxkyO10
	SUuaXVptOqR4q16lhRQ==
X-Google-Smtp-Source: AGHT+IFHZt3BnQxTnjrinSVy1JtKhEMHkRg+LEokGOtmOBZxYSPyEETqTBFJckhElghvkIX1hmSvWSCVF9ljT4k9
X-Received: from wmsp7.prod.google.com ([2002:a05:600c:1d87:b0:439:88bc:d27d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f86:b0:43b:ca39:6c7d with SMTP id 5b1f17b1804b1-43bca3972efmr32164545e9.3.1741095833346;
 Tue, 04 Mar 2025 05:43:53 -0800 (PST)
Date: Tue,  4 Mar 2025 13:43:44 +0000
In-Reply-To: <20250304134347.369854-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304134347.369854-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304134347.369854-2-vdonnefort@google.com>
Subject: [PATCH v2 1/3] KVM: arm64: Add flags to kvm_hyp_memcache
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org
Cc: qperret@google.com, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Add flags to kvm_hyp_memcache and propagate them up to the allocation
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
index 1f55b0c7b11d..68d99baa76c2 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1086,12 +1086,12 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
 	}
 }
 
-static void hyp_mc_free_fn(void *addr, void *unused)
+static void hyp_mc_free_fn(void *addr, void *flags)
 {
 	free_page((unsigned long)addr);
 }
 
-static void *hyp_mc_alloc_fn(void *unused)
+static void *hyp_mc_alloc_fn(void *flags)
 {
 	return (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 }
@@ -1102,7 +1102,7 @@ void free_hyp_memcache(struct kvm_hyp_memcache *mc)
 		return;
 
 	kfree(mc->mapping);
-	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, NULL);
+	__free_hyp_memcache(mc, hyp_mc_free_fn, kvm_host_va, (void *)mc->flags);
 }
 
 int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
@@ -1117,7 +1117,7 @@ int topup_hyp_memcache(struct kvm_hyp_memcache *mc, unsigned long min_pages)
 	}
 
 	return __topup_hyp_memcache(mc, min_pages, hyp_mc_alloc_fn,
-				    kvm_host_pa, NULL);
+				    kvm_host_pa, (void *)mc->flags);
 }
 
 /**
-- 
2.48.1.711.g2feabab25a-goog


