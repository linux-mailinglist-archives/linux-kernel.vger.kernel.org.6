Return-Path: <linux-kernel+bounces-273023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A1946378
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7693428251C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818321A7040;
	Fri,  2 Aug 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUMfBmJN"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411D1A34BF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624933; cv=none; b=JK1lUefLbISynYLFiutL3UefVRmF2S5jefG/7y+kWskF8T2MZGD79GligME0Sissu9Bylmu3QTNrTQ50iUmmJC5QKU+bQErIkmTLyJO2+CfK7Pm1ktJ9sYAplcMcJEMJ+INxw+oEatp37dx+PZmdDFr7sdii81X46xe4sOJIukU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624933; c=relaxed/simple;
	bh=eIV+FYdJhQs5sXuHNlkR0r+AyOQQyHcB8GM1pTTn+fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIxQcf/ibIAGb07LCulJlR9SBJ0KgB2K6NssKc4nenfncVFwezzTzXPliJMjMum1FGf60Z+nR1mrBJtWUjLqd26svrgNSezL4fRNcodK1qMkyQPnqDoQHA3YmvyVijexg6GXAc9dMtuda2rDvnSHdXYlsFkxf4Jb/yCFuGnFyOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TUMfBmJN; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bebbbebeaso1303489276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722624931; x=1723229731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MerlJqn4bVyg3mGydSW2OGMbCzaSyxYLo7ygyAWKfwY=;
        b=TUMfBmJNd8cyYCPPfeIri8h913Evp559Iil3ZzIKaj7woy688p37ZbxI8zgTto/6U8
         /A2nOJVdFf5evXRyvd6i24AZ2kSHCVoVy77qfAcrMogy7ShpM73JF8F8F4nv8zmCvv14
         ZqaH/AgtLy8S3tTt/SeNI1aE3KIZ9foCvtz4iO72AHFVC/WkMto08pEWJLG21nAXygY7
         m28AR11wlqFoLpJNiLZSkYpBpc9RSUemcw0mKwiL0gV7bHaa5I0DzSSJVKx7ACBL+P0X
         jRTJXC7UDmGAT72dNieoYR5ekyVo013nc4OXjWlFIfm5md0dwbquwMhralafEELbkjeF
         wI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624931; x=1723229731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MerlJqn4bVyg3mGydSW2OGMbCzaSyxYLo7ygyAWKfwY=;
        b=H+9XW1JYzx9vlHlhVu8Qc0NxoegeifFjoKm0E7gVtMjbhZ9h19/bjQvgKodgm9nc3c
         VwHdUuP9/R4zUuPKAFWpaItZOItIycGHwvmk4fd7Q6tqJsgji6sk7WbmhEHviZE1xHPe
         hLfNPiJmmPBMVDqSOn3hcGQa+j9dy6EsAimMsdXyt4R5IIPzzFi6WYwrHaFdwwlBETgs
         n4YjoPcU4An62RkQTPLWxDVlES/2vPiUJU5LM4EWOubyhnC/zKe6HOvIberuQg/57c77
         FiMGsQ8R9ij5i4fR15CQpYmRs3xnulvCmpFDtaeuiWruA0NV6Ah04wa6FgQS7iV8EmTU
         qxhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ+NoKv4r1k2RX4PRBn/LGXl7BXMeU90s623DVcNfhBVTeLsEcibAf1sZv5wUW4Cg0z+dUWqRT6nh2iN3OKZbfYIYnLQzwFZpObjIu
X-Gm-Message-State: AOJu0YySfemFq5ew4ZstYFwMHqCrOLXRQ/ix7fclji4o/q/5eruIvSya
	I2j+Fuvs11z3TqEv1SOltSEQ7w+BdT9STXfTAVPfrDfbo/4Po605toF7R4UTzrrRxA+0Stvd04+
	T5g==
X-Google-Smtp-Source: AGHT+IHswe5/CkX/DtlsTvaAS5oC9dYy6wH3QqDG0ZluG+o3E35qvyo4ilahXxkGw4Z6a6FaqYnqfF/to1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b12:b0:e03:6556:9fb5 with SMTP id
 3f1490d57ef6-e0bde481682mr107222276.11.1722624931070; Fri, 02 Aug 2024
 11:55:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 11:55:10 -0700
In-Reply-To: <20240802185511.305849-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802185511.305849-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802185511.305849-9-seanjc@google.com>
Subject: [PATCH 8/9] KVM: selftests: Verify get/set PERF_CAPABILITIES w/o
 guest PDMC behavior
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add another testcase to x86's PMU capabilities test to verify that KVM's
handling of userspace accesses to PERF_CAPABILITIES when the vCPU doesn't
support the MSR (per the vCPU's CPUID).  KVM's (newly established) ABI is
that userspace MSR accesses are subject to architectural existence checks,
but that if the MSR is advertised as supported _by KVM_, "bad" reads get
'0' and writes of '0' are always allowed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/vmx_pmu_caps_test.c  | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index 7c92536551cc..a1f5ff45d518 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -207,6 +207,29 @@ KVM_ONE_VCPU_TEST(vmx_pmu_caps, lbr_perf_capabilities, guest_code)
 	TEST_ASSERT(!r, "Writing LBR_TOS should fail after disabling vPMU");
 }
 
+KVM_ONE_VCPU_TEST(vmx_pmu_caps, perf_capabilities_unsupported, guest_code)
+{
+	uint64_t val;
+	int i, r;
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, host_cap.capabilities);
+	val = vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES);
+	TEST_ASSERT_EQ(val, host_cap.capabilities);
+
+	vcpu_clear_cpuid_feature(vcpu, X86_FEATURE_PDCM);
+
+	val = vcpu_get_msr(vcpu, MSR_IA32_PERF_CAPABILITIES);
+	TEST_ASSERT_EQ(val, 0);
+
+	vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, 0);
+
+	for (i = 0; i < 64; i++) {
+		r = _vcpu_set_msr(vcpu, MSR_IA32_PERF_CAPABILITIES, BIT_ULL(i));
+		TEST_ASSERT(!r, "Setting PERF_CAPABILITIES bit %d (= 0x%llx) should fail without PDCM",
+			    i, BIT_ULL(i));
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_is_pmu_enabled());
-- 
2.46.0.rc2.264.g509ed76dc8-goog


