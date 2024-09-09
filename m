Return-Path: <linux-kernel+bounces-321377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B709719CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669D31F23470
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C21B86C3;
	Mon,  9 Sep 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBrV+HtL"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9121B78FA
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886049; cv=none; b=GcN+nfd2drF7xnkf7XoTjXfwBAOQ0Z6QitqwL6OI980eVtXjDTWlwr9ZFil32kXobaniVP8e5j0U7tCilT2TKonjIC6u3OE8/ADs0XC9lfBBGv38N4tHWuEguBT9D993Js1cxZGTpXDFhiVxflUhFn/e6zSXvIlE3wpJjMyq7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886049; c=relaxed/simple;
	bh=HPr21emQzpEuVlDmp/qQjpu5BVkYPBhIboCvezWrCNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iYp7iQHvOTgkPdV9NIpTAFboQQu0CzCDwEv4s3eN/VUC43iD9Sgx0KgZ0bK7yB+ORvOdYiZUsLwnFGgubvO9ESle2XUjEjoPmvSN8FVPlLbWmsf8yMeTKJa/0xPy+G95iVXfHJtjTSBNN2urMA5C4y69lKC/me138u21cgqKxcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBrV+HtL; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb827e9b6so7465295e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725886047; x=1726490847; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKJ1NP3DrAm45Ot6yL2cReAMG8qo73bbwYgKiOjz384=;
        b=bBrV+HtLAKiBnJYjNYS2770a543tqIFLYF64nZDbZd6wVrnEQxHRmWtmbkPAEyiLdm
         JeskoS8JhKggVYJGS6q3o9wA0cxmPuMkljIf4KcOdDtZ+OCoqRvNBdTa0ajApTePHXda
         RJQHQOw/Rp4NkYqqlN61bh0w2kEyc5lt1C78oOzbepG3eZADNncpkw4wEwTh6qvHEVKy
         mqFYjnK2uXqmzFElSEXJj0eYErN4DUWxIysYo2YfPVsOP9o/1DaguMBvepYA8Tnrln2d
         FIJ/imdE9ZlC7nNRiuPl1a3yjFXvik9l0S8/XLAaHUSr77r5gudiDZUOuBgTh+IIgOaC
         sPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886047; x=1726490847;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKJ1NP3DrAm45Ot6yL2cReAMG8qo73bbwYgKiOjz384=;
        b=cqnP6UyfJDytU5YwVSgTH+E8ER0lSEPioesD/9LKP+V6UJxIsP3Gbe2NeQbM0VO2es
         W3ifG8Gj9zTHVKZJ1A2yMdG+DBw2QsTrxn4IQGZh1aADfeR76T/mL1348DdnTCPMoyT0
         osb3+xn9sQqlGKuFdEZeuJmB4+2swjFNnRQ8MiIZz54YmKooQYYNHtUDJQxDXDN0ess4
         yuXHK4pVeQfdJvORA43Fp3V3FoKbt4bGgBbQhuKSouULOJwlS315AGE/WqroX8zNbkKj
         cKqt6VZwY9nseJfxYpgStgEhniNmUB8jGuOr/PGL1surx53poDKleVNECJY+s9lIg3nJ
         YiVg==
X-Forwarded-Encrypted: i=1; AJvYcCVQZBjagDxWc4Lk8JIfDawIa6EuO6DKEvblFBQg6Xd8CTBzlz6loNYat4TLNSF83gG7NxhAScT//QGKgbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9LXEoAmQGIcmzeryWtQ5ektkjkK5RYxyvoIEgvrZH4vkbSloz
	BLu/AbrfBS0YckbyIcgEeaU5Wbie17kqKU6PQUrB3qpFF081+pTTMvpbEw/d6O1N2skz/tCM6u/
	QG9l8sZ8v3PgOC/kMZxcgo/cqEw==
X-Google-Smtp-Source: AGHT+IGB9bwzA+fwuWPOhmU2PE2PuSrdb0vA8nxugJEsLMz4E+4/m65aP47k2xrfDB7zI8uLZNKmhk8HfA0/HNK+S/I=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f1b7])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:2d8c:b0:42c:ae30:fc33 with
 SMTP id 5b1f17b1804b1-42cae30fd4fmr872025e9.4.1725886046868; Mon, 09 Sep 2024
 05:47:26 -0700 (PDT)
Date: Mon,  9 Sep 2024 12:47:17 +0000
In-Reply-To: <20240909124721.1672199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909124721.1672199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909124721.1672199-2-sebastianene@google.com>
Subject: [PATCH v10 1/5] KVM: arm64: Move pagetable definitions to common header
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

In preparation for using the stage-2 definitions in ptdump, move some of
these macros in the common header.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 42 ++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/pgtable.c         | 42 ----------------------------
 2 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 19278dfe7978..03f4c3d7839c 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -59,6 +59,48 @@ typedef u64 kvm_pte_t;
 
 #define KVM_PHYS_INVALID		(-1ULL)
 
+#define KVM_PTE_LEAF_ATTR_LO		GENMASK(11, 2)
+
+#define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX	GENMASK(4, 2)
+#define KVM_PTE_LEAF_ATTR_LO_S1_AP	GENMASK(7, 6)
+#define KVM_PTE_LEAF_ATTR_LO_S1_AP_RO		\
+	({ cpus_have_final_cap(ARM64_KVM_HVHE) ? 2 : 3; })
+#define KVM_PTE_LEAF_ATTR_LO_S1_AP_RW		\
+	({ cpus_have_final_cap(ARM64_KVM_HVHE) ? 0 : 1; })
+#define KVM_PTE_LEAF_ATTR_LO_S1_SH	GENMASK(9, 8)
+#define KVM_PTE_LEAF_ATTR_LO_S1_SH_IS	3
+#define KVM_PTE_LEAF_ATTR_LO_S1_AF	BIT(10)
+
+#define KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR	GENMASK(5, 2)
+#define KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R	BIT(6)
+#define KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W	BIT(7)
+#define KVM_PTE_LEAF_ATTR_LO_S2_SH	GENMASK(9, 8)
+#define KVM_PTE_LEAF_ATTR_LO_S2_SH_IS	3
+#define KVM_PTE_LEAF_ATTR_LO_S2_AF	BIT(10)
+
+#define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 50)
+
+#define KVM_PTE_LEAF_ATTR_HI_SW		GENMASK(58, 55)
+
+#define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
+
+#define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
+
+#define KVM_PTE_LEAF_ATTR_HI_S1_GP	BIT(50)
+
+#define KVM_PTE_LEAF_ATTR_S2_PERMS	(KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
+					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
+					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
+
+#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
+#define KVM_MAX_OWNER_ID		1
+
+/*
+ * Used to indicate a pte for which a 'break-before-make' sequence is in
+ * progress.
+ */
+#define KVM_INVALID_PTE_LOCKED		BIT(10)
+
 static inline bool kvm_pte_valid(kvm_pte_t pte)
 {
 	return pte & KVM_PTE_VALID;
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 9e2bbee77491..c3e9d77bba23 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -17,48 +17,6 @@
 #define KVM_PTE_TYPE_PAGE		1
 #define KVM_PTE_TYPE_TABLE		1
 
-#define KVM_PTE_LEAF_ATTR_LO		GENMASK(11, 2)
-
-#define KVM_PTE_LEAF_ATTR_LO_S1_ATTRIDX	GENMASK(4, 2)
-#define KVM_PTE_LEAF_ATTR_LO_S1_AP	GENMASK(7, 6)
-#define KVM_PTE_LEAF_ATTR_LO_S1_AP_RO		\
-	({ cpus_have_final_cap(ARM64_KVM_HVHE) ? 2 : 3; })
-#define KVM_PTE_LEAF_ATTR_LO_S1_AP_RW		\
-	({ cpus_have_final_cap(ARM64_KVM_HVHE) ? 0 : 1; })
-#define KVM_PTE_LEAF_ATTR_LO_S1_SH	GENMASK(9, 8)
-#define KVM_PTE_LEAF_ATTR_LO_S1_SH_IS	3
-#define KVM_PTE_LEAF_ATTR_LO_S1_AF	BIT(10)
-
-#define KVM_PTE_LEAF_ATTR_LO_S2_MEMATTR	GENMASK(5, 2)
-#define KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R	BIT(6)
-#define KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W	BIT(7)
-#define KVM_PTE_LEAF_ATTR_LO_S2_SH	GENMASK(9, 8)
-#define KVM_PTE_LEAF_ATTR_LO_S2_SH_IS	3
-#define KVM_PTE_LEAF_ATTR_LO_S2_AF	BIT(10)
-
-#define KVM_PTE_LEAF_ATTR_HI		GENMASK(63, 50)
-
-#define KVM_PTE_LEAF_ATTR_HI_SW		GENMASK(58, 55)
-
-#define KVM_PTE_LEAF_ATTR_HI_S1_XN	BIT(54)
-
-#define KVM_PTE_LEAF_ATTR_HI_S2_XN	BIT(54)
-
-#define KVM_PTE_LEAF_ATTR_HI_S1_GP	BIT(50)
-
-#define KVM_PTE_LEAF_ATTR_S2_PERMS	(KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
-					 KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
-					 KVM_PTE_LEAF_ATTR_HI_S2_XN)
-
-#define KVM_INVALID_PTE_OWNER_MASK	GENMASK(9, 2)
-#define KVM_MAX_OWNER_ID		1
-
-/*
- * Used to indicate a pte for which a 'break-before-make' sequence is in
- * progress.
- */
-#define KVM_INVALID_PTE_LOCKED		BIT(10)
-
 struct kvm_pgtable_walk_data {
 	struct kvm_pgtable_walker	*walker;
 
-- 
2.46.0.469.g59c65b2a67-goog


