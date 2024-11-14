Return-Path: <linux-kernel+bounces-409739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE9D9C90B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F666285202
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C8C170A1B;
	Thu, 14 Nov 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZEVpWje"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926BC262A3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604998; cv=none; b=gdX+ww4FVwvLMC/Y/aIOE9lAQCGlsBcjbEZarZ45pYMtSTAUmFfXms+Egz0xvBr7cmeZQRXjpeo5kD0bIm1ETgVXGZiq7ymwbP9u9ians55VZ8ZzEtJ5my1ggGEb20nxKuVFxGsnl1OzvcyyaWjFB4javTwEqdpXeb9rzfYviWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604998; c=relaxed/simple;
	bh=ko2Y5hL0e2UtOm6NPkx3iyMACXarcDuUvdA8EJXyZho=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=QGJtUtkz/vvPELOdpe5f58bGtlCS/c4HVxQlZXED0VgCRxzyFzxp/ZSZ8ZJxJGJDNhkKf2DZHAt6xSyoU2pryfhKyq2bMgtIw3plZK9jZrmwxH+fXUy2FietEz1fqN91/yrMTSk+1O7OCM77uSgPkjsHmxpfyV/CoSkk+j5bdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZEVpWje; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3810bac8a7so1409367276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731604995; x=1732209795; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tplORWF4lB1kFcLT2S9umn6jTJHAtpwJjn+q05Tpaww=;
        b=FZEVpWjeAB5Jx0BO47tt0DcGaM5gvYFwJLwIJw/8gYcVvVacMSjOejCFJ2s+z1VZRW
         QphzPOcDO5Xr8oWJsrh17onjmQy1jMuBBwOKfjZy35eJAH4yLSn61PCcgTZpJAIFGvgw
         5NTQIJ+0ct5vh1ruoxD2/QQNDfCnn2BCFYUnf+6OcyalVHbwpfzWh29b3dEgF0HvPos4
         TD3OyFS5Kw24xBhEp0i3HlPN7cDURw5a5PfN2/AsvPKBokfuGpnIQ4vTByZU0JR8CVwL
         O/Pto3NM52BIDG9g5CtztoBhbAKSELiIEKGMu5Lu0nNVe/1jc+RvsHzqZAIyjBLmgLqC
         MZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604995; x=1732209795;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tplORWF4lB1kFcLT2S9umn6jTJHAtpwJjn+q05Tpaww=;
        b=pIl4Ki29SATkmuv05shhvtipyTbfSj5dn48sy6yu2H1hpk94IR0XRIfnjK3CFuT9dB
         Y/6BbeFVegYV0JeaFHXk8r5UuK5P+B9/pGy3j49h5BBNiiA3wK7sXVIYHCmbrwwVz3xf
         9hJIg1jXxRcc99vKSXMUYrvpcE2QK5DoU5bfFU4BO0fLoT7Q3a5pI0L6ngbgjeoNCayM
         es8cenT4TPb2V0dwkftew0nBzbGFl5Qaw0XpJ5sLrUsfn3TQDLksrs1Tr+zEhQCHVKy1
         wmFEFy0Q1zuSFB2wc4EuZyD11+OfDnfi30nMNaBdXW31B5hW2XIC6wSq4cAg2WbJ0f1X
         pPlg==
X-Forwarded-Encrypted: i=1; AJvYcCVXcHjlLaMAAfqAH+o+SLl2cdCADl3njnms5tSwOyPujlqTHJCEdYxe5JOHl9w9J3UL0mWCm0bqvOClV7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJiAeU3rpSAB/VAkTBjU1HfM4W1mnooYBfYmt+bTPBBpgzq+c
	EQysCfK7C5cQhfmNmcWLX3tqZHD+9woUJbSz+5XCDuKU9aCSWAbInZi6OUxXyl9YxEKKFeIdJC/
	EohVhLQ==
X-Google-Smtp-Source: AGHT+IHTg382ptONqMV1SS8JKIAl4lNuXyiud6OAb4kDx+ibv6p/sZ9M05mTWNZeCCMRd2M3fgfap7YNawpF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7595:be86:b969:ac41])
 (user=irogers job=sendgmr) by 2002:a25:5846:0:b0:e28:f35b:c719 with SMTP id
 3f1490d57ef6-e337f8cadb7mr183397276.6.1731604995674; Thu, 14 Nov 2024
 09:23:15 -0800 (PST)
Date: Thu, 14 Nov 2024 09:23:09 -0800
Message-Id: <20241114172309.840241-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1] perf jevents: Provide better path information for broken json
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

If the json input to jevents.py is broken it can be problematic to
work out which particular json file is broken. When processing files
catch exceptions that occur that re-raise the exception with path
details added.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 6e71b09dbc2a..caeddd939cfe 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -461,12 +461,16 @@ def preprocess_arch_std_files(archpath: str) -> None:
   """Read in all architecture standard events."""
   global _arch_std_events
   for item in os.scandir(archpath):
-    if item.is_file() and item.name.endswith('.json'):
+    if not item.is_file() or not item.name.endswith('.json'):
+      continue
+    try:
       for event in read_json_events(item.path, topic=''):
         if event.name:
           _arch_std_events[event.name.lower()] = event
         if event.metric_name:
           _arch_std_events[event.metric_name.lower()] = event
+    except Exception as e:
+        raise RuntimeError(f'Failure processing \'{item.name}\' in \'{archpath}\'') from e
 
 
 def add_events_table_entries(item: os.DirEntry, topic: str) -> None:
@@ -1255,7 +1259,10 @@ def main() -> None:
           item_path = '/'.join(parents) + ('/' if len(parents) > 0 else '') + item.name
           if 'test' not in item_path and 'common' not in item_path and item_path not in _args.model.split(','):
             continue
-      action(parents, item)
+      try:
+        action(parents, item)
+      except Exception as e:
+        raise RuntimeError(f'Action failure for \'{item.name}\' in {parents}') from e
       if item.is_dir():
         ftw(item.path, parents + [item.name], action)
 
-- 
2.47.0.338.g60cca15819-goog


