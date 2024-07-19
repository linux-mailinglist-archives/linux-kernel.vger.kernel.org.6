Return-Path: <linux-kernel+bounces-257720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51346937E1B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED51C28174B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7D514B08A;
	Fri, 19 Jul 2024 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgFEX+ii"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E014A629
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432644; cv=none; b=ecfq3KLNt7L1SFkxXJZJyIPvZBzWw/+wcnXNs+1RxdiXoSfPwX8ug+js102Dpa1D71MIw6EgC/Nck+vC4AnXZqIkxCE89u8Gc+i1J+YhxnmVwTm8PP39OOcWtc4X/3v3dY0kpDoHbz7ZdeFiLKloh5OPEhpxB/tnBnqEZJ7GSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432644; c=relaxed/simple;
	bh=vGX+QjydJu3zU32DeuD0uDs+BGgsKqP86RvQO+BJ6uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Thu58ggMUXmCnP8imtGtx/dDYkSOQFn3NlKrp9gp2qZ50ZZaa78EfN7zkRY6iQg3aCIv26Catuzxrgcu6Bx+X11l0Vkx4VzANdM0jenMKt4ABsp89xsPaDj8uaKHhEST/NoDy6C9+bimucTOY0OYIDGVPxCdmpFrlXEttN1dREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgFEX+ii; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc52d8bf24so27331435ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432642; x=1722037442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUvOecK3sLTMz6qm67Q0shiPwc10UQD2irey1Qg3WXo=;
        b=IgFEX+iim849Wzc++CNUkvAjvUB6Xb6zPl8eSF8bOwiDDAZkZZqS39BN9fNQ5y/btR
         StMXYkjGqLpS1nq47f1nDQBoDneL22/ZQDYjDnluYzgKINVZyPNjH2tLe85lN0uhafvS
         yS1O0IrDeOdzrCmP5T9gVSNHhkAXk9SSN6z4GZkKT0EKmVwkRPbEQj1Cr87W9jIyJFKV
         WNPyFFCG5Efqs34trfgO0FeJXI8p61CqMbzD2tuQYrcx/Xwkm5Pea9QUjljngZ5zdNv6
         IELnPCCL03fRlTONGDJxlb1ul75lZ0p9e1I81oGnizxC6fYpWwlOae5QIsEtkv8H+o9a
         FfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432642; x=1722037442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUvOecK3sLTMz6qm67Q0shiPwc10UQD2irey1Qg3WXo=;
        b=mN7Rj+dfSlSobIB2b8Y9n4wTTyZQFnYuKVusIFaX4noriM2PNYh4uMoITfB9t/Lh9F
         36gg4qX8BgFl7qs14a79yOE+NjlrpwHyoK/JVqREaL1XR8j7XVe3cXxjpCgGuB2cND0M
         2od4CNe8+YCQ9XRqIX0gxJOCrO9pivV5NBOJd0cPpEYM/IAiVdUICR+ACKfvawQhFiNo
         0W1yRm4POrfs/NVFwocofAH2v2E5TMI60lC4BeTdw0cqu+Xxxjhr9xrSPeG9FgFWjyjd
         udkChtotxqvMNt2vQF32njPVR3bsEdm6aAY54Y2kTrd496wS+OZESzZk2DiaYVimSH/q
         V5Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVSX9ht8PSotgpy2gtPuunNhGsNLap5xRbNP8GsQFxcqN5ScSpTUSTUJBJ671GL3lR0RjTj9Kg8OuTYPEmEKfothuAFAZG17BBlsPvr
X-Gm-Message-State: AOJu0Yx9R30Ky27t16mTGXCtgkinYguN+wOW42HEm3cZGpzO77Z9uqqw
	qGFDVNn+2X7u2rsopa1DPfSoz0xYHVHrDnNcN6peVpGSqeFRSPMcTcRSHuDfhIKTQxNOITDKOsU
	MsA==
X-Google-Smtp-Source: AGHT+IGnhKiwC1lWgStU0irxOJLtvwWl6nqop+oW+igV346cVb8SlQ4Ca/NDQl0jX64yTdSTKHgW0Kp/9hM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea10:b0:1fb:526a:5d60 with SMTP id
 d9443c01a7336-1fd74d87f6dmr880325ad.4.1721432642189; Fri, 19 Jul 2024
 16:44:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:43:44 -0700
In-Reply-To: <20240719234346.3020464-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719234346.3020464-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719234346.3020464-8-seanjc@google.com>
Subject: [PATCH 7/8] KVM: selftests: Skip ICR.BUSY test in xapic_state_test if
 x2APIC is enabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Don't test the ICR BUSY bit when x2APIC is enabled as AMD and Intel have
different behavior (AMD #GPs, Intel ignores), and the fact that the CPU
performs the reserved bit checks when IPI virtualization is enabled makes
it impossible for KVM to precisely emulate one or the other.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/xapic_state_test.c    | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 69849acd95b0..928d65948c48 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -70,12 +70,10 @@ static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
 	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &xapic);
 	icr = (u64)(*((u32 *)&xapic.regs[APIC_ICR])) |
 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
-	if (!x->is_x2apic) {
+	if (!x->is_x2apic)
 		val &= (-1u | (0xffull << (32 + 24)));
-		TEST_ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
-	} else {
-		TEST_ASSERT_EQ(icr & ~APIC_ICR_BUSY, val & ~APIC_ICR_BUSY);
-	}
+
+	TEST_ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
 }
 
 #define X2APIC_RSVED_BITS_MASK  (GENMASK_ULL(31,20) | \
@@ -91,7 +89,15 @@ static void __test_icr(struct xapic_vcpu *x, uint64_t val)
 		 */
 		val &= ~X2APIC_RSVED_BITS_MASK;
 	}
-	____test_icr(x, val | APIC_ICR_BUSY);
+
+	/*
+	 * The BUSY bit is reserved on both AMD and Intel, but only AMD treats
+	 * it is as _must_ be zero.  Intel simply ignores the bit.  Don't test
+	 * the BUSY bit for x2APIC, as there is no single correct behavior.
+	 */
+	if (!x->is_x2apic)
+		____test_icr(x, val | APIC_ICR_BUSY);
+
 	____test_icr(x, val & ~(u64)APIC_ICR_BUSY);
 }
 
-- 
2.45.2.1089.g2a221341d9-goog


