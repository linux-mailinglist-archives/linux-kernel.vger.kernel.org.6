Return-Path: <linux-kernel+bounces-309565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06573966CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B851228476B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A36318E341;
	Fri, 30 Aug 2024 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7ekMyTU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC2178389
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725060552; cv=none; b=nM9VKSPRKeg/TK5jXw8bDan5RIO7TW26TDaGV/i6zU1rUm5jNTKGsnkp7oaMXwXjqI8jO6HBQyhPMgSMH9Gg8ruPWshiWXW8EGU0NSTXnYISW4yskBiZ3qqPAgD3tyPBvIqe5ZNZv0yHQ7BX2QqYieNFiDhfsIVf8OD2vInjisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725060552; c=relaxed/simple;
	bh=V9kYcsA5oxmJbTnxP/uw209RZRlY9o37zXTZdKLuG+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bUreqDgqnmi9B0+8YLFwURSPRQiCvW0fkeABFBNpOAfOM0lAP6SDaVRcqVheZrEY+dM1xUpOuohvJEWgRBsxCW87Folgu9GOyrF4ZJQewM0hkCkKRO/eQ0/5EhIS5WWlzwOTUKa5XdIJv9RHK6ApeRkK+0uFZpeVmK3i8bxNhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7ekMyTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502DEC4CECF;
	Fri, 30 Aug 2024 23:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725060551;
	bh=V9kYcsA5oxmJbTnxP/uw209RZRlY9o37zXTZdKLuG+g=;
	h=From:To:Cc:Subject:Date:From;
	b=F7ekMyTUi2cwmFPCgeKaJ005AY5M3mM9UsZofNjEtkpzoYB9Pke/XG73Mq9FUx12n
	 aetFB0Uf6gwQ8G2WQCLhkYvKtmNsKKFFrHv6dcqc8B7USN4oJL6PqlortN74NBGZmT
	 Hukp+YSzq16uINFij4iH3Jf5B2AaklQtThpBzMBb/ruqjhg8UV7LyxhN/WEdxVv6b4
	 AZfnDG8x1eFtT3U/3Q06Y7AQGc1aCHlXfZvFnyyQNFIsyB9Aok7dyV61zyw97WU45y
	 3gwx4HO9OnTkfrxjTAWeYLsYFKZd+3qcYtQYvbI06RKgrF/4ZLD/oqBptcNSjhUmYb
	 cVBco/B1CA9Cw==
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
Subject: [RFC/PATCH 0/4] perf: Relax privilege restriction on AMD IBS (v2)
Date: Fri, 30 Aug 2024 16:29:06 -0700
Message-ID: <20240830232910.1839548-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is RFC v2 to allow AMD IBS to regular users on the default settings
where kernel-level profiling is disabled.  Currently AMD IBS doesn't
allow any kind of exclusion in the event attribute.  But users needs to
set attr.exclude_kernel to open an event on such an environment.

v2) changes

* add PERF_FORMAT_DROPPED
* account dropped sw events and from BPF handler
* use precise RIP from IBS record

v1) https://lore.kernel.org/lkml/20240822230816.564262-1-namhyung@kernel.org/

While IBS doesn't support hardware level privilege filters, the kernel
can allow the event and drop samples belongs to the kernel like in the
software events.

In order to count those dropped samples correctly, I'd propose a new
read format PERF_FORMAT_DROPPED same as we did for the lost samples.
With this, it can count dropped samples in the software events and
from the BPF overflow handler as well.

Let me know what you think.

Thanks,
Namhyung


Namhyung Kim (4):
  perf/core: Add PERF_FORMAT_DROPPED
  perf/core: Export perf_exclude_event()
  perf/core: Account dropped samples from BPF
  perf/x86: Relax privilege filter restriction on AMD IBS

 arch/x86/events/amd/ibs.c       | 13 +++++++++++--
 include/linux/perf_event.h      |  3 +++
 include/uapi/linux/perf_event.h |  5 ++++-
 kernel/events/core.c            | 27 ++++++++++++++++++++++-----
 4 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


