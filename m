Return-Path: <linux-kernel+bounces-257719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 414C4937E18
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38002821BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556A14A616;
	Fri, 19 Jul 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0r3601bv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D714A4D6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432642; cv=none; b=MOoTOL6ptfPoBFlL23AEEAxhDod8IE5YGFGmj2RHdimMvEBiQEvw1PhuC2fs8GVOSjsrZCBY8QTpUZJbWibsCm95NiXuDzL9iquUroHJ92oTLp1+aLMGIxDN3he0bEa6N+ztBXCyxfy+DF3vNCZxkiiiagUJykZVf8nBAk8Sy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432642; c=relaxed/simple;
	bh=avuIVrOvbdJuGswu1VBc5QXgq1mmaRUWopHFZ+/wLdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JFDYc0krRXaPtzusteiNa49xIkz4vokZHM9yTIg523vDx/LaAwI+DuChUiu/nfTpJrT/ccKTmHJGQZRpQrMTg2Kp1Vy5nICqb0YKRrpm87CsaAHnQuXrUMomlztYMCs5nUddP+LKSaHEv/Pz+zgK46Yr5eSOKX/NmhjOD1/0caI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0r3601bv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb4bcdd996so1818460a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432640; x=1722037440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vV3aMaVHf7C/0akufsxFVZJRmuCa+4Ea2SM/3XMiVaU=;
        b=0r3601bvHPZl17MhLs39ASHfYqDDVZLF/ZdoHoubWqtS08h5jfdX3wo6h4JvqIGu0J
         tYIe8VuuYIr8sgplw+OSabkUbgzNxEIIwY6LXA3uzUyBgnTPL29CoKfMHewytkSl9/Fx
         OBCJvXZNXggsMqp/Z0+cfUiQ592ek+H0v5pNnAdkFOER2YjnNTOpnZ+bMyl4KVCH8oak
         qJ2RcM5VLMOInvxks/wg/2rvKU1dUyJyxbkdBl8mHESEbjtI3qvjMpnyR6QePVGywUCX
         1tcWhBlbps4P26N9sqTtmwr0V785nb8yqDaIWRCuicYB3DSkR3148sZNdT0+u/T/8A6e
         gEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432640; x=1722037440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vV3aMaVHf7C/0akufsxFVZJRmuCa+4Ea2SM/3XMiVaU=;
        b=CfZNaKKCasKUPCGNjhSAhgRnUqHFj6FuFYg8LyGJh7rDWtwDnrtfShZ9niySDgO/Ud
         3RIE0bL2P7n/gTezop/2K7I8sAGoCiwcSZecqGgX15Q+162No8iQybyTi/yhOAFGCoRu
         V3InsKaorlcu5rx8cBzL/nnSRa0qfaUdMmwIy7IDahuFqXh4LRQ6g0MXrWPEiPPOhhX4
         tERufUS+rSmyYg+pLP/QCWE1y9EqcRTqAO3F3oukNLkoy80d1PlEEAV4GfKFddr5vrBd
         Lk3xzEinBC3/1m+AIHkrKDJNj4E3XHM8aChN6GvEW3E8HNRfY3P7w+Z6Uhv3wTdXHrdw
         Z/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUn25BEZ8U/788FY6bptICtfcwBf1gLfxZQZl8/8of/7NBst81RcNP2gL9zfSkRgh9EKiiSfSBnRC8j7KikmYYq41W2k2RjeKc4+AqY
X-Gm-Message-State: AOJu0Yy71L3/IhwR0L+KczByBhX9ZxPTmxOoyA//patNn76Ni1j0AFu0
	+52P1he1nlbn58PpTCzLgRaNTxd1YopRcu2IG6XNDwi/JboY/7NKFS6uafYojKl/N1DXHAAqWDZ
	bdg==
X-Google-Smtp-Source: AGHT+IGPvuABTRGzUn95rBWDL/2eBHyGq/tmVyD1jWvRffYkunDVRYZslMTOmS1p0lIemoM5bFBHW+JX+M4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:7081:b0:2c8:632:7efe with SMTP id
 98e67ed59e1d1-2cb7761c6bbmr21715a91.4.1721432640200; Fri, 19 Jul 2024
 16:44:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:43:43 -0700
In-Reply-To: <20240719234346.3020464-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719234346.3020464-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719234346.3020464-7-seanjc@google.com>
Subject: [PATCH 6/8] KVM: selftests: Add x86 helpers to play nice with x2APIC
 MSR #GPs
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


