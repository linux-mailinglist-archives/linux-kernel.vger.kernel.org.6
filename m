Return-Path: <linux-kernel+bounces-409309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6F79C8B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB59EB2AE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFDE1FB8BB;
	Thu, 14 Nov 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="U4gMUkmn"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E71FB3F0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588691; cv=none; b=BSO/arge/2HvmlLt83PIyZvYdFXdi6GgOMr3M1AnA7HaPhYtl79/XUex1dZzu+P1EL4YUQzAm9PnO/vnvKHdSvbeVjsqZGIYUk3wtO2zBECUv1SLG7UIaEYkioQzCt9TDayFWpmkfxvry8Lz03/qkIMDBigBFquDZUupikOYcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588691; c=relaxed/simple;
	bh=7BWxZUL8BPWR6eLTaynalF6dwkMbQ/MTBnnvcddL0FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nh7Yty9S9gom0L2LRODb67zNzws6sgvegZUmLwapp5MVu8N4+PCxFqjSab3dj9BKtmF3uOinCfdShYU+U0tKBWPty0RrGtZhWImU+Zpv8aRCqakykLBxa3YTJlh5joBZQPGaxhb7bmMgSs3fYFVwmX6okxqqMFPvQIl9H2CWK64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=U4gMUkmn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1731588683;
	bh=Gwg1Wb/EnhMGpio5VQhUKOeR/ots8hhKw5ERQs6T44M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4gMUkmn8bsp5hjgPmdr++lAcre3BdiCwuVAgJ+S3q/ZShxj/RfJUKdIkChqfWd29
	 1CDqf46JkPSFcFiNSEzukkPWjbDvVgqV9WLIZLyyWlsjOxzTI0fOauY+qzrEFFEwu4
	 QKyMaO38269Ax7Db1745w+v2umhVi6HoQV2JuLB4pI/8/dctlcMKjRa9Y+0vfQvmpf
	 b9+ZkO5pSsAsy2x+gvUswBNwY3oTMj1MPq0wd+GD/YsUMUrX9am3NKNkWvoRI6UQ16
	 JiYPV+BO4V65uwoO22IVA3EfUIdvomx7KYK6yEAoBxGEVLaerKlLAfWMUmThi9burO
	 Kao0KpwdMcB2g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xq0QM0n5Dz4xTM;
	Thu, 14 Nov 2024 23:51:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<jk@ozlabs.org>,
	<arnd@arndb.de>,
	<geoff@infradead.org>
Subject: [RFC PATCH 13/20] powerpc/io: Remove unnecessary indirection
Date: Thu, 14 Nov 2024 23:51:02 +1100
Message-ID: <20241114125111.599093-13-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the __do_xxx() defines do nothing useful, they just existed to
make the previous hooking macros work. So remove them.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/io.h | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index faf868715eb5..fd7fe78be86f 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -505,13 +505,6 @@ __do_out_asm(_rec_outl, "stwbrx")
  * possible to hook directly at the toplevel PIO operation if they have to
  * be handled differently
  */
-#define __do_writeb(val, addr)	out_8(addr, val)
-#define __do_writew(val, addr)	out_le16(addr, val)
-#define __do_writel(val, addr)	out_le32(addr, val)
-#define __do_writeq(val, addr)	out_le64(addr, val)
-#define __do_writew_be(val, addr) out_be16(addr, val)
-#define __do_writel_be(val, addr) out_be32(addr, val)
-#define __do_writeq_be(val, addr) out_be64(addr, val)
 
 #ifdef CONFIG_EEH
 #define __do_readb(addr)	eeh_readb(addr)
@@ -607,27 +600,27 @@ static inline u32 readl_be(const PCI_IO_ADDR addr)
 
 static inline void writeb(u8 val, PCI_IO_ADDR addr)
 {
-	__do_writeb(val, addr);
+	out_8(addr, val);
 }
 
 static inline void writew(u16 val, PCI_IO_ADDR addr)
 {
-	__do_writew(val, addr);
+	out_le16(addr, val);
 }
 
 static inline void writel(u32 val, PCI_IO_ADDR addr)
 {
-	__do_writel(val, addr);
+	out_le32(addr, val);
 }
 
 static inline void writew_be(u16 val, PCI_IO_ADDR addr)
 {
-	__do_writew_be(val, addr);
+	out_be16(addr, val);
 }
 
 static inline void writel_be(u32 val, PCI_IO_ADDR addr)
 {
-	__do_writel_be(val, addr);
+	out_be32(addr, val);
 }
 
 static inline void readsb(const PCI_IO_ADDR a, void *b, unsigned long c)
@@ -688,12 +681,12 @@ static inline u64 readq_be(const PCI_IO_ADDR addr)
 
 static inline void writeq(u64 val, PCI_IO_ADDR addr)
 {
-	__do_writeq(val, addr);
+	out_le64(addr, val);
 }
 
 static inline void writeq_be(u64 val, PCI_IO_ADDR addr)
 {
-	__do_writeq_be(val, addr);
+	out_be64(addr, val);
 }
 #endif /* __powerpc64__ */
 
-- 
2.47.0


