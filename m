Return-Path: <linux-kernel+bounces-214497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFA890858F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1328F284A38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C2187565;
	Fri, 14 Jun 2024 07:59:33 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCAA18755E
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351973; cv=none; b=IOkN7fpdvVpNFdjytBjzUL38WvxVnAFbuCMDwcmhJ5Sgew50e3Q3BMw+d1IgQN74Jj/XMaIu8ZbJp8JYcNMdiSu+Zc+v6jENR84fkkRbd62zWNvzE4EclsVzJy5+iVymI0m2qW/JV7TbbZvCUZhyYoQEfGhIRo5G8LkRZGIpfuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351973; c=relaxed/simple;
	bh=82mosCs27ITWTJUCV0xYEfOAWcf98zU8jdLeP6ZvQsE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tl0Jvn/M8p7mZ/FfRiCaS+s+JxPuSNJeXszfXhTjMtXdkKLuYTkuCDH+X16zAX4eZCHRKJZeu4fIA8dVK+VLJEMDvtVCfTyOnUt4hLq7g6n11Z7XhUTUWD87otBr0ZQRR85b/YO4bZvUSy/fymzgCbuhkUMs4fHFYGZujrerVaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W0s5M02sjz1SBfV;
	Fri, 14 Jun 2024 15:55:19 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 287F7180069;
	Fri, 14 Jun 2024 15:59:27 +0800 (CST)
Received: from huawei.com (10.67.174.76) by dggpemd100004.china.huawei.com
 (7.185.36.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 14 Jun
 2024 15:59:26 +0800
From: Yuntao Liu <liuyuntao12@huawei.com>
To: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<liuyuntao12@huawei.com>
Subject: [PATCH] RISC-V: Dynamically allocate cpumasks and further increase range and default value of NR_CPUS
Date: Fri, 14 Jun 2024 07:53:06 +0000
Message-ID: <20240614075306.357861-1-liuyuntao12@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)

Currently default NR_CPUS is 64 for riscv64, since the latest QEMU virt
machine supports up to 512 CPUS, so set default NR_CPUS 512 for riscv64.

Under the promotion of RISC-V International and related chip
manufacturers, RISC-V has also begun to enter the server market, which
demands higher performance. Other major architectures (such as ARM64,
x86_64, MIPS, etc) already have a higher range, so further increase
this range up to 4096 for riscv64.

Due to the fact that increasing NR_CPUS enlarges the size of cpumasks,
there is a concern that this could significantly impact stack usage,
especially for code that allocates cpumasks on the stack. To address
this, we have the option to enable CPUMASK_OFFSTACK, which prevents
cpumasks from being allocated on the stack. we choose to enable this
feature only when NR_CPUS is greater than 512, why 512, since then
the kernel size with offstack is smaller.

vmlinux size comparison(difference to vmlinux_onstack_NR_CPUS baseline):

NR_CPUS     256         512         1024        2048        4096
onstack     19814536    19840760    19880584    19969672    20141704
offstack    19819144    19840936    19880480    19968544    20135456
difference  +0.023%     +0.001%     -0.001%     -0.001      -0.031%
is_smaller  n           n           y           y           y

Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
---
 arch/riscv/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0525ee2d63c7..5960713b3bf9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -77,6 +77,7 @@ config RISCV
 	select CLINT_TIMER if RISCV_M_MODE
 	select CLONE_BACKWARDS
 	select COMMON_CLK
+	select CPUMASK_OFFSTACK if NR_CPUS > 512
 	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
@@ -428,11 +429,11 @@ config SCHED_MC
 config NR_CPUS
 	int "Maximum number of CPUs (2-512)"
 	depends on SMP
-	range 2 512 if !RISCV_SBI_V01
+	range 2 4096 if !RISCV_SBI_V01
 	range 2 32 if RISCV_SBI_V01 && 32BIT
 	range 2 64 if RISCV_SBI_V01 && 64BIT
 	default "32" if 32BIT
-	default "64" if 64BIT
+	default "512" if 64BIT
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-- 
2.34.1


