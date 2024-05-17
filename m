Return-Path: <linux-kernel+bounces-182454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8B98C8B72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB561C20978
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0850814EC59;
	Fri, 17 May 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ll+VrpiG"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9914E2D6
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967626; cv=none; b=loZo98FcAFlNn7mONA9Di4d70xmmKIPGyC8P+yyDv6Ize5XygUR5euu+oAmngItnJ5nxyQg2ZFwn+yhAxrMBJKtotPwQ9kxB1brzzkCuaVvmjAlR3uSeDXv2ad30afXI23WdUYVM1tkAT50cKqHRM49tpVZ7VRLuHW4jSdcX01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967626; c=relaxed/simple;
	bh=IGUlCSQb4VVlh8Teh+TRRnLSMg0hHTZ2QvJoUqqI9nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QzJqUotmWBCeLzQ8uopGFA85rX+jSH3rzM7e7NiI5YuSAil6cy66WJ7X4+6mDjR2+ROU1h3qDsrrDbTcSXmaRy/8ewttdKZx0x5q9i6KqvLpixRSCl4h3/xjjgA4tR+4jhzE3tiqCnWiZaxyZJN6+nMczlgGWpFU6fLHlfwrWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ll+VrpiG; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee2f06e652so97227385ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967624; x=1716572424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dijBj0qWI1t8uCqCnys4DJX7KSJC9/goR7IRU4yKvG0=;
        b=Ll+VrpiGF6R/9lllVDHxGja3NR3XWiDxZpV/0xU/jXUJIAovCoD8LNNWlOSdCEWs3A
         yHSRFNjrQ/SXiQ/ZZ73levPRtdaExVC0BZok/lOaijvow0IYs/vSfmEvMw/bDCdvNzVQ
         q2AxCbFTvuC9Ow4KS22mrcztAHn4rfcBx+Q2+v4leAFdYlI/sDKeYKbeBSiHdC7sjQMR
         wi1dCyC/RhRgjDblxtQCiyzQvQXRfJzdDHhDEmRmW8N9+h7mqFtpVah8/4/N+eT7LElr
         PYDaf2NButa6l67ZkJ9/Gdk21KeTvxj9H1I19qyHhs4QIlXq82uL+PEWgatk7JMJ149s
         GBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967624; x=1716572424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dijBj0qWI1t8uCqCnys4DJX7KSJC9/goR7IRU4yKvG0=;
        b=cqsUa/AVewV+k3ObxhIlV4rfhP+5Ct6v2jPd9Kug4gA1ZBY6/ZTLXq7jAJX/d6Oezd
         kdjSMefSOcfiFDE4wzGLP9zQisgsu35RZAk6w4VVlBnJRpHQBKueU2S1HPNopTHaKrgH
         Bs8wXmZwglTohSgervAH4h3j63qeW3C0Yrb3ESEEbG0F7jQp4g/AS346p4240LvjGB/9
         /n2ERCZc5Mxc90m+b0TPVjD+Z1yp18NLXEYowZ2FkeYDVxl4mbfByyfK4BOhqoLH3doQ
         f+LWLPzeKz2yYes9zZHMXRTGuplvptX8l42Ie35Gnt+4LzKrcEafV3Qd+P2KAazeL+6w
         wy9g==
X-Forwarded-Encrypted: i=1; AJvYcCWmElpRq25OHItfdH9iOqKfrdYnnoMXUzJLmLtmqKCEo8s+h8FAbfzQKz+1JEzCZjIyOz/E9EIQ2UPg4iG99YWEvEiFplkT04VLI0Eu
X-Gm-Message-State: AOJu0Yw7dOBCW3Zvb949f5Gy0Y2r6zCtKXkxiME6wmaReJ51ozIQ4N3R
	GQhSa917X2f4kjMWueOZ9NHUdA8hBY6IPZlnpDsiul7AFObeEQwsxO1h46HNTbXiClbeAh9AKcm
	Uiw==
X-Google-Smtp-Source: AGHT+IFXRR5hECS8skrS+8tF7N466noZtET3R8dKSeQyoxLftATzA6/rtw5ghxXdGChJjmYjlQhUGFb9XU4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:245:b0:1eb:538e:6c77 with SMTP id
 d9443c01a7336-1ef43d1831amr1616515ad.5.1715967624058; Fri, 17 May 2024
 10:40:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:58 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-22-seanjc@google.com>
Subject: [PATCH v2 21/49] KVM: x86: Add a macro to init CPUID features that
 are 64-bit only
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a macro to mask-in feature flags that are supported only on 64-bit
kernels/KVM.  In addition to reducing overall #ifdeffery, using a macro
will allow hardening the kvm_cpu_cap initialization sequences to assert
that the features being advertised are indeed included in the word being
initialized.  And arguably using *F() macros through is more readable.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 5a4d6138c4f1..5e3b97d06374 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -70,6 +70,12 @@ u32 xstate_required_size(u64 xstate_bv, bool compacted)
 	(boot_cpu_has(X86_FEATURE_##name) ? F(name) : 0);	\
 })
 
+/* Features that KVM supports only on 64-bit kernels. */
+#define X86_64_F(name)						\
+({								\
+	(IS_ENABLED(CONFIG_X86_64) ? F(name) : 0);		\
+})
+
 /*
  * Raw Feature - For features that KVM supports based purely on raw host CPUID,
  * i.e. that KVM virtualizes even if the host kernel doesn't use the feature.
@@ -639,15 +645,6 @@ static __always_inline void kvm_cpu_cap_init(enum cpuid_leafs leaf, u32 mask)
 
 void kvm_set_cpu_caps(void)
 {
-#ifdef CONFIG_X86_64
-	unsigned int f_gbpages = F(GBPAGES);
-	unsigned int f_lm = F(LM);
-	unsigned int f_xfd = F(XFD);
-#else
-	unsigned int f_gbpages = 0;
-	unsigned int f_lm = 0;
-	unsigned int f_xfd = 0;
-#endif
 	memset(kvm_cpu_caps, 0, sizeof(kvm_cpu_caps));
 
 	BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
@@ -744,7 +741,8 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_D_1_EAX,
-		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) | f_xfd
+		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES) |
+		X86_64_F(XFD)
 	);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_12_EAX,
@@ -766,8 +764,8 @@ void kvm_set_cpu_caps(void)
 		F(MTRR) | F(PGE) | F(MCA) | F(CMOV) |
 		F(PAT) | F(PSE36) | 0 /* Reserved */ |
 		F(NX) | 0 /* Reserved */ | F(MMXEXT) | F(MMX) |
-		F(FXSR) | F(FXSR_OPT) | f_gbpages | F(RDTSCP) |
-		0 /* Reserved */ | f_lm | F(3DNOWEXT) | F(3DNOW)
+		F(FXSR) | F(FXSR_OPT) | X86_64_F(GBPAGES) | F(RDTSCP) |
+		0 /* Reserved */ | X86_64_F(LM) | F(3DNOWEXT) | F(3DNOW)
 	);
 
 	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
-- 
2.45.0.215.g3402c0e53f-goog


