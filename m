Return-Path: <linux-kernel+bounces-519587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFB8A39E56
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C07616B3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D0B269D12;
	Tue, 18 Feb 2025 14:10:16 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EC6269B02
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887815; cv=none; b=L/vjj+pVbtxc/vBgX/7NhYZCArQGTlhA9SFHGOwmKDpCZ67UxGVai25T0hPbqzUalJQJrPHxpmlObD1FuQPpAlJ/efndRCpThEdc2Cs1pxJXSbjXEfJyFPdkt0WEip0F36w2WU1fe128mRHOPdKVSiT7RB+y9Iu1sI3LlbPMVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887815; c=relaxed/simple;
	bh=LRl8TxXKYLKQOTgJsRcLmBgOSWF1FAn4AnP32fxf0tY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4hOqSsLnJTVSQ2MOPBGc4UrXd6xFe4jKWs7tZ55Fqk1nIFFw9sr7pshmxVYQbto2AX4pwUWg1Rb+/ZJLxZOZqeQJ+gVSe5aEmVmFwoCGRvWcf4liovf+sxA/ucvD4Zv+lYyUxybjBS6DJ5tVQKx4P/UdI7Z3oL3AKxg813Zh4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Yy1dY4T6SzpkCN;
	Tue, 18 Feb 2025 22:10:41 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id EA2EF1401F1;
	Tue, 18 Feb 2025 22:10:10 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 18 Feb 2025 22:10:09 +0800
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
Subject: [PATCH v11 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
Date: Tue, 18 Feb 2025 22:10:18 +0800
Message-ID: <20250218141018.18082-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250218141018.18082-1-yangyicong@huawei.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Enable HOTPLUG_SMT for SMT control.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..947616d37e0c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -251,6 +251,7 @@ config ARM64
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
+	select HOTPLUG_SMT if HOTPLUG_CPU
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
 	select KASAN_VMALLOC if KASAN
-- 
2.24.0


