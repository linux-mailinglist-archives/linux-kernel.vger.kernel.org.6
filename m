Return-Path: <linux-kernel+bounces-268705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C039A94281F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7AAB219A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F61A7207;
	Wed, 31 Jul 2024 07:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="e1rqvkV+"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952691A71FE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411325; cv=none; b=okrpl6McEyNtPdnIFICugBKligUeQRKG8JmlBS2NFNeg7+HXr8rL4nS0EYRgxaHzyhDmFIykdTKCWVyrVioMrzIC8EjIJzli6nNPv1RFVSrw/0VYNbXYscPSljuzQ69/riIfiy5N/E0zplaG2UTwGd6u5B9eJMCbyOZeTgBT5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411325; c=relaxed/simple;
	bh=+9/y9wvtaqMsdeXKfExQM5dsUcThBpV6bsD9FDAfAQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luJsPDcrkKeOcIjQm44UPxgP2BlLDmaIEqtRC2BdJs/DgOjv0hrIXu0ljuMJzV9ov5YFWD1WVMrAFi5k8kLnsa4mruNRXuQ2AKatd5nTyGTQWqHmFrp4YlarEPKSSUMXZJO8anecJF8esY3M+gLSWlwgfHJeDNm/avuPe2a1cRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=e1rqvkV+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36865a516f1so3766514f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722411322; x=1723016122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z44ALrb7LNXYv1B0ZHkbMo5mYcvmK7MIKHKlm+pxL7E=;
        b=e1rqvkV+tHP6kZSLCllIO64WzIc0/UdYhnbG6DhpoEjTSrPE87RcjuLBo1P/taJA7q
         RDjlvYNE6m2tTeNNHtJosZjmwep5akV0lPeuxHSSoBKP7Lcjc/j/lmrmi+N3IaQO7lP4
         rn0GmOq9goq4w1XSPAxuAM8FtdJEvNRMT1PWKPEKDoUB2oy3aRj7H4t1y4fGUBfKl2UX
         3MI9FfOd9YZ3viJYyHhfIrtMMsdTWvSE35oCh8IfCRRZMjrawG1lqI433/GtDlXXfO1Z
         Q0d/5Hu6UMI0cKxWDKrzx5b32YYIB4mqChalEIBINSuc5be4EcXVlJkjoAIHtOheG0VE
         sRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411322; x=1723016122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z44ALrb7LNXYv1B0ZHkbMo5mYcvmK7MIKHKlm+pxL7E=;
        b=SmeQC0QRKiix2OMIeUgngQAttdpZqkJgBkH2Qn3ydzjjPi1EdbugXI0iOWsIzn5TbU
         YugzFNI2IUyvo7hULTdXehdgeybQJj3u2wYxjyBj02+3kHks07UKYjWtlMPwqmXLn2Eq
         Lr5NhxRK5+vV36WLglbehQ2Z+km4Bf0aEdLTRnTgiFYtw5GVC1JWvvOuOVEgieJOawdn
         YHRgO8OdMcQcu+/1r3AS91iyITWULugtxhQxzW3yZfuEfdzcmNYzsLh+RbhRgdGF9yfm
         vgncE6zMHZdqXomDWaGvVz4JqP0Xlvoy5MylL1emQ/TgnfstXKT65qbIpUoW1/1P3Kf+
         I+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3wAMk5FY8E7vo1g9CV3R6fF41fH2+uTGTvZkpY9HdPoUtj++TBh/S7oxjYw4zSepqggKDzYfLTEHzdth7TvHxBK7ixH8ojf2Vc78e
X-Gm-Message-State: AOJu0Yyzc+qI8YNuaaJ/bWUY/ARlWVNp5+7jh4TgqMLtVb+9Ua1SXKxU
	aGCDJ0VRkUay8eJClVY3SmkHQpjbDQrMZSLdkVzeUcR3e4vxg6/BKu64slTEVhU=
X-Google-Smtp-Source: AGHT+IG6U6uPzWRr6gyEB9gsCw8ZKy/LcXxiWXsEaCB8YLZ20e09CxhjZV72Tw4GvYFGKWtqsWRHog==
X-Received: by 2002:a5d:6d87:0:b0:368:31c7:19da with SMTP id ffacd0b85a97d-36b5cf2520fmr13078467f8f.13.1722411321847;
        Wed, 31 Jul 2024 00:35:21 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36862271sm16333146f8f.98.2024.07.31.00.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:35:21 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v4 11/13] riscv: Add ISA extension parsing for Ziccrse
Date: Wed, 31 Jul 2024 09:24:03 +0200
Message-Id: <20240731072405.197046-12-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240731072405.197046-1-alexghiti@rivosinc.com>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to parse the Ziccrse string in the riscv,isa string.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index f5d53251c947..9e228b079a6d 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -93,6 +93,7 @@
 #define RISCV_ISA_EXT_ZCMOP		84
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_ZABHA		86
+#define RISCV_ISA_EXT_ZICCRSE		87
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 2a608056c89c..097821df8642 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -314,6 +314,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 					  riscv_ext_zicbom_validate),
 	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
 					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
 	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
-- 
2.39.2


