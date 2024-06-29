Return-Path: <linux-kernel+bounces-234795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015F591CB0A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 06:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78823B222F5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 04:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C033307B;
	Sat, 29 Jun 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irtwE8JP"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6A2BAF3
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719636854; cv=none; b=cUp346ff7+/Az6uVruNAlgzoSiuoONn+4+av9y47BBSCS2M3i7S55+hSesdiUc4fsn6FMXsJSwc+Wkvg0kR1qgLcrAOZ+7Cr2K2xfybVInN3MIMWL3LGKRHfIXONh4cBmtw53Q1Brbp9wHUU1bL3puwJkEw/TDBUYNvwAeSz1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719636854; c=relaxed/simple;
	bh=ZWJL2IZGB4Jyl+Jh8k0ovfzFTLaNCadDQOMYSgkyOUA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=g8wWB3QnIvCYB2HWoTKYtkFzkf5TWcuUw6NbjMFi0nUH7X/lbjeKyTa4grSS7jXasPdzJ5hFFEh8fmV1CpNsL9CzaxRB/Gpi+RKex92IgLbfAtuawNtvIjsUDxwSm2vsn3x/OzwMLtNyvG72cGSu04ZPVBbN6EYPCxuziIWY9Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irtwE8JP; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e035f7f715cso1166288276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 21:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719636852; x=1720241652; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Py2DKOjmjxOtoOnuVu083IR5IZMLkEQbnPoATbWiYI=;
        b=irtwE8JP+bTj9QW5ZNplAhm4IKPdC3t7F6ym+F+vatfxSI605cmfBWdipiyM1Z8ab9
         50pdPhEai06v0EGTaTQuMQBt1Rl1MAwASaqIDLR+PCR6WkzPcIT742+ewTHZpr9wH+bt
         p/C2+t+AZoOaErXrhXwrbg6sSGmpRYoLq3fkLkL2j4lgEs8zvEwY0Md1HMB/0W3bipWi
         FfNaJKPah/sfbOYUtZdRh0MhAcgp8uqUq1AuhYcA1pze+8hRP50i8bp6o9pQboHVBJQa
         aJk6C/FpIGdQ+CND9HR7QLDvMuFjXbw2er107wl4Ege7tJgwAKDenweZeYcR6qvvKKuK
         DnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719636852; x=1720241652;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Py2DKOjmjxOtoOnuVu083IR5IZMLkEQbnPoATbWiYI=;
        b=tjrpmj+W/abMp3/clMAgKYLPrNi+J5iIYrrKpvBEJoHbhwYXZ3IiBqrzysdopUViJS
         ukWrXDxZu71MLNi4BbixsucAnWQqh/DdtMPw8Yc45NKEL+PRLbPn6ddEi5C9RFN3C2f6
         4Soccrvhw/VcN0VQKIs8P+t3Ygoqwm2k4BemI7VjbtTyj9M6fyqbzRd5qXS1X7EoOUpL
         tGXASsRE9PmWJRMuTlmH/yohMWaTPUGRbIsJtPOD7+FcTBOeyFV8vTZMIc4N/Kex67jK
         WVLXZyeVdrQnZcibSlJ9Pd10032hw8IUWCacW64OV16opuo39MF8FwJte6jWNigzv/oT
         BBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsZpxyWim7sMEp5sB0Z72SjLJuwrrRBqouEQbAAhzwiRnKVaIeHfGAR8D3b7XtECvd0nIpS+QIiupdMVSKlte3v2AfBdWqWp1iLDbc
X-Gm-Message-State: AOJu0Yz/duhoHHZEqEEut0rwxS6XVWeWy+1mNqd8fRJ/71X/zGVEFLZn
	RE3pH9IMnP6nRV/YVrNDoAyRJVsZ4VeKGROv+VSoURrBiek8NAJVcDHZQKpbdr14ulQGC1BAoqg
	Ivu2cSg==
X-Google-Smtp-Source: AGHT+IH2+W3iClgJSmJE2byX19nmxCZcdn3WNsd1JolO2htIsab6d+nKnVHk5sfOXGj6K2Gy8Ju4VzejR8iq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f9fe:7acd:496e:4edb])
 (user=irogers job=sendgmr) by 2002:a25:2684:0:b0:e03:61bb:6032 with SMTP id
 3f1490d57ef6-e0361bb6162mr42020276.1.1719636852532; Fri, 28 Jun 2024 21:54:12
 -0700 (PDT)
Date: Fri, 28 Jun 2024 21:53:24 -0700
In-Reply-To: <20240629045350.285243-1-irogers@google.com>
Message-Id: <20240629045350.285243-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240629045350.285243-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Subject: [PATCH v3 02/28] perf s390-cpumsf: Remove unused struct
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

struct s390_cpumsf_synth was likely cargo culted from other auxtrace
examples. It has no users, so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/s390-cpumsf.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 6fe478b0b61b..4ec583e511af 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -952,11 +952,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 	return err;
 }
 
-struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
-	struct perf_session *session;
-};
-
 static int
 s390_cpumsf_process_auxtrace_event(struct perf_session *session,
 				   union perf_event *event __maybe_unused,
-- 
2.45.2.803.g4e1b14247a-goog


