Return-Path: <linux-kernel+bounces-340840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DE898786D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2282BB28189
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B289A165F1F;
	Thu, 26 Sep 2024 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZNDeVfJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0494156665
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372178; cv=none; b=pkeBZBhAE290rx9c1MY43a4MmXYgg5gXu0D7rjmUCnKY9l6xJPRU4slM/RNUL+45Yz+R2KIUXjTU0R9Qw0hmUXwFrmVFNKDHLafqdtzKoWjG/jPGynwgrnpASFvcePTF2Wm3bgR0OE5B+5rfbsoFCcStEiFzkEMTYgmUVNBcMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372178; c=relaxed/simple;
	bh=M99U/TsRjoC4o8Ub8ccQQEiFuk+6w4FbHCS5wDw6B/M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EG0A4Ol2mrLVLRfCX1LssN0LV0QgrwxhKIBwtk9JWWAD8It1IWQr3P1nOmj3r5RA18vnxINeUv32Jnm4d5qiMpdfhWchFhcBnUwds/O9msyMAihgAv/Mlv2OJwEd+LGRKAZ6WTWrwwGGHzrNrqlAo6Wz1wR2D6SsotbOTPEcDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZNDeVfJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so26070757b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372176; x=1727976976; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6d/FOySDNNTFXzgASGTIFb5rx5kn+XWz56YenJ+UerU=;
        b=2ZNDeVfJf6jPZjfrBnWqehNI/lWI0cS8ilVgYaEWrILsTZAgdTtQuqRg0w24qPssp2
         WLB5eSrmacpOpaLvAti7ZjUirwRDKkpB4fK7S68kuYOmMKehPXH1hyL2adtup81W4/wT
         25bOCBUmrZghk7XfXMgptgTxoev0lQiHy1JRABr0m1+H++i1QjuFtxztTRBOYgC4CHq9
         M3rTafEFKbPcn0gjupsj7BdrTa9jzuFpR9k0ji2BtK0CWDtZl6D8swdpcifva0PtEiVt
         Kcv1+/4SNPpObVlQ5OgIOy79MnJjfy4TY0VSx1vrw631EpVtmKuRxmkSiY4qbTyntkzR
         I93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372176; x=1727976976;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6d/FOySDNNTFXzgASGTIFb5rx5kn+XWz56YenJ+UerU=;
        b=fsc/AFWvoX6riIKm3EkSaE2uhQPYhHe9ZMg+8VQJOXBRVRj9IRUJH6Ut+9KAbaVD9n
         Q8ra+y9UHxOkrR9ko/UvWTgF9h39Xhvj94UJGzKBFR63DvQ/8KjT7r2SN2aQUfmoCIb/
         B0WU5VqJS4Lp8MUqr/VK5wvhJD+91KeJ6uQIoC4jUCmG6mCIepZev4PqfXXEi00XDqA1
         vHuXCXiclmKBDefnBUuOgvAvU5474vezObmTmgt3V7dBSvnM0ZNqKEHmyQx9fu0Z8Jz0
         m16TJC8z0I6OXZHd4lpDE5O9iayPfVYfVBm/nW4AyNPBPkN+jUUXeUqq0dis+1sRDhRY
         RIfg==
X-Forwarded-Encrypted: i=1; AJvYcCXC8wN3XVI2UqDV3Nq8Pipza5iEKtD4ADm0mfsTd1BFKi35kkHUndajIFqTiFxGS2Vl+lEo7JsyAGbNIEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rALxcp3LQGf701D9iThrqwKiB9SNlfuJL+SWdE23Qb4BLW14
	DzCUwRwD0t8jhWadmk10qgRo3nCM4c3fF2P9QakNkaiX0oEzLr6FtL2/B6cfDnVJnykmnE780wA
	1fvv6XQ==
X-Google-Smtp-Source: AGHT+IFy5j6b6E61WtCzGHx6ximLIJ6qOIMeGqheO8aFHvdx/oRvCBkswdXue/hoIdyiuvY7LgQbTZtvj2Tt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a81:e346:0:b0:6dd:bcce:7cd4 with SMTP id
 00721157ae682-6e24751a289mr10547b3.2.1727372175765; Thu, 26 Sep 2024 10:36:15
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:46 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 04/12] perf jevents: Allow metric groups not to be named
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

It can be convenient to have unnamed metric groups for the sake of
organizing other metrics and metric groups. An unspecified name
shouldn't contribute to the MetricGroup json value, so don't record
it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 1de4fb72c75e..847b614d40d5 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -455,7 +455,8 @@ class Metric:
 
   def AddToMetricGroup(self, group):
     """Callback used when being added to a MetricGroup."""
-    self.groups.add(group.name)
+    if group.name:
+      self.groups.add(group.name)
 
   def Flatten(self) -> Set['Metric']:
     """Return a leaf metric."""
-- 
2.46.1.824.gd892dcdcdd-goog


