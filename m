Return-Path: <linux-kernel+bounces-393201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519D39B9D95
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873781C213BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4382315C15A;
	Sat,  2 Nov 2024 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UAHPCXOV"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221D8158D80
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 07:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532180; cv=none; b=cP7RzBcY3P9z4tBfk4q5B2bBEpqK1hNt1wKJaxm0XuAO0sNASITcFqYqC7CrDmm2SzRmw2THiyKivaGC+e97WwhMafeKCVH5NEdkCyvKDrjdF4IGZ4T34mA6kv+tI0WLULNKZTHuTokZaolF3rIXi5RBdw4ixbpyHTW4j+Iy3ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532180; c=relaxed/simple;
	bh=jqtfqcDozTYMQzjOGe7gtUqSxh4PDuu/Rn5JE1kCsYM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=t75tSc9JSF1bvnVtLNg11XTZOMHDlyd1MC0gBXtyHLGHV/ckNfYC9w7aVatdgdQFdh2L0Rla57XiUXYO/dT6i+ypmIogc7NCTtoD+KKzFKOyZyPnlKiqpkF6spb30+uMgfbgIycYzmqe/074WSJH0oF0Up0LgS1zyo+g8AbUnF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UAHPCXOV; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so4999635276.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 00:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532178; x=1731136978; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=UAHPCXOVQXv2u6VmhYmd3iNDa6dFJJlTgYtGmYg5laZ/470imMKuCMst7YvCKSyVBY
         TlKA1Ng61B40ZehgggGZhxCfvY3qsPJz8/Z/tKKx+FRg+qVlR41ejTgmHE8gY5/xUHo6
         9wSQtgCOM22ELHsE8FUAA/OYEyRfIFsQfYnyphkS5Uk4/LW/OP5anvFbpBjtpoD5etCQ
         cZedC9i9A1XgZlup1df4ilJSdB64bdYau+2pB0YqZYpxmGeyOkSqYDf9ax9tHcrtVYkb
         mFRRRN4061TSnOe2DzI2Rl2uQNmRk3ySxO1CWy+idRVNICwweN43MUr/sHSmHlwqWJNw
         1C6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532178; x=1731136978;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmeR/ooJwGRf7dfAO7pFQRGOg67G8nX2zbSdm6KkuuA=;
        b=WxQDPwDrbS1Xc4xtC8VJtUPW2UoywxrQoYisKsLXK3Gz284Dvg378bY6J6PpeHyIu/
         5inF2nuPvkzssH4YHeYOKvxOVqW5MdWGiVv8P+LC3imkiyb0p5EiNVp4Xpo8mrSqZp6s
         ZpEj2516hx/QLsrq5VhzcoRUUnA0Bo79Q+R5no7ryfPlDbZBfUsDZBvbGq3gBBAqGC9X
         DnQId4ePU40tQTqxBfC/s83+NYEX8t4M8x09W4ZPazh9vgn5Kn23AylHk3NZfzWYvGxb
         KX5SfzSJCYA9GMa1MjWVwK7EziWw09uSG/TbWxHXVA5wVZxzony2fq11PIefJ+ZU9U+V
         8wvA==
X-Forwarded-Encrypted: i=1; AJvYcCUxaS4kOU98fMU8WEdMqoW1yv8PmpHcZMXXVLim5nSzhwjZuANJfsF7h7/bj9YuO/CBvQBsmfcrhrn3XGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykg0P/DC4ey20p7s3A0lCyeLrfMkLfd5lRS15BVL/c9NBspoPZ
	TXYNFyJdLR+dQcTVPu4k8+OXcxQJfvPBlIB0CwAAdfOw0EI2Rr0rQ07H99EYglhIEd+wn/b/0iO
	GWdLNcw==
X-Google-Smtp-Source: AGHT+IGqNYDJGcJcBslQGiLIgr1hpmee2pkGHEX7lgSwjZdA4gYXA5a6NRHoGJ8pve8HiBofxVjagJwDuvaT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a25:26d1:0:b0:e2b:d0e9:130f with SMTP id
 3f1490d57ef6-e30cf2e9c2bmr9944276.0.1730532177579; Sat, 02 Nov 2024 00:22:57
 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:44 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 2/6] perf trace-event: Constify print arguments
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


