Return-Path: <linux-kernel+bounces-196832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E18D6254
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DBC1C229F0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969CE158852;
	Fri, 31 May 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="So3CyOX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D5381AD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717160667; cv=none; b=m39ifyWhxDhaOFgn3SCPeisvItnhl7Ameu/jfbHmQhX4OEqhU0/+g8jpbc/OeElZtCRKoq3uu5+Ee6BQ4mmEv367nmYDhfvwDVmeIQ5zSMeLVW30rwE9g1exrCyhwYeZNWKvs4uJgVk2FLUet4Yct240PuNLCkvOnn69xbdEsxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717160667; c=relaxed/simple;
	bh=LNKu49pBwLUdjwHEeEVOwY8XyUhmJM4N5e1r0Vn3N1k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m5Eeoyy2FDb9JoJRRny+aoCcThj2mW5Oo74d6uXKNWPLfne2QuLZg5LIrONBJ7GLw5hTQOIyR07LyUhH6bxKuPC9TmhdZltu6FhyOttf70nAYuUODRHi4N0oNddtnD09L1rBnTsscF6xn/LgM6uyzTEaQjiqvWTzAiMiWXvhzrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=So3CyOX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AECFC116B1;
	Fri, 31 May 2024 13:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717160667;
	bh=LNKu49pBwLUdjwHEeEVOwY8XyUhmJM4N5e1r0Vn3N1k=;
	h=Date:From:To:Cc:Subject:From;
	b=So3CyOX60GOdoCxGf3NvV8/qNtVRcJ7o0EaJfip/xyGgqA+HXyUu7RW2W77Enlw5j
	 Mib1yqQzsIhPfCsUgF7i2Lhu9KOhtSqvnJci9c1iSgI+//BHfcBGQ0T/J2TEGh2k6m
	 6WsjjtrfZ5SSrT9wOn4hSVOnYQmohDf7ANUnD9NljdBMMU9RCX+QaXQZdS0jC9NbLN
	 O4ZZ/0OUd79oNfOGtlfhKcKfml4bLFHDyf5Soc7louLjbbzEhNPJ380SL+WdaCbGv0
	 6TqlhKW6kWa8FmrXioHPcwKfV3dBrGiUoIQwNZuaXtO2pYLR+VXwQbE3LZLNsM8R7M
	 9O4R8QtsSLcmA==
Date: Fri, 31 May 2024 10:04:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers uapi: Sync linux/stat.h with the
 kernel sources to pick STATX_SUBVOL
Message-ID: <ZlnK2Fmx_gahzwZI@x1>
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

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

To pick the changes from:

  2a82bb02941fb53d ("statx: stx_subvol")

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/stat.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 2f2ee82d55175d05..67626d53531664d0 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -126,8 +126,9 @@ struct statx {
 	__u64	stx_mnt_id;
 	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
 	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
+	__u64	stx_subvol;	/* Subvolume identifier */
 	/* 0xa0 */
-	__u64	__spare3[12];	/* Spare space for future expansion */
+	__u64	__spare3[11];	/* Spare space for future expansion */
 	/* 0x100 */
 };
 
@@ -155,6 +156,7 @@ struct statx {
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
 #define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_id */
+#define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
-- 
2.45.1


