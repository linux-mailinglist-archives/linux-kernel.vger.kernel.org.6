Return-Path: <linux-kernel+bounces-358039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1197F997981
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413581C21DF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33650219E4;
	Thu, 10 Oct 2024 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGieEpAe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312091773D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518860; cv=none; b=JDBrpvOQ1HVThwTxyWuRlTEjEoy5rOog9FqlEa2aeKxb7eLqEOxgYGmFL3z5Kq7Ye9BlAuRdYJgqOF+xytKDk95bu+yX1JqJgMWlWOYvOwrNpR+KgYJescXlinnwyZhXm4u+WhFiZ7BlDnZWMCXehAAwTnexXEXPIDyFRc3Hl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518860; c=relaxed/simple;
	bh=1azV7E7FNm5ZgpAvEIdQ64JI8F44TJjzhA8h4p43pa4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EgWWASYtkK0YeBXML/G5QrnfmLOozPw81lYYEs6+4siXy7td9kE46ncuuC5aQIWu9nNeYuBT9X6lFzZAmX6XNP8aSnOuMk8BGBMad7xX2n7Z0UeP+xOEReFLHmlyMHglOZd43jOE9MvTLObw+H+6QrtEeQyOne5lGka6Ruwzwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGieEpAe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e4874925so8057247b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 17:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518858; x=1729123658; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=RGieEpAeKcEcm6ar4g37YNJ/+hhVQQ0v3QKEwbfxT8cIWzdyxPoT26P0C1LeU4FduR
         WbTetQ/hPDeLAbICJAYajGrcMQOnObKJDH7RJP6xoj+xDBYUdn9cx5ES+8mP/6Gxi381
         6gdmGWEf35S3kdjQXWgOQZrkhVjXBNnfsiOQZ8vGbMPJBU4qdCiW17YPOJk+EfjofJV7
         RYrfijZFmSKA3z+Ef6XRancPQgCqFUz8Jw6G2oK9KZdvA6RkfOOvPwTbmipNxdfWXiqQ
         g4szAFyUa/YjFApEnrYqsf+EQqwCU5dsqliDnNoSRN2HaW0FNkBnafsfTCXGPM0BGdRT
         3g9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518858; x=1729123658;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1XFcCPRE5WoawTRbLhb/GdnJyywM9jpDE6V/JQJDp0=;
        b=AO45GCRLn26V/O4Tsq1PEI96q7thIGhMXmlpcpwJ8w0L82kQL4MgETmWiV/r/h41Sm
         XEmrudIvxGn3KWzqY0ndYPzW3wwBkqMDNmC3nH/9/pFXUqpk655uLAGI9WjUWmIyzUXa
         uurnIxSAa+8ECW6DskBNdHg0ImKvjLom8/NTFfgHBxThTMiCUKLt40dZaS5XunwMpa/6
         OfxMQr6mA1imU3f8bUsgki+LnoAYuIX5fWcNBhk/u5vQjbK72EPhthXIlyLSCNVfKPZn
         I8ZrRsgfr0m5flDqGLH/CykR0oOx7FKrUHOLHzROXMVjH9AxqGVnyj6GZtFevWLEuSF0
         PNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXicGJS5CDPQ1jDB00FI7cjNAhXsFRgYpFlw56qN59QonBjwXkuA8uE5kI0fko9sKv+EJSSp7Z7upvRBKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH0FIV79ej5e+FvCWdvxlTN82oXgeE/taMJ5uUEuf/d/VhGHy6
	9RCiDSDe4FMW2yFERUwYtJvgEahB+MfAgBQH4aXnx/ktQRE11qKrTDIy0R1bYXc4WGE/RPpisQe
	B2fFzGQ==
X-Google-Smtp-Source: AGHT+IHNoxyro9XdhuFfsc7bf+vWfsjYtcZE7l/ylvctEy37DlR4T6Q+7ItK2XwAF8/IOsc1WpU2LePV/ENR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a87:b0:6e2:70e:e82e with SMTP id
 00721157ae682-6e3224227fcmr167887b3.6.1728518858075; Wed, 09 Oct 2024
 17:07:38 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:07:17 -0700
In-Reply-To: <20241010000719.1172854-1-irogers@google.com>
Message-Id: <20241010000719.1172854-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010000719.1172854-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 4/6] perf stat: Drop metric-unit if unit is NULL
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

If there is no unit then drop the metric-value too as:
Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e392ee5efb45..6bb048fefe9d 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -470,8 +470,8 @@ static void print_metric_json(struct perf_stat_config *config __maybe_unused,
 	struct outstate *os = ctx;
 	FILE *out = os->fh;
 
-	fprintf(out, "\"metric-value\" : \"%f\", ", val);
-	fprintf(out, "\"metric-unit\" : \"%s\"", unit);
+	if (unit)
+		fprintf(out, "\"metric-value\" : \"%f\", \"metric-unit\" : \"%s\"", val, unit);
 	if (!config->metric_only)
 		fprintf(out, "}");
 }
-- 
2.47.0.rc1.288.g06298d1525-goog


