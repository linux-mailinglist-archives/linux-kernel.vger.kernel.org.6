Return-Path: <linux-kernel+bounces-535126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD4EA46F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B28A16600C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBF2702B8;
	Wed, 26 Feb 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNR+sn03"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B19F2702A6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611893; cv=none; b=uxv0TJBZlJN9fsPTqj5YjZ+HpFWbtSt/Z30O6sELnCXW2TZDsJ/Z8jOO+JXgbJxHyc5PXH8KAQo++4mJl+SywdWxFqJ/buMWxbfozOxDNMl8X31Z6T9uhi3CVi05s8f6uL0JPOzGZR4tIHKpgqri0XMcvmId1d2p8hvvErwASd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611893; c=relaxed/simple;
	bh=Qkm5BIKtbAFKIKjExrny2u3LarGMU+GBVzkWBeN5zS8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pZUnzt9bi7csnUHj9Hu6jO8H5PEu2CY3HMsoBbD0sqE0V8kTtTLJKB5xHi4MEzvz//8dySohJRRus0Ah2DaVNPO7j0uBbZ4w8fWJAMnRATRitSw0t2VGdzp2NOXXsvTbH1n7ZeR2JPbJAo2e1Q8X+C0biDXfhvVrYtxuSt1VZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNR+sn03; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ec5c16e9so4828365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740611891; x=1741216691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OApIGFxNkhYuZ7jMdFGNMK6W71TWPZaSxPmKfEXurdM=;
        b=ZNR+sn03iCrYTR1zv+ibh3WUhe6Sp3kdvfzBAZR1GkZ/S1x5/SJqTaPQ1DP4Eza6uN
         rLAhukLBfD3ECeAXTIN/RnIXXEUyFZeEqtgZEYsCUGebnzxEIU+g7RqOocOB4jhmT6ZV
         N8huwKYLjgRwzoyvaYsthxOS/n8U9+nIauFZSdORYm7g/9g/CJr0qfp97O3GNrBVaEIl
         y3CZS5bNRiBtwu41YG8Tth0dQJUbZvN7JhsDipgM8lqQlmVyXjCcLvcTOSQNi1sb/KrG
         blhcLbSR0s/JTKggHam1dy2aH9AQ9c+rR3DkJ+ManGgtHybIjo1I1MtXZjzqwLFt/c/c
         rjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611891; x=1741216691;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OApIGFxNkhYuZ7jMdFGNMK6W71TWPZaSxPmKfEXurdM=;
        b=WepoXFyWTE47X/R8VQas163b8Y10UM8+Xvf68RJHI4ezuZDBh6hCKvRvBz3PQtxs7n
         li4X63pgC8VcaIqHCn7NbQmn8R2hBQ5AXPl0zxZOD7ixrhuJaah4zR2PTfRj9kx6ocpM
         j4ZGiranaTCBnU+vwQSU4PWQj1k/gRUyKQYY5F1HKyvVr7jeIWmueEK4ndEvZWQu1ZDG
         Pk1mWha2Iky0fa/T8PWv21egtkS4rmLeYgtp328uC8w8yAbRI1sRpKA5ffmpNVipaILR
         Cr09p43MBhUQegst+yZzbEsLgevAU7rmdTfavMd+0sFd6aaGJcZlt8KU67mPD62uvlUO
         6m/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBzuQcyWxQ8ZaPn7nwcYQYfgrGdwto17jE+mPnHFGmt1RAO8dYJDGQ9o7mh848wyZy/SNVGKreiVXUC7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOLZlR7iKfSTXmDW/HC0ZY2RDQ28InLV5DVKl3rFQ8xhALnzl
	FX2V/IMI7rWxmHRA6AbrWb73iXOrHqMt3SyB0jhK1ioxLQS+dhf+wL5gzDqLlCj1mgkOvFTOfBz
	nYA==
X-Google-Smtp-Source: AGHT+IGhzRlzNfLfem0QIlPUfzfjHMql18Hl3vIG1JGEHOibbS5iEQ41pW7nqNdJBFPxetvvTbfh6soGDVg=
X-Received: from pfjf17.prod.google.com ([2002:a05:6a00:22d1:b0:732:2df9:b513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:190e:b0:730:87b2:e839
 with SMTP id d2e1a72fcca58-73426d8ff83mr41869311b3a.21.1740611891375; Wed, 26
 Feb 2025 15:18:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 15:18:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250226231809.3183093-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Relax assertion on HLT exits if CPU supports
 Idle HLT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manali Shukla <Manali.Shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"

If the CPU supports Idle HLT, which elides HLT VM-Exits if the vCPU has an
unmasked pending IRQ or NMI, relax the xAPIC IPI test's assertion on the
number of HLT exits to only require that the number of exits is less than
or equal to the number of HLT instructions that were executed.  I.e. don't
fail the test if Idle HLT does what it's supposed to do.

Note, unfortunately there's no way to determine if *KVM* supports Idle HLT,
as this_cpu_has() checks raw CPU support, and kvm_cpu_has() checks what can
be exposed to L1, i.e. the latter would check if KVM supports nested Idle
HLT.  But, since the assert is purely bonus coverage, checking for CPU
support is good enough.

Cc: Manali Shukla <Manali.Shukla@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h |  1 +
 tools/testing/selftests/kvm/x86/xapic_ipi_test.c    | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 61578f038aff..32ab6ca7ec32 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -200,6 +200,7 @@ struct kvm_x86_cpu_feature {
 #define X86_FEATURE_PAUSEFILTER         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 10)
 #define X86_FEATURE_PFTHRESHOLD         KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 12)
 #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
+#define X86_FEATURE_IDLE_HLT		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 30)
 #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
 #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
 #define	X86_FEATURE_PERFMON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index b255c7fbe519..35cb9de54a82 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -466,7 +466,18 @@ int main(int argc, char *argv[])
 	cancel_join_vcpu_thread(threads[0], params[0].vcpu);
 	cancel_join_vcpu_thread(threads[1], params[1].vcpu);
 
-	TEST_ASSERT_EQ(data->hlt_count, vcpu_get_stat(params[0].vcpu, halt_exits));
+	/*
+	 * If the host support Idle HLT, i.e. KVM *might* be using Idle HLT,
+	 * then the number of HLT exits may be less than the number of HLTs
+	 * that were executed, as Idle HLT elides the exit if the vCPU has an
+	 * unmasked, pending IRQ (or NMI).
+	 */
+	if (this_cpu_has(X86_FEATURE_IDLE_HLT))
+		TEST_ASSERT(data->hlt_count >= vcpu_get_stat(params[0].vcpu, halt_exits),
+			    "HLT insns = %lu, HLT exits = %lu",
+			    data->hlt_count, vcpu_get_stat(params[0].vcpu, halt_exits));
+	else
+		TEST_ASSERT_EQ(data->hlt_count, vcpu_get_stat(params[0].vcpu, halt_exits));
 
 	fprintf(stderr,
 		"Test successful after running for %d seconds.\n"

base-commit: fed48e2967f402f561d80075a20c5c9e16866e53
-- 
2.48.1.711.g2feabab25a-goog


