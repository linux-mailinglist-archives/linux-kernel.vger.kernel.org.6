Return-Path: <linux-kernel+bounces-305971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BB7963743
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9781F22E07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D44CB36;
	Thu, 29 Aug 2024 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g7I2v6K/"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5C44C77
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893326; cv=none; b=Nxg6+iAiEjIvsMtrnBpPUC3xLDhC68HHSzCnrUP9C+HnbFqdCqA2EUObBkElQnYOczXXcTpNcptE6o+S1Azhstexsb2gYH1cs23/ew8mbr7VRaz6kAxPi41dBogMncH1vkTaEkHQYAfyH3DdWGaz1MsdTwB3El8rcsbwJvD1Fdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893326; c=relaxed/simple;
	bh=Z0bb52PNqVU2ZfqlFeRvD7yJ3Iv38IwXjpqhPARo20U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAOxgZVA6NY7tUx9v/27go9uqPxoT1iieGF0kxI3yggHuR3/fMnf7pG1HBMiqpHzUU2+yXhqDHvMD4WRP5T2SRAT+FdGVUfkev6LpOW5E4If+20OxSax7E+HxdB2f3KVtqioyHBHnGynyCla/tky5pg8Zk58rCQsCa/Zh5tZzHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=g7I2v6K/; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-715e3e03831so113249b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893324; x=1725498124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2DzaTFaQhCi8x+b8lScKZdT6wqGghcdZfo+S0TqwgI=;
        b=g7I2v6K/BD4QlfEdjZJKeTfNk3EM1VB91stpM+i30stohXl5Bvs8Akrf6ce+Kr/Pem
         OGm3YGVaoGtL6EATAwowioaq+QAkQl2ihOcZeAyfwmWVn5vjuSmkCzEMfcHuZhwN73rx
         Cl8DeFNx5rFFy0wxeHX4yqcWCurw02L5AlhQv+z3I0iGjNAOgC0ZxZAnrNa5DlDoybm6
         tlV4dFiKdqZu8917PPuzEQY34sxRM0vyBMBM0lXIW9/VNIBo62jzp6J9c5TO6rd9w2mP
         qt5+lj/1njFmIRMcgUrbDQ4OivaRTrLH9qsoEHniv/9ftWfnYyEMY7s728A0qnKcpGv2
         KFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893324; x=1725498124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2DzaTFaQhCi8x+b8lScKZdT6wqGghcdZfo+S0TqwgI=;
        b=jdK260OVDPk2AN/DnsffOyLa8s0JYYjehMCaQiGvsSMwiT+M/28ihn3AzH6u6z30s+
         lAabyVeWjbTgG68BKF5X3jixNTUXez42CjEhFUtJiHq+zY6dwJssoKVvxQtsmS6bd4fe
         7KwGEyyFiaFQdFhTOzjnq2l6BdIYu11OeP7liQOvdwRQvhOTeUU1qpQI0U4qjNHOKghX
         1NoLtP4MXjYyaTL0w8LiBq3yWxPuuuu3Yum6SeCmRICL6AnyT+PjHmvEnjFXWZ5/+Mid
         hY8p/uGQEKsqiZTVqYjKo3ubXxFVKWkuufq3SWHxvmbbgViq65UQodVLwP0PYSwMsXjm
         9Y0g==
X-Forwarded-Encrypted: i=1; AJvYcCVTy4PLLkfsDItV4UEHl8PBp2X0w3FKSidb19e2s471x+9TMkfAnupUEml8shEkRQaikG2wOPn5k9Zk+I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiI2vq7ABKBPihDPiOBpDmdzqyponcerOuTyfFo8SgDd1RlwL
	OxAa090aNFt8yMvy6ZKkjo2/rHG5y+RAYTvwdWDNKCSFHCBunb46qPbNV6M5Lcs=
X-Google-Smtp-Source: AGHT+IEyh7NfQmaTixftnZaGL0dh72GRDf2NK4ZAJB5jBbRdIOg64cL/KbANa/7sfibaG7qR2QQ3aw==
X-Received: by 2002:a05:6a20:9c89:b0:1c3:a63a:cef2 with SMTP id adf61e73a8af0-1cce10161e3mr1027463637.28.1724893323584;
        Wed, 28 Aug 2024 18:02:03 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:02:03 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	Atish Patra <atishp@atishpatra.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 06/10] riscv: Allow ptrace control of the tagged address ABI
Date: Wed, 28 Aug 2024 18:01:28 -0700
Message-ID: <20240829010151.2813377-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240829010151.2813377-1-samuel.holland@sifive.com>
References: <20240829010151.2813377-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows a tracer to control the ABI of the tracee, as on arm64.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/kernel/ptrace.c | 42 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/elf.h   |  1 +
 2 files changed, 43 insertions(+)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 92731ff8c79a..ea67e9fb7a58 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -28,6 +28,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_V
 	REGSET_V,
 #endif
+#ifdef CONFIG_RISCV_ISA_SUPM
+	REGSET_TAGGED_ADDR_CTRL,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -152,6 +155,35 @@ static int riscv_vr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_RISCV_ISA_SUPM
+static int tagged_addr_ctrl_get(struct task_struct *target,
+				const struct user_regset *regset,
+				struct membuf to)
+{
+	long ctrl = get_tagged_addr_ctrl(target);
+
+	if (IS_ERR_VALUE(ctrl))
+		return ctrl;
+
+	return membuf_write(&to, &ctrl, sizeof(ctrl));
+}
+
+static int tagged_addr_ctrl_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+	long ctrl;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ctrl, 0, -1);
+	if (ret)
+		return ret;
+
+	return set_tagged_addr_ctrl(target, ctrl);
+}
+#endif
+
 static const struct user_regset riscv_user_regset[] = {
 	[REGSET_X] = {
 		.core_note_type = NT_PRSTATUS,
@@ -182,6 +214,16 @@ static const struct user_regset riscv_user_regset[] = {
 		.set = riscv_vr_set,
 	},
 #endif
+#ifdef CONFIG_RISCV_ISA_SUPM
+	[REGSET_TAGGED_ADDR_CTRL] = {
+		.core_note_type = NT_RISCV_TAGGED_ADDR_CTRL,
+		.n = 1,
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.regset_get = tagged_addr_ctrl_get,
+		.set = tagged_addr_ctrl_set,
+	},
+#endif
 };
 
 static const struct user_regset_view riscv_user_native_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b54b313bcf07..9a32532d7264 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -448,6 +448,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (prctl()) */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.45.1


