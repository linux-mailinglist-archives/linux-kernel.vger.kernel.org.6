Return-Path: <linux-kernel+bounces-424090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F49DB084
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C40B215B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15DC14AD0E;
	Thu, 28 Nov 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUsvA2Vk"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2137146D45
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755372; cv=none; b=RebfcBtIo15+EN935f+kkrhEKC82Clb+Foih7iLwK6PzVzXybO+MjBEZae80FZC5QTFSFBqi9JMlmsImUhq8DdkMM8PdGQJEjoJTiI39kBU+z7zGxa7EWLv032vO4PsuOI0N4BZL7gEVnKhbKEKRXWwvr2vNWobcGKtBsOy1lfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755372; c=relaxed/simple;
	bh=tB5Y/jG/Ubvw+ASTUSDw04Dbo+k1MHeniGJPuaDceRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fArB75nQMspSYXaveran/SGHxSLPd95yz6OOOTOl/CEXwWi62FXWnfrECt45Y+T3bXE67Vm8up1rShSyazisAD98peZXZl+iwDTuVNVl2aKfH45sQuCz2wyU5RzLAHfuasJ9DNf1SXAEwyHSrquBkiTQnxUlsSpgBaZCbewAZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUsvA2Vk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7eb0a32fc5aso218415a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755369; x=1733360169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/mFf9b1jkbcIPk1lRuUSamWoSedpUsq+XjDpJ8wT6fg=;
        b=WUsvA2VkOWzarWa1H4q0hM8ySVaeVtl1jM6+g1bQ8AuAedscLnGG/IpkCtuOHgNHsH
         4wXDgybyuc+oLhhRLR9UmlKJIS+BZIUdRBFTOt2aUPQJT1Jn2xUXTGJEIgOHN8A2A90x
         qu6drytqITMSOKrJ4K5d1wxZcycSlTH+SE8ozLPAKG0h6zPm1l0SD8zD9z3ylrl/Jz8F
         gOSgjbkI1nidHXLpDKRP9YMxTurl0nqdOMrBknKIz7SVQhWh2lJv270hMzVVfmvcP5Hd
         0ZJW4mfttQhlAfk5G+3FP8xOPBxN7bkg5YI4fXXL8ADVJWWvK5rdblEKu0C0mD4CiaMV
         udyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755369; x=1733360169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mFf9b1jkbcIPk1lRuUSamWoSedpUsq+XjDpJ8wT6fg=;
        b=RLmh17kkpWTe7Ni0T6D6l9zKWLrvGho4sbanCQG7Qxn8ghTYgOxSVlWWRPnit1bPT1
         1BKYRreViiVmQBUIH4naWWGtLBKpNS+jnOO4YjMrjOSZScX72diB5YVRFbQc1tJIPpqB
         cgPQ5rKa9uEDC0QBtfEKuX0wepN+SqV7dc8AqxX2ZU1gvCyFq1S/BTSVl65KsBt/HoIJ
         8F7W13twVycvdyy4niOeTrTmLckDojkVHjr/TA1s39RVHltzvCjONZKMDjx/osr8w23B
         K4ZWDF6BVTl3WlchdCrSgdwSHTY6DlOU70rY+zcLrT6vXKVpWiYzeESPgHhqPIiW1Nmc
         uNBA==
X-Forwarded-Encrypted: i=1; AJvYcCWHE5O73tMRBiYpnRXrMJFVNUThSmvW3kY1TN+Re3FWzk6J7IdfRPySqPdkV45BppoXHoaTsOFX0GxbQWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEKeAbh4hgtUgeInTPCgcDbwhiZ9o9PvNshSlt0/86rCNTKOVc
	HdxSaGhLrDig0/Q/e7c+XGkK2Vb3wo/ixKgvW2oNvzJhuhqek29bCLbYer7L3SMvhC/KwVny9Aq
	IOw==
X-Google-Smtp-Source: AGHT+IH5HVAxwH71e8ybYbHuEKxtEP3yXlkNICJu49WhynVenqzqkDMIejgXVsQlKc9eCbp1lS1lKkfrLgg=
X-Received: from pjbsc10.prod.google.com ([2002:a17:90b:510a:b0:2ea:d2de:f7ca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a28:b0:1db:eecb:f7a1
 with SMTP id adf61e73a8af0-1e0e0b4f376mr8089233637.17.1732755368992; Wed, 27
 Nov 2024 16:56:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:42 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-12-seanjc@google.com>
Subject: [PATCH v4 11/16] KVM: selftests: Precisely limit the number of guest
 loops in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Jones <ajones@ventanamicro.com>, James Houghton <jthoughton@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Run the exact number of guest loops required in mmu_stress_test instead
of looping indefinitely in anticipation of adding more stages that run
different code (e.g. reads instead of writes).

Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 25 ++++++++++++++-----
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 656a837c7f49..c6bf18cb7c89 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -20,12 +20,15 @@
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
@@ -52,10 +55,18 @@ static void rendezvous_with_boss(void)
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
@@ -69,7 +80,8 @@ static void *vcpu_worker(void *data)
 
 	rendezvous_with_boss();
 
-	run_vcpu(vcpu);
+	/* Stage 0, write all of guest memory. */
+	run_vcpu(vcpu, 0);
 	rendezvous_with_boss();
 #ifdef __x86_64__
 	vcpu_sregs_get(vcpu, &sregs);
@@ -79,7 +91,8 @@ static void *vcpu_worker(void *data)
 #endif
 	rendezvous_with_boss();
 
-	run_vcpu(vcpu);
+	/* Stage 1, re-write all of guest memory. */
+	run_vcpu(vcpu, 1);
 	rendezvous_with_boss();
 
 	return NULL;
-- 
2.47.0.338.g60cca15819-goog


