Return-Path: <linux-kernel+bounces-283740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DED94F863
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D308B283522
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F67194C83;
	Mon, 12 Aug 2024 20:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qdlGMOYc"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD01922C6
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 20:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495651; cv=none; b=YY4vQ2QSbeTmiPVI5q+lil9TQnwzviPaYpePY0rBvUgoPf+TCU7i8/yLQgWV5kY+SaxuUX6u2zMcDEhX1P8oeJ/JxiW8qFMLCqmJ7Ihx+JOt22jZZKCL/gqjrAn2jTHipISVdI28JVMiuXIu398k/HUIrK9XYVEZSRZrkGdws3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495651; c=relaxed/simple;
	bh=SmGvrb/RiIfmEnAttLomvZlQJWQIDHH0GVeuoCluYbI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KS7YmADYpBKT6/wgQdbWTnB4qWKo/g2gc2PTc0GsehFx+EoF9waoKmIU6m3acziMAy9IpyBoYZSZ/iujLdHAw4tUjRq5Ze+u5cdnylwOSFq1tdlmtoRknmsKMtlUDLRRkcA9tpf2BFW76z7cefOqjJbs5IyOVOVjIuK1kEcO9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qdlGMOYc; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-66619cb2d3eso134359657b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495649; x=1724100449; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OP9aiQs3LSZ3NoWhBifFY5k1xgj0LP87bCzLwLOVCg=;
        b=qdlGMOYcTaT5MjZvJh0zqs/ocDvMweE5jAXKXA06vkWpJ26RGrp5YZVi3XPrM200qx
         QuZTsSucQFQmh5tVgtfh25wjWqboD41Ynoc2x+xNDvhsCY2sPn3fmlTUoVLhzmxYz9z0
         JzkgIT1G6O/4+YEYSBQSkUrKMG1a1oKlaz4L7dc6Uh9iiZgFcRdHbDOjf2XvmxjIXNyz
         kDSWHvnlcepES0mQmULSuL5RGaTYWETYSpG8mT04IbNFZTk7hgBy+wiBiPcEOHkzYtss
         oNQga7k2MFBWX5jITYonDCV935cKyXZgd8/Yp1Qzbz1iqsy3dMYOSnQFl9RnntOPrajy
         nRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495649; x=1724100449;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OP9aiQs3LSZ3NoWhBifFY5k1xgj0LP87bCzLwLOVCg=;
        b=e0BstswJQ4+L2LuZFTeI9qPV9vTt85M4+0Z2hc+11bxj4pLDMF0LPxp385S29c+IG6
         KbziIfWPNySw9CvkPpA0kXJi6lZprMzTe+bim/S6VeNixEJGoES48VnH98PxtL/HHbQN
         GqoapApvjEVa+v/kZZaJQ1A6+JzRMVCLqrsMP/MOpam0eW2IHT0unMzARn8pnJ1xhtRQ
         TZHUR8rGMFOPB/zgC1N51DbYXvrB0mPSBpnZC2tr4IJcBtyF634Pys0VTdK4Vwg+3/m/
         Zqqan3rIbnXE5mdHbA67qmkgUO2pJiCT0H+Tzk6cgk/ywPVtYOfTBhdwhL5tAuHXVphN
         nQCg==
X-Forwarded-Encrypted: i=1; AJvYcCVwtkHTb47w7R8jbm0tM61u88L1M91uwAvPXnmG8sUdOlH+JJJrZA3j3FUuf88SYQsCPkpr6sa/CQrjkxzLk+yneTrgB0k6iWYETaGZ
X-Gm-Message-State: AOJu0YzukUrFzITBaIZ2/upZmwQzos1hBIVK+hbOnR+K5APKEGPwqg5U
	HjJ4SN/uD0bkItt12JdDTRhG8TZvxAmgJVhT1oj9KcozxxnVvWmeKFqfm9b8N+N+Tu1vy2/qGPs
	TtnMGzg==
X-Google-Smtp-Source: AGHT+IF6KGsif2kcc/WLiE8m4uQ1YeulYGefZc5LJwWTscJn9uh205dobOwh2Y783hd/EsBConXuVHwlLeeL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:abe9:0:b0:e03:5b06:6db2 with SMTP id
 3f1490d57ef6-e113cd4619fmr2756276.3.1723495649104; Mon, 12 Aug 2024 13:47:29
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:46:54 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 02/27] perf s390-cpumsf: Remove unused struct
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
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
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
2.46.0.76.ge559c4bf1a-goog


