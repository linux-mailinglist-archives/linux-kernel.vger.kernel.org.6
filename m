Return-Path: <linux-kernel+bounces-346960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F65E98CB74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92EC3285AF6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D401754B;
	Wed,  2 Oct 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FFzNJevI"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747CDF60
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 03:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727839228; cv=none; b=PNcD4ImUTsvt4uunqUb509n7A3JBcYkqA4sZ1Lsxpm6sZi+LwNc/O1GwOZwwFX27K1rEjz2uHyBDaFlbgHYwMv73ZaqG/broPK+GFnDbY3dvx6lk17FRUhB9OtohG0wRT5vpXVoZO1K1hnUxQYhFy+jG5tZ36VIyQWOgAgeC3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727839228; c=relaxed/simple;
	bh=Z0h5c1P0yeBhm5Am9G6JjbqtoJL+eQh4PwduChMZ9UI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dp8SZUjDvKoXCTLbh9A6aQPvIR1AI0netow+K2KGRTsB3YWRPZpXRTTT0dvw5SXb9biylJfrg14GLYxGtRVJINtY7dbcK+jSaPAIAr4PmPJtguZfGHntDGNjaIbik65w8QbVT81lpVePkopbmWm2pSt9InTBDKcsThLygKBiNc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FFzNJevI; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e29b4f8837so6536397b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 20:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727839225; x=1728444025; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mlqVBWAOpVfJanfv4s+m+V064r/fmGnZe909uVEp74Q=;
        b=FFzNJevIRBYbarn+yFm4lSAD+eH7A8qZ1d2QYfz2+J5ql6DsrGvrYC/8pQYqSjXxZT
         67wXoeEstlxnvePIEb7R0cX1vt9+MRJUTpEg5M5ZHnPEua54k9kIIqNb+mLgjDNasUUI
         9XN/0C63fwMhHbZDx0EVqA1Xid6FpX1yQ6uoDY08kN5zGrtrRlfjtjIVdRNOpno8Sa4A
         rr1E4QHQUbllEJDXK8J3Sl5uVDGUvwt44nwbdPHHP7xc/Aowk5ZOKXvR7PeS+g/9tdUA
         IPzslAqmeKFdSF4AEo1JlnvcC02+NP20Z7j3Gx0RJpA44y/FXT3sr4M3+HeK26VDMAkC
         PJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727839225; x=1728444025;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mlqVBWAOpVfJanfv4s+m+V064r/fmGnZe909uVEp74Q=;
        b=V/hw138SX4NKtL1FAKBhGeM6967LnwstBY0xdtvBNdZZOgH5LXpKkZ8I25l8ITzHGO
         q1Hk6W+Yv+Xz0HbV683eM8vmJovFu38e5j4oY5Rr7iuMf00XjpMZL0lW37NTtkFnAUha
         fe9MgCh7oOG9ek/5fYkikWkplSvCpc6I3FQvHcGf+MnUWcY/tw0H3MX+1tMlszj/E37K
         SqeVDHCdKe7TEZYha0tb77Y2xudiLUeVyH5ub4eO1N8JPAoc6RZQwQT9Xq4zAJZwZ9Vl
         tGd47A3bJ1XnFhHUBvJT7VhuEmetq/HFd+KMZSGLtARpmEq6jLbDz1AcC2KFcCGv4OAB
         t7dw==
X-Forwarded-Encrypted: i=1; AJvYcCW749efeURbGECsgnazqEoKWrWH31EwBWsUW6nWy8X/8rxHlIa0nC24IiJjd2SP64hJ3wI+kDeLn25OyEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7sr2pVAC2En9UX9Ol3RnKIs4IwfTVqTGxm5a0TUbDEO5xy3+A
	aMWKVdTkR5qK2D0XEmXePqR7VdNm1BJLbXQRk3uiGzPQv7uuSsB7euK/5o+yfA26j2QI5CKtiZF
	9CinGMQ==
X-Google-Smtp-Source: AGHT+IGzuGaCwhO4F5RbpJtWD80jojIRLpMbMtUnTcgGgB1r9Jr5pkreMHPYLvjuBmCRnD7/UJ/Wuc0bIOVS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ffa1:6d00:2acb:535f])
 (user=irogers job=sendgmr) by 2002:a05:690c:64c9:b0:6db:e464:addc with SMTP
 id 00721157ae682-6e2a34b7328mr410007b3.4.1727839224568; Tue, 01 Oct 2024
 20:20:24 -0700 (PDT)
Date: Tue,  1 Oct 2024 20:20:04 -0700
In-Reply-To: <20241002032016.333748-1-irogers@google.com>
Message-Id: <20241002032016.333748-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241002032016.333748-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v3 01/13] perf pmu: Simplify an asprintf error message
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

Use ifs rather than ?: to avoid a large compound statement.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8993b5853687..cb2eb2407de5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1466,13 +1466,12 @@ static int pmu_config_term(const struct perf_pmu *pmu,
 		if (err) {
 			char *err_str;
 
-			parse_events_error__handle(err, term->err_val,
-				asprintf(&err_str,
-				    "value too big for format (%s), maximum is %llu",
-				    format->name, (unsigned long long)max_val) < 0
-				    ? strdup("value too big for format")
-				    : err_str,
-				    NULL);
+			if (asprintf(&err_str,
+				     "value too big for format (%s), maximum is %llu",
+				     format->name, (unsigned long long)max_val) < 0) {
+				err_str = strdup("value too big for format");
+			}
+			parse_events_error__handle(err, term->err_val, err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
 		/*
-- 
2.46.1.824.gd892dcdcdd-goog


