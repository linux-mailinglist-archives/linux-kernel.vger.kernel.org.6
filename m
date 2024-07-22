Return-Path: <linux-kernel+bounces-258432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9A9387D4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 05:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E89CB2106B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DE6182B2;
	Mon, 22 Jul 2024 03:52:18 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE217C7C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721620337; cv=none; b=sFzlQuPp7UA3/1fBgr1RvqcYrJuDP84WogNCmuDPuqUUGIqVb7xN9f8xISpKeKFF6w1Mf4P5Jf2BjQjNIlNdcgp6SNH51BxisK+L2c8JubcTD0XezzDxUIY45cet/TvzgyDyaz6zUXtJ4afPhAVfeqpnUkRej96p64nreC76re4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721620337; c=relaxed/simple;
	bh=kD6ozyoyatyHCh4TtJcouGzvcFXx9//icFteEAwHw0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWBL57pu2PjcvNVSGiyZIqOFsXcLncoHhRSQiHUAMZ09xd2paktKdunZ5PlR/POb8zMSk0cwQvCWTJtuiZZGKu9mO8jmlQpQ7FeZoBJ7zjMsnOx9Kp2iQrjE3AEIjVPl8FhqHsVtdzmShwu5gVjkGJ5XWDikZDI1vvM5xuzsmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WS5p80pm5z1X4Xv;
	Mon, 22 Jul 2024 11:47:44 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 44DAD1A016C;
	Mon, 22 Jul 2024 11:52:07 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 22 Jul
 2024 11:52:06 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<arnd@arndb.de>, <gregkh@linuxfoundation.org>, <deller@gmx.de>,
	<javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<alexghiti@rivosinc.com>, <bjorn@rivosinc.com>, <akpm@linux-foundation.org>,
	<namcao@linutronix.de>, <dawei.li@shingroup.cn>, <chenjiahao16@huawei.com>,
	<rppt@kernel.org>, <julian.stecklina@cyberus-technology.de>,
	<rafael.j.wysocki@intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v4 0/3] crash: Fix crash memory reserve exceed system memory bug
Date: Mon, 22 Jul 2024 11:56:58 +0800
Message-ID: <20240722035701.696874-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi100008.china.huawei.com (7.221.188.57)

On x86_32, arm32 and riscv32, the crash memory reserve may exceed system
memory and display "reserved ok", fix it.

changes in v4:
- Update the warn info to align with parse_crashkernel_mem().
- Rebased on the "ARM: Use generic interface to simplify crashkernel
  reservation" patch.
- Also fix for riscv32.
- Update the commit message.

changes in v3:
- Handle the check in reserve_crashkernel() Baoquan suggested.
- Split x86_32 and arm32.
- Add Suggested-by.
- Drop the wrong fix tag.

changes in v2:
- Also fix for x86_32.
- Update the fix method.
- Peel off the other two patches.
- Update the commit message.

Jinjie Ruan (3):
  x86/kexec: Fix crash memory reserve exceed system memory bug
  ARM: Fix crash memory reserve exceed system memory bug
  riscv: kdump: Fix crash memory reserve exceed system memory bug

 arch/arm/kernel/setup.c | 5 +++++
 arch/riscv/mm/init.c    | 5 +++++
 arch/x86/kernel/setup.c | 5 +++++
 3 files changed, 15 insertions(+)

-- 
2.34.1


