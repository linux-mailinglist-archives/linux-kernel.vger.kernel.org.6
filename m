Return-Path: <linux-kernel+bounces-211495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A84DB9052A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E09928287D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188317083F;
	Wed, 12 Jun 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4YR6W9z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52816FF59
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196033; cv=none; b=na4ZyzswUpNzQSAGR0VYZmLlnQHPnFuTgpZScl2MdGIb//orVyXnEnjqmzgVtD2zBnuZIHSd2Efxyac6cGtBh/SrFoCDYCYJkBv1FUH/Ilavjhn32JHGiwd3saM9gML14QvOHO/VdI4p7g5CwMst26rsg8xthiXH/ZHd+XjyNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196033; c=relaxed/simple;
	bh=c+DRRveXulk99snT5VccdZXEOQB7aOSMnf5enVXmdbQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=NGfQmYeckSTm5FxtYMDkeFTkb2EHyDV0NOtad17a5QPS7fqxhRJqQvtIADCOpwnSaxEQuXhi+JAKclB469TL1iNj+SNmXCDUSYoa9jx67NjLv6v0aMAGjd4bSUtf1E8Hoxh/hEKE4pxPHS712QwUBuE95Uko+OI+0VHlcO3d0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4YR6W9z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627f43bec13so41203987b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718196031; x=1718800831; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DfSgBhx2prDvvpbn/rXVh0w6qYSSonJrkoho8C5QmNY=;
        b=u4YR6W9zi+yi3lOYpXYJI/c0cQHv1faIKiyySmXHvKBzcxQAv4VTrFCMMAJ62XyTYU
         Lhe07dewELjfoKad4pDBCI7kAlKVkXDRRG6v79GkrvCiVOprft/zKYABldsnVx3ZvjSU
         XpJaW45o+tTIFPaR/ZeHE1RvNjZdKdsNpyixRiCEryYmiWhCNaE55X+YbWcD+RtFkHMm
         fXWYmpz5QFw8G0kYBOaKJTeqATcjDF1Zm1xhK5LqnB0NDqJUHCDwSKboKa//f8iKnxZK
         eSexkE2fcKseibo8VJ9yH1EIXoQcHjvCYidLhtuqSu7O6yI44iFUQflZ8lWmZh8u7FV+
         B+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718196031; x=1718800831;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfSgBhx2prDvvpbn/rXVh0w6qYSSonJrkoho8C5QmNY=;
        b=c/z5DjW5jyW2GFNP5eDO1cSeUxAw8VERiYtH4DkxrR1w/KGT0RDQBXV8adYl8M3Tfi
         E1Bu1zlyAQt+cT9U7SYVYXOuY/kWbur5FsLPPE+pDtbZjq7yPx8kGURBspzhMVxS/xe9
         hcawsWvkfW+mEKlEpZVU6+7D9L9OfRSL8IFOptGzXe8Fv7ZQMYu7kpPXXsXNilceLzgz
         cFFnbs7RzgJSQ+6htnxlHIW7CwlC0n1irNR9tn0dP06vb6dC0KdThCwRNgb8OUfGXKJ5
         osXIhJEvgpcCgXZJsRiMOIE9eia3s6tAZwBuilVfnZgw1mX3+yss4Z0vJG4eNw9ABIvj
         HMiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa03/AhduvW6+CIbxRpfF5uDjyYVdTzIJJawjRtkMzporGrRehi9414QmnXYgcjqhNJ+OXAH8Ly/8VVvzlu2k6vdMsXbo0NsxCRfxH
X-Gm-Message-State: AOJu0YycPjQLvX0ORugKQ0USYPP7YG5WdxIiyw/SNKhq//nypNcv0Xyt
	qoQ383BcTH+ZGzMzWWHTmHnjZlnZ6y283Knw9GiOkDqJArUgPyjDufXs1OutNqqfKrTZsAqiDny
	3qqwUpA==
X-Google-Smtp-Source: AGHT+IFsvL4EQynJNi0fl6hpXid6BCCRZLXCXaUyrZcJtE/YeA0i+GUTbcsmCCc9bk4eqiIQIkDukubWbUDJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ea09:ea36:268b:d86f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4491:b0:62f:f535:f37 with SMTP id
 00721157ae682-62ff535129amr3636757b3.0.1718196031241; Wed, 12 Jun 2024
 05:40:31 -0700 (PDT)
Date: Wed, 12 Jun 2024 05:40:27 -0700
Message-Id: <20240612124027.2712643-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1] perf test pmu: Warn don't fail for legacy mixed case event names
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Kajol Jain <kjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

PowerPC has mixed case events matching legacy hardware cache
events. Warn but don't fail in this case. Event parsing will still
work in this case by matching the legacy case.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/pmu.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index cc88b5920c3e..201df4446f7c 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -260,26 +260,42 @@ static int test__pmu_events(struct test_suite *test __maybe_unused, int subtest
 static bool permitted_event_name(const char *name)
 {
 	bool has_lower = false, has_upper = false;
+	__u64 config;
 
 	for (size_t i = 0; i < strlen(name); i++) {
 		char c = name[i];
 
 		if (islower(c)) {
 			if (has_upper)
-				return false;
+				goto check_legacy;
 			has_lower = true;
 			continue;
 		}
 		if (isupper(c)) {
 			if (has_lower)
-				return false;
+				goto check_legacy;
 			has_upper = true;
 			continue;
 		}
 		if (!isdigit(c) && c != '.' && c != '_' && c != '-')
-			return false;
+			goto check_legacy;
 	}
 	return true;
+check_legacy:
+	/*
+	 * If the event name matches a legacy cache name the legacy encoding
+	 * will still be used. This isn't quite WAI as sysfs events should take
+	 * priority, but this case happens on PowerPC and matches the behavior
+	 * in older perf tools where legacy events were the priority. Be
+	 * permissive and assume later PMU drivers will use all lower or upper
+	 * case names.
+	 */
+	if (parse_events__decode_legacy_cache(name, /*extended_pmu_type=*/0, &config) == 0) {
+		pr_warning("sysfs event '%s' should be all lower/upper case, it will be matched using legacy encoding.",
+			   name);
+		return true;
+	}
+	return false;
 }
 
 static int test__pmu_event_names(struct test_suite *test __maybe_unused,
-- 
2.45.2.505.gda0bf45e8d-goog


