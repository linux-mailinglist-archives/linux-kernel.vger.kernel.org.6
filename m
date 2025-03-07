Return-Path: <linux-kernel+bounces-551090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BDA56808
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C64E18998AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81693219309;
	Fri,  7 Mar 2025 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0GVy30Oe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZw4mupL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67714A4F9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351412; cv=none; b=uHc6rNBUkgkBRJ1+59kiyePsy7qOrj8fExjKSSUIxZE6GRtwprS1o09arYt25OwpLj/oAEB46innkGgh5a+3xG5GA8sYCLomYE0UNFEWzcToHFz+UO1p/t4xaCP9XYtSKnc+sYQn11cRO49+SyKkDNPtaPdaO3uGH+QGMm6f3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351412; c=relaxed/simple;
	bh=7VmanMlSY+AL4R5Gl2+izLNwqisKICSmKSHCP61d7X4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l061qzJKE6QfEFVkNB5hBKWxSJpIJ2sNuiVS52xWSfjc/mNTcU/OL/+TWiiaWSGKKASS/OUPJbGztl+xu0n6LslzrHyovObfi5CSY+YZ4BnXI+MPihN+aYmVuJjsSC9mY3eKxGR4QBCtUD8bVIGRULLSMBj4VNADEu46sb9tBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0GVy30Oe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZw4mupL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741351408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hiWhhFFiguC06XDLj0xZWCAnw46+uSzsqCLVXGy3bqM=;
	b=0GVy30OeGXpmtADuBX35FXO0zSDxLiaJZjaKxvGp0OIeeH7Nk6kvJrVFBuOjdTTNt4Pn6+
	hKODrW2wUH427dTmnDDCTUbK9ZjfU7TnkcTF5troe574orvLiZD1AAu1dUQTWhiuDRHf38
	oOh6buwzKFDkp1mm1HK57nJC9IsWO+1TxfO7PppDFLAk2db9r9KE5Ya272mjqYxr4Vd0ux
	YsADF1tKUioZgMzn9/TV2f74df0whDuIeOWWjE3WMHotqbdnBHFtUabHbkhHuzjO4zIPRJ
	ShXX4anigtReAMKuc47smAGxkgVXWuCp0zlT3i7n8IFzHEEF530wqqxKGL8lFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741351408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hiWhhFFiguC06XDLj0xZWCAnw46+uSzsqCLVXGy3bqM=;
	b=EZw4mupLSQoxdrmdJyKguJYM0IdXY4LGBr4sw13RIDOKd3FHeLpIiWGA6wv9jg90jsIPtN
	QdCiUpD+BBXsKqDA==
Date: Fri, 07 Mar 2025 13:43:23 +0100
Subject: [PATCH v2] tools/nolibc: don't use asm/ UAPI headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-nolibc-asm-headers-v2-1-e2a734f25d22@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAOrpymcC/32NQQ6CMBBFr0Jm7ZgyDUJceQ/CotKpTIKtaZFgS
 O9u5QAu30v++zskjsIJrtUOkVdJEnwBOlUwTsY/GMUWBlLUKK0a9GGW+4gmPXFiYzkm1C11dHG
 mc9pBGb4iO9mOaD8UniQtIX6Oj7X+2b+5tcYaHalGW3bE3N5m8e8lBi/b2TIMOecvg1mQ6rgAA
 AA=
X-Change-ID: 20250305-nolibc-asm-headers-372826fa8f3f
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741351407; l=2634;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=7VmanMlSY+AL4R5Gl2+izLNwqisKICSmKSHCP61d7X4=;
 b=v3GgKbG6q81UqOVdqDDElEK2JG3g5bwXd+gDyipgRc9MKaXCdglIP9IJ1iw4ZLklnZxSS8NvU
 zh+lkoAv6x9A1vE1HanxFwFLAAhE6f9sVtYZDSimT26+y961L3QC2h9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The asm/ and asm-generic/ namespaces are implementation details of the UAPI
headers and not meant for direct usage.

Use the equivalent headers from the linux/ namespace instead.

While at it also drop the duplicate include of linux/signal.h from sys.h.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Avoid duplicate '#include <linux/signal.h>'
- Link to v1: https://lore.kernel.org/r/20250305-nolibc-asm-headers-v1-1-f2053def2ee7@linutronix.de
---
 tools/include/nolibc/arch-s390.h | 4 ++--
 tools/include/nolibc/errno.h     | 2 +-
 tools/include/nolibc/sys.h       | 9 ++++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index acfee7e9d5e2bb65718cb947110d2c5e1cdeba9b..df4c3cc713accd45551e07e1f02d3638e49e300e 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -5,8 +5,8 @@
 
 #ifndef _NOLIBC_ARCH_S390_H
 #define _NOLIBC_ARCH_S390_H
-#include <asm/signal.h>
-#include <asm/unistd.h>
+#include <linux/signal.h>
+#include <linux/unistd.h>
 
 #include "compiler.h"
 #include "crt.h"
diff --git a/tools/include/nolibc/errno.h b/tools/include/nolibc/errno.h
index a44486ff047745bc9bcf9748c3e5074213430f80..1d8d8033e8ff766ee4b3cf7efdb741d4208db04e 100644
--- a/tools/include/nolibc/errno.h
+++ b/tools/include/nolibc/errno.h
@@ -7,7 +7,7 @@
 #ifndef _NOLIBC_ERRNO_H
 #define _NOLIBC_ERRNO_H
 
-#include <asm/errno.h>
+#include <linux/errno.h>
 
 #ifndef NOLIBC_IGNORE_ERRNO
 #define SET_ERRNO(v) do { errno = (v); } while (0)
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 5d8adc7785759d2ef9316d70979740b16756dab1..08c1c074bec89a27e53e5d461a3ebbf71ec323d1 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -10,10 +10,10 @@
 #include "std.h"
 
 /* system includes */
-#include <asm/unistd.h>
-#include <asm/signal.h>  /* for SIGCHLD */
-#include <asm/ioctls.h>
-#include <asm/mman.h>
+#include <linux/unistd.h>
+#include <linux/signal.h>  /* for SIGCHLD */
+#include <linux/termios.h>
+#include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/loop.h>
 #include <linux/time.h>
@@ -23,7 +23,6 @@
 #include <linux/prctl.h>
 #include <linux/resource.h>
 #include <linux/utsname.h>
-#include <linux/signal.h>
 
 #include "arch.h"
 #include "errno.h"

---
base-commit: a782d45c867ca92edc50e54715a71124bec1dd11
change-id: 20250305-nolibc-asm-headers-372826fa8f3f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


