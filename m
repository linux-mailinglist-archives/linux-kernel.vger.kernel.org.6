Return-Path: <linux-kernel+bounces-200639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0714D8FB2CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385E21C26367
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB6114658B;
	Tue,  4 Jun 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="00ZnnNIt"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEB149C67
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505286; cv=none; b=YKZew3uBmT4vvhT70LlI3jkMXWhjmmE8eDKleD+GKo0FQa5e66qz5sv2k6hk32WCYGAK96S50S+FQcxUo2Dr23D5CDTSePSfGB+tklKfD71mYUolJkMINCvCNQ02RXkTJb6Q6osSRqysxyNJdnQznkyWH+uNt1uyB1BxsQ6xEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505286; c=relaxed/simple;
	bh=ZohCCwLLKDWdWTtROOn+XtuALbMR8Hmvwe3YoT+NpEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGL8mNNMfgXZKAfykvHNyoOjispbdq7osu7B878jMjMb10m9qIDSCj48oar8kzU5AeNRQzN5vnn80DLR5asWl3+BalMxEBoNXtD5BRfsUs9QwOuuWiQVTJJN/tTLNtzvZCQ9Tc8UsUE5JnwH3PyVpSV0OtyF/NftawLI5mOfduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=00ZnnNIt; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-64ecc2f111dso648737a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717505284; x=1718110084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs55v193sdHVl0rBHs/P2Y++ez1UXnaq9pE10ZEsFSw=;
        b=00ZnnNItS/Pw+S6qBsfKb/toNYH3b2xRDcbYdOIUbiMEJeQoMgKR3aN6zsT0Q2oX+5
         ooXYunPbsuk0Ux+K+21ifbQQOQ9P8ujK4wBpZ8eMFikF7rEj1zDX0dKVcCVktgP2cyJP
         qcyDizhg5ZH+sZG6PjLfp9pYucx0lAQS+f+yXFxvX5T6lRdUF6roW4pPUtIUfJAoXvbw
         riNhuff4DLt+q27QLpUp3hsGJR2FaXx1Aev8WxN7IDlVYVcGXKok6WFP90T+FbeOpnAG
         bsyvmbrsk262K0HdbvCM/LG2P9tUZMC7sIIacs2IYs9J8czQVndy9zh2EKWpD5s7jHh+
         XCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717505284; x=1718110084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs55v193sdHVl0rBHs/P2Y++ez1UXnaq9pE10ZEsFSw=;
        b=J9jy7Gft0Ed2oLs1x5k+sEGkTNB8hu8AXYpc2lrwAFdMDDg0lr3XA2qURdMedMTZo7
         ippXH1CQYpjbT0hD989alBxPfPGpPsOhkRohJvvi4IV1785iaexYLTlzCIz0qZKFNExK
         7f7/5VFLymVpL8vgZcSgVTpU6OB8tSUKoG8c479wUPx895IyK0Y42s1ZoZq5GvsASx65
         7fQ/u5gu9rsyH8kwswnbsHFCsda8euyABP/NY5+6o9ePp7+n2IWGLGqyMIzS1DiPCxIc
         RpDXDTts4ZZXWpGNIq07Q0PsOFJkV9yb690lHJRAMNqiiZxSiIMUkg3LZXjDYZ63oAZX
         O61Q==
X-Forwarded-Encrypted: i=1; AJvYcCW233HKLQve6WicpZ/LPpZQAqgkTXCwed/lahEsXtCig8MjGbnurkXd23YZWF0Bc1umvGqkM0AAKd5pO6Kb4obHV01Bq1lmtePaaa9H
X-Gm-Message-State: AOJu0YzoITCxEYuf6c55Nb7QigGM0Ee+CaePi33AdpnIRfFB5TiiVsoy
	mxPKCZ0CBgY/vPn+6x1Ykavyr+zNjkSfGZIB0EjwuF3Lu00TVr9BCl3d4esM41s=
X-Google-Smtp-Source: AGHT+IEsMZJmc0GRfwnGJXawzgQpJTLYGNhY37MgDtgsSTzGDBp6EPH/FvyBY3q5m6FyKXNVAkhfqw==
X-Received: by 2002:a05:6a21:99a6:b0:1af:a4a5:a26a with SMTP id adf61e73a8af0-1b26f0f25c3mr13691235637.1.1717505284134;
        Tue, 04 Jun 2024 05:48:04 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:327b:5ba3:8154:37ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ebc69sm83042885ad.211.2024.06.04.05.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:48:03 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 10/16] RISC-V: KVM: Allow Zca, Zcf, Zcd and Zcb extensions for Guest/VM
Date: Tue,  4 Jun 2024 14:45:42 +0200
Message-ID: <20240604124550.3214710-11-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604124550.3214710-1-cleger@rivosinc.com>
References: <20240604124550.3214710-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the KVM ISA extension ONE_REG interface to allow KVM user space
to detect and enable Zca, Zcf, Zcd and Zcb extensions for Guest/VM.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/uapi/asm/kvm.h | 4 ++++
 arch/riscv/kvm/vcpu_onereg.c      | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index db482ef0ae1e..71b17a6799e6 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -169,6 +169,10 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZACAS,
 	KVM_RISCV_ISA_EXT_SSCOFPMF,
 	KVM_RISCV_ISA_EXT_ZIMOP,
+	KVM_RISCV_ISA_EXT_ZCA,
+	KVM_RISCV_ISA_EXT_ZCB,
+	KVM_RISCV_ISA_EXT_ZCD,
+	KVM_RISCV_ISA_EXT_ZCF,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 09f0aa92a4da..f68b15b15f0e 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -49,6 +49,10 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZBKC),
 	KVM_ISA_EXT_ARR(ZBKX),
 	KVM_ISA_EXT_ARR(ZBS),
+	KVM_ISA_EXT_ARR(ZCA),
+	KVM_ISA_EXT_ARR(ZCB),
+	KVM_ISA_EXT_ARR(ZCD),
+	KVM_ISA_EXT_ARR(ZCF),
 	KVM_ISA_EXT_ARR(ZFA),
 	KVM_ISA_EXT_ARR(ZFH),
 	KVM_ISA_EXT_ARR(ZFHMIN),
@@ -134,6 +138,10 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBKC:
 	case KVM_RISCV_ISA_EXT_ZBKX:
 	case KVM_RISCV_ISA_EXT_ZBS:
+	case KVM_RISCV_ISA_EXT_ZCA:
+	case KVM_RISCV_ISA_EXT_ZCB:
+	case KVM_RISCV_ISA_EXT_ZCD:
+	case KVM_RISCV_ISA_EXT_ZCF:
 	case KVM_RISCV_ISA_EXT_ZFA:
 	case KVM_RISCV_ISA_EXT_ZFH:
 	case KVM_RISCV_ISA_EXT_ZFHMIN:
-- 
2.45.1


