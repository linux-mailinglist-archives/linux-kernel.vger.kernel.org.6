Return-Path: <linux-kernel+bounces-249662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05CB92EE4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 422501F221E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B817A5AB;
	Thu, 11 Jul 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oY5wAVSY"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F78179957
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720862; cv=none; b=WKdW7WduM0G80kM4P4nw8GmUdHF/b2fd87zgcc06JFYCkSCvUcc3408sbRkaVQQAf+BZir71Lk217wAnMjXXHXc+hqbH/82S+RbipYsoJ0z7doATHFFb6Xq1XZ1Sqp+eZhU2Z/cpKAahe/pShD3qqFsbDb6fbvvB3UuhS5FRS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720862; c=relaxed/simple;
	bh=ulxtdrULVFXHxSwGu1u6ejOo2/3AvfXoc6ANmm1gsuE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=hCC5zPjFUVTfXd6SscrqEh3P95KN94sz0nzmUxh3SnBzT+WyyKiib30+psM+5mfAH/2ySDgfD237YMw5LBW/fVrBBWgXI0MyjzFDvptF3nsh+XIPVCUYVbI9jbUfUsmpwr8abnS+XCGOb/2dsemKeinlU/WYCLVNON5OxkxKxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oY5wAVSY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6501bac2d6aso13428847b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720720859; x=1721325659; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=30wTiCp+NVIhDTuqUvYj4YUy4HL96R/Tpq22ji595AI=;
        b=oY5wAVSYr8CgW5eQIgnVB0RZy+wBrReOOpsBcJs7qimpREAuhJHWIQ0ENgNWuE3uC8
         tl7iOx1zKbdJzb1fA7ZpoGWqbUyhZDltDVb6DWzCXKEpHdKRLHkw7Zd70vyRge2z3dp2
         skYZikwwpB2xHePvmwZKPolbIFUDcvaFR5poZKJhKPW9QL0qyzrAptMszPsDd/3ESyta
         0HXkE9O6nKUmOTIlqF63hjrSj/3p95473n6AWEbfLq7inqVT4XoogrDxyoGdbB8s4qy8
         bmhHNzn/GYG7Lz7rd8B3cf4vkAcA+2xKwci1iaObPWs4rcuB4rs0xSlQEX7HIZhRAcZp
         qxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720720859; x=1721325659;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30wTiCp+NVIhDTuqUvYj4YUy4HL96R/Tpq22ji595AI=;
        b=JCU1vJ1JbUembimer5p+lOmShu+ApIMsteTaLgliEf7Slw1OBkEKtY3zG4/8BirQtM
         w97t3ANVGDbGq6Xi2cOZQo2A8WYlUOTw8ctVcpmIPrIS/57UpqetDpYhztxBfyaDp8NE
         aKbGHQrNoqUhZddlGu2kcmJdEv8IRgwH3DRdI/bU8Wna7qo1yUAo/N/DXpg14QpM6QJs
         VyjT8GOf9U9u4TaZMeH0JbrlEtJ9gcE504sKgR70kvhw+O9E6YK0TDUCNiO7Iwnf6Igc
         zqT1ysEoeLXAm8BFgc3thsnTJWx0QRTcNtH77hwgnRGNEP/yPkz0bD3Nr3pScUCdfUuU
         no1w==
X-Forwarded-Encrypted: i=1; AJvYcCXKrkVNbJj5rYYT7gsegL5PJN+eexvJKeb6bgLx2rUXywnK2IcRK56fXtmpcdnIedqAUqeAwaQpcXcQV2AbUnF0h35SjNlPokwxgmwF
X-Gm-Message-State: AOJu0Yxh3RCArNObqQzI5RFFRWEuzGyQMEFH8KebMwdjOGzS1B3bu45T
	fAOYSKX5GOERpXMkArEzIvtFQH/2no/oPqrr7JkKAmRWlYjV1G9cSfnRpS7SNWTr/ZR+vqfWEqM
	8DRInVQ==
X-Google-Smtp-Source: AGHT+IFZpTMg4BQB94SCXas1IM8Xhd/IszdibFEMqZP5+uba0vWSTxmY0iKOvfL8EAF9shV0sCKOMUKx0Nvd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bd08:a1e0:c497:32db])
 (user=irogers job=sendgmr) by 2002:a0d:ea49:0:b0:64b:a38:31d0 with SMTP id
 00721157ae682-65df50b328amr15297b3.4.1720720859459; Thu, 11 Jul 2024 11:00:59
 -0700 (PDT)
Date: Thu, 11 Jul 2024 11:00:01 -0700
In-Reply-To: <20240711180008.188906-1-irogers@google.com>
Message-Id: <20240711180008.188906-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240711180008.188906-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v4 21/28] perf timechart: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-timechart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 5bf818baa662..218c8b44d7be 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1606,10 +1606,16 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		.mode  = PERF_DATA_MODE_READ,
 		.force = tchart->force,
 	};
-
-	struct perf_session *session = perf_session__new(&data, &tchart->tool);
+	struct perf_session *session;
 	int ret = -EINVAL;
 
+	perf_tool__init(&tchart->tool, /*ordered_events=*/true);
+	tchart->tool.comm		 = process_comm_event;
+	tchart->tool.fork		 = process_fork_event;
+	tchart->tool.exit		 = process_exit_event;
+	tchart->tool.sample		 = process_sample_event;
+
+	session = perf_session__new(&data, &tchart->tool);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
@@ -1924,13 +1930,6 @@ parse_time(const struct option *opt, const char *arg, int __maybe_unused unset)
 int cmd_timechart(int argc, const char **argv)
 {
 	struct timechart tchart = {
-		.tool = {
-			.comm		 = process_comm_event,
-			.fork		 = process_fork_event,
-			.exit		 = process_exit_event,
-			.sample		 = process_sample_event,
-			.ordered_events	 = true,
-		},
 		.proc_num = 15,
 		.min_time = NSEC_PER_MSEC,
 		.merge_dist = 1000,
-- 
2.45.2.993.g49e7a77208-goog


