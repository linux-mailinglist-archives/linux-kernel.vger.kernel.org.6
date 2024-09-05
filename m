Return-Path: <linux-kernel+bounces-316247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9896CD0A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81BD4281089
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAD41442E8;
	Thu,  5 Sep 2024 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTUzM9ro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5211422D4
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505828; cv=none; b=aTLI0zKa92SfT37NaU+gXkdxnl8zYeAhaRgcqsa4pVrGBKF88e5N8FfF3IPbRb9d5hpEALQN00fp8fZy8L1w+7xwkOE6DX7qI6yCmtb+8o2EoVR+BdhvegOSS010pi62z7Occi4she4zaXzOgv0ivPnHQvLUd/2Rku+TVGNkD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505828; c=relaxed/simple;
	bh=8U/+lWF0Wmx6pUU6P6UrrUMykJO3VDzldoqy1DB1r8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BgOW5y4xe9ijFQprQxOJqDEKhlneaZ0MmY292TcT//jN122hUlT7hNTNAi03ja8kAQcymLMzMwfUbrpEtP7/o14j9tE7DUX7NemE76bFN0De5W2v91eRcc9s1D/A1BOZkt06P2g7xcCqRLy49MyUawcKJ7VPB8dI5vyTp/QN1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTUzM9ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF86C4CEC2;
	Thu,  5 Sep 2024 03:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725505828;
	bh=8U/+lWF0Wmx6pUU6P6UrrUMykJO3VDzldoqy1DB1r8k=;
	h=From:To:Cc:Subject:Date:From;
	b=hTUzM9romQOYOJNPRHH3o5DZshnE6uXFltI/o2FEen3LhCqxj8Sjs2aaJFuJk/Urt
	 C6RWFczlNV/USikuFP3CefW+qIExchEbmlfF9HTv+i6EfVzKtK3QcbzicNw3qaAEXg
	 qvbDykq8m4vPcr5uvRY6Ry1FumwLICeqW1D04dDFO6d72lF+STQ4dQuJGafJZQneub
	 8BXEVPIa8KIfgOsoUcVKWkKwkAivQ1uUfbawBCX3bGyzVFHOizGxMt6+mtBOO4CGDB
	 hWAlhj55WpSU+0bRdSN+Rue5ddh4F/oVQ56eZbx9/eHz5+PCHkdgMt9ji7Sx++qEi3
	 xnQLUJHnLfdcg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [RFC/PATCH 0/5] perf: Relax privilege restriction on AMD IBS (v3)
Date: Wed,  4 Sep 2024 20:10:22 -0700
Message-ID: <20240905031027.2567913-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is RFC v3 to allow AMD IBS to regular users on the default settings
where kernel-level profiling is disabled (perf_event_paranoid=2).
Currently AMD IBS doesn't allow any kind of exclusion in the event
attribute.  But users needs to set attr.exclude_kernel to open an event
on such an environment.

v3 changes)

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

  $ perf record -e ibs_op/swfilt=1/uh $PROG

(Not sure if it's better to accept or ignore exclude_hv so that it can
use ":u" modifier only.)

In order to count those dropped samples correctly, I'd propose a new
read format PERF_FORMAT_DROPPED same as we did for the lost samples.
With this, it can count dropped samples in the software events and
from the BPF overflow handler as well.

Let me know what you think.

Thanks,
Namhyung


Namhyung Kim (5):
  perf/core: Add PERF_FORMAT_DROPPED
  perf/core: Export perf_exclude_event()
  perf/core: Account dropped samples from BPF
  perf/powerpc: Count dropped samples in core-book3s PMU
  perf/x86: Relax privilege filter restriction on AMD IBS

 arch/powerpc/perf/core-book3s.c |  4 ++-
 arch/s390/kernel/perf_cpum_sf.c |  8 ++++--
 arch/x86/events/amd/ibs.c       | 50 ++++++++++++++++++++++++---------
 include/linux/perf_event.h      |  7 +++++
 include/uapi/linux/perf_event.h |  5 +++-
 kernel/events/core.c            | 27 ++++++++++++++----
 6 files changed, 77 insertions(+), 24 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


