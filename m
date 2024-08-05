Return-Path: <linux-kernel+bounces-275262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86483948285
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B841C1C21C59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363116C69F;
	Mon,  5 Aug 2024 19:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="got0GdUI"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6DA16BE31
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887077; cv=none; b=mdqFYaOtT1ekNnblOvm0gwBOM/ggtLBd+iMObaoDWGb7CoYSHtAoeqGduPCRV5y/CgoRCvWiLV7tBbc4zFkTw+H62MGQIcpalt+iag6pj59ZM+2RHWbsRBViVA4mrmogAgoFyTOlIr41K5XCje42mzP/aP5V2t2oqO2ET2EHpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887077; c=relaxed/simple;
	bh=CSdm4ZpN1S/oImSC2nWOUlg9um7r2EBy22OoKRuW8sw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=spRgGQZh0sOSx4bQABmYLDA9vW6qvoZbnolzso1BzWdtWEIV97FZzdMziATZnlBL/OzNqWMtPtp7S6pB0goYAGKwTPm2gpxDJnXVVMvyuVXR0sO3QwcKE+ZA1klhPWSacXUuS93XEGEd+vVjAgMOFdB+akZOIEombrj5Twzd5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=got0GdUI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05e9e4dfbeso18372282276.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722887074; x=1723491874; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tA68ylO5jWmS/IidvWPiQaY17OcIuvwiHS8mFC423wA=;
        b=got0GdUIR3mXkiPLoB6ZMHF8TCfbz7BlrbAFGJKJUA83pMZFFC/tKEnE3fd7W/Guhj
         UkY+UGV6P29sKKQhVXKfrp9FTJWU+WmIh5lqOVcN7YSaGmequ56M45y3QphPWpyfV13+
         JUayiSdy4L1zHQbQuwsV44GkwnnEHgsH5MGkm1MMCpXOLn4nwppq8/gH8WBoLEzobQKQ
         rPqr1vHLa4DUQUBK2CLcdzIJh6TXvnHPYLMevx6SSANwZqMnSWu6ma9fH+7hslfKvttD
         MCCw4WFqd5+oTCKcn+ihE1BD/EzGjwm00Gam0ZYuh0u1y6LqDnfFM3VQgy+LoAdOAMGs
         IE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887074; x=1723491874;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA68ylO5jWmS/IidvWPiQaY17OcIuvwiHS8mFC423wA=;
        b=nrYgSD4Xa5oDvTrYK6wXd7otBj6daLM75v64NxUsciX4W+jtP0PRyfnaum/Z4jEOYT
         qG3ZzKGktXnKSUZG57Jqy8npA+kXCxM3e+7jz7zdHLsL7fyGhMkiOaWWjKGc3qaklVX8
         Kq4v13FXrznFJWiYNEkseHrOciUXOz7md2utP0BesTQ+ZHtnygMYtAtS8997zzzLDUbz
         3dTZzEzOp2cEDX+R1+jTmTkEGyc/0yhO4VdbsJ0fn5byhurFN31nTbQn6Uq/7TFXU7nw
         lRvdLU0wRiaftWV65rLGDUvAtfXWa32kQfvbOpeb2gj19l6oLfFI6opfmsfvlG7uZaPs
         f26g==
X-Forwarded-Encrypted: i=1; AJvYcCVdfbD6McMzbezLYlbRstwhzjPIdsTU0qwd6AXjTgTeBwJXULg+A9LPIMxK7w0ef1q2nwJrMbs194SdzP+qYfwkXw5PiUNcjYIf2bMm
X-Gm-Message-State: AOJu0Yw5Tr3zXwdwoki2h6KT4yKioO9lDNSH0GCg3vuZanf7o8IVJolg
	FmSX5JFF3dZreEW07Xe4lOnZIjrYnn3aDvcK3Mrn5qw2ESomwiI1Se6TYwb8+JjTyx2WazA+3hH
	ew7pBbA==
X-Google-Smtp-Source: AGHT+IEe61oyAxRcyJbONskfgG+pxQhuzYOimimwYVvqO8/yvxoo+1a+/P+Oz8TdzIpat9CjNonli4Crb+al
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:1f65:8dc8:61d0:4b08])
 (user=irogers job=sendgmr) by 2002:a25:9008:0:b0:e0b:f46d:a2bb with SMTP id
 3f1490d57ef6-e0bf46db4edmr40122276.11.1722887074494; Mon, 05 Aug 2024
 12:44:34 -0700 (PDT)
Date: Mon,  5 Aug 2024 12:44:21 -0700
In-Reply-To: <20240805194424.597244-1-irogers@google.com>
Message-Id: <20240805194424.597244-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240805194424.597244-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v1 2/5] perf pmu-events: Change dependencies for
 empty-pmu-events.c test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	Charles Ci-Jyun Wu <dminus@andestech.com>, Locus Wei-Han Chen <locus84@andestech.com>, 
	Atish Patra <atishp@rivosinc.com>, Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	vincent.chen@sifive.com, greentime.hu@sifive.com, 
	Eric Lin <eric.lin@sifive.com>
Content-Type: text/plain; charset="UTF-8"

Switch from $? (all the prerequisites that are newer than the target)
to $^ (all the prerequisites) as touching jevents.py will mean that
empty-pmu-events.c won't be passed to the diff command breaking the
build.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index c3fa43c49706..d941bc9d16e9 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -39,7 +39,7 @@ $(TEST_EMPTY_PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(ME
 
 $(EMPTY_PMU_EVENTS_TEST_LOG): $(EMPTY_PMU_EVENTS_C) $(TEST_EMPTY_PMU_EVENTS_C)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,test)diff -u $? 2> $@ || (cat $@ && false)
+	$(Q)$(call echo-cmd,test)diff -u $^ 2> $@ || (cat $@ && false)
 
 $(PMU_EVENTS_C): $(JSON) $(JSON_TEST) $(JEVENTS_PY) $(METRIC_PY) $(METRIC_TEST_LOG) $(EMPTY_PMU_EVENTS_TEST_LOG)
 	$(call rule_mkdir)
-- 
2.46.0.rc2.264.g509ed76dc8-goog


