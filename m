Return-Path: <linux-kernel+bounces-534893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB6A46C59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C3F188D552
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7745B2580F4;
	Wed, 26 Feb 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f5A/MGIS"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC972745E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601514; cv=none; b=laIXe+9DGQHfctc7mSKEL2wz+NoOf5mb9LO+KlY2JxlPL90vbSNNcMxOYBFh4MkaSzFbrofR9WrNqzti6j7sY9ahFUZ2Ed8WLRQMO6pHG7U22tFLov6A6CLooVjCiaXYZfuZPUsXA11HiS2E06UWneQiVKOR077RHRJWO80uU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601514; c=relaxed/simple;
	bh=QBL/O8yP4cmvHwkIXxg+UQn9RcAHq1y3i0H/8OMhFUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HoptCsqPjuY0sJ+/iqifTiU9N/5a9mg8fupChy2U53ks/e+8zQAb8rg4q+H559G7OuPLxXpOsTHO/9q9Ic+j9KhfX6YBO7hl9xDaB3anW8FwFa9ptCr1VpGWQaiM2sZBKC2XXbWzOLQmRwbmZyqu6Z6sYhGnCsGCVPqxbujdEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f5A/MGIS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2232b12cd36so2457975ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740601512; x=1741206312; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElQVVHGvy1PCJJEf3x7O3Wq4GDtnkpov0IINkskU+dk=;
        b=f5A/MGISzjFSrplNEjJKnl/3POUBYwbI696oW9ISqocm+RF1moBEyuauSmL798Jm2B
         MaIDz2DygXuvQ5sxD+ZRUZZHl9d/hR2lirJHDU0rRb99bRnu/8zoxv0s2B8tAMeHldtO
         R3RYksblxEoXwgRvEEmnjpJmfcgrrM2fHD3r8u9ZI4E3lw4ODDkJf8AjZZA2oasdM6HH
         9cm7j/eWlYrpPviN77cd2OWi8gvte12UeduYszP5VcEsBCN2hGRo4NiO8h4Ff9cbQJ3w
         OC5pUMOpSoypJBBFsQMrB+a+5TcCUcNQjE5s4vMtbb6NjFpHxOT62uYrfI6RHUrHSS+r
         g6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601512; x=1741206312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElQVVHGvy1PCJJEf3x7O3Wq4GDtnkpov0IINkskU+dk=;
        b=s+L/bBaXu6M8y7h23j8zPkYZ8+1Alnv4lW6v5onVNLaO37yFqEoydbcpYYRnnqzIiP
         Z4UuEuB3NV4EU2MxOlTZl0BxgcGOwgHNY3P/lvH+xDhAO7RMRYMqsarartpry0s/9KaB
         A5zI6niQGNYzshnlb3IGuNqZNhWM1ZfxJWnxstP6ghtHxwOnsfXSKXFCCq+jfn8RBqX4
         Xa2kk3qdAeQ0GqAPKrxRCDZ8urK3uorHDdvrjUk7Y/1emc2qgKUjb9tj95gRMVKVq91F
         dAm9zveBIkRz+ZEcGCALASe42h5zbDB6blrB8gmCa9VIlB/8nieamvxAvVtPKAsQxg45
         /EsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKGtKnobu84eW39F7lppJOJIR3/7CVWom4B60Ic8RepUZ32msRA+kyoezEeWktzWnt5q1Iu80H8dDQqZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PTS8eFPjaJWGcWHWLSUc1rnloxYK2fykEG69k7/wkc5Hcl/m
	KlHpSgXXqRI/HyJ2M0PXj/5ho/Z/v0QNnla+hJ8nOXQ8kmBWUNvOXhah4xCYNn8=
X-Gm-Gg: ASbGnctR1S+va5g81AJRj83Ls2cJNEOgB9SiELjdi/HatRd6kmiuw5UOtCRPR2wsTHe
	+eQe202JngN8bjOWymEyBz/LikAH1+yWcjZTgN/cKZ8NkjG3hxPnGrEloKqfMuM0JQojhbiTI0z
	eIjqvIhZQSwpNuECjx7QyLSF0KmrjVqZy4Kv2fSap6xa5ER1Wzl8+3yQ1pGSxR07s9jSotBb9Ob
	XeEE/JkfnjTJGD6Np5XnctAiWhlIPHtmElQJmiHAmX9a7b7oLH6U97o6XdBJCSe62y9fVPC6I9a
	JCX9PzLtsz49b+H9pMeMoUZWCcejSH6XnCyot78=
X-Google-Smtp-Source: AGHT+IFqbgodjU8bkbuDJlr/kSmLoWQ/SEWprjRdiuzVEUOwMd31NiSuNQgBjPeic2eXnfkR3SMW9w==
X-Received: by 2002:a05:6a00:a1e:b0:732:22e3:7de6 with SMTP id d2e1a72fcca58-7348be4650cmr6595071b3a.17.1740601512524;
        Wed, 26 Feb 2025 12:25:12 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f7de2sm4100963b3a.106.2025.02.26.12.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:25:12 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 26 Feb 2025 12:25:04 -0800
Subject: [PATCH 2/4] KVM: riscv: selftests: Do not start the counter in the
 overflow handler
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-kvm_pmu_improve-v1-2-74c058c2bf6d@rivosinc.com>
References: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
In-Reply-To: <20250226-kvm_pmu_improve-v1-0-74c058c2bf6d@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Jones <ajones@ventanamicro.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

There is no need to start the counter in the overflow handler as we
intend to trigger precise number of LCOFI interrupts through these
tests. The overflow irq handler has already stopped the counter. As
a result, the stop call from the test function may return already
supported error which is fine as well.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/testing/selftests/kvm/riscv/sbi_pmu_test.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
index f45c0ecc902d..284bc80193bd 100644
--- a/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
+++ b/tools/testing/selftests/kvm/riscv/sbi_pmu_test.c
@@ -118,8 +118,8 @@ static void stop_counter(unsigned long counter, unsigned long stop_flags)
 
 	ret = sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_STOP, counter, 1, stop_flags,
 			0, 0, 0);
-	__GUEST_ASSERT(ret.error == 0, "Unable to stop counter %ld error %ld\n",
-			       counter, ret.error);
+	__GUEST_ASSERT(ret.error == 0 || ret.error == SBI_ERR_ALREADY_STOPPED,
+		       "Unable to stop counter %ld error %ld\n", counter, ret.error);
 }
 
 static void guest_illegal_exception_handler(struct ex_regs *regs)
@@ -137,7 +137,6 @@ static void guest_irq_handler(struct ex_regs *regs)
 	unsigned int irq_num = regs->cause & ~CAUSE_IRQ_FLAG;
 	struct riscv_pmu_snapshot_data *snapshot_data = snapshot_gva;
 	unsigned long overflown_mask;
-	unsigned long counter_val = 0;
 
 	/* Validate that we are in the correct irq handler */
 	GUEST_ASSERT_EQ(irq_num, IRQ_PMU_OVF);
@@ -151,10 +150,6 @@ static void guest_irq_handler(struct ex_regs *regs)
 	GUEST_ASSERT(overflown_mask & 0x01);
 
 	WRITE_ONCE(vcpu_shared_irq_count, vcpu_shared_irq_count+1);
-
-	counter_val = READ_ONCE(snapshot_data->ctr_values[0]);
-	/* Now start the counter to mimick the real driver behavior */
-	start_counter(counter_in_use, SBI_PMU_START_FLAG_SET_INIT_VALUE, counter_val);
 }
 
 static unsigned long get_counter_index(unsigned long cbase, unsigned long cmask,

-- 
2.43.0


