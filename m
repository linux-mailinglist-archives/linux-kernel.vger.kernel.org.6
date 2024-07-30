Return-Path: <linux-kernel+bounces-267787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BF0941571
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 17:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336421C22A6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD39F1A38C0;
	Tue, 30 Jul 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAv1TMU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948319FA91;
	Tue, 30 Jul 2024 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353274; cv=none; b=cftU2cb/4whOUCLE08OWFNLjsAZeNBOaFsf/ohZ4rWun/vH/2nUm4UStp9U5UHBQ5p81+90El/miO/lO4bO68gZ2bfuGTLuAine2SfIOQeop9E7mOzsenEP2bUTUoRjBLSF2Fm5XanCNO592VEZuQyR5QIDcGCLuJId6ezKPcQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353274; c=relaxed/simple;
	bh=hLn0LnSAJQwjQksBgCWRjncLHVbUTiyPKYWC9UAmUeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RUgARPKSYmr5x+bZmis3tSAyxfUuVFdGY/nGRgRwqJ+RMkYHDaHSwK+uyu7X0vfAv/bOah2QDXbbCHH2nOsWnyBJWWDSPY8c3c+L5lWRyT9ykGEVY7xYbTTeQEWDDt0E7Ktv/j4+mltdupZhUKKmnTK1Ye2fVa0xP1EIZjF5ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAv1TMU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9B6C32782;
	Tue, 30 Jul 2024 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722353273;
	bh=hLn0LnSAJQwjQksBgCWRjncLHVbUTiyPKYWC9UAmUeY=;
	h=From:To:Cc:Subject:Date:From;
	b=iAv1TMU9TwrHPcxD7MebC2v47nKVo1PUeQw3QcVx7m70mFqC+wusIh3LgZJhs3GEH
	 3VaEsTtRL39STYIoOoMYlYoGRt9itvn3Sa1C37CzyGNvTY1d/i2I+tui3wnbNIuuIg
	 +YbE26SC4syjNH7InP00/ULk/qS+XDTOAt/MK4sVRI3HnYmvSM3hwYawcGDn7ocS3T
	 ApVrrquYECTITnQCw5UW9T4mRpiGGKJ5aZPkQBJlpmoQKPS5eKkTEwV7xyeta31RoG
	 2Kb1KDy8AbyaqGloQ3uZ0/3buS8vGv+F8/XxiJ+nHRr/08otXTIY8wnt17KP4aPg9K
	 50OSliQf1v2tg==
From: Arnd Bergmann <arnd@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Baoquan He <bhe@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: fix ioread64be()/iowrite64be() helpers
Date: Tue, 30 Jul 2024 17:27:25 +0200
Message-Id: <20240730152744.2813600-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing the crypto/caam driver on alpha showed a pre-existing
problem on alpha with iowrite64be() missing:

ERROR: modpost: "iowrite64be" [drivers/crypto/caam/caam_jr.ko] undefined!

The prototypes were added a while ago when we started using asm-generic/io.h,
but the implementation was still missing. At some point the ioread64/iowrite64
helpers were added, but the big-endian versions are still missing, and
the generic version (using readq/writeq) is would not work here.

Change it to wrap ioread64()/iowrite64() instead.

Fixes: beba3771d9e0 ("crypto: caam: Make CRYPTO_DEV_FSL_CAAM dependent of COMPILE_TEST")
Fixes: e19d4ebc536d ("alpha: add full ioread64/iowrite64 implementation")
Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
Closes: https://lore.kernel.org/all/CAHk-=wgEyzSxTs467NDOVfBSzWvUS6ztcwhiy=M3xog==KBmTw@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've queued this in the asm-generic tree now, will send a pull request
in the next few days to fix alpha allmodconfig.

 arch/alpha/include/asm/io.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 2bb8cbeedf91..52212e47e917 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -534,8 +534,11 @@ extern inline void writeq(u64 b, volatile void __iomem *addr)
 
 #define ioread16be(p) swab16(ioread16(p))
 #define ioread32be(p) swab32(ioread32(p))
+#define ioread64be(p) swab64(ioread64(p))
 #define iowrite16be(v,p) iowrite16(swab16(v), (p))
 #define iowrite32be(v,p) iowrite32(swab32(v), (p))
+#define iowrite64be(v,p) iowrite64(swab64(v), (p))
+
 
 #define inb_p		inb
 #define inw_p		inw
@@ -634,8 +637,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  */
 #define ioread64 ioread64
 #define iowrite64 iowrite64
-#define ioread64be ioread64be
-#define iowrite64be iowrite64be
 #define ioread8_rep ioread8_rep
 #define ioread16_rep ioread16_rep
 #define ioread32_rep ioread32_rep
-- 
2.39.2


