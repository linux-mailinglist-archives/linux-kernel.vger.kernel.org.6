Return-Path: <linux-kernel+bounces-360681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A57999E06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9075D1F21ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360020A5C1;
	Fri, 11 Oct 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r6LJZ/cQ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7988209689
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632176; cv=none; b=OgyatvVsxaYL2jm+5CMUhD4omWAZmUmSSd6QlgRP1TAOCsXemCEYDsVYVpUV3ZsMMOJN52Z+m1fR96NOzKxvLB7SdUGvTR5Ztf4N6Hnbn0CpIKOG9jWRGz0pEsHMLh4Xt+0AePNLlNi0dZYslCk176zh+QKRO6QbKFYaKfMsZog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632176; c=relaxed/simple;
	bh=lUB2o1scNST3hN4cylTN+G+8VoIQiTYeovLJsjD7b74=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=o1oQour0tK3Pu36X7/zaUmwb/NFO6TCoJ08BmLPWS7aKNP7wcs1PftXWE5EaO2MtgvIfw3Ucy59uZM1LcnoIJNioro4MsY43hvff6wKA/VTBVYj7kLL6tPGN2xVviW6TpVh0M6nfv1Z9iH1tIne9L7fdvbLdBMOMH6h5PKqB2w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r6LJZ/cQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so38389337b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632174; x=1729236974; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=082HBAGTYATQivuUItRa0pVoiNzfZzxmLvOuqTtuOk4=;
        b=r6LJZ/cQWAQyZSlBTnGW5T/p0537iGJbK3wTxODzcK8xYZlQtnC010EuaL4fkfSHcc
         8UjnoXhnAErtPaUol/8BfD4zxRCXScf9DrOXurUlUtBtfUL4NLd6Oh7MfqQosbfLqc5N
         42v+FRm1i7c1yO87F8SyKj8amorcPS/rn9iS6Paa3NUpC/JaE6pILmc4U1FMK/zymPrE
         pH1/xF4+Z3SBA7kncO9a+eYeHW81I25SAPy8ofjMieEWZ2ec43UtCfWIOHpQ3vKamUYZ
         MlsXIXK+77kBCUe9loDb55tlF0cfH/Dz/Ol211tWYAtQLBl7r9upNFj53uzJuTk6r77w
         90Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632174; x=1729236974;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=082HBAGTYATQivuUItRa0pVoiNzfZzxmLvOuqTtuOk4=;
        b=TbBB7odnBZH0gEKrzvS+1k6d4+XDEMTr7Ac0OwA/4Z8yd2TKtQSM52CpzfyL2YQ+sM
         TAcnNVAX5BtI3GscSwMwtoxA8OjR9CTcpfWoNld/bk7G+7UqQ/CZuDcqBy3fxXK1uvOy
         z/adMbFRH2ZyJtbvQRMyyEWEyLHtT0RIjvneBMrnakUekp4S7ugL+soWcXGffJNdeaFp
         4ZmWzlSRy1+ixoC33nXWUrxZK0lwOdBNIcZsw0NDKBSVY+iTfplX56km35zMkA8X0Ag5
         ZaACGtTsyh8ZYNxUK6UHoqX/TZ3qkfB9yP2NZgUOxP619oaAtb9VV3t/g2S8Cuj3yPd5
         FG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbRNM+OxlzsxqPrg1eRAT9j/bFl4iR/9DPpX9QG/TgKqcwsoeuo3B4JJw/tgdPhgQzpGsUvYiBHEQLYYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd1IM74b3OwN4QK/zH5LrZYBgFJTeF/MfiEhFIrm2yCImifj1o
	GmHFUas4LGgXbS857pH/k95HGUHzjxqWU6xXQJtSQYZ+GHQRAMatOUPRFQ2bpogLFyzteMAV1QN
	vd0WQPw==
X-Google-Smtp-Source: AGHT+IF+NmwHbCceXv4XCf8hDtMkzjHk7RVBwNg5O18f4sHDn/8yCRobAp4FLzcI3dVNwGTqsVt3kaaPbl4d
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:4043:b0:6db:b2ed:7625 with SMTP
 id 00721157ae682-6e3471ee4d2mr65517b3.0.1728632173989; Fri, 11 Oct 2024
 00:36:13 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:51 -0700
Message-Id: <20241011073559.431302-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 0/8] Run tests in parallel showing number of tests running
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid waitpid so that stdout/stderr aren't destroyed prior to wanting
to read them for display. When running on a color terminal, display
the number of running tests (1 if sequential). To avoid previous
flicker, only delete and refresh the display line when it changes. An
earlier version of this code is here:
https://lore.kernel.org/lkml/20240701044236.475098-1-irogers@google.com/

Add a signal handler for perf tests so that unexpected signals are
displayed and test clean up is possible.

In perf test add an "exclusive" flag that causes a test to be run with
no other test. Set this flag manually for C tests and via a
"(exclusive)" in the test description for shell tests. Add the flag to
shell tests that may fail when run with other tests.

Change the perf test loop to run in two passes. For parallel
execution, the first pass runs all tests that can be run in parallel
then the 2nd runs remaining tests sequentially. This causes the
"exclusive" tests to be run last and with test numbers moderately out
of alignment.

Change the default to be to run tests in parallel. Running tests in
parallel brings the execution time down to less than half.

Ian Rogers (8):
  tools subcmd: Add non-waitpid check_if_command_finished()
  perf test: Display number of remaining tests
  perf test: Reduce scope of parallel variable
  perf test: Avoid list test blocking on writing to stdout
  perf test: Tag parallel failing shell tests with "(exclusive)"
  perf test: Add a signal handler around running a test
  perf test: Run parallel tests in two passes
  perf test: Make parallel testing the default

 tools/lib/subcmd/run-command.c                |  33 +++
 tools/perf/tests/builtin-test.c               | 267 ++++++++++++------
 tools/perf/tests/shell/list.sh                |   5 +-
 .../tests/shell/perftool-testsuite_report.sh  |   2 +-
 tools/perf/tests/shell/record.sh              |   2 +-
 tools/perf/tests/shell/record_lbr.sh          |   2 +-
 tools/perf/tests/shell/record_offcpu.sh       |   2 +-
 tools/perf/tests/shell/stat_all_pmu.sh        |   2 +-
 tools/perf/tests/shell/test_intel_pt.sh       |   2 +-
 .../perf/tests/shell/test_stat_intel_tpebs.sh |   2 +-
 tools/perf/tests/tests-scripts.c              |   5 +
 tools/perf/tests/tests.h                      |   1 +
 tools/perf/util/color.h                       |   1 +
 13 files changed, 226 insertions(+), 100 deletions(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


