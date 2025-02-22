Return-Path: <linux-kernel+bounces-526967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F16A405C4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70D44243CE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E5D200BBC;
	Sat, 22 Feb 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eNAvZlvf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85C1FAC37
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 06:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204629; cv=none; b=o7jh4JI145nOqpuaC1i9q6w4+KylCP3g5cOCumEF1JyIx0rDnjkd4gpsc8pQjnk1s5slZZRbQaoONBbhUw98wh1p/Alrk9Bfbp16e4Econ7T0wnlyoGeU2QmmTjv5kbhYwaTBSthzqPKPUrI87NXzVKSKHquOMIStgPANRwZgsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204629; c=relaxed/simple;
	bh=JlhCie1KVGPxky6hLFrhYmegSBkXKTMJ+o4py22ZdJY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=bZw+jM9adAoverY91+czlhU2F7tYWGGtx+nMnhnJneLSloVUzl+FOalRlKXetdtLJ81deC62JzVWcavy6+I0Oilmlf8Pi0dh0ogNih9QkA4sEEH8wA90n2ps31osXd/9tdCrs1wZQkJZDsViQKRdzoJcDgYh48NmKdRUGvlceGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eNAvZlvf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f79c1cf49dso35427497b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204626; x=1740809426; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=U/7ZX9JhDgLMSQLTzuNEs8rLWBMeKnvwebReBgtVAUg=;
        b=eNAvZlvf97MojJ1yYbhbYlwMf1BPjiW0yy+gi32S/S/X+Pq9JfRZl4hNZHjTi1LTKt
         QkUgHYL7kgI2R+QBZr8vyHhsrkDM+o2qW3VKhWrgXUEKO4fcqfPDenXxWE7r5WmIpC+G
         5zubFSHjWJsvuCA+JYJuckKV2jXea6bY0srKnkWYqWVMEeetvJHQfalP4QVbHfcXUYV9
         tf9xPJaAJvcmUILSDQYEgGYhylyQQ6H8THwS+bM+7uRIAyWxFDSPPeA+v2ggtg0NNMD4
         Wyd6zPOrU2THp+EVAeAnzyBFxcAqhFj0g0YYR7SY8bRvGCxTkihOV+Kdkj5z8IguLalw
         csfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204626; x=1740809426;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/7ZX9JhDgLMSQLTzuNEs8rLWBMeKnvwebReBgtVAUg=;
        b=FdPkSW5iv6R+negkzQnQswOSLcLx8gygfxAOPPiXA+WOyxRdMpGBw1ikvGkXypMqQ3
         kmIo8l/d0cC1HPgftCbFZV7N4i2wgcEs5W8rCLZALZ7HVXm3Ea4uvaKoCTSWXoQK2pdV
         MHydhnNKJdDCMqfFE+ULdIONGo6bwgU6Lwav6faaD0LMXHIf2L6Be2MHuqdpsvJMck0y
         Xrq5eeOxmQ2rz6nPtNl3T8AZRNgxB355xnDZAZgcwTh0T5hXVHjKfksUs4Yl4gNjcjy9
         NUX6zszZ/et1kzlGikwPGiEzS4/ZXjocZQOBVBoYyQAyX5Zs+C2Sh8yDG8JsQ5DD/E0y
         nCPg==
X-Forwarded-Encrypted: i=1; AJvYcCU+eQXkhvDbeO2TD/dDs64u7KpbQWI6tqWCww1CCLb/SpZQN0UjhKcNOS9W5Mallq8hb5SoM38tx+fVeSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/luLqnTliA+jHwQ5iS6iZLZpy20YgFqB3GslHbMrt2tKjXfK
	q9VS9pbLEdEWBNy4CduRYaagsB+M2bTSo/gbzjgcSvMcukAZrr5QyZVheMaJtm2ERxMXQZDcM/7
	TOVJZug==
X-Google-Smtp-Source: AGHT+IEYFAPRiX8fFmj1juQHrQSqiPZVIrB8A6o/q8ZsWipx0bDxLmVyKrA3nYPlyo25uJmD0bFLmIOqFEoH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:83d0:0:b0:e48:2ea1:d9ea with SMTP id
 3f1490d57ef6-e5e8b073be9mr28959276.7.1740204625695; Fri, 21 Feb 2025 22:10:25
 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:06 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 1/8] tools lib api: Add io_dir an allocation free readdir alternative
From: Ian Rogers <irogers@google.com>
To: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sam James <sam@gentoo.org>, Jesper Juhl <jesperjuhl76@gmail.com>, 
	James Clark <james.clark@linaro.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Anne Macedo <retpolanne@posteo.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

glibc's opendir allocates a minimum of 32kb, when called recursively
for a directory tree the memory consumption can add up - nearly 300kb
during perf start-up when processing modules. Add a stack allocated
variant of readdir sized a little more than 1kb.

As getdents64 may be missing from libc, add support using syscall. As
the system call number maybe missing, add #defines for those.

Note, an earlier version of this patch had a feature test for
getdents64 but there were problems on certains distros where
getdents64 would be #define renamed to getdents breaking the code. The
syscall use was made uncondtional to work around this. There is
context in:
https://lore.kernel.org/lkml/20231207050433.1426834-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/Makefile |   2 +-
 tools/lib/api/io_dir.h | 104 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/api/io_dir.h

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 7f6396087b46..8665c799e0fa 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -95,7 +95,7 @@ install_lib: $(LIBFILE)
 		$(call do_install_mkdir,$(libdir_SQ)); \
 		cp -fpR $(LIBFILE) $(DESTDIR)$(libdir_SQ)
 
-HDRS := cpu.h debug.h io.h
+HDRS := cpu.h debug.h io.h io_dir.h
 FD_HDRS := fd/array.h
 FS_HDRS := fs/fs.h fs/tracing_path.h
 INSTALL_HDRS_PFX := $(DESTDIR)$(prefix)/include/api
diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
new file mode 100644
index 000000000000..aab73393d2a2
--- /dev/null
+++ b/tools/lib/api/io_dir.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/*
+ * Lightweight directory reading library.
+ */
+#ifndef __API_IO_DIR__
+#define __API_IO_DIR__
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+
+#if !defined(SYS_getdents64)
+#if defined(__x86_64__) || defined(__arm__)
+  #define SYS_getdents64 217
+#elif defined(__i386__) || defined(__s390x__) || defined(__sh__)
+  #define SYS_getdents64 220
+#elif defined(__alpha__)
+  #define SYS_getdents64 377
+#elif defined(__mips__)
+  #define SYS_getdents64 308
+#elif defined(__powerpc64__) || defined(__powerpc__)
+  #define SYS_getdents64 202
+#elif defined(__sparc64__) || defined(__sparc__)
+  #define SYS_getdents64 154
+#elif defined(__xtensa__)
+  #define SYS_getdents64 60
+#else
+  #define SYS_getdents64 61
+#endif
+#endif /* !defined(SYS_getdents64) */
+
+static inline ssize_t perf_getdents64(int fd, void *dirp, size_t count)
+{
+#ifdef MEMORY_SANITIZER
+	memset(dirp, 0, count);
+#endif
+	return syscall(SYS_getdents64, fd, dirp, count);
+}
+
+struct io_dirent64 {
+	ino64_t        d_ino;    /* 64-bit inode number */
+	off64_t        d_off;    /* 64-bit offset to next structure */
+	unsigned short d_reclen; /* Size of this dirent */
+	unsigned char  d_type;   /* File type */
+	char           d_name[NAME_MAX + 1]; /* Filename (null-terminated) */
+};
+
+struct io_dir {
+	int dirfd;
+	ssize_t available_bytes;
+	struct io_dirent64 *next;
+	struct io_dirent64 buff[4];
+};
+
+static inline void io_dir__init(struct io_dir *iod, int dirfd)
+{
+	iod->dirfd = dirfd;
+	iod->available_bytes = 0;
+}
+
+static inline void io_dir__rewinddir(struct io_dir *iod)
+{
+	lseek(iod->dirfd, 0, SEEK_SET);
+	iod->available_bytes = 0;
+}
+
+static inline struct io_dirent64 *io_dir__readdir(struct io_dir *iod)
+{
+	struct io_dirent64 *entry;
+
+	if (iod->available_bytes <= 0) {
+		ssize_t rc = perf_getdents64(iod->dirfd, iod->buff, sizeof(iod->buff));
+
+		if (rc <= 0)
+			return NULL;
+		iod->available_bytes = rc;
+		iod->next = iod->buff;
+	}
+	entry = iod->next;
+	iod->next = (struct io_dirent64 *)((char *)entry + entry->d_reclen);
+	iod->available_bytes -= entry->d_reclen;
+	return entry;
+}
+
+static inline bool io_dir__is_dir(const struct io_dir *iod, struct io_dirent64 *dent)
+{
+	if (dent->d_type == DT_UNKNOWN) {
+		struct stat st;
+
+		if (fstatat(iod->dirfd, dent->d_name, &st, /*flags=*/0))
+			return false;
+
+		if (S_ISDIR(st.st_mode)) {
+			dent->d_type = DT_DIR;
+			return true;
+		}
+	}
+	return dent->d_type == DT_DIR;
+}
+
+#endif  /* __API_IO_DIR__ */
-- 
2.48.1.658.g4767266eb4-goog


