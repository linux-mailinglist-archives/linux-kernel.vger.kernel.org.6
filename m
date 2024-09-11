Return-Path: <linux-kernel+bounces-325610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FEB975BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADB0B2345C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227CA1BE87D;
	Wed, 11 Sep 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUM6hTdl"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221B1BE851
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087367; cv=none; b=H3l7VOjXTWv+Ieysa+ukDb4x1PBRN7vX1RFV3K6+9Cj6YMWEP7WWeonFjXMxsHB37bWpNX3nIe1gYvRopRmLwhNS10clI/e19b+cn+ZPUiGEj6cH620teHxT7sKY5OKLOAgHCJez4mepLwFqxekxArJG+W31y/oCTHJPG9agMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087367; c=relaxed/simple;
	bh=8oi3u31KxpdCNwifk0F+crB0nVZG46vd0de0WiqVC9c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gqz+Vqi73WBdq5LMO6P9QsVdqca6CXgB/0txOBRK9GJZSCGCHn3IiUtsnY+6X+yHjK0r37BAmSVRXOr9vT2XFS9BYwbJ4wn1QBXnA1uo3Omi7aygwHHcuXNJh1zYNkKGZuIv3iDnB8Vqp0zzU2Tbgu0barfAj6pHUkM6cR2GVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUM6hTdl; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20535259f94so6635385ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087365; x=1726692165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hqBHipBEc9VIgDpl6wbsMWiAPCMzGAxUDsb/VQrQ1Fg=;
        b=OUM6hTdl+tJZhMLUMb4clrwW+vMBVdUKc51lpK9cOdppZR5TmC7Eh9aBoXf0GVP7sS
         MS4iiKhh7dgAeVYe8BvUedALoLD9tvlnQhyg07JnOZRVUAsnROKIYbw8KVwLs+dJuHbV
         X/VKd6VoFmU6k4XORw6wON0AM8JslDkNeG/baQsYuztWKsn/izR3YeLAvZYOI/cZs6PY
         09ZDXOPIpOMUvqvuatpW+ph6kBSX96mpID/rq3O38ZibKvk3scGSKqIM0n4jdak5+xnh
         eYxPH7V6dcwV4Y6Wu43C17EuygG6ZeKoK9Y+TiSbLjyOUOECw80p6gZ+gCL2WaOZ3I21
         eZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087365; x=1726692165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqBHipBEc9VIgDpl6wbsMWiAPCMzGAxUDsb/VQrQ1Fg=;
        b=g8/pSIEB6bpTNqU1+/Y9yOxS5Mc5raEt1O2mc6o9YIUqd+NJ7rSWoK5MXivbl05p4N
         /xaAoCYN5r3QcqECXSjv/fPVTm2dB/qep84GwqR524MoAy3+w9Mo+wduKAoTdeI13LXk
         IY7n9j+R2dgeMO/6De0dyrq+/tiHFMJWr1DRbivHokCTa5VTOTvkg86VOVYHSXuJZgQ/
         xu45FS6KV40zvBQD4ALcsXJdSQG9d9ZtBuZCfbEb3P3Ab/r4pD0zz17+S5IX0oYMJwnq
         JsRmPvwQdIaN8yUHTrKBpi6bNE1GLsKTDB3Sa+RVXLKdesHrrNy7Y2vnW3015yEpM0YM
         nyOg==
X-Forwarded-Encrypted: i=1; AJvYcCUd2KIOJyCw42WzYg6IFOQVwsLvaWRvipJbAHjWY4UdZ1eKhCbo0SM9KTmSdyWbF3zmsX/noDQuipVe0yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxCt/Lrgli+egqWYZS0q1vGN5QUxm9Ha1jzMP+sL39z8Ei4HTX
	NYkUwjwECw1nYoj6ysPVd7LW0B69mLsWoLgyETz1fAY/7+UNaITzhd9C58Q6WdyOZBCi/8s9Iz2
	G0g==
X-Google-Smtp-Source: AGHT+IGFL4zTHrWHCMVM8aBCteHxHmYI7HhRHME2L0vYSDU/f35eVCRnBetmKBLszuGgfMu2jElNurnmeFg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f90b:b0:205:937f:3acb with SMTP id
 d9443c01a7336-2076e4768d5mr74435ad.10.1726087365359; Wed, 11 Sep 2024
 13:42:45 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:57 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-13-seanjc@google.com>
Subject: [PATCH v2 12/13] KVM: selftests: Add a read-only mprotect() phase to mmu_stress_test
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

Add a third phase of mmu_stress_test to verify that mprotect()ing guest
memory to make it read-only doesn't cause explosions, e.g. to verify KVM
correctly handles the resulting mmu_notifier invalidations.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 9573ed0e696d..50c3a17418c4 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -27,6 +27,10 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 		GUEST_SYNC(i);
 	}
 
+	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+		*((volatile uint64_t *)gpa);
+	GUEST_SYNC(2);
+
 	GUEST_ASSERT(0);
 }
 
@@ -94,6 +98,10 @@ static void *vcpu_worker(void *data)
 	run_vcpu(vcpu, 1);
 	rendezvous_with_boss();
 
+	/* Stage 2, read all of guest memory, which is now read-only. */
+	run_vcpu(vcpu, 2);
+	rendezvous_with_boss();
+
 	return NULL;
 }
 
@@ -174,7 +182,7 @@ int main(int argc, char *argv[])
 	const uint64_t start_gpa = SZ_4G;
 	const int first_slot = 1;
 
-	struct timespec time_start, time_run1, time_reset, time_run2;
+	struct timespec time_start, time_run1, time_reset, time_run2, time_ro;
 	uint64_t max_gpa, gpa, slot_size, max_mem, i;
 	int max_slots, slot, opt, fd;
 	bool hugepages = false;
@@ -278,14 +286,20 @@ int main(int argc, char *argv[])
 	rendezvous_with_vcpus(&time_reset, "reset");
 	rendezvous_with_vcpus(&time_run2, "run 2");
 
+	mprotect(mem, slot_size, PROT_READ);
+	rendezvous_with_vcpus(&time_ro, "mprotect RO");
+
+	time_ro    = timespec_sub(time_ro,     time_run2);
 	time_run2  = timespec_sub(time_run2,   time_reset);
-	time_reset = timespec_sub(time_reset, time_run1);
+	time_reset = timespec_sub(time_reset,  time_run1);
 	time_run1  = timespec_sub(time_run1,   time_start);
 
-	pr_info("run1 = %ld.%.9lds, reset = %ld.%.9lds, run2 =  %ld.%.9lds\n",
+	pr_info("run1 = %ld.%.9lds, reset = %ld.%.9lds, run2 = %ld.%.9lds, "
+		"ro = %ld.%.9lds\n",
 		time_run1.tv_sec, time_run1.tv_nsec,
 		time_reset.tv_sec, time_reset.tv_nsec,
-		time_run2.tv_sec, time_run2.tv_nsec);
+		time_run2.tv_sec, time_run2.tv_nsec,
+		time_ro.tv_sec, time_ro.tv_nsec);
 
 	/*
 	 * Delete even numbered slots (arbitrary) and unmap the first half of
-- 
2.46.0.598.g6f2099f65c-goog


