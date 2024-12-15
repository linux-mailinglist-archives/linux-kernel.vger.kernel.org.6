Return-Path: <linux-kernel+bounces-445828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AAB9F1BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 02:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8981016A064
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 01:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD7168B1;
	Sat, 14 Dec 2024 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDjAi+DY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBFC16415;
	Sat, 14 Dec 2024 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140175; cv=none; b=QuENmgN6TTO69KY37lQSwYmtjB6AV36gdCoWFD+CHzb8/ONdUsFXuiQFPLqoqmP73USu5d4p8WqhfJ7c2Tog3IfKjFb1246d0PgXd/PrXa+uG7UMZNYpbrfqFIXPTUyc9rcBcVMTKs/52n5jVgFRN5H6ZHq+pCt5GYv3torYOpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140175; c=relaxed/simple;
	bh=NUzk8OaNRmebZRGwC9lVEydVbn811EyMNpBEvRidY6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DPCp87oDtqo00Aa2F2djGvNjaFt1PSm3g/4PlmQV2/QC08Mi62AOy8sptL1xinsbdALDdLM5o6AsV9vzdXd5kTBzlgN2D1jbRm5SEEiBptywNVJUMwa7npD5kD/cX4yfYxqvWhuwVzBqQE/ji4/PO4c131p9AdQKdADcWlFldM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDjAi+DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55C8C4CED0;
	Sat, 14 Dec 2024 01:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140174;
	bh=NUzk8OaNRmebZRGwC9lVEydVbn811EyMNpBEvRidY6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=EDjAi+DYsKxwdJSvUH4jneUnsT1DjwGGf31tlLMctq2RpHHRqbou1RCFNkrWNsogn
	 BolOush6XEKMEj+hfONlQI0Y82Qw4tmG3P45rmiF5tLgjpI1UecRg76Th3VJik3+Qg
	 nbVDkl/4TzjfUUyT8Uz0AW1Uf7+cVLBx894zKfbls+Etc7S6fdU3MQrWqJkplYeCfq
	 yeipZnaXs+sCLHTNRjeaIwL0kF2qkmmL7uH/xvFLept1amvli7B9AJPM6J/qq9Rlqt
	 XhQoClZAneO7tjf7NJYuCqN+yYOXIlfkRehqciENrAsZPWj3ap99OZmwWD515JhSmI
	 pfK94jQnOSVNA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	"Qing Zhao" <qing.zhao@oracle.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fortify: Hide run-time copy size from value range tracking
Date: Fri, 13 Dec 2024 17:36:10 -0800
Message-Id: <20241214013600.it.020-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7263; i=kees@kernel.org; h=from:subject:message-id; bh=NUzk8OaNRmebZRGwC9lVEydVbn811EyMNpBEvRidY6Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkxDzkvsdXszVsdfCGhfMnMCW3iJa+/+S/qao68bbY34 N36h5nFHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABMxEGZk+Jl4XlG/L7MolOXU 3AKFLD1Vy17G6m/2Of2hN7Yorr33kZHh9abET1XiSr4KqWHGAtl7L8zVUP97Pmq6bdAjH8tM/+N cAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC performs value range tracking for variables as a way to provide better
diagnostics. One place this is regularly seen is with warnings associated
with bounds-checking, e.g. -Wstringop-overflow, -Wstringop-overread,
-Warray-bounds, etc. In order to keep the signal-to-noise ratio high,
warnings aren't emitted when a value range spans the entire value range
representable by a given variable. For example:

	unsigned int len;
	char dst[8];
	...
	memcpy(dst, src, len);

If len's value is unknown, it has the full "unsigned int" range of [0,
UINT_MAX], and bounds checks against memcpy() will be ignored. However,
when a code path has been able to narrow the range:

	if (len > 16)
		return;
	memcpy(dst, src, len);

Then a range will be updated for the execution path. Above, len is now
[0, 16], so we might see a -Wstringop-overflow warning like:

	error: '__builtin_memcpy' writing between 9 and 16 bytes from to region of size 8 [-Werror=stringop-overflow]

When building with CONFIG_FORTIFY_SOURCE, the run-time bounds checking
can appear to narrow value ranges for lengths for memcpy(), depending on
how the compile constructs the execution paths during optimization
passes, due to the checks on the size. For example:

	if (p_size_field != SIZE_MAX &&
	    p_size != p_size_field && p_size_field < size)

As intentionally designed, these checks only affect the kernel warnings
emitted at run-time and do not block the potentially overflowing memcpy(),
so GCC thinks it needs to produce a warning about the resulting value
range that might be reaching the memcpy().

We have seen this manifest a few times now, with the most recent being
with cpumasks:

In function ‘bitmap_copy’,
    inlined from ‘cpumask_copy’ at ./include/linux/cpumask.h:839:2,
    inlined from ‘__padata_set_cpumasks’ at kernel/padata.c:730:2:
./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ reading between 257 and 536870904 bytes from a region of size 256 [-Werror=stringop-overread]
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
./include/linux/fortify-string.h:633:9: note: in expansion of macro ‘__underlying_memcpy’
  633 |         __underlying_##op(p, q, __fortify_size);                        \
      |         ^~~~~~~~~~~~~
./include/linux/fortify-string.h:678:26: note: in expansion of macro ‘__fortify_memcpy_chk’
  678 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
      |                          ^~~~~~~~~~~~~~~~~~~~
./include/linux/bitmap.h:259:17: note: in expansion of macro ‘memcpy’
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
kernel/padata.c: In function ‘__padata_set_cpumasks’:
kernel/padata.c:713:48: note: source object ‘pcpumask’ of size [0, 256]
  713 |                                  cpumask_var_t pcpumask,
      |                                  ~~~~~~~~~~~~~~^~~~~~~~

This warning is _not_ emitted when CONFIG_FORTIFY_SOURCE is disabled,
and with the recent -fdiagnostics-details we can confirm the origin of
the warning is due to the FORTIFY range checking:

../include/linux/bitmap.h:259:17: note: in expansion of macro 'memcpy'
  259 |                 memcpy(dst, src, len);
      |                 ^~~~~~
  '__padata_set_cpumasks': events 1-2
../include/linux/fortify-string.h:613:36:
  612 |         if (p_size_field != SIZE_MAX &&
      |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
  613 |             p_size != p_size_field && p_size_field < size)
      |             ~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
      |                                    |
      |                                    (1) when the condition is evaluated to false
      |                                    (2) when the condition is evaluated to true
  '__padata_set_cpumasks': event 3
  114 | #define __underlying_memcpy     __builtin_memcpy
      |                                 ^
      |                                 |
      |                                 (3) out of array bounds here

Note that this warning started appearing since bitmap functions were
recently marked __always_inline in commit ed8cd2b3bd9f ("bitmap: Switch
from inline to __always_inline"), which allowed GCC to gain visibility
into the variables as they passed through the FORTIFY implementation.

In order to silence this false positive but keep deterministic
compile-time warnings intact, hide the length variable from GCC with
OPTIMIZE_HIDE_VAR() before calling the builtin memcpy.

Additionally add a comment about why all the macro args have copies with
const storage.

Reported-by: "Thomas Weißschuh" <linux@weissschuh.net>
Closes: https://lore.kernel.org/all/db7190c8-d17f-4a0d-bc2f-5903c79f36c2@t-8ch.de/
Reported-by: Nilay Shroff <nilay@linux.ibm.com>
Closes: https://lore.kernel.org/all/20241112124127.1666300-1-nilay@linux.ibm.com/
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: "Qing Zhao" <qing.zhao@oracle.com>
Cc: linux-hardening@vger.kernel.org

 v2: Make sure the expression statement ends with a single statement
 v1: https://lore.kernel.org/all/20241213020929.work.498-kees@kernel.org/
---
 include/linux/fortify-string.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 0d99bf11d260..1eef0119671c 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -616,6 +616,12 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	return false;
 }
 
+/*
+ * To work around what seems to be an optimizer bug, the macro arguments
+ * need to have const copies or the values end up changed by the time they
+ * reach fortify_warn_once(). See commit 6f7630b1b5bc ("fortify: Capture
+ * __bos() results in const temp vars") for more details.
+ */
 #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
 			     p_size_field, q_size_field, op) ({		\
 	const size_t __fortify_size = (size_t)(size);			\
@@ -623,6 +629,8 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	const size_t __q_size = (q_size);				\
 	const size_t __p_size_field = (p_size_field);			\
 	const size_t __q_size_field = (q_size_field);			\
+	/* Keep a mutable version of the size for the final copy. */	\
+	size_t __copy_size = __fortify_size;				\
 	fortify_warn_once(fortify_memcpy_chk(__fortify_size, __p_size,	\
 				     __q_size, __p_size_field,		\
 				     __q_size_field, FORTIFY_FUNC_ ##op), \
@@ -630,7 +638,11 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 		  __fortify_size,					\
 		  "field \"" #p "\" at " FILE_LINE,			\
 		  __p_size_field);					\
-	__underlying_##op(p, q, __fortify_size);			\
+	/* Hide only the run-time size from value range tracking to */	\
+	/* silence compile-time false positive bounds warnings. */	\
+	if (!__builtin_constant_p(__fortify_size))			\
+		OPTIMIZER_HIDE_VAR(__copy_size);			\
+	__underlying_##op(p, q, __copy_size);				\
 })
 
 /*
-- 
2.34.1


