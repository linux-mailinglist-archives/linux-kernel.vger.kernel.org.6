Return-Path: <linux-kernel+bounces-174276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112DD8C0C68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FF01C20828
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BC114A617;
	Thu,  9 May 2024 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9lVmzlg"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701EF149E18
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242703; cv=none; b=o9WXVXzC5vEoyPqVUteoIWGwRsN39UV0gqXFuS2Rc9mK6g2k8sXF3JDzNswZUv5XCWsLx6mDZAEw1tS2suekLf7vRPNto3esHOB7O2Liij0sHcxRII1MKFkKk4YIARcT5rs9tknwY7vGy/0Zm+x3QGMOILQ+ss4He5TnVAsUHGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242703; c=relaxed/simple;
	bh=YWhSEjEbsm7333DuMdJ8QQbDQ8u2mmDpgmnCidre4OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=nn1rkqrkLBaG1RWBGVZEQ5v8QgNlfgnHjAA5Vednwh+e5OgRKL9MahcX0RukpDAoEtkCPGlAHY3ihbs//FeJ9HF5B7tM2JPXspn30sAajZJ14j88O6+y+Xwvw1B7Le0v6gScfQiJ+cKvq2yxAemR0qdrKBQVuPgJsLgW1hRpnCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9lVmzlg; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 59E95FF806;
	Thu,  9 May 2024 08:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715242680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yU2z5WhSAQTqB93fjY3ukGXftN14kQ1DQjtcB3aeejE=;
	b=e9lVmzlgiGpIHxll1amJDGhf3cX7f9PaBNhtrjSNqgPDDiJuvQHgGEX4lJd8jWYBPnfPA8
	uE7NNSoe0worlgTH3NhfRUBjcYBgbLFAJ7KjKJTCmxJvMUB4Dvpv+r+tE4w0vsysCX3IMd
	MRC6BxEpgVpZ+rF1j8ti1RrMJ23Xwd27oVJOIye6l0LX4iDfmyu4Wp4DTp9rCzduE99KSG
	AF00dSgs0r1qH19G7nhW2laO4jlv8a0QXu7zTqZxpNTshvKQDuUAwN8Pb4qnhfnAQaYpIC
	1BPg030SV4fPPwyB5rQ+9vzkukcFWo3rbq5+7TLnDkcKBonSVBDseLn+Koj9Dg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 09 May 2024 10:17:21 +0200
Subject: [PATCH v2 1/3] scripts/decode_stacktrace.sh: remove find_module
 recursion and improve error reporting
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-decode_stacktrace-find_module-improvements-v2-1-887fb6d5acb9@bootlin.com>
References: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
In-Reply-To: <20240509-decode_stacktrace-find_module-improvements-v2-0-887fb6d5acb9@bootlin.com>
To: Konstantin Khlebnikov <koct9i@gmail.com>, 
 Stephen Boyd <swboyd@chromium.org>, Sasha Levin <sashal@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The find_module() function can fail for two reasons:

 * the module was not found
 * the module was found but without debugging info

In both cases the user is reported the same error:

   WARNING! Modules path isn't set, but is needed to parse this symbol

This is misleading in case the modules path is set correctly.

find_module() is currently implemented as a recursive function based on
global variables in order to check up to 4 different paths. This is not
straightforward to read and even less to modify.

Besides, the debuginfod code at the beginning of find_module() is executed
identically every time the function is entered, i.e. up to 4 times per each
module search due to recursion.

To be able to improve error reporting, first rewrite the find_module()
function to remove recursion. The new version of the function iterates over
all the same (up to 4) paths as before and for each of them does the same
checks as before. At the end of the iteration it is now able to print an
appropriate error message, so that has been moved from the caller into
find_module().

Finally, when the module is found but without debugging info, mention the
two Kconfig variables one needs to set in order to have the needed
debugging symbols.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 scripts/decode_stacktrace.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa5be6f57b00..7f3fb5e82707 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -88,31 +88,32 @@ find_module() {
 		fi
 	fi
 
-	if [[ "$modpath" != "" ]] ; then
-		for fn in $(find "$modpath" -name "${module//_/[-_]}.ko*") ; do
-			if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
-				echo $fn
-				return
-			fi
-		done
-		return 1
-	fi
-
-	modpath=$(dirname "$vmlinux")
-	find_module && return
-
-	if [[ $release == "" ]] ; then
+	if [ -z $release ] ; then
 		release=$(gdb -ex 'print init_uts_ns.name.release' -ex 'quit' -quiet -batch "$vmlinux" 2>/dev/null | sed -n 's/\$1 = "\(.*\)".*/\1/p')
 	fi
+	if [ -n "${release}" ] ; then
+		release_dirs="/usr/lib/debug/lib/modules/$release /lib/modules/$release"
+	fi
 
-	for dn in {/usr/lib/debug,}/lib/modules/$release ; do
-		if [ -e "$dn" ] ; then
-			modpath="$dn"
-			find_module && return
+	found_without_debug_info=false
+	for dir in "$modpath" "$(dirname "$vmlinux")" ${release_dirs}; do
+		if [ -n "${dir}" ] && [ -e "${dir}" ]; then
+			for fn in $(find "$dir" -name "${module//_/[-_]}.ko*") ; do
+				if ${READELF} -WS "$fn" | grep -qwF .debug_line ; then
+					echo $fn
+					return
+				fi
+				found_without_debug_info=true
+			done
 		fi
 	done
 
-	modpath=""
+	if [[ ${found_without_debug_info} == true ]]; then
+		echo "WARNING! No debugging info in module ${module}, rebuild with DEBUG_KERNEL and DEBUG_INFO" >&2
+	else
+		echo "WARNING! Cannot find .ko for module ${module}, please pass a valid module path" >&2
+	fi
+
 	return 1
 }
 
@@ -130,7 +131,6 @@ parse_symbol() {
 	else
 		local objfile=$(find_module)
 		if [[ $objfile == "" ]] ; then
-			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
 			return
 		fi
 		if [[ $aarray_support == true ]]; then

-- 
2.34.1


