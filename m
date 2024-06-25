Return-Path: <linux-kernel+bounces-229410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8129C916F42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3A41C22ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048A17BB1B;
	Tue, 25 Jun 2024 17:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvCeEzBz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27551802A4
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336423; cv=none; b=csC/zNSaWmCIesUDeS0yhrFOtuyOLSgy1xKh+WwMDWnwNLWIk4VhqwhJv/iknNnlsOBqjK30g8d9wxSmaDkv8D64Yenrxpg+ItPnhvNfxXYDW19in0gg458c1b+US50Dzf+NfB2B7Z1BAPS9GEZGAF3KkPZtdNNdKEqyLZKy7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336423; c=relaxed/simple;
	bh=2DeEVPLy0FEUT5ZAm0DKrKbPev4k7F682AE5BOrx02o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PGUhyE+2YHyLQnUOjWUnUvFVC9BxIcbJOxEfzU6I7k60JVZ/CMgUATmcu3f7PbU5IlKp1Y6G//9DVfBgGHYM3EWvSONRSEWJNY6eLRmBT6yCQFJXSGbAd0EJLwL306f6/DaLIDQxVvx5sl5at6tHEDd0MAjikv+68ff3UbyvsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvCeEzBz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d054b1ceeso120074787b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336420; x=1719941220; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6A7PaqIwyu4CU4GrB89ckL5QJWFy56tGr5i6+q3YuHU=;
        b=FvCeEzBzv4xEfgVFNK0k0NFftPJh/9BSppTSV+gR/RWdbcn1WU3DDMyshSxiYUJs8v
         GW0G11kcWXPYnkTo5pkFiymKeyl+PIyNrioaHllUm4lE8wvrMQ10jB84LA+a8xVIM2HS
         +/zILn0T3mV4XBKbVxOV05V+irb//yiNYcRRhzPyoxLiLEmi3XYGKj+nCDqUKieH4GjS
         notM1cZoFAMFxt83hJ+zgewhQdPojoMgU25vClkNXyXHlNvmWjbNjnVPC45ZqFiWnZZS
         PuKi0VNbxBtz0oVyIDgCvninOET7GDIRuDsU2WiDSiYIPTlAXJL855gONv65V5wpHYYs
         +lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336420; x=1719941220;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A7PaqIwyu4CU4GrB89ckL5QJWFy56tGr5i6+q3YuHU=;
        b=s9YCGu3g2+omAbQ5JW9RfYdFuRMM1FDeA6kGhVci50nh4qrOgRwdnEJ1DE6mXTI2LX
         nQc6H1Tlre3NNGNsK9krjM60ZG2gMNu3xxRZ4Cw+eqi+/0ZzxSdKcGUjtpPWJoycLFhc
         O668PcBqvTiiFS9kbblG7TI2EW6e82KJ93V1+ra/StJd2mYiIYmLe3KFtOUQKVQp57Xj
         /zfyJcUsiHvWzekjw7W/qbzOnDR+HauD0h8BQPUsKD7WNl13b+DKqFvxSgPHVU0k6ByI
         aj09Bh26Q+1ovL+LXbhsgTQBaBYtd3SU4soHPkac79auxQkLHfyA+WfbyfXx2kZVSGts
         +frA==
X-Forwarded-Encrypted: i=1; AJvYcCXqX+yq88yq+CNKHgPGxB8e3p9xWfjl04P1cTCfA+zkuKwpcfmCBxt08yxf5o1VAH5jOx5l15F9NABP6T4TfeFBIGKW57Cq+9YcrJyh
X-Gm-Message-State: AOJu0YxZbpnYRVPbdYIzT3N2FF0F+A708Aj/FOtF23kdRHbzVQMZ/iDX
	kfb2CidofD293f8H9PbRifiGVvpGoM8gqSy6UjhWc3+HBkOGK8lNFavztJ3DJmrZmS3olvvICg/
	8kUcfJA==
X-Google-Smtp-Source: AGHT+IGIWKw3wlhnYW+gj5sNzYIaUB7CqGMqyR/kggiKnBfYHZogEyOyafdY5n5VrvSu0dmMoUTAy5u3BnvK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:690c:7001:b0:62d:a29:537f with SMTP id
 00721157ae682-643ac338f18mr3046937b3.4.1719336420093; Tue, 25 Jun 2024
 10:27:00 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:59 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 22/26] perf auxevent: Add explicit dummy tool initialization
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Ensure tool is initialized to avoid lazy initialization pattern so
that more uses of struct perf_tool can be made const.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/arm-spe.c     | 1 +
 tools/perf/util/cs-etm.c      | 1 +
 tools/perf/util/intel-bts.c   | 1 +
 tools/perf/util/intel-pt.c    | 2 +-
 tools/perf/util/s390-cpumsf.c | 1 -
 5 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 70bad18c4a0d..06a198b2f483 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -1097,6 +1097,7 @@ static int arm_spe_synth_event(struct perf_session *session,
 
 	memset(&arm_spe_synth, 0, sizeof(struct arm_spe_synth));
 	arm_spe_synth.session = session;
+	perf_tool__init(&arm_spe_synth.dummy_tool, /*ordered_events=*/false);
 
 	return perf_event__synthesize_attr(&arm_spe_synth.dummy_tool, attr, 1,
 					   &id, arm_spe_event_synth);
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 231cd833c012..02eb5b3eed14 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1619,6 +1619,7 @@ static int cs_etm__synth_event(struct perf_session *session,
 
 	memset(&cs_etm_synth, 0, sizeof(struct cs_etm_synth));
 	cs_etm_synth.session = session;
+	perf_tool__init(&cs_etm_synth.dummy_tool, /*ordered_events=*/false);
 
 	return perf_event__synthesize_attr(&cs_etm_synth.dummy_tool, attr, 1,
 					   &id, cs_etm__event_synth);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 779982c478e0..ae97109542be 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -761,6 +761,7 @@ static int intel_bts_synth_event(struct perf_session *session,
 
 	memset(&intel_bts_synth, 0, sizeof(struct intel_bts_synth));
 	intel_bts_synth.session = session;
+	perf_tool__init(&intel_bts_synth.dummy_tool, /*ordered_events=*/false);
 
 	return perf_event__synthesize_attr(&intel_bts_synth.dummy_tool, attr, 1,
 					   &id, intel_bts_event_synth);
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index bed35029e1f6..48ed60e521ed 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3687,7 +3687,7 @@ static int intel_pt_synth_event(struct perf_session *session, const char *name,
 
 	memset(&intel_pt_synth, 0, sizeof(struct intel_pt_synth));
 	intel_pt_synth.session = session;
-
+	perf_tool__init(&intel_pt_synth.dummy_tool, /*ordered_events=*/false);
 	err = perf_event__synthesize_attr(&intel_pt_synth.dummy_tool, attr, 1,
 					  &id, intel_pt_event_synth);
 	if (err)
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 5834bad6ac0f..eb835e531cd6 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -953,7 +953,6 @@ s390_cpumsf_process_event(struct perf_session *session,
 }
 
 struct s390_cpumsf_synth {
-	struct perf_tool cpumsf_tool;
 	struct perf_session *session;
 };
 
-- 
2.45.2.741.gdbec12cfda-goog


