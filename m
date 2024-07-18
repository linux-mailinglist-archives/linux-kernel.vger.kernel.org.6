Return-Path: <linux-kernel+bounces-255946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DF39346EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61569283EED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FAA39FD4;
	Thu, 18 Jul 2024 03:50:10 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581579D2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721274610; cv=none; b=DN740IrmYsOvRAk9HFc7VHl/faYDA1+dVVshzWXE8YmHlLUwzAFff6EI8qcd7QeEjo8I9/6nAvzq8FjbOIGx7dzOMRBVDNj6yQo8lYYEEKn16epR0T3KO2zOD3PxWU8gTurL4oz9ks9LTPGgh/PENgXG4gt/itHIYYFT4vbrUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721274610; c=relaxed/simple;
	bh=UVhbin2h8kH7gkcKkUqbr+ik+FV8pkbCMXoISG3lcfE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IU8hxeVAXxBO0MkRBV5FAALtJboyWWUlb+YaaNVAXLESaU+Gkji5qqKbjaDRpbInwtFUrUtoN5JGzphFuwo8VWwJN7DpdYYKtmKHA+UFVCfoBR6Zl4IhB1Zz2bgaBg0acSQRtBZU7lQqjrjd+ap1G1HJ6AW65fyeWvfAkg53VCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WPdx33lvqz1JCft;
	Thu, 18 Jul 2024 11:45:11 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 31B2C140109;
	Thu, 18 Jul 2024 11:50:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 11:50:03 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <bhe@redhat.com>,
	<vgoyal@redhat.com>, <dyoung@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<eric.devolder@oracle.com>, <gregkh@linuxfoundation.org>,
	<javierm@redhat.com>, <deller@gmx.de>, <robh@kernel.org>,
	<hbathini@linux.ibm.com>, <thunder.leizhen@huawei.com>,
	<chenjiahao16@huawei.com>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v3 0/3] crash: Fix x86_32 memory reserve dead loop bug
Date: Thu, 18 Jul 2024 11:54:41 +0800
Message-ID: <20240718035444.2977105-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Fix two bugs for x86_32 crash memory reserve, and prepare to apply generic
crashkernel reservation to 32bit system. Then use generic interface to
simplify crashkernel reservation for ARM32.

changes in v3:
- Fix it as Baoquan suggested.
- Update the commit message.

changes in v2:
- Peel off the other two patches.
- Update the commit message and fix tag.

Jinjie Ruan (3):
  crash: Fix x86_32 crash memory reserve dead loop bug
  crash: Fix x86_32 crash memory reserve dead loop bug at high
  ARM: Use generic interface to simplify crashkernel reservation

 arch/arm/Kconfig                       |  3 ++
 arch/arm/include/asm/crash_reserve.h   | 24 ++++++++++
 arch/arm/kernel/setup.c                | 63 ++++----------------------
 arch/arm64/include/asm/crash_reserve.h |  2 +
 arch/riscv/include/asm/crash_reserve.h |  2 +
 arch/x86/include/asm/crash_reserve.h   |  1 +
 kernel/crash_reserve.c                 |  5 +-
 7 files changed, 44 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/include/asm/crash_reserve.h

-- 
2.34.1


