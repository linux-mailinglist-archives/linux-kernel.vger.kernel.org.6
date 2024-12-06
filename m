Return-Path: <linux-kernel+bounces-434413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBC89E6670
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110BA16B237
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD831D95B3;
	Fri,  6 Dec 2024 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xFSBuAS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81A1D90D7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733460054; cv=none; b=qs/eUzvUrW6N93YsALetdBFPk+m8JlCtxk72/iOl4uvtX+hCXdIqHJd9RZZ2oDNpG300c7nC/2OkkTxYtx9t8rDIXefNhKCfglF1v5x3TApuscgi+Bi/QJJzbVB9803JTxMLAVynR90Vgrk5lHBOu9lHyhRN6v9CwkL2GhWtSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733460054; c=relaxed/simple;
	bh=zAYbTToy7miM8tLMLMB1fAi9ERVwZv7WSJg6LoWxSwo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZzxvLdo9pt6blaovB4Fp49Rcpp6mFxtkdqSrdS7kzHwIQvLgKnjfWEO2SndfRr0wJQAigu/uxXq3/vzqcrM8/0OGKhPgecVaux87TB9zGEF4f8ZRLgr6GV3JmskJZLEgdDvnpq5Z+osonH+l1scSnhDmlRbN1ofJuP50W2U65t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xFSBuAS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6efe45a2405so5984337b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733460052; x=1734064852; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXXuS2o2j6xQTgeWYL+xQ1vIazksKTne/XbLVeScbI4=;
        b=0xFSBuAS59PoKkpftK1g3OnJdqM96MzP5i8UliVFoD/9WRAZFfTz2YJySTFKJgbfEZ
         w4E7pyWkF/sASTH1htbGOjXm7HlH353NgavyTfKoKQMszdi/JDg04Z4obSVugkTNw5RL
         0b6F4P5iJfN4gttFcyz6JfD5QdjUzddPWqyyQE5MZDAXerS0ABi0YvsRwRfUOXfetlTg
         3OFCDcP9A0aVnRVOvsZQ27HfdtjHbDOiB0m3XqmvpoTnOdtQq6pSq2kTqAIdJk0KE/gu
         IKJtJXQRG1KNNIn4hblkVhmwXSgnMe5ln73BFE+D81tsaJ52zEAGA2B/5W4htMymil7x
         oV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733460052; x=1734064852;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXXuS2o2j6xQTgeWYL+xQ1vIazksKTne/XbLVeScbI4=;
        b=iU19QECT0DNI0WNNfmKK1qCdvieF4+1dNUtU7QKVhidBBoTohzd+iP9RfiktjsDTCA
         4GOF7a9mYg5indlSMFN1+a4MVpfeVtbDR/R2Om+o2WIndE4GCa2YB+QE9U0O+i61VjoH
         6P7gUDttkeXzW/mwBYjd9jryjitUnvQuf6Z7yzxruXeHnbXsnCAG0tDffl9PnuwNPI9P
         cfMCKg1EDN+C0OaQtP6FucAfOBbELVMhorITc6nUBerqSevhl0piisWMU8k9OoCY8Tub
         Ug3YiclyMIMyp0SYO2siiEPZriajoNG6g7L1Gvn4nbxV4NQTF2uidBlLPDK5JTjZDk2g
         OoQg==
X-Forwarded-Encrypted: i=1; AJvYcCVrJra+Mm+VDKe6KkzyCFjyie+NxL0kSZSRzuGMNTk4P+QvXRI1KhAVOo13Uy8n+rMXKJF/z8aBk273bUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfAquLJI3aESMoTceOraeaPjHVmNtG5ryQUfo4Xr7wH6AgGXW
	w0c1vZq/m5jG4y8FaJtxghIunL3A1c3xyHXfJtOWyyF9+hN+acF6H+TieDtpKVuidryQJkvxb71
	bC57Qsg==
X-Google-Smtp-Source: AGHT+IH6pJSsb1JmXS5B9BULKcXqWLb4MGTO9GRL3/aT9G9AWPq77Czm66g8jckJzv8epZvzw9L7H8e/LggM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:eb75:393:2a8c:1440])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a88:b0:6ef:7a23:afbd with SMTP
 id 00721157ae682-6efe3c83279mr17827b3.8.1733460051702; Thu, 05 Dec 2024
 20:40:51 -0800 (PST)
Date: Thu,  5 Dec 2024 20:40:33 -0800
In-Reply-To: <20241206044035.1062032-1-irogers@google.com>
Message-Id: <20241206044035.1062032-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 6/8] libperf cpumap: Remove use of perf_cpu_map__read
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove use of a FILE and switch to reading a string that is then
passed to perf_cpu_map__new. Being able to remove perf_cpu_map__read
avoids duplicated parsing logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 20d9ee9308c6..60ef8eea42ee 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -10,6 +10,7 @@
 #include <ctype.h>
 #include <limits.h>
 #include "internal.h"
+#include <api/fs/fs.h>
 
 #define MAX_NR_CPUS 4096
 
@@ -102,12 +103,12 @@ static struct perf_cpu_map *cpu_map__new_sysconf(void)
 static struct perf_cpu_map *cpu_map__new_sysfs_online(void)
 {
 	struct perf_cpu_map *cpus = NULL;
-	FILE *onlnf;
+	char *buf = NULL;
+	size_t buf_len;
 
-	onlnf = fopen("/sys/devices/system/cpu/online", "r");
-	if (onlnf) {
-		cpus = perf_cpu_map__read(onlnf);
-		fclose(onlnf);
+	if (sysfs__read_str("devices/system/cpu/online", &buf, &buf_len) >= 0) {
+		cpus = perf_cpu_map__new(buf);
+		free(buf);
 	}
 	return cpus;
 }
-- 
2.47.0.338.g60cca15819-goog


