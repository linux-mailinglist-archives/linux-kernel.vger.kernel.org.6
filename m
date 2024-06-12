Return-Path: <linux-kernel+bounces-210847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED477904948
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C964B230EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000F171C4;
	Wed, 12 Jun 2024 03:02:46 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017811182
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 03:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161366; cv=none; b=HZ8/bBpx4mTdryk80F9t74E6XxuA+mVLYiMcxqTX1H64lVNkIO4xtQOkkjeatQWPBAL8jF+x3x4uF81WmTI2CnKlQeRaQFzX9JdIyJIn+3bd9BY2mFAzTg+4z6zULX8+2kEG7mhT1Ys3cUFPgXupqNtGcrxUZgoW1O4VNc5eW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161366; c=relaxed/simple;
	bh=z7SFNGqX2BtgFOLZtTPrHEcCw9sjTaEi9gADm24RfGk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=hsWm0D9BGMQuMTWMHraQMVSwwjdPmQMu/rwS/6C9MyQbMQKaJCU/OlAojreIjCkY6mfyS4YQteRplxbGNNP8AliqGuwztbxvDIpjXKIjY+No2lYm4YsmUQZk52gyOAS+/AmqB1Rd2yTMv5wMzm99gnh2BuJBwUIX7EDgd4Exqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzVbm3Snxz1SC4h;
	Wed, 12 Jun 2024 10:58:28 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B4A56140EEF;
	Wed, 12 Jun 2024 11:02:33 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 12 Jun 2024 11:02:33 +0800
Message-ID: <c740ef8f-1bb4-0c4a-4b88-77dab19f3e31@huawei.com>
Date: Wed, 12 Jun 2024 11:02:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
From: Li Zetao <lizetao1@huawei.com>
Subject: riscv: link error when supporting KCSAN
To: <linux-riscv@lists.infradead.org>
CC: <dvyukov@google.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpeml100015.china.huawei.com (7.185.36.168) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi all,

I'm developing support for KCSAN on riscv but getting the following link 
error:

riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L996':
core.c:(.text+0x2b62): undefined reference to `__atomic_exchange_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1015':
core.c:(.text+0x2c40): undefined reference to `__atomic_fetch_add_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1034':
core.c:(.text+0x2d1e): undefined reference to `__atomic_fetch_sub_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1053':
core.c:(.text+0x2dfc): undefined reference to `__atomic_fetch_and_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1071':
core.c:(.text+0x2eda): undefined reference to `__atomic_fetch_or_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1090':
core.c:(.text+0x2fb8): undefined reference to `__atomic_fetch_xor_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1109':
core.c:(.text+0x3096): undefined reference to `__atomic_fetch_nand_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1128':
core.c:(.text+0x3182): undefined reference to `__atomic_compare_exchange_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1147':
core.c:(.text+0x3274): undefined reference to `__atomic_compare_exchange_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1166':
core.c:(.text+0x3366): undefined reference to `__atomic_compare_exchange_1'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1220':
core.c:(.text+0x35ec): undefined reference to `__atomic_exchange_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1239':
core.c:(.text+0x36ce): undefined reference to `__atomic_fetch_add_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1258':
core.c:(.text+0x37b0): undefined reference to `__atomic_fetch_sub_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1277':
core.c:(.text+0x3892): undefined reference to `__atomic_fetch_and_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1296':
core.c:(.text+0x3974): undefined reference to `__atomic_fetch_or_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1315':
core.c:(.text+0x3a56): undefined reference to `__atomic_fetch_xor_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1334':
core.c:(.text+0x3b38): undefined reference to `__atomic_fetch_nand_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1353':
core.c:(.text+0x3c28): undefined reference to `__atomic_compare_exchange_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1372':
core.c:(.text+0x3d1e): undefined reference to `__atomic_compare_exchange_2'
riscv64-linux-gnu-ld: kernel/kcsan/core.o: in function `.L1391':
core.c:(.text+0x3e14): undefined reference to `__atomic_compare_exchange_2'
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[1]: *** [/home/l00517538/PrIntFuzz/third_party/linux/Makefile:1171: 
vmlinux] Error 2

The reason for the error is that riscv only supports 32-bit or 64-bit 
atomic operations.As far as I know, this error is solved through the 
no-outline-atomics option on arm64. How can I solve this problem on riscv?

Best regards,
Li Zetao

