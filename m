Return-Path: <linux-kernel+bounces-421799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F149D904E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23767B276B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1058F219E0;
	Tue, 26 Nov 2024 02:14:00 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AE17BA0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732587239; cv=none; b=i08mxGda8owgp8OdANRmST0gqJW/moOT49BRaqtN291hguSpFIDi7aQ++zO9Z67iDvF0X+uU/Nhd2U/cIzY+A4X0pW2K4d4NTTHYZTXHhDTOTnYh+bOZx6/KgjPxeQHiFbiHWzy35BgtF3jgzbq3Nvb/TEWGEhJtWhBOmEm+fRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732587239; c=relaxed/simple;
	bh=L+KGXDQap5jeTwXQAw9PJxRk14WnNHmKTwxq8wDilDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jsnuzmS9xQW0uwyvRnHVpRqGDVJ7n8Vau7nL00KC/OgsvxbM2Grh5npELF684WzrJI+I6oBRpPsLZ9RJlv0BY8gVy9w6QC0BQbYthe0LqSGAL2ReAE7dRoxQCB79tiGUm746WSaeDxGHFW/KJUiULo52Oie19NZ4xO3CWvjX/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Xy5dz0JPnz1V51Q;
	Tue, 26 Nov 2024 10:11:03 +0800 (CST)
Received: from kwepemh100007.china.huawei.com (unknown [7.202.181.92])
	by mail.maildlp.com (Postfix) with ESMTPS id A2423140137;
	Tue, 26 Nov 2024 10:13:48 +0800 (CST)
Received: from huawei.com (10.67.175.69) by kwepemh100007.china.huawei.com
 (7.202.181.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Nov
 2024 10:13:48 +0800
From: Zhang Kunbo <zhangkunbo@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <liaochang1@huawei.com>,
	<chris.zjh@huawei.com>
Subject: [PATCH v2] x86: fix missing declaration of io_apic_irqs
Date: Tue, 26 Nov 2024 02:05:11 +0000
Message-ID: <20241126020511.3464664-1-zhangkunbo@huawei.com>
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
 kwepemh100007.china.huawei.com (7.202.181.92)

arch/x86/kernel/i8259.c should include arch/x86/include/asm/io_apic.h
 for declaration of io_apic_irqs. This fixes the sparse warning:

arch/x86/kernel/i8259.c:57:15: warning: symbol 'io_apic_irqs' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
---
v2:
- fix some typos
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


