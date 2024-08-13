Return-Path: <linux-kernel+bounces-284259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21B394FF08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7501F238D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7494112FB1B;
	Tue, 13 Aug 2024 07:43:45 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0E77102;
	Tue, 13 Aug 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535025; cv=none; b=euSZYpmN4MPt9x5zpFpSBBMRGdbI76qvudP8uEILnX1xbAr9T+hHc/zmNRp9RbQ7eC180hhBI3IikIgYR0fBhj05Gx07z39zK6QmbWICSn0TxJfyrDgNxIX4G8aPAao7RmXPIYJwZlxtgZcAtUjrgPk4uCGTLghI6L+nYNNQADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535025; c=relaxed/simple;
	bh=FgHp+Rh61XDrWmv/1aR5vDKnKDEV1O2lHrTZCJ72UHk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+W48lGlh6z0DCvdOGGKlxxJqU8H+373ldSVUhCwVAs1q34jCNa2n4LqpDEu3ZEMrY9CtZ6go7ZRT94n9k9NJIWlmc1WoGGZ+hErtbS/Oik+eupOu/NZAndRqZ0AE7DP/O4aVV0k/lGL78q7KD5+foz8IcK4ksjY5LlOWLcpk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 13 Aug
 2024 15:43:40 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 13 Aug 2024 15:43:40 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v1 0/2] Add support for AST2700 INTC driver
Date: Tue, 13 Aug 2024 15:43:36 +0800
Message-ID: <20240813074338.969883-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce to the AST27XX INTC modules, which contain two conponents in
CPU die(12nm) and IO die(40mm) comunicating by SLI or LTPI protocol.

There are lots of device in IO die, which need to be serviced in
requested interrupt handler. As two die ICs, combine 32 interrupt source
in IO die into 1 interrupt in CPU die.

soc0_intc11 represent CPU die INTC, which each bit mapping to soc1_intcX.
soc1_intcX represent IO die INTC, which combines 32 interrupt sources.

Kevin Chen (2):
  dt-bindings: interrupt-controller: Add support for ASPEED AST27XX INTC
  irqchip/aspeed-intc: Add support for 10 INTC interrupts on AST27XX
    platforms

 .../aspeed,ast2700-intc.yaml                  | 120 +++++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 198 ++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1


