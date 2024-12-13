Return-Path: <linux-kernel+bounces-445569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A879F17C8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDD4C16C330
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9271946A2;
	Fri, 13 Dec 2024 21:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qHJyB/z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B25192B86
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123876; cv=none; b=na2emgqPYmvaa9rYOeMwIANjTg4ZzcWHjQZCgWxxd00lhODEXiBHrAyzhq1YaMkG//B2QYGOsIHucHtZz/vzjJWR9XiEivDFj70PXAceplBMVOrwfi9ptM4wNss6YlcTCH/TKDU281hQBLpGwJbNsyOy9HhLEV8znPQID0Sh/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123876; c=relaxed/simple;
	bh=S9oJ5nvUyNCQs4RFbbxftBNA4JqtJFj0IOYK/XGlb40=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=tIzyx+uVoPBmh4aZaMLw7HvOuGKjxD3PItGScjf8Y3CbbP/FxnAhoPWlQmVvY9afBfP5DSfWWYLC6WAOtdBOzTKDg1UOtHIY15/8K11zNudTkowpzSVpQPtziYDK5kzH524woFT0q60vCKB5ytEq9g6nmVhzvDGsYryCRtVow78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qHJyB/z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef4e426a3fso20029327b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 13:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123874; x=1734728674; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNAmP2QIXRRPXgUvgn+lR3CXU9fGdjYzcf/lM/XtA7E=;
        b=2qHJyB/zv4Oyn0C4mqJFE9mlyfic4e2cQ0tlgxsGa/qQ7gXdd7os3eZ+PUP8rz0BQA
         UslPypsbr1ifJMqZuBzYJtJo56yW3n7DMdkFPbIPHh7IQ8hCZaNRVsl4X8m1yBeC418T
         JS4Ro+OVSPjOnLcC3sJC7xLIUrwHZe1Ip7/n65Lrf+IyH54dYv2xVCi/k0P6PxkeJlo3
         RWENxBvr3FN/4ZOSkPTyTD0srt1VmpHl/Z6rz4P2vAIiNRRY3TZHi7LvQ0N8KNZxE5Om
         hRyZAFqsG7xvbhyzDzXAnpN9EoiEyPpl3y2Dik3nlJ8kf1YHXrv+YWVZlfcEolphossg
         ViXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123874; x=1734728674;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNAmP2QIXRRPXgUvgn+lR3CXU9fGdjYzcf/lM/XtA7E=;
        b=PDA1u+Sy3zrvwboS+F3qqCZrj6Ii/Fnh7xu2hWqnpmYJyf4wWxqp1FhTaQbf5aj8Nd
         WSBJNd6DWLjrD99SD4kJN2m0R/py7OENOpCi4jiULiP+i4gMS92PATUdXmyiWCTcxn7D
         uGiSgh0tAiYDwrkbNW0tWXccDM2icGrT0/Uv87lPa9lDR8ItDmrISF2z+IbnMiVNrOgg
         at3Ik1njsvxODNWQo2UIyyhGyXxZcnYRPKeEY8MByTzgQoE6IFIUl+XQL9xBSprL1fE1
         SjpZxhUewcc1VpXgcEYg170L7Ikox3u9fk5Ex4Fas7IRXCqgnP+B2Xk13p3qrJC29UL8
         wdUA==
X-Forwarded-Encrypted: i=1; AJvYcCUGo+uh8TdPSsY81K54FTfeCgjIUY9xFXQ9RhMLBeuUvwSBk5tnHdu2TQyMmI206EqOgcAXXfBDd5GnJSg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HicgYoN451YR2WPEuOnHh0aRtmC0S0wAkmXp5H58omCeET5Q
	jDDxFWqXkEjiml3b8dqJL51kXHVLNFE4w6v5M4yM47u1hXhGeZwKzx1aeZMIuC38Onwy2aEz2uN
	PFimuQg==
X-Google-Smtp-Source: AGHT+IHQnJ8AwzFR+/gCmsmiNG9OlGzkCbBAFmQ5ZaR8gDuemwKOAK/7yUyedwJUi8XDw10fkhpSLVZKmo8q
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:2008:b0:6ea:1f5b:1f54 with SMTP
 id 00721157ae682-6f2798ef726mr136197b3.0.1734123874200; Fri, 13 Dec 2024
 13:04:34 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:18 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 1/8] perf disasm: Avoid undefined behavior in incrementing NULL
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Incrementing NULL is undefined behavior and triggers ubsan during the
perf annotate test. Split a compound statement over two lines to avoid
this.

Fixes: 98f69a573c66 ("perf annotate: Split out util/disasm.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index 2c8063660f2e..e8e7a8257007 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -389,13 +389,16 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	 * skip over possible up to 2 operands to get to address, e.g.:
 	 * tbnz	 w0, #26, ffff0000083cd190 <security_file_permission+0xd0>
 	 */
-	if (c++ != NULL) {
+	if (c != NULL) {
+		c++;
 		ops->target.addr = strtoull(c, NULL, 16);
 		if (!ops->target.addr) {
 			c = strchr(c, ',');
 			c = validate_comma(c, ops);
-			if (c++ != NULL)
+			if (c != NULL) {
+				c++;
 				ops->target.addr = strtoull(c, NULL, 16);
+			}
 		}
 	} else {
 		ops->target.addr = strtoull(ops->raw, NULL, 16);
-- 
2.47.1.613.gc27f4b7a9f-goog


