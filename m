Return-Path: <linux-kernel+bounces-376078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6A9A9FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C241283DE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DE1993B8;
	Tue, 22 Oct 2024 10:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WQAeDcOb"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7B9145B24
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591956; cv=none; b=rXIvIUSINXvmRYpYgbQo3IoZMISo59olF6h1fUb3r9Dm7pU7Qvs96gY4/9wEDff0T+dEmjGc+HBZkO7nkPWE1KnXLVvsjtSTmLDAzM1IZ5uyyOaUSs14fWJUnezNmjDORL35X3wtSnEotOGvFrDXsS+Dy7KraLZS4gb7V1zj/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591956; c=relaxed/simple;
	bh=xL1HCYi+zrts8RXAQUVfhEIWRIYuKy3PpcBr1bQH/HU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKna7HFi+DKebosxY4M1B0Wz/fEAvDrPK0mnBiGb+RifelIO6nr7vq8ySEDb/gU6PgR1uR/NsFBrCZU2D4+DGniNlV2bQyN/e2ZYo3SqKMc+5pDc8adfhk2MtjPQ722pO6s89XiXinYd5KyB5Sis/4rNBjZyjNAsBW44PLVHes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WQAeDcOb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=m9A8NsFBAFTswSqlww6Y4t2F/qBPyrFIIj2x1KFfI8E=;
	t=1729591955; x=1730801555; b=WQAeDcObNPBxqQSeMS2PVLtBxz9iUE+qkazS2bHCWqv2azj
	ME/gNOTJ9YiibI8sgp3aHO4LoS527Slp86uUjPfpwJnWbkCjZxCNCdgTmoeJVSP3u2olgpK2uo1XU
	NAaVk/zcGP3QDLHl8SekH8W5DdxHedL1mSWvebSQHONrNsMRKU2sGRsu3x+lL/DhHMvO48vJ7dtG0
	bQa4fh440u4Y5LJQqO6NpxLVcEC3iO0m0RRb/X+WNcW4UgXM3CkjqLx/F/Mn3Jhcrz8pH/l9pVL0k
	KxBA8Ltydui7ODfrisdLGH2+ezCkBEfZikUZfyf4kXX0+JwKvoQUAhy4t0XScNCg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3BsN-00000001fw4-1Pnq;
	Tue, 22 Oct 2024 12:12:31 +0200
Message-ID: <242801ccf39e42dfc8305c248649cd3a5a3bee10.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Fix misaligned stack in stub_exe
From: Johannes Berg <johannes@sipsolutions.net>
To: David Gow <davidgow@google.com>, Benjamin Berg <benjamin.berg@intel.com>
Cc: linux-um@lists.infradead.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2024 12:12:30 +0200
In-Reply-To: <20241022101016.2565249-2-davidgow@google.com>
References: <20241022101016.2565249-2-davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Thanks :)
>=20
> Changes since v1:
> https://lore.kernel.org/linux-um/20241017231007.1500497-2-davidgow@google=
.com/
> - Use force_arg_align_pointer on real_init() instead of naked on
>   __start, which works with clang.

I already applied it, so need to fix on top of it now, not replace it.

However I was just playing with the below - was just looking at the size
though, but what do you think?

johannes


From 57c5a80a4db2de33a11a5a20fcbea8f3643844f5 Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Tue, 22 Oct 2024 11:48:21 +0200
Subject: [PATCH] um: make stub_exe _start() pure inline asm

Since __attribute__((naked)) cannot be used with functions
containing C statements, just generate the few instructions
it needs in assembly directly.

Fixes: 8508a5e0e9db ("um: Fix misaligned stack in stub_exe")
Link: https://lore.kernel.org/linux-um/CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgK=
RKm4uz6DFm2Lb8Q@mail.gmail.com/
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/stub_exe.c      | 8 +-------
 arch/x86/um/shared/sysdep/stub_32.h | 8 ++++++++
 arch/x86/um/shared/sysdep/stub_64.h | 8 ++++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.=
c
index 722ce6267476..a61f9c008233 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -81,11 +81,5 @@ noinline static void real_init(void)
=20
 __attribute__((naked)) void _start(void)
 {
-	char *alloc;
-
-	/* Make enough space for the stub (including space for alignment) */
-	alloc =3D __builtin_alloca((1 + 2 * STUB_DATA_PAGES - 1) * UM_KERN_PAGE_S=
IZE);
-	asm volatile("" : "+r,m"(alloc) : : "memory");
-
-	real_init();
+	stub_start(real_init);
 }
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysde=
p/stub_32.h
index 631a18d0ff44..760e8ce8093f 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -123,4 +123,12 @@ static __always_inline void *get_stub_data(void)
=20
 	return (void *)ret;
 }
+
+#define stub_start(fn)							\
+	asm volatile (							\
+		"subl %0,%%esp ;"					\
+		"movl %1, %%eax ; "					\
+		"call *%%eax ;"						\
+		:: "i" ((STUB_DATA_PAGES + 1) * UM_KERN_PAGE_SIZE),	\
+		   "i" (&fn))
 #endif
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysde=
p/stub_64.h
index 17153dfd780a..148bf423289e 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -126,4 +126,12 @@ static __always_inline void *get_stub_data(void)
=20
 	return (void *)ret;
 }
+
+#define stub_start(fn)							\
+	asm volatile (							\
+		"subq %0,%%rsp ;"					\
+		"movq %1,%%rax ;"					\
+		"call *%%rax ;"						\
+		:: "i" ((STUB_DATA_PAGES + 1) * UM_KERN_PAGE_SIZE),	\
+		   "i" (&fn))
 #endif
--=20
2.47.0



