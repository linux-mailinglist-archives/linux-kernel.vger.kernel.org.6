Return-Path: <linux-kernel+bounces-340876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D2F9878A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 19:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6FB0B27D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9F17BECD;
	Thu, 26 Sep 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqpFoIda"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81E1779BC
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373055; cv=none; b=lLv9/RDlrHQloFxmupc5e2mqJgGs+Rzw35DqPGnCjW4tbAgY7lpmKEVKYGflbftEfcpg6VRcwUxsPnQVuzwhyeHJhb1UHEKVzTttJkowW35uuMN0BknbN1JSQFqCRxxc9g7oQC/R8FR9VroueqmSn8g8UAbraN3SHL42YENSaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373055; c=relaxed/simple;
	bh=igdjcVeSBNdpas96QJTqhaTEvBNXZAj2tpTOV09EYxo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Bb4hoCXyvCK1BrC0NBSb4mU0VQW+h14GzUuQbQv5HnHHIf0fBlR7M1S1VVPlrd6Er5P5WWSKz1kKlObEkYI/uFmBTU/s4qbz/nEKORD/ZaFSoscdNpP1nq868usKL5e6E9Ki9keY3TpZBOAgMotXY/e9du/PHy93ziZg5NkCrzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqpFoIda; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6dbffbae597so23760117b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373052; x=1727977852; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GGQgy8ZopxkauWxHyK3qOU/sEGEKBL16T+Yf1IyLOIU=;
        b=fqpFoIdaF0c1UHgxFEjZKHGkOhhlx+lANROBMEUzHnywlGKVuq5x8/Kc4xHWONiwKP
         gIMOtlB7hWU/gUY+QNZq1S5QeJVrmdAPYZpCGqxqNX7w5bysUat25zjbqnWldYA12DoT
         +pOYAexxfGkapsiU8bKiN14MGarY9d1ipch/bQXfHUFyqFGXLec4aLGa3311/RHqDXQ/
         uzzktEFxXrBfY6qh58/Lx7kYDCwHyEMKM/oRu9aOzoy4lAyzjm4cPbKAtJzvqteHF72a
         SiIby2MuB8AqK1g5x9J3KE7z7uaqReriAcWjAnEpeC2zVOCiiPMuE5yD6/PwsJbpXJsF
         lC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373052; x=1727977852;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGQgy8ZopxkauWxHyK3qOU/sEGEKBL16T+Yf1IyLOIU=;
        b=NKTzDh0YzWkCgejkL2K0G8LosWlEhBDSi3S47phNQUqeuUgEnFPqzYGuO8ZQKboYxX
         uVEppgxl5OEduXjqWREUE4Tu/UEyDdcqoqLDj0Bi95HbJ72wwkTm5lRG0qL5sAdzKRPE
         /uE/pzEqOWCBDNtXr4yEcByPJgQefTbSAhfKm2ssGBW+kkPGWgzqyRG6IlYm8yl9Roe8
         /9gc9QOCTjqOCHvqsY3jy6nWqHe5MOX/dJoKCiUOmtNxG5drEGkCsPySjMJ10kxUFWaQ
         pmUdPfL1Xrqze5+C4EE1W4IkbK3MfQ98/pH+deD8D245MJ/kQopeR8xFnbnybjzfOz51
         bdjg==
X-Forwarded-Encrypted: i=1; AJvYcCURus9383FquWeBu7CEZhPm8HITvExNB9odLPtTJBTkGbHbWcgoKnKlGj50aumPfjVDvCsoGX1d1z1TsmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziJjxucFvcaE2C/MyFiWFu3myJuXJeAEh9gHmn7EQITMYVYVdl
	rTfGoxdEu/bIydk0uLXCyV6Sy3BhYtX5wBnSeI9HMYtJ2ZSOLXTJJmjrzi1qc/V1PS1CGggd9kd
	9/wJnAA==
X-Google-Smtp-Source: AGHT+IF/LyuuqNsHGggzUKI4CZBBmqUSsh5FFZZC1B7GeNvpGibPGbP95IMucWwg/4DOkUa4ywyqykhVl/uc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a25:884:0:b0:e11:584c:76e2 with SMTP id
 3f1490d57ef6-e2604b1a4d8mr290276.2.1727373052478; Thu, 26 Sep 2024 10:50:52
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:17 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 04/22] perf jevents: Add CheckPmu to see if a PMU is in
 loaded json events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

CheckPmu can be used to determine if hybrid events are present,
allowing for hybrid conditional metrics/events/pmus to be premised on
the json files rather than hard coded tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/metric.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 03312cd6d491..e1847cccfdb0 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -8,10 +8,12 @@ import re
 from enum import Enum
 from typing import Dict, List, Optional, Set, Tuple, Union
 
+all_pmus = set()
 all_events = set()
 
 def LoadEvents(directory: str) -> None:
   """Populate a global set of all known events for the purpose of validating Event names"""
+  global all_pmus
   global all_events
   all_events = {
       "context\-switches",
@@ -24,12 +26,18 @@ def LoadEvents(directory: str) -> None:
     filename = os.fsdecode(file)
     if filename.endswith(".json"):
       for x in json.load(open(f"{directory}/{filename}")):
+        if "Unit" in x:
+          all_pmus.add(x["Unit"])
         if "EventName" in x:
           all_events.add(x["EventName"])
         elif "ArchStdEvent" in x:
           all_events.add(x["ArchStdEvent"])
 
 
+def CheckPmu(name: str) -> bool:
+  return name in all_pmus
+
+
 def CheckEvent(name: str) -> bool:
   """Check the event name exists in the set of all loaded events"""
   global all_events
-- 
2.46.1.824.gd892dcdcdd-goog


