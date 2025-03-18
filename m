Return-Path: <linux-kernel+bounces-565438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85DDA6681F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27F4188F303
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F58D1A8F7F;
	Tue, 18 Mar 2025 04:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IvSVYaWe"
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A3C4A07
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 04:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271291; cv=none; b=ZsvTLbnSQUQt4XTbr81Irc07du8XkcGX539AGnmDZwkiIs1JUh8H8SoACmFrZyDtKQ9l+7htC6SQB5l/lZPGZzl9L4BghESe1iXgvF9SY83zMaDwUUR7XnK/FczCs+ULpGbShgINT2mCeBVkGvH1zkkucz4eAX6nuG/GJYAisgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271291; c=relaxed/simple;
	bh=vwSuIOLnA/rA924Wx5C3CE/x6rCE/KXg4XsE4o0zr/0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=dKlfLs05GrQ/VNvdfdJP0ihugB2eom92+vf/OEE677yNa7PFk/UXRdYT4l+1Y/MKK1HTB89j+YGBxRvGr1xfdJEHYxHIRex1CQ1XAgfXtjX8Gp3YjTGNgavcAdO/+LknTwcTstsg+9D4IO4pma2T5AuDcBH6CvvEv7iKsSvrIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IvSVYaWe; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72bc289077fso3077198a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271289; x=1742876089; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c20EfOqMQKLLNq4NqYo5a2mSos1RhsSfXPB0xScr91w=;
        b=IvSVYaWeg+Gk9xST/rH2zsqtkCMCqi/qT6FBpxsMrKDtvh2p/Gc0mRYce+VFZgevSp
         VzU2RHUHHs+++tlsc2jYhVoSDndg0p+NkUm59kYHVHMoXylMAFeBS3nh7PKNbEDVklCT
         oUXZLwlZlAUAVjJoOlw/jvqIf4SjMP8J18HiFZ5tR672rZwWy+Q9gzTmAWYPY+sZ+Sk6
         XcXkeHiuFBBUVLwVt0e+NWSOLYHZL2uGUpMgktyfbT3ceqChUrMGPoJ98Uju5WkoXImw
         X8F1ik5modic1vjIS931LV0TmGqsGbUe6JLUg889Gtj/7O2pyOpL/d1OCJtcMmdz40XW
         w46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271289; x=1742876089;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c20EfOqMQKLLNq4NqYo5a2mSos1RhsSfXPB0xScr91w=;
        b=VLis16dPU2BM4fdtrf+wEgIrjwJ+efQ5GEL4BAqjUoJZ0PNBa2OWsQpp+HX3few5mG
         H+b6ZBn20BW0IL/zZm0/TIUWcjEMsC0bUtL9BO0c5KNLhwjdYwwQsYb2wXqVSdHbW46W
         54sZzkuHZBYbBUx+EN6tikK9FsLYRTB2MUfLYrtv3F3tsCsjT+xiiA98dR0JCGCXsR29
         KY2ZaOp4KuCoYByD7NChgmygXDBpj0V9DPuCU3K0wlN+QJyr4hpzhGgwKjKCUK5nii+5
         GYL36aHErtQ/JNTme1ITBPEyMBtwkVEMYeR9c4gH0D9IoVmd1X1WgBEB/M8Zm9NuRWmM
         Tn/A==
X-Forwarded-Encrypted: i=1; AJvYcCWlRjjFDuN8w3dqeoWeJis6at2Dlb4pwAB0TLThsJRrZNlJr9eqlG1i/SN1oThNr92tluP6hL9kWWhKWUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8Y8AjyI9R5IJC6FZFHpFogyplDM9dGkUEdP6p8nv3Y2drDe2
	lkBc/+OM+H6StmjFfiSu828m6OrZQu6kRyLXNDyR8rCtsWbA+zjbPCnec9bHCQR5yjktU6yFSWG
	pS7XidQ==
X-Google-Smtp-Source: AGHT+IGaOr78+GhG1WlKZws8Pa/ebzKJC3cZj3+kb1BlNLwSchDT480SwwYF+ymbNAiFm3qjQ7JB6ePxlGFx
X-Received: from oabho10.prod.google.com ([2002:a05:6870:498a:b0:2b8:431f:3a1d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:6a9a:b0:727:876:c849
 with SMTP id 46e09a7af769-72bbc6613d9mr9830264a34.27.1742271289169; Mon, 17
 Mar 2025 21:14:49 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-1-irogers@google.com>
Subject: [PATCH v1 0/5] NMI warning and debug improvements
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The NMI warning wouldn't fire even if all the events were for one PMU
type. Remove a nearby, and no longer useful, mixed hardware event
group function. Improve the evlist to string function and dump it in
verbose mode after the reordered events warning.

As commonly happens legacy events like instructions will be uniquified
to hybrid events like cpu_core/instructions/, even though the
encodings differ. To make this correct either:
https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
or:
https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/
needs merging.

Ian Rogers (5):
  perf stat: Better hybrid support for the NMI watchdog warning
  perf stat: Remove print_mixed_hw_group_error
  perf evlist: Refactor evlist__scnprintf_evsels
  perf evlist: Add groups to evlist__format_evsels
  perf parse-events: Add debug dump of evlist if reordered

 tools/perf/builtin-record.c    |  9 ++++---
 tools/perf/util/evlist.c       | 32 +++++++++++++++---------
 tools/perf/util/evlist.h       |  3 ++-
 tools/perf/util/parse-events.c | 16 +++++++++---
 tools/perf/util/stat-display.c | 45 ++++++++++------------------------
 tools/perf/util/stat.h         |  1 -
 6 files changed, 55 insertions(+), 51 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


