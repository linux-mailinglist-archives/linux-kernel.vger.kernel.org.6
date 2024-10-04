Return-Path: <linux-kernel+bounces-351570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26698991335
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6402848BF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C39D14D299;
	Fri,  4 Oct 2024 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iIhc7osT"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C81231C9A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085286; cv=none; b=kJpzNQz1xTuopwdFe4CwmsydL6FVRphRNxsveknd9oKeYGwMg96UOPr3HJDBpYE8Vtl8x0zSitiwJtkG1auA78PmOn8QqwYYuVlYf0CkYsM/wLgus68qUGARPXc2HCamgJfyInhwJcedPN2TCYcMgQX94K76ztdw4YdS69KtPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085286; c=relaxed/simple;
	bh=0ewX+Ngc0NcpulzsenrDwxUPqfYbaus5LQCFfX+bSKU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=a3LjH3PNQiFOCHeKet9640oSkAt9PEWYxqyCm76WKyGDONDee5ROdBfiHFtAgtQPJ8wJjo4WrggPauQ8NDdeVG7xoeOma/ejvuu87A9Kt33PDLz7c0aupxuftlMm5+b3cBTYmbshg2dqD+ziVOHcbbOcrs8nUrG0IyKM2omIdd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iIhc7osT; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25ea440729so4118282276.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728085283; x=1728690083; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cwiDFuSbl6FB7NmqYOyxOc/XwPagJhaLZPJBTtRN9Gw=;
        b=iIhc7osTNMV5/wURfwsnnwXwf+egHnOSRdAv0s/HthMS3U8wSDcgQuRim0TyowB46g
         I/73MOWJTYyhNBku/319hrt5tKFqHB8H67U2PtbDqqrQCF+ICl0zeQG50qHoZAx9j02V
         Dgy59oaIq6p0I1t7Z2U+OaFdFmopvGNaZk0ZeaM7GSNJOwrnWn94OUSdMLciFRyfIP9m
         rcR7XlY23T4yxL/iG54Nm/OJn0oxVK17UeTzxI+VD0yBuqW4gp1vtN6DfbMakU0XFYfr
         CWPdbOpUDzNXflLbS2Ljo/xGStqVpOddCgPYsiaaduV7T2XUcWXmong1foTS5Id6N0hj
         pv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085283; x=1728690083;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cwiDFuSbl6FB7NmqYOyxOc/XwPagJhaLZPJBTtRN9Gw=;
        b=l6F2Ta56IkuumIew1t7fFKGYgNizhRIjegFnLxA7/KfI2vB7vuXWD5cFPJ7iAUsy+z
         WMR3Rd5VXdX2ZIWw+W+WcHL80PlCm3zEaa8zAmCaEFbTuISqtyOT7txISKM5/eEGYMIU
         232CavbdZyM7eCCUVcmGR9CsHLTmbeCvDyhCiGfwCr2sHWSksJtuKJrZ4L8GZ6se9Smz
         sFZknUx98BDdRUKxGDOEbbQTfgkPYwmMUf+ZYrDUiLzUd/hr8+d/RkwgPYsI9Jl5eX/K
         aJ6TEgqm2nUXDU1s7AaFxlw4z5yKZGdkWjLJ4mC1oWmh5NOEEg9pQdTmXiwd5RPaVNCe
         QwpA==
X-Forwarded-Encrypted: i=1; AJvYcCVc8Gz1Jtc6wX5qt4JcZsOYhJDogm3CZmsC4yeOZ21HmJOmx77euOf6RUipZBMHtL8i63oSEeak7d8/SIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLs7nq0pmi3/MfPWtITkGbHnTDtZFrVX4CH/iMaQ9IzVwkDpD/
	6BnVNQ1xI+nhvPfEMnLQJASzUFx0FtyOp008K9vFkOyYWb0TfLjfTn3LUkJ0TbqFK0DEsw5aFNH
	rqAslbw==
X-Google-Smtp-Source: AGHT+IHQmFybmLmWSQKXu8t25MjnCcbz9iuIAs3Pnyt0Y1H4euwaDEThxlC7JNbnVvQxWUSSP2JxskAgdM3p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8d23:e3c7:679f:19df])
 (user=irogers job=sendgmr) by 2002:a25:6908:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e28934fc7a7mr3435276.0.1728085283292; Fri, 04 Oct 2024 16:41:23
 -0700 (PDT)
Date: Fri,  4 Oct 2024 16:41:12 -0700
Message-Id: <20241004234120.1495209-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v1 0/8] CSV/JSON metric thresholds, fix printf modifiers
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

Ian Rogers (8):
  perf color: Add printf format checking and resolve issues
  perf stat: Fix/add parameter names for print_metric
  perf stat: Display "none" for NaN with metric only json
  perf stat: Drop metric-unit if unit is NULL
  perf stat: Change color to threshold in print_metric
  perf stat: Display metric threshold value in CSV output
  perf stat: Add metric-threshold to json output
  perf stat: Disable metric thresholds for CSV/JSON metric-only mode

 tools/perf/Documentation/perf-stat.txt        |   1 +
 tools/perf/arch/x86/util/iostat.c             |   2 +-
 tools/perf/builtin-sched.c                    |   2 +-
 tools/perf/builtin-script.c                   |   6 +-
 tools/perf/builtin-stat.c                     |   8 ++
 tools/perf/builtin-trace.c                    |   2 +-
 .../tests/shell/lib/perf_json_output_lint.py  |   5 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  24 ++--
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/color.h                       |   9 +-
 tools/perf/util/intel-bts.c                   |   2 +-
 tools/perf/util/intel-pt.c                    |   2 +-
 tools/perf/util/s390-cpumsf.c                 |   2 +-
 tools/perf/util/s390-sample-raw.c             |   6 +-
 tools/perf/util/stat-display.c                |  85 +++++++++---
 tools/perf/util/stat-shadow.c                 | 128 ++++++++++--------
 tools/perf/util/stat.h                        |  16 ++-
 17 files changed, 191 insertions(+), 111 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


