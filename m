Return-Path: <linux-kernel+bounces-424091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BC9DB085
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CA328214A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0EE14D2A0;
	Thu, 28 Nov 2024 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOTKb+Ub"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D914A0A8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732755373; cv=none; b=fCrGIsLUOJSExYwTR+MZMKoHWbstvItQtgz1RhshUUQwA2JuiBotfifjYz2hMVdS9ruZmG5chKUCKzP1yYR2pjECr+FhLJJIb3KXpIIh4ssmi8bSxtEk9EgbG7gJo/YftoIn7wn2rOOwJoA5eiWN89zfxT+S2sGljMVhPU6EKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732755373; c=relaxed/simple;
	bh=Pl/WDPJJFpEGoonemEpYTO8CqOvLteUalaJutLV+GEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=juz5h5sdYeUmerYkCLngDPqRoDbVmdRetSUgCTHN+CpSAq2D4CLagBvCa0ztdzLTv+YDEhDdaElebt0bBE0W4yXf1WLeOx5g4sIDEx7E9P5NSOPIJaOu9Vrv/goVMNhZfE9UveVTyAzP1i0/1Bc6WvI3HNmcEQ7L9wDey9TXlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOTKb+Ub; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-211fcbd2325so3222935ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732755371; x=1733360171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GWRtxUB7qEaUtLrlQ1xtfEnMmWvmcI3LuUmySZ8Q/Js=;
        b=uOTKb+UbcxVat1BTRDF5V9ggbfjlmpZ0OBVaMazd8wdph/IHUqaD65LuoEHySoEVmD
         1Hc5XTV2zhKDb2W9Sz/Cw9PeFAda/JDYOIIJwiS77sjbrWaq9OLblfy5j11AItqzCtal
         fpEx9tRnIcoa9PvLvyl25Om6Z6SmFqvKJnTpijJGSzIsuiazlNRwSmd1G/5z9Jvr7sOC
         NnboAYNkvkBFwkHZqaSW0zUMmUyzVmsj+Z+v0ZexOdIwIYARvbyumwDONvNJuIS2l3PQ
         ekFCmtBD5mb0wLtKLBXUuDmeVzbO41PTGqvl6DsNDb8DH8ce0SLk9Qv8BnDFoGYgQLzC
         nGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732755371; x=1733360171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWRtxUB7qEaUtLrlQ1xtfEnMmWvmcI3LuUmySZ8Q/Js=;
        b=XpnJ9x4eZUABnFwxwsrOLhecQLzMuJkuKyB6f3/r2YTQLD1fvSFWBRUat9xXD47//x
         ppeJhsCSWunvyUviRBzeAQJUwFHrurKXvYCuhDNXJi/eH04qdPAo4KvISFgJWJTJI3tl
         cpK9FbtEAwx2bz0MBKXCFBq1hDjXbN7bgGU+TB5cHQJb1hmi78if3LKKED/1RaeWx7cI
         o7OUEH0ZVqnHtSGZm5RScm1FFane+O+HCmM/oKIby583+1mCqnsn5EVkNsdWWPRLqhlL
         X80yJC62gZPC6vR3gB+1iSNI11Nu3MnTB2zv25Msq3awhMpz3pp4Wjrwo1vRRb134d8D
         ZJmg==
X-Forwarded-Encrypted: i=1; AJvYcCWr4NFYHBXhnRYAg4Kr9qX4gvJS8LP9Njt4liTwXepyIVN9KQiqd7eJagfWE1/TB7oZDyko2LOMOSjLWqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIsn2ecC1apGm6LYaZzPILSji4kW/1HxQQS9MXm4FDAxDfK8x6
	Zs4kovbaNWasRS0zyNp4jWkSvRtCtD1q9M0G99d44KWHYa0A9ARnyLHyuOWHbNAq3ct36N2KgpU
	+mA==
X-Google-Smtp-Source: AGHT+IFMaJnuqI9F/c4uFlh6+NRFxIyg9v4WX4blDwY4PB6trx1cbKx2cypM7Azi46JxvUwmbV0z2d3j/+0=
X-Received: from pjbqd8.prod.google.com ([2002:a17:90b:3cc8:b0:2ea:7fd8:9dca])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0d:b0:2eb:140d:f6df
 with SMTP id 98e67ed59e1d1-2ee08e9bd21mr6479606a91.1.1732755370916; Wed, 27
 Nov 2024 16:56:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:55:43 -0800
In-Reply-To: <20241128005547.4077116-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128005547.4077116-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128005547.4077116-13-seanjc@google.com>
Subject: [PATCH v4 12/16] KVM: selftests: Add a read-only mprotect() phase to mmu_stress_test
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

Add a third phase of mmu_stress_test to verify that mprotect()ing guest
memory to make it read-only doesn't cause explosions, e.g. to verify KVM
correctly handles the resulting mmu_notifier invalidations.

Reviewed-by: James Houghton <jthoughton@google.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 22 +++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index c6bf18cb7c89..0918fade9267 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -28,6 +28,10 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 		GUEST_SYNC(i);
 	}
 
+	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+		*((volatile uint64_t *)gpa);
+	GUEST_SYNC(2);
+
 	GUEST_ASSERT(0);
 }
 
@@ -95,6 +99,10 @@ static void *vcpu_worker(void *data)
 	run_vcpu(vcpu, 1);
 	rendezvous_with_boss();
 
+	/* Stage 2, read all of guest memory, which is now read-only. */
+	run_vcpu(vcpu, 2);
+	rendezvous_with_boss();
+
 	return NULL;
 }
 
@@ -175,7 +183,7 @@ int main(int argc, char *argv[])
 	const uint64_t start_gpa = SZ_4G;
 	const int first_slot = 1;
 
-	struct timespec time_start, time_run1, time_reset, time_run2;
+	struct timespec time_start, time_run1, time_reset, time_run2, time_ro;
 	uint64_t max_gpa, gpa, slot_size, max_mem, i;
 	int max_slots, slot, opt, fd;
 	bool hugepages = false;
@@ -279,14 +287,20 @@ int main(int argc, char *argv[])
 	rendezvous_with_vcpus(&time_reset, "reset");
 	rendezvous_with_vcpus(&time_run2, "run 2");
 
+	mprotect(mem, slot_size, PROT_READ);
+	rendezvous_with_vcpus(&time_ro, "mprotect RO");
+
+	time_ro    = timespec_sub(time_ro,     time_run2);
 	time_run2  = timespec_sub(time_run2,   time_reset);
-	time_reset = timespec_sub(time_reset, time_run1);
+	time_reset = timespec_sub(time_reset,  time_run1);
 	time_run1  = timespec_sub(time_run1,   time_start);
 
-	pr_info("run1 = %ld.%.9lds, reset = %ld.%.9lds, run2 =  %ld.%.9lds\n",
+	pr_info("run1 = %ld.%.9lds, reset = %ld.%.9lds, run2 = %ld.%.9lds, "
+		"ro = %ld.%.9lds\n",
 		time_run1.tv_sec, time_run1.tv_nsec,
 		time_reset.tv_sec, time_reset.tv_nsec,
-		time_run2.tv_sec, time_run2.tv_nsec);
+		time_run2.tv_sec, time_run2.tv_nsec,
+		time_ro.tv_sec, time_ro.tv_nsec);
 
 	/*
 	 * Delete even numbered slots (arbitrary) and unmap the first half of
-- 
2.47.0.338.g60cca15819-goog


