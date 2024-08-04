Return-Path: <linux-kernel+bounces-273616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24CA946B87
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D023C281DC3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 00:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D85564C;
	Sun,  4 Aug 2024 00:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U/US/c2b"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCE18E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 00:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722729714; cv=none; b=QVHe320vT9QXFFzgyxyYxho0apNfXMYtXFJGoncf6KJvrc46xUsRGlDqCoT9stj1gnRSU84V3zmNofpnb6/87m3rEEmLpDLmV6TjH1rJqfYLpE3EuVal1VT/wYJBUWpVydAdG4u6XC9RsmCx3pCP/dZfGArsjKb9/2TArjpOcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722729714; c=relaxed/simple;
	bh=QWatGnYIjr75cFL7gnu9Hw8K1zXzdXEziy6dMJKQG0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RhTU0aHcgeEYFOZrEtIjVAQcWpcyHkDxl2CWf1bOirvSlRnssaUBbl7n3uZkt4Dj9kUcenSwliYhuAygEPGx3kHYbAOcz3lDK+mQYoAcX4Nan80cxIojAsTX9wnNZGI5aqcj6QeV/WzabCTySBN85F/cxVZP/dZAmxCSfPzoTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U/US/c2b; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722729709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIdTyUKOG+u/puKVKslCgH0BjO8rJiEJyhRvAfqLFlU=;
	b=U/US/c2b7LK1qa5E7K3IWPhjvMlKS6Cwv5lDgC9f+vDntRiyJsRb5C0hZd1pbop6ws4JJ8
	5XhXZhFyfFCPNK+Ah7Nfd/kr3LsbaYStzETdgoS0jqPI+q77OW+yIzHodzbARwTdjDu/1+
	BCuzyPmcK7ubX0M7WOlrl/KiyYuoQWA=
From: Jose Fernandez <jose.fernandez@linux.dev>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christian Heusel <christian@heusel.eu>
Cc: Jose Fernandez <jose.fernandez@linux.dev>,
	Peter Jung <ptr1337@cachyos.org>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: control extra pacman packages with PACMAN_EXTRAPACKAGES
Date: Sat,  3 Aug 2024 18:01:25 -0600
Message-ID: <20240804000130.841636-1-jose.fernandez@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce a new variable, PACMAN_EXTRAPACKAGES, in the Makefile.package
to control the creation of additional packages by the pacman-pkg target.

This changes the behavior of the pacman-pkg target to only create the
main kernel package by default. The rest of the packages will be opt-in
going forward.

In a previous patch, there was concern that adding a new debug package
would increase the package time. To address this concern and provide
more flexibility, this change has been added to allow users to decide
which extra packages to include before introducing an optional debug
package [1].

[1] https://lore.kernel.org/lkml/20240801192008.GA3923315@thelio-3990X/T/

Signed-off-by: Jose Fernandez <jose.fernandez@linux.dev>
Reviewed-by: Peter Jung <ptr1337@cachyos.org>
---
 scripts/Makefile.package |  5 +++++
 scripts/package/PKGBUILD | 11 ++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 4a80584ec771..146e828cb4f1 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -144,6 +144,10 @@ snap-pkg:
 # pacman-pkg
 # ---------------------------------------------------------------------------
 
+# Space-separated list of extra packages to build
+# The available extra packages are: headers api-headers
+PACMAN_EXTRAPACKAGES ?=
+
 PHONY += pacman-pkg
 pacman-pkg:
 	@ln -srf $(srctree)/scripts/package/PKGBUILD $(objtree)/PKGBUILD
@@ -152,6 +156,7 @@ pacman-pkg:
 		CARCH="$(UTS_MACHINE)" \
 		KBUILD_MAKEFLAGS="$(MAKEFLAGS)" \
 		KBUILD_REVISION="$(shell $(srctree)/scripts/build-version)" \
+		PACMAN_EXTRAPACKAGES="$(PACMAN_EXTRAPACKAGES)" \
 		makepkg $(MAKEPKGOPTS)
 
 # dir-pkg tar*-pkg - tarball targets
diff --git a/scripts/package/PKGBUILD b/scripts/package/PKGBUILD
index 663ce300dd06..41bd0d387f0a 100644
--- a/scripts/package/PKGBUILD
+++ b/scripts/package/PKGBUILD
@@ -3,10 +3,15 @@
 # Contributor: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
 
 pkgbase=${PACMAN_PKGBASE:-linux-upstream}
-pkgname=("${pkgbase}" "${pkgbase}-api-headers")
-if grep -q CONFIG_MODULES=y include/config/auto.conf; then
-	pkgname+=("${pkgbase}-headers")
+pkgname=("${pkgbase}")
+
+_extrapackages=${PACMAN_EXTRAPACKAGES:-}
+if [ -n "$_extrapackages" ]; then
+	for pkg in $_extrapackages; do
+		pkgname+=("${pkgbase}-$pkg")
+	done
 fi
+
 pkgver="${KERNELRELEASE//-/_}"
 # The PKGBUILD is evaluated multiple times.
 # Running scripts/build-version from here would introduce inconsistencies.
-- 
2.46.0


