Return-Path: <linux-kernel+bounces-175331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F48C1E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01DDE282FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EFA168AFF;
	Fri, 10 May 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1+hk+OF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v/A+xlAr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B12E161901
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322539; cv=none; b=rZXkP/uz/T+3i5/OudCEnCGfQJT8EZFKhu76pM9KIKlC0ixzVNK8DiC3sEH2l86FtgnkWn8Ik4Wi/rfltzr+hRRimNlh84Z4YrUXTu2VGyJdMJXwuRZvZaPM9CL1sSzSiK567RJWaOZZIh92OC4QlIU9MAtgr66uvYhXiiEr1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322539; c=relaxed/simple;
	bh=FkoAiQom5zEMUBgNwYGcFZFIVxo6I9ypUxOYNFG819I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W2ugX53i0NwuE8o+/rE4GN51hNBodrnPuiilbZZ7a9QNkjddUsaLRcpqQWpXT5Bc+in60cvvhoKi5YIFdSxaCRZGNEgPiS8/TW6hX2hknOA3rtQPN6PxOQbRtq7Zm/i7ZXN3gfe8fu1qtwmWUTvPIWVVGVR9LgdvP6uREwfOz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1+hk+OF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v/A+xlAr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMWfkp27OznWlNQgIqa8Ut1fqRBqjArqo7o6O8rXF3c=;
	b=D1+hk+OF8UMJ50ThKBUE/5x7fCrbI/A2VHxlcQXj5+opl/L9Lk/wssXdHNpOgyOpCrqe7k
	RK6UgKFvxiW3XSxDiHHtFo2/mo483XtcXG7rMPHNzKEMIrmwRond3J5kZ4uDNycQ5zy/tp
	re+TU7xKG5Kk5Y8fNdyMPRki9A9iPsqtcuqA/4C5Da6oKfVrHKdEeTeA7O4QcaFAmEqSnn
	gOS8YRgnY9p+lJvyUGMLVbwhfHXz/2t7uk27WLmpqO8wVTnTfCOelYrP4c09t7hiDNwINl
	Mu8Y+cYo3eiAtamovp7FrUmzLSilwK+QDp6DcnsCGIkHjSVbewY4JmptMgO8Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aMWfkp27OznWlNQgIqa8Ut1fqRBqjArqo7o6O8rXF3c=;
	b=v/A+xlArdYtI8vanKBB9Z10cB1sPT4MYU2/62wU/eaFnr2Jy6vRwv/Wc+8oV6dpwWNpzIR
	xox45WumTacghaDQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 7/7] riscv: remove limit on the size of read-only section for XIP kernel
Date: Fri, 10 May 2024 08:28:45 +0200
Message-Id: <9eea4b61f7b6300def3b6582d8e465ef4207501e.1715286093.git.namcao@linutronix.de>
In-Reply-To: <cover.1715286093.git.namcao@linutronix.de>
References: <cover.1715286093.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XIP_OFFSET is the hard-coded offset of writable data section within the
kernel.

By hard-coding this value, the read-only section of the kernel (which is
placed before the writable data section) is restricted in size. This causes
build failures if the kernel get too big (an example is in Closes:).

Remove this limit.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404211031.J6l2AfJk-lkp@intel.com/
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/include/asm/pgtable.h    | 7 -------
 arch/riscv/kernel/vmlinux-xip.lds.S | 4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index fbf342f4afee..75f4a92ea5bb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -104,13 +104,6 @@
 
 #endif
 
-#ifdef CONFIG_XIP_KERNEL
-#define XIP_OFFSET		SZ_32M
-#define XIP_OFFSET_MASK		(SZ_32M - 1)
-#else
-#define XIP_OFFSET		0
-#endif
-
 #ifndef __ASSEMBLY__
 
 #include <asm/page.h>
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index 8c3daa1b0531..01f73f2ffecc 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -65,10 +65,10 @@ SECTIONS
  * From this point, stuff is considered writable and will be copied to RAM
  */
 	__data_loc = ALIGN(PAGE_SIZE);		/* location in file */
-	. = KERNEL_LINK_ADDR + XIP_OFFSET;	/* location in memory */
+	. = ALIGN(SZ_2M);			/* location in memory */
 
 #undef LOAD_OFFSET
-#define LOAD_OFFSET (KERNEL_LINK_ADDR + XIP_OFFSET - (__data_loc & XIP_OFFSET_MASK))
+#define LOAD_OFFSET (KERNEL_LINK_ADDR + _sdata - __data_loc)
 
 	_sdata = .;			/* Start of data section */
 	_data = .;
-- 
2.39.2


