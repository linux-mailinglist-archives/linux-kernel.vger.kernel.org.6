Return-Path: <linux-kernel+bounces-172665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B48C8BF511
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C34241C2304E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 03:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7414F65;
	Wed,  8 May 2024 03:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFWc5Iuj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D499B1427E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140394; cv=none; b=Hz1ukN0vrO8vcvwWGmzVcVOCRuVsaBWcBAZu2zmf4+AU6ROV7dV7F+iarwr59kVWGA2sAgC26KyftXeRL+vCwbO+y4GEN6jeEngr60cFSPaPZtZmH0I43p3YxlagpT7oKkwjk5NNVVP+xY9m/VZgLRfgHHz3RCsVZ0ewgTb1zxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140394; c=relaxed/simple;
	bh=ROPg/gfI2eavy9Z1CPY638eJak5zjeWpfDVytTAIiTE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=adSfKsMCDehXEpqsjzsDF5DEe4V+4RTL4AKxK2W0+NLD8DK3sws6aZ6O6xW97QJK1YLpx22NQUhX6+GfV/5nWrJaFOQLq3W0JAQTuAqL9s54fR4TSWemt8PBudWK1zsp3D9AKwevOTfdSdy2DWoWe/c6w9zMJB4zyGP0XqhciYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dFWc5Iuj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61e0949fc17so73085137b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140391; x=1715745191; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mufc51TKTvUTkAvo+jJkjhWq+JDNmar0wgLRYKt6Lnw=;
        b=dFWc5Iujjrakmamh04ul7wfeuL1tbmoMQX/iZLg/wUlvTtwt4X51eyuww/GHDVLvp9
         JgyHeg7VAOUuHQWHxRMsll7mthFr1TuwgaanwHQruIi7v42dTeWTgBzDelmxBbdkwnMS
         lepr/s/D5JfVzl4KJxxJ/+c1Mzw5DG5UEqbX4zmomHHj28+/hU7Kfq+2Grd8yIejc04S
         gsiYj1MPtBdJXkJDI2Xr0vI9uownUSuov7gXi0tuRJc6DR6/cEWadbe2252BjKTmNgTY
         60l7iQpF+wlys6S5egSzMlBKY6RDk7vMm95qouyDZw+aFGRXtkwD+ao5O64r6zLtJMrf
         wiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140391; x=1715745191;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mufc51TKTvUTkAvo+jJkjhWq+JDNmar0wgLRYKt6Lnw=;
        b=vzfaHdV9jkOsa+XrOD0rSJIwD3SFMwytFEdKhgvusaoGJ18LepShwJCVLPDVDi3E34
         RRu3qMUqggUJ5DT1saOsWG6Dml395H9Slwdg2pXGVbBb4oWMa4+4uzzyXj5Y8midgGZb
         NaLgeQvWM3aUe74TWL/j58//UYVdTK/d+Nj0Be+Z+xfkrPWwrOlxtK6oDEaf1rQ7m0/l
         ZPBiXNgVESv4wNGR073jIqGtuBuc1+99Ui04dYlD3JTJATh+pR+MEmZKHPbiuibFyghi
         JH50CBBP9q7vzxd1BfPvLQyeBPzAjPFV7fd+5KrlWrPfxJgz8LxPkC2jsH5vkn6o3LCT
         lhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY96qX+F7uo8YpK0kWXImbcpLXMNNhlgQEMZOhaMYObm4DLQUyXFNO8JSKlMRCmeXGjocdqYwiI6qa597IWtqDUN1FIMklfaLrKbnC
X-Gm-Message-State: AOJu0YzF8FWMRba082lOBHZR38gmqaWIE4oDKu0dIdKf2DfQ+w6sIvoM
	5tLZAYWN+VbUCls6pcIrJfj2/eXIqQ8W2eWOXekaPt7Af9yf7C14b6UR4UHGUFkmOP0AlgJtb4T
	8LUNkVA==
X-Google-Smtp-Source: AGHT+IEig+LG6Dz276JK7E7u4akAR3x+i2ywHtItBHE9xxlwABAkOAUt+KeEphX6wlCTPwCgxtBd70QZTXQF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a0d:db05:0:b0:61a:d0d1:1813 with SMTP id
 00721157ae682-62085a332d4mr3619277b3.2.1715140390933; Tue, 07 May 2024
 20:53:10 -0700 (PDT)
Date: Tue,  7 May 2024 20:52:57 -0700
Message-Id: <20240508035301.1554434-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/4] Segv and RC checking fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Resolve issues found with address and leak sanitizer by running 'perf
top' and 'perf mem'.

Ian Rogers (4):
  perf ui browser: Avoid segv on title
  perf comm: Fix comm_str__put for reference count checking
  perf report: Avoid segv in report__setup_sample_type
  perf thread: Fixes to thread__new

 tools/perf/builtin-report.c |  2 +-
 tools/perf/ui/browser.c     |  2 +-
 tools/perf/util/comm.c      | 45 +++++++++++++++++++++++++------------
 tools/perf/util/thread.c    | 14 +++++-------
 4 files changed, 38 insertions(+), 25 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


