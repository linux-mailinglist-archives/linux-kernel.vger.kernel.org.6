Return-Path: <linux-kernel+bounces-231501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAD891994A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E721F23270
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721E5198A27;
	Wed, 26 Jun 2024 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KWHjCidm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A8198A01
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434256; cv=none; b=EIbW3Y724NwFVV1IEPhmHpWXDdKItLUCDIs6KjTgIxlpLxdOM1CpVN069goPfIw3EN9mD/7e9A+pSg2aEGxT2isNmaZbzokjB+SJN6NwbKZEtFbiRj6FBj6HRLDS6UuqGdPTfkNu7QM/5aHUUWEcC2RYKbsxa/IZ3asgSi1BR2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434256; c=relaxed/simple;
	bh=vLAWwP6pxeZ3+8l+944tuEizrGnbW644ZT2RUZBRZLw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ScCD5Ct47Dno81QUWSd8te+Pt7XVjqlpKTRJrukAfgocgwsujBxW3e7gCIT0L1ajp/BzKcMRnuMtWutwO8tPm2CT440LjTlnx1bPVoz2wfGgdeLJsRwyRb6WsP7gtMfOD5bjfKR6wXDP0l2AFrMKIlPRr+Y8PHHfgzF+oqDdx/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KWHjCidm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6452f8f2942so77874697b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434254; x=1720039054; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=KWHjCidmBAyCkFGW6EIyO48NzgysWZZxlcV9NlHN2Zg6eWifjpyWwi5k3YBFVSEoiY
         5y1lUY85q+T3atzhq7Pd7eZKSzKImyRG0l/hP40Dg1/kfDNdZSbosF9GbJtSxSUdcPsd
         Y2c91tVAtccs4XJgF9jAl6SgySMS7+K4GPVyN0lQRhldTCIuS+FLR+Y2bh7WrC6Vch5A
         C2Pqbwp6Mvi0zQ+TpB9aJPeUdlnocKxpDZn/HBE6ZPoEvjz7KFEA4zsKuAXSUzHvlu+v
         Ql1MSq/nqsjckuMaOm4NObCxD1O6QyvfJpjT63DSk7RJJ4YD7ALn2rhFR0EclqgDsbeU
         895A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434254; x=1720039054;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=W0yuWvPga54IWzJNPHVIoUgEzVeQ8WxUsUwnEL0up0gQMPi5CWvDWBGbXF8i4Wa6/C
         IwvRfc28OsbRtbyO3RRhy/LiJbKFaRHdvtT+dwFMjKMBX9oMO5JtXK9Cmypyu1AR54/c
         iK2ZDeuUwCeLWwOHMMVy0kD1saifL5pADWa/iwn/HbPe2bC3nbTyP/4LqQjrRqv5Ay76
         zfpDEM88FA2I6ZAEbl8iOzJySxPgOX0SxD7rqLKlhaK4JhbJtgP43HQC4p6Iiq5dzwcj
         iuvQn7ElNkq8SoD7JPtAwBpQUaifQr7otjheDVS1z9dmNQsYciYeY3bal/XoVPxHlQ6P
         en7A==
X-Forwarded-Encrypted: i=1; AJvYcCV6f0eSa5o4EVvdWKngdKma20Lm5PYVQgqeatWOJ5+lGgJ/eq8ocK6w44Lua48aaB+b+mQFqBjwul7Nm1IsNxP0ScCTLGGXiY5OHLJL
X-Gm-Message-State: AOJu0Yzu3MknwrcjPJjeQNGs7L4r3agl7MkqSCVgrAkOW/lQMmuZXiIS
	YRNbc6n34NhpW4EtoNYQFZP0Q4U5VJnny9ADWTAPNjsZTu9W810Cn62XUYyQ0VJkMqmMTw+KLe5
	cr3gpfQ==
X-Google-Smtp-Source: AGHT+IH9TuYO+WiPmgRtSFFWHjHBH655rX65a4zVzk7gaz2aQTP23YgHXVJikjgfAs5bm2nu+W28AwUbyUSL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:dff:3096:85e1 with SMTP
 id 3f1490d57ef6-e030104fe43mr68452276.10.1719434254286; Wed, 26 Jun 2024
 13:37:34 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:26 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 24/27] perf test event_update: Ensure tools is initialized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure tool is initialized to avoid lazy initialization pattern so
that more uses of struct perf_tool can be made const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event_update.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index fdecad920f59..d6b4ce3ef4ee 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -103,6 +103,7 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
 	TEST_ASSERT_VAL("failed to synthesize attr update scale",
 			!perf_event__synthesize_event_update_scale(NULL, evsel, process_event_scale));
 
+	perf_tool__init(&tmp.tool, /*ordered_events=*/false);
 	tmp.name = evsel__name(evsel);
 
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
-- 
2.45.2.741.gdbec12cfda-goog


