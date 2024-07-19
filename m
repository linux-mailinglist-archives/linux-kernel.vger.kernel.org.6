Return-Path: <linux-kernel+bounces-257717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B15DE937E15
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3FCB219B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA85014A0A8;
	Fri, 19 Jul 2024 23:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKRfBVO9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71327149E0C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432638; cv=none; b=g4LWJvuKosX9RejXTomrdQmmxTZpi4pTwqTPDOhzNK9hhIH4NloJTZ7JwrJaAg2eNu5EoK/0/JNV15jFQbiwxfOGN9l8E+M9RCCRBV2ZLAAGuehYsS5LhibBKL/M/O07igLcuYTM/ksqkzHqSSSU26nWl2FamCnvg76zrZNPjHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432638; c=relaxed/simple;
	bh=L5K4LhEvErOvub+DyS3BuApRHh5XgLwLfLGmErCpdIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEl9KTdfstdDjoz0QSKHy0SpS5uNJglH7j5AgFgKCSncaRWIDt5Adg0EytwsldwLAXj6e8Udj7WUgUHX75SnzLCaXCvzIM0qB3yKt/mikDMWSRmeY4ANejmMH7i/wV9CTfPa2w1W7npnJkgp09DzAHDMS+uyTrtV0+sqhA1ouxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKRfBVO9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664b7a67ad4so63644857b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432636; x=1722037436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=szsmqea3Ly+/pHf0iLcDxQ8R3kri7Zn2BloJwbPXzbQ=;
        b=cKRfBVO9uW3KH4IWeqnJv1Q6J/rkUKH7lgTsQiOSqXHvbkCSXQGD4g0fwOwKT05jeU
         YBUO2xk1cEPW+ulo5QCgatStBgQkw5CqJUeoch4ZP0PWgohQ5VpFxpmvngbFOW6w8Aol
         O44pfnUI7xAu5LJ39PI3M1QdiKVA63wMUd2HvedKjR2evyQOKGA9ubfY2p+NSPnrpyvw
         v552avnLc7skp2ON9z/Qb0HWEw5XE+y/cK/FbMpWf5L2N7TPOP4xCfI0btsEuNu2MGZs
         bIMrXgOQ2tKd1hk2Aux213mMT7eI1Ce5K9vW19CarrzOrsR165jBBZnKT/tVMCfCyITT
         awPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432636; x=1722037436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szsmqea3Ly+/pHf0iLcDxQ8R3kri7Zn2BloJwbPXzbQ=;
        b=qyJqzhPBAtrMwkQfPUZTdtto/an79l17BWmcxoL7kXqVTyb2b6B1gF/arqL884NDen
         VOs3XPaAPOpnQr5NvW8EMAA/xwsI9Q3MdZ5nLVHxEFEsFxlA6HezsNH/AtrJN01jxTFR
         qJlPysCpmaj6xPBOIvs3FCbtC/588XePq25bQDTnMR7e5PINdDrvigRwXbqxAaF+B3tm
         hG8T8duNyrB5mhfUElD3q51QrIaIrbIAAlbVwnK4eed1d0DMD2ucKskzpi8yY+omknwb
         HpKuYPuzhWNH+af+K0/hpcD9E4MPZm+24493885rIqPJOgc9A7Zf+2+8keekva67Vt6v
         iNsA==
X-Forwarded-Encrypted: i=1; AJvYcCVZbpNQ3jl8milinm5mhc7JFZYOHMTfGCCnhbf7frChmHiEEy7QwSxsnXsxOgBfAoTLc2SFc04MUxOXM3fnZmD0MgeVYyrtlgcCl6za
X-Gm-Message-State: AOJu0Yy7vhtc0dXo/2q/y6kNQD3TyePYGwNRKs0lMDyk/JLDjTHG6wqx
	ris3kqSbTZLDxRU+reSU+6+KYno7HsYUhloob66ld22hGrfte0F2jomHKydeBuezWv603ZvB9UP
	Ztw==
X-Google-Smtp-Source: AGHT+IHyklNc/kciJMRQw56X5UOMRuQVOpb5WnfAPHuAp+SM9Knp643EKgohR9My7VTvqkjf450OIUMnKJ0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:804e:0:b0:e03:53a4:1a7 with SMTP id
 3f1490d57ef6-e087046cademr8377276.10.1721432636436; Fri, 19 Jul 2024 16:43:56
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:43:41 -0700
In-Reply-To: <20240719234346.3020464-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719234346.3020464-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719234346.3020464-5-seanjc@google.com>
Subject: [PATCH 4/8] KVM: selftests: Open code vcpu_run() equivalent in
 guest_printf test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

Open code a version of vcpu_run() in the guest_printf test in anticipation
of adding UCALL_ABORT handling to _vcpu_run().  The guest_printf test
intentionally generates asserts to verify the output, and thus needs to
bypass common assert handling.

Open code a helper in the guest_printf test, as it's not expected that any
other test would want to skip _only_ the UCALL_ABORT handling.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/guest_print_test.c  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_print_test.c b/tools/testing/selftests/kvm/guest_print_test.c
index 8092c2d0f5d6..bcf582852db9 100644
--- a/tools/testing/selftests/kvm/guest_print_test.c
+++ b/tools/testing/selftests/kvm/guest_print_test.c
@@ -107,6 +107,21 @@ static void ucall_abort(const char *assert_msg, const char *expected_assert_msg)
 		    expected_assert_msg, &assert_msg[offset]);
 }
 
+/*
+ * Open code vcpu_run(), sans the UCALL_ABORT handling, so that intentional
+ * guest asserts guest can be verified instead of being reported as failures.
+ */
+static void do_vcpu_run(struct kvm_vcpu *vcpu)
+{
+	int r;
+
+	do {
+		r = __vcpu_run(vcpu);
+	} while (r == -1 && errno == EINTR);
+
+	TEST_ASSERT(!r, KVM_IOCTL_ERROR(KVM_RUN, r));
+}
+
 static void run_test(struct kvm_vcpu *vcpu, const char *expected_printf,
 		     const char *expected_assert)
 {
@@ -114,7 +129,7 @@ static void run_test(struct kvm_vcpu *vcpu, const char *expected_printf,
 	struct ucall uc;
 
 	while (1) {
-		vcpu_run(vcpu);
+		do_vcpu_run(vcpu);
 
 		TEST_ASSERT(run->exit_reason == UCALL_EXIT_REASON,
 			    "Unexpected exit reason: %u (%s),",
@@ -159,7 +174,7 @@ static void test_limits(void)
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code_limits);
 	run = vcpu->run;
-	vcpu_run(vcpu);
+	do_vcpu_run(vcpu);
 
 	TEST_ASSERT(run->exit_reason == UCALL_EXIT_REASON,
 		    "Unexpected exit reason: %u (%s),",
-- 
2.45.2.1089.g2a221341d9-goog


