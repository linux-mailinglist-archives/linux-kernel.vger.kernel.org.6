Return-Path: <linux-kernel+bounces-430723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB67B9E34B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7FD2814AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B94420C00F;
	Wed,  4 Dec 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="iYULa6lf";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="gXOqmg0k"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026320B7F1;
	Wed,  4 Dec 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298595; cv=pass; b=GwEM4LJ5EtgDtQukzRJue751xU8hnImpMF2FUWHf7/G8NqSc4zL/b4uuwNqteFE0V19nxXhUcy3uQKSyFo1/dV5Ghp9try2GEK+EPiUgrjqvuMmtgNKNYelrQNbKVVdtZeC4mAH6WzssYZNgzL10ZkXQofFzWCyirzsKII1yUnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298595; c=relaxed/simple;
	bh=M6RwKluML8bmmOp1YgaUxZ4urfVP07tr+vFA/heYw+c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DdsJDouv9T62fyDcQ0Nl5vA9n/g/CJpeR57T5VU3n/lpsh8S6qRIfXs2kLUBigvfgAnm/flzlYZWE06suIfLjDhcbElYV/be5YBImL6d5s2KiYMcrFhIzJw7cFEO/KZ0bc1OkZY18z2XTmhd3cgmGCc4hh7IrAZf36Bx6kcyD4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=iYULa6lf; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=gXOqmg0k; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1733298406; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ofPnBNBvn05vQEPQimJekSufbpDRzrEYpcoAEybHqTT+XnTTSYOHaMqeFGlWOebflq
    gQl/q2c3kWKIS4btGUoJW8ROUO6yAsRjmILhamZANC1pYL1rT1IoFKWyBzh+0wV5DPcH
    t34doOS6F26DNhoouiko1+Lu3chM3xfmlFCo4vfAWgkHBaxTeHM5zk2aJ+AE3ZFQz7gG
    mq+xubdXSqhljA0iLnUd8UTHwGEXqM/SCbMpeqnQjBF5C3V0//n6rfLED4JYWnBs35Vp
    +/YZQ3IV0iV7Xj1YFBlPU5+VO/WZKyzxkNyzMvmss7fm/uv33iB52qoXeqgs1t2clCiQ
    sKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733298406;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vdY7+wuKPrphJStJSSvgK5sCtQyNjRN2UeTezk9EShM=;
    b=g4yEEMq3Lk5a7bTP+LZnQAe/tTj0zn25IREgshWyDK9pRfvKzYbB4Y+s7Rp7lsEVOc
    le+51wCizrCQ+h+L7TsR0KQEdLT41/8Gdv4Wr7gVUojqAi9hyff0XFEXFu0eoG1vObE5
    ITVK+ejIriV9Icbxjy+HLEqvHq0y57wP4LzZqIMFLUSmq+Qhdo1CpahIbjOuRJuKvFoC
    xfiYN5+wwURAe6lo4ZEVBNDWvUYLX0AH5GNekFES7BYbfO/9QLhopbE3RD6Ne7bARiEe
    jd5qaIUZjE066PdVFbbqKhgKX59VHcAMfDJ0mbtQq4uvUweuLSK0jSC7Q2E1fORAFhpL
    UxIQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733298406;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vdY7+wuKPrphJStJSSvgK5sCtQyNjRN2UeTezk9EShM=;
    b=iYULa6lf4ulqokbrACJSUQVpnNLR+5vRUnhIw+9oBvzGC36ZMHl7diwTTzcDvMHvcO
    8CDCgVhkrptlUFE606qnjhUUC6Zl2H9JT0/AOSu491BqGqcBwblYsmtq53b2FEsZpbGX
    timWfCQHzDf08GEJnuE8bwJMsvYGrgPRZ8rGpauHhvGue3zZA85LX9Tfxx0oCKTH81td
    bzDFBJkOYL5oU3zKfwGUJzq/sj+AaQkceAZgvokCh2GvQQEpP36nIguavl5/xIyIvW2c
    wS5IAn7mv9F7BL4GPQXVCI2cYEiT9EsN5BZ2N9O9z7ItHWsnXSbQg4zapupZTqy87SFI
    toTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733298406;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=vdY7+wuKPrphJStJSSvgK5sCtQyNjRN2UeTezk9EShM=;
    b=gXOqmg0kd6J+XNhyfvkOSTO4FU50FQETCjNZM0rc8NzRYyuEUKOYc9lKc2sDXIYWau
    Ec3bAPhDjLSAVNXEvNAA==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Ja0a030B47kjQjQ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 08:46:45 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] parisc: Remove memcpy_toio and memset_io
Date: Wed,  4 Dec 2024 08:46:32 +0100
Message-Id: <20241204074632.3683523-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Recently new functions for IO memcpy and IO memset were added in
libs/iomem_copy.c. So, remove the arch specific implementations, to fall
back to the generic ones which do exactly the same. Keep memcpy_fromio
for now, because it's slight more optimized by doing 'u16' accesses if
the buffer is aligned this way.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 arch/parisc/include/asm/io.h |  4 ---
 arch/parisc/lib/io.c         | 47 ------------------------------------
 2 files changed, 51 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index a63190af2f05..3143cf29ce27 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -135,12 +135,8 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define pci_iounmap			pci_iounmap
 
-void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
-#define memset_io memset_io
 #define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
 
 /* Port-space IO */
 
diff --git a/arch/parisc/lib/io.c b/arch/parisc/lib/io.c
index 7c00496b47d4..7461366a65c9 100644
--- a/arch/parisc/lib/io.c
+++ b/arch/parisc/lib/io.c
@@ -12,32 +12,6 @@
 #include <linux/module.h>
 #include <asm/io.h>
 
-/* Copies a block of memory to a device in an efficient manner.
- * Assumes the device can cope with 32-bit transfers.  If it can't,
- * don't use this function.
- */
-void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
-{
-	if (((unsigned long)dst & 3) != ((unsigned long)src & 3))
-		goto bytecopy;
-	while ((unsigned long)dst & 3) {
-		writeb(*(char *)src, dst++);
-		src++;
-		count--;
-	}
-	while (count > 3) {
-		__raw_writel(*(u32 *)src, dst);
-		src += 4;
-		dst += 4;
-		count -= 4;
-	}
- bytecopy:
-	while (count--) {
-		writeb(*(char *)src, dst++);
-		src++;
-	}
-}
-
 /*
 ** Copies a block of memory from a device in an efficient manner.
 ** Assumes the device can cope with 32-bit transfers.  If it can't,
@@ -99,27 +73,6 @@ void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
 	}
 }
 
-/* Sets a block of memory on a device to a given value.
- * Assumes the device can cope with 32-bit transfers.  If it can't,
- * don't use this function.
- */
-void memset_io(volatile void __iomem *addr, unsigned char val, int count)
-{
-	u32 val32 = (val << 24) | (val << 16) | (val << 8) | val;
-	while ((unsigned long)addr & 3) {
-		writeb(val, addr++);
-		count--;
-	}
-	while (count > 3) {
-		__raw_writel(val32, addr);
-		addr += 4;
-		count -= 4;
-	}
-	while (count--) {
-		writeb(val, addr++);
-	}
-}
-
 /*
  * Read COUNT 8-bit bytes from port PORT into memory starting at
  * SRC.
-- 
2.34.1


