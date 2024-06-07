Return-Path: <linux-kernel+bounces-206693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDEA900CD0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407DA286385
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F414F11A;
	Fri,  7 Jun 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zVDZmWbz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gO8J18Er"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3913D29E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791737; cv=none; b=FV0UwOv9rfnvA9/Dz91EpuDVCmpnYghILkQujJf9OwANBQ4B0TW4b8jIjDMFb42f4T2iRUtTSl9lCdu7Sy3qq+sQxk23+i6Vd7Wz8rTvcyV5If+9cG0wXiJS6pkuoMQwDxd/XjiOuUWBSKWrxVdAjrQVEblaohcj1ZzoCPmqVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791737; c=relaxed/simple;
	bh=NRwjMMW1NpcsWO7RJK+bpTO7Rv+OtExdexlMAAkxYns=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uh0oVCigxfnWRQb0lpplr6w80RWVe5uwg6Lj2VllR+94Sh1p9FcwZUoRf21cTuqLZ0qDVdMMhK5Pw7MzMmWSUXfZq4dmOGH5mAqKo2h2kIle64GgVjHOw6mEok0VP7PS+uO20A1CHPdxm+gSV5Ml6xrGoaObNkeePp8xSa6Ugmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zVDZmWbz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gO8J18Er; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qZuhyf1lQhZt5s3eJFi8xrQOgugcSrfCBUJNf59gow=;
	b=zVDZmWbztBHi/M21/7J+Y5FeFxkTdBDatbLJyQAc/z8s1fHROXf0zBSzAL/ulQstFpGyrg
	zfRyUsZci059OwtCvS4pPWPeybEYXmpYcl9KeVkQu3D0dYr0+ETILmKDEpVxQoF8CRCx2B
	sgtVFRsKdkiMvSQy+OvKMhL1FQfSyJE4OtbAw0xLHV7tu+ob99ohN3mARhPZGooCxxsUo4
	ojVMsEJt0VI0ymsM0cqCF8hlbGz5FeazRfVXsJj4cRo8eNrFYN/l3pWMIMby3HtBU6WTZ7
	OJkRVLCe8REVuuhkiXTne8T9cvBMoyFqfw5HrwgNpo4eqoyRdtqGWelHmpJgkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717791734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9qZuhyf1lQhZt5s3eJFi8xrQOgugcSrfCBUJNf59gow=;
	b=gO8J18EreVY72dp9ASgoYtgplWRm+hThsi87epU0keVDaiDb0vsxg5HPVyY/g/jh5RcHeY
	CVYR7vY5j36RVlBQ==
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] riscv: cleanup XIP_FIXUP macro
Date: Fri,  7 Jun 2024 22:22:06 +0200
Message-Id: <95f50a4ec8204ec4fcbf2a80c9addea0e0609e3b.1717789719.git.namcao@linutronix.de>
In-Reply-To: <cover.1717789719.git.namcao@linutronix.de>
References: <cover.1717789719.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XIP_FIXUP macro is used to fix addresses early during boot before MMU:
generated code "thinks" the data section is in ROM while it is actually in
RAM. So this macro corrects the addresses in the data section.

This macro determines if the address needs to be fixed by checking if it is
within the range starting from ROM address up to the size of (2 *
XIP_OFFSET).

This means if the kernel size is bigger than (2 * XIP_OFFSET), some
addresses would not be fixed up.

XIP kernel can still work if the above scenario does not happen. But this
macro is obviously incorrect.

Rewrite this macro to only fix up addresses within the data section.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index aad8b8ca51f1..1bc103aa9b74 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -142,11 +142,14 @@
 
 #ifdef CONFIG_XIP_KERNEL
 #define XIP_FIXUP(addr) ({							\
+	extern char _sdata[], _start[], _end[];					\
+	uintptr_t __rom_start_data = CONFIG_XIP_PHYS_ADDR			\
+				+ (uintptr_t)&_sdata - (uintptr_t)&_start;	\
+	uintptr_t __rom_end_data = CONFIG_XIP_PHYS_ADDR				\
+				+ (uintptr_t)&_end - (uintptr_t)&_start;	\
 	uintptr_t __a = (uintptr_t)(addr);					\
-	(__a >= CONFIG_XIP_PHYS_ADDR && \
-	 __a < CONFIG_XIP_PHYS_ADDR + XIP_OFFSET * 2) ?	\
-		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
-		__a;								\
+	(__a >= __rom_start_data && __a < __rom_end_data) ?			\
+		__a - __rom_start_data + CONFIG_PHYS_RAM_BASE :	__a;		\
 	})
 #else
 #define XIP_FIXUP(addr)		(addr)
-- 
2.39.2


