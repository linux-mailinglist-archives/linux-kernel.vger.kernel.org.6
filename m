Return-Path: <linux-kernel+bounces-556975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A539A5D1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 22:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7009D17AAAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80CE264A88;
	Tue, 11 Mar 2025 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQqr2fKS"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B978F260A22
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729004; cv=none; b=sTTWBcWluCL0X/ARVI3kbqTwReQR9hoyhSUY/662R795MizFo66iPUzIFXsfsfvo4eVL9dPzEk4uySxKoXhEVetTkxVqB/gOSdBiRELg2c1bGcRen43ixKl+4M8MKFHD48CEe5Xc1p6fFJKwXq5Wb0n2HtF+4nkpJxIf0aQaRRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729004; c=relaxed/simple;
	bh=sUwbT7WOgD0FIknigzEgWXhmOc32K/iEVs+GUL5v1TQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Xp7B/ebaarpgNlOkN6M4mj9P7WckAlZIg+tV9yCOi6tOeMbQ1B1YHqyJYALZtd3iI4ucmw1L337I14utxuzscCkwKKvMNzG7TM9dDgp9NKZvLgqxugcx86aTOB7tYBrJiCBAeFFL2n9erJOh83S/rNSEAvfKC4Kj+ZUenuNSKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQqr2fKS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e572f6dee18so8507655276.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 14:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741729000; x=1742333800; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gdbMrZ6QKc/HSgRcVo2vPMQTZhcAPxAyZ2QgrcTsM/g=;
        b=wQqr2fKSjKgZDLNnWuw+djo42uqZcedYIIbAczV3BRrxhU/1FHKnFDsl3iqs6YblgZ
         aQPrywDKpBe5TOqQZXu44Mg56rIzPb/9vcNhyCl/Qz0A9SqdpjxumZo9y3npY86E24lQ
         vqZ836gt4ltu1P9712LEIvJxt9BGp8QH/HAVpmhlz4aEfqF7vQhiDharp6z6D+ckkaHS
         SSY4N5TtiypTwkboQuZKEpCoPlV6ob1wG3Ikis2bRcnLM0WSEqlXE14qA9QfNRxs0mXD
         N1kje0H0BdtAG9h4Jhcqzgbw9+8SfCtVsEz02kcdsBFqD1RsALvtU/a+ix9j91nInwD6
         HvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741729000; x=1742333800;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gdbMrZ6QKc/HSgRcVo2vPMQTZhcAPxAyZ2QgrcTsM/g=;
        b=ukXq2pkwmsFEJMnevoDP68h8k2JYw5mBt0ca9LkSaZVSsIwkxrxkYqnaC9kU3wEboZ
         zjrEmBjzDwTZa3YwZOJFaOQxEflEeFTyyGTz2foKrqZ+2bq+c+LzpPdX+ICeg/ODt7NZ
         LrwC6/PWrWRuQI9qGBppfYq8DeBzFRoiIDv+vuw7E9Ov8n1lvqYiN+Dh2brTvmGsZBYl
         DtGT/WpM6KFi1th9l1mfRzLCpCkmp8hemifuxGeeM4Aks8LqIr/2dHPj6xcwcFWLnlwD
         BX1kpT2bOsjUktFS81NCuLdsVo0YNG+1pJ1Sj+1YczNUcrt2Yqkkq4nGuboygcSS8F9Q
         K7wg==
X-Forwarded-Encrypted: i=1; AJvYcCUzTyTYwI84Cbx+6rEtY27FjfMoLUK4wpYCgp9++T4jHgdojJvMkqtv1L5dmb/3bBusEcRlpCIfTL48yjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLEHG4hWrWC+vNQJAXKmWIVo56cnOzaSXsNDIPWCbeVKfacac
	91lZ/4Qu7t3tZpDKM9dsgH6vHJg7DcrejZ69Ad3PO+oHpAfIgV02wsiH3FE5B7z176HCDzojnDo
	yiUUHDQ==
X-Google-Smtp-Source: AGHT+IEixeaWWdDRv7NsutZMCUQWM8MFfqMHG5r2TPiZPbjziRKYbNJ8SDXErqEIpQt26Pz9sgUXxloTZYNL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a25:bbcc:0:b0:e5d:bd27:92a with SMTP id
 3f1490d57ef6-e63b52006c7mr35598276.4.1741729000628; Tue, 11 Mar 2025 14:36:40
 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:36:22 -0700
Message-Id: <20250311213628.569562-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2 0/6] Mypy and pylint build support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Support building perf checking the python code with mypy and/or
pylint. Currently there are too many errors to make this a default.

Shellcheck generates no output on success, so linking shellcheck files
doesn't cause `ld` to fail. Mypy and pylint generate output that will
break `ld` so change the Makefile.build to ignore test log files.

Address some initial mypy errors.

v2: Rebase. Add James Clark's reviewed-by tags. Add example mypy and
    pylint error output.

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
2.49.0.rc0.332.g42c0ae87b1-goog


