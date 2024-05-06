Return-Path: <linux-kernel+bounces-169886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862268BCF01
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7652AB24FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C8C78C6B;
	Mon,  6 May 2024 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m2wuIT+6"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CD34642B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002468; cv=none; b=kKWyWJGxUxs+kBr3ngM6ygOLERG0g28F/5olK3Qva3DKVI/FaqqIl2k+/PQE3Cgl7Mt7ebpCcgyOPiB4EmMMy6ZLXTtnOjj7HsKa8Bns6fo+OVTyXnD55ewsOlBIjSKEbazG7AHpsEgQAC6yz1O5OmlazgFR+EKiSx5XIGPh62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002468; c=relaxed/simple;
	bh=7plsvwWt892ug+lOAVg1CmP/z4v5I8cCGR8iMFVxc1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGbOwPclkC4sFG7TUNkJ2wkwSXZt3R/SEmXyFM6iVfY4YKJeWBSrRZth6giasGSVczZb131fiykxE/WAlZa5MC4r447ZJFODJNMwEtiDwL6dbTAJ16UxTIPJIo+TfEocvoN/sQ+GuVbpaXN0z3xkgLqLPsfU/GyHK6XzdU83fIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m2wuIT+6; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446DP5XV032357;
	Mon, 6 May 2024 15:33:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=XIk/vz4CZvRDP46S7QF0CjZaFR83xkL+/AG9b+2atfg=; b=m2
	wuIT+6qcBtMsPsZemGk8e5n+WKLSsOTLRY2sWuyfjzjMR/STD2l46AOpTDqrJfpf
	d9hUBvYGyMcfiM4SB536Wvw6KW5MIseaCNABMjsuh+Ymhbx0Y2GTNB2QzxJw1UUM
	djcCaTaLl3MOFoNcZlQzJoQeDEsrvAyWOXZ0OBFvHbm6xfVd7GdVN18CzGhJSQpu
	PZ+2EIy+K2+4pkX3JQOaPrrGEJB9kYXjdmA5R1sWVABmqfC6PP5k7nXQNoyLAC/K
	lXHxfRnMGp/R/gvg3ChXteHGxkYbbYn18YhSVt83PRYji/TxKfN+b+PCc711nx9O
	02KKRqkMDk6t1vM/lkpQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwcbx781r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 15:33:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9CC4E40051;
	Mon,  6 May 2024 15:33:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8E1F621B537;
	Mon,  6 May 2024 15:33:07 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 15:33:07 +0200
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
Subject: [PATCH 1/8] irqchip/stm32-exti: add CONFIG_STM32MP_EXTI
Date: Mon, 6 May 2024 15:32:49 +0200
Message-ID: <20240506133256.948712-2-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506133256.948712-1-antonio.borneo@foss.st.com>
References: <20240506133256.948712-1-antonio.borneo@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02

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


