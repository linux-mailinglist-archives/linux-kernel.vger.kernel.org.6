Return-Path: <linux-kernel+bounces-255827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD6934588
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 330C0B219C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 01:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907664D8A8;
	Thu, 18 Jul 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smYjIxup"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BBF620
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721264462; cv=none; b=a2SHXWp8SQZEFNfVSfhF40oemO7T8lO6eJHnFuUqJuW2wh34aeFe+Nr150daLrAU4Ogdxa377S8Cm4djRxMP4hM+2NeYtzqg7eKPAh/b6I8pXDzqWEEebBv1Mcsje8TTiPU7NRgMfuYZTML7m25Q9NR+xA7gtSPB8TDd6d9AD9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721264462; c=relaxed/simple;
	bh=lx9B36RzjHlRcTa00YroWxsB5FR7jL0RJ2UU+VNJZi4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fOB1QOLYNgKr15mgxDylMSXQ9hbf+VrUFe7YGPVvXuCP6vHcjX89Z9FQBDm2B30NpKWTWr7hIEDuYdCZD6qtWV2pbIt+vjVtDI0sjRL3JDkQehpk3wv86rq+CCK3op+DL0LNIbNBjey48FRnInt6g4oxyidNUbm2e/2e7vuCQHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smYjIxup; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e05eae12defso804720276.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721264460; x=1721869260; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRYCHYYbMGKjB3Qvf71te5ARgV5gIJcFTXBlC43nr00=;
        b=smYjIxupq4tHm3CdDh2uwakLulQ/eDW6sNiEWFfs70FfJ9WdZng1l+4U3aoJ+AFuy+
         ZxzbYl4yTjugcqqbyjzomRTV5PHzPu8AA2V6ZzoA/4kg/hI/qG6kcygUgtJtbYrn4vWL
         4BYWTXO2LtG6PoPidbNwfAUpXCkgjRqGO7F4eW8X7qm0ARhdJEfVJBznes6pBwOrNrb9
         /TkbbnSNk+qE585vNqoJaS2ZT0YLOBa/Rkqzef+RpvQ04OP5CwLhYL/cUNlv4p0Rt2vu
         CqakyMhjcZBh+qbJwYO6XhdnXXCQ5cWe5eRt6g0Y7Gcy5w9TZpETJ5IWEL++jK9+u20A
         1rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721264460; x=1721869260;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRYCHYYbMGKjB3Qvf71te5ARgV5gIJcFTXBlC43nr00=;
        b=bbmtTojwP4yDDssgd5AjwK6LzUPSZU011B4Vt5kUzjTASUBpndNuywo55Yp9vh3prX
         MxDnTByzVSbt7yc7gz9se/QXeCOS3aDmSqp4Yu7Mlsye+NGzAtvV0j/PrIGgy/43nwYP
         8UV+hwHZbYczGnhZvuyIhoYlSzYK5sivf6CwzYFAgtJhuw/Bhk12Ri9UOgo9XFZx89da
         qY8uLvH8/BACqvuE9bFFD7d09MVutMNOZUmEM4yy3J77INtyPc8EYutQj9kmiWcVAkOk
         3RRiTK7kpgCtlnc1/hgWC9KkPjiwS8vyVyYdQcqYNSQEufQcJGoMxZiMcDGzALYUTQ3o
         iiVg==
X-Forwarded-Encrypted: i=1; AJvYcCXtOtzbsfOW77cfsp7+2+zJ6lvS7u2qc3m3kHJvVrTYwr9ls/JMSaxnI3yHmoI1v3RrXSNAV7E9TUZJz8vrv0MKvBP1wy/8+kgThf5m
X-Gm-Message-State: AOJu0YwSOtVSYKfGpOxry/lMkMLDQkMuW/32t/IqOI9zTIE20QgFE55k
	LHba5MIg8LR4MROB4wbAtSUPGVphTeAn/SB2qM+US789MIXypSFjWTAM9DvVOdV6MB1ShqXssSs
	78JwOKQ==
X-Google-Smtp-Source: AGHT+IFYtrxkbVfYcmj/8+44DV+o0ePqkzDO07+yzQP4ulp2Q9arWW+kMFkiLAGqIisbVnxNl9FY7TnY38mC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:940b:9044:fa83:4060])
 (user=irogers job=sendgmr) by 2002:a05:6902:100b:b0:e05:a1df:5644 with SMTP
 id 3f1490d57ef6-e05ff4c5bedmr36307276.2.1721264460178; Wed, 17 Jul 2024
 18:01:00 -0700 (PDT)
Date: Wed, 17 Jul 2024 18:00:06 -0700
In-Reply-To: <20240718010023.1495687-1-irogers@google.com>
Message-Id: <20240718010023.1495687-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240718010023.1495687-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v6 10/27] perf evlist: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/builtin-evlist.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index 7117656939e7..818ab21c3f73 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -35,13 +35,13 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
-	struct perf_tool tool = {
-		/* only needed for pipe mode */
-		.attr = perf_event__process_attr,
-		.feature = process_header_feature,
-	};
+	struct perf_tool tool;
 	bool has_tracepoint = false;
 
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	/* only needed for pipe mode */
+	tool.attr = perf_event__process_attr;
+	tool.feature = process_header_feature;
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.1089.g2a221341d9-goog


