Return-Path: <linux-kernel+bounces-171353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B68BE32E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF369B23C20
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237D515E81E;
	Tue,  7 May 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sXugHfw5"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B815E1EB
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087522; cv=none; b=MOpx52jaUuKrDQslFo41WP4YVsRxFiBZjCEgpf1chy8WsRcGQb7aZ0O8Az2tA/qLkvGwPVA50ESw0dAMjhxlx1STsLeftxXcEqyX13tC2f8pmgw0fyHR1OWCWBUv2J3RA/mA8QR8c38BGO2mMLB7ZP6EBAYbOwZkHxazOAE7NDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087522; c=relaxed/simple;
	bh=d+Lu3UqXP8fLNjjyb8nbXA+oe8Jrx30InvX4yaybJ04=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AP8CqV5gDHcjZrhUg3rwIY155QXHJwy3DzCLmmbED856AQuSh/3Bx31GKol0vqC6k5fNh/mN2yN5ZaDg+6ByOMOBoR5m8CxjMHB7F8PaLc/OzfyvxIrxY60GCmnQxfj1+LXL+nncZsazfKnKHs1XlvLlIpb7vIT4yj0RTxRJMUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sXugHfw5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447Bw9t6030034;
	Tue, 7 May 2024 15:11:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=Xx8BStG
	SuUuWEWc4uf/Q4C/XeVhtQS6pvbN0QryO6OM=; b=sXugHfw5fEGmrbHRH04y0hA
	6ri8Z8xeniYIEEM2I5V5/Zt9Q2sBL2WpurJ0JNnwilTNRVXqTmkfitir7hnyOwsu
	k2qlqjVwyOBVUD41quMMkgloYwPZYpytqCBRvJAxS6pC/nb8KDTWRTsy+rVohmY6
	ozqmx2yI+HGd5KEJmQ8n+Pr/AYSSJhsfALiaRa7h/erKat8qA3jf3wBjFBwkO5bz
	TWjPJfqvs99XcdiccjjKG0gDIeh5DdncCjYKY85PMBuE+bGoybjfKHMv0806AnRO
	PoVt2PsJ9GfB4jjf+twqPIm9oaO9GXf5sAOD7Eml26X8i3hP1yKTTwK3I4AC6gQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwa553xd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 15:11:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6C76A40047;
	Tue,  7 May 2024 15:11:29 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4809321B53D;
	Tue,  7 May 2024 15:10:55 +0200 (CEST)
Received: from localhost (10.48.87.171) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 7 May
 2024 15:10:55 +0200
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
Subject: [PATCH v2 0/8] irqchip/stm32-exti: split MCU and MPU code, allow module build
Date: Tue, 7 May 2024 15:10:43 +0200
Message-ID: <20240507131051.980313-1-antonio.borneo@foss.st.com>
X-Mailer: git-send-email 2.34.1
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02

The file 'irq-stm32-exti.c' contains two drivers:
- EXTI for ARMv7m STM32 MCUs;
- EXTI for ARMv7a & ARMv8a STM32MPxxx MPUs.

The current arrangement causes some issue:
- the growing code for MPUs uses precious space on memory constraint
  MCUs devices;
- the driver for MPU cannot be built as module;
- there are risks to break one of the two drivers while working on
  the other.

Since there are only 4 minor functions shared among the two drivers:
- stm32_exti_set_type();
- stm32_chip_resume();
- stm32_chip_suspend();
- stm32_exti_chip_init();

this series splits the file in two independent files, each containing
a single driver.
To guarantee bisect-ability, the series first introduces some hook in
Kconfig, then splits the file and at the end enables module build on
MPU while cleaning-up Kconfig.
The symbols in the MPU file are renamed to better match the new name
of the driver.

The patches are created with 'git format-patch -C' to correctly show
the deleted parts and the tiny modifications between the original
monolithic file and the two extracted ones.

The series is rebased on irq/core branch of tip as it depends on a
previous series already queued for v6.10 merge window.


v1 -> v2
- fix module dependency from IRQ_DOMAIN_HIERARCHY, detected by kernel
  test robot <lkp@intel.com>


Antonio Borneo (8):
  irqchip/stm32-exti: add CONFIG_STM32MP_EXTI
  ARM: stm32: use different EXTI driver on ARMv7m and ARMv7a
  arm64: Kconfig: select STM32MP_EXTI on STM32 platforms
  irqchip/stm32-exti: split MCU and MPU code
  irqchip/stm32mp-exti: rename internal symbols
  irqchip/stm32mp-exti: allow build as module
  ARM: stm32: allow build irq-stm32mp-exti driver as module
  arm64: Kconfig: allow build irq-stm32mp-exti driver as module

 arch/arm/mach-stm32/Kconfig        |   2 +-
 arch/arm64/Kconfig.platforms       |   1 -
 drivers/irqchip/Kconfig            |   9 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-stm32-exti.c   | 670 +-------------------------
 drivers/irqchip/irq-stm32mp-exti.c | 737 +++++++++++++++++++++++++++++
 6 files changed, 752 insertions(+), 668 deletions(-)
 create mode 100644 drivers/irqchip/irq-stm32mp-exti.c


base-commit: 382d2ffe86efb1e2fa803d2cf17e5bfc34e574f3
-- 
2.34.1


