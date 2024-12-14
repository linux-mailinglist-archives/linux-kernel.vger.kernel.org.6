Return-Path: <linux-kernel+bounces-445812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E39F1BCB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80300164155
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC518052;
	Sat, 14 Dec 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebE9QEXk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D81AB500
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138473; cv=none; b=ghtQ3Pc2jl2Xturq+Xlq8NyK6GB7/vAu2V3bXPUrFE07KnIt+AnLM8IiMVMjEeoGI1EeNOacebwBKh5FfymXL/BUnIBmtcgw5yd8q7LfqetBSvNbiA2VL+EdkajVUmX6DuV1Do0eC9r7UISk6sJKy4kPBsg+t5dsajkUEDOb/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138473; c=relaxed/simple;
	bh=s82yfUral0BohE54IlxUWxNUqQShfk9wROTZ0YeYQLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uQ62EMT3R5QebUP9WVyRsdRnjFjdVZH5LlFte0zp2zXCD2gXkEIa0MInHdH1a265sBG9x1Jlqx0H8cBixKbBCMKpsoI7BrzMfjwS05xxlrxAbk6APd0qpqXhZJQat0nPU4OVevQQ5elB0sgFPfa8kXQzbtZgQtlCvpkwv0KXmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebE9QEXk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2163a2a1ec2so32490005ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138471; x=1734743271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YWWtymQ8Nn5N0UWTLn3mSIvyTdUGCBiZBYn7TuhHiD0=;
        b=ebE9QEXkR20I8IRtJFTzXEG3bF6iInfwctjmwySXuYfh4Rp010xmd6saYQ+4gCdo7r
         bWxXw3N6uvq35x1e3be1MiDl5WB4Rulh+NABTwW6eaIRpTEKjcSWOm86wXmraJOmSpOo
         NY3nB2iv1rqub1UlZelLRl40DxoxhRI8zDk1cYqICWsF3kJP7x+5bXw1pD5/O8FxE5kL
         aGq2GAVeNkfC/i04AZ9/MTx1HHtNyC5/j1zkmkvI72Efy3LvRTRlNiAb3oEt1n9X22Pt
         rYK+q3tfCEjhgxA+PbQM0TeslcHjmTVE+BCa2hRIWOJRbZNUoR4Gzmc1Cbl+Bo+yEtSV
         QHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138471; x=1734743271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YWWtymQ8Nn5N0UWTLn3mSIvyTdUGCBiZBYn7TuhHiD0=;
        b=FpTDsDz8fVxcvibgp/cGHoY/FKz2nPM+zmya9WSHjjgY2yh4shO+oBY6RyQveN5L05
         5mCzcxdEQevb65f3IO4CPcBD7A05UGMeVUCT8VNtDqBXuY0a76s9uH5Ih8ZHNMSpSNaA
         gVhysJu5f/8nsSwNuGLdtsyUHwA9XPwioNhk6/w7sc7uywGRlQ5zOaNkAvlv6yAgdoml
         CydMY4OpPkvuKBWGUsNQpfc/9SMmYZwDBllNV7F60pSfbV88APvoR06/MctB/+vJLf5x
         8NdmsS1UZGo3JA79NbrJ9FMNz3LBkGeiuiYdblu/FbOurtp0EQs+Us4iWuGEl7RaIZ4I
         ERhg==
X-Forwarded-Encrypted: i=1; AJvYcCWOwGuzx1KPZsA0IPR1WwXZPET5EG9iz59tmvBMMK9WxU8TV/ik5m1e5ua7F6F40VXGaAEoBhAz2Wc5HuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCo9A+51NDoCQeIEcFTivKKY4Sg/enOzB6alXHhSpvvfyITapa
	FuGWZR2W70CqJyEPpZavinLlBG0fuKWh/5qS+AshiGIhs6gVZRYruT2l0rRqdO6jkEk8wL/rWK1
	97g==
X-Google-Smtp-Source: AGHT+IFU4BypwuzzTQOeGtuvKNhTd3bHMKO+gfxWQLVd3JADZrqnkPL2M0DVn+Td+hPRNqfQ4ImRbaLlQMY=
X-Received: from pjbsj5.prod.google.com ([2002:a17:90b:2d85:b0:2ef:7352:9e97])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf0f:b0:216:5af7:5a6a
 with SMTP id d9443c01a7336-21892a01ad5mr68834145ad.32.1734138471497; Fri, 13
 Dec 2024 17:07:51 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:17 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-17-seanjc@google.com>
Subject: [PATCH 16/20] KVM: selftests: Ensure guest writes min number of pages
 in dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure the vCPU fully completes at least one write in each dirty_log_test
iteration, as failure to dirty any pages complicates verification and
forces the test to be overly conservative about possible values.  E.g.
verification needs to allow the last dirty page from a previous iteration
to have *any* value, because the vCPU could get stuck for multiple
iterations, which is unlikely but can happen in heavily overloaded and/or
nested virtualization setups.

Somewhat arbitrarily set the minimum to 0x100/256; high enough to be
interesting, but not so high as to lead to pointlessly long runtimes.

Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 30 ++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 500257b712e3..8eb51597f762 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -37,6 +37,12 @@
 /* Interval for each host loop (ms) */
 #define TEST_HOST_LOOP_INTERVAL		10UL
 
+/*
+ * Ensure the vCPU is able to perform a reasonable number of writes in each
+ * iteration to provide a lower bound on coverage.
+ */
+#define TEST_MIN_WRITES_PER_ITERATION	0x100
+
 /* Dirty bitmaps are always little endian, so we need to swap on big endian */
 #if defined(__s390x__)
 # define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
@@ -72,6 +78,7 @@ static uint64_t host_page_size;
 static uint64_t guest_page_size;
 static uint64_t guest_num_pages;
 static uint64_t iteration;
+static uint64_t nr_writes;
 static bool vcpu_stop;
 
 /*
@@ -107,6 +114,7 @@ static void guest_code(void)
 	for (i = 0; i < guest_num_pages; i++) {
 		addr = guest_test_virt_mem + i * guest_page_size;
 		vcpu_arch_put_guest(*(uint64_t *)addr, READ_ONCE(iteration));
+		nr_writes++;
 	}
 #endif
 
@@ -118,6 +126,7 @@ static void guest_code(void)
 			addr = align_down(addr, host_page_size);
 
 			vcpu_arch_put_guest(*(uint64_t *)addr, READ_ONCE(iteration));
+			nr_writes++;
 		}
 
 		GUEST_SYNC(1);
@@ -665,6 +674,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	host_dirty_count = 0;
 	host_clear_count = 0;
 	WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
+	WRITE_ONCE(nr_writes, 0);
+	sync_global_to_guest(vm, nr_writes);
 
 	/*
 	 * Ensure the previous iteration didn't leave a dangling semaphore, i.e.
@@ -683,10 +694,22 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 		dirty_ring_prev_iteration_last_page = dirty_ring_last_page;
 
-		/* Give the vcpu thread some time to dirty some pages */
-		for (i = 0; i < p->interval; i++) {
+		/*
+		 * Let the vCPU run beyond the configured interval until it has
+		 * performed the minimum number of writes.  This verifies the
+		 * guest is making forward progress, e.g. isn't stuck because
+		 * of a KVM bug, and puts a firm floor on test coverage.
+		 */
+		for (i = 0; i < p->interval || nr_writes < TEST_MIN_WRITES_PER_ITERATION; i++) {
+			/*
+			 * Sleep in 1ms chunks to keep the interval math simple
+			 * and so that the test doesn't run too far beyond the
+			 * specified interval.
+			 */
 			usleep(1000);
 
+			sync_global_from_guest(vm, nr_writes);
+
 			/*
 			 * Reap dirty pages while the guest is running so that
 			 * dirty ring full events are resolved, i.e. so that a
@@ -760,6 +783,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			WRITE_ONCE(host_quit, true);
 		sync_global_to_guest(vm, iteration);
 
+		WRITE_ONCE(nr_writes, 0);
+		sync_global_to_guest(vm, nr_writes);
+
 		WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
 
 		sem_post(&sem_vcpu_cont);
-- 
2.47.1.613.gc27f4b7a9f-goog


