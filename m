Return-Path: <linux-kernel+bounces-252685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 811C49316C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A05F1F22706
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B91922C0;
	Mon, 15 Jul 2024 14:29:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DA1191F6F;
	Mon, 15 Jul 2024 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053789; cv=none; b=M3OmI+x0yi1RIgX1bPy2nBGS6AA4Vv8RmOaaPPoYeZGcb/6uaCIaSF/UoafoeskNtS4Cv6klrMuzRPRVwgL8FxsDTteDHVE/jgA0QiLxrb5BEHoVHIqFV1uRp+XVBzdkZk5lWYavmLobPMdzxZqGEOjlWOfyFvw2wtR1JqregMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053789; c=relaxed/simple;
	bh=THN5rLNVvIjNeAoyxyQQ+pJ8hTn9svBd8fM+nE5JKas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRgzgmfpnDpVI6+wXW+IEHcorgWx6S2hAinnRICUJgwUbKZLXJikHrg4lX2CM8sQlVBqNLnBgQuARqEmY+eXb5cT8WDvB+lMR09KMwPVxC/kSY6U3dbqmzTK+zdzvoTAnFxsOVPum3q2sI8lyIbHMaN/COiEVsqcb32ncfoBd94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D683DA7;
	Mon, 15 Jul 2024 07:30:12 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53E143F766;
	Mon, 15 Jul 2024 07:29:45 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@arm.com>
Subject: [PATCH v4 6/6] perf docs: Document cross compilation
Date: Mon, 15 Jul 2024 15:29:21 +0100
Message-Id: <20240715142921.51881-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715142921.51881-1-leo.yan@arm.com>
References: <20240715142921.51881-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Records the commands for cross compilation with two methods.

The first method relies on Multiarch. The second approach is to explicitly
specify the PKG_CONFIG variables, which is widely used in build system
(like Buildroot, Yocto, etc).

Co-developed-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/Build.txt | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index 3766886c4bca..2237ceee74ba 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -71,3 +71,40 @@ supported by GCC. UBSan detects undefined behaviors of programs at runtime.
   $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
 
 If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
+
+4) Cross compilation
+====================
+The perf tool can be cross compiled in below methods.
+
+As Multiarch is commonly supported in Linux distributions, we can install
+libraries for multiple architectures on the same system and then cross-compile
+Linux perf. For example, Aarch64 libraries and toolchains can be installed on
+an x86_64 machine, allowing us to compile perf for an Aarch64 target.
+
+Below is the command for building perf with dynamic linking:
+As Multiarch is commonly supported in Linux distros, therefore, we can
+install multiple architectures libs in the same system and then cross compile
+the Linux perf. For example, the Aarch64 libraries and toolchain can be
+installed on the x86_64 machine, based on it we can compile the perf for
+Aarch64 target.
+
+Below is the command for building the perf with dynamic linking.
+
+  $ cd /path/to/Linux
+  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
+
+For static linking, the option `LDFLAGS="-static"` is required.
+
+  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
+    LDFLAGS="-static" -C tools/perf
+
+In the embedded system world, a use case is to explicitly specify the package
+configuration paths for cross building:
+
+  $ PKG_CONFIG_SYSROOT_DIR="/path/to/cross/build/sysroot" \
+    PKG_CONFIG_LIBDIR="/usr/lib/:/usr/local/lib" \
+    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
+
+In this case, the variable PKG_CONFIG_SYSROOT_DIR can be used alongside the
+variable PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH to prepend the sysroot path to
+the library paths for cross compilation.
-- 
2.34.1


