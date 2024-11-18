Return-Path: <linux-kernel+bounces-412419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F79D08D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62901F2305C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E527D13CFA5;
	Mon, 18 Nov 2024 05:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Xpam8uL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04513C906
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907608; cv=none; b=g7pXv+Wpa5OhhTT0tnhpyuN2kWBZkxZ3WRjYxJnXL1hOYgtXgOsHPai1WUqrhGemwqcXeQNGLjQqJs3pKlDhybF91188eMa9xj3KeH7BAuxx0QBRLo5MZ0FjqoW+ZV1WOsw9egBWdz1dFMdahGfYSGYBOb6nSUKBWo6FD28AoUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907608; c=relaxed/simple;
	bh=FSLgf7jIU8Cg5GPZ/xlTi5EV3FppM+GFoz/qkNa3AC4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gLiQy9lu5NBalW1T2JPuk8aDaeq5clMq/FQ/5SxuZ39OWrwAkMd7xCWU8wpClOrytvaBQbh6FmSXMhn072DAyHnCWLVk1cwgQDuFdb/JRoekcwZxQbbTM/yZpom/KNBIcxJrXhYmb0sxV7sNbCKi0RhPJwWiHysIXsws4HmHnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Xpam8uL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee3fc5a13fso36572467b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731907606; x=1732512406; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CVj7EzOpLkXZaUuUsXzkWLUL7uv5LaSWkn156n2FLk=;
        b=1Xpam8uL7oFyzGeogbGlv2QSrhbmee3+568or/J8PiYsNOTq08arxd7sC6/aBfmxdn
         l5288fhl0vCXPA851vMsT+7v9z8wED4a64tchdkcW9Biiy1BIuRjKbGNViSG0nAi04m9
         6oc4DgEOaQpZ3lgxEHsjcKDUXroX128rFHoWsmsx97YvdF8vOs6tf31QnRQ66vUmQ7d8
         1gbBUeAiqEk9hkciTalJXrFkO4+Sg7R3jPxwmG567zKiadSRmkQ+gmWrHfqFDTnbF14B
         9EGTBEHWReNFZrlp41sAebKxHgBrpbaS2WK2YmHdGRRvkErz53teqSyEFXuWSkCNPBrv
         bPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731907606; x=1732512406;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CVj7EzOpLkXZaUuUsXzkWLUL7uv5LaSWkn156n2FLk=;
        b=WECGa+G7ao2VmeuOdahLQma5g7lyjX/HeKoA2lTqmuXPmRgRUQTA7fflJLPCDc+bqf
         3L9N2ZT+3ayodj8CyYua2KaaTwEVRHMCiNXNgQTfoHrDMTesXZuS0w37xvmsycrAMulR
         YWjmM+lTh1G6I0uNqU4P4VPp2S/Pwr9/mTJSV7vruuQP0xyoMZ+o4lqq2gpdsFZaOpaf
         wvVuAmtFp0g6sT9FNCTX+ueHHEHnQYubuBiWvx7un3h3ScVFyiY882O8FB3A2A2Ch0ep
         jbh4CQEjCXSzW63j1OZMFBmjkJh7bXT0kCWCrfUR692uiNO61qO9klgeuzlVJUgAYiC6
         Z0iA==
X-Forwarded-Encrypted: i=1; AJvYcCX7Agmws9YuUhpgrnHDpotCykYB/NxJuSiMHSWn7sq6Aq2JxMYKr77iYLKJtWB8CBuKigEmpu9l1jasfZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU/ksbzRmZl85p8a+Pbad9ocoOQ218PazxbOT+OB2iI5HMAIeq
	pqYbFaBkc+QaIKPKsbQ/BStQK4+Y4N2b8BFehD2XvJ01NbBjitE2mLavp1Uxm20raAs6kJ4yA3S
	YTMAOZA==
X-Google-Smtp-Source: AGHT+IHf9gDi0FbO73XCSlPlQ/bLknfcP/3i0HYD/A5A/j05+tMO0q8TKgNoFaLVu9gsGgks76Xnz9DM59wc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a05:690c:7241:b0:6ee:6f60:e564 with SMTP
 id 00721157ae682-6ee6f60e67cmr250187b3.3.1731907605851; Sun, 17 Nov 2024
 21:26:45 -0800 (PST)
Date: Sun, 17 Nov 2024 21:26:38 -0800
Message-Id: <20241118052638.754981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] perf test: Correct hwmon test PMU detection
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Use name to avoid potential other hwmon PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index 9f44093f18df..1e5f93aaaf5f 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -173,7 +173,8 @@ static int do_test(size_t i, bool with_pmu, bool with_alias)
 	}
 
 	evlist__for_each_entry(evlist, evsel) {
-		if (!perf_pmu__is_hwmon(evsel->pmu))
+		if (!evsel->pmu || !evsel->pmu->name ||
+		    strcmp(evsel->pmu->name, "hwmon_a_test_hwmon_pmu"))
 			continue;
 
 		if (evsel->core.attr.config != (u64)test_events[i].config) {
-- 
2.47.0.338.g60cca15819-goog


