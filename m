Return-Path: <linux-kernel+bounces-290212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E489550C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7271F23C14
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956881C3F2E;
	Fri, 16 Aug 2024 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKN5S+Rp"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9721C3796
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832767; cv=none; b=BGBaQmmljRR9ddGoEDAEUopz9L8MEOo7jtObqwVloVvz/SsqH8mGKKNiWBeAzom1FBzs+aYqd1MvTaYDZfGvcsl3UizhmnucQzt22aRzeLJ3mcNuc8xzNQb/C/ztrCKk/mPamgDP7w7nERrL5iouakl0XWOl6FURKcG0zSAz01E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832767; c=relaxed/simple;
	bh=MJC7nEJsLQW96ofZcmOX1FaidhLei9K4+rANZcg3DS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LwctmXv5P8+JRZ55gsh6LbAbEmvG7UxVA6zacrj4hZQX34io+lzi4rtNBTmkjzY88dNHzYUQNd2SE43UzIgmbB1mKzwONKSffOrsYU3AFh74cLbvMqduAPbuHBhKd6kzRaSvhwT8/4SEH2m1vbckko7kPcT3cyRGHXjgrq7FM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKN5S+Rp; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2d404e24c18so117542a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723832766; x=1724437566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0/Dzxs86f6ftJO2B1jByWJPM+C0/huK5/pjbVScDDk=;
        b=VKN5S+RpM/+izq4LXgzNVUocT2HaYKOnfXRTKfnd2aOy6IRtVJ+lb19JEyrSgJ4tiR
         8uyBxNeiOlRH/UwQhMB7sQ056YsoBCUbs1NI/UwEEvmNddKPxKQVw1TMlhT6echQ+P2w
         E9LmFgJ2I/vjIqhDcMr5XlqVaEJI4PWwDO+0R4/C3HZ2m/hYEUEEPukR83tgilTY5pVo
         nvbu7zfT8wUDKODqFyQFHv4JT5yXjIqv66znqh3fiA0tfTpFzejdV25WpofLYamdpHtz
         ztycsjC0xvKYjeXJuTa/QlJDuUAs2AqQtunNE4D6+k7EblC5M+bg9XCsiG+RrIP/D0TX
         XLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832766; x=1724437566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0/Dzxs86f6ftJO2B1jByWJPM+C0/huK5/pjbVScDDk=;
        b=c0a5N94u3GyNcHvG6gjAagwTKHxyWHx3QmLzxLgZdeMurDrDkqAMgCTL13wN/TbXoO
         xXAB6qUuNRx08iMo6kpvwU9XNwi6u1cot5OtOuK/flz3EfgFoUmtZvV9BuH5QxH+5HO7
         hv2Du3gAWew2zPiX6HoxmYstRyeg0tf49Uu/mQ2AZbJj7vIZYuclHtBIT8gPd//wrf7N
         k8nATdTm2KMXGf/Yg0qgvpY+ZOJHpSUFkCkKeT3dZN+x5amLlLL1/NdH743oZ//+HHQN
         O/vnzQo2/hWhmY3g9XvnfUpOG1LG8gaSOaproV/DipMhYLYhv8tcNciXxtYfOqgNJL1l
         XiKw==
X-Forwarded-Encrypted: i=1; AJvYcCXuEf3A6+TMZPmiWIPiujBuJCb0o8ep9ZmbrOVjtzMCde3SN4U4M64Chz0WUargLDkiT3KXE5E6pchLQc6P+X+hZP+BvmxeEJpL2CpW
X-Gm-Message-State: AOJu0YwVOBwwaCe+zCbAoMfLAtR6mfyMlgQRavs1Vrs205jBRQ6Vj2DZ
	TtQRguOQNwOqMQEwbv85nBD3IgD1CZsbM52+BweIyi9ciwO0hAbHYiiorDI1bczJQ0ZtTMNi0nw
	3EG03VGoZ4w==
X-Google-Smtp-Source: AGHT+IHuK0XyI9quxEpVXMzaV02NmnG9/saRSfQMGl4jJ28Ky2gHkkoF49pjkowXvl/2+5uvWEfSmZJJeu1AwA==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a17:90a:e516:b0:2d3:bd43:789d with SMTP
 id 98e67ed59e1d1-2d3e00ef3d0mr40938a91.4.1723832765467; Fri, 16 Aug 2024
 11:26:05 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:25:22 -0700
In-Reply-To: <20240816182533.2478415-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816182533.2478415-1-jmattson@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816182533.2478415-2-jmattson@google.com>
Subject: [PATCH v2 2/2] KVM: x86: AMD's IBPB is not equivalent to Intel's IBPB
From: Jim Mattson <jmattson@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Daniel Sneddon <daniel.sneddon@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>, Venkatesh Srinivas <venkateshs@chromium.org>
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
 v2: Use IBPB_RET to identify semantic equality (Venkatesh)

 arch/x86/kvm/cpuid.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 2617be544480..044bdc9e938b 100644
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
@@ -759,8 +761,10 @@ void kvm_set_cpu_caps(void)
 	 * arch/x86/kernel/cpu/bugs.c is kind enough to
 	 * record that in cpufeatures so use them.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBPB))
+	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB);
+		kvm_cpu_cap_set(X86_FEATURE_AMD_IBPB_RET);
+	}
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		kvm_cpu_cap_set(X86_FEATURE_AMD_IBRS);
 	if (boot_cpu_has(X86_FEATURE_STIBP))
-- 
2.46.0.184.g6999bdac58-goog


