Return-Path: <linux-kernel+bounces-229708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEAE917307
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A83B23BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB76D17FAAA;
	Tue, 25 Jun 2024 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kj7Bq7ru"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75CA17F367
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719349783; cv=none; b=PtwGDNzKtl/ibj6O4/uGN0J+bNFEO91VbY2IvzTQ8kv57piZACGBRrirH+XsBAvYt8Ed/b0mmorYGuMO+yuXAe66dbqCLF5EOr1BLw4272MeJ25TTBalkdzmL4aDkTxD7bhB95pNjeijZNdn0ulCeYWxheYnLDHB+eWnpc0wuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719349783; c=relaxed/simple;
	bh=URSk3J5UK0YJpSFyH6d6kLZ0L2XfZMO7gaaG8YfquqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idbwGw+AIDN7T+Q2Rt4WbGrrrr7Rn46wQXdHHkTjO4R1UsFG+g23IsLzSXCioD/zDyZ+0rmJYAIuXaxTMsrRzrdx8/UbamaN58lKRczigCbLuagOKYcjRqFvPbORp9KjAlYmw61QZ6GvMZ8TnjHLSxS478kEujgPRcUW8Jy3+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kj7Bq7ru; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa2ea1c443so24278395ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719349781; x=1719954581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrGWvMN3Ht8MgkCDub4Kzj37NN41tMPLHr9Zd0plWWo=;
        b=kj7Bq7ru7jviwNLcFGYA36BqHVBEVjonox2IxuzHfwaSRGsVyty8l/PC+8jqJOuuSi
         HmGrXWmlGxjQVsP5PA4aEXbCjxIpzcKQ+cAcnbABB9OtIRZPgHnIi20tu8lvbRFnBSsP
         vky7RWL0IKGjOm/ll8d5a75X5FQHiTKRNPU7KRyAQxvr0nRf4WRo3AjnBd1f3rsdTAIW
         sr1nHKDLAoiSiZgBMbw7007cmF5S2kCnho2Ty79vpp86/q4C4Q5QIEfhtjGmCO5j7bTg
         Z1+WwOFbP8igoXPjF0VfGcP1vV8GVrcZyxOMjOvQoNFoxbUP9/SvkolYuf4v8DgV/UJ4
         7UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719349781; x=1719954581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrGWvMN3Ht8MgkCDub4Kzj37NN41tMPLHr9Zd0plWWo=;
        b=IrYj3OB4/RFT1pBkzqAvDFyksZ4rWHHrfNyadV9FFQI4MNwPqbvkanGxt48ybfiArG
         aWfvsYF7p7v+zg/r7qg6yYn4l7/Vje6020d30UkLPVHgrDAiuqnX8BNDk1Hf52UncX4s
         2/PLVZencGstx6Rxj/X3FPd2KMhnWr3v1D9FXkmzpBCU74RADaQAbKXvOL+d5HswJ4Ma
         c1GyEn4SnjjEuvenykZ5qq+B/w+/vBEWavcssen5TDc5vI0T5uzQi1TEG1HWxRFAPDGf
         PFxrocMYsVpURFYPU8ksucU6I0FrqMIAWbZ5iandMc8gYQGyfoyqHzH52/OMtpgJCri7
         Nlqw==
X-Forwarded-Encrypted: i=1; AJvYcCUHmogYPhyF/0vnMS2kC0GJAJ4095yCTDSRWSMoSGi445gT9tS3dknTuAkGaLtviwa/b+GkTWVQyZIiPNzEx53kg2jW67xKVD46RpiK
X-Gm-Message-State: AOJu0YzEcAeG9r0f6vNqJdjhqHR22/WuPf8/0702beUGg/p8dspGUV4i
	52tTlArLiWvbNNCMTfQFxByKTWqlqA/o69thuFGCUaH9K7xo+23dHz5pTqq2HDg=
X-Google-Smtp-Source: AGHT+IHVaMXVM6zxBwAZCg/cGqYarn4awLSQvEqo6T1mYUpeIGRyF6rap0HbZ7xb98QAIxlepqf95A==
X-Received: by 2002:a17:903:41c6:b0:1f7:35e0:5af4 with SMTP id d9443c01a7336-1fa23dce235mr106984915ad.30.1719349781063;
        Tue, 25 Jun 2024 14:09:41 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb328f57sm85873455ad.110.2024.06.25.14.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 14:09:40 -0700 (PDT)
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
Subject: [PATCH v2 03/10] riscv: Add CSR definitions for pointer masking
Date: Tue, 25 Jun 2024 14:09:14 -0700
Message-ID: <20240625210933.1620802-4-samuel.holland@sifive.com>
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

Pointer masking is controlled via a two-bit PMM field, which appears in
various CSRs depending on which extensions are implemented. Smmpm adds
the field to mseccfg; Smnpm adds the field to menvcfg; Ssnpm adds the
field to senvcfg. If the H extension is implemented, Ssnpm also defines
henvcfg.PMM and hstatus.HUPMM.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Use the correct name for the hstatus.HUPMM field

 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..5c0c0d574f63 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -119,6 +119,10 @@
 
 /* HSTATUS flags */
 #ifdef CONFIG_64BIT
+#define HSTATUS_HUPMM		_AC(0x3000000000000, UL)
+#define HSTATUS_HUPMM_PMLEN_0	_AC(0x0000000000000, UL)
+#define HSTATUS_HUPMM_PMLEN_7	_AC(0x2000000000000, UL)
+#define HSTATUS_HUPMM_PMLEN_16	_AC(0x3000000000000, UL)
 #define HSTATUS_VSXL		_AC(0x300000000, UL)
 #define HSTATUS_VSXL_SHIFT	32
 #endif
@@ -195,6 +199,10 @@
 /* xENVCFG flags */
 #define ENVCFG_STCE			(_AC(1, ULL) << 63)
 #define ENVCFG_PBMTE			(_AC(1, ULL) << 62)
+#define ENVCFG_PMM			_AC(0x300000000, ULL)
+#define ENVCFG_PMM_PMLEN_0		_AC(0x000000000, ULL)
+#define ENVCFG_PMM_PMLEN_7		_AC(0x200000000, ULL)
+#define ENVCFG_PMM_PMLEN_16		_AC(0x300000000, ULL)
 #define ENVCFG_CBZE			(_AC(1, UL) << 7)
 #define ENVCFG_CBCFE			(_AC(1, UL) << 6)
 #define ENVCFG_CBIE_SHIFT		4
@@ -216,6 +224,12 @@
 #define SMSTATEEN0_SSTATEEN0_SHIFT	63
 #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
 
+/* mseccfg bits */
+#define MSECCFG_PMM			ENVCFG_PMM
+#define MSECCFG_PMM_PMLEN_0		ENVCFG_PMM_PMLEN_0
+#define MSECCFG_PMM_PMLEN_7		ENVCFG_PMM_PMLEN_7
+#define MSECCFG_PMM_PMLEN_16		ENVCFG_PMM_PMLEN_16
+
 /* symbolic CSR names: */
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -382,6 +396,8 @@
 #define CSR_MIP			0x344
 #define CSR_PMPCFG0		0x3a0
 #define CSR_PMPADDR0		0x3b0
+#define CSR_MSECCFG		0x747
+#define CSR_MSECCFGH		0x757
 #define CSR_MVENDORID		0xf11
 #define CSR_MARCHID		0xf12
 #define CSR_MIMPID		0xf13
-- 
2.44.1


