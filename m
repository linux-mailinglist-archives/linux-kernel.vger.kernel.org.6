Return-Path: <linux-kernel+bounces-327101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023329770FF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821DE1F21334
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18127DA6A;
	Thu, 12 Sep 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ZRW/bG/"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900791C1748
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167839; cv=none; b=SYi/ILRu9saHjmlgvZgQrW0Ok10vK9d8yaNdvXT5YvEslfSnpIlkhQ7fwiNxlqaordX4fzNGSfMbyiK3XNezBXlnlDtgYsajYdxTSQD3TIg4MM9X+g9nJCXGHZckY6H8FB27fQHLzpIEntjZoHqKCGx0S37J8qV57LWCsl3OFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167839; c=relaxed/simple;
	bh=Vk535oLjOoVnV6GXf6fF06oFHm6U/y8aVOQzLJgw0ks=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=eEpXY2A6MONhdxGaEnoZiv0iaWzCU0PI3AmEQ6wZjAJUVTrF1d/HiJJdOshQCXccDJIKfJOrCB/MtP4fT/XByoAieGczCd5dNgJteqk+5nube1+x6+R4vchwYGlmk3DDivfh2TvdR5Ir63CVN4AgpBVkGvwRhrboSf+H5UHqrvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ZRW/bG/; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d3aa5a6715so3278617b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726167836; x=1726772636; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nv46Pxr4RqOiUfocd6lnckQ6oaO49PAAJVzHx2iL/LI=;
        b=3ZRW/bG/1Kw8xpkWQvAb16sItUCWyMDKtgP49iwFKFUsKbz+1B9+v7BMkv1IFenJpW
         g6Yn9kAV+NEMzhNDIS4xe4mtzcCNosjvwiOwRuLlulNiPv4MrM6kZI4Ar3RFexGC6T/J
         PoQDyFN36QKXsiHLtY0fNgnNJod6X21R6v4a89BgB73b4Njuxrh5ZYA+zknt8ULxAw1w
         fxJICM72+Xu7LC8S3gEypNkulfNf4C74WVZBIe2nSiQZ4rgeeiIb0sEYC6Hfx46/3Rll
         9O72V5uX6BaDms5KFH44TZ9x43xBDEGyT/8WsFkyaRN/dSVnbOj3rB9Z9+7LVSATmzF8
         QczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726167836; x=1726772636;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv46Pxr4RqOiUfocd6lnckQ6oaO49PAAJVzHx2iL/LI=;
        b=aLIH1bJF8gDLl6Hrwhh1Hf3acFpV1bMWNt7KNKerHrR+ODRCXH3byPXQ2xYi9ZkQGo
         4s+3NrKQYhP6IPLACY15dLg67swBlkMin9KkWH/efdRF1gRVPhGPUmmqhTAO8KJ/v4dt
         8+x4ISzf3hAh0IDW/8MAdT2FGZ9XYfqmUg1ZMSgKJNmgzSwqQxnnP8SQlNBJPquAn5sL
         oEiQ5EHkCRDl9kAFL1htWj7hJzSPYKZsPZ9yv1QULXYBl3Tgk7ZK/LFrEB+y8hcyL3pU
         Nlchxvm+Euu0COR5crHO6Pufn6t8PDBP0UOA2o3c+TcLQEokhVdI5ArsYjxP7baVxkVH
         Qs9w==
X-Forwarded-Encrypted: i=1; AJvYcCWIE1YpbWgjE9Fyi06oRlyooVLRoruM5clDJXOy4P2MVsuMGP+wiX0P8Vnp7CXcatBsT60ggKzqzFFVvnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCFc+8cyjV5hdZaAgIiyx9DNs3iJszPtcDK+95XHAy31ab9kVQ
	6Zfi3xWTpsYsR6wPM+AsGOzkOE1h4z9CEJPGh9uEQ08cck7C9iNM0bzKNdupbEmEx9nj3OySMHW
	ZeEjQRQ==
X-Google-Smtp-Source: AGHT+IFHO09bW2w4OpHfnI1mvLyMuz+jqvEx61veclezxCDRJ5X1P4hSJYcP6uZSfsVCOzJE/dx5n6NbJdWI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cf0e:7a99:e672:3862])
 (user=irogers job=sendgmr) by 2002:a0d:c641:0:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6dbcc584e0emr97147b3.5.1726167836594; Thu, 12 Sep 2024 12:03:56
 -0700 (PDT)
Date: Thu, 12 Sep 2024 12:03:30 -0700
In-Reply-To: <20240912190341.919229-1-irogers@google.com>
Message-Id: <20240912190341.919229-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240912190341.919229-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v2 03/13] perf parse-events: Expose/rename config_term_name
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

Expose config_term_name as parse_events__term_type_str so that PMUs not
in pmu.c may access it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 26bbc6f603ab..776812460dad 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -794,7 +794,7 @@ static int check_type_val(struct parse_events_term *term,
 
 static bool config_term_shrinked;
 
-static const char *config_term_name(enum parse_events__term_type term_type)
+const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 {
 	/*
 	 * Update according to parse-events.l
@@ -880,7 +880,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 
 		/* term_type is validated so indexing is safe */
 		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
-			     config_term_name(term_type)) >= 0)
+			     parse_events__term_type_str(term_type)) >= 0)
 			parse_events_error__handle(err, -1, err_str, NULL);
 		return false;
 	}
@@ -1004,7 +1004,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
-					strdup(config_term_name(term->type_term)),
+					strdup(parse_events__term_type_str(term->type_term)),
 					parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
@@ -1127,8 +1127,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
 	default:
 		if (err) {
 			parse_events_error__handle(err, term->err_term,
-						   strdup(config_term_name(term->type_term)),
-				strdup("valid terms: call-graph,stack-size\n"));
+					strdup(parse_events__term_type_str(term->type_term)),
+					strdup("valid terms: call-graph,stack-size\n")
+				);
 		}
 		return -EINVAL;
 	}
@@ -2568,7 +2569,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config ? : strdup(config_term_name(type_term)),
+		.config    = config ? : strdup(parse_events__term_type_str(type_term)),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
@@ -2602,7 +2603,7 @@ int parse_events_term__term(struct parse_events_term **term,
 			    void *loc_term, void *loc_val)
 {
 	return parse_events_term__str(term, term_lhs, NULL,
-				      strdup(config_term_name(term_rhs)),
+				      strdup(parse_events__term_type_str(term_rhs)),
 				      loc_term, loc_val);
 }
 
@@ -2709,7 +2710,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 				if (ret < 0)
 					return ret;
 			} else if ((unsigned int)term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
-				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
+				ret = strbuf_addf(sb, "%s=",
+						  parse_events__term_type_str(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
@@ -2729,7 +2731,7 @@ static void config_terms_list(char *buf, size_t buf_sz)
 
 	buf[0] = '\0';
 	for (i = 0; i < __PARSE_EVENTS__TERM_TYPE_NR; i++) {
-		const char *name = config_term_name(i);
+		const char *name = parse_events__term_type_str(i);
 
 		if (!config_term_avail(i, NULL))
 			continue;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 10cc9c433116..bbe6c5700828 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -162,6 +162,8 @@ struct parse_events_state {
 	bool			   wild_card_pmus;
 };
 
+const char *parse_events__term_type_str(enum parse_events__term_type term_type);
+
 bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 			      const struct perf_pmu *pmu);
 void parse_events__shrink_config_terms(void);
-- 
2.46.0.662.g92d0881bb0-goog


