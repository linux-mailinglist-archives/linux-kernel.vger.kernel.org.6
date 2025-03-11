Return-Path: <linux-kernel+bounces-556554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BA6A5CBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FEC1899BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF97B263C72;
	Tue, 11 Mar 2025 17:05:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366C2620D7;
	Tue, 11 Mar 2025 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712735; cv=none; b=cI9o1hiG0m/C4JAi7eoj/o06qCE7LWIWwzxgkfJ6aUohdSXhMhIxedtel80A0e8w8ecQhx3usF+A+G/2MfCbmpXMTW0pE6i2PR5mjFcbKI3Ta3QiL9IY8n5Q1YlSe4ZUKw9RyiEVO8gHAyrbUoYk/HO0rSnMlp/a+ep6Imjkhb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712735; c=relaxed/simple;
	bh=udctrwbuiTyYZLDxzpiksmAUIKV99gHl3fUEtUiKXzs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZXkWCGkwERdzj1LG0AqWEfTpY1IUkekz2UI7TfL9Qx+IE9TfLqGutVsOhBl1zI5BmUoRJdMKMq80dj4LvYCsKdVnjXlY/gDs/SXcQrRoOhXPXubxao9+yKYOvYTdv3OIJOEndqJp5O7wUo269pXt9+SJJJIkNmIMD9iJk3vNtsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FB73152B;
	Tue, 11 Mar 2025 10:05:42 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF4663F673;
	Tue, 11 Mar 2025 10:05:29 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/6] Arm CoreSight: Support AUX pause and resume
Date: Tue, 11 Mar 2025 17:04:45 +0000
Message-Id: <20250311170451.611389-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is to enable AUX pause and resume on Arm CoreSight.

The first patch extracts the trace unit controlling operations to two
functions.  These two functions will be used by AUX pause and resume.

Patches 02 and 03 change the ETMv4 driver to prepare callback functions
for AUX pause and resume.

Patch 04 changes the ETM perf layer to support AUX pause and resume in a
perf session.  The patches 05 updates buffer on AUX pause occasion,
which can mitigate the trace data lose issue.

Patch 07 documents the AUX pause usages with Arm CoreSight.

This patch set has been verified on the Hikey960 board and TC platform.
The previous one uses ETR and the later uses TRBE as sink.

It is suggested to disable CPUIdle (add `nohlt` option in Linux command
line) when verifying this series.  ETM and funnel drivers are found
issues during CPU suspend and resume which will be addressed separately.

Changes from v2:
- Rebased on CoreSight next branch.
- Dropped the uAPI 'update_buf_on_pause' and updated document
  respectively (Suzuki).
- Renamed ETM callbacks to .pause_perf() and .resume_perf() (Suzuki).
- Minor improvement for error handling in the AUX resume flow.

Changes from v1:
- Added validation function pointers in pause and resume APIs (Mike).


Leo Yan (6):
  coresight: etm4x: Extract the trace unit controlling
  coresight: Introduce pause and resume APIs for source
  coresight: etm4x: Hook pause and resume callbacks
  coresight: perf: Support AUX trace pause and resume
  coresight: perf: Update buffer on AUX pause
  Documentation: coresight: Document AUX pause and resume

 .../trace/coresight/coresight-perf.rst        |  31 ++++
 drivers/hwtracing/coresight/coresight-core.c  |  22 +++
 .../hwtracing/coresight/coresight-etm-perf.c  |  84 +++++++++-
 .../coresight/coresight-etm4x-core.c          | 143 +++++++++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +
 drivers/hwtracing/coresight/coresight-priv.h  |   2 +
 include/linux/coresight.h                     |   4 +
 7 files changed, 246 insertions(+), 42 deletions(-)

-- 
2.34.1


