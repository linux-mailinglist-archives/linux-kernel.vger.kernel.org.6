Return-Path: <linux-kernel+bounces-397846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B289BE15E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63E328417E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83661D5CD3;
	Wed,  6 Nov 2024 08:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KDRfvLS9"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494281D4333
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 08:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883316; cv=none; b=OiZ72GNFpepFtfWzoN3xTcaA3dVCdTmZbdvAnbcAMzJ8nvl0gGMrpkq0dZr2NT5Fe+iRzRJMlAAxoADBz8NdzJF8gfDVTajSulFpb3VfpTzPQwwsQ9KmlkXprzjD1FPiMBvqA/XYcSits0XFwL4j1BD+6HDbYG2HBV3i+TWtGk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883316; c=relaxed/simple;
	bh=O3HM6CaWeh7k3VC0Q5KJYPGcxjmHye1kMZ8bKcZeHBU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGmyTn2cepumuce36rqUzutA2Wn3Jxg+lN16qdWgXCMATIk+0oeFLRvAh80bSHD9TbpPJpohgjoJ39IzpAGDBfjX5ZlbpB1UOyyZJ9zua1gJbtbcAEOwrFv1Z2wrWG+ACoqMhJidDIXZKh6aobXTxg3YnlIU2GNx6jx3nUUemg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KDRfvLS9; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 101EF1C000A;
	Wed,  6 Nov 2024 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730883311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DK3aO1Ft6P60EgK01AvhNU8ciFPwjwRQCU5JDKN6QFM=;
	b=KDRfvLS9HeE6reR09UlcPAaftktG9Pcxj3vpz+diP6NOyaJ/2eajMgQIvyaweGHKzNQFuA
	vJ7BkmT+7ZBD/SFkyPsabM8OGsu/CZnYXiszvHBAx9dqDRGmW/TM4dGoZJEt3jSk13Hi5K
	I7Y4/PE2duw5D3zHP8lKQN4sSBYLT8VSczV81VbnTN6fWInMXnMq9px8o/ACUpORLh097X
	nguMtvSLrXLWRcJML6LFOWDqdwMM5Wxy07SUjURfQJPf2HM/p81Sk3k9Qj6nQ2Lgxueci3
	QX0KgYPj2gp9LdLpk7Agz+rY7yUGkumxAn3vtQmLGWah5xmfauZB00TUtR2rYQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Santosh Shilimkar <ssantosh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH v2 0/6] Implement setup_interface() in the DaVinci NAND controller
Date: Wed,  6 Nov 2024 09:55:01 +0100
Message-ID: <20241106085507.76425-1-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi all,

This patch series aims to implement the setup_interface() operation in
the DaVinci NAND controller to enable the use of all ONFI modes and
improve the NAND access speed.

PATCH 2 depends on PATCH 1
PATCH 6 depends on PATCH 2-4-5

This NAND controller is present in the DaVinci (OMAP L138) and Keystone2
SoCs and functions as a 'child' of the AEMIF controller. So its timings
are set by the AEMIF controller itself from device-tree properties.
Implementing the setup_interface() callback implies being able to update
dynamically these timings, so the first two patches of the series modify
the AEMIF driver to provide its 'children' a way to modify their chip
select timing configuration.

The remaining patches implement the setup_interface() operation.
The computation of the register's contents is directly based on
§20.3.2.3 of the OMAP-L138 TRM [1]

This has been tested on two platforms based upon the DaVinci SoC. One is
interfaced with a Macronix MX30UF4G18AC NAND, the other with a Toshiba
NAND.

[1] : https://www.ti.com/lit/ug/spruh77c/spruh77c.pdf

Change log:

 * v2
   Cover letter :
     - Add dependency details
     - Remove the question about ti-aemif.h location
   PATCH 1 :
     - Fix aemif_cs_timings's description in the comments
   PATCH 2 :
     - Fix typo in the config_cs_lock's description in the comments
     - Move include/memory/ti-aemif.h to include/linux/memory/ti-aemif.h
   PATCH 3 [NEW] :
     - Fix dependency issue with aemif controller in Kconfig
   PATCH 5 :
     - Add details about the clock bindings in the commit log
     - Replace devm_clk_get() with devm_clk_get_enabled()
     - Use dev_err_probe() to return the devm_clk_get_enabled() error

Bastien Curutchet (6):
  memory: ti-aemif: Create aemif_set_cs_timings()
  memory: ti-aemif: Export aemif_set_cs_timings()
  mtd: rawnand: davinci: Always depends on TI_AEMIF
  mtd: rawnand: davinci: Order headers alphabetically
  mtd: rawnand: davinci: Add clock resource
  mtd: rawnand: davinci: Implement setup_interface() operation

 drivers/memory/ti-aemif.c           | 102 +++++++++++++++++++---------
 drivers/mtd/nand/raw/Kconfig        |   4 +-
 drivers/mtd/nand/raw/davinci_nand.c |  93 +++++++++++++++++++++++--
 include/linux/memory/ti-aemif.h     |  31 +++++++++
 4 files changed, 191 insertions(+), 39 deletions(-)
 create mode 100644 include/linux/memory/ti-aemif.h

-- 
2.47.0


