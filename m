Return-Path: <linux-kernel+bounces-257730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56377937E2E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37011F22878
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B92114A62F;
	Fri, 19 Jul 2024 23:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOAWMULj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489EE14A4C9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433083; cv=none; b=b2OlMwNTJyZ0zstaKyT65wWChvOGWZ/FndMaYUM8WuNLMYXl1Bbe/+pofFXPK5dzTVnF7O0KqgxRrBUGJFBVaGNwNzO1wIiNfyRXEXpKuOA9hFqxujsh4/vjeNd3OS4rkVti4/6FgNciQSLh4aKE0lY0/ab6+wNcG8vXVNxP+to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433083; c=relaxed/simple;
	bh=avuIVrOvbdJuGswu1VBc5QXgq1mmaRUWopHFZ+/wLdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b6WkGA7h3EEIlicAk7I62dtTKdXM4qPgfBC5OA13b02Pibd2NBzcImjqcE9MVdubz6XpIa3pSsIQVuMqKvc4eu9hgOqsWjLQ3ngQ5RAbWQAF7ZzMSCHhWcreFn7o96xG6kYSYVadJ4WFz6OuO1tEoh0yBktpDrxoczBqqI7OrmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOAWMULj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e087a57edcaso119987276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433081; x=1722037881; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vV3aMaVHf7C/0akufsxFVZJRmuCa+4Ea2SM/3XMiVaU=;
        b=eOAWMULjI0sxK5+DAGTf7g9lHPawrWWDsxm1ws1SCXQnGgMmZlrpwdvAKK7GIiqYM/
         86KTwrWcZOkwk7sU/2lG9+C+pPS+aOu3skk+15ZSsWbZXh357kpP52cV6LIaXA9WXY6h
         XZacye6vD82sbm6lh+YBso2VPAnffT8ty12duHvIQ10PyaYDF8jrzeH1NYR+TzbOcrls
         CLRqv2lUm6tC0DqTkqJeCf1A8mOAz/aX2lzGpAs2KwolKFs9IAeD1hyKRhE2EuBPVrnA
         hpDs8Nr+nLZVF9W7EJ7QHudRi4WsIGGTcEgbl2OpPSsOCGvuSqXa/kkwlkZi41i08PHI
         DiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433081; x=1722037881;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV3aMaVHf7C/0akufsxFVZJRmuCa+4Ea2SM/3XMiVaU=;
        b=VtMdyPbvNdjVxdLk1AQqxvfRZKKeSxgssuimgyuOM/uVk8KgxjwvBSmG55m9JHOMRF
         yZ1Ad1+wM84qlwzJZK+rev3zteporwl/RIOk8dbT1RpuLLSMB0gdj29Tkc7WsjwddtNB
         UmRpYJSML0UaReMrLlW70bnsMGRWnympw7g3/nv0pRtbsye8YM+tRua2sJRzOvf/dtl1
         RIk5UYnYU8Y8FtQfpX4W2Ym8C1he7U09DqvoJt2YIVlgQw+bWZSGYk/2exKParg/LZ6U
         NWqSAnEswC7kj7dHnmxHKgn8JEsQw4FZqatY0sRzxAi/HwzrxHjScPWttgCU1IPRc69p
         V59A==
X-Forwarded-Encrypted: i=1; AJvYcCWeZ8GL/D0SrwQ49GfxtYuVpA4V4HR4C/L+7jjKF23McDUyVEZcGGu2FfSqCStxDJcqy2ElNCSIXK2XTcCiqHVL/wWSQS3LjRzuNVK7
X-Gm-Message-State: AOJu0Yy2434raupSz/vbSMwyy0mopBxbZXh4rkLzMVj1nyD2XGQYpNFH
	PB2PaGvG/OwocijtBHIx6+rmAnWHTConii/iQP2Hw5fDI6yGFy2TVL9F3otZuJe1SHkazn/3dZM
	Oyg==
X-Google-Smtp-Source: AGHT+IFx9+7vK2ERpoBYVxnQ2HTxUS6m7HbUD6i5XHwtnqVPJXqKCxVy91eJGzC7dRUx4lbD788BVlCbsAI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:100c:b0:e03:b3e8:f9a1 with SMTP id
 3f1490d57ef6-e086fe45084mr25809276.2.1721433081278; Fri, 19 Jul 2024 16:51:21
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:51:03 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-7-seanjc@google.com>
Subject: [PATCH v2 06/10] KVM: selftests: Add x86 helpers to play nice with
 x2APIC MSR #GPs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Add helpers to allow and expect #GP on x2APIC MSRs, and opportunistically
have the existing helper spit out a more useful error message if an
unexpected exception occurs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/apic.h       | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/apic.h b/tools/testing/selftests/kvm/include/x86_64/apic.h
index 0f268b55fa06..51990094effd 100644
--- a/tools/testing/selftests/kvm/include/x86_64/apic.h
+++ b/tools/testing/selftests/kvm/include/x86_64/apic.h
@@ -11,6 +11,7 @@
 #include <stdint.h>
 
 #include "processor.h"
+#include "ucall_common.h"
 
 #define APIC_DEFAULT_GPA		0xfee00000ULL
 
@@ -93,9 +94,27 @@ static inline uint64_t x2apic_read_reg(unsigned int reg)
 	return rdmsr(APIC_BASE_MSR + (reg >> 4));
 }
 
+static inline uint8_t x2apic_write_reg_safe(unsigned int reg, uint64_t value)
+{
+	return wrmsr_safe(APIC_BASE_MSR + (reg >> 4), value);
+}
+
 static inline void x2apic_write_reg(unsigned int reg, uint64_t value)
 {
-	wrmsr(APIC_BASE_MSR + (reg >> 4), value);
+	uint8_t fault = x2apic_write_reg_safe(reg, value);
+
+	__GUEST_ASSERT(!fault, "Unexpected fault 0x%x on WRMSR(%x) = %lx\n",
+		       fault, APIC_BASE_MSR + (reg >> 4), value);
 }
 
+static inline void x2apic_write_reg_fault(unsigned int reg, uint64_t value)
+{
+	uint8_t fault = x2apic_write_reg_safe(reg, value);
+
+	__GUEST_ASSERT(fault == GP_VECTOR,
+		       "Wanted #GP on WRMSR(%x) = %lx, got 0x%x\n",
+		       APIC_BASE_MSR + (reg >> 4), value, fault);
+}
+
+
 #endif /* SELFTEST_KVM_APIC_H */
-- 
2.45.2.1089.g2a221341d9-goog


