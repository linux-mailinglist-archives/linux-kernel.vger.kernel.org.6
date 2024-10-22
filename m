Return-Path: <linux-kernel+bounces-375434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE99A95DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2E6283B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587C11494A3;
	Tue, 22 Oct 2024 01:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kqbroY5z"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54862136E30
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562372; cv=none; b=CZ0cnJ5Vh2Zouew4vHzrFQPq+yGRHVefWQRj8f6F1tWN/dQ0mO3rYMUNc8hl2t4BDuSrko24hD8UKgcvuC/OXtInWQkJDyAQaTYlKzSUTBtPv6VpKfxED5wV9c3myIZ0vquUZK6RK0IKPShF/pY2MlZJD+Vq9LyllZLwe1lbh6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562372; c=relaxed/simple;
	bh=vA+zJm4qoMQLI2hkp6NXbqiyhUSCAXA2wJHgTca3RRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OaNqDdUPojHbOF76eF7Cc9H026HVjUhvfjdSBJsl436PePyVFptWkrBNh2qFOheugS2fphnqmeDWN1UU3I1Dzs/hmxIlT2LU4+n73vw6TLyLLtpvBpb77v4jR4WQDF7hlXzi3lVGI5gRIkErHEEQX3H1WV/5Tj1DWXrrWMEfaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kqbroY5z; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so3504808a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729562370; x=1730167170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo8mvyzhNAGog51IrcbhLjSHRzC25xwCT3do7aV0R5s=;
        b=kqbroY5z/ZfYntapR2mCxgFLZ5Ez64TS5Ct3wtdqGYLEYQZ6wpQ5MCz5Gr600H3MTn
         vEwS5JZkAD3H5dmEAaybJ7nUaSescSR8YH9oNspR3IIDOlRKtic36123SSZ1yVZ6+5mF
         ykSyODXjMl0bJxqtx672a/F/B5TN6+cYA/YR7sLCyBHoIhUJgsfwc6lZ5lRo0cGzXYKk
         HkBbhL0csSZIoJZgissd8tQJ8G/j914UD/wDfdFZFB3E+1r4TFkRvMGapMxvd0VeKl18
         Vek5GIPRs7HE3kxDDhDosg6XOGA4A39V4tJc3ikdC81w8F1HfFxTBPRwfG5BxpJtZzOS
         lvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729562370; x=1730167170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo8mvyzhNAGog51IrcbhLjSHRzC25xwCT3do7aV0R5s=;
        b=YjQCMVFn2yQ0jJNk9CH3XiPxaXOkug2ppevHLTMDkOSyqYqW0a7gGxyc/dPVdjdnZ8
         nslWYFPphdw4Qj3Xuc53WNW3GNAQppCm3g3UD6M5+J4pXxkQosUkNJZt/1Z0SpxQqkTh
         sFn0huONggPuz4RYk9PEOJ/qhwmbY1kX/wolTpR4iwMwRKmoUhRH0BoUyN1Roy999jM+
         zdbhXKwBLB9t28WuUNe9yUYGTM/rFuiLog1q2oDNXEXxeTO4FhcnE/seTvaGLYw4gS0/
         bumZy70DX+v/bHXYxPGOGNCgdPpMc0YYt9MeujrTDxoOsYSAmrwvXeYGeV3L3YYrhn1G
         Mz/w==
X-Forwarded-Encrypted: i=1; AJvYcCWg+AS/g+JvbCILvryAwwZYtKDagR66Fws1IJmwI2T2VxMp7wvWX5rrOUapJ3XmM9mSilyDVFaKPT0HH1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywof1G/r2hbCttNDmRYpX5XC8Mbx17BuSykqaKORy0pCAZ/L0Jr
	mOHtYA2aTeQzvjIUQxZAcIhWVrnvtY+N+uOWe5M11c8aCkyYRuCoVEZaQ9iEIC4=
X-Google-Smtp-Source: AGHT+IGIGEeeGnC+KScU7RsGDXnOT3F+tOuXMVMoo+fGP2CQIBFtA2wtlRRoG48p3wyuBbKw6oUq4g==
X-Received: by 2002:a05:6a20:b40b:b0:1d9:b78:2dd3 with SMTP id adf61e73a8af0-1d92c5100b6mr19225561637.26.1729562370603;
        Mon, 21 Oct 2024 18:59:30 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec132ffdcsm3600710b3a.46.2024.10.21.18.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:59:29 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Will Deacon <will@kernel.org>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 8/9] riscv: Add SBI Firmware Features extension definitions
Date: Mon, 21 Oct 2024 18:57:16 -0700
Message-ID: <20241022015913.3524425-9-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241022015913.3524425-1-samuel.holland@sifive.com>
References: <20241022015913.3524425-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Clément Léger <cleger@rivosinc.com>

Add necessary SBI definitions to use the FWFT extension.

[Samuel: Add SBI_FWFT_POINTER_MASKING_PMLEN]

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/riscv/include/asm/sbi.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 98f631b051db..4a35c6ffe49f 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -34,6 +34,7 @@ enum sbi_ext_id {
 	SBI_EXT_PMU = 0x504D55,
 	SBI_EXT_DBCN = 0x4442434E,
 	SBI_EXT_STA = 0x535441,
+	SBI_EXT_FWFT = 0x46574654,
 
 	/* Experimentals extensions must lie within this range */
 	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
@@ -281,6 +282,33 @@ struct sbi_sta_struct {
 
 #define SBI_SHMEM_DISABLE		-1
 
+/* SBI function IDs for FW feature extension */
+#define SBI_EXT_FWFT_SET		0x0
+#define SBI_EXT_FWFT_GET		0x1
+
+enum sbi_fwft_feature_t {
+	SBI_FWFT_MISALIGNED_EXC_DELEG		= 0x0,
+	SBI_FWFT_LANDING_PAD			= 0x1,
+	SBI_FWFT_SHADOW_STACK			= 0x2,
+	SBI_FWFT_DOUBLE_TRAP			= 0x3,
+	SBI_FWFT_PTE_AD_HW_UPDATING		= 0x4,
+	SBI_FWFT_POINTER_MASKING_PMLEN		= 0x5,
+	SBI_FWFT_LOCAL_RESERVED_START		= 0x6,
+	SBI_FWFT_LOCAL_RESERVED_END		= 0x3fffffff,
+	SBI_FWFT_LOCAL_PLATFORM_START		= 0x40000000,
+	SBI_FWFT_LOCAL_PLATFORM_END		= 0x7fffffff,
+
+	SBI_FWFT_GLOBAL_RESERVED_START		= 0x80000000,
+	SBI_FWFT_GLOBAL_RESERVED_END		= 0xbfffffff,
+	SBI_FWFT_GLOBAL_PLATFORM_START		= 0xc0000000,
+	SBI_FWFT_GLOBAL_PLATFORM_END		= 0xffffffff,
+};
+
+#define SBI_FWFT_GLOBAL_FEATURE_BIT		(1 << 31)
+#define SBI_FWFT_PLATFORM_FEATURE_BIT		(1 << 30)
+
+#define SBI_FWFT_SET_FLAG_LOCK			(1 << 0)
+
 /* SBI spec version fields */
 #define SBI_SPEC_VERSION_DEFAULT	0x1
 #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
-- 
2.45.1


