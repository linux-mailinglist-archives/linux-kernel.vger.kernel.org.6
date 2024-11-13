Return-Path: <linux-kernel+bounces-407323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF399C6BF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B418B23E41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64141F8F11;
	Wed, 13 Nov 2024 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PQbX4+O6"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F611F81A8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491386; cv=none; b=l0qXpETADUcj67Re3INJT3gPQ/+hDBnZ8sOBs/8/yMcUI0ooFIVoQBkJHlZ2rwQn1tlctRW6SRa3NQJ+4gyUBAtlacwWTCbWdry1U/WCxxRYbZxHthpBVDCXvedUFO4EkKX/0Vp8gonER31kWkOOgbFNMcyUSBf3QKE5SmgM/Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491386; c=relaxed/simple;
	bh=zEoDTWZCv/dnw4Zj5iWN5DuVV8v87YTJU9Ba8xcVw1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LFbpEKmnooRm8Ywj9YuJ+Q3JSvIIsMRXwvBsKJLzetjXC+RdhscQiO2727OPCnNz8CWZPA7IoCQooV34TNRJlrBPqB/5SM+7man9zDn3nQyLSK1Rskd7EJ5l9Ir3Jlb4YNxyqGBcKcugV+F9cPhdmFZB/mO05Sp0LPb9TWlh7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PQbX4+O6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 0667DC0004;
	Wed, 13 Nov 2024 09:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731491382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TF98DUnwKLixz1e8gODb+/hKwGspDaRBxYKzd0vc82c=;
	b=PQbX4+O6HGpxHs+9bzABSaOg4JGYfWtS2bmYTELjsHgVy20NbpEAkFmfYnBihDpHHcidPg
	hIp5r9Wxrlx0+HqgfWWP7E9IF/Uq8tDRxslkIOscJGuLdedYuZ33xmiZUu0Lqw19UC02gF
	n9NPDEJV8e5rx5iXwKsFyvV/6OzawmEWaKSiku8AlCnkg1YskcBd47l62ykctlAjSHEfTE
	sSRcY4sTqpAcrxT6sQQmR1prKKFRoZpKuyv15t5evZdPqFvV2L4PmNqao2YKnOVn1t22JX
	qa2QKUOv+7dwxrRBFOPtLOKGf2ooMqe151cGhmyRsOsjMdmRHZDUR30sgSSD9A==
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
Subject: [PATCH v3 0/7] Implement setup_interface() in the DaVinci NAND controller
Date: Wed, 13 Nov 2024 10:49:31 +0100
Message-ID: <20241113094938.44817-1-bastien.curutchet@bootlin.com>
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

PATCH 3 depends on PATCH 1-2
PATCH 7 depends on PATCH 3-5-6

This NAND controller is present in the DaVinci (OMAP L138) and Keystone2
SoCs and functions as a 'child' of the AEMIF controller. So its timings
are set by the AEMIF controller itself from device-tree properties.
Implementing the setup_interface() callback implies being able to update
dynamically these timings, so the first three patches of the series modify
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
 * v3
   PATCH 1 [new]:
     - Wrap the verification of CS timing configuration into a function
   PATCH 2:
     - Fix comments
   PATCH 3:
     - Replace the spin-lock with a mutex
   PATCH 7:
     - Add handling of the NAND_DATA_IFACE_CHECK_ONLY case
     - setup_interface() returns errno on failures

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

[v1] : https://lore.kernel.org/all/20241030104717.88688-1-bastien.curutchet@bootlin.com/
[v2] : https://lore.kernel.org/all/20241106085507.76425-1-bastien.curutchet@bootlin.com/

Bastien Curutchet (7):
  memory: ti-aemif: Create aemif_check_cs_timings()
  memory: ti-aemif: Create aemif_set_cs_timings()
  memory: ti-aemif: Export aemif_*_cs_timings()
  mtd: rawnand: davinci: Always depends on TI_AEMIF
  mtd: rawnand: davinci: Order headers alphabetically
  mtd: rawnand: davinci: Add clock resource
  mtd: rawnand: davinci: Implement setup_interface() operation

 drivers/memory/ti-aemif.c           | 137 +++++++++++++++++++++-------
 drivers/mtd/nand/raw/Kconfig        |   4 +-
 drivers/mtd/nand/raw/davinci_nand.c |  94 ++++++++++++++++++-
 include/linux/memory/ti-aemif.h     |  32 +++++++
 4 files changed, 229 insertions(+), 38 deletions(-)
 create mode 100644 include/linux/memory/ti-aemif.h

-- 
2.47.0


