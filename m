Return-Path: <linux-kernel+bounces-357391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910939970C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A311C22C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6A2040A0;
	Wed,  9 Oct 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yuaRRkWH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC5C2038B1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489014; cv=none; b=JOVcczvgK8urAXcdpUDWrRnltVpgVNd/Xx/Bbpkl5GhNd7p3clnnBp1KHQY2e/08ug+Wd5omkAQr3piyVG4f8UoF3yrULxa4Np7JBh7SLVFzW7ktle0MQuIp6EpneBNZAzGxESaLo+jXBybkxmfqBTE0FxsTzhWl0u2cNX0RGW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489014; c=relaxed/simple;
	bh=go2nSUoOu7DLGf2G03lp2uqdBfC+a2fqniLkbFG5GlI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g5NtKlcyFQKmdq5fQGe7/S25tDFQd10SPuBfsEzmWE07Nk5h9bEdGpqDqHbZ5rT7HRUXnap4ch76JRLIgpsg69kdhFwI3DeC3cfO/tT2Fsfben6fcMHEyUIaB4ywmkyNUpjpF8qH9w/sULN7IGGHvUM3lFWzkofsnkQL5XWun3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yuaRRkWH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so9598715276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489012; x=1729093812; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BR1gG58gw5F7E+LpSzoPu+wX+wiyja7ptJ1fl5K+zYE=;
        b=yuaRRkWHUpaQW6R1zC8KmVLk7LZ4KoXDgjH+7DhZZjo84iFhsXvBBB79W7zRaP80Ip
         NLCqRZtX3ue3+a9NZUgmp3fLL4+W7oEb8I+SI3PCnSj6ROXc5jYiyW0TggvtinpLCROC
         M2YllRT7zAUFeharTgVDn6boRcIM5SRusunlNhfVmbn0EDgmgU657KATjNKspJYTN171
         52wJBxY7gVldYw/EHt8Y/seBGyNRdCjXUxtnCl9pG6Vt1f3jBvCuEnneXNEvghIQHqjZ
         AiNqZLIFNi7fE0V+JlXdaj8M87POruZqgTn8pfFbRhapZjgg5BCdGNphVITLmNXqQm2H
         rs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489012; x=1729093812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BR1gG58gw5F7E+LpSzoPu+wX+wiyja7ptJ1fl5K+zYE=;
        b=iUPFMXuKGIYLcjnoCu+ikxehqTLcUbtPnh6B15/QAQdpQfNZA/RuVO4Ns6PeoFx7gc
         4wdmEU/g/Z+gdyBEfQOU8vtq8Kb0nlGcE481CLcGyESlifGFiQ+Gg5/91k4vGCCUHdDf
         hougsInnT0nuO+icpkiMzgWCA5w5C0I7dJxqqF4NOWs9jYgUSDtDH204SF6eFNWQdnDp
         z/QBKDTGt6kENenWsJnWm+PtrTt3Rhcp4aq3QKTqDhqmoAjyuR33tlndQIuW1DnL7ojD
         q1l+biWVnJR00xGH82D5OfPB/JgeqbwJLPUob0ZhHiZQTcu+7U/pAqTksFf6ePLbIOHk
         colA==
X-Forwarded-Encrypted: i=1; AJvYcCWhM5i0K18nOcP0iSddgyTw7U7zIW9PmBQx9flvp2U7sqOdFHWj/HhP8ECLASiMegHiVocY2loEA42jAr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7o0zE52rsZjUU2SMaGkk3Fikn2McbMVyYn9PSmaRJVHtwnd6Y
	SLB204YjtoZot6wYdSfW43za6r+V1nKLbX3BSpm7cpSWOWiz5Kqy/NAwkc8if820Ax/K3TwNDyE
	pmA==
X-Google-Smtp-Source: AGHT+IHLwQuTuSKn2K83jzMORxhmnJG2QJIDSetKispH+vrqgQjqJfiOQ3+gOO6ZQgZWYqSyd9aEi5B6J6c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:6948:0:b0:e29:6a6:ed83 with SMTP id
 3f1490d57ef6-e2906a6f043mr903276.11.1728489011277; Wed, 09 Oct 2024 08:50:11
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:47 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-9-seanjc@google.com>
Subject: [PATCH v3 08/14] KVM: selftests: Compute number of extra pages needed
 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Create mmu_stress_tests's VM with the correct number of extra pages needed
to map all of memory in the guest.  The bug hasn't been noticed before as
the test currently runs only on x86, which maps guest memory with 1GiB
pages, i.e. doesn't need much memory in the guest for page tables.

Reviewed-by: James Houghton <jthoughton@google.com>
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
2.47.0.rc0.187.ge670bccf7e-goog


