Return-Path: <linux-kernel+bounces-272994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87A94631F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C371C20ED7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94FD3DABFE;
	Fri,  2 Aug 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1efgfqv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A1421C18B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722623008; cv=none; b=IjerLqfKp56/fdzZ3YCutsemO43iZGjOH3ZGmRD2n9UXAb2pbyunicCbNwpcCcG/3Ml25DiDETh1YNWeUK1ZPqCXBo5Io7NaLOQwirFfRzhM12K2jfnveniGrYuSKzh0Eji4K7oV4WQMhzPa1Txf8gpxQGX+eeA9Bt81/YtNevk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722623008; c=relaxed/simple;
	bh=t5yfFgH9ibPxbspkUAv08vifOSOXvkrbmarqeKUHNec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bgMb4EKAAnG07Uz63K3S8NLWiylgoDb8k5qvtmQsb3ygA+eEVPx3vUZS3fFyBPHh6iXrkD9cfapZN0hTjr/hr/UnJsYbYbWy281i8QWzmfMt6XusGVDoR0vfLAZBQmCJRfzPJazfCplC14KUuI8MZbDarg0iviHISb798kwVH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1efgfqv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3742b309so12337715276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722623005; x=1723227805; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+gWTjgtCkRYFWW1GzmPZwN0r2c2xgD+FnvKvPUO5Yc=;
        b=V1efgfqvQhNS8R8AhLyNT4/+7fMZg4geGq+SW0T8S+Orq/3tGtafAi3KPDC0eL63tF
         uAe+EcqtWyiqXc/1gJsXfRgSM1ConfqMx6gaecPTKFsrJ4Zu4a4OE0ulJ3SXvZ6T7QRN
         p2sPPeEui+6WqS4WnUwjAT7snCbwPOtmxbaX0cW+knNyer4NQBN1+7LJM4NkIyMoaIET
         n6jamXzXzVnHUX/0RQKXwRq0nfEibbOLSl0m4wt3z4cWdoYlZGpPeT3/wtiHK3KVI+Dj
         IBPn/DEdMEBlQBF3a2tYcEFKP9je1W2q7647uBPRm53W4GwRjQNsSqZE1pYEtk/nGjNj
         X1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722623005; x=1723227805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v+gWTjgtCkRYFWW1GzmPZwN0r2c2xgD+FnvKvPUO5Yc=;
        b=tGSn9FXg3YDL9VwBNNclifVdTD+S4jeUSwxfqdx2KIxFkZ2SHEStASJe3MFo1zohlG
         JKCnUjEb0Qn0x/rlRMXLYLB0lfY6xeMXMkLo2QfLTLWJKepDl9wa+rnpvRSrcraGG8Cz
         55+e+S7tDaLSti1Yyf/jp2ni7SaIOMG2QkaQoLlsK7B+hfF3nT7mrxvjxdJUyoC8+hg5
         wiysnbIQSI+39UWOCTymcvp6ZabcmSXWX/Flhs34Tb24HH3D6rgNjMEGqeOJ3GQ6776e
         uG1QwUgcC1I1pODBF9DHOsPu9DECqisVP+74+kluleLMr+67uduC1UWoZ6W6BlA352Qz
         2jmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJsX0nyNxV85rkkUUJtz9CfDpkGLPmU8/CIF0bPb/h2+3znF3LRzSj73er7Whp8JVkgwxhXUwj0hSdo/rbDpATrpgM48iN6Sw+BffS
X-Gm-Message-State: AOJu0YyWRK1AOl3JgAZ6PgHgywyspzOctN0XWS4nGvktwpp+8E53oIkW
	A5C2cgQGDzbzYxkd+OmV5+eomq3922CZLfMF0GH30FAHZd4Hb/GMNHcfKKCSWtSsXrTIwoO5VVb
	rIZgrswlNGkmBPkWmuOmjTQ==
X-Google-Smtp-Source: AGHT+IHIxi2bUOzRGGFcYEQj+O4fh0rQpQV9JaZDgKLUag1mDu0fuzixL7xb4lP4fZSR8NjHgonBhqXCr0OCVlzOFg==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:14ce])
 (user=coltonlewis job=sendgmr) by 2002:a5b:bc7:0:b0:e0b:c0a5:71e2 with SMTP
 id 3f1490d57ef6-e0bde45ffb2mr14075276.11.1722623005492; Fri, 02 Aug 2024
 11:23:25 -0700 (PDT)
Date: Fri,  2 Aug 2024 18:22:35 +0000
In-Reply-To: <20240802182240.1916675-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802182240.1916675-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802182240.1916675-2-coltonlewis@google.com>
Subject: [PATCH 1/6] KVM: x86: selftests: Fix typos in macro variable use
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
2.46.0.rc2.264.g509ed76dc8-goog


