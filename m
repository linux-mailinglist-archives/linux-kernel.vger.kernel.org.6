Return-Path: <linux-kernel+bounces-182909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E98C919B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1541B215F7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385A0481BD;
	Sat, 18 May 2024 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kDBCzJo0"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40626FB1;
	Sat, 18 May 2024 16:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716048039; cv=none; b=KU0Kk+u/alEePqaHiyPZ/sQDrDExP7xwBhMWlsTvwzy5/B9QVqN5iy/PGFlXHdh7aJqCNpj5/tu0cxDWyjWuKpXE4oPy9NZx6Tv0zVs6j5eB3CzvMq//KEpv+5lTzxOJ18HL28XHaPlgCYj7/utFNMdHX6Gs1WdP+zUVEJ4AmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716048039; c=relaxed/simple;
	bh=raFmh41kRwhvulwd7DO9n5P2KRQxaVYat7WsL503+BQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kEL9+dMip72FO242f3rTRyfrkTbjQ9GWod72hxpIr2z9DxPiJAewZAwjszwkgpVVUIwqpEs3JyNKODUo6U2sbfCjtabkgZcmv6g96gza7abj/ncj02BeKKY6aDuyvH3je0KwyxxIVzJjwQd8usyWLGn+ymet40IX1c2jJ8ictFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kDBCzJo0; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1716048032; bh=r7ksz0jh/Cq1KNFdh3J0kduhB/g9x9RXKtULXiwHTl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDBCzJo0MOpBQZ9MfmYXir/4+x3pkt1cl3R0DjpJTABBb+quUROObVVFE4ROEtCur
	 +a84XwiWL6M3p3fRAmtdmVUt4dnbhcT+TLx619JidnIngU6ab9+RLrHWT4RscsWrIT
	 kTP4tgaqQqr0Aa9KDX3XsP8WJa+khmr6hxLOy1+8=
Received: from cyy-pc.lan ([240e:379:227e:fc00:28c6:7f50:fe33:13fe])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 198A620; Sun, 19 May 2024 00:00:25 +0800
X-QQ-mid: xmsmtpt1716048029t4krshmay
Message-ID: <tencent_338DF690631BAE788C4CC858233E9FBAE006@qq.com>
X-QQ-XMAILINFO: N2/jAoEINgTT+556m0Y/CLzFdKzIbL/OjFBlzd6z8s5fsIaUFVkWc6r5qmIUu+
	 zpMdi0UeMYXHxTO0aYfG2QRCY8YFtSb7NzkuySsvlIszhXRqPKwm5m/2NpCnQ2E7F8TmjmvAqfSg
	 gwmuYWx1l9OT57W0DmfmKdOhihQ2Qh/sD2qY/rT0udvDKG+sBjGziIbzwIBd/G1kporVEK31Na7t
	 B0l7Dgk2beuq9QOUcpb3Bm0HPBolFdgEhi9o+rdmgnz6328hg0PMX+dobqW73lfeheYxZfK66/Cd
	 EINUjrsZ8nNZ4c8PF5mA6BcYyJzdcrzzgXVbk1n67/ARSwVLOBAkFR4dD7uA/Q2wuvAncBYUiWKP
	 eYde063DabJueVH0aOvqBLHNR1FoPZQh30cadownYEkq01NYmOA/bTAqjmcfXPYGcJVKr+p42loI
	 VmWHzJFBjaa16fXvjnpDz4rQSPY42MZoqP4N/WSTl9ZAT3bJN/URtg/h1UQkWFcfJYydFkPNjPn7
	 /QX5WUPQb/RSeNQrJ2OndyKzPkDtCtYEJs8h3eWh9CpK12V+gvRwYU+Rtfhf/Intm4lCgUyZUQNK
	 gCI7pXjWnsqU4RtbP9nT/EHipIEB89IHnmFQlM1p3VXEc2vheoWCbpb4L3EDMtrB0Q894hL248kX
	 lZRIb589q9BbIIzk1GSe4JV6gBUbQbx/rgactGGVkxvy6fan3UKIA/e7aX3OD0nmBn+JT2X22Ntn
	 3zdh7VoUDohVk5wttDuqwZH/dakM0dI0aILF6bJCH8toYnbBR8cH+JMlCitBLXMIDrteb8+QEMP8
	 2p253mJGZzEZfuzORYk/dlZ26qjafpnZTQuYc7MRBxHwBMXsU/v+RGhElaM2c40Z4uJYOltplBIP
	 q4rgSRz1r45NM2E/kAKHeLgaR8ACl1H7vQHERTlY5zKfmmSf11LggeoAuj16lpAfu49akqOdvKn4
	 eA9LLhfT0Z/pwqqoj22V4ALk3TucITY/7S9iS6kFJtFs/i+FK0C800T55sspIi
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Subject: [PATCH 2/2] docs: riscv: hwprobe: Clarify misaligned keys are values not bitmasks
Date: Sun, 19 May 2024 00:00:12 +0800
X-OQ-MSGID: <20240518160012.892135-2-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
References: <tencent_9D721BDDF88C04DBB5151D57711D62524209@qq.com>
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
index 239be63f5089..4abfa3f9fe44 100644
--- a/Documentation/arch/riscv/hwprobe.rst
+++ b/Documentation/arch/riscv/hwprobe.rst
@@ -188,25 +188,30 @@ The following keys are defined:
        manual starting from commit 95cf1f9 ("Add changes requested by Ved
        during signoff")
 
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
2.43.0


