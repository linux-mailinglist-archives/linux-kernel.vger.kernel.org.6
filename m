Return-Path: <linux-kernel+bounces-225294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33085912EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BA5283721
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5617B4E0;
	Fri, 21 Jun 2024 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP0p8WZK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898917BB1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002597; cv=none; b=SncxcYDKUB8KTbiXHimdPUg0oJjqBMOnTwLSq3pLWLIVyHFTZYkXnf03r/2ub+N99EvjDJFKxfHDYECLfChQ/m+sNAroqr+71xNoC3sL35w9+/XoNKSjJ1xUyN1+UAlBXgnUynLC63WUPBgBFa2A8oDxBDnqBRsCXcQNzZ7Q5Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002597; c=relaxed/simple;
	bh=fbPKq2NOUyj6ARzm8j1aTUi+9sMeeTHtszN5s48caQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MfdJGCs1esY89SVNC2OrpdIrfem38t9bf3nPaTc5pNIKRljaUVa9Y9fZmCoGHP2KXPpg2dLzA2zl1wHgEvs6gDZhpcm22WS3egOwwpeviF00wzRHDHUhvWOlQFJ1q2BKJZQvCSX2uJNYfeHenKFMAzKiZAqlQRsJmxxCiml8pX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP0p8WZK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719002594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tdFYqlnxT4b/X2jXFdbuNA5FlVONtuFtg+X8/7Lucfc=;
	b=VP0p8WZKxGwy6BWPsn9vokQBk4//m+ORwiHmiPM7L5AwN1KM9MBy+UoG/Lee/RoiyUPaE9
	c9V6GSpIGfSbRsi3bpYrUrNCCc6yzPfw5nLShCyymWyoNEFAHvMqmpIAiDbMMDHED2aJze
	C6CVin921YWCQO2WDfSwF8+mrEMVQ4I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-JLWNBzHjPtaauPbx2ljLmg-1; Fri,
 21 Jun 2024 16:43:10 -0400
X-MC-Unique: JLWNBzHjPtaauPbx2ljLmg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F8E019560AE;
	Fri, 21 Jun 2024 20:43:09 +0000 (UTC)
Received: from starship.lan (unknown [10.22.18.76])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AF67A1955E72;
	Fri, 21 Jun 2024 20:43:07 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/1] KVM: selftests: pmu_counters_test: increase robustness of LLC cache misses
Date: Fri, 21 Jun 2024 16:43:05 -0400
Message-Id: <20240621204305.1730677-2-mlevitsk@redhat.com>
In-Reply-To: <20240621204305.1730677-1-mlevitsk@redhat.com>
References: <20240621204305.1730677-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Currently this test does a single CLFLUSH on its memory location
but due to speculative execution this might not cause LLC misses.

Instead, do a cache flush on each loop iteration to confuse the prediction
and make sure that cache misses always occur.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 20 +++++++++----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 96446134c00b7..ddc0b7e4a888e 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -14,8 +14,8 @@
  * instructions that are needed to set up the loop and then disabled the
  * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
  */
-#define NUM_EXTRA_INSNS		7
-#define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
+#define NUM_EXTRA_INSNS		5
+#define NUM_INSNS_RETIRED	(NUM_BRANCHES * 2 + NUM_EXTRA_INSNS)
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
@@ -133,9 +133,8 @@ static void guest_assert_event_count(uint8_t idx,
  * doesn't need to be clobbered as the input value, @pmc_msr, is restored
  * before the end of the sequence.
  *
- * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
- * start of the loop to force LLC references and misses, i.e. to allow testing
- * that those events actually count.
+ * If CLFUSH{,OPT} is supported, flush the cacheline containing the CLFUSH{,OPT}
+ * instruction on each loop iteration to ensure that LLC cache misses happen.
  *
  * If forced emulation is enabled (and specified), force emulation on a subset
  * of the measured code to verify that KVM correctly emulates instructions and
@@ -145,10 +144,9 @@ static void guest_assert_event_count(uint8_t idx,
 #define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
 do {										\
 	__asm__ __volatile__("wrmsr\n\t"					\
-			     clflush "\n\t"					\
-			     "mfence\n\t"					\
-			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
-			     FEP "loop .\n\t"					\
+			     " mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
+			     "1: " clflush "\n\t"				\
+			     FEP "loop 1b\n\t"					\
 			     FEP "mov %%edi, %%ecx\n\t"				\
 			     FEP "xor %%eax, %%eax\n\t"				\
 			     FEP "xor %%edx, %%edx\n\t"				\
@@ -163,9 +161,9 @@ do {										\
 	wrmsr(pmc_msr, 0);							\
 										\
 	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt 1f", FEP);	\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
 	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
-		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush 1f", FEP);	\
+		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush .", FEP);	\
 	else									\
 		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
 										\
-- 
2.26.3


