Return-Path: <linux-kernel+bounces-175324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A58C1E13
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 772301F21A06
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F45515EFB6;
	Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rym64PB+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PkNmo9a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1FB224DE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322535; cv=none; b=UILyXEKL6Oix4NcnRLPoWKhN5YL9+17T+ALsUrSJeM077+eUbkzE1h2knD05/hnLq+qi/A7q2lbNGapeM1jzmIcOeWiubQK+2p/Xksqg8apGofNrxyVTZ0Unkq9fFlbVosG/rId8qfPlLa2pjbKsG33APDHeGfj4joC0IOAx3+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322535; c=relaxed/simple;
	bh=jPNszMR3zfL+4GPIAPOJiKNbXrv9nPfVt/IsRIaEyBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixPoORxJLJ/79xPCuApGFqrIsx2zMYvQ3Xsd+pTTQ2rkvZbM842n/0lMc6sM0gps447oVVFgn6KOS4a74AnkWw5ISopBWzuHMj/szA+2fSivvaxwCYQ+Hkuco+zuJNFClzpYfmlpfxc4SkauHJ3XtH/Vn/hXFvMSPSSVmPuruIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rym64PB+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PkNmo9a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHgttoFFWFRLkchEo2QfX0lB112yKyL9eNSmZIo3a+8=;
	b=rym64PB+TVDtCShFhxpKTOgaRSwibgR7yFlmNFd4PvRAuUrYMc2UEwlsOKr+TaA2X44nKV
	/BGxJK9Lz4G67Y++lwd+9styGjOi3EJMSAckZSpmyt1Q6ailUw3Xf3l2DOiF40V1U/JZJp
	9AfXnueGo9xcQGlawkeXI+cpmV6+WRVdB0bp2GqbzI1z+8tL21tnqud3yB/gzQw8aO0caN
	X6WpDnfSbqejhpXjrUfApK8jWG8/z+mvSS9iT+CL20f0h1woOwJc3FdR4h2bsGR4C3aCOj
	Nvl2zdqa1AWxKEuUTTZlLL+QlcecxyhlgNYw14dGuhq5uJ0d3zgrfyRCfNPCxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHgttoFFWFRLkchEo2QfX0lB112yKyL9eNSmZIo3a+8=;
	b=0PkNmo9aY3VUVjYwMRi7xLx59JUldrS/CLbglWFZDpVhxTuy5/Erscv7pKrXKonLZoj7mR
	7fDp+5SrNKk0kuDA==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/7] riscv: cleanup XIP_FIXUP macro
Date: Fri, 10 May 2024 08:28:39 +0200
Message-Id: <19e63324d7a099f561c4a2e55f7df051bd5b8a6f.1715286093.git.namcao@linutronix.de>
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The XIP_FIXUP macro is used to fix addresses early during boot before MMU:
generated code "thinks" the data section is in ROM while it is actually in
RAM. So this macro correct the addresses in the data section.

This macro determines if the address needs to be fixed by checking if it is
within the range startting of ROM address up to the size of 2 * XIP_OFFSET

This means addresses within the .text section would incorrectly get fixed.
Also if the kernel size if bigger than (2 * XIP_OFFSET), some addresses
would not be fixed up.

XIP kernel can still work if the above 2 cases do not happen. But this
macro is obviously incorrect.

Rewrite this macro to only fix up addresses within the data section.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 58fd7b70b903..fbf342f4afee 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -139,11 +139,14 @@
 
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


