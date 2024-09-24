Return-Path: <linux-kernel+bounces-336420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E063983A9C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34282817C9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54674DDC3;
	Tue, 24 Sep 2024 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlE81wgz"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F550BA4A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138253; cv=none; b=Os5SAbeutyVta/s2uvbE4f7jY5ayViXIXDfwYGZ/Cdm/Uuy3G/7PtgoPjycAZ7A4WPjIS6397KgiSxS+dC4fQTPESNS3Vp0trINp9dISRMRgCL44MzZ7NlGKNFolQNXiNIHS0cvhIPWYLmS5ifBRQ+NHtanG0K1c+iZurdYyYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138253; c=relaxed/simple;
	bh=Qo1Qps6/oRTPke3sLUp94xRSSuy8lIc7nno8/awTXfI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BC0j9/Q5kuCzjcPsO+lDznuBdRunKSoVn4XPllngHjGg3vmvd7cST+QBAb42aRQE2cd8qEU6jdTdIXF8Pj9r/E808DwCCKVJybXzmI0liCu+0FJ1jN1Jb/rj2kKvP1qcXtd9WEhLvpVqUuewhZNnXrlUacAxgCGYDn4ruJM2eyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlE81wgz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e225c289c90so5648961276.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727138251; x=1727743051; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/x8P3+kVeCiLfvUzo1Nwxxj4w2s36O0oobO+3bH8RI=;
        b=UlE81wgz363HFPR2YEmwLxjoEsHOCGEdAwTakQeW6SRURnM6WmDuE9v9kRdLShBo/g
         JrWXhVndNWqvjeEDQ1jReP0W9nxNBqwtnP2Vuf417yNp3fbjhBIhEjPZUdOw/nC5s/pL
         f/Ww7VuxWUgQoov/lzYaGZOlIIsT0MZz1pPkiwnnE4KrBo1g32PARgLBi/DSe/dh6waW
         RIRHuQZ/d3NYJAKsWdc8RMaVw2FY23W5MpYL4BnzTcKFaD+4Wb9voDM+Sr9FbPIwW4b6
         uWnJuf4YkaGNRENu40ZFoqFSJew85kFztZll25Gm6933NsIS1h9W1MPar5rdVzTigexb
         vuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138251; x=1727743051;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/x8P3+kVeCiLfvUzo1Nwxxj4w2s36O0oobO+3bH8RI=;
        b=ciE/yzqmugRwZWAvE87FXPX4XkPdUqNAfY8igijchIvg+FOB1u9bo6zG6HYZVgcPpm
         m3zFq+p4g2VNoorA7PcXAlPSrbhDEYCP5T8qa7oDq9FVpIE6FLdW6Ygz9aRkRkw2wnX9
         b5fY0kQTAzLBEVqQZoLr3QonY36pU/9jFCXNLWrg835q8RZ+/nGzM3GDmeMs61GHxIS3
         /19G3FJbkng0Xlqt5RIpJbePhF+k9I6m4Ed2/igereJoPnLi9biSYWjVUMmDOeF74rsP
         ouUAIQPNZArX0DobKAfV3ls9M5BrCl6EkUlwi4/b3cGPTTGOQ4oTPduC78TyDTXR46Yx
         2Dpw==
X-Forwarded-Encrypted: i=1; AJvYcCUk0AzBvoSGi4ACSAEESHOLM/nXLT+UCGowxDPdUFhOG+AW7ZJWcsx1ljNP/t9yx8dtbeyOE1w8Vi7Jc0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4sEknJnxoGpe50riaL+LiOHduSM96Lv9i4gsLmf2j1A20wVr0
	iHXZ7jeQe3wwitGh8fZPRaD/0/6RjLskKCrX3JcOBN6ot/StmkLc3cWBWKySLgzxau1JvrHJxmg
	Azm+yRQ==
X-Google-Smtp-Source: AGHT+IH/rgjYbdOMDt4KrSS3kKCFiGWPaYMRdvdlvzOkH+OY0cQ7tzxBAPYC6JadwO1FlEe3HgelNh9m6Ab7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:83cd:0:b0:e1a:7693:a8ac with SMTP id
 3f1490d57ef6-e2252fb2d4dmr33250276.8.1727138251223; Mon, 23 Sep 2024 17:37:31
 -0700 (PDT)
Date: Mon, 23 Sep 2024 17:37:19 -0700
In-Reply-To: <20240924003720.617258-1-irogers@google.com>
Message-Id: <20240924003720.617258-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924003720.617258-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 2/3] perf probe: Fix libdw memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"

Add missing dwarf_cfi_end to free memory associated with probe_finder
cfi_eh or cfi_dbg. This addresses leak sanitizer issues seen in:
tools/perf/tests/shell/test_uprobe_from_different_cu.sh

Fixes: 270bde1e76f4 ("perf probe: Search both .eh_frame and .debug_frame sections for probe location")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/probe-finder.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 630e16c54ed5..78f34fa0c391 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1379,6 +1379,11 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	if (ret >= 0 && tf.pf.skip_empty_arg)
 		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
 
+#if _ELFUTILS_PREREQ(0, 142)
+	dwarf_cfi_end(tf.pf.cfi_eh);
+	dwarf_cfi_end(tf.pf.cfi_dbg);
+#endif
+
 	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
 			clear_probe_trace_event(&tf.tevs[i]);
-- 
2.46.0.792.g87dc391469-goog


