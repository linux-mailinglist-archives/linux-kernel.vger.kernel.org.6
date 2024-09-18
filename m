Return-Path: <linux-kernel+bounces-332993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79397C1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 00:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2DDA283CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 22:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2D1CB307;
	Wed, 18 Sep 2024 22:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5ttkSnV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399911494B1
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 22:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726700064; cv=none; b=fnJk/vUtqYVec73zCuOegou2RbkSga4MOiLZVSoQ/RNjYNbFOX6nlc50KdK6Rpny+buSMQPO62R43xnlu5p0tcOgzIbe84vqhmGCVXnzlYiLoYJmU/uXSecQ9D/dqzzz4RoXF9FSzHPxFpRDfaXpRZ5Wo2iAKQKk1xs5o2275xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726700064; c=relaxed/simple;
	bh=OxKyUufht0q3CEXmxv5toefQozGjYx7DZiJ0OEjsbHs=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=k3N7pPaeoRQZyhFPhMtfiPoNIo/mqhKMB0V0W4/yrO7roBJ8HasCL4EWLz67hmvkxBkL7fYhQoJ4Le2jsJI6et2hbYQNRzf8ffO5mqVD1xhDlYijXQakj9YsPVd/qh6QarX2BD2MjkqbgdarPsiUOHkG1idemzZWNTKjVqDg94A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j5ttkSnV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6cf78470a56so6872847b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726700062; x=1727304862; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5ICEyu+KfG8LnD7rrY5JAl3MiV83XrCT4LMwE3uhCA=;
        b=j5ttkSnVuRUK8l2tRAmS1DNdXz2NZfuPqq7KOk0XN0Yb+iosw8+uOUfu6aOd0Uullh
         zSfZLqMYOz82sZnL57besursB01U2+pv79wbz/QhAjvh4revmsXZdzZZmQEXuiWo8L/+
         c6QN+ea1JclvJwla+0grQN1wfRTHkkF43i78JykJbGVdfRRGV8ldoCf8VxGCDR93jKeO
         oOE7VlHiXe8ejSUA1/5BRBbA5CvhFmqf5bhhA8Rj3RfjRahEBZlFEOTCLZcNN06qYsZo
         4uFMrZqTCOBlhoawsNCHkUDNH4wLlWBNIo/o6HtCnLmWNID5wS8jicesLWRkGbzTl610
         wooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726700062; x=1727304862;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5ICEyu+KfG8LnD7rrY5JAl3MiV83XrCT4LMwE3uhCA=;
        b=mDrfdVH83zl5Rd5aApWAyxylO1vPRmLktMjrX8hnpxQTtbFw/xpiDQ0CZ21OBwXQJE
         95P2LIh38x2MYez7jLn+1/dClB6sBDPFCeNO+lUx3OZSrplJjMCC3z0fU0IKb/YPuWS5
         fHQU3J3uvsILCymmvrPAsNeTG62bK5K4DGUF1iGygv1w+DSL6ASi3XdeEX24TphoiNn4
         UUusjqKkvsI3LUPjUWupK81xS6zrAzebjXzpn0l+WuIhAhbEXnITCvRdC2uLE5cM2Uo/
         o9lycProXyYu5mb+jpbbGSKRFXKTTYeN/oMFYt+PKXqBIynaJ1m/XMunb8ZUs+EhZPXC
         5/dA==
X-Forwarded-Encrypted: i=1; AJvYcCVZPOwu7U3R2M3+mPT7aCP12aTV86GbEiJ+YtTqeOTYqmbqOvq0M5onQUlnY7feYCpk4fwSmaI1GGLjids=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1YVoJRM+HF3UTJGc9MC+f8rn2ah2qc1j+mSF+T/eTGLcF4puh
	pvor40+JoQ4WhFzNZpuHHhb9LsPDbtxVVexLXuAw6htV85uWgLrZsTCrvDPK+6GpuewJ6ZHKUcq
	ZyEJhFA==
X-Google-Smtp-Source: AGHT+IHr4DfOLJNUlz9M3nEE5DuR6Q22roaSsevBUu2c5aAYacWeG1F9xpkUUkJ77QIvz1tqChjGxTqgH6tu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:cb6b:1e62:cfd8:bd50])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a0f:b0:6db:d257:b98 with SMTP id
 00721157ae682-6dbd2570de2mr9938907b3.3.1726700062173; Wed, 18 Sep 2024
 15:54:22 -0700 (PDT)
Date: Thu, 19 Sep 2024 00:54:16 +0200
Message-Id: <20240918225418.166717-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Subject: [PATCH v1 0/2] Python module cleanup
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Andi Kleen <ak@linux.intel.com>, Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>, 
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Remove workarounds for Python 2 module support. Constify variables and
parameters to functions.

Ian Rogers (2):
  perf python: Remove python 2 scripting support
  perf python: Constify variables and parameters

 .../scripts/python/Perf-Trace-Util/Context.c  |  18 ---
 tools/perf/util/python.c                      | 128 ++++++------------
 .../scripting-engines/trace-event-python.c    |  63 +--------
 3 files changed, 44 insertions(+), 165 deletions(-)

-- 
2.46.0.662.g92d0881bb0-goog


