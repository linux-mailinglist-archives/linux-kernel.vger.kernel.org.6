Return-Path: <linux-kernel+bounces-424085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0029DB077
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2736B227E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73305139566;
	Thu, 28 Nov 2024 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0H7UpLYx"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE382C7E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755363; cv=none; b=tD45rXZ+nsL8MnqIofHzwGFVjw0MjobdIhokRY5ou9z6YCd8jHdVgDTk/nGBAZ+JxS17uKD43pcSdywaj0TETiIDt4SGJYNvJKlUGkS9xKYXNT5XkdK/5Be7zcsbV1x9gGxoyDhjuC1daMU3qYRvrFQjrSg4zCK8nhHNxTmt1q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755363; c=relaxed/simple;
	bh=/iq+5+KMMzm1j6WYTevg5oS1IBKtUjYGyIPBk5OQXL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdSkM1CgikvGXupzAoFj2d3Y09UH9ymON1DKNMe6qUoT2dOticjlDFsyMYefj7JWqjbOf07XMEdF2R42lh2vunhDosYPv8WcNVigcHnLVrFSpQjLnXfNrtDPvlF3iCSeanfU89mFdCI/9phps4vZaPaXe+i+fZ3YSlPYdZ/DqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0H7UpLYx; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-71d63a6ce62so161592a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755360; x=1733360160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=JyP1JUxR4wRqvaLFIbbuwXgM3uy7FspWl6pSel31SGs=;
        b=0H7UpLYx4fY+Hekf6j13QVIBtf2YVcr4dZ+UtitlAWw4sHsnzufMLk6qXCh/qn62mH
         cZrYBo16TITC51UJgo+QmQfwsG+z3rn6U4zrlZuNS9vdTiyinFlwV3z4HMFM1UH5DwJo
         pga5GzJSquNUycZHhIgeJK1PZnmu0FkozYEcBEu+0hua8fm0XtLBwB0J9VKKKkYE+8HO
         ynLFAfeNM4qfDnXjE6zQ+y66GP27uY1hnl3S8MQKBLSzLLTgJJMXSD4Y4KtrbsuLwrWS
         o/J0Lma4v6ItmpoH20NxxKQmkC+KYbE7T4ZIyzd7aloPl/mQF8s0fXFD73mCzUYChop3
         mnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755360; x=1733360160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyP1JUxR4wRqvaLFIbbuwXgM3uy7FspWl6pSel31SGs=;
        b=bAEF1hu/o1vi8Q4NSkV9oQhHUwBhO08bEyzOveXU0+wro1fNZK08GAnc5GPzT66GoJ
         xQaO8Nt5txccVarM3AFIl15a7ptVPqNkVytbQIyR6TbTTelZRn5jVQqJT7G8RSCiC8F+
         9wsiCcgTHYSKShR0Je196br4BIav7tvkLNgAGClDY7lHbO6E4TOeqvNxYDgyJxTe0+dn
         KwUCPD/OOOSmxQQ6HXTOWaYG0dnX5WVQ+GoAz6OdkwX24WgB93aXjok6yFD1O/QeA0jT
         e8cH6pLGMXQobZ+MLYmxZ/ugBOvaxVadlNLYAXhqX/TEIXQZjZpROwZqdDNf9hgIvdk5
         Cq+A==
X-Forwarded-Encrypted: i=1; AJvYcCV+pMKNANPuDo3JUYovqqhyX/OzwOSl1ONkGRX12rCiZ0WyI3StbsrnqV0FfbMlqJsccAUaYH6Qg6Qo/mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWYbYy62zH+n1EVhzx6WzdNpv/XRkodCgdWgbZHaWXRcE9j9+G
	7kGm42vC5yPVqQooQdWhFQ4SCq9NVapbiibFlf1jrsdR17+9mTOBwN7qYH3ySH8js5IHx4Kv12l
	2EQ==
X-Google-Smtp-Source: AGHT+IH8OsD6EvK6kpKey4op5FA84HiW/8R3R+eIuJX0ly9wWTrNA0B30UgLwfP51sElrM78pAke6fhK31g=
X-Received: from pgah20.prod.google.com ([2002:a05:6a02:4e94:b0:7fc:1fef:7deb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:6c14:b0:717:fdb4:c207
 with SMTP id 46e09a7af769-71d65d00ddamr5604090a34.26.1732755360453; Wed, 27
 Nov 2024 16:56:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:37 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-7-seanjc@google.com>
Subject: [PATCH v4 06/16] KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
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

Try to get/set SREGS in mmu_stress_test only when running on x86, as the
ioctls are supported only by x86 and PPC, and the latter doesn't yet
support KVM selftests.

Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 0b9678858b6d..847da23ec1b1 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -59,10 +59,10 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 
 static void *vcpu_worker(void *data)
 {
+	struct kvm_sregs __maybe_unused sregs;
 	struct vcpu_info *info = data;
 	struct kvm_vcpu *vcpu = info->vcpu;
 	struct kvm_vm *vm = vcpu->vm;
-	struct kvm_sregs sregs;
 
 	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
 
@@ -70,12 +70,12 @@ static void *vcpu_worker(void *data)
 
 	run_vcpu(vcpu);
 	rendezvous_with_boss();
+#ifdef __x86_64__
 	vcpu_sregs_get(vcpu, &sregs);
-#ifdef __x86_64__
 	/* Toggle CR0.WP to trigger a MMU context reset. */
 	sregs.cr0 ^= X86_CR0_WP;
-#endif
 	vcpu_sregs_set(vcpu, &sregs);
+#endif
 	rendezvous_with_boss();
 
 	run_vcpu(vcpu);
-- 
2.47.0.338.g60cca15819-goog


