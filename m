Return-Path: <linux-kernel+bounces-357390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE969970C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6CB2352B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9682038C5;
	Wed,  9 Oct 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnSDfYS5"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EE202F8E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489011; cv=none; b=r9L8SvTSXxVG0x8FaMvf/i9MUwyyZN+Dsdk/d2Xn7bK9HTAcBFPLn5wMwd6oESC9Qt/N+c3omLgI1cVLZjnmjP06c9DNvxqQhaUJ10RJocoRfbV0+vrrynAh1rWpt+8D2wujKqHzcRTvyq1ZqJNglSf4fzyJ82aqNgke8rvQNBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489011; c=relaxed/simple;
	bh=iJgiAVVkswthc5+5Sg734uhrpe9cCqrlEjv/8yEej0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CtQPP+GJ4VXnaNm/yAbUAq4Unytfv77wGegOvTrx04nZfUx+wbA2VzuZFwU6ueaMbiHlbIUMRnhmWpi9oKTORYnsb1cv2dKbBZqgoAvBS8nN8AKOAF0sOH57foEcUXUGfD4ZnbR6UsA7HI7/0CGSfA0tFpSOD/PXzbEGJc9ym4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnSDfYS5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e251ba2243so15556197b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489009; x=1729093809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mkSNDDdTvmOytZei+cHiV7cpe/wxQK6hsvQ24y9wIjk=;
        b=fnSDfYS5iKalBfRgLhSpGhQWtvNUH11/UhY8QMNsbYym7XT99Yrnn9mrQX3riHWc/P
         UI3GJRwt3uEJgL+A3DpzeAKkyPosHfBmmyhE/7fpu0GzgV/oTBwXSFkdgbOOiA3ab+3B
         uC0+3LGzDIwwU7aWDf0ibuuOXNv++AVSH4EK72+ql0rzDe5D5Tc89nxcJbOExXHLES12
         yXrCloidBZprENpMLCEZW6yAL/lWLpL1OFmck//KPytksB0QHzpBFLXBXxeB0EdMntU9
         9lTjVam33Az+4d6I6KBEKvZprvVQZeMiA8q4kb5Ze3EWNuk//mF0gzKSMyhUbsmzSXGd
         kcbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489009; x=1729093809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mkSNDDdTvmOytZei+cHiV7cpe/wxQK6hsvQ24y9wIjk=;
        b=CWxx+9z6btJwYzX4IaBdSo07D5urMarhtVMGnRNUNtdILCrmm7yD98AOdHrI77G9/u
         2n37cZmgeZxgQoB9hYon+aufgwL4E8SR92zxnkci0mWzWZP5ylQpsxdTl4MpsIeMtEtu
         DIinypSFrWz8eBA/NQ+p2iX/4nUMW1yGiKLO5k25wzoMYHJ5zY1ye/NTxriph8mz8keF
         XG0V5SGNY8RXGju9DqBcvBCnNxcpEsQxzz2mjAEYvjnw2TPhrKv4+ZoIJlA8vtgMYq7v
         rgN9JGW26V3OeDbhKmwQJHIeBA2YQRcpOmJJnuNfyQ7xNTVJ16FrFR5mKssLzV28GsVm
         sc0g==
X-Forwarded-Encrypted: i=1; AJvYcCUl3HCSWrUv0AztXsOfQgE1edwVQm359JH5KBFcJ1DZpKSKTNYw1k2p+ACup8N33sFq3EbnW4tbZiTXEFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG303500hps7x2bXyzb7vUsyRtv7scnID3hMbAyRqBbVZ009hX
	cLZHNHO253rrKfvjrxB8OlBmKWlyGCXfWWn0g2uXn0vha88hOxf3Rl3NQ7rtDsGK2sfwXM4N0P4
	mZQ==
X-Google-Smtp-Source: AGHT+IE+D7P5FL0ahoVlcq9P7kEER6bVqpKARxPS0zk7xyFxuVv8bFBUXfQ/Ook8UnSyIIw/scGTO80UaRk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4706:b0:6e2:a355:7b5c with SMTP id
 00721157ae682-6e32f33bf7emr177b3.5.1728489009508; Wed, 09 Oct 2024 08:50:09
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:46 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-8-seanjc@google.com>
Subject: [PATCH v3 07/14] KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
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

Try to get/set SREGS in mmu_stress_test only when running on x86, as the
ioctls are supported only by x86 and PPC, and the latter doesn't yet
support KVM selftests.

Reviewed-by: James Houghton <jthoughton@google.com>
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
2.47.0.rc0.187.ge670bccf7e-goog


