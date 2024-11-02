Return-Path: <linux-kernel+bounces-393506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D33869BA189
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 17:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175D4B210AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 16:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E9A1AB50D;
	Sat,  2 Nov 2024 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXglA3+L"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C432D1AAE0B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730566456; cv=none; b=kMxvZh3ZBOl9cEAgsDzMbxvlupS7eAMfeDI347YOKEqEvLPt0tNbqbs9mtlD/IvyGGvKMmcUbDyAMXmPxLFy8lbBUM/ecoIPAcQ9AIHMKlVW/n9VrowkAEF+Jzp1XI03QSVp3NCjZzmeO6aLmcPpbbja5jx57uAEgig0/o/KRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730566456; c=relaxed/simple;
	bh=jqtfqcDozTYMQzjOGe7gtUqSxh4PDuu/Rn5JE1kCsYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mZCUQBbNLeCzq+2iKT6h2+3/lkGbeeJT8pnmdSVd4jyWTrnY5IQHnTDSCWiDYHTeLLN0VNBhlTcjWAREIluUijyE+9ov4sEAC/vzIqhqbUBvD6QvcNqnIcEklXXViF3Ot0xKV/d7AeAKz89W6g9plr3GxPDOqYMpsrN0FH08XwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXglA3+L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea527764c3so65217677b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730566454; x=1731171254; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=QXglA3+LQdT8Q5Kjr7m/cxW9naHt8SY2dhi4+CxBJSiTtxa7OIWppFNN+xI0QubqC4
         oLio/rDTRDaReCw/2ODvlvclJENjFvJHuHvC8xZpfzzTCsf5we5I2oNhG9W0KEUcO2DN
         dbFus9nFrZJKymzLvMzontD7vb/qKmQi4KAgmKPBYKkpv9+ow36JUCgMK7Y5PESfKfQT
         eAkbLUAjwvSF+F2zQ6VGmawptyMCi1eGB+Zx93Gk6UL67DSvAizWgavyMAOX0KZIxfa4
         vQyRySBKDYosFgoDjY+98IIYD8fFVDbEfqkGQCoGWgcOrh2t8s7ZtAfWkqUozI3j4JOK
         J0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730566454; x=1731171254;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=NUlHEee7fc12cShkU5Qy1uDhbGrXEzBGnebsxrfRj2lRoFJtNWi8LvJSp8EuBt7GV4
         J/1k0aAh1iiAOXoy3pBPzql6NRsTiaecsMGl4nKsSCUMadoF7yd0D0G54cKx7tlrHKPl
         gPQZb94yhNZyVyZJPX5jV7HGkChYOxXwQirIGr1xn1S8/L7E7qLTBAVFUnRH2xnuRZN9
         EMgY7MAcsT6Vxltjd0N274czhXgdf0Y/mW7QhLDq1ab3FHWZ4e4JpBk+5VCw6kqzI78r
         EVRV8Uf5CMkg61TW4fW+tzqu6vwEa5d2pK54Uw9mrCIQMx0uMzXdrKpz2cxYsEXZlcEn
         VPmg==
X-Forwarded-Encrypted: i=1; AJvYcCX/yTN0UWC9Pdoja7zalqn+lh6y45aBevsikoruBsHvX9nUpDSNWvkdASYJguEk5I5r6cJXTh0WwxBF/cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx98rQAeBs6zst+5/4TMPDOAcpgDZDCI/yq9hunFa6YcS/a3fG
	QYKxYlmhamfIxYHE0C3pFVk5Bl14y2ZPqY43PAjWxXRiGvFL5tRzwY6ZgBj9aE8UgHBmQ34Dchu
	/OcncbA==
X-Google-Smtp-Source: AGHT+IFq/57/M1dR4TI5sTZFRkJ+7pfYTpS18HTUCeIYozNVMDf4uGtf39Rs8KrRHBzucavqtbOBsbu5v5wx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a05:690c:45c5:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6ea3b88e882mr2411427b3.1.1730566453754; Sat, 02 Nov 2024
 09:54:13 -0700 (PDT)
Date: Sat,  2 Nov 2024 09:53:56 -0700
In-Reply-To: <20241102165400.75785-1-irogers@google.com>
Message-Id: <20241102165400.75785-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v2 2/6] perf trace-event: Constify print arguments
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Capture that these functions don't mutate their input.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/trace-event-parse.c | 4 ++--
 tools/perf/util/trace-event.h       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index f0332bd3a501..6f11ca5513e3 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -99,7 +99,7 @@ unsigned long long read_size(struct tep_event *event, void *ptr, int size)
 	return tep_read_number(event->tep, ptr, size);
 }
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp)
 {
 	struct tep_record record;
@@ -116,7 +116,7 @@ void event_format__fprintf(struct tep_event *event,
 	trace_seq_destroy(&s);
 }
 
-void event_format__print(struct tep_event *event,
+void event_format__print(const struct tep_event *event,
 			 int cpu, void *data, int size)
 {
 	return event_format__fprintf(event, cpu, data, size, stdout);
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index bbf8b26bc8da..084068fb36a1 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -39,10 +39,10 @@ trace_event__tp_format(const char *sys, const char *name);
 
 struct tep_event *trace_event__tp_format_id(int id);
 
-void event_format__fprintf(struct tep_event *event,
+void event_format__fprintf(const struct tep_event *event,
 			   int cpu, void *data, int size, FILE *fp);
 
-void event_format__print(struct tep_event *event,
+void event_format__print(const struct tep_event *event,
 			 int cpu, void *data, int size);
 
 int parse_ftrace_file(struct tep_handle *pevent, char *buf, unsigned long size);
-- 
2.47.0.199.ga7371fff76-goog


