Return-Path: <linux-kernel+bounces-533093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA81A455AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD8F3ADB19
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 06:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3250E27455;
	Wed, 26 Feb 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cClNN/kK"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1526773B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740551564; cv=none; b=L3eePu4fMsMC+ed/OvZ8SNU0mzX5BlXRG7hduNyJ/zbSs4ToCY6hocRxBbSItlxVvnmKlk3+pMPuQUpTLduuIJAbYStbPCDSFcsgPn0P5MKSGU5D5CNDLlbnF9kazRk1irjebJo2umaAEyF+sODZA6efWLUCyDt8WphtDDZ76wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740551564; c=relaxed/simple;
	bh=NqOUrka99DSUi18FOpq9XilJAxI+Dx6U6EraUGvZnFk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqU8974bZ3srWVVMo1EO8vLceCF1+xAWiy1Aoay3LjHqm5l7HEfNAYVHb/Yz3hSDOqhqFDDySXcNvjIf7vEB+CERjTOe1P+BTW5CzhsbCyQrRgK5o4rO/RWBV1JJgIsUtvOrM+gmPOE4BobJk+F9jAfoJlGOcl7u+D0oJ3gss90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cClNN/kK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc1c80cdc8so9859379a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 22:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740551562; x=1741156362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6H6/Xpe5szI3425MURKDC2kUnYsqHlXT/4n1BN4R7E=;
        b=cClNN/kKf3Ag/Jf81Njzu/dr376IYzR9AYZNF6pUbWSn/TTxadExPYirR9HUAKLman
         0oHXyz9mW7wz05rEZT9wQXM1YA/Td8EKmJqXwqlPVMgSAI3FbgBHYr/8bVkkhx4soBI0
         uadfr3ZnIgWuI2jTLHchGbBjiTYC9H/RN1F2y+Vk4RdibBtPJDnZj045iWw4AVPWKegW
         739XSl51rHWryG8/Tr9e/VtXjM+ZCmA1Jk3Ij8q9worThYF2PEymX1uxCI61013ykAam
         WtQwwTReGh4g24D0WHBHZmZzYJ4Epumu6T3bJC72rbX2WCG6fzREe8gKla4Ly8dxbh7t
         O5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740551562; x=1741156362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6H6/Xpe5szI3425MURKDC2kUnYsqHlXT/4n1BN4R7E=;
        b=tC4MSlWgtVzIsf20Eop+ux56w9syHPlr+DNihG3qcyeDNLZL9+DLQUn8RNYTaAA3G3
         ybzhiR924DhQYT5Abn7RQ8c6SALQ4nUguHhpNYwLyI5V++o9rZZKtwLJDYI9yBWNOAwC
         ZHldvfvc74XyV62N3/YVIUPN3GbimhAi+dGKfFwn0OxFtlcNYU0mYAIBKB6LvG0chlt9
         vRWJDm1YrKDtt1vpR7R0BdVayf7E8yvmsFSu7qPeDiAQYIRPTNgN9ATEB7t1R9B/0bAc
         kl+1sBsUyjfNACxaCDi9SEDTTniFbSYwB3t+MVbR8QS8R91Q+mzcVdWcSKABqGKRZ/dX
         SzRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo0udFU0pCe6wTskKlJZBNNZ8BKgrKv0/GIfNqya4lYPvo9uOmAUFnRGNS+i+Pkyfz7ArBNep4AKKbJ+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5XKdGehlt/hQd/z5gbiUVp8qRX54rzHMjSmuTEGzJbtR97EM5
	+sjE1Ec/nfiFGoWD2uQV3wIuHelK7LwtKissdJM72qHfCeV67xptkMLT8tIpDIo=
X-Gm-Gg: ASbGncsf1VgCLNMjAFzmgWJw5Dnnrq+oQsuuAhv2MCJ+ujwZg28jqhZwcSZYsHfaVR+
	rqic5+qwHT2L/zg6hemS3xNUGVtQp07V6fEoYE2tI6J5cGOWxSkSaxdjopYfcSftiv+93O/9ixV
	VFjK+ql/lM2ijsQKfppXvTFII59xgLyOYHLxBEele7rDRSSdFC974KpiYj+tSk6nxIRD4poXYrI
	MPK3uuwsyKhVB//3G3920hmcDK19ZpowhHqJ91FpFaxFBx/s+CM3yT3wYJcQYooY3akV4rstemU
	UVqVd21x3ktZ1Ih3Od2pkHKcwlHZMgXFUpcqsbCDzhxLxYUXgS0X3+DGybfx
X-Google-Smtp-Source: AGHT+IEdlez3a8zCoVcQhSExdtKJWaxRweBj5/bzxHVZ9RIDHfLdLR/jDGw16LdyFBY45f4pDOd51w==
X-Received: by 2002:a17:90a:cf8e:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-2fe7feaca86mr2608925a91.32.1740551562148;
        Tue, 25 Feb 2025 22:32:42 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe8284f152sm682599a91.46.2025.02.25.22.32.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Feb 2025 22:32:41 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v7 3/3] RISC-V: selftests: Add TEST_ZICBOM into CBO tests
Date: Wed, 26 Feb 2025 14:32:06 +0800
Message-Id: <20250226063206.71216-4-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250226063206.71216-1-cuiyunhui@bytedance.com>
References: <20250226063206.71216-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test for Zicbom and its block size into CBO tests, when
Zicbom is present, test that cbo.clean/flush may be issued and works.
As the software can't verify the clean/flush functions, we just judged
that cbo.clean/flush isn't executed illegally.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c | 66 +++++++++++++++++----
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..5e96ef785d0d 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -50,6 +50,14 @@ static void cbo_clean(char *base) { cbo_insn(base, 1); }
 static void cbo_flush(char *base) { cbo_insn(base, 2); }
 static void cbo_zero(char *base)  { cbo_insn(base, 4); }
 
+static void test_no_cbo_inval(void *arg)
+{
+	ksft_print_msg("Testing cbo.inval instruction remain privileged\n");
+	illegal_insn = false;
+	cbo_inval(&mem[0]);
+	ksft_test_result(illegal_insn, "No cbo.inval\n");
+}
+
 static void test_no_zicbom(void *arg)
 {
 	ksft_print_msg("Testing Zicbom instructions remain privileged\n");
@@ -61,10 +69,6 @@ static void test_no_zicbom(void *arg)
 	illegal_insn = false;
 	cbo_flush(&mem[0]);
 	ksft_test_result(illegal_insn, "No cbo.flush\n");
-
-	illegal_insn = false;
-	cbo_inval(&mem[0]);
-	ksft_test_result(illegal_insn, "No cbo.inval\n");
 }
 
 static void test_no_zicboz(void *arg)
@@ -81,6 +85,30 @@ static bool is_power_of_2(__u64 n)
 	return n != 0 && (n & (n - 1)) == 0;
 }
 
+static void test_zicbom(void *arg)
+{
+	struct riscv_hwprobe pair = {
+		.key = RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE,
+	};
+	cpu_set_t *cpus = (cpu_set_t *)arg;
+	__u64 block_size;
+	long rc;
+
+	rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)cpus, 0);
+	block_size = pair.value;
+	ksft_test_result(rc == 0 && pair.key == RISCV_HWPROBE_KEY_ZICBOM_BLOCK_SIZE &&
+			 is_power_of_2(block_size), "Zicbom block size\n");
+	ksft_print_msg("Zicbom block size: %llu\n", block_size);
+
+	illegal_insn = false;
+	cbo_clean(&mem[block_size]);
+	ksft_test_result(!illegal_insn, "cbo.clean\n");
+
+	illegal_insn = false;
+	cbo_flush(&mem[block_size]);
+	ksft_test_result(!illegal_insn, "cbo.flush\n");
+}
+
 static void test_zicboz(void *arg)
 {
 	struct riscv_hwprobe pair = {
@@ -129,7 +157,7 @@ static void test_zicboz(void *arg)
 	ksft_test_result_pass("cbo.zero check\n");
 }
 
-static void check_no_zicboz_cpus(cpu_set_t *cpus)
+static void check_no_zicbo_cpus(cpu_set_t *cpus, __u64 cbo)
 {
 	struct riscv_hwprobe pair = {
 		.key = RISCV_HWPROBE_KEY_IMA_EXT_0,
@@ -137,6 +165,7 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 	cpu_set_t one_cpu;
 	int i = 0, c = 0;
 	long rc;
+	char *cbostr;
 
 	while (i++ < CPU_COUNT(cpus)) {
 		while (!CPU_ISSET(c, cpus))
@@ -148,10 +177,13 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 		rc = riscv_hwprobe(&pair, 1, sizeof(cpu_set_t), (unsigned long *)&one_cpu, 0);
 		assert(rc == 0 && pair.key == RISCV_HWPROBE_KEY_IMA_EXT_0);
 
-		if (pair.value & RISCV_HWPROBE_EXT_ZICBOZ)
-			ksft_exit_fail_msg("Zicboz is only present on a subset of harts.\n"
-					   "Use taskset to select a set of harts where Zicboz\n"
-					   "presence (present or not) is consistent for each hart\n");
+		cbostr = cbo == RISCV_HWPROBE_EXT_ZICBOZ ? "Zicboz" : "Zicbom";
+
+		if (pair.value & cbo)
+			ksft_exit_fail_msg("%s is only present on a subset of harts.\n"
+					   "Use taskset to select a set of harts where %s\n"
+					   "presence (present or not) is consistent for each hart\n",
+					   cbostr, cbostr);
 		++c;
 	}
 }
@@ -159,7 +191,9 @@ static void check_no_zicboz_cpus(cpu_set_t *cpus)
 enum {
 	TEST_ZICBOZ,
 	TEST_NO_ZICBOZ,
+	TEST_ZICBOM,
 	TEST_NO_ZICBOM,
+	TEST_NO_CBO_INVAL,
 };
 
 static struct test_info {
@@ -169,7 +203,9 @@ static struct test_info {
 } tests[] = {
 	[TEST_ZICBOZ]		= { .nr_tests = 3, test_zicboz },
 	[TEST_NO_ZICBOZ]	= { .nr_tests = 1, test_no_zicboz },
-	[TEST_NO_ZICBOM]	= { .nr_tests = 3, test_no_zicbom },
+	[TEST_ZICBOM]		= { .nr_tests = 3, test_zicbom },
+	[TEST_NO_ZICBOM]	= { .nr_tests = 2, test_no_zicbom },
+	[TEST_NO_CBO_INVAL]	= { .nr_tests = 1, test_no_cbo_inval },
 };
 
 int main(int argc, char **argv)
@@ -189,6 +225,7 @@ int main(int argc, char **argv)
 		assert(rc == 0);
 		tests[TEST_NO_ZICBOZ].enabled = true;
 		tests[TEST_NO_ZICBOM].enabled = true;
+		tests[TEST_NO_CBO_INVAL].enabled = true;
 	}
 
 	rc = sched_getaffinity(0, sizeof(cpu_set_t), &cpus);
@@ -206,7 +243,14 @@ int main(int argc, char **argv)
 		tests[TEST_ZICBOZ].enabled = true;
 		tests[TEST_NO_ZICBOZ].enabled = false;
 	} else {
-		check_no_zicboz_cpus(&cpus);
+		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOZ);
+	}
+
+	if (pair.value & RISCV_HWPROBE_EXT_ZICBOM) {
+		tests[TEST_ZICBOM].enabled = true;
+		tests[TEST_NO_ZICBOM].enabled = false;
+	} else {
+		check_no_zicbo_cpus(&cpus, RISCV_HWPROBE_EXT_ZICBOM);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(tests); ++i)
-- 
2.39.2


