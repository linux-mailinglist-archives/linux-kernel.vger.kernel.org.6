Return-Path: <linux-kernel+bounces-555609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F8A5BA38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A081895DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE2224B07;
	Tue, 11 Mar 2025 07:51:59 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC67146593
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679518; cv=none; b=KsIVSiIdWYMXqRUlpZoV8GPt1SqNfq71aCTUs80U6bwUFJ5ACE3zuD44AQ4PcNswbG54m3SNMi7n8RzzEUXqf9nfS7hdfDF+e9tB021ENDsS8ZJ76oxSINv9RrGt62DJGQp83/zCuMXBTFYZh1dRjj8DlrCurPTx1H0tQCDS/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679518; c=relaxed/simple;
	bh=tcNPGeNm2A19hynfJ1x3JoQyxqoyuKtwWbdmNcxBJu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6UmeO6o1o+enTDMK71rjwUFa3ajZrgDrWY0zqfCCsKEZhKCm7nc1Z47o02PxOoTAkMEgxJ/Xr3heMISWc5H0/S9u07aclQZ3H34jaLD1hozU9jZ5JyFiR3h4cCo28chV2+ZKWuelicCHew49GTz+mFFfjoRep2qxk5rNZGs8L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZBm9002pTz2CcGk;
	Tue, 11 Mar 2025 15:48:36 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 4CE511402CD;
	Tue, 11 Mar 2025 15:51:46 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Mar 2025 15:51:45 +0800
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
	<guohanjun@huawei.com>, <sshegde@linux.ibm.com>
Subject: [PATCH v12 0/4] Support SMT control on arm64
Date: Tue, 11 Mar 2025 15:51:39 +0800
Message-ID: <20250311075143.61078-1-yangyicong@huawei.com>
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

Tests has been done on our ACPI based arm64 server and on ACPI/OF
based QEMU VMs.

Change since v11:
- Remove the check and warning for heterogeneous platform as suggested and discussed
- refine comments/commit according to Dietmar
Link: https://lore.kernel.org/linux-arm-kernel/20250218141018.18082-1-yangyicong@huawei.com/

Change since v10:
- handle topology parsing failure case on DT based system
- address some style comments per Jonathan and add tags, Thanks
Link: https://lore.kernel.org/linux-arm-kernel/20241220075313.51502-1-yangyicong@huawei.com/

Change since v9:
- Refine the comment of topology_is_primary_thread(). Tested with LoongArch
  to prove it also works on architecture's not using CONFIG_GENERIC_ARCH_TOPOLOGY
- always call cpu_smt_set_num_threads() to make the smt/control shows correct
  status on non-SMT system
Link: https://lore.kernel.org/linux-arm-kernel/20241114141127.23232-1-yangyicong@huawei.com/

Change since v8:
- Fix WARN on ACPI based non-SMT platform noticed in v7, per Pierre.
Link: https://lore.kernel.org/all/20241105093237.63565-1-yangyicong@huawei.com/

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
- Drop the dependency on CONFIG_SMP since it's always on arm64, per Pierre
- Avoid potential multiple calls of cpu_smt_set_num_threads() on asymmetric system, per Dietmar
- Detect heterogeneous SMT topology and issue a warning for partly support, per Pierre
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
 arch/arm64/kernel/topology.c        | 54 +++++++++++++++++++++++++++++
 arch/powerpc/include/asm/topology.h |  1 +
 arch/x86/include/asm/topology.h     |  2 +-
 drivers/base/arch_topology.c        | 18 ++++++++++
 include/linux/topology.h            | 24 +++++++++++++
 6 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.24.0


