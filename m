Return-Path: <linux-kernel+bounces-429246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4448B9E1AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA298B3AEAC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C391E283A;
	Tue,  3 Dec 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qw6OiG3S"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE981E260B
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222264; cv=none; b=fn9zJzUdxv5o5aZ3hOMqvoI6jc7WY7aQGSqimI3sFqqP9EWwuphf5Kd1MEVgDLDq3x/6rt3tJgHcGkR1/c3XPRL0vuRZtSCkBOKFjN7Zg2Oc4QIQ2Zuz/ySB4F7lWilV84oUFExqaw2M+RDnb4tnh0uTKzRqkeJCtT+YexipJb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222264; c=relaxed/simple;
	bh=8zlhOfilNBPHbTyk82/DPjfRWwwj3ZA1xBzeIbJgyAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uOGBcLba92AB/S2SRqQ7hU476GQafE/eQR6ZfSn5luxXhUk7e1ds0d0SBCEI7+uGrKQqeGvHaxVEcjAJB+qcoiBBvH+Z/d6lhk0OYI2fEa6UHkQJEgdfmmet01W8xsZLQZdeN8vqT1igjVzeh8GfpsvpVZc4o7OwQN5Fl4p9EgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qw6OiG3S; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0d329cea3so1972930a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222261; x=1733827061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8VefaN+uYOgTsW1Gl3aOfwIF+ybrZqn9BRXod1CkyGg=;
        b=Qw6OiG3Sqzzh5vGOLnb2oaVJ4OBwpV6QEdNelBL65qIZwJbJz7019wNgbMQAqRfRXx
         iY+hfLQj6YfgzWKsStXHf5dYIjmXFSUJTGMuOSsOGx27xBnR9FjB6pS1IeKwuQX9X00v
         cNYYF1mu5jnyo7LfSho+9c0i1KdlujS+5AJPyi3pR9+8DZr9A7DPm2ZgMZ9xuaKgXjG2
         aVAWwVJ9a/fDLDbycijP6VKeDC5kNSNxbcnoQV55GiHHIgZ1kLKkK4aBykc/zZT1IK4H
         j8HYrtYpGnXw+bR4N0/RKY7LJN6uVuiqOsux0q3Zejo2Y5PIwDhrdqPb0NAUi6bo4EMA
         Rasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222261; x=1733827061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VefaN+uYOgTsW1Gl3aOfwIF+ybrZqn9BRXod1CkyGg=;
        b=AEGRjjHlMaVeqaEXWI21Du5ATbH/0Df069kmKhjfF82APqglg1Y/8sqfj/noODlaZ+
         MCRsZTo8YyWr8+M47lNReHlfUoJE1hzgtop10tkM5Kvt5/r53Ob6cqDeBf3Ly+HQdl60
         S8nOWyjIaxpj7vpH7HxIXndaKzNlO4SDQqo5H9Oow5sn4rgvuhfPrfsE3pwnOCwnK2Pf
         n+ZZvYfFvNl3mz170L5VAViBYbjC+L03bbLzeXb6wIw9dmzsrqxJAOT6nLZoQIq05p0E
         fb9ErSWr9qXel79uDGzQ5zRYhjEqGqrUVrcBVvOTs1CEW15DHVd+D5BqpiH8opn2uJoP
         TB9A==
X-Forwarded-Encrypted: i=1; AJvYcCUB4+c+sUt4yr4E8zYoLGQwntEC5BuecDxqwnsYRDRPHjAWjzWFf719Wcm9X9q6f2sHHFd5gopnzmqFBKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4QSJP13RZu2OPXvCeZ4EGS5kCVD8ljJdPJStPpNXXhE9QVJo
	k0v3HuCXClDpWQr7gwNyWaX0MiFaYA+/yCT8D7gjmX7yLF2gBD0Vjyg+VxOLTHS+7CrM0mFkt5+
	z0j16Sw==
X-Google-Smtp-Source: AGHT+IGE5QTCAH5U7r3oFdzIO1ntikDg2nD7iaMmA+2JXan6nFEy0acuL36E+ffU/jQD6HNvAgowxLrE1pEQ
X-Received: from edxa18.prod.google.com ([2002:a05:6402:13d2:b0:5cf:b86e:9cac])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:51d0:b0:5d0:d84c:abb3
 with SMTP id 4fb4d7f45d1cf-5d10cb7f906mr1537351a12.26.1733222261602; Tue, 03
 Dec 2024 02:37:41 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:19 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-3-qperret@google.com>
Subject: [PATCH v2 02/18] KVM: arm64: Move enum pkvm_page_state to memory.h
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
2.47.0.338.g60cca15819-goog


