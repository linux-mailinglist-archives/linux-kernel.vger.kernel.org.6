Return-Path: <linux-kernel+bounces-556585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55406A5CBFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4F57A42CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE892620F3;
	Tue, 11 Mar 2025 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="uPkyfvWZ"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA782620EB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713655; cv=none; b=PcaZeIk/HuxLekz5loaJpxYZ0e1MjHmSOSexp91VpeM49KwIQup8iQjAAiwh4Z39CFsEfBawmL2Jk2pvbfswVx8ia1aX4ZUF62JXgNeZDC6JfL9Vbqnv67896FH/RM2TudSBjGswvGwb6+z7wnVeIIKs/wGOIgrnk8hVBzLfuNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713655; c=relaxed/simple;
	bh=rNUcHSP2FpvVCaR6xsgIP4uOrg8T5+YYy+BHIJDjss4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=owfmaqy+Q5NKS5HEJJAos7zU5WFs2Zx2+OCtR/CJvJFC3d1gll2fHN4zkc9rQdpJb4ZIcsGU+6Urz41LvMKCMLmDyFjXRxd0cK6zX+uFGNN8vM0inm6ohVnPU+WHW6ZPr4cFQ20tJR+xXLAqAKN1Na6JmfvKk6Oy8L1VDn0dF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=uPkyfvWZ; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1741713650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tgSt81uvJI3vKLVetlm9klAJwDGyPHMhXRAlaqD2p8k=;
	b=uPkyfvWZsSw6Vg3qkYIUrQn5g3wIyD7dEs+84MZY4jm5hSVFHR15Oc3tiUXoEgORGQhKSE
	vdaWIl0Qh3YVuJzatKNWGqqsy8DxFAOsbWJ7bV8kxZ0vKsOk8WLCOAoiHcVwht1g95Wn+F
	fNbfxz7Ed3ANi/JkQpjPwbgqGO6KW6UV/Oh+sGJulPsy7oyHaktFhscPH9WfDQA+31eCb0
	8JbozNKnFsikmqyetGLZbfoPuRRWp6a2KJaR0tJyvVnld63l0pKgxeMaDPFar5zcDH8UVS
	0pRIBJBc69VVbhMEAqW5xGwsYrBe53Amy85OzWG3VTpKsgOS3OkXQn1m5rfTsQ==
From: Ignacio Encinas <ignacio@iencinas.com>
Date: Tue, 11 Mar 2025 18:20:22 +0100
Subject: [PATCH] riscv: fix test_and_{set,clear}_bit ordering documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-riscv-fix-test-and-set-bit-comment-v1-1-8d2598e1e43b@iencinas.com>
X-B4-Tracking: v=1; b=H4sIANVw0GcC/x2NQQqDMBBFryKzdiCTYlu9irhIk2k7C6Nkggji3
 R1cvs/jvwOUi7DC0BxQeBOVJRtQ20D8h/xjlGQM3vnOPYiwiMYNv7JjZa0YckLlih+pGJd55mx
 b6N2bgn+lJ4EdrYXNvyPjdJ4XARLKYnQAAAA=
X-Change-ID: 20250311-riscv-fix-test-and-set-bit-comment-aa9081a27d61
To: Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Ignacio Encinas <ignacio@iencinas.com>
X-Migadu-Flow: FLOW_OUT

test_and_{set,clear}_bit are fully ordered as specified in
Documentation/atomic_bitops.txt. Fix incorrect comment stating otherwise.

Note that the implementation is correct since commit
9347ce54cd69 ("RISC-V: __test_and_op_bit_ord should be strongly ordered")
was introduced.

Signed-off-by: Ignacio Encinas <ignacio@iencinas.com>
---
This seems to be a leftover comment from the initial implementation
which assumed these operations were relaxed.

Documentation/atomic_bitops.txt states:

  [...]
  RMW atomic operations with return value:
  
    test_and_{set,clear,change}_bit()
    test_and_set_bit_lock()
  [...]

   - RMW operations that have a return value are fully ordered.

Similar comments can be found in
include/asm-generic/bitops/instrumented-atomic.h,
include/linux/atomic/atomic-long.h, etc...
---
 arch/riscv/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index c6bd3d8354a96b4e7bbef0e98a201da412301b57..49a0f48d93df5be4d38fe25b437378467e4ca433 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -226,7 +226,7 @@ static __always_inline int variable_fls(unsigned int x)
  * @nr: Bit to set
  * @addr: Address to count from
  *
- * This operation may be reordered on other architectures than x86.
+ * This is an atomic fully-ordered operation (implied full memory barrier).
  */
 static __always_inline int arch_test_and_set_bit(int nr, volatile unsigned long *addr)
 {
@@ -238,7 +238,7 @@ static __always_inline int arch_test_and_set_bit(int nr, volatile unsigned long
  * @nr: Bit to clear
  * @addr: Address to count from
  *
- * This operation can be reordered on other architectures other than x86.
+ * This is an atomic fully-ordered operation (implied full memory barrier).
  */
 static __always_inline int arch_test_and_clear_bit(int nr, volatile unsigned long *addr)
 {

---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250311-riscv-fix-test-and-set-bit-comment-aa9081a27d61

Best regards,
-- 
Ignacio Encinas <ignacio@iencinas.com>


