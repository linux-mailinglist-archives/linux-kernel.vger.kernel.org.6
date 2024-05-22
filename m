Return-Path: <linux-kernel+bounces-185726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA828CB9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8B21C2151D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54C75813;
	Wed, 22 May 2024 03:36:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5765B1E8;
	Wed, 22 May 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716348965; cv=none; b=DbhaQJG7nHFQBUKUnDDUCFlS6r/trevkaATH7z7NeNPT4fwQP+9DYCBu8Fy3ho3iHv3TpwmnvGTL903yYMaUKyHzvYsoGLTeSSvh3XgbhRl3+GE6EC1dmwD/Cg0ryK9c79VpB6E0prX6hV9Wj+N28gqXcxapNoRo7uj/4CNWN0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716348965; c=relaxed/simple;
	bh=zRjS4HniSyauajIjylYLbXjWxv2s24OoOrQ1SnYwpBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ggu4YtWpU88/oYD9F2M8lMM8C2YNSvHieSS7G4540qlFNKJ36t02CzOWMHWDXMYEJ5LkgzHDlk/tCUn8Bo2bhjo12jHBa2iahSCSuhujJB3rgh+WIiMQpYxmRAI58DFpW6cFa/9FICATn+b9cB6ob8t1xVPyw25ddtncf9uJ8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VkcKx2d1BzXnRy;
	Wed, 22 May 2024 11:31:49 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id D2ACB1800CB;
	Wed, 22 May 2024 11:36:00 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 22 May 2024 11:35:59 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Changbin Du <changbin.du@huawei.com>
Subject: [RESEND PATCH v3 1/2] perf trace beauty: Always show param if show_zero is set
Date: Wed, 22 May 2024 11:35:41 +0800
Message-ID: <20240522033542.1359421-2-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522033542.1359421-1-changbin.du@huawei.com>
References: <20240522033542.1359421-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100011.china.huawei.com (7.221.188.204)

For some parameters, it is best to also display them when they are 0,
e.g. flags.

Here we only check the show_zero property and let arg printer handle
special cases.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-trace.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e5fef39c34bf..915dcd258002 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2091,17 +2091,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			val = syscall_arg_fmt__mask_val(&sc->arg_fmt[arg.idx], &arg, val);
 
 			/*
- 			 * Suppress this argument if its value is zero and
- 			 * and we don't have a string associated in an
- 			 * strarray for it.
- 			 */
-			if (val == 0 &&
-			    !trace->show_zeros &&
-			    !(sc->arg_fmt &&
-			      (sc->arg_fmt[arg.idx].show_zero ||
-			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAY ||
-			       sc->arg_fmt[arg.idx].scnprintf == SCA_STRARRAYS) &&
-			      sc->arg_fmt[arg.idx].parm))
+			 * Suppress this argument if its value is zero and show_zero
+			 * property isn't set.
+			 */
+			if (val == 0 && !trace->show_zeros &&
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2796,17 +2790,8 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		 */
 		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
 
-		/*
-		 * Suppress this argument if its value is zero and
-		 * we don't have a string associated in an
-		 * strarray for it.
-		 */
-		if (val == 0 &&
-		    !trace->show_zeros &&
-		    !((arg->show_zero ||
-		       arg->scnprintf == SCA_STRARRAY ||
-		       arg->scnprintf == SCA_STRARRAYS) &&
-		      arg->parm))
+		/* Suppress this argument if its value is zero and show_zero property isn't set. */
+		if (val == 0 && !trace->show_zeros && !arg->show_zero)
 			continue;
 
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
-- 
2.34.1


