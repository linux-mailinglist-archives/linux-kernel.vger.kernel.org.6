Return-Path: <linux-kernel+bounces-237344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6691EF83
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96A61F21EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB4512E1CD;
	Tue,  2 Jul 2024 06:55:36 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E16EB7C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903336; cv=none; b=I9lEdFOoFMt7zgbcPKEcDJY7HytQFHi4Q4zZc/DWZaZZQr7rdNcquM1uKXPq2PT9yatCKqNBDsEjnE6NZNHpfj/yLow6QB4UxRs6AhNxMsFFUqCC9C0WLohuIIcumu1cJRFQwUgLqq92teu5sWa3NMH25u7SBHS/6DlIxTKeTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903336; c=relaxed/simple;
	bh=4uG+ux9EgZA8XzVPZigkfsy0eVgdX8NowUwLkucQ8lc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pX8GAq2+ynLwFbxCM1IB0FFNFdc5K+aPV/aE60Mmlw5HX9/o2jQunM+XjJNr2XwmYF8vrf3pRvWKipr+dBkSSraKKwnEeOOudHW9L0knP4OYMmb+zwjn2Q/O9rps4U/ld5k15pgWSzZ24wwJ9wmxygf+kMVW+eICLLTKrhnu6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WCtqg338zzQjwd;
	Tue,  2 Jul 2024 14:51:43 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 457AF140416;
	Tue,  2 Jul 2024 14:55:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 14:55:29 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <ardb@kernel.org>, <gregkh@linuxfoundation.org>,
	<deller@gmx.de>, <javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 0/2] ARM: 9322/1: Switch over to GENERIC_CPU_DEVICES
Date: Tue, 2 Jul 2024 14:59:04 +0800
Message-ID: <20240702065906.929987-1-ruanjinjie@huawei.com>
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

Currently, almost all architectures have switched to GENERIC_CPU_DEVICES,
except for arm32. Also switch over to GENERIC_CPU_DEVICES, which can also
make the code more concise.

Jinjie Ruan (2):
  ARM: 9322/1: Switch over to GENERIC_CPU_DEVICES using
    arch_register_cpu()
  ARM: 9322/1: Convert to arch_cpu_is_hotpluggable()

 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/cpu.h |  1 -
 arch/arm/kernel/setup.c    | 14 ++------------
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.34.1


