Return-Path: <linux-kernel+bounces-257713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B5B937E0C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 01:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E1AC28179E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 23:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749B148FF8;
	Fri, 19 Jul 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFGL7t+9"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB8EA35
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721432630; cv=none; b=bzw434yknSAMv1FQME0MvfwZp10oznOZlHs/+vC62nAvUizURaRD5p3mImrET3DCy9ah+OwhYR40K8r9oaVSGkednH9gmi6ERCn8+C20lR0QhFAAaHQAX4pCr+1Mgnke5BZC8XpB2iawUDOF1Gbrlzrw0PPJNKnr7ErFxmAPNNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721432630; c=relaxed/simple;
	bh=BnwkD7JlA3wmXN5BrEBBPWjBLeMDRCGHGyt5jyb1mnk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M9pyu1wzhDYVAk4uU3EyfG8ZGPO95EIuyjCSqpXb33pbjzBjL6u2Fs2y7VHDehdW0qiVvfJQJO7B6y+JO4jwYeNXEGPFdGRSq5I/LrxplUySUIA71/Ty2/h72kkAv9Xvykfe3rQ+dSWR4kC1/MV8XX35qrNImNKx0hzioQtc1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFGL7t+9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1fc60ef3076so20864815ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721432628; x=1722037428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQ8RivBIo75BrN+Ijd6URWso23XciyBNatHrUyqY5Ac=;
        b=FFGL7t+9VHuGwz60vM9cvkmt8iT2/0KHplM4nn3QMRKn1iRi3l6s4YNxErRYvHGTHe
         i0WUcCrazE+q9CyUxstr4eGkUgD7Ljg4NRrpd2VWSspmxfjWuqhxtbD9LgGZWCkAijaa
         xcQwKJ+q4kW1uicf5PIBs2jweWsLQ79xfSlzzGh+MabaUOc3hAE3zaiu6dZtYr8Y3FJj
         A3HDlOVsVtxT6V1JjANhaGjqMRf+Jx9768hDMHRwh8YWb1wRlLSu5VGSWFXmF+AtvykC
         ZjfckFjsXtQ5HIKDqNggIQe3j2eMduKHdlP+ajAAf7THTvpxxuxfHkefw9+2ZKusUE8A
         r8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721432628; x=1722037428;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQ8RivBIo75BrN+Ijd6URWso23XciyBNatHrUyqY5Ac=;
        b=g0ObXpM/QsrOT5pYTQvi9ENtAMloVrzRqEWQOH2YRYNUtGRmhSn65QJld9zXzrqheZ
         ux4GSKRNfqLbFycbWElO2/oP4299idW2UZHkCbJYnpPxT9ysBv8YsA/iH0NmZ8GQPyTJ
         BCjD0KFrCk39VZqvBuQZHlTe+xuyz7moZcvmKvbfZN/38Fxt8YKB3n79VDHpZoOu1uKj
         TpvhXuz1ZUEz7oMzfzXKuB4lZC1XnSHcPnfm48OOnhTdGtnscR/jK01pTAryKj7Q2gkC
         t5FIHQwmVIuvBkzguxVdVmDzushxNIYeu68PuMWaF0YlvEN94kH3TIHPAXoRM4fCwafq
         7uyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn6vS6Tj5FeBX73qB2KvBBWj4Nskt0cGbkLKmvls8H9gpaw70ATzKu3vKFxv2amUqJxqYiAoLkBqArNcq+g5kY5MVxRRS8M5GMFVHR
X-Gm-Message-State: AOJu0Ywzfd+EWi7WF7HXlrxdkRqKWgCIrO456yYAxNGnxODa40iEfms7
	jfgLNY90w1BvsRA3+Ge2yNmCgBJc8dGK+eTIs8lEG8RYOIY8bIKDoWRfMv89zH68Shgl0xY8Lc2
	79A==
X-Google-Smtp-Source: AGHT+IFMH72YYuQamYsgopMC2DbqPeBfYDYeUR+OeGPgfIewS1lgEjCIJMOHMg0iIcOIVdwR5UAqnDPkHPg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e885:b0:1fb:7f2c:5642 with SMTP id
 d9443c01a7336-1fd7454ba9emr958365ad.4.1721432628263; Fri, 19 Jul 2024
 16:43:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Jul 2024 16:43:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719234346.3020464-1-seanjc@google.com>
Subject: [PATCH 0/8] KVM: x86: Fix ICR handling when x2AVIC is active
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"

I made the mistake of expanding my testing to run with and without AVIC
enabled, and to my surprise (wow, sarcasm), x2AVIC failed hard on the
xapic_state_test due to ICR issues.

AFAICT, the issue is that AMD splits the 64-bit ICR into the legacy ICR
and ICR2 fields when storing the ICR in the vAPIC (apparently "it's a
single 64-bit register" is open to intepretation).  Aside from causing
the selftest failure and potential live migration issues, botching the
format is quite bad, as KVM will mishandle incomplete virtualized IPIs,
e.g. generate IRQs to the wrong vCPU, drop IRQs, etc.

Patch 1 fixes are rather annoying wart where the xapic_state *deliberately*
skips reserved bit tests to work around a KVM bug.  *sigh*

I couldn't find anything definitive in the APM, my findings are based on
testing on Genoa.
 
Sean Christopherson (8):
  KVM: x86: Enforce x2APIC's must-be-zero reserved ICR bits
  KVM: x86: Move x2APIC ICR helper above kvm_apic_write_nodecode()
  KVM: x86: Re-split x2APIC ICR into ICR+ICR2 for AMD (x2AVIC)
  KVM: selftests: Open code vcpu_run() equivalent in guest_printf test
  KVM: selftests: Report unhandled exceptions on x86 as regular guest
    asserts
  KVM: selftests: Add x86 helpers to play nice with x2APIC MSR #GPs
  KVM: selftests: Skip ICR.BUSY test in xapic_state_test if x2APIC is
    enabled
  KVM: selftests: Test x2APIC ICR reserved bits

 arch/x86/include/asm/kvm_host.h               |  2 +
 arch/x86/kvm/lapic.c                          | 73 +++++++++++++------
 arch/x86/kvm/svm/svm.c                        |  2 +
 arch/x86/kvm/vmx/main.c                       |  2 +
 .../testing/selftests/kvm/guest_print_test.c  | 19 ++++-
 .../selftests/kvm/include/x86_64/apic.h       | 21 +++++-
 .../selftests/kvm/lib/x86_64/processor.c      |  8 +-
 .../selftests/kvm/x86_64/xapic_state_test.c   | 39 +++++-----
 8 files changed, 119 insertions(+), 47 deletions(-)


base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.45.2.1089.g2a221341d9-goog


