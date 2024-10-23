Return-Path: <linux-kernel+bounces-377144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0D9ABA63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9037F1C22CAF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70F0196;
	Wed, 23 Oct 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q38IhB88"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B20380
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729642170; cv=none; b=DFMgmjc6l8fMhTqOifmVPQSdQOcP6bd897lw0K/be8h/dUr92gq6falR+HbS5fn/YkQBexljXU2R5RIo/RY/LzLrVFEZVtycy67iUTJ4JrKg9b4nGnd4++MsZ2Nxg6Xm5zGo2fiQ/6epTF5JPjkYZmroreN2pCcl0vpNQ0BOzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729642170; c=relaxed/simple;
	bh=7rlz7NmdWwCUF+DnjzaiHZPWW98Cm9/UVt7DJkGgtes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/4dq/y7YVaGg0kkzrIwvntOIeMjR79SsYRMzCngHxza3xP2B6sA6CGl0hJZIYbazxt4yK0fZNjMhGlRlKhdOui91XJlqrx3w4UFQDljFWhF4mKJmLVWykZTeEcGuGsz2LwMpMHNmkK2Zqric7dq9HwZcDxBITMPaVIo1CNUb34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q38IhB88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65871C4CEC3;
	Wed, 23 Oct 2024 00:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729642169;
	bh=7rlz7NmdWwCUF+DnjzaiHZPWW98Cm9/UVt7DJkGgtes=;
	h=From:To:Cc:Subject:Date:From;
	b=q38IhB88hYg9FwlfkkHwpaCmwsrxDNPLtomPFOsEFmZS2sK8lZMF50GdyCbb2upMI
	 TWyYa2YY6GKcRM7zDF3Ewqw1cYgf8ie/Ias4frXNK7TLG2809UDq9PPEfInU8fLOCM
	 9fwWJN5y8HhmeywerBXX685ppmMoMCOJACuT4s8S5LUjf69TfOVF0b0FsxMXmW8sU0
	 DevFBMGjWu1CT2OIdqCyYMzMHYikZjZ7m+Ap/PQ2TAmEmdbjsNQ31VCVDo/kwa7k89
	 pukRoW63u8D2N2GPjd3Vtxjck2ozFbsnU6cMp7FiarYSJAXPHg/yEIXjhzT0qJ3fsH
	 MsZE/5nCgNLnA==
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
Subject: [PATCH v4 0/5]  perf: Relax privilege restriction on AMD IBS
Date: Tue, 22 Oct 2024 17:09:23 -0700
Message-ID: <20241023000928.957077-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
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

v4 changes)

* remove RFC tag
* fix sysfs attribute for ibs_fetch/format  (Ravi)
* handle exclude_hv as well, so ":u" modifier would work for IBS
* add Acked and Reviewed-by from Kyle and Madhavan

v3 https://lore.kernel.org/lkml/20240905031027.2567913-1-namhyung@kernel.org

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
 arch/s390/kernel/perf_cpum_sf.c |  8 +++--
 arch/x86/events/amd/ibs.c       | 59 +++++++++++++++++++++++----------
 include/linux/perf_event.h      |  7 ++++
 include/uapi/linux/perf_event.h |  5 ++-
 kernel/events/core.c            | 27 ++++++++++++---
 6 files changed, 82 insertions(+), 28 deletions(-)


base-commit: de20037e1b3c2f2ca97b8c12b8c7bca8abd509a7
-- 
2.47.0.105.g07ac214952-goog


