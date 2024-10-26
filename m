Return-Path: <linux-kernel+bounces-382938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B849B153A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 07:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4072834AE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 05:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF41632C7;
	Sat, 26 Oct 2024 05:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvoopHvx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19CE33EA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729922095; cv=none; b=Ky1nGT/FWNWoaQry9YjT91gFtzjXGa5dDsvRGv61iqIt/FXLwUAc1MzMHaKigCWAwpGNy4L+hues791iiArZEoLTDsXl/r7yOvuieQa4dCufXqjb6ZUBNvlWYgAaKbJKAH3sA46VJnZ8A3SCXwfXKxKYOIqKvNWOx6mNqZ5SlCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729922095; c=relaxed/simple;
	bh=qhKiOzd4hWkfDT0ixda2Xpgm6/DzGg6Q7le4hCKq89I=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=hMp5CH1sTKA/pJmZce23jTppwMTDiJU5CmfVbq+S3dS9WOJRNljCVihGTN92tOr1d4d7PxBPTI2pUQbj3TnHtFQi+CU9ta30NiK182rYcPohxfLEu+uFd84KFR4MFuWsm26B55xucceJu9KQ3mtTrP4VvL2MACBjfzmS4ApUA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvoopHvx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso5114980276.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729922093; x=1730526893; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQ+JoA3yMgCIChxZeZuJrJ0GmpCnonVaPMsJNW1KHPQ=;
        b=bvoopHvxvp4OUJSNRb03tezzt1wkkSvBwvz5+uPNw2QzC44gtQ/JrPXD0xtT5WRTCo
         Hb9Snz3aOhCcofba0VYWZGosMp+5ivoFvrQ82c8xCalJ8n2V2FuF1lFl7mqceRRKMGzZ
         rlYlz5PVbQSvrR+5UFkpnXq9YI4AIqmmWk38GmPJ+W/6aH5Chx1K5OWB6vcIc5R8rQmO
         WgCtWkz8H5KX5KB/apYy80RJvfYArfAXT/eFy4LhnS25yTXVcod2ezjDc/QhCO8PKoJb
         GSTs3xjYKg9e/W9SleNqrJtazeZPHiNPTxgySpWF6UsP9uCHZtuqoRhzQCGzyTCrKhmJ
         VTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729922093; x=1730526893;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQ+JoA3yMgCIChxZeZuJrJ0GmpCnonVaPMsJNW1KHPQ=;
        b=hI2NAo7brLmSt6YocRIrQyhejeTe1Reujgu93+NsVfpMyWOd1uJo4YshGQC6MFmJQo
         4Sc5ZU1OexJzCqovsr25FBgf9SgoKdr5q3hhztkz7t2sHLiAu1Qux6LxKR/IkLzrOHW5
         nda1r7akRgLssNKG+mstrUwskC4ZQnBV8RhOGTIJGUb/9o0NtRbht+WmBDcbBsvSd89Y
         T5AtP94yz0RLv4NNV424cwApNqSEwmE18XoKkeM2L3owe4uwdMzAe+sbZ1fsqLnXq8k5
         qgv9E/PF6bmOoAFlB5hPnG/Y9tspq6/Xzy+pUZ0Kdc8bPTzBZMHgUOG29EASrlFHPgQK
         pNsg==
X-Forwarded-Encrypted: i=1; AJvYcCXa8J/DCrgIYC8Tal99UbWmm2PB7xIQia+tvzzrqgZNRdM5Wmq6AKq0fgQXLOvY3Oil7D5sHsPVUio9LSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFZKjM2KZhdKHmFkN4qEfzfgQ4Ocyg3aptuXQqb0MTH58FUsFi
	5gSKB1v3S/JzWAASklOUjzJFgTxSqMaff9tTzbN5jwiLwOJxByChnUWr5vTI+j4eeoIVTQr1Rvi
	Ml5++sQ==
X-Google-Smtp-Source: AGHT+IEwpU1onMnTo2a0bqqTaAxZpdCUl7SSf+//vaZrTq34r6usaqFmjLfqXqtavVQ/YGKlGvWMoIEowYWk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:4bc4:f7cc:83b4:dece])
 (user=irogers job=sendgmr) by 2002:a5b:f0f:0:b0:e2e:2cba:ac1f with SMTP id
 3f1490d57ef6-e3087bd5414mr7597276.6.1729922092758; Fri, 25 Oct 2024 22:54:52
 -0700 (PDT)
Date: Fri, 25 Oct 2024 22:54:48 -0700
Message-Id: <20241026055448.312247-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1] perf cap: Add __NR_capget to arch/x86 unistd
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As there are duplicated kernel headers in tools/include libc can pick
up the wrong definitions. This was causing the wrong system call for
capget in perf.

Closes: https://lore.kernel.org/lkml/cc7d6bdf-1aeb-4179-9029-4baf50b59342@intel.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_32.h |  3 +++
 tools/arch/x86/include/uapi/asm/unistd_64.h |  3 +++
 tools/perf/util/cap.c                       | 10 +++-------
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_32.h b/tools/arch/x86/include/uapi/asm/unistd_32.h
index 9de35df1afc3..63182a023e9d 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_32.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_32.h
@@ -11,6 +11,9 @@
 #ifndef __NR_getpgid
 #define __NR_getpgid 132
 #endif
+#ifndef __NR_capget
+#define __NR_capget 184
+#endif
 #ifndef __NR_gettid
 #define __NR_gettid 224
 #endif
diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index d0f2043d7132..77311e8d1b5d 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -11,6 +11,9 @@
 #ifndef __NR_getpgid
 #define __NR_getpgid 121
 #endif
+#ifndef __NR_capget
+#define __NR_capget 125
+#endif
 #ifndef __NR_gettid
 #define __NR_gettid 186
 #endif
diff --git a/tools/perf/util/cap.c b/tools/perf/util/cap.c
index 7574a67651bc..69d9a2bcd40b 100644
--- a/tools/perf/util/cap.c
+++ b/tools/perf/util/cap.c
@@ -7,13 +7,9 @@
 #include "debug.h"
 #include <errno.h>
 #include <string.h>
-#include <unistd.h>
 #include <linux/capability.h>
 #include <sys/syscall.h>
-
-#ifndef SYS_capget
-#define SYS_capget 90
-#endif
+#include <unistd.h>
 
 #define MAX_LINUX_CAPABILITY_U32S _LINUX_CAPABILITY_U32S_3
 
@@ -21,9 +17,9 @@ bool perf_cap__capable(int cap, bool *used_root)
 {
 	struct __user_cap_header_struct header = {
 		.version = _LINUX_CAPABILITY_VERSION_3,
-		.pid = getpid(),
+		.pid = 0,
 	};
-	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S];
+	struct __user_cap_data_struct data[MAX_LINUX_CAPABILITY_U32S] = {};
 	__u32 cap_val;
 
 	*used_root = false;
-- 
2.47.0.163.g1226f6d8fa-goog


