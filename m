Return-Path: <linux-kernel+bounces-379991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22B29AE6D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E9C1C240D7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7061D63DB;
	Thu, 24 Oct 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoOzrrLX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5641E3DF1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776896; cv=none; b=ab+OFmWR8lxXtAoSOrucLiHP5t2GnxchDTJIwtgt9GFT877sHhjTAjU8yInG9MI107T+q0Adgewnse6uSB/DPLNDs4DxZb+4+byIyCxFrvYX6N9jreBdT5fisuZWZgLZ9d/9zvVX4/AEjIyPvIMpuT1kgVaAozKsJ4Vk404TBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776896; c=relaxed/simple;
	bh=3akjFI4PW1LERDz1uzlJbaefuzyK1P3a4/MJQUBfu6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tEm82qU3c72J0U1bsSPw87OzrPdKpZFRBhtTl5eWf+JXUdycMXeQFzq4MXcjGXRc+8Rjq9KxBHI7I2gFVKxQKNDvLR3gVtq8jkQ6g0GQcRd9m8as65ElS9GSGqCWO4GxC8VbmZ/RAKq3H4KFr+2g56e2qmRRm1HAfoV1YbAiXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoOzrrLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEF4C4CEC7;
	Thu, 24 Oct 2024 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729776895;
	bh=3akjFI4PW1LERDz1uzlJbaefuzyK1P3a4/MJQUBfu6w=;
	h=From:To:Cc:Subject:Date:From;
	b=LoOzrrLXiOVhH7LSxEC+PV/xI8rqRjEsZwqUztxUufP0Tj5ukW8Ud5gWgQTcuAi4W
	 f2UDab6vCjYnsiE7maLDx0hF5HCbmOBajnDB8BhTenYGzgI10eDQIL4NOdseREQZSM
	 UF0jZhkVl94NI84g0DRc/gjfEOUr9POaOK6HTBM4Q10WV8AyUo2mKlrSUsNXlfw5mE
	 9TeyeCffFr0tzUahnbNJEJyNpurC6V/GCXHPJPiPsdINM40oJ0zR9qekA1vDXfCO0q
	 IkUPp4ZWByKGfbD9mDBPrz4x9E/B9HXIeLQPCFrv4wloLAjyiTifvsADvc81qn3XSz
	 9DjMIvnOZgJXg==
From: Arnd Bergmann <arnd@kernel.org>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Alex Bennee <alex.bennee@linaro.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vdso: change PAGE_MASK to signed on all 32-bit architectures
Date: Thu, 24 Oct 2024 13:34:26 +0000
Message-Id: <20241024133447.3117273-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With the introduction of an architecture-independent defintion of
PAGE_MASK, we had to make a choice between defining it as 'unsigned
long' as on 64-bit architectures, or as signed 'long' as required for
architectures with a 64-bit phys_addr_t.

To reduce the risk for regressions and minimize the changes in behavior,
the result was using the signed value only when CONFIG_PHYS_ADDR_T_64BIT
is set, but that ended up causing a regression after all in the
early_init_dt_add_memory_arch() function that uses 64-bit integers for
address calculation.

Presumably the same regression also affects mips32 and powerpc32 when
dealing with large amounts of memory on DT platforms: like arm32, they
were using the signed version unconditionally.

The two most sensible options that I see for addressing the regiression
are either to go back to an architecture specific definition, using a
signed constant on arm/powerpc/mips and unsigned on the others, or to
use the same definition everywhere.

Use the simpler of those two and change them all to the signed version,
in the hope that this does not cause a different type of bug. Most
of the other 32-bit architectures have no large physical address
support and are rarely used, so it seems more likely that using the
same definition helps than hurts here.

In particular, x86-32 does have physical addressing extensions, so it
already changed to the signed version after the previous patch,
so it makes sense to use the same version on non-PAE as well.

Fixes: efe8419ae78d ("vdso: Introduce vdso/page.h")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Cc: Alex Bennee <alex.bennee@linaro.org>,
Link: https://lore.kernel.org/lkml/CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/vdso/page.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/vdso/page.h b/include/vdso/page.h
index 4ada1ba6bd1f..710ae2414e68 100644
--- a/include/vdso/page.h
+++ b/include/vdso/page.h
@@ -14,13 +14,14 @@
 
 #define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
 
-#if defined(CONFIG_PHYS_ADDR_T_64BIT) && !defined(CONFIG_64BIT)
+#if !defined(CONFIG_64BIT)
 /*
- * Applies only to 32-bit architectures with a 64-bit phys_addr_t.
+ * Applies only to 32-bit architectures.
  *
  * Subtle: (1 << CONFIG_PAGE_SHIFT) is an int, not an unsigned long.
  * So if we assign PAGE_MASK to a larger type it gets extended the
- * way we want (i.e. with 1s in the high bits)
+ * way we want (i.e. with 1s in the high bits) while masking a
+ * 64-bit value such as phys_addr_t.
  */
 #define PAGE_MASK	(~((1 << CONFIG_PAGE_SHIFT) - 1))
 #else
-- 
2.39.5


