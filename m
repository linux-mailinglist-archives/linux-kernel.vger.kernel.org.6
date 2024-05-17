Return-Path: <linux-kernel+bounces-182440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6544A8C8B57
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A911C21BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF51419A2;
	Fri, 17 May 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vxaBxEtW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5310D13E8A9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967599; cv=none; b=mzskLmTSdn43hXcxjeWYDGaB28VShuSaJVu/wsY7B6fbSaOszvShA7e4PXzsqD3jKEnaJSaFfY+Oaxdc1gW7Us6hVnKx6bvqyQudICTYQVn1LRrtlhn1NzOe3Hhz/XZWTtBI9FRbDve7OGBLaiLURr8KwWW6d/QLdmSXbl1EmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967599; c=relaxed/simple;
	bh=N9PO5HRhq589/FZmt7XnV7moYhp7bMFPlsJa3v0pqAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bi65wIerchDQX/g8inV8bCNxL1jdjr/C67UFTP1CM32uOnQ85k4ncLtFG0+KSe8OtKjVHSVMJ79WNvXfVNsz+RfiCvamPeUisLNw9zmShfkQHClgTYCYvHB5mNRNzMllJRjcpyteX11OCrazlW1GsIK7mutDuypuN7z83raCqLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vxaBxEtW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so9072029a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967597; x=1716572397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6Yo+VLe9odGlqzwhT9Gwf6Wef0XuvPIk4gSpAu9YZ3E=;
        b=vxaBxEtWphVVSF9DbWSgakuS3mkOE2oj7pbq84DeXGBcw+uZu9JHBS+7ERylWPxY9+
         6XFZdVVwp7QtbOg4qT0E4TFAP/0BH7nQCXqfjInk+uXUoeUbA7AXoIhnblQdGxIZftno
         LL3Vm3ZMsMKzeEt9YqKsV4cJ1hshqirrvKdAJ2jnY0GCNJyB/3jpBnOpVt1ao1lWx1uO
         4BRml0egPRlHvvt0LDaEl21pPXP03OEDAq/oFwmzxekqatTxpiN4jrSg3UaHluKqS16A
         sRAc3OvvlzC4QchALCyZ3i2SPQ/8LNHc4WfsCSH6q60S8stzHP2tfPkhmYkhhiMwXysk
         O49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967597; x=1716572397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Yo+VLe9odGlqzwhT9Gwf6Wef0XuvPIk4gSpAu9YZ3E=;
        b=fD6cuRj6l+kS2YKS11lOrOSjYRdre/SQAACwo6W32lsgovUs0Os9xsFsje1ktqCVuw
         MerBuvQ/paTixPs5DM9WKBXmX0P/T8NQEi2AHrOzwC+LkZtYGR3wh215CFHBI/vq5YZO
         PY1e/ul0r/mLAcdCVb+UV1+xzBSM1zlm702Z82dUXJijaoIiEviokpFGQFOIGVg/Z1P6
         gfb9LJtMJTqljCcpJoY/S/USWM4QiqzRRGkodwCNo+WKlCgfqABrt6+/ALcFkmSnJ+vT
         iSsLQge5MXX9DV43OQByQv6f8m/hS5rL/N1ep+wU9b9AFzctdS8uiCP2cvOVzBuvDMvU
         5nvw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ3n8v3Xo3PBK6DoGFEebbSHIaCbxz5mFI5OB92aiEHmkmRDpDLwbrJV6kOq/al+o++g1tLr9dY3QJQnxl3V6QyM8vY5L2mmvUAG2d
X-Gm-Message-State: AOJu0YxnBFS8/Ll9N8KnhSKGH9q9fMvsGjmKEaL9/Rn475aKHchXn5U4
	EB/b2CXYVDYIX2MqLXSxg+GmeNLYcwrf39Fh8A0vpuJ1UaFfL9bWXIkYXZoRWmtLmRH5/H32pEC
	Wqw==
X-Google-Smtp-Source: AGHT+IHXiidSMA654/zQaJMUmb4GFxomZhcL0ZO5qiPxnLUpOmpXw2SDX4LG19i9eS8UqNld9GpMFUgu1xs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:124e:b0:1e2:969b:dfdd with SMTP id
 d9443c01a7336-1ef43f50544mr6561205ad.8.1715967597545; Fri, 17 May 2024
 10:39:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:44 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-8-seanjc@google.com>
Subject: [PATCH v2 07/49] KVM: selftests: Verify KVM stuffs runtime CPUID OS
 bits on CR4 writes
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Extend x86's set sregs test to verify that KVM sets/clears OSXSAVE and
OSKPKE according to CR4.XSAVE and CR4.PKE respectively.  For performance
reasons, KVM is responsible for emulating the architectural behavior of
the OS CPUID bits tracking CR4.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/set_sregs_test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
index 96fd690d479a..f4095a3d1278 100644
--- a/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86_64/set_sregs_test.c
@@ -85,6 +85,16 @@ static void test_cr_bits(struct kvm_vcpu *vcpu, uint64_t cr4)
 	rc = _vcpu_sregs_set(vcpu, &sregs);
 	TEST_ASSERT(!rc, "Failed to set supported CR4 bits (0x%lx)", cr4);
 
+	TEST_ASSERT(!!(sregs.cr4 & X86_CR4_OSXSAVE) ==
+		    (vcpu->cpuid && vcpu_cpuid_has(vcpu, X86_FEATURE_OSXSAVE)),
+		    "KVM didn't %s OSXSAVE in CPUID as expected",
+		    (sregs.cr4 & X86_CR4_OSXSAVE) ? "set" : "clear");
+
+	TEST_ASSERT(!!(sregs.cr4 & X86_CR4_PKE) ==
+		    (vcpu->cpuid && vcpu_cpuid_has(vcpu, X86_FEATURE_OSPKE)),
+		    "KVM didn't %s OSPKE in CPUID as expected",
+		    (sregs.cr4 & X86_CR4_PKE) ? "set" : "clear");
+
 	vcpu_sregs_get(vcpu, &sregs);
 	TEST_ASSERT(sregs.cr4 == cr4, "sregs.CR4 (0x%llx) != CR4 (0x%lx)",
 		    sregs.cr4, cr4);
-- 
2.45.0.215.g3402c0e53f-goog


