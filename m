Return-Path: <linux-kernel+bounces-414940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595BF9D2F80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4808B26375
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC521D9A66;
	Tue, 19 Nov 2024 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ayez7NoG"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD71D7E5F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048260; cv=none; b=r7Hb6+MZ5e0hQ1I9ZbR0uKeawckdrji7mzKNhf2bkBHxkc4W+fmd6bZXRLld13OcaypU72+4QD54qqqmVgi8Vj6I8R84U5uex767mducOaaitdAdQfln/YjL+wRlrKvA7HMIwdKCpXKX8osCJUKXxxn67z/FZFCpOsSMN4UKu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048260; c=relaxed/simple;
	bh=I61ANzW3mMGNw+TsEklnF5HMFHS9Ft60jqTehlaG7hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pq43GY1NmFRY9KGKdTjNzyy0MM8BGLnRqrbuiBA6qgWHs7LPSbMwnTbpID6CIXey/UoyHiBWvrbSL5UMFOnvbDpYeSGG2fP3+5DErHrKgJXyXBtS8w/gSXKlGPLkIOFEskcAu4mvxO0YqXRytJ/mIzafAV24PLI75tAxz5arddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ayez7NoG; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-212008b0d6eso29111065ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732048258; x=1732653058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oS1moOcp9ct9rXCWQSjf/GhpQtGR0rWY3wjXVfG0zao=;
        b=Ayez7NoGQMC9UcHgiyewYOdCCbHkBpWpfNnPlD4oJkCVCqo6aySmmHdCUC+kj0dNYv
         IT/9SpjthbtWdrsPnBv1kpHKQeEO1GlcUJlTUY0mRFcLJjE6btuC2l7iQ5F/QxMKAlKv
         o/APu6wZLBpE2CcFYmkWxJ1EIUKEfTV0Dpmx8j5RI+TfkV0Ppd2ff8JdVxnLTAg52pGG
         BThnI/HKmh7yfhWwZdp80HJa5GomB1DcdtWtrhop40ItRulHCA/PMh7rfhq9k/Y4l9CX
         PdcxIX2SgwN1c+wjEgGlqXMKbfX1hyik0ZyBqu/rE51dgQeHOIECbN1dVeMnp/woa7DF
         5aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732048258; x=1732653058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oS1moOcp9ct9rXCWQSjf/GhpQtGR0rWY3wjXVfG0zao=;
        b=oZsiMBz/IGqp9lSexaRE6W44F9qqDp2c7tp3OR/Gm64lJS3sJ4mdoYYNrEBibyNECC
         f6ffTx/PdATYDmd78OWL+tvjnBfhgGZpPb7mGHXM+QPDnEzJd8frX829OnggVZbmIZCo
         VXKrO6QbRplT0isCBd90D1BUY3GeVjt5GL/ajkpDV1FjGqTEeQZH4RTXjpgzINopa+iq
         Lq9giUjl77AAoueGR85sv9kb9sqqnJBaogFRT9zBwW9iBjYajzQOr7U3tV5zU0WsMXiU
         NFYbVjnmvJFORfiU+j6zGqrMNRgL1U+J6I5OXpzIJG6n/OQTcd81VNZVf/E9kT3wlYpW
         heeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW2ttfLLUkTVf4XAk3bCwk8fpLTWnRj/PuGe5knD2xB1l4evRZsU06rnAPhIc9s3IkYVwrorP5Cylgw+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2BksQOfEezoD3YJa5e5PW9sbswWeLzA0t+Rv0Ia2AWGPezvY
	guGEv7Rs+vUbEMG6XTcTfh81nUveB8kjZfgc1SGpJ9c4W+JTCSvY5luibuDV0r4=
X-Google-Smtp-Source: AGHT+IHJJKUj/G9a1vcUatY4x43+GcKI1AsZDcQ+KjFbu3ubgI0Q6fpviZE7gWtG38yqh7oUq4m8sw==
X-Received: by 2002:a17:902:dad0:b0:20b:7210:5859 with SMTP id d9443c01a7336-2126b07a574mr1668385ad.38.1732048257883;
        Tue, 19 Nov 2024 12:30:57 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f34f2fsm79001315ad.159.2024.11.19.12.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:30:57 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Tue, 19 Nov 2024 12:29:56 -0800
Subject: [PATCH 8/8] RISC-V: KVM: Upgrade the supported SBI version to 3.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-pmu_event_info-v1-8-a4f9691421f8@rivosinc.com>
References: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
In-Reply-To: <20241119-pmu_event_info-v1-0-a4f9691421f8@rivosinc.com>
To: Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

Upgrade the SBI version to v3.0 so that corresponding features
can be enabled in the guest.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_vcpu_sbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/kvm_vcpu_sbi.h b/arch/riscv/include/asm/kvm_vcpu_sbi.h
index b96705258cf9..239457b864d7 100644
--- a/arch/riscv/include/asm/kvm_vcpu_sbi.h
+++ b/arch/riscv/include/asm/kvm_vcpu_sbi.h
@@ -11,7 +11,7 @@
 
 #define KVM_SBI_IMPID 3
 
-#define KVM_SBI_VERSION_MAJOR 2
+#define KVM_SBI_VERSION_MAJOR 3
 #define KVM_SBI_VERSION_MINOR 0
 
 enum kvm_riscv_sbi_ext_status {

-- 
2.34.1


