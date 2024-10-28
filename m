Return-Path: <linux-kernel+bounces-385733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59B99B3AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4731F22695
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A71DED7D;
	Mon, 28 Oct 2024 20:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv3dmlR+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E33A1DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730145715; cv=none; b=XIIiKBcEmz06ASdwbfP40v0sUICOebzPOIYnIj7OeJ0d5KGR/vNdnfVE6ZHtYBvckprkul2I3Nt1Ae+2q92UNc9TXLd93z2Ltwy8GdIwh9HZVfEYv+fp+6Ay5+qimtJViiCbgTseqEcR8YVRyjp3uw7LfjOWQvafjpN5E18ELlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730145715; c=relaxed/simple;
	bh=/D3Hbmc4k31cO962NwxHMcfECtTuA5a+tAZ1KwkPABA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGGGY61x0eZO3Pvzpp1m5T4zhItmYGiXC/OrV4tswiS1eGH2+vCbmvyXSCc6DNXqWCUyTmTe9FRFiCB+h0g3T1sQA31PyUUGppKUsRvKwfnvBLZ/KnPvlQulp7ZPBzNkHQZ43SBohDhGbGpHLCKBMfZodsvNr/YedEBCtX85QXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv3dmlR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74932C4CEC3;
	Mon, 28 Oct 2024 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730145714;
	bh=/D3Hbmc4k31cO962NwxHMcfECtTuA5a+tAZ1KwkPABA=;
	h=From:To:Cc:Subject:Date:From;
	b=Lv3dmlR+7TnMQuuX0hq+UH5lEgPbQnPzaAFtJ1nFP+/cq6FSWAJn2o+Gz55+d37gt
	 Cr/MvUgyTHtDB0S2vz0SDCTXryqBqKSQZ7ewuxiYK5wWa2OFFqomHrlNyoHdE2if8e
	 9DO4ZN0/k5r/NsZcm+mXZHfsGwGDrfeAdUz3ttktscw8Qth7GNVkQwZAAmeEWsbObh
	 6oHbhORDsKDt2F4uIAXpyXxBX9IE8uQl8SDeW7TaYFdEbL7tIa7dxhybcnsaYjnn9P
	 FRjMDzRbrliyLZilFK39IkupRliR0h0D+27F5qiecwNU/yCvD61MOMHUImVtBCbGOw
	 lCfGRItKZr7XA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: [PATCH v5 0/2] perf: Relax privilege restriction on AMD IBS
Date: Mon, 28 Oct 2024 13:01:51 -0700
Message-ID: <20241028200153.1466731-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v5 to allow AMD IBS to regular users on the default settings
where kernel-level profiling is disabled (perf_event_paranoid=2).
Currently AMD IBS doesn't allow any kind of exclusion in the event
attribute.  But users needs to set attr.exclude_kernel to open an
event on such an environment.

v5 changes)

* drop PERF_FORMAT_DROPPED support for now
* add Acked-by from Thomas for s390

v4) https://lore.kernel.org/lkml/20241023000928.957077-1-namhyung@kernel.org

* remove RFC tag
* fix sysfs attribute for ibs_fetch/format  (Ravi)
* handle exclude_hv as well, so ":u" modifier would work for IBS
* add Acked and Reviewed-by from Kyle and Madhavan

v3) https://lore.kernel.org/lkml/20240905031027.2567913-1-namhyung@kernel.org

* fix build on s390
* add swfilt format for attr.config2
* count powerpc core-book3s dropped samples

v2) https://lore.kernel.org/lkml/20240830232910.1839548-1-namhyung@kernel.org/

* add PERF_FORMAT_DROPPED
* account dropped sw events and from BPF handler
* use precise RIP from IBS record

v1) https://lore.kernel.org/lkml/20240822230816.564262-1-namhyung@kernel.org/

While IBS doesn't support hardware level privilege filters, the kernel
can allow the event and drop samples belongs to the kernel like in the
software events.  This is limited but it still contains precise samples
which is important for various analysis like data type profiling.

This version added format/swfilt file in sysfs to expose the software
filtering by setting the attribute config2 value.  I think it's easier
to add a new config rather than adding a new PMU in order to handle
event multiplexing across IBS PMU.  Users can use the perf tool to
enable this feature manually like below.  Probably the perf tool can
handle this automatically in the future.

  $ perf record -e ibs_op/swfilt=1/u $PROG

Let me know what you think.

Thanks,
Namhyung


Namhyung Kim (2):
  perf/core: Export perf_exclude_event()
  perf/x86: Relax privilege filter restriction on AMD IBS

 arch/s390/kernel/perf_cpum_sf.c |  6 ++--
 arch/x86/events/amd/ibs.c       | 59 +++++++++++++++++++++++----------
 include/linux/perf_event.h      |  6 ++++
 kernel/events/core.c            |  3 +-
 4 files changed, 51 insertions(+), 23 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


