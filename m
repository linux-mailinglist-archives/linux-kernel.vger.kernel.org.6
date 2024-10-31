Return-Path: <linux-kernel+bounces-389841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C51CD9B721B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 505BCB209BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D212A14C;
	Thu, 31 Oct 2024 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i8dSVfJL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD6684D12
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339008; cv=none; b=UhWJsqz7dv613M8kPyjiBlLTghB25UKf5LsH3GtDZPvR0wRdTU0aKDh0SagmMueJrPfTjAAf4zy4xLFnezTFF+F+qjtbsT99rZgmPDW/VLNVaw9JHetUpwV/XbZF3VXc86ckRfs/S8ybFP8VIN+Dy6wMA9AKZD7sA4KJmXSW/5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339008; c=relaxed/simple;
	bh=GYxmpcXArXMONJWsRe5WPl7DZqsyI1iL6F7x/lVFYsI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=l4spAPF6IDSHKrhfGhRuWf1Y+8KzXEDydhk/meJ22XxWt1LOJYej4WVGxOs68vR0j/7BSO5tP9Nh43RnLT8rvc+KAT9MbilW+TZsB8an/9UWNBaDxYlndR3sEtvOJj9+sBSnrroaBgbTAYITpca6ho1QQRXNf8WYg+0tWf4kkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i8dSVfJL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3497c8eb0so6019147b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339005; x=1730943805; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=i8dSVfJLwAEC3Yc3iBSmdXJa2a1NKEQl0pe29oKpmV9UfR2G3iEHDnHTEfkiXW+Gp1
         xECSB6NxeLVsNj1m4TG8XoSpFduYKvxNk0EvpSCSjAqWARTSRL2tV3IMCgN1NVa2duBc
         Th18HNhxGQhsehqllG+QCBu91ckdXLkxD8PgTpdARw6M/0svOHOyPTF+U+dLyzJbA/vr
         misp0UXr5z3s8qTBFS7lFf9xupKLKIlcBE4sEzS2DV+OACoBKJRae8V8VoF64Uxqz0wB
         R86ql7ANYS7OvRNNJK+HtSCFUJ3TqjkeB8SgDizXLBLhSkPJmVOI+p9y/PnxGDF2tUfv
         s4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339005; x=1730943805;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJdU7+o4d1QH5mPoNKTab3DA0/sS4GdEQIezl8TuMU=;
        b=IXJ7hu42lJVe8gz4ulTJK/vCqpWWwCxKq3PDD//fTmApsxLL3P7HU+dCHAgHiA32wL
         teS14nA52Lf06Q5akVMBqDi7pbs286Ovwz5ZEMxePeFl3xS1TxjR+oaryETZlEZYFMRF
         Zqcg6sIl+FNMcxJn4IVL0RMVecbc7Ke1EE1zkUe4GfwaY3/GlcOc9WVRMgsWmZ9arKyT
         njk8J6haERcWXVrakBRBlGxKKVobvIaXd92xFntZCjVEfI/u7aDUpDvbU1Rx4eXuDSd8
         EDFqK2h9KDks8GMZJGH3KU0ubLBLW5lO2LISdMXQe6OVwCv1yIUk/y6rB/dumnlE3lZM
         r7Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUisCyWp2rX+A6Ak05BuMS5qbOth3T5VNMbtUOBEFBF0MsMbXSKAERqmIGPqy/4iLZ1mWTfCZOdv3sh/Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYnicI5Mcb0dZBLgEvUKhm7en0RkVZsBsrPZnNx01/9BsblDZ
	vNDrWzquQxUM2SstXsx7xLa+KYWIAcn8cKAfxiXhrbTXceM2UC7YUPOr3spiJxYWMSJiNH75exK
	HSEme9Q==
X-Google-Smtp-Source: AGHT+IFR9rK/aQ9amJdpd1t/y1Cad1qqJ3/zdCMOUezpWk9aRtk00B9mU2U04VpxVeYw1eEz90LsxD3W/WdV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:690c:7004:b0:620:32ea:e1d4 with SMTP
 id 00721157ae682-6ea554802ffmr68657b3.0.1730339005014; Wed, 30 Oct 2024
 18:43:25 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:34 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 03/21] perf python: Remove unused #include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove unused #include of bpf-filter.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 13dad27169a0..974578a04099 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/bpf-filter.h"
 #include "util/env.h"
 #include "util/kvm-stat.h"
 #include "util/kwork.h"
-- 
2.47.0.163.g1226f6d8fa-goog


