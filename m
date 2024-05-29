Return-Path: <linux-kernel+bounces-194586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDDF8D3E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABE22839F4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091D1C6887;
	Wed, 29 May 2024 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JpKCexS0"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0E1C2319
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008876; cv=none; b=tvU+d3xDvT7jaUrJu7oimop3Oz6sNPzgibktsqYQ16Cp2rKz6KbtUbbLA2l6W4qnOWEs9XU5du6VFyAfykMMqAce1AzJPETDRmfj4h9zlptSE7HzVr0XDka6PAXb6qZSnK35QUt5dsxEyQ8/iH4D0IZas6m0bOz4jVd4Ymp5gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008876; c=relaxed/simple;
	bh=fMpo7uyRB4y7EFUUS5JpPLDb1F+bGUsB2lDFWPSLOEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTo2O+PNyuQhiMuoeaXuUnyRE9+uyllwGhz6EVrtoSAsRIwxaHwSc0XRtGCXs3yAEF6aKh7HDW89Osx8GnyUSSNWN2DJyKDg+VmAIlUyx9OFy4Bk0TKNTF4ixt0x2OvjHdgsmSOgjvDUFWe231/fsV9kFPqIw9SGo3xFmQNQ1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JpKCexS0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354de3c5d00so20244f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 11:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717008873; x=1717613673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSkmcpX/DU8tSqXScAea3itOYSZ+Zk7JjFi4MBclVMg=;
        b=JpKCexS0d5fubLu2T0o7lTYPo82rcTpuKXaxl+1KMQScc0K0Kk5R4vazXhqZaIH2qT
         e3BJZ1TJluS6P+kS48FWAWm3xmRnabAsjTrCuSUnRyOz+JcxH3tSd/fa7gC43oDsGylD
         k/NRvn5dHkiWQVbOt8L0tbO8KJluxTDAKpfYtw4E8isxs0H4KLTtkUJPaYiQciplLQWH
         yAzLYnXRm3Ho2yas/2LFti748WYC/rt9xc1/UJfOb/LPQct20dxRP+ELWKmYh1rBfqXw
         CHJYvVLC7xouduyAcJX18k03ixLxBZB36nlY0EvFjSKeBLgjZi743fKcNr+oXJC0+7Cp
         hoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717008873; x=1717613673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSkmcpX/DU8tSqXScAea3itOYSZ+Zk7JjFi4MBclVMg=;
        b=oK7oojJHHKEMeL7gmqC9+XElXGLuU2GAoBJJqwtlU16iezSChuClW7CsdjwSLHNHBK
         u+3WUIZF4oxMqaCGDSa8QWWRf+579ghDTlqsUUqcZORG2osTCbSE5zLZ5civXNe03yp+
         r11rbyBnB88xCIRkziHp9i6c8ddirlgAvSbM1u0aEcmd3VfswsjmcPh5vwPdOlnLkmf8
         K+s6eTIvAqRlG7AIUzZGmXpCuitm/TeDmZcaeZrl/u3RiA3GZF5f16Ci0kYNIHAFrwXc
         4jrNxoFwdamNyEJBapiNQ5aV+f64kCHcUlqW2cxykgVCgGwI3bfc4n1KNw0CavFD8IlB
         AHhg==
X-Gm-Message-State: AOJu0YwHht0AQ0CK6HHcIiGi8evvTZWdOdXXzd3kbljx4JGa4QPKr5QH
	FhM9G4BK7EdFGI6RgQnZaTlfTw7P3BVYwBiD2vQjlk6ZTEw1ZskbUxfQ7LJ4aNtFuFenRNsUy6q
	g
X-Google-Smtp-Source: AGHT+IHHl9KK9z/L8izKsRybmVqfP8bMjXHwVAHsTsF/TnNuIRcfgvHrqZiLQ7fq4FiWPMrXEUFK7A==
X-Received: by 2002:adf:f6cd:0:b0:354:fce5:4cc3 with SMTP id ffacd0b85a97d-35c7a8477f9mr2527916f8f.19.1717008872954;
        Wed, 29 May 2024 11:54:32 -0700 (PDT)
Received: from rkanwal-XPS-15-9520.Home ([2a02:c7c:7527:ee00:7446:71c1:a41a:da9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212706a23csm2787885e9.27.2024.05.29.11.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 11:54:32 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	acme@kernel.org,
	atishp@rivosinc.com,
	beeman@rivosinc.com,
	brauner@kernel.org,
	conor@kernel.org,
	heiko@sntech.de,
	irogers@google.com,
	mingo@redhat.com,
	james.clark@arm.com,
	renyu.zj@linux.alibaba.com,
	jolsa@kernel.org,
	jisheng.teoh@starfivetech.com,
	palmer@dabbelt.com,
	tech-control-transfer-records@lists.riscv.org,
	will@kernel.org,
	kaiwenxue1@gmail.com,
	Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH RFC 3/6] riscv: perf: Add Control Transfer Records extension parsing
Date: Wed, 29 May 2024 19:53:34 +0100
Message-Id: <20240529185337.182722-4-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529185337.182722-1-rkanwal@rivosinc.com>
References: <20240529185337.182722-1-rkanwal@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding CTR extension in ISA extension map to lookup for extension
availability.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 4 ++++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b8cc459ee8a4..aff5ef398671 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -86,6 +86,8 @@
 #define RISCV_ISA_EXT_SSCCFG            77
 #define RISCV_ISA_EXT_SMCDELEG          78
 #define RISCV_ISA_EXT_SMCNTRPMF         79
+#define RISCV_ISA_EXT_SMCTR             80
+#define RISCV_ISA_EXT_SSCTR             81
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -95,9 +97,11 @@
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SMCSRIND
+#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SMCTR
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SSCSRIND
+#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SSCTR
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d1fb6a8c5492..4334d822b2f2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -298,6 +298,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
 	__RISCV_ISA_EXT_DATA(smcdeleg, RISCV_ISA_EXT_SMCDELEG),
+	__RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
@@ -305,6 +306,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_DATA(ssccfg, RISCV_ISA_EXT_SSCCFG),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
-- 
2.34.1


