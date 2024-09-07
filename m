Return-Path: <linux-kernel+bounces-319641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDD2970019
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC331F21D9D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906D149C55;
	Sat,  7 Sep 2024 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLCa+Nip"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB29B1487E9
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685732; cv=none; b=Afeh1iwG/P0iyBgf09ZK1IF4sRTrbbKVUqQIbUU4xm//wQZUGZOV3H3no+2BTS4xwTM11kMHI7O0cDXUMfdocYP/Na0FIoFS5RIQSf0pMBqdYqN7oiuJRY9WFyUzXr17fMDhJo2po0SmLtpzbS1JGqJVsPl2VmprQ+Cs3rImO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685732; c=relaxed/simple;
	bh=HkKh04X8D6J+bMpYJGXztyOf9L9ngWoa7v1G2rn5Oi8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IaD7SaMWa5QL3rTMGcl32+awuwcvRXltOHpMeVc+mVMerA19Fu1wYi69O5ug7O4Gg3/2Sx/hv4NXpgUUN8IynoFrqXzh4x3x8rWgpfoSOBGEJuhFCyBCd3biLnr6lEiLRLFHjTv1RR80woVihvppvtc/sM66Qo0zxQrYHLMbJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLCa+Nip; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so6487900276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685730; x=1726290530; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QKvA61WwO8WManIDEry3xBPvYjCmgFaen6iyvj8dmS0=;
        b=CLCa+NipwramntTlpL4SbzoTMVP8F8LgejlnIN3w5Ju9hGCndXTEvx9os8Q11ia926
         H8HRkKH7yqOUr3C0zh/I5MTr3nZ/SRsNhWncqq1SQ/uD8Oo5bdLz8LGCv8ptPpogN8qy
         Hm2LD+7OEYSB9hSdG25tMhDKgnqjvj5d0vU5o4gga4AVgakBuAhWIY4gfFL/X+V7tjxh
         ktWJQihx41SZIZcXDcaxUhWI/tXCVqTjwilLdNAy17a68wSFEKPTxCKOhYvPB+MNb6HR
         /GH2BvpVDP4/f4RA0TxEa53nDlEG1M16sJ1By3ivSLTevEitf+qdh18OoHof0sR1iVMz
         3h8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685730; x=1726290530;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKvA61WwO8WManIDEry3xBPvYjCmgFaen6iyvj8dmS0=;
        b=m4gY4P9F31dwAz4SN6lAjOsxHmLJHiQBOK0y3ii6/dxlSvzLiOy4nI4G5t68Tv/tci
         kjYKrXNyC+t8AOM0ZaDL/zREt79CUo/XxACwR16i+y3EifvWXwR4sdlhlEvfTAy+F8if
         4ABxlURjcVbN9ReuZjT8NmoMspfWdf8rqbHzFToBQiFVuwwbiT0O5t8schHfHBUN7IMN
         mS0lp/EudduUIW2L9zg1fXnyZ2uUclDrZg++K5kYdqvEFls5eeR2ASjzOZiFrK8wn2Mn
         QHTlk2O9jmE5k0A07FVXfF8+QYds7vKw+3pT9tgQuKXOIMOVETB/nB3HZINnGbb/RbZJ
         8y6w==
X-Forwarded-Encrypted: i=1; AJvYcCX8Mbok6sosRhaq2vFlJWGXxAyW5drXRMBOSOO33HJXEj/drK6XTI3U6vi9CeLlC0fXwBqLXBNNaccAI9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6eAjAieMK1+Swkc0zFq54pU4CQXfQ7A3+CEgx1rHOQJXScwZj
	Hd10qamZJgJ7leiunjIvRB5EBSOMhIgtgSzc2fKb+KTUUE9RUOA4ylzXOM+O/ikdaamJlF5KtgD
	gz6dR1A==
X-Google-Smtp-Source: AGHT+IF7UBKTi9sJI18dojLizpBg3DhTO/Azd5rIjyDI4e7nelFwAEZSFGGcydoCgyKhtL3urTmxhEGBxaKF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a5b:6c6:0:b0:e1a:9a4d:a500 with SMTP id
 3f1490d57ef6-e1d34a1461cmr7217276.11.1725685729619; Fri, 06 Sep 2024 22:08:49
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:19 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 04/15] perf pmu: To info add event_type_desc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

All PMU events are assumed to be "Kernel PMU event", however, this
isn't true for fake PMUs and won't be true with the addition of more
software PMUs. Make the PMU's type description name configurable -
largely for printing callbacks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c  | 1 +
 tools/perf/util/pmu.h  | 1 +
 tools/perf/util/pmus.c | 5 ++++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 50e2e7abffab..72bfc321e4b3 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1857,6 +1857,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct perf_pmu_alias *event;
 	struct pmu_event_info info = {
 		.pmu = pmu,
+		.event_type_desc = "Kernel PMU event",
 	};
 	int ret = 0;
 	struct strbuf sb;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index d6f702e55a05..4397c48ad569 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -194,6 +194,7 @@ struct pmu_event_info {
 	const char *encoding_desc;
 	const char *topic;
 	const char *pmu_name;
+	const char *event_type_desc;
 	const char *str;
 	bool deprecated;
 };
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 864cbfa1f960..93e5c0435ee0 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -371,6 +371,7 @@ struct sevent {
 	const char *encoding_desc;
 	const char *topic;
 	const char *pmu_name;
+	const char *event_type_desc;
 	bool deprecated;
 };
 
@@ -444,6 +445,7 @@ static int perf_pmus__print_pmu_events__callback(void *vstate,
 	COPY_STR(encoding_desc);
 	COPY_STR(topic);
 	COPY_STR(pmu_name);
+	COPY_STR(event_type_desc);
 #undef COPY_STR
 	s->deprecated = info->deprecated;
 	state->index++;
@@ -498,7 +500,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 				aliases[j].alias,
 				aliases[j].scale_unit,
 				aliases[j].deprecated,
-				"Kernel PMU event",
+				aliases[j].event_type_desc,
 				aliases[j].desc,
 				aliases[j].long_desc,
 				aliases[j].encoding_desc);
@@ -511,6 +513,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 		zfree(&aliases[j].encoding_desc);
 		zfree(&aliases[j].topic);
 		zfree(&aliases[j].pmu_name);
+		zfree(&aliases[j].event_type_desc);
 	}
 	if (printed && pager_in_use())
 		printf("\n");
-- 
2.46.0.469.g59c65b2a67-goog


