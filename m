Return-Path: <linux-kernel+bounces-394926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 228289BB62F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545AE1C2169B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFEE84A35;
	Mon,  4 Nov 2024 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDVnZmJT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04E970816
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727135; cv=none; b=p5hhYwYaekKOm8pZuPMofk+U7+QW8w1K+KaCDxGDcJxXw8sf+A2Y2S0nxWhj+rW/VJQESd4ZC/qzX/bMv5i8IxPwmCrlIAq0dFdiJrlCtNI5CpuG35w4IAFBH9g70Zgq/GXO5OxUGuseEKW+KkErg+RO+Ih4wzBKeDYpFjcfoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727135; c=relaxed/simple;
	bh=JCsNEOwCob5F3IJKkBqX1lBcmUqiGgMoJBMXxpVz9bc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FG5hNTVnXlt9IlzhB9EUZBexpgw+TQMPfdRaiI511hygYdZVuM2Ln6VnXUnR/ogrpaTN+9/aK5rk6xSUlve0YSvzbk7hBYDf7BdysT/L40Ez9yKOG9qkRRF+hhp5duBMdyCdpEmAf+R8xPXtO+clHNbXGLpGtoxa7kZWwcEMBk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDVnZmJT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso6669690276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730727133; x=1731331933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PKkm6+349ykGA9NvXy7LF0BQjMAqTfQ2kTd431L999Q=;
        b=LDVnZmJTLm2KDBP43pzXYADIPBcQyXTcYGcoRcURPf0MwTCXwbBR/KyoE5pIa/3BbP
         hszIQ7AnrkS1ZgltK5brO5Kdwfn2i74pa+exanLh1AjHtKi70tybKhMTvV71JCiY1oVI
         UOGO39MB4ea6pilw3YMVmDYTTnKQMBTIICGTGPsYgMhcJaPEppGpkGsziPVhhSkGi9QF
         J1uMVnw7LcBj9r29T+ReajcaT2drRjYffYtZwOsOGGOSpLaiYTZKf2cbIKGRju7QWZQl
         DjYv2rn7ErKkx/lfSIo4ow0DsLn1piO7Uok5LsFOPrQtGwTnp/+RJc+4DPf7HymFu3dt
         5xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730727133; x=1731331933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKkm6+349ykGA9NvXy7LF0BQjMAqTfQ2kTd431L999Q=;
        b=M2LJWJuqusKXw4bq8TqxUVbzav2cWS3d7kMx9aTzX9uueh2I8g/5SNSRTHkFkeyqU4
         aNe9zdung0j5kKK1iFSTM83FSCt3KMXiGRVWRCOS3nwediJ3pKz5DdZ4AJTcySkZ8ywM
         LFXYKZfvi8JOYmPeoFF5LWLSKWGa1fPA/TPZ7680UMb6YKPwTtOuzuTBgLiYb0LEcMCF
         X4PcSr+XmXR6fN1pch2178dZcqX7rQrI5h9p9n//reZpcv6/XJFHOp0e033AHuvllwAk
         +ecjCjV7nSWKMMBXxUg+ZhBdE2uMzFtC6QMLQAhvMJaUGUjn+/hsh3MOZ335fmVFIP7d
         Zemg==
X-Forwarded-Encrypted: i=1; AJvYcCVz7lIVfW7KpQamTcLMocFlNF3wasqlFwJwERqhLmX7YCzv4/ZjCi1G75buNiMOFTIrvbGig1DPLjOWSlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWH5GB4tqP27ZEz9iHREQRfWUVuvRzZ9lcJiiisMqEDTt8Jsi
	VLSh9zS5aY+5waM/KDXXmNIZYCIrs/FuH+3eibPinJ1VeFwHzJoJfNW/ynNH1zpGxNYxwylTbhi
	Mr58G/Q==
X-Google-Smtp-Source: AGHT+IEeIacQkmxOu92UwsFG/d4mBUfXOkjaaTFyk9RQX+gm0U4bljU3gFu+U2mMY/h3tB6h+FVJRJ+qoRNf
X-Received: from big-boi.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:129])
 (user=qperret job=sendgmr) by 2002:a5b:f0f:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3087bd5414mr144751276.6.1730727132285; Mon, 04 Nov 2024
 05:32:12 -0800 (PST)
Date: Mon,  4 Nov 2024 13:31:48 +0000
In-Reply-To: <20241104133204.85208-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241104133204.85208-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241104133204.85208-3-qperret@google.com>
Subject: [PATCH 02/18] KVM: arm64: Move enum pkvm_page_state to memory.h
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In order to prepare the way for storing page-tracking information in
pKVM's vmemmap, move the enum pkvm_page_state definition to
nvhe/memory.h.

No functional changes intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 35 +------------------
 arch/arm64/kvm/hyp/include/nvhe/memory.h      | 34 ++++++++++++++++++
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index ca3177481b78..25038ac705d8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -11,43 +11,10 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_pgtable.h>
 #include <asm/virt.h>
+#include <nvhe/memory.h>
 #include <nvhe/pkvm.h>
 #include <nvhe/spinlock.h>
 
-/*
- * SW bits 0-1 are reserved to track the memory ownership state of each page:
- *   00: The page is owned exclusively by the page-table owner.
- *   01: The page is owned by the page-table owner, but is shared
- *       with another entity.
- *   10: The page is shared with, but not owned by the page-table owner.
- *   11: Reserved for future use (lending).
- */
-enum pkvm_page_state {
-	PKVM_PAGE_OWNED			= 0ULL,
-	PKVM_PAGE_SHARED_OWNED		= BIT(0),
-	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
-	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
-
-	/* Meta-states which aren't encoded directly in the PTE's SW bits */
-	PKVM_NOPAGE			= BIT(2),
-};
-#define PKVM_PAGE_META_STATES_MASK	(~(BIT(0) | BIT(1)))
-
-#define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
-static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
-						 enum pkvm_page_state state)
-{
-	BUG_ON(state & PKVM_PAGE_META_STATES_MASK);
-	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
-	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
-	return prot;
-}
-
-static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
-{
-	return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
-}
-
 struct host_mmu {
 	struct kvm_arch arch;
 	struct kvm_pgtable pgt;
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
index ab205c4d6774..6dfeb000371c 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -7,6 +7,40 @@
 
 #include <linux/types.h>
 
+/*
+ * SW bits 0-1 are reserved to track the memory ownership state of each page:
+ *   00: The page is owned exclusively by the page-table owner.
+ *   01: The page is owned by the page-table owner, but is shared
+ *       with another entity.
+ *   10: The page is shared with, but not owned by the page-table owner.
+ *   11: Reserved for future use (lending).
+ */
+enum pkvm_page_state {
+	PKVM_PAGE_OWNED			= 0ULL,
+	PKVM_PAGE_SHARED_OWNED		= BIT(0),
+	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
+	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
+
+	/* Meta-states which aren't encoded directly in the PTE's SW bits */
+	PKVM_NOPAGE			= BIT(2),
+};
+#define PKVM_PAGE_META_STATES_MASK	(~(BIT(0) | BIT(1)))
+
+#define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
+static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
+						 enum pkvm_page_state state)
+{
+	BUG_ON(state & PKVM_PAGE_META_STATES_MASK);
+	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
+	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
+	return prot;
+}
+
+static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
+{
+	return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
+}
+
 struct hyp_page {
 	unsigned short refcount;
 	unsigned short order;
-- 
2.47.0.163.g1226f6d8fa-goog


