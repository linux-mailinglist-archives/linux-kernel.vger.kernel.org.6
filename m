Return-Path: <linux-kernel+bounces-343372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB0F989A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68E71C2115B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 05:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFA313B59B;
	Mon, 30 Sep 2024 05:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RhqEunER"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3682A47
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674533; cv=none; b=Gv2KSRc0jIxn2tiA8MCBZsDFMLp3xgG5TaoIZAUrGyP4v3h87vzHdwy0p19JjE5ac9sVRppGNSthrK8xkcivEBi2L0Gj8IUCyvGlXNFtDoS+tFEaPv7JRr/wX4RwPF3I4dBsSZr1LijQimtFYK2vR/MPlPK3IiUyoE2YSVnw5HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674533; c=relaxed/simple;
	bh=f69NjxeLWgCvu1AxRb/ia8cq5/1iiXIEWEdC+aBzadQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SLUGJLmf4ePHqyFXXjQ4YwEJ8CnrD7oA/V+s45BRIHeF4NSCgLQOkIJO3FItx/f93V9nOvt4yG7aq6joT+rwsUUyi+HQQHJ45D44qJEO8va9zHtpH1NU/1qB64ljyVdWZPRNOzw97YDco4C8Y44trajAT++HRiTtf3x7xGSRUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RhqEunER; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727674527;
	bh=f69NjxeLWgCvu1AxRb/ia8cq5/1iiXIEWEdC+aBzadQ=;
	h=From:Date:Subject:To:Cc:From;
	b=RhqEunERZfsgneyf9WoAF11ZwWXVBfwBzhgaoORZSM2Qgw83M9RSJ8/lbqRiqen2I
	 /GahA3d80qvqEg/zam5U0mulDovyadKhmtwJV0aBLvhHNaLmivjTGKdEpO4qnHtFML
	 R6PMQmxN9aw8G+2+AbjlL6g9oVxONzVC0U3oBGsc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 30 Sep 2024 07:35:19 +0200
Subject: [PATCH v2] tools/nolibc: compiler: add macro __nolibc_fallthrough
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240930-nolibc-fallthrough-v2-1-2e8d10fe3430@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAJY4+mYC/32NQQ6CMBBFr0JmbQ2MoNSV9zAsBhzoJKQ1HUAN4
 e5WDuDyveS/v4JyFFa4ZitEXkQl+AR4yKBz5Ac28kgMmGOZW7TGh1HazvQ0jpOLYR6caalGpJI
 sVhWk4TNyL+89em8SO9EpxM/+sRQ/+ze3FKYwFXN+YbJ0rk+3F4uqdm52R88TNNu2fQHs/PV2u
 QAAAA==
X-Change-ID: 20240929-nolibc-fallthrough-ba822a4a9255
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727674526; l=2262;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=f69NjxeLWgCvu1AxRb/ia8cq5/1iiXIEWEdC+aBzadQ=;
 b=xjOrvT1EAYYMnxa+CvQHqgX74LM6B1BVSF87TIXP6RjD9q2rdG42bNNXnv3dvkJviMEiYufPt
 h4uHZecKRI6CRCzM2WgTBn5autsVlEL9YSfzUWTrAIJPcpBeIjWKWx4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Recent version of GCC and clang gained -Wimplicit-fallthrough,
warning about implicit fall-through between switch labels.
As nolibc does not control the compilation flags, this can trigger
warnings for when built by the user.
Make use of the "fallthrough" attribute to explicitly annotate the
expected fall-throughs and silence the warning.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Add a do-while loop to improve compiler compatibility
- Link to v1: https://lore.kernel.org/r/20240929-nolibc-fallthrough-v1-1-5ee07ea9a683@weissschuh.net
---
 tools/include/nolibc/compiler.h | 6 ++++++
 tools/include/nolibc/stdio.h    | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 9bc6a706a332378e5af1f5baabf953f137f99749..fa1f547e7f13d151ea98b9c585b36659d2d27324 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -32,4 +32,10 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
+#if __nolibc_has_attribute(fallthrough)
+#  define __nolibc_fallthrough do { } while (0); __attribute__((fallthrough))
+#else
+#  define __nolibc_fallthrough do { } while (0)
+#endif /* __nolibc_has_attribute(fallthrough) */
+
 #endif /* _NOLIBC_COMPILER_H */
diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index c968dbbc4ef8137e237b859bf18a6d2970230cbf..3892034198dd566d21a5cc0a9f67cf097d428393 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -15,6 +15,7 @@
 #include "stdarg.h"
 #include "stdlib.h"
 #include "string.h"
+#include "compiler.h"
 
 #ifndef EOF
 #define EOF (-1)
@@ -264,7 +265,7 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 				case 'p':
 					*(out++) = '0';
 					*(out++) = 'x';
-					/* fall through */
+					__nolibc_fallthrough;
 				default: /* 'x' and 'p' above */
 					u64toh_r(v, out);
 					break;

---
base-commit: e7ed343658792771cf1b868df061661b7bcc5cef
change-id: 20240929-nolibc-fallthrough-ba822a4a9255

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


