Return-Path: <linux-kernel+bounces-269948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99131943923
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CA3286901
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B59616D9CC;
	Wed, 31 Jul 2024 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r2TVlNlD"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DC16CD1C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722466811; cv=none; b=SQKbw5Fc6HfkR3cbZGT1acI/oZi8auikBZaPn4hxYzU0zph8rZCD4nSA1yvtQ16FTna/VSmbgBu0R42WSa3bjDxeR5XRUP9Z+vLbFqMwcr3dlxFOe7s2F18cEHxBmsX//nLa22ToCgn+fVUt8y3ypVaBnQsirCK/rs6nZR5RwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722466811; c=relaxed/simple;
	bh=OJgk9cJ+TdeGwOTgs0ZEde/0xIJ389zukYYTF7pgxO8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=osVKIZxwTKn8NqF9dWsLqGwg9aFUwfdRXI6hpsQ73P2b4kIbkOSqWruQTDWfcmmbPliFHcd+0WPDelrW3Pvda0Tx/vQddGyHymYtzrxP+ddydWnNWRb0ylyZ6qNF1Z5bZXZTHeYFDOHbtk+InS1L56tMAbLiSUwQ9FWqYa6n3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r2TVlNlD; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b3d35ccfbso7764786276.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722466808; x=1723071608; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IvDlKqQSP4EQTz9NFmsrxvp0IpCcDOcWrteWc7+vTTo=;
        b=r2TVlNlDi9muKMX0v1tXfZnpImzvplWv3Q7irYc/IcWVls8G2eUXkcPsdUsnAml+FC
         JEEm0KZpiWI6LKCGsgVDhMvRW2R6zWdVf+67Zh4Y2Xojq9Uudu0REtjidCgzLTm9XLIi
         CbpbGN/BuvgKV9o1iRHCqi76IkfTHq6ffvkTKZXvs0x2qUK/gs+83Tx7Xr6miSaT2wLV
         st1JY+o1qb0+JhKvz6ezfcCCJMObE0tdSesULbLncfbQLJdxYgKPw3ZOJx1ToUGPCho6
         F5/rbdx5YTY2dOReKP6R8oCS3CauNIxA6ECCLdjK1GxjZiODxiP75Iw2a/gSDpBKVnvW
         Ci9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722466808; x=1723071608;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IvDlKqQSP4EQTz9NFmsrxvp0IpCcDOcWrteWc7+vTTo=;
        b=RK+tzIW3I03P/wvY+Pg5XRvRjSAP//OT4M5mSnKBM79yibPl/jT7PDMkjJ8Ef5yYrZ
         nrBuDx/2u7bM2F8MkpfNKLBpkABgole32E/HKty/utPC6BLBtjqEoTIGwwQbdY+wB3iX
         a4fqNlMl0K7C8/ammHF17XCLN6vxLap5dIDU8MrB7hkPVsJvQvZZhUb2xroc1FN5H1+8
         CpNA1j0hODN52LIIs+Mogl2HgpgOiSxQYh4HmqbCBV1XLriTB4oLaaUWCbWyeNPt+LRW
         RxLMy9BPqeW3wrE8S8c0QYQ/diqQJYTB0Z5O2CRZ7hrCwHsqseELoRcj4VAu2YWDlLqW
         NG/g==
X-Forwarded-Encrypted: i=1; AJvYcCUfOHFloMxjmse4zyjApNQDL48/FItvwp4IpONEL4/8NuieUd7qw1edG3Z6hCm9xDyewVctRJGA1QR1st4MWdNHTj83JH9aN0JTpBG8
X-Gm-Message-State: AOJu0YyMi53KopRNaSoCmOikflenzaXq+XYiI8iJIk0JHT8CqnUO62Fa
	KAk8qEMlPkh83lKdDmT9k9KVej3k6sRbpkZ68gAPutvQ+9J4d2bEmVLWeQSOpO3bwAI/BgwCXg7
	PKcDmHw==
X-Google-Smtp-Source: AGHT+IFR7w2wRPd8Gbc8O26Wa4D6n9qH15B2Ufe2fKiQvk6YNr6BOOAn2gagsJjY5+BdwpcK7lp2dOONGop+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91b9:a9ed:5ab1:7e4c])
 (user=irogers job=sendgmr) by 2002:a05:6902:154a:b0:e07:2e88:89fe with SMTP
 id 3f1490d57ef6-e0bcd20e3aemr808276.3.1722466808184; Wed, 31 Jul 2024
 16:00:08 -0700 (PDT)
Date: Wed, 31 Jul 2024 16:00:05 -0700
Message-Id: <20240731230005.12295-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1] perf python: Remove PYTHON_PERF ifdefs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When perf code was compiled one way for the binary and another for the
python module, the PYTHON_PERF ifdef was used to remove some code from
the python module. Since switching to building the perf code as a
series of libraries, with the same libraries being used for the python
module, the ifdefs became unused as PYTHON_PERF is never defined. As
such remove the ifdefs.

Fixes: 9dabf4003423 ("perf python: Switch module to linking libraries from building source")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel_fprintf.c | 2 --
 tools/perf/util/mmap.c          | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 8719b3cb5646..c2c0500d5da9 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -107,7 +107,6 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
 	return ++printed;
 }
 
-#ifndef PYTHON_PERF
 int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			      unsigned int print_opts, struct callchain_cursor *cursor,
 			      struct strlist *bt_stop_list, FILE *fp)
@@ -248,4 +247,3 @@ int sample__fprintf_sym(struct perf_sample *sample, struct addr_location *al,
 
 	return printed;
 }
-#endif /* PYTHON_PERF */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 122ee198a86e..43b02293f1d2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -230,9 +230,7 @@ void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
 
-#ifndef PYTHON_PERF
 	zstd_fini(&map->zstd_data);
-#endif
 
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
@@ -295,12 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
 
 	map->core.flush = mp->flush;
 
-#ifndef PYTHON_PERF
 	if (zstd_init(&map->zstd_data, mp->comp_level)) {
 		pr_debug2("failed to init mmap compressor, error %d\n", errno);
 		return -1;
 	}
-#endif
 
 	if (mp->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
-- 
2.46.0.rc2.264.g509ed76dc8-goog


