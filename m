Return-Path: <linux-kernel+bounces-264523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE60693E473
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A138B1F21807
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38954765;
	Sun, 28 Jul 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C1DgjJTG"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8823BB24;
	Sun, 28 Jul 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161421; cv=none; b=c4cB69+c6mBx3t/LvB2tcrIlfp40WkjheNkVZaJ7p4MEa6o0FUSmrF2ofVMMJ/7DpL28dzVe8vRUzjJfIwTGNI/zWZhwp4d9dy4wLBWvPn/sr8FRmjcNLRH1csmhIZWjn5Q3MSw3kbZDrvbBqDEelNcIIfrmkj9hJtTHi/7qmjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161421; c=relaxed/simple;
	bh=y2afXACcLDaFX3zkiEL9TM0mUXBaMn2Zx8HipnSDda8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=laWP6s6UHMvmQWYqArHyuq/dXcQ/5H9gTjViEw5vfG34DiwxHtDa+99SDFV7viH1Ond2RSmV46FcQTCVDeloFP/o3nlGsmGTUJ/ezSFYJNcl71FZaWQF23BrNq7Z+9P4C8IqWhuYENVVYY8rN2wO3SzWCEhNroAPrelXh8pLxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C1DgjJTG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=y2afXACcLDaFX3zkiEL9TM0mUXBaMn2Zx8HipnSDda8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C1DgjJTG089t9CZsv/NnSgz2hHXCWy/fN6oryUWj391sTs63eg1x/apskTiWenqQ1
	 5q61Q6drEmkHHdXfwD7k25MwCO3eRYILjwEHjUIJHg8siU+sjiiyjDo2b7KHI9SErQ
	 Z2ZVboj8P2hGLwoP7CZhsOT8YTdR3EUzCw2Miqu4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:05 +0200
Subject: [PATCH 11/12] selftests/nolibc: run-tests.sh: avoid overwriting
 CFLAGS_EXTRA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-11-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1485;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y2afXACcLDaFX3zkiEL9TM0mUXBaMn2Zx8HipnSDda8=;
 b=W2/Qu+gER8dEDijIyITmcbJhA20YxfQaMVKgcyZEnwAnWlKpyzn4KLp1P6/MACeU/xs6yIG4n
 9nhtefwygCzD6XT6J0UtqOHH+sRjaio3ptrwDLYRyAOABlt91ORuedj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

If the user specified their own CFLAGS_EXTRA these should not be
overwritten by `-e`.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 0446e6326a40..324509b99e2c 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -15,7 +15,7 @@ download_location="${cache_dir}/crosstools/"
 build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
 test_mode=system
-CFLAGS_EXTRA="-Werror"
+werror=1
 archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:peh' -n "$0" -- "$@")
@@ -69,7 +69,7 @@ while true; do
 			test_mode="$2"
 			shift 2; continue ;;
 		'-e')
-			CFLAGS_EXTRA=""
+			werror=0
 			shift; continue ;;
 		'-h')
 			print_usage
@@ -140,6 +140,9 @@ test_arch() {
 	ct_abi=$(crosstool_abi "$1")
 	cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
 	build_dir="${build_location}/${arch}"
+	if [ "$werror" -ne 0 ]; then
+		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror"
+	fi
 	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" O="${build_dir}")
 
 	mkdir -p "$build_dir"

-- 
2.45.2


