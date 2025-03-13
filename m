Return-Path: <linux-kernel+bounces-558733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3968A5EA21
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AC7176EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60325136E3F;
	Thu, 13 Mar 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WlS42ggH"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205C35946
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741836687; cv=none; b=hu9i0F4WZHxrrFb9JFWTmtn877e0uTdsXkr6O7F0UERsZg1Vc5aaTJ+9w5PIgZDPrhJZfF40LMcXDwTeQLjTD3SLvc9Rt/CHDU/j1NUJbDBVAeQhN4cw5OAX9O5CqnxGDA6VWWdSIVMdB5i9X7Sm9hdHjFnxqMnMss9VWP6oHB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741836687; c=relaxed/simple;
	bh=AwmRAO1YNMdcTMcSsFQKmFypkHXuPAKuj2jZ1dmJz9o=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=QAPxAk9+3/It7yFjfW2qAZmiHkr6KwVQqpAp9OdnNleWA18UDut0kxeelkr2uYDOZUwpyzr0ZQ6Z1ElIu8rewBn4enbnQq8qqUHpAzKUzKWkGXlbXInt3YX5er+IPvPWpQMysqBI9NmeekJiWqSZPSsoQ7+4ngC8Jf8+kr33SuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WlS42ggH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e572cd106f7so832738276.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741836685; x=1742441485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCUU7sU0LaTPMQmzYqMXMA0ay7SOjDSgfU7Iry5P/WU=;
        b=WlS42ggH75A6yVKEkUa+IDWW9tlA9wZLpflO5iYO5vY3eLCimMeRmd1ICYfyGro70z
         bHrhW/lzGTC+WW2PUsp4aHLLLTNC6WHUWquYl6WpRlOqwz8EcPNKdmhqPwy4FSxG0wWf
         zs5lTSeHOk1XawJnytP7np6n3EwFFNZGuND0Bn4uIHV6ORSLgrOMlIdT5LnFaL40PdDf
         Lo7DjbnNw1qLgeMvhGdiKwl4NSLdhnoZZwse+eElzyAmZYazUT9Rx914aL9Ej7weH9Yl
         wH6g8Ph15iZgHhVnpu8huhwZi4ecuu3qVyxiz6cpn6110QgkcETqvNY0RohfBFTgal8x
         B10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741836685; x=1742441485;
        h=content-transfer-encoding:cc:to:from:subject:mime-version
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCUU7sU0LaTPMQmzYqMXMA0ay7SOjDSgfU7Iry5P/WU=;
        b=HeJOB1Xl2Dt3qa+KXvVEVZpT0gO3xCRY/nP10ktGrSI2U0YdlecTY3kEKUTpkmRkx2
         ezWct2OeQhX5ZgAm2tNhl2+cHpFq0pH/yUZAGV6Ni/1/WVWkeXid6aH0tQo2ZP5CmC/u
         Za+WOQohb0ABamj+UyCvtzhNfYMLRlqguF5ci0dPYlq4ubEgnD+KsIXbIYgaKwugGsIj
         2xgO9sw2ZwgDwLduShcNasA2hap1ZhKIbj8sYqBGmZlLLvKiBauOSypThCuURmNy7+j1
         adhjTfLNfWPoyDrp6sZJzwu9CMcgqU2yGx6cNCR7zrSUW/Ee9ZpZUcq/0WBOPhX99T7K
         K6eA==
X-Forwarded-Encrypted: i=1; AJvYcCUz5TLvyCvSVgTh+gxBBtgBaICHPzHENsYsglLxBGwCxK9kzUyLMpVdJ0fRP0oYOZF83wzO2pOfNKLtlKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu0+VcqxpuBZtzuaQRGoRyqgPz48oGfAha+l/32+Peug8MSL8N
	wsSIxi6ZFi8uD4Wi2UBtDenpbVz68GU2YwWxvyzTu0WRKVmEQc9zPJuCHa3kWXUhxm52ld5vWGM
	R/HT/bw==
X-Google-Smtp-Source: AGHT+IFyG3cDgq05Ln+M3gq3U94u6JEVep+JU8nfl9R1gQIGOfiNyyHzSnSFL8c1J3fOTbNeyQzacqQDbpaV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de85:e25e:4e36:1ea5])
 (user=irogers job=sendgmr) by 2002:a25:5142:0:b0:e60:a52a:377a with SMTP id
 3f1490d57ef6-e635c0e7a15mr209589276.2.1741836684471; Wed, 12 Mar 2025
 20:31:24 -0700 (PDT)
Date: Wed, 12 Mar 2025 20:31:21 -0700
Message-Id: <20250313033121.758978-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v2] perf libunwind: Fixup conversion perf_sample->user_regs to
 a pointer
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yunseong Kim <yskelg@gmail.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Andi Kleen <ak@linux.intel.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Michael Petlan <mpetlan@redhat.com>, 
	Tavian Barnes <tavianator@tavianator.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optional")=
 misses
the changes to a file, resulting in this problem:

  $ make LIBUNWIND=3D1 -C tools/perf O=3D/tmp/build/perf-tools-next install=
-bin
  <SNIP>
    CC      /tmp/build/perf-tools-next/util/unwind-libunwind-local.o
    CC      /tmp/build/perf-tools-next/util/unwind-libunwind.o
  <SNIP>
  util/unwind-libunwind-local.c: In function =E2=80=98access_mem=E2=80=99:
  util/unwind-libunwind-local.c:582:56: error: =E2=80=98ui->sample->user_re=
gs=E2=80=99 is a pointer; did you mean to use =E2=80=98->=E2=80=99?
    582 |         if (__write || !stack || !ui->sample->user_regs.regs) {
        |                                                        ^
        |                                                        ->
  util/unwind-libunwind-local.c:587:38: error: passing argument 2 of =E2=80=
=98perf_reg_value=E2=80=99 from incompatible pointer type [-Wincompatible-p=
ointer-types]
    587 |         ret =3D perf_reg_value(&start, &ui->sample->user_regs,
        |                                      ^~~~~~~~~~~~~~~~~~~~~~
        |                                      |
        |                                      struct regs_dump **
<SNIP>
  =E2=AC=A2 [acme@toolbox perf-tools-next]$ git bisect bad
  dc6d2bc2d893a878e7b58578ff01b4738708deb4 is the first bad commit
  commit dc6d2bc2d893a878e7b58578ff01b4738708deb4 (HEAD)
  Author: Ian Rogers <irogers@google.com>
  Date:   Mon Jan 13 11:43:45 2025 -0800

      perf sample: Make user_regs and intr_regs optional

Detected using:

  make -C tools/perf build-test

Fixes: dc6d2bc2d893a878 ("perf sample: Make user_regs and intr_regs optiona=
l")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Leo Yan <leo.yan@linux.dev>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tavian Barnes <tavianator@tavianator.com>
Cc: Veronika Molnarova <vmolnaro@redhat.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
v2: Ensure user_regs isn't NULL when read, spotted by Namhyung.
---
 tools/perf/util/unwind-libunwind-local.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unw=
ind-libunwind-local.c
index 16c2b03831f3..5f4387e2423a 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -579,12 +579,12 @@ static int access_mem(unw_addr_space_t __maybe_unused=
 as,
 	int ret;
=20
 	/* Don't support write, probably not needed. */
-	if (__write || !stack || !ui->sample->user_regs.regs) {
+	if (__write || !stack || !ui->sample->user_regs || !ui->sample->user_regs=
->regs) {
 		*valp =3D 0;
 		return 0;
 	}
=20
-	ret =3D perf_reg_value(&start, &ui->sample->user_regs,
+	ret =3D perf_reg_value(&start, perf_sample__user_regs(ui->sample),
 			     perf_arch_reg_sp(arch));
 	if (ret)
 		return ret;
@@ -628,7 +628,7 @@ static int access_reg(unw_addr_space_t __maybe_unused a=
s,
 		return 0;
 	}
=20
-	if (!ui->sample->user_regs.regs) {
+	if (!ui->sample->user_regs || !ui->sample->user_regs->regs) {
 		*valp =3D 0;
 		return 0;
 	}
@@ -637,7 +637,7 @@ static int access_reg(unw_addr_space_t __maybe_unused a=
s,
 	if (id < 0)
 		return -EINVAL;
=20
-	ret =3D perf_reg_value(&val, &ui->sample->user_regs, id);
+	ret =3D perf_reg_value(&val, perf_sample__user_regs(ui->sample), id);
 	if (ret) {
 		if (!ui->best_effort)
 			pr_err("unwind: can't read reg %d\n", regnum);
@@ -741,7 +741,7 @@ static int get_entries(struct unwind_info *ui, unwind_e=
ntry_cb_t cb,
 	unw_cursor_t c;
 	int ret, i =3D 0;
=20
-	ret =3D perf_reg_value(&val, &ui->sample->user_regs,
+	ret =3D perf_reg_value(&val, perf_sample__user_regs(ui->sample),
 			     perf_arch_reg_ip(arch));
 	if (ret)
 		return ret;
@@ -808,7 +808,7 @@ static int _unwind__get_entries(unwind_entry_cb_t cb, v=
oid *arg,
 		.best_effort  =3D best_effort
 	};
=20
-	if (!data->user_regs.regs)
+	if (!data->user_regs || !data->user_regs->regs)
 		return -EINVAL;
=20
 	if (max_stack <=3D 0)
--=20
2.49.0.rc0.332.g42c0ae87b1-goog


