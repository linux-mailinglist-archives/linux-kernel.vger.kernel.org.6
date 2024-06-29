Return-Path: <linux-kernel+bounces-234800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 728ED91CB0E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09872B22DB2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6A3FBB3;
	Sat, 29 Jun 2024 04:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f28MZLdv"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42883BBF1
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636866; cv=none; b=OhAkm6kM2y937tL6XQRQUIK4h5Ca9BXY/+urlNBXGM+XhUE6eVgTIjS984l6niDJmeGYJPgA27yZo4k5SadcgtlOZZAHEntK6hTL9j7lV+j92dcNErj50wASUeA4sj7lrkBZWUNCK/KuNlmm4DVI5njeIVxBG2oWlT4sRtYSaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636866; c=relaxed/simple;
	bh=znmkZCaamQRU7v0uy6sIpxst336CItbxWtsabeYeLf4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C+m2M6TrKCWpFf5ih0iswL8wOM4co3rXO8C7z3aYa07hbhzN4nkUxZSuQLpWa97KiD/O5vQdkqMPGVCUNvQhXNhUvKRF6R7upZy02TCqCJVzinW9yTwftR2hneuyvr/BQrLeb4d7SE1Dxjerpx96Jh3w/NRsrwhZkarVNLFyzVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f28MZLdv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso2460017276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636864; x=1720241664; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qFahSvtYCgkWsqqCp3yfdkhC2VqGdDus+43H+4umnY=;
        b=f28MZLdvKtzivZaykR7jY05B0x4pOcs4TQTHmnaqMs7kidSbo6AVUj8+aFI0cjoVZO
         bICcaWU+n/jS6r1hmFtDsAEBV3eYT0dQMASanIJpY7Onq/LhZb4+8cb3RlDyOcEYoOJ6
         ITx6QkXR+TXQVlkf80FN62nOUQpovZ+q/4TiTlj7DFWwe6xJ6N/HU6zMM5PgAMwM3WP4
         fqEKnj4ZuWH9CIqvBkFieGAKyBrGeLoo9VK+edur0Rl2z8rFAgARTVtJNeEl7SIejpKa
         Rqy4OW9hJz9x5vyT0j7fO0aDkrRxe3nHU2tdlIM18RCZray+mGq/U60WfEPCpMRtZ8Lc
         a49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636864; x=1720241664;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qFahSvtYCgkWsqqCp3yfdkhC2VqGdDus+43H+4umnY=;
        b=Li9MH6Q/u09Ugh4XuIv7tdnime6YflQUU5u6bs/5S1M9QNGFfW68HNZIe8OLRdi7bN
         M8rhScwvDCWWZbDAUOfPNmj+hvsYrpj1p29WyIbto60KK455ysS1m4rx9ZJ2c2NjeaWb
         5gNn6r5Fo9gKiJiSuMkSQ0fB1eXs4b7TQa7aV747c/3olNbEGpZaUoC8XqYng0ISIOtx
         lnPEQysDzMSMEMGjB0+gKLwtFGOijCkseyHfbNZel+eQ37CO36TeWH3ZTTBB9AixJQr+
         kyKeowt6ugENGqXfFEQ8hcr6G79qR9knXRbraMRpxB8MzGM9LQqSl4X2Phg3tFeRkKRY
         AJsw==
X-Forwarded-Encrypted: i=1; AJvYcCWJoFSemhksz4xGi0+CaswFkxk9k0txOJa6Op1eRHo8CTZkzKIO1pUViRTU+xNp2BJhic4vhQhYQKFvJt+jJtGm4LndyOv5W/aHds+m
X-Gm-Message-State: AOJu0Yy3MaSOl+3jTrWesE4aVxGsbUlLm+UxH/gnWC+jkpH+ciUCYA0u
	ndSLA5O1qti7yHTGOgFJNhoCZzslgwOeABc1+5pYaV2X2UL/ru45ixEK+BiCZPktSeWNGmZrvJ6
	ZCORlgQ==
X-Google-Smtp-Source: AGHT+IGyYt+Ug4wKE7CF+0lD3txU6miVuOCyb94wJamUB8cYnxGDHnmXcKWlP4cbadWy9xXjx9f2PM3zPXp9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b89:b0:dff:83e:b259 with SMTP id
 3f1490d57ef6-e036eb4a8cemr995276.6.1719636863723; Fri, 28 Jun 2024 21:54:23
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:29 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 07/28] perf kmem: Use perf_tool__init
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

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.803.g4e1b14247a-goog


