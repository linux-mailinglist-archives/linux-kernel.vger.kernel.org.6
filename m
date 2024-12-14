Return-Path: <linux-kernel+bounces-445797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A879F1BAD
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1B4162F02
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7359818AFC;
	Sat, 14 Dec 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8Igj+q/"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894215E90
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138448; cv=none; b=JKOdTT+/e4KcI4PyguQNtsQHtEcHgjuwlni4i+PIzyrpxfrSHHlc6nSg48Qx/M4CtitRppD2HOBrB2OIXt3kbT9WnqorRGgxSXB9v6ukOVv8jP+Ehx7eGotv/zNFVq3npfyIjJX74YWVLbVK5RCvmgz6WbY388v8iqsVG4RzIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138448; c=relaxed/simple;
	bh=cSnwUK/2rXGD+rrAuQ2cWaSYdAoHz1OuzoU7A8Ugyzw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MYbF5WxdXCKf4Af8dcd5Y3lzKxl4Jls++FvMpuTa9a3PNY+aRzKhxk70/ugV7K0hl5fp/lEWq426lgcQbyp6r9abQgQ7Wql7o5TtydHprfUdGTLXITFCwtKZy0y7IIGIBcr6x6sPKBsZquThwsAcso6u5JjlB0ZEolXPyunussI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8Igj+q/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee6b027a90so3120530a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138445; x=1734743245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FDkeem6MqewIEXRWoJcJJSDt8+RewhtQwmeUHyoVvwQ=;
        b=p8Igj+q/GB/05CyWdpM+D2gC13AKjgcSTCKkYZvIWWi0G1V97/D/g85yIgBFOAcpUU
         hxhHAoPvZRGA9JPz8QpFBerjqDtVzZyxYV4sgZaGKu+wZ2qHAQJXzRY/JX/LH8Su0+2+
         O9A49qfvmxZa0jK/KCh6GFSlVEUB51l0+ojpmJxzD2NPt61dptpZwff0wKpQS7FQS/L0
         hZgDuY6xJzJP4KgSwuIBeajitheja8I+uhZmzdmMq5B7Vr0GRi5a4MkPjHdw3iA4n1FR
         VE+XRxO0Z43SB0WepodwIrUu4oOFKhexTLAlN33ahyvdv1sM21CajGimX9DqHg7912Ov
         Xaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138445; x=1734743245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDkeem6MqewIEXRWoJcJJSDt8+RewhtQwmeUHyoVvwQ=;
        b=pDOBtoCvK6fKngwv444X5iy8z8aUmjsnT6UTgfg6qpKVNP0JzIYbG/72RCdI4JMcl7
         byiG+hKODX7xzLoO7TP6Xz/K+zQl2p54RSYzDSO54Zh0PHe8YZuw3QY3XMt/xHIpmVxU
         yizvOPzPAzG3CuwRP9y/gPatP8zmTl6okjyxzbk1mS+eScI5vCOlyPWRDLRIhk4Is4s7
         QMHLiUreHOikDPChtnMCNEShntpliA2RkX0K3XYqxEDXUicZ4qgemjNNFMq9yRTbsMpy
         kpYOqG4Clx20nxu7HwKVOp+R9ETBKjvwcRgZzCqMWXBk/UzUdgE4NbdeCE/5moLuap2t
         cuQw==
X-Forwarded-Encrypted: i=1; AJvYcCW7+vJneL0nZBklKITO67MKv2Wbac+uhHmj+54QLXjHs+jj88jNnpntV/N6Cl1jxi7jzHLS4WzbHDKro3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5l6lzGA8r2nOzIobD5qtLpRs2OZ+NiSk/922+WtKq3Tcn4Qt4
	i4iL0ZaleMnDboz8T12VtYzLUQk9BQ0ylzk5yr1FlKCF2GTNMI0BwHNEj4E3Ad1o9sy5LWLZfO6
	ajg==
X-Google-Smtp-Source: AGHT+IFK32cTaqoqTJNazGtX5TzExs7AH57kjcR5A7Qc6S14R9Qqh2LtvZ+1ec7OP+laMIvBdbl42YkuaIU=
X-Received: from pjf15.prod.google.com ([2002:a17:90b:3f0f:b0:2ea:aa56:49c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d450:b0:2ee:d024:e4fc
 with SMTP id 98e67ed59e1d1-2f2901b3661mr7398519a91.33.1734138445502; Fri, 13
 Dec 2024 17:07:25 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:02 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-2-seanjc@google.com>
Subject: [PATCH 01/20] KVM: selftests: Support multiple write retires in dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Maxim Levitsky <mlevitsk@redhat.com>

If dirty_log_test is run nested, it is possible for entries in the emulated
PML log to appear before the actual memory write is committed to the RAM,
due to the way KVM retries memory writes as a response to a MMU fault.

In addition to that in some very rare cases retry can happen more than
once, which will lead to the test failure because once the write is
finally committed it may have a very outdated iteration value.

Detect and avoid this case.

Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 52 +++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index aacf80f57439..cdae103314fc 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -152,6 +152,7 @@ static atomic_t vcpu_sync_stop_requested;
  * sem_vcpu_stop and before vcpu continues to run.
  */
 static bool dirty_ring_vcpu_ring_full;
+
 /*
  * This is only used for verifying the dirty pages.  Dirty ring has a very
  * tricky case when the ring just got full, kvm will do userspace exit due to
@@ -166,7 +167,51 @@ static bool dirty_ring_vcpu_ring_full;
  * dirty gfn we've collected, so that if a mismatch of data found later in the
  * verifying process, we let it pass.
  */
-static uint64_t dirty_ring_last_page;
+static uint64_t dirty_ring_last_page = -1ULL;
+
+/*
+ * In addition to the above, it is possible (especially if this
+ * test is run nested) for the above scenario to repeat multiple times:
+ *
+ * The following can happen:
+ *
+ * - L1 vCPU:        Memory write is logged to PML but not committed.
+ *
+ * - L1 test thread: Ignores the write because its last dirty ring entry
+ *                   Resets the dirty ring which:
+ *                     - Resets the A/D bits in EPT
+ *                     - Issues tlb flush (invept), which is intercepted by L0
+ *
+ * - L0: frees the whole nested ept mmu root as the response to invept,
+ *       and thus ensures that when memory write is retried, it will fault again
+ *
+ * - L1 vCPU:        Same memory write is logged to the PML but not committed again.
+ *
+ * - L1 test thread: Ignores the write because its last dirty ring entry (again)
+ *                   Resets the dirty ring which:
+ *                     - Resets the A/D bits in EPT (again)
+ *                     - Issues tlb flush (again) which is intercepted by L0
+ *
+ * ...
+ *
+ * N times
+ *
+ * - L1 vCPU:        Memory write is logged in the PML and then committed.
+ *                   Lots of other memory writes are logged and committed.
+ * ...
+ *
+ * - L1 test thread: Sees the memory write along with other memory writes
+ *                   in the dirty ring, and since the write is usually not
+ *                   the last entry in the dirty-ring and has a very outdated
+ *                   iteration, the test fails.
+ *
+ *
+ * Note that this is only possible when the write was the last log entry
+ * write during iteration N-1, thus remember last iteration last log entry
+ * and also don't fail when it is reported in the next iteration, together with
+ * an outdated iteration count.
+ */
+static uint64_t dirty_ring_prev_iteration_last_page;
 
 enum log_mode_t {
 	/* Only use KVM_GET_DIRTY_LOG for logging */
@@ -316,6 +361,8 @@ static uint32_t dirty_ring_collect_one(struct kvm_dirty_gfn *dirty_gfns,
 	struct kvm_dirty_gfn *cur;
 	uint32_t count = 0;
 
+	dirty_ring_prev_iteration_last_page = dirty_ring_last_page;
+
 	while (true) {
 		cur = &dirty_gfns[*fetch_index % test_dirty_ring_count];
 		if (!dirty_gfn_is_dirtied(cur))
@@ -613,7 +660,8 @@ static void vm_dirty_log_verify(enum vm_guest_mode mode, unsigned long *bmap)
 					 */
 					min_iter = iteration - 1;
 					continue;
-				} else if (page == dirty_ring_last_page) {
+				} else if (page == dirty_ring_last_page ||
+					   page == dirty_ring_prev_iteration_last_page) {
 					/*
 					 * Please refer to comments in
 					 * dirty_ring_last_page.
-- 
2.47.1.613.gc27f4b7a9f-goog


