Return-Path: <linux-kernel+bounces-446709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A499F283A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B34518817A2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186B185947;
	Mon, 16 Dec 2024 01:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqCXimzf"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057C58289A
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313616; cv=none; b=HCMZxUvMNQW1uc4i6KSnnl8HhDOEGxCQPlvLGEClhu+p/1gEUkMEj+A8+dOL13zTVityXEgMQpxWXbihymdA9q7NtUByqsZZbosOpntATc5CaYjQxq3oSRrb/3gxw4O6ia8TPEKuHyO7c2Cvz7mf2MgkYxMmAcf1nWT1kb9eFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313616; c=relaxed/simple;
	bh=6N1g9uANonuB1X5ujQfQoFLZ8OgRQZPDGmKT28hZDMg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QaaR8AjHsBojFmX6o+r99ZdsfYTjQzCn0FLa+DEjXZ2xq8EILx3yCtbImiqvi7KBQAzrjJvK7EhkeWCV4KZyWNZHWACMiUgMUEWjPCtVCAXap6LDRsqW1tavUB6OvJ6DySk65GvkNUrxSnj9bUgLHST0nFJWAE9zVPNoT2gAV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqCXimzf; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3c61a11a40so5250114276.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 17:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734313614; x=1734918414; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=fqCXimzfZNOpAJwcasNf/cGSulePMvyaVFsQv39RcXGS9L901P/0NdyqMWkmLPFCcJ
         M4ZtoHiPJHLaxu0sj2Q8eZRt6tTJA65WSMOiJA2i1HRL6qFNJKskrEwkCNq4msq8Ye6t
         B6CuDkh0fr6/DHFKxEiOt9cpd3hnFaEZ2a0EbLucoTPnuBGStpIWVRbngSe5rIrbyA5G
         DJ+wOmslVOYeD5jkgoAsR7Jeq7VC4qtA6mxvodX8z38id4ecykoMBhZi+bekt4AAOuxT
         DHJs/g7Wigy0fQ9dVw9RQQdokPKgOsQeVbgPtzXu4jcI66XHswzudMG41LAeBryX0wfM
         RwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734313614; x=1734918414;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=w2L+ZOJXvp16mIE6iITbDhO6nmYEE2MfdacDxWYjQTxloKoCnQMJS7M8Jp+yGKUcXS
         P7FnteHu4avVdCuQKaSX/lK8LcPbGTh8QuWK0YSiVYmQWoIY8l4pIqge4OVs/UQBvMkU
         XkLV2Wu9wacEhYqq+RAoFM90u8oGLYmmi3we3MoY75pNlDhNG1+D6auEGLeeK67wUN7f
         V0J76xonliUY81Q6FqU15Qjw3XbRQHGlmlnQW+e/08Sa3Q2ljLdEFGPiRVZmE6zQdjLu
         2yfVxbCks/ciybm9VHV/HDO4b/KI0ERC4PR94PJhxKo7G8TtoUOJEzB/Hb5R5IKvIad0
         IN/A==
X-Forwarded-Encrypted: i=1; AJvYcCVXcWU/F/bWZGSckRCWiRKW4V4fIr27sHLn4gEThEI0Sc7KUu267LcERaJnBjRBONfmfAN5h7qFt+FdF0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx1fVmrmG7hDSwwWg6fdYM7/HpgkmxH4x5Q8WQjy6UHaR2BSAL
	hmtWPCMaT2dSNk0599WsxTnTwjBFAH9Ukxuvtj5t1BZA2YyMkprhAQ08K7veRh/PI7F/oA3kqar
	nhlO2vA==
X-Google-Smtp-Source: AGHT+IEJI4OnjwPwIbrmZcw/cre+ES3OYknRsW/w05Ns/lgKMyEqnXJlq9KI1hfL6zbr00Cql871xgXmUp+t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:175d:4db2:deb4:d450])
 (user=irogers job=sendgmr) by 2002:a25:adc1:0:b0:e3a:512a:dca7 with SMTP id
 3f1490d57ef6-e4349ba1ccemr5441276.3.1734313614042; Sun, 15 Dec 2024 17:46:54
 -0800 (PST)
Date: Sun, 15 Dec 2024 17:46:36 -0800
In-Reply-To: <20241216014637.304761-1-irogers@google.com>
Message-Id: <20241216014637.304761-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v2 3/4] perf machine: Avoid UB by delaying computing branch entries
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the branch_stack is NULL then perf_sample__branch_entries may
return NULL+1 which triggers ubsan (undefined behavior
sanitizer). Avoid this by making the computation conditional on branch
existing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 84661d950104..7b1e1c254c17 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2670,7 +2670,6 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 					    bool symbols)
 {
 	struct branch_stack *branch = sample->branch_stack;
-	struct branch_entry *entries = perf_sample__branch_entries(sample);
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
@@ -2712,6 +2711,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	 */
 
 	if (branch && callchain_param.branch_callstack) {
+		struct branch_entry *entries = perf_sample__branch_entries(sample);
 		int nr = min(max_stack, (int)branch->nr);
 		struct branch_entry be[nr];
 		struct iterations iter[nr];
-- 
2.47.1.613.gc27f4b7a9f-goog


