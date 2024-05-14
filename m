Return-Path: <linux-kernel+bounces-178201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A868C4A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0844C284E06
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FE7F8;
	Tue, 14 May 2024 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuHvIuxL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE831365
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715645659; cv=none; b=MSk9efpS7CMwCaNyJ5liVm1t4wviBYu/1FrgPBpG55HVBfb4M4DKa2PkCQmVPIjRMieCYHDbNVyD9TXWTsL1vKJAshAgx3H1LkXHVp98nBdoRarZEwFvClT3sGb69Xa7VnqLoMFtVwnK2j0AQ9GtlfAW4Rh7fiV4Yx1KtCSyJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715645659; c=relaxed/simple;
	bh=H4Ltz56e0ZLx1rx6NCOIfo5A4T7x+ukzpJ1TsvEhnYg=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ECNx1ir0x6hcSDmgwK/w5S5IB9V6h6yi+ngn5gIInXmLM+dO8FVYKLSjHWOB3e2Bt1p0uMken1MsEF7NDs3VQ8DrkLnWI8aJBtR0Xqt02jBhkUbkukFGENoCoKtYP0O4r4+V6DG10so+w+LRnGQt2mLC31I/uGsE64/9PxaDDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuHvIuxL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61dfa4090c1so78066497b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715645656; x=1716250456; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cXc5sMECqLyRKcbNINgEdeLmZDnFaOhVgOI9sZNJ29M=;
        b=uuHvIuxLL8N76Tt0QpsLmYxsHwtcISCMHSivCXZV4oPDdA7BjHzMlW7QRAXk1wlZK5
         GvG0ht0GJ9+i/5E3QGSteaajxAi2mj4hDIS3CkEMYZi0tPE0ClbwMi5c8Nnt4anEOaJw
         eYbXFTQed445y1awjdphB6M25hgw+kBeKSkzSoA5a8ZKz3G8kgh3C/8Un00peAjKN0dQ
         E5iQnpRq5YYPMl6e1Szzo4mCvVuWWkxqVqsTLVI6bx+1rrPXmyFTAI1OolLS/lfBGdEQ
         h3aeCigrO0DvVIjxm/6xCCWWW0/L2aNQ8R0pfS6mRUopwjF+UUZIF0sYHnAPccYBm4V3
         GiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715645656; x=1716250456;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cXc5sMECqLyRKcbNINgEdeLmZDnFaOhVgOI9sZNJ29M=;
        b=jU9kPM/QFJ+8GLBGc+35ETrZo8gZ2tDmZ4PYPIYueewG6cK4n2VC8Dy1AbTMD22csc
         Aex1azyw7k/Ti85fIeP8dFQVbRRwMoiz0uOAroM9n4WBbYq9fpYctIEbcbNwPp2TNTfG
         BlDfQH/HnvFMdoUyzLizfaRVzBSre2piFhTnPUYFWj6Js0gQAdhNhHzi+1pNG+dgergE
         lIiDT6zrxTouWmVJY1Q3gy3OxNhJneEM40QkRkpB9ByiyG6Ai+oEPlGrAb46UmNiQuNF
         AEhikPoRsfhz9FUnSzvY5020H2hLaVpKfmDq57SrZQvVlEz1ALvMPte/pohSouR+gvk2
         4U7g==
X-Forwarded-Encrypted: i=1; AJvYcCVD1CcmJ0oAhyAT1cDcUemRVdIdcB038+i/aQ858PQS5TJ+yVUfwy3yQb0bjs/L20FNt2u53v5yw1I2sy/wldnhRCdUFNeywMcrrWja
X-Gm-Message-State: AOJu0YwqsGv31D9CpjTMPgILHZ/HtDQKcc4IBzaLiuxxXWWs/PMmzRZD
	ii9Mh/hrcBQKuD8jB4hLk6yQQ0cCVyjkYXZc0s5hZzXBWwYMckKxwNCLA59GxRvETmoL052FGl+
	IIQ6nEw==
X-Google-Smtp-Source: AGHT+IHLSIDckp9FGiCB9B8xou3caJHCrjo8tS2qOskoEoK80K8YTo7bIXEOr/HFvihvKqshyWnhvYko00uX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6e66:3031:b400:2dc8])
 (user=irogers job=sendgmr) by 2002:a05:690c:4507:b0:61b:3b02:6901 with SMTP
 id 00721157ae682-622b001dd60mr27773957b3.9.1715645655981; Mon, 13 May 2024
 17:14:15 -0700 (PDT)
Date: Mon, 13 May 2024 17:13:57 -0700
Message-Id: <20240514001359.2882951-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v4 0/2] perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
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

v4. Workaround GCC build error by using unsigned types. Don't consider
    short hex suffixes as suffixes (e.g. cpum_cf) and test this
    behavior.
v3. Rebase and move tests from pmus.c to the existing pmu.c.

Ian Rogers (2):
  perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
  perf tests: Add some pmu core functionality tests

 tools/perf/tests/pmu.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 17 ++++----
 tools/perf/util/pmus.c | 67 ++++++++++++++++------------
 tools/perf/util/pmus.h |  7 ++-
 4 files changed, 152 insertions(+), 38 deletions(-)

-- 
2.45.0.118.g7fe29c98d7-goog


