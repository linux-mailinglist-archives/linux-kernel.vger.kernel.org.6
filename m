Return-Path: <linux-kernel+bounces-447873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FBF9F3831
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8237A4587
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949520A5D5;
	Mon, 16 Dec 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGKtX90M"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA32207E08
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734371890; cv=none; b=jJeQrPbuVY80GqX2bsHsLHb9DULQ262mmDoPtQPd2IyhUS+5wgEpaQJf+MzHEQ2zGz5aoxLBOREjswyqIqo3WmgUfdONLI3C0vls3opZ4Apr9eY/oVdY2mRZ3QrHRACh9h0rSYOvn1JcOeB6bv+WC/mOh1aFnFv1GjABieyyo34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734371890; c=relaxed/simple;
	bh=c9TuY0JzEDJDlz8409s4LmorQWb/6VBYImcN+XUquJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=stYkfOdsj4rFrev/jf+jYP2eLmu2sNHDXGS5oNC3R/41s0L4rgnkzmoDhX7oWFWidcSQE5LDVVacQmG6QWgJqL2oDijKT+vckiaD4RV+dDwpvmQfn1/XiBZffMcrwt3lncXLvs72J/nAmZX6fJDSVVL5r/c5Or3ox38rnG9KYNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGKtX90M; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--qperret.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa6a1595fdaso338697666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734371887; x=1734976687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm077LWUklom1qgghNmApFcV7NaUdG/wSJAtTBhffFY=;
        b=HGKtX90Me03sH5ESKlNzm213I3Ji4tbr3MmaBBdz1RVy+a/w7iPV8Cg2OX6ArEt3DD
         yFS5uJU5jBbEae8PUP1gXURuflfRMOYn4eLxT45Df35YtjjbdUO1X18vYmzx9RUROtcT
         rJg6WkLP0jBrGLkthNJDbSio0fx4ci9IVC9EuvYgf/KHDRLoybpHMbhh5kzA469MuyOj
         pUulyW2gAj5kgff/0m4NXLJGq6aBMAZmTfBfghLg12ocqNPJ6bm17nSxS1svx73yuoQU
         xFDC4rTaVodz5Zd8vi+GKdl5grBHshdoEyqpMjq7mgMowpWuYvDwjvAfwrG7mc9GGEHl
         beDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734371887; x=1734976687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zm077LWUklom1qgghNmApFcV7NaUdG/wSJAtTBhffFY=;
        b=cV/pgcUYyl6ND7xyeqj2TO1WY3VVBQQSYHP+WW3Aq8/bRqO1OMPBvpGghCWji3pv2A
         +270yQIb1D5wzFFPKlipW/Hs6izze1aKyh1MDPPbzavfREa39i1GyQvb4KGl0rnWtm98
         KmJYOZ7aIBN2kty03xejfYaaRwEIAJRtkthFtEnNFXCTxL05kWE9Eta4vJHhU1k+eEh2
         gEneRmlB6x382JjP/N9P4uxVklB73f88iWVbu3/e/QMY/IwQukfVoztcBzi0baV/nNcD
         IhbDBCAq+CFf6Wj38XqxLaihyjtIKVA90GFZkTpaUHgw89+oEheIXlTbw9igTaetFSTe
         RexA==
X-Forwarded-Encrypted: i=1; AJvYcCUPafPmAnlslL1BOjUmAVnw8yFtlil4f2iPcbP1PIQ9avRfA9M6b9zfbvK38+phHLtA7uNshxLWZVBTmOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3m0y6sJCCVWtuTbABxY1yYA5a4SJyl3e69ETskZ67aGiyzwez
	fRHh+kJzedfqpL8L49GK7UPrkTcASKsfaPTEGPYxokL/KbMCVDaOiEYLtiv/2PSlYptjZ5i7exQ
	dIftM/A==
X-Google-Smtp-Source: AGHT+IHQ5oA98sWMNkT9FIe7HUKG7DjxRL6Q1mhzqfn466rudnNmwiDaQ8QrHj3NSSmISVUj3n4MBHY2yXmJ
X-Received: from ejctj6.prod.google.com ([2002:a17:907:c246:b0:aab:70bc:648c])
 (user=qperret job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:7ba1:b0:aa6:894c:84b9
 with SMTP id a640c23a62f3a-aab7795ff77mr1374185366b.23.1734371887552; Mon, 16
 Dec 2024 09:58:07 -0800 (PST)
Date: Mon, 16 Dec 2024 17:57:46 +0000
In-Reply-To: <20241216175803.2716565-1-qperret@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216175803.2716565-2-qperret@google.com>
Subject: [PATCH v3 01/18] KVM: arm64: Change the layout of enum pkvm_page_state
From: Quentin Perret <qperret@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>
Cc: Fuad Tabba <tabba@google.com>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'concrete' (a.k.a non-meta) page states are currently encoded using
software bits in PTEs. For performance reasons, the abstract
pkvm_page_state enum uses the same bits to encode these states as that
makes conversions from and to PTEs easy.

In order to prepare the ground for moving the 'concrete' state storage
to the hyp vmemmap, re-arrange the enum to use bits 0 and 1 for this
purpose.

No functional changes intended.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 0972faccc2af..8c30362af2b9 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -24,25 +24,27 @@
  */
 enum pkvm_page_state {
 	PKVM_PAGE_OWNED			= 0ULL,
-	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
-	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
-	__PKVM_PAGE_RESERVED		= KVM_PGTABLE_PROT_SW0 |
-					  KVM_PGTABLE_PROT_SW1,
+	PKVM_PAGE_SHARED_OWNED		= BIT(0),
+	PKVM_PAGE_SHARED_BORROWED	= BIT(1),
+	__PKVM_PAGE_RESERVED		= BIT(0) | BIT(1),
 
 	/* Meta-states which aren't encoded directly in the PTE's SW bits */
-	PKVM_NOPAGE,
+	PKVM_NOPAGE			= BIT(2),
 };
+#define PKVM_PAGE_META_STATES_MASK	(~(BIT(0) | BIT(1)))
 
 #define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
 static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
 						 enum pkvm_page_state state)
 {
-	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
+	prot &= ~PKVM_PAGE_STATE_PROT_MASK;
+	prot |= FIELD_PREP(PKVM_PAGE_STATE_PROT_MASK, state);
+	return prot;
 }
 
 static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
 {
-	return prot & PKVM_PAGE_STATE_PROT_MASK;
+	return FIELD_GET(PKVM_PAGE_STATE_PROT_MASK, prot);
 }
 
 struct host_mmu {
-- 
2.47.1.613.gc27f4b7a9f-goog


