Return-Path: <linux-kernel+bounces-345245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F60598B395
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C041F25C45
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECCE1BC078;
	Tue,  1 Oct 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMnMk1sm"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395C1BBBF4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760219; cv=none; b=k0vEC8QKll1n3yPtP3kgKqCfPnBEfo/rwQZVDXbMzSkX/9jb8GGQWgltCeWJaBCium35EQb7hrWKq/U2Sa8gC27i57RHe5/PWvhegvSXCwjvFqImQ4vpS4+Lj4vWXh+IDiUaDh48bS24WFO0MP7gDYP5PPvKrAW7f3u1koDketU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760219; c=relaxed/simple;
	bh=3sJTix9+hVyh80kzwiZoBEnIVXZyPC2rJ0LryrXs4fY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Xv+FemG7wrt74zb1vkNv+ezRUiXelC8kOymI1dN2PMm9+tuyIjBymWjpGFxTRWEb52KLxToX/+2McDJytzhapDXUhVEX8+7kcbXHS4xZRI0i+4ZdGQk6pzTdgNDzd7MAZhbza/P945irnCRdX+BLt96sl2CCGfzZTporBqkdQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMnMk1sm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2608234531so5603326276.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760217; x=1728365017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQMGtk6GwbaXhFywRtPjz9CEeNpxRP/qdOj8Kk4AmBM=;
        b=SMnMk1smLogyOYM242/SVzs2VobsyNZJTEKFsFqkG8gFtf2SnfiGSBSAozec8RYtre
         5YfvnsBUDpHfohldhl0l+tFBsyKYeDpVqnc38zoNrkgp2a83Re3pRmp/OMrHK/YRalTW
         WbsaiICN+ZrGfEiREx2zdMlw1WwmWlSShyab/xbVET2HcXhhPbGF4vhlZ9x5QnrIgHVv
         d29Sy3H+djfQvwU3dUyHiLIy6kUkkN5xuRIKLq04LecoIFkJu+/+xs1gyzjAo5O8o8+f
         lF7Wgu4NHytUTlRfH76hAmOSLdaiczcmgRDeOSXu2J9TlVf3EbsVNpneSr299rfqtzyP
         3IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760217; x=1728365017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQMGtk6GwbaXhFywRtPjz9CEeNpxRP/qdOj8Kk4AmBM=;
        b=fL9jmZLo/0ggWp1WUJte/8Jg0phGGqbTPCSiosNimdCjGshXkWhCdfBLH7gZvzmY/v
         YObFssYZo4NRc/jQKj2kDDJLNYsD1H3Vox3B7+3q0XhZpIk92qnMbX1s2gr2zO7mpOi+
         UyxiMAUvcwhV/zOUqtIbL46oH6H21mnA6MD7ERyth0PDKSiZw5R+7lphWktT8ZmXc8rk
         t3sbRxveIv1yKQNmGW6SnmAFkGQOLu33qIwvrtsNhT2UJRKQHguFEjV61tq4vkulw/i7
         heF9FsA6vRQz64NXpEGibgs5CelPTfwnck4I0zAPyAJM+Ai+kUuUm2L9jS7AJGMIelXd
         3tsw==
X-Forwarded-Encrypted: i=1; AJvYcCUBhQDdyYF0nFLFBephg9gqwGYrbPY9iFNCQZsVhom1FwKeBSZyiuUZvlApSYoM3Z9LFVHkmqLcmT261uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+L0WgiuDuIOl+3/5o1htKX2ouxWO0gDl/uYPNAmCwK7JAho1N
	flhowYGAp4/aDdma7Kew4w95EwoyrgqqEZtt+TOAeYA9e5sz7g3WKpf17e8WK57S8eI1qv2fjDu
	7y48sAg==
X-Google-Smtp-Source: AGHT+IEtJ5iHDU4WG7YqVYSBmkd2+4f6hQoz49uFn7BXq4j2kS3RcFmOmtpe5Dixo6yM80mfjOYYyRnT+UeT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a5b:f0e:0:b0:e11:5f87:1e3c with SMTP id
 3f1490d57ef6-e2604c8b9d5mr55878276.11.1727760217150; Mon, 30 Sep 2024
 22:23:37 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:25 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 2/4] perf test: Fix memory leaks on event-times error paths
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These error paths occur without sufficient permissions. Fix the memory
leaks to make leak sanitizer happier.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event-times.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index e155f0e0e04d..deefe5003bfc 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -126,6 +126,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 	evsel->core.attr.disabled = 1;
 
 	err = evsel__open_per_cpu(evsel, cpus, -1);
+	perf_cpu_map__put(cpus);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -134,7 +135,6 @@ static int attach__cpu_disabled(struct evlist *evlist)
 		return err;
 	}
 
-	perf_cpu_map__put(cpus);
 	return evsel__enable(evsel);
 }
 
@@ -153,10 +153,10 @@ static int attach__cpu_enabled(struct evlist *evlist)
 	}
 
 	err = evsel__open_per_cpu(evsel, cpus, -1);
+	perf_cpu_map__put(cpus);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
-	perf_cpu_map__put(cpus);
 	return err ? TEST_FAIL : TEST_OK;
 }
 
@@ -188,6 +188,7 @@ static int test_times(int (attach)(struct evlist *),
 	err = attach(evlist);
 	if (err == TEST_SKIP) {
 		pr_debug("  SKIP  : not enough rights\n");
+		evlist__delete(evlist);
 		return err;
 	}
 
-- 
2.46.1.824.gd892dcdcdd-goog


