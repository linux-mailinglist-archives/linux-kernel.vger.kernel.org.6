Return-Path: <linux-kernel+bounces-325606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC49975BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0560CB230C1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722101BDA90;
	Wed, 11 Sep 2024 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9NKtBUP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0B51BD501
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087359; cv=none; b=dj7mFu4FRUQ3pEYyodjmwbqqXrxq169BnfzYnTZb0kYWLImBZJy6Dveio+s4RoOui6jhz+x0T/VLZ8kLzimA49mpOR+dvwiNLp6+4LAm5LC+omlzEEaUdd+cB2FSu7Je8jP3dIsALmzkh/sALEbYuRENytAdBpJXBO0oqvhANak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087359; c=relaxed/simple;
	bh=fr34CVsgL2g82sb+1gvS8yCzrvuGG/23h2+dDn8u8kM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KgM5+Q+1E4osE83St/DuHgZbCCglBXWoXborWltcl/EeEmqAy/n2ZJ7NMIFkgBR7n/8HFrVI6qrG4LCmIOjlL902jAKQzqAyO+PxgpVbisJp8PiVuTPJT2W0YcLPSBYG7quyuDiWNWkv2J9UEp/Dp5J+J6m+Q4EVzRo6f7MdpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9NKtBUP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a6d328eacso738135276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087357; x=1726692157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=47BQJJiikboIPrV2PD33si1kPUmickrZ0k1m7wYEIK0=;
        b=k9NKtBUPxU7T6Vzao2Y0Rzz1GfVvTRbDy9KYF0mNoqxXmc1F9m36H4awV4f89ATXIL
         OGEn1MVfBm4BwBaa8hLy55TYwIieof/ic/SflSnfLGNrB0oLMiISrlrVRLpyDZZ38uby
         LvXC5F/+JUA850KTW90Wp9YCaRDq9TmLw5hFvEkyDkczRbTz5YPQiTlCqNA86JZ9iOxo
         M+Z55TTJx579DFYe1r8gamUmcx/ub5WT/ueDHeg0meLfXrqnaZWT9B01DOgHVFf6B3j7
         Ws+AB80cmFssM+uc0rbbQGFigm+ofAXQZ9mX5oX2OUACXya2N0Q2vOvBv0eJwRaK81p0
         D8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087357; x=1726692157;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47BQJJiikboIPrV2PD33si1kPUmickrZ0k1m7wYEIK0=;
        b=HZSaSsLcrcdcrwZh+M8aNdNqkXIhmWj8Zdfl3gsQ+T03wUV+WpGht4zjYUjZg7i0g3
         EjEdIqPHQc9owGmgeoUUpuvsl8vjc8uxHjk+yZosdqJBUGO16xj3qzpV+Dj5+AtOo/iQ
         FkKs/oZcDQ1g35yJeb+Tzk6kydaGOYWYhwbUhN3/p+jXvFVxLI1p/GfsiA1i8LmLw44y
         RMIBush61loNip/l0a+yicuzo6HCRfB7Y77vFB3y1hgNxH/e3W3A1JYfIF4WFvP9rlC9
         5RF2k1BWiSCinmInKNwa7PSQ5uLuUwwCTtHE4doM/sPp943sfP5B2o2AjkSXokXuBl33
         NEBA==
X-Forwarded-Encrypted: i=1; AJvYcCXI+vXloSQmaiMSOfoBDb6g+uTqKt6/GLwluVS27jXioe7uU2FNqVoyp1GrP3iAzcj44tuBH9ENQ1t700E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCgkc02q156NMvHGLCqP0/fkAzJo9AS6nbmw602jE7q3a3vC3I
	bgTvQITKrEo1kX8pUvuTvsOPyYq4U5LMN8py+zZCnm28JMQ3LosS1nnH6WL3Bp1jHCBEQGR+bXB
	4rg==
X-Google-Smtp-Source: AGHT+IGKCOrdvuPh1JFZJTD4VhxgbmNdEtpijYplyDxOyPTYxT/JV5RegfErX1F5y84KkH5DsNf+hpV7TUg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c206:0:b0:e11:7039:ff92 with SMTP id
 3f1490d57ef6-e1d9dc6f379mr708276.11.1726087357418; Wed, 11 Sep 2024 13:42:37
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:53 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-9-seanjc@google.com>
Subject: [PATCH v2 08/13] KVM: selftests: Compute number of extra pages needed
 in mmu_stress_test
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
2.46.0.598.g6f2099f65c-goog


