Return-Path: <linux-kernel+bounces-434355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277319E6561
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61C41885DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821A19644B;
	Fri,  6 Dec 2024 04:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ncfBHcGK"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598BD192B76
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458998; cv=none; b=VokDZpN6khNHsueSsU6Jeop5xpPytHMyev52mGoI5h9eQdGLlCfPh4BqbUvCx/jFPGOl8MXwaQBj8yzOCv8sq1AM/BBEau1xT4iXzQJHkNeMQIvG3PY7ditSEyJnF0Ca5oTxWrbpKlij3cFR2bkUhWlNaGXZzswvCUaFdAsioeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458998; c=relaxed/simple;
	bh=Rwf4MxwSdxTaPh5ZCszoKXNLa79X2zBBI6OkcmNS7p0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OqHYN3yMxPKHJaPGOlWjkL8HLLzSmJkUVjdQ4V8ph41cZtWuAePEVZrA0l+TW6S397Rvpufpvi1uTXKx5EJrjrzsWMyzraFQCJFE/teMv4zCtpBaxFCzKQK+GVjPLQgzuCMI8xjEfEGKKnLkmfpIsRzW1NWuf7Y7AtvjZoBD4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ncfBHcGK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef6e33c182so16686077b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458996; x=1734063796; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgJJ5g2aHoKUUYUSCENiai8qRmAsLGGyUUtQm2tP8Hw=;
        b=ncfBHcGKYVCjyiKUtCFcVhkMLuyWThePrpnjnZrPjbXv08JJ1dZI8uZW2JUMR9hjxG
         Gy0IXO5/3pQsg+5NEVKDUCURa/66rzUZd3FO2SIQIeWUr8Ne3bV8OXSGn0VbUSQW77bx
         wnq9BRSIl/VaxeV9HFOzXn1M80M+5goY95JofgHVUUtpQC1A1EVvq8eQTdgVndSvrrC6
         dcvaCMmtnEZvxMKbCZoggF1/MewpElUwR4ZWlru3hXNOM9Twlij41r/3q/yHV2Ij4elc
         /Gx7YsOUenzEHBJKEQ7TGlk7hq0jWpmAggWHFGw6SKv/gWDckP3Bs00e336kyE1HUHBb
         1Rwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458996; x=1734063796;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgJJ5g2aHoKUUYUSCENiai8qRmAsLGGyUUtQm2tP8Hw=;
        b=Uo12W7L4e0wA0yKp/266336Po1nKVUdmBSnHmJlKicEG/AOOnfNKY76p7aqmsUlngx
         S6RvtRQRUlI3fMqIhIJ14iICY/7XlsjjimdMsfnok4cwv7n0FvoGw1okBlZkrdmhbRhZ
         F6n8kALo9DLSiRd+h+h8tB/oefxcV3b8XlEB2vZw+UB/5pDprBkikl15nmwDXL8o6nae
         GK776/DgvNqDcLqWS0yPHU7yEFQUAcumA4xC+ka9twrhP8MTMWms6vWVKT3Xy0j6wzJp
         FyQgXNtcgk/tPaoPi0iWYQ+xwjcCsl0S2hrFLiB8whhTxMnMsze+hG2pyiJxYGN2MggV
         fFIA==
X-Forwarded-Encrypted: i=1; AJvYcCUEDf41As8yuwejBjlpu41+cVp3nUuBGa5Tph3oAUZ/946Ff/wt6CbNIpNY+sEXB5RL1o7JWfOFx2BmT/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWAkw87OXA9mFAPkALvNgTJD75CYm/K57EtWaUnLVfZiTCOdcy
	pBIhE1hNRQBrz7BrxDWt3HW+5ShXZmqVF/6WAUWAl8gGQoUWryhJwBjk9b4Hk0zVcQ/lgJYgsUd
	8Y4GjTA==
X-Google-Smtp-Source: AGHT+IEGKy7oI8KriU61gktJff/RjJQfOZ1L6irXI6BNWBEsPPfFoz+Td9buKSXKNERBGKurnjEaVnc0Uc2S
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:4c13:b0:6e3:8562:fbf with SMTP id
 00721157ae682-6efe3c6ae7fmr12677b3.3.1733458996171; Thu, 05 Dec 2024 20:23:16
 -0800 (PST)
Date: Thu,  5 Dec 2024 20:23:06 -0800
In-Reply-To: <20241206042306.1055913-1-irogers@google.com>
Message-Id: <20241206042306.1055913-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206042306.1055913-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 2/2] perf test hwmon_pmu: Fix event file location
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The temp directory is made and a known fake hwmon PMU created within
it. Prior to this fix the events were being incorrectly written to the
temp directory rather than the fake PMU directory. This didn't impact
the test as the directory fd matched the wrong location, but it
doesn't mirror what a hwmon PMU would actually look like.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/hwmon_pmu.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/hwmon_pmu.c b/tools/perf/tests/hwmon_pmu.c
index f8bcee9660d5..d2b066a2b557 100644
--- a/tools/perf/tests/hwmon_pmu.c
+++ b/tools/perf/tests/hwmon_pmu.c
@@ -65,7 +65,7 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		{ "temp2_label", "test hwmon event2\n", },
 		{ "temp2_input", "50000\n", },
 	};
-	int dirfd, file;
+	int hwmon_dirfd = -1, test_dirfd = -1, file;
 	struct perf_pmu *hwm = NULL;
 	ssize_t len;
 
@@ -76,19 +76,24 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 		dir[0] = '\0';
 		return NULL;
 	}
-	dirfd = open(dir, O_DIRECTORY);
-	if (dirfd < 0) {
+	test_dirfd = open(dir, O_PATH|O_DIRECTORY);
+	if (test_dirfd < 0) {
 		pr_err("Failed to open test directory \"%s\"\n", dir);
 		goto err_out;
 	}
 
 	/* Create the test hwmon directory and give it a name. */
-	if (mkdirat(dirfd, "hwmon1234", 0755) < 0) {
+	if (mkdirat(test_dirfd, "hwmon1234", 0755) < 0) {
 		pr_err("Failed to mkdir hwmon directory\n");
 		goto err_out;
 	}
-	file = openat(dirfd, "hwmon1234/name", O_WRONLY | O_CREAT, 0600);
-	if (!file) {
+	hwmon_dirfd = openat(test_dirfd, "hwmon1234", O_DIRECTORY);
+	if (hwmon_dirfd < 0) {
+		pr_err("Failed to open test hwmon directory \"%s/hwmon1234\"\n", dir);
+		goto err_out;
+	}
+	file = openat(hwmon_dirfd, "name", O_WRONLY | O_CREAT, 0600);
+	if (file < 0) {
 		pr_err("Failed to open for writing file \"name\"\n");
 		goto err_out;
 	}
@@ -104,8 +109,8 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	for (size_t i = 0; i < ARRAY_SIZE(test_items); i++) {
 		const struct test_item *item = &test_items[i];
 
-		file = openat(dirfd, item->name, O_WRONLY | O_CREAT, 0600);
-		if (!file) {
+		file = openat(hwmon_dirfd, item->name, O_WRONLY | O_CREAT, 0600);
+		if (file < 0) {
 			pr_err("Failed to open for writing file \"%s\"\n", item->name);
 			goto err_out;
 		}
@@ -119,16 +124,18 @@ static struct perf_pmu *test_pmu_get(char *dir, size_t sz)
 	}
 
 	/* Make the PMU reading the files created above. */
-	hwm = perf_pmus__add_test_hwmon_pmu(dirfd, "hwmon1234", test_hwmon_name);
+	hwm = perf_pmus__add_test_hwmon_pmu(hwmon_dirfd, "hwmon1234", test_hwmon_name);
 	if (!hwm)
 		pr_err("Test hwmon creation failed\n");
 
 err_out:
 	if (!hwm) {
 		test_pmu_put(dir, hwm);
-		if (dirfd >= 0)
-			close(dirfd);
+		if (hwmon_dirfd >= 0)
+			close(hwmon_dirfd);
 	}
+	if (test_dirfd >= 0)
+		close(test_dirfd);
 	return hwm;
 }
 
-- 
2.47.0.338.g60cca15819-goog


