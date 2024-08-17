Return-Path: <linux-kernel+bounces-290613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C652F95564B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D2A282B1A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227FE1422D2;
	Sat, 17 Aug 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHU5T+t8"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC96FB657
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723881434; cv=none; b=Zhg54tuXT5u4Ltf1Cf9fQchgzKETOBcCpUFdnvSUPvbtN1YffCFx1GgqzDHnt1xYPv8z0vOqxquMGoEK50r3Hz10jfn3G0OcDOOyM8BE9ZDVQxig/yOvSnabqsjPGJkMboSESlq5fXBt7J8959+UpEsxUUKCKK/b/7jBe1P5drs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723881434; c=relaxed/simple;
	bh=ZzyorN4xHW9OVDFwjjmq7HeVDkIWjPO7F7h/Ll7A7Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnIr0IksA0ShsCxXHbBA8WQif52g8MtvoESLDXLha65/o22X0H2gp/sjQJoNKvr2XCavkSnyolXtWLtp7ZIKrdea1vTSEwI4l6KuRliKa8NwhwExfKO5YGi9teJHjuzvasfbVrzHhnDMbA5J1RTD2CR6ckxQ6Kgr1JyN2RkGdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHU5T+t8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso376037466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 00:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723881431; x=1724486231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5jB9WqD9hn9VQJpZtHAV2ARCrG+g8V2GVK+szYij7E=;
        b=CHU5T+t8YwdEJ9dbvMCuFC668P7fIRaPWJevVlqFvH+xcgBqm37J7QlDJ72+vXNBLK
         EyPrMg4k5jzuLeXDDj1MBQbTwWJyovJWcUWP82p3R04rRoXOK5kQ1e0kP12vlkY31D9m
         HEfqn6I6znlyWDBefGrTYCCCE5Uzn0BAdMXKZTgz5wI0OjfJWexFlDXqpLFY2+QY7rnz
         yKTOu9wQFXr2pqog9MUcD9qs4LNvKOkdR3ZZqKqcIarCDGSGRV4x4h8hLFse5SeqRkcn
         LW1a2ET7rkiu4+fagHsD3mxPc4GP63MBocqOD4dAJL2KE9akFboKaNn5Kgjm1Gxnk+nv
         smqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723881431; x=1724486231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5jB9WqD9hn9VQJpZtHAV2ARCrG+g8V2GVK+szYij7E=;
        b=Fzz0O04L4a+FZh9H75Z9ggn3PXYIey5zd2N+lxGDz+saHypvX2gFaJVjzzYCihg83l
         c3D40mXN1u/AEJRJ9wCtHojrdL1X9k7IXlwlTYmL6+9ovwciEMy0P4sYf4QuJo8UOiXG
         8wQFsKh/Psqss3qC2DPKux5iLpMKRHbfC80+KolX5eCxo6kdN7aKjNZlppQmCwKwa6nX
         +Wq+a9YOB2uQ/mwLbKfadyZMy68CDeCe/DpZUhBaYwZm8qL6piOiW86PesOzmV9rK1i8
         +9UGx78ZQdhcnVbM29OUZBTubjy6h8rYyvaF+suEcql0As9Oz7MoSKacsh0aYTPWQdxo
         R76w==
X-Forwarded-Encrypted: i=1; AJvYcCVzlxfXBH33J5xlkXfzEb4C0GSY48NpTzruDWtiTzMb1aa71m+AL8M9zXLELNqsvZK3ygCCEA0eEZMABrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY7+0kXp+f5g62vM0nebWttIB0ry0e/6JJXtM/fX6BD/T7LgT/
	ZTdprzgHDWo749kmB/9dIxrxSSO5USmG1Xx+1h89W1RbVgRYgTKY
X-Google-Smtp-Source: AGHT+IGxg9zUYsOiUSm9ol0uO2f1rXCDCYJQtLTwAm0CSAhLAQ7RavbVKMfZvk659KR/93hyGd3LQQ==
X-Received: by 2002:a17:907:e223:b0:a7d:a080:bb1 with SMTP id a640c23a62f3a-a83929f1240mr344339366b.43.1723881430522;
        Sat, 17 Aug 2024 00:57:10 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946967sm369430866b.172.2024.08.17.00.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 00:57:09 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH] riscv: hwprobe: export Zicntr and Zihpm extensions
Date: Sat, 17 Aug 2024 09:56:29 +0200
Message-ID: <20240817075629.262318-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Export Zicntr and Zihpm ISA extensions through the hwprobe syscall.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 Documentation/arch/riscv/hwprobe.rst  | 6 ++++++
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index 3db60a0911df..5bb69c985cce 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -188,10 +188,16 @@ The following keys are defined:
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
        during signoff")
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2.0
+       is supported as defined in the RISC-V ISA manual.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZIHINTPAUSE`: The Zihintpause extension is
        supported as defined in the RISC-V ISA manual starting from commit
        d8ab5c78c207 ("Zihintpause is ratified").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZIHPM`: The Zihpm extension version 2.0
+       is supported as defined in the RISC-V ISA manual.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZVE32X`: The Vector sub-extension Zve32x is
     supported, as defined by version 1.0 of the RISC-V Vector extension manual.
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index b706c8e47b02..098a815b3fd4 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICNTR	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZIHPM		(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8d1b5c35d2a7..30aede1c90ff 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -118,6 +118,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZKSH);
 		EXT_KEY(ZKT);
 		EXT_KEY(ZTSO);
+		EXT_KEY(ZICNTR);
+		EXT_KEY(ZIHPM);
 
 		/*
 		 * All the following extensions must depend on the kernel
-- 
2.46.0


