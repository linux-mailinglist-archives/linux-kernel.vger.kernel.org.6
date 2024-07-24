Return-Path: <linux-kernel+bounces-261448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB4293B77C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF7F1C23BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B021741C5;
	Wed, 24 Jul 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="axCysORr"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7F172BDE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848471; cv=none; b=VHbD59y2+kv/eTbN/CFEzeG4IadDJcCQZlKr8NVUcu9NPvSYPNEB1QmP2Kf+ln53ULJm5SeZvwy7HmFeT1eQ9onfT5U4A9i8UCN4Xal7rrkeNGa+totpNHGGvV6KDy87k85Ul7xfYc5VciMv+UXXSaEvTarQSmOlfrmQcZOIUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848471; c=relaxed/simple;
	bh=9w7dBpv+20Zqh2hfnY2iaYlSIT6IIR7L7F4Z0i1nJ5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCnD5+nTMxptGiBlPZxL5Ne2Dk2hNzMpYD/O0hkaCjwnUZhBAzX1J19hk3e8coNT6g8DguRPYf6/xbpX5ZXF/7h+ggveiigxcKPeOb6U7LBSTb1+FBucMfrlnS58r+UV8f66TstSVblSFWEra1Zb35PIBGC2hiZO/dzjSmgX/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=axCysORr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb682fb0cdso116430a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721848469; x=1722453269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9n2f4kq3fPmLVWerTpucYYwN/E7TPJTN4fKyHj2upcE=;
        b=axCysORrCoHkiBaKFKc8MTSUyst2WFdqFYnUxTZB5Y634RbP5KTb2CU6aZGQrWsUDa
         e+PdEZMqCuxtjZYkMYnMsn7HClqm8rZBEW+5t0GlPdl9jVsQYZB/rcQNUXUudkEyTSSp
         m1OeGA5YPHH4UpQ1yzrYvTRswFl86D6MRqdap96IvAhQIIUzENUPQJ4KIe+MZUk26nBe
         b6uyUxkO+wU9h02uTa87D6jTsHxl8vfnDK3sfaWrcKyp43ojbYQuu7xQc9DocvYV/JQI
         gcdqxSPCClx037kQHEbTR9BVZUqnpPGSFXio/k343uRGxqfO+zxNwpfCx+6PNTTMTCO6
         HwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721848469; x=1722453269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n2f4kq3fPmLVWerTpucYYwN/E7TPJTN4fKyHj2upcE=;
        b=tu4Wer3lL386o7OiOWJ2/HHka2e0L0DVdw6o46IJvvL1wjmn4zU9t7hNHm7PMT13m1
         mM7vB+4awTDOEvbqXcSoTGYig25x1c2vTlSe1FzVM/hf/5tnk9F/mRutwY2/1VnEM6vi
         4l/Qu4pOHNDs2fzZ0VOpsZif4/itj1v1TnMoPDKfrdzO6WSuYfUM8CVebg92f6g9E+zJ
         eeU9+bYYIKBsh84HkW4Dktyclc5S/aClXDwlqslZVAWv8ey8LZ47j2ttqbS0W3wDQ2t4
         VpOZ8wDttC8gNMaMFGg4eiD63M2kvk1sJ11R5lxJSFn3YiRKqOVUPyGHDQkHNbvXlvJ2
         5iOg==
X-Forwarded-Encrypted: i=1; AJvYcCV8EU9+skT6ErYHX/1p5e293s1G+BvMdQpw7NcCkSVAwO4w9eNMHH6IgYjGjIOKHYPEcFNV6rKW+wmZIi+aBM9Lfnte2fK/OmykryWJ
X-Gm-Message-State: AOJu0Yy7sgVywsfSjQmLyosnE5WRg/Q1ty0L5c3JF3lbeQLZSUK2CbBL
	eemUoU+utmmhJ3I9XGRs1ORU9E1HL6v7zUraMyUo8kw/Jz5vC5eSJib/65Jofaw=
X-Google-Smtp-Source: AGHT+IEZ2eSQz9/NkyDTRtS2JLM/PD44YW3y91s1dByPYA2nrfdLSOUMecEljdqwJPMe+E0Ah2wvng==
X-Received: by 2002:a17:90a:de98:b0:2c9:69cc:3a6f with SMTP id 98e67ed59e1d1-2cf238faad3mr492871a91.31.1721848468746;
        Wed, 24 Jul 2024 12:14:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73edecesm2022359a91.32.2024.07.24.12.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 12:14:28 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 24 Jul 2024 12:14:04 -0700
Subject: [PATCH v7 13/13] selftests: riscv: Support xtheadvector in vector
 tests
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-xtheadvector-v7-13-b741910ada3e@rivosinc.com>
References: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
In-Reply-To: <20240724-xtheadvector-v7-0-b741910ada3e@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721848437; l=13279;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=9w7dBpv+20Zqh2hfnY2iaYlSIT6IIR7L7F4Z0i1nJ5w=;
 b=zp4rJJzPPCLuQpXDIQ2CmSZF36miPWkAOnsPCKR7+26zriWTWY3uuz3GOOAIg4gaa9qiQOVQd
 hEf4ts7hoiGCFYOrbkIO5vaL0wSDcYOUiO+5qvNJILgqK0kPiBX3PM8
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Extend existing vector tests to be compatible with the xtheadvector
instructions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 .../selftests/riscv/vector/v_exec_initval_nolibc.c | 23 ++++--
 tools/testing/selftests/riscv/vector/v_helpers.c   | 17 +++-
 tools/testing/selftests/riscv/vector/v_helpers.h   |  4 +-
 tools/testing/selftests/riscv/vector/v_initval.c   | 12 ++-
 .../selftests/riscv/vector/vstate_exec_nolibc.c    | 20 +++--
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 91 ++++++++++++++--------
 6 files changed, 115 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
index 74b13806baf0..6f40c2acc0c2 100644
--- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
@@ -18,13 +18,22 @@ int main(int argc, char **argv)
 	unsigned long vl;
 	int first = 1;
 
-	asm volatile (
-		".option push\n\t"
-		".option arch, +v\n\t"
-		"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
-		".option pop\n\t"
-		: [vl] "=r" (vl)
-	);
+	if (argc > 2 && strcmp(argv[2], "x"))
+		asm volatile (
+			// 0 | zimm[10:0] | rs1 | 1 1 1 | rd |1010111| vsetvli
+			// vsetvli	t4, x0, e8, m1, d1
+			".4byte		0b00000000000000000111111011010111\n\t"
+			"mv		%[vl], t4\n\t"
+			: [vl] "=r" (vl) : : "t4"
+		);
+	else
+		asm volatile (
+			".option push\n\t"
+			".option arch, +v\n\t"
+			"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
+			".option pop\n\t"
+			: [vl] "=r" (vl)
+		);
 
 #define CHECK_VECTOR_REGISTER(register) ({					\
 	for (int i = 0; i < vl; i++) {						\
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.c b/tools/testing/selftests/riscv/vector/v_helpers.c
index d50f4dfbf9e5..01a8799dcb78 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.c
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -1,12 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "../hwprobe/hwprobe.h"
+#include <asm/vendor/thead.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/wait.h>
 
+bool is_xtheadvector_supported(void)
+{
+	struct riscv_hwprobe pair;
+
+	pair.key = RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0;
+	riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	return pair.value & RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR;
+}
+
 bool is_vector_supported(void)
 {
 	struct riscv_hwprobe pair;
@@ -16,9 +26,9 @@ bool is_vector_supported(void)
 	return pair.value & RISCV_HWPROBE_EXT_ZVE32X;
 }
 
-int launch_test(char *next_program, int test_inherit)
+int launch_test(char *next_program, int test_inherit, int xtheadvector)
 {
-	char *exec_argv[3], *exec_envp[1];
+	char *exec_argv[4], *exec_envp[1];
 	int rc, pid, status;
 
 	pid = fork();
@@ -30,7 +40,8 @@ int launch_test(char *next_program, int test_inherit)
 	if (!pid) {
 		exec_argv[0] = next_program;
 		exec_argv[1] = test_inherit != 0 ? "x" : NULL;
-		exec_argv[2] = NULL;
+		exec_argv[2] = xtheadvector != 0 ? "x" : NULL;
+		exec_argv[3] = NULL;
 		exec_envp[0] = NULL;
 		/* launch the program again to check inherit */
 		rc = execve(next_program, exec_argv, exec_envp);
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.h b/tools/testing/selftests/riscv/vector/v_helpers.h
index faeeeb625b6e..763cddfe26da 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.h
+++ b/tools/testing/selftests/riscv/vector/v_helpers.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <stdbool.h>
 
+bool is_xtheadvector_supported(void);
+
 bool is_vector_supported(void);
 
-int launch_test(char *next_program, int test_inherit);
+int launch_test(char *next_program, int test_inherit, int xtheadvector);
diff --git a/tools/testing/selftests/riscv/vector/v_initval.c b/tools/testing/selftests/riscv/vector/v_initval.c
index f38b5797fa31..be9e1d18ad29 100644
--- a/tools/testing/selftests/riscv/vector/v_initval.c
+++ b/tools/testing/selftests/riscv/vector/v_initval.c
@@ -7,10 +7,16 @@
 
 TEST(v_initval)
 {
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	int xtheadvector = 0;
 
-	ASSERT_EQ(0, launch_test(NEXT_PROGRAM, 0));
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
+
+	ASSERT_EQ(0, launch_test(NEXT_PROGRAM, 0, xtheadvector));
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
index 1f9969bed235..7b7d6f21acb4 100644
--- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
@@ -6,13 +6,16 @@
 
 int main(int argc, char **argv)
 {
-	int rc, pid, status, test_inherit = 0;
+	int rc, pid, status, test_inherit = 0, xtheadvector = 0;
 	long ctrl, ctrl_c;
 	char *exec_argv[2], *exec_envp[2];
 
-	if (argc > 1)
+	if (argc > 1 && strcmp(argv[1], "x"))
 		test_inherit = 1;
 
+	if (argc > 2 && strcmp(argv[2], "x"))
+		xtheadvector = 1;
+
 	ctrl = my_syscall1(__NR_prctl, PR_RISCV_V_GET_CONTROL);
 	if (ctrl < 0) {
 		puts("PR_RISCV_V_GET_CONTROL is not supported\n");
@@ -53,11 +56,14 @@ int main(int argc, char **argv)
 				puts("child's vstate_ctrl not equal to parent's\n");
 				exit(-1);
 			}
-			asm volatile (".option push\n\t"
-				      ".option arch, +v\n\t"
-				      "vsetvli x0, x0, e32, m8, ta, ma\n\t"
-				      ".option pop\n\t"
-				      );
+			if (xtheadvector)
+				asm volatile (".4byte	0x00007ed7");
+			else
+				asm volatile (".option push\n\t"
+					".option arch, +v\n\t"
+					"vsetvli x0, x0, e32, m8, ta, ma\n\t"
+					".option pop\n\t"
+					);
 			exit(ctrl);
 		}
 	}
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 850a0caa226e..3d79f266cc65 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -11,7 +11,7 @@
 
 #define NEXT_PROGRAM "./vstate_exec_nolibc"
 
-int test_and_compare_child(long provided, long expected, int inherit)
+int test_and_compare_child(long provided, long expected, int inherit, int xtheadvector)
 {
 	int rc;
 
@@ -21,7 +21,7 @@ int test_and_compare_child(long provided, long expected, int inherit)
 		       provided, rc);
 		return -1;
 	}
-	rc = launch_test(NEXT_PROGRAM, inherit);
+	rc = launch_test(NEXT_PROGRAM, inherit, xtheadvector);
 	if (rc != expected) {
 		printf("Test failed, check %d != %ld\n", rc,  expected);
 		return -2;
@@ -36,7 +36,7 @@ TEST(get_control_no_v)
 {
 	long rc;
 
-	if (is_vector_supported())
+	if (is_vector_supported() || is_xtheadvector_supported())
 		SKIP(return, "Test expects vector to be not supported");
 
 	rc = prctl(PR_RISCV_V_GET_CONTROL);
@@ -48,7 +48,7 @@ TEST(set_control_no_v)
 {
 	long rc;
 
-	if (is_vector_supported())
+	if (is_vector_supported() || is_xtheadvector_supported())
 		SKIP(return, "Test expects vector to be not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
@@ -61,12 +61,12 @@ TEST(vstate_on_current)
 	long flag;
 	long rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_ON;
 	rc = prctl(PR_RISCV_V_SET_CONTROL, flag);
-	EXPECT_EQ(0, rc) TH_LOG("Enabling V for current should always success");
+	EXPECT_EQ(0, rc) TH_LOG("Enabling V for current should always succeed");
 }
 
 TEST(vstate_off_eperm)
@@ -74,99 +74,128 @@ TEST(vstate_off_eperm)
 	long flag;
 	long rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF;
 	rc = prctl(PR_RISCV_V_SET_CONTROL, flag);
-	EXPECT_EQ(EPERM, errno) TH_LOG("Disabling current's V alive must fail with EPERM(%d)", errno);
-	EXPECT_EQ(-1, rc) TH_LOG("Disabling current's V alive must fail with EPERM(%d)", errno);
+	EXPECT_EQ(EPERM, errno) TH_LOG("Disabling V in current thread with V enabled must fail with EPERM(%d)", errno);
+	EXPECT_EQ(-1, rc) TH_LOG("Disabling V in current thread with V enabled must fail with EPERM(%d)", errno);
 }
 
 TEST(vstate_on_no_nesting)
 {
 	long flag;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn on next's vector explicitly and test */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_ON, 0));
+	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_ON, 0, xtheadvector));
 }
 
 TEST(vstate_off_nesting)
 {
 	long flag;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn off next's vector explicitly and test */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_OFF, 1));
+	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_OFF, 1, xtheadvector));
 }
 
 TEST(vstate_on_inherit_no_nesting)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn on next's vector explicitly and test no inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_ON;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0, xtheadvector));
 }
 
 TEST(vstate_on_inherit)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn on next's vector explicitly and test inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_ON;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1, xtheadvector));
 }
 
 TEST(vstate_off_inherit_no_nesting)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
-
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 	/* Turn off next's vector explicitly and test no inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_OFF;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0, xtheadvector));
 }
 
 TEST(vstate_off_inherit)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn off next's vector explicitly and test inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_OFF;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1, xtheadvector));
 }
 
 /* arguments should fail with EINVAL */
@@ -174,7 +203,7 @@ TEST(inval_set_control_1)
 {
 	int rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xff0);
@@ -187,7 +216,7 @@ TEST(inval_set_control_2)
 {
 	int rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0x3);
@@ -200,7 +229,7 @@ TEST(inval_set_control_3)
 {
 	int rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xc);

-- 
2.44.0


