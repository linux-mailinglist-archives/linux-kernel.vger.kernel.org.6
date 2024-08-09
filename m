Return-Path: <linux-kernel+bounces-281506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9094D795
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5311F24F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A3192B8A;
	Fri,  9 Aug 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJzVP8fp"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E88216F0FE
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232636; cv=none; b=Ao0H949oydYnaNiub3Zh1U+sqwwOo46+g5XZXUh+nKE/3X08UrRWmf0zUbRbp1+fqvSknMe8RdaFJyfqUWXMD7NOc5MU55Y+/s2L+uv9XqKNqVEili5n3WxSkOrZ0SNHps8+icUitWnTU5uRiz2Zwek5uQuzMNIiqhhhgAI0gCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232636; c=relaxed/simple;
	bh=JMLriyucuH1C15GtvvibdoIfA8+6so79QMDBwKK8/UQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HFPNlBpSGeHyBOpxwYG53wYlNrBmfnxpwfBd+mmkyi0BQa2I72oUzUtD/+oDQWcsKG/8/a4VYr4+Wl23R/MMfvdkymBqS7LTWAaeOC4gG0/MZ0IZ3hQiYtM9H09wu2JJ2oo0yDq0uy5f+cGfyxI32fqgkXLR10k3gdhxUUUga7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJzVP8fp; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cd2c7904dcso3031347a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232634; x=1723837434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=KtOd9aj4hqeGD1AC+o3mLs+Sgxz7FerwNOXhm7lsLkU=;
        b=yJzVP8fpammFpUwlRKxnR30bVqCTcPr6UQpxuw18PmiM5fSSjMw+yv4gKxL4pi3sqF
         zhHLJAzpPap6QdBRQO6yPeYO+2Sdloc0CW5kdXRlnbNToXyyQgxA2yHm9Tv9beKhM3fA
         njYEpKrjTfqEZUZ2Cbu2moRRTsH1NRhAsExnPh27+dmmEEoUYkhcD6gr/fuVSkaoroAP
         aejQhHfhgbOH+AcKZNqGr4lHfca35Vk0WCVTq/mVCtgEX1NOplJGnEoJJ0jTwC9pgu4O
         +1i5/m0EGXGqbldIFrQgbVih2h0K3ZEWMEt7SZoQKVxn2QpgeiZDZAT2Hff9oVJ/eUXh
         UsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232634; x=1723837434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtOd9aj4hqeGD1AC+o3mLs+Sgxz7FerwNOXhm7lsLkU=;
        b=ZGt6tHe/NjZHm1RdH+P9XQELSPf2YkzIjt8RI1x0KJNd4+tX+oB78cjo0dbxDvqQ+D
         tWQcB6IJKoXn0GLR1m5U84s59+rbBvLrhiyodwz20uDWCBOM9UInr/54Cp/q4J2Hyk1p
         jPbx94Xb0W+E5BXp3fqa4NthPaVIdRdwURK9BX3HJctTTuMkGDypHpMEfF0TNqzNg1lW
         SMJkb5/wYE7q+c8zhtVK8nVBIjEPKUVyk5cM2k97oNNGdj41N5rhS0ibfBajbHq+PU62
         YoviHlxzvLMNNpGAg4cNHE2sJHeJ8xQEAJh0BNDGllHPDnYIBeKPAESwBs4jJvyLaD11
         EzBw==
X-Forwarded-Encrypted: i=1; AJvYcCUuUTbDXUFFOoE7SmGIBEk7GfPJkwsw3yToDL2Dg7TVnYBKb7QuCGqiN6EIsj2tZqD+zB3HZ2nZOcH7SalkuHZ2h4seRF8kqktSc1Yl
X-Gm-Message-State: AOJu0YwTWlmBNRwL1BJrhNtRBfj7knmXUat3d48I4bagFBC1Yctz6oG/
	Vj1Rh5FbVgVqryVM1eykkxssnGhXETY3X0F9+4RZkDulIZqFjD/MdsHLFlOthg6MsAPTnyfS1mR
	YTw==
X-Google-Smtp-Source: AGHT+IGvAmg8+tqrGrCIZoGsSdnG8ZSFhwx3qgY9wt9WSt5Z7jq3JEgK8XnEDH316ti3bUud1crZuHLg05M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:a88:b0:2c3:1985:e9c3 with SMTP id
 98e67ed59e1d1-2d1e80b80femr12946a91.3.1723232634383; Fri, 09 Aug 2024
 12:43:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:20 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-9-seanjc@google.com>
Subject: [PATCH 08/22] KVM: selftests: Add a read-only mprotect() phase to mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
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
2.46.0.76.ge559c4bf1a-goog


