Return-Path: <linux-kernel+bounces-204890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9D88FF4B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17BB28F4CF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCC84652D;
	Thu,  6 Jun 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kGMKl4HY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BC282F4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698754; cv=none; b=aDqvJI1/yKEE3XykK6r70Kx4HGkL+nnVNREHAnF0NkgGvio+ESky4i17Jzp0Z/ZnsCWIHmGjd6fRapt8bmEhy8x0HLWj6e4PCRqj5lvX+L4+823+UNNFCyiSgVtFg3cE9iuCKjurT9QOdFXMNS+XUR52n1w0xb6tPY80TRHHkyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698754; c=relaxed/simple;
	bh=qo5Fp+94MFzodZ7tHH/90f9zqTpsIE0APgCFKDlFrMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VYQMs/YVxPFyRfrWXHTcDsIlmu90eiQIiUn1LIFPcrh5PVICjjbc05jQaVWiPea7vFtYdJbezXlJgLFjB4s+F6l2FFhEIyVfwBAY1+ft9i0Lu+urqFK+IQDZh/BbuMF6QuB4fWEIQxHKJwJ3OpsFJTx6kPI4jagLP5MBltYGy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kGMKl4HY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-702508bf0a9so1084292b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1717698751; x=1718303551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XHQ4xY0/ZycwaDFTeaCf9+bM8HlQPdbfiT+ZJ9McmuU=;
        b=kGMKl4HYo+NAC4Sn/WFaoMv6XP0qJ0wjkb2RMeUYaoPulUzVznrThaZZbxuCacbYhH
         xx4qYwrqvQKQQIY4VUjcuJsuboZ5NbNs5awEuHkIJJ7p06YjDRCZYS3aLS4Plb3Yc1Xk
         5MpOSXB1GEz2s+RFYSfaQZgYz8vSPs+SRPUdpAfbaupIxNHc4fdE5E/qA7AyoOKV1OH2
         1KIX2YX9AZ/0QGu1674GiDg2zULmKh21Cu8/55zZWkxIYpxf/DWAtNul4/ECzLT/N7+3
         94RVX8aw+XB7t0fcbmPDdXjjBTprimU/WLaoFCdEK1J42ad7r/Xpsog1c8yrlX4YvAZV
         hbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717698751; x=1718303551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XHQ4xY0/ZycwaDFTeaCf9+bM8HlQPdbfiT+ZJ9McmuU=;
        b=ATCaKsqIKZbnB4pkCi7cN7Lrh/zRheCVDYyyWUIYuoEY7Ao23AYARg/ROlrZ4F0Qk1
         W4ok/7RkCKPN0dC7oSldDE0bCMGFr/UAG+YYYNgeMH+aPwzw+B7oRwDNoo/IKcEgWBaB
         PNI6hVtc2fF0sEjrEXXXuLeStGscSToMzdgCwqlLpiKO9RB9j+GjeGBR7wptmHBT2Sd0
         CgyKwR04tbalctGmvwMyxTDzMxZxMHAWUYFJggs10V8i1kc+5FRce2v97AMKjzomM2wZ
         950MSJV9lnov6TNIgUt6sIcZhUrSe7g5mYE3X0dehHTBb2/MfcOScQVOeg3QktH6qT2c
         UY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoFoG4jf5KQxBUAcvYJWYGwxDj6g59kDYsnKKFL9suJ7FtrNsbeJO+Qtq4Zx4iSnMBsx3O39d9tJANWWmbG9dPfe2XhM6xMqixm59r
X-Gm-Message-State: AOJu0Yw6G1NaGZoXScO9uOF6tEfIoYogk/ijp7CG9GtbqPrQGuQK1dWr
	XLofsaQIWV457JXmujw045QSsF8M0JOQnLbsUznFGY8ppjKm0FgUAMgPAadWYbY=
X-Google-Smtp-Source: AGHT+IE7uVUmqhwWIRRmVbjMZN707tZ0ufiL2FY4wEF2ttUqm8YDlay8qBTPoUJh4t9AHRrtXZ/ztA==
X-Received: by 2002:a05:6a00:9aa:b0:702:5a22:3ccc with SMTP id d2e1a72fcca58-7040c749549mr201330b3a.33.1717698751529;
        Thu, 06 Jun 2024 11:32:31 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50f0c6sm1378400b3a.191.2024.06.06.11.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 11:32:31 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor.dooley@microchip.com>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Guo Ren <guoren@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Erick Archer <erick.archer@gmx.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] RISC-V: Add Zicclsm to cpufeature and hwprobe
Date: Thu,  6 Jun 2024 14:32:13 -0400
Message-ID: <20240606183215.416829-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Zicclsm Misaligned loads and stores to main memory regions with both
> the cacheability and coherence PMAs must be supported.
> Note:
> This introduces a new extension name for this feature.
> This requires misaligned support for all regular load and store
> instructions (including scalar and vector) but not AMOs or other
> specialized forms of memory access. Even though mandated, misaligned
> loads and stores might execute extremely slowly. Standard software
> distributions should assume their existence only for correctness,
> not for performance.

Detecing zicclsm allows the kernel to report if the
hardware supports misaligned accesses even if support wasn't probed.

This is useful for usermode to know if vector misaligned accesses are
supported.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
 arch/riscv/include/asm/hwcap.h        | 1 +
 arch/riscv/include/uapi/asm/hwprobe.h | 1 +
 arch/riscv/kernel/cpufeature.c        | 1 +
 arch/riscv/kernel/sys_hwprobe.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index e17d0078a651..8c0d0b555a8e 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -81,6 +81,7 @@
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
 #define RISCV_ISA_EXT_XANDESPMU		74
+#define RISCV_ISA_EXT_ZICCLSM		75
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 2902f68dc913..060212331a03 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -59,6 +59,7 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
 #define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
 #define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
+#define		RISCV_HWPROBE_EXT_ZICCLSM	(1ULL << 36)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..863c708f2f2e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -305,6 +305,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
+	__RISCV_ISA_EXT_DATA(zicclsm, RISCV_ISA_EXT_ZICCLSM),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 8cae41a502dd..b286b73e763e 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -125,6 +125,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 			EXT_KEY(ZVKT);
 			EXT_KEY(ZVFH);
 			EXT_KEY(ZVFHMIN);
+			EXT_KEY(ZICCLSM);
 		}
 
 		if (has_fpu()) {
-- 
2.43.0


