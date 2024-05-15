Return-Path: <linux-kernel+bounces-180321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE48C6CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 21:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A67284130
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839D415B0E5;
	Wed, 15 May 2024 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uTpcroEI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E8E15B13B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715801797; cv=none; b=CsM1PuOev/zuFsN5Aj8OMwyolqDbKEaUpTULbXbAJ1au3Qf7riJUmgdA+W2gWJc8CZTRdwYguzQGIVzkiLs0y0gQ+6tPePLYusAtBfnn3F44MsbjH5Asx3FxbmsV6+Dj0N5lZsBBinUt7Rk33LmXcLk3WSEq6tiYB15y9LuvICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715801797; c=relaxed/simple;
	bh=he0/u3sIGVL/RVwt13BLNfoDrXSI661dD7cIPhfWeMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OT549tqQuXoJWRWrK8l5wrGOWM3zXJYq+2bqK4MUmSFDqMmPu+eIFh+atKjvJWos46rQBtc9tUZsZOH05lwxWr1pgDVUY3STmMLLYyyRksLKCX2BYIWftonHXfnKqrRKXExejF/5Mabv/zyf2P9QKf9pvyyytf/av+BZxYTvEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uTpcroEI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de74a2635e2so11860966276.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715801794; x=1716406594; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOOQJ5w73fGp6GcpDlduyDPXgxiHotLSQ/tbSKNqQEg=;
        b=uTpcroEIiBPYyGyoRuRXv4CbbyMtFk/CWKyic7H8usc4kemD/OPXGxT1o0gcFB36ik
         6Uqzo22OcRKDPrB9DuLrAZBMz27YcDxiNxGpdXCJLmufZA1EhgMZnwwwRm1/p8nDN1w/
         UU7+xvMYGe5QeQC/axsKnSJ2gJ/k5skNJYbMHzK/Qr8iJ1MoZpnHphtqqGr6icZK/i15
         Mboc1Rgf8wTdFHDMiCboZy64VdIpCeEsz0O96mDv4GlLae7V/iqsxmx8JgBN3bzLbgYZ
         yra2WTqmeOUJLuQUaJW/JI8NIrShcVT9cxkDAw0IjARbMBL7w1YbJKGfpLN1wVhkwb/S
         hFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715801794; x=1716406594;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOOQJ5w73fGp6GcpDlduyDPXgxiHotLSQ/tbSKNqQEg=;
        b=qHT5LDoeaqyDAryjnJDnrpG05E55IJ8WMR0RcRJUOWdoRbtfkdiENtyx6YaMqLK8QR
         MzK2uR3jehLWyMwvjC7qH++jadTK2WadzsVEIIpGt6NPBJ2vzmA0mbyL4WT7WqgrPtsJ
         stHNNiMsfINXSN+fkv3HUcIkANti2Zw2A22sOwWGo8hJNTAXWKnaLkbYe8P/6a7z+Yu7
         6PH5E/vejC8ILVm/631+uYT9JByrjTSWlbGx3ebmaXCdnU5h0gPN3fhfEX3KXbGdGToj
         gpfvAYBZWEQ/zC7FVOomW+aq6N2zU+UseODvpUSQtCWapuF1RRw7Q2k1oRyw+R90tz05
         ehXA==
X-Forwarded-Encrypted: i=1; AJvYcCVTcoyliLq0qj4CqGa3nlx7cUqaVKll9Wcc+Jq6jJAtI9eZxSuHnTeRpRgGWxGfxml95Htr+VCCe3ZYP6LMsbmMqPrkHKNyq382nI30
X-Gm-Message-State: AOJu0Yyu0+kv0vEYoSminkTOyD7th5DvJHHv8NcpGyGFYAco793Q1aZz
	x+mHBCII2g6KZB3YpBe6dINlk7iZr1Ks+4vnxKGBOY3hfon6Ytyc/n6UCa5vn7Z5fGSJ7EKvL6h
	+
X-Google-Smtp-Source: AGHT+IF6QmVbhQuJj9RtRACtFUo4iDmGwzViKpWJl+nMgnxXUnqlxhoXTKA1SYrr2yOInQW9GSC3sD6FIl8=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6e4e:954d:1e49:f87c])
 (user=yabinc job=sendgmr) by 2002:a05:6902:1026:b0:dee:6147:7e26 with SMTP id
 3f1490d57ef6-dee6bf164abmr1178181276.11.1715801794050; Wed, 15 May 2024
 12:36:34 -0700 (PDT)
Date: Wed, 15 May 2024 12:36:09 -0700
In-Reply-To: <20240515193610.2350456-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240515193610.2350456-1-yabinc@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240515193610.2350456-4-yabinc@google.com>
Subject: [PATCH v5 3/3] perf/core: Check sample_type in perf_sample_save_brstack
From: Yabin Cui <yabinc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

Check sample_type in perf_sample_save_brstack() to prevent
saving branch stack data when it isn't required.

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Yabin Cui <yabinc@google.com>
---
 arch/x86/events/amd/core.c |  3 +--
 arch/x86/events/core.c     |  3 +--
 arch/x86/events/intel/ds.c |  3 +--
 include/linux/perf_event.h | 15 ++++++++++-----
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 1fc4ce44e743..f71a9ef932c5 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -998,8 +998,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..ff5577315938 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1702,8 +1702,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
-		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c2b5585aa6d1..f25236ffa28f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1754,8 +1754,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	if (x86_pmu.intel_cap.pebs_format >= 3)
 		setup_pebs_time(event, data, pebs->tsc);
 
-	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index bda066c33120..f6637f3cbe84 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1276,6 +1276,11 @@ static inline void perf_sample_save_raw_data(struct perf_sample_data *data,
 	data->sample_flags |= PERF_SAMPLE_RAW;
 }
 
+static inline bool has_branch_stack(struct perf_event *event)
+{
+	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
+}
+
 static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 					    struct perf_event *event,
 					    struct perf_branch_stack *brs,
@@ -1283,6 +1288,11 @@ static inline void perf_sample_save_brstack(struct perf_sample_data *data,
 {
 	int size = sizeof(u64); /* nr */
 
+	if (!has_branch_stack(event))
+		return;
+	if (WARN_ON_ONCE(data->sample_flags & PERF_SAMPLE_BRANCH_STACK))
+		return;
+
 	if (branch_sample_hw_index(event))
 		size += sizeof(u64);
 	size += brs->nr * sizeof(struct perf_branch_entry);
@@ -1658,11 +1668,6 @@ extern void perf_bp_event(struct perf_event *event, void *data);
 # define perf_arch_bpf_user_pt_regs(regs) regs
 #endif
 
-static inline bool has_branch_stack(struct perf_event *event)
-{
-	return event->attr.sample_type & PERF_SAMPLE_BRANCH_STACK;
-}
-
 static inline bool needs_branch_stack(struct perf_event *event)
 {
 	return event->attr.branch_sample_type != 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


