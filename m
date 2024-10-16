Return-Path: <linux-kernel+bounces-368721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57AD9A13F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C762281592
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A1B21A703;
	Wed, 16 Oct 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YoTWxlvb"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CDF219CA1
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110517; cv=none; b=WWIlxLQ42d+jnl/BP4lnA5t6Lk4qnE8n4sOKFJSWrp0rLaKrMGtAOE6hhEZ0nrzTrXhw0UjLDkcq9/p/1f5erN0x7knImqiMq+HCSw+Ld4DlhrtoIU08dXXc3khU1auX1DlC9Z0JTtCxJDYyclOm77dKgV3biw6GgL/y23ZT0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110517; c=relaxed/simple;
	bh=BsCzhPQdWowE8LOw5zBnSFi1XHB7Z9+iXM8KDjw1xGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fsxj748fjb/MjaOlqBSO94oonVVFMvm8q4mq3jMQElnC0DZCBeZPcJnBNlVP8KM8j88YvCGFrhznWhLCyHE8Lmg6qv8s4lS9tIxEAArSNZ4JoBsTnpwBBlxO+mbUqIY3w0SEx9WmSUZKzoEcc67G4J65CUHCZsVa7eobFHAARSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=YoTWxlvb; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2cc469c62so158880a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110515; x=1729715315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WI0PfAqEvWugCZ5STUUK7Rk7SGo8azDpX4lf/J5+9s=;
        b=YoTWxlvbWQ0wuT8aqiQmCAI/9aFKlFxuMC+E+kyw3n880nSLDhghfbRJkT7tP9PSnb
         +MKIOiE3YSSvJC8qFR39tF86R5DnaBM/5a3knQNCPctIg+eoWpq9FLrE/BctsQDwl3XG
         7srSpRWp6TqvGkjZabXHUiNzmeRRejx8UhZOZYhJ7olToooJvSks+gsnpb/GZvQywxvt
         4cNa+GlVzLhOHy9SeibuB/LfGWonpqZ95ziKezEzb7hsfI7rNS5rmJEQtQ8FI2gM54vh
         OyAxJYutDmlQBGGI5bsEsiJZRXXpK85CjcWC6aSBy6KUuxIf8zeYkGUSggAmcbHz44C7
         PrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110515; x=1729715315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WI0PfAqEvWugCZ5STUUK7Rk7SGo8azDpX4lf/J5+9s=;
        b=E1t+g4WA6vCWzKCu7RriAvIzlaJFUOAyRKdJt+ZmdT3F0dAKg4PdJS5l/H0My6yGS6
         nJZ2jCr1Lda6brt2uiqKAVLT+0TWT8kKGv1PW3/b+Da1uvWg8+3hm2lZjqRV/MBuqfOO
         8cvV3ibMwlMGjkntrYyCUrQJwLF7GaoGlzYZCT3bll4u2baDwiuk8F1ERNDADBqQhn+O
         qsMhXK09CwPfQijoKLv//78J24gIFweHWFaeH0zWGBXebvU4fC+k64tTf0pOlgj83jN0
         1aZEq4395hi4xIq9SH/YvNmFh7RnT3DvJScTUwdp0I/BNnOOWvgsVL7OyltIm2G1GhEj
         HqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPzXh0hIYFzYJ8kch0shcmccgTgvuPO7ie5Rv63Om5RgiLIWCExuOLOO6h58YgMKOhSRt32pm8Jt0VXkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZMOpCwwqg2c4rf+2b8YB5SW/DgeKl/5rxK4mAGv09vGUj4yp
	MTqzxPQQe3clXnmXAwdN2ofDLT24+gM21DgE3N6+4/3nZRIu8iyZyilal7NTPlg=
X-Google-Smtp-Source: AGHT+IGcSXANWUtxTrqBQY826KCMZtK9Mvi3eTSETMPgwJlkMpZfT0sjFjvzgcJsn91FjGVwM3cBqA==
X-Received: by 2002:a17:90b:802:b0:2e1:ce7b:6069 with SMTP id 98e67ed59e1d1-2e31538f1camr20096845a91.33.1729110515177;
        Wed, 16 Oct 2024 13:28:35 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:34 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 10/10] KVM: riscv: selftests: Add Smnpm and Ssnpm to get-reg-list test
Date: Wed, 16 Oct 2024 13:27:51 -0700
Message-ID: <20241016202814.4061541-11-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testing for the pointer masking extensions exposed to KVM guests.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 tools/testing/selftests/kvm/riscv/get-reg-list.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 8e34f7fa44e9..54ab484d0000 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -41,9 +41,11 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_I:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_M:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_V:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMNPM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSCOFPMF:
+	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSNPM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_SVNAPOT:
@@ -414,9 +416,11 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
 		KVM_ISA_EXT_ARR(I),
 		KVM_ISA_EXT_ARR(M),
 		KVM_ISA_EXT_ARR(V),
+		KVM_ISA_EXT_ARR(SMNPM),
 		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
 		KVM_ISA_EXT_ARR(SSCOFPMF),
+		KVM_ISA_EXT_ARR(SSNPM),
 		KVM_ISA_EXT_ARR(SSTC),
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
@@ -946,8 +950,10 @@ KVM_ISA_EXT_SUBLIST_CONFIG(aia, AIA);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_f, FP_F);
 KVM_ISA_EXT_SUBLIST_CONFIG(fp_d, FP_D);
 KVM_ISA_EXT_SIMPLE_CONFIG(h, H);
+KVM_ISA_EXT_SIMPLE_CONFIG(smnpm, SMNPM);
 KVM_ISA_EXT_SUBLIST_CONFIG(smstateen, SMSTATEEN);
 KVM_ISA_EXT_SIMPLE_CONFIG(sscofpmf, SSCOFPMF);
+KVM_ISA_EXT_SIMPLE_CONFIG(ssnpm, SSNPM);
 KVM_ISA_EXT_SIMPLE_CONFIG(sstc, SSTC);
 KVM_ISA_EXT_SIMPLE_CONFIG(svinval, SVINVAL);
 KVM_ISA_EXT_SIMPLE_CONFIG(svnapot, SVNAPOT);
@@ -1009,8 +1015,10 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&config_fp_f,
 	&config_fp_d,
 	&config_h,
+	&config_smnpm,
 	&config_smstateen,
 	&config_sscofpmf,
+	&config_ssnpm,
 	&config_sstc,
 	&config_svinval,
 	&config_svnapot,
-- 
2.45.1


