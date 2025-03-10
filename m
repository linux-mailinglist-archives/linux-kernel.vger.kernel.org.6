Return-Path: <linux-kernel+bounces-555249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4AA5A949
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D107A7E87
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375502222CE;
	Mon, 10 Mar 2025 22:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgelEORX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC422171E;
	Mon, 10 Mar 2025 22:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741646969; cv=none; b=sPlmU2fgMgGpdZf8cqSjghuhDeekuQRDGM7+pvATm55s/v/j48Qv0PIlPYNOYx624SMsxfVCMM50/DUPJ1NdfnrRaTIQVysxsK5YhAfWs/ADEkFGBVWJI/RXp2+g7YfCZYURWRlV8BXI7WnsO36/CpaaQRR8bvqJ6u+p0F+nMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741646969; c=relaxed/simple;
	bh=yC3jyht6Qf2EHmpXnSyTmnCZv5pR8We4zv+2ttrDcVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bK91RjawxDnzzrbGWcnHEMvAHu4bmVhJLin6shDMYHowya5dZA1t1ns2djwTKbObDI/bt1XeYERo0UAN9MCKml2RAewoCdFCWAMRuPecvomExIHxm0Q7MoJVsOkOi3er0eJKTYPDyVRMwMwUtoY7PVBKJpo45sDu8fJK+0xk1q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgelEORX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE498C4AF09;
	Mon, 10 Mar 2025 22:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741646969;
	bh=yC3jyht6Qf2EHmpXnSyTmnCZv5pR8We4zv+2ttrDcVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgelEORXqSg58sokwIt+cRtzDHeY91JYQcxs6+C0+Cm9ok8O2fAJAJbdNi1sHrHJU
	 n9FlESvUxGHgwI9tjlWNm9IciBTLLaP8aI0XBbPNSmPF3TSiXIGEq8ysoxxvvlJwWa
	 3Srb7EkymDxs4MkgjNaUgPYs+mhTz6HLzHb7H9AliU1TR1bbvaGHOyhkOBVJTjygyf
	 f2UI23eyI0epB4YXgVYo9K7HlNORZaoXxbQ13Esjd3cRojAry1ciZK9ZcE+DMte9Dk
	 0Ezr5rqn4PBMaLQSP0e6QmURIVka6GXKNil99z4MUbNBMVOx5PubPDxirt2PGB3XX8
	 WBhmcM+8GZy9w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH v2 5/7] perf annotate: Factor out __hist_entry__get_data_type()
Date: Mon, 10 Mar 2025 15:49:23 -0700
Message-ID: <20250310224925.799005-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250310224925.799005-1-namhyung@kernel.org>
References: <20250310224925.799005-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can only handle a single disasm_linme and hopefully make the
code simpler.  This is also a preparation to be called from different
places later.

The NO_TYPE macro was added to distinguish when it failed or needs retry.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 170 +++++++++++++++++++++----------------
 1 file changed, 95 insertions(+), 75 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 029e47a521caf1af..8a67340a64b94c39 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -87,6 +87,8 @@ struct annotated_data_type canary_type = {
 	},
 };
 
+#define NO_TYPE ((struct annotated_data_type *)-1UL)
+
 /* symbol histogram: key = offset << 16 | evsel->core.idx */
 static size_t sym_hist_hash(long key, void *ctx __maybe_unused)
 {
@@ -2649,6 +2651,92 @@ void debuginfo_cache__delete(void)
 	di_cache.dbg = NULL;
 }
 
+static struct annotated_data_type *
+__hist_entry__get_data_type(struct hist_entry *he, struct arch *arch,
+			    struct debuginfo *dbg, struct disasm_line *dl,
+			    int *type_offset)
+{
+	struct map_symbol *ms = &he->ms;
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *op_loc;
+	struct annotated_data_type *mem_type;
+	struct annotated_item_stat *istat;
+	int i;
+
+	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
+	if (istat == NULL) {
+		ann_data_stat.no_insn++;
+		return NO_TYPE;
+	}
+
+	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
+		ann_data_stat.no_insn_ops++;
+		istat->bad++;
+		return NO_TYPE;
+	}
+
+	if (is_stack_operation(arch, dl)) {
+		istat->good++;
+		*type_offset = 0;
+		return &stackop_type;
+	}
+
+	for_each_insn_op_loc(&loc, i, op_loc) {
+		struct data_loc_info dloc = {
+			.arch = arch,
+			.thread = he->thread,
+			.ms = ms,
+			.ip = ms->sym->start + dl->al.offset,
+			.cpumode = he->cpumode,
+			.op = op_loc,
+			.di = dbg,
+		};
+
+		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
+			continue;
+
+		/* PC-relative addressing */
+		if (op_loc->reg1 == DWARF_REG_PC) {
+			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
+							    op_loc->offset, dl);
+		}
+
+		/* This CPU access in kernel - pretend PC-relative addressing */
+		if (dso__kernel(map__dso(ms->map)) && arch__is(arch, "x86") &&
+		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
+			dloc.var_addr = op_loc->offset;
+			op_loc->reg1 = DWARF_REG_PC;
+		}
+
+		mem_type = find_data_type(&dloc);
+
+		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
+			istat->good++;
+			*type_offset = 0;
+			return &canary_type;
+		}
+
+		if (mem_type)
+			istat->good++;
+		else
+			istat->bad++;
+
+		if (symbol_conf.annotate_data_sample) {
+			struct evsel *evsel = hists_to_evsel(he->hists);
+
+			annotated_data_type__update_samples(mem_type, evsel,
+							    dloc.type_offset,
+							    he->stat.nr_events,
+							    he->stat.period);
+		}
+		*type_offset = dloc.type_offset;
+		return mem_type ?: NO_TYPE;
+	}
+
+	/* retry with a fused instruction */
+	return NULL;
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -2664,12 +2752,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct evsel *evsel = hists_to_evsel(he->hists);
 	struct arch *arch;
 	struct disasm_line *dl;
-	struct annotated_insn_loc loc;
-	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
 	u64 ip = he->ip;
-	int i;
 
 	ann_data_stat.total++;
 
@@ -2721,77 +2806,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 retry:
-	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
-	if (istat == NULL) {
-		ann_data_stat.no_insn++;
-		return NULL;
-	}
-
-	if (annotate_get_insn_location(arch, dl, &loc) < 0) {
-		ann_data_stat.no_insn_ops++;
-		istat->bad++;
-		return NULL;
-	}
-
-	if (is_stack_operation(arch, dl)) {
-		istat->good++;
-		he->mem_type_off = 0;
-		return &stackop_type;
-	}
-
-	for_each_insn_op_loc(&loc, i, op_loc) {
-		struct data_loc_info dloc = {
-			.arch = arch,
-			.thread = he->thread,
-			.ms = ms,
-			/* Recalculate IP for LOCK prefix or insn fusion */
-			.ip = ms->sym->start + dl->al.offset,
-			.cpumode = he->cpumode,
-			.op = op_loc,
-			.di = di_cache.dbg,
-		};
-
-		if (!op_loc->mem_ref && op_loc->segment == INSN_SEG_NONE)
-			continue;
-
-		/* Recalculate IP because of LOCK prefix or insn fusion */
-		ip = ms->sym->start + dl->al.offset;
-
-		/* PC-relative addressing */
-		if (op_loc->reg1 == DWARF_REG_PC) {
-			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
-							    op_loc->offset, dl);
-		}
-
-		/* This CPU access in kernel - pretend PC-relative addressing */
-		if (dso__kernel(map__dso(ms->map)) && arch__is(arch, "x86") &&
-		    op_loc->segment == INSN_SEG_X86_GS && op_loc->imm) {
-			dloc.var_addr = op_loc->offset;
-			op_loc->reg1 = DWARF_REG_PC;
-		}
-
-		mem_type = find_data_type(&dloc);
-
-		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
-			istat->good++;
-			he->mem_type_off = 0;
-			return &canary_type;
-		}
-
-		if (mem_type)
-			istat->good++;
-		else
-			istat->bad++;
-
-		if (symbol_conf.annotate_data_sample) {
-			annotated_data_type__update_samples(mem_type, evsel,
-							    dloc.type_offset,
-							    he->stat.nr_events,
-							    he->stat.period);
-		}
-		he->mem_type_off = dloc.type_offset;
-		return mem_type;
-	}
+	mem_type = __hist_entry__get_data_type(he, arch, di_cache.dbg, dl,
+					       &he->mem_type_off);
+	if (mem_type)
+		return mem_type == NO_TYPE ? NULL : mem_type;
 
 	/*
 	 * Some instructions can be fused and the actual memory access came
@@ -2811,7 +2829,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	ann_data_stat.no_mem_ops++;
-	istat->bad++;
+	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
+	if (istat)
+		istat->bad++;
 	return NULL;
 }
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


