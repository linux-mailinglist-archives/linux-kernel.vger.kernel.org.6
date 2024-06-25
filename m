Return-Path: <linux-kernel+bounces-229406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378EC916F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8AC6B24C60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F420317F399;
	Tue, 25 Jun 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0ei3c/UI"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43217F374
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336413; cv=none; b=UYvuzk8rehuf3fgDxjdnYp1AVFz5olhfhKvw9y7BZ6Kk48u1kQtvyZWRBFOqsXTUfonAUgN+koDtfUD37kGz70yCYWWsgSBLS4WHJ7Rk49CqB7JCkPWhT3VsfeguOluTg1nVeeY0p3Gb15hkbXmSCkZfmk1AdbcYx+EbiLqtm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336413; c=relaxed/simple;
	bh=wyJ+MS1hXvC6jnjDEgOqcoNvRhtG2Ev85ERR2gsbIdw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ust/PAwIUCorTUsBEkmnwwR8Y2xJhniaR08SuergrENbGMIRVnZibmFpKMRsUX0om8SNyC5peHTmw+7sBOzy3YtkwuphI0Ui3E5usI3qMfpyStpFd6UKEgX4DirlSZBAeBBoklj1wM7xArPw6tixv7s/VkrvriumvyRXdewD95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0ei3c/UI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0268d49b6dso11738348276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336411; x=1719941211; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=0ei3c/UIMAsYHLRlrg2JJKlzHWxbzftb+76l5Xgw6d7i9XQExYvIlXurDNw+TlP7Ap
         dVAYUusS/w29wS267str7Em25TSnGCmAkvCMQbQMiehGbFO4u38XXWuPA67UDPi7B0jM
         ESWSnK0DIVMaTaxaevI/r+7EC0JgAphf1qQMV0afsYJ1zQa2y/0P9zt6BcYd7h7QAFAf
         v5ZECPO44npQkb3hqZAz+Uo15QHdyVso9sSt0KeyFi7488Xpw3OMaRCAWGXlBWHTSQy5
         ELTeXHATSz1V3DQ/1dehLe+cBpn6f8gA3WeclWqGO3GtyfT08JxPwWOUNzD5Jf5/aTjx
         pnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336411; x=1719941211;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ygd9VSeBzmgIFn0KNDzBnTE+heYOe9Db6FtOSFvMpYw=;
        b=b+r7EPnO6i6/JA0+zQu1D9Mf4Tl/rMUFYA2uCSuJrpPI/OykjefWv7mB2vRVQsVWb4
         JMBniQp86fZ/no8F23G+NBEFsfTpeTfwhMmYpbo7V/VhLUvvW6JW8oiNHNk4CpYORwga
         8Q8HkLgUQDAiF5cT2yUbxJ1rQ5acEHWap2YffuyH5PpmfuEW02gO/g8ufKlgkzeLb983
         J1j2UnK8LVGz6Q6eu5vGgCKeGykj7j4St6ScR8SCnRWKcec+prQhh4EozNzI+CW439X1
         9MXbEqC72jtiSjTK/keWXVbJx/YgzpRM2i0JwkHa4tJCr9LbKL5a8w3/P/Ip6HCACUHC
         SOFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSLOFHRwRztrfvCeV2H12IJDBEo2HRO/AiRL358JXEtUwNiuliY9M6JTzlJs2vQTnMGhDmQ4xbWQ4pEXkCOlHY77fgmfQRvppcpSN8
X-Gm-Message-State: AOJu0Ywx6/KpYNMvV4d9ZNk16fOS89mKMhW92Dz49+NZBwXOZlyDg/wf
	OphLsADxGvNtKCNWjaeAnRUnN+Fn5G20DU04U59GGyxfZ9aDCcG1obQjiIIZWNFSrBc3UUg6AnS
	+NjiPOg==
X-Google-Smtp-Source: AGHT+IGJqb768geaJ/+3Dza1yAwPrymkaebPJuzakVPlvvTG4c9cKDtVCh89RfUHal9utqfZd1Pqsy6N9wKe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:e02:b093:dc1f with SMTP id
 3f1490d57ef6-e0303edb60emr31284276.1.1719336410683; Tue, 25 Jun 2024 10:26:50
 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:55 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 18/26] perf timechart: Use perf_tool__init
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
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
2.45.2.741.gdbec12cfda-goog


