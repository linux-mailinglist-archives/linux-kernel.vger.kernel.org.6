Return-Path: <linux-kernel+bounces-515941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB64BA36AA9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A7221894148
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4CE2D7BF;
	Sat, 15 Feb 2025 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WTjDmWcM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E74433AB
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581794; cv=none; b=QdBW/uuNg4OPk3xhWeqqpmBREfHGqpxnppu7u2JUDWwkRf6h0B3DpC2Ti0oBJ3bunMTQhjYPdESPtvF8ECTmaW9YwBm6HDGKJgD7DXluEJuoasKJR2Pdx6Oa9OxUlrZTeeZqk4F+bNuYzRMcxFBLFGvWbRSTos49/Oo+7PNjhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581794; c=relaxed/simple;
	bh=k08kYOr5amr0PMaAsg/vb1TyI0SEHxFgH5fDVqymMUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u1kvT8jYDICmoQ76ikk4AnsfBFQvArANAHfNBHTzZkDJGKQjuTS7E2zgdXnzI/64EqYZLGAFFewcO81XvpCwdeEPTY+6elefLJkLqZsAyuy6fa6WZvy9PU6LmbAppon5XIV4eCJfZPzBwHtCvjszBxYMSiqhoDbX6NCp9uQlMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WTjDmWcM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220ee2e7746so25900095ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739581792; x=1740186592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=daGjRlPn538a7Mhk1b9p32Ju5z76xxGZiL/mJoi1gQY=;
        b=WTjDmWcMzDfewC/A8m+CN5Z8BFUl++XnjKhK0DJ0bsT1v4sTWbTgeeaR60VZnrTV4k
         Mxvvqrz2qfXkZDKILb0YWjeU4B0JvZIFMrWwFUAT0yE4vgHAXOgDSWxBWmWxIMC0ATRc
         F6DprdU0KakYGpGLyHl1jy2Hc3iiixowTDk9VpI+CXqt0RPRVNiJnDLM6B5N1TvHHcP8
         FPMvJ4NQ/7DEPj/idwLft1jViFVc/Hkko8OpvtsYQPcm7dy/msOykQQFLNHCU2fLU3Tq
         +k+YB5U0MVaO/6WrrvdX5eVHdSO96Z8p+Qr9dRN2URzI6lcCLxoXk1s3vNjoOomQVGFi
         iDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739581792; x=1740186592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daGjRlPn538a7Mhk1b9p32Ju5z76xxGZiL/mJoi1gQY=;
        b=VgESR4jYSmZaJSMroq2sQxOImi5YhSB/e0NyViPvmEG007DfgH3eukI1hypHVxCXvJ
         iUWCu14eNETtq1ZxvhG0oJ88ifvi8/X+BHqhH8rKMvy4S5j/O1L+JG1agj9OUTlq16nn
         vANHH+sut0tuqkbntlrzSIhjXGzfsQmpnHIN2P129iLIzgF+mbHNEKs4guAiclb9YGJt
         hQvp67Pee60/q/SdnrGigesHmA3TqnIwP9LWQVT23QGKoqr/yM4eUhlc4Ej27+NwCFhf
         G4yPOAF6MfwyUejGezDbnFU0wedPz2QqcYE2cnNZvd+QKOLt/txvC8gehmR8a2kudKvw
         7kfw==
X-Forwarded-Encrypted: i=1; AJvYcCWVwStRm+yltNNHF37UqEOsiyyuRe7+RorL4pGG+JfM8IkiZFE7Hx5LSBN6TiO6p8yzwIM/tIpHi7+beFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn4NYP1A+rGcr/QWuJZ5nGw5l3ygtqcTI0CKyzsazwdZ76q5L
	Glp3QRb9x7rkr475AWZhIELx0zzYW813cZ88XbiJU6wgdnikEN/yv5XmeMs5t1+hYzs8KAVR/1u
	RJg==
X-Google-Smtp-Source: AGHT+IFvuYkc6dkhIoLSXv/TfkhyhlegXXjjNDffj8c9h7UcOv2qQGR5/L2/ydeA43o8bay1iGCM92srIFU=
X-Received: from pfar15.prod.google.com ([2002:a05:6a00:a90f:b0:730:9717:b216])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a2:b0:1ee:6a26:648c
 with SMTP id adf61e73a8af0-1ee8cba0fe8mr2926356637.32.1739581792352; Fri, 14
 Feb 2025 17:09:52 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:09:46 -0800
In-Reply-To: <20250215010946.1201353-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215010946.1201353-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215010946.1201353-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Assert that STI blocking isn't set after
 event injection
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


