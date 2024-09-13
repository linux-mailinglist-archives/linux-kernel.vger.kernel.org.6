Return-Path: <linux-kernel+bounces-328327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5628097821D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 16:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7381F2645A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394A01E0B9D;
	Fri, 13 Sep 2024 13:59:13 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0B61E009D;
	Fri, 13 Sep 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235952; cv=none; b=SLqvqUOMSYa3lvo2cBQDeZOy2UKdyjg4IFCIFl4R2rAf/Mz/E3gREchIXKoB1/5hSMJb3pDPOK3zzWiGWBVTojx/2cmaaRj91kkc24ibIjTzFTPoYbpcECCVGqxq7jDpn1dMZaJkBiY4XaCyY5Iat0cNtE8C3qe42RT10x+4YUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235952; c=relaxed/simple;
	bh=TfrJsCoxLEjQEhNqRE84QZ0HtAFlFvOU8ohO/Zkk66A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hMLJvY+kmTk81eHqlxYBTPWmpMF01MICiZRgfsxxKt5K1WRvqYtmvV3K9yxm5yzJsmLjtcwTFFA1h566w5IJ3K0dW4TcYIh9aULLo0nv7CZgLAUic4flI54R7yrSn0qbZdTks1KQ+b2ZnsRykcMJQUWF+jnIBpGOfXMe5MjJWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 586AF339;
	Fri, 13 Sep 2024 06:59:40 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E18B43F73B;
	Fri, 13 Sep 2024 06:59:08 -0700 (PDT)
From: Levi Yun <yeoreum.yun@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	james.clark@linaro.org,
	asmadeus@codewreck.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 0/2] Minor fixes error handling of perf stat
Date: Fri, 13 Sep 2024 14:59:05 +0100
Message-Id: <20240913135907.648734-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset fixes two issues that were seen when running
  "perf stat -r" with perf_event_paranoid=3

   1. failed with Too many open files.
     $ perf stat -r 1044 -- false
     ...
     failed to create 'go' pipe: Too many open files
     failed to prepare workload: Too many open files
     ...

   2. repating error message
     $ perf stat -r 1044 -- false
     Error:
     Access to performance monitoring and observability operations is limited.
     ...
     (repating with same error message 1044 times).

v4:
  - Move comments to run_perf_stat().

v3:
  - Fix comments.

v2:
  - Add some comments.

Levi Yun (2):
  perf stat: Close cork_fd when create_perf_stat_counter() failed
  perf stat: Stop repeating when ref_perf_stat() returns -1

 tools/perf/builtin-stat.c | 11 ++++++++++-
 tools/perf/util/evlist.c  | 14 +++++++++++++-
 tools/perf/util/evlist.h  |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


