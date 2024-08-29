Return-Path: <linux-kernel+bounces-305967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB696373B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C561C21D97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A926296;
	Thu, 29 Aug 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EqOKEGoX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8817740
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893319; cv=none; b=XOKObnBsbgWzLK9qIeKGSgZRPYol4PgfSidHxUZ5H1FRRAdlJx5fhQUJWkjoYORAcZ46ZOHfr38p+H2spWg/hw/L92u+L7FjdpLLPYQbcAVV1M1QYEoZUIateDZGWsdFjP2yIgnmL46QDhWyaxMtVJse7U8rK3Qw2WbW4C/9RMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893319; c=relaxed/simple;
	bh=54Z1Kki/M4ycJcTfHa5Q/jrtvjooogsViCipu3Aud9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fH+bIEk0//MzoE5SNk3RfZW9PzC4Gq+9VkZxyrVphC2ioSO9nMjzrDdtY63psOU0SChNHjzZz1GguilxyaS6uWRPz9bVjJp7lSQykIazR6Sw+IM82NgwTPAFWUntfHy3R9/XvWEsS5OzmCvakZ3fanld5zDaQEw697KTRI4RerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EqOKEGoX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7141b04e7a3so110155b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893317; x=1725498117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZG+HhHQwJZyYDPSqWXytdNleBw1x1orMvGaUGC5rVdM=;
        b=EqOKEGoXXt6175YfbV19IGH22E4ICWheez4qRD0T2xvN6fLPu4HAWQYJDXX5SXMf/1
         J89Q7axqpx0tsHQRzfh3lZiMX3VdPBu9NgQqHtZQMB+CaYSk6/kw4G2qOSWxbUVQuLR2
         pL/Htw2nG4v5CD+2aVy8p+b6hWwTewfhk6gR6hsiORCKd1NpEl8WX1nv/9tBz/LW+HxX
         JopCO52lV/dgaztVKIaBmDJuMioQb08aoDTxsBqXJf1N3w/m6CKJYFc3V+/8gyt0HI5M
         wXaNlQ9nhDG2CbR7CGn/gYtiNB5HTdJLe/4BUg2P+DmwXSmGBICvTHiCor3+oe9Sq2HA
         PzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893317; x=1725498117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZG+HhHQwJZyYDPSqWXytdNleBw1x1orMvGaUGC5rVdM=;
        b=glHMu/GPXFbwhjG44sqN9j6F99cmxZQeqlB/0Wgbla7Eva9q2PFr9h5WHdTPXz07Se
         bI4C1iQLOVli8TU5qTmZspAQNqMPiE2JjwFGjgviiad7gULOWnSl/1b28oL9j6htPbA4
         l+tsKS+Sg+qYGlbfnnvi9Kyflvk4AP329xYeEaa2QKC68O5aOXn2t4Kszq/JymGv4rO3
         4aAJOQ4umJoLlcYk6w7uw1ZZmFkGZ7JjdYk/KUeHFK+qSwYKdYO9868OSNZQrxai3dx/
         9QqUV3zsuMq0/dTSe+FtuQlQfJispe2aWQjmSQDb5Qw4QW0T31HCz61L+nbF/r8Tefxy
         KJcA==
X-Forwarded-Encrypted: i=1; AJvYcCVLw1CTAXBbiSr8l4wcTA2J1OW4mQ3+Rce5Xggqih/76RT3buQOopQ+KMrFfmlnn0sJ++YMagvks5MRKKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx60WgTQiNL94/a9aq/b0OrssE4Mt7X9zKjmozNeDlT3WrpoNBz
	mEtuSN9w1TrwPoAMTAU0pxp7ImnaHU/8hBWMdrvEvZ5InbROe1yVS51mqfqjIZO4IpRLDmNtcCU
	I
X-Google-Smtp-Source: AGHT+IHXB3sOFlz5wc2v/ZX1VlSZzqk3ek5ZPHncWXvfSK2QDoK6tsVnueohSEGQZAci3rskyhyBIw==
X-Received: by 2002:a05:6a21:460c:b0:1c4:d05c:a967 with SMTP id adf61e73a8af0-1cce10fdc89mr1209674637.51.1724893317164;
        Wed, 28 Aug 2024 18:01:57 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:01:56 -0700 (PDT)
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
Subject: [PATCH v4 02/10] riscv: Add ISA extension parsing for pointer masking
Date: Wed, 28 Aug 2024 18:01:24 -0700
Message-ID: <20240829010151.2813377-3-samuel.holland@sifive.com>
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

The RISC-V Pointer Masking specification defines three extensions:
Smmpm, Smnpm, and Ssnpm. Add support for parsing each of them. The
specific extension which provides pointer masking support to userspace
(Supm) depends on the kernel's privilege mode, so provide a macro to
abstract this selection.

Smmpm implies the existence of the mseccfg CSR. As it is the only user
of this CSR so far, there is no need for an Xlinuxmseccfg extension.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Rebase on riscv/for-next (ISA extension list conflicts)
 - Remove RISCV_ISA_EXT_SxPM, which was not used anywhere

Changes in v2:
 - Provide macros for the extension affecting the kernel and userspace

 arch/riscv/include/asm/hwcap.h | 5 +++++
 arch/riscv/kernel/cpufeature.c | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5a0bd27fd11a..aff21c6fc9b6 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -92,6 +92,9 @@
 #define RISCV_ISA_EXT_ZCF		83
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
+#define RISCV_ISA_EXT_SMMPM		86
+#define RISCV_ISA_EXT_SMNPM		87
+#define RISCV_ISA_EXT_SSNPM		88
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -100,8 +103,10 @@
 
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3b9735cb19a..ba3dc16e14dc 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -377,9 +377,12 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
+	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
-- 
2.45.1


