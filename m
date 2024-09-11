Return-Path: <linux-kernel+bounces-325608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640D3975BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296BE285D42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DABA1BE23A;
	Wed, 11 Sep 2024 20:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hya+hz8z"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B671B86C7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087363; cv=none; b=F8r0x9peQy5Zrf4jDLZR6LqQQaKK5J/PNPwWZn1T/YDncUWy/YCTjO1IsG55EmNVe0jDPfwzdrP2U3/oBOaIH1M/+SBd4X9b2wUXTq8jzJnCBrXtigOgx6qNRJd3cvGaJ9bk9Osna59lOfCNVni5nVr1gRLlvTYkvve0690Lcok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087363; c=relaxed/simple;
	bh=hTKlj60rYtk0bD0DOzR2zSTjrZ18AZM0vgeJHBtr2dM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AIrdb2Qqm3da6Jx0NVwYSVWi+Hs1Qeu0ISUUfDYfYB7e88jlf9yxFcUbwaYVg6QAJ7j2RDXQe1OLvZeCNOROY6HLDhSHAW18E/skW/0d9VE67980UmuDwmadqche+pK9/fqNUg7jmB8E8oE2zKnkC5RM/5H9XVegMOAoPgkIOPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hya+hz8z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7d50dadb7f8so805703a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087361; x=1726692161; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5I/tJcOHFIa65Wz9gc3TwU6W0/w2a3V6j4MGXxqQ3K8=;
        b=hya+hz8zWaCit7GyLjAcudAcV87uvkS8gzBLkYr2mbeUWDxeexwuqzUNtpb3GGV8lM
         Cn5r5OGAVq3xtULHAOnIymuxAy/8Xl+vdX1urF32cai8jubjP9FoUppfMFLik+kvj5Hy
         52W5LCT/D1tDS5a8YlkUldv2/OoAyFenjAZC236+ArgSivSmr63cCfnq4MfHNOxltCr+
         cxms2ERTe1hZhz0iRNJr7VwWg+rlOy5MYx0FoGXL2owzzL+uDZUMFWLj15EHL22ihREq
         00b0OIwHNrf/ZTKJHosRxeGzbl4VjAzJJY7TCKrlERWQCmqAqfuErx5L2/YFd0Ppwnb+
         RovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087361; x=1726692161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5I/tJcOHFIa65Wz9gc3TwU6W0/w2a3V6j4MGXxqQ3K8=;
        b=vjIwNDTqqcmBcMdsB0agf5kbvOGl1It5suYQ9Aiu+CzlGEhVuvXBT2j6M8Xf+RtQVm
         4KfpIrLTR+0O/w2oGLKQMpcUidjNfeTKgSZvQux/XQWlklmTH7zT5cZcQ7qTNQWjOd7l
         9xFRxCfPJeIlg05dArRB85YVGq+E8fQwm7oEwMlwj69970RdtD/RBE55II0dSpJUEyMa
         BEpiQVh9TBUXyFUbBtv3JXCHFxrNbdl/FflJlon/RVgSehyQUZI7upN33y/p6xJkvtON
         DTZ09BdVTylXlJ1Rnz/39IR/HqPXSySSXJ8+V7N6FkxT/S6bwSVyRG81E1Gs5OnTk2q1
         iVEg==
X-Forwarded-Encrypted: i=1; AJvYcCUluS7P6NyY0XsrUYpE8cmfPwXKLUyUZ/Lfy/oiX6+t3IuHEEj+lUcJWP5AYDivWXnlzSbenLmWuYCf6Rc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/kfDmlNRprUQ/GbbQM0dxxrb89fNsPmVgFmn+joFiLoFf4Am
	knAIr/7N5lJrPdA1D2Df/+U53eyFS5lOqQ3qSCLwf2V5hzZy04S41FPZbOqv+USHMWiUVC0IxVI
	fXA==
X-Google-Smtp-Source: AGHT+IFOw2zNAqVhdCkeZdNi5IKOGHn5wgnynX/KErJqxVULBd4txDltmiT4cacd3crmvx8FKohy/M+nAhA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6fa6:b0:2d3:b1af:ae48 with SMTP id
 98e67ed59e1d1-2db9fcb47f3mr17342a91.2.1726087361313; Wed, 11 Sep 2024
 13:42:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:55 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-11-seanjc@google.com>
Subject: [PATCH v2 10/13] KVM: selftests: Use vcpu_arch_put_guest() in mmu_stress_test
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

Use vcpu_arch_put_guest() to write memory from the guest in
mmu_stress_test as an easy way to provide a bit of extra coverage.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 5467b12f5903..80863e8290db 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -22,7 +22,7 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 
 	for (;;) {
 		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
-			*((volatile uint64_t *)gpa) = gpa;
+			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
 		GUEST_SYNC(0);
 	}
 }
-- 
2.46.0.598.g6f2099f65c-goog


