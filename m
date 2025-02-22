Return-Path: <linux-kernel+bounces-526968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE24A405C5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE7E189F8F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DF9201256;
	Sat, 22 Feb 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRHIWNqf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1343820011D
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 06:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204630; cv=none; b=mvEu1zpwV0TWu3rJqccnvbTD+TEcxO5H8XSpE3l3d1AfDU0avFIxwaz6Tj0Cw4rkceIaz3+Arkv9hw89EgFR8CnHGyZiEmGJVgqw6MJa4MLWT3aTgRZq7hB9PBj2pJ5xX6tKcRWcMJVoi9fFlSOYfAne3wUYSUbaNtDw7e0WDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204630; c=relaxed/simple;
	bh=uZKZq4ptD24vFXFwJHlzTnn9G+8E1Z8PHZx5KZGUu3M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=M3YE3Qx5sV3iInXmhz7Xwk51lH8Un9EcAn1PQckLMNXgJT8vgMJzHMAoODLEsQmqKbkwZXr462vn1LHNJSSz9fwapUGxYWOg0EJ6TO+3+teRVzZlgbApu5WbNp6HuILJvD4E++qhQWKweAkYhxaA/aT8ckGe5VRlC+qUHaiKIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRHIWNqf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fb91a99b18so40382437b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204628; x=1740809428; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VtHjp1N8qbHeA5gb9C+9YjzRoSPteEkA5kdevNpasM=;
        b=hRHIWNqfTOxWcJRTcNxqKhMJlnXqAfyukKK4U/C1Uuwb2RKbdAkXFv/NpeT6EgnKNL
         RzsKtevk8NEbGNEbmtR4rp4mZYE9GikVE0M7Xq9mL/hb7iiYK43uD1Rd8meWO3XXxlcZ
         0pLBpHw7upg7QlujB4+kOc0frOjoyAklKIz83suUx4ZPbHP/c20TMbNNvWaz6TmgeMp0
         NbDxlyRxaBKy25y0vX3/0zAQFGB0xUAwqT33MbpJ1QEWn0rIb4Ej3l0kAvaimpuMbl01
         9oCCxah38NeQD2CwmwDP918Lgy1nJsQyTdWSUQGfBc6ITjHLAnTvXseJO05YpSn9TIPK
         63eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204628; x=1740809428;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VtHjp1N8qbHeA5gb9C+9YjzRoSPteEkA5kdevNpasM=;
        b=NdmkQaygibQAlLZdw41Hnd14UwB05bye4Mbs744vTN71pl5qZgh7T8+oaYNg7t0hCC
         yb+vS3D1to3HeKd5XwWEKUnhmHC1v85SXX4/ErSRjTOOuR/PiiYMaKXNp6kmVnZRWtcv
         Atq++6ahu15rKbXj85q9q6ZQGqq/d7Z0BgjBW332Tpm77r6iyVDOhGXBqcT1IHwtSr9S
         IP+7OXER8LLoNoeXI3zoiKz4cOezGA2QE7A5olrwOZ3Q+epOSdjVO4Lbo1xakoesTU2Q
         3d2Jtfw53O5RT8pVst81BCAHqHeFEdT0VyO9bIgxgLmMryOT1J65zMig94d7C7CzOYwl
         NGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRNyrLwmAEHnuAgGQ1paM7duUBVbTolz6AkBPc7dfYggrVKV2BG3waNEEJqtddlwg/mBDAZWTU7hWvL6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTxxE+rBpug14ipuVcXmBZKbhPPHeJxArwR1jIWEFH3bqjUGA
	8Luqpmv6txJ8XIwyxaxCCnXRFbCAX9nFLcDKLS7MK8Zr0XCJfAloeCv6hQoEWSvQBzzVKRhnoVu
	y/AngkQ==
X-Google-Smtp-Source: AGHT+IE65L8aluDbSw023cnsnaEhizB//+QYeu9aiZcX9uqw2fvJ5SWSNv1xb4rtN0ccuBBufv/OlbuXxuxn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:694b:0:b0:e58:991a:e855 with SMTP id
 3f1490d57ef6-e5e24502529mr39737276.0.1740204627922; Fri, 21 Feb 2025 22:10:27
 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:07 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 2/8] perf maps: Switch modules tree walk to io_dir__readdir
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

Compared to glibc's opendir/readdir this lowers the max RSS of perf
record by 1.8MB on a Debian machine.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 316f0879e5e0..e394c630e3a2 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -37,6 +37,7 @@
 #include <internal/lib.h> // page_size
 #include "cgroup.h"
 #include "arm64-frame-pointer-unwind-support.h"
+#include <api/io_dir.h>
 
 #include <linux/ctype.h>
 #include <symbol/kallsyms.h>
@@ -1339,31 +1340,21 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 
 static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, int depth)
 {
-	const struct dirent *dent;
-	DIR *dir = opendir(dir_name);
+	struct io_dirent64 *dent;
+	struct io_dir iod;
 	int ret = 0;
 
-	if (!dir) {
+	io_dir__init(&iod, open(dir_name, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	if (iod.dirfd < 0) {
 		pr_debug("%s: cannot open %s dir\n", __func__, dir_name);
 		return -1;
 	}
 
-	while ((dent = readdir(dir)) != NULL) {
+	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		char path[PATH_MAX];
-		unsigned char d_type = dent->d_type;
 
 		path__join(path, sizeof(path), dir_name, dent->d_name);
-
-		if (d_type == DT_UNKNOWN) {
-			struct stat st;
-
-			if (stat(path, &st))
-				continue;
-			if (S_ISDIR(st.st_mode))
-				d_type = DT_DIR;
-		}
-
-		if (d_type == DT_DIR) {
+		if (io_dir__is_dir(&iod, dent)) {
 			if (!strcmp(dent->d_name, ".") ||
 			    !strcmp(dent->d_name, ".."))
 				continue;
@@ -1396,7 +1387,7 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 	}
 
 out:
-	closedir(dir);
+	close(iod.dirfd);
 	return ret;
 }
 
-- 
2.48.1.658.g4767266eb4-goog


