Return-Path: <linux-kernel+bounces-430884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50D9E36DA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EA1161CA6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E31AB6D8;
	Wed,  4 Dec 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R2MvzP+4"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC056187FFA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305407; cv=none; b=kAsHHF5bgT37+ed5uq4zrTYLGXpamkVaWShQXAJKsgjJuLutA9ohCHj/TVfdASGm2nUukdBXmjfAEyOE+E+YQZzqdZu6+FBv245NZPkWm/YZxf5Qt79mtzPMCd06jMf51mqnusPX6EA3v2YRy9Bzxg05mOBWUQFM5PlJmPhutgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305407; c=relaxed/simple;
	bh=sAfpp9nueSZv5paKBpqAu9edIk73x4GTc2621dNaUhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YwgyHX7bWJFS6DjgZRmsJa9V/3J1yDNmDAZtVd6ZPw0NE6FS2BvSy+6+49tYzGt8qSuKFVWUkktE8b1DmRgO7HDn2yure9tJY53HHLWZFEdAJBxqf0smbna81sy/iW83agXvTRzWRj5TDuLQjIspCqvIuxkvD5xFHv3qccHmK9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R2MvzP+4; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C38760004;
	Wed,  4 Dec 2024 09:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733305402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hKcYOHyEFAVPL+bloJMlVp02+e+jLT8JX4gSHEoctCI=;
	b=R2MvzP+4c9Q1ERLZ/n9kpLGZk6iwZhdeKeT5TOJKxynBc8UMGicgj0r5pEgyqC7j1AOIDb
	Mk4aPH5Xzo33sLKERjJ4EV+5BLvF0WxFx1E8Us1i+guYDQJTa6uNI47IDR1Vbp2yAW3USZ
	l/pvyZ/X7+qZiIISUlGUlloc2PIGBwl+7Siuq8PM6+fD8Rmqek6PrRBH8x/YVfEBAqs+cD
	1fT2rK8YQz/GITIG3vgEbuJWx0ytoLeSGjNmJiAbIc0xJ0iM/iKSw/cC7H9sEgcE5viAo5
	rSfI3d3GPogEL9Ce7hyrnIaaLu6TO6UDcDjPkMcGCmJwUP3VaB+Ep9W3wv4FeA==
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
Subject: [PATCH v5 0/9] Implement setup_interface() in the DaVinci NAND controller
Date: Wed,  4 Dec 2024 10:43:10 +0100
Message-ID: <20241204094319.1050826-1-bastien.curutchet@bootlin.com>
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
PATCH 9 depends on PATCH 6-8

This NAND controller is present in the DaVinci (OMAP L138) and Keystone2
SoCs and functions as a 'child' of the AEMIF controller. So its timings
are set by the AEMIF controller itself from device-tree properties.
Implementing the setup_interface() callback implies being able to update
dynamically these timings, so the first six patches of the series modify
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
 * v5:
   Rebase on v6.13-rc1
   PATCH 1:
     - Move the struct aemif_cs_data's comment modification to PATCH 3
   PATCH 3:
     - Fix commit log's typo
   PATCH 4:
     - Add '()' in comment to fit kernel doc format
     - Change aemif_calc_rate() return type to u32
     - Add details in commit log and fix typo
   PATCH 5:
     - Add '()' in comment to fit kernel doc format
   PATCH 6:
     - Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
     - Use longer header guard
   PATCH 8 removed (already done on v6.13-rc1)
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
[v4] : https://lore.kernel.org/all/20241115132631.264609-1-bastien.curutchet@bootlin.com/

Bastien Curutchet (9):
  memory: ti-aemif: Store timings parameter in number of cycles - 1
  memory: ti-aemif: Remove unnecessary local variables
  memory: ti-aemif: Wrap CS timings into a struct
  memory: ti-aemif: Create aemif_check_cs_timings()
  memory: ti-aemif: Create aemif_set_cs_timings()
  memory: ti-aemif: Export aemif_*_cs_timings()
  mtd: rawnand: davinci: Always depends on TI_AEMIF
  mtd: rawnand: davinci: Add clock resource
  mtd: rawnand: davinci: Implement setup_interface() operation

 drivers/memory/ti-aemif.c           | 191 +++++++++++++++++-----------
 drivers/mtd/nand/raw/Kconfig        |   4 +-
 drivers/mtd/nand/raw/davinci_nand.c |  86 +++++++++++++
 include/linux/memory/ti-aemif.h     |  32 +++++
 4 files changed, 235 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/memory/ti-aemif.h

-- 
2.47.0


