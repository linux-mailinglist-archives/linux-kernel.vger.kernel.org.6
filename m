Return-Path: <linux-kernel+bounces-544282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D4A4DFAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A57189CEE4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6B204875;
	Tue,  4 Mar 2025 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgoUqlXl"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270942046A0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096218; cv=none; b=XG7lZ78Lrxj9+SAQITMC5/vErREnn7D9L/+lhCLGizUAzdY/4NyxJ899AULSgQKhAdQVS8YOcohMeevDgWIVmYpKFx/gH/Bxkdldao+Gioko0bDRhzFsqC8Dbo9faSBWgDNYf0HpzX8fwSeuPHlOMDiJhqUj1U0GfmdL8Hx+QDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096218; c=relaxed/simple;
	bh=fotnUl6mFVw6Lu0WmVlkseT+Ib5u0hL9bJOrBpjvm3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoWQwdkwzLM9lJl/QRxduOJEENuo/5l26k+B8tcIyVJGyby328IQROqFbFSVVFhgc+Z5SpV4kWwf02sVLwrVlLJhJs0JX2CpoTyupBgDDCjpwnvQd4Mp+LekfT7Fb+vwYARF5M5h5PzNazrOL22pSHAu7g8XrDd5/mUMHny9YdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MgoUqlXl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so36713495e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741096215; x=1741701015; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oyc+dQeRJPZgGXdSbanHL1FEsriyRzJPurWdjKL7aTU=;
        b=MgoUqlXlA24ZC4OtijXioBT2X6yZ/uiWw8LkanFnRiBomSeTX+wc0soGJkbbl7YxrL
         tVXkajRqwTWALbvu4xxC5wk8jVn7jY8/s+uZjWYoqBPhMN4gP5qR6u0JlVkVDa203BGG
         LonKvRWFuXt8el74b+jwMChuvpyTyCgCfymBPi309bhpyzd956linHwmHmOjrx/Dr6Rk
         B3tRPMTjhJHfrPvWw5XATVp+WkV0jIMA449HWjxD/xg7oCw3M64JfJ6aMNU+miZmZRjK
         D+zC+KHYUCZyDJeXnj8rDxljP1KvbluMQsOOiywvJQ/5jiHumdTI65i+lSjrI//OFI7u
         J/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096215; x=1741701015;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oyc+dQeRJPZgGXdSbanHL1FEsriyRzJPurWdjKL7aTU=;
        b=ih2UU6GVreo3Ro9wbGtsKk50Qneu11Smt55NUkO7aSmj/bFaKQT/+TEh1z9sIHM3Xc
         DvQEeulTpVVm0ov197msKBfpm8ADfHq2LBhbpe6R8bz9vYb/3Gf04xqobUIhjPkokIKr
         OEO4fAMnmOJgq8XcojOg79wybAwdyo3nn/D02/5yaemNIEFN0ApWJ4Y8tj2jqDRzhXld
         ZLf0zUWIKWtCaJT4xkOwS5Va3CRABdXEtYU4ojZa+ah9jHv2sGKcYXpuTEN6PhMLRqmi
         2VpRS/vzAUTX0qqB7/Kv/SJUVEb9ZQOw19y4QvNJ07MDFWDoKTX4ELHMVve4zyNgLz1A
         RP9A==
X-Forwarded-Encrypted: i=1; AJvYcCWkmsIDRhB2Is43l+Ob1Aji6Bb0VAxG/1jBcibyQe41oprPvknaodDLO4lOp4NWneFL9NVu9WCf5iT7cXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Yu4XuFj0TvZkg4cZk6toLKcU2lF8Gyqr2AUQjMJX4LG+fje+
	mXvLtqFGhwK1Z77kELIM0Cp0aWL7ZsaI8nB4mOIGdQvqjRqbvxZerP91KUos97k=
X-Gm-Gg: ASbGnctBDYBMaeImLSvWJfLHojujFNWgdpGkJyiPCS53uYO9nvMUdpFqc7GXh5+u0PH
	h2mZuCkQCwVdbg/OzQYYpSyxTnBF4CmFJyaSAjE5RnUPp7cqeVzx39bbX3AvKL7IWtvrpbBx+L7
	811XK1Y7Y90s3TOwp0JGSxpY7L6/SNonjqBDvPJ2fASaUXM4RN5Sj8KSeDbVD5puZSbCFYhExiK
	zEG25lUeay9iTVo2TI6OV5O7rcKMT4oskI+XpGmwvwCzp5cXbABXj0R5tSZK6clME8Gjnpj3ZIs
	6M0/4VIg2qls4RK7AkVOefBwHd3yrF7GcmvCJ6U+GZvrtJmJ
X-Google-Smtp-Source: AGHT+IEuxLuB2VKvMIgoNJYYZcq8eunqDiuuEPPOKwodqE83YBs5enQUed7C/k5mduwZC+ZQXinvcg==
X-Received: by 2002:a5d:5f84:0:b0:38f:28dc:db58 with SMTP id ffacd0b85a97d-390ec7c70fcmr15776645f8f.10.1741096215355;
        Tue, 04 Mar 2025 05:50:15 -0800 (PST)
Received: from pop-os.lan ([209.198.129.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7cf2sm18096697f8f.59.2025.03.04.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:50:14 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Tue, 04 Mar 2025 13:49:13 +0000
Subject: [PATCH 1/3] perf list: Order events by event name before PMU name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-james-perf-hybrid-list-v1-1-a363ffac283c@linaro.org>
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
In-Reply-To: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

In order to be able to show a single line for the same events on
different PMUs, they need to be grouped by event name. This is because
deduplication relies on similar items being adjacent in the list.

Even without the following changes this would arguably be better
grouping because it's easier to find events in a topic alphabetically
by name, rather than in separate PMU blocks.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/pmus.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index dd7c2ffdab38..4d60bac2d2b9 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -445,15 +445,15 @@ static int cmp_sevent(const void *a, const void *b)
 	if (a_iscpu != b_iscpu)
 		return a_iscpu ? -1 : 1;
 
-	/* Order by PMU name. */
-	if (as->pmu != bs->pmu) {
-		ret = strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
-		if (ret)
-			return ret;
-	}
-
 	/* Order by event name. */
-	return strcmp(as->name, bs->name);
+	ret = strcmp(as->name, bs->name);
+	if (ret)
+		return ret;
+
+	/* Order by PMU name. */
+	if (as->pmu == bs->pmu)
+		return 0;
+	return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
 }
 
 static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b)

-- 
2.34.1


