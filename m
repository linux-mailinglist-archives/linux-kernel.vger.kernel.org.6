Return-Path: <linux-kernel+bounces-273534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA510946A55
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B2A1C20A6C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF501552E3;
	Sat,  3 Aug 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKT83GIq"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6381547FB
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722698422; cv=none; b=OAAZ5SxIxzaMmdy3v5QG+DfpdsQk0cBoDswaXJOY5dwiB3OXuafzrTJziAvUvqHUoKVzATU5XHcBkqtWJlnEVQo0sg9h+FLkVXRynQ04kzAUThrUK55K3G2sq4ZMEqJTnh3GMhvsNO8INV4xlvq5zHg6enDrxglpfXPPJePJ9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722698422; c=relaxed/simple;
	bh=atFFZ6Z5FIzQtKPTP23gsn+DvSJjm6Z6g2QIoXa74hg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VyzfEWqyZsCmG7UZd60IfgCkMRQzl28sHX5zVuJAYAgjQfbD73kDjQCIetdBUPpKFVMvounuKUuli2fKAeMC01Cr+SXDhd/d166l+PS3Kyq0LufXsdCocHItcF9pgDtog25V7diaUoZYwLIDHDzSrKLHm+Q/eYILbxDO8tHt85M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKT83GIq; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2ef2e57fb7cso86433411fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 08:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722698419; x=1723303219; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsomUCzSWsrZbNlMTeafSAnwYZDCwSdK4Xg/dZo2iE=;
        b=iKT83GIqKulpzwi+1eVS4kP9hx5BuBH0YFTYdkApswZQw72K2KyDb8kNJjeqsY+NMc
         0oTgEN0sUwRBoNLdkDPcuvr/GMycCAPoZoJ9Yg86ugjhPFjATZn4WNFji50KyilJGoBt
         dA+1F4aI2jXaSOcWH/9cqmkG2mOxbTl6Uk9w+9svZwiymjTnDHt+XngZSSk8JZAnULgS
         k52gH3JtwHYs6uKkXbjuVkXtG8G/6I+bgW/0gCN8ULBE9NSXdjxREkgMIyWWjUWEQlyB
         ruuZtSLfviXZEB8x4q3s6/IwhpH0kKQiZ7TFlzOlJmxO2LUnNfiWgEk8rwSRwqzjqFb5
         upLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722698419; x=1723303219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aYsomUCzSWsrZbNlMTeafSAnwYZDCwSdK4Xg/dZo2iE=;
        b=JTzjLWHnjYx1r6ERnpp0eVQPj5Ounue8LBi1XJXQKAx6R00He34z0B8dBh7z0l/eCJ
         6c8z4AElZPp98eNcI0I/5N2PbRsfx3Y/CBk3e8QO3t3cy/286NG6voctSQ5n73SDfyT4
         EbG0pUWV+xL151kyo5AQmR9teYbil8oS5sHbBJw2Dtcf2xNXwiVxsOIVOP/h/q5mhwZK
         03IQrjJkxOTV/w95ev448mYlGPVxgBGnAtMW8SCZFTR/8VRI7n2N6WM5d+nWNAmMY96H
         6Lo9zFAMF04ZIm2WVsSSsyhH99gBTeZaAm1T3XTottLIj5LHtR+x1/5B0rqFz5cg/duX
         027Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/YNICdH2jiSivV+v5S1bew5oiOpzNpNRmYm7+ATHydB92yJUcwLaAnSShivsCjugnDgM5Z+vxvSrgOFUtTjtt2RtLW7JkEm1DkguQ
X-Gm-Message-State: AOJu0YyHRmCbj2vnhZCQ0/mKtDz6wxruvEdbSm1a4WZL+L4ziCmhUyoc
	Zwpp/RKNlBk/iGVIBpCg8cRnedsrT5/zwmMd7dlnaxu9ptNwxP2YTAoYTSlOyPMPFzb3dm2orQ=
	=
X-Google-Smtp-Source: AGHT+IHOn+BG3PWGTFXEpj1Qsf2sSgK/+OyzWNVcKwaEPBrTntBrC944xIuu9xgMGxcfSEb8Ryk3v9Mvkg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:521e:7b8e:2bc4:adde])
 (user=sesse job=sendgmr) by 2002:a2e:9892:0:b0:2ef:23af:f1f4 with SMTP id
 38308e7fff4ca-2f15a9fd3afmr79251fa.0.1722698418787; Sat, 03 Aug 2024 08:20:18
 -0700 (PDT)
Date: Sat,  3 Aug 2024 17:20:07 +0200
In-Reply-To: <20240803152008.2818485-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240803152008.2818485-1-sesse@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240803152008.2818485-2-sesse@google.com>
Subject: [PATCH v10 2/3] perf annotate: split out read_symbol()
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
index 85fb0cfedf94..1022b09c7258 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -1372,6 +1372,53 @@ static int find_file_offset(u64 start, u64 len, u64 pgoff, void *arg)
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
@@ -1572,19 +1619,13 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
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
@@ -1593,31 +1634,9 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
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
@@ -1635,6 +1654,11 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 
 	annotation_line__add(&dl->al, &notes->src->source);
 
+	if (open_capstone_handle(args, is_64bit, &handle) < 0)
+		goto err;
+
+	needs_cs_close = true;
+
 	count = cs_disasm(handle, buf, len, start, len, &insn);
 	for (i = 0, offset = 0; i < count; i++) {
 		int printed;
@@ -1679,8 +1703,6 @@ static int symbol__disassemble_capstone(char *filename, struct symbol *sym,
 	return count < 0 ? count : 0;
 
 err:
-	if (fd >= 0)
-		close(fd);
 	if (needs_cs_close) {
 		struct disasm_line *tmp;
 
-- 
2.45.2


