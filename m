Return-Path: <linux-kernel+bounces-340843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD8987870
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072AFB253A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C945F17CA19;
	Thu, 26 Sep 2024 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwTaSzPC"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652417C9B3
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372187; cv=none; b=CN8ESv+g/HbyCpQstIJy1XOSMyeVgPizWFdBSfHg3vquhIyVGokvscZ4ORdVihbDlgIxg2BmYVASW7dC70OeZQyTduOCNuy04SYw7M82sKRTSScN5sq9Nh9snPjd8PFT8bNOGeI+lgq4G8du1xRgOQQcCzF0Vg18AdqcXMGcLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372187; c=relaxed/simple;
	bh=j27L+GXsZRPzyM6oYjhYvobTFCzvOew+QVZrvE5Qf/w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=IEgKbF0b3iAxqcHiAGxJJGy4M7IstE0KAw4Wn1RlFDX7ywLhty+YH4OHuRNEa7DaI2LSuJLGXpiWXZ2SNLsupTRxKYN5Cs18Uh58/dMufdnS4eY6vI/fRXcKdWrLP7IMXYFOueXRKyABt2ggqFCJkRBpWemOKArhF3ePxzGSXLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwTaSzPC; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so1990609276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372183; x=1727976983; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khk7+EiEpOodwHgWTt1yX5x0DBXiet2yqtmzphl8YmQ=;
        b=WwTaSzPCy6hsJN38tXzZ1MuPMPo3BpZ6SIMVAAizB5BpNFSryPDYNcFfDkFE5lBt6w
         CmlT6A9tbFJwIZuGHnV79GpUYRto9R9w6e4PN1z+b0JkjczA5V9tcdAaRcR6TAhMeU/+
         NG0qqTYHqD1Qt9h9mzrfW0urD/6VzILu1oPFyBDs2vyVNRBfGY+D/a3zjvUOCZawXYSK
         nWV1/6zQPfJJUDTi9xa6eW2P6FjesGsWlriZZvBjTVwkR6Tkis7AddOBtpiqEYiPJUmf
         hsQyhOu7HwhF7ziLpRc2fZlWKGjoWXP71pSVd/8W3pdCvsPr0nGNXo6Vl1hXBFEwFdeM
         Dy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372183; x=1727976983;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=khk7+EiEpOodwHgWTt1yX5x0DBXiet2yqtmzphl8YmQ=;
        b=T1TYfFkKSY3tH0qxatCZnGn1SH/opxRV2qnJ81sdXeJqgi52dJc22KD1G6KeGjdyzH
         8tuipTCk5SlgPNQN1Kpd9F3vsRorfIh4AdONX7ueIw/vBevasNZC7gLMQVQfJBNjsE7S
         laUUjjAK42iUSeGtAMu3Evh4aFF8QsgRQyMy+L6If9rWSOivMT4cQeLhJDdNUSyQzpBS
         doJVaMTQSYiCqsloO9khe0KLN1i4fhdDD7Fu47ofkVyDqCTUhg1GVumuiscFGJkFCime
         1FjYfyazMZylKGS3CqmqW+fffIWMrdRyiP4SZkFgxvstbazc97xjj8WBl85DQT92BUVQ
         CZrw==
X-Forwarded-Encrypted: i=1; AJvYcCUAc4H26wzkEupqGGYi9KIGl311UVdvLhzTiFm6D7ZCt2W3gce+2pJ9VYXlNxY3A5H2key1LaCva+enwqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0FdlTe5DrbVaapz2dJEKl1rDwj5WC2Dvk0hgWpk2FmA/yo5fA
	6kEjn/IVbPxx2lIVIb7gLxlodWWGA+Efk6Hy5DGIstSaSHhVWnuobyoGoZ9NQT2weG2i770QOu9
	nwLBQvA==
X-Google-Smtp-Source: AGHT+IGKMpzXcgy3KQv4XDI/gMP78suYWexjnA14h0X+xSwR4o+sg1dvELNMVAsvj+AX4H3FE4TfaRTTuSHX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a05:6902:b25:b0:e0b:d729:ff8d with SMTP id
 3f1490d57ef6-e2604b3de26mr103276.5.1727372183273; Thu, 26 Sep 2024 10:36:23
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:49 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 07/12] perf jevents: Add threshold expressions to Metric
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

Allow threshold expressions for metrics to be generated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 0f4e67e5cfea..e81fed2e29b5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -430,13 +430,15 @@ class Metric:
   expr: Expression
   scale_unit: str
   constraint: MetricConstraint
+  threshold: Optional[Expression]
 
   def __init__(self,
                name: str,
                description: str,
                expr: Expression,
                scale_unit: str,
-               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS):
+               constraint: MetricConstraint = MetricConstraint.GROUPED_EVENTS,
+               threshold: Optional[Expression] = None):
     self.name = name
     self.description = description
     self.expr = expr.Simplify()
@@ -447,6 +449,7 @@ class Metric:
     else:
       self.scale_unit = f'1{scale_unit}'
     self.constraint = constraint
+    self.threshold = threshold
     self.groups = set()
 
   def __lt__(self, other):
@@ -473,6 +476,8 @@ class Metric:
     }
     if self.constraint != MetricConstraint.GROUPED_EVENTS:
       result['MetricConstraint'] = self.constraint.name
+    if self.threshold:
+      result['MetricThreshold'] = self.threshold.ToPerfJson()
 
     return result
 
-- 
2.46.1.824.gd892dcdcdd-goog


