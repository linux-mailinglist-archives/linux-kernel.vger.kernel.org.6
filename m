Return-Path: <linux-kernel+bounces-237403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791C91F08B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E3E1C21898
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E1414600B;
	Tue,  2 Jul 2024 07:54:16 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51255C1A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906856; cv=none; b=MRRxetVpqrdl41gP406cIOsjK2QnJG87qFnhhDA7Ul4wAsZeuFH/E19T+D355AQHuPfCtaUUzEXvAQRQqHKysURzrO2bm+1avmMDsQzg+wUTbHLVu/Q/EWMZBo2mVAJ3LDWAJJRsytPEqx4pUslnB3N20yRa+0kdxvMkJhyBjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906856; c=relaxed/simple;
	bh=a29LGA8EQbMOlQV3ertGv7eGszMrHWzDVnhg1Sp+ang=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HU7LxKUkVHdG7mpktvEQGhCtgwUwxPLmsmo1c2NSQvlypJqPuXyAg26WpMdghDCqvIof9WfzF5N4N1dMwtmOKS/4LFjvA36l9m+x8vKaoVxuRnCWh5JihYIGWzj6b2at7yxGiIitofnpTY6xE4cYgWtfyCLhIEs9k31sP3Ll+2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WCw7L557wzQjx0;
	Tue,  2 Jul 2024 15:50:22 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 990F418007E;
	Tue,  2 Jul 2024 15:54:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 15:54:08 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <ardb@kernel.org>, <gregkh@linuxfoundation.org>,
	<deller@gmx.de>, <javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH RESEND 0/2] ARM: Switch over to GENERIC_CPU_DEVICES
Date: Tue, 2 Jul 2024 15:57:40 +0800
Message-ID: <20240702075742.945768-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Currently, almost all architectures have switched to GENERIC_CPU_DEVICES,
except for arm32. Also switch over to GENERIC_CPU_DEVICES, which can also
make the code more concise.

Jinjie Ruan (2):
  ARM: Switch over to GENERIC_CPU_DEVICES using arch_register_cpu()
  ARM: Convert to arch_cpu_is_hotpluggable()

 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/cpu.h |  1 -
 arch/arm/kernel/setup.c    | 14 ++------------
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
2.34.1


