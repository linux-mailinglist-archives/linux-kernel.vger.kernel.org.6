Return-Path: <linux-kernel+bounces-345244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6FD98B394
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3BA1C234C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 05:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6611BBBEA;
	Tue,  1 Oct 2024 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulbduHJ/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5A91BBBC5
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760217; cv=none; b=EBe/ysKJ6ktPrBI/eDXlggbOx/QCc5IGEldrv1s117yBNjffyc59BcFs++OufyASxZ+aa+VrCilk+8Ed0dKVLGtfLLWYvdvhfOP7ET9Z566WjhYykwvlmu5XV5JFtGNsTXZkQGQvtwXeG8v1uwf1tg1peP4vyCPBnc+kq5cDpLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760217; c=relaxed/simple;
	bh=ZUl/ydmmbgHj875SzIndORvnGh+y4tgIfETJAN0I7XI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XeAH4q1aqHq5EThyjUzLFx7ky298qmQyjUu1SLfEE7exwJoSEYhN8OeIpIMrwAddULnw2XXbF23IXcm6soEl9O/+7PJFwftbmjfFnwT5pGcMsCYRskFB8lEfR/fM1mkDF4RgTthKV4n67Tbo4FjZ8pjP+5VARq90XTHCTVqSScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulbduHJ/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e251ba2243so45336207b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760215; x=1728365015; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pDg21Rij+IIeZQVgaa8iBgfJqI0jYu+y1eH5S/MzuI4=;
        b=ulbduHJ/YD3gYenUUioMqMmR4cekFVaQV1Uf6FCxQkke5xPWADyWfI4ut6MpciTb5f
         EU8SFCfqGFPL6FE2YW+D7OPtw8UL4+cNloNkffZdnS659RE78dCLukcZswSYuDEVkr5I
         5BEXO26RPUu+2KcqRpmJ7NicQS7f/udwCbggW/hNK+0SR3x4MHXgiIrmv2WXyYbWsQsy
         GhQcA+QoTF40Il9GduV29QReZ6MeKKUw68miDByEVo64szcw+AXyZ99l5C0EfyZsB3oP
         aHsB0TgDz0wX0vUtH/1XjPQjIaCwhG7uZHeYSo/ito7AjOHcFXqQAX86X62KuMC/EZss
         oS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760215; x=1728365015;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDg21Rij+IIeZQVgaa8iBgfJqI0jYu+y1eH5S/MzuI4=;
        b=jfIKUQ+CKSokB4xpCW7IHQ1lZhHZHFeWkXZePetTBrtOQQGjZcQAjKFP0EfC9cFGB0
         eHlnPBTFwWX6zbrUQQAezAj7L2CD75CbrPUcZ6ypS7rS1/e+e+8SR/Q6Xad11TJAOpyZ
         VwmdqLuoClT8vnCR8r3Ebb8vXgvxyzJt1zI1eUq6d0PoGGlkjON8HGZwz58XDviQp4vC
         vNLAhr0rQW3PVFVK9wjLxyXv7FNbRPSQMBg93w+M1ME9xpUrV//ds+2bRAmi864MWik6
         V2mOrja7t+EdXtUICtDjtasyEXhMu7YOz4ne/FUFRiqeYDA58glM6cjhSF7Tw80k3IuA
         LKwg==
X-Forwarded-Encrypted: i=1; AJvYcCW3fnfH8wVgIkW6IbtXJ3OMu1/rXVKoo38nODAyaMHQDxY22p8yjtHVIIGP8B6EuW30vo7ym4/izBcfzas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVaNy0dbFz7NnChwRC/nnLO2oZ4y6e6RdQckLWJeoCcI51SgCe
	iHtiaB3N+iYKTkPT/nkvX6UqRIGdRjP3vxBNdH1yEBuaTqhzadohIuVAYMpLsOFr+4nHIuwNel1
	5ymOMyg==
X-Google-Smtp-Source: AGHT+IEePI86EHzO2lKFHMUhhhibUrr1ifCWaWS9m6yGJmNtyzlTdWvIyNugozYcmICy9rbCctLESW+kX90s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a05:690c:23c2:b0:6db:d365:19c0 with SMTP
 id 00721157ae682-6e290eb5dd2mr581447b3.5.1727760214866; Mon, 30 Sep 2024
 22:23:34 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:24 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 1/4] perf stat: Fix affinity memory leaks on error path
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
index 1521b6df2606..3e6b9f216e80 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -827,6 +827,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		}
 	}
 	affinity__cleanup(affinity);
+	affinity = NULL;
 
 	evlist__for_each_entry(evsel_list, counter) {
 		if (!counter->supported) {
@@ -965,6 +966,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (forks)
 		evlist__cancel_workload(evsel_list);
 
+	affinity__cleanup(affinity);
 	return err;
 }
 
-- 
2.46.1.824.gd892dcdcdd-goog


