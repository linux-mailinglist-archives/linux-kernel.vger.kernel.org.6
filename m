Return-Path: <linux-kernel+bounces-304415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A512E961FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4671F25A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269D156677;
	Wed, 28 Aug 2024 06:27:50 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D414B956;
	Wed, 28 Aug 2024 06:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826470; cv=none; b=aILqS9Tmp6NEThWlS9v8xihp7byJeGLfWdmyUCOkZJzM11KCdirNGQKdOa9N6ttq4Dapwxk/lO85VNHpg14irppuIPScX2OjI0trW8Y1nszhMvj7/zu0zBzxLbpuIPsL55hFg/tcu7nGfmaEhsCHei0skZueKUueytQcI4vewXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826470; c=relaxed/simple;
	bh=/75gyVrSQxnSZyVzUBvNGhjrloQB+9R5CgjaLt+rewY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GdHIj18f1WOnRJ8HpWvGv/Bla/FkrgIYyFhPOxAoJ9gRBzR4g3OF8TNqJImkCwGduf6N1AcX3+o4GLM1M676io8qmW6cFmKpViGc+Gv0Tg4Qhq1sF8dDEIt4kWAvauUzwjL/LdHWXXv5opqkOzb6yZQA7UMv5snC7j2olK7FAeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 28 Aug
 2024 14:27:40 +0800
Received: from twmbx02.aspeed.com (192.168.10.152) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 28 Aug 2024 14:27:40 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: <ryan_chen@aspeedtech.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <p.zabel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v2 0/3] Add support for AST2700 clk driver
Date: Wed, 28 Aug 2024 14:27:37 +0800
Message-ID: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
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
(BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.

v2:
-yaml: drop 64bits address example.
-yaml: add discription about soc0 and soc1
-dt-bindings: remove (), *_NUMS, reserved.
-dt-bindings: remove dulipated define number
-clk-ast2700: drop WARN_ON, weird comment.

Ryan Chen (3):
  dt-bindings: reset Add AST2700 reset bindings
  dt-bindings: clock: Add AST2700 clock bindings
  clk: aspeed: add AST2700 clk driver

 drivers/clk/Kconfig                           |   10 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-ast2700.c                     | 1198 +++++++++++++++++
 .../dt-bindings/clock/aspeed,ast2700-clk.h    |  165 +++
 .../dt-bindings/reset/aspeed,ast2700-reset.h  |  125 ++
 5 files changed, 1499 insertions(+)
 create mode 100644 drivers/clk/clk-ast2700.c
 create mode 100644 include/dt-bindings/clock/aspeed,ast2700-clk.h
 create mode 100644 include/dt-bindings/reset/aspeed,ast2700-reset.h

-- 
2.34.1


