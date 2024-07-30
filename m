Return-Path: <linux-kernel+bounces-268101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631FC94206D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCD0285688
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC9118B473;
	Tue, 30 Jul 2024 19:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2q41Bfgi"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAEB241E7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367070; cv=none; b=oxLtgTCGJpej/DfrJLHf3s7/3Fnd+DlmvCdpsdkPFK7QyY0/Urg7HrPGz8mzQVn1AyN9+1B4gGL6lqlUS12w498eRU0q3kYzGymeKAtgK4Ev+dEyoKqoFmMUOtHuRuuxpefFTlWsBF0Mw9l0TsOghQalxqJKBwn7q7yGFkKeFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367070; c=relaxed/simple;
	bh=XFEeUN0IV3OvseSsWCX2dxHl2R27oAX3kgzjRpdZ5jo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=GRl/v/NNoNBkwvBR6OvGnIBzraYzlpk6x1gHIcA9KmykX97BVI8dXDPXSNh887puXAtD8Pz/tq6two01lR8BWL9s39jei0sNJyNbYXITOXkoiYIvc+A34aqzuqMaNoJwL+hmxswTgd3rMLslhX7qYutsT7JhWIzIV8jpUAdDlJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2q41Bfgi; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0ba5663132so1628782276.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722367068; x=1722971868; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jnRKI2DZaKF19Vc7gkMAAWBTLm1lonuKlg3WaQu1cmY=;
        b=2q41BfgiZHxl4A+Q3trZDAShwM8MwBNGiHrARa02EdDYYsKHqlKAO8usTu96WSukKG
         0cATWuqCKSoqYXCPaUzag40nWatv6Zq6fYYSWA18JINYNLda0CxuvCvXEEEUZyj8iH1k
         IybrUVXUCcoVxerLEEc7XejhCBEu7411t7YXeGpht0g2UOeJ6n+Wz4f95x3qQESi/VZn
         cMdn11rEi/c+pxtwLOFzU7FHXwheHfBxVyq9BBmXOhh/FqaqWCoiMhbmSf1aKibk5wCj
         YPiWSvJVCQw3eRYmYgWzNpueZ7/DfpOKf5mg3k1y9awvmA8m+9gpiBoNIv4/quSdoDvl
         ljmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367068; x=1722971868;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnRKI2DZaKF19Vc7gkMAAWBTLm1lonuKlg3WaQu1cmY=;
        b=g08cjOegZHQD9rafVodPWQHrJK6vTQyxWE0WLNvKof3PYX06mpvGn2h6PbdPfPtXW2
         cCdAwXznzTgf/hwQEgI02mSSlccjzRNSR0fxYxaWwa3oF7C5YOFSptRTEa5BiHV9ST9E
         B2vwBzBoh+720ypy7LuVhGHN7ZYDHjha16j4gOqUm3XPjkNJ3tx9ipoKmEBWOP+eybyn
         Dl8NJPBfpoV3WnIc0zZgPJeyCabthTuclbWdJb9WmtmMBNw/+Tn60lJ/ECfxTEv5wtC9
         9/vgo7aFF7Jzwc7l+W1XFCS7Rmxt6/skFhxRgf0+XglPo3D22l1wBw6BHRs079adSIcs
         7nDw==
X-Forwarded-Encrypted: i=1; AJvYcCVKIIPqYBiH6iglaEdwbcJG5dZ+X7hiOvJyjirTPR3K1RHWTzJScl6j6EBWGi4Y/tt14MfAtLLHCDclrRKDKboW9egFRMQhPCw+EFv/
X-Gm-Message-State: AOJu0YzWc+JIdRo5UyCuqBby0JfiZLslwZKQqUNhdjHtPrwJ4mH60ERv
	LWSU1CyJEXpZaMIfnszBZdox9YOs71phzEAji7DY8emBl+/QpywEE/+eJvruEt/vxG7hVqHfIB5
	08LQKRw==
X-Google-Smtp-Source: AGHT+IGHCOIfYE+jU3yP8n/6z+ayYRfbV7TpOWQuKGEYqkamORc80np3zqTC3an9irTD7xo5qfFitXAYjsOS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b07a:93d0:1b64:3771])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b8c:b0:e03:31ec:8a24 with SMTP
 id 3f1490d57ef6-e0b5450c532mr513973276.8.1722367067754; Tue, 30 Jul 2024
 12:17:47 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:17:42 -0700
Message-Id: <20240730191744.3097329-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Subject: [PATCH v3 0/2] perf jevents: Autogenerate empty-pmu-events.c
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, philip.li@intel.com, oliver.sang@intel.com, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rebase of v2 patch set on tmp.perf-tools-next.
https://lore.kernel.org/lkml/20240525013021.436430-1-irogers@google.com/

Review was delayed because of an Intel automatic testing issue,
confirmed not an issue here:
https://lore.kernel.org/lkml/ZqhGNm+WDcsNx05e@xsang-OptiPlex-9020/

v3: Rebase and add John Garry's reviewed-by tag.
v2: Add not found constant.

Ian Rogers (2):
  perf jevents: Use name for special find value
  perf jevents: Autogenerate empty-pmu-events.c

 tools/perf/Makefile.perf                 |   2 +
 tools/perf/pmu-events/Build              |  12 +-
 tools/perf/pmu-events/empty-pmu-events.c | 894 ++++++++++++++---------
 tools/perf/pmu-events/jevents.py         |  12 +-
 tools/perf/pmu-events/pmu-events.h       |   9 +
 5 files changed, 574 insertions(+), 355 deletions(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog


