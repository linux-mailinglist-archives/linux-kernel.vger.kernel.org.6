Return-Path: <linux-kernel+bounces-279056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13F94B86A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BA5283069
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37861891B2;
	Thu,  8 Aug 2024 07:59:53 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067712C475;
	Thu,  8 Aug 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723103993; cv=none; b=NccnbPrTceSKFQodLGnmpXcoRUpskRgi1TO50WrygA3m++tzEOyLCMilcgYUaL9qAjk6CSi4JqllBEolQ2BMV9pEbO+HQ8+f7cSMbae2uqBzIw920i+fk9HNUi88ds1bqY8YX6MmfI7R5sl9xuTngzOglUs8vaJF6wAxC3wmEbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723103993; c=relaxed/simple;
	bh=0c7oFVjrGMLk7zC3cd+inAQX07SFAa3D5XGIj8d0OW4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hYms5kj2pKCvib6RudWtUXCTpAt1F48Ou3GQlONdGQtRO+MXJ4sJqgs4SZzAGkeF+pTDtDn1GHLtEAhBYBaxOT7pB1M5bSmzFW7DyTnEKDXlIujI6fI5CnmKyQ7rdGuGb0aJn+cFcW4QixBXpaAQezC1Wo8oHWRjTmk/Z8pJAFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Aug
 2024 15:59:37 +0800
Received: from twmbx02.aspeed.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 8 Aug 2024 15:59:37 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, Lee Jones <lee@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
Subject: [PATCH 0/4] Add support for AST2700 clk driver
Date: Thu, 8 Aug 2024 15:59:33 +0800
Message-ID: <20240808075937.2756733-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series is add clk driver for AST2700.

AST2700 is the 8th generation of Integrated Remote Management Processor
introduced by ASPEED Technology Inc. Which is Board Management controller
(BMC) SoC family.

Ryan Chen (4):
  dt-bindings: mfd: aspeed: support for AST2700
  dt-bindings: reset Add AST2700 reset bindings
  dt-bindings: clock: Add AST2700 clock bindings
  dt-bindings: clock: Add AST2700 clock bindings

 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   31 +-
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1091 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  175 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  132 ++
 5 files changed, 1428 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1


