Return-Path: <linux-kernel+bounces-351574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2834991339
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2BE1F23CA2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8B1591ED;
	Fri,  4 Oct 2024 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPrmzqT0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F33158A30
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085295; cv=none; b=uCPousA49OiWZ1gOL/+nzWuwuHC/7aeebZAPLTQwsrjMJgD9eAmPLxilugJzV68I7z/iiHUPc9S/eOqUROlokfU7cqwHG2iWRUGF0VImQqqjdCGvkLj9ncjMDCuBNfhtHBiqkSLITwxjprMtmf8Dv+kqFfohPy2oTXlWA7d+W9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085295; c=relaxed/simple;
	bh=WH6U5UKcSxKz080nFhPzA6BhGHtiiakcmSbMwKhmscg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=cEf73c1Nqr9dK8Iu7eBmG7EgrCuTxX6UVW49q20/0UVuzNFiAxN/Mk1L0kgiRmiYz1vFVst4eqqg0pEFn5mjtIqpQNPzFPA6w5Hk8ZBmJsA7P1FCshyTHdSl/VqE2ovRNzpofSQOZX6Eu9ip5aiVEFaPJxZEYMWcdl//lD97dFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPrmzqT0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25ea440729so4118362276.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085293; x=1728690093; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JbHvBR/EzAqjLypHxbH5hOAD+Tff2Cbq3GElgEXpZ6I=;
        b=vPrmzqT0DMXQTv2hokqIuAxiwMTUWb3vr1SsUTyRyZgBti4/SiEv1rg9BAn2cOUPLn
         pE3QQaNWr+gRBzaj8xlBPfWSQpRieXD5ygKYrQwjaZ9Jd/6wmCHAtaRSEfJh9+t10SJ+
         tm2hiCatqyYgOF3Swa4/HPAxkxgtJh5b8Vkzku2VFkYp7YajWZJw0x6VqHSfWijGt0RJ
         P07kiUxvWTesmQS8EGMYFDwLT8oekUB/ZKOB/E70jHVRkE5qicM7TG+Ap7HMTF6lWMGN
         FvksCBc9IrhoolzEe8YN9sG/DWxg4AeTR443pun/HubifWOhSO2MFhr+bhAdTKoSkmkd
         4nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085293; x=1728690093;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbHvBR/EzAqjLypHxbH5hOAD+Tff2Cbq3GElgEXpZ6I=;
        b=lSMHU1i++w3dFFvwXCC/xUHjxcQD4N+Oc0iuTKPG7duCiMSj0ziUiQNSJGkD+8NQOh
         eupHxX/45YLR1TjGVpXnFiqksYVKuP6nsyfSQrE4oEXTRb3FQS3m/uzNRNrYkHmd/sH8
         MNZKKVcKMyCs5/MYIS0SvMPVOfVthP39M3CljMtw0LMy3+WMqSM2AyMmPJCqz0fWj9le
         lYaw0UwRSU6h+7GwDlu5uc2KeqpZuu7OmViQyE98J+YeDvu11QrJaxc9VBNLsjzHbfP0
         mVXs+Hjl2Il01X46fKqPrLc9MN9Lh37ZqileCfeyXNdbwYycZveqiaxKBvqpcY75AAt7
         RoNw==
X-Forwarded-Encrypted: i=1; AJvYcCWelfj0LochiumOcVQJxUHb94njbKOcoRMOigpRODw3koXYk1y0C/8zcClvODS0OPez9KQ0q3wzgqARyu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+aw0XwDBb6EDNxJ0jjCycvgVak4LTmh0HXvMxJTPHOEw2+WR4
	QToeQ7lkcN6yhmSsJL62OFvsucsMehRPZsH59v/RPG/6K6U0hEt4WRVACgcd5XmrBMTXkKc+Sym
	X76QtMg==
X-Google-Smtp-Source: AGHT+IH22Jbpim2TnHZNa9RN1uITcqq/n+FuZ5urdZ2d5c5YMlnYHZNc5wFzlIOwE/NB2tBENvRcUrdAHqAL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:6908:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e28934fc7a7mr3438276.0.1728085292542; Fri, 04 Oct 2024 16:41:32
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:16 -0700
In-Reply-To: <20241004234120.1495209-1-irogers@google.com>
Message-Id: <20241004234120.1495209-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 4/8] perf stat: Drop metric-unit if unit is NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid cases like:
```
$ perf stat -a -M topdownl1 -j -I 1000
...
{"interval" : 11.127757275, "counter-value" : "85715898.000000", "unit" : "", "event" : "IDQ.MITE_UOPS", "event-runtime" : 988376123, "pcnt-running" : 100.00, "metric-value" : "0.000000", "metric-unit" : "(null)"}
...
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e392ee5efb45..9b65968e37d1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -470,8 +470,9 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	fprintf(out, "\"metric-value\" : \"%f\"", val);
+	if (unit)
+		fprintf(out, ", \"metric-unit\" : \"%s\"", unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.rc0.187.ge670bccf7e-goog


