Return-Path: <linux-kernel+bounces-357389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586789970BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3E71C22EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0B202F96;
	Wed,  9 Oct 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I/AY7GT1"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419F202F6E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489010; cv=none; b=kf52fsyZkrKvFb4HpVkBNeuKjLc4qYMmLj0Q1ttKP1N+kRjitz65YN2A8VdDZ8pY84PK2xkEsrkWLlNKX6YRz8kBJL1QKX7d81GdVIin47rKn2sW6jxus9NpB3E5fXNfX+i7tw33k/6do2cQnUxbidRubG+tRddb5tJZqMRUBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489010; c=relaxed/simple;
	bh=rzKl++CWaUW8jRUGQiR8avz8+vDBd2uSvVkufkDoQug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aR8NugL4xiUaJxvetoMyTRBsZqmsER9xQ0eFRT32/V6jy4trw6S5i9+KawEkvGoHc/SmiWqNQan5SvrJhZ6yu/PGkHGoFkE4/5XkcVsgRFM2dRsDUfuafG/R9vZUxyYU3Vs1nTJE+Osu9nT9z9n3wNi6h6TQz+Nym781UwalsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I/AY7GT1; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso517587b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489007; x=1729093807; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9+y7oelTnk6r5KXO5BIzd9TWGjZrwMN3AFTrylQnTmc=;
        b=I/AY7GT1bgD9i8lobvu05GIV2nOjbI9GCdlGiaHQK3NhazjbvpUDZ31rMp5fFeW4B7
         6TtkLxvwLRU5ZSjIiRQ/hidvAY3HMTbKSa5+ITsLd2mcU3rCOjQUg/WkGCCugrR4RGja
         1nagJRpsWiJmEACvdZss6FPxtXY/sv6jtOoy1C3HqDAsdxRBmg3WrKEIoRPdjObsdV9K
         Fil3n56TnJtj+HIZyMsm9j0qbv99StAFFqHDoXhiqwD6JXcUQ79/5bU4O6V60ZG3s3Zs
         1GQuCC2iVaLrY/ltHaR5HgtSKRRdYDL4BfZF6Nv2fdhQTR8um+k38A3AdN0NoYli2qM2
         QBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489007; x=1729093807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+y7oelTnk6r5KXO5BIzd9TWGjZrwMN3AFTrylQnTmc=;
        b=MGKvEdYwL5ucExAKVflbJOsvW2Uj0JQ1riPJ0bQvJ/x/Ko3400TRLWSlq0zRTlpe8i
         xxdhxalOLVtccFai9mjRKsFFjZcY4H8b44m56U70a60JGVnD3hC/wWjJZlJRMxGQMPDi
         RtGhex+EeSHP4XB70Srz+5q0ouQCJ+4kueibN7Fit0ZSE+tB0iib/YL1ujoNFTE1OgeV
         lG1/yII0aypkjaXyfeWFHs7WlT7vXqW9XkcZZSqiF7a7BbAxbHbegfpKU7EtlO8SfNtw
         VeuRiGpB1eA+zpRHHkY2XFdqFQQjJuoAPKo6h3+fWC0F3eRw8B0kzLROfp/lOXiXKo5l
         l4cA==
X-Forwarded-Encrypted: i=1; AJvYcCWVL81Bw6jjJ2EwMrIug0Tof6VZ/3OKZuQc99RzvwCm4SMs6DlOBftKz7PwwCUdelaWDAbiWgwKb0S6tOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuNtO9ENPCnfevE17jx9tvPb39MjxEiDce8gD5zaPi0UrvnllV
	vPPxyggLlOxcsktbI9rywTKD8re7VWOOg/nkPQSBLt4vTPPtUowGJestt0RlW5Rz4wSAJ0/8VpI
	g7A==
X-Google-Smtp-Source: AGHT+IEnOiEr/7ufmCoIIHo0RYjnE1E6sJgU5IKNyLPqmQLuHnTee5V8zvUGQ36LhzFM/1nmzHnRUzKqVBw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4b08:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6e3220deef6mr671277b3.1.1728489007658; Wed, 09 Oct 2024
 08:50:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:45 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-7-seanjc@google.com>
Subject: [PATCH v3 06/14] KVM: selftests: Rename max_guest_memory_test to mmu_stress_test
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

Rename max_guest_memory_test to mmu_stress_test so that the name isn't
horribly misleading when future changes extend the test to verify things
like mprotect() interactions, and because the test is useful even when its
configured to populate far less than the maximum amount of guest memory.

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/Makefile                            | 2 +-
 .../kvm/{max_guest_memory_test.c => mmu_stress_test.c}          | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/kvm/{max_guest_memory_test.c => mmu_stress_test.c} (100%)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 6246d69d82d7..8c69a14dc93d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -139,7 +139,7 @@ TEST_GEN_PROGS_x86_64 += guest_print_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += kvm_page_table_test
-TEST_GEN_PROGS_x86_64 += max_guest_memory_test
+TEST_GEN_PROGS_x86_64 += mmu_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_perf_test
 TEST_GEN_PROGS_x86_64 += rseq_test
diff --git a/tools/testing/selftests/kvm/max_guest_memory_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
similarity index 100%
rename from tools/testing/selftests/kvm/max_guest_memory_test.c
rename to tools/testing/selftests/kvm/mmu_stress_test.c
-- 
2.47.0.rc0.187.ge670bccf7e-goog


