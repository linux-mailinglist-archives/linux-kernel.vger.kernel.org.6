Return-Path: <linux-kernel+bounces-442724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDE9EE0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF2F167F41
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB01320C009;
	Thu, 12 Dec 2024 08:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUiAebGI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F0165F01
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990738; cv=none; b=VjwgJsBDGYZ7OYFPjXY12u7PU41/LcP4bM6gPDUlHXnIDe22rUcGDhlwPgOaLrCzzOqbtTRz/cJPTtMCedw0GptMscJRIgFzEkM9ia4HzNJYuRuMyBKMOoJTfI/FtmT1Vux45YssJKxNMzCMDnAhpg6RxEeRM0ebUvWOrjxLLbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990738; c=relaxed/simple;
	bh=6N1g9uANonuB1X5ujQfQoFLZ8OgRQZPDGmKT28hZDMg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Jm4F3WjYo7Yv1NvJFlogNyrLF1WNOEt+M34mVPlPebrt2Isj7SBEH8Y8TmYvxCDNYb2PFPHIWNG07U50AzG4s0KDxrPtyw/HX/UtWWCY4eSpu+AlmdnbCpNjwUiay4AIeYrfVlOuLrGF5ysH1bd/O92+it0Sx67l3G6dVklaZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUiAebGI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef18fc27f6so2692467b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733990736; x=1734595536; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=vUiAebGIi6gfUunXmmJPJQZGSyWJW8Meo9ywzgNYvwFHWdbR/XWUvuu6VR1XjywVuZ
         dsbIZ4w05SwK6XbG0qp+3S0ApqHNfpsDPV+W0kidRMTX6gEJCNDwpsTk0oVVIEfFC/Wa
         /ty8OeDqDhZEt9cdUJQrqBfuNOm/gfAycSWC1zlbDx19bdba8fg27t3rJtnBXoOimaD2
         0uwp/VBjUG3O0EbsqrltlTPQ11nfT84nCihZnjBE9XT430X8l5F68iqwO7ioJlnCpykX
         7hixlGoBpnaL5VuA9AHE48E4HOaEcx9eAmS7F0Hd+WQGC/lPLn6cgJTpoFiQk/Dm3qTj
         juAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990736; x=1734595536;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvACGcoM6KJ0hrZi/+tcGlPsYcMWSS3N/4SFXVszCzA=;
        b=E5DCSuFbBzjSyWww8LBUdaTnL0/XMcFys0inn0k3DvgTFaEi5tUU9hP3aZXh15lz2b
         owLsaHcNX7CX4JY/L6eZTMen2bXD4E/mEaafVDtRjvsyIMhf/B//k6j9FEXc6ID12nrw
         t0ti2f/UbVsPbmSbMutYRoJKP66H19nd1Z0gcAw+Kis/c3djv17Mc1pnFVz8SEnZVvS6
         7Z+d+iPv8anxfuIg4CkKbGq3DbVjdomqCYlEm3gR3VYceeAq17rhOKp3dMj+h2Ushs3R
         fH4o6HKD19hvqQt+JxSREY53h4lohFyfN1Ysp9UOTSPvdVBU0CF8tGOLKBbq6DzeU6zK
         e+wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1GYbU9//QyojT5l0OK/Hhhmk6qaI0LGqRliZacBc2B9DK8qGfbJf8ylqUIazxuIlH5VcY9CtQCUYk/b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWtokurh06yBPJPLWnhanCJ85NNoNeasfV4W5o8pPONHrTENTY
	u6A4tsn50hJFKqATRTXueOKPqYeimBlirLbG03o4ipwDCUhsI54Ulsz+uZCQW33UVsSbo4h5UL7
	g4KxQnQ==
X-Google-Smtp-Source: AGHT+IFAew6b4XewE2sS3ACOtYD2pG3glGOc5kuvZ85xkAahNNImPTypHr5ywNAFiwSAz9u2K0i7i4oJsHpu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c22f:1975:e7cf:849c])
 (user=irogers job=sendgmr) by 2002:a05:690c:404a:b0:6ef:7372:10f8 with SMTP
 id 00721157ae682-6f19e752f6amr27967b3.5.1733990735857; Thu, 12 Dec 2024
 00:05:35 -0800 (PST)
Date: Thu, 12 Dec 2024 00:05:29 -0800
In-Reply-To: <20241212080530.1329601-1-irogers@google.com>
Message-Id: <20241212080530.1329601-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212080530.1329601-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 2/3] perf machine: Avoid UB by delaying computing branch entries
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


