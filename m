Return-Path: <linux-kernel+bounces-445805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E589F1BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D27E188E661
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E9818FC8F;
	Sat, 14 Dec 2024 01:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kj/Z0Pmz"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905D1891AB
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138461; cv=none; b=Tz37GPfWK0JpHP8BG1Ime556i59QI2M6zDAUUh2X/J/YPrrRJaz+SDY5EWlhELb7xsQqiuY963K6c4A0yh5C/AwAt1hwD2n4gcwQS9q+/1qtc+m/jxIY1LjZ4CGmIEzF+BjJ9w4OklmVY2ce+XVVcwbNiU7VVbCNH9sYtgNXthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138461; c=relaxed/simple;
	bh=OgTTk595VIyjaFheqBqRfYqIoPT5CZ9K1t127fuPGa4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b4DY+rqsYLff6S56QIzFbs3QhXVd/MgFoX9v8zjrQ5B+vcuUPIeyBd3e1UXdehvj6T77GDfFhA/awQJNa7mY+I5DKa8mjVCLcEM1QI576oXA1wFalSOzK4DnEtb6YoYGdmggBtZcddiTA+srZYU815rLFxaJ3TcGzJJhzbIDgsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kj/Z0Pmz; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-8019f05c61aso1565204a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138460; x=1734743260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FAzPo3qg+GcWGQlv0+FYKxHsP1523EqIgag6kKt+kTY=;
        b=Kj/Z0PmzldV5EsrSdmlgEl3jWCkgez3RBbLXjpSLtjzXHU11QUAQbPcFW+o4RA4JGu
         BopPNu7GSdoSCPgJkOVL3WkKZLUWrjo5WH9P2Dnh6vtWmW7ZhYonpCMUcMEkwEBi8rEa
         4Plr2MVpg9q3hWEhCbw7PZQZkc0q2vX21/omy+f7sO3KFbd3PZ04jpnpHKVJm9Hevymu
         QsgY7bRrb8nCrv/Q6xBc1+w0+2VkzHzZsDRzXh4CUUSzkDQu+hN8aBgMFbjRTIZcXSJG
         r0srUFcYfQQcYsifZz0RWCytyMW19mF8QTsiF3EG45Craq3yCQ2hh9WBI7rWMzwItHlD
         2Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138460; x=1734743260;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAzPo3qg+GcWGQlv0+FYKxHsP1523EqIgag6kKt+kTY=;
        b=pP15ELEZGl1gmJzwo63IOx7/JOFOKZem12OvMkAvbNFbGTnY+LW/cO2vmXoXeGroHx
         2UalGZNEzML+FpvoTJRmcn7hiUd0TOkpBkcLdLHXb1rQ9kuZfaFKfF7QwvQn6xarweD6
         9egWZegNS1Yb9yuPTHupDACjmnN+3XB/nlbNOxG6THjr4qggxAexSJ2SzKGdzrp6N2kN
         xwtkqhsECAYVWuGbeLmy8vjrPPMBuDB5KstBN0nmyKBkKqX1Jw4sjzJjsUjxkf9HMfdl
         ogJHqJ/G3nGfhFhg1pjYpk9183Le2xqTes/PPr06Z3R4PijLUmPVpivcfFwR9LiZ4R8B
         67mA==
X-Forwarded-Encrypted: i=1; AJvYcCWTDFqFxBKg1c+pvVgU9PGcpmqswOqf+1aKC0oWZmCB6eXee5t7LLgImEbJ5g2xA2rtF6PJI2KOI2B4pjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmJenzjKSNyom3D2nXu1JWJxkLp+GtcFEbh9xO6zjd3X4aWCM
	39VODKXXpE8DKpfOJI15KxeFv409uY9uL4MPati0jY13pF0xm9iYHUhPkFeoNJusxKSIRd54AUs
	zgw==
X-Google-Smtp-Source: AGHT+IEx6xV8z10SAfTW31+ni8NBIZeIzTyZ6UR4kfmgK36HNJYqi0QxFoc4iypAwYbfX3m4FftoXPhh3r8=
X-Received: from pjbqo12.prod.google.com ([2002:a17:90b:3dcc:b0:2ee:4b69:50e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef49:b0:20c:9821:69af
 with SMTP id d9443c01a7336-21892a40599mr66605485ad.45.1734138459850; Fri, 13
 Dec 2024 17:07:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:10 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-10-seanjc@google.com>
Subject: [PATCH 09/20] KVM: selftests: Honor "stop" request in dirty ring test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Now that the vCPU doesn't dirty every page on the first iteration for
architectures that support the dirty ring, honor vcpu_stop in the dirty
ring's vCPU worker, i.e. stop when the main thread says "stop".  This will
allow plumbing vcpu_stop into the guest so that the vCPU doesn't need to
periodically exit to userspace just to see if it should stop.

Add a comment explaining that marking all pages as dirty is problematic
for the dirty ring, as it results in the guest getting stuck on "ring
full".  This could be addressed by adding a GUEST_SYNC() in that initial
loop, but it's not clear how that would interact with s390's behavior.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 55a385499434..8d31e275a23d 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -387,8 +387,7 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu)
 
 	/* A ucall-sync or ring-full event is allowed */
 	if (get_ucall(vcpu, NULL) == UCALL_SYNC) {
-		/* We should allow this to continue */
-		;
+		vcpu_handle_sync_stop();
 	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL) {
 		/* Update the flag first before pause */
 		WRITE_ONCE(dirty_ring_vcpu_ring_full, true);
@@ -697,6 +696,15 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 #ifdef __s390x__
 	/* Align to 1M (segment size) */
 	guest_test_phys_mem = align_down(guest_test_phys_mem, 1 << 20);
+
+	/*
+	 * The workaround in guest_code() to write all pages prior to the first
+	 * iteration isn't compatible with the dirty ring, as the dirty ring
+	 * support relies on the vCPU to actually stop when vcpu_stop is set so
+	 * that the vCPU doesn't hang waiting for the dirty ring to be emptied.
+	 */
+	TEST_ASSERT(host_log_mode != LOG_MODE_DIRTY_RING,
+		    "Test needs to be updated to support s390 dirty ring");
 #endif
 
 	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
-- 
2.47.1.613.gc27f4b7a9f-goog


