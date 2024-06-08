Return-Path: <linux-kernel+bounces-206852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD701900EC3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 02:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D781C210B2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 00:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569DC2579;
	Sat,  8 Jun 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TILMNDrX"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642C417F5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717805472; cv=none; b=Llx1BxhoU7j7trklunyOFv51XMFmkMVzAlE0zP3+5bSkdP7JZIguGq3uasY2zWNtjQ4BMAGxj+sfJd2kB7BesAKKcyvL6Xg43xv8bBs4XOW3EtY394OBeNCNzUN402zdWhyVlqfO6bhIpSrYULlWcTxwf5DEmgIroYYZdikbIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717805472; c=relaxed/simple;
	bh=vWPGDr0VAOnNNuqxYO9KemOUnDeq1bzz8spYQseOLoQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=csB1+dOGBC+9FpFOeCwlqULdY6/iGbm4zwjqg1CqX3s2USI3/4SOLTKRtKJWfsvJA92N5+5qVyKANUapY9goDgORztwooMBBGXxI5bHCjfHGgCEjnFcbutu7HKoMaIYk73s1m3jvlf6zzlNSpN9rGT3uSxOKg1MbVq13V+pujIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TILMNDrX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7041c30c0b4so710038b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 17:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717805471; x=1718410271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1D7CxmQOWEB+afJq8q/LjLb1nA3G9jvJYdupVYkAuw=;
        b=TILMNDrXFVEhm9Rf/NiMcpZDXlaxqwagc4Dy3EtW0YecdSVAJxCtfkLMScMHs6Z8Da
         +5X19Y0Af64RxgVLOcxT9Ajq8z2j2oJD85YvL0WPYWqsFjBfUqHjdA6Sg6dJI2MsaA94
         /0wlQ9HS+c6uh5nz/vUiHMQYBz6P/A4KDdwyxhPYHpu8c4VlVREEWV66i7Tj9NvgyeoD
         MDg3Sv56PiNuHtg4SPlzvqKqa+wUCLYb75Ux4ZA3rzUGRJdhnqSuZepwnljAw7/Ws5A3
         n1KfiiJDIgTb4ChRfiNf9QYONZilLYwLh0MMsIuG9G+RF6b/HeC+tWqOdf3WWsB6Ebh2
         sZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717805471; x=1718410271;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1D7CxmQOWEB+afJq8q/LjLb1nA3G9jvJYdupVYkAuw=;
        b=QbiLX//ofhVPXcfgNwecj1KhvDL8sd9DcjGCjrkTm4dhTm9cJtRad6ufZ8no14EP7p
         UQz5lFuQDnw+3IPVJ1hDYnPU9ck1i/4jj1QNo3JuDYDVSLneGqOK8bYAT27VizNI/GtX
         UEldu19Gt50U1GIB34VBlRKEPESyiOKJQlGbS2iBtXcm5LTxCytFunkAF4VZTK6lr5ZI
         4lSFZVB8jj/qaAxNSV3fbJ4qQ2dn8OCzR8IE7wjpcCkpJhXDFYvupwhmoDCGOJzVxKY6
         j7JdRuQILrM/PpZkBEJlZlCBy8u2bBIQgDKB421LNQn9xSegK0QhzmvlY2B7YZa5/Qca
         Dtnw==
X-Forwarded-Encrypted: i=1; AJvYcCWsoG1Btztt7Aq+TSdyFHIMxzNU88FDgOdEmrN8Bz1+t/noofvxEwYkhIzwrCTiAVtW8SmzBe6jGLZb4KtgxyP4wXWnyY25l7frkCzB
X-Gm-Message-State: AOJu0YyTcIab1QTVZYdDS33/uZ1Yh2ps0Rb/PaNIEfoBYBfHbTxTlS5r
	Tn251j0zjvDBZaDRMWjjxIs8BIP2GxEejj0GjMIqIaZVjEIE8Nk79U0NLggdJRO8Ue23sdMOc9l
	Xng==
X-Google-Smtp-Source: AGHT+IG9PBzMAAZoiZyf0Ifd3jc9ODlYrgfiGByUvwS7iZ7SJgKLrOSsaQR9jZWzB7+o1o0N9vRC0QHSiDE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2e9c:b0:702:2ab4:b12f with SMTP id
 d2e1a72fcca58-7040c708fa2mr16072b3a.2.1717805470628; Fri, 07 Jun 2024
 17:11:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  7 Jun 2024 17:11:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240608001108.3296879-1-seanjc@google.com>
Subject: [PATCH] KVM: x86/mmu: Rephrase comment about synthetic PFERR flags in
 #PF handler
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Reword the BUILD_BUG_ON() comment in the legacy #PF handler to explicitly
describe how asserting that synthetic PFERR flags are limited to bits 31:0
protects KVM against inadvertently passing a synthetic flag to the common
page fault handler.

No functional change intended.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8d7115230739..2421d971ce1b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4599,7 +4599,10 @@ int kvm_handle_page_fault(struct kvm_vcpu *vcpu, u64 error_code,
 	if (WARN_ON_ONCE(error_code >> 32))
 		error_code = lower_32_bits(error_code);
 
-	/* Ensure the above sanity check also covers KVM-defined flags. */
+	/*
+	 * Restrict KVM-defined flags to bits 63:32 so that it's impossible for
+	 * them to conflict with #PF error codes, which are limited to 32 bits.
+	 */
 	BUILD_BUG_ON(lower_32_bits(PFERR_SYNTHETIC_MASK));
 
 	vcpu->arch.l1tf_flush_l1d = true;

base-commit: b9adc10edd4e14e66db4f7289a88fdbfa45ae7a8
-- 
2.45.2.505.gda0bf45e8d-goog


