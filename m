Return-Path: <linux-kernel+bounces-535368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A977A471B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45860167CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B418FDD2;
	Thu, 27 Feb 2025 01:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIlsJA+U"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B317A5A4
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620958; cv=none; b=evJdCsgiyFIMZJBSBTEKpNGTqcIL+X5hC+Q/0upwdX7WKCE14q+95gIfUsdvPIBkoV8/sbapPXnno+z7EJXoQbb/MON/P31+ksZXK9hqxiPrqS1tPANDrThYB92TOT0U8SrvFGPQlXIgq0/fo3WgDtRDS61wMpLvsosBo0pRiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620958; c=relaxed/simple;
	bh=f+785LO4fr1Q0w+vl79+A+2demuBbiAwgE72UOupkZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rrD41+wvdg7n451z/rS3FPZHrliUkosWiuCVFayqBuR5NUOMCns5BGNd74cb73mQt4t8Fl7jG4AWnG2YqXsbBuDFk0VeNuXP3Crq7yt+4Sr4PCNYts6KTpGBNYOe95L5gUOiFI33oevQywQuclQ8LpyflUsaK6PYZdlJlK2L3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIlsJA+U; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2234c09241fso11440245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740620954; x=1741225754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NQZed8KL6LHWO/050rdoKsJKgWyNu5Psv+4lrw+wuwc=;
        b=eIlsJA+Udj73SUuU6QLqH/n2fyYA8LdiJC/C5pOhXpVTXq9u6PrH3e0qofqpJOS/u5
         oVBorRtU40CByG+KYgC9GijDQ7WKN77ZpNuFH9d8RRR+s3Budk+z4OHHodfgwu+bib/t
         UNpl09I5sP7BDH0c5GetDQ4JHwt5ScxOUkn6jCwGS5BT2gMTYlE5rY+d6a7WwcemEFhr
         HnXiRHO6NO8e+Cfp9ZKqVlHzyeSEPw9z3qIO52whYaXbafafUH0lcHcLiMLqetEj5UOX
         sCUmhV/FJIdETTJkF5gdTilHVgAq5XnA/I10wqSZ+lEyaFgVR9tOIp6UZETsTVpjzJfQ
         LY/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740620954; x=1741225754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NQZed8KL6LHWO/050rdoKsJKgWyNu5Psv+4lrw+wuwc=;
        b=AHECDzZCSS8biO7b/VrAI3Fj/qAuMVeRpcQtsj9OZknciwoD+HhpN+sYNkxxJI8nI5
         OhmPsb3C7bY8amGgQ37Av0h1FWEkcuciPCeXUNTV6idqAxNeg/sDq7y5v9j99UrIjxNX
         DUdf5O9Zu0m3oizD3hfzTJqcDR6mjsBZ915rHQbzGm48wbs9KErXCVnJs34zA7JUWodQ
         H7vmhB01yhMyVDlawF2Nc/HDn0f7/V/nslD9Cp0rSY9CfP5IjoBJThqygGMXzOPE1WnZ
         nogYQbJllTObkT3y5uwDPx/lHhlqo91wGNH5g0aTcEdBm7uXEaOqKl1StwAd1cBV/DIJ
         fJdg==
X-Gm-Message-State: AOJu0Yztqx2waRE45tr+J5ow+zzfLHxUdyUfYMAO2jRbkMxkdm6D1RDG
	Gw29eNhPqt8X8Ls5zaF4YOxrthOWgwJH8ysYmNHfPBn+b1CIPTU3tUXhZuCcAVGOB2DwUKwg8pu
	MSA==
X-Google-Smtp-Source: AGHT+IEBsvNRrBmGvNI+lMLh6OTitFYdua8e/JkLykQQgoZZ3p0Ao9dgEqJEduJTu6/BkxCWmHP7ogooq3Q=
X-Received: from pjbqn3.prod.google.com ([2002:a17:90b:3d43:b0:2ea:5469:76c2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e749:b0:21f:6c81:f63
 with SMTP id d9443c01a7336-22307b4aa2bmr131878595ad.16.1740620954634; Wed, 26
 Feb 2025 17:49:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:48:57 -0800
In-Reply-To: <20250227014858.3244505-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227014858.3244505-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227014858.3244505-7-seanjc@google.com>
Subject: [PATCH 6/7] x86, lib: Add wbinvd and wbnoinvd helpers to target
 multiple CPUs
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zheyun Shen <szy0127@sjtu.edu.cn>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kevin Loughlin <kevinloughlin@google.com>, Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Zheyun Shen <szy0127@sjtu.edu.cn>

Extract KVM's open-coded calls to do writeback caches on multiple CPUs to
common library helpers for both WBINVD and WBNOINVD (KVM will use both).
Put the onus on the caller to check for a non-empty mask to simplify the
SMP=n implementation, e.g. so that it doesn't need to check that the one
and only CPU in the system is present in the mask.

Signed-off-by: Zheyun Shen <szy0127@sjtu.edu.cn>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250128015345.7929-2-szy0127@sjtu.edu.cn
[sean: move to lib, add SMP=n helpers, clarify usage]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/smp.h | 12 ++++++++++++
 arch/x86/kvm/x86.c         |  8 +-------
 arch/x86/lib/cache-smp.c   | 12 ++++++++++++
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index d4c50128aa6c..df828b36e33f 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -112,7 +112,9 @@ void native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 void wbinvd_on_all_cpus(void);
+void wbinvd_on_many_cpus(struct cpumask *cpus);
 void wbnoinvd_on_all_cpus(void);
+void wbnoinvd_on_many_cpus(struct cpumask *cpus);
 
 void smp_kick_mwait_play_dead(void);
 
@@ -160,11 +162,21 @@ static inline void wbinvd_on_all_cpus(void)
 	wbinvd();
 }
 
+static inline void wbinvd_on_many_cpus(struct cpumask *cpus)
+{
+	wbinvd();
+}
+
 static inline void wbnoinvd_on_all_cpus(void)
 {
 	wbnoinvd();
 }
 
+static inline wbnoinvd_on_many_cpus(struct cpumask *cpus)
+{
+	wbnoinvd();
+}
+
 static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eab1e64a19a2..8146c3e7eb40 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4957,11 +4957,6 @@ long kvm_arch_dev_ioctl(struct file *filp,
 	return r;
 }
 
-static void wbinvd_ipi(void *garbage)
-{
-	wbinvd();
-}
-
 static bool need_emulate_wbinvd(struct kvm_vcpu *vcpu)
 {
 	return kvm_arch_has_noncoherent_dma(vcpu->kvm);
@@ -8236,8 +8231,7 @@ static int kvm_emulate_wbinvd_noskip(struct kvm_vcpu *vcpu)
 		int cpu = get_cpu();
 
 		cpumask_set_cpu(cpu, vcpu->arch.wbinvd_dirty_mask);
-		on_each_cpu_mask(vcpu->arch.wbinvd_dirty_mask,
-				wbinvd_ipi, NULL, 1);
+		wbinvd_on_many_cpus(vcpu->arch.wbinvd_dirty_mask);
 		put_cpu();
 		cpumask_clear(vcpu->arch.wbinvd_dirty_mask);
 	} else
diff --git a/arch/x86/lib/cache-smp.c b/arch/x86/lib/cache-smp.c
index 1789db5d8825..ebbc91b3ac67 100644
--- a/arch/x86/lib/cache-smp.c
+++ b/arch/x86/lib/cache-smp.c
@@ -20,6 +20,12 @@ void wbinvd_on_all_cpus(void)
 }
 EXPORT_SYMBOL(wbinvd_on_all_cpus);
 
+void wbinvd_on_many_cpus(struct cpumask *cpus)
+{
+	on_each_cpu_mask(cpus, __wbinvd, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(wbinvd_on_many_cpus);
+
 static void __wbnoinvd(void *dummy)
 {
 	wbnoinvd();
@@ -30,3 +36,9 @@ void wbnoinvd_on_all_cpus(void)
 	on_each_cpu(__wbnoinvd, NULL, 1);
 }
 EXPORT_SYMBOL(wbnoinvd_on_all_cpus);
+
+void wbnoinvd_on_many_cpus(struct cpumask *cpus)
+{
+	on_each_cpu_mask(cpus, __wbnoinvd, NULL, 1);
+}
+EXPORT_SYMBOL_GPL(wbnoinvd_on_many_cpus);
-- 
2.48.1.711.g2feabab25a-goog


