Return-Path: <linux-kernel+bounces-283764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C28894F87E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5141F21CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1919D8B4;
	Mon, 12 Aug 2024 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0qiufs6x"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844F16BE03
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495702; cv=none; b=soJq8h1MXlpNSlKtS7JhO8NEzCSdsboU112+4htHXzsezMhwmxTgx8TvB8NZGT0904SBlldoCViMitkVWM7LjVAlBYc0k6/5lZ8SdBmLEN1KVME23wf06WsdP816Ofo07HFGwOsBPK/aycaC9wIsd6Mli3Rax2f66yZ6/UW8qYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495702; c=relaxed/simple;
	bh=k0D8y4XSo3WErX7je8ZpWPyhozBB7rGTE+pvrl2cKZQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=glf90PNySenZrjlYapkjjSdU5J4/hTTUoCty6OpfOLu0Zt23vUWulyGO5zsr68PKgUEBB4byBuqsNaVUxNPis5O/62Ft12kjH97uD9ockEKhm0hvWGZ/CqVG+3ojuQaAaOx4nGi8Dm9+4Jy9ONZoi3Dpt44ioTdpbSnuMLqNp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0qiufs6x; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0e4cd64909so8234224276.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495700; x=1724100500; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kiqQs713NS2cwu9IGmflyeUpCc5+2eIUysSxdZONVB4=;
        b=0qiufs6xNL2dp715GpNy1/zj4t6xsd55u/G/dZiFysL6c0alaXeLQFiBSuEl8FVnl0
         FxEelhLatMLKvU0wBzvakJJiP0halXZuh3vUe71/yY/pSNSwbuyubzIuqGkUKL6s0FLt
         3annXynzQDXYTAqvNHfHP41QWACuHO76/UdFIaSKAqUWQRyrcG7XyuLUS5TAkn+x9nGQ
         EVae2/orL6nijUhtuszk3xIxWJSTtG7604I97N7GZwuvHTPS44zDgoXJVkqYHo6RhIB1
         6RDHlEfjnAirIkhJhjj3Fv0S1VCqVKaq7j68grbsOK7YvOtV2hVK4S2vMwCpfTgQIRIU
         ssow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495700; x=1724100500;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiqQs713NS2cwu9IGmflyeUpCc5+2eIUysSxdZONVB4=;
        b=X68o9YoHBcv6hdEvuYIyTWzNq+4WKH9sF11afGeX38G/i7CUdnGKGf5tGjqWsHi6UW
         Mw+V3Batrg5cU7bIXnS6jBEpx8GnF992IxWxrNDX9Xy4H2Q11TKTQhnyYg9rpn8quEej
         AZPMEJhYP3anoptcLBDaAUyX78X96RTih+a4jPyTGOB8OxfDkBcWMGDacarPPMCljIhn
         8Kg7JkeD2A4uCl5/pwsqxlXDL1+NRPJn3UWx5YLvWMTMHZtORWLkp75SFCEaIWb/Z8K9
         lzsl3meigNSBD+wQZhn/0lpr4/88JHcriUDkt8oC6AIMkCbP/+fWsirLhQf762lJc3CZ
         WBKw==
X-Forwarded-Encrypted: i=1; AJvYcCVSShObL1Yx/TvsaRhTdsDq7uOUVPdS9NWQdkzAIXrO3Zrp5Tzr4Ja1vhchB2KA5/xkUCwfedOq0SBAXq8XqR3DHBn3rW5r0Wq+6jYs
X-Gm-Message-State: AOJu0YxSJn+AtJ2FQzUXSLr7Zy9r16s1/BLdPRijCi6oNihvbWYfm4sS
	BJ/4wx0r/IEe/Jclwy352s6S5W2GHiEwMcHHmxTLqYVIwEh4f3yqxotr104hpvdtJI8bEJ3a896
	1NxJpjA==
X-Google-Smtp-Source: AGHT+IH3KiTk750Irbjnomg6Lm7uXV9YcitFsOtYH/VB3qZCzlTL/MIwOsfRWnRrXOwHrMNRY7pbWgYokw0z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:3002:0:b0:e05:6e45:84b6 with SMTP id
 3f1490d57ef6-e113d176384mr2040276.8.1723495699659; Mon, 12 Aug 2024 13:48:19
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:16 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 24/27] perf test event_update: Ensure tools is initialized
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
2.46.0.76.ge559c4bf1a-goog


