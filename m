Return-Path: <linux-kernel+bounces-448279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 877909F3E17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC66916DDFB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2A1D8E12;
	Mon, 16 Dec 2024 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yZAoAsop"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB2A1D90AE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734390810; cv=none; b=fEXWrE1LeMx7ZAa+uIfTuTulW8vPaCF+UafDVtAREbDCGXkX8YR/8nZglkF23HIxFGjtA13ZymHG2WY5/vBrb6771RAB12fhty6v7Y0VHuvi8qOmQCcBPTaT7GcBhNcN33ZdxFPHk8Ezb296jMF8OH9RnDb1oni2l8CAZgG6/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734390810; c=relaxed/simple;
	bh=IChtsS2vcC0zzlF9qX93bNksLgkX24amcVZg/Whalhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VEKITII0jsZzSpWU14o5CeqzV8aBJ9k6oBa9UCQ78nok9zrA9CWs1Dxs0jGksfezdlGpD3I0yuvz9ZM9oq3OAMSdz+T3UtNa9+J8mg0ykJVHd5FsbIOdnA1M86iKdkb8AsIIidrOzrBLsOLag3zq4D/efCvE/nlZo1uyCjd6/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yZAoAsop; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21636268e43so57166185ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734390806; x=1734995606; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KtErM1Ve2hYinmhWDXFCRPsbxJ5zQtoWuxH4M5kRJWs=;
        b=yZAoAsophac381RvX87Kck32TSlUlWV8JTdi3EX3V5YXYxVXDjkP7p6vPUNyuDq4Xr
         529+cX/SbJt2Ii2IDF1caXgca/HvpJNI2iruBG6knFVretP1XZo1TpDzXQcymEjUCg14
         UUc49ZaWhw7g4R0AOIHaHKpj+6Y1FRNHa1OQ1Ndx0cPZnZyAHnN8BCj1M36nZSss9y2P
         34qPTTUdE0xoQC97QPGrqu0Kw9vd0IYO3m+ZODjxzv5eTr1DAk2BcLQj+iOQJOC5lZOd
         qCH3ew77HSs5zNZUWYSPMCsZ3hLXXvZ40aYqxxuRZRbb/JjVQ8QvawX6F1mrD1YYs4Dn
         bDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734390806; x=1734995606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtErM1Ve2hYinmhWDXFCRPsbxJ5zQtoWuxH4M5kRJWs=;
        b=Dtd1sGfjfZ8k0XUtUW1Z0BmwFigN/UNXRwQ8qn/9ZA2FJNxqwi0tszunrd4lF7h6H2
         0vSa+Rk0/aiAkyGkwDzTSRfUdbiv5RH2zCJuWP8cPnbGwtY3Noa4tY7TYw+2RdFFI7YZ
         dSXGbj6DOmO3D2D9YsumrEw5VWBBocgB2XCdSfwpXl5ATEayVTsBupJZZoETDpfIJvFe
         VpbM6/9wlTewjFQ/WBNI/tYWbrJq+DnRFODcSTjO6F23GFTjkvXODfkUFaO+C/RL1ZVh
         VM1JywTsTRJCZY4Q6su8B8gzaurbH/N3+rhqqz8Wos3TTto/Lm8In5rX7yv9s4HdOHRI
         eOgw==
X-Gm-Message-State: AOJu0Yw22MCO5HwowTiXMfFlqBZbhs3V8VTyjRWpVo5ZIxJbyICBfdi9
	5XMeSL6Tu29YG974aVeK8B4cpWowb2t8JaESx49gKFIctyFLiLxAOUCOumMaNqs=
X-Gm-Gg: ASbGnctJ/T+r+HpOtcLTz9mtJkpDhfJmtRVbhDJ6um4tCubVSYMiU/QZOhqgbVevVe1
	HNV0KJ0fJZWMVGF2x8jTc4Z2ufS/UdMX9BzlsVxQi2ZD+Sn4pzXLnBI4Lxh03XUL9KdHi4aF8nr
	aH3yPbKBooTa+jWO82leVn5GuG6T5HueWq4+vygmdLlowD/A2ct5G6iLaEkSpOTsncuc7zaGw6G
	ttkFD5bDrCM3yK1iq9Yh4FXELqyeNj9NOF63MeKtP0SD6xPlwBsFJtYkRvXF22brz0OMIJQ
X-Google-Smtp-Source: AGHT+IG7d1EVk09Gyn4kffMe9mhj+HK2qa0XP67wFBNzKqGiDe300RSugOZB/wYYtlbfPKTuuRzmLQ==
X-Received: by 2002:a17:902:ecc8:b0:215:7421:262 with SMTP id d9443c01a7336-218929820a5mr216451045ad.12.1734390806556;
        Mon, 16 Dec 2024 15:13:26 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dcc47bsm48333255ad.63.2024.12.16.15.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 15:13:25 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 15:12:51 -0800
Subject: [PATCH 1/2] kbuild: Check version of objdump
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_fix_riscv_obj_reading-v1-1-b75962660a9b@rivosinc.com>
References: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
In-Reply-To: <20241216-perf_fix_riscv_obj_reading-v1-0-b75962660a9b@rivosinc.com>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Nelson Chu <nelson@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev, 
 linux-perf-users@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3835; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=IChtsS2vcC0zzlF9qX93bNksLgkX24amcVZg/Whalhg=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rCFsFFrwPjpm/neppcomk8U6ZceR7/mol1y5/FNwstL
 W2dMm1JRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABO5ycPwv/bu6wu/imrKdDZq
 bjKZHBWWnnRkz7PCvC/pV51nvTyxJ5Hhn+mD3V2n+P5EHHj17tnntVdUz5lVzn/yf6butml/19y
 Lb+cEAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Similar to ld-version, add a way to check the version of objdump. This
should most of the time end up being the binutils version or the llvm
version.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 init/Kconfig               | 10 +++++++
 scripts/Kconfig.include    |  6 ++++
 scripts/objdump-version.sh | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index a20e6efd3f0fbdd7f0df2448854cc30734a0ee4f..0b5d36f939e1de89c12ebdd61e4815015314d4f1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -60,6 +60,16 @@ config LLD_VERSION
 	default $(ld-version) if LD_IS_LLD
 	default 0
 
+config OBJDUMP_IS_GNU
+	def_bool $(success,test "$(objdump-name)" = objdump)
+
+config OBJDUMP_IS_LLVM
+	def_bool $(success,test "$(objdump-name)" = llvm-objdump)
+
+config OBJDUMP_VERSION
+	int
+	default $(objdump-version)
+
 config RUSTC_VERSION
 	int
 	default $(rustc-version)
diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 33193ca6e8030e659d6b321acaea1acd42c387a4..cb3e2d2564fea8cce780adb3be672c9596b7ccf2 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -58,6 +58,12 @@ $(error-if,$(success,test -z "$(ld-info)"),Sorry$(comma) this linker is not supp
 ld-name := $(shell,set -- $(ld-info) && echo $1)
 ld-version := $(shell,set -- $(ld-info) && echo $2)
 
+# Get the objdump name, version, and error out if it is not supported.
+objdump-info := $(shell,$(srctree)/scripts/objdump-version.sh $(OBJDUMP))
+$(error-if,$(success,test -z "$(objdump-info)"),Sorry$(comma) this objdump is not supported.)
+objdump-name := $(shell,set -- $(objdump-info) && echo $1)
+objdump-version := $(shell,set -- $(objdump-info) && echo $2)
+
 # machine bit flags
 #  $(m32-flag): -m32 if the compiler supports it, or an empty string otherwise.
 #  $(m64-flag): -m64 if the compiler supports it, or an empty string otherwise.
diff --git a/scripts/objdump-version.sh b/scripts/objdump-version.sh
new file mode 100755
index 0000000000000000000000000000000000000000..fa24f8dc2d3c42fd1195fceb3c96b27f7127db25
--- /dev/null
+++ b/scripts/objdump-version.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Print the objdump name and its version in a 5 or 6-digit form.
+# Also, perform the minimum version check.
+
+set -e
+
+# Convert the version string x.y.z to a canonical 5 or 6-digit form.
+get_canonical_version()
+{
+	IFS=.
+	set -- $1
+
+	# If the 2nd or 3rd field is missing, fill it with a zero.
+	#
+	# The 4th field, if present, is ignored.
+	# This occurs in development snapshots as in 2.35.1.20201116
+	echo $((10000 * $1 + 100 * ${2:-0} + ${3:-0}))
+}
+
+orig_args="$@"
+
+# Get the first line of the --version output.
+IFS='
+'
+set -- $(LC_ALL=C "$@" --version)
+
+# Split the line on spaces.
+IFS=' '
+set -- $1
+
+min_tool_version=$(dirname $0)/min-tool-version.sh
+
+if [ "$1" = GNU -a "$2" = objdump ]; then
+	shift $(($# - 1))
+	version=$1
+	min_version=$($min_tool_version binutils)
+	disp_name="GNU objdump"
+else
+	while [ $# -gt 1 -a "$1" != "LLVM" ]; do
+		shift
+	done
+
+	if [ "$1" = LLVM ]; then
+		version=$3
+		min_version=$($min_tool_version llvm)
+		disp_name="llvm-objdump"
+	else
+		echo "$orig_args: unknown objdump" >&2
+		exit 1
+	fi
+fi
+
+version=${version%%[!0-9.]*}
+
+cversion=$(get_canonical_version $version)
+min_cversion=$(get_canonical_version $min_version)
+
+if [ "$cversion" -lt "$min_cversion" ]; then
+	echo >&2 "***"
+	echo >&2 "*** objdump is too old."
+	echo >&2 "***   Your $disp_name version:    $version"
+	echo >&2 "***   Minimum $disp_name version: $min_version"
+	echo >&2 "***"
+	exit 1
+fi
+
+echo objdump $cversion

-- 
2.34.1


