Return-Path: <linux-kernel+bounces-337216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD2984719
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF70BB22D24
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9411A76A6;
	Tue, 24 Sep 2024 13:55:27 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D21DDEA
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727186127; cv=none; b=VcyRlFVw7VJHCPIp7ZI8FI7gaQ0h883cLAt1GvD92+DJQgjobW6MfGH5dmGcR7ijbzzMf/QFdom7YNiwZ8xoEecL9VF90nu5Z7jdyKdg+eOcDy6MyLUj3n7FVEz/lJj6NsN4xXqZuAge2n/V+9mT/GRKPFMfZG3+0t/DbNHkWQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727186127; c=relaxed/simple;
	bh=o9UQOkjoQY/GowfiJxlEdWUS4wvKv0K+HCXp/DEHfy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BrmLgGU76HIbzV0+uP7MSjr95wIrESU207Nu0vI1liYi/x130guBK2z3doFIplQ+Q8bT5D2pM1oBiAJNcJm/HIgyPUD5+EznNsoIRZoNEr2A3fE1eWx1tD0ZcGBdI28PBOS6UDcCmo7ELav9cZ83Nb6/c8PCrkoQLKtmpvYG8tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:beb3:bbd4:b9cd:84ae])
	by xavier.telenet-ops.be with cmsmtp
	id GDvP2D00N3rtkie01DvPhP; Tue, 24 Sep 2024 15:55:23 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st60d-000Syp-1K;
	Tue, 24 Sep 2024 15:55:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1st60g-005zKO-TC;
	Tue, 24 Sep 2024 15:55:22 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Tony Ambardar <tony.ambardar@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] compiler-gcc.h: Disable __retain on gcc-11
Date: Tue, 24 Sep 2024 15:55:20 +0200
Message-Id: <71d8f8448d29c3ce5a7fd883e56c0edeb2f4106b.1727185783.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

All my gcc-11 compilers (Ubuntu 11.4.0-1ubuntu1~22.04) claim to support
the __retain__ attribute, but only riscv64-linux-gnu-gcc-11 and
x86_64-linux-gnu-gcc-11 (not x86_64-linux-gnux32-gcc-11!) actually do.
The arm-linux-gnueabi-gcc-11.5.0 compiler from kernel.org crosstool
fails in the same way:

    error: ‘retain’ attribute ignored [-Werror=attributes]

All my gcc-12 compilers seem to support the attribute.

Play it safe, and disable __retain unconditionally on gcc-11.

Fixes: 0a5d3258d7c97295 ("compiler_types.h: Define __retain for __attribute__((__retain__))")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/compiler-gcc.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f805adaa316e9a21..bedeb76b63a34745 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -145,3 +145,12 @@
 #if GCC_VERSION < 90100
 #undef __alloc_size__
 #endif
+
+/*
+ * Most 11.x compilers claim to support it, but only riscv64-linux-gnu-gcc and
+ * x86_64-linux-gnu-gcc actually do.
+ */
+#if GCC_VERSION < 120000
+#undef __retain
+#define __retain
+#endif
-- 
2.34.1


