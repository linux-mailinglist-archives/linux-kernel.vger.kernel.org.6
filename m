Return-Path: <linux-kernel+bounces-233207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9069691B450
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47340282989
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8D81B80F;
	Fri, 28 Jun 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alRpKdfs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4592D1400A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536167; cv=none; b=jMwHJSdx6fWW274hGzVcVglsmT7Z8b8fNoB0BzZYGNYFNLv8OjB1bGT1BGRJxEGtg2Uyy1w/NEFK3Z18R0ijM9w6Rj9vpDEQThrugLcThQ3u4zCU6TOL70tTOmqOLDq8QhKSBsJupBiJsKM2IUuV8zMtkXfuDXD3EbuMUkTJeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536167; c=relaxed/simple;
	bh=ouz2HkMvZDg0rz7UCNaykl0tgJjrYN90xrQGH+dM7JY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jOCXCcyLcqMvfzUr1QOPA8kAaRe0Zy7G9o3FltTJ8cP0pWdxTvfPE6lbkvDzhll20V+Hh/8gLzceKsBH2GCffyr8xqyViwGXSuaHrL5qfZK3hzmzuS8oXcTZvN0Mq97hahQPcObKP0vt4UnlLfxnMv+IiBiXqjtXrZtP2x3NV6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alRpKdfs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-63a988bdec8so1138177b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719536165; x=1720140965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=lgbEHLSUX+AoWB8CRQeP7XnPv01GFcLuAOz7jK1qHRE=;
        b=alRpKdfsnHpA7HntXjzxkMf/D8+31439xytPM/cpqOfqlYXXVy9xHArkYKFboS4Hiy
         7p68DA4G3A3mMWQ8OabX+SjelTBMdnjQ9TJp3M0oeOnfbsujj+feCY1wek34BCmc2hdE
         rTMWP8WHhl5vWiBQwddMq6X9arnCe/JmePCKd8HDEKEk02e9QHOSbiIMxBv6MIsD9GN6
         nYGOVMnP0HJy8nLxytYIOQPvJa8vq7vPRmnXYU2ZfHSkKgKw0Ow4zRuqDrkZbHQlQSXk
         3Pvrc9Wd4BjY+mYQo/EYHv1wnqbE7NXFwtatB4JRFUlhefTNTJfP+Nl7nxYOLKsEbZbt
         IYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536165; x=1720140965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgbEHLSUX+AoWB8CRQeP7XnPv01GFcLuAOz7jK1qHRE=;
        b=d3E2lYlDLdObwTC/qlX01ox0K2467yMNbW+c+kuaiBdpcgGyvXQvrWkPVtx6IDs/xA
         BCCCjwv1rS4hBcT2iKg1/WHhgyn+muoG3guWv87hn4H0wZElvlcL3gLG6ugqT7LFGaaM
         Mdj0iYl0A2R2zYDvT+aC+GQie/4JuMqfzUDhsnHomfbULn0GokYf2U7fno3wpiSzWO0O
         aqXIPpO2W9OmFyEOrfHlcikIosexW+NgmDlLyu8sdMBww2LXTzPbB3TqHeBNQ1yaZ2Jh
         umZ4Skw8ucs8JxOArAdIRT+CFciBfEj7rXUkdE4LMYD7HebtbZ89Ynsfewf0a0FtKAZk
         VMSw==
X-Forwarded-Encrypted: i=1; AJvYcCVTudhEITUMpos4H9UvjayZuIrIiyInELu5zLUflQ2yqrBl7xhJaiojBGK2eJ+LauHXHN/U2cDONUun6HnYY9l9xQO+6bisXR0WZDIH
X-Gm-Message-State: AOJu0YxPBU8AjQhjqoWDeq3LiKUXQs87hFfIb0pcrFLULkyk/mgzTUXX
	kIyVbO2emsqQ65YnSoJPXt6zeLNTxX03/WaM4HerFum68FJuBr/jjM0fXu2C857t2dEfLoBOhca
	J6g==
X-Google-Smtp-Source: AGHT+IEfsdzeEKoN2CFXkFy/F27W7DGQi+5hVe0TUGhV9Q5SkO0DdUv3a6absdV41KaqoJhZfCUpZvmBwzM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6a01:b0:62c:f6fd:5401 with SMTP id
 00721157ae682-6433f0e209dmr1891667b3.6.1719536165349; Thu, 27 Jun 2024
 17:56:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Jun 2024 17:55:57 -0700
In-Reply-To: <20240628005558.3835480-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628005558.3835480-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628005558.3835480-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Increase robustness of LLC cache misses
 in PMU counters test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

Currently the PMU counters test does a single CLFLUSH{,OPT} on the loop's
code, but due to speculative execution this might not cause LLC misses
within the measured section.

Instead of doing a single flush before the loop, do a cache flush on each
iteration of the loop to confuse the prediction and ensure that at least
one cache miss occurs within the measured section.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
[sean: keep MFENCE, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index bb40d7c0f83e..698cb36989db 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -13,15 +13,18 @@
 /* Each iteration of the loop retires one branch instruction. */
 #define NUM_BRANCH_INSNS_RETIRED	(NUM_LOOPS)
 
-/* Number of instructions in each loop. */
-#define NUM_INSNS_PER_LOOP		1
+/*
+ * Number of instructions in each loop. 1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE,
+ * 1 LOOP.
+ */
+#define NUM_INSNS_PER_LOOP		3
 
 /*
  * Number of "extra" instructions that will be counted, i.e. the number of
  * instructions that are needed to set up the loop and then disable the
- * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
+ * counter.  2 MOV, 2 XOR, 1 WRMSR.
  */
-#define NUM_EXTRA_INSNS			7
+#define NUM_EXTRA_INSNS			5
 
 /* Total number of instructions retired within the measured section. */
 #define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP + NUM_EXTRA_INSNS)
@@ -144,8 +147,8 @@ static void guest_assert_event_count(uint8_t idx,
  * before the end of the sequence.
  *
  * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
- * start of the loop to force LLC references and misses, i.e. to allow testing
- * that those events actually count.
+ * CLFUSH{,OPT} instruction on each loop iteration to force LLC references and
+ * misses, i.e. to allow testing that those events actually count.
  *
  * If forced emulation is enabled (and specified), force emulation on a subset
  * of the measured code to verify that KVM correctly emulates instructions and
@@ -155,10 +158,11 @@ static void guest_assert_event_count(uint8_t idx,
 #define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
 do {										\
 	__asm__ __volatile__("wrmsr\n\t"					\
+			     " mov $" __stringify(NUM_LOOPS) ", %%ecx\n\t"	\
+			     "1:\n\t"						\
 			     clflush "\n\t"					\
 			     "mfence\n\t"					\
-			     "1: mov $" __stringify(NUM_LOOPS) ", %%ecx\n\t"	\
-			     FEP "loop .\n\t"					\
+			     FEP "loop 1b\n\t"					\
 			     FEP "mov %%edi, %%ecx\n\t"				\
 			     FEP "xor %%eax, %%eax\n\t"				\
 			     FEP "xor %%edx, %%edx\n\t"				\
@@ -173,9 +177,9 @@ do {										\
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
2.45.2.803.g4e1b14247a-goog


