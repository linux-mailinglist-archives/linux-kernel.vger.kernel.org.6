Return-Path: <linux-kernel+bounces-284885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C8B950665
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCDA1C224E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 13:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFD219CD18;
	Tue, 13 Aug 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RUKI/Rn3"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F219B5BC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723555506; cv=none; b=hYmBTqygxWLlXDN8eyBJeAKDf5BpqBDR5LGH9nXJzGBKzmS3gdM9dRxgzRipZIDnU06x3LZsMmS/xkaLG9aGC6Cq/hlwMvvxWwbsE6WjNhzO2NH8/sLqeyzQIWRGfmgDDQA0X3vR6Iy8mQLc9iooV9/afsW4c0ycNcStBp7062s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723555506; c=relaxed/simple;
	bh=sk8jQ7TSnFQUuaoZblpBoM3GuHBThM7t2sSndxy08T0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qvF8LfR8Nj2wzewxkkE0LPRHLzMtHoTywdGVr9KryEnBKxUHR9/UyRVbBd/A/rWxMrgvaC6ucIHo7oqW7XubUOGZU3FK5Zbj/qeL0Ys3pMRYeQXQbV60r+LrPJoXSp71V6refaFZenT3YVr9AIk46dNKq0YUiV/E/upo8TQ06QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RUKI/Rn3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e3129851so40531605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723555503; x=1724160303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mUMDC/pIRcRlMc7URQ4bqWH4ou9rkjeyAIxTsLOjwA=;
        b=RUKI/Rn3O4aURT2ShtYQQ3jKAjOHq7BLf+P96vQgA0LDWT/losfWZfRg9MRLToZT6c
         UN7OV/7sOVKEF0DqW1WcpEdwNzrM0DrQ1gCby+T4x7nO1R9jLmU/XaqZH10Psp+pgnoU
         mvYcvLv0vO84sOdFxItRg1FsjhEf7zp7AcEQZvUkRDq9kxSR7dbOoKVHY2P+x4zNiI0Z
         vUQt2wmfGa8EvhMSw8zgA5oqpORUHE8Pjq91+02pHGiOe+X/l7fHaCSL1EEczig/68Yi
         /QJAclLe0xkdt6gi0jrvAGdwlIiBecprBLur/5h7sNWs14aDisMHME/GT4dDC8EvNmOD
         /tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723555503; x=1724160303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mUMDC/pIRcRlMc7URQ4bqWH4ou9rkjeyAIxTsLOjwA=;
        b=D14zNQTgRZaWAg06JdOmfT0D9G1E7PK9HAZSz83guznOx7y1bbePUpzH+tbeojX0Td
         QAysez2sW2UFgmDY3F6VI4QM3eLwKVaJI2/JMqLG75vkagBOTAfYi7p3SrAOANJfUF3B
         PSArr5efNsdfDkc7iqc3XxSpp9w49GYTnLfNC+wcfZWF41VQc2i8WXWSx8Jt9yzGyysh
         oVmuJUOuBJKhIxK2tKYv57KKpwRK5onKTvM7timbIHLibTC1ZvV5CHGmUmmXkoqNYI8N
         eC7cAiUdAHJO3VDg9JcN23OZ+5Eznlb0UNOOZ+a2mDcr/lYSaIXSq3t+4pYRem6jDPpK
         XSAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU+Y1O59Ga7WL7kxpr/LXx12ks+TmiSXp+puMznIlQlv6ifnUnWZzksi4dHJgHDg4HlvXeirh2IIkjthnUPFK0poS7dnWYrJLGH0wB
X-Gm-Message-State: AOJu0YxKDQHyC/ozBj2QymsuInHCh3SOIZf+ihEg+mf57hgUmNTisggY
	v39BLIeMmudWtEywGtFoa9aMph+dchEZBTSRzLd78uHq9ucgJy+92rjFCv8m7/Y=
X-Google-Smtp-Source: AGHT+IGw1QWxHLTWtfvThNKdG+ceHa5O84W33fyasp2TM4dbvhwsCi+UKFDYqmXqt/QG5hQn4Fsr4g==
X-Received: by 2002:a05:600c:1d2a:b0:426:6388:d59f with SMTP id 5b1f17b1804b1-429d47f4ac1mr26464035e9.1.1723555503354;
        Tue, 13 Aug 2024 06:25:03 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c738d21sm223186625e9.12.2024.08.13.06.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 06:25:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: irogers@google.com,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ze Gao <zegao2021@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/7] perf stat: Remove unused default_null_attrs
Date: Tue, 13 Aug 2024 14:23:10 +0100
Message-Id: <20240813132323.98728-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
References: <20240813132323.98728-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All current implementations of arch_evlist__add_default_attrs() do
nothing if nr_attrs is 0. To avoid confusion that it's used, remove it.

It appears that it used to be used as a mechanism to add topdown events,
but this is now done separately.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-stat.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a65f58f8783f..cf6a1923811b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1930,7 +1930,6 @@ static int add_default_attributes(void)
 	(PERF_COUNT_HW_CACHE_RESULT_MISS	<< 16)				},
 };
 
-	struct perf_event_attr default_null_attrs[] = {};
 	const char *pmu = parse_events_option_args.pmu_filter ?: "all";
 
 	/* Set attrs if no event is selected and !null_run: */
@@ -2072,10 +2071,6 @@ static int add_default_attributes(void)
 			evlist__splice_list_tail(evsel_list, &metric_evlist->core.entries);
 			evlist__delete(metric_evlist);
 		}
-
-		/* Platform specific attrs */
-		if (evlist__add_default_attrs(evsel_list, default_null_attrs) < 0)
-			return -1;
 	}
 
 	/* Detailed events get appended to the event list: */
-- 
2.34.1


