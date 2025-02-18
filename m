Return-Path: <linux-kernel+bounces-518992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF94A396D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DE7188BC78
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8522230274;
	Tue, 18 Feb 2025 09:19:53 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A11FFC48
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870393; cv=none; b=tp3l5VFQe8Sdw0jw+dUMhncez9H4c2Ix7c6Dyj51r/wICkbMujEVyEkTDklhRZXRcqINJNjop+M53KleTCQbHXRS3c6F9C1LGr/UjnHQCSzHAybiKN2pHM+3uygLNmUZFgqvumJefUprx5ZNJbx5+hT8U9BEusQ1HHAzdE23uCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870393; c=relaxed/simple;
	bh=bm8fDjPIeiOH7fCF+lKeJZJ4f6L8udgW786BkS51F4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=je3R/KD+b+b2m3d2ttEim8/8gOs3kV/078lPHmQa6wJqNBsopi+sTEUqfCG8Lg3imepyBIfS9vaIucfjPI5SjZpxSiYmSuDpnwLmSQHi5w05I/TenKK4flH5Aozu5OFIQp+m8xmWY5/35GoOwH3lRQ2pV1MUokquyzLA046GX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4YxvBV1QbSzpk8m;
	Tue, 18 Feb 2025 17:20:18 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 87F84140259;
	Tue, 18 Feb 2025 17:19:47 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 17:19:46 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH 0/9] General updates and two new drivers for HiSilicon Uncore PMU
Date: Tue, 18 Feb 2025 17:19:51 +0800
Message-ID: <20250218092000.41641-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Support new version of DDRC/SLLC PMU identified with updated ACPI HID and
register definition. In order to support this, we do a preliminary refactor
to initialize device of each version by using driver data of each HID
rather than checking the version. This will also make the driver easier to
maintain and extend, since only the HID specific information along
with the new HID will be added to support the new version without touching
the common logic.

Two new Uncore PMU drivers is also added to support the monitoring the
events of the system bus (by NoC PMU) and the DVM opertaions (by MN PMU).

Junhao He (7):
  drivers/perf: hisi: Extend struct hisi_pmu_dev_info
  drivers/perf: hisi: Simplify the probe process for each DDRC version
  drivers/perf: hisi: Add support for HiSilicon DDRC v3 PMU driver
  drivers/perf: hisi: Use ACPI driver_data to retrieve SLLC PMU
    information
  drivers/perf: hisi: Add support for HiSilicon SLLC v3 PMU driver
  drivers/perf: hisi: Relax the event number check of v2 PMUs
  drivers/perf: hisi: Add support for HiSilicon MN PMU driver

Yicong Yang (2):
  drivers/perf: hisi: Support PMUs with no interrupt
  drivers/perf: hisi: Add support for HiSilicon NoC PMU

 Documentation/admin-guide/perf/hisi-pmu.rst   |  11 +
 drivers/perf/hisilicon/Makefile               |   3 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c | 354 ++++++++--------
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |   7 +-
 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c   | 355 ++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c  | 391 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  11 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |   2 +
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 234 ++++++++---
 10 files changed, 1104 insertions(+), 266 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

-- 
2.24.0


