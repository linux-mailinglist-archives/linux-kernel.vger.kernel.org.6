Return-Path: <linux-kernel+bounces-285207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85562950A99
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3A11C2083B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6FB1A38F6;
	Tue, 13 Aug 2024 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2D+223B"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992241A2C02
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567399; cv=none; b=GOYqI8byXJbb8nRTIElIT3R63FSdosl6virCYx5TtSAizF4oKuCUBZJmy6U2b+J8RPhbtsyqM2YGyaL0l0VZriPrSchmhpuEsQxA8xqKP5eHWFcXerPRs41subsPT8+CJlsnsbzTjTkQnMLWupldFfXSAjif55pe5iz7rCCKSpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567399; c=relaxed/simple;
	bh=v4fPQ3bf3I89lDkNGIzHum+PJC8y+wKwn575q9cvuzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VyQoQ1xyO9bnZCkEwqQzGRYJvR0BkVnEYZU0l1GAxJ/fGTI0nLoG7BkPkesX7+p5fx6Ydodywl2hjs+PHRw5/JlxAGpozN8v29liw6610sgilslN5DHFI3J7i5JTqvMscPQ9N6JOitP7gi9Snx8zloGNT14d7cnDMCkQ2Ix5NEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2D+223B; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-39b15a6bb6dso545815ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567397; x=1724172197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sgL70S4+dG2Qyapd3eVQQ0HKCLvTkvReAD20xuDL9hw=;
        b=u2D+223BOzJcj3lHQT94BggUC+J/x+/lLEf/e700/ZVgWABGEfoBF3a8dC+XK2Gsfr
         9OmoCFTrw7Hx5KvNOiugsX7v+dWtPYi5N0e1Ij2o6ZduBBkup4OWnFQ8gHE8U2m3LYOr
         1bs5eMJaaVJYDhk8WhDqvULKIY5gcdDG/RvW3melPnbj4HFeCfl+fIeJJxXW+JOZhDZ4
         c8+CztPJ5rLIl0h34su/CulEEYNkVMQLjsiT8NOjwZuTMt1pBPMex73AG6SW+85JXrh+
         hupR3MF3/Le8rHk13XeXdog0ujIl08oz6WtMidwqGdpKFayuZBVvdz8dXctVPUc8mEyS
         f4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567397; x=1724172197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sgL70S4+dG2Qyapd3eVQQ0HKCLvTkvReAD20xuDL9hw=;
        b=WvQatyoZNiR2IhuGp7/lDtWHy4nnW3pu1a8mdeNRSjqrkMm/ucLvxV4pyQfOMDCsm8
         duFLUgr+CQTloLWBQui/hFu9ilaqena3w5Neuyvs2dVwoiOFInmyEDGxe23HhIRrAm8+
         IGQu2fEdUqLR/GH/trYo5GKKQioCptv7oFR+9ycKpJGoFwToN3C0g/HTbUyYAvc3HE+b
         sfrekb16qwglGqUwvwVWbZf69Bx7zGyYgEDiSzzKVxy2yvYZ8qO7l2I+rILGidBKcTuI
         B39GA+38RLEBpRReDikKRIOftdV5yaU7VmldJ8UXqOq130JzqkMICzAmE1uYtjwgFqRm
         /wMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGkz2iaAysZ0a5HyxDw7i9gsnCXjSry07oi38O9IUyBzyUY9sIOMkfOuYZ3DTOzxxqPlhas5YjZjL3EtaDW7cNsBkDgAsb3vd5WaPm
X-Gm-Message-State: AOJu0YyYA1aiE3RsUJzPDacDztwY8ArIIJkZuQHoadNgNqOnfMdbzhBT
	QqYP9jVNvG6JjwGxU0zeAIA+AquM9RJdl4dKohHd9B65nWxW1ky6L5vk7yQK54g+9gAufZaNi86
	67DGC5ddphrkEj+ZL8ikz3A==
X-Google-Smtp-Source: AGHT+IEMzS4g6YBWOuvRkL9fDIVltMciftLvn5LDHPHYvvupM7c70l0d4kLcwSXFjGfv1320K+mL4WWI1BSR3GYh6g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:cb1:b0:376:3fad:bb7c with
 SMTP id e9e14a558f8ab-39c48bd96d4mr529865ab.1.1723567396876; Tue, 13 Aug 2024
 09:43:16 -0700 (PDT)
Date: Tue, 13 Aug 2024 16:42:41 +0000
In-Reply-To: <20240813164244.751597-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813164244.751597-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813164244.751597-4-coltonlewis@google.com>
Subject: [PATCH 3/6] KVM: x86: selftests: Set up AMD VM in pmu_counters_test
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Branch in main() depending on if the CPU is Intel or AMD. They are
subject to vastly different requirements because the AMD PMU lacks
many properties defined by the Intel PMU including the entire CPUID
0xa function where Intel stores all the PMU properties. AMD lacks this
as well as any consistent notion of PMU versions as Intel does. Every
feature is a separate flag and they aren't the same features as Intel.

Set up a VM for testing core AMD counters and ensure proper CPUID
features are set.

Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 80 ++++++++++++++++---
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 0e305e43a93b..a11df073331a 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -33,7 +33,7 @@
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
 
-static struct kvm_vm *pmu_vm_create_with_one_vcpu(struct kvm_vcpu **vcpu,
+static struct kvm_vm *intel_pmu_vm_create(struct kvm_vcpu **vcpu,
 						  void *guest_code,
 						  uint8_t pmu_version,
 						  uint64_t perf_capabilities)
@@ -303,7 +303,7 @@ static void test_arch_events(uint8_t pmu_version, uint64_t perf_capabilities,
 	if (!pmu_version)
 		return;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_arch_events,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_arch_events,
 					 pmu_version, perf_capabilities);
 
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH,
@@ -463,7 +463,7 @@ static void test_gp_counters(uint8_t pmu_version, uint64_t perf_capabilities,
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_gp_counters,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_gp_counters,
 					 pmu_version, perf_capabilities);
 
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_NR_GP_COUNTERS,
@@ -530,7 +530,7 @@ static void test_fixed_counters(uint8_t pmu_version, uint64_t perf_capabilities,
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 
-	vm = pmu_vm_create_with_one_vcpu(&vcpu, guest_test_fixed_counters,
+	vm = intel_pmu_vm_create(&vcpu, guest_test_fixed_counters,
 					 pmu_version, perf_capabilities);
 
 	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK,
@@ -627,18 +627,74 @@ static void test_intel_counters(void)
 	}
 }
 
-int main(int argc, char *argv[])
+static uint8_t nr_core_counters(void)
 {
-	TEST_REQUIRE(kvm_is_pmu_enabled());
+	const uint8_t nr_counters = kvm_cpu_property(X86_PROPERTY_NUM_PERF_CTR_CORE);
+	const bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	/* The default numbers promised if the property is 0 */
+	const uint8_t amd_nr_core_ext_counters = 6;
+	const uint8_t amd_nr_core_counters = 4;
+
+	if (nr_counters != 0)
+		return nr_counters;
+
+	if (core_ext)
+		return amd_nr_core_ext_counters;
+
+	return amd_nr_core_counters;
+}
+
+static void guest_test_core_counters(void)
+{
+	GUEST_DONE();
+}
 
-	TEST_REQUIRE(host_cpu_is_intel);
-	TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
-	TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+static void test_core_counters(void)
+{
+	uint8_t nr_counters = nr_core_counters();
+	bool core_ext = kvm_cpu_has(X86_FEATURE_PERF_CTR_EXT_CORE);
+	bool perf_mon_v2 = kvm_cpu_has(X86_FEATURE_PERF_MON_V2);
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
 
-	kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
-	kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_test_core_counters);
 
-	test_intel_counters();
+	/* This property may not be there in older underlying CPUs,
+	 * but it simplifies the test code for it to be set
+	 * unconditionally.
+	 */
+	vcpu_set_cpuid_property(vcpu, X86_PROPERTY_NUM_PERF_CTR_CORE, nr_counters);
+	if (core_ext)
+		vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_CTR_EXT_CORE);
+	if (perf_mon_v2)
+		vcpu_set_cpuid_feature(vcpu, X86_FEATURE_PERF_MON_V2);
+
+	pr_info("Testing core counters: CoreExt = %u, PerfMonV2 = %u, NumCounters = %u\n",
+		core_ext, perf_mon_v2, nr_counters);
+	run_vcpu(vcpu);
+
+	kvm_vm_free(vm);
+}
+
+static void test_amd_counters(void)
+{
+	test_core_counters();
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_is_pmu_enabled());
+
+	if (host_cpu_is_intel) {
+		TEST_REQUIRE(kvm_cpu_has_p(X86_PROPERTY_PMU_VERSION));
+		TEST_REQUIRE(kvm_cpu_property(X86_PROPERTY_PMU_VERSION) > 0);
+		kvm_pmu_version = kvm_cpu_property(X86_PROPERTY_PMU_VERSION);
+		kvm_has_perf_caps = kvm_cpu_has(X86_FEATURE_PDCM);
+		test_intel_counters();
+	} else if (host_cpu_is_amd) {
+		/* AMD CPUs don't have the same properties to look at. */
+		test_amd_counters();
+	}
 
 	return 0;
 }
-- 
2.46.0.76.ge559c4bf1a-goog


