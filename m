Return-Path: <linux-kernel+bounces-429251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE99E197F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9170281D9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09D1E3779;
	Tue,  3 Dec 2024 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hs+huc5V"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF101E25FB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222275; cv=none; b=uGAdHkeUWMW2NHNVVqh/nI/ZTNbn7kDiYAIL7iAYgXPY6XrozVE57yTuaV7PR4TBxatB5F0QBWSTcfx6VpkLPiqIpDgRk/C8Yi8FhZjjQVhnLybbsgcIkZPWLhcbDH1qKTQ7m5sV83p5GKuzC9WFPZEht/i1bHg2y7Lo+XkD/+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222275; c=relaxed/simple;
	bh=lJYxg2ORZLoU4C32XfNiVx3N75+98ndLA0eq7VTKcZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CmpjsEMSJ3DXES8sundIgTC+Y1y88Qoe5MtBdxMu4oy0ciR8wSdVaAchQ1lZav+2Ex8cPiaZcb34OlBI+zzpjQYZnfUKlilCOuCrDWD/0iqfTFA5g+0iZbJkrAuAqY5zksOTCC38pMPcYlk7YmnweIY2/VGp0gdZhC/LavPAujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hs+huc5V; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0d322ce63so2425948a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 02:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733222272; x=1733827072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RoLTpcw2i/ARiDDfP5KR0JIwlxbCPGGxl8N0KcEuWeM=;
        b=Hs+huc5Vtm8lNkt5w3DLHg9boTbIPnZDXOyKA79SU+8/3gBKimxFf5kFlvFmmN+2IR
         hbS9D1gGkA/Q/SiysN+3315X5roPJ2oVkIXRy+WF+VtvKC6gKbz8cctTsvSxM6aO5wMX
         NltGRiQemogavvLy7M3ClmhoeKfrVIEL1ImLU8pVTr5q+Xt75P2O40Co+98C03L9j92B
         0C9vOa8dyScGR+GZA+demiCBGSc7dQ6dnd1709PH2IwIbYpF2jA9JTiks2rbWyDnHOMq
         46E3q5oChr3Spt3nOBxoeKtxG66yPolI4vOuR6rTBy6xyOJD0lb7shU7nG/kK5vjaggC
         xgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733222272; x=1733827072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RoLTpcw2i/ARiDDfP5KR0JIwlxbCPGGxl8N0KcEuWeM=;
        b=RSwxB3/Cdu7xZjQoqz9XCGPpz20IKz/rEE9d4psm0mFXc8XZDLSlJ9N3PBtEHWSP9E
         nkCiuqckcx3C6KGjLq+BfHfjMg8J5iCjnbXyApcrEyhtCioo3GJtlYrjFQRlL8cFMvUs
         onKu4l4m+3St6b75fW60Og4GZ89FHrDP0alrZGLrDPfOcahsJL9FbgKfgCEWmbucfhXl
         6IlXx+pqr2GJQOErzvtaEMX+joN1l5jR8s6vcVtMKsLbxRhxHz5qrOlS5F6N2dRSK3t1
         aXkfSu8g/8qlihR5wOVyZtalHyg/09BKGRotjd2FovtwGRQ0kKMjw2deBbnGzr+uSHHP
         Rmhw==
X-Forwarded-Encrypted: i=1; AJvYcCWpRrwGFgShF4rBh7u+3HIytjqRUjO3oFbQCj0jQVCLRPAsJdVZqOmHUaFgbO2wRBoi32hs/RyC566rIWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pFUlt4kLiKesM6B7zG2398YFVp9U0tYZITXvcUWGXP4Obw2g
	CabZsD0BUsA0OCURhhOvKGROfVasrAczZEoyhCCCVKvsqT01P5G6h/qj0ztG3VC+DO6MY+RbD91
	mkK4n6Q==
X-Google-Smtp-Source: AGHT+IGydksz2oitkkS+PzunE3Xo1LLjOTwrM0JRUgGZOInmX86+vMlVFPZJqRfsJ77VjfmAauob+8D8Wh13
X-Received: from edtw23.prod.google.com ([2002:aa7:cb57:0:b0:5cb:ee45:27d6])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:27c9:b0:5cf:924f:9968
 with SMTP id 4fb4d7f45d1cf-5d10cb4f7c1mr2156507a12.2.1733222272258; Tue, 03
 Dec 2024 02:37:52 -0800 (PST)
Date: Tue,  3 Dec 2024 10:37:24 +0000
In-Reply-To: <20241203103735.2267589-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241203103735.2267589-1-qperret@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203103735.2267589-8-qperret@google.com>
Subject: [PATCH v2 07/18] KVM: arm64: Make kvm_pgtable_stage2_init() a static
 inline function
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Turn kvm_pgtable_stage2_init() into a static inline function instead of
a macro. This will allow the usage of typeof() on it later on.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index c2f4149283ef..04418b5e3004 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -526,8 +526,11 @@ int __kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
 			      enum kvm_pgtable_stage2_flags flags,
 			      kvm_pgtable_force_pte_cb_t force_pte_cb);
 
-#define kvm_pgtable_stage2_init(pgt, mmu, mm_ops) \
-	__kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL)
+static inline int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_s2_mmu *mmu,
+					  struct kvm_pgtable_mm_ops *mm_ops)
+{
+	return __kvm_pgtable_stage2_init(pgt, mmu, mm_ops, 0, NULL);
+}
 
 /**
  * kvm_pgtable_stage2_destroy() - Destroy an unused guest stage-2 page-table.
-- 
2.47.0.338.g60cca15819-goog


