Return-Path: <linux-kernel+bounces-286375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A765C951A39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C501C21583
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4511B1512;
	Wed, 14 Aug 2024 11:41:16 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101F1B14E9;
	Wed, 14 Aug 2024 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635676; cv=none; b=u9918owX7ruH7nZHfjoo2hHI/4nRgoPjVs7unjm+xX6lLCMvGe3/6uDCjnV3o4eCYCA02bNZ7M+0FbnRoKsBzXNax4+/pgcOE3bci9mFh02yss7NMz6Hwf6noBfAvKQZAXaXEy0tri0bGMsDn5QZPWn0R1oSsdDG5I1HzSN/X5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635676; c=relaxed/simple;
	bh=15W++Gq9Yz/K95lmP9DTHfuEXA628Wov8hJTzf8MUZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1XPIkdbdsRjVxhBy0MeMd1Xd+RP9f9Qg4kycDmhajJzSVX5JWKzjyGNCUNd9EFsAhjpO6Nc2svyhBWFgYT09U8DeVTD2MgngOyKLAOdQv8ZjHJ2pS121tFI8OLOw5EBNuXvWsis462+OX49WCWZQkST3bs0+KbLyUFDmWx5voU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 14 Aug
 2024 19:41:08 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 14 Aug 2024 19:41:08 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v2 0/2] Add support for AST2700 INTC
Date: Wed, 14 Aug 2024 19:41:04 +0800
Message-ID: <20240814114106.2809876-2-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support for the Aspeed Interrupt Controller found on Aspeed 7th Geration Silicon
SoCs.

ASPEED interrupt controller(INTC) maps the internal interrupt sources of
the AST27XX devices to an parent interrupt controller.

Changes since v2:
Combine the aspeed_intc_ic_of_init and aspeed_intc_ic_of_init_v2.
Switch raw_spin_lock_irqsave to scoped_guard and guard.
Fix the error of make dt_binding_check.
Refine the aspeed,ast2700-intc.yaml.


Kevin Chen (2):
  dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
  irqchip/aspeed-intc: Add support for AST27XX INTC

 .../aspeed,ast2700-intc.yaml                  |  71 +++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 137 ++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1


