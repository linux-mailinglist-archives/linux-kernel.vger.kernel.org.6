Return-Path: <linux-kernel+bounces-182915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C777A8C91AA
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 18:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6311F212B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FF82E3FE;
	Sat, 18 May 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XcHrBW4r"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406A45BF0
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 16:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051227; cv=none; b=HrJ1kVdMUtqLj4BI5e9/JkewdnLDGE5JR9BIFc603KPxYRYFFlM/yIkRexsEZVAmI+EViC5piXHvhtuAEvgb3mRKsi7eui9cyibrvUi9u5XOK2QAmel/ejyINDJI4jEuWjvE9VCfHAXbYoWNAqrI5h8kVFesWHmo2W/uwb5fHqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051227; c=relaxed/simple;
	bh=eu6ojl58i6PaNBkZTsBa65l6mv2Xh7vqwl4uDCER8f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=He9UXGZeWtIM0ywE/caZvlcpMqrSPd2XKOQtS21PO9Z1dhGzAAg5anDlHMYwcjaXRwxuXH1hQfz3Q9+ANPsNBivTHXuaWATBwYM2UG/8gu3Dbd+4jPmE1ZxkTaf3r78HVnRucAveua/TB149kfVsFe49Zq5ODchczXFdiSuNZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XcHrBW4r; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so16028295276.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 09:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716051224; x=1716656024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3v7Wla8eK6FwuQ+NrrrAEqVqGJsnfekL6/dutIVE2c=;
        b=XcHrBW4r9fJG5mnWlQpMLwsrM/NAkf8YWOj/41FYgC3mHwCmgwP+d978PDGgyey+Ue
         YFIyfiN9Tk+NGhqNUuKvUarwifMjFTI+55PYWoWZo9ahBjfyE9vAe6D7jZ9UiNb7pnmx
         OZ1gtqYrh5NSQFVUmv8Qa2J8bpoPLMQSY0s9oGyVylXAvHpK9c4TlyTopJUNiDNK0cug
         G8qIc9jCQEolgl8ElaiPw02tB/q0sDyuLqm4lyb89CrTzDo4Zfofhq1dgfksX1TBsdG9
         xM4sBZsphXnobOjHjoAVbofkLcGzlNMOOhlfoXUfWvVHg9sNZhfTX5eR4OJhtcqRNVw0
         0zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716051224; x=1716656024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3v7Wla8eK6FwuQ+NrrrAEqVqGJsnfekL6/dutIVE2c=;
        b=pCxo7ko9cqYRHCSfxxhiODyjPm5+b2ypV2B6+Y5r1POjYlDRLg/abY1noOTTwlkO//
         bU71UtTL9NLI4v4LMU/BOdW3ZbSRdH+J1+QaXXxFCQb7I7GF7uDalA72nQ68IE6d9bVp
         EpFtqzQTIodS4K8bDPyNeirI03D1lzlfmzpQHYgNoPJnTXgWO7YOsytEqnMrW10QQGTj
         sLmKzh/hxtp+xz/YzxyeCivCDc5kiqET7vGKmzMKNACJrKNRmPQuI9ovAqpmBVgzlFoy
         pZ/B9DsRpLiYItdegsTC6DRuS5P33QGHH9aAcVRlu1rslTO2WTeDt163w8Pdt5Cc6fYA
         QRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf3SNOVKuqEin/nUaud7kChQJqwbTH/++7SNySZsAtbj7Xo4X1VJrT/CtTtYdfIkqJnbCSmtVJZ3JsTQeAkPx/AyfyRi6+Aow2nFDs
X-Gm-Message-State: AOJu0YysTiX9DwyXrNob2vKyFB22DyQZsG044COoH+Ai2sY/aUAFDI4+
	Z2piV+lUpPSKw7v6uKi5G4CSpzpvxCrZeR2u0O9UKuloYi8AowedwjNVnCaCzAFnNiJq6Uu8xA=
	=
X-Google-Smtp-Source: AGHT+IEEIPCNIscfY8ZfqwDY04Qp+V/cf3hGM6nbAO2vqNbQ9+4crpfyNW7EO56ldGp7kPx1QkCoa0wpSg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:8b68:8208:4316:d53b])
 (user=sesse job=sendgmr) by 2002:a05:6902:1002:b0:df4:8cef:8c54 with SMTP id
 3f1490d57ef6-df48cef8eb9mr406915276.8.1716051224603; Sat, 18 May 2024
 09:53:44 -0700 (PDT)
Date: Sat, 18 May 2024 18:53:34 +0200
In-Reply-To: <20240518165335.3963530-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240518165335.3963530-1-sesse@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240518165335.3963530-2-sesse@google.com>
Subject: [PATCH v2 2/3] perf annotate: split out read_symbol()
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


