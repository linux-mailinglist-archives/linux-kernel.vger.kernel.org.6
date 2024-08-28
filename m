Return-Path: <linux-kernel+bounces-304249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F10E961CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D7F128547E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4109C13BAC3;
	Wed, 28 Aug 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="CSLj0Ra4"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929B139D04
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814881; cv=none; b=pQoZKCdAB5yyNFpEMLYs9F0taCUpVnPThbs3nqO56m6E63OWESu5AUBagL+3FuxFxZRIgo+ulsnGnorJIloMjhfHUhkB5vXy2KQxnTOvF8q0i3vamjXAXpGLN8oqdp/JNH4cCP6cu8vhT2b8GzVdC12nQzIrNILez9p0oM8mwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814881; c=relaxed/simple;
	bh=LFuzTQXoQu5ZclmkQmNwwwB4hTMgb1OAouhABIG4ujI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shUR9NqrrgQifAW6u26gb/dRlymn10QV349J8llTyYo0eEaxeyPY0FHed3DPpapZcB/8cIclibZIWrBDDmBlRVWzMJSIMWCugUyGOawqm67DZdGKBydkS3ct1Mo45n9T5FWW/6xrbbfBRP9honsqJlNwxH8Zvf+RFPGydPmE6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=CSLj0Ra4; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1724814879;
	bh=LFuzTQXoQu5ZclmkQmNwwwB4hTMgb1OAouhABIG4ujI=;
	h=From:To:Cc:Subject:Date:From;
	b=CSLj0Ra4vP9TgvK2rdPFXv+JLUAIAVMjj02nlywfN785tYuAnWIXSqVYboEawUvPA
	 /lHRJyinZUwQgqLvnbGoo6BkyIiFkVv4C8WPJ/X9oLuYztKf52pkdoCNTxmIFcIIY0
	 n/4sQ8UbDAeopiauMrEk+g6nLwy6Gr5K7vlF9pUc=
Received: from stargazer.. (unknown [IPv6:240e:358:11b0:4f00:dc73:854d:832e:3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 8729E6656F;
	Tue, 27 Aug 2024 23:14:35 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Remove posix_types.h include from sigcontext.h
Date: Wed, 28 Aug 2024 11:14:22 +0800
Message-ID: <20240828031421.147944-2-xry111@xry111.site>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing in sigcontext.h seems to require anything from
linux/posix_types.h.  This include seems a MIPS relic originated from
an error in Linux 2.6.11-rc2 (in 2005).

The unneeded include was found debugging some vDSO self test build
failure (it's not the root cause though).

Link: https://lore.kernel.org/linux-mips/20240828030413.143930-2-xry111@xry111.site/
Link: https://lore.kernel.org/loongarch/0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site/
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/uapi/asm/sigcontext.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
index 6c22f616b8f1..5cd121275bac 100644
--- a/arch/loongarch/include/uapi/asm/sigcontext.h
+++ b/arch/loongarch/include/uapi/asm/sigcontext.h
@@ -9,7 +9,6 @@
 #define _UAPI_ASM_SIGCONTEXT_H
 
 #include <linux/types.h>
-#include <linux/posix_types.h>
 
 /* FP context was used */
 #define SC_USED_FP		(1 << 0)
-- 
2.46.0


