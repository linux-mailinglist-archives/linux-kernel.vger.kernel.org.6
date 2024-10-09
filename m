Return-Path: <linux-kernel+bounces-357392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8D29970C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BC11F212E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E32040AB;
	Wed,  9 Oct 2024 15:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuXSEu6i"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11020408B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489015; cv=none; b=Nil4oXRMRT64e2ORYZkqU/ltu4pkAwfQswRCWzur5Nkc8Vozg+fyz6Kgblack+z5rV6527dXsZltDI680rRqEJ5Jvt8cfI4WSli/WxH76pl/dy+uPjcksW0CklrDJP6PQD0egBJxbQ1CLI0pRnT279hRdR3I8jysgxGvmP+Ozak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489015; c=relaxed/simple;
	bh=n7uJjw0M+CvpEDCyIwANzPoenH4vXh1rKtEVamrxwhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sj0NVSTm3rvy+jlyFFUhHnPCd2d/JBblt2bsa//vXpaZ5bMzJUiPdpdBRvCGkt/0VSrlk+ZsaAWv+X2RTufL0Jz5jdVhMggaYYnLq1qnH2e2G74M4YBZL2LHKeLr7ESry427A1mjtAQTV2QM6HCQDcmzl/QVZFbvdf26ln8hq4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuXSEu6i; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e251ba2243so15557117b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489014; x=1729093814; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pKnU0Kp/o5z6vCl+SnuNv4XsTANtPNd0KXgSeGLrrD0=;
        b=XuXSEu6ilNt3ZE0hwR4wttyKQThAE6OvDhRnZ7B14HahxekMpOIqkR4BwQ9I81YF79
         HRWtmVnbrr5XxsDzpB/hSnGb8gR5/ZE7y/RDXSJorKrBIdj1zQHNm6P/BMq2b07+w4CG
         hoCHwgunZIEcSqd1gbsc1sLq4iYNm+jL6kSA8wR8Uk9mxPGUjBrIi/Xx3vo/aQiuStMU
         IBY+9yMyv8ipXQEJml6EkuBXPomiqqno6d1+EUyWEkHiDh0ShOWH9wDQbQr7DgnBkVjH
         mPhKfyUzWkirJCzB5R77pen2Ei/vjlb7bLH3vMCGH0FiyTztRgY/xep2pn/CmHqtygD8
         xMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489014; x=1729093814;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKnU0Kp/o5z6vCl+SnuNv4XsTANtPNd0KXgSeGLrrD0=;
        b=wdTx9e6P2xacS5Ybs18m1bTKFDa3GgzJeUx2C8Y+V5+u89RAtfVpQj3DYJdPC4R13s
         +fiohv4pqxW8doOEtksH+OXBOfncET1pSXfQ5JrvFA3qfu5KjufUHnusPYXg1vUw9Xol
         9JLsrwQbNMR/KNnHDbP/LqI1pNc4tM+RfuYxWI9qLScVquFU2UbrfSlep94UOdX49nT3
         HGjEUe1+zT2q/AiV+WFEGnpETqsCt+GHhc0WpA/FpS+KSmL87mDbhgYt14e96JguHUpE
         OZZfgePXhkW8+Tj7GGaW7QEom/vMJ44ID1t9bD8VPWSw2S84YO7ADqdZC1hkl8LEftwG
         +RWA==
X-Forwarded-Encrypted: i=1; AJvYcCW+HTn0eyDMQtr/E0G5lbFhmErTbo53RkBSuCY2SPPlvK5yWf3E+YoJvHiGpgFaicE8QbsgaaGifeXNvfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADDQvCwKiGA3QcdkisfNUa7465MIaaLRlDi1+DF9hTy94UwZe
	PbdP4L9LIUMWbU4sakylV+ECU/VypwHEJukx9HHKeGELz3mF1KK/LxM7WpChNrgBKxUa2Z4ZnJq
	TJg==
X-Google-Smtp-Source: AGHT+IFl4KKTDXOPETiRWWIkjcYQuDw12IfhMjxBQcTnANGnaD3TD9lTchjjvx4T5v8klQyshc757dwsFY8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2b86:b0:68e:8de6:617c with SMTP id
 00721157ae682-6e32f279e6fmr2237b3.5.1728489013701; Wed, 09 Oct 2024 08:50:13
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:48 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-10-seanjc@google.com>
Subject: [PATCH v3 09/14] KVM: sefltests: Explicitly include ucall_common.h in mmu_stress_test.c
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

Explicitly include ucall_common.h in the MMU stress test, as unlike arm64
and x86-64, RISC-V doesn't include ucall_common.h in its processor.h, i.e.
this will allow enabling the test on RISC-V.

Reported-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 5467b12f5903..fbb693428a82 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -15,6 +15,7 @@
 #include "test_util.h"
 #include "guest_modes.h"
 #include "processor.h"
+#include "ucall_common.h"
 
 static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
-- 
2.47.0.rc0.187.ge670bccf7e-goog


