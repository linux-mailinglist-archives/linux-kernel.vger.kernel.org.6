Return-Path: <linux-kernel+bounces-349749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B66A498FAEF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E49283227
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060E1D0B87;
	Thu,  3 Oct 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AeSBXKvj"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F61D2B06
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999041; cv=none; b=TuhnB9buHV7WIDi/QfDE/RYlHxHyBIqmHaVgY7Y6pCTWkJ1qgHo88j9ROdbLEtYW/AzdphuAEB0Ntxsg9SOu8m4pTD7dg//JrgqoxBZwwNOhEY3NL1sMSb2yACVbMY4SdtcynadXc7GK7ClcLV48EV9dBw1T5KFjFzXwLtCrhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999041; c=relaxed/simple;
	bh=BC7/PgFAhuyr7N0SeAVV58DtND5eOdQFwYoP8EUI7lI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0DOo2fCBx6MZRdqKFN/owBewa+oFSgPK54r0xEWx/ZZ4d6RJT/rReKzxJ3ByP/F75wmcfhTGnujDCbWxwnITL1eBTPzSRuLit6Pe6trJHR0IJrR+m3+5LvvpPVpOW0AhE0Y+RJZtLFp3VZyLf9Y3z5eZ+TOQwvq23qhOamdH7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AeSBXKvj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-718f329aefdso1798969b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999039; x=1728603839; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=miF0NnrKs/LVUqtwEsnwKwGdVp/l7Rk6nLP0b8R2e6Q=;
        b=AeSBXKvjerqysEKNtTqIN57t0U5a620aWths1DPeJfPv3lCKzSps0UzOVNf8PTzNFF
         dFUsljWf+7Om+jHk+5p0BWFJzVrJSgIJ/pj23LVtPGKfIsaGUTC6C0vDFQq8ONX89GkB
         Xg8mxehdZVMuy6ofMJgX8Lqkdmh/UR5hV7Mw0BW1LedP2zArTe+iEDdFiMJUbIWpdmUf
         yNT9eprgzcAk5pYzZhEWxU/hEsDFJhW8zo/uPpqLgWpVvu4v/FxNcFKTqMXhsCDb2VGI
         TyNy6a/4Ksr/0DABLjMiGToMn4dZ94LcML767Zn+MzdYBQOBljCu2sad+YHqeydOy9x8
         +xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999039; x=1728603839;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miF0NnrKs/LVUqtwEsnwKwGdVp/l7Rk6nLP0b8R2e6Q=;
        b=OU+6wOLUlKFkSwa/5gnDIk5JCTQPuVhuhIBUfCuxRdOP3Dc7AxAjcmH1aDaqY253dn
         WRsIp0bMWpn8S88oDl3uxvMS3Lz1GDbnmA7KjVbix7NV+qUXMdWz9Qzpg7rk1HybfNC6
         PDdISgS/MBL+3ISOU7Wso41b7+K6ws1ytDaQOOyGm1VEOVMVbxsQeKrESKySwZe0TXM5
         jaN063H9Db6/CwqHSxBha3fz+VSdgMZznAkCfefBvVUvAo2KzjIeG518OTPlahUd/1Ns
         Qdty9XoVwhJRmxz7tXWcMdnNLil+k0ZEn+B8uklcNLbtFOyPUo4C/+h2DIqGJaAhtlMn
         9hVA==
X-Forwarded-Encrypted: i=1; AJvYcCUJkwwxfCDPe4ZhrS+FP/C42n7EpDHUI+OjR6i81VOi5e+KOK9Oq7+ICH5Y1iy63m/XfjSehzQMRPs5W0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB49rtmlgCwRc0pOMEIYhRoYdf4HdGnvDNUiS4v15is+/yvttN
	3yDk+co8/Pc013EzDEJK21dqHyK6NP8bOOx5QSFnxgaSQbjCOn6aLrs/EZW5Ivua55L62fEnpxZ
	Z0Q==
X-Google-Smtp-Source: AGHT+IFxJ85cxWVOAwm7Y/0i5309oldZWB8K0r+VZOLEUf2bRY9vmsB1cfaYlvtoaXQ+SY+jIkaIglV0w3g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a62:e815:0:b0:717:91ba:b156 with SMTP id
 d2e1a72fcca58-71de2455097mr8131b3a.3.1727999039232; Thu, 03 Oct 2024 16:43:59
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:36 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-11-seanjc@google.com>
Subject: [PATCH 10/11] KVM: selftests: Drop manual XCR0 configuration from SEV
 smoke test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Now that CR4.OSXSAVE and XCR0 are setup by default, drop the manual
enabling from the SEV smoke test that validates FPU state can be
transferred into the VMSA.

In guest_code_xsave(), explicitly set the Requested-Feature Bitmask (RFBM)
to exactly XFEATURE_MASK_X87_AVX instead of relying on the host side of
things to enable only X87_AVX features in guest XCR0.  I.e. match the RFBM
for the host XSAVE.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/x86_64/sev_smoke_test.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index 2e9197eb1652..965fc362dee3 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -41,8 +41,8 @@ static void guest_sev_code(void)
 /* Stash state passed via VMSA before any compiled code runs.  */
 extern void guest_code_xsave(void);
 asm("guest_code_xsave:\n"
-    "mov $-1, %eax\n"
-    "mov $-1, %edx\n"
+    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
+    "xor %edx, %edx\n"
     "xsave (%rdi)\n"
     "jmp guest_sev_es_code");
 
@@ -70,12 +70,6 @@ static void test_sync_vmsa(uint32_t policy)
 
 	double x87val = M_PI;
 	struct kvm_xsave __attribute__((aligned(64))) xsave = { 0 };
-	struct kvm_sregs sregs;
-	struct kvm_xcrs xcrs = {
-		.nr_xcrs = 1,
-		.xcrs[0].xcr = 0,
-		.xcrs[0].value = XFEATURE_MASK_X87_AVX,
-	};
 
 	vm = vm_sev_create_with_one_vcpu(KVM_X86_SEV_ES_VM, guest_code_xsave, &vcpu);
 	gva = vm_vaddr_alloc_shared(vm, PAGE_SIZE, KVM_UTIL_MIN_VADDR,
@@ -84,11 +78,6 @@ static void test_sync_vmsa(uint32_t policy)
 
 	vcpu_args_set(vcpu, 1, gva);
 
-	vcpu_sregs_get(vcpu, &sregs);
-	sregs.cr4 |= X86_CR4_OSFXSR | X86_CR4_OSXSAVE;
-	vcpu_sregs_set(vcpu, &sregs);
-
-	vcpu_xcrs_set(vcpu, &xcrs);
 	asm("fninit\n"
 	    "vpcmpeqb %%ymm4, %%ymm4, %%ymm4\n"
 	    "fldl %3\n"
-- 
2.47.0.rc0.187.ge670bccf7e-goog


