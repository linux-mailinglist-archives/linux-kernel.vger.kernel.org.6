Return-Path: <linux-kernel+bounces-382261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B49B0B97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C778286E41
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9502F21216D;
	Fri, 25 Oct 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBgNwkHo"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E815820F3EC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876989; cv=none; b=W9yNpioM4anLCcJrUadrbwcnHzW7Z0CVBbXwZJPEAVwKrn4y35Nq9NI55HWXRBFc8l4yfslQ4etqq8bKE56VLzf48MykmHh9dDRKcj1ccnmjuv4bYI+gj4MQUFcoa/KNWYy30AWMz/msLN2ZzbfHQvUOtehJMDjBW4j8RmWPm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876989; c=relaxed/simple;
	bh=jDw2DtjTh/d2C9SAVH2SzICTX68aZnUWB2tE77E7XCM=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=sO6jhRn0HVHHToYqenYNFWr48yDprR8eKXR6QNalmakBTlFjSII7mLkV8pgWlt1fqLYdFMcst9tjk86HBjkw2fuTRYCzw8Ql6N1PAFBJy/9oRXkM7RXX6dWUncylpIZZyxRliFS5uC0B0qJmBTCABOB7a0hZbiqknfv71UBfoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBgNwkHo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35199eb2bso48521907b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729876987; x=1730481787; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xnWHGw0eKbzFpr+Bgh2ZHR3jRDdoOl8w2bFZjp2fXKE=;
        b=HBgNwkHoLq0c9Ardm7hGqbCNH4cvUDqseDBcDEIW/Gi2KJD/H8OrX+oNfR0RMwsWPh
         Y4F7CmnxGTBv0tdJIBu98pHVSLtZ+PSCCX41VYVlF9zVmrSqzv4pwchqvS0zvoK5y297
         fLYo1EM4Koy8C8zLQChsKDtVNfXscQb3bxekxrK5ObeuUGBiukOPlQAJX545YZN+Ym4p
         gpxTPSuZFCYYdxLkXZyP51e78qR/HjVTxcay8/tYbvjJ6dw32ANpePKYTVODJ/vtAwt9
         jPsRi1nFoPkEAyqTg2kprhXoI1Ht2qK9Cx993329hCpHsCwYvUKMKj1UgoR5SlxHTUxs
         cqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876987; x=1730481787;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xnWHGw0eKbzFpr+Bgh2ZHR3jRDdoOl8w2bFZjp2fXKE=;
        b=GxxSxVjkWBF7est/b5+0RoV2AlBY3ysSa3spChOdlFmYjx40KtwdpCF+kkh3s3pR/7
         IuWd/7/swVDaGq5p4v7InaoWw5w/ajvyJofO3SxrRyJJeZojrya4akMDLwv1/m1/OFwb
         jUQCMYgJsNf9W0CFfe7rJo/nIZKBY4YSGBPU8iKZbDqRUdGiVxMQ8jJZy3kLHOxpb+SU
         nGSmaRY6EW1P5PSYqHuFZ9pfvbDTzDKxEKGJfoC9JQR5gjeTmWVl9Gyq4Xtj0tyZaZcV
         bM/k9iZ/mUcn9/KlTNklACiP+OP1zyNd84CW14njdmaAJmdqQ46KaLJSt1Ki81Ia9Br2
         EotQ==
X-Forwarded-Encrypted: i=1; AJvYcCWexHQueaFPQt//UOlDRPcOA7Nwu4hcBFpRWeqpSYDhJ3BGBr3L5TA93+6TvQYDaH0z+4OZqx720F+x0LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZx15mNI3+mSQ2PPUe+6Afr4J4LknRXyoTtoDM5qHTrsN04Zr1
	vWMBxLu03c+YEXGReE+kJ8DhRmzJMFShdnoKle5JpUHbm8g8mp75hXuG7oCRF4qXGG58cHe8FQg
	UMmtl5g==
X-Google-Smtp-Source: AGHT+IHrCQXmBcypl47HjTYUFhsAA6XprwVd3+2HKX5oHa5YuMXPMF/2Cyd+MSETogZ6mmUFrjUMrY+qgkrM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:690c:994:b0:6e2:b263:103f with SMTP id
 00721157ae682-6e9d86fa10bmr82907b3.0.1729876986894; Fri, 25 Oct 2024 10:23:06
 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:22:57 -0700
Message-Id: <20241025172303.77538-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v1 0/6] Mypy and pylint build support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support building perf checking the python code with mypy and/or
pylint. Currently there are too many errors to make this a default.

Shellcheck generates no output on success, so linking shellcheck files
doesn't cause `ld` to fail. Mypy and pylint generate output that will
break `ld` so change the Makefile.build to ignore test log files.

Address some initial mypy errors.

Ian Rogers (6):
  tools/build: Don't pass test log files to linker
  perf build: Rename TEST_LOGS to SHELL_TEST_LOGS
  perf build: Add mypy build tests
  perf build: Add pylint build tests
  perf test: Address attr.py mypy error
  perf python: Fix setup.py mypy errors

 tools/build/Makefile.build         |  6 +++++-
 tools/perf/Build                   | 32 +++++++++++++++++++++++++++---
 tools/perf/Makefile.perf           | 14 +++++++++++--
 tools/perf/arch/x86/Build          |  6 +++---
 tools/perf/arch/x86/tests/Build    |  6 +++---
 tools/perf/pmu-events/Build        | 25 ++++++++++++++++++++++-
 tools/perf/scripts/Build           | 26 ++++++++++++++++++++++++
 tools/perf/tests/Build             | 32 +++++++++++++++++++++++++++---
 tools/perf/tests/shell/lib/attr.py |  8 +-------
 tools/perf/trace/beauty/Build      |  6 +++---
 tools/perf/util/Build              | 31 ++++++++++++++++++++++++++---
 tools/perf/util/setup.py           | 10 ++++++++--
 12 files changed, 171 insertions(+), 31 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


