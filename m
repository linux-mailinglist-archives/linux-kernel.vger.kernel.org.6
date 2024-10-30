Return-Path: <linux-kernel+bounces-388496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F09B6067
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F1B216EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BDD1E32CB;
	Wed, 30 Oct 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQi96Fz/"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9829CEF
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285244; cv=none; b=JPdVL5GQdmVhfFIG3SUCSXSFtJGgG0T9+i78ZoK+8zkX47JWBE6FDZveypwI7zUgza4KK2EJOHXgfp7D1l6kkl9MnziKPRIzyIJ3Kxg39v5XrBCWNMlhj06UCEdTaaOSnCaPSKsYZpbHRuGegcaPewvvZ9v1kxf/UZBiuTvsqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285244; c=relaxed/simple;
	bh=7uRJN94kAdSKzBkbHx+YMndx4HNvWLjNqGp/vu1spm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NIJfwKZEJ7SEmWLioqvH5LVQOGq8YVIuaWu5u5duNJj3Z7T92M3uaH9a9++cnKG7FpGwiJOYb8e9mRTSrs8mnJZ2/m+bGuSRtFMCkxCrp6vmRRGW3rFST6JOQbSAuSHMv2nLSQRcOQrXix+0wHl4QMWWQFVaSi51tsefKnMRQAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQi96Fz/; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 6DCCCC000D;
	Wed, 30 Oct 2024 10:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730285240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pMchHP69c26XAzNG8iivY1LwGH4VkexERcWrseBovcE=;
	b=QQi96Fz/s2t8sT6eX/b5kiVtkfZtV8foCN5TjSoDyePJtejoJyvs5A7Cz6jJtwS8Fq0bhU
	eZrsByeS3K3ZKg/uXD1NygBBt8zPrnktXWx1pHCsPAmA2+VDEWg0GZNG1/a8YZ9UAhaXeE
	Qa9q6nIw/0RZPsF75uhDz1mykkyEzaWmGv95rc1IIt/RnFbaBBd62Z4ZEdd29iOmWM1C7a
	R90NLIY2a4rza5TAu4kT+bTzCWw1xP6qDgV0ajCUvmhnvoUF1sDLtI2QkEp03Wm/z+qtVf
	2OXmbRcnuYAeAWKBD43OLtgGNSRYPn10spxEngb7VyWosNid+CLo/2ZBrOUTKg==
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
Subject: [PATCH 0/5] Implement setup_inteface() in the DaVinci NAND controller
Date: Wed, 30 Oct 2024 11:47:12 +0100
Message-ID: <20241030104717.88688-1-bastien.curutchet@bootlin.com>
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

This NAND controller is present in the DaVinci (OMAP L138) and Keystone2
SoCs and functions as a 'child' of the AEMIF controller. So its timings
are set by the AEMIF controller itself from device-tree properties.
Implementing the setup_interface() callback implies being able to update
dynamically these timings, so the first two patches of the series modify
the AEMIF driver to provide its 'children' a way to modify their chip
select timing configuration. To do so, I add a ti-aemif.h header, I'm not
sure whether this header should be located in include/memory or in
include/linux/memory. I put it in include/memory because the folder
already exists while include/linux/memory doesn't.

The remaining patches implement the setup_interface() operation.
The computation of the register's contents is directly based on
§20.3.2.3 of the OMAP-L138 TRM [1]

This has been tested on two platforms based upon the DaVinci SoC. One is
interfaced with a Macronix MX30UF4G18AC NAND, the other with a Toshiba
NAND.

[1] : https://www.ti.com/lit/ug/spruh77c/spruh77c.pdf

Bastien Curutchet (5):
  memory: ti-aemif: Create aemif_set_cs_timings()
  memory: ti-aemif: export aemif_set_cs_timing()
  mtd: rawnand: davinci: Order headers alphabetically
  mtd: rawnand: davinci: Add clock resource
  mtd: rawnand: davinci: Implement setup_interface() operation

 drivers/memory/ti-aemif.c           | 102 +++++++++++++++++++---------
 drivers/mtd/nand/raw/davinci_nand.c |  95 ++++++++++++++++++++++++--
 include/memory/ti-aemif.h           |  31 +++++++++
 3 files changed, 191 insertions(+), 37 deletions(-)
 create mode 100644 include/memory/ti-aemif.h

-- 
2.47.0


