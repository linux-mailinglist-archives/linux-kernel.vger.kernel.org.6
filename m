Return-Path: <linux-kernel+bounces-234817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D31B991CB20
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049C11C21777
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AA1139563;
	Sat, 29 Jun 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1pWZiYKS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC739FF3
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636904; cv=none; b=jp4Hg+esqV/IPJWIbMYyy4bcV4UZfDbDppxKdT7jyuOK12TXXo6VP5d/dsXjFTR4nvyIfuqEAmxumCiQC5UyPaFCgMTyUDwoFJOTetTZ7qrZ7RdzhJYMYYeyC5+je3meID0klLpWfNmfcJm3mDEifWn8zqfJNOvodjCgSfwHtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636904; c=relaxed/simple;
	bh=KZ93qPz4l1aJIMbX6X549+h/aAfpzEBF6ypr0gskuZY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ZGJV4/U+kR34LcR5DbHKfCuXRMPhSjz+gLGff1Re1vUnRDsBtQxpTEyfKzjFdvj60OsPMTyApJsiRr8anOj0vYy+mke7nk2ssoUR5iqTCeaCA8iC9ITNXO1m3Vzi5+eu5XTJb+9jXjuMTQ9RVbxFfgmLIq9D0SIUSLioSFqZTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1pWZiYKS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-632588b1bdeso27930457b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636902; x=1720241702; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QxE8zaj+b5/x1bVRBgpaGx+eOiWA4VqUOBFS7RhEkrQ=;
        b=1pWZiYKSpfEW4ENOqW64BwM9mM7UHr0/nJX852LAti1kS4xMj95N7JGGN04wV2zqEk
         4EiHMBH9s8feSspkrDCxw6epzqSZQ9cyRIzkOt0oC35NwhGw6JFDswPiqXUlrqF8M4gq
         hvYVvtzvVKW7tXLHDMqmQH0xkO9fZ+WHeK20UfrO0no/HUp0KMCeOBeG4VgOLumgndhb
         8IGrT6nrcAghkhn3RRPGJ/oB7Qrd5TFtcDmHgL9l5np+cBUfG/HaxonCfolPMOqypkfx
         GY5M5zvmBXcvAPFX+i3yPiKwCWZkYFo2E25XBJXIyrOSK2lA3mRcgBPT0X03/KYt5BaZ
         csfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636902; x=1720241702;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxE8zaj+b5/x1bVRBgpaGx+eOiWA4VqUOBFS7RhEkrQ=;
        b=gNEqaz1oe9CAV+Z4KbxIXcnkdV6Q47hbXYRQYkJugOKGOJmYW41mJwRioezrbK7lgu
         zNE/U5dDXFFvr/jeUy8cDmUqp3ECZREBkEdEGirsv3IjxOScOV2uc07qmx5nFzvjOSo+
         LNBcDpCwDQFf0uQ1UE5TsEdLGRh0+b9DiO8A9cJN48jRg0xhqt+jao+ks8dk5WBja5Gd
         atq6oxIN6Dd+lXOZhSDNc2dh9mWg10dTVBe87jp/KXgsHUIYI5pp/dy7YqgB3AwqVEVw
         BVbuKbc1T/lFANxOFWNZfRqsPf0jsdLIfukNRiBw6Bkh0MS7PM3xKVlov2u7TVBLacs5
         WHwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/zKSeq6tJqIgi4gFddLivglGGUPdoB2JqlLSBHM49/aQOpa0x4r5F0lwMF5aMAzFWzicSH7n2P2UFSiSIzp5FNWrqopyJNRAXNFe
X-Gm-Message-State: AOJu0YyngCG0LhjVTNf7EIYRugu79QA50/ZKHW2rXdTTZyypzw9C6LhX
	dgP9Y4CvKtHBUmUA3gjNwMHfNAoqmzZfZhYmMN5glLZfkhkDTlha846yR+DuoBDVgQSD2fgbfN6
	jbhpSqQ==
X-Google-Smtp-Source: AGHT+IFYiat8zAOFqEhWzL8cJxNr/uK8cs0d5B+e6TJJDnVINuyMYTmdafGkH7qdb27g2EciP/a0Ubwb1XCu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a81:83d1:0:b0:64a:bd29:c5cf with SMTP id
 00721157ae682-64c711459cemr44947b3.1.1719636901688; Fri, 28 Jun 2024 21:55:01
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:46 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-25-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 24/28] perf data convert ctf: Use perf_tool__init
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

Use perf_tool__init so that more uses of struct perf_tool can be const
and not relying on perf_tool__fill_defaults.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/data-convert-bt.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 9e2170604b66..021e9b1d5cc5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1607,25 +1607,23 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-	struct convert c = {
-		.tool = {
-			.sample          = process_sample_event,
-			.mmap            = perf_event__process_mmap,
-			.mmap2           = perf_event__process_mmap2,
-			.comm            = perf_event__process_comm,
-			.exit            = perf_event__process_exit,
-			.fork            = perf_event__process_fork,
-			.lost            = perf_event__process_lost,
-			.tracing_data    = perf_event__process_tracing_data,
-			.build_id        = perf_event__process_build_id,
-			.namespaces      = perf_event__process_namespaces,
-			.ordered_events  = true,
-			.ordering_requires_timestamps = true,
-		},
-	};
+	struct convert c = {};
 	struct ctf_writer *cw = &c.writer;
 	int err;
 
+	perf_tool__init(&c.tool, /*ordered_events=*/true);
+	c.tool.sample          = process_sample_event;
+	c.tool.mmap            = perf_event__process_mmap;
+	c.tool.mmap2           = perf_event__process_mmap2;
+	c.tool.comm            = perf_event__process_comm;
+	c.tool.exit            = perf_event__process_exit;
+	c.tool.fork            = perf_event__process_fork;
+	c.tool.lost            = perf_event__process_lost;
+	c.tool.tracing_data    = perf_event__process_tracing_data;
+	c.tool.build_id        = perf_event__process_build_id;
+	c.tool.namespaces      = perf_event__process_namespaces;
+	c.tool.ordering_requires_timestamps = true;
+
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
-- 
2.45.2.803.g4e1b14247a-goog


