Return-Path: <linux-kernel+bounces-448291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA119F3E37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657D016E146
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD231DDA33;
	Mon, 16 Dec 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ql2yAjwK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7121DD529
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391514; cv=none; b=BAgnMhneXxom7AD0Tjs7ZcHKuRekbnb3BVfKxyKN7yxPBLshJGRTxvFJbZ/UVUx0IfdxtE7xSqM92arY4w5BRv4Xi8v00MTDhcemaVTVBIZ8eK2mZ1yg17K7geHRZCnr/S4q5jZMOsJ9jdXr4iAkfDNmQZALqspeV0+e88cYr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391514; c=relaxed/simple;
	bh=6N1g9uANonuB1X5ujQfQoFLZ8OgRQZPDGmKT28hZDMg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J1bCmzbnzV/g/UwZCL6C5yBqdjsxtcNW5iPJAMdYzuH3qF1vHAcOfpGhtslcI56T3anm233wQasLJnEBwAjhOjLXzwHNiRvQUq4i+3a/7pPrTZeuzR36z8+zF2wJvp6JDynGcjxjkfqzlFDJbawaJvE5bKMidu+btO3ywJ/C/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ql2yAjwK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3886f4cee2so7253973276.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391512; x=1734996312; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=Ql2yAjwKbJFtXxcHsOQYgP8Ar1paSe+Z3C4BvR0Mci8KUNk5rFEc5pY/P9rUD+u9uF
         IwW/72oP/oMhUlYQOaZvPhk7G2UN9w087pkLc7qkR6iZGw24hrPIr9YjTU18vM8FNDBB
         txU18nUwzgVj++xoPocDigy6vS+aGRhhzMcJubmVPNX7yYcTy9YthRrIIwlkovTi0ZQC
         1ziVzpI8r2BfOqCWXwc2hzPK9G+q0o9Lzc2H+wYkw/p/NRdDfM9ONxuUPD67W4WsGUYt
         Tnsd5HjITisD7vltuT8vywfqrA0IGuNVVNY1l7bYLRRGZphxr7FIKToRqW1C8CovKCJT
         z1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391512; x=1734996312;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=WOOlZmPf6dP80xfhPmco4VMSUY3Xw8uEgBEhUg/AQH+W8sqkPFMFLRbVkX9WW6TUNq
         P6yWJqhqNMXakxLZyjqIpOnu8JfAXrBdlE9gsJEtLMu3vM/6JMOmygZBhJXuibHmxBmq
         WZhDx9LKIfWv74fIukMVfrEo5m5QcGx1OiP2cVrQ/nXKIK6Y2ElMuaeL5Trgg1fAOwdT
         F7fHenznqchAxXNk0gDXkPQFaXCxcr1aMzlyehiJpsoi0pffU8HFyD8eSi9c0jNebZCC
         XVUcsnNxfM0B+PoTHTyzVjCC3/pizj2Irs1q2AKVZrL1+IP/MJgxKT2WJsoBNg45ihk4
         83Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUAq2IPsEquTxilTT/98eoQfWm/+YEGwCGCPcYYS7vs1/RUEn7qs0kX+Y8tPQ/LL0/34AcP17EedD3Gfbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfKamnEAgM0GfV6ldKOg9zVD3XhFcbe/rOTyRJ7mQSk+bn771j
	6jl24oHZxQwIj7cxiRwk4tZzXdEI8G6BSVn5izDST9o0iNiMYAdGEz9CRJybBUxUvWdw4CfpzY6
	07u2S5g==
X-Google-Smtp-Source: AGHT+IFPn3zLwGeYM+WqTOT+tiRtVfhiPONKWI9nlzAPsyTkfAgQ2S20PJn+fhfchxBHApz9migyE/zCITXe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:a209:0:b0:e38:cdae:5fba with SMTP id
 3f1490d57ef6-e532ba3c549mr588276.3.1734391512421; Mon, 16 Dec 2024 15:25:12
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:58 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 4/5] perf machine: Avoid UB by delaying computing branch entries
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


