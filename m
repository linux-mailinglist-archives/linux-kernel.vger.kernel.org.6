Return-Path: <linux-kernel+bounces-188258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A608CDFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A171F2288E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4143839D;
	Fri, 24 May 2024 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Cvp7UAoH"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E245D29B;
	Fri, 24 May 2024 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521789; cv=none; b=JLPBahQuVcp84cOcpRBQ8gSCAw8Qrk4WA1GFS5Pzw1SgElyeSPjQ6AbGjQvlhdVtoR5lSmIYV8/QdL4/UnquxR3Is6iKYL5c7SF1TrWEcDmKXLqRYDwVi+0pbtRVZYGTfgvBXojTpq7TJ7J+cAendFZWvLh8WgKDeRqOyqTar7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521789; c=relaxed/simple;
	bh=eVF4XyAQQt+XD0kRfwQoMxD2Psu2LzqAIK3RDYWoudA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=b6MmWfv0UdgCIxWF2wI0lYhH033g17kotLsZ9ZARj2bt1y1QwUg3qeuQfoL3aiTcQcCyJTYs4RtJ47kiHST5Xwh7Cnuj6AzTowGGnudp5IaejHv8Gdi5moxCiRI5HigyTRjDAcuzXBUsmcqNZHHcH8mBy72yqC0KGZIUa59R6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Cvp7UAoH; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716521779; bh=F+wpGwccmcn6o4Ew+LaZ6dWwIWr+GXbaYvvVaDRhjFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cvp7UAoHHo0sntuoIeyYXEKNz52svYa2kYu/QZIWc6n3fO6e+dnbe26DV6JEIaJyD
	 g1xSjemy3epL6IAPGFl8oZmoAQpXhNrcjDKxp9vTi7vD9F5JSLufNjl6fxN4yKLB6G
	 kAQbNNOrKVwN2fYlX3Hu1ZyyITQsH4n9h3g70XUw=
Received: from cyy-pc.lan ([240e:379:2259:4c00:b652:79f2:d4c3:c8a8])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 90C8A481; Fri, 24 May 2024 11:36:12 +0800
X-QQ-mid: xmsmtpt1716521776t16vwkpjg
Message-ID: <tencent_AC4A216B8D1B7C7882DCDA648E1AB8653108@qq.com>
X-QQ-XMAILINFO: OaubouGXmhNz1eavt//OG67W7xDtIvYLLMONKHsz6+IiIO4dHYHDqnoCwbCZPI
	 okSz/bJukyevJNvtVzbzOHiS4nNIrtxS2Mykj2dg3/lyLU2ewATOcco0IQfceysIqiHu2TgvyqRY
	 KYLbWGMEViuFuoEWrtK5j3BQuhmkLddFxnQf0uZltF1B60xGsHFadstuybh25U9iiIEZHViFhcHh
	 pAHu/MWf0HQtdHHi/bN5mN27ij/fpMFEZYSkSfcHtyXgsVVIqriH3bZVOQzsojADprZOZfODKdyT
	 7co0MBhPGrFOqjhC7bV7ZPEyClJ6Oul2ZZANoFkRnGBxrDch7bGMBuAv+ADCXXBV5LOz7pvUQsXp
	 68YMle8uV54DAGsNxVHkiy3Qyp9oW4xbb67UoUmyknFtZdIyj0F5DpspU3d3srI2VY822KSSWuAf
	 sp2+3Sobn82hAgA/1t6G/MLhGnLY7jPfv7Q3Aw+l+Njxihx+1TAY4/gfVfbQvBwFPNV43Eem2/Gc
	 AZts+FNdAVyXvd8pJkq3z8y6ryOhWNxwXAi208W9yajlH19Pdj8TP157qO3ENqK77ZGjtRdwNmdy
	 +sPlQ7/YTG1AxFnJgYhEbTzq6YJNHJEJf9rk8wxaFpkCGSelyHAAWiKxG8zjtY4Bsc6xaOeJtAMy
	 Qz/7kdaLTARX9cSdHHOBkAEo3HMfQ3egdlTedPGISdKK4pLj+5hiBsvF9L4zVclYfkAa2YxJNIdB
	 316KlTSM0ux9K0ekDqQ/ibn1bY7J+PzMhhwfZMQ/eeiyv7SMFBJZ6UfY25VUi8hrmiwJd3zR7nZE
	 0k/lmSO2CBSEe1MTsRtuu/ES992Z132BrJgF0Z0BSubE0/O5c13IUoFnDfBsX+NhKjASroCKz99S
	 5AZXp6QjjrF/Zo4m83h44XwDdtKbAfv4qD5fuHhA4uoL49YZFlV7zKOAifscEQyKCuRGfEgc1aF4
	 fy7Crj7XYEnMMMJRu4+pK+9cFJveWciofCv50c+3Y0x+FXJSMBNytOci7IMbF1OqCvAXaLq0UmiB
	 B7tCvrnrH33xVv6szV
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Elliott Hughes <enh@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Evan Green <evan@rivosinc.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v2 2/3] docs: riscv: hwprobe: Clarify misaligned keys are values not bitmasks
Date: Fri, 24 May 2024 11:35:58 +0800
X-OQ-MSGID: <20240524033559.298935-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
References: <tencent_1E3506F09D08066B8F3BAEE136C4F887540A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original documentation says hwprobe keys are bitmasks, but actually,
they are values. This patch clarifies this to avoid confusion.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 Documentation/arch/riscv/hwprobe.rst | 31 ++++++++++++++++------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
index d720712e9734..2e212956185d 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -192,25 +192,30 @@ The following keys are defined:
        supported as defined in the RISC-V ISA manual starting from commit
        d8ab5c78c207 ("Zihintpause is ratified").
 
-* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
+* :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A value that contains performance
   information about the selected set of processors.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
-    scalar accesses is unknown.
+  * :c:macro:`RISCV_HWPROBE_MISALIGNED_MASK`: The bitmask of the misaligned
+    access performance field in the value of key `RISCV_HWPROBE_KEY_CPUPERF_0`.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
-    emulated via software, either in or below the kernel.  These accesses are
-    always extremely slow.
+    The following values (not bitmasks) in this field are defined:
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
-    slower than equivalent byte accesses.  Misaligned accesses may be supported
-    directly in hardware, or trapped and emulated by software.
+    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNKNOWN`: The performance of misaligned
+      scalar accesses is unknown.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
-    faster than equivalent byte accesses.
+    * :c:macro:`RISCV_HWPROBE_MISALIGNED_EMULATED`: Misaligned scalar accesses are
+      emulated via software, either in or below the kernel.  These accesses are
+      always extremely slow.
 
-  * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
-    are not supported at all and will generate a misaligned address fault.
+    * :c:macro:`RISCV_HWPROBE_MISALIGNED_SLOW`: Misaligned scalar accesses are
+      slower than equivalent byte accesses.  Misaligned accesses may be supported
+      directly in hardware, or trapped and emulated by software.
+
+    * :c:macro:`RISCV_HWPROBE_MISALIGNED_FAST`: Misaligned scalar accesses are
+      faster than equivalent byte accesses.
+
+    * :c:macro:`RISCV_HWPROBE_MISALIGNED_UNSUPPORTED`: Misaligned scalar accesses
+      are not supported at all and will generate a misaligned address fault.
 
 * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
   represents the size of the Zicboz block in bytes.
-- 
2.45.1


