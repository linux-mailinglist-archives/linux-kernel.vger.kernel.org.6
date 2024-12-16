Return-Path: <linux-kernel+bounces-447875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1959F3836
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9086116D103
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9565420ADDC;
	Mon, 16 Dec 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4Mk3uCh"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FAC20A5C5
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371892; cv=none; b=JEoD04yv7FAXQZyFAqmdjHSlRd7GwXV+NAnt6LZpr8QVaYcTUB5zT58Id3dlYgxrglobv/kPH0DfoAqND6/MKXofRR7emqtcEpCzoHURr57TRUrGm/pmIx49RocNRQo+PH/7xfs7xVk+2YUFY4yL+cZdEYKJDUInknYIl2R5qZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371892; c=relaxed/simple;
	bh=YMN5nrVnm7MBUS1/MQRoHbk4AumZcaFpRHgZ3PnOdz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XZepQbctD2zOiy4UvHdS3PQ5tQYuJyU2PMljHcFCH6+MMcbrsCHsOtVzDPgCw01xs+Q/F3ilufz5GbEjy38zMPi27/eK6BqK5q4D/yW4qDnq4ovCYTY3YJD1bhnaA97BDMnOnkHeD/+RB2DmSWirneMsMTVhwtL6k+dJmlpsGyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4Mk3uCh; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa6845cf116so447105566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371889; x=1734976689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKKtybYMKA7zsu5unQStwbk02cJvQpLoCTe4uFlfQf0=;
        b=V4Mk3uChciZltD7l5mGDBoUkNV4Q4vm5SSAraNhF1rppuv3ioXyRHVa/vCFE5f3wJ2
         KtVPGmhsJOfDD11yfJ9eLWKHoI0agCDg+mr11zlBEv+/JtrrBarIakM7E3ASOFTYtt5/
         wkMeS9I3YtbsF+whi45MnMc3rHOeBawPfJDscj3QtjJvvDqdGZ+fQcZkLSJ3qstvs0Gs
         UUzMrBLFcnSaNMOYWDtft/8+QcwCGf/eeHr4aPEeur2GANUIbjjM15Oj2nY65wVkNYUR
         ZJ+KrHKdM2iAkS1O47bml/6RADtCIKdalrYGDlBjqav/OHuHoZ0AKKZRTqj36g6cdfi9
         kHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371889; x=1734976689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKKtybYMKA7zsu5unQStwbk02cJvQpLoCTe4uFlfQf0=;
        b=hQ0yTyaQ38AXeQCVrxl5GdqoUkau4gfWGLqLaIMu6q0OCbpl7puhhIaK9s/fjb75DS
         erKncjZNfDEUhKK35dCyhEONtRSnMReRV2q29rkr09rzv2ycomcsa6EFSAqdHj+pLJe3
         WoEYnuX4Ve3CjoO8o9g+zEgAirdaeJq4tLU/ar0t0cuHjlVsr80Gvae3d9kEI51p+RBz
         C+F/JIvlTbfkkfA7dqcNwRPAaPhfznZf1eU6pAjwTR8h1sur7w55/CHQ0OHEzk2I2/oS
         KEBxaJpv7QDpD8LIza1KqCESh+PGRluLFkDJaBnO5aJHRsSq/fCwO0baovqEw5Z2WpWX
         fwrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLs0KI6M0LCdlqC7DcynysvO6MnliSavWc00d79qxolMaGNXw764rFZZFPfYAe1wxv30BuwtbDw8Et4QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3tIV8WyZbhb2WZXdaSgmg7homWjiLm0eTsbFcqcQ1SfiFWCY
	eR/duY57iUk8ky+iWnnck6EQ0vykQ1RgPp1D6pCNQ813b44dzSQro354S50bIckUqjmjd0aulOu
	NRhFS7w==
X-Google-Smtp-Source: AGHT+IGNIsVt310HOq58YI6qOaJU0R9CQoXTaCdBST5eb3fkgxzHsq57oQwvG8ZxTSrd75RDqwWjPK4h1541
X-Received: from edbin5.prod.google.com ([2002:a05:6402:2085:b0:5d2:727b:9b35])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7da5:b0:aa6:9540:570f
 with SMTP id a640c23a62f3a-aabdc8bd0e0mr21397566b.18.1734371889630; Mon, 16
 Dec 2024 09:58:09 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:47 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-3-qperret@google.com>
Subject: [PATCH v3 02/18] KVM: arm64: Move enum pkvm_page_state to memory.h
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
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 34 +------------------
 arch/arm64/kvm/hyp/include/nvhe/memory.h      | 33 ++++++++++++++++++
 2 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 8c30362af2b9..25038ac705d8 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -11,42 +11,10 @@
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
index ab205c4d6774..c84b24234ac7 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/memory.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -7,6 +7,39 @@
 
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
2.47.1.613.gc27f4b7a9f-goog


