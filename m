Return-Path: <linux-kernel+bounces-200584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B78708FB21D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D949282FF0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BCA145FFE;
	Tue,  4 Jun 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+BGbWSd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427D145FFF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503967; cv=none; b=U7jgqeJucXt9yaniJe7uLiwZNjwcycAigs1hv1V2whuUFOaS74wdaH4fpxnJeBnamlsrdXT0oXbSm1FHPovRaog9PY7BcJl38fsyWxkagiKgR+uhF6Vz40+weedZZ9+9zOiZHPqJc5ox5IS9pMiISVLy1dqNV2TMqB33HVFZyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503967; c=relaxed/simple;
	bh=C0m1q9sQFto++NXEm5lo0SSe/c2H/tzIMnQtwBN17pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUAeNA2RyTdOg8/Dqjse2Y6VSIH00ZLyk5vVeoCzyfb0Pbsje136epuAJIUhtk3f+KhxhyW770xAzZSa8w3a6T+HibV1bt+kQIDF78piNkolgAvuCs5U/LCAWGI9RdSWG+WIlWlSLo7tsXsQORIqjWTfayZhBkK3HIW4ZuGsQPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+BGbWSd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717503964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g9xu8CO6FcwPIS6aRjJr9urN6rt6ZyZUoWGzoofY+lc=;
	b=D+BGbWSdnUu575pFWlf6WUaigVRJFG3ZmoZBMJHUFcmJms4pGVe+wgKy0FpSXcrXmWMzul
	sHd+377IqHAJdr+TcyZh8eGDTmre8s6ha+al8g0nto8GhNw6CDF3osaFfMM6wD0+1drjRO
	oQAXWT/FkrSNruaqmBfnqWau6v36ZIM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-6cKNhcoxPuygImNn1gcRmw-1; Tue,
 04 Jun 2024 08:26:01 -0400
X-MC-Unique: 6cKNhcoxPuygImNn1gcRmw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B184B18FF939;
	Tue,  4 Jun 2024 12:25:57 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BEB91955D92;
	Tue,  4 Jun 2024 12:25:49 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Russell King <linux@armlinux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH RFC 0/3] kernel/events/uprobes: uprobe_write_opcode() rewrite
Date: Tue,  4 Jun 2024 14:25:45 +0200
Message-ID: <20240604122548.359952-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Against mm/mm-unstable.

There is interest in supporting uprobes on hugetlb pages [1]. Having
uprobe_write_opcode() implement COW-breaking itself is really far from
optimal, and having to add hugetlb COW-breaking to implement hugetlb
support really does sound wrong.

Further, I think the current code doesn't really handle some things
properly (see patch #3) when replacing/zapping pages.

Let's rewrite it, to leave COW-breaking to the fault handler, and handle
registration/unregistration by temporarily unmapping the anonymous page,
modifying it, and mapping it again. We still have to implement
zapping of anonymous pages ourselves, unfortunately.

Note that we now won't have to allocate another anonymous folio when
unregistering (which will be beneficial for hugetlb as well), we can simply
modify the already-mapped one from the registration (if any). When
registering a uprobe, we'll first trigger a write fault to break COW to
then modify the already-mapped page.

Briefly sanity tested with perf:
  [root@localhost ~]# perf probe -x /usr/bin/bash -a main
  ...
  [root@localhost ~]# perf record -e probe_bash:main -aR sleep 10 &
  [1] 2196
  [root@localhost ~]# bash
  [root@localhost ~]# exit
  exit
  [root@localhost ~]# bash
  [root@localhost ~]# exit
  exit
  [root@localhost ~]# [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.287 MB perf.data (8 samples) ]
  ...
  [root@localhost ~]# perf report --stdio
  # To display the perf.data header info, please use --header/--header-only optio>
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 8  of event 'probe_bash:main'
  # Event count (approx.): 8
  #
  # Overhead  Command      Shared Object  Symbol  
  # ........  ...........  .............  ........
  #
      75.00%  grepconf.sh  bash           [.] main
      25.00%  bash         bash           [.] main
  ...

Are there any uprobe tests / benchmarks that are worth running?

[1] https://lkml.kernel.org/r/ZiK50qob9yl5e0Xz@bender.morinfr.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Guillaume Morin <guillaume@morinfr.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>

David Hildenbrand (3):
  kernel/events/uprobes: pass VMA instead of MM to install_breakpoint()
  kernel/events/uprobes: pass VMA to set_swbp(), set_orig_insn() and
    uprobe_write_opcode()
  kernel/events/uprobes: uprobe_write_opcode() rewrite

 arch/arm/probes/uprobes/core.c |   4 +-
 include/linux/uprobes.h        |   6 +-
 kernel/events/uprobes.c        | 387 +++++++++++++++++++--------------
 3 files changed, 223 insertions(+), 174 deletions(-)


base-commit: 065d3634d60843b8e338d405b844cc7f2e5e1c66
-- 
2.45.1


