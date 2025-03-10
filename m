Return-Path: <linux-kernel+bounces-554535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B743AA59979
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36D716EC6C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B862922E3EA;
	Mon, 10 Mar 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cdz7/WQR"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD74B22E004
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619636; cv=none; b=HKuNzs50XHZuyjvF11sL5rGv5ZoyiMM52G/S5JqQtjXkE31KinMWvIKw7oIhx7w8c00rr0WfV34vMH2H1hTIEelVQE/w7C3H0V/d9l10QKWNeVX2cVNHLCQXQd9jIcywoodyHsi3XJzUQEj3YQ3/EiMoOy0aniI2ypDf8LwRusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619636; c=relaxed/simple;
	bh=3Gq7Z8A+hrlF6/0Q9hK5MxRmxk1HLIsaGdv+leWkC6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtxEaXMd3GEDmFDxhSJ2UM6njnSNMz7Q173haYHkqwK+0fd3aKIoPKaTan4R29lZ4XoHD4D5Yeo6GNjdr4ZiKFS1sbNrNHiRnfleEry+TYkbi+k730PQTe8vyXe2XYBxAVhTAsysfzUqip0URGCAfrB24u/qxSpmBR22ladHCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cdz7/WQR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22398e09e39so79073865ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619634; x=1742224434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJEE3tstWlxClRLN5XCqSGWhwaxxi8RTX0eYkvDKRxQ=;
        b=Cdz7/WQR+7uX6hIvezcWmd3SYIK18OWbBaXZR1ZFus4W2Cd1z8o7LZxIpEzwrSf2A0
         WYgHqtDyiST/2VT7/6Poc/4cQHf2XahmIXa5sZzJl0UeYnWqLwchUJXww8lv7UEvERvz
         hXwX1y43/rf+FO1Da1jDthCzv0bFuRPDjYfpwoivhIoOk5rLY1XWjKJbEZPEqu8jr4Uu
         Sqz52CRsO0xxgoUZSsj0bWbm+I4i58N84IrpU081jSNAcoCNWKYboJgFll9K06W6rx5i
         IJsGK5J60N1mnTjWc9ApDSN+ud128BOh0pYZKW3CAega7/iSAr9dsyftwf988rC0rQHj
         PoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619634; x=1742224434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJEE3tstWlxClRLN5XCqSGWhwaxxi8RTX0eYkvDKRxQ=;
        b=t935IAayU+IAZAW1n5eT7kqmLtbCtExHWdCFMxWJyJFgqieqvQvVlQ6Xvo5kHq2dDi
         qTig9Ozct/dh/cPG4GJivHIOYSevNgUvyXNm77fSOVMBXBpzjyusM1QPhihENiw3ncQc
         E9cdR/uiG5MRtfjMw288ZuQaZU+yoJVXdfEhw2rfDuANtEP5hh4foNmaRm2fTm5MVylE
         YK8pI8pLLacTMaenzkOWX5Y2qg4BHjt00T5lpoBdtyHQOP49SqHj0d9b0+auAul4t0dO
         7KxG/rd9TTkWGB5lvR8IQPfEf7nDgB/jiuNLyruCXwBzVZ1tBvExsGjYcN5U7NgY1elX
         Y2ng==
X-Forwarded-Encrypted: i=1; AJvYcCWtiTQ2sSkKj+qJGhnhpsAx5klXtSYZQWezTW2FG3rbknPBlaIYU0nIvLd4RodaOyOKGcszk2mDFG5aO4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmxM8SimiUn6Yy98eu8lBBJGAiKosSslzk70FCMBw0v0LlrNYK
	e+tLFFnu7Yo3ViHiuFyiHifVkKecd8BjXKQxVuo2+/Kq2Ti0t9GUW2JOOoqmsqs=
X-Gm-Gg: ASbGncsgpEnmrRQhFt9f5KCjCn/TdYo7w5fg7azF7Zt8J16AXVMxa9FA8dXI68lkXiC
	1dsFgLb3yxw2P5v+mbUs/68Qx8pH2agKb4XSvWzJJQyOOMoTlQ5zlJWF7Q46r18eoikJIksuL1N
	vdwfH4l6c3ISK8tEqbgo2roV2K1pj6ZsZb/OPtcurUBMj+ewFyfS1YsirJXOIuyadTxyMtoVkqc
	/gJZOw92n/WLtsFMHrLp4aGiuP45UBoTntfDJBi1Er2f9bRrWjr5dC0YwEjynoC/0Ws1oa61HDF
	q1qGPAtoZFyjaOXoRNSfCTcxlEs8hHkziXeKw2EJS8hjRg==
X-Google-Smtp-Source: AGHT+IFu79SrTcHr6DQ0LZoB48TuSJ0ALQO1FccV1+6ehx1qbYGTJAEYU8+IrRgycH415AfK45aV/g==
X-Received: by 2002:a17:902:f68a:b0:220:bcc5:2845 with SMTP id d9443c01a7336-2242888666bmr164594065ad.7.1741619633926;
        Mon, 10 Mar 2025 08:13:53 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:13:53 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 08/17] riscv: misaligned: add a function to check misalign trap delegability
Date: Mon, 10 Mar 2025 16:12:15 +0100
Message-ID: <20250310151229.2365992-9-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Checking for the delegability of the misaligned access trap is needed
for the KVM FWFT extension implementation. Add a function to get the
delegability of the misaligned trap exception.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h  |  5 +++++
 arch/riscv/kernel/traps_misaligned.c | 17 +++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index ad7d26788e6a..8b97cba99fc3 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -69,12 +69,17 @@ int cpu_online_unaligned_access_init(unsigned int cpu);
 #if defined(CONFIG_RISCV_SCALAR_MISALIGNED)
 void unaligned_emulation_finish(void);
 bool unaligned_ctl_available(void);
+bool misaligned_traps_can_delegate(void);
 DECLARE_PER_CPU(long, misaligned_access_speed);
 #else
 static inline bool unaligned_ctl_available(void)
 {
 	return false;
 }
+static inline bool misaligned_traps_can_delegate(void)
+{
+	return false;
+}
 #endif
 
 bool check_vector_unaligned_access_emulated_all_cpus(void);
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index db31966a834e..a67a6e709a06 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -716,10 +716,10 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_RISCV_SBI
-
 static bool misaligned_traps_delegated;
 
+#ifdef CONFIG_RISCV_SBI
+
 static int cpu_online_sbi_unaligned_setup(unsigned int cpu)
 {
 	if (sbi_fwft_set(SBI_FWFT_MISALIGNED_EXC_DELEG, 1, 0) &&
@@ -761,6 +761,7 @@ static int cpu_online_sbi_unaligned_setup(unsigned int cpu __always_unused)
 {
 	return 0;
 }
+
 #endif
 
 int cpu_online_unaligned_access_init(unsigned int cpu)
@@ -773,3 +774,15 @@ int cpu_online_unaligned_access_init(unsigned int cpu)
 
 	return cpu_online_check_unaligned_access_emulated(cpu);
 }
+
+bool misaligned_traps_can_delegate(void)
+{
+	/*
+	 * Either we successfully requested misaligned traps delegation for all
+	 * CPUS or the SBI does not implemented FWFT extension but delegated the
+	 * exception by default.
+	 */
+	return misaligned_traps_delegated ||
+	       all_cpus_unaligned_scalar_access_emulated();
+}
+EXPORT_SYMBOL_GPL(misaligned_traps_can_delegate);
\ No newline at end of file
-- 
2.47.2


