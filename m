Return-Path: <linux-kernel+bounces-183491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4788C99CA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8213C1C21122
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE41CA9F;
	Mon, 20 May 2024 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cdq2P4lV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81581BC58
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193487; cv=none; b=Ge1gTOWQwXFnQTaz53VEB9I0nvD0Hc0AbeNGdZpX8P3r+4xw11QArJI9hCJzObyewweQ0MUASBIV0m+t5XPcb1iAET7V3YDOEZWbAJBbBwJhe2ygVuTzdw5qtSVQAQiJwkADJ8Ndg1HDS/9IrG2DKI8fxpVP9t7F9jub1+YIFAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193487; c=relaxed/simple;
	bh=eu6ojl58i6PaNBkZTsBa65l6mv2Xh7vqwl4uDCER8f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZY/3vvbNVedgAK0T1Xbx/ymctphP4811TTNYhImguWo4YJajQmcCldyu2fzsf123GAjqgv/7CeG8nbKquVKzVYNSDGyMKZ7+OuwTKHkOmCZr7NDvB33X5yn8RvFeVva1eIt+zxWvoA3h8OXOs/0g4mBw2YKW2f4suUcuvKfa3AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cdq2P4lV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59e612376so16476070276.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716193484; x=1716798284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3v7Wla8eK6FwuQ+NrrrAEqVqGJsnfekL6/dutIVE2c=;
        b=Cdq2P4lV3wrjZd3pPhnElVcv5/4XxPbk7KV6McaGNpKP+23HPzya24h/Jq4pnmiome
         pAmnRi+AVC7Bk1qUZo8z46+DwrvU3hR6ZMo20g798K0xRyXap+GAGfduW/ToJ9yKcnY2
         4dvVJh80YLE9hCZQfIeWhZCspIs24CBwTZc1Jf2nBAItUchDWFwQ/ZGX/8DJt4IC2Mdq
         XZtoB+VdYW1Bi55BfmE25RG5XWvMqTqsJoXU0NGpX0/UhP8A+MDC79b0pIaatUant1Zk
         HqEuYewUqCU4BZ07ga1y++ZfOveU5JAbCAu9FxyHqQJBOA0RW6rGTlj+8axnKsAbCX6Z
         20nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193484; x=1716798284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3v7Wla8eK6FwuQ+NrrrAEqVqGJsnfekL6/dutIVE2c=;
        b=SGwT1negZI8QkIUHDAnmTuP1tZhY7JrB8X4wx6+Uj1p54mJijBFgZFF2hWRv6TDht9
         5c+alCUd3CJ541TAwD5GxWrWIACaZMc0bgNoNUT12gFTFmTp1hAvjMK3RXPq8oC7UicT
         NyFBKQ2qAfzYY8kpupbsukBkohOeHgbST6AbjmuYB1FYIyqzm32060Lf5rEyGOM7vUiL
         kFvvW6nidJmjH0AIWNm5xk6KBBT21lN58Af5Nh+SEiAwiU8bBu5s4Z+DIVglSpQLDzzy
         Kf09jJRwcLJPCNS8Bxvt6ECAcVZdSAa6UG27wW7HzvMYagH528gIpyJTilmiRm1HJfWf
         /1ow==
X-Forwarded-Encrypted: i=1; AJvYcCVf0GwhF3+GC91i8izwlfWQjdl6cNc4Wgno62kfMUyRl3DaFE6v4OMc7MWP6FquswEzY/F+uLFk5MUWTcXeU9DBz/oFk0Y/rFmvt3A5
X-Gm-Message-State: AOJu0YzEHhdRG+NHz4rlp8OGBNEVkWHahY04mh2gOTBnF+2x0A63Oqes
	T7gVJuj0e4GzopjdkvcV2+u0jk/wqkjyLwhirekFHwsNqOpjD0xY3demqQrTOfgkAiNcUSMZKQ=
	=
X-Google-Smtp-Source: AGHT+IG8sA3YeAIFxrhEE+nyyOYQWuGUkUZrZ3eRkMpFDbFRqBPU+s9KI5+gvkvtaWsVQO/64uSndvp/Mg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:d897:cddc:22b9:d054])
 (user=sesse job=sendgmr) by 2002:a05:6902:1082:b0:df4:a395:4cf2 with SMTP id
 3f1490d57ef6-df4a395502fmr297617276.0.1716193484680; Mon, 20 May 2024
 01:24:44 -0700 (PDT)
Date: Mon, 20 May 2024 10:24:28 +0200
In-Reply-To: <20240520082429.320107-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520082429.320107-1-sesse@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240520082429.320107-2-sesse@google.com>
Subject: [PATCH v3 2/3] perf annotate: split out read_symbol()
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
2.43.0


