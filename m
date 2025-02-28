Return-Path: <linux-kernel+bounces-539554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44739A4A5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4586E172879
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD151DED43;
	Fri, 28 Feb 2025 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9S66EPs"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CC1ABED9
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781433; cv=none; b=gqzH2TtV2SCz7M2G0hBNwEI2mL35gxUhWnAHpPh9MCXFymX8oSZX5thc+/MhpvqtT1d+aTMcFLG8q4ZzHxipJY824JyE7ptSYg+hEmtjWPENfeS4KhklLIwkPCNfrgz0Nd7nYDtHsYZuhOLxAFIlx1CwhBan7lD4NLTqvwTvtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781433; c=relaxed/simple;
	bh=t5obstzOsFYHZQMeUlh840zqrWOvu/IZWSg25oxLlQw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=KAKJNp9VF0TXcxqPAml0MJge0IYGsz+ojUTN+MQylxQkPu2njDCcDhWzuBvsoflkHxxD+U1nSLQX5jcbnot6jUBuvufKz50qY8xTdaz63GJ5n+NOeuLr37iMuKeL1mgKDoz9jsGfJapJ5bCOMmlG7MRpDMZNKTV1KU/Z7ka5OSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9S66EPs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e583e274095so3072657276.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781431; x=1741386231; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1gaG8MxbaAldmJlxoU3EEkJb8EuBrTpS7RMIu6uThJI=;
        b=R9S66EPs5txJDHZJRFELkQx8sX8HqW09/2bgOBrLpIWJ0g3kIeWu5xrSGtAmT+XOAz
         IyEw52yJosbmL4fsTJK1OqvcCx+Kuk/8XlIWThmU3ikx+5OYGXhPZWsAwTHYieNXha3v
         F+im59uZ9goTq9tcIqNDpRl+5Ehbf5SL1pXOmvjTxcxpTfqekLVvnyaNtmmiyxc1HjqL
         e5qOoz78I7KpA79ME5v0X6E/idWDLl4mQFYoW7joKtDHAltK2xTuhFpzyKbMwP4cYjyJ
         tSmgb2QmEld+E1+7Y/do7n9jBcZpEMzbsashGaL8dbWXZz0ur4DvLrb95RkguE+1w8zI
         Aiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781431; x=1741386231;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1gaG8MxbaAldmJlxoU3EEkJb8EuBrTpS7RMIu6uThJI=;
        b=LxUmPP8hMdLJg96TfC7EyTeWiNxt3DUgSFLKPDlxdzVYsCxy0kDcppRWJPbzWq+hD8
         O5UyO6mmtfA0VN/zKkdUPJHGANqxC/iP8juvPF0BWW1fj+ZzWidLZA9YcJ18ZI2XAl6k
         QWe/GKlCiT3TgqHpciH1T4f/yVrF5aXmWUgIt8xhua5bpimvKePGIojcaiCnY5QTuo6i
         1jUOILBmWQr1LpEifMRUeSV9DW8Xth/S6s7bjrjR4YTWS6QeFXeeMWHTFEa6BlFl6luj
         y4tSqmepuOKp2rHX0b/woJupCRGpMYS0ZMJcQxlWWl7IKMooc4CkRyX3/UhzCGjaPf+c
         08ew==
X-Forwarded-Encrypted: i=1; AJvYcCXWz++kQMzwuazHGZNwuni+e9+CmeZpG77+uJbIZ3a0QVZnjeadQ3py24Exbit2FAixP/2ALuB8LbZr9b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWVp0wSIWdItRSke22mbMErDM67MSC23qUimtXciLLWFEVxpR
	6sY6cCHazIC/j201VH5vz/GWpz59wN5vOJc6TUlOWCppTpUISRKK12xT9mFce78sWsEZVjRHC7Q
	GmQUOLA==
X-Google-Smtp-Source: AGHT+IEO8S8uc3Pu23GUjCfLISxHYBj4GGmavUA+KxZLvnODKz5g4cAro5i1QbvxsUJyyjyVdTINfVJka6we
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a5b:b43:0:b0:e5e:fdc:88e1 with SMTP id
 3f1490d57ef6-e60b2f347b6mr513963276.4.1740781430772; Fri, 28 Feb 2025
 14:23:50 -0800 (PST)
Date: Fri, 28 Feb 2025 14:22:57 -0800
Message-Id: <20250228222308.626803-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 00/11] Python improvements for a real use of parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

While parse_events access in python was added, it wasn't used by any
python script. In enabling this for the tracepoint.py script a number
of latent bugs and necessary improvements were discovered.

v2: Fix a whitespace issue on the evlist.config patch spotted by
    Howard and add his reviewed-by tags.

Ian Rogers (11):
  perf debug: Avoid stack overflow in recursive error message
  perf evlist: Add success path to evlist__create_syswide_maps
  perf evsel: tp_format accessing improvements
  perf python: Add evlist enable and disable methods
  perf python: Add member access to a number of evsel variables
  perf python: Add optional cpus and threads arguments to parse_events
  perf python: Update ungrouped evsel leader in clone
  perf python: Avoid duplicated code in get_tracepoint_field
  perf python: Add evlist all_cpus accessor
  perf python: Add evlist.config to set up record options
  perf python tracepoint: Switch to using parse_events

 tools/perf/python/tracepoint.py |  23 +++---
 tools/perf/util/debug.c         |   2 +-
 tools/perf/util/evlist.c        |  13 ++--
 tools/perf/util/evsel.c         |  16 +++-
 tools/perf/util/python.c        | 127 ++++++++++++++++++++++++++++----
 5 files changed, 145 insertions(+), 36 deletions(-)

-- 
2.48.1.711.g2feabab25a-goog


