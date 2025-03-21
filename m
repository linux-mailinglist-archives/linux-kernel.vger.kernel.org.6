Return-Path: <linux-kernel+bounces-570837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D06A6B52D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F7C21888822
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9A91EDA01;
	Fri, 21 Mar 2025 07:38:34 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF6F2AF1B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542714; cv=none; b=qhuVhmQ56zXSsmp4TQJkTOek9o04wMDy93xikxph57IBG0EK94X2QMs3AtMyzAhKG77mprcHm6VtDGRYU+ZVhBK/ThvDpckLbJS7GYofRrl3eKlGgRJk8zn/LOSrB3kEnI8oel+cp/R0JSaUASncpK8tqwwRG1RNWJzaETB8EWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542714; c=relaxed/simple;
	bh=usV++e2AgawUljJSv4L3rQfJrq4B0dx0a0/0i80BJEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/ly4XOjYtlP162whtQX3ZLU6mTlbjVm+VvVDmxNEV9c+m20dfgDwLnwvQ/HEFNabmCtit7xyDwsS+KmXIRyFmiNoVIdU2DhkkGDG6MiXJVLSSiRtnY+GnySxcpLijwbJ9geZtmR3IC8nRHlbvdr+3VeTY5ISQHRxrbgUaky1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZJvTP48yYz27gMb;
	Fri, 21 Mar 2025 15:39:05 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id D22581A0188;
	Fri, 21 Mar 2025 15:38:28 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 21 Mar 2025 15:38:28 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hejunhao3@huawei.com>, <jonathan.cameron@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>,
	<yangyicong@hisilicon.com>, <wangyushan12@huawei.com>
Subject: [PATCH v2 0/8] General updates and two new drivers for HiSilicon Uncore PMU
Date: Fri, 21 Mar 2025 15:38:38 +0800
Message-ID: <20250321073846.23507-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Change since v1:
- Fold patch which extending the struct hisi_pmu_dev_info into its user
- Use bit shift rather than bit mask for SLLC PMU registers configuration
- Address other comments by Jonathan, thanks
Link: https://lore.kernel.org/linux-arm-kernel/20250218092000.41641-1-yangyicong@huawei.com/

Junhao He (6):
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
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |   6 +-
 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c   | 355 ++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c  | 392 ++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |   2 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |  11 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h      |   2 +
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 220 +++++++---
 10 files changed, 1098 insertions(+), 258 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_mn_pmu.c
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_noc_pmu.c

-- 
2.24.0


