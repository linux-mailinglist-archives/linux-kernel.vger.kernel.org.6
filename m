Return-Path: <linux-kernel+bounces-332937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2256197C109
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D7D1C21990
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EEA1CB509;
	Wed, 18 Sep 2024 20:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aTlvEM/I"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52A1CA6A5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692841; cv=none; b=W8mjEa5vZ2EYhgPaZE6Uqxh+0I21bTpjR8wLG8XOTN7M7SfEEDIzlzOY865H86jkvf4Ws3RRgDgKK3gSfP+jYhioaq6VNJbcl5fct7UMlXjMNvZg1PRe5W1YqGJ/k6tUkq1pPooqTX1dPkOadOLdzBmszTihOyX/bO23up+wyV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692841; c=relaxed/simple;
	bh=7LFbPeFjkQq1UTJ8lEzVj85jrHSO5Ur9v/Y+l3mM/6A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CHC5PRhM4ZJONpaSfMG+fSPWXpLu//KythAR/CmAEE0ld1usy0vNQozvlVIo2xJvclnOp8G9Ca63ji1zE3cRXi2BwJzZUKAWjPdehN7sgBI5S0+QCped3rtk1rBM8AV3rYXNo00hErfAdEYeXQ4h/LU+7l9nj++eudQjdr2m2Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aTlvEM/I; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso289728276.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 13:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726692839; x=1727297639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rJ/KpP7ZLjH/baI+Q4VTgii8fM80xVyJoccolaGcXA=;
        b=aTlvEM/I8pCaQl8i/1OmC4g4gkSXYcpZlslWxUhWtYTDfGfjGRQb1zxEyVl6KgEk+k
         VfTE69P1955Qkmyc/WQHANhsb8ujWKbDFrmbIBv3BKH3Wfa/2MZAe7Zx632BfbUCRCTZ
         or/OHZq1VxZO0cbT8PrMFjedQJqKwX4DFFZ3SKlG/ns7rj44sbv4k9nz6lnpZ0cr9Hks
         L41kaJeehLWKjfjGoIyZCOEHHHnZo6Acdu3xCiop+kpIzG5FdYiLIHuASpTv0p/BQbT1
         Jx9F9Fi7PAw1lLP8SJA/FHwT1eABd6neOJ6qBAonXdyD9IU6+4wlJwM967qkBCIyzKjg
         VkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726692839; x=1727297639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rJ/KpP7ZLjH/baI+Q4VTgii8fM80xVyJoccolaGcXA=;
        b=fRNmycY+Xlvs9WO5q2wjzv4MPQAeiK9RhCo6IdTo9HJPuh7CI0qVkQlChCgqhZt8NJ
         n3j/wTKLL98sdfcunJS7ze1dQT0c3jBnVVVyA9eqpSXPWqNhSoNkhapqYMsvOUIFaaM2
         42ZJWufPcUWvAPs0+XYbtyT4TwUXdwvBK593N+3iPApKPYSHGsAiFzqncqQv3UGyhs9D
         YLDm+Qm0Dds3RYcOAwZJpglJtRVOkaPLWCQ2pk/3TSmi4k8e/pZpKb08bKnFgmFPQqg0
         2Sb6hweHpR+xyUv2ILmA9weokMWVFYyg/EYNAwZqUvEzjH1/9Vwc+TwRGVU35lwPT7oy
         cDvA==
X-Forwarded-Encrypted: i=1; AJvYcCVXVSxvnhtu4iCLZfXn2EQWCtCxhdocR1IL251NIzK+nvY428e/l5+kD8nwnsCtvhz/3tgeCm6SaD48VEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTdRXXFTDL+bKcETbf1asCuBoA69SOy43T2DuCr9G+bZXHuQp
	SOPuW426fQEB+p15eCsaOjsAgnJpL5fUNKyPVY7UHSaIEMZILemcxIdGeg8272WVR6BHGxrnrWj
	jMhWwjnJATKWCY6hBdsI06w==
X-Google-Smtp-Source: AGHT+IE19c7uHgFQDSF5lDBOr6e84MO4hTZGPdwklurCeZKa3gXSTOztaJSR5dLNDju6LDGeGsq93ws0AB9ttpRl9Q==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:f304:0:b0:e11:7105:956a with SMTP
 id 3f1490d57ef6-e1d9db9c23fmr34188276.3.1726692839006; Wed, 18 Sep 2024
 13:53:59 -0700 (PDT)
Date: Wed, 18 Sep 2024 20:53:14 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240918205319.3517569-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918205319.3517569-2-coltonlewis@google.com>
Subject: [PATCH v2 1/6] KVM: x86: selftests: Fix typos in macro variable use
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Mingwei Zhang <mizhang@google.com>, Jinrong Liang <ljr.kernel@gmail.com>, 
	Jim Mattson <jmattson@google.com>, Aaron Lewis <aaronlewis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

Without the leading underscore, these variables are referencing a
variable in the calling scope. It only worked before by accident
because all calling scopes had a variable with the right name.

Fixes: cd34fd8c758e ("KVM: selftests: Test PMC virtualization with forced emulation")
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 tools/testing/selftests/kvm/x86_64/pmu_counters_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 698cb36989db..0e305e43a93b 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -174,7 +174,7 @@ do {										\
 
 #define GUEST_TEST_EVENT(_idx, _event, _pmc, _pmc_msr, _ctrl_msr, _value, FEP)	\
 do {										\
-	wrmsr(pmc_msr, 0);							\
+	wrmsr(_pmc_msr, 0);							\
 										\
 	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
 		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
@@ -331,9 +331,9 @@ __GUEST_ASSERT(expect_gp ? vector == GP_VECTOR : !vector,			\
 	       expect_gp ? "#GP" : "no fault", msr, vector)			\
 
 #define GUEST_ASSERT_PMC_VALUE(insn, msr, val, expected)			\
-	__GUEST_ASSERT(val == expected_val,					\
+	__GUEST_ASSERT(val == expected,					\
 		       "Expected " #insn "(0x%x) to yield 0x%lx, got 0x%lx",	\
-		       msr, expected_val, val);
+		       msr, expected, val);
 
 static void guest_test_rdpmc(uint32_t rdpmc_idx, bool expect_success,
 			     uint64_t expected_val)
-- 
2.46.0.662.g92d0881bb0-goog


