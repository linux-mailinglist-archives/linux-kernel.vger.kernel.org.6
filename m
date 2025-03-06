Return-Path: <linux-kernel+bounces-549770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4240A5571A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385A21898D78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A6A2702CF;
	Thu,  6 Mar 2025 19:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="Woqq7Kca"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F018B47D
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290595; cv=none; b=uk/MKXXOFSYKGaxG/vV941MNRzCXlK/ekbKNCIAbMX6V6nFMbnjTb4o/QN0mpQJoeV4QD57mfiup5GusPrwqdOHssvnow65WVPABtt6+iM2Kc6NdRRSjfTNxUKhN3vCcQppNB6HQtk75u5sqGmck/YycSmnqLFIZSyW4cbef5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290595; c=relaxed/simple;
	bh=I7/pS/ZjDOrhdm0B+91sVfRepedE7aeBt8yijFHJB38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=acSSik2Mbkj0KLgHAZzZgvdTqFyvZIB0+wvn94VNy2gH9RID18GN9gRxeOUcu1mY4957PtpAw/hUVukiXLwGYnT40DdtZguTHZ/UCO7edSW6isS1WxI4KqkU0i/ztzDp0HNciZcJAoNPgWjzhaQmzxZxWeA6GtbvtGSd6/Oj9g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=Woqq7Kca; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741290581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1pLENHPcmZUPIKEuLyD6Q5KL/3y3ps8NKG8+iORBPzI=;
	b=Woqq7KcaOuw73MND/CJ+dS09hGfOAOtzBgcT+dtblRLADUAHmiaT1Q0L4JXXvkCGBjvoeR
	z7d0fU0PyBnqDdsD8ZhIlk1gtGs6QEcWfg+XYtMSj5tLjWyKjqruCC2J8Sod6yp2aPyka1
	hKQcUH+4oo7XThVmvI0AyRJ1z5JbO6Q1SnKVJJnRHsBivZcFn1G5wbW/CjFeOjETE3vaph
	9k9tGJvGYMG6aYdYg621dQnntElEgRy6l3VMQyvFeQPESZHTlWKr7d7Hu8VkexFqIswLti
	wZu8tAr56eMwCruUdBCcSBA3qRRyEC0ysv6RcicjIoFxpiuDaH2CaSGLAFkTTQ==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Thu, 06 Mar 2025 20:49:27 +0100
Subject: [PATCH v2] selftests: riscv: fix v_exec_initval_nolibc.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-fix-v_exec_initval_nolibc-v2-1-97f9dc8a7faf@iencinas.com>
X-B4-Tracking: v=1; b=H4sIAEb8yWcC/32NywrCMBREf6XctZE8+nTlf0gpSXq1F2oiSQmV0
 n83Fty6PMPMmQ0iBsIIl2KDgIkieZdBngqwk3YPZDRmBsllxRUX7E4rSwOuaAdytCQ9D87PZCw
 ru3bsmtqqRo6Q96+AuXy4b33mieLiw/u4SuKb/qzVH2sSTDDTNqbmWCrO5ZXQWXI6nq1/Qr/v+
 wdmehr5xQAAAA==
X-Change-ID: 20250301-fix-v_exec_initval_nolibc-498d976c372d
To: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, 
 Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

Vector registers are zero initialized by the kernel. Stop accepting
"all ones" as a clean value.

Note that this was not working as expected given that
	value == 0xff
can be assumed to be always false by the compiler as value's range is
[-128, 127]. Both GCC (-Wtype-limits) and clang
(-Wtautological-constant-out-of-range-compare) warn about this.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
Changes in v2:

Remove code that becomes useless now that the only "clean" value for
vector registers is 0.

- Link to v1: https://lore.kernel.org/r/20250305-fix-v_exec_initval_nolibc-v1-1-b87b60e43002@iencinas.com
---
 tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
index 35c0812e32de0c82a54f84bd52c4272507121e35..4dde05e45a04122b566cedc36d20b072413b00e2 100644
--- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
@@ -6,7 +6,7 @@
  * the values. To further ensure consistency, this file is compiled without
  * libc and without auto-vectorization.
  *
- * To be "clean" all values must be either all ones or all zeroes.
+ * To be "clean" all values must be all zeroes.
  */
 
 #define __stringify_1(x...)	#x
@@ -14,9 +14,8 @@
 
 int main(int argc, char **argv)
 {
-	char prev_value = 0, value;
+	char value = 0;
 	unsigned long vl;
-	int first = 1;
 
 	if (argc > 2 && strcmp(argv[2], "x"))
 		asm volatile (
@@ -44,14 +43,11 @@ int main(int argc, char **argv)
 			"vsrl.vi " __stringify(register) ", " __stringify(register) ", 8\n\t" \
 			".option pop\n\t"					\
 			: "=r" (value));					\
-		if (first) {							\
-			first = 0;						\
-		} else if (value != prev_value || !(value == 0x00 || value == 0xff)) { \
+		if (value != 0x00) {						\
 			printf("Register " __stringify(register)		\
 				" values not clean! value: %u\n", value);	\
 			exit(-1);						\
 		}								\
-		prev_value = value;						\
 	}									\
 })
 

---
base-commit: 03d38806a902b36bf364cae8de6f1183c0a35a67
change-id: 20250301-fix-v_exec_initval_nolibc-498d976c372d

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


