Return-Path: <linux-kernel+bounces-518300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADFA38CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36B71723D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C46A23FC49;
	Mon, 17 Feb 2025 19:59:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5F23F295;
	Mon, 17 Feb 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739822389; cv=none; b=CvfiEGKg36yjwoxHE2aZZnHV8vxtIfOkz/bQRf4HvCrAcQ/WXTm80FNUlgNc+6Z6LW92pWE9NTd1vC1LjUvo/zPlrSZ5iw97qJjyBYY5EToGsGoIoGXerlF2ZMJI1msc/JOZUmkL6Cd4KtH0ASnjsR+MrfROxhg8GzhfjEiwYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739822389; c=relaxed/simple;
	bh=UsyBwrJV9wFy95Fj5nIBK4fL8yenb7w/Ki9AmRJ2tsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9O+lOdv5ydpk44HihAxNs9zQ2JEei8IA8qzZ+sgqIvd1K3QJxA9MZmL/ZFSNIx4XNo1JxDgF2oCvT0mStdqucMGkot7ooXphY2AcosKUYprWoYFxUjb2LjO1Jb+xcZU6oDYCBNy5ZFtsKVkyNJUqHev3rhxJilxvtFkVyVO+sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A154D152B;
	Mon, 17 Feb 2025 12:00:06 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28E453F6A8;
	Mon, 17 Feb 2025 11:59:45 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Graham Woodward <graham.woodward@arm.com>,
	Paschalis.Mpeis@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 11/12] perf arm-spe: Add branch stack
Date: Mon, 17 Feb 2025 19:59:07 +0000
Message-Id: <20250217195908.176207-12-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250217195908.176207-1-leo.yan@arm.com>
References: <20250217195908.176207-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Although Arm SPE cannot generate continuous branch records, this commit
creates a branch stack with only one branch entry.  A single branch info
can be used for performance optimization.

A branch stack structure is dynamically allocated in the decode queue.
The branch stack and stack flags are synthesized based on branch types
and associated events.

After:

  # perf script --itrace=bl1 -F flags,addr,brstack

  jcc                   ffffc0fad9c6b214 0xffffc0fad9c6b234/0xffffc0fad9c6b214/P/-/-/7/COND/-
  jcc/miss,not_taken/   ffffc0fadaaebb30 0xffffc0fadaaebb2c/0xffffc0fadaaebb30/MN/-/-/7/COND/-
  jmp                   ffffc0fadaaea358 0xffffc0fadaaea5ec/0xffffc0fadaaea358/P/-/-/5//-
  jcc/not_taken/        ffffc0fadaae6494 0xffffc0fadaae6490/0xffffc0fadaae6494/PN/-/-/11/COND/-
  jcc/not_taken/            ffff7f83ab54 0xffff7f83ab50/0xffff7f83ab54/PN/-/-/13/COND/-
  jcc/not_taken/            ffff7f83ab08 0xffff7f83ab04/0xffff7f83ab08/PN/-/-/8/COND/-
  jcc                       ffff7f83aa80 0xffff7f83aa58/0xffff7f83aa80/P/-/-/10/COND/-
  jcc                       ffff7f9a45d0 0xffff7f9a43f0/0xffff7f9a45d0/P/-/-/29/COND/-
  jcc/not_taken/        ffffc0fad9ba6db4 0xffffc0fad9ba6db0/0xffffc0fad9ba6db4/PN/-/-/44/COND/-
  jcc                   ffffc0fadaac2964 0xffffc0fadaac2970/0xffffc0fadaac2964/P/-/-/6/COND/-
  jcc                   ffffc0fad99ddc10 0xffffc0fad99ddc04/0xffffc0fad99ddc10/P/-/-/72/COND/-
  jcc/not_taken/        ffffc0fad9b3f21c 0xffffc0fad9b3f218/0xffffc0fad9b3f21c/PN/-/-/64/COND/-
  jcc                   ffffc0fad9c3b604 0xffffc0fad9c3b5f8/0xffffc0fad9c3b604/P/-/-/13/COND/-
  jcc                   ffffc0fadaad6048 0xffffc0fadaad5f8c/0xffffc0fadaad6048/P/-/-/5/COND/-
  return/miss/              ffff7f84e614 0xffffc0fad98a2274/0xffff7f84e614/M/-/-/13/RET/-
  jcc/not_taken/        ffffc0fadaac4eb4 0xffffc0fadaac4eb0/0xffffc0fadaac4eb4/PN/-/-/5/COND/-
  jmp                       ffff7f8e3130 0xffff7f87555c/0xffff7f8e3130/P/-/-/5//-
  jcc/not_taken/        ffffc0fad9b3d9b0 0xffffc0fad9b3d9ac/0xffffc0fad9b3d9b0/PN/-/-/14/COND/-
  return                ffffc0fad9b91950 0xffffc0fad98c3e28/0xffffc0fad9b91950/P/-/-/12/RET/-

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/arm-spe.c | 99 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index daecf9e1017a..ed89b7dbc244 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -103,6 +103,7 @@ struct arm_spe_queue {
 	struct thread			*thread;
 	u64				period_instructions;
 	u32				flags;
+	struct branch_stack		*last_branch;
 };
 
 struct data_source_handle {
@@ -233,6 +234,16 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 	params.get_trace = arm_spe_get_trace;
 	params.data = speq;
 
+	if (spe->synth_opts.last_branch) {
+		size_t sz = sizeof(struct branch_stack);
+
+		/* Allocate one entry for TGT */
+		sz += sizeof(struct branch_entry);
+		speq->last_branch = zalloc(sz);
+		if (!speq->last_branch)
+			goto out_free;
+	}
+
 	/* create new decoder */
 	speq->decoder = arm_spe_decoder_new(&params);
 	if (!speq->decoder)
@@ -242,6 +253,7 @@ static struct arm_spe_queue *arm_spe__alloc_queue(struct arm_spe *spe,
 
 out_free:
 	zfree(&speq->event_buf);
+	zfree(&speq->last_branch);
 	free(speq);
 
 	return NULL;
@@ -348,6 +360,73 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	event->sample.header.size = sizeof(struct perf_event_header);
 }
 
+static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
+{
+	struct arm_spe_record *record = &speq->decoder->record;
+	struct branch_stack *bstack = speq->last_branch;
+	struct branch_flags *bs_flags;
+	size_t sz = sizeof(struct branch_stack) +
+		    sizeof(struct branch_entry) /* TGT */;
+
+	/* Clean up branch stack */
+	memset(bstack, 0x0, sz);
+
+	if (!(speq->flags & PERF_IP_FLAG_BRANCH))
+		return;
+
+	bstack->entries[0].from = record->from_ip;
+	bstack->entries[0].to = record->to_ip;
+
+	bs_flags = &bstack->entries[0].flags;
+	bs_flags->value = 0;
+
+	if (record->op & ARM_SPE_OP_BR_CR_BL) {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND_CALL;
+		else
+			bs_flags->type |= PERF_BR_CALL;
+	/*
+	 * Indirect branch instruction without link (e.g. BR),
+	 * take this case as function return.
+	 */
+	} else if (record->op & ARM_SPE_OP_BR_CR_RET ||
+		   record->op & ARM_SPE_OP_BR_INDIRECT) {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND_RET;
+		else
+			bs_flags->type |= PERF_BR_RET;
+	} else if (record->op & ARM_SPE_OP_BR_CR_NON_BL_RET) {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND;
+		else
+			bs_flags->type |= PERF_BR_UNCOND;
+	} else {
+		if (record->op & ARM_SPE_OP_BR_COND)
+			bs_flags->type |= PERF_BR_COND;
+		else
+			bs_flags->type |= PERF_BR_UNKNOWN;
+	}
+
+	if (record->type & ARM_SPE_BRANCH_MISS) {
+		bs_flags->mispred = 1;
+		bs_flags->predicted = 0;
+	} else {
+		bs_flags->mispred = 0;
+		bs_flags->predicted = 1;
+	}
+
+	if (record->type & ARM_SPE_BRANCH_NOT_TAKEN)
+		bs_flags->not_taken = 1;
+
+	if (record->type & ARM_SPE_IN_TXN)
+		bs_flags->in_tx = 1;
+
+	bs_flags->cycles = min(record->latency, 0xFFFFU);
+
+	bstack->nr = 1;
+	bstack->hw_idx = -1ULL;
+}
+
 static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
 {
 	event->header.size = perf_event__sample_event_size(sample, type, 0);
@@ -416,6 +495,7 @@ static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
 	sample.addr = record->to_ip;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
+	sample.branch_stack = speq->last_branch;
 
 	ret = arm_spe_deliver_synth_event(spe, speq, event, &sample);
 	perf_sample__exit(&sample);
@@ -450,6 +530,7 @@ static int arm_spe__synth_instruction_sample(struct arm_spe_queue *speq,
 	sample.period = spe->instructions_sample_period;
 	sample.weight = record->latency;
 	sample.flags = speq->flags;
+	sample.branch_stack = speq->last_branch;
 
 	ret = arm_spe_deliver_synth_event(spe, speq, event, &sample);
 	perf_sample__exit(&sample);
@@ -787,6 +868,10 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 		}
 	}
 
+	if (spe->synth_opts.last_branch &&
+	    (spe->sample_branch || spe->sample_instructions))
+		arm_spe__prep_branch_stack(speq);
+
 	if (spe->sample_branch && (record->op & ARM_SPE_OP_BRANCH_ERET)) {
 		err = arm_spe__synth_branch_sample(speq, spe->branch_id);
 		if (err)
@@ -1278,6 +1363,7 @@ static void arm_spe_free_queue(void *priv)
 	thread__zput(speq->thread);
 	arm_spe_decoder_free(speq->decoder);
 	zfree(&speq->event_buf);
+	zfree(&speq->last_branch);
 	free(speq);
 }
 
@@ -1497,6 +1583,19 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 		id += 1;
 	}
 
+	if (spe->synth_opts.last_branch) {
+		if (spe->synth_opts.last_branch_sz > 1)
+			pr_debug("Arm SPE supports only one bstack entry (TGT).\n");
+
+		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		/*
+		 * We don't use the hardware index, but the sample generation
+		 * code uses the new format branch_stack with this field,
+		 * so the event attributes must indicate that it's present.
+		 */
+		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
+
 	if (spe->synth_opts.branches) {
 		spe->sample_branch = true;
 
-- 
2.34.1


