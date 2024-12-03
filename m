Return-Path: <linux-kernel+bounces-429981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4A79E2A41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41D3284D9D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED691FC7E4;
	Tue,  3 Dec 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEVFvJrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FBE1FBEA5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249083; cv=none; b=qTG984NmPvjmKM5qYvml1/CYNneUBQmNkyxWaLLOZ25td5Lkdsy9p8c0Yjpt3f/AAMOO78gxNcPXufV334IYvRG3YU1XQMFRpPTW9k09T7vkHdC9coYC7cab6PFRpXrUXv7/n5xOd2p7PNXpH3ZT9sRgYnpEmQ+fIhqtln0PC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249083; c=relaxed/simple;
	bh=m9oWvK5bOeQAAs9/R49XPd8h7UE2JPqfV743Ea8xDsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YG5tQSRz4Uma+8EtnY+dNd0MTqygEwsART8v9/QqFFb6oJv3mBbSt9x7+sv/8QhvAlEc8w5BC2rOwp7t2psIe0c2KOtr4psD8scSTIhpjrntiO6Pb2H4SerGc2GnTwRJONZErv9kzTEYPH9XW3cgmajCJ6gkz4p0mnwCPkuT/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEVFvJrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9FC4CECF;
	Tue,  3 Dec 2024 18:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249082;
	bh=m9oWvK5bOeQAAs9/R49XPd8h7UE2JPqfV743Ea8xDsM=;
	h=From:To:Cc:Subject:Date:From;
	b=cEVFvJrWzzKkKkBLcG6gMSM0H39ra/39SlyqANv/PS/k3oxOT7Fo3bRUMMBluAxfQ
	 ygskOUfIhIaudeGXUEaboU/1Ac+66LKR3OqGNbf3juv6kWLdcgIh2l0hrOehpbLD5Y
	 1TMEP0K0zzqu1nYBBYjpRC7U87hUU7oQvImHM2zjuQmn/Mau83WHHDbu+Pwzp8yxk3
	 3C0u5YUDyq7G0U66FlaCPfneIKqBJaQ+rDxQEkGkumOQtSiSs3Fz1ItJc3Gi+5jWA/
	 n71pCDr3YXA+Q+D/gzkTZoga1srb1AQyIzkZ1Tzsw7wJkRqOK9Mq2H9IGKqqiNRPoG
	 jHZqeIoCTd4qA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 0/2] perf: Relex privilege restriction on AMD IBS
Date: Tue,  3 Dec 2024 10:04:39 -0800
Message-ID: <20241203180441.1634709-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v6 to allow AMD IBS to regular users on the default settings
where kernel-level profiling is disabled (perf_event_paranoid=2).
Currently AMD IBS doesn't allow any kind of exclusion in the event
attribute.  But users needs to set attr.exclude_kernel to open an
event on such an environment.

v6 changes)

* add Reviewed-and-tested-by from Ravi

v5) https://lore.kernel.org/lkml/20241028200153.1466731-1-namhyung@kernel.org

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
2.47.0.338.g60cca15819-goog


