Return-Path: <linux-kernel+bounces-182468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D48C8B95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82EA51C2176D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42D6156898;
	Fri, 17 May 2024 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwGxXaAT"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EB013E89C
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967652; cv=none; b=fPygb3dqlahZlddSt+LfoCDi/NZ/2pMP5jmQWO4r9qV2wS1FRk0xVUQ27nrfWeCGuEvpbnmme/OEtqu1ATBd77kGVZWZRzdcg1EMFM3B9E6KYAOcp4nY8mg1v611XtC7e374Rk8CWDH8mVQjhr8nyo2OFbxX+CJZC6PU75H/x18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967652; c=relaxed/simple;
	bh=koSMywtO/wu2gesVxdjPks8AXActvjhb/e04o1t61gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gr3HxisYDYQfEUkKOsvLHo20Gti4S4cf/WDsHxzWY5OPzsZvGJ8NTJnN+IZ/uBj9jWHc+qUkqJKYav2RAQVsxulbMMSyQR23VWPU9vKMaeNmcB1SCXG7gopgLzMzNjuFmbchJINVPrBK86VVB4bNK1aJUxq6u/q8GoUajXY5ayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwGxXaAT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2b2c438d031so8003965a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967650; x=1716572450; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=P3RngJIC5VF79RUjcYdmJyXsqnL8+OK/DjLIm1MOcZg=;
        b=mwGxXaATJc+2KDgWrtdyyesWstHesTIt69/gLFg8Bf5hstmGfLvG3auRIpC/sE6tTx
         Lp0W2RsRDx7WxDW88xECma1g/UMkVY2yPJlLEj74y7NQG6JGexakQR3EKjQH0llmy2K6
         AADSlqCs1Tv9k5qfy29EwCPF5EAXj9ehaVo1hwYaegO4eM4qki5p1vwjNCxCfCgsSzm4
         ArkU/+IQNcdY+PIlCwXQr5BHs2Ld/P57MHBi/xScS54o5+nZZF/HF4w8oRED/JBQzroD
         US+PsO+hor2cS0nqsQlkp6qFstPOPFiBQi897V3PWeP4t2Q8p1oCe1nmXanDLl3vihOr
         v/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967650; x=1716572450;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P3RngJIC5VF79RUjcYdmJyXsqnL8+OK/DjLIm1MOcZg=;
        b=Cu+zCWlWpLa1MDvJ4T4kZn/h5sSAYO3zkXNveoR6v7cM55Z3AR2Atym8EoPAAlKIUm
         tALW38RwOmCqgcbvhpknWe9sbzT83JSLW7G2Qi5jQfFtJ56MADYRSt9HzQlUK1Cwbq9v
         /xwjJ5kgQdMIz8EyGaFV6OqDDcdQZ79I7RzrIo3GpYyk/AAicS0knuCniGkw4Sggz8e2
         r8zz9S4BwKS8xATrha5gZNKilenhNc0oZWB6f50MYmk4uSjsXIOkXf5PflsQVQzHM5xm
         rraaCZ00XEDCl0UDCUida5r9va81QXdoT3Bbt2ydY9a807/P9qpSdoIPUa5vQ5iSdmYM
         2gFw==
X-Forwarded-Encrypted: i=1; AJvYcCVXlXVDLkYcm6bvLBJbirCnUFsL8dGX+Pivzn2o5YXOcthc8Ob8KR5fX4B1nBISNYrpAOK0zvrjG7p3EU1D7jXHENhntLwikMHBz+Jy
X-Gm-Message-State: AOJu0YwDdfBOGonYf+8UgieryeFJZ9fIuCY5OsKLi6fR5Zxnjdg5DKLk
	a/IibbPJvGyWPMMk138HGNZQSNfHBPyM2/5T1ygn3As/HimXVEX908jRErPPuD5uU7qTYl0Y5Ru
	aUg==
X-Google-Smtp-Source: AGHT+IEKNtq2BO+HVRMnzElkhBJ01/qnt/HDkWshsTsAb7m2nd7jfQBCIy61dWTL2NM24Dxm+NEfmpKaqbk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:c481:b0:2b6:208c:8520 with SMTP id
 98e67ed59e1d1-2b6ccec9f0cmr64162a91.6.1715967649824; Fri, 17 May 2024
 10:40:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:12 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-36-seanjc@google.com>
Subject: [PATCH v2 35/49] KVM: x86: Add a macro to handle features that are
 fully VMM controlled
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a macro to track CPUID features for which KVM fully defers to
userspace, i.e. that KVM honors if they are enumerated to the guest, even
if KVM itself doesn't advertise them to usersepace.

Somewhat unfortunately, this behavior only applies to MWAIT (largely
because of KVM_X86_QUIRK_MWAIT_NEVER_UD_FAULTS), and it's not all that
likely future features will be handled in a similar way.  I.e. very
arguably, potentially tracking every feature in kvm_vmm_cpu_caps is a
waste of memory.

However, adding one-off handling for individual features is quite painful,
especially when considering future hardening.  It's very doable to verify,
at compile time, that every CPUID-based feature that KVM queries when
emulating guest behavior is actually known to KVM, e.g. to prevent KVM
bugs where KVM emulates some feature but fails to advertise support to
userspace.  In other words, any features that are special cased, i.e. not
handled generically in the CPUID framework, would also need to be special
cased for any hardening efforts that build on said framework.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index de898d571faa..16bb873188d6 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -36,6 +36,8 @@
 u32 kvm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
 EXPORT_SYMBOL_GPL(kvm_cpu_caps);
 
+static u32 kvm_vmm_cpu_caps[NR_KVM_CPU_CAPS] __read_mostly;
+
 u32 xstate_required_size(u64 xstate_bv, bool compacted)
 {
 	int feature_bit = 0;
@@ -115,6 +117,21 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
 	feature_bit(name);							\
 })
 
+/*
+ * VMM Features - For features that KVM "supports" in some capacity, i.e. that
+ * KVM may query, but that are never advertised to userspace.  E.g. KVM allows
+ * userspace to enumerate MONITOR+MWAIT support to the guest, but the MWAIT
+ * feature flag is never advertised to userspace because MONITOR+MWAIT aren't
+ * virtualized by hardware, can't be faithfully emulated in software (KVM
+ * emulates them as NOPs), and allowing the guest to execute them natively
+ * requires enabling a per-VM capability.
+ */
+#define VMM_F(name)								\
+({										\
+	kvm_vmm_cpu_caps[__feature_leaf(X86_FEATURE_##name)] |= F(name);	\
+	0;									\
+})
+
 /*
  * Magic value used by KVM when querying userspace-provided CPUID entries and
  * doesn't care about the CPIUD index because the index of the function in
@@ -674,7 +691,7 @@ void kvm_set_cpu_caps(void)
 		 * NOTE: MONITOR (and MWAIT) are emulated as NOP, but *not*
 		 * advertised to guests via CPUID!
 		 */
-		F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64, MONITOR */ |
+		F(XMM3) | F(PCLMULQDQ) | 0 /* DTES64 */ | VMM_F(MWAIT) |
 		0 /* DS-CPL, VMX, SMX, EST */ |
 		0 /* TM2 */ | F(SSSE3) | 0 /* CNXT-ID */ | 0 /* Reserved */ |
 		F(FMA) | F(CX16) | 0 /* xTPR Update */ | F(PDCM) |
-- 
2.45.0.215.g3402c0e53f-goog


