Return-Path: <linux-kernel+bounces-359767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 921CD999070
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485EF1F25440
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8E1F8917;
	Thu, 10 Oct 2024 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4VD+bqQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD61F7088
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584739; cv=none; b=RXlWsNg5hlfQOkdUTvv51MPxQEDNfZhDTUdxjxisJpHafUr5trPMlenouV/z0vKDgmtIqX2Is8rLvgUtWQbvGWrRBHWKGT/lmgpk0QZ6bj4ghDWWCHS5VrdWWD7dZpmAPptEbrfS4fEwAyR7RrIYoWYHdPHnQhJ3o8r6CXxVrdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584739; c=relaxed/simple;
	bh=w6CtoHT4iiBJ8oKluaibldhSnM94wRba+mvcEkROyJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liPoGHhPf0hAr1yR8rrDIuu5MDNOpTLJe9qZz5C5oq0TGj6Nyd/R8G89XLNfVT2r9RPJH9BEbhpp4qek5BwDjyPQ4k1eID5hSbqWqXeVZ8fAtzc3ibk3vUhYst1Nhi7GE+fDTSOkxD4pLlh3tib2tNXW54Fo0hItfit3Ki2Gcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4VD+bqQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so2179755276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728584737; x=1729189537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMgO/JDFhWAWu7Wkr7+zBWYfApHhI977J8rKw7ML51Y=;
        b=B4VD+bqQ1bv6Pf45zN8plQZ+1nlQIV+x2YTm+XE8/QAFyOT6pF5ri3atTDy7wmWK1W
         cBuNjj+RZcYpDljbhbOPdKgUEc6sxDbKrQJ1fcQGXI1ipHd31NNylsUJEh9353nqzmBe
         xErqAc5drpMhDXL6T2FAUVJtAVGGhL9gh8F57tSlbW7u9huTn8DSiVUEoNHxzP9tsAAL
         App72uklOszMQmpZcdIaLkjDcH7P4uuH5tw33U+NlFCh5D1Z5egpssNiIn5bx95a2D6u
         zh0dl5vUT4MDK4fiWa6tECFRTbzyA11CMn2YXNF224VvrXZcgmYLwkzQLjyWsiB0wLbP
         KAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728584737; x=1729189537;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IMgO/JDFhWAWu7Wkr7+zBWYfApHhI977J8rKw7ML51Y=;
        b=qrdaEc2BHgkmTJvcYVSAUmoillbOiO3S7GlwTWOv/pwJEkp6CpsU5KEudB8P1aq5Hd
         Pt5Y3ljkdTZ9EEts5c7dMemn5whwiewSgrexpG6HZa4/TH2V6RyBF4rMieav9Nh/kT7q
         pBE3TlG7qw8a3jNdTDu4DaD/HBMO0JLfxKiibMq2BopdDz1sWE0oCHhW2mSalVBVju8b
         VGcMTpdIl9OprSLgiUdBNdb2Of9S5LHDt183PStMDJoFafLw04p5IjNNVK09CBM4lHGh
         QZJ+Ad9eFpWp+YyzQIOVZhluqQO1KOGGdwFp/oy7/LibaSMDLyMFw6zYOlTrpwUQ1l23
         pqqg==
X-Forwarded-Encrypted: i=1; AJvYcCU+asxwIrS7DJU3GHmIlr5f+lUNbHSXkphYT5NVvsPdb5YdH5H+47uIVIZ0jRCWLgFMk/0leQlrLT4700o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVw7AbK6+R/jkxbKahjMSWs3ao14+DzPbeh0udGNUsw1W2KgmZ
	n8+0GpDAy9ZjlOCzyQFXphw2vznyiMY1/9ef3/ojxlQwsVl8rWoiovlZ3D9httJrEvqW2g2lXbu
	o4g==
X-Google-Smtp-Source: AGHT+IGlSN4X6DbrP5DPPe6+MPgoNlxMoOT3GZzpJV2jr+xnXsAJlzTjTlsnBYkwN+CsyuU9UJbLGW89hxk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:c70a:0:b0:e28:eae7:f84a with SMTP id
 3f1490d57ef6-e28fe0feaecmr5507276.0.1728584736880; Thu, 10 Oct 2024 11:25:36
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 11:23:23 -0700
In-Reply-To: <20241010182427.1434605-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010182427.1434605-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010182427.1434605-22-seanjc@google.com>
Subject: [PATCH v13 21/85] KVM: Explicitly initialize all fields at the start
 of kvm_vcpu_map()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>, 
	David Matlack <dmatlack@google.com>, David Stevens <stevensd@chromium.org>, 
	Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Explicitly initialize the entire kvm_host_map structure when mapping a
pfn, as some callers declare their struct on the stack, i.e. don't
zero-initialize the struct, which makes the map->hva in kvm_vcpu_unmap()
*very* suspect.

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c7691bc40389..f1c9a781315c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3067,32 +3067,24 @@ void kvm_release_pfn(kvm_pfn_t pfn, bool dirty)
=20
 int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *ma=
p)
 {
-	kvm_pfn_t pfn;
-	void *hva =3D NULL;
-	struct page *page =3D KVM_UNMAPPED_PAGE;
-
-	pfn =3D gfn_to_pfn(vcpu->kvm, gfn);
-	if (is_error_noslot_pfn(pfn))
-		return -EINVAL;
-
-	if (pfn_valid(pfn)) {
-		page =3D pfn_to_page(pfn);
-		hva =3D kmap(page);
-#ifdef CONFIG_HAS_IOMEM
-	} else {
-		hva =3D memremap(pfn_to_hpa(pfn), PAGE_SIZE, MEMREMAP_WB);
-#endif
-	}
-
-	if (!hva)
-		return -EFAULT;
-
-	map->page =3D page;
-	map->hva =3D hva;
-	map->pfn =3D pfn;
+	map->page =3D KVM_UNMAPPED_PAGE;
+	map->hva =3D NULL;
 	map->gfn =3D gfn;
=20
-	return 0;
+	map->pfn =3D gfn_to_pfn(vcpu->kvm, gfn);
+	if (is_error_noslot_pfn(map->pfn))
+		return -EINVAL;
+
+	if (pfn_valid(map->pfn)) {
+		map->page =3D pfn_to_page(map->pfn);
+		map->hva =3D kmap(map->page);
+#ifdef CONFIG_HAS_IOMEM
+	} else {
+		map->hva =3D memremap(pfn_to_hpa(map->pfn), PAGE_SIZE, MEMREMAP_WB);
+#endif
+	}
+
+	return map->hva ? 0 : -EFAULT;
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_map);
=20
--=20
2.47.0.rc1.288.g06298d1525-goog


