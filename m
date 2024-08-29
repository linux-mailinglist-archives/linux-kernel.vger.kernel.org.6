Return-Path: <linux-kernel+bounces-305968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8342A96373D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85D01C21FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 01:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C072B3A1BA;
	Thu, 29 Aug 2024 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CNcsp7sl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61F22EF2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724893321; cv=none; b=WQvK8klJl0D1snEiczcJXQsn3Kpymb/MBmeV4Z4+49erMCltdJTqZRtAoTmwlpoDrIjwrGWp7/3QXV/qQOl/3+viEhU8Zi75lvj1a45vHNEo3z4iQ23BuogEibUWx9uL3oueDMD63zTFwp2inARkXvvOeKHtxkqr5UOcidUy5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724893321; c=relaxed/simple;
	bh=UJjhC6mwAByWdESGrSD/skLO6hngO0x/+geXvfRiNMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riSLgLVzuJHne+lq7HFQDcy6vOz7cQnwXhjOdSqd+Zgm2jqsthcRfNCII0DfokryumvKEd26XLb8OiMhsk8gjcjZHzK1ihljmtNAlvOttSBOUOUWH7hwvaxUgO31nupFU61tge1xnMt4R0U5azUCKeb25be+eRzSEFQPJRNnc/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=CNcsp7sl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7141e20e31cso108723b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 18:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724893319; x=1725498119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvnGAjQNY6ccaQDDneANEaSxBsVmyy75aYzWJepO5sk=;
        b=CNcsp7sl1D6T/h9A0/d3jhf/ACDAVfQTmPI/nrJU73FxBMiuSsSLgvGoh4vuDQ2CiZ
         nNyhWjY1Yi/04Nonegw8nmV31xLyuEDmOBSQQ8SGiuLrIvOmBbDXsJnod8ufSM5fbvs7
         FtcvCXMUcH7VVd9+ZT3b/JpFO6xogmJQLjeS1ABGGZXufxfMXMTp/Hjw0NQ1CktKXR5o
         c8va5NuXgn8MJDGDZsEeecqH0Wx6DmzVc5N9ASyiZJyOhx5QOYFVaoqqfkofkyd8lRTo
         pFhOFxb8Jsbo9COTJCLAVavDEeL60QgVynQKZ52lzfg6lO/aqaqQttmGzCwrLfJLKLor
         5n0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724893319; x=1725498119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvnGAjQNY6ccaQDDneANEaSxBsVmyy75aYzWJepO5sk=;
        b=jdimWbMDnO3kWF0uj27a9gh6cYg7vRreNTVZ0VW7Onpxrs9fFkXCQ7ldMT2beZauZn
         4qeJ9RfcUC+csy5RZ6WBhoxwA/Wl3lekpnlmU9etknXYknzlJOpbSrvXhnTinjULwje1
         DIfD4UokXacdlbfr3mF7hH/dAzwqd6xSUij9Ez1/4M7OMxRFFvVo6BiLrajIIPIwLOxO
         329v41PHn+E7RNLpk9HqqsIh6DzZ+qN5G+aKQmk1RDinEcM8k8ZKFs56fiQBQdXap7YG
         xUn1u5xFcucQsxfgqBqhavgs6LtL5sO5iLgbjO4HqwIcQstCrK7yecPaq6AqXoMxLjDs
         2T7w==
X-Forwarded-Encrypted: i=1; AJvYcCWMuIRwStb5+N/fbQEk5qihuPaYeSYZuY5RQZqQsj7V3bMpX8uGwzj9zaMCe40YW4ylSMCZQL7qlVgP79w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqK91xBw/q9oXCI7NBIwVgwdh6QwsrPO7AcTB2XdcF7rC2ycH
	8oblTN29NWO1fQ5b1bDXNywFsLaMBEpmiNuqbUgK/KShVUuxldccLhq5ktqQu8s=
X-Google-Smtp-Source: AGHT+IEGopUyFxNYKdi1Fm00/px6XJ4FQ28S5BEmNcwqyBZ90BZIGqFp0Q1Tx11Ndv7+QQzMV9yqMA==
X-Received: by 2002:a05:6a21:3949:b0:1c8:92ed:7c5a with SMTP id adf61e73a8af0-1cce1011e48mr1298963637.22.1724893318753;
        Wed, 28 Aug 2024 18:01:58 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a4dsm89670b3a.17.2024.08.28.18.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 18:01:58 -0700 (PDT)
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
Subject: [PATCH v4 03/10] riscv: Add CSR definitions for pointer masking
Date: Wed, 28 Aug 2024 18:01:25 -0700
Message-ID: <20240829010151.2813377-4-samuel.holland@sifive.com>
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

Pointer masking is controlled via a two-bit PMM field, which appears in
various CSRs depending on which extensions are implemented. Smmpm adds
the field to mseccfg; Smnpm adds the field to menvcfg; Ssnpm adds the
field to senvcfg. If the H extension is implemented, Ssnpm also defines
henvcfg.PMM and hstatus.HUPMM.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v3)

Changes in v3:
 - Use shifts instead of large numbers in ENVCFG_PMM* macro definitions

Changes in v2:
 - Use the correct name for the hstatus.HUPMM field

 arch/riscv/include/asm/csr.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 25966995da04..fe5d4eb9adea 100644
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
+#define ENVCFG_PMM			(_AC(0x3, ULL) << 32)
+#define ENVCFG_PMM_PMLEN_0		(_AC(0x0, ULL) << 32)
+#define ENVCFG_PMM_PMLEN_7		(_AC(0x2, ULL) << 32)
+#define ENVCFG_PMM_PMLEN_16		(_AC(0x3, ULL) << 32)
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
2.45.1


