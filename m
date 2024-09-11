Return-Path: <linux-kernel+bounces-325604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B129B975BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673F81F23B67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27591BD01A;
	Wed, 11 Sep 2024 20:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nh8Fl5B1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14AF1BC9FE
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087355; cv=none; b=iC0wFc6IbJj9S4pgt4dZDiG5YYSRTm5kCtkH7uqlpyAdq5kKZoJJFTw/B3xd0cdBmT02KW573tQx2FqZeJPXplarOVQbv+IxODc/Fg5XLZkncF4hI1uOmFa76+v1qeRoRNhElbTgWapoC8rOCKm1RLZR4iOV1kdWIGbqOdCUAL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087355; c=relaxed/simple;
	bh=1saQ6Xhz3JzwSNCRR1yV2CCjz4AlXZeyzxAJr9SdD5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y21lgUlQmVrfLWKVA0Kk9ydr5zF+PHKQgKxJEu+eGAyUX4QPB18C6mFthDm5MFPk07TFdAjzxlpfIvR5Flaq6/v4K16oGCP3uXc/8KnHtH7VDtEeoBSaaSsx60ngUD+bz6S+KMPMxCOYPMJhzSRO0li3jqWTNxlKzWRCzRmGU+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nh8Fl5B1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-205428e6facso4479135ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087353; x=1726692153; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/zCwfp6P0Cp/T+by076ZLxu5O+Esa9Wy3+GZFib04b0=;
        b=nh8Fl5B1uMJnzTK73PvfxxAQ4f6H5uAMcdZARFGessH0r0jaqoOot4GHUEfYvUh0jR
         djN9CTfewLrF7pFYcBLXh7X5Xb0bqyHBXl35Rt9xcH3Mpprq9AdtzFDiswpbPiaRuUDW
         qUtApXQHEeyWuomDoU+BEVXmv7AfUoPb1bBo1PRZAqU+m0QdPy/31kfFbDBhmjhzxlfb
         1H7lILbQm/AEpESny11TXjzVG9foGMd/DN7O29D9swNzfQQWQHMUlJAFhXZN9z5D6wcj
         t8PlWwaNFeHfNNroDRK85u2JgzVYk+8uiiWkJZm4t++mXMlk2DuN5M1mgDg1GsjHAhWa
         ApVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087353; x=1726692153;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/zCwfp6P0Cp/T+by076ZLxu5O+Esa9Wy3+GZFib04b0=;
        b=qNCSpV01nNWSFKyU4fdkgpWwMQWeEWOmnRw57rIgONPhaiWa2RvaExoZX5ru/pWySY
         IuxSNReKe1gUTDYdktddOPZH02Jd/VP1BES0J76W5vn8K7MZqCgHv8PdNC8b2iYqqDNx
         CuFgKZkUWC1wH4ii6l8JdSqd5eDNbNnZYyZQg53SPt70Q8lJ8LCUOOgHuwz6BSh1iaIQ
         BaCqLD+EaEstnZU3wi1pPGoFsCHdgpE/5yNZGn/v3lKa/6jdCngwE0AO0xZxwi9oLvjx
         rTmrCUKwAABfvHVaULvZjqMXeijVht/+dtAcHs66/a21etayxyMBr6o9trmskV+tN+Dt
         Nibg==
X-Forwarded-Encrypted: i=1; AJvYcCUUv1TpltwcgAb5PGSRSh69yGMVKJB2xbaatMoUIoA8k9QT+/VDkQeTKb18KMCMPU7sHaEG4YaYGNdt6Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgN+HtSnVZrJtaKhjfRNJWnX80bEq+KeSjvHzbWt2KB/mSxRSs
	2d3CNiZm9inXmV1mLGdouTL+661CRpoWIRZVuO7DRHgnQmDnRA/tLsuliun+Py4f+qdSGbgc3mI
	yrw==
X-Google-Smtp-Source: AGHT+IGUai264jNYdPregUs2lG6efJQ9mB9ec+8i+QUzJ8LDBnAP8lzvYrxYOQMf2YPIMJvqww0dvL1st/8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f68a:b0:206:c5ec:1445 with SMTP id
 d9443c01a7336-2076e44b9a6mr10485ad.8.1726087353017; Wed, 11 Sep 2024 13:42:33
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:51 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-7-seanjc@google.com>
Subject: [PATCH v2 06/13] KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename max_guest_memory_test to mmu_stress_test so that the name isn't
horribly misleading when future changes extend the test to verify things
like mprotect() interactions, and because the test is useful even when its
configured to populate far less than the maximum amount of guest memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile                            | 2 +-
 .../kvm/{max_guest_memory_test.c => mmu_stress_test.c}          | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/{max_guest_memory_test.c => mmu_stress_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 48d32c5aa3eb..93d6e2596b3e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -138,7 +138,7 @@ TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += kvm_page_table_test
-TEST_GEN_PROGS_x86_64 += max_guest_memory_test
+TEST_GEN_PROGS_x86_64 += mmu_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_perf_test
 TEST_GEN_PROGS_x86_64 += rseq_test
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/max_guest_memory_test.c
rename to tools/testing/selftests/kvm/mmu_stress_test.c
-- 
2.46.0.598.g6f2099f65c-goog


