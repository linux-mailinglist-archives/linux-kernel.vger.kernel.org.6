Return-Path: <linux-kernel+bounces-249668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1092EE58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBC31F213B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B617C234;
	Thu, 11 Jul 2024 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwMXmUMw"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8B17BB3A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720872; cv=none; b=ntDeoCDx1f44urfWRs1TV/YifRm74iTYnL5qTg6kf+iZl/ygQq5kjNAoHhP1OorQyUjCAiIrbEBeNjIUliYJWViMVuni9cnTXVDBsxLTVJld3/NI/SfrJuXKXHw1XM9W+7NGRyaq0fenyaq2PqCl2CJnEnTxAcqX1ho1pN+UC58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720872; c=relaxed/simple;
	bh=QJTLBouB03fYPDSHR5NUfnIzNoxc+9fFEDyXtvrnJyA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=V2FQDDTC4Qx1B+QcvOZxwQQDdbqkbaYqnc9FYNAnwm0DuKrpcxLPk6BQ9N9iIrOOzwqJ5jOyWdJg//CX5WT/zCdQt/QQDQGJSslMpzfhtxwQs77kT1CRdo//Wt3CUd2cLmShFlq1NqU2wJTSauG66a1W9UX668lpBD7R9l1Z08M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwMXmUMw; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0353b731b8so2287953276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720869; x=1721325669; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2MNiLSniwVv1E9e5Lf2m3HZTOrICLuX9boz579z3/KM=;
        b=UwMXmUMwukNa6Nd4r6YnVtVgunpqe4UQZWTgZ7Qm/+RfdggDEzq3fC2n7mRjGMXVTk
         znxKHWl2b9MH5ZvZB27gJgbCGHTBMELZFao55TuzHH3FQob/siuw0U3lL37fkqciMMKs
         gGFyiq1F/+YNWrc1R+O+ut4tVAe0uT9NF3lW3CiUgy0snEM5d3o+k9v5axZGex74uf52
         m0EXL0B13ukHOs4cmlEWji+iRu88nxT8v4YF6k2c7P2U+m1dJ31X+Z6HGvuj1JAzpYJ9
         PReKqWbJi3MvygF1Q+RO2CeYmRz9SrTVGu+8Y2tGD/SVXhUpChCnAEOB00sS2OfDWusx
         t+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720869; x=1721325669;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MNiLSniwVv1E9e5Lf2m3HZTOrICLuX9boz579z3/KM=;
        b=LWM/MuH2vb0I/9jcmSDalZr6k3BgtO/EgfiPFQPQ0hH4BPGVyYYqMxKOA2pWBEoLqy
         oDKM+WKS+GlHRnkj4Bgn+9pEhjDrGMcWhhbY3Vc/pkAWb+mBEySc2NUzvIP43SdKvNMS
         ssaCbeze5syCkiTZWDyq0gCgb/BpHeYBF350HmWm22QuIM7x/+OKs45FUTqugWUfm5e/
         h3MLRGx86tdwvcnbltuBrbDKZ4KK0hLfYhVyeGpbp34ZCTi8Kct5Wrln+jl9Ypkdz99M
         WQ2235QhUYhFtwE/9RaxbPCMqMkvdJbc2Z1y+iChFotT1RPblmLXWyVZIcbVqCuxZp4q
         gA7A==
X-Forwarded-Encrypted: i=1; AJvYcCWYXvekVWq2HF2f6VkQ58csWKVZALzml/u2FOpV5JlvBONzTlt7cidJD20L/D++WGroJxKpROa7lQIixQ4egyd0bmV95XStzacz2WnA
X-Gm-Message-State: AOJu0YxcmwVhBv8lTdb+6K0AYPbcBMW3DZCf5AfBTgEsVDJcHmeE08dq
	diJB9M7+qnqGkHfU0njIzMzkix3tEOq+AAQS1LYtQawZA9yVqT+DYYGy1b4tEhDGf1qokhRZcJR
	6DLmlOg==
X-Google-Smtp-Source: AGHT+IGM2xQme0Hs8QJpMwRrl0GnjElIf4QWIdg7meyT8+jpTN98FNf8secObYryk9mDw0GyqbyaX812usu1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a05:6902:1206:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e041b134afbmr16523276.10.1720720868643; Thu, 11 Jul 2024
 11:01:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:05 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 25/28] perf test event_update: Ensure tools is initialized
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
2.45.2.993.g49e7a77208-goog


