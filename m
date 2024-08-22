Return-Path: <linux-kernel+bounces-297958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CE895BFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD771C223B8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2231D0DF8;
	Thu, 22 Aug 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UeJy/+A7"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8F1D0DD8
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 20:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724359157; cv=none; b=UKgHr/5BbtVE4KLgiF8tSsiAJi01o57NmVJ0YF37hnjeVd2UTqjKXcncZpXPWSUtzXYn0uwbRWlKFzLkiVdcTHpXkD7OsTtJjK+l0rDcfgg6III1Mf3wB4RK38mztIUcaKHBd4fjh5mHNwloeYlvkycxKgxH3p4qQHIy1pGmcl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724359157; c=relaxed/simple;
	bh=tDCqrqpDYIv3O4fx5f8QNj6vedfwK8+6GsRpsKvRbkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwjFBoGYcqiI8rtWT/ohLLMh1UDhbDCiGXWNGIQR1XtCvoD7J0Opccqnf3LFYzB6fCaZvEZFeH6SPd5gIiDLfygtMr+Ac0wYjPEhuhurVNwK7dNnYGAxeVB1yZgyf4IxIE+0TnJoCkb0yWPq/FuvIIn3vdiyJ0VU8F9DPTQ16DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UeJy/+A7; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1d81dc0beso79857285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724359154; x=1724963954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aVFB9PSUxxNQxYSa9Dc2uzxRSZf/ScsRdF3Dy3pBcbw=;
        b=UeJy/+A7aLxBu6Y8zZIxOXDHqpasJL/8delrYD2b/lfL1pUemRj4d81w7D0FG9FsF/
         kHllOmbd6a8ftjFCdRtQgVV6AaNeW7PMK5QGEI/d7Si9L2VJSpQq0dmiYf6O7/eUwAOm
         gcazt9LzemsiC3vSYLZJUFYjsr4HJv6zSfWHVCuyl/+fUyZ2ehioueNZ6brQpu/n0U0m
         ohppTtPCMUrakc+vo2AchJo+1IeCiUFhl9T8w5tO2Cj92FnY6Ev3F1EsyLCF/fszwLwo
         ITP8oZuDWG8GDk8FLsSVBJT22qnU89mdVk9YSy/02ITic9/BJxL43TNVcLYtU6C7HALz
         OfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724359154; x=1724963954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVFB9PSUxxNQxYSa9Dc2uzxRSZf/ScsRdF3Dy3pBcbw=;
        b=LRlLyxuiJWLft2MqarqSpVkjElN4ttVvphv8FT5EBKKikYzf5hUOvO01jYBLEfUuL9
         eqGT0k6Xb2/fnv7FXGmhfn3VMgtki6YxQGUNPK1K/L/wLWGZKpVeniPGjaL7EDLZ30Mj
         szmb0KBkMC8CylR/WMOaiopPykjhWx2G/U5HMx0ortywqXrkOPMwT2CLbGoz2kImIqrN
         gnfI3x/7l+evyVGCPDOlyQyqTZ9leOcxhqroz+JOaHPo7ND0O18hRv0bkzsKaoXL+q0+
         6vl7PPs4XcRZF85nVbCuDtwFG9mYJ2s7cn1fLnu6K8C8L5waBsVi3NE2kZpvMxhxKGQQ
         LirQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtpPAnIQwHc1GyJAf1pf13tnDKF2XxI80AKX3bQzEv5P2kjBhwsLndq4V9p2fGopiTKAjXzbGO7y2hEiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSa5Mtb4s8zP6wGcTpipihQiRkPKqDBlBrnqeNSAI5+WA626b
	DdeU7T7Q/zRKKYK50+KLME/Amv7O2cYUbegSsQwT4h3qrrbRbnMiFsSSyuYRGxc=
X-Google-Smtp-Source: AGHT+IEoRpx83TwCTADpbTIPE8iEGIQ8Pwle6TGVihkq7WkEL+JaskxzQiEWVFEUECXATS3MnClPBw==
X-Received: by 2002:a05:620a:1990:b0:7a2:d64:1cbc with SMTP id af79cd13be357-7a680a57533mr449953785a.26.1724359154139;
        Thu, 22 Aug 2024 13:39:14 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f327ce2sm108846185a.1.2024.08.22.13.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 13:39:13 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>,
	Evan Green <evan@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Jesse Taube <jesse@rivosinc.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: hwprobe: Use BIT macro to avoid warnings
Date: Thu, 22 Aug 2024 16:39:12 -0400
Message-ID: <20240822203913.2306574-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uapi/asm/hwprobe.h file, (1 << N) is used to define the bit field
which causes checkpatch to warn. Use BIT(N) and BIT_ULL(N) to avoid
these warnings.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
---
V1 -> V2:
 - Reword commit message
---
 arch/riscv/include/uapi/asm/hwprobe.h | 102 +++++++++++++-------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index b706c8e47b02..d0874ff2fd37 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -21,57 +21,57 @@ struct riscv_hwprobe {
 #define RISCV_HWPROBE_KEY_MARCHID	1
 #define RISCV_HWPROBE_KEY_MIMPID	2
 #define RISCV_HWPROBE_KEY_BASE_BEHAVIOR	3
-#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	(1 << 0)
+#define		RISCV_HWPROBE_BASE_BEHAVIOR_IMA	BIT_ULL(0)
 #define RISCV_HWPROBE_KEY_IMA_EXT_0	4
-#define		RISCV_HWPROBE_IMA_FD		(1 << 0)
-#define		RISCV_HWPROBE_IMA_C		(1 << 1)
-#define		RISCV_HWPROBE_IMA_V		(1 << 2)
-#define		RISCV_HWPROBE_EXT_ZBA		(1 << 3)
-#define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
-#define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
-#define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
-#define		RISCV_HWPROBE_EXT_ZBC		(1 << 7)
-#define		RISCV_HWPROBE_EXT_ZBKB		(1 << 8)
-#define		RISCV_HWPROBE_EXT_ZBKC		(1 << 9)
-#define		RISCV_HWPROBE_EXT_ZBKX		(1 << 10)
-#define		RISCV_HWPROBE_EXT_ZKND		(1 << 11)
-#define		RISCV_HWPROBE_EXT_ZKNE		(1 << 12)
-#define		RISCV_HWPROBE_EXT_ZKNH		(1 << 13)
-#define		RISCV_HWPROBE_EXT_ZKSED		(1 << 14)
-#define		RISCV_HWPROBE_EXT_ZKSH		(1 << 15)
-#define		RISCV_HWPROBE_EXT_ZKT		(1 << 16)
-#define		RISCV_HWPROBE_EXT_ZVBB		(1 << 17)
-#define		RISCV_HWPROBE_EXT_ZVBC		(1 << 18)
-#define		RISCV_HWPROBE_EXT_ZVKB		(1 << 19)
-#define		RISCV_HWPROBE_EXT_ZVKG		(1 << 20)
-#define		RISCV_HWPROBE_EXT_ZVKNED	(1 << 21)
-#define		RISCV_HWPROBE_EXT_ZVKNHA	(1 << 22)
-#define		RISCV_HWPROBE_EXT_ZVKNHB	(1 << 23)
-#define		RISCV_HWPROBE_EXT_ZVKSED	(1 << 24)
-#define		RISCV_HWPROBE_EXT_ZVKSH		(1 << 25)
-#define		RISCV_HWPROBE_EXT_ZVKT		(1 << 26)
-#define		RISCV_HWPROBE_EXT_ZFH		(1 << 27)
-#define		RISCV_HWPROBE_EXT_ZFHMIN	(1 << 28)
-#define		RISCV_HWPROBE_EXT_ZIHINTNTL	(1 << 29)
-#define		RISCV_HWPROBE_EXT_ZVFH		(1 << 30)
-#define		RISCV_HWPROBE_EXT_ZVFHMIN	(1ULL << 31)
-#define		RISCV_HWPROBE_EXT_ZFA		(1ULL << 32)
-#define		RISCV_HWPROBE_EXT_ZTSO		(1ULL << 33)
-#define		RISCV_HWPROBE_EXT_ZACAS		(1ULL << 34)
-#define		RISCV_HWPROBE_EXT_ZICOND	(1ULL << 35)
-#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	(1ULL << 36)
-#define		RISCV_HWPROBE_EXT_ZVE32X	(1ULL << 37)
-#define		RISCV_HWPROBE_EXT_ZVE32F	(1ULL << 38)
-#define		RISCV_HWPROBE_EXT_ZVE64X	(1ULL << 39)
-#define		RISCV_HWPROBE_EXT_ZVE64F	(1ULL << 40)
-#define		RISCV_HWPROBE_EXT_ZVE64D	(1ULL << 41)
-#define		RISCV_HWPROBE_EXT_ZIMOP		(1ULL << 42)
-#define		RISCV_HWPROBE_EXT_ZCA		(1ULL << 43)
-#define		RISCV_HWPROBE_EXT_ZCB		(1ULL << 44)
-#define		RISCV_HWPROBE_EXT_ZCD		(1ULL << 45)
-#define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
-#define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
-#define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_IMA_FD		BIT_ULL(0)
+#define		RISCV_HWPROBE_IMA_C		BIT_ULL(1)
+#define		RISCV_HWPROBE_IMA_V		BIT_ULL(2)
+#define		RISCV_HWPROBE_EXT_ZBA		BIT_ULL(3)
+#define		RISCV_HWPROBE_EXT_ZBB		BIT_ULL(4)
+#define		RISCV_HWPROBE_EXT_ZBS		BIT_ULL(5)
+#define		RISCV_HWPROBE_EXT_ZICBOZ	BIT_ULL(6)
+#define		RISCV_HWPROBE_EXT_ZBC		BIT_ULL(7)
+#define		RISCV_HWPROBE_EXT_ZBKB		BIT_ULL(8)
+#define		RISCV_HWPROBE_EXT_ZBKC		BIT_ULL(9)
+#define		RISCV_HWPROBE_EXT_ZBKX		BIT_ULL(10)
+#define		RISCV_HWPROBE_EXT_ZKND		BIT_ULL(11)
+#define		RISCV_HWPROBE_EXT_ZKNE		BIT_ULL(12)
+#define		RISCV_HWPROBE_EXT_ZKNH		BIT_ULL(13)
+#define		RISCV_HWPROBE_EXT_ZKSED		BIT_ULL(14)
+#define		RISCV_HWPROBE_EXT_ZKSH		BIT_ULL(15)
+#define		RISCV_HWPROBE_EXT_ZKT		BIT_ULL(16)
+#define		RISCV_HWPROBE_EXT_ZVBB		BIT_ULL(17)
+#define		RISCV_HWPROBE_EXT_ZVBC		BIT_ULL(18)
+#define		RISCV_HWPROBE_EXT_ZVKB		BIT_ULL(19)
+#define		RISCV_HWPROBE_EXT_ZVKG		BIT_ULL(20)
+#define		RISCV_HWPROBE_EXT_ZVKNED	BIT_ULL(21)
+#define		RISCV_HWPROBE_EXT_ZVKNHA	BIT_ULL(22)
+#define		RISCV_HWPROBE_EXT_ZVKNHB	BIT_ULL(23)
+#define		RISCV_HWPROBE_EXT_ZVKSED	BIT_ULL(24)
+#define		RISCV_HWPROBE_EXT_ZVKSH		BIT_ULL(25)
+#define		RISCV_HWPROBE_EXT_ZVKT		BIT_ULL(26)
+#define		RISCV_HWPROBE_EXT_ZFH		BIT_ULL(27)
+#define		RISCV_HWPROBE_EXT_ZFHMIN	BIT_ULL(28)
+#define		RISCV_HWPROBE_EXT_ZIHINTNTL	BIT_ULL(29)
+#define		RISCV_HWPROBE_EXT_ZVFH		BIT_ULL(30)
+#define		RISCV_HWPROBE_EXT_ZVFHMIN	BIT_ULL(31)
+#define		RISCV_HWPROBE_EXT_ZFA		BIT_ULL(32)
+#define		RISCV_HWPROBE_EXT_ZTSO		BIT_ULL(33)
+#define		RISCV_HWPROBE_EXT_ZACAS		BIT_ULL(34)
+#define		RISCV_HWPROBE_EXT_ZICOND	BIT_ULL(35)
+#define		RISCV_HWPROBE_EXT_ZIHINTPAUSE	BIT_ULL(36)
+#define		RISCV_HWPROBE_EXT_ZVE32X	BIT_ULL(37)
+#define		RISCV_HWPROBE_EXT_ZVE32F	BIT_ULL(38)
+#define		RISCV_HWPROBE_EXT_ZVE64X	BIT_ULL(39)
+#define		RISCV_HWPROBE_EXT_ZVE64F	BIT_ULL(40)
+#define		RISCV_HWPROBE_EXT_ZVE64D	BIT_ULL(41)
+#define		RISCV_HWPROBE_EXT_ZIMOP		BIT_ULL(42)
+#define		RISCV_HWPROBE_EXT_ZCA		BIT_ULL(43)
+#define		RISCV_HWPROBE_EXT_ZCB		BIT_ULL(44)
+#define		RISCV_HWPROBE_EXT_ZCD		BIT_ULL(45)
+#define		RISCV_HWPROBE_EXT_ZCF		BIT_ULL(46)
+#define		RISCV_HWPROBE_EXT_ZCMOP		BIT_ULL(47)
+#define		RISCV_HWPROBE_EXT_ZAWRS		BIT_ULL(48)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
@@ -85,6 +85,6 @@ struct riscv_hwprobe {
 /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
 
 /* Flags */
-#define RISCV_HWPROBE_WHICH_CPUS	(1 << 0)
+#define RISCV_HWPROBE_WHICH_CPUS	BIT(0)
 
 #endif
-- 
2.45.2


