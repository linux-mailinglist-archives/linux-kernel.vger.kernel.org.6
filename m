Return-Path: <linux-kernel+bounces-337596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDAB984C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EABBA1C22947
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB413B783;
	Tue, 24 Sep 2024 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuUNo6/P"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A86B126C0D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209766; cv=none; b=CYdcMvVrikVqKcXZH1tZj5pTAKueOoDLBoDHhVzOlSKsY0FzTlZ6nSYhoV/HWm+N4QFAkwm+lNOB5C1yesIBdFWTu7jtagELNktHLxbDezL0x6ELJRHbip6VAzz61jVxXwDzw2ItNc6+BT5Svxq8u+o4Cd/TAy84iXKeqJ7T/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209766; c=relaxed/simple;
	bh=mFjhdQiwvR9CAqZB6ZhikCzrE0gEej86IXDZhFy6CX4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=CF/sqi+pp9aZzvNeZ232mUzQeo9x35F+hGThCS6jBR2uAAo4eWOPaYf4WB8Rz2XxFrp5q/1rpreb7rS5SWPny1W5788Iar/PTX661BtQ1YPkDxZZcHm79w1CgC4B4G75im5r3kjI3WzZg1IKZjFs7SNwlG4u+kDVWZYr/vWvPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuUNo6/P; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d7124939beso91734657b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727209763; x=1727814563; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nn8ECyCmWyPn9tXLc8lNZejR80O62lwdh1iFMAs+Rqo=;
        b=YuUNo6/PE5J24a3sNTFYd1PLvyaEBqttAdNd+BMuK8wCktxAeyPvH8Xtx1azaR3Lp4
         iLzqrkWTvoQhMUCzG9AwrQ6NawDB8ul9sGwm2CxW9SLjLwlnXNFpt1zqNZUUpbDoizrn
         BBYk3WzccCF78jBQwaiw8E9o81WgCaS4iV5GEex0wGToFS5IyRosQelZWH9ZHdEdQyRS
         gOSmyeQ991wBjwfTWBd49Vf0RkHM/tWbhbYeYW9W+QhFCXnhjse92tzdLnrWmNTxqDlN
         90fqjyJqnhn6Erqq4r3OO7b/zW/T7tgF7kBhTMrVULrO8wz5uXYSoJsFa8MM1mWumokK
         X1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209763; x=1727814563;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nn8ECyCmWyPn9tXLc8lNZejR80O62lwdh1iFMAs+Rqo=;
        b=gCjoH3O/A/b1+kvxYyeRpK8qY1RGpqru7ofhjVNhz7g5EelhO/BtH+dDm8wGPUbcIN
         gcUirG6IuiN9MOGUogs6GFhzZvQROCSd955bYPh6CVp58lNnESid0/HIKxaHWRG91e0n
         whoMXeJOXV4jMqUnaAVnVEL/+RD2D/MVZGraSlgskXGfbmIGyarH6DXMyrCaMjVn34ti
         NaAjnUY7w0NLVg1+TLi1GDrHCiarRvdn7sD3Kt6gTLmLCz4a4zBcNzW9gnvzIQ56ykae
         5XMlzmRLhSwSia9UzyXPhlw9SDTF4DNr9l9rS9DwMSvWw+YfrjQpu6ro58o7KLmdti8p
         hQow==
X-Forwarded-Encrypted: i=1; AJvYcCV09dRHKOxABcVEPrPQl9bRCaJKlU0+hiGp+9pvjYikdQjUtmFciv3k6uHyKbuS9+W9OdAt+w/Y0MdqV8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wDNY7QJQdXsX4dtJ7IkZfPo63ulGPoEx+5RRMB6x5rJQ+BgF
	w68gir33XifIzss5zaktZXAcDMHu1gwoHCleeOF5yJUArxMyZdX+4a+yhRjw1CwlWhCyFSG97Qk
	+vmKZBw==
X-Google-Smtp-Source: AGHT+IF9aApUK33I6f+5seodeuhmYm49UBu0r6pcj/qZiBEC6FE68CAKJFmd469r3veH4l1UEVa5sCABPcz1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a25:9c84:0:b0:e20:2b5b:c6e6 with SMTP id
 3f1490d57ef6-e24d9bdb37bmr8964276.9.1727209763324; Tue, 24 Sep 2024 13:29:23
 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:29:13 -0700
Message-Id: <20240924202916.1560687-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 1/4] perf stat: Fix affinity memory leaks on error path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Missed cleanup when an error occurs.

Fixes: 49de179577e7 ("perf stat: No need to setup affinities when starting a workload")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 689a3d43c258..cc55df3ccb18 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -767,6 +767,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 			switch (stat_handle_error(counter)) {
 			case COUNTER_FATAL:
+				affinity__cleanup(affinity);
 				return -1;
 			case COUNTER_RETRY:
 				goto try_again;
@@ -808,6 +809,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
+					affinity__cleanup(affinity);
 					return -1;
 				case COUNTER_RETRY:
 					goto try_again_reset;
-- 
2.46.0.792.g87dc391469-goog


