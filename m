Return-Path: <linux-kernel+bounces-424166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC09DB12F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85CC164C32
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB62B1CF7C2;
	Thu, 28 Nov 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWSTJS0v"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF41CF2A6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757767; cv=none; b=QzSXrOxk7l/5VO7uSTBRTetB/pn/dbuabMpzFFiOHtDLUhbSIHD9ceHNCzQJxDd2Cz/gaSdUgSi3gGuZXE5CG94k5xO16D/Egs6ftKdbNsiOUACtEqqw3R2wpsZFID+YhmPOmFCUjn9ihIsZRne4suIJ/dKsgib/RnrEZ80Wu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757767; c=relaxed/simple;
	bh=MMiZl9iY/e+X4ElPn4IVVdodHF/M0Jd++AmXSEry4Kk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RJfSUniZlMNdrW6HHlTpBiYWOZJ2nBOK2ZjArSR97d1b03wrQnsLHeytT8WGPfi2i3z23l5I0rM8jnwZU8M5eGQ0gg79vfmJ9tLlfwR0lrdnbNokXc26pT67gHDFME80a7FW/AoaGEgmEJTes7Go9ESVUq8a90JokLGm6XGH7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XWSTJS0v; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-724fc3f60c1so466019b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757765; x=1733362565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=B//UkNeK73y2hzL0OUmcG/RbjTED96o4ACtsqb9F7d0=;
        b=XWSTJS0v1Kbj0+E0CGloAzU0TwicPl35VXAp4ZT2eX0RvlQrauuj9XQEzQONlyJyru
         TpNwLMUi9umZTNb5tUsi17e/0DzI21+57V494dcG/YmVXAHoPqAJvYoI6/3VKOoUxlE4
         JaBx15PMUNZ215lQZ3tv1hq/Vu3R+UNAcZBSAcTp9lXEKbndYyzNxx5VHdIyvD+UG/g8
         RBrbk76dCi+TLdmxgAzFUMJoOitCZEUBMu9Hlz0/GaQ+MoTuXerIfwQOFBoJ12WvXlYK
         xRa3pum0bmXvvbQTI4u5Q0JHtFWG8lG1VQQv8ZRrt43Z17whKjMUKhxLosWWEjcHsu7N
         +EWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757765; x=1733362565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B//UkNeK73y2hzL0OUmcG/RbjTED96o4ACtsqb9F7d0=;
        b=IsmpxrGMnMQgVsvccZ6URR3v9hdgWVqm2zzbNK1aMu6j6rvNleCqvT3RuQ6agRbNd2
         2T5tCcBte9iiFaiWR/JdigithAR3sQ+3GcJvNIiy2Z7TGpZh3uOpz7YUFU5yo5Jf+bwM
         b70cyqhhyfb/UgcPO10moYsBAGJStpkAgmSrWuxhBlg/t8cxKBIPZJBb9TZ2luVar3Da
         a5y9ALpdmekjqJKHjA0kDB3EXRZuDZP12fdcGfofesh5t7z7/iVz4A3h+iL/k5nE8LY/
         PLk4VN03AtkEbytnZVWTC3ROfk/+ibsTivRvaj+2lwA39hV6Awww4zeH4LH2RYc+tSB+
         mvEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8/fsLvDyqcoOkyGhJ4GALBEnYzmLRCVpWImfmDxtDjBQzGPKykMBsfO2FoxJFtUeLDl21gg4eDQPLwzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpoOyPe+wjaye7bV2ravp/Eu8c0gNfBduD5yI2POOCR7dWzdqZ
	VFRK0eQz7GmwJpaV2ksICxLFQ1S/2xAofl1AGrYEQA5cWdCaerOeEEw3DIVahYwpJImLXqvf3vt
	Qpg==
X-Google-Smtp-Source: AGHT+IGav2YrMKCSsi0KLsriYCbteWLnwXMh9zd2luggfwwO3gPhoujBO8/44GnfWCNLBK+2ZL62U5efhiI=
X-Received: from pjbpt17.prod.google.com ([2002:a17:90b:3d11:b0:2ea:5be5:da6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1192:b0:1e0:cd97:be
 with SMTP id adf61e73a8af0-1e0e0b8ce17mr7582568637.42.1732757764981; Wed, 27
 Nov 2024 17:36:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:20 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-54-seanjc@google.com>
Subject: [PATCH v3 53/57] KVM: x86: Pull CPUID capabilities from boot_cpu_data
 only as needed
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

Don't memcpy() all of boot_cpu_data.x86_capability, and instead explicitly
fill each kvm_cpu_cap_init leaf during kvm_cpu_cap_init().  While clever,
copying all kernel capabilities risks over-reporting KVM capabilities,
e.g. if KVM added support in __do_cpuid_func(), but neglected to init the
supported set of capabilities.

Note, explicitly grabbing leafs deliberately keeps Linux-defined leafs as
0!  KVM should never advertise Linux-defined leafs; any relevant features
that are "real", but scattered, must be gathered in their correct hardware-
defined leaf.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2b05a7e61994..3b8ec5e7e39a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -657,21 +657,23 @@ static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
 }
 
 /*
- * For kernel-defined leafs, mask the boot CPU's pre-populated value.  For KVM-
- * defined leafs, explicitly set the leaf, as KVM is the one and only authority.
+ * For kernel-defined leafs, mask KVM's supported feature set with the kernel's
+ * capabilities as well as raw CPUID.  For KVM-defined leafs, consult only raw
+ * CPUID, as KVM is the one and only authority (in the kernel).
  */
 #define kvm_cpu_cap_init(leaf, mask)					\
 do {									\
 	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);	\
 	const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;	\
+	const u32 *kernel_cpu_caps = boot_cpu_data.x86_capability;	\
 	u32 kvm_cpu_cap_passthrough = 0;				\
 	u32 kvm_cpu_cap_synthesized = 0;				\
 	u32 kvm_cpu_cap_emulated = 0;					\
 									\
+	kvm_cpu_caps[leaf] = (mask);					\
+									\
 	if (leaf < NCAPINTS)						\
-		kvm_cpu_caps[leaf] &= (mask);				\
-	else								\
-		kvm_cpu_caps[leaf] = (mask);				\
+		kvm_cpu_caps[leaf] &= kernel_cpu_caps[leaf];		\
 									\
 	kvm_cpu_caps[leaf] |= kvm_cpu_cap_passthrough;			\
 	kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |			\
@@ -769,9 +771,6 @@ void kvm_set_cpu_caps(void)
 	BUILD_BUG_ON(sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)) >
 		     sizeof(boot_cpu_data.x86_capability));
 
-	memcpy(&kvm_cpu_caps, &boot_cpu_data.x86_capability,
-	       sizeof(kvm_cpu_caps) - (NKVMCAPINTS * sizeof(*kvm_cpu_caps)));
-
 	kvm_cpu_cap_init(CPUID_1_ECX,
 		F(XMM3) |
 		F(PCLMULQDQ) |
-- 
2.47.0.338.g60cca15819-goog


