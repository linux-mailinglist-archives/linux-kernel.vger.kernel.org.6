Return-Path: <linux-kernel+bounces-546238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2964BA4F839
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B20616D61A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E391EF0B4;
	Wed,  5 Mar 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wJkdAGWG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sWLAyG57"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB81D86FB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160917; cv=none; b=thTfve+1dNPgJyfTMj7nDcsT1LRG5NvmMsy9FSjIma49OF9RARTV2hcVWUashr0GY/Bsgdtdf0MXJ+grnIegOZPklY2D5YTOpQ2oIyB+KY6JHdKt5VtyxBKMp7eLqwAcX5GlsfaT/Wmk+xoRHWPogqOOFopuT2cSZZjf2W3ZBr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160917; c=relaxed/simple;
	bh=MOVxLsldxSzzkncdFrsmbwgGBG9+y57xSR00hWfN4QY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TU32sNJOMjBXOfcbxC9Z1l/tRAPedRhmr49lfMaKXqSAH97HnBcOapElaelyIyVLkZULLtn5dXU2z3Aihga4teh75qZCAHczOocdDcG6INfD4ARw1agYfzXQJNk0zm47mfL1QGFwFGzEo4kO+u6wkWTfz7Pi5qgCIYe4ovi30nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wJkdAGWG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sWLAyG57; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741160914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EKIJdoZTaWwWUpQrkFTqmWnQgJD8NqxVx8MOFMvcjOk=;
	b=wJkdAGWGUetiJaYajWut595+keRaDuDTB20KpD3a/k+zi/eIpU7xmDNu047gJYKL9V5iz0
	s5NPoNAYoklBocvkt80wpZvzDtee8syW8LAw5pUPy3xmVIn0ZyfWw7czmezM4Yximl+6y/
	GkOlog1AUbG4/L+A+HoeA3mKnYhO/gOiSrNjepRZUsy6Q/kg3FLiXJJBm+I66FY9kGWmNu
	wUStQcCJQFtJ2gDOHhejouvm5vHOEKb0c2ZSAaWvCdgv3RdODtR2ZTWCu4dMn4WCk47Caq
	oZCCFa+sMmSlI7b9H+tgcCzINEEp/DiIckQB0pimgFwhiOKWplhj1fOKAOx6Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741160914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EKIJdoZTaWwWUpQrkFTqmWnQgJD8NqxVx8MOFMvcjOk=;
	b=sWLAyG57LfZJ34TMSmr1yqMOc1CKvErWad5KMWXSi5IQIl6p5a5EAYD3Dkz02KYJY0yW/U
	Kj/2FCYmzGxr4BAQ==
Date: Wed, 05 Mar 2025 08:48:13 +0100
Subject: [PATCH] tools/nolibc: don't use asm/ UAPI headers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-nolibc-asm-headers-v1-1-f2053def2ee7@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALwByGcC/x3MTQqAIBBA4avErBswpR+6SrSwGnOgLByIQLx70
 vJbvJdAKDIJjFWCSA8LX6GgqStYvQ07IW/FoJVulVEthuvgZUUrJ3qyG0VB0+tBd84Ozjgo4R3
 J8ftPpznnD3n3WqpkAAAA
X-Change-ID: 20250305-nolibc-asm-headers-372826fa8f3f
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741160913; l=2210;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=MOVxLsldxSzzkncdFrsmbwgGBG9+y57xSR00hWfN4QY=;
 b=fTenldmkupcWVow4C/ZhNNo8nlv3Gadny7TtkBUaOK3UAjfr4Dcr3X4cgCgXfRLHEZS5UYoxS
 zrkliX03mokBmi66IV4pIyBXvTRGX4gsNczqViIYdKckVVxLVuiz6BZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The asm/ and asm-generic/ namespaces are implementation details of the UAPI
headers and not meant for direct usage.

Use the equivalent headers from the linux/ namespace instead.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/arch-s390.h | 4 ++--
 tools/include/nolibc/errno.h     | 2 +-
 tools/include/nolibc/sys.h       | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

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
index 8f44c33b121300e80b41c971019484007d050b17..cbf7345c4b8dcda8cc0832c487383606672366eb 100644
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

---
base-commit: cb839e0cc881b4abd4a2e64cd06c2e313987a189
change-id: 20250305-nolibc-asm-headers-372826fa8f3f

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


