Return-Path: <linux-kernel+bounces-198433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FCB8D7827
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2003C281496
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CF17CF39;
	Sun,  2 Jun 2024 20:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBu4zOK5"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096678283
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360939; cv=none; b=A4uh/0KKgw39SX4Wst+Q1fk7e8C/kCtYqdQgnryrxI0q4uk2b7L1z0gp8C90RFulGngM9O9vJAyWz+FCjnJoAhU3tUSZtiCwbJT7w8cPAsHN7KqL4KvisfS1t+an/PSqKKurI1YwUSLi/o4XRDheTkA1mAHORj3+wDo6Ti1I8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360939; c=relaxed/simple;
	bh=2lqPOceltLwRczEmThPV0eUtcRU8lZHDrOgk/+NdHEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xi4FI6CYyS4jam+AnTffN919hqeC8NmJFhBAtVfxcJY+VrpDWRKecVFkNU/uupKxxCMTwhrUGuphuh0gFTK0TnhFnitLFpMoA+vmLht+vadAAbsuBEI/9HdtXGF/lW1TQuZk3kclY8txcfCwT33ugcN3UErkDhYpOtZrxT2Mj0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBu4zOK5; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2eaafba0579so1061811fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360935; x=1717965735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=eBu4zOK5ebGkwDlQswdsOiQoVJlCPRRSXXksJ0PmN9eOshwpwSDdUk2auEDb5jB9/n
         62f0L0pdCPXZB0RwCtNtEDWjfU6TYDfflTvkGymd4RDlIlbSHusR9wLR/xmOI8pzDT+9
         lsa+qfsUW7RKC11bENWmg6sCNA4xqp5+tqRhS2DqDMVowRtoaUtci/v1EQ5pvI1joYmV
         EWczkbrN3hgiRdhd8GD4oy1l9p26pTUzo3enBgyKKJ7IXutKNq4tU3TTvPYyrx1YO8FP
         KaLHPYDfIqRL7EFqFDE+wUMeSOED4XKyEFbOHCQzBPFtkui5c4kHSmo+EtiD2/8JXYTx
         jsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360935; x=1717965735;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=w9Br9mNoS7TsqK1AwwiJ5uYXSSj5F1UDMMW+fjHmLguhCcAMBJydxfysixs+/ZfGG1
         RokRDU2EpssWs/2zevXADZTcL1R2gmHtnN2K/KzDOagLRG/70xKPrNXCjST8FRGmj91V
         /d9jMLO0FOIpH4DuxLgds5Rv/JPdJ6nT3RnmvGe/CtJkvXbUJ+c/zgepAA1Aj5j9jo8Z
         I95Qhjz+PBGWXiLxICDKcL4JiOM09FGLu9ahsNYWlYxWwFpCy4953x+pJlEOVWq15KmS
         zhoyDngayQca8Jj3Rf7j0iLBUhKOFXZx9oMiKJRDP+aBqmGhFGGLvqf16Ymentjp636a
         B/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZAHuBdYCWurWuIeHE7RZDm0dryMZNgDIWgZWO2PYPrIbe8yAK7gqAw8FahuYYA2sVINI0ervUH9GMIjaWZeK4Wjx9bKr6UxtlUgSc
X-Gm-Message-State: AOJu0Yxr3VNjr9Z3wqyaWPE2UJMjo5dpmjRjBWRYX53KSlhV8j2XI7E+
	k/Foeq0wrPd2aDwz4ThRz6WELVSA2xIntFRKxEdmDcZ/a82+HfVwBg0AQ+gNU7XAjdMpocXV6Q=
	=
X-Google-Smtp-Source: AGHT+IGdyPoPeQMD4GrlnPMGe2Xbk3wMMNeLLud8vfLUFYVfkeJiiNNeyoKXeqzTkSpaDvGL3tLqRHl0qQ==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
 (user=sesse job=sendgmr) by 2002:a2e:be05:0:b0:2ea:aca0:277c with SMTP id
 38308e7fff4ca-2eaaca02afemr15531fa.4.1717360935627; Sun, 02 Jun 2024 13:42:15
 -0700 (PDT)
Date: Sun,  2 Jun 2024 22:42:07 +0200
In-Reply-To: <20240602204208.735793-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240602204208.735793-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240602204208.735793-2-sesse@google.com>
Subject: [PATCH v8 2/3] perf annotate: split out read_symbol()
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


