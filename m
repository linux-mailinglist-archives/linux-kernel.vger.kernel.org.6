Return-Path: <linux-kernel+bounces-343204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EB5989811
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174F11C20CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A3768E1;
	Sun, 29 Sep 2024 21:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IPaJ/nHB"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B18F6D
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646608; cv=none; b=ppY1/jjtlVoHFd+l9jA+hoCXiUBJYwaqulNXSDlu6mEC3Vw8pBRNRbNuxP2FpKh6Uk3MgzorqFg0cWh1GKbpJZkCLsH+J0wFtGLsOyRltqDqce5hqAQ597NhH2wz/YiB+nyPa1pjsTtQgc7WnNZw7r3q4hu9lGzHXw5krFfEP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646608; c=relaxed/simple;
	bh=Jk49fhk8slceGx+/frOFZ4vgsPz5bUJQXWPnaQP7KoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nzUOPaUbuJ1PKMqx+zJQXq1wsTWeRi98hvrsCyyy5SLfuvc6aazECj6MiUs9oZ19ldzgB7fjuqERtYERO90RblRjrlr+1Hs/KteCvttKy9ZD05iGAGPDNuwiz+Xv8L+5MD1vHEkNWAkj4jh3MZq5U7hGNw6DUeoU4yP16dmaYVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IPaJ/nHB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646604;
	bh=Jk49fhk8slceGx+/frOFZ4vgsPz5bUJQXWPnaQP7KoU=;
	h=From:Date:Subject:To:Cc:From;
	b=IPaJ/nHBshdeFCDyk17scyZhQiZrzLiwfgnAd2CZUnCW9PZnh+MAvgy+6ffn+ZIzd
	 8MyYsQ359VY/5PWZArktN3oC0vrpB/rz0NiLxWctIW6eLgH7qke07Jwf/3xAlYrt4A
	 iz+YclDq2wu6QlucBPr3xBEWl/HceEFYxJpJeBZY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 29 Sep 2024 23:49:57 +0200
Subject: [PATCH] tools/nolibc: compiler: add macro __nolibc_fallthrough
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240929-nolibc-fallthrough-v1-1-5ee07ea9a683@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAITL+WYC/x3MQQqAIBBA0avErBNqKMiuEi2mGnVANLQiiO6et
 HyL/x/InIQzjNUDiS/JEkNBW1ewOgqWlWzFgA12jUatQvSyrMqQ94dL8bROLTQgUkca+x5KuCc
 2cv/TaX7fDwjvYVdkAAAA
X-Change-ID: 20240929-nolibc-fallthrough-ba822a4a9255
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646603; l=2047;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Jk49fhk8slceGx+/frOFZ4vgsPz5bUJQXWPnaQP7KoU=;
 b=pa+c9OcGTa2o/eMcIWMmpz3S8yUvbxvwie1s/q7tuKy+IonnFRH9Ig95f9FPupzZ05sGAlfPJ
 c/sfgffF6AtBlxOyCeGSJ8XhCMaAW1kTuXikOyyQjEp8/fcuRPNNDa3
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
 tools/include/nolibc/compiler.h | 6 ++++++
 tools/include/nolibc/stdio.h    | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 9bc6a706a332378e5af1f5baabf953f137f99749..d213b67e5f1f6101128ba8a7ddfbaa2daac20b9b 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -32,4 +32,10 @@
 #  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif /* __nolibc_has_attribute(no_stack_protector) */
 
+#if __nolibc_has_attribute(fallthrough)
+#  define __nolibc_fallthrough __attribute__((fallthrough))
+#else
+#  define __nolibc_fallthrough
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


