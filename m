Return-Path: <linux-kernel+bounces-421010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F859D8593
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFFE169051
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F6D1A0700;
	Mon, 25 Nov 2024 12:44:24 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E65199EB7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732538664; cv=none; b=XLSuffqPVZ4iiwxPWuvi9ttZqGKpRnTLLgGqTZFunWoe7vTu26Q6lRwm+qaKgYrK1MihIwhACXw5/Nw1/hCLpbSe1k8braZLBrqbGaiHKooTtBr4/P3rROQ1L8KBkXB+s/hbUbbqyczUxRajntfbIYGRIGEjcBzA4ud19JeB5GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732538664; c=relaxed/simple;
	bh=F4tpTnN2XkEPixr1eQYeFS9dAxW2okz5Bia8n0s/bv0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IkdPH1+I0iqosm0xnAErQx92wANURHFo+S7HAiUG5kHnQtTJa1mzUE1bvQg/RrHt1eAm7YU0WhT+yVlKsD6XeCeKAXXlOApIaFJwt36ia0e1RX63cvI3NB6apDmSsmx8zhU66HpqWTz9YHTdwAHFHqc5FLvLzea8XMHOe2+3G/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xxlhj4z0Bz2Gbp8;
	Mon, 25 Nov 2024 20:42:13 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DC761A0188;
	Mon, 25 Nov 2024 20:44:19 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Nov
 2024 20:44:18 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH] x86: fix missing declartion of io_apic_irqs
Date: Mon, 25 Nov 2024 12:35:47 +0000
Message-ID: <20241125123547.3307117-1-zhangkunbo@huawei.com>
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
 kwepemh100007.china.huawei.com (7.202.181.92)

arch/x86/kernel/i8259.c should include arch/x86/include/asm/io_apic.h
 for declaration of io_apic_irqs. This fix the sparse warning:

arch/x86/kernel/i8259.c:57:15: warning: symbol 'io_apic_irqs' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
 arch/x86/kernel/i8259.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index c20d1832c481..2bade73f49e3 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -23,6 +23,7 @@
 #include <asm/desc.h>
 #include <asm/apic.h>
 #include <asm/i8259.h>
+#include <asm/io_apic.h>
 
 /*
  * This is the 'legacy' 8259A Programmable Interrupt Controller,
-- 
2.34.1


