Return-Path: <linux-kernel+bounces-213253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53D3907325
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9B6E1C217ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A5143C59;
	Thu, 13 Jun 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QFxQd2Wa"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB95F1E49B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 13:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284073; cv=none; b=bQ5G6Cup9TV+Fo1/6ofdD9w9vRARxuGqhWLSij2IzKqnYDesGcxtIus9SarFhRYktrC+rLu+ZrRTveza2TI3kkdlTSqNFqgzu7i5aoeU+8/eqQjOTHI7alB0VCa50FgHim7ao3zaW3YRAHDgX5x0/nU2EB+Dg7htZe8RJ8mv6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284073; c=relaxed/simple;
	bh=nYhITXwpEqswuA0y+v2fNK+GobGvtB6mkwsMf3RAmbE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ngv+MPYOKNF1V2uWQ22wMJ9q0q/f9BBUUAZI4KmVfQstLLhm3YJmQTf9vzb6Wz2987B3YrjSMKErJi6b4jjq1Ss4AK7Cam0oP7bEW41d3JUKXH9JBCKmleZU/VV1LaRRognSiowtYX2LkzJjdLXumVMjPJ1fLFq5dcqsGXhrQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QFxQd2Wa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80FED24000A;
	Thu, 13 Jun 2024 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718284064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HCp+HRWBM7otRyA0rCsZa1wXyol+qhme87TP5J80410=;
	b=QFxQd2WaIo5VgVuJiPC2kWnLWxQ2UmKrlbkARWsl5NTmKGA7iD4sYcYwXHzqhL06YAUGno
	1Do6DxQx+f7kKs2J3kEJemZnygs5W8LJ16Ka9UvEotqSlXBTBh6QBm63+600lIUU65uL4V
	alSnKGNJJ62t/cHR+TGUF9TywehpEK3xcTi8ZlxIN9pwauAgCeta+7XN6VKt8StWs1OAAk
	vGRd0P31e9dooFk8or5vunTzGIWy9cQ0Ygblyiq1buFk0VV8VkJ6d7/iuETcqFIfMdwRDp
	cV0Gwrkmuxo0szYScqhxGFiGC9wYvV/v05YkSue66vBr57c/bYFhgRQQ3p36gA==
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH 0/2] Add resume support for the mux mmio driver
Date: Thu, 13 Jun 2024 15:07:29 +0200
Message-Id: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABHvamYC/x2NSwrDMAwFrxK0riCxTRe9SulCSZVGC3+Q6hIIu
 XvsLmcewzvAWIUNHsMByj8xyanBdBtg2Sh9GOXdGNzownifPMa6Y4ySUdlqZLRaStYvhtXPjnw
 g7whaPZMxzkpp2XpvTrGrPhXlVfb/6fN1nhd+OY65hAAAAA==
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com, 
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.12.0
X-GND-Sasl: thomas.richard@bootlin.com

The patches of this series were originally in the series "Add suspend to
ram support for PCIe on J7200" [1].
There is no changes compared to the patches in the series [1].

These patches add resume support for the mmio driver.
The first patch adds a new function mux_chip_resume() in the mux subsystem.
The second patch adds the resume support for the mmio driver using this new
function.

[1] https://lore.kernel.org/all/20240102-j7200-pcie-s2r-v6-0-4656ef6e6d66@bootlin.com/

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
Thomas Richard (1):
      mux: add mux_chip_resume() function

Théo Lebrun (1):
      mux: mmio: add resume support

 drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
 drivers/mux/mmio.c         | 12 ++++++++++++
 include/linux/mux/driver.h |  1 +
 3 files changed, 42 insertions(+)
---
base-commit: 8e7767d07e04b89999d5adefb190f4d5e566d8d4
change-id: 20240613-mux-mmio-resume-support-4f3b2a34a32a

Best regards,
-- 
Thomas Richard <thomas.richard@bootlin.com>


