Return-Path: <linux-kernel+bounces-424088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66339DB07D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCE4B23453
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFC1863F;
	Thu, 28 Nov 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QCVFgUT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18989143759
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755368; cv=none; b=iZ64GpJOUt6TVo7DB4VbsbjrMKcAquoSgqi86IDvnYbyu9SNASX8ryCmAuwm0uN6DCbiUPNFIyUgCcGPNTy/y78mvdAUKdj4SaaArGQaXpB8lTpZue5nguiMrUj1RCZNnEeKzBGzYkjV995I0QhIft9IRW5qkFCT9IVD0+/jKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755368; c=relaxed/simple;
	bh=aNYWrhV3+Hlqkeo6/DSEk9PQ+DunnQgH+0LyxQ37ZvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b1HzVQX71xk8Zl7wIhJIKmU2lYxzXYp6HXEVJnWMydZOm9xDGSZfsdByuwuvBkfvimLCvuXAo4fNV3ecEoXJd19Lup+q6E2aZMnYxkrc0EcXYAOU9US5alhIeKr0yB8gNndwJBQyFUpTQGP4EvKI9elQvOUWqmFzV1Zk52+iuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QCVFgUT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ea9d209e75so301196a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755365; x=1733360165; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=m3N0I2xWsrfV4i9nnr3KT1Cpmm4B4GrEhZX0cF+2Gqk=;
        b=2QCVFgUTqg42jrqoJJlSe69N1DGudTAzLkpZgLaDN+H94GlnnaSOsVn9F/mUxiqxnf
         QhbECdSFLTqECkq6YppyZZ2bkUE9YTy37KWlPEYXxzqSIwVnfghbQ9NfoZ56EPFscgQU
         /KUaYX7n9unHO40bBmYhF+I+ANnLCUSb9Wjfm4r15/RXgjLuJkhgyrCorrPElKj7RFFw
         TzpaLecjBqY5Wxd6g6iCyowrWMK57SLaIcNJ1Es0Xd16bp7VzhMQajMp75+RJfhbBgp5
         EA0ohdTE49Zkn9bobsd3FVcQma3YZhlsM40rSs2kqHIyMqSzqzjLwQoUKE4NO9zsNdKl
         yxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755365; x=1733360165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m3N0I2xWsrfV4i9nnr3KT1Cpmm4B4GrEhZX0cF+2Gqk=;
        b=EM5gM9i4rA+Tt4NW2U+3S6LDkZLU7xaORKMwFci6kJ3wy1ao+keofYGG7qTB+M3lAa
         RVrHgAlt35t0MyoGAc4buWY/6SNG7y4TEGYy9sZfjy8dFCiEPMnJ6YFmiR6PJhTvjWqt
         FbwKwpH1QD9ALIXQuvnoCeLnjNx7Ltrt4Q76/idVOk6YcLKhVLKuRfhD6Hh0rGRy6FAJ
         k6Pui1irScSd4j9SBk6w81nRB4afBqqHUs/q5J/r1n8+IDWxLxLo0DL0aQF8APG7Nxf2
         PCVQEzd3H7bxcr4gCHL94qoRGCgGR6Xoj9L6HLsH3N7zdhvh7DiVqoyPPRBDpsLUvnHl
         FBTw==
X-Forwarded-Encrypted: i=1; AJvYcCXHx5qo0HdW56KZMjt4lQ4pN0NnxHRmnXegVnR5l6gRJDEJJUktaPjpaDqc//KAVEhRsUYsAi2dLodvc+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOlHISD+uM3jzTEH7VxJ8pb7GhfG+Df5JMYbVbjxE/5eAO1+q
	gOLUeesckGVPTylXrHFkJLil245ugsn1T5rVkWMl1HwxVoEC6EbJUDgD63KT4ktHwxYBBSWhZ1f
	4kQ==
X-Google-Smtp-Source: AGHT+IE4OA2YWpjZt4cUyGKEolrSn+wbKfMl6eazhCePp/W8mIleK1HW5p9Pm9svs3J06p9qg41Q+800XRI=
X-Received: from pjbsn5.prod.google.com ([2002:a17:90b:2e85:b0:2da:5868:311c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c6:b0:2ea:6f96:6504
 with SMTP id 98e67ed59e1d1-2ee08e9c7a3mr6508990a91.1.1732755365479; Wed, 27
 Nov 2024 16:56:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:40 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-10-seanjc@google.com>
Subject: [PATCH v4 09/16] KVM: selftests: Enable mmu_stress_test on arm64
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

Enable the mmu_stress_test on arm64.  The intent was to enable the test
across all architectures when it was first added, but a few goofs made it
unrunnable on !x86.  Now that those goofs are fixed, at least for arm64,
enable the test.

Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>
Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 4384e5f45c36..c59a337cd4da 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -180,6 +180,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += memslot_modification_stress_test
 TEST_GEN_PROGS_aarch64 += memslot_perf_test
+TEST_GEN_PROGS_aarch64 += mmu_stress_test
 TEST_GEN_PROGS_aarch64 += rseq_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
-- 
2.47.0.338.g60cca15819-goog


