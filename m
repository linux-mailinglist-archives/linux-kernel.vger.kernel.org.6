Return-Path: <linux-kernel+bounces-240117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D76926943
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111941F24CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DF194A43;
	Wed,  3 Jul 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvM0IV9C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7C191F69
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037010; cv=none; b=HFTVHKpVFXNh0I2mE+hlCJpLMYPEZvLudI5G6H18EvYfjnd3W5bnyx4EyxkWAtObOQCSlIKInQNb6JtkHDzCxTcTymVjqWDOtoAAEFVA+qCZUMNn7jkXZ8VKgjRGpHEXtkPcEa4snwcj5ge7HLAQitNrY5N5/3Li2bQXgjfU21U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037010; c=relaxed/simple;
	bh=35d0AnDBxA+mMCwEFzE0w/OcjIGDMUFiqT3maRRcqZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwgigPEKyUo4j+3m+LoqLSM4KJH42LNjGAAu/3NX1R/sKGKkMsolJxpdZymkCSFlfJL2zUtciGTneHZgC3aZuhbTyw4M8EVsFBeA6Z2qBoOhjIXnNcV9hD6fBeDiyC9P+mOtIvRkV88tKrJyr3eb0ltLApFjj53R1+wfQnp7dWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvM0IV9C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720037009; x=1751573009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=35d0AnDBxA+mMCwEFzE0w/OcjIGDMUFiqT3maRRcqZk=;
  b=bvM0IV9Co1/aMPd+SFFdAA9aTE2+N1Zm6q3SqsOM2ive1fT8bB5q4Lr4
   bU78C55LOYvqfW9GoIzZLIbrVouDulRh78EbKtZc3Q0Bcj094yjBSEp3L
   0m/5ve4n5MFjBRJ0hHi7yEAKHNjpazPIc8qT/3nncDMat0IOBo+Q5T0Mt
   VJMN1GD09tB4upLybQaZ/ehjh95goUTiMTZCcXHEEGZZ9JU62oLqkrJdx
   yMjKQPSwC36a9NGYrf2Ke1UC+RQNZdQnCGyDKx4Tv23iOqDNheI4QJMTQ
   qXU1geYRaotXyKKarV1BR8rWreXF+U/QoppNBvYWEolgDE4eYRv232m1X
   w==;
X-CSE-ConnectionGUID: Id8Ng3+kSciawtIMyH3HlA==
X-CSE-MsgGUID: yoPeuB5ISYKdgGsco+FlKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="39807610"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="39807610"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 13:03:28 -0700
X-CSE-ConnectionGUID: 9emNEXXqQs+dnzCNvUwvdQ==
X-CSE-MsgGUID: 37i5iBW5TluqjnQX7/1vpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442599"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 13:03:26 -0700
From: kan.liang@linux.intel.com
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-kernel@vger.kernel.org
Cc: adrian.hunter@intel.com,
	ak@linux.intel.com,
	eranian@google.com,
	Kan Liang <kan.liang@linux.intel.com>,
	Tinghao Zhang <tinghao.zhang@intel.com>
Subject: [PATCH 7/9] perf annotate: Display the branch counter histogram
Date: Wed,  3 Jul 2024 13:03:54 -0700
Message-Id: <20240703200356.852727-8-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240703200356.852727-1-kan.liang@linux.intel.com>
References: <20240703200356.852727-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Display the branch counter histogram in the annotation view.

Press 'B' to display the branch counter's abbreviation list as well.

Samples: 1M of events 'anon group { branch-instructions:ppp, branch-misses }',
4000 Hz, Event count (approx.):
f3  /home/sdp/test/tchain_edit [Percent: local period]
Percent       │ IPC Cycle       Branch Counter (Average IPC: 1.39, IPC Coverage: 29.4%)
              │                                     0000000000401755 <f3>:
  0.00   0.00 │                                       endbr64
              │                                       push    %rbp
              │                                       mov     %rsp,%rbp
              │                                       movl    $0x0,-0x4(%rbp)
  0.00   0.00 │1.33     3          |A   |-   |      ↓ jmp     25
 11.03  11.03 │                                 11:   mov     -0x4(%rbp),%eax
              │                                       and     $0x1,%eax
              │                                       test    %eax,%eax
 17.13  17.13 │2.41     1          |A   |-   |      ↓ je      21
              │                                       addl    $0x1,-0x4(%rbp)
 21.84  21.84 │2.22     2          |AA  |-   |      ↓ jmp     25
 17.13  17.13 │                                 21:   addl    $0x1,-0x4(%rbp)
 21.84  21.84 │                                 25:   cmpl    $0x270f,-0x4(%rbp)
 11.03  11.03 │0.61     3          |A   |-   |      ↑ jle     11
              │                                       nop
              │                                       pop     %rbp
  0.00   0.00 │0.24    20          |AA  |B   |      ← ret

Originally-by: Tinghao Zhang <tinghao.zhang@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/builtin-annotate.c     | 10 +++++---
 tools/perf/ui/browsers/annotate.c | 18 ++++++++++++--
 tools/perf/ui/browsers/hists.c    |  3 ++-
 tools/perf/util/annotate.c        | 40 ++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h        | 11 +++++++++
 tools/perf/util/disasm.c          |  1 +
 6 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 0aa40588425c..57c9c863dce9 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -917,11 +917,15 @@ int cmd_annotate(int argc, const char **argv)
 		sort_order = "dso,symbol";
 
 	/*
-	 * Set SORT_MODE__BRANCH so that annotate display IPC/Cycle
-	 * if branch info is in perf data in TUI mode.
+	 * Set SORT_MODE__BRANCH so that annotate displays IPC/Cycle and
+	 * branch counters, if the corresponding branch info is available
+	 * in the perf data in the TUI mode.
 	 */
-	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack)
+	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
 		sort__mode = SORT_MODE__BRANCH;
+		if (annotate.session->evlist->nr_br_cntr > 0)
+			annotate_opts.show_br_cntr = true;
+	}
 
 	if (setup_sorting(NULL) < 0)
 		usage_with_options(annotate_usage, options);
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ea986430241e..868ea84d766b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -156,6 +156,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	u8 pcnt_width = annotation__pcnt_width(notes);
+	u8 cntr_width = annotation__br_cntr_width();
 	int width;
 	int diff = 0;
 
@@ -205,13 +206,13 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser,
-				 pcnt_width + 2 + notes->src->widths.addr + width,
+				 pcnt_width + 2 + notes->src->widths.addr + width + cntr_width,
 				 from, to);
 
 	diff = is_fused(ab, cursor);
 	if (diff > 0) {
 		ui_browser__mark_fused(browser,
-				       pcnt_width + 3 + notes->src->widths.addr + width,
+				       pcnt_width + 3 + notes->src->widths.addr + width + cntr_width,
 				       from - diff, diff, to > from);
 	}
 }
@@ -714,6 +715,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	struct annotation *notes = symbol__annotation(ms->sym);
 	const char *help = "Press 'h' for help on key bindings";
 	int delay_secs = hbt ? hbt->refresh : 0;
+	char *br_cntr_text = NULL;
 	char title[256];
 	int key;
 
@@ -730,6 +732,8 @@ static int annotate_browser__run(struct annotate_browser *browser,
 
 	nd = browser->curr_hot;
 
+	annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
+
 	while (1) {
 		key = ui_browser__run(&browser->b, delay_secs);
 
@@ -796,6 +800,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		"r             Run available scripts\n"
 		"p             Toggle percent type [local/global]\n"
 		"b             Toggle percent base [period/hits]\n"
+		"B             Branch counter abbr list (Optional)\n"
 		"?             Search string backwards\n"
 		"f             Toggle showing offsets to full address\n");
 			continue;
@@ -904,6 +909,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			hists__scnprintf_title(hists, title, sizeof(title));
 			annotate_browser__show(&browser->b, title, help);
 			continue;
+		case 'B':
+			if (br_cntr_text)
+				ui_browser__help_window(&browser->b, br_cntr_text);
+			else {
+				ui_browser__help_window(&browser->b,
+							"\n The branch counter is not available.\n");
+			}
+			continue;
 		case 'f':
 			annotation__toggle_full_addr(notes, ms);
 			continue;
@@ -923,6 +936,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 	}
 out:
 	ui_browser__hide(&browser->b);
+	free(br_cntr_text);
 	return key;
 }
 
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 73d766eac75b..6dc765e37788 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3705,7 +3705,8 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
 
 	memset(&action, 0, sizeof(action));
 
-	annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false);
+	if (!annotation_br_cntr_abbr_list(&br_cntr_text, evsel, false))
+		annotate_opts.show_br_cntr = true;
 
 	while (1) {
 		key = hist_browser__run(browser, "? - help", true, 0);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f20f9e40ef0d..8a7024534469 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -500,8 +500,10 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 	}
 }
 
-static int annotation__compute_ipc(struct annotation *notes, size_t size)
+static int annotation__compute_ipc(struct annotation *notes, size_t size,
+				   struct evsel *evsel)
 {
+	unsigned int br_cntr_nr = evsel->evlist->nr_br_cntr;
 	int err = 0;
 	s64 offset;
 
@@ -536,6 +538,20 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size)
 				al->cycles->max = ch->cycles_max;
 				al->cycles->min = ch->cycles_min;
 			}
+			if (al && notes->branch->br_cntr) {
+				if (!al->br_cntr) {
+					al->br_cntr = calloc(br_cntr_nr, sizeof(u64));
+					if (!al->br_cntr) {
+						err = ENOMEM;
+						break;
+					}
+				}
+				al->num_aggr = ch->num_aggr;
+				al->br_cntr_nr = br_cntr_nr;
+				al->evsel = evsel;
+				memcpy(al->br_cntr, &notes->branch->br_cntr[offset * br_cntr_nr],
+				       br_cntr_nr * sizeof(u64));
+			}
 		}
 	}
 
@@ -547,8 +563,10 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size)
 				struct annotation_line *al;
 
 				al = annotated_source__get_line(notes->src, offset);
-				if (al)
+				if (al) {
 					zfree(&al->cycles);
+					zfree(&al->br_cntr);
+				}
 			}
 		}
 	}
@@ -1903,6 +1921,22 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 					    "Cycle(min/max)");
 		}
 
+		if (annotate_opts.show_br_cntr) {
+			if (show_title) {
+				obj__printf(obj, "%*s ",
+					    ANNOTATION__BR_CNTR_WIDTH,
+					    "Branch Counter");
+			} else {
+				char *buf;
+
+				if (!annotation_br_cntr_entry(&buf, al->br_cntr_nr, al->br_cntr,
+							      al->num_aggr, al->evsel)) {
+					obj__printf(obj, "%*s ", ANNOTATION__BR_CNTR_WIDTH, buf);
+					free(buf);
+				}
+			}
+		}
+
 		if (show_title && !*al->line) {
 			ipc_coverage_string(bf, sizeof(bf), notes);
 			obj__printf(obj, "%*s", ANNOTATION__AVG_IPC_WIDTH, bf);
@@ -2002,7 +2036,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	annotation__set_index(notes);
 	annotation__mark_jump_targets(notes, sym);
 
-	err = annotation__compute_ipc(notes, size);
+	err = annotation__compute_ipc(notes, size, evsel);
 	if (err)
 		return err;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2ff79a389dc0..5cda399ae52e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -31,6 +31,7 @@ struct annotated_data_type;
 #define ANNOTATION__CYCLES_WIDTH 6
 #define ANNOTATION__MINMAX_CYCLES_WIDTH 19
 #define ANNOTATION__AVG_IPC_WIDTH 36
+#define ANNOTATION__BR_CNTR_WIDTH 30
 #define ANNOTATION_DUMMY_LEN	256
 
 struct annotation_options {
@@ -44,6 +45,7 @@ struct annotation_options {
 	     show_nr_jumps,
 	     show_minmax_cycle,
 	     show_asm_raw,
+	     show_br_cntr,
 	     annotate_src,
 	     full_addr;
 	u8   offset_level;
@@ -104,6 +106,10 @@ struct annotation_line {
 	char			*fileloc;
 	char			*path;
 	struct cycles_info	*cycles;
+	int			 num_aggr;
+	int			 br_cntr_nr;
+	u64			*br_cntr;
+	struct evsel		*evsel;
 	int			 jump_sources;
 	u32			 idx;
 	int			 idx_asm;
@@ -350,6 +356,11 @@ static inline bool annotation_line__filter(struct annotation_line *al)
 	return annotate_opts.hide_src_code && al->offset == -1;
 }
 
+static inline u8 annotation__br_cntr_width(void)
+{
+	return annotate_opts.show_br_cntr ? ANNOTATION__BR_CNTR_WIDTH : 0;
+}
+
 void annotation__update_column_widths(struct annotation *notes);
 void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms);
 
diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 72aec8f61b94..3663938ca234 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -857,6 +857,7 @@ static void annotation_line__exit(struct annotation_line *al)
 	zfree_srcline(&al->path);
 	zfree(&al->line);
 	zfree(&al->cycles);
+	zfree(&al->br_cntr);
 }
 
 static size_t disasm_line_size(int nr)
-- 
2.38.1


