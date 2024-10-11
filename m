Return-Path: <linux-kernel+bounces-361874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1099AE33
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C951F23790
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD521D173F;
	Fri, 11 Oct 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CAHDqFPy"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585A61D1E72
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683068; cv=none; b=RyEpNYI5Q5P3CQgGqA+gYRmeJcgM2XO2RGVSbMGT7fo2GmgKr5vjUkfToMZe8CguXeNzQwTUVqDf2xWP20cD2MFezQ7FdEFmdqDBGfJDJmG5Qp5ECpKNv/IYO4nvH63jUyvTxDKq4Yos5kGNlumQXmMs5aI4fXw4OrTeFIz0rKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683068; c=relaxed/simple;
	bh=g84dQRvOkmfkJ9fMKPkg7yFI/j/iidv6fqlkrGBROj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RljwdCtVNo9NPvNRHHS6ozYH+i/dhMQRpm+nCncv3ycp6O0U8MgfL2LDMlRHEbYpiYR2Hs/PwKavdjJyhiz+dW9Z9cLf/ehbl0u0MdSr5tmTqKrg5ozWE4mGjcHgjqDf4uGYci2/3qs7BPTeYNFytaVpoi9L76ewMYeEtTDjVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CAHDqFPy; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20c45296b3fso25324005ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728683067; x=1729287867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwpmJGxchn7b8cfCM3dVFdqHT3Yg0RQpXo/tMqXMwnM=;
        b=CAHDqFPyfnlGQBhQS99n4GaK1uNc1jSSam2QwtQ6bJCY4XMxe1wPmnpgYgJ7Q3rG08
         FFD2lujeiE590dSOMhA8RpLRSsKW2ez5Bu9lO/B9ZiNz2rnWAuX3jKpk3rxDtsp4fsUk
         8biJ7ZRbSwqZbhKzILPQ206Z/0U3/DxOdzRXRwkXTuurkUEAoZBr5o1ij+W8g115HQzB
         AKKeHei7yW2oKVWP1oyQ19heofnjKDiS1pxx3HtDMvAwXUz5KjDg6vBaPSEq04ryUxRA
         pANdPMbLLtp3LSLnXawocvZyRx49V7azSJHJbzl3vHIUSJbuyGg4RTFQ3UDx6Szz1S03
         XZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728683067; x=1729287867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwpmJGxchn7b8cfCM3dVFdqHT3Yg0RQpXo/tMqXMwnM=;
        b=kWjKpnZZODNKv+iJ+bQu7+5ckzc91aYT624mzXnxOGKdmnyxsDN6LyOo8DuVhl4407
         FPcrBy+Pcz1aCC9X4/54kR+I80Vh2YYD1MNLcFV756J/9SqNV6khw8Jm1QtJfhF5aKGE
         NK8OyatxyMkhDYSRuopoPW5J8fwNqs2XniOn/m+s9OhbLEa10+maEVUB8Mu2h9GgFUaE
         OiryXwudBttIEYBceszvxWBuQOhFCgFraLNUzVzhkcyWjpq7bunQPVI8nUvstlq1JuNE
         NCia7x5q0iqxCnRitlbezONTRA/txRhUm3aAi/aJi6atw10esUvrkomhDmdZHzuD3smw
         MSfA==
X-Forwarded-Encrypted: i=1; AJvYcCV9K/Ex32pgNq4Nmnc55+u222EFZXAIy6PbAnqkfhQI3AQuSUOrTaQ6qb+I5Anzj+tNPVCLReQCIAq+KHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA2zc0FjQYWgoyxmcPJhQ0Mt0hSvKFXQ67/ANHTo6rTn6eioLm
	10MBvx2g2MkWxysk0b6/FydjSHVyLw9lAzJ5j7MkM6MB1rRzBFE7RxW77yN6AUeXl6HscwF3DLW
	PSUUCF6dfkg==
X-Google-Smtp-Source: AGHT+IE/S6/IuBocPgmULf1WfcyR70lEh9UP0uUwh2OMsuj8NvlIvRc19XBB4ypneCTpUWYMlwcLmYYG+mlRqQ==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:f3:525d:ac13:60e1])
 (user=jmattson job=sendgmr) by 2002:a17:902:fb44:b0:205:656a:efe8 with SMTP
 id d9443c01a7336-20ca16d0d07mr234905ad.8.1728683066408; Fri, 11 Oct 2024
 14:44:26 -0700 (PDT)
Date: Fri, 11 Oct 2024 14:43:53 -0700
In-Reply-To: <20241011214353.1625057-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011214353.1625057-1-jmattson@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011214353.1625057-5-jmattson@google.com>
Subject: [PATCH v5 4/4] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
From: Jim Mattson <jmattson@google.com>
To: kvm@vger.kernel.org
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	jpoimboe@kernel.org, kai.huang@intel.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, pawan.kumar.gupta@linux.intel.com, pbonzini@redhat.com, 
	sandipan.das@amd.com, seanjc@google.com, tglx@linutronix.de, x86@kernel.org, 
	Jim Mattson <jmattson@google.com>, Venkatesh Srinivas <venkateshs@chromium.org>
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
index 53112669be00..d695e7bc41ed 100644
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
@@ -763,8 +765,12 @@ void kvm_set_cpu_caps(void)
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
2.47.0.rc1.288.g06298d1525-goog


