Return-Path: <linux-kernel+bounces-281432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA2294D6E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BDD1F22F98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D919AA72;
	Fri,  9 Aug 2024 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hgK0uaBd"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5C19A282
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723230234; cv=none; b=AibHgS6Mp0OKCkh+f0+T3BjvrXktPwhI90dCCcrLjCayFZ66RXLn3v10crz6Cddrky9lz0S9r264ohSyz/v8l7IL/ALHH2T6CPJF86Kys02TUFLqpSjfQ11aKVwR7B/N1nQoDblgpbT61MGrWFk3MYmc6BaeRU8JesD0YM9ySnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723230234; c=relaxed/simple;
	bh=bRCd13k6i1A0U1LnG9khVbeFxffh10XZUO3UGsbmPjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dSFkCvREagetQBalKLVk1XJOFyyrdFWP7lubCvByrpasMjmHuSdIzMr9cZbuVBngbFZaZUNI2IQr9wdG1LtlCSsjcEAX8GDZQExm+i2uwMna7DDL/Jc7z6K8pILRvNbxGPygBKchlLgWIh7wIeLnBCVfTn3xP0FwM7UkYBW1piM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hgK0uaBd; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ff192decb8so25498625ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723230233; x=1723835033; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=i6No2hwzIu6e4YAJZs7ugQt7CXH2dDKyvdiMgrvYWso=;
        b=hgK0uaBd1RE+lf3DyVFJOV9l/j2RQdxqNqi358JHDxqzPCD3Tx+ZS5r/leMQduUrQm
         DnmQXl/xK4eJJD6gkoPt38xa2dt45RY50vSlpNA3F6oO4EwCCNl/GaoroNSm0kSpGLp+
         emlosudG2AzCn+Xh4gK/2eYKfFGUPafJQ7MWtDD4yowBQaEI/7hwX3sdjgiNYLf3fqa+
         t4VDfJtK3YvqRrNTjWtDc69t8FaOuK9TO56L7MuozAtt3qyWb8VTcV9/sP3CKx1CeCIT
         nVhRmuXfUZWcq/wCpvT6Fy7E/qAiy1VKKfCH9L7MwzpyJlo6YDMP0OQOEMp/Pux1gLOG
         h1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723230233; x=1723835033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6No2hwzIu6e4YAJZs7ugQt7CXH2dDKyvdiMgrvYWso=;
        b=nJ89PAZDGeQJ1KG3j/WT/5fW0wT5IfxVONzMuGNngZ/J1bvwMTh+MJzJ8DCQy8+ZNE
         X3qg09jDllD48hZ4a4VKdbGksQ+PnKtaGjelXtLh2+YOnYS3Q21wV5QHtH4HendCHqYx
         TtgmHDIVKmBV+DKv8/MvRtKB6k3uxfIOTyvhue6Pc1RaZ9PugYCQs0hwKLZ9a0bnrmtQ
         +E/NKB+oB9uYH1138dmQ+xbxh1iZjEr1vCKHHKkOGMloLol8qjpRy8notHHjBsEfMlhW
         eQlWEjiIW8myWkJxI03V5obUxrbS44N/GZdxC/z5O9WTtLacutGHZ/w5o77ty1qG+Zt/
         tUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXATwVhM1+My15iz+xBx/P7k4vZFAFMqkvNDzew2HbwD0xbFOxgnAXbrcpH573WWKHRjsSmPPA6eXDhJE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNXsxgL5e3A+yC8KU65StZ6Y59SLvsbAe/UGqazmTVAWTsEig1
	abYEhWNcBSAKa7t26i0KWBJrDEknw2Q/VSxVsp/I744t+XgMtjGGV/iCAacaPmQPC6msY/ii89z
	rug==
X-Google-Smtp-Source: AGHT+IEiNLsgXHr0s14hEc+y88fytjsQ/uGLHuXkzmmisdcEk/UgFC8sD2BUQDaPdf5KBMzcHwv9BLUzTIc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fa8e:b0:1f6:2964:17b8 with SMTP id
 d9443c01a7336-200ae584d14mr701055ad.10.1723230232634; Fri, 09 Aug 2024
 12:03:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:03:11 -0700
In-Reply-To: <20240809190319.1710470-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809190319.1710470-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809190319.1710470-15-seanjc@google.com>
Subject: [PATCH 14/22] KVM: x86/mmu: Always walk guest PTEs with WRITE access
 when unprotecting
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Michael Roth <michael.roth@amd.com>, 
	Vishal Annapurve <vannapurve@google.com>, Ackerly Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

When getting a gpa from a gva to unprotect the associated gfn when an
event is awating reinjection, walk the guest PTEs for WRITE as there's no
point in unprotecting the gfn if the guest is unable to write the page,
i.e. if write-protection can't trigger emulation.

Note, the entire flow should be guarded on the access being a write, and
even better should be conditioned on actually triggering a write-protect
fault.  This will be addressed in a future commit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a5d1f6232f8c..f64ad36ca9e0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2761,7 +2761,7 @@ static int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva)
 	if (vcpu->arch.mmu->root_role.direct)
 		return 0;
 
-	gpa = kvm_mmu_gva_to_gpa_read(vcpu, gva, NULL);
+	gpa = kvm_mmu_gva_to_gpa_write(vcpu, gva, NULL);
 	if (gpa == INVALID_GPA)
 		return 0;
 
-- 
2.46.0.76.ge559c4bf1a-goog


