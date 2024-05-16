Return-Path: <linux-kernel+bounces-180617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909778C70DD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E56282E42
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 04:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD7815E83;
	Thu, 16 May 2024 04:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PN9Pakz4"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457AD17BA1
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 04:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715833203; cv=none; b=IBu1Pf5ATl4mXbVhzjJnUDUWQBL7j9vVw/DHn1+njnfbuc8HTkqF+fLbomCy3kNSIVeSvyg+gyc9OewHQaZzck6c7kK3Mr+Zq+5dKn46iaMkf0/q+LPSszW8CNs02ppVWLWDqCQzmhQliHW1JRCtfOg2P5lSNcfF37hehQLGcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715833203; c=relaxed/simple;
	bh=lHHwkYfHA8wjarLgp5Pin3R8Kdwmiap6eamnf3fEAj8=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=JZqIv7Yq6fUWC9ZPwEP1FiBEqBHWqxGJTFmc/MUkBwkPnxs0C5OF1kO9Wv90R9pDwHEhkzk4Ska/tAj+qGS2AoFv6Lo4I1QL5T20vI0fxN9qgu3EG6iCf6qXk6hEalHOPg2OMBCDrjUWrXVxYX+96h4ZCRn98GfidReLMwrQoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PN9Pakz4; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62035d9ecc4so144948867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 21:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715833201; x=1716438001; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhvrEJQEtg7mfpXP1eaEk1iTrmpUehU3kjsviXcKots=;
        b=PN9Pakz4SXgiav6BxBSqXt+qB/OAbcUzUB281zKhngB03cLS+oQ0j8QxbK9i91dprF
         Mhs9LRH/zwdrijMPsG0FLAd4jCFZozqyGYPOKUjgA9YfSj6h+NbGv7xqDMIoRP4HxqUa
         jJr37v6Kny0s5HSznqjAlThPODBrF+vJhBCx6xz+oarmpLucmADCVxkzp1+Sub4NuBlw
         0xyV7+aNHDAF21dNo8r/PQFfq+jdTy5enYplpA5c5qhey6dr8OWCi8zAhfbIdsz31h+y
         je1GdNI1aQRpRatMc8GzpAYLn9oBABRN2KBfz262BD+nx4NVIngsV+S9DKdq9tqT6OsP
         P3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715833201; x=1716438001;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhvrEJQEtg7mfpXP1eaEk1iTrmpUehU3kjsviXcKots=;
        b=l++2Fl3nUGpp9gel3NOXDyUhIPbuXx7+mGmMn6qaPSLsG38rBS+n5o/ihAzvEyqXJN
         pyMFytzwb9W4r0FarNU3lMl3gdTG14GH/NZDv5RSFW+M4eBRsCEqE66pZ1Ek1Z2mQmxs
         fdkaQJeUt77DbF6FSlvKlThsgYKgw0/D7F5vUYPuEVGTcFrNvYqOWcGRd6IcQFeNlhvE
         w/EOXuDamdSDYTZBUET23OUMVqZ5BmramR2hGXH5rxW8mwi2+0hs/wiIw4xYppq2sjry
         Vt31R7s+b6xay/9q49nPNjpZw5ocMK/KHI1CN/SVzM2by5cGIO5bWqw9GhZhvgClrz6c
         OAtA==
X-Forwarded-Encrypted: i=1; AJvYcCXYla/op9fPfhFPfIL0lx8GeFgOW2F1Fy/wwW+gMS0xTFuV0pVLGrz/4zjlm9CTn8oRK+tuavH8WQ2tnndxZA/LbCgTPWhu05KfeYDN
X-Gm-Message-State: AOJu0Yw+cvMr1loDjkeVtQLk90jMzLJFs6rFxQN38Y/1uvWmDfsEeVgc
	7Yl52UGA0SaG3Gh4swN2bJ/Y8zJQ1UXlqSwIg4YhC5jHJrzWMwoFbygk4FfU788pSu5eRw6qq0f
	ZvfiYAw==
X-Google-Smtp-Source: AGHT+IG7tjaXXbXKUovZxPYRnXIcz16bs4tMWPRVs26fsA8k2+yRtiUieQLjMyGUvC+JI76UlHP2+h+y5haK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bac3:cca1:c362:572])
 (user=irogers job=sendgmr) by 2002:a05:690c:668f:b0:61a:bda3:a78c with SMTP
 id 00721157ae682-622afd81d04mr45306547b3.0.1715833201091; Wed, 15 May 2024
 21:20:01 -0700 (PDT)
Date: Wed, 15 May 2024 21:19:45 -0700
Message-Id: <20240516041948.3546553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 0/3] Use BPF filters for a "perf top -u" workaround
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Changbin Du <changbin.du@huawei.com>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow uid and gid to be terms in BPF filters by first breaking the
connection between filter terms and PERF_SAMPLE_xx values. Calculate
the uid and gid using the bpf_get_current_uid_gid helper, rather than
from a value in the sample. Allow filters to be passed to perf top, this allows:

$ perf top -e cycles:P --filter "uid == $(id -u)"

to work as a "perf top -u" workaround, as "perf top -u" usually fails
due to processes/threads terminating between the /proc scan and the
perf_event_open.

Ian Rogers (3):
  perf bpf filter: Give terms their own enum
  perf bpf filter: Add uid and gid terms
  perf top: Allow filters on events

 tools/perf/Documentation/perf-record.txt     |  2 +-
 tools/perf/Documentation/perf-top.txt        |  4 ++
 tools/perf/builtin-top.c                     |  9 +++
 tools/perf/util/bpf-filter.c                 | 55 ++++++++++++----
 tools/perf/util/bpf-filter.h                 |  5 +-
 tools/perf/util/bpf-filter.l                 | 66 +++++++++----------
 tools/perf/util/bpf-filter.y                 |  7 +-
 tools/perf/util/bpf_skel/sample-filter.h     | 27 +++++++-
 tools/perf/util/bpf_skel/sample_filter.bpf.c | 67 +++++++++++++++-----
 9 files changed, 172 insertions(+), 70 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


