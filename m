Return-Path: <linux-kernel+bounces-189829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF88CF55E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1A61F21293
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 18:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552D312BE9F;
	Sun, 26 May 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zwvn6wiv"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B51DA58
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 18:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716747742; cv=none; b=P3ZSfFyrxOI1evgm4KKEfdHugE24jgLDXHj9CIugI51825VwB6vfM/F3GS6qq5nsXSBWhX83eu05iML6RARImqik1UadEvzUs0Z6X3gbssbosWbFUwOvOhvrQ3/IKb00KPnUHYj7uzgMsXfG9ODik4pVKoQ5e4B7Yka6EBeDhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716747742; c=relaxed/simple;
	bh=2lqPOceltLwRczEmThPV0eUtcRU8lZHDrOgk/+NdHEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CE01hFwpzoseMKwoYC1Sz635hNV9NkOJiW433Wj7XN0ZQMYTuHl9n40ypmp0L6tFm+fTh02invpVLNspvgpr4EE/FVjLu3SzXQZ+t6W2k9ZEmnXfzyjmlSTNFdbMC604h2Gi4MKUcpUsxf2LWNoe0TvrCK3QfJA7bjoJ93AJigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zwvn6wiv; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2e716db6f7bso31131271fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 11:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716747739; x=1717352539; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=Zwvn6wivrBHpQT/kT+2+kmUKQFg9RU/YJrIGZpDUNPXW3U7sKd0CBT37vLuYqIQ7Jy
         ZGEdBV+VsOr1d+TAVBcyK4sy5Zl55e6COJ8xDES0XKOYnB+zESxMfG232p6OfV+/LSYI
         OlUIo2XSGFmzpZyhIPP0ursf5IERTi75q/tOH3TGjgHffP9wgL0HjLphOXSjfonnONMY
         EiV03y+AOkd3wZ6wHv6CoL+Wvm5TReAKcInOieoqjab3LL5bgsQ97YlpB+r3BrgL5Igz
         PFi+I2jdU5gV9UIBX+1o+HRgQJwVU5+jiG6rCJnJSr3n7JnlVPpRkHwJ1Z4DXVMN9U38
         WnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716747739; x=1717352539;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=XpYVyLysWiVmn1l8sVdUDEz16uXRiCmqpXitSee2fFiX4LxjLMGXYzzhkhr+LJ7uSV
         63pxuGq/p8NHMic4A5H1oTM+80BEVZpcvbpS9EI4k6QK/rP5mD074W9T3qE/cmR05K1p
         RJsqljdnwzIKWBuAKMrt9uujlVDpyJ7sSnfsd8tevQn/JTBNDQjFKC2B6n1SG1/w6KzT
         2hy603xJNzHE06oMLFYGOrBmv2hSt1y8+8Xu4lJ0JxE21jnqBMMdWyrjnlxVm6SpXK78
         Kus8oOIywCEILYk320o5UK3D0Lbcs7pSmopTChK++6F7b8QT8XIrS9b5iMVGArgKhrH4
         2y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnbS5aoPgbTOSc8g1nONixe1d8YLNOs7VjEhaR+vPV+w+6fHnZmA5nCE3LnCsB/ck8BBRkL6pW+Lo6fb0lj7nmLuPLHUz+BEFMuZ85
X-Gm-Message-State: AOJu0YzhQ6JlhK0N/M6YhkmJBC0XxOJJazkNBwlbEvfVQ2B6Sgac92sT
	Z3WEOiXUAgP0MoEsq37U62A4OgulUUHIoZFAbTr/Kjg/7D3K8lDAcyJkVbZS8+boxFM8tjgy3Q=
	=
X-Google-Smtp-Source: AGHT+IEHacK0EOoIXQZNWJEJY5PwIeR87a4+xnhGom+1cPjXPpueFfwuuakKWDATbwi2a1lVFOc14j8cvA==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:1a92:9649:8b20:5054])
 (user=sesse job=sendgmr) by 2002:a2e:9396:0:b0:2de:d240:b418 with SMTP id
 38308e7fff4ca-2e95b28757bmr62901fa.9.1716747739076; Sun, 26 May 2024 11:22:19
 -0700 (PDT)
Date: Sun, 26 May 2024 20:22:10 +0200
In-Reply-To: <20240526182212.544525-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240526182212.544525-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240526182212.544525-2-sesse@google.com>
Subject: [PATCH v7 2/4] perf annotate: split out read_symbol()
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"

The Capstone disassembler code has a useful code snippet to read
the bytes for a given code symbol into memory. Split it out into
its own function, so that the LLVM disassembler can use it in
the next patch.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
---
 tools/perf/util/disasm.c | 90 +++++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 72aec8f61b94..c0dbb955e61a 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1396,6 +1396,53 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
 	return 0;
 }
 
+static u8 *
+read_symbol(const char *filename, struct map *map, struct symbol *sym,
+	    u64 *len, bool *is_64bit)
+{
+	struct dso *dso = map__dso(map);
+	struct nscookie nsc;
+	u64 start = map__rip_2objdump(map, sym->start);
+	u64 end = map__rip_2objdump(map, sym->end);
+	int fd, count;
+	u8 *buf = NULL;
+	struct find_file_offset_data data = {
+		.ip = start,
+	};
+
+	*is_64bit = false;
+
+	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
+	fd = open(filename, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
+	if (fd < 0)
+		return NULL;
+
+	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
+			    is_64bit) == 0)
+		goto err;
+
+	*len = end - start;
+	buf = malloc(*len);
+	if (buf == NULL)
+		goto err;
+
+	count = pread(fd, buf, *len, data.offset);
+	close(fd);
+	fd = -1;
+
+	if ((u64)count != *len)
+		goto err;
+
+	return buf;
+
+err:
+	if (fd >= 0)
+		close(fd);
+	free(buf);
+	return NULL;
+}
+
 static void print_capstone_detail(cs_insn *insn, char *buf, size_t len,
 				  struct annotate_args *args, u64 addr)
 {
@@ -1458,19 +1505,13 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 {
 	struct annotation *notes = symbol__annotation(sym);
 	struct map *map = args->ms.map;
-	struct dso *dso = map__dso(map);
-	struct nscookie nsc;
 	u64 start = map__rip_2objdump(map, sym->start);
-	u64 end = map__rip_2objdump(map, sym->end);
-	u64 len = end - start;
+	u64 len;
 	u64 offset;
-	int i, fd, count;
+	int i, count;
 	bool is_64bit = false;
 	bool needs_cs_close = false;
 	u8 *buf = NULL;
-	struct find_file_offset_data data = {
-		.ip = start,
-	};
 	csh handle;
 	cs_insn *insn;
 	char disasm_buf[512];
@@ -1479,31 +1520,9 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	if (args->options->objdump_path)
 		return -1;
 
-	nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
-	fd = open(filename, O_RDONLY);
-	nsinfo__mountns_exit(&nsc);
-	if (fd < 0)
-		return -1;
-
-	if (file__read_maps(fd, /*exe=*/true, find_file_offset, &data,
-			    &is_64bit) == 0)
-		goto err;
-
-	if (open_capstone_handle(args, is_64bit, &handle) < 0)
-		goto err;
-
-	needs_cs_close = true;
-
-	buf = malloc(len);
+	buf = read_symbol(filename, map, sym, &len, &is_64bit);
 	if (buf == NULL)
-		goto err;
-
-	count = pread(fd, buf, len, data.offset);
-	close(fd);
-	fd = -1;
-
-	if ((u64)count != len)
-		goto err;
+		return -1;
 
 	/* add the function address and name */
 	scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
@@ -1521,6 +1540,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
+	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
 	count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
@@ -1565,8 +1589,6 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	return count < 0 ? count : 0;
 
 err:
-	if (fd >= 0)
-		close(fd);
 	if (needs_cs_close) {
 		struct disasm_line *tmp;
 
-- 
2.45.1


