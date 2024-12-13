Return-Path: <linux-kernel+bounces-445572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E69F17CB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE2216C38B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB431A8F78;
	Fri, 13 Dec 2024 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/AW9b31"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE5F1990D3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123884; cv=none; b=sApMu+X1IwQavy2I/tphXHkcRv/+b8MGudnTj2Ne0nNrFVnoZ/o4O0OnOKR3lURmakqwX35ZazxUxIDf0dymun2lZWHF91mUMBLlrAM2t00p2q0pTgYLihJvRHrPlJkhP9eQShYudQkVgvvihprzcAx6foMFj2qp5DA2Tm8f/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123884; c=relaxed/simple;
	bh=i5e1b7t1EPpevqJjKlGFUSU+o5EL+PeGA8k4xzs8Loo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tX2JWkArf1kvTMCcbAv4JvmBTz2ciTkIX+OPlQ06+JAxunHKeiBu9QiRrO9I7GZ05p+55fSn334Hrv9yZufoDEqElNuBGiDhOt36e4NvQgt7ctPhTYbHKAnCWHvb4F5lqKGaBeOmw4P3DpnMlO55kNUdCn4DtdSqcR9i8ZO06Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/AW9b31; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39993d8594so3270614276.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123881; x=1734728681; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jve5UrRFX8lUtfG0zKrFxVw3qJ0NTFZjVOZjxLZ9cVg=;
        b=q/AW9b31AwzdF2MPgZyiRCOZm8jMoycmBbP8bwFiuQ4KVPGi8yRxHagzUmPfUsI/rv
         nkdhfz0LVHxaP5Ju+TUZ9vynOea+c7Ij3cOKDJfIbK3t/q9nt2ulCevkt8akkGoaIDM1
         V27Gf2ISysII2zr4AX7ZzDhi8NpJYb7ehdWZxj0ZoRJTIm/pn4w6/aja3y6GOk5a6/hD
         ifaMASLDHl/F4b04rbC1POX6yc5MRf02nebueSZ/wgysXEq99ChiR1VBGcRxXnao1CvT
         +qnB1oCMGYpxOTqrRXt0AyS3VKitm9dvGnrCpNk2KC/mx5VEmi7eBEB4n6YLxV0dq+6P
         lW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123881; x=1734728681;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jve5UrRFX8lUtfG0zKrFxVw3qJ0NTFZjVOZjxLZ9cVg=;
        b=Y+7EZ5jqCU41ayki46L7MBopaxlzL3LofUie8ZVVdljzoZVIOJmpUE9zad40jbbTQ/
         y59oYhbLvFAizxAuwbpNKoTDoZDWlx3BehCoGcRcO+68NavVZf3WN9JnC9gjIjSGrjzK
         VrmcyzHEvhUxkdefjcDUAIGJladp2TuePiOR9XrsMP4dda87AacRAH/ib0cELfOOA0FO
         9AWzhfaiWsabPsUzWKUfDSoJatkKQVyHOiOnngRcl6/2Wcnr1Hj4noOO2InFTm0An7QU
         O7NCw/T2jLLzauNjHXs2ImDno6KLIQ95H2rb0IMLRbt/kplStaT2mHnCbNNAyCvWF7QF
         5dLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQiQs0ERIUqFFCOsDnXfaSPOST84yIH6rc6FqlWrR3lB9j0PHKSATgWc7bOL/9JmkWXda7+xHB3xYVYjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAQuU+giiR1B12eSo0tbkAjhC2fOPKmWXptbCghkUHj8CSKvo
	grSvK/Sj8BGrYrFzClcrwGAjdJTe3gAJmIyIO8MiN6g03CRYDewxncRwXts+Wv1caW5//gDVFlI
	WNJ+HAQ==
X-Google-Smtp-Source: AGHT+IHENPzULra0CGF12H7jvOCHRuu8SzpjakUA14QaljJ4wh60e2ID3JmDlWJVD01OmUAMdsqmIhpWRjOY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a25:aa2c:0:b0:e39:b4ca:3dc7 with SMTP id
 3f1490d57ef6-e434a259f73mr12504276.4.1734123880992; Fri, 13 Dec 2024 13:04:40
 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:21 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 4/8] perf evsel: Avoid container_of on a NULL leader
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

An evsel should typically have a leader of itself, however, in tests
like 'Sample parsing' a NULL leader may occur and the container_of
will return a corrupt pointer. Avoid this with an explicit NULL test.

Signed-off-by: Ian Rogers <irogers@google.com>
Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
---
 tools/perf/util/evsel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cb6952b6d9d9..dc427eafca6c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3327,6 +3327,8 @@ bool evsel__is_hybrid(const struct evsel *evsel)
 
 struct evsel *evsel__leader(const struct evsel *evsel)
 {
+	if (evsel->core.leader == NULL)
+		return NULL;
 	return container_of(evsel->core.leader, struct evsel, core);
 }
 
-- 
2.47.1.613.gc27f4b7a9f-goog


