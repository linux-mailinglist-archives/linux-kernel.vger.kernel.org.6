Return-Path: <linux-kernel+bounces-315984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4996C977
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF0D281512
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCC314F121;
	Wed,  4 Sep 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuwR+h6U"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556E13D28F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484631; cv=none; b=ctK8BvXBHoirPS+STgXLA69b3pPuum5JXSi9dIQmwQP7EqZAjUlADDRBUnIciVHmKJ2Nd26OJU+1tbcEsy4Nehm7hG78MX+CcHiY2nHNfJO2zrMKmhY8ORoIiDPfMQCffdpPzEgQ7vf/k2bEgg2gYETHjiBKekZzyBoU7oIokYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484631; c=relaxed/simple;
	bh=sw6PdzoA8edJ/FZwSBA7Pp00GqIZLs5I64ITVdroShU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=MoVnT+PfAFRLZggWOiu5z+gNRHEv9hmrxxjkEdPKBczLW1wmsY9rTXZACJzjDxrrDSEBy7Wj2CJzlxFgl+EU7r/JEAKCmFphoDXTwI3USEY/MFoQLUI0E+eKkyxIXwijVIhtH9r+pN9IWRJV8/CM1QxkI+nC14w2RWUNMD2TpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WuwR+h6U; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so277322276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725484629; x=1726089429; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LSKRbPPROI10402FVcupQQc44qQEukdAyMkZrVit+8=;
        b=WuwR+h6UOjy4ibITszibmBDYPCw5SFwKMM/lArzZ0IP1idOd2zldIieDzP2TmLyICZ
         s3V3+vTdU9P2btdO8CMJOgWOawQxHulXrysjylFDxmLE+IerBOSEKl1+NkPuuDLtZlVj
         bYE9aMcOmqeKgSfpfF0QS4MYeleI+r0x4FUtNMGt3vwspZoTEHMKj9m+sPNdERmb6yVG
         dVB0sJed7YPwviVS2ILj+DniDk3/tl8TzqXtHhtDBQKkOnH7x2Xo33yWU7jdGYGGMp+T
         wrO5rbPFHs9vAKsIVqM1IOtn/20ihxpgOlOPjzexdk9gZLbE8hwtMyOeVYDqiXnxjODL
         EyWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725484629; x=1726089429;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LSKRbPPROI10402FVcupQQc44qQEukdAyMkZrVit+8=;
        b=QGxbm2KEC4kZlyLSxIRYeIFdy7GhNahTjIwyNALemPRpr7BV8bxIXB0ZPNRt5wDhQ/
         L4rEAUbOC2n1wMxcs9QlOhv9fHnxDflaK2JDTEzdkzboRDNio6wDphIhzfH5Cp6Zk0d6
         +w3SSXSltqpw/Wsxpsm8UYOXDuLBRTMMcEpxmmP7L5I2L8KZL0Nuziyl08VcPnqOobGN
         EUls82pJvrsjiCatKIgoW3zhHYEcE76PJJf7QdxUTkiGd2Iezyt7IKeFkmV/Kkicelzq
         XiJuQXdET2OJrw1Xvm4dpmF9BO25fu7Wrfln7/12VFC1jFtUVTI2DoFo2CDGLpPVRTVV
         WNAA==
X-Forwarded-Encrypted: i=1; AJvYcCX6M57GJaGxy45YDBVAuEMrD7p52r403Taa5xRetQPy2wM17PQhGHh1N361qq9mJb7D0A+/lCC37aC6Vks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPSF37fvWCzwYMyGQf58gh55TCIo/L/oTkZ2eKTXXS7pA2Zw1j
	XrxF7vQXqeQ2nmi4ZTdcSaIzjxmCzolagxr1vVWa79UTUNjOIE2MKvInBS6RXKG+bTS11kiPQsi
	yu8SR7w==
X-Google-Smtp-Source: AGHT+IHxXsCmjr7nDR1gzVFUSR2MHv1sTzvy8MqpSzwxQxFynLR5CENdqoAxYET2l9qFkp3t+ejq+4o15sJZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:11b1:b0fe:e30b:a492])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d5:b0:e05:fb86:1909 with SMTP
 id 3f1490d57ef6-e1a7a1a339bmr2362826276.6.1725484629231; Wed, 04 Sep 2024
 14:17:09 -0700 (PDT)
Date: Wed,  4 Sep 2024 14:17:05 -0700
Message-Id: <20240904211705.915101-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1] perf jevents: Ignore sys when determining a model directory
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Existing sys directories aren't placed under a model directory like
skylake. Placing a sys directory there causes the `is_leaf_dir` test
to fail and consequently no events or metrics are generated for the
model. Ignore sys directories in this case and update the comments to
reflect why.

This change has no affect, but when testing with a sys directory for a
model people have reported running into the no event/metric issue.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 1d96b2204e52..bb0a5d92df4a 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -635,14 +635,17 @@ def preprocess_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
 
 def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
   """Process a JSON file during the main walk."""
-  def is_leaf_dir(path: str) -> bool:
+  def is_leaf_dir_ignoring_sys(path: str) -> bool:
     for item in os.scandir(path):
-      if item.is_dir():
+      if item.is_dir() and item.name != 'sys':
         return False
     return True
 
-  # model directory, reset topic
-  if item.is_dir() and is_leaf_dir(item.path):
+  # Model directories are leaves (ignoring possible sys
+  # directories). The FTW will walk into the directory next. Flush
+  # pending events and metrics and update the table names for the new
+  # model directory.
+  if item.is_dir() and is_leaf_dir_ignoring_sys(item.path):
     print_pending_events()
     print_pending_metrics()
 
-- 
2.46.0.469.g59c65b2a67-goog


