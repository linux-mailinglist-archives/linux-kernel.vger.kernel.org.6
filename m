Return-Path: <linux-kernel+bounces-185511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9338CB608
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4B0282FFE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 22:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ABD14A4C5;
	Tue, 21 May 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kqZ0cTw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5414A096
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330973; cv=none; b=AWXglpRUkx04xtH95Eb7ETcHhXEIitqRWeXE9cL5cF299bMIuynwQpnjvnmFyxozCD2mIIvATPTyfSDIw67Uzd79H7iGxLoBFhHwTrzZUttD1m6tY+kCZU/SbP4/L+0VhfP8oMYJgg+7Qg3c9/EgWmXObioUhqg6XLophgxC5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330973; c=relaxed/simple;
	bh=QGxpTjj48GaRZSK2/CFDsNhCOvq+ZWj3YumGS/8jXG4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=MAo2faSkuroveAlfxqdSeZdyjgPgPDBESirSaAyxN1yYmqNyUMiumtynEcJdUYTJueUFPPWXMIjyTpke8BigENn2YHzjO3eWeGx9vOl8Yp6H3TmFovOysGm6PUFozubzEnQyBhccjCMwiTb7BWj2SUNJMnCE67lwgxjXbswyUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kqZ0cTw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61beaa137acso223509687b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 15:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716330970; x=1716935770; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9zyIB32Gej4Re6et8G9BG0IxjoKckxZsG/WVrAIAd0=;
        b=3kqZ0cTwUbRa8xe09xpufrt+jkmksHq6ZaAaz3hHuGTx1h/MfwzqjBVOe53aykf0Xg
         701SKr4YGcveVwy7Lzl9Li3vGyY35Gs9kfigAhXvB9c8n0qTpfsgl6kU9H2Kf0Mo3rsw
         NF3uv9zf3PnqDZc/c5khXrzsIrHZ6PacHAKDg2jFIduio2OfPno//PjZ7o+emJoQCYtk
         uJbZqw9KQAg94eC1ICxZMjtarf85KT/eN8Rtlzhqz/u9XcplNhjgirmphb2eLURsjFsG
         33debaEk1wstCu/ZS5U5IAsf+h9lSZWdVvxhHcS0navEgeVQGi+qhZerf8samge2ci2m
         fdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716330970; x=1716935770;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zyIB32Gej4Re6et8G9BG0IxjoKckxZsG/WVrAIAd0=;
        b=TWCZqk4CRc2mN7mAur0Da2QnnTLxMW2kh+24hifF1hVnQnL6Zqmf3gj+qWAQKeo/Ty
         3JRrn88/G6W82zMh9GQEDo3d2DdEeTtR2OW/M1wzNlDNVUJZujEfBalWvUce4OgaVA8H
         5KUonNV/76379yQyJq+u1ICtHv9Hrnm0u5ycO0IGt6JBISQ21dZGD5yf8hCn9pfi1j9N
         sX9jr6funw8IjKCcx4mr3Fz2skftY4J80WX5gXjca8ALGbee8SnRAjkdMJna8vB3yaqM
         fkkQhTn1cGdfSeHgWfUgLUZmeG6c245ppLGx1ZAHXkjv/THPMDfuSkxPP/MVK/cvkjos
         j3MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkEs2S2Unq0rv5c8a3N0Xqetsl4fgZitlI0VEGQRfFi/oaQxZHKp6px45lSNcFM1op4BKFc0BSi9itNJj+xQwDYLDQiUUgLpO2VIqJ
X-Gm-Message-State: AOJu0YxQiGtj49RfIUW+zjq/bbMP9IY+1LGd0yDvC91Piao3tFslsRvP
	Reef+eyJvTKSlODGdmCqzqaNCprxXaTncYuJIptzZRyiAADRnr//tRYgx8JBOyEWRSahLRs1p3k
	FeSHakg==
X-Google-Smtp-Source: AGHT+IFr46OKHqb1Gmau3FlOjnj7rKv/zTGU6S/NYdxkSQ+SlZLP0lYKMlzndTrTXDAiGfJd5nYQz59RGoWn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6953:f69e:7357:3598])
 (user=irogers job=sendgmr) by 2002:a05:690c:fd0:b0:61a:b2d4:a3fb with SMTP id
 00721157ae682-627e48a51d6mr988177b3.8.1716330970640; Tue, 21 May 2024
 15:36:10 -0700 (PDT)
Date: Tue, 21 May 2024 15:35:55 -0700
Message-Id: <20240521223555.858859-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Subject: [PATCH v1] perf docs: Fix typos
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Assorted typo fixes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-kwork.txt  | 4 ++--
 tools/perf/Documentation/perf-mem.txt    | 2 +-
 tools/perf/Documentation/perf-record.txt | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-kwork.txt b/tools/perf/Documentation/perf-kwork.txt
index 109ace1d5e90..21e607669d78 100644
--- a/tools/perf/Documentation/perf-kwork.txt
+++ b/tools/perf/Documentation/perf-kwork.txt
@@ -1,4 +1,4 @@
-perf-kowrk(1)
+perf-kwork(1)
 =============
 
 NAME
@@ -35,7 +35,7 @@ There are several variants of 'perf kwork':
         perf kwork top
         perf kwork top -b
 
-   By default it shows the individual work events such as irq, workqeueu,
+   By default it shows the individual work events such as irq, workqueue,
    including the run time and delay (time between raise and actually entry):
 
       Runtime start      Runtime end        Cpu     Kwork name                 Runtime     Delaytime
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 19862572e3f2..47456b212e99 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -21,7 +21,7 @@ and stores are sampled. Use the -t option to limit to loads or stores.
 
 Note that on Intel systems the memory latency reported is the use-latency,
 not the pure load (or store latency). Use latency includes any pipeline
-queueing delays in addition to the memory subsystem latency.
+queuing delays in addition to the memory subsystem latency.
 
 On Arm64 this uses SPE to sample load and store operations, therefore hardware
 and kernel support is required. See linkperf:perf-arm-spe[1] for a setup guide.
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb6..77578c0a142a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -311,7 +311,7 @@ OPTIONS
 	User can change the size by passing the size after comma like
 	"--call-graph dwarf,4096".
 
-	When "fp" recording is used, perf tries to save stack enties
+	When "fp" recording is used, perf tries to save stack entries
 	up to the number specified in sysctl.kernel.perf_event_max_stack
 	by default.  User can change the number by passing it after comma
 	like "--call-graph fp,32".
-- 
2.45.1.288.g0e0cd299f1-goog


