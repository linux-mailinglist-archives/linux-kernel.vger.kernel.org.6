Return-Path: <linux-kernel+bounces-358035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB8D99797D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91B9284CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F1133E1;
	Thu, 10 Oct 2024 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u6IdLcU2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147C2913
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518850; cv=none; b=Zfm/a7ppOFHsCgiy7SdDYaqQmDb1/7D0xnR7d2qxBoxIojcWWFB1T3MlcZT3sn9J2+UJkE2zrDh997pHSvO124N0x1ngT2bko3ojs3Wgq9LxW56rW701vilheGQSg3Nde56vqsyjvhhu0ZaOwcgCK5TPGC9wIowjwoBFkxjzaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518850; c=relaxed/simple;
	bh=873TCTNElKQX0bZntabxvE87Xk82g/cv1CuRKgs9g7A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gpeW8Qv0dZXSWapHBrD9mkOrWXwJBWm/X5Ql3ymcJUjynVZauastlbj6LoU0iPgy91QejQ2479VdffmLV6dIWna2n6InXp/xdw+jMhTr2MgeqwmEsD8PoRvQjtS1GUyKgHbyNsylkdniu2tnAaroP/HEiX3pdi/dGXkqKekq494=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u6IdLcU2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e17bb508bb9so535300276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518848; x=1729123648; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wxLrGOjIUYrXf1Xm3RquDNZNVmQNpQ36swJ9i1PVT94=;
        b=u6IdLcU2hdjgN7+Oqe0z977Qlk27hVrT4cX+8S5FxMQZEVuIOGScZmQA0Y6i6y21tT
         MNePSAFbmEeB5l1qCzAZtZ2P7jnf5yzmrAraht6IMYAzTjfScB1rt2+VxKDuLh7UfBO0
         WfeZM+tnO1/lX4Nmdgs8tcCuq4Fdoxz9foJ6pCwIqGJuK/+rKXJRBHBDU20BVbmCYB/S
         TUq4Ms1LKAQWbDyAT3GuNDCzk0n9vc/DcRS6g4hDOvWM2a3wW3asKYSw1LYnyFx45tzs
         SISUg5pFSaM5j+ewq6VzsFIPkOMZADaHZh27qfdyNMxTL8dRQeqQnRThAG+mgLHulB3p
         wrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518848; x=1729123648;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxLrGOjIUYrXf1Xm3RquDNZNVmQNpQ36swJ9i1PVT94=;
        b=tJnmULq+CjytqR+z4lcj1SuvQ8Rqt7Y566NsAfsxxWiYndFGikcuPJCUTzQqR2UsD5
         Are+xJ1d2Ke5diXdSjPw3EDXO0jQDMmlkj/MOPpcyYYue3bKQ8VjCM5MvuglykKLGypb
         u/Jo43ofPsN+jRehdAvYeRhD/77w0H5ys3qAfGCWt1dAPUIEVQyxPoAPtPzxG06jmg6f
         hfUrQAItaeoadXLsMaVezCCrFLKf+5jdkgm8T4QHVtVwar4TytvWppanebsPbYnKaYt5
         9T+J3jeZbCdbQ8NwMnzkDCGQv9kV0vf9NjtI8j1xIp7SqbN4q1niKcZGnbnBAFlE9eRK
         qlhA==
X-Forwarded-Encrypted: i=1; AJvYcCUyqmX2UQVYC3B+pTSV2ASdbqZV7Z8gHIjDi+OWhtWIEiao/w3Q11QTMAy/b7vv6YpIusEVPQed+AYrCfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX43OGir8b5oqx3svztyql0ze0yFwexofHgw8GYg0BwNSEt/VY
	lRxFLMV9c9R6re10tgsSMsFRcRyJ9IVMEstRNVr8zk92fM2AkdW6q1VY36SYVdLwdZ9s1HJJ+wV
	9kfKnOw==
X-Google-Smtp-Source: AGHT+IFay/ECMcmFAcUljtg9lOQdarFfE1jnU6vii9GYoXo19lPJtQcJUKrBTdhSQDmFgfSly7DwKWWJ7dIF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6c8b:1170:a0ca:9d72])
 (user=irogers job=sendgmr) by 2002:a25:ab6d:0:b0:e28:f8e6:f4c6 with SMTP id
 3f1490d57ef6-e28fe465652mr32303276.2.1728518848391; Wed, 09 Oct 2024 17:07:28
 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:07:13 -0700
Message-Id: <20241010000719.1172854-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 0/6] CSV/JSON metric thresholds, fix printf modifiers
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Yicong Yang <yangyicong@hisilicon.com>, Weilin Wang <weilin.wang@intel.com>, 
	Tim Chen <tim.c.chen@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metric thresholds are being computed for CSV and JSON output but not
displayed. Rename the color that encodes the threshold as enum values
and use to generate string constants in a CSV column or json
dictionary value.

Add printf attribute to functions in color.h that could support
it. Fix bad printf format strings that this detected.

v2. Don't display metric-value for json output if there is no unit.

Ian Rogers (6):
  perf color: Add printf format checking and resolve issues
  perf stat: Fix/add parameter names for print_metric
  perf stat: Display "none" for NaN with metric only json
  perf stat: Drop metric-unit if unit is NULL
  perf stat: Change color to threshold in print_metric
  perf stat: Display metric threshold value in CSV output

 tools/perf/Documentation/perf-stat.txt    |   1 +
 tools/perf/arch/x86/util/iostat.c         |   2 +-
 tools/perf/builtin-sched.c                |   2 +-
 tools/perf/builtin-script.c               |   6 +-
 tools/perf/builtin-trace.c                |   2 +-
 tools/perf/tests/shell/stat+csv_output.sh |  24 ++--
 tools/perf/util/arm-spe.c                 |   2 +-
 tools/perf/util/color.h                   |   9 +-
 tools/perf/util/intel-bts.c               |   2 +-
 tools/perf/util/intel-pt.c                |   2 +-
 tools/perf/util/s390-cpumsf.c             |   2 +-
 tools/perf/util/s390-sample-raw.c         |   6 +-
 tools/perf/util/stat-display.c            |  80 ++++++++++----
 tools/perf/util/stat-shadow.c             | 128 ++++++++++++----------
 tools/perf/util/stat.h                    |  16 ++-
 15 files changed, 174 insertions(+), 110 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


