Return-Path: <linux-kernel+bounces-325609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C968975BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F1286A89
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF21BE853;
	Wed, 11 Sep 2024 20:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTBkhlFJ"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3556F1BE23F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087365; cv=none; b=aAxt8XbfHD8tnKFhI27qSPAZukUjbfdzO+d3HtkcUD7VuW0/sWi7FCsCG03+r7ikfeUppF5PeCzUkVzVqSIrIU/Uyq6QyLCEpOl1XnqOi+wPUyT+taE0TvG1iTv3lr/qpBp7jnGsXB/CNQXA7z+I/poQsvDGbO7pN3UM45pCohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087365; c=relaxed/simple;
	bh=RjIjbK/O7AOXgjJl4H0U8PhhFXmA3gdfj48wRxxggdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLMlAALbbiHqDZJApa1wN2G/15esHCHDiSGRr8bUAHfFCY3A2YCbf+lPzyCpv67y1PTKWucqBcuOa2I13AlAOVGYy1Zu3Mr1FGHNvWqXOLCpmXJ9nEZww/zLktNRhFXir9/Tw0uPKmxsE1/KNrGAbEMLoSuACj26zA6bLCh+NYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTBkhlFJ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2da511a99e1so343278a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087363; x=1726692163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bmoPUX+JXjpnDZGI5p6xMsNQ8aqKvxbSE8GAbeQD0ic=;
        b=iTBkhlFJ653J/8UGf2qMVfsdiF3zELdIPjzeJSKo++keIaFQcQpV/WWrMNwpCeKNaV
         0CbXJebXEcGM0HUVwkuwyF8A3dMwaW+nE5Ajb5/diKF19l80LBny9lSg3E095m/AnXow
         gaKdy74S0dtFkAo34nDxA2KYpZl2IK/03My4mOXiHm+u7s7/RbVLLAlq7D6bAsI2GKYb
         frZ5+CMtj7dEJz1MNq8rsDpEck1ELJpFlOvO8/H91t1bCHb9vYhwwwf7O9Lf0DFuU5C0
         ixyZonKiJNVpnoVrymsqqzeiW+PbMc5JocyPwTHsdT3xY+NXHmN2x7WuFDiynYfF+meM
         Drhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087363; x=1726692163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bmoPUX+JXjpnDZGI5p6xMsNQ8aqKvxbSE8GAbeQD0ic=;
        b=Jt9XdOh6ZuRwEAMEzkZ1nONEkfutOLWtuNG+Ii91UYJpD0BDKkUlUunHijzvXZRmhi
         ASIsmm2eqXT1ZAdvpLGeH9qX7jT4jE3LvlfGWDvNhFrCmrg9AYtAXfpUKVhbsiIT2a0H
         P9Eb3CWv/+276u56cbkRsaNPhpoE4ePgIj2iCfksL1TRCYV3zmdHvUJ5ip3Pe9XnFfgu
         cpQvGSgtFUhdcOiF6npNGxZwmp5t9TG3MlkpmyWXamXPlewCzVvkQUoTPvTcsoI9oiht
         eFmWiyEo/GfI1pS3viCyFHe1TZNR/jxYVfoYKKooeQAFIbekDmb749+kl+LfyTZOIFEg
         4KcA==
X-Forwarded-Encrypted: i=1; AJvYcCUNya2WPuGdLgY9Xwbg1QJ9LJZFP2+quHqeJLXHyyHUbXa0oYSL74pcTb/ZPNBH9Mwpqdx8ZfvbcVc1kn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJn1EEaO622WQ86AlhHozQO936Lvyf2z6/K73XYzdgaRoJ4ju
	FzWpSfOC2JWu5p4zD7SCkPxR1ZK3KoE2TDlJbgRs56QM1MwogdnSk1rTNzPe7ulx8ycKmYYSgrP
	cVA==
X-Google-Smtp-Source: AGHT+IFejIMeELuVO8txo5UGwYsGrFXhMhJbdLyClaj2asDasqbAOd2Ag+P6eX01VQr2edSnhAi2+MXrYfY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:710:b0:2d8:a9a0:3615 with SMTP id
 98e67ed59e1d1-2dba005b566mr856a91.8.1726087363354; Wed, 11 Sep 2024 13:42:43
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:56 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-12-seanjc@google.com>
Subject: [PATCH v2 11/13] KVM: selftests: Precisely limit the number of guest
 loops in mmu_stress_test
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

Run the exact number of guest loops required in mmu_stress_test instead
of looping indefinitely in anticipation of adding more stages that run
different code (e.g. reads instead of writes).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 80863e8290db..9573ed0e696d 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -19,12 +19,15 @@
 static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
 	uint64_t gpa;
+	int i;
 
-	for (;;) {
+	for (i = 0; i < 2; i++) {
 		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
 			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
-		GUEST_SYNC(0);
+		GUEST_SYNC(i);
 	}
+
+	GUEST_ASSERT(0);
 }
 
 struct vcpu_info {
@@ -51,10 +54,18 @@ static void rendezvous_with_boss(void)
 	}
 }
 
-static void run_vcpu(struct kvm_vcpu *vcpu)
+static void assert_sync_stage(struct kvm_vcpu *vcpu, int stage)
+{
+	struct ucall uc;
+
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], stage);
+}
+
+static void run_vcpu(struct kvm_vcpu *vcpu, int stage)
 {
 	vcpu_run(vcpu);
-	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_SYNC);
+	assert_sync_stage(vcpu, stage);
 }
 
 static void *vcpu_worker(void *data)
@@ -68,7 +79,8 @@ static void *vcpu_worker(void *data)
 
 	rendezvous_with_boss();
 
-	run_vcpu(vcpu);
+	/* Stage 0, write all of guest memory. */
+	run_vcpu(vcpu, 0);
 	rendezvous_with_boss();
 #ifdef __x86_64__
 	vcpu_sregs_get(vcpu, &sregs);
@@ -78,7 +90,8 @@ static void *vcpu_worker(void *data)
 #endif
 	rendezvous_with_boss();
 
-	run_vcpu(vcpu);
+	/* Stage 1, re-write all of guest memory. */
+	run_vcpu(vcpu, 1);
 	rendezvous_with_boss();
 
 	return NULL;
-- 
2.46.0.598.g6f2099f65c-goog


