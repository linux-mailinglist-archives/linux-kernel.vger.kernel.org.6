Return-Path: <linux-kernel+bounces-281505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1D94D793
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5EEF1F22891
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F816F0DC;
	Fri,  9 Aug 2024 19:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3G3qEOen"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F38416DED3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232634; cv=none; b=thhR/1SZf5BRKTv6YZYbWjvYRkazY7DJqRi1+24m8n24g5qeCfSWqvk4NDaKefbEEKluusbs5h5+AwW47RPrBrQpMvR9q0IQEKF0M1U/JUnGVEn4xPv5xtudV1A2cHiqH30pnyDBTdMF+MCJRbeFxNyo73idEhy3n4HV2EPc7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232634; c=relaxed/simple;
	bh=oqLsHduvmYrRBvhT430Njd0wP4bVpgHOh7c0T70VHPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kHOlmGERieW0UnYTwDO6IGChEbJY1a1TgYKPEDjc9aGGkQNbbKCNFtD7CvUJ/xQ225hCnRrXCIfqpt31xKJ4F0Lgsy3Gl1qAmVxvtsOrZDJn0ZQGGHeSTGMcI5H0ioP+ODyKKJfmeTuOiaxQQqLW6s8PM63R1MDMJKXySHgvqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3G3qEOen; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc5651e888so22885125ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232632; x=1723837432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvey1ZPxH+FTyjcmf9WeApEHMp7j68Ugrd4yPwlOS4s=;
        b=3G3qEOen1ah2pii+2eNgPqGvrKcUEnJVE0wQ8m3axxVsmLNGatC5zxOV4DBk5fmf7z
         POhd0EXVYHSm7I+1KvHCGagkHkJVBRHvv8e6bWDdfGbeJEq3KnYmLbLyZLJhPwkmG73P
         fILFf06DLCT0ZpGVfv7bRjclIpMwhKGFx5hE5jRx6PSBkA5mccvyVz7FjV85qNrbVO35
         woRAHl/MFwTCmjDlMDRB0r/sXUMYoVrR0ie6/CQzZjJt8lj/TA81RFsB+8LSDNd2Sfdu
         +hGF4odoebHk8n6hCDpJB+zZQOUZuZbiw2iQAAi3PChVP/mTmy6gGmDTY/PHiXZKkCnd
         rJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232632; x=1723837432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cvey1ZPxH+FTyjcmf9WeApEHMp7j68Ugrd4yPwlOS4s=;
        b=OlIt0ew6vaiZcIrQTUZXewCAtvGWNNOL0AIRx9tKInLIEL6bDXJ3RV4iuCc275JKcW
         IjQOCr4EZdOpDVvOfibDu8iX2aBGhnGKvXsrzB1VQwsDOtyMzkAidGbZcObyiRV0Z98c
         R7ntbLogOgYpXdklDFGkQF+EoIwIr22xwScACThNbaSewi9NrpaVm4z4HFHt5NbYYgqW
         gByGLF8I+KK1SRR8tJR6DHBxU+zFJ0EGJUGoXVYzzIgmFC+Zxk5FBJ0CpAJ5zEIorUFV
         NeBqkuEQO1Nuq8lZB2MxbDZ7M2miJi3pyT3MfnubMQ3MdIX/+GzuJrvM7c5IKkkzIBmw
         Zpog==
X-Forwarded-Encrypted: i=1; AJvYcCXKgd5msnP+2cd7TbCpWo1GINDxi5EWdLQjx+x66eiWcjmgcwYNoJ28FcZp93hTls2smvaXB6wXNNdBELM6gy0TB7+odfMZnWenb6rF
X-Gm-Message-State: AOJu0Yzuv/b+i47ns59cE2UZrIBdnkNH9QCuL8ENIWEKgXqzGB0WXFmv
	2OUDLjAREbYgLdBF9gdil4vXRVvzUzddl2qnRimDFTiGvUyAkMG6q3CwjYia0J/L+FjIEQZXowO
	cFg==
X-Google-Smtp-Source: AGHT+IH+toPWCiPDFAxpzyjZiz0XzGzpUA6+VQs+q838rMwjQmsoPXGyEJ4VZpEN+6XxrI30IFrHifQqDGo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2352:b0:1f7:3bb3:abe2 with SMTP id
 d9443c01a7336-200ae5eee52mr1182405ad.12.1723232632391; Fri, 09 Aug 2024
 12:43:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:19 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-8-seanjc@google.com>
Subject: [PATCH 07/22] KVM: selftests: Precisely limit the number of guest
 loops in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
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
2.46.0.76.ge559c4bf1a-goog


