Return-Path: <linux-kernel+bounces-328645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA89786D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDCF286DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3E12F588;
	Fri, 13 Sep 2024 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWXdHCXk"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C812BF25
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726248778; cv=none; b=k1Htre5uqYpFT3X1YYut2xThOLE4tZU/VWf/9bzRQVurTVzOR5MgYObNaL74k91IFvA81areCMpiGAjnwxheb935ONgnMffBMx3S7mp6PjiY/tCLpawmJ5IGgcQec4X40qHqSau4xFfUHy54+tcklHn1A9uDi+1M2gI5O7GoyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726248778; c=relaxed/simple;
	bh=INXEGqBpdqXknfmZSD/sh52qeMFtGxNFla/jPofoHTg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DvgIHlHzDC+RhoehBcGOlnO/NKH15teQ5zsoIPWsPCkQrIgIgEpxpgN5/q0CJHrXK1TLYn/qXStv2n75JG3XJabECvfoTLVZV9chQTDNfaIFZF9UBtJtvOqlMuIOc5z28GSKslurPKI1fTpxTWy231jjZ0uRT4XbmkPDhPKg4zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWXdHCXk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d470831e3aso26242977b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726248776; x=1726853576; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g8wmRU1VBjftYUbE8QWox2vZgYnjmK1j3kpaMosk3/s=;
        b=EWXdHCXkW5znDv/JsjN+fX1/Z4mNgAAtnYKHXtG89ipLjOi7hBfN2uXR/mzFm2eDXQ
         pWgrgC6xggoKHw0qWlODXUbdCQWR4AtjWhu2HueD0x0CR6J2aHEF2Iq8A39wI86EzZYu
         rnMXdgNt5bDlEajhf8ZT4Ef5LkcITZPM39eYnwFarhMfvXJddPpwMek7GsRBlRIslO/t
         H16+fYdUmb2W3k+VZmKArqlOUxIF72aZvid8+HufUBZlOpULgd6Znb7a/TMHY6BzZQKF
         Besp3n6+VdZozN9jR4rQJ0IYpeRV/blP5lhDUhMnPtiVHlNyoiQOYiJQMQdN4sUF27Av
         nKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726248776; x=1726853576;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8wmRU1VBjftYUbE8QWox2vZgYnjmK1j3kpaMosk3/s=;
        b=i1Cr/g6XwyH6LqsYtCBBNeR9vWdW786BxyfHHV4Kx3Xplg9CWhr5x3NVMYGklLwzUE
         M9zzV0Fi9/KWzO1LLmfX6L1FrxrVTgUZja6vq/gevXTfU6oRDuRlNM5+SgtjR54G2J0p
         dViIdc4hZrgq3cuIA2dfyhshRFE+gyMg0efOVv3skSnSdIoW2EBGTY4CCKVWP05UNIKt
         0rWUOs1GL2FBu5tksSV5ReA9c/gbwEfSPXOqJ30Xpg9Fv4tgL0HVFgVUlehCd9UDj2mo
         Fs6mHZTYabuCcFXoLpY284y2GDoO+I9CB93apQKxnhIK+aEymOw0Jj92iuugyZjf4fbf
         kaCg==
X-Forwarded-Encrypted: i=1; AJvYcCWTFhWxSBoctlkUUNRliOtPIBxfK62/hVH3QMnwUhn4wTZ2TSFVa2hAdZpA2CmYesw20xfrNyaU4MUJXOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPu1C70i9LS5ONi3Yk4qNeezYBYRcbQLDFvtdxPZuCWhxVVkMI
	2Q2W8yNHmRNETRD85uv9seuQEZ2d1NWhY0DPVNSLXVgNmc+BuDLbFJVVpHsThaBzzOibLKaDDO6
	dxx9bbsyBAg==
X-Google-Smtp-Source: AGHT+IGSFsTgCDbNetbXcYx95b1Niemc1TyU+mUuvVsCWCrCX6LdU1NXur64D5AtqnSZJbSSZ+54bB9edgoiUg==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a25:b2a4:0:b0:e11:5807:1072 with SMTP id
 3f1490d57ef6-e1db00f2edemr4504276.8.1726248776127; Fri, 13 Sep 2024 10:32:56
 -0700 (PDT)
Date: Fri, 13 Sep 2024 10:32:29 -0700
In-Reply-To: <20240913173242.3271406-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240913173242.3271406-1-jmattson@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913173242.3271406-4-jmattson@google.com>
Subject: [PATCH v4 3/3] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
From: Jim Mattson <jmattson@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jim Mattson <jmattson@google.com>, Sandipan Das <sandipan.das@amd.com>, 
	Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"

From Intel's documention [1], "CPUID.(EAX=07H,ECX=0):EDX[26]
enumerates support for indirect branch restricted speculation (IBRS)
and the indirect branch predictor barrier (IBPB)." Further, from [2],
"Software that executed before the IBPB command cannot control the
predicted targets of indirect branches (4) executed after the command
on the same logical processor," where footnote 4 reads, "Note that
indirect branches include near call indirect, near jump indirect and
near return instructions. Because it includes near returns, it follows
that **RSB entries created before an IBPB command cannot control the
predicted targets of returns executed after the command on the same
logical processor.**" [emphasis mine]

On the other hand, AMD's IBPB "may not prevent return branch
predictions from being specified by pre-IBPB branch targets" [3].

However, some AMD processors have an "enhanced IBPB" [terminology
mine] which does clear the return address predictor. This feature is
enumerated by CPUID.80000008:EDX.IBPB_RET[bit 30] [4].

Adjust the cross-vendor features enumerated by KVM_GET_SUPPORTED_CPUID
accordingly.

[1] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/cpuid-enumeration-and-architectural-msrs.html
[2] https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/speculative-execution-side-channel-mitigations.html#Footnotes
[3] https://www.amd.com/en/resources/product-security/bulletin/amd-sb-1040.html
[4] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24594.pdf

Fixes: 0c54914d0c52 ("KVM: x86: use Intel speculation bugs and features as derived in generic x86 code")
Suggested-by: Venkatesh Srinivas <venkateshs@chromium.org>
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/cpuid.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ec7b2ca3b4d3..600d79ea22be 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -690,7 +690,9 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_set(X86_FEATURE_TSC_ADJUST);
 	kvm_cpu_cap_set(X86_FEATURE_ARCH_CAPABILITIES);
 
-	if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_AMD_IBPB_RET) &&
+	    boot_cpu_has(X86_FEATURE_AMD_IBPB) &&
+	    boot_cpu_has(X86_FEATURE_AMD_IBRS))
 		kvm_cpu_cap_set(X86_FEATURE_SPEC_CTRL);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
 		kvm_cpu_cap_set(X86_FEATURE_INTEL_STIBP);
@@ -759,8 +761,12 @@ void kvm_set_cpu_caps(void)
 	 * arch/x86/kernel/cpu/bugs.c is kind enough to
 	 * record that in cpufeatures so use them.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBPB))
+	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
+		if (boot_cpu_has(X86_FEATURE_SPEC_CTRL) &&
+		    !boot_cpu_has_bug(X86_BUG_EIBRS_PBRSB))
+			kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
+	}
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-- 
2.46.0.662.g92d0881bb0-goog


