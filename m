Return-Path: <linux-kernel+bounces-367114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839999FEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A17D1C22C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325415C14B;
	Wed, 16 Oct 2024 02:24:24 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD031531C8;
	Wed, 16 Oct 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045464; cv=none; b=j5sY3wNs/CVNGizzoD+BHuvrx17b501BAxK/k4DAd0m2JrgkaCYGF8SfRTTNsLUWRyw3ih5tiIm7jNqibwCGFUeqiMf7QzL5wKzXsIUpiLXBAb4+3MFNWIqi1kugmTk+N4f4fzjfHyLwAzc5jNby13UsS2Sf7Mq2KXZyDtC4A3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045464; c=relaxed/simple;
	bh=vGap4uagqME4SGcYPfjjS0YLv4y3zBvZmBdjDx1SIL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pAeLk1gFXnqrpbUYsL/REoezGG0FgAfYgK5TVUTgj8rj+JlhilXXNPhrfbJfEUyPQNIqH2gAfwUPNvtUnry7/f1Jsm71wDAB8a7VftFUyWV11vBecR3DCaeCxfED5/Jzx9A4OZX30KX9LtcitVJt5Dh8SW8C1eP+jk8NE2SdYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 16 Oct
 2024 10:24:13 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 16 Oct 2024 10:24:13 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v4 0/2] Add support for AST2700 INTC driver
Date: Wed, 16 Oct 2024 10:24:08 +0800
Message-ID: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

---
v4:
aspeed,ast2700-intc.yaml:
  - Add |' to preserve formatting.
  - Remove the interrupt nubmer accroding to maxItems of interrupts.

drivers/irqchip/irq-aspeed-intc.c
  - Reduce scope of variables, which are bit and status.
  - Replace 32 with INTC_IRQS_PER_WORD define.
  - Remove reduendant tab.

v3:
aspeed,ast2700-intc.yaml:
  - Change reg with maxIntems:10 only.
  - Change interrupt with maxIntems:10 only.
  - Add description of INT0 and INTC1.
  - Fix the indentation.

drivers/irqchip/irq-aspeed-intc.c:
  - Change to use CONFIG_ARCH_ASPEED.
  - Fix indentation.
  - Remove irq_domain name assignment.
  - Check all irq numbers first, and set chained.

Kevin Chen (2):
  dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
  irqchip/aspeed-intc: Add AST27XX INTC support

 .../aspeed,ast2700-intc.yaml                  |  86 +++++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 140 ++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1


