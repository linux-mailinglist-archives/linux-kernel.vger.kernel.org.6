Return-Path: <linux-kernel+bounces-175329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367058C1E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652B91C216E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E9168AEF;
	Fri, 10 May 2024 06:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hWdBlhnh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qixzu2G5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9F161920
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322538; cv=none; b=VWA4UI/UO/UHY6SSMAe2WFA8DOu9FEaVXxryv7ck0eOz83sjmtGKWOQXZiVL+iBpYPcBeebo3FUK4HZTCwCFtcg8+wM0f0EHHd7XSfY3J32+OQVkJaLcfPaHHFYoRsk+xYeGyOFev62aJd8smVlSlW88KmN5bgrKG90TroAfh1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322538; c=relaxed/simple;
	bh=SjStDidQObO2LvRJnVozzhbgVVCPf5LDF7cTuOyL0xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFRB1n1sfPYMjnm9kyDE7EJUp8Ger+sMJRwE66FcwQXV1V0Z9Hh6Vv+/x9qT+chHX4Rs8uG8o6l0y1t6LUzhJVip2Im13hDrs/OXMJzDoiR/o+EsxHs1QFyDdvrmdffAsDMxkfzreNvGkj2UIWhpbMG5GNf6hb7tgH1EMdHF+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hWdBlhnh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qixzu2G5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUj2+QY4yHVaTP+Z3xu9XzUVGT256iYtfuxPIy3zZGw=;
	b=hWdBlhnhnkLUsdOO7KNRM7oQJc4W7CYCCGcne8gyHRuKcWxd9y4/csOkBDMaRw6Y8yiwd/
	8gKxKXx+oJOBBClXYKFvctPy6tZz2SKVlzl56CtBVSw9WgXua5KGB086OcqtgUdxzaMuPJ
	aOh5HB8UZLD+nFMA5NSLYLyx2zcMphsIviWjbGmDLnsaX5fRdai1wzuPXcYe/WGY7K9oU7
	GtuYCvvHGBhfdYqPO1iPhFzZ0PguIr5TB/oKsWAZyoYv1hzZUuGXq1rk5/zSLIpCzqlIff
	CQQfGN7YOfkeKqp23epeYj86vA4u+eVnymcHwqoFa7AvrW4mX+UERg91zjZhiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715322531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUj2+QY4yHVaTP+Z3xu9XzUVGT256iYtfuxPIy3zZGw=;
	b=qixzu2G5QM3S57DoFmxPWMeaaq9ODLwpMOKRAOJoVs9C1XOAR6STtUT2avMcuyMuNVLExf
	xaWP8KRJ3pp52ZDQ==
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 5/7] riscv: drop the use of XIP_OFFSET in kernel_mapping_va_to_pa()
Date: Fri, 10 May 2024 08:28:43 +0200
Message-Id: <5439a181cdd7ba185d55457200ddda2d2efa5eb1.1715286093.git.namcao@linutronix.de>
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
placed before the writable data section) is restricted in size.

As a preparation to remove this hard-coded macro XIP_OFFSET entirely,
remove the use of XIP_OFFSET in kernel_mapping_va_to_pa(). The macro
XIP_OFFSET is used in this case to check if the virtual address is mapped
to Flash or to RAM. The same check can be done with kernel_map.xiprom_sz.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 14d0de928f9b..bcd77df15835 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -159,7 +159,7 @@ phys_addr_t linear_mapping_va_to_pa(unsigned long x);
 #ifdef CONFIG_XIP_KERNEL
 #define kernel_mapping_va_to_pa(y) ({						\
 	unsigned long _y = (unsigned long)(y);					\
-	(_y < kernel_map.virt_addr + XIP_OFFSET) ?				\
+	(_y < kernel_map.virt_addr + kernel_map.xiprom_sz) ?			\
 		(_y - kernel_map.va_kernel_xip_pa_offset) :			\
 		(_y - kernel_map.va_kernel_data_pa_offset);			\
 	})
-- 
2.39.2


