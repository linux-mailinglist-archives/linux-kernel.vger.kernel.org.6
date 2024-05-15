Return-Path: <linux-kernel+bounces-179498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5548C608B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E16EB23C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E7142073;
	Wed, 15 May 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmpd2wIx"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15BE42058
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752880; cv=none; b=esVEO8ZCsBJqf9iaj8KINCD9wuKma/X5zcWdgZAge8331drE8oprltVDJBXTOTzeXlSEOaZ0M4dN+wli23DoDkDtFIOq56xAGY5VitPV/XHLHEXUCIkItqN9tOuS4IKQZ0wvWpeKYiByEid/F9BW7sPlx2VXunzTmYJEkVwhuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752880; c=relaxed/simple;
	bh=GiXxAHFN2GD4CXggEYA/tGtT5/RanUB+p73pbxTb67E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=HDOL+cUZI1arOPMCSR68eTmex7vFG56V+LaZHhRrWepltoPGkYldC59FdCkvhIWr4G+f0NKWeTQGfIGhXIgC6zirYCs6A2V8t6mcfsyNyJtQ75/kxPU4PAa+XBQyuw3wOjcWqw3avxjBQwbdnFddcYIpAp92zkdDFNExMsBMRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmpd2wIx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6207c483342so113816847b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715752878; x=1716357678; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X4R5s9OJ/uGB6XbGrKz0Wv7rjDRBvcB0bapwlYPxoLM=;
        b=zmpd2wIxB7IFCLe+3wEliwe9DkUK01+DlgvQQMQQs9b32JrGgNUUN/XSILM6sti331
         7CeODtG3rPsiYbnHf1eA97ODROTUZRTnjZlnK6Bii/R2BUmProHchsBiHRtqB8SPdAOU
         PE/n3yWlPniWtouVqCPuw8FT9NH5gdSYczNUhQuWH3w9oY0hXREAL6YPQ4S7JzTsBxjK
         ow/22eKTwQTAPuKks/efrVvCcb9/ClQeQrXDMvJO/cVn9OBigSG+2AkaDtFFAonPhHTO
         EaQZmKf6A7gWQ3JQNkMcmdnFPN47g+SPeGEHyjFUjxa2IfofLNMndHNqRHAhdzxYeFmx
         NOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715752878; x=1716357678;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4R5s9OJ/uGB6XbGrKz0Wv7rjDRBvcB0bapwlYPxoLM=;
        b=Zt0ahJJ/IZHVWalsuyHAK2HCTrTMB2qxWPNVD/OcUtuWHc515kSlIpjnPbl0JxUMMf
         lF8fxsZEP6dgl5aQYy1VIkEJTnB2CgycnSq6ci9nR90T/evvAcas1djFH5Q45o7XYex4
         smYKGQEYiuDtZLp46/gpdXJ6kpHrjuJOCqpr80iiMmIOTSezHVjs/6DBuhwS+NWQdBMt
         ZSmB8ktnqmP8tUCBg5FnKL60zJMCdH7cgu2TBdy9V6B8WVg0btTRsYNt30qA/7ayQjix
         RYLoecLjzA74cPJWMaoIEFbXu+uFbz6odATCoYOHSJDtWFqy2dJUU65dqQ8T4kRgZfgb
         qNsg==
X-Forwarded-Encrypted: i=1; AJvYcCUChnzcQhlGP/tUiyBd+2CDGPmwKiIWEG4UAx6x2iW1659/7xeA7DrKS8XWTgDm0QPjqwTiDGaHuy0gJQ6MGqBKLwz+n87Pk3N+dGs+
X-Gm-Message-State: AOJu0Ywfv1U5j5aQwVlfarZJiavGALH2Rg8RxJDrLB+flDiBBq1beqxh
	1DMBNEE4U6IxyiPFXn+Gm4YM8AWL9IHF21n9pcSmUy5gvgUT1UivOwY7wpdeL/z5IoisF0oge7u
	s1hDpIA==
X-Google-Smtp-Source: AGHT+IGnt3HIxHi4XWke7jxmWc3mTKxLZwUxpFYUbZXCr6GXLud2W3KxEdFcusezJQDhsEbvfc3IULp16Q6u
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a0d:eb57:0:b0:622:cd98:3b89 with SMTP id
 00721157ae682-622cd983e47mr25481097b3.9.1715752877742; Tue, 14 May 2024
 23:01:17 -0700 (PDT)
Date: Tue, 14 May 2024 23:01:12 -0700
Message-Id: <20240515060114.3268149-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v6 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
From: Ian Rogers <irogers@google.com>
To: Tuan Phan <tuanphan@os.amperecomputing.com>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Bhaskara Budiredla <bbudiredla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

The mrvl_ddr_pmu is uncore and has a hexadecimal address
suffix. Current PMU sorting/merging code assumes uncore PMU names
start with uncore_ and have a decimal suffix. Add support for
hexadecimal suffixes and add tests.

v6. Add necessary fix in pmu.c to perf_pmu__match_ignoring_suffix that
    also needs to ignore hex suffixes.
v5. In pmus.h remove needless addition of #include list.h but add
    stddef.h for size_t.
v4. Workaround GCC build error by using unsigned types. Don't consider
    short hex suffixes as suffixes (e.g. cpum_cf) and test this
    behavior.
v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 33 ++++++++------
 tools/perf/util/pmus.c | 67 ++++++++++++++++------------
 tools/perf/util/pmus.h |  7 ++-
 4 files changed, 164 insertions(+), 42 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


