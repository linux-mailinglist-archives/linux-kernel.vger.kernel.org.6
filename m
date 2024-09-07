Return-Path: <linux-kernel+bounces-319643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE497001B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F991B2378A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7497114EC5D;
	Sat,  7 Sep 2024 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSmLK2b6"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98914B967
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685736; cv=none; b=Wtvu5XalEU3s65fu4QCYeCe41RNftaqMPMcx5B0wcA+NuvFYXsdGcdloVwaZ7u8dplf/mZUfraXkQKNBkuF6/9x8TxQjDEkAsUQJcdNJ732xZqb+uV8m2J5ZYzOgCThtqb3fMU8qGWoD7B0ECRTV8WobTWtvRqf6fUnDmPUh14w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685736; c=relaxed/simple;
	bh=4cOZXSssGH5UHbeiNemyHw9AfNWWkQY3k/4vv6r+rYg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YZ2DuYnKU4zL1gyqgJ3RctnI9T8GMb5RWbiCFTcl6QYDUUyEO49UeFZtnyG+ZVNVUMm/7Vvorw8Tx/z9OTDQ5070Kc7AkHWFVguS5s7QFh7mDlrpFLVXkG16qyCfkhBv8S6xMCcB4h8bZYnoFQzWbvMlIK6yBZp8d8wROM+6FEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSmLK2b6; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d4f52a4069so102144067b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685734; x=1726290534; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K446thzmdZyY//9ueXzoZapLMwoJZQ44b1S89B5s8Ac=;
        b=rSmLK2b65RgRfYaJ4UToZO3bKX/CB+Ymaji0pJTBk8tYPPNMqmSx5C7wcdkVoQCeEK
         MjMOxjCfQz/2HAnKZg0y5JZKYnn/+WhF+O0rIE/8O/t1bVojmihm0s5LEHGPPwJ5LB3A
         v99qizbQAU8A5xJZ2xUg7zT1MNjfVYyn7tQHgyYW2hi8Qf2Dc5kvEVAI42nqpDpOiM8h
         VAwrQXLUbT6dUA97Pf2MSZP18HzfItTmoURaPoKk4uuIYrf8155mE62v1qlO/v/AxPfv
         JJaZltjAxuqZdkVOnzgQk6MrQtttlToFl6t2bt8DYYHzpadgRFsV7p6xK7Pr/aWCaI5b
         qPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685734; x=1726290534;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K446thzmdZyY//9ueXzoZapLMwoJZQ44b1S89B5s8Ac=;
        b=kixvyTuHintifW4TtdHDBHJ5NXSo7Zvc/6M8Wk0bnw1YxJDqMGGvYULj1tdlenAH+5
         VmQ8DH0QRAAjxPiX0fmiX+TsN8Xt14uTlXKf94u9iL8HYkT1u4z/RDddcZVwlEMKLoPm
         1MmVw+opxc8ouNxcRtFsV6S/pAPTXy7R87UIoSHGcynCXS1K4Jffmurhkpg0LTVPKNK4
         J9nI1pyCsWHC+mon1GWuALA0owacBVGXQVEulcClfgT/xUu0ItDyKvRubBV4QZ2t8Mic
         rV9qDClZKDAcxWML3tEWP203WzjBF2nDISTbTaz5x6JTm8XM9HDTvmNOGzX6XV7+bSYn
         VXGA==
X-Forwarded-Encrypted: i=1; AJvYcCWLvufsZK92GxWNn956ga7HBww0W+U9uihFfTSjctnvR0dzhLlPU0xveYYXEh7mLD3NJuhIJRprPN1Ylls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5hclhrTJExJoEgtwDpsY8Y2x0plpXT1b3RjXzH5E9ddlEU3KR
	uNze5xT4+H5ZjY7Jmg27D5Ia00aJyPTZhQRhPtcaCvs6K8HS5g+yn1yBtUG+LVu2OHrBFKkRncf
	xTz79Cw==
X-Google-Smtp-Source: AGHT+IG5ulMeYZYI+0rmqtyIoRb8/mTAk4z4SLB4POy1XLmQNC5TMS8PJhGseVM70zE/iZ51QJ2+nhNJuJxc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a05:690c:b1d:b0:61c:89a4:dd5f with SMTP id
 00721157ae682-6db44a5d1eamr3228967b3.0.1725685734285; Fri, 06 Sep 2024
 22:08:54 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:21 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 06/15] perf parse-events: Expose/rename config_term_name
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
index 30b78fe8d704..b68a744f41ba 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -772,7 +772,7 @@ static int check_type_val(struct parse_events_term *term,
 
 static bool config_term_shrinked;
 
-static const char *config_term_name(enum parse_events__term_type term_type)
+const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 {
 	/*
 	 * Update according to parse-events.l
@@ -858,7 +858,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 
 		/* term_type is validated so indexing is safe */
 		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
-			     config_term_name(term_type)) >= 0)
+			     parse_events__term_type_str(term_type)) >= 0)
 			parse_events_error__handle(err, -1, err_str, NULL);
 		return false;
 	}
@@ -982,7 +982,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
-					strdup(config_term_name(term->type_term)),
+					strdup(parse_events__term_type_str(term->type_term)),
 					parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
@@ -1105,8 +1105,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
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
@@ -2546,7 +2547,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config ? : strdup(config_term_name(type_term)),
+		.config    = config ? : strdup(parse_events__term_type_str(type_term)),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
@@ -2580,7 +2581,7 @@ int parse_events_term__term(struct parse_events_term **term,
 			    void *loc_term, void *loc_val)
 {
 	return parse_events_term__str(term, term_lhs, NULL,
-				      strdup(config_term_name(term_rhs)),
+				      strdup(parse_events__term_type_str(term_rhs)),
 				      loc_term, loc_val);
 }
 
@@ -2687,7 +2688,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 				if (ret < 0)
 					return ret;
 			} else if ((unsigned int)term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
-				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
+				ret = strbuf_addf(sb, "%s=",
+						  parse_events__term_type_str(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
@@ -2707,7 +2709,7 @@ static void config_terms_list(char *buf, size_t buf_sz)
 
 	buf[0] = '\0';
 	for (i = 0; i < __PARSE_EVENTS__TERM_TYPE_NR; i++) {
-		const char *name = config_term_name(i);
+		const char *name = parse_events__term_type_str(i);
 
 		if (!config_term_avail(i, NULL))
 			continue;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index bfbf391451d9..cf3f07db0295 100644
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
2.46.0.469.g59c65b2a67-goog


