Return-Path: <linux-kernel+bounces-175283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8788C1D98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6421C20D68
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989EF150994;
	Fri, 10 May 2024 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhKEHf6b"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E65548EC
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317994; cv=none; b=jrPWbiLSM1nX8nD4LlYvGtoJSW3CMMKt7EMSqHZuHOdI5NJUOgj08iGYBOLVQnoghT+EfSaM5OlORSXEbwXHX6yV+Jh2QQcE0b7dw5EAUlxbxC/bT1HAjc9NM0gIM9RRWp6Pw0b2BB0TfH/etrTSIK8YA257Mugou2duGb9IgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317994; c=relaxed/simple;
	bh=2CSSuDANH+DI3ZSn1/F+R7LCv62bfHS4CcN1mcJHHl0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=CaiqX0ivNrk5RJTxcX5xjv294jxFH6oMWsUX+mSkjsQpZjwQZ/+hmbfqNaTkc6vq7iNExg8JACZU45/V2WnsaUFGiDUgw3fG/cUuI/G2cJUaSFEhrxS/oSguCuBDE3k0SbHfZ3/HK24EZ0CizW/VrmxroNDnOceo8FCN/OFnE4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhKEHf6b; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6dbdcfd39so2949535276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 22:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715317992; x=1715922792; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OKjQVp3FAUgk+ze053pkAabzKwTqf9LXD3i69ugyhcQ=;
        b=BhKEHf6bd0kN0LlV9WIEzc2zpWFB3f95GDz68qlfhx996R9+2nnU9+xkWni/2P2ksc
         6ly3W/+dYZPL2sAao4imnuu87oliWZFLmqUQcjdAVyKpAa8HiEK28+bIBu723yDmbJ34
         oQV8QDTcDOCFrodkRlcFzN6rrr9RMBwVmmoJPLP5WwZmO/bufTqcRTYsn8asfsU9zNZK
         wwGPIogd3i9pis/OzZYI2FZfgUkBlSKxZhcFRFB5Leu4oUml9OvLW5PB5ALcz/cyV/z6
         W21nlvvn6sSroVoZWfLsQiHfw2xGcZnKSp7rY9jFAmR4Dm6znrGPrjVuM+ZneKrE1Wui
         snCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715317992; x=1715922792;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKjQVp3FAUgk+ze053pkAabzKwTqf9LXD3i69ugyhcQ=;
        b=qAjafST5hAFcL3NZWzVF9hPerlq3youXW7X9ZPg6hznXpMoKwZ5e5L9yC28Dxgjiyq
         fwSSMahf61MW1VTxnUREO4FPb5bt6Vw8ND3JlboMFTo0JF0/caNcJhA1cMh33n6sASF3
         e8tUha/qx4k56sNocix1mySDQ/09u1vb5mRhYfaI0CvXVOXzxG1x6LMlyp1eOhBk6t8c
         AxNWtTtKmwG+AOWXifMLEMEvpcJC+tkUGpovz62z8CPItd88+XUSaQtSXIPn4mZpjGIv
         PywnntUi2AgO0967fuCf1khu41W6JFZ7eGrbO3qormCruBsAa5W4nTiFS+29JV0vdHEw
         eWQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm3rlg2ommGaNQZyhh32uNcW+W+mNk1tjoXVLRrJyssqyPgHukeZjWRegJAvR5x10xDdQVRTM9nxzg72XCtS682cYzxQfJ4+xkGTr4
X-Gm-Message-State: AOJu0YwTrE6WH/NKZePYb64JIPwixCitqZN9dBb2TPROJGlWGU36WKOD
	OJWnLvRJF1TSk7Lp4G+SgtMiSCF/cWWxGu2m/WDNigQl8E9CTD86pb3i6CjOookPSvtxeUV7caB
	kS1t9Dg==
X-Google-Smtp-Source: AGHT+IEyteZvNqV/b2Tct9YqzW6qTIA83prGM1x9o7/VX+ENGd5xhTev2l0+eI7qtwOmojAY0zI1cu7QxLHz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:79ed:c375:51e3:ed39])
 (user=irogers job=sendgmr) by 2002:a05:6902:1081:b0:de5:53a9:384a with SMTP
 id 3f1490d57ef6-dee4f53a18emr445869276.13.1715317992474; Thu, 09 May 2024
 22:13:12 -0700 (PDT)
Date: Thu,  9 May 2024 22:13:09 -0700
Message-Id: <20240510051309.2452468-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Subject: [PATCH v1] perf stat: Don't display metric header for non-leader
 uncore events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Kaige Ye <ye@kaige.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On an Intel tigerlake laptop a metric like:
```
    {
        "BriefDescription": "Test",
        "MetricExpr": "imc_free_running@data_read@ + imc_free_running@data_write@",
        "MetricGroup": "Test",
        "MetricName": "Test",
        "ScaleUnit": "6.103515625e-5MiB"
    },
```
Will have 4 events:
uncore_imc_free_running_0/data_read/
uncore_imc_free_running_0/data_write/
uncore_imc_free_running_1/data_read/
uncore_imc_free_running_1/data_write/

If aggregration is disabled with metric-only 2 column headers are
needed:
```
$ perf stat -M test --metric-only -A -a sleep 1

 Performance counter stats for 'system wide':

                  MiB  Test            MiB  Test
CPU0                 1821.0               1820.5
```
But when not, the counts aggregated in the metric leader and only 1
column should be shown:
```
$ perf stat -M test --metric-only -a sleep 1
 Performance counter stats for 'system wide':

            MiB  Test
              5909.4

       1.001258915 seconds time elapsed
```
Achieve this by skipping events that aren't metric leaders when
printing column headers and aggregation isn't disabled.

The bug is long standing, the fixes tag is set to a refactor as that
is as far back as is reasonable to backport.

Fixes: 088519f318be ("perf stat: Move the display functions to stat-display.c")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea11e3437444..bb6bbb821b5a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1251,6 +1251,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
+		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+			continue;
+
 		os.evsel = counter;
 
 		perf_stat__print_shadow_stats(config, counter, 0,
-- 
2.45.0.118.g7fe29c98d7-goog


