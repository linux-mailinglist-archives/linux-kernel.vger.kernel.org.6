Return-Path: <linux-kernel+bounces-396200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FE9BC944
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D39B24012
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EF9188734;
	Tue,  5 Nov 2024 09:33:21 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28D1D0F63
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799201; cv=none; b=hMEM+U0hXw9KXzihvQA6k4Fi/5Y3clbkgVBXXsNsHPtm2m15tHK299H9wFnZ2zpxMkPZ2XAO5UfDO4L7IW8Cyj0c940kMFHDIKLc9qPFmBJZ7loXlB4aqFwZ0k+/QTUG1dfGkCiC6PK9bDgZ2Ofgag48YxwKpkTCOYlbcPRm3JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799201; c=relaxed/simple;
	bh=mtbLo+J8r2HrGEDxQ3qNCbb5RRZCOixkEBOX+ZMMCmI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DQfJwaWq9p9dPzyS0oEfjVUGe2Ew5mLdBxZCwIgwvu8+p4iXkv4ASIVCOdBj0ZR5H9oIgmLnNW2QrnviWnliJL6Z6J4cid25C4GWQT8jwtGITdLGYPGBJsGHjWruv7t5zGnmTX/Loq20yEKdwz2Ug2HVlZNoD29J1bwAvhyYFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XjNQW53RZzQsYC;
	Tue,  5 Nov 2024 17:32:03 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id AF49D1400CA;
	Tue,  5 Nov 2024 17:33:09 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 5 Nov 2024 17:33:08 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <sudeep.holla@arm.com>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>, <xuwei5@huawei.com>,
	<guohanjun@huawei.com>
Subject: [PATCH v8 0/4] Support SMT control on arm64
Date: Tue, 5 Nov 2024 17:32:33 +0800
Message-ID: <20241105093237.63565-1-yangyicong@huawei.com>
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

The core CPU control framework supports runtime SMT control which
is not yet supported on arm64. Besides the general vulnerabilities
concerns we want this runtime control on our arm64 server for:

- better single CPU performance in some cases
- saving overall power consumption

This patchset implements it in the following aspects:

- Provides a default topology_is_primary_thread()
- support retrieve SMT thread number on OF based system
- support retrieve SMT thread number on ACPI based system
- select HOTPLUG_SMT for arm64

Tests has been done on our real ACPI based arm64 server and on
ACPI/OF based QEMU VMs.

Change since v7:
Address the comments from Thomas:
- Add a newline between the glue define and function of topology_is_primary_thread
- Explicitly mention the sibling mask won't be empty in the comment
Link: https://lore.kernel.org/lkml/20241030125415.18994-1-yangyicong@huawei.com/

Change since v6:
- Fix unused variable if !CONFIG_ARM64 || !CONFIG_RISV found by lkp-test
- Fix max_smt_thread_num updating in OF path pointed by Pierre
- Drop unused variable and refine the comments/commit per Pierre
Link: https://lore.kernel.org/linux-arm-kernel/20241015021841.35713-1-yangyicong@huawei.com/

Change since v5:
- Drop the dependency on CONFIG_SMP since it's always on on arm64, per Pierre
- Avoid potential multiple calls of cpu_smt_set_num_threads() on asymmetric system, per Dietmar
- Detect heterogenous SMT topology and issue a warning for partly support, per Pierre
- Thanks Dietmar for testing, didn't pickup the tag due to code changes. Thanks testing by Pierre
Link: https://lore.kernel.org/linux-arm-kernel/20240806085320.63514-1-yangyicong@huawei.com/

Change since v4:
- Provide a default topology_is_primary_thread() in the framework, Per Will
Link: https://lore.kernel.org/linux-arm-kernel/20231121092602.47792-1-yangyicong@huawei.com/

Change since v3:
- Fix some build and kconfig error reported by kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-arm-kernel/20231114040110.54590-1-yangyicong@huawei.com/

Change since v2:
- Detect SMT thread number at topology build from ACPI/DT, avoid looping CPUs
- Split patches into ACPI/OF/arch_topology path and enable the kconfig for arm64
Link: https://lore.kernel.org/linux-arm-kernel/20231010115335.13862-1-yangyicong@huawei.com/

Yicong Yang (4):
  cpu/SMT: Provide a default topology_is_primary_thread()
  arch_topology: Support SMT control for OF based system
  arm64: topology: Support SMT control on ACPI based system
  arm64: Kconfig: Enable HOTPLUG_SMT

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/kernel/topology.c        | 57 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/topology.h |  1 +
 arch/x86/include/asm/topology.h     |  2 +-
 drivers/base/arch_topology.c        | 24 ++++++++++++
 include/linux/topology.h            | 20 ++++++++++
 6 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.24.0


