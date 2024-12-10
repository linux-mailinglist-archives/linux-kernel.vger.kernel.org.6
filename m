Return-Path: <linux-kernel+bounces-439122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99E29EAB09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BE1C282995
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D578230D27;
	Tue, 10 Dec 2024 08:52:18 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA6A12DD88
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820738; cv=none; b=ICYHuBJCn7JCaNOJtA3dNDDIIshbdr108O7W8KEm4fsVTQHlVoHyCa1cQSWu37p5RWLLnD1HOHYzWwQ/GfBNz5H1AK5ejGrLwZ+TZVJcTnBMPpCtz7wqJiML038w4QC/7sR1X8R+l1NARYtVleEHC9UWFYFCOxoGL2GkC99qqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820738; c=relaxed/simple;
	bh=hr0TPaCGw3LhKmhIDpLsXe/y8JIpZV+C5LY9aLrSB/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxp0D94++aL/1TzgEaynB709iI9Uj6wqb83apPxb5AHtK8fZzFFAI3G8CRRpETlxlZhCYXV+mSP+kjFeVjwk/CRGXecZNmwQ8X/jz6X43zN/85R0L+V0hXpFijJ8HcMfDSAFNDXR7DBEJLAkprCoG+fZOJU9210vIfLjmS5eiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:bf13:4c3:373e:7260])
	by laurent.telenet-ops.be with cmsmtp
	id mws72D00K3K2VbF01ws7Kj; Tue, 10 Dec 2024 09:52:08 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tKvyP-000eT0-U3;
	Tue, 10 Dec 2024 09:52:07 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tKvyR-009nZb-5C;
	Tue, 10 Dec 2024 09:52:07 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] kbuild: Drop architecture argument from headers_check.pl
Date: Tue, 10 Dec 2024 09:52:05 +0100
Message-Id: <168b2cb09f09ec3cead8a6b1e726ac76f5d06171.1733820553.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 7ff0fd4a9e20cf73 ("kbuild: drop support for
include/asm-<arch> in headers_check.pl"), the second argument $arch is
no longer used, hence drop it.

Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Closes: https://lore.kernel.org/CAK7LNARNa3NPSeRAUgMaEqWiA+C6-s1PxRe1bCUJg6zLyOtDkA@mail.gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 7ff0fd4a9e20cf73 is part of the mm tree.

 usr/include/Makefile         | 2 +-
 usr/include/headers_check.pl | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 771e32872b2ab12d..6c6de1b1622b1a69 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -78,7 +78,7 @@ quiet_cmd_hdrtest = HDRTEST $<
       cmd_hdrtest = \
 		$(CC) $(c_flags) -fsyntax-only -x c /dev/null \
 			$(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
-		$(PERL) $(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
+		$(PERL) $(src)/headers_check.pl $(obj) $<; \
 		touch $@
 
 $(obj)/%.hdrtest: $(obj)/%.h FORCE
diff --git a/usr/include/headers_check.pl b/usr/include/headers_check.pl
index 7070c891ea294b4d..2b70bfa5558e6451 100755
--- a/usr/include/headers_check.pl
+++ b/usr/include/headers_check.pl
@@ -3,9 +3,8 @@
 #
 # headers_check.pl execute a number of trivial consistency checks
 #
-# Usage: headers_check.pl dir arch [files...]
+# Usage: headers_check.pl dir [files...]
 # dir:   dir to look for included files
-# arch:  architecture
 # files: list of files to check
 #
 # The script reads the supplied files line by line and:
@@ -23,7 +22,7 @@ use warnings;
 use strict;
 use File::Basename;
 
-my ($dir, $arch, @files) = @ARGV;
+my ($dir, @files) = @ARGV;
 
 my $ret = 0;
 my $line;
-- 
2.34.1


