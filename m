Return-Path: <linux-kernel+bounces-259465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F3093969E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02406B2184A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90D43F9FC;
	Mon, 22 Jul 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nbYbTP9Z"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C65D512
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721687856; cv=none; b=NjrilrwzrfYXupDNWcSszMhhH9zuILlz6jEhPi+1MCyMX2vJKqu9w0K+FpQqPhiI+Y/P3jMr6O79luXBk4kCbV/LDlSLo2JefTcgPftBRbm05/bqP28ZZ26SzknzNkjQzm1G6Mqc6rlpniyM7knar10PSsBCfhdDqKuw5JksQIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721687856; c=relaxed/simple;
	bh=yRAmGqihqv+Yp16Q6semJORcHEgHaKMdI0FNG0MfAqE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tLJ5VCOvw31Mo4vt9uAYtkndtwOhvPyFDXMG+1Hm/4fMcHlnha8X1qGT9d4m1LjqGwK0iW6HC/vKLanY0+bjNkmIsKqPxM35ObPl3UJ2xpfmD+uy92v1bxs5vLqwKz8GPo3dUULETlbqSqfk0wW9ZM9YH5c4Y0Qt9gvK9zuPt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nbYbTP9Z; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dvyukov@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721687850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r0s2bcH9kroSUN7wqiU+85l1vjvMcUHeZz27ffRte2E=;
	b=nbYbTP9ZQMvO+c6cZtJGWfuX+yFlD4hTwLChUAOegCs1VOBNqzOLrsRDx84u4fH+aBeT2S
	yw/N3ZH0fArrRp0YFAPQ3eYQE7hkQmrIgmZ6F+/taOc66QhcOnlbkrxfElc1NMqcn0Xy9i
	JJguMxXR6VteDV8Sq9Es+SDs80E0wlc=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: andreyknvl@gmail.com
X-Envelope-To: nogikh@google.com
X-Envelope-To: elver@google.com
X-Envelope-To: glider@google.com
X-Envelope-To: kasan-dev@googlegroups.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: yury.norov@gmail.com
X-Envelope-To: linux@rasmusvillemoes.dk
X-Envelope-To: linux-kernel@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: andrey.konovalov@linux.dev
To: Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kcov: don't instrument lib/find_bit.c
Date: Tue, 23 Jul 2024 00:37:26 +0200
Message-Id: <20240722223726.194658-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

This file produces large amounts of flaky coverage not useful for the
KCOV's intended use case (guiding the fuzzing process).

Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>

---

I noticed this while running one of the syzkaller's programs.

In one run of the program, the number of KCOV entries amounts to ~300k,
with the top ones:

 117285 /home/user/src/lib/find_bit.c:137 (discriminator 10)
 116752 /home/user/src/lib/find_bit.c:137 (discriminator 3)
   2455 /home/user/src/lib/vsprintf.c:2559
   2033 /home/user/src/fs/kernfs/dir.c:317
   1662 /home/user/src/fs/kernfs/kernfs-internal.h:72
   ...

In another run (that triggers exactly the same behavior in the kernel),
the amount of entries drops to ~110k:

   7141 /home/user/src/lib/find_bit.c:137 (discriminator 10)
   7110 /home/user/src/lib/find_bit.c:137 (discriminator 3)
   2455 /home/user/src/lib/vsprintf.c:2559
   2033 /home/user/src/fs/kernfs/dir.c:317
   1662 /home/user/src/fs/kernfs/kernfs-internal.h:72
    ...

With this patch applied, the amount of KCOV entries for the same program
remains somewhat stable at ~100k.
---
 lib/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Makefile b/lib/Makefile
index 322bb127b4dc..0fde1c360f32 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -14,6 +14,7 @@ KCOV_INSTRUMENT_list_debug.o := n
 KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 KCOV_INSTRUMENT_fault-inject.o := n
+KCOV_INSTRUMENT_find_bit.o := n
 
 # string.o implements standard library functions like memset/memcpy etc.
 # Use -ffreestanding to ensure that the compiler does not try to "optimize"
-- 
2.25.1


