Return-Path: <linux-kernel+bounces-445807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 376E69F1BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD55188E48F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E1419258E;
	Sat, 14 Dec 2024 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8LbnI+x"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EB41917EB
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734138465; cv=none; b=seGN+nuQIKDbA8MPUJltErc45+Oc9XcjeuQusHf+u49HtJNKwfCkH6tYtp4ytLeJ+0J9gLp3QKlKSTc7UZd5G7VO3PVHAlud4bO4HTbr6zjoOXsgC7h8Zuno738IuX8KRDGcrOOtKYsRskPBAw4rgY5tV6/CbHYupRlsDpDipTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734138465; c=relaxed/simple;
	bh=3sfvgMqPiGr/4hRycKbPGFa+ObbRBz+P/dL5LYIATKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T6tYKhuEHILpTl3wmifu4i3JBKuZXfAgw25svrlwMMSEE+FTqpv3D1uslK1BpQseFcVxV+yaRwlkVhkDRUiaJsLtlXONZ/9wJHXG4V1rdJr0CcmgQiplTrwihcDLTCeLpQGyQGy5gG+8oUb7cESikRD7yj5a2/OxpG2YkjsrHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A8LbnI+x; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9e38b0cfso2054829a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 17:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734138463; x=1734743263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YB7ROV39Pzlxg3CsT+e1YkqRcv/fedX8ByOvnUPuqfA=;
        b=A8LbnI+xIsAvTqlyukc1yVRx4tejiaNyu/a4+/94cvGB9W252yqIkxT4rJCe1xG4ki
         z+1acdIjdnwxDjV5jkpD5HhB956dW/9rRqxrcDTrkUaE163xdvOEdIrrxg14GbkFBWT9
         t2LYCyjCv3+cHyF3jbX5CDuYlBE1ZSwQe/ZdWhKhir5996+dNUbYLrW0DGJQb5mGui7J
         wGYFx5kYaNg/pdwyc+Bkfb/I3+00CLreDSD9dM5Kl4kGk19rXac6pBhxNPvCRHX4q69b
         HpPOTXYka95xQo8Wi9H+u4/mbJlnF6Sdej2UdIlrgkSuAURri4O1Is9f5Z8tS2GSwyjw
         EyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734138463; x=1734743263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YB7ROV39Pzlxg3CsT+e1YkqRcv/fedX8ByOvnUPuqfA=;
        b=VdBcQMgLhR6leDp2ilds4P6hu6oa5HfOjPel0fo8qQicBEG+t2BQJkMXXOphRnHRJe
         2iWDl2oIvAm66Y9G1mMBM/ait+2MAucWPjop89Q2tH0owApCxOQxmx8RNfdAoh4l+twN
         XfVaEI2sMU2TTamJJItZD+KaIW8QywOQZQm0zta1wPRG71sqjN4Ssae3jmwmHSCzMwle
         UGcVjyo0DpJ9DXf2Rl009rKJAPCbBvlzT8L4UZzZYKueHbW7jzlgs0GVUrWd2zdV3rGg
         cOukGrrnf0ObbkWRa1UvmtLa42GgVbjUfyYam1+MjAGhzZtYlvXtokT4pt52xBpREjP3
         27IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWT6Q9KTXxe4U3sO94qO0ecDJxxsodwawgR+kFQDt5hFxUOP9gjbgQVZqsc0mvAqdGEcVFbGlWMOC/ky6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0gRxlcFIMAqgVBQsEqwfWae/saZkMcDZ/wLuDNjgNWGQZT0WD
	bOF5oPzol1dRplwZCCsvNQ22Xnahju44mq8uIVU8kBsTFSThqKkyJ0wO+JgN/zLpnBB7+ThBPy9
	6kw==
X-Google-Smtp-Source: AGHT+IGLm+tWav0mdJroXvXIQGQc9a1oseLEfkqvEWloBr+EUUQt8A3f4c9LKw5WCptpE+rDX+y7oQPeGEI=
X-Received: from pjuj8.prod.google.com ([2002:a17:90a:d008:b0:2e0:aba3:662a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c8a:b0:2ee:8008:b583
 with SMTP id 98e67ed59e1d1-2f28fb7216emr7811449a91.16.1734138463343; Fri, 13
 Dec 2024 17:07:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 13 Dec 2024 17:07:12 -0800
In-Reply-To: <20241214010721.2356923-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241214010721.2356923-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241214010721.2356923-12-seanjc@google.com>
Subject: [PATCH 11/20] KVM: selftests: Post to sem_vcpu_stop if and only if
 vcpu_stop is true
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Xu <peterx@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

When running dirty_log_test using the dirty ring, post to sem_vcpu_stop
only when the main thread has explicitly requested that the vCPU stop.
Synchronizing the vCPU and main thread whenever the dirty ring happens to
be full is unnecessary, as KVM's ABI is to actively prevent the vCPU from
running until the ring is no longer full.  I.e. attempting to run the vCPU
will simply result in KVM_EXIT_DIRTY_RING_FULL without ever entering the
guest.  And if KVM doesn't exit, e.g. let's the vCPU dirty more pages,
then that's a KVM bug worth finding.

Posting to sem_vcpu_stop on ring full also makes it difficult to get the
test logic right, e.g. it's easy to let the vCPU keep running when it
shouldn't, as a ring full can essentially happen at any given time.

Opportunistically rework the handling of dirty_ring_vcpu_ring_full to
leave it set for the remainder of the iteration in order to simplify the
surrounding logic.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 40c8f5551c8e..8544e8425f9c 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -379,12 +379,8 @@ static void dirty_ring_after_vcpu_run(struct kvm_vcpu *vcpu)
 	if (get_ucall(vcpu, NULL) == UCALL_SYNC) {
 		vcpu_handle_sync_stop();
 	} else if (run->exit_reason == KVM_EXIT_DIRTY_RING_FULL) {
-		/* Update the flag first before pause */
 		WRITE_ONCE(dirty_ring_vcpu_ring_full, true);
-		sem_post(&sem_vcpu_stop);
-		pr_info("Dirty ring full, waiting for it to be collected\n");
-		sem_wait(&sem_vcpu_cont);
-		WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
+		vcpu_handle_sync_stop();
 	} else {
 		TEST_ASSERT(false, "Invalid guest sync status: "
 			    "exit_reason=%s",
@@ -743,7 +739,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
 
 	while (iteration < p->iterations) {
-		bool saw_dirty_ring_full = false;
 		unsigned long i;
 
 		dirty_ring_prev_iteration_last_page = dirty_ring_last_page;
@@ -775,19 +770,12 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			 * the ring on every pass would make it unlikely the
 			 * vCPU would ever fill the fing).
 			 */
-			if (READ_ONCE(dirty_ring_vcpu_ring_full))
-				saw_dirty_ring_full = true;
-			if (i && !saw_dirty_ring_full)
+			if (i && !READ_ONCE(dirty_ring_vcpu_ring_full))
 				continue;
 
 			log_mode_collect_dirty_pages(vcpu, TEST_MEM_SLOT_INDEX,
 						     bmap, host_num_pages,
 						     &ring_buf_idx);
-
-			if (READ_ONCE(dirty_ring_vcpu_ring_full)) {
-				pr_info("Dirty ring emptied, restarting vCPU\n");
-				sem_post(&sem_vcpu_cont);
-			}
 		}
 
 		/*
@@ -829,6 +817,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			WRITE_ONCE(host_quit, true);
 		sync_global_to_guest(vm, iteration);
 
+		WRITE_ONCE(dirty_ring_vcpu_ring_full, false);
+
 		sem_post(&sem_vcpu_cont);
 	}
 
-- 
2.47.1.613.gc27f4b7a9f-goog


