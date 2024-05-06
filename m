Return-Path: <linux-kernel+bounces-170267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A848BD44B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBD11F25394
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3605E15885C;
	Mon,  6 May 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYzbgBq0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085A158204
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715018514; cv=none; b=MRnDEPWRtTq1oxkycK95MCz2TTkqgDZy/EqTxmxb/TH0B2ivm5EwsBkknyjLbu71CJvJfkMf3tnUX/jGdMURAobGZTcl8rrZ/hdXTyntrMGtfYxXo6HwsTZPFutnFYzSgQhjam6umKFXl3AkUzHiLP/xdUYQ92uzoUj9CG0JB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715018514; c=relaxed/simple;
	bh=j8Z7oAr4T/RVK6j3SDFulgi4NDpLrg8sogiffRXB6e4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=uKQDZFhBzUjMdoXaKsdybXFpLkoecD4mXPQWA5FuvBalJj3VDTkBwIeY4CwHHzuIxNQAgwuYVJmESBLoerEVeJEZm3jM8uMl+OGcKCWSw5Mjc01EoB4a0spJAQX2kgs/CbTpy70S8T7lqRj9SacLEc8+OzNvv91/Iv8j3Vi5JDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYzbgBq0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso48479387b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715018511; x=1715623311; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hckve5lNnoWU91k19E5DrtO6+aB3SdYV2ufG0b9QIiw=;
        b=GYzbgBq0CUh7mv00eV/hN0y1zvwgUiP/COI4VIZG8ZwEMLniCT6zksTNohOXptQ5cT
         wfzc1QAlUozr0vmq2yZJ/0+gSVkosniVBbLSRJhUSuhl9ZSVLMnpBjJkRvp7WQn3ZZgD
         lSiqiZVgeSTL1Y49xXCFq+/5YJg3BY64Ar9PAjuBdr0gcP3HNTc5NKDiwJlZ0r6qbLE8
         BnMC0fulkneRyNqE62tHwHEA5vlzhyRYLQ252a4zFKO3faBj6cAXnLYqr5ssGa5N6lVo
         obvRvQnLnOIbXgucgLF96zTHmpDYcBJS6BVUEzomPy4i/mSCDOeeEcrRsYMzm/oKQFo/
         yXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715018511; x=1715623311;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hckve5lNnoWU91k19E5DrtO6+aB3SdYV2ufG0b9QIiw=;
        b=M6qmpzGNszrgM/qMsjhr1paYJeF2ufQJivldCzF1Jb8viY66kwmipq/Ffgi8H190AD
         SDF1RdJw1fs0CTIwasvSD/z2J4Ql53KKD09R8IVjgU6ypPS40dOhXFP9LIYilQf/RxBd
         VKdxTr/hGp9+Qkdcikl34EfkYThz8uBTEnQOsgm1UoXuRjbJWGxxm8qeuIIieMvOejxQ
         pq6UXM3jSwp8aNmqIkE8wUisR2UnwRQEbBpZJeqV/h3T1MeGtqTX0HLrAntjKti1LXyM
         BXMihnv6Y31X0XmXrh+3zoV2ePE5AcQW4l/bijVdXmYVKQAOaGK1dquChl4/Jtc2IgdW
         s/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWstthan+7eTENMfPjXQMn8pqZnXMBQbrRiQbhBhFcVeJzmbWsjloc0NC9XJSwbJUnH5t9QhnT2bBh8iRiQM+Gvxq6i+dK9e8DPUn8u
X-Gm-Message-State: AOJu0YxorU/HT7AmRiobgNPsUynN3+Tx1FTl6zMV0CUiuDuWoyDn4X/o
	TI+/1oRaqK0lTFtWMJImz4I0Z9vnxOPEYnskZmrKgLncWyhTtI2Sa9aHCTQcmECW+o+SPe0g8uU
	y6Wgccg==
X-Google-Smtp-Source: AGHT+IG3NCkA5GcJ1BRwj4DJ3132qCOi6Yk8/px2hKYaoO10eMAK/YabhDsirkl8KleNCntIW7iZiy7P1DE4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:91df:9b7f:c8d8:409a])
 (user=irogers job=sendgmr) by 2002:a81:498d:0:b0:61d:3304:c25e with SMTP id
 w135-20020a81498d000000b0061d3304c25emr2878746ywa.7.1715018510893; Mon, 06
 May 2024 11:01:50 -0700 (PDT)
Date: Mon,  6 May 2024 11:01:00 -0700
Message-Id: <20240506180104.485674-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v7 0/4] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Changbin Du <changbin.du@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hopefully the final 4 more patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
a near half year old adventure in trying to lower perf's dynamic
memory use. These final changes fix reference count issues, some
introduced by making find returned a getted (+1) reference counted
DSO. The last patch lowers the overhead using container_of rather than
a pointer except when reference count checking - asserts maintain the
validity of this.

v5. Rebase, adding use of accessors to dso as necessary. Previous
    versions were all rebases or dropping merged patches.

v6. Rebase, move dsos__purge NULL assignment to dso->dsos to above
    dso__put to avoid a warning reported by Arnaldo. This was part of
    patch 5 in the v5 series.

v7. Rebase dropping 5 merged patches. Break apart the fixes per
    file. Tweak to the map dso logic as the else path was missing a
    dso__get.

Ian Rogers (4):
  perf map: Add missing dso__put in map__new
  perf symbol-elf: Ensure dso__put in machine__process_ksymbol_register
  perf symbol-elf: dso__load_sym_internal reference count fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/tests/dso-data.c  | 60 +++++++++++++++++-------------------
 tools/perf/util/dso.c        | 16 +++++++++-
 tools/perf/util/dso.h        |  2 ++
 tools/perf/util/machine.c    |  6 ++--
 tools/perf/util/map.c        |  1 +
 tools/perf/util/symbol-elf.c | 51 +++++++++++++++---------------
 6 files changed, 75 insertions(+), 61 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


