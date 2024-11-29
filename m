Return-Path: <linux-kernel+bounces-424086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCEC9DB078
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419922818E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BD213BACB;
	Thu, 28 Nov 2024 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwFi3Vqg"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB542E628
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755364; cv=none; b=QCAL+yzxmv6yn0akASzK/7GhLU5nVQxHKql25XcuH6e4scyQs+GFiIunpYiHd2UPzFY7jiqbsDzHxSqaGm4k57hmXMxxPnx+LNyz3JTSuhRp8b5iWPK540SzbSu3OftoTQIYNXvnTQmW3tRrS2rxaP59GaiQ7N4AgcboKbBiQpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755364; c=relaxed/simple;
	bh=EYB3L6b74MhfJrPzvb7T9WOOU7QX9pbOjbRmtOdicCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPL0eiqUciC5U5phs/cBSTQJJSCwaV/uv/hhP/09WFBz+iBc3NBkFAp2vdtzi5HtFJ7U4ekg4aCnND811sQV5WyYEdLDCVbvyt9Cze+T0i/4cnsu1c2FX7XDdbjHO0BAx0KEz6/YxvVRfspvpkWXsLzmGjbJymGzzDOEi8MCkh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwFi3Vqg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7250da8a2a5so325344b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755362; x=1733360162; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7/2VfJdiek5/ConUN3oh8Dq9U963aWvO6yCMgPFkp+8=;
        b=cwFi3VqgyVT749tieMTXYIF/Qk/99w7cG45MGFJ6SGQOGQe1tLYt/xlslTyqVNAkM3
         ByhjIRaFW47AJXqt7Ez04Tf7AWTU2iKYHlQQRiEPVfrQOe8Z54dRpg/0pygVlpS+A+BN
         CaPGnEr+TwOqgDe/wTwAmfS2ddQ5EW81ZQImfCzQW+SwKTQQmhN9TBL6mUXg77JaeJrk
         9iFxCPFxQ45sE5J9RGWBlbMzDQMA5C1IGTHjC+SAonEI9Y1ulFWAKMp7P58MCxbMfDuE
         GTDIfVMGlsai311I7VfLiW3L6CZFr7eAHLPTc50Ng9bpjFa292ZyMTAIutyw0mgCqDgz
         /cZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755362; x=1733360162;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/2VfJdiek5/ConUN3oh8Dq9U963aWvO6yCMgPFkp+8=;
        b=xT4AU4+E9wKlC1GfHwEeUtoe4mf45qaeII//5h5gWPzfSuq7QJD/obOUHwB4Af18a7
         fLauw0bBNDngvRMNkDMGs7D8MwrVEIlimLVtKaQC+o8lmxhx9UZ2Pk+IbK06zv36KRA7
         B2hKs0Nwv0NxmJjGYvcoy8UrN/q+dvxQ0GFeqLIVaAjUpoJmJLIankC8xPmtOTAR258v
         rAFn6jdxpayDITavMZ+9DMRahTXZZ4PsXCu8w3vfMJzKGK8VDENx1xU1Pj1YWlPakaCY
         KJDl6HrY69ti//e/c/bulSAVJG2DQs1ygRkSFStt5IQKXhIcmP/wlTZmJw/iyqYUjIu3
         L+NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUA8YvLaty334vi/SQrPaq4SMI0sPF+nPjxwIDQ22O5hdMNK8VFe1hsEhZ+j3FRDp358MSQCxX10/3cVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWNJnvO6/nULW0c7m+RUhe/MUfOanXxchvEH74lhMCwyzhgu8
	e//hOVqAJKF5q8pHPlg49owEzLx7ixdseTUslaG2Nl3kVZ/LY1n94kQKLHXPiajL+NEskvA7gn0
	LEQ==
X-Google-Smtp-Source: AGHT+IH/oCUXOezhQ0A565EEmfthxQY0rCc4VbVmqRSwagA0iA03VskT3jIu5Z1zmAcsnP7ZOJe6QkUN4cI=
X-Received: from pfbeb15.prod.google.com ([2002:a05:6a00:4c8f:b0:724:e5a7:e33d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4654:b0:71e:6c3f:2fb6
 with SMTP id d2e1a72fcca58-7252ffd753emr8477585b3a.8.1732755362168; Wed, 27
 Nov 2024 16:56:02 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:38 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-8-seanjc@google.com>
Subject: [PATCH v4 07/16] KVM: selftests: Compute number of extra pages needed
 in mmu_stress_test
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

Create mmu_stress_tests's VM with the correct number of extra pages needed
to map all of memory in the guest.  The bug hasn't been noticed before as
the test currently runs only on x86, which maps guest memory with 1GiB
pages, i.e. doesn't need much memory in the guest for page tables.

Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 847da23ec1b1..5467b12f5903 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -209,7 +209,13 @@ int main(int argc, char *argv[])
 	vcpus = malloc(nr_vcpus * sizeof(*vcpus));
 	TEST_ASSERT(vcpus, "Failed to allocate vCPU array");
 
-	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	vm = __vm_create_with_vcpus(VM_SHAPE_DEFAULT, nr_vcpus,
+#ifdef __x86_64__
+				    max_mem / SZ_1G,
+#else
+				    max_mem / vm_guest_mode_params[VM_MODE_DEFAULT].page_size,
+#endif
+				    guest_code, vcpus);
 
 	max_gpa = vm->max_gfn << vm->page_shift;
 	TEST_ASSERT(max_gpa > (4 * slot_size), "MAXPHYADDR <4gb ");
-- 
2.47.0.338.g60cca15819-goog


