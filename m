Return-Path: <linux-kernel+bounces-336418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28581983A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE9D1F234D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 00:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2C81B85CB;
	Tue, 24 Sep 2024 00:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DmtPbgqw"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96918D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727138248; cv=none; b=mASpQvqjLa9M6kgAgIZvwZNg8mOVbMMe8KS6iU7n2TpZdwvKYVOGTLSN+l7Psglasacgc7NvjTwBn3M7UtknT2/VCwQGuw9+XrDlE5nVzSc4o7yTtbCy5wec7JTVSDHHml0d1jxARXF5ZUAvgycmZDjkmpTBXs9HubS7Lj2xf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727138248; c=relaxed/simple;
	bh=nWzK2sWZ6Z8nHMEPrWRkFV6YjF5AHdbQe+FRvNSlQfY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=m7CEIAhWYeDOLeti6JBttzLhcLQes/oo44mMK2bl7ZJb6OvWa0Uj1eMZOap0ocrsP2f3pchPm5udpCwyYCVvtIG8yIghaJm8yUr1QpCo+CQGcY/f1hLrJbRd53w4Ndqdpz0a5TIZs6tEIScg01KRq+mAk06m2Mtwi4HU65lB954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DmtPbgqw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6db791c42e3so76258957b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 17:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727138246; x=1727743046; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=upRWoGqTyroyxo5Zs70wrDT7qOnjToEaTm0XO6j/m9M=;
        b=DmtPbgqwm9rSXOfRLw/UmEdYild691eeXFD7zbN+btqHmejmEx8ZRTx7enkXomwzAI
         IDp7GuWAlozeh664KyQ9ExksbdxNF9phvTT9ukpDA8f3EPQeq/I++DpXMG6AqWjl1aq3
         LlGJy4wZxFA9s9DBWqhMhSiOHaIxbdWaEUctdYHOCAVwVFSXs0xXIhSzo2bSDbKw87l0
         CQipUvz/vdrbT5AK4eSwpBBKtcuVdSA50vqdIhqwZpk9/DxXAI5B/pnP6zJanagtSKct
         iMtjYhPocqgLGzLl4q8SthSladoJaPTyrFbab+SlcELfKZvT79Iy5YjFHEOnzNEBbRZC
         mLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727138246; x=1727743046;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=upRWoGqTyroyxo5Zs70wrDT7qOnjToEaTm0XO6j/m9M=;
        b=tieSoUJUJwJLPQYVHFt+f/kL5afWyHJ648a+5a3fvcuS5YZY7jCIMlXAKfKSqyinOI
         +ZAryk1kwG4xoVAS6zAXkMvOT6uqPTvNASBIRhZohGjC0mrliLJJEOMW961hnceNifKW
         98vaQZMgxc+mTt5Aiw7xj2T89VNq1cwl1TkZh4NT6YqHywNcFeetruQt8Omn+z80BtvF
         g5U8L+yUtrl9Q7cZyq0Stsq3tl7d51bqsoGUj8V6W5hniSK3fT3cZYgj9GRN5/aaJR6E
         KmWw3EXH/8Dtw40xbNciGsZ0i2WAgGoF6F017/i/Qe47uTBPKiWcPhT2gMChg9KVgXaa
         05KA==
X-Forwarded-Encrypted: i=1; AJvYcCWP5Zfpou2XK78CCSfBdjofa0UFW8gKa95vr+BxS3VRq9a2ivaLm/aPpRnRswyCsO9nrslXl/jjCd27imk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ZUfNSqwA6jtlSMT+2kyg3KuQE96WN7/k1k2FSKaPiEVzepv9
	sGSrmFxAUOi/hl8Pzi57u//tZjbg+ljgulaqWoyN7JL5cMBrHsJn7CzQfRGVoTdL1ST/yJI55Y7
	USw4RqQ==
X-Google-Smtp-Source: AGHT+IGSP3mTlfIixD7hCnVJrlETi6KEyVW+ABwML5thN0IfChfL6UiHcL1MQts56QEVsxOGq7XYw+d+ejuy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:d38b:0:b0:e11:584f:c2ca with SMTP id
 3f1490d57ef6-e2252f94f85mr36895276.6.1727138246208; Mon, 23 Sep 2024 17:37:26
 -0700 (PDT)
Date: Mon, 23 Sep 2024 17:37:17 -0700
Message-Id: <20240924003720.617258-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 0/3] 2 memory fixes and a build fix
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Content-Type: text/plain; charset="UTF-8"

I was looking into some lsan regressions and a latent issue with
libdw, creating these fixes.

A thought, we should probably simplify the libdw logic but rather than
do it here I'll do it as a separate series on top of these. The issues
I see are:

1) dwfl_thread_getframes is used to test for the presence of
   libdw-dwarf-unwind. The blame date on this function is
   2013-05-30. As the function is 10 years old I think having libdw
   implies having dwfl_thread_getframes and so we can just merge the
   two pieces of logic instead of having different feature tests and
   ifdefs.

2) similarly, dwarf_getlocations has a blame date of 2013-08-23 so
   let's just make libdw tests test for this and make having libdw
   imply dwarf_getlocations support.

3) similarly, dwarf_getcfi has a blame date of 2009-06-24 so let's
   just make libdw tests test for this and make having libdw imply
   dwarf_getcfi support.

4) in Makefie.config feature-dwarf is a synonym for libdw support. I
   think using the name libdw is more intention revealing as dwarf can
   mean multiple things. Let's change HAVE_DWARF_SUPPORT to
   HAVE_LIBDW_SUPPORT and all similar dwarf vs libdw names.

5) We have "#if _ELFUTILS_PREREQ(0, 142)" testing for elfutils version
   0.142. Elfutils 0.142 was released around 2009-06-13 (via git blame
   on the NEWS file). Let's remove the #if and ensure elfutils feature
   tests for at least 0.142. If someone were using an incredibly old
   version then they'd lose some elfutils support, but given the 15
   year old age of the library I find it unlikely anyone is doing
   this. They can also just move to a newer version.

From the mailing list I notice also overlap with the last patch and
this series:
https://lore.kernel.org/lkml/20240919013513.118527-1-yangjihong@bytedance.com/
Simplifying the libdw support will address some of those issues too.

Ian Rogers (3):
  perf disasm: Fix capstone memory leak
  perf probe: Fix libdw memory leak
  perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT

 tools/perf/Makefile.config     |  6 ++++++
 tools/perf/util/disasm.c       | 11 +++++++----
 tools/perf/util/dwarf-aux.h    |  1 +
 tools/perf/util/probe-finder.c |  5 +++++
 4 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.46.0.792.g87dc391469-goog


