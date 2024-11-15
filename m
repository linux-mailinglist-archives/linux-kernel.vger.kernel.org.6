Return-Path: <linux-kernel+bounces-410694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D09949CDFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EEC1F23AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286711BFDEC;
	Fri, 15 Nov 2024 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JgousXi0"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E241B6CE0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677198; cv=none; b=l056g19mcePe5Z9g/broKOkZSoKcBKBoPQtVkr1JkSXwiqxiikyckK2kvfb/sI9qht8q1OLq9/a0Vk0RsRJ/Oxqvb62aaeZfDHnt82lzvCsmgqjjHl67q2dzp7riUbiCYNzG+ymdGzdRX0CdNX669ghFd2xRNbSfy9ZtGMltE4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677198; c=relaxed/simple;
	bh=dZakMgOx/PLPdbmknARgYFqlNyLxAGHuRn3M70ko5+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RIlYv6f0UXCsEv8dKhRy8QAcj0riCeKAizQoJXFE7g/QKGJGNeSq5WFN5dAwsLnIqsHuiaAPkAfEq3LxloT2IfYm+k/mKCPdFXkN5gxzkvL027KD9EuiyQvz7Y6+BkI+i+ZSBndVqIievkXdT4Cn/Bmt3lxnNVYxpjFllt2qby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JgousXi0; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 20F1120005;
	Fri, 15 Nov 2024 13:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731677194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Vya+/aulsxN6jrI3L2J+A9p7VNvahxNnPqnUJh8M+QA=;
	b=JgousXi0G4U3C5TFxZ+KYuxpxNpzFcSiZnC7fLoVmxhH0yTC/1my3Tf3GNvO9IlRU0sf5L
	Tq/6FMFlAteqYnbKg2xsdkEt1ntByjsPJicOHYqvUPLqaJyGDsHcsHpmtd+max8rzmpib0
	hLRFUjYP25bhJFk14hlehY9k9kWaciJiTJpIpEpn+RQhSgfHhP5oh/pX0qxHiving3FXvO
	6L0Tx/2fEGcHwF1O05UjgcuVwBVy4hq4w5zQsYvYitxNRUN+vy4mFnPcDD/w6H1zqNq7V7
	CRNxfN8+/PAE0vGmUuTZQs1aXfdcXBpFesX0PeRCJkQFDNA6IQaerBm5j/DmhQ==
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
Subject: [PATCH v4 00/10] Implement setup_interface() in the DaVinci NAND controller
Date: Fri, 15 Nov 2024 14:26:21 +0100
Message-ID: <20241115132631.264609-1-bastien.curutchet@bootlin.com>
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

PATCH 6 depends on PATCH 1-2-3-4-5
PATCH 10 depends on PATCH 6-8-9

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
 * v4
   PATCH 1,2,3 [new]:
     - Create the struct aemif_cs_timings inside the already existing
       struct aemif_cs_data
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
[v3] : https://lore.kernel.org/all/20241113094938.44817-1-bastien.curutchet@bootlin.com/

Bastien Curutchet (10):
  memory: ti-aemif: Store timings parameter in number of cycles - 1
  memory: ti-aemif: Remove unnecessary local variables
  memory: ti-aemif: Wrap CS timings into a struct
  memory: ti-aemif: Create aemif_check_cs_timings()
  memory: ti-aemif: Create aemif_set_cs_timings()
  memory: ti-aemif: Export aemif_*_cs_timings()
  mtd: rawnand: davinci: Always depends on TI_AEMIF
  mtd: rawnand: davinci: Order headers alphabetically
  mtd: rawnand: davinci: Add clock resource
  mtd: rawnand: davinci: Implement setup_interface() operation

 drivers/memory/ti-aemif.c           | 187 +++++++++++++++++-----------
 drivers/mtd/nand/raw/Kconfig        |   4 +-
 drivers/mtd/nand/raw/davinci_nand.c |  94 +++++++++++++-
 include/linux/memory/ti-aemif.h     |  32 +++++
 4 files changed, 237 insertions(+), 80 deletions(-)
 create mode 100644 include/linux/memory/ti-aemif.h

-- 
2.47.0


