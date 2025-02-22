Return-Path: <linux-kernel+bounces-526974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF26A405CC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9C219E017D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B0E204C3E;
	Sat, 22 Feb 2025 06:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="It2lLtrs"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E6C204F77
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740204646; cv=none; b=LNIw/0gHBCFGSilf90lu9vSxmW3w9qoRJ74bRhG7SPV3MwuCJ+R8nmPjIoKoI6u/Vo1x6RPWYC8K47HPcZp+QQUigLz7CmN51PcjxdRhszEvTlgxHmIZna71AxdyllSI4A3VwhOaPiVyKkn2JkM3JNW9KPrJKuemYb95kce8JzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740204646; c=relaxed/simple;
	bh=0rGe2Tx7vGTWJQZpyarukIB5VD5h2OOWpGiW/oGj8Co=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=XGrFR6KHzkV/f3XZnWNk7VQ7WVmtPFvUKeX4eTpr/ez8uUBRH9WcXdA+W6MODyQ4yE4jx7lssTY5i8cAuXUqiju9VmREw5+D4o2CdoJo3uGQCNetgX9I/vqq+jLIS7WozbYJk8zxWLizPGGemD5auefpIq9f6v6LRppdfnKa8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=It2lLtrs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e5de0ad7db6so4938719276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740204641; x=1740809441; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLpMV9YZOp3kQVJ6OIZMf/6FQONJ7O+cIn3Mp/VbejI=;
        b=It2lLtrsvQX8hGMGF0G3/hDBLRVFkJQ1jiLR+fQXgtEYirjxkyPf2mRKVHeVxUo1bs
         iivYJpMMXCs1AHxr9fZsz9DbFwIdL5w1tUA7qAvJ2w6kicuoFWTSPHAWR08V1Yq/tQDj
         RegsWV8a7SSmscoIFe5/uJQz0HhUF2ChV+gscLwpyaIU2lOPFU/acENmoPdXUig+v4cZ
         pt5k0515j/lUweA8ljquJAbPmwi9CDfYTj8stbHgLkHyfe3BJ0ySQ9xvv3st5cZ/6VVq
         4YgcUQelhSptJiK9uhOjX8qTVXIYexkfyD3n7sxwS8MqADDeIDfIalc14cR/k1aIqBJH
         P4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740204641; x=1740809441;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GLpMV9YZOp3kQVJ6OIZMf/6FQONJ7O+cIn3Mp/VbejI=;
        b=ljv3o8jxQnq0u89i33XkxrmE68sfHfmP3YQ8I3NCuUItDIw0qzt1xczLgeRG4IWwim
         xWJPrLJmi8DsUsMvbzmT0ZrLsh5BxBKsXGWw4xAiSAV+DD4xWC0dtSJxmFhuLtANp+p3
         O+j2hukYQ8/8Inqv6BeC2In0zOyHvp7csd40sz0OMVpxaO7aYhklaaygr5hcPKDnoriR
         MjhINgAuXhu7tr+wxVi2S3ZA55AusC56J9LKrOfrxurusfmgEK30AfQOCTNHKYsVryEm
         3HgKBUcHWHkZsaiCTdviTF5p/AKbZVhxsddv1pM7P6xNgfXEl8A3Eu7wmwY38FltcWFG
         DSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgwHwZVjzv5kEaSiNNxTC8f1w+k7QSDBArp7hVabZ7WiZyXnR4C4qYQwQ/FQKMWkOTFDI8r15iR4wuzns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyiCqoo6VVzNGqzulHWFSLk5gUomGEEGR3AFrAfx7NR7aMrCC
	3nBdAYQVBKXva57/9W9ZL9sdeTT+WiHUTEg95kDQoMtaTkmZ+7xu6+LYJNly+tr9OkftOLCwUxE
	VvTnRKg==
X-Google-Smtp-Source: AGHT+IGkVRJQVO24ZIN0lXFVx1WEQn5Knpt3I24rS3BLhFGjT3PFDvokyY7XvCUGe/Psu14UYhkCKp9UY5Jr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5003:3a14:d4e7:121])
 (user=irogers job=sendgmr) by 2002:a25:d6d6:0:b0:e57:f46a:98ce with SMTP id
 3f1490d57ef6-e5e19290b77mr848613276.6.1740204641328; Fri, 21 Feb 2025
 22:10:41 -0800 (PST)
Date: Fri, 21 Feb 2025 22:10:13 -0800
In-Reply-To: <20250222061015.303622-1-irogers@google.com>
Message-Id: <20250222061015.303622-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250222061015.303622-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Subject: [PATCH v3 8/8] perf machine: Reuse module path buffer
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

Rather than copying the path and appending the directory entry in a
fresh path buffer, append to the path at the end of where it is for
the recursion level. This saves a PATH_MAX buffer per recursion level
and some unnecessary copying.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e394c630e3a2..3f1faf94198d 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1338,22 +1338,23 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
 	return 0;
 }
 
-static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, int depth)
+static int maps__set_modules_path_dir(struct maps *maps, char *path, size_t path_size, int depth)
 {
 	struct io_dirent64 *dent;
 	struct io_dir iod;
+	size_t root_len = strlen(path);
 	int ret = 0;
 
-	io_dir__init(&iod, open(dir_name, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
+	io_dir__init(&iod, open(path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
 	if (iod.dirfd < 0) {
-		pr_debug("%s: cannot open %s dir\n", __func__, dir_name);
+		pr_debug("%s: cannot open %s dir\n", __func__, path);
 		return -1;
 	}
-
+	/* Bounds check, should never happen. */
+	if (root_len >= path_size)
+		return -1;
+	path[root_len++] = '/';
 	while ((dent = io_dir__readdir(&iod)) != NULL) {
-		char path[PATH_MAX];
-
-		path__join(path, sizeof(path), dir_name, dent->d_name);
 		if (io_dir__is_dir(&iod, dent)) {
 			if (!strcmp(dent->d_name, ".") ||
 			    !strcmp(dent->d_name, ".."))
@@ -1366,7 +1367,12 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 					continue;
 			}
 
-			ret = maps__set_modules_path_dir(maps, path, depth + 1);
+			/* Bounds check, should never happen. */
+			if (root_len + strlen(dent->d_name) >= path_size)
+				continue;
+
+			strcpy(path + root_len, dent->d_name);
+			ret = maps__set_modules_path_dir(maps, path, path_size, depth + 1);
 			if (ret < 0)
 				goto out;
 		} else {
@@ -1376,9 +1382,14 @@ static int maps__set_modules_path_dir(struct maps *maps, const char *dir_name, i
 			if (ret)
 				goto out;
 
-			if (m.kmod)
-				ret = maps__set_module_path(maps, path, &m);
+			if (m.kmod) {
+				/* Bounds check, should never happen. */
+				if (root_len + strlen(dent->d_name) < path_size) {
+					strcpy(path + root_len, dent->d_name);
+					ret = maps__set_module_path(maps, path, &m);
 
+				}
+			}
 			zfree(&m.name);
 
 			if (ret)
@@ -1404,7 +1415,8 @@ static int machine__set_modules_path(struct machine *machine)
 		 machine->root_dir, version);
 	free(version);
 
-	return maps__set_modules_path_dir(machine__kernel_maps(machine), modules_path, 0);
+	return maps__set_modules_path_dir(machine__kernel_maps(machine),
+					  modules_path, sizeof(modules_path), 0);
 }
 int __weak arch__fix_module_text_start(u64 *start __maybe_unused,
 				u64 *size __maybe_unused,
-- 
2.48.1.658.g4767266eb4-goog


