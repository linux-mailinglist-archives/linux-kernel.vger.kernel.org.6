Return-Path: <linux-kernel+bounces-292673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9732195729B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4023F283F91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43CD188CA6;
	Mon, 19 Aug 2024 18:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rVksU7Oz"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09BA1CAAF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 18:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090689; cv=none; b=SLxfxUvC1IHoVDbofBBCTzj06Xx+EWeoaoQEIFBJSRSY7o90uqAWgsE6/MqEJIwbJW+hWGj72VVw5E+X6QZ36POPo5ibklKxxu76TO/01MAqs5cNj8kPEZyDVJ2QE+2KUzSziVCaXkL4Usw5wB9VvsnOYSanRwBHlNYe8Da3A4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090689; c=relaxed/simple;
	bh=qv6Xwgzs2ZEztiuS4SXbDSC2KAR7OjiYQiuvISL8968=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvrfHAUQh7KN2zWjExDRMh5/3+JUiwYHjRBucYyi8BDx3Otk0DCAwyRIABikbuIwlzVFG5Mh+pv0SCcnCvMthoPQCOBt1jUAr5RQ5rjrqWc8Z7EeU9RVb0DsuH763TEvC4H57IbRY4Z46uJsvy0wAS8fspGnYe034pXhZ6AAn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rVksU7Oz; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7140962ac9eso30177b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724090687; x=1724695487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRCst/mJFl2Z5sGmOEBBU5/Fl/39H0BD6NmUA32/Xac=;
        b=rVksU7OzvkGSi6dCuTVbCDjdK4swGGqkZn8ULZ0HorOGXYsUhFmaRNLRpGGfPeZop7
         qM+jiRgz1ODAnLt8LsbJSUYhhkXYeBqf/01b7odLNj1eFdlnLk+z2J7JIxwMSF0ncvQR
         OOAJgwNCXoE1aQiLIuDEtUZXQBUMvH37yKDg4VDz5wOn8QP9qstNr/EtjX3/U0wlSjnF
         +NXCoktTcOztLaN50H/wJNb3uSjBjwv5oZU0K4N9Ny4ysj6Wk9ZLt45X5/jjCTGqH3T0
         7JyKTt7+3lrnhZ1fo392Ri5hzeiPOPtYYn4GlbARWR7Ofs4RBBVTxQkLeLazJ4uj1YR3
         FXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724090687; x=1724695487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oRCst/mJFl2Z5sGmOEBBU5/Fl/39H0BD6NmUA32/Xac=;
        b=jqmQR5vAjOAXzZ+pQHa88AGgH6u6r5EtATeTFm6eyFATKpdQSrBQKtp+5YiCmhgjid
         JhLqZHXYGsHamGYh9kDzoJ3t5Q1Ta5I4ymyBBUmA6phIwcrR5O9Vx9FdkvDbWtzmedgX
         gU2uI2gwBKNjhz/34HGM5nGMRos9BZzBkk0xL2xJAlAdba7x/fjkBkCe8qxQqGotwZUx
         8WQUgHTgODcXbgu5wt17j7S00Y4bIotifqrB+NHXl+Q6VJ0Fq/IGK2LTIlmy1o9TyC/U
         fBiCinrwbbzJQXNYrygW29amdqTfEdAwRLbMT3qFoOfjppW1s3oiJsAP8jZBLJvmaFxR
         5MiA==
X-Forwarded-Encrypted: i=1; AJvYcCW7dDZczmBGr8Q1xRgRiIuio8buamAobYVwafi0lOiBjde33F8itGgk0L161QhZ4PrlsPWykpUVaXeP9/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/LLP1mJ7oA+/CFWznhBfGA3qdxBiovRe8GreWrVlei0RgcYk
	sF6r9DfF6ZbW1J3wyN/hLoRvaF9Jok7S2YByue410jDBAThd7naX4BLmkf/aWa4=
X-Google-Smtp-Source: AGHT+IGxAiLTim6Ov8tR0HmBj/x1W1FepMhWEnzMwXhbeDlv2es5Fx4JZULBVKA0Tici7M3baSfe8g==
X-Received: by 2002:a05:6a00:3cd2:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-714081b6755mr593351b3a.8.1724090686862;
        Mon, 19 Aug 2024 11:04:46 -0700 (PDT)
Received: from jesse-desktop.ba.rivosinc.com (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5457sm6846498b3a.127.2024.08.19.11.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:04:46 -0700 (PDT)
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
Subject: [PATCH v1] RISC-V: hwprobe: Use BIT macro to avoid warnings
Date: Mon, 19 Aug 2024 14:04:43 -0400
Message-ID: <20240819180443.1774641-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uapi/asm/hwprobe.h file, (1 << N) is used to define the bit feild
this causes checkpatch to warn. Use BIT(N) and BIT_ULL(N) to avoid
warnings.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
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


