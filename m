Return-Path: <linux-kernel+bounces-340846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C614987873
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03288B29E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E953615A853;
	Thu, 26 Sep 2024 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQEx/nho"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7B183CCD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372195; cv=none; b=WAijX3sKOhqzWCqY7H6lQYidcSyiqoQrXiuHk5hPazR4S/TZyvtVzWQGHvb5pjihwEIq+XIQa5WgRpFSK3HHtAbuEWS9PhTZlAapzbVRQAVl3FCxTD1ZilRPrMKes3kDCjG+ltPJI6tnLO86biz7rpfRqeHIHHz5CaMIRzK+psY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372195; c=relaxed/simple;
	bh=fI23lg2vSD0PJe5j7dtsTs9wlvKu/gvHpzMuGdst40w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SQhNjkae+y7Zrpv3BSJOBx47P17iVki0EfbR6LoxQAkROIbVWx/OVV43ihnDGh5R5m919Jnrxcix14Ohg66L0Em4yHGB+TyU+O+5QwskZUtRmcevb1aBF+q4KkZBJCbjAKTpS47dzHza0LEsQwkUoSe+8ZkKtwUdFNVwk+bRH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQEx/nho; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e25d494faa4so719447276.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372190; x=1727976990; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a6UDuHGKMWgBm1lEl1cmmS7v6p/aZimzfV7mPrGbWXw=;
        b=gQEx/nhobTYi7Sbnaur5EvXYZkUe3oLZywROy88coGdMILCqiEhYvrwHh2mH3XuTT7
         TNGkR0CwG6hXSfx5TMWgJ0fNLyrBO+AXsmT4lZ7m8fp2tT/nYsq++q0jLwMS+tYSpJsG
         0l8+OoazvZNEnDm1WAZhWkPNANnoeI59CLzlJrSlq2Yu/PHIT5Ff1NPuKqD+frMGHVVE
         nyeuT9QoDbmE/em249CtFSHbYd4dHe3KfXV5+BechpWL1EMBQtxtj5uz/bCWgOaEkv6u
         urtRi7Q2SSJwPStziiQjRbJrS5KXJdBeMeUQBILzLU979xE4cmc1wCI748LwflGK6ieb
         BZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372190; x=1727976990;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a6UDuHGKMWgBm1lEl1cmmS7v6p/aZimzfV7mPrGbWXw=;
        b=f7OOKLlGlgcjLEdYcAeaLPzMo2CxSlze6DSzisYAzNNL2saWaSmHYyeFwOJbsMo+bs
         gnMiW4qSzK2zy7GGQc0stm+N7RhDdxwkiLrhyJJ7FEwRF73EnG0CBSyURKrl2JiV0UF9
         sHZUFpZMS21DIxz2YUcpK798Pex/C+o2IQudltWa9rJuGSNuVpkD1FrblcRhDiC36X6u
         DCvmPOZBW0P/R7nsrJ8k8UFkDrmpxExFGqkcMa4MAl9zqJMLhWkloxWM6qq5zdafmCyL
         HWgKDrdNBpigItc9Y5RW2XXYuZt/DLG0ty8r++MhsbRdIK0qaaAos75O0JLywB5/NAXR
         2xsw==
X-Forwarded-Encrypted: i=1; AJvYcCVoiG93gSJ8Nw7L585u65+anjxTvoU87vqZD+SE0ocCxHnxa0QhVxlu4AyKpqDUaM13eVv3xHXG5lZZuGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KSw2RAUSPLitnJ4UJXGeS1PI08WVzhAWmJrKbK4aJOum9JY+
	8elCdrRuMIULNne29VSpNpqCu1FI2/R+/S2/k1kWkLh59h+pPR7LNwSJHhdtAFBiyE1HIYwdBTX
	2BcAliQ==
X-Google-Smtp-Source: AGHT+IEQ1v1udEuCVrnBHWM8Chy/nN8/OC9iN2ju/Bd9VgTTXhMcCxeiRvBecFcpETJs3lIyyiKunBEaUEPh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:d6c1:0:b0:e16:51f9:59da with SMTP id
 3f1490d57ef6-e2604b79520mr174276.6.1727372190471; Thu, 26 Sep 2024 10:36:30
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:35:52 -0700
In-Reply-To: <20240926173554.404411-1-irogers@google.com>
Message-Id: <20240926173554.404411-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926173554.404411-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 10/12] perf jevents: Skip optional metrics in metric group list
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

For metric groups, skip metrics in the list that are None. This allows
functions to better optionally return metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index b39189182608..dd8fd06940e6 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -493,13 +493,15 @@ class MetricGroup:
   """
 
   def __init__(self, name: str,
-               metric_list: List[Union[Metric, 'MetricGroup']],
+               metric_list: List[Union[Optional[Metric], Optional['MetricGroup']]],
                description: Optional[str] = None):
     self.name = name
-    self.metric_list = metric_list
+    self.metric_list = []
     self.description = description
     for metric in metric_list:
-      metric.AddToMetricGroup(self)
+      if metric:
+        self.metric_list.append(metric)
+        metric.AddToMetricGroup(self)
 
   def AddToMetricGroup(self, group):
     """Callback used when a MetricGroup is added into another."""
-- 
2.46.1.824.gd892dcdcdd-goog


