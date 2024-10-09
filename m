Return-Path: <linux-kernel+bounces-357394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5649970CC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4011C2264D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849B3204F8D;
	Wed,  9 Oct 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knLE5FfQ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B1204F66
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489022; cv=none; b=u4grrblMQBNP8ep8QNjqYToqlUXolXL1IN3AC0SZ08xxJPy9f1WWXC8ocbXKr8/8eyPytJRjCE9yO4GCPAmnb4cfRvNEKsSTamMZLug0kKUD0Po8wUAJ4ske6LFeyGgqWSHhGe1BBkEeFPkSoD/GFvsPWiuifq6ozFwVQh5euLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489022; c=relaxed/simple;
	bh=ySYmz6+XDdTBZKIHQpIWEkeL65GnrCL3nDWRuqk8AHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NTWJEU0gmvuHaue362Z75/Eu0tz1fcTbFlwj29hwTQ/iLNDbJqXGme42RtYoJrGfv7jzIiJn+snpyP1v1whKfetvk/tapXjpv2CzGcjfWde6pE0ippZH5bh8FnHPbAxwAUzMQvuIIIJl2pWJjfw3yaOLnwyrbx6dGZGsZIPec0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knLE5FfQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cc76cae1so1375502276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489019; x=1729093819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IpGlLPpdKIlhRCfJQtftwzWlWOxZ3g0ZRZhoTsEcT4I=;
        b=knLE5FfQmeSTB7xMcSplj1mP74VJ5UFP8UfVhbVUJ8rBuIBMXJj3WqSuOX3HoVtZvE
         B0WFiRXWtzZ96ejyKsV9QtaDO1upWXTsXDangHzQDFDQWbNdfs1UVkIcuvBZEn7U8uZ7
         O1p5UEhXn/QCXdYPYNG0hYq0iSwgCXL8JwvDQ/FgvWCK9Etz6xlaS7NbXos4hf6gepew
         E1dUStsKLx2pt+D4WsXAxycW0IghnAR7tOxHIPWw76FzW6UwJMOCQfVqlGzYIpAwOGEI
         qJcfS5lRwCuLRLJorEfQMS00IsqfCkCrQaH5DhU0Exchs7U7cP/kfpJnG4fJJpnmHPe5
         bEuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489019; x=1729093819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IpGlLPpdKIlhRCfJQtftwzWlWOxZ3g0ZRZhoTsEcT4I=;
        b=cIV1o9+z47DtBsiO9EwERkISk+zfO/RMereZi30T1183/HOuFd4m0MAgFHy/H5VjK0
         zjLA+HTv8smZAgVESCFTSDFerpyolNscPeiICKi0LH8gU46QqmgSnJyH9jA5JHqL3Ib4
         pKdY5hvsC6eLBN9sXThcMBzRuZjFq7opWfhf7A+YrOFhyxNBrQC9xMBJJ3RB6cHTJQYN
         A0r9LJuZzEZ9NBgUWBeArWXjgfOGz6o3BBuH8OAcV6hZ/wRV1HmkpLV2fFD+/+IITohz
         w70T4LdXTg90yoPCC6m7dcXOUzcVsVb+gPCZe6o3DnjdZKqy0XovSI43FV0QBVxZ84xx
         vNxw==
X-Forwarded-Encrypted: i=1; AJvYcCVCH3U54M3N8tuPi1o7PpUBj41aFG593IeB+lHMn5Q3+aWwa305xIj7OmsRiy6qxC6jn1x8unuZeeoxZKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKbz8txqvpu9zACbxnZcxxI2NI2nO2Hha9WDmVItycOURTywi3
	drVq/bBVmY2wPJ1XQWGWpvIUQtz0v0WbrLctXWAfugYZNnVVlkJfHpez3Pfz0fQ4z73bijtiqm9
	0Eg==
X-Google-Smtp-Source: AGHT+IHJrTSljEGX+w+vGWljsF6J67uTWXS92qMmyHsTMzVm3HG9JVjkOOVhTNIgejhJpa5nZzlmmTlBPQo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:8248:0:b0:e28:e97f:5397 with SMTP id
 3f1490d57ef6-e290b7ec5bdmr51276.3.1728489018761; Wed, 09 Oct 2024 08:50:18
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:50 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-12-seanjc@google.com>
Subject: [PATCH v3 11/14] KVM: selftests: Use vcpu_arch_put_guest() in mmu_stress_test
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

Use vcpu_arch_put_guest() to write memory from the guest in
mmu_stress_test as an easy way to provide a bit of extra coverage.

Reviewed-by: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index fbb693428a82..656a837c7f49 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -23,7 +23,7 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 
 	for (;;) {
 		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
-			*((volatile uint64_t *)gpa) = gpa;
+			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
 		GUEST_SYNC(0);
 	}
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


