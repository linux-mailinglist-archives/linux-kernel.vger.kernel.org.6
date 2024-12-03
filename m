Return-Path: <linux-kernel+bounces-428994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924E9E15FF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F0F616412E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBD1DDC24;
	Tue,  3 Dec 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="Sd7ttXfq";
	dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b="YHGvcH2r"
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C031DDC0D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215142; cv=pass; b=mu/qrg7PB8NElB6tyjZd5LsWvo70gLIldhGe/aPvXYRrF/KU3q5lhS5RrK0ICXCsG9gVLZe4IIe9uI8y9dRg4hzV4fykNq99WkhBRg0dP1Plwnwti9zIznzQAsYo+ZCCMb9ULh4bVKBrGLCpm1hwqlja3igaeIHqeoBYGknN7YU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215142; c=relaxed/simple;
	bh=HohEI9rTRMfx46FIoQv/JfGzVQPl7Isa6riEwUNf3Zw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N0lYJ+TqDAJq+YPXN1loO0WpLq5FHSeN4yK7efNhvmVTeBAlrqC9KmiM6gsD7Etf/lT/+pUz68zsB6OxnEknKhZcp9Cz8l0jy3qVX+a+862IiW+is69mG5fzUhd4l+4iiYhzb2xs1OcRKkurXbWRSruyrxgPg3w8OmMqrEn3jBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org; spf=none smtp.mailfrom=outer-limits.org; dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=Sd7ttXfq; dkim=permerror (0-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.b=YHGvcH2r; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=outer-limits.org
ARC-Seal: i=1; a=rsa-sha256; t=1733215132; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mTGrP+w7r1jVHkfQqLkt+0Qd7od7FgigkZ1HWG8fggOEy6fyUjBQRlrjeJMJkgGTOn
    O+dGroydibAdObJv4X/Me00oTZgj8vEpPLr+uC7RyEV+pQuGYE/s1H3oPavuWipnVyAn
    3PfHJHqKVGSq0Z23oG1wV6OAN+Q32d5cJwmiPf7KY11kYdX9er1133Pf1mM98FLj65ws
    DHGTDQ2J57gttKNKthWmwlw+MrW1o0UhoxMhuawcKuOMDwTgCe/MJeMqLd/UIu7qo+HW
    u4ej0pfLIxiv0F69bDhhUvuo/HgnkpU6vPlvrvrZq21yfyDeQj+/65s/UjkOuo1sE7gr
    gThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733215132;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Lw2D+9HANItMSeEwSYOf98A6Xqs0QdT9oH1SuF6xmmw=;
    b=r1OFeCohVLJhPyNjLYfINJ463rcTlsHxboH7tZ5ueyJXFZH/AxFhjOO/gZBVuWKyky
    uYlBo2wV9w5asdswDrNsnyLWEwmh4UB2GuakaXL4pZ1AmRqb5P3bpON/AaROLCEIZm/B
    KlQfq3peJVS7xiq2LJWgoC0teM6B4cbjnPldnSvtsvoJ3mmfUIDY+XLIP/3g2G9/y7sI
    8BuY6QN1BrLhp0byvx0ag4uCzAi2ZL5H1eIbff3EQVjW6rMRygcd/ZpfoEGzmKMJ9VTr
    q7WCC0edTA4uGD9dUdbBwVd64/PPa3sXLsHMt8FkLlKD5hv1fwg7Pz9TzR7exh9eP+1j
    j5aA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733215132;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Lw2D+9HANItMSeEwSYOf98A6Xqs0QdT9oH1SuF6xmmw=;
    b=Sd7ttXfqT8WRoLAO6kpzLpxJ6hyGFK+apxuLaxdp/ll9tibTe/7PUudnvCPqZUi44L
    QcytN1HvX3qt6P5gIstsR/JpeXIfXMe1AVxkWXntrDwUYk31LALFVaP8in/bNyUM9u6o
    7hwpWoZLYohLzzeCGHRaNC/g5F46cb+al/rXT3CSiJFk4ku5WxIJGuficrz5KHncdzJT
    fwLbbvI6ODWmF4E+pWSBWvvK2En46NP2FwwuRjoM9BMfMEARH9mfK5/qJkj8qUWBMejp
    zANclQ9TOdCF9ex3Ocuf0kkahulMF07EvHWnSM/acMlhP+WHOaHlEEe/Z60acoXqND4H
    iW9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733215132;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=Lw2D+9HANItMSeEwSYOf98A6Xqs0QdT9oH1SuF6xmmw=;
    b=YHGvcH2rLW7hEKJf+wrY7n0I/t/JNI2ed8a92zIBn9NzeUJYstR6OY/bRsxCMB0AQe
    ctAXT6IFgDL7gB8dwMAQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBEHcVJSv9P5mRTGd2ImeA=="
Received: from ws2104.lan.kalrayinc.com
    by smtp.strato.de (RZmta 51.2.11 AUTH)
    with ESMTPSA id Ja0a030B38cpBuw
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Dec 2024 09:38:51 +0100 (CET)
From: Julian Vetter <jvetter@outer-limits.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH] arm: Remove IO memcpy for Big-Endian
Date: Tue,  3 Dec 2024 09:38:38 +0100
Message-Id: <20241203083838.3260036-1-jvetter@outer-limits.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Julian Vetter <julian@outer-limits.org>

Recently a new IO memcpy was added in libs/iomem_copy.c. So, remove the
byte-wise IO memcpy operations used in ARM big endian builds and fall
back to the new generic implementation. It will be slightly faster,
because it uses machine word accesses if the memory is aligned and falls
back to byte-wise accesses if its not.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
 arch/arm/include/asm/io.h | 11 ----------
 arch/arm/kernel/io.c      | 46 ---------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 1815748f5d2a..146509d82e30 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -253,13 +253,6 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size);
 #define insl(p,d,l)		__raw_readsl(__io(p),d,l)
 #endif
 
-/*
- * String version of IO memory access ops:
- */
-extern void _memcpy_fromio(void *, const volatile void __iomem *, size_t);
-extern void _memcpy_toio(volatile void __iomem *, const void *, size_t);
-extern void _memset_io(volatile void __iomem *, int, size_t);
-
 /*
  *  Memory access primitives
  *  ------------------------
@@ -322,10 +315,6 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
 }
 #define memcpy_toio(to,from,count) memcpy_toio(to,from,count)
 
-#else
-#define memset_io(c,v,l)	_memset_io(c,(v),(l))
-#define memcpy_fromio(a,c,l)	_memcpy_fromio((a),c,(l))
-#define memcpy_toio(c,a,l)	_memcpy_toio(c,(a),(l))
 #endif
 
 #endif	/* readl */
diff --git a/arch/arm/kernel/io.c b/arch/arm/kernel/io.c
index 60b621295d6c..afa4eff8c6c5 100644
--- a/arch/arm/kernel/io.c
+++ b/arch/arm/kernel/io.c
@@ -37,49 +37,3 @@ void atomic_io_modify(void __iomem *reg, u32 mask, u32 set)
 	raw_spin_unlock_irqrestore(&__io_lock, flags);
 }
 EXPORT_SYMBOL(atomic_io_modify);
-
-/*
- * Copy data from IO memory space to "real" memory space.
- * This needs to be optimized.
- */
-void _memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	unsigned char *t = to;
-	while (count) {
-		count--;
-		*t = readb(from);
-		t++;
-		from++;
-	}
-}
-EXPORT_SYMBOL(_memcpy_fromio);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- * This needs to be optimized.
- */
-void _memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	const unsigned char *f = from;
-	while (count) {
-		count--;
-		writeb(*f, to);
-		f++;
-		to++;
-	}
-}
-EXPORT_SYMBOL(_memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- * This needs to be optimized.
- */
-void _memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	while (count) {
-		count--;
-		writeb(c, dst);
-		dst++;
-	}
-}
-EXPORT_SYMBOL(_memset_io);
-- 
2.34.1


