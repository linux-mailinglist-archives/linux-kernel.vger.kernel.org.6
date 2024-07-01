Return-Path: <linux-kernel+bounces-236602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5441D91E4B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068ED2837AC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D54316D4D4;
	Mon,  1 Jul 2024 15:58:44 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0F2126F1E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719849524; cv=none; b=VKXi6c9/kmHMWjDDiokL3pO7aT0Vdd7aUNm/TRHaewevBDiLB1rm4AlgWaSx8pokN6wNP748BK2P+P68HpZHaa0JL1E0v6qZ1tu4LSlc+e8h4KvtrHIrmBcItzI57rVDCVdPDCAzFNP8Muj36841ULi3JntgLFcelg9u5Ea2mN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719849524; c=relaxed/simple;
	bh=P65RSjpx1W3Wlc35q3Hd0bUfGsAgaHRuGZmoy0ZMZlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OamuzdB7ht10CnZRrNwK2xRs8Ky/g6S5auqF8RbuPEZ+CJpPmx+ohJLAUgA8ScBlfVby0JuqyrrcRI0Qjcc597gsfWx2AcG2J+3GgUwzgJd4Z+UoaeKw6GnvmzwaVsAbCHY8S0SHgtHwya0utlZuEeKuvLL0jEsmYJC8WhWkt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from abreu.molgen.mpg.de (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4AC2161E5FE01;
	Mon,  1 Jul 2024 17:58:16 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	kernel@pengutronix.de,
	it+linux-kconfig@molgen.mpg.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH] lib/build_OID_registry: Avoid non-destructive substitution for Perl < 5.13.2 compat
Date: Mon,  1 Jul 2024 17:58:01 +0200
Message-ID: <20240701155802.75152-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On a system with Perl 5.12.1, commit 5ef6dc08cfde
("lib/build_OID_registry: don't mention the full path of the script in
output") causes the build to fail with the error below.

     Bareword found where operator expected at ./lib/build_OID_registry line 41, near "s#^\Q$abs_srctree/\E##r"
     syntax error at ./lib/build_OID_registry line 41, near "s#^\Q$abs_srctree/\E##r"
     Execution of ./lib/build_OID_registry aborted due to compilation errors.
     make[3]: *** [lib/Makefile:352: lib/oid_registry_data.c] Error 255

Ahmad Fatoum analyzed that non-destructive substitution is only supported since
Perl 5.13.2. Instead of dropping `r` and having the side effect of modifying
`$0`, introduce a dedicated variable to support older Perl versions.

Fixes: 5ef6dc08cfde ("lib/build_OID_registry: don't mention the full path of
the script in output")
Link: https://lore.kernel.org/all/259f7a87-2692-480e-9073-1c1c35b52f67@molgen.mpg.de/
Solution-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: kernel@pengutronix.de
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: it+linux-kconfig@molgen.mpg.de
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 lib/build_OID_registry | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/build_OID_registry b/lib/build_OID_registry
index 56d8bafeb848b..8267e8d71338b 100755
--- a/lib/build_OID_registry
+++ b/lib/build_OID_registry
@@ -38,7 +38,9 @@ close IN_FILE || die;
 #
 open C_FILE, ">$ARGV[1]" or die;
 print C_FILE "/*\n";
-print C_FILE " * Automatically generated by ", $0 =~ s#^\Q$abs_srctree/\E##r, ".  Do not edit\n";
+my $scriptname = $0;
+$scriptname =~ s#^\Q$abs_srctree/\E##;
+print C_FILE " * Automatically generated by ", $scriptname, ".  Do not edit\n";
 print C_FILE " */\n";
 
 #
-- 
2.40.1


