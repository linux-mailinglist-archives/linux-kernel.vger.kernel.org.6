Return-Path: <linux-kernel+bounces-229711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143E991730D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C5D1F22E5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC29180A96;
	Tue, 25 Jun 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IfpPBn7G"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169B517E446
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349788; cv=none; b=FkBL7a120kve6a0Gae/PugYywNZX5incg81yj0vpup1i+Vr+o/BfXgvcaE76l5NigKfUvcxqDwz3UoxN0T64RuZFiEZHpBYseqp5LUN38cJPvGNmXUduz5QLgRXzVNbnMSpI5wNsuKbzKQldsmKWYGCOBEtEV5TNrLSm6nsjfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349788; c=relaxed/simple;
	bh=LkgYYNuLS4U34v7gIANEl6UTbksQAjDkLyeECR9ZdVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZEc9oIbCDO3vcf96mypR4rYeWlxCfhk6M4//78fsyC1Uv/isD5Y6479hoP0mobHMseiyXcYSoXS/nRmo9BhAWOpcBV32cC3ITDD05pgw6LgE/p1M8AZP78DmCuuYqF/8tSSQ1r5Xjne+8Cc/CLf6277UZbiQxEAbzN54e3hbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=IfpPBn7G; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f8395a530dso47218105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349786; x=1719954586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcVNJ1c0k9nGflpMj97RQ79v8JL+NQUn2VhiWagHpuA=;
        b=IfpPBn7GETiS/XtqY0wS48u81e7iiccXvwaoU9sq3LwsWHKq8Bq1kv6izeqah8DY9n
         UxFFProXUEIqTGvLkNW9Epn7f1Og0jlM2fL40A/rsVLCf7kwD9Az5DBXb1UfaA18W9HM
         nfUZv2FOhDEnANOld0yVMJBQZLXVFRPxsyFUfQTx0X/oOlsAXOkuSPQcxfzR9yhz5Usp
         RimkohSEiZtI2Kg7sQCa9nrocOWwheu/80faI5SPu7uYXuDwVd2mCRa0IZJMVgAXXVag
         HcaGtu7fo04IYBJB3ADGtnJRB3Sdnm1Ez8SCHi+R5jcEGjVyTtYDL8cU4WVjaU66SFoS
         YUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349786; x=1719954586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcVNJ1c0k9nGflpMj97RQ79v8JL+NQUn2VhiWagHpuA=;
        b=lWpgUrockSFx0QmaidQD0ynILSfnd8kwYF2S5GG7fAPW//zUBsKbjTIPt4pPi4tFny
         wybHlfJXFXvlwfby9WiS6PzsYVLpWK3AxPI6Bsr2UXltQuyk3ZtDZkeCyu5BKUi4AYGT
         RYSxmrfKETS7Gd5aXBDAeSScFQpw1GgksnV6680ELlQKp0eW9Ps6PtcDQvOYmbxTJTHu
         OXHkoLROJZ+v0dSA8ZuGacVp5zVXVSGy4cF6UpR8qXoZsWgqcdOfBk2OzNFJXWgi4UPb
         YQvP+D64nPOU4Pjvh8QMjxJnjiZfjXYnCDpy06eA/rNuVZAxphi4bWUOdDr8q12F0fVJ
         y69A==
X-Forwarded-Encrypted: i=1; AJvYcCXJivJYh8/C6hvCQ0yif+cYXZcdNbPfiSQZ4hUhfxCokZogBeK3wRoKJPn7ZEjLtsoKPG9US9K2bdhfCzd+LEf1UxFkQ6l0Fqhybvd+
X-Gm-Message-State: AOJu0YzhXOHBe/SbzYsH9dDqKlrNsRXDHCBIRcRWU9lkqC9d8XyHbtsM
	xr+rjwpNfx58QnQStC32MY5GxT6KzGkuAvDFN3KJw3CSL/4nzqoSC8iIvl7yWWY=
X-Google-Smtp-Source: AGHT+IEkxpAQRQEVDc6TW5GfsE+EzweemTWIRBHDNXOU7XbbycmCakpPne7BxVO3PsXnE1O0ndqnMA==
X-Received: by 2002:a17:903:2291:b0:1f8:5a64:b466 with SMTP id d9443c01a7336-1fa23eceaedmr107096065ad.21.1719349786391;
        Tue, 25 Jun 2024 14:09:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:46 -0700 (PDT)
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
Subject: [PATCH v2 06/10] riscv: Allow ptrace control of the tagged address ABI
Date: Tue, 25 Jun 2024 14:09:17 -0700
Message-ID: <20240625210933.1620802-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240625210933.1620802-1-samuel.holland@sifive.com>
References: <20240625210933.1620802-1-samuel.holland@sifive.com>
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
index 92731ff8c79a..f8ceecc562fe 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -28,6 +28,9 @@ enum riscv_regset {
 #ifdef CONFIG_RISCV_ISA_V
 	REGSET_V,
 #endif
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
+	REGSET_TAGGED_ADDR_CTRL,
+#endif
 };
 
 static int riscv_gpr_get(struct task_struct *target,
@@ -152,6 +155,35 @@ static int riscv_vr_set(struct task_struct *target,
 }
 #endif
 
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
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
+#ifdef CONFIG_RISCV_ISA_POINTER_MASKING
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
2.44.1


