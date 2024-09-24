Return-Path: <linux-kernel+bounces-336613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC86983D04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2C21C22623
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB3A79B8E;
	Tue, 24 Sep 2024 06:20:16 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BBC4779F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158815; cv=none; b=X/Wxc3r2bXmQbJDbofVy0bR70FbTl/rp6iiImO2mn0kArXZBbSTnDQsnqvXsXH4YboZoepw11t/E1M6gr3jU+n4LGQO9UAnlkhbw5kzp54nCYcRoxBDXcRkwd4BI51pX0d0hCSuqapWNynvTz8xvVMeLDb604O5gVUCMnUzZTwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158815; c=relaxed/simple;
	bh=5FQDDYs0nRz+Oq1YU4mWw8FOlIj9pbeglI4+dvIYkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZEPpbpr8kbwJzsyD9tqM3UPmW/bDNlBlgnozOcrvJqsY6/p0LFd3/urbTtxNbWPZh1D4BhcYbCypIe0B3RobUi6T/hBQEv1tUrlJyMFI/6XcsbkG4f7UXqDcnH5HlF5UJyF+BxrRzSev3msitRPkuttVXW1GhO3Tf71AEVl0iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxbeoTWvJmJb4NAA--.31651S3;
	Tue, 24 Sep 2024 14:20:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front2 (Coremail) with SMTP id qciowMCxbccSWvJmJHwQAA--.2260S2;
	Tue, 24 Sep 2024 14:20:02 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Enable generic CPU vulnerabilites support
Date: Tue, 24 Sep 2024 14:20:01 +0800
Message-ID: <20240924062001.31029-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qciowMCxbccSWvJmJHwQAA--.2260S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFyDAFy8XF4kZFW3tFy5Awc_yoW8tF15pF
	ZYyr1SqrW7JF4xJrnF9a48GFWUX34kKa1fXryqyrW8GayfCryUWw4fJr13t3WjvrZ8Gayf
	ZayFgFWSqF4UZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

Currently, many architectures support generic CPU vulnerabilites,
such as x86, arm64 and riscv:

  commit 61dc0f555b5c ("x86/cpu: Implement CPU vulnerabilites sysfs functions")
  commit 61ae1321f06c ("arm64: enable generic CPU vulnerabilites support")
  commit 0e3f3649d44b ("riscv: Enable generic CPU vulnerabilites support")

All LoongArch CPUs (not only LS3A5000) implement a special mechanism
in the processor core to prevent "Spectre" and "Meltdown" attacks, so
it can enable generic CPU vulnerabilites support for LoongArch too.

Without this patch, there are no user interfaces of vulnerabilities
to check on LoongArch. The output of those files reflects the state
of the CPUs in the system, the output value "Not affected" means
"CPU is not affected by the vulnerability".

Before:

  # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  cat: /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow: No such file or directory
  # cat /sys/devices/system/cpu/vulnerabilities/spec_store_bypass
  cat: /sys/devices/system/cpu/vulnerabilities/spec_store_bypass: No such file or directory
  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
  cat: /sys/devices/system/cpu/vulnerabilities/meltdown: No such file or directory

After:

  # cat /sys/devices/system/cpu/vulnerabilities/spec_rstack_overflow
  Not affected
  # cat /sys/devices/system/cpu/vulnerabilities/spec_store_bypass
  Not affected
  # cat /sys/devices/system/cpu/vulnerabilities/meltdown
  Not affected

Link: https://www.loongson.cn/EN/news/show?id=633
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 6d68c5020307..4b02b0492c3b 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -84,6 +84,7 @@ config LOONGARCH
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_CPU_DEVICES
+	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
-- 
2.42.0


