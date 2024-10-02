Return-Path: <linux-kernel+bounces-346962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6461898CB76
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EDC1F22A3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155FAFC0A;
	Wed,  2 Oct 2024 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DcSd1WeI"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5306618B09
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839232; cv=none; b=IiMU4wQgGUQfQ8w4OCb4cFR2RcvBURaaxJv69uhFHV8v06y53rwPAAvR3u/eNFmuUVNn5/3oQTJjZ9PN8QG9nAZUZ5g5zqbJxFyNVRjXak330lsitWNK5l6ONWeAq7PrifaW+QcudG8ZwwQEZ/6v9cEXbUzgMaUSAOyST+9/13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839232; c=relaxed/simple;
	bh=pbd0mtz7VbHTf9Txoh97J1oZDoDP3tqW9zIloce5NSE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=L1VX0CtDFjqPTNOJRFlwJU/AaGH2qa+qY+/Y4frcAShu813SJ+WY9I7IM4iG1JUYXTUZ9cYEM3vrH91lx5y6YIMqQPkXjxrA3JprTf9uK8tKOZf1MB4NwsG6+swSh2PwtKQhAxXXKlK/rf2wD1bT12a95QsUkLH2s1znboNYKfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DcSd1WeI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e26046ed465so7631305276.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839229; x=1728444029; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39T+6noF1HDYHixFiWW8nys9E5rCFMsxZqBd3BPaByY=;
        b=DcSd1WeIoaya/OLsqKgxKzHR9cKxv1Y1LoQk5xOPveRM1fGBMyKj6a2syWAkylpENC
         9A4cGNfdrjW/XK29IMJTwj2RL6RWrOkeRZvoUdM8EXtmUaAVZ8oAeNcUbWTLxb7Mi8K8
         srDZAPM7vUoPdmcS9RNZPOdQrVkqITbjcCyFGawJN3qhRsfTyeIxDWwfmXpIJNT1QHTa
         im2x3faWIeF6B0zpL88amoFuURW3qA0P6aC9BApVaXaAU1zyHyDgwZOzB8iZ+9il7Vr5
         xmfW2Hdh0Fclp+tRRDvN4c9/N3UkfAqH7VZpPXSxqgO1tqtyV7O76GDUVvTnIUxBX0Be
         NcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839229; x=1728444029;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39T+6noF1HDYHixFiWW8nys9E5rCFMsxZqBd3BPaByY=;
        b=k5x23qBVII8XpLc7gzRKKjMawF+IsDXqETLihuy4q6O313PZILz46QzNGjLnmv1s8q
         juxDSMzBzOpnYrF8Hq1rVLzfzchYWoOTtt/fj53mn/lzh8iPbMWiZBoNAQKJCR0Sg+Hb
         I5S6bzgINcP63jGPynE9Kj81TCCymCWKEpIcG+l1BpFcjNWd6aytjgICXI6+7/Smsv2j
         Ke1q8wBiL4/MDcxEY7c+r/AaTtz9cPb/CMIy4omj0mYDU8wyOYLtlZZhRBkydOZ55haI
         s99EnTKrghRU0r5yT0FG+byMHXvn0gqPyl89UuscwxDgyZQyLySHYJImbe/ziRaTBj5V
         EUDg==
X-Forwarded-Encrypted: i=1; AJvYcCXbEx9Hjy8haPr5mwqqHXjwMyB7Bbwtyrh96+9ITzLcdAx+dePhbsm7sM1uxmEpAbswn8/KPXm6+XiKR94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tS/8q6BGJt/jQhEAkCGKLRhplhMo9IiTA0MQ6Ngs5YArvFhB
	vjqvBu28KUXhoIXvnDulSvjn8sKq56KlMYTedyFBXyypDz2yZJkPtFZUwoMR2i1Jt8gdHcZK7tT
	Ise5Vuw==
X-Google-Smtp-Source: AGHT+IGGXpz7W1T1yyjYa2QLFOERmH1YOJwoLGSUEPWG+E5FM/tlDieHSEHZd2aGX20w6HMLgZUOd0Zysatg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a25:bc8d:0:b0:e25:e5b9:8114 with SMTP id
 3f1490d57ef6-e26383e33d0mr5567276.4.1727839229299; Tue, 01 Oct 2024 20:20:29
 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:06 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 03/13] perf parse-events: Expose/rename config_term_name
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Weilin Wang <weilin.wang@intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Ze Gao <zegao2021@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Expose config_term_name as parse_events__term_type_str so that PMUs not
in pmu.c may access it.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/parse-events.c | 20 +++++++++++---------
 tools/perf/util/parse-events.h |  2 ++
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6ae611e70fae..228ae469d44a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -800,7 +800,7 @@ static int check_type_val(struct parse_events_term *term,
 
 static bool config_term_shrinked;
 
-static const char *config_term_name(enum parse_events__term_type term_type)
+const char *parse_events__term_type_str(enum parse_events__term_type term_type)
 {
 	/*
 	 * Update according to parse-events.l
@@ -886,7 +886,7 @@ config_term_avail(enum parse_events__term_type term_type, struct parse_events_er
 
 		/* term_type is validated so indexing is safe */
 		if (asprintf(&err_str, "'%s' is not usable in 'perf stat'",
-			     config_term_name(term_type)) >= 0)
+			     parse_events__term_type_str(term_type)) >= 0)
 			parse_events_error__handle(err, -1, err_str, NULL);
 		return false;
 	}
@@ -1010,7 +1010,7 @@ do {									   \
 	case PARSE_EVENTS__TERM_TYPE_HARDWARE:
 	default:
 		parse_events_error__handle(err, term->err_term,
-					strdup(config_term_name(term->type_term)),
+					strdup(parse_events__term_type_str(term->type_term)),
 					parse_events_formats_error_string(NULL));
 		return -EINVAL;
 	}
@@ -1134,8 +1134,9 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
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
@@ -2582,7 +2583,7 @@ int parse_events_term__num(struct parse_events_term **term,
 	struct parse_events_term temp = {
 		.type_val  = PARSE_EVENTS__TERM_TYPE_NUM,
 		.type_term = type_term,
-		.config    = config ? : strdup(config_term_name(type_term)),
+		.config    = config ? : strdup(parse_events__term_type_str(type_term)),
 		.no_value  = no_value,
 		.err_term  = loc_term ? loc_term->first_column : 0,
 		.err_val   = loc_val  ? loc_val->first_column  : 0,
@@ -2616,7 +2617,7 @@ int parse_events_term__term(struct parse_events_term **term,
 			    void *loc_term, void *loc_val)
 {
 	return parse_events_term__str(term, term_lhs, NULL,
-				      strdup(config_term_name(term_rhs)),
+				      strdup(parse_events__term_type_str(term_rhs)),
 				      loc_term, loc_val);
 }
 
@@ -2723,7 +2724,8 @@ int parse_events_terms__to_strbuf(const struct parse_events_terms *terms, struct
 				if (ret < 0)
 					return ret;
 			} else if ((unsigned int)term->type_term < __PARSE_EVENTS__TERM_TYPE_NR) {
-				ret = strbuf_addf(sb, "%s=", config_term_name(term->type_term));
+				ret = strbuf_addf(sb, "%s=",
+						  parse_events__term_type_str(term->type_term));
 				if (ret < 0)
 					return ret;
 			}
@@ -2743,7 +2745,7 @@ static void config_terms_list(char *buf, size_t buf_sz)
 
 	buf[0] = '\0';
 	for (i = 0; i < __PARSE_EVENTS__TERM_TYPE_NR; i++) {
-		const char *name = config_term_name(i);
+		const char *name = parse_events__term_type_str(i);
 
 		if (!config_term_avail(i, NULL))
 			continue;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 2b52f8d6aa29..ac1feaaeb8d5 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -168,6 +168,8 @@ struct parse_events_state {
 	bool			   wild_card_pmus;
 };
 
+const char *parse_events__term_type_str(enum parse_events__term_type term_type);
+
 bool parse_events__filter_pmu(const struct parse_events_state *parse_state,
 			      const struct perf_pmu *pmu);
 void parse_events__shrink_config_terms(void);
-- 
2.46.1.824.gd892dcdcdd-goog


