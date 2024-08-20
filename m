Return-Path: <linux-kernel+bounces-293251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3F0957C89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7676F1C23469
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC19446D1;
	Tue, 20 Aug 2024 04:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU9d/e59"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D20E541
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724129321; cv=none; b=NHGcdq+CEccfE3Yv0lNeVOUgF+SFEDcp6V8Dwvn78RR3tm5mUvOu1lqZ4VCl407P1r6cM/VUQqyWI+Bl8GOWjEQuuoQlLKeoG6PoS2wtumel3jDq5N818EH+S4wFF5DMJK7kAYje+Obo+yLB4IEg7nr5+L3U6+5WC1Gx5gEA0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724129321; c=relaxed/simple;
	bh=vo0PQxsgFLeIZ/uP4YKfB4xBpxc1LMwJL4fn4rI7d4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRGa/PzUfLRsZbRi2h2mzaA6MEvT23TUPJmBiaU6lyX3qsbaHXoIugmy5a9nwSEvGLyr2gS4/nWqQAlmQYXr8np3E9LTsF/lR3VmOglz9dRDd+OPASsqNGrdt0lK3kcH51OlBltSqiGtxeOxbPjDsoAbo9kYwn+vVqmuJ+G3g7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU9d/e59; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4281faefea9so39594445e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724129318; x=1724734118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fye/jS5o+GEq4JZRP+A1JuHLRGwmKc6iHbcdO7MuGDM=;
        b=UU9d/e595UQC5X1TPjEOcTsQQV3B1YfmxF4B3iAuVqKlDAroJuxXzFS7uPwJNPYsMs
         Y9cf6CR0mWRNh33jxHIHPx16ACtYE/QyjiVuB9G53zu3cHKrUYNHT7A0Z3DAnBtQkr/j
         Q4ikmGgTj3HVnU5/IZLuodI/DsH9YcfY37TwL1+qjEVrZmEk/ofcCn9zoNegaqOqZURj
         +seoGoDEsBqqBJIIUlxTFrEaXejSgU7pizVothvpW38qaXR7KzS5KkpS6utwTurGLMDY
         6eI+4P0WC5JcHXMdCFKrJFFwfOiptfSel3uQT3HyJXHT/1g2+SZPZMMJu6NU0fV9Kouj
         a28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724129318; x=1724734118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fye/jS5o+GEq4JZRP+A1JuHLRGwmKc6iHbcdO7MuGDM=;
        b=vl3dFOV+6gFdaWr00/8PxL7YvZZ1vgHhTsG8OCyhQB5QegNoNGuVRfADatcV6YDNlM
         2aDT6fG6B42xJihS0oW1OJ2Yt50pyUhF3hx0pTj5tJJ4sOmd9R9GBuG1nLrWW0npDHOK
         BDein9wSH8QBO960ycyeO3SxlEBjPE8oqFG+iuTCE8vsfAzxEegsnOg/aiKFs6nXo0Do
         qi1zqY8d6IPYj2LsxS5i0JmVeOvYyZhBVHOYsL4RMvEUoHY5ksIg8O6yZqRMLq/YlJuK
         Nz7tBKQPLPPPWGtIfIIToVsMIQVnlnHyRyIjRDyLXSqPjKndZV+HvtRMGLQnLmd8eSzH
         sbGw==
X-Forwarded-Encrypted: i=1; AJvYcCXAu7L/lBy41UmkbxfB4p1grMZpfEARwA/atLXY/+p1drijEhAdWI3tCzHANXu7Wgg5BFv7nnXb7DfluBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1xe1V2R98f7hO9aKARMDJCgJ0WzoRp2JvrAyNswX8tsK2yU/F
	LCvPxkf5bwO22kgM9wCbhU+5liLUyZx8BLIythHJVSN4y/n7Za1F
X-Google-Smtp-Source: AGHT+IGepWIntETFS0+Xa90Hiu+rMqViuMxhxVMaVXC8MjFst8jt6k0gXZCZcKMX7zUqHRGOXDvJgw==
X-Received: by 2002:a05:600c:458b:b0:428:1663:2c2e with SMTP id 5b1f17b1804b1-429ed7a6b76mr80365795e9.17.1724129317734;
        Mon, 19 Aug 2024 21:48:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:57a0:1620:4000::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded299a9sm180852875e9.18.2024.08.19.21.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 21:48:37 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: paul.walmsley@sifive.com
Cc: palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jesse@rivosinc.com,
	conor@kernel.org,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH v2] riscv: hwprobe: export Zicntr and Zihpm extensions
Date: Tue, 20 Aug 2024 06:47:49 +0200
Message-ID: <20240820044749.557349-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240817075629.262318-1-mikisabate@gmail.com>
References: <20240817075629.262318-1-mikisabate@gmail.com>
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
index 3db60a0911df..cfd2929d0562 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -183,6 +183,9 @@ The following keys are defined:
        defined in the Atomic Compare-and-Swap (CAS) instructions manual starting
        from commit 5059e0ca641c ("update to ratified").
 
+  * :c:macro:`RISCV_HWPROBE_EXT_ZICNTR`: The Zicntr extension version 2.0
+       is supported as defined in the RISC-V ISA manual.
+
   * :c:macro:`RISCV_HWPROBE_EXT_ZICOND`: The Zicond extension is supported as
        defined in the RISC-V Integer Conditional (Zicond) operations extension
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
@@ -192,6 +195,9 @@ The following keys are defined:
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
index 8d1b5c35d2a7..910b41b6a7ab 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,9 +107,11 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);
+		EXT_KEY(ZIHPM);
 		EXT_KEY(ZIMOP);
 		EXT_KEY(ZKND);
 		EXT_KEY(ZKNE);

base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
-- 
2.46.0


