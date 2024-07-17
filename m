Return-Path: <linux-kernel+bounces-254704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A246C933691
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C6A1C22968
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AAA11CA1;
	Wed, 17 Jul 2024 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="N4Bgf5Is"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EAC171A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196158; cv=none; b=Ij/Elri9iLvKIlVIQUoz5knOIKj4i+mwcRzDsGx58AdPgOgRuXhWBrcJHRNmpPUZN4mCfeyQgaAf1Sqx902JD5lk13MQATgyphl078yr1zRLmGwivrXMWfskds+9x5aMTXhzd3PIDZzlDUhD1AatShL1uwyHJwmma6944OZaDSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196158; c=relaxed/simple;
	bh=LZA4zhT5BIJyw4yEug/ytb1tl/M2pa5AKaP9gougVIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fofk7xY82GJ+mL3BMs1idGw43j3lr+bXJtGrGuwnPtYtl6QysmeBB7lxRpFWvvA/8hIurQSaWhuA7QTTj3/HTxhhu0bHMPjFQntcxClIPt3z8eYDPhgRL5x4A0qzOmBIKUnyBz1Kcx0wFXZwfys/tpQ4dLhmRS9Q1aVeJD4y7r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=N4Bgf5Is; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so2184165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 23:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721196155; x=1721800955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXmippFvjJBdPaOFd0Bb9N+zo48IbYES3OA/c/+iV6I=;
        b=N4Bgf5IsURrP2XiDcAL8Fd0i078+Eqi1JTXItVF/nc/JDZCf25b4rat5tbeNpyK2vA
         jqrW/gB/UtlINm6eL+CC0sURipJj5AfqvX5ZiXTPAwavTeusbqoMmyT4VOTqWiYyIKiM
         aowvGK2+MHhdPGhTCNB8u3nBOX5+LpGv4925iiNRN9cqzA4V+Pe2kE6dlQhMAehDHoLx
         E6uH5qm/fuZSEXYsOARn3NKizzUwBJ4sP6LjzgYRq9jsjUSajlC8sbogpOVZppnibK4p
         keaoChdIKTjFOgn08yLRxlMWLfOzjnJDHwQ2RrgQfpEDTZ/cYwKt9FgxISenE6nog2El
         FTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721196155; x=1721800955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXmippFvjJBdPaOFd0Bb9N+zo48IbYES3OA/c/+iV6I=;
        b=vJ9QPuTnRMtqBJcDjsFFqqTCP4YRXqDcjPag5WkB8Nqg6ahJbaFjqohKCZDddCxql9
         VKHKkUToPIAmJta1n6aY0VTRtYnXtTL1QRbc5bev5K7+BwSSVyo9keZL3U0z1cASskHp
         D37Nq0G8qsCPYOjPits7Lbbap8UbHU2+T5s+BxVkETnUB2/1d31PCygN1QrVI7dsHec/
         esNLyTbOUfac+zvcQ1OJ/LRo2HcI/oSzjzUFyrYI121tn3+TKjlPZ+hUmb47oeD7aaaE
         Aa85pTHmhuZFG4meFY6NMAKVonXVJLSuXnjo3T7fbRTM7FRTyHURIVrzOnY2k7wFqLCs
         FWrw==
X-Forwarded-Encrypted: i=1; AJvYcCXoijUYLvMv66K+TZrTJMDgLhNxqb2nnaQEtQXn9DzxzhHunZBVfXpAJOVjAONud9oSkenG+mfc4uweoPKldCWzKzCq8BOpjQTxDI8R
X-Gm-Message-State: AOJu0YxDAH8C5tuix2en6PtBD8oKqsQfMsIYKUYCiTRzjKlJ+6vKSDu4
	rnVGSHTxkCSlI4e0BKNcvkM2JTVdT0X4OgxdyPPUUwPC5VNvk8RCOIkAQcKNCB4=
X-Google-Smtp-Source: AGHT+IEsqNOSqGgGsp+64azNiE6BQN3Oyun3IARQaHDYKamOpOynPrKTjcW0Bs4EgmHDicXeJE1Lzg==
X-Received: by 2002:a05:600c:3c83:b0:426:706c:a55a with SMTP id 5b1f17b1804b1-427bb67fcfcmr30629405e9.2.1721196154921;
        Tue, 16 Jul 2024 23:02:34 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f09d1d8sm188634835e9.0.2024.07.16.23.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 23:02:34 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Matt Evans <mev@rivosinc.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/4] riscv: Add ISA extension parsing for Svvptc
Date: Wed, 17 Jul 2024 08:01:22 +0200
Message-Id: <20240717060125.139416-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717060125.139416-1-alexghiti@rivosinc.com>
References: <20240717060125.139416-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to parse the Svvptc string in the riscv,isa string.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..6dd0dd8beb30 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_SVVPTC		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 5ef48cb20ee1..60780d246743 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -305,6 +305,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
+	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.39.2


