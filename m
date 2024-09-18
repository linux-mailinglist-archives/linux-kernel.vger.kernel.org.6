Return-Path: <linux-kernel+bounces-332988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868797C1E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E220C282B37
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01334179970;
	Wed, 18 Sep 2024 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LR3nFthj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F216DEA5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726698682; cv=none; b=LssHjCmV0uekKAHsMWygaxvDZrCXCvI2Euqz88NDdHeDmjesHI82iCjJ7LOK4b254g7uicPaqb5wF3iWjisqqomw4BajloKU3+18Rzhs0MTh8Nuf1P0IKs8PBEfw7/9jwM0kEnhdXJHPvQ+lnCPQ9ek8AtXQC3NJwM6yyEqIl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726698682; c=relaxed/simple;
	bh=IUjiHDKQHx81MlKCsICvRhcoKva7+fvwpy12714dQgk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iDeXEp4d8CBKj8cyZNtxmJrMYwApy9dUi0i41jKEJ4DEv/vMOZEbb35N7TGd6FAxplG4tKEHoYhsBE8ohlDZKaxdA9lYxUQB2lSQkN29hg/MxGmOKT4WSlXkA//rnt2YhptRUa7OcGB6AGynCdHNryfgIUNrmvKz1J6GIFhGMUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LR3nFthj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1cfb9d655eso444636276.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726698680; x=1727303480; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2o26eYKFIy4j4OcCh4X158KxqMBJxnfBtjyjzMK/+FM=;
        b=LR3nFthjl8fu5Xw29fT2V+XBTr2jq2d7rtMrk2o6sSXX2MCIfI5j4Cc6RV+1MLEEp+
         /RqfuMgnH5jQE5jCiSgNJ+aHm6bDrgDwYnzktpUzfyGAdhZ7TQ/HvtIVYEWOddIxsC2m
         vQFpMzNk1qda/UcgTthLnGyfXo9hGvqK2QxPxbdkbVY33TKuygzQM76tA8tdg+M/Ry9k
         NkKMpQ2y4njH9epjmk75De16ojYOR/eDe1LTaNnGa0Rdtkoqfm6960+w4g6CJ2xd167W
         uBmtIbLyousNutNwJxsImnSvi3ZzSJOAZM5EUHo8+k/CbvXqfTjREJrVkTIoqyHjFgmq
         P3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726698680; x=1727303480;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2o26eYKFIy4j4OcCh4X158KxqMBJxnfBtjyjzMK/+FM=;
        b=X/0+6nLc8VwP4WTQ8ZlmwAyGm9xXmnX81UcaKy5zw9iphAAsJMUKyVxmwGCJoZZ9Ym
         vLSppkydVf/YerHXRVukc4fpu+RGyGwGmIoLeOHHYBK0TokJto+XLRPWS6a8bk3uYWiy
         h3DRFID8AMTheLgBOH2Az5yezjHoxqC4kWUPNCFP2nXJmIEqW9iw/XvxIpICLW9ShzI6
         OqUfxjUqiuf7XAf9m43YjzOGcPJ5QRjGRts2bNSx1uLpBFoDwSx3GmpdlbcO+S6/W7GN
         H7Mul/xnR3W6OQ3vRhemTie+0fKuNTZactmfqxoXbxDuMYZt5DzUkTlONHoWAa/1GtQ/
         sHWw==
X-Forwarded-Encrypted: i=1; AJvYcCX9uEKr2twnnwZdU8E3o8pt1rqZ4vKZ/4OPtLUNTWpIveWP5Oee3L9LNnrmE1+57P9cQtdiBolRd6jcADY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZj6+ugMF/muKvx3Jo4b3fnUe9bHpiEqNUj0/zS4OxHQWm3HTO
	L82ROIL6yHSbx07o9rzd4EhQqHxVgsSHQdFX7lY07P7NM6pOPLqW5Bl3ufmKjJYj7gtWE4h3HfG
	pWvRPPA==
X-Google-Smtp-Source: AGHT+IG/eNQi1SAlUx74EwwOpKn+0X40DoLJQtlS2A4o1ZGW3YtPJNHIr+ZyNtZtVuHFpKP9In8U3+jEHQRq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a25:dfd7:0:b0:e1a:70ed:6ec9 with SMTP id
 3f1490d57ef6-e1d9db8c019mr78265276.2.1726698679956; Wed, 18 Sep 2024 15:31:19
 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:31:16 +0200
Message-Id: <20240918223116.127386-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v1] perf evsel: Reduce a variables scope
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In __evsel__config_callchain avoid computing arch until code path that
uses it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5..f7e829e96599 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -862,7 +862,6 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 {
 	bool function = evsel__is_function_event(evsel);
 	struct perf_event_attr *attr = &evsel->core.attr;
-	const char *arch = perf_env__arch(evsel__env(evsel));
 
 	evsel__set_sample_bit(evsel, CALLCHAIN);
 
@@ -893,6 +892,8 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 
 	if (param->record_mode == CALLCHAIN_DWARF) {
 		if (!function) {
+			const char *arch = perf_env__arch(evsel__env(evsel));
+
 			evsel__set_sample_bit(evsel, REGS_USER);
 			evsel__set_sample_bit(evsel, STACK_USER);
 			if (opts->sample_user_regs &&
-- 
2.46.0.662.g92d0881bb0-goog


