Return-Path: <linux-kernel+bounces-356958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090ED99695F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE1B2845C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7095192B78;
	Wed,  9 Oct 2024 11:58:28 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8ED188718;
	Wed,  9 Oct 2024 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475108; cv=none; b=Mzfi/ckO9fUYpUg3UMb0x0mpMFPDhhyQeW6hKFPdEbaYXKWGOzXd7TZMsFm/bqVTAwOlscQzORPj0kZlYn6anOu4oq9qgKBtmjlL4E95jXZrIxulYNFlRRAS72J1DfTAR0eC+0jvO/wrd11LozGrmxVnMoHDna8hvb+GvZADsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475108; c=relaxed/simple;
	bh=6PgHj9NAvRMbeob0LrxWxe6G17OG6Dvy4i/riRrAFVM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LBCajA3ar+qpx0aJrQ0JAgeIkxn4ImIIS/qOGBy8eUVD6TNo/KlYEMG6HwaedzE5GIz18g3a3oil0PfmKkA4BlpplsxMWNXdojCEDE4DNCfiUzNLIwbCDkZH2xEaRQpgacInmF2Jq4zs8tnEYecaS1g902VB9fb4jK/Xp7ol/n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 9 Oct
 2024 19:58:18 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 9 Oct 2024 19:58:18 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<kevin_chen@aspeedtech.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v3 0/2] Add support for AST2700 INTC driver
Date: Wed, 9 Oct 2024 19:58:11 +0800
Message-ID: <20241009115813.2908803-1-kevin_chen@aspeedtech.com>
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
  irqchip/aspeed-intc: Add support for AST27XX INTC

 .../aspeed,ast2700-intc.yaml                  |  87 +++++++++++
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             | 139 ++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
 create mode 100644 drivers/irqchip/irq-aspeed-intc.c

-- 
2.34.1


