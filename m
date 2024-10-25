Return-Path: <linux-kernel+bounces-382455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AEF9B0E09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA562825B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D320D50C;
	Fri, 25 Oct 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9fD/ckg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303020C301
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729883466; cv=none; b=BUgmXr6hD0pfX4gkU4lTi6uI24/e8udalQ0va/GNTy7gfhJgynbXLFR7dTEqlckaHtLwwofedzxpGS9V/Lh/GQZah7TQk0S6Niqlzse8HmrpgimQOu0AL0La9nsk8k7Eau4R9ofHYi+ktCG5u8/dD1e8qS5hQsFSSR8w3B1zLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729883466; c=relaxed/simple;
	bh=VR05ZHNoxXu0MyPvhQ6RqaLZanAtWqAL6sc1OEgLUmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEIJcTgdErAWOREUw0x2MBWXdziwSR37bd6EU+hbVXB87LEF4bMbgcmAWr244f/OK1YrXJedqiwPuDDEygT7b9j6jzC5OrYq0AZ8Lss6xT8+4X88/a5yDtC/MJ5ZAyY7ZF9eK0/hhS/gV7R3wMjEb8a92t2JFnFyGq5pYm/GWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9fD/ckg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729883465; x=1761419465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VR05ZHNoxXu0MyPvhQ6RqaLZanAtWqAL6sc1OEgLUmU=;
  b=N9fD/ckgHXH9cwZba0qQXkAGvarJYqcdAFXBWiveN+LbR6jCds2m8+4M
   V9v7pSSnJe3G+4kMzGvxgLwMeP34F8Bl8dIyka9p+kAtvyV4rxtZFDdOs
   sksVKMSapZF6B7qfSKF8e9+F9RTIiOJy3oYjgfHSLERiZggzjhLGQ+rSn
   uIfnMV40e1RN2dRubCkBSWyMUha3cASugz/h2BEGS0uK004keePIiHKTS
   mb/lCk8q3KGVtDUPqkNRFlMMaBnO40qOlZGtQOiJdmzbrd+/hOvyp1Vrb
   pGTH92+gbhBAPyUjL/1V4Di1Pvvkh/MaipESWhPcpSE2114fmxHCgBXnk
   w==;
X-CSE-ConnectionGUID: oSzB/GlZRA69XZRmMJ5pkA==
X-CSE-MsgGUID: tXp0unbfTRitRDtXTbRTBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29738454"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29738454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 12:11:04 -0700
X-CSE-ConnectionGUID: fjCrDZ6lQf21Hh96NjYpjw==
X-CSE-MsgGUID: T25uJK6nQvauDIe6RVJ+tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="81154738"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orviesa006.jf.intel.com with ESMTP; 25 Oct 2024 12:11:03 -0700
From: Dave Hansen <dave.hansen@linux.intel.com>
To: dave.hansen@intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH] x86/percpu: Avoid comparing unsigned types to -1
Date: Fri, 25 Oct 2024 12:10:41 -0700
Message-Id: <20241025191041.40169-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang warns when comparing an unsinged type to -1 since the comparison
is always false.

This can be quickly reproduced by setting CONFIG_WERROR=y and running:

	make W=1 CC=clang-14 net/ipv4/tcp_output.o

net/ipv4/tcp_output.c:187:3: error: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  187 |                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  188 |                               tp->compressed_ack);
      |                               ~~~~~~~~~~~~~~~~~~~
...
arch/x86/include/asm/percpu.h:238:31: note: expanded from macro 'percpu_add_op'
  238 |                               ((val) == 1 || (val) == -1)) ?            \
      |                                              ~~~~~ ^  ~~

Fix this by avoiding a comparison of an uncast -1 to 'val'.

Doing this in addition to the existing 'pao_ID__' calculation would make it
even more unreadable. Remove 'pao_ID__' and replace it with the three
components of its calculation.

This preserves some unintuitive but useful behavior.  For instance, gcc sees:

	percpu_add_op(..., var, (u8)-1);

and can transform that into a "dec".  Clang, on the other hand, sees the 'u8'
type and assumes that "(val) == -1" is false, which was the root of the
warning.

This is useful gcc behavior because:

	#define this_cpu_sub(pcp, val)  this_cpu_add(pcp, -(typeof(pcp))(val))

so any code that does:

	this_cpu_sub(A, 1)

where 'A' is an unsigned type generates a "dec".  Clang, on the other
hand generates a less-efficient "add".

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/include/asm/percpu.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..57d9759c692e 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -234,18 +234,19 @@ do {									\
  */
 #define percpu_add_op(size, qual, var, val)				\
 do {									\
-	const int pao_ID__ = (__builtin_constant_p(val) &&		\
-			      ((val) == 1 || (val) == -1)) ?		\
-				(int)(val) : 0;				\
+	const int pao_const__ = __builtin_constant_p(val);		\
+	const int pao_inc__   = (val) == 1;				\
+	const int pao_dec__   = (typeof(var))(val) ==			\
+				(typeof(var))-1;			\
 									\
 	if (0) {							\
 		typeof(var) pao_tmp__;					\
 		pao_tmp__ = (val);					\
 		(void)pao_tmp__;					\
 	}								\
-	if (pao_ID__ == 1)						\
+	if (pao_const__ && pao_inc__)					\
 		percpu_unary_op(size, qual, "inc", var);		\
-	else if (pao_ID__ == -1)					\
+	else if (pao_const__ && pao_dec__)				\
 		percpu_unary_op(size, qual, "dec", var);		\
 	else								\
 		percpu_binary_op(size, qual, "add", var, val);		\
-- 
2.34.1


