Return-Path: <linux-kernel+bounces-222253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD190FEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF930B249E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1319AD71;
	Thu, 20 Jun 2024 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="U+doxcwx"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470A17D8A6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872358; cv=none; b=o7tXQgiZz4t2YOEx0aZpKeUzEYvIRgkaedBZFcnAYAHY3ODbfyr1F87zHkAcSXXZytr7mUUqmJcFrXeSzwF2/aDz/FHKtJsVm70XeKdlC0P6WzEg5xx666LDtyVwDsWoyUifzEy9wuxH5j/SwC64Bw1Nag7U2Og1S6cbbGe3l5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872358; c=relaxed/simple;
	bh=7plsvwWt892ug+lOAVg1CmP/z4v5I8cCGR8iMFVxc1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sU6x7McPeO7YTAQTZ4dMda719sZ269qFE0tpxqePdqz7yd7zZBrART5eOozUxEkAqPZMugOUOc3xQIgsDSRCae9kd2gUQPhr1bN+0JVhYWN21puU1BToASq2etTVODfK7C/QHtYQTmtA48Av9Jqhaph5FXO3OJ7PXj5gtQQTTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=U+doxcwx; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K6MbVS014878;
	Thu, 20 Jun 2024 10:32:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	XIk/vz4CZvRDP46S7QF0CjZaFR83xkL+/AG9b+2atfg=; b=U+doxcwxLT73catl
	m/jIv8tDHGdLQV4oAeZ7H2UKXazCvGKZdbFo1U8ytT0UQEAdShh/gTL3AyLDzfE+
	YJpIy93kgo0ep8eJEqYG0bgt9FwTgFCSFMJA0RSWXPgbqcN/esU2Uenep9X8nEec
	EA56e2chP7MFdzUkTQFJ6AXBUvDLaHc+ACFW72EsD5oEyLZqHkoCh+B+zAhSs4mH
	yejaZZPmv5V94J0asFPmi4tFZIupc8WfJVnjEeJVF+H/6LVigDEdrzgh1jFI4y53
	1vjgC8WqHpxrwNvHxQxmW4rDO0WaGB9aLUilY0m3yO8WDDbW4zrmnMH/UtTKlJ0z
	Ar8icQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9uf7v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 10:32:01 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 79A1040045;
	Thu, 20 Jun 2024 10:31:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AAFDA212FB7;
	Thu, 20 Jun 2024 10:31:20 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 20 Jun
 2024 10:31:20 +0200
From: Antonio Borneo <antonio.borneo@foss.st.com>
To: Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: Antonio Borneo <antonio.borneo@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/8] irqchip/stm32-exti: add CONFIG_STM32MP_EXTI
Date: Thu, 20 Jun 2024 10:31:08 +0200
Message-ID: <20240620083115.204362-2-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620083115.204362-1-antonio.borneo@foss.st.com>
References: <20240620083115.204362-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_06,2024-06-19_01,2024-05-17_01

To guarantee bisect-ability during split of stm32-exti in MCU and
MPU code, introduce CONFIG_STM32MP_EXTI. It will be used in arch
configuration.

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
---
 drivers/irqchip/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacbb..798bd50f8ab23 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -392,6 +392,10 @@ config LS_SCFG_MSI
 config PARTITION_PERCPU
 	bool
 
+config STM32MP_EXTI
+	bool
+	select STM32_EXTI
+
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
-- 
2.34.1


