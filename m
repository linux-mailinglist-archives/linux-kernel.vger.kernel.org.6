Return-Path: <linux-kernel+bounces-183496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DDD8C99D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1E0280F19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC281CD39;
	Mon, 20 May 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opiKHQfl"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A51C6B7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193860; cv=none; b=bxKInRZw44uKDoOAnpFzHJB+QpmjI7oYT0/9UOef9Rnz18XtI0b3M6uIoGHg+lvPk9UMD+q8ky7EhnxWOaxXuTRSs9UG/GJwwi81MrscvLvCkmhfTv4TZ/wDRNd1KKvwHoKCESPhXXtKHqgTFPDnv7j1bXPu4ye7Ho7s0OqH/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193860; c=relaxed/simple;
	bh=eu6ojl58i6PaNBkZTsBa65l6mv2Xh7vqwl4uDCER8f0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRSLDHd6TxV9/3WeSbn01kZ4Dr1J/5kkvSnf5++6oJGPRDT3JlldeMsV75gKPZhdYjJptHA0dw3xUDrl5QFrDzM3rIT4aonz2MANO6/8ZYQTjypbFCHS6LHMK9kP5c8+v9AvOAJrF0Mcc6g/HZyobC8RVgbwjqWqrc55QFpmqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opiKHQfl; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-51fb0ba9f6aso7615413e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716193857; x=1716798657; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3v7Wla8eK6FwuQ+NrrrAEqVqGJsnfekL6/dutIVE2c=;
        b=opiKHQfl/WRVM8+Vd2a905tjkX5mcnoLmLn9SthPuu9rFQHO5civ9aSA/SRYF4MT0h
         QCsVohw7WxZpf0qUx2U9amZoNtAwrkBbmBPTOXbr3E7AielnbH5YI8d6afTk0Lvfr9+h
         WRKVtkxHsZhq3asPJ58Ayq1b4cd8dr/ja45kYLlcJPUoKufg21DM7FXl97L8CugAoL7f
         IJMIK0umkwIFEaQxoCSA2eXiKddY/+XXk+qjXy69X+ceFeMvtwgGZ2+wOORCACyU/FRJ
         i1t62W26lmKnfDmsazVOOkl0mT0I1gdNYjbuQC3bRJV9hW93WUo1fbdE1nnCKHZr6HTf
         hgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193857; x=1716798657;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t3v7Wla8eK6FwuQ+NrrrAEqVqGJsnfekL6/dutIVE2c=;
        b=L7j7/CVSWk4mZcoPeRN/oJveefqyI334VAJ6CrSs4Jx4gKkRiFdBscZbyVepoo8oku
         IUASk+ExvK5eGyBn6lNuBw68KZZswqUijGchNnzK0aFUhUXUVZjGV4qKAZQnGcOmjG5j
         8Ji2/VjZTj0BfHpAexzEAdPUidjrHGnvgJzUnG+NpfqIbUogI+KlEPnB0E3nilC8usTP
         cRGwRQBPEHJxhTcM7HvY/SK2eAzXjXUl0mNvMc7oPeTgJ/PehePSrPG4RsUYCOjaJ/vl
         jSa0rLvPnvGORXnhNrZZaYtA/OwZklRFob+AYjuMmOFmsWDiJyzAdSo9uIT4Tpr7WDKE
         SRAw==
X-Forwarded-Encrypted: i=1; AJvYcCVTLSMGoJKnpRQza+fa77CP+pXNdHNRi8gm6x81w6cvDSzz3HO51OPgDme+H0RoCwmMOvy/ct/yWDAI47qtrputyUOYhvOkI+/1Nr5r
X-Gm-Message-State: AOJu0YwUmkthy1HmujDBwJ+K0MIhSvgGBjqqii5MDYrHXw4Am7DTnbI4
	u4lK+xDKponpy7UiA/19AgJm+fedR3ftQeEaPdc6C+yXMEdgVSqlOr8Dg6YuaR8FrI5+jYjcgg=
	=
X-Google-Smtp-Source: AGHT+IGU3P+9McvbQ/F1CKntVZeGiyVuZEE8QZkv5ejUH7dTZ8+AObX8fUW28ywqlSX2CdyUj1u9htW6TQ==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:d897:cddc:22b9:d054])
 (user=sesse job=sendgmr) by 2002:a05:6512:2e2:b0:517:5d67:2e6 with SMTP id
 2adb3069b0e04-52210074a4emr29233e87.6.1716193855803; Mon, 20 May 2024
 01:30:55 -0700 (PDT)
Date: Mon, 20 May 2024 10:30:47 +0200
In-Reply-To: <20240520083048.322863-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520083048.322863-1-sesse@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240520083048.322863-2-sesse@google.com>
Subject: [PATCH v4 2/3] perf annotate: split out read_symbol()
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


