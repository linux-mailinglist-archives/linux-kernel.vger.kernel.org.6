Return-Path: <linux-kernel+bounces-385112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028AF9B328B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72FB4B216B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E4D1DD547;
	Mon, 28 Oct 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AESMA4Qi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DC01D2B1B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124388; cv=none; b=DoaDED6ljVKbPC1sK6UUGCsR24zfro6Xa8728pfv9bk1UA3oaVNufk8RGS6Jhwz/LnYRSlvAggjxpixodbz2QL+cspr0V2XZerZrNfPlhus14mKxa2Ge/YhL9jC/yiqHD4p19dL5PJkZ6qafZ0Ygz3yqxn4dqT4otGt0kNaMkRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124388; c=relaxed/simple;
	bh=ZmXLhFUb7DFAUNDXbc07QZbARoO8b4vxXEdjdRvvSy8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oPQw2flgRkhlW+u4XS643ZV5mz6x50SmX9szlYlEDoJVlww1801sOOgitxPCfz5sBHBpgrJ3mRGfL+EBPmMzfP7VdUzP7QGZFi66Vap9xDLx/UQ37tOs9eEMxnjOgMN9MiA3zjD/N0CM9iQ9QvgSzD+6w1/1+o2/mJ3UWnOj2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AESMA4Qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE09FC4CEC3;
	Mon, 28 Oct 2024 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730124388;
	bh=ZmXLhFUb7DFAUNDXbc07QZbARoO8b4vxXEdjdRvvSy8=;
	h=Date:From:To:Cc:Subject:From;
	b=AESMA4QiKA1yi42JcOuDQidbwJzzTMvmqi0VLs3rCtbr1pz2eymx+Q0m6NsuC85CX
	 t60xwl74SKRvRObf5wznXBNyl9H5o3ZbVzybSdXWtUrSVCucDJbXYovCg4Ns+OM1Dy
	 WbmxP+FphXoqKhjjE2Bb4vGgWCJzaqBWCwe5gqJ1WRhcVDnKVv7Z5X3UtTicd+Oqw6
	 yw3S65rUSOlsqOJa+8lO8LuLZjfPt1ew157Jbd5MF2AI5A6ByrgLca0zNoumhmRgQK
	 2lbuAXGDQ6Nr6J50S94Cu9wFFNEvbbMe+1QvS2yvyNReIYIkxPrjjCEODG0TzGaI0o
	 754HhnIe++UXg==
Date: Mon, 28 Oct 2024 11:01:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/1 fyi] tools headers: Synchronize {uapi/}linux/bits.h with
 the kernel sources
Message-ID: <Zx-ZVH7bHqtFn8Dv@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README

To pick up the changes in this cset:

  947697c6f0f75f98 ("uapi: Define GENMASK_U128")

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/bits.h include/uapi/linux/bits.h
    diff -u tools/include/linux/bits.h include/linux/bits.h

Please see tools/include/uapi/README for further details.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bits.h      | 15 +++++++++++++++
 tools/include/uapi/linux/bits.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 0eb24d21aac2142c..60044b6088172b3f 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -36,4 +36,19 @@
 #define GENMASK_ULL(h, l) \
 	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
+#if !defined(__ASSEMBLY__)
+/*
+ * Missing asm support
+ *
+ * __GENMASK_U128() depends on _BIT128() which would not work
+ * in the asm code, as it shifts an 'unsigned __init128' data
+ * type instead of direct representation of 128 bit constants
+ * such as long and unsigned long. The fundamental problem is
+ * that a 128 bit constant will get silently truncated by the
+ * gcc compiler.
+ */
+#define GENMASK_U128(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_U128(h, l))
+#endif
+
 #endif	/* __LINUX_BITS_H */
diff --git a/tools/include/uapi/linux/bits.h b/tools/include/uapi/linux/bits.h
index 3c2a101986a314f6..5ee30f882736cbd1 100644
--- a/tools/include/uapi/linux/bits.h
+++ b/tools/include/uapi/linux/bits.h
@@ -12,4 +12,7 @@
         (((~_ULL(0)) - (_ULL(1) << (l)) + 1) & \
          (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
 
+#define __GENMASK_U128(h, l) \
+	((_BIT128((h)) << 1) - (_BIT128(l)))
+
 #endif /* _UAPI_LINUX_BITS_H */
-- 
2.47.0


