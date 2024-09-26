Return-Path: <linux-kernel+bounces-340852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C297F98787B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA91F214C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE2415B552;
	Thu, 26 Sep 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOWx3pwC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C23FF1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372470; cv=none; b=M/JZH3Twr31r9KGv5gLzMDP6Fbm11jzRtyjxyeFtakjEqtS2+RPcxp1Y94Up5T2h4whgiUi/+3xWFZDD24dPKgP3PyUSHE8F9pM9DJDVXfLIlNvz9Xhy8s6YtiBnzKyUAT6rqTTtreC7FfkD5NmioVsNDFbXg2E1fTkWPCp8rQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372470; c=relaxed/simple;
	bh=xYTvT/X6H/Jy/9lhvkNHbs0MU+Ds+5Fj0tHuRvF0PbA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=ro8PcybZQ2lLlYlLNZknrbKd6qAIfnI9BUmmM7EgACW/DzetPZDSDPW422IB5nEAH0iS5IbqcJjcQVHaI62IJpQaJzU8ngNl/z1Q94m9/xLpUX5AbisWiIkbZShfj5GQgKuRAvjRebB6735wp7n6WlW1TsX/EDL6MEyRGetGbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOWx3pwC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e21d0bfba7so24295717b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372468; x=1727977268; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GyH3SO1mNYuRldKvYuRf0v70ujcGsRvXTczGrayvKgE=;
        b=sOWx3pwCygy2my5NeBNTX9K9dPoYT3OSL4Y8b8w2YIij63xSFH3ro3xWm6d3KmQTNO
         8xv8/Jh9hANZy32Qq0P+RclCta9+63+sN5qwDsRuGfvNtcJLCu+AqNfqBqM4ebWO7+/O
         Q5FrGbnubjtw4h/PQDYV81+slEvrOtRfgGbpOrVGDOMJK2rF2WPfY4baYlAPvuwiV/g6
         LO7d3rFEjzUa/GH+aBlOgfeL2WVDxFETCfnhz15C5RtTYA/zMMTss0I6aD7kSxhW3rfd
         v59gJDaRM/ZWlk7hEFduC+T+jf1Av7SC532FMUUBYotMB6vqrCjJb54uekHbP+WdocSU
         OF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372468; x=1727977268;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GyH3SO1mNYuRldKvYuRf0v70ujcGsRvXTczGrayvKgE=;
        b=OngxZt3S96EzJwULOzhuWOVH9wSwl5CCzi/vbng8GyeWNcLJajg4Q0mFGJOfL2GB1E
         dR/CW0eCmOG901oE3xf3g8LS6ppFXt5zSG+tKPJ+PWAK/HoIAfzjU9vraTXg6NCiL7XN
         OFw2UNIw+ojBcE4IKojURObSBOrQwr+3S2LusjvMBBk+VuWTnAs13/lqjeLeCGz6EsQH
         BcLzBNP5dBgKX2PZ47V8GsO/V4LfFmTJfORXSKPb09JdQmepshIr56DtaGtftHYFpF3n
         07PrYZBl67UAR5ZtGDhUkrP/cCPBcNPTpzbnIY5QDs/KkuJA0+Lg/IoUur4VFZpllNNG
         ptcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDTZ/ZOmJFWLLB0df+WXGUOhx4pZXIsB0uoK8iAvYOU/9O8XY29AYzI9Xz+rkNEvFyL1orM5ZB+5M/wYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HX3j8efSL948bp9poWI8sLs9sVKnSwiNWmdCxMxWowH4H69q
	jBbaS3SCHel6VeR58xJnwOOKSgVKvU09eREIp9iMskh2bX52+2hbwqRZBPTaaAOOwW9uQNZjqC8
	HwVzNAQ==
X-Google-Smtp-Source: AGHT+IFtUX3Z97jE1thwb87+PLNbrw+/Ef5tJnpoOZBB123Lkucq8zRkpEkpb7eMlOOwF7DwYXFl8Cj4AYLM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:690c:5249:b0:6dd:bc07:2850 with SMTP
 id 00721157ae682-6e247600427mr11327b3.6.1727372468208; Thu, 26 Sep 2024
 10:41:08 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:40:49 -0700
Message-Id: <20240926174101.406874-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 00/12] Python generated AMD Zen metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Generate thirteen sets of additional metrics for AMD zen.  Rapl and
Idle metrics aren't specific to AMD but are placed here for ease and
convenience. Uncore L3 metrics are added along with the majority of
core metrics.

The patches should be applied on top of:
https://lore.kernel.org/lkml/20240926173554.404411-1-irogers@google.com/

v4. Rebase.
v3. Some minor code cleanup changes.
v2. Drop the cycles breakdown in favor of having it as a common
    metric, suggested by Kan Liang <kan.liang@linux.intel.com>.

Ian Rogers (12):
  perf jevents: Add RAPL event metric for AMD zen models
  perf jevents: Add idle metric for AMD zen models
  perf jevents: Add upc metric for uops per cycle for AMD
  perf jevents: Add br metric group for branch statistics on AMD
  perf jevents: Add software prefetch (swpf) metric group for AMD
  perf jevents: Add hardware prefetch (hwpf) metric group for AMD
  perf jevents: Add itlb metric group for AMD
  perf jevents: Add dtlb metric group for AMD
  perf jevents: Add uncore l3 metric group for AMD
  perf jevents: Add load store breakdown metrics ldst for AMD
  perf jevents: Add ILP metrics for AMD
  perf jevents: Add context switch metrics for AMD

 tools/perf/pmu-events/amd_metrics.py | 630 ++++++++++++++++++++++++++-
 1 file changed, 627 insertions(+), 3 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


