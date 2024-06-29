Return-Path: <linux-kernel+bounces-234818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1C91CB21
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDE31C21779
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3172C13B792;
	Sat, 29 Jun 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fgx8RVE7"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187743A29C
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636906; cv=none; b=qpRXNUurLVswXvK0FpUwhlkd6Mwam+32CfarCi+bQlS+MAwtztipnYqMLBUXLSp8BtOtSztv/4gKw2AFI84NHHKGmSOamQoOrKJiMQxEXut7KY0uiIR+a/sl3Sek+cmMJX6n3QtRAkGx4bsQo13YsxMmWrvK3GudeHDXBm7ZhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636906; c=relaxed/simple;
	bh=vt9ewm0QhsA5LxvdEiaxvxHZ5z/a2gIOxOI+SUxySds=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eOZpoPZlW36R6mR3Iq0Jt3/mY6kDsj9PQYHzUiWfuVPrUtFO95bJP4OfW8Ei00MiSGqen0vS/YbncM4mUI8E7kgZ2Uzf8q76/WXBmaPthoYUrSEZjZCz2I+s0kYBH1jINTguMsbR3ECVV/4/IhT3aDmwJI6py/12gXGR2ZR3gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fgx8RVE7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-64aac532a60so22739947b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636904; x=1720241704; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=noOlfQUa2/5XniX40b614TPnZq/cMjt6hUwCRNEoLZQ=;
        b=Fgx8RVE7TwnqlPqAzRnKXut2ObS8HsjRKMJBPx9qOVXAzz0/HYtk91OxLF1NQ9zgNN
         wP22ep2mz7ZcbGjLxKeH9kT8ZlNiJo8QWUF0MBAoqJksb44LCMb7BRN5afr54WK1gchU
         tbm/QLwR/vMG3AetGS/ZL4yh/Rm4d1sESq7pu38DKlrODOOuiEae0Tt0RLOqR4ru3u0j
         2OmeoeN7pc08n7gcOJH+RP/wxgsJ0c8TbOxTXsIdRczDGz5F/rDoEH7jItF25Th07k6Y
         w+JeIN+pWZaAj9Lr3dFTKLenMdsLHTo6nFFdErwhemWditIzILKTrL83Cns3GsZ8rQuh
         vSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636904; x=1720241704;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noOlfQUa2/5XniX40b614TPnZq/cMjt6hUwCRNEoLZQ=;
        b=BaTFx4mcaVXl62FCOsDRdCzC8w7WeZeClRMtZ6MfiDxyw7msnb6qTYlgbjKRRROyW3
         r7ybH11VbSdl5/DpTGdReq8aL1a4QRr4Jt0DygRG7n733X6Am10Pl1wf/W9cEnCn9vv2
         a6sd9vf9IDwcPbJOCPvbEwOUSXdkm1WTL7H9svfMTahMjHZKazPMmCB4T6M8n0vxHN6x
         7eUe6PYtX0tkPD+AqQ01/LbULe1iLBiWzeD7whVVom5P0A9bjbLBFHlXFM0o/6khZtqI
         LZXgTuktYuV3FfYvLTqaMugW9xsUriY78wjkWcAIrjTdxiPsWFZg1LSjAKAwtc6u8S/z
         osBw==
X-Forwarded-Encrypted: i=1; AJvYcCV4Hzvdh2P9N5SQ3/AARbccm3ROOCJ+2jw3/NvDBvTOq50kboRZGhx8dmp5YAPY8rVEzpM5AjNB76L+y/4qGh6Qo3jFvp1qPg18cQZl
X-Gm-Message-State: AOJu0Yx5hsOaOXI1b+aw8M+6Mq5JRSzjcEQPppI2X8RSJXf5RnlVbAY8
	OnsaAMoNL3JfsLx9r8FKEaSsdO8SWm5W7I/7nEqjvY9Bniv3drQuf98BBzg5iKTE5JlYxakQPMM
	BZ0KROg==
X-Google-Smtp-Source: AGHT+IEKYw++EBM3BOpjxqBCYOk7yHdmndAqP8d1uXeeoD7Shcgt85q+rgf6pDTYxLWW1zGq4YNyK5c40syM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:1004:b0:e03:5d0e:7886 with SMTP
 id 3f1490d57ef6-e036f29783dmr534276.11.1719636904177; Fri, 28 Jun 2024
 21:55:04 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:47 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 25/28] perf test event_update: Ensure tools is initialized
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
2.45.2.803.g4e1b14247a-goog


