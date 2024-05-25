Return-Path: <linux-kernel+bounces-189338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF958CEE95
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A915F1F21599
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D553A3BBEF;
	Sat, 25 May 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vngge9AZ"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB93A1C4
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716634092; cv=none; b=OHDlIWD4/FbxQLhNC5IWyJixv44MA2Q8+dlFI1JM9ESQTjjv8/X2iaJ8Qg1Fa546F/c8NpKXKx4V7/lVDYEkRGDnChdsDW1HPjo516OhAqCEdFhEjO+Al099tEHIoECAXQwvrtjnmebH2PJ1UjSzulIg5Wh2GnhVOdVnGqiHJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716634092; c=relaxed/simple;
	bh=2lqPOceltLwRczEmThPV0eUtcRU8lZHDrOgk/+NdHEA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MGHD406Qwc8pkaTEnABEpci/NmoFWVjdFhEPzPm0RDikm7JPG0kjHbxc3sLU24cTumNO3zWyhWTTVze4ekien7jOrk0JK90JzjSquC1H0W4yXcHzLaeaKA76CF0Ol+YUBEEd6Qsg9GyFk7cp5HQCFP3xzzJHtPRM4VCG+gG3mOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vngge9AZ; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2e95abbcfe4so13757631fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716634088; x=1717238888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=Vngge9AZKQmQnjLG5WUU459h6cwkTPxN4rt+W4JWJRb4y0qoCVx2/K3Fs8Ozw0yrdU
         Ecgy3XFhDS7nKs29pATcoYrT6fE1fahIVMpNPO1QoAWYx09Vh2DUxTRKPocHp1vEe3QZ
         u2Hl0/zThA7C2dzTkDlj+ybwqHGp6aylLWCtVn/9bRvrHJixc7V+4vg7qnM0LZFSWRqF
         D3CHHYmX7kISjM0jEIAL4rjiE5yLNchfXZmcVWinzCYncgjq5gsIPfnGXKbmiBUHKa5D
         3GOtfg1+ssdvblpqNOkkQ3vOPOs18q+oOA80YBecJ0e64BMUADO35hhpXGAGRg9zdEJb
         Buhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716634088; x=1717238888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x33LW9A7dVK5EVTAPgwg05LtwyjW2o2CH4TqOgwA89I=;
        b=N8IDUnBxyO/f8rOUHz3i3SN4UsOAjk3N35Im1GgUJQmPoMh4c4QneI2ApBy8u1c6mq
         jVe98R71/7HMh+LKz4Y6f34hPMw1H6CNDeUHAjzR+b7wZ0hUwM40GFo3NJ8XWen2Vzmn
         z1SDlSMWI50gKZdX1fbjYL0mTc4/fdMgGGP7QDkGxV94rgDvbzhGLQ9bg5xSCm7DJcB4
         hzyONjy/otrA0uALwoApqjEOn3PsK3kv13PVog3Fbe8X8TbztihRmNBKliI/6vCjJXpO
         J/+D9WKFnZ6ikAz5BgRQQQsau5Hp2X1EToCJY0tjdJTXaZIHDUntPFyNk9YL0VMPlYNs
         QCKg==
X-Forwarded-Encrypted: i=1; AJvYcCUzwaZ6z3lmn7Btv8jkAYwAdIxZALiQH/y+yZIkuac1rlO5myT8T09IjVnPZ3iiskLtkh0oFKNiGQdSFAfd7A6jv3l6k1Edf7PwxiHK
X-Gm-Message-State: AOJu0Yw5i3tEBl+mxS1Xr8PYy3TLk1LzBt+BHTjN9VlNWS1pSMp2srYX
	UomkKuRgnQGHA4u4Okr1OXCj1gube6SBKu98likf9Pufjlbr4x11qwFVbXqWqJhQiMQbv4uRpw=
	=
X-Google-Smtp-Source: AGHT+IGN6xVdZAkSrm56Sh9UHyxZz/GpA8d9fzFyHMmnzeWi8Ie7DGT0rYA4SiFems0Hx2Nk/ziYNi4Fkw==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:8cba:1aee:d3cd:626f])
 (user=sesse job=sendgmr) by 2002:a05:651c:10b1:b0:2e9:570e:1d5 with SMTP id
 38308e7fff4ca-2e95b273f56mr41271fa.5.1716634088029; Sat, 25 May 2024 03:48:08
 -0700 (PDT)
Date: Sat, 25 May 2024 12:47:54 +0200
In-Reply-To: <20240525104755.324014-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240525104755.324014-1-sesse@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240525104755.324014-2-sesse@google.com>
Subject: [PATCH v6 2/3] perf annotate: split out read_symbol()
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


