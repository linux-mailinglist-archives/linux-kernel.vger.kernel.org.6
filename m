Return-Path: <linux-kernel+bounces-529596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747E4A42869
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A1251893DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00F6264A68;
	Mon, 24 Feb 2025 16:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MMbXH3+4"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30142641D0
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416090; cv=none; b=phhYqCLinju0MbqHrNPWHoOsSEsC6L80WdrQ2BvPO7FWcc4ugA/BC920HtrtZm2+oSCPJvyQcq/HYGMgfTr2lbOVFcwMkggGL79/YeUroSXWpETYVD47gCheksgQfub6hrFeKYXXvtXpY5X9dVctaMZnBKLc4uU0e6RJpaVL8II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416090; c=relaxed/simple;
	bh=k08kYOr5amr0PMaAsg/vb1TyI0SEHxFgH5fDVqymMUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XPponZkoaX9+h8HfISd3uC9isYe2FNnq2so8DGwanAbwKGoeLTM77N4g/rpzMvfuApx7DhEWnYx6lI8zu5yMehpjRBSl3wpsXtxuZcF4SMc8ZwUU9X5FDegBd2q20JbGfB2CSV8jvdXrxsrAcFZWxhLBUn7MSuQ7gSk4B1udE68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MMbXH3+4; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fc4dc34291so8902076a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740416088; x=1741020888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=daGjRlPn538a7Mhk1b9p32Ju5z76xxGZiL/mJoi1gQY=;
        b=MMbXH3+4Cd25m4zUu8rlIwOsLWg1shCbPrnLq7G9j0EJ2Bc9IZMOSCBG8BlfoOxBrc
         RBV1JQxM+r8t2kq6c9yHhbBt7en12r+NqFt/sliGytUKFvcuKr7WdzGbzjlnsE8o1Dog
         pQ3fUYztFjPKNAbuCbD9ippC3aXN2E9ZFnzSOiD6iJMtH1rvErpSsHaKWHeqAGIAuGpB
         osgTa1EdELifo5ANHs+FJMz+azHYJ56ziUVY+53BRApfJdcpRXU/lcmngpZOVFr14qjw
         4EpZKb4ZoLoTGhdZCz/V8jM5L4cmexo2snduVTGAwzslRdyay+/2OBLwQjeyfOTStEFV
         37Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416088; x=1741020888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daGjRlPn538a7Mhk1b9p32Ju5z76xxGZiL/mJoi1gQY=;
        b=C1Kp7BTwS1qSdgxdpHMnJS3pmxDsodQlXN9hwKfdvvTRKL8sRNxVz3t4Wn6x5ITbnd
         xtTz8+lqCy2DOG4svkF3EG+1AAfsQbVL45OW2jZPoR4tDOBm88cKQ0tHDvHAg5hpg7t0
         Yl7Gmou8HRPXOFefU8AMghp2OtTfhnb2vkCTL7enLAfo7hHliIQb7jZSRnJdkag3/KO/
         DxKf7rWhgU+YHywomdyCPdl3hQs0m+eUpPDiK4Qojzoppj6D++CcUtmS/BxyRadUEMmX
         uzwQm7ev8ZdJRQMUe73g0VQ5iF3gbfNmIchd8jjjn6H3IKLNq/O7VJqjIBRNOMXKbZEp
         crWg==
X-Forwarded-Encrypted: i=1; AJvYcCVoMsd/1hApAg7n7Y+a00wflNQITV4UTbEACeYadDrgxXA9LFgExbwJOfnoiXySogIviFkQTg9ACuqeLRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOYXieHkLIvl3QwnEi8h8MkE8WM0GeS1EUV4L9EfUlwFBKOGW
	lwmK6vUyIU2UeVVQWxftdw3chiCZ5RCc90kIeCOf3T0H/RpaGVw09ETa98u52BT9Z97j1bmH7y7
	UbA==
X-Google-Smtp-Source: AGHT+IH+KEvQ9vCv7mHp7B4rZulwnRTcTJdx+Vfa7nofNtJtLF+U/LGwZGdzx9zvN5HOlsBR7jE4qNXI9oA=
X-Received: from pjbdb16.prod.google.com ([2002:a17:90a:d650:b0:2fa:1b0c:4150])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17cd:b0:2f9:c139:b61f
 with SMTP id 98e67ed59e1d1-2fce78a3812mr27531134a91.14.1740416088081; Mon, 24
 Feb 2025 08:54:48 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 24 Feb 2025 08:54:42 -0800
In-Reply-To: <20250224165442.2338294-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224165442.2338294-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250224165442.2338294-3-seanjc@google.com>
Subject: [PATCH v2 2/2] KVM: selftests: Assert that STI blocking isn't set
 after event injection
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Add an L1 (guest) assert to the nested exceptions test to verify that KVM
doesn't put VMRUN in an STI shadow (AMD CPUs bleed the shadow into the
guest's int_state if a #VMEXIT occurs before VMRUN fully completes).

Add a similar assert to the VMX side as well, because why not.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86/nested_exceptions_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
index 3eb0313ffa39..3641a42934ac 100644
--- a/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_exceptions_test.c
@@ -85,6 +85,7 @@ static void svm_run_l2(struct svm_test_data *svm, void *l2_code, int vector,
 
 	GUEST_ASSERT_EQ(ctrl->exit_code, (SVM_EXIT_EXCP_BASE + vector));
 	GUEST_ASSERT_EQ(ctrl->exit_info_1, error_code);
+	GUEST_ASSERT(!ctrl->int_state);
 }
 
 static void l1_svm_code(struct svm_test_data *svm)
@@ -122,6 +123,7 @@ static void vmx_run_l2(void *l2_code, int vector, uint32_t error_code)
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
 	GUEST_ASSERT_EQ((vmreadz(VM_EXIT_INTR_INFO) & 0xff), vector);
 	GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_ERROR_CODE), error_code);
+	GUEST_ASSERT(!vmreadz(GUEST_INTERRUPTIBILITY_INFO));
 }
 
 static void l1_vmx_code(struct vmx_pages *vmx)
-- 
2.48.1.601.g30ceb7b040-goog


