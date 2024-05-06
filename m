Return-Path: <linux-kernel+bounces-170270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADFD8BD44E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0471C21355
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1B41591E9;
	Mon,  6 May 2024 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2aFOfafb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1125158A14
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018521; cv=none; b=a4JYgxHy1SOGlX+bD/oZbsk0CgGMAOVl4p6RF2sHoVMKfEKLNfUvZ4d7gPazYHT5awgLKp8ChrQvxakUlELDjilg8jvlGLGh1EUwrwPXlW9lA/vPpKVNONU+OG075YrCoJJSmdIgbYubrkOP+LwlX4SSojQm/gy+uqqNVbTnMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018521; c=relaxed/simple;
	bh=B5YCrNJTCZryBr4SX9wn6iX9/7NXKsUtgmUQYdaTOqU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dgO2AsEOeZDEoJtN6FjMPccmYDDYVzfLbqHKRyDDtBpAPUzTAKOPAVeqi0gg58qFzDZVo6pBXaXt1faLklOZFpQL0LfKH6NuydCEfH2UvSk2wKZpu5lxnCdLBN46t5Y/6W4XaDeAEzlmdJQFZEepE7Xazoyxy1BqH68aAFON5Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2aFOfafb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de59ff8af0bso3411912276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018519; x=1715623319; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eshutGTjVoHzsDoYZ6X7cLa8J+Y1qLX+rGm1M53txEQ=;
        b=2aFOfafbEFmIv3QfB8bzDCCmfw6iHenS/UTsBq4qDvNWe8alMMpADcjpndmubXiO9d
         pxqzq53tTzWME3yeSq2VSmXzHoWthhnlcL9VtWRPKWStwc/pvoZnuPPJB4H7QNdI93sD
         WTCzdCozdcV90uB/oyDdBHUxRWkRkd/e7cP1hlurypUgC/MYsT1Jikdu6JtNyrU7J3nf
         Fw/CDWgLFR2cSuLsY50W8JnPib9CLT+40QyQLDW3NcBPyzKXnE0DLWegRXa2KnMhp707
         WyFkj8p4XpziP1mIleYvY0D46tYlCCquoJM2nrz6TdiAAjWjqmftrPgdRfOl3WuINBYl
         QH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018519; x=1715623319;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eshutGTjVoHzsDoYZ6X7cLa8J+Y1qLX+rGm1M53txEQ=;
        b=Is6k9O3JwtpD35RdqNpIRueCsVxcS+lC/V92flsVLgNZDGofXPfcPku3Er53SEzvAG
         5XX5nKD9NsPiKOhW01W4er0Tze2KnCqDsDcMxaCNO34f3QRGyExO83FzFUjVdgHxxxIX
         JkLNuMsT6FKGDJ22JFVugXMZ8O0DmWZ9O7oJX3ULrrptRZHrsq8dOSoIU2TvzPrG0VW2
         Pv71g8NqJI/7LkcYgRl4urNAp6eKNn2Y71PBw/e6o2I0cGJPl+VkPo3UWhPypY7VTm8R
         GxiBuRoVgwZwD9TNgDF/W4nNYpx2wnKBQdjb4fmhNJtcT4B7Aa0sCCLoNvPqUK5zOHBI
         TSWw==
X-Forwarded-Encrypted: i=1; AJvYcCW2HXfOQARGadUiWUZzy09KSJwtH9aCylscC/hoT/Lggju4ApPaPRI7Mo32sx9J+ZiI93jD0bVbn/1QzSftiQ/lfePZ4VMhwR99BYRl
X-Gm-Message-State: AOJu0Yz3r7Pe2tu+qhMK7NvK/34p4geeJKLNYPfy9ZLBmOxltzLa8to5
	WETtfDjBKltx5xXrKcIHqUA7u8D2w+dTJLURPlT0kjlt9Oq33VT5mjwnndy4woy4vdhn3kB1YWI
	k7RaJPA==
X-Google-Smtp-Source: AGHT+IFycb80TYJHS38MiZ1ZZKc5F2EMkIKPLrvf5Bh1gwndCYV7HCmlJHYbrUfSp1G78RAFb2VjnjghsBW6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a05:6902:703:b0:dbe:30cd:8fcb with SMTP id
 k3-20020a056902070300b00dbe30cd8fcbmr1331405ybt.0.1715018518877; Mon, 06 May
 2024 11:01:58 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:03 -0700
In-Reply-To: <20240506180104.485674-1-irogers@google.com>
Message-Id: <20240506180104.485674-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240506180104.485674-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 3/4] perf symbol-elf: dso__load_sym_internal reference
 count fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

dso__load_sym_internal passed curr_mapp as an out argument to
dso__process_kernel_symbol. The out argument was never used so remove
it to simplify the reference counting logic.

Simplify reference counting issues with curr_dso by ensuring the value
it points to has a +1 reference count, and then putting as
necessary. This avoids some reference counting games when the dso is
created making the code more obviously correct with some possible
introduced overhead due to the reference counting get/puts. This,
however, silences reference count checking and we can always optimize
from a seemingly correct point.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 51 ++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 3be5e8d1e278..e398abfd13a0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1419,7 +1419,7 @@ void __weak arch__sym_update(struct symbol *s __maybe_unused,
 static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 				      GElf_Sym *sym, GElf_Shdr *shdr,
 				      struct maps *kmaps, struct kmap *kmap,
-				      struct dso **curr_dsop, struct map **curr_mapp,
+				      struct dso **curr_dsop,
 				      const char *section_name,
 				      bool adjust_kernel_syms, bool kmodule, bool *remap_kernel,
 				      u64 max_text_sh_offset)
@@ -1470,8 +1470,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 			map__set_pgoff(map, shdr->sh_offset);
 		}
 
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1484,8 +1484,8 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 	 */
 	if (kmodule && adjust_kernel_syms && is_exe_text(shdr->sh_flags) &&
 	    shdr->sh_offset <= max_text_sh_offset) {
-		*curr_mapp = map;
-		*curr_dsop = dso;
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(dso);
 		return 0;
 	}
 
@@ -1507,10 +1507,10 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_binary_type(curr_dso, dso__binary_type(dso));
 		dso__set_adjust_symbols(curr_dso, dso__adjust_symbols(dso));
 		curr_map = map__new2(start, curr_dso);
-		dso__put(curr_dso);
-		if (curr_map == NULL)
+		if (curr_map == NULL) {
+			dso__put(curr_dso);
 			return -1;
-
+		}
 		if (dso__kernel(curr_dso))
 			map__kmap(curr_map)->kmaps = kmaps;
 
@@ -1524,21 +1524,15 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
 		if (maps__insert(kmaps, curr_map))
 			return -1;
-		/*
-		 * Add it before we drop the reference to curr_map, i.e. while
-		 * we still are sure to have a reference to this DSO via
-		 * *curr_map->dso.
-		 */
 		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
-		/* kmaps already got it */
-		map__put(curr_map);
 		dso__set_loaded(curr_dso);
-		*curr_mapp = curr_map;
+		dso__put(*curr_dsop);
 		*curr_dsop = curr_dso;
 	} else {
-		*curr_dsop = map__dso(curr_map);
-		map__put(curr_map);
+		dso__put(*curr_dsop);
+		*curr_dsop = dso__get(map__dso(curr_map));
 	}
+	map__put(curr_map);
 
 	return 0;
 }
@@ -1549,11 +1543,9 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 {
 	struct kmap *kmap = dso__kernel(dso) ? map__kmap(map) : NULL;
 	struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
-	struct map *curr_map = map;
-	struct dso *curr_dso = dso;
+	struct dso *curr_dso = NULL;
 	Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
 	uint32_t nr_syms;
-	int err = -1;
 	uint32_t idx;
 	GElf_Ehdr ehdr;
 	GElf_Shdr shdr;
@@ -1656,6 +1648,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (kmodule && adjust_kernel_syms)
 		max_text_sh_offset = max_text_section(runtime_ss->elf, &runtime_ss->ehdr);
 
+	curr_dso = dso__get(dso);
 	elf_symtab__for_each_symbol(syms, nr_syms, idx, sym) {
 		struct symbol *f;
 		const char *elf_name = elf_sym__name(&sym, symstrs);
@@ -1744,9 +1737,13 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			--sym.st_value;
 
 		if (dso__kernel(dso)) {
-			if (dso__process_kernel_symbol(dso, map, &sym, &shdr, kmaps, kmap, &curr_dso, &curr_map,
-						       section_name, adjust_kernel_syms, kmodule,
-						       &remap_kernel, max_text_sh_offset))
+			if (dso__process_kernel_symbol(dso, map, &sym, &shdr,
+						       kmaps, kmap, &curr_dso,
+						       section_name,
+						       adjust_kernel_syms,
+						       kmodule,
+						       &remap_kernel,
+						       max_text_sh_offset))
 				goto out_elf_end;
 		} else if ((used_opd && runtime_ss->adjust_symbols) ||
 			   (!used_opd && syms_ss->adjust_symbols)) {
@@ -1795,6 +1792,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		__symbols__insert(dso__symbols(curr_dso), f, dso__kernel(dso));
 		nr++;
 	}
+	dso__put(curr_dso);
 
 	/*
 	 * For misannotated, zeroed, ASM function sizes.
@@ -1810,9 +1808,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 			maps__fixup_end(kmaps);
 		}
 	}
-	err = nr;
+	return nr;
 out_elf_end:
-	return err;
+	dso__put(curr_dso);
+	return -1;
 }
 
 int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


