Return-Path: <linux-kernel+bounces-255841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6659F934597
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18AFB21812
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22F981728;
	Thu, 18 Jul 2024 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQQjWLrr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ADA8062A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264498; cv=none; b=DJpGf+7qxJmrjCzHy/1QTHYBdlSx1xxLUuikFK4/7eu/2czAL/DWmB3WWcI8vficKMGkYP43xfFaYVQFK2jtbHUVaKikZvUu33JIWI6u9pIBABwSiuXowYSyshxSyWFDkdrHoMqbCCfuY85kqy/csFuBADfOH8Vo3HCdizAgvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264498; c=relaxed/simple;
	bh=YbRvpu+uwwMuNTTvEvI4OhddcpMs6oF9/mMJNtkseCc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a1XdAlmMUMbEqG/YI0P2MFB4iF+BrqV9TZWwDVgKHA9DP0fUUAVBnhjni9Nb6KrWRf7LhX9kzYm7eXgMTd8s+SyhbUlMCUTXm4BopaPu5vuhsx98w5tm0VX6hmKQkR8UWAo3QfNuwWRWvFqkbJBxX4A0/TnlvQZ/HWPFEM0Lbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQQjWLrr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05f08adcacso782946276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264492; x=1721869292; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REzOwcnCQMi8P53oskFE/aACHZkwc/UlMI8wZ8Kriac=;
        b=SQQjWLrr9ecqnLoGcmCDm5TYrwjsy7H5/tlhASgyuj2ggPopTjzlrdW5Pqy56iGO6O
         RtwTLOv1oTaPKmf00Rg1cUkoAkJlwUgqFCr8wYSRz+iLMRLYTH8u7tCBeS5DGN4m200h
         nmd2eTjmHYVPJf7cWFzDGbfd7wjuzG6xr9M1vvXJtrzW5XhD1jA+OQ2gMbQQ530m9Q5R
         KCtPDc6e4gmqel6G7YuCLng0tCjd78IOjhkHXQS2iAv1LNJmjWUKloXXEa8uKMT3MBHk
         rhdD3mNaD74Z449VoHQCSgTdJOk9EyvpIDgw75HKcH5v/7urhVVvj0rKV1WLaBB7dUy1
         LjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264492; x=1721869292;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REzOwcnCQMi8P53oskFE/aACHZkwc/UlMI8wZ8Kriac=;
        b=in/7sYUnLYtkFDpeqzumQkJKBZkIGeq38mlKBnfrac6NFr+CFDRrNhS1cEu8nRlWu5
         N0Hn6gw4I4Cjg8xgBhOfYyPwXqeDpniLqBaatE4kuSKPDdB68WZxvDKDMxTuTa0vOZPU
         lpqMQXz/K2VYO1mHp1Eiu0j92rEw8XK/UU/Gy/jpIs1PKFk5emJSXSEIcY/Pmd8zZd2f
         3+KOImXTbdcPeR3s3asWiOmdbxDdPK5xlLnSOGH6XoNdH9FG0OJZM5/5cuqhlMIZcHqt
         lttcQ6nw2EdeqoHPiUrsRhhRkWhZd3WSIQYYFDGkZALAin7arXc5IoIZcVhE1eLmw6/1
         XT9g==
X-Forwarded-Encrypted: i=1; AJvYcCXegcM93keCn6mD5uBhOdsUry/JrX3jap0XpZLBDEZl0IPtqfeFdEgmVUrzK4wX5aT3cf5/cMcZvsL8clt05NX2zE3hCfLTyEarO2ky
X-Gm-Message-State: AOJu0Yz8X2OTbywkhubAruN6pEGTUJKmd4K5irG/T861EUgaaiGk1kcA
	Gx68QBPRmAghRN+0xAsdKPELTBvLjhiTyidNvVWBGATdMPIByRExpIR1StEMVybW9k0ec99khxM
	KVFnqzQ==
X-Google-Smtp-Source: AGHT+IENJRTJFBxLEruydNwMFvGZtwUd9yw7NYoBiIOr6hcXSjFkwsbhRtb36vAKwTB1IMSXwJ8aHdyUAnC0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a25:a2c4:0:b0:e03:39fb:5729 with SMTP id
 3f1490d57ef6-e05fedaf378mr2117276.10.1721264491944; Wed, 17 Jul 2024 18:01:31
 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:20 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 24/27] perf test event_update: Ensure tools is initialized
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure tool is initialized to avoid lazy initialization pattern so
that more uses of struct perf_tool can be made const.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.45.2.1089.g2a221341d9-goog


