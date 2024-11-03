Return-Path: <linux-kernel+bounces-393848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6469BA635
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37598281B23
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E917DFF5;
	Sun,  3 Nov 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fLXQNess"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B517C9E8
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730646193; cv=none; b=NlJ+JvR8s/Ol30DBsPmKIs6UIKiCmfFCLhgXQ0ciGU56DyN29HG56Q4Zss4fZfedyPQZLN8cCi2Kparw2kbrnR8+uUz2GxkiFaFsjuHYEOAJSISyWRDZE8VOaxxUnQzutbnjWfULbgNbC++gb7lFUSXVedXPR8Ba3imFl5qHW0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730646193; c=relaxed/simple;
	bh=xeHnByhcs5nCaAI8R1ijkMCW2JIwlS4zwscmM/llep4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uko/wT2mDVgF4IJQHLPxsiphvIBeEwMCeClvDSbBEY69QZ9L6qZa4eT9i0mz+z1QN3JO+G0Zdz7pVrL82si103Omhkli8tz1Rl3Me45vEoeFCQtzsRaAVdvMD265PFIH+aBNpNpVZVH/bbsUrABXM1jGKysPxZYr6UnOSeutr/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fLXQNess; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so29820295e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 07:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730646190; x=1731250990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51tYDRwP1WvxpzmCthvL0bau6hmUz8qjqFRqrLI9cd4=;
        b=fLXQNessp7bw7zyHRTo7WBFUD2v78z//Wh0lh865XQudosktnxWmbuqumUH7GLtYi/
         PSuPAfrsw8srPjG7MK2V1xTLyT7tMhVnpIPK1ez2rDprDbcYycAPics22yh37pbhIS6F
         2PF1XsLVtsChtyq15/QI3SNPmubWAOK7OvR7awNc/qJmdJRP5471CrvTMQw0HuYD8BhM
         XHakXShR0aW5sUpSls7hUHB0aYu1hbPEmHqu0CB+OzAPTpRZXsGhB+GLh1sk+vshjBB8
         AksswBCQ0mnss+VowigWLTIuJKNcIvJnGflg/uoJhIukkMBNdThlEhhDRrWobHD/YWGE
         U5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730646190; x=1731250990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51tYDRwP1WvxpzmCthvL0bau6hmUz8qjqFRqrLI9cd4=;
        b=HklNSwyomKe3kXPmuulmhEp4pBUsulFfSJWjMNyHoiFkaOFZnR11cgE0O2KP2FKu9G
         q+04xTrSqeO/jDyMn+MJKVYSSnusPZl+beGo/0nWJVpkOUxfnMRhtaumNvXVnixT/qos
         zt34Kj86+lxbz1BqqAVOVOULnrMNPiyqj3Ldq4ykX/k2VK1NgrCfiOFIQEr8QcTSqBIP
         DNTl9zc9LeJaytdztkgGn4PxIqB8vnKRAy1xH/URTYD40EM/ev2GHOT00Wf+ksr63gZn
         h3sgbrbEt0jjRjAO8KON1S+nFRyElIC/ys63ndMeJyVQRaoV7cwqKaQPNdTA7tuDGuwa
         J5eg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Q8HRPRSnDH6r/gUbipSry0RtYkxBHgeFWI3M/bjaJnVfPbnCmF7s4KCQNFQvX3+9wDSQo0MxUXJul5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYxKHFBTi2O9AHkcEhz2dcWELB4R2oINAl4Y2JPzNkeGPLtjfI
	5zAYsaxLz+skaqQJu1Ln7qfV4MKCAz1XBkEuSAUk/swI0TZq/ekJOgKm0++J6xA=
X-Google-Smtp-Source: AGHT+IFqldFYKHqBiRaB6ae6bURZkYwVuzbn5bQ+e+Hym9E5heEep9SJOfB/eoXxuGPgZenIG/xzCA==
X-Received: by 2002:a05:600c:1c9e:b0:431:5632:448b with SMTP id 5b1f17b1804b1-4327b80d3c5mr115258455e9.25.1730646190486;
        Sun, 03 Nov 2024 07:03:10 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (lfbn-lyo-1-472-36.w2-7.abo.wanadoo.fr. [2.7.62.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm10816042f8f.80.2024.11.03.07.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 07:03:10 -0800 (PST)
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
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v6 11/13] riscv: Add ISA extension parsing for Ziccrse
Date: Sun,  3 Nov 2024 15:51:51 +0100
Message-Id: <20241103145153.105097-12-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241103145153.105097-1-alexghiti@rivosinc.com>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to parse the Ziccrse string in the riscv,isa string.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 74bcb0e2bd1f..0aa3c3f5e682 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -94,6 +94,7 @@
 #define RISCV_ISA_EXT_ZAWRS		85
 #define RISCV_ISA_EXT_SVVPTC		86
 #define RISCV_ISA_EXT_ZABHA		87
+#define RISCV_ISA_EXT_ZICCRSE		88
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5e743d8d34f5..5f453a039ec9 100644
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


