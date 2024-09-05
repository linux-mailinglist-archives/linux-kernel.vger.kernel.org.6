Return-Path: <linux-kernel+bounces-317588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324496E0C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F923B22508
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AA01A0AF4;
	Thu,  5 Sep 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7OQSDtM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B331A072C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555848; cv=none; b=AIu6W1cboRT1cQoVxiHpoagxk2V+AU2Y2+FDKGE4oR8VLxIv/onAJ5liXHYJbljHS6Qh0kZaVYxI4c02xnbOcqvd5PQ8pkooAxt90HhhT3GnLHYv2vG7MK9tzCCXfOxL2PmY6kgWgDHVoOjWW7sRHI6WnAN4LCzyaSK726GoLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555848; c=relaxed/simple;
	bh=je+24oM+vGkAb1L4ZYV6lFCDT8JiS8JKuowtm9MBI5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z66R7/qAeRElfKIckQcoZFAkPZZz6wfcc/6Xg33M7SAgVOO0QMui2IO0T8WFBPVbUdScv6/f1mQklTFNZvAI06eObdDq8nhplOvZhm2pievTan+qrihlXajnint1dvfltSoqrZYkqHxtDLeKBLThndLmCPYe+xY/AWEbtrgYIbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7OQSDtM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725555847; x=1757091847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=je+24oM+vGkAb1L4ZYV6lFCDT8JiS8JKuowtm9MBI5E=;
  b=A7OQSDtMZHSkiyEM8RjFvPkV0lCh/xhSS0wnVkGg48LAmhOd1UH4cIef
   UPLJ6io7+HnuR2rmNX8l3YjbVjRo7zw16oo2q9JQ15GQZ4PwjfxRwkUc4
   OWN4hCVbQZD3Nc3C3OOTeYWyvZLUE79k1lj7g3TplBU34d4T6+kZIaPEE
   JHJ4bQbn7U0kmqFZX/nGcqFf3yUEl+DlJLUzRLtZaMJ+6iI73a5d5R64b
   up5jfjgAM9zLBKapEyzE6s3WZD63iEWEya+TGmiS2HrOIuC17grC0kTkj
   2r8IlAI+9q4zxyzhEWJNVD2HtM+vgiDre4RukVWHOXiotJJIYp9Wk+A/q
   w==;
X-CSE-ConnectionGUID: 4R17Smn4QwmUy10d/OMZUQ==
X-CSE-MsgGUID: 85Mv6CM3Rw2s4PEE4pARow==
X-IronPort-AV: E=McAfee;i="6700,10204,11186"; a="41768505"
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="41768505"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 10:04:06 -0700
X-CSE-ConnectionGUID: TKnBCRQUTi6EZs+5cC5WTg==
X-CSE-MsgGUID: XPdBFsaiRWepUjq4r3nKxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,205,1719903600"; 
   d="scan'208";a="65678413"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 05 Sep 2024 10:04:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B66AF31E; Thu, 05 Sep 2024 20:03:58 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when comparing in percpu_add_op()
Date: Thu,  5 Sep 2024 20:03:56 +0300
Message-ID: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When percpu_add_op() is used with unsigned argument, it prevents kernel builds
with clang, `make W=1` and CONFIG_WERROR=y:

net/ipv4/tcp_output.c:187:3: error: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  187 |                 NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  188 |                               tp->compressed_ack);
      |                               ~~~~~~~~~~~~~~~~~~~
...
arch/x86/include/asm/percpu.h:238:31: note: expanded from macro 'percpu_add_op'
  238 |                               ((val) == 1 || (val) == -1)) ?            \
      |                                              ~~~~~ ^  ~~

Fix this by casting -1 to the type of the parameter and then compare.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/percpu.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feae..e525cd85f999 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -234,9 +234,10 @@ do {									\
  */
 #define percpu_add_op(size, qual, var, val)				\
 do {									\
-	const int pao_ID__ = (__builtin_constant_p(val) &&		\
-			      ((val) == 1 || (val) == -1)) ?		\
-				(int)(val) : 0;				\
+	const int pao_ID__ =						\
+		(__builtin_constant_p(val) &&				\
+			((val) == 1 ||					\
+			 (val) == (typeof(val))-1)) ? (int)(val) : 0;	\
 									\
 	if (0) {							\
 		typeof(var) pao_tmp__;					\
-- 
2.43.0.rc1.1336.g36b5255a03ac


