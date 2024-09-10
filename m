Return-Path: <linux-kernel+bounces-323689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E3B9741D9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6BCB25B54
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB61A2872;
	Tue, 10 Sep 2024 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="En0VR6cK"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E3F170A2B
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992203; cv=none; b=HGxA4pqFZdsYqXoXBsiDjWisPjmqvRyK4Bi5scLIrN9GSf6CKwX7oK746OKL/SWO0tx4YwbbuMvD+AjwTQ2+CNbMWkPABn3EeoUBYwlHvmwS/Cr6XtrNPgCoa6QjOko7VLKKvUelZYSzqP+E63xFsykGj7ZjYwlWy4ZkK8O2KxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992203; c=relaxed/simple;
	bh=iPI9JMCgSWWidI+HW82ggnJaGnrlOTN4Ozvuwagp7u8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQJwXO1RA4pJ9CdpT8y+tD6oK8yD9zArT9Z5Oy6Y7fX0xTSpwRVStUvOXh5lsezv5YMTs/P/P6TTV+GhrvtZMu7C+RnoGOF+fJ+7rGS/xCIITs0qsF35Ow5pQJXBIROQQcTy1xIUfJlL0ILXt7ZUZ5rHB/H0fWlf2NJfUDgqF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=En0VR6cK; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 01198BFB09;
	Tue, 10 Sep 2024 20:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1725992199; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=lRrN4PAU2l7OJC8sxx1hbjfmdyyjIZeE6QJ3Tin7hsU=;
	b=En0VR6cKYZksf0bzopn3Ltb94zOS4gvpoEwQsGyQBrzn499j1x4jVquVdwkxqcnxXvIdFN
	syIch3T7psqbftlssn//KosSt0dkEZO0eQD45rN3yPb0MRThKePfYibAB21kh8c7KzGfi8
	M2Zk5qREdyjV5zUkW8wibCLTlTXQNF+/E5SKP7QYHcacaY+o/s/qbetMDE2Hjh5zn6Aa80
	3E6C4l/aTSUMljfvzHUYfQhHl6p2y+b6vuULgK57xlQUGr4uc8ABSv7nX1gftTMcZjNU95
	U9kJTHymbBeSO1hnFasHyLZwbDLJIFuHrJZ7Yt7CWm/hEPhw5e3xCYRuUbD+8w==
From: Frieder Schrempf <frieder@fris.de>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Frieder Schrempf <frieder@fris.de>,
	Adam Ford <aford173@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] phy: freescale: fsl-samsung-hdmi: Add PLL LUT entries for some non-CEA-861 modes
Date: Tue, 10 Sep 2024 20:14:53 +0200
Message-ID: <20240910181544.214797-3-frieder@fris.de>
In-Reply-To: <20240910181544.214797-1-frieder@fris.de>
References: <20240910181544.214797-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In order to support some pixel clock values not specified in CEA-861
and not achievable by the integer PLL algorithm, we add some new LUT
entries. This allows to use the fractional-N PLL to achieve pixel
clocks of 75 MHz, 88.75 MHz and 296.703 MHz with high accuracy.

Signed-off-by: Frieder Schrempf <frieder@fris.de>
---
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
index 401178bfcdda..6b36318630b2 100644
--- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
+++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
@@ -156,6 +156,9 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 74250000,
 		.pll_div_regs = { 0xd1, 0x5c, 0x52, 0x90, 0x0d, 0x84, 0x41 },
+	}, {
+		.pixclk = 75000000,
+		.pll_div_regs = { 0xD1, 0x3E, 0x30, 0x9F, 0x0E, 0x82, 0x41 },
 	}, {
 		.pixclk = 78500000,
 		.pll_div_regs = { 0xd1, 0x62, 0x54, 0x87, 0x01, 0x80, 0x40 },
@@ -165,6 +168,9 @@ static const struct phy_config phy_pll_cfg[] = {
 	}, {
 		.pixclk = 82500000,
 		.pll_div_regs = { 0xd1, 0x67, 0x54, 0x88, 0x01, 0x90, 0x49 },
+	}, {
+		.pixclk = 88750000,
+		.pll_div_regs = { 0xD1, 0x6E, 0x50, 0x8B, 0x06, 0x81, 0x40 },
 	}, {
 		.pixclk = 89000000,
 		.pll_div_regs = { 0xd1, 0x70, 0x54, 0x84, 0x83, 0x80, 0x40 },
@@ -277,6 +283,9 @@ static const struct phy_config phy_pll_cfg[] = {
 		.pixclk = 277500000,
 		.pll_div_regs = { 0xd1, 0x73, 0x15, 0x88, 0x05, 0x90, 0x4d },
 	},  {
+		.pixclk = 296703000,
+		.pll_div_regs = { 0xd1, 0x7b, 0x18, 0xe0, 0x3d, 0x8a, 0x41 },
+	}, {
 		.pixclk = 297000000,
 		.pll_div_regs = { 0xd1, 0x7b, 0x15, 0x84, 0x03, 0x90, 0x45 },
 	},
-- 
2.46.0


