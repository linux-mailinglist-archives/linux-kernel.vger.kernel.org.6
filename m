Return-Path: <linux-kernel+bounces-257728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A162937E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB231C20FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F814A4C6;
	Fri, 19 Jul 2024 23:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flYsAvdj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135814A084
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433081; cv=none; b=iBBlzykcPm7ce93YL+ebpFtx4tRjxoaPEzscpCeMDTcgKUvqOMqnnD+s5K9wn6euFPp/JRZMcAxudPe3P7oOiF+9Jq5o4WxyNaT97rVXyVD2hd3U2PlVV3CaqByeDmUOcIC43AlZee4YJ5zuAYMpReswIwoCrN25hG9w8gfdKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433081; c=relaxed/simple;
	bh=L5K4LhEvErOvub+DyS3BuApRHh5XgLwLfLGmErCpdIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N6PxxdO87liCMYbD4WbrOCaLjUj9p7KNqA40vmbnSEHZIjiP2Ok71eiSFAMEV1xhylnGn8pqRvy48o/EPCbriMLivgWjP6Ebplgl3FxasQV+gDR7xZlLOxy01TdIon1+7XgzI7pBGxYClQhE7N3xDJUF9ZaVuE/5hhAHGdq7GXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flYsAvdj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05f9611400so5495541276.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721433077; x=1722037877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=szsmqea3Ly+/pHf0iLcDxQ8R3kri7Zn2BloJwbPXzbQ=;
        b=flYsAvdjZTwuhmxBu59ntx1ZwFjQitc6jnnLtYYl+YyKVEqYqB7IX1H7eqjJ5SgaGS
         fJ38h7aamBCwQEOys03wXDBoIdmsJwVuxi/u1MSo9CgNxsxkmwxrNENtVLJHQx04GbiJ
         uvG0DgV7LByW+/KRKru68mSKbDjFqbrkJMzeaNJVTJ4IruAh7UF4t7AVy3doqVsDA3WI
         QxXGKXW0tMQiYdMzqHh0Q0vJVtomrfktf7eIUwYbp5VogoZKQ+kirvWg+vRqmcyOde/p
         2cQxvVrelQce2ivSrSmId0v+TReJng20MFK6M7JYaNtBOnCgFnZg4sqMcqAhzQcsAwL4
         nEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721433077; x=1722037877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=szsmqea3Ly+/pHf0iLcDxQ8R3kri7Zn2BloJwbPXzbQ=;
        b=Eb3wfxpqdO+E2sEKBxLZaJWBWn0qBhJsPSf3X3Yeq/iT2WaGO4cxG+NZN3TM/IkVCH
         3hUhzempjGsG5Ei95RVH2F6EMsa062i2+pWlRU9Ut93z5MmPn+ou/E2UEf2KeuktyRYB
         eDWYBTCdsoS5OSLF6Z+THaO13oN4jpqP0W1K6eOUtOwnSuman3S1pe54ipZLHLP0+tCO
         /MhUauoFtUr3umktXRH0j+yqnZi1PARwc/jDwt/NBl4qE7n4AXlz9n30g5XKl/dSHmBq
         EQ3gutBON2M8twQ3z+l9ancaM1ePIxh6FJ6H856YlY0Cdu9cU3cICQn3yT6C8uktt/U0
         8Nmw==
X-Forwarded-Encrypted: i=1; AJvYcCXfeCRe0PQLPqZx0W3/vCd604BsbcyuGAEO50vTJteL/cElHEqBI0DNAaUMvN0tnwj+cTAx7oz9pndpy51Mjq7ziwjG4Bg4VSoveTa2
X-Gm-Message-State: AOJu0Yxu1PC1L6FcyGAvcg0rKHPCKtKKJsxz/atXz5rJlVl654bW/DEB
	oz9lPNipEzrjxjjgAqBMoqlLj1vzbZordQwV83G+PyIdgCPRVEHH31QjxzMcNt3cZUxtPvhV/G2
	pbQ==
X-Google-Smtp-Source: AGHT+IG+Kf34xxLKIMRA93LE8zHki7PaXFwYp13mgJqswzo6PchKoevDMqejbvrPRDDVtschS9qg6QN+O5I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1509:b0:e03:5a51:382f with SMTP id
 3f1490d57ef6-e087042262bmr9466276.8.1721433077656; Fri, 19 Jul 2024 16:51:17
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:51:01 -0700
In-Reply-To: <20240719235107.3023592-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240719235107.3023592-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719235107.3023592-5-seanjc@google.com>
Subject: [PATCH v2 04/10] KVM: selftests: Open code vcpu_run() equivalent in
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


