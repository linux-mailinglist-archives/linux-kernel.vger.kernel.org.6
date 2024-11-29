Return-Path: <linux-kernel+bounces-424137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D349DB0F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C57280ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB89F1A08BC;
	Thu, 28 Nov 2024 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fZTT3Jpc"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8463919E830
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757716; cv=none; b=ua9D4mCDVtKtV35ttrxYjDIviVsJzU4HryjcYaRV+yT3BnSruHog7Ziqv1zFy2K2tppPisJtnndWueSnmUAEtCAoYY5Y7lxYG94CtvbeBURLRsnHZodMFjId91ucBrAM9e0+EP4jstVxQjAtQFLWbOOR5Y5hBWwUA/wVf3jWH8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757716; c=relaxed/simple;
	bh=jTHw6WzG1L2ET0+uLOjxe98U/NZComyDwuqnLDwUK7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CLWpykKeNjdkUDWaf+qbVhCiPGi46U5jvmjxPVYDvkDMqn16PE6fAsjInaLaSJ1mkHKE0XSJuqQf8lq2RcmwnuRNFJ6ZXBlW1Fh7Qmv0Pe8EUcx6zkaeAOo8Cp90lTAOj2iSYEimEKB3PL/UT9DWWQTRXVfI5zSuAg+as1wnxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fZTT3Jpc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea3c9178f6so359852a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757714; x=1733362514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pcqSghdFCh/ZctdAGuZ6xZDRZT1voItvL/TUvcMElMw=;
        b=fZTT3Jpc6K2+TuR6tKqAEsWBtp9uD4CCGK2XSmInd4hpiU2Pr0z20O76XfJHvYHz9i
         L31VLgnVZULe04zQqMePbmzx2Hsh5VnTcIz9o7+Hjux5gcv/iQ1j9epbv0LTwyO4eLRG
         BfSCxPYYfTH2fhlC1Ynkg/S82w5bM0tSVto51vPewH2dsr/hrXImPWY7/PzXzFksFoui
         VWWQ8Kcd6yRWe0JJFSi7zKH/urV29LuvDR1biDHFKhdcWn2+69E18D81R9Z3yEAv1rdt
         GqQQlAPiM7g3mjj3Y10aCYPXCnPMQ8rlobYiiBXqT4XPdAwvOcmpAgtJi1kxZURrC1g1
         cYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757714; x=1733362514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcqSghdFCh/ZctdAGuZ6xZDRZT1voItvL/TUvcMElMw=;
        b=OuXmXNTjf2N+9ML3scoB7L2CzY2Woz6sfZyxk1xVwMKguRkSXnCDB8xuE3n4L29ImU
         LJ6Iq9R9aw7SsW8Hoqrcf/nlL1uxBL8c+wDmRKYCH4yJvVHudvbYAkzUp9hKlpXtQb9w
         3dpM+3LDWrQXgaoDxUsavzuNk2dhhYDt7gazFw1pWhAUgWzpPxlFEpBdu4iKL7/THQJX
         u90lWDDkpJClvOHi3VuP96QGApp4rSYUBsCwe/QKaJ9+w04WSUEZyGgd05Z12fcvT26M
         KbWvUk6Yq4tewtuUgaqSIQ4OO9wgHTHaiWwhLWL1P91WtEz/wZIPxRN39nIGk2YgwD56
         bkeg==
X-Forwarded-Encrypted: i=1; AJvYcCVa6D5JTDf9DUao3YBqmGTFnzjcFRenIOEvot6pcFvmNbBYk0W73dwZNVHF/ssG15ULtCI2DkXaf2ATlH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJxTfkhXfSZPw7UsXEntRIgue8r1rSM51gEKFcJlTWeM7DiQS
	kXZ9EeAUbQEF4gQTNP5PANTjf07IUQmoZNiuZBFf8PjgmBTVN39h9Tqk77PU392easE73eRTIjk
	+8w==
X-Google-Smtp-Source: AGHT+IGUQlMTSKfuvU5bVfNlJaMTNUCCVb/DTfETxPEeuTtM1qtJCGgOOyXt1nJBI+ToBILywzlFBuJrkjk=
X-Received: from pjbsj16.prod.google.com ([2002:a17:90b:2d90:b0:2ea:29de:af10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164d:b0:2ea:77c5:e877
 with SMTP id 98e67ed59e1d1-2ee097bf31fmr7054546a91.24.1732757714077; Wed, 27
 Nov 2024 17:35:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:51 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-25-seanjc@google.com>
Subject: [PATCH v3 24/57] KVM: x86: Add a macro to init CPUID features that
 are 64-bit only
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add a macro to mask-in feature flags that are supported only on 64-bit
kernels/KVM.  In addition to reducing overall #ifdeffery, using a macro
will allow hardening the kvm_cpu_cap initialization sequences to assert
that the features being advertised are indeed included in the word being
initialized.  And arguably using *F() macros through is more readable.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 9bd8bac3cd52..9219e164c810 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -642,17 +642,14 @@ static __always_inline void kvm_cpu_cap_init(enum cpuid_leafs leaf, u32 mask)
 	(boot_cpu_has(X86_FEATURE_##name) ? F(name) : 0);	\
 })
 
+/* Features that KVM supports only on 64-bit kernels. */
+#define X86_64_F(name)						\
+({								\
+	(IS_ENABLED(CONFIG_X86_64) ? F(name) : 0);		\
+})
+
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
@@ -859,7 +856,7 @@ void kvm_set_cpu_caps(void)
 		F(XSAVEC) |
 		F(XGETBV1) |
 		F(XSAVES) |
-		f_xfd
+		X86_64_F(XFD)
 	);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_12_EAX,
@@ -920,10 +917,10 @@ void kvm_set_cpu_caps(void)
 		F(MMX) |
 		F(FXSR) |
 		F(FXSR_OPT) |
-		f_gbpages |
+		X86_64_F(GBPAGES) |
 		F(RDTSCP) |
 		0 /* Reserved */ |
-		f_lm |
+		X86_64_F(LM) |
 		F(3DNOWEXT) |
 		F(3DNOW)
 	);
@@ -1057,6 +1054,7 @@ EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
 
 #undef F
 #undef SF
+#undef X86_64_F
 
 struct kvm_cpuid_array {
 	struct kvm_cpuid_entry2 *entries;
-- 
2.47.0.338.g60cca15819-goog


