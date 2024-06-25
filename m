Return-Path: <linux-kernel+bounces-229411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645D916F43
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72DFCB2571D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF67180A6F;
	Tue, 25 Jun 2024 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyvEnJt9"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794851802D5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336424; cv=none; b=b4/AuD5MKfi1qJK0RuRh2ABD3TNrVJsFUhp61ucj/3RUFyMqN5HDqN9HtVDAh5FLnm242TSNtvUVDvYdw67aHOnKZ2jAEI/LJdOoWCVE1SgkJQDOJ+5mltauA1LCFtdYx0vZB5njfI390rxJASJwXbyJXFD2xKfA+fSIO178UM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336424; c=relaxed/simple;
	bh=vLAWwP6pxeZ3+8l+944tuEizrGnbW644ZT2RUZBRZLw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EAJfylDUtVMyzzFKxWJ/rdswvDOn65y6bht/KFOJdbEJ9nOoxFb4nzdgndU2DFW0Z3G5IJ8/HBA/0L/6iUI4cVKrwhJX68vwFVqkICmMpc33F110iSRoB8t2UJEbg/6Bt7yEz4y470uGvdNP7FtAazeKAeSTfGAC/6eWYFpowTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyvEnJt9; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe4f388d33so12075945276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336423; x=1719941223; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=YyvEnJt9x+PNEMpC1xEVslYpHwK6aI9WUwKhiGvF2qbdWs3j7GmtZsHAC6+P3eH0Fk
         MNvNx+PdV7HCdBeqQtxI2Es5xEbHsfeISE1LlGSJCQLMD/aZ33n6PldhiNIb3n6aNkDh
         o0UK5L/LdzLtzrymA9YOa7CsS0ZXijpiNL0PKZDJlW/Ub4jndM+RZqR3TZu1Dv46XKtR
         elgbZzrU9hroA7Do0v+Ge2gbbQ+9m7MWPeaaOv/gJepmQ2UdYpv/cfPlq1y9rLYP810G
         4vM4mQ4Dy/J9asY9NonL6f+f4KUDgNDFJK5LfRUDRiLEoZC+mhH930m28ON8Q1BARRK3
         qbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336423; x=1719941223;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TFHYu3Nth2gR5eivBBGcLrTyqj+GOTAKJL2cvnIsazU=;
        b=mynymQhocR4jzjltfjbeBilbPejCcqovZeRc1bEUWFbn+8EiqXetDhKxHarpT1gfEf
         PUqD7SjndxMiHqqggxViS7BV6XShrqmHutsXxRo07lFYPI70S+7DIwCDRZT9P5k3uuAG
         TnGqxzs9SYnC/QEclaA68IdiDUol2ocd3fW8akY+VMKGAsEovLpVaoCxAdiU3xYDdHtL
         ohZkKfZ+HDS6qQAEg8JaYAewvJ2Fw36b37XS5nb44B18R333RH5D0fUIVHEW4ZfaxW2n
         2jNUtzImGuuPwGE6xBNqtdNEG/1n3DoT2T5iBpgJdLF+NdbODlq/ZyV2Uw+PMflHxWbV
         EWLA==
X-Forwarded-Encrypted: i=1; AJvYcCVLvqx/4+4zXsif7ETfUlYOjPi+X+OmW8cWLjHC0KvbayBDes6oH6V5hIC7HeYhn7F2M6gEZP9+YBAIBrhPxZo1YEiSEAnellgtRyeR
X-Gm-Message-State: AOJu0Yxm//iZoTt7MJISOruWswsZv9iHtMJq6jZW0dWLsCEd8ShUDgsF
	fIkCjvwwebE6obu5YT5RVWEeK3uSZhh/GM8pUT0AmZ4BZz9D/WK3q9vyzN1AqWrOViCKANsK4R3
	DaiuKOQ==
X-Google-Smtp-Source: AGHT+IEIJrvS8Di9GHrS7HY7MQGBt42o3442HpJrxb6gkWIG5aRlpvERcLbaC9Aj1Jog8BdPYhFCbRMarycP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8e:b0:dfb:b4e:407a with SMTP id
 3f1490d57ef6-e03040c112cmr445932276.9.1719336422541; Tue, 25 Jun 2024
 10:27:02 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:26:00 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 23/26] perf test event_update: Ensure tools is initialized
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


