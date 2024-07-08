Return-Path: <linux-kernel+bounces-244387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA77A92A3A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B0D1F22779
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27581139D15;
	Mon,  8 Jul 2024 13:29:54 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B4B665
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445393; cv=none; b=MxHjvkFQkId2e9kUOjt39D5OsGNzT5gcC/KTTftWQ1liJXOGD9OmI5jz3+JOscwdIYgAdr0RXvFNV8LSSjBavR5qe27Y3calJqmTipgaPHime/rG8E8jVXZMfDx+TmjptqKhaI6CCgm7YY3+PNDHQ8bTBe7cTd6A2Pmm0x4ywoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445393; c=relaxed/simple;
	bh=Mi4GSE3gm+fErCC3cU3mZPhxHzANML4Hc56U2pjR/sI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lfi3g9863aaSBdMuOwhnB5ovpsU1+/js8pzhMGl0SzaM0k2Nx/SV+2LJz6Xv0QKobrcL04OKimCI8QlmrWwZI9r2lXCdOHoV0hZG0mi18jRjDHZJ5akThIAiGQf7xaO92NLpNGpAY6OjlzcXGGc6128msEjyFubtGamWIx2ql+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WHlMl1wM9znZMj;
	Mon,  8 Jul 2024 21:29:23 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DDA4F140415;
	Mon,  8 Jul 2024 21:29:47 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:46 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>,
	<gregkh@linuxfoundation.org>, <deller@gmx.de>, <javierm@redhat.com>,
	<robh@kernel.org>, <thunder.leizhen@huawei.com>, <austindh.kim@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/3] ARM: Use generic interface to simplify crashkernel reservation
Date: Mon, 8 Jul 2024 21:33:45 +0800
Message-ID: <20240708133348.3592667-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, x86, arm64, riscv and loongarch has been switched to generic
crashkernel reservation. Also use generic interface to simplify crashkernel
reservation for arm32, and fix two bugs by the way.

Jinjie Ruan (3):
  crash: Fix memory reserve dead loop bug in
    reserve_crashkernel_generic()
  ARM: Fix crash kenrel data type bug
  ARM: Use generic interface to simplify crashkernel reservation

 arch/arm/Kconfig                     |  3 ++
 arch/arm/include/asm/crash_reserve.h | 24 +++++++++++
 arch/arm/kernel/setup.c              | 63 +++++-----------------------
 kernel/crash_reserve.c               |  8 +++-
 4 files changed, 44 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/include/asm/crash_reserve.h

-- 
2.34.1


