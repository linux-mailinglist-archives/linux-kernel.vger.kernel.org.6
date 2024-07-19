Return-Path: <linux-kernel+bounces-257732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4827B937E33
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0813A282109
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CC14B966;
	Fri, 19 Jul 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zD+eUP1W"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19611494A4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433087; cv=none; b=NkNar8qMEZZCZqvMkvpxqAhrGC1XOkQdwnUjUn/bebeuudyKscysiNgklTsJnYJ80GXOZV6pj8YXqvMNVJJCuaVeHZ7gCNVo+9rF/jle7VuSkupEHaWhptmFpHpvB8o5eOBqlJ/oH56h9vOK7iMNnuyFMXesSPonYVbTg+SjPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433087; c=relaxed/simple;
	bh=M/NyQgjGXBaNreFjHyLA402m2eagNzOE5eYuTkfJG8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RP3tmv/0Y6wD+YRLh547vnlgIiwmK6D6/ihXu4rgUuxnhZOyt9Zog8fBHirnS2GGpW0qavPbGg1l+vtgF3VxarZNs62VM5O16ymVba3aVQa6Ki1KDhER8onONelXoU98/IkyRelN9EgyHEyUb34hBaP7AL/4wuRWY0SWDc3K8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zD+eUP1W; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc5e651bcdso23370805ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433085; x=1722037885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rky9lB8r38gMZ+TqqtRst26vC75RUEgf6EDR/NOmmsM=;
        b=zD+eUP1WU7wGtbT4m/PC+U/wBpDtGL4qu9fL1n2HR3cPceaYkiEThnGBJOjyLhdv9i
         WfIwiJmjthRQjNYEdf3X7M1EzFBF2ba+EGTKG+OsJ+DgXPb7Hb/xdmYduFxA0lIQ7G/o
         aoNhsVBGTz+MWJEKbAIen3NJ3R/d5y+ttABkELN3e4VHR1KIqvtQ3WoVP7fGexIlCNFM
         vr3W8J7jc5dcsb7RgIP84LmuKwHAPerACUsKAubTLSY5uIlLzhLoMqWNRIsNtOvhLRk3
         Z0kwzzK8Kqcu7jwW2Cqu6gDrWpu4iP+B3oVPNslxLMs4YbFECs7A3qAApxDGN+0VnS9J
         4+fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433085; x=1722037885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rky9lB8r38gMZ+TqqtRst26vC75RUEgf6EDR/NOmmsM=;
        b=BQcEcIrb3SreGyKSHMgzmLdKJDRHtYgUewjFYs8W+Zpwdjc23raKIJZ/ocRQrSEgXW
         wy7Bx87U7/Fr9Im3ID6jV+Q488l0UmIoXSkgl/6artKJHAOyUgppPL022A1j27L7a5qz
         c/9VUG40Md6hfGVbG/gFPOb8tcqH45YBYg7cYQACz0zMDu4QqWGMBljw9paloY6xRR4N
         0noH0eW5QG3ymMdWQ/kV/MRP/fbfUTOBPegg+hwlc4g+a7WkvN7R17go8jly/mx3Ig8g
         6A5C4g6/TxgV5MZIt5SmlYDQ2B4yM7tsck0abe0OgdKD/F3tsfNcI49C/0xEwxhG/7a9
         /Vjw==
X-Forwarded-Encrypted: i=1; AJvYcCXDOJGs+oka0P61fLqROOIy0VLlVn4yK3tREq9mfaCARLBxT8+04/n+aUAi3l4XAH0y55I00/i+ynUzyveg7iDBkGMiJI69UeBHvGcb
X-Gm-Message-State: AOJu0YwaNXwJyoqttG3Q7WSff2O9HHHhKG7Or6E5mUvDXtNyk4Ldskqg
	kp97GSLzASSVbacWvzpAu1OH2QVORxbYiGu1FLycuXpD/Cq9quw/5iWHNHHNTpC1A0rmetCzSeN
	X/w==
X-Google-Smtp-Source: AGHT+IGSRWf9jMvU/TzDtViOp5LXg8rQIWEJDZtRAQmAnRvU6S8IZvjXlJh7nuKM59TgEcdGyP5wOFgiCak=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:cecb:b0:1fa:9149:4979 with SMTP id
 d9443c01a7336-1fd7453544amr1146075ad.2.1721433085107; Fri, 19 Jul 2024
 16:51:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:51:05 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-9-seanjc@google.com>
Subject: [PATCH v2 08/10] KVM: selftests: Test x2APIC ICR reserved bits
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Actually test x2APIC ICR reserved bits instead of deliberately skipping
them.  The behavior that is observed when IPI virtualization is enabled is
the architecturally correct behavior, KVM is the one who was wrong, i.e.
KVM was missing reserved bit checks.

Fixes: 4b88b1a518b3 ("KVM: selftests: Enhance handling WRMSR ICR register in x2APIC mode")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/xapic_state_test.c   | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 928d65948c48..d701fe9dd686 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -31,6 +31,10 @@ static void xapic_guest_code(void)
 	}
 }
 
+#define X2APIC_RSVD_BITS_MASK  (GENMASK_ULL(31, 20) | \
+				GENMASK_ULL(17, 16) | \
+				GENMASK_ULL(13, 13))
+
 static void x2apic_guest_code(void)
 {
 	asm volatile("cli");
@@ -41,7 +45,10 @@ static void x2apic_guest_code(void)
 		uint64_t val = x2apic_read_reg(APIC_IRR) |
 			       x2apic_read_reg(APIC_IRR + 0x10) << 32;
 
-		x2apic_write_reg(APIC_ICR, val);
+		if (val & X2APIC_RSVD_BITS_MASK)
+			x2apic_write_reg_fault(APIC_ICR, val);
+		else
+			x2apic_write_reg(APIC_ICR, val);
 		GUEST_SYNC(val);
 	} while (1);
 }
@@ -72,24 +79,14 @@ static void ____test_icr(struct xapic_vcpu *x, uint64_t val)
 	      (u64)(*((u32 *)&xapic.regs[APIC_ICR2])) << 32;
 	if (!x->is_x2apic)
 		val &= (-1u | (0xffull << (32 + 24)));
+	else if (val & X2APIC_RSVD_BITS_MASK)
+		return;
 
 	TEST_ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
 }
 
-#define X2APIC_RSVED_BITS_MASK  (GENMASK_ULL(31,20) | \
-				 GENMASK_ULL(17,16) | \
-				 GENMASK_ULL(13,13))
-
 static void __test_icr(struct xapic_vcpu *x, uint64_t val)
 {
-	if (x->is_x2apic) {
-		/* Hardware writing vICR register requires reserved bits 31:20,
-		 * 17:16 and 13 kept as zero to avoid #GP exception. Data value
-		 * written to vICR should mask out those bits above.
-		 */
-		val &= ~X2APIC_RSVED_BITS_MASK;
-	}
-
 	/*
 	 * The BUSY bit is reserved on both AMD and Intel, but only AMD treats
 	 * it is as _must_ be zero.  Intel simply ignores the bit.  Don't test
-- 
2.45.2.1089.g2a221341d9-goog


