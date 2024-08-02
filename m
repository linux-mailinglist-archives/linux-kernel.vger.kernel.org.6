Return-Path: <linux-kernel+bounces-272969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2109462EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6886A282CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD750166F1F;
	Fri,  2 Aug 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUbjaSmt"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA69165F07
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622784; cv=none; b=XefD6rXdzCInG/QDHU6LZUJhtIaatvWttgdT0s102Jj2F5yv8jOdHdeaAppHq3J9jsRmasTN8Vuq/koj+lkZYkfTWpnO5CUV/bdyDTR2pMu+0tguSU71yXDpSX3jJyjk6dEGhmBa4PKCvlYT+d5+yGy2jrF6IzSMbpBEgFYdL9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622784; c=relaxed/simple;
	bh=hkR6QEr+WLoDq3xFNE6eHV98zpNeTguqeGIsqeOvNJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rmNbF0B6hICSJmDjn+SjqR8aLF/vBdRtJB2LvwxslxMArgCiW6aQYBWoZlcQ2/xqtEgWVJullSt1ncgN5ivOEipCLHKn8o0yBSdaCvHq1z4vP5wYmuDrAcBv4ke+olXl6pB4aFzVDJEOnITDNVvuLzX9B2yITo3Mvu934BP4ErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUbjaSmt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7a242496897so6609287a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722622782; x=1723227582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=j/AuksRw4eRbr1UmkMXYc3JTMMOK1vQLnbFBUZIHu+k=;
        b=qUbjaSmtDzLUyisDRt9YLwEL4LMl9q0mEedHKeOLJS/7HWGAl4IslbUd7hO8m9d3t3
         OALMeeOC1sSlKvF3YLBO+2uhD5iyNsuitisDctY/haJP83hwSnDqPrLJb35g2/KKgP7r
         qmJ+zhYUomzvKPGeOLiHX8NqFeJ5Lf47DFvLanNP/0Ic5lnwB/zXisNn46fa+Ex1Znf9
         OuykVn19yz6IdDX6OM2g4BZ2k9Xg5YWKD0AOG983/i7Y9V6swaPINeWnQLPymnDJYioc
         UsgRjQVxSXa0+jDEUeorBMTRGII0m4bRYskju/k1O6wrZuGlcLDaUHygbSxU1QyAPeHW
         RMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622782; x=1723227582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/AuksRw4eRbr1UmkMXYc3JTMMOK1vQLnbFBUZIHu+k=;
        b=b+/4tnikvahXbDkCn2l+kXABX8etD4RyHLLPP5AL8Pbvz+1sutsNAQ7aS/IduUFJdP
         bvgvxE0gqvPtHWyM+1/uJCnPGv13NoB1spmndT1WEeEjCGTws7KPdUvvMnyux4+dTZFy
         c8KOl4pUe9twoZ3lnKx/p/UzpPVvArehScvcm474KF2t96o2kpGqoXEfxySX1pQQOP6z
         +voLAAbwmH1xyz5CZsWmRiJYnti/fqeMeZ/XHAq21c1dMGZ7Z5EZOs2VAtdomFt5C/Cq
         9wL2fscB0ZQAwYdBIOWxQJ2C8J7DAkeCgVJCIh8aorLe2HHDnGu4r67hdyOtZYhTQmns
         +a9A==
X-Forwarded-Encrypted: i=1; AJvYcCV1MQBdTnaOMc71dcfbyE1pX83WS0ljHj2nR2nDCn+V9wVlzzzZ7338+5KIFwXBKPV4kKPLd+DabL0q2MDKzcrdZinYhK7GVrlXkR9s
X-Gm-Message-State: AOJu0Yx8FOpdrBp1C84tEIRqapiZRuGDId9ayOBB+rrMKWERTlO+/qah
	IRJZxT9i6mKJNXy0shmLzlXXfsxFsw1KdWOsP9tdMw5mT+TenOKXNffEos+SSlmX/82qeayH4z1
	5TQ==
X-Google-Smtp-Source: AGHT+IHLj8X+lZRtIC24TP4NuRlObpH/Kd495L+iYe6/wJIc4BaC8JUsz1rCyorY9vbGmn7x9ISQkirN3fU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:494:b0:79d:9ea1:e03f with SMTP id
 41be03b00d2f7-7b74a2fde72mr7518a12.8.1722622781900; Fri, 02 Aug 2024 11:19:41
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:19:27 -0700
In-Reply-To: <20240802181935.292540-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802181935.292540-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802181935.292540-3-seanjc@google.com>
Subject: [PATCH v2 02/10] KVM: x86: Move MSR_TYPE_{R,W,RW} values from VMX to
 x86, as enums
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Move VMX's MSR_TYPE_{R,W,RW} #defines to x86.h, as enums, so that they can
be used by common x86 code, e.g. instead of doing "bool write".

Opportunistically tweak the definitions to make it more obvious that the
values are bitmasks, not arbitrary ascending values.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.h | 4 ----
 arch/x86/kvm/x86.h     | 6 ++++++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 42498fa63abb..3839afb921e2 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -17,10 +17,6 @@
 #include "run_flags.h"
 #include "../mmu.h"
 
-#define MSR_TYPE_R	1
-#define MSR_TYPE_W	2
-#define MSR_TYPE_RW	3
-
 #define X2APIC_MSR(r) (APIC_BASE_MSR + ((r) >> 4))
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 50596f6f8320..499adef96038 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -504,6 +504,12 @@ int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
 int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva);
 bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type);
 
+enum kvm_msr_access {
+	MSR_TYPE_R	= BIT(0),
+	MSR_TYPE_W	= BIT(1),
+	MSR_TYPE_RW	= MSR_TYPE_R | MSR_TYPE_W,
+};
+
 /*
  * Internal error codes that are used to indicate that MSR emulation encountered
  * an error that should result in #GP in the guest, unless userspace
-- 
2.46.0.rc2.264.g509ed76dc8-goog


