Return-Path: <linux-kernel+bounces-330403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD2F979E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC02AB23859
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FDA14A4E0;
	Mon, 16 Sep 2024 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uZInbVsn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52C114900B;
	Mon, 16 Sep 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477904; cv=none; b=DwvaTjkSzDFgphhMVVhGARcJvzXNd75YGA0vpfH2G6D5GTjDz9PXUsg6Xq0RQhx7ULNpM6i2/nXaQGB05SrQblSzxXchCskx0WV9fmWYDn7TAFVqltyKax02/IvlG8vODI2unOnVTN2FRMZg0Za7V1bt9sNqBrlzjak202DrsjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477904; c=relaxed/simple;
	bh=bBXVjManR5QI5nqLaRpf1s6ZfTEZVAXdd/J2a6VUsCo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Geyae9reWGb7p73dLGNw28n7lep64je2pWkeF2Z+9ApN1A/HYq7RvkN/s+3P1Ta+KMAVbrbzKn6Cn43LCm2tocoztNFozHEtU9Iu6rp/rQ1nQ2oF/6RS2NmHhHZjDVmdkbp90yf1Wwbcl8w5LC/Vw9oKnP24C7ZH9eenaljcEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uZInbVsn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726477902; x=1758013902;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bBXVjManR5QI5nqLaRpf1s6ZfTEZVAXdd/J2a6VUsCo=;
  b=uZInbVsnOvkRTwsjd/UfsYq1fz/MAQiaon0tTRVgq0lIO4c8n/5ix+cr
   PsyFzKrQOv8eWtPKajMFY+Q1iZXkUL+6Et9+tBzCnjmUjOGF9HfDOe4vF
   dUrlLjoe+LbDOni+B8L70a1loW/shYO+K/lLLVOBB7cPjCKAf9ZCxDSbo
   Cit34VWe1JXwuJlKnOPlP/FCQ8pX/ZIjwG21lvOr0uIC+ZRp37JkWZdb2
   fn9+dxhk1tpEtbeR3JzGmfgQ5p38FOYWpNQzHnXloOH4A0DUD7fgM1SKf
   CMaqzY2U2Bo5bOihgfZRoAWzHHGzgs7J8Lo88P7U3U8YDdSy7WLnD2y5o
   g==;
X-CSE-ConnectionGUID: zBJi05dESDObnv88EXzWcg==
X-CSE-MsgGUID: WplkUA/6QpyGdb05qmq9uQ==
X-IronPort-AV: E=Sophos;i="6.10,232,1719903600"; 
   d="scan'208";a="34997189"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2024 02:11:40 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 16 Sep 2024 02:11:22 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 16 Sep 2024 02:11:20 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: [PATCH 0/2] Updates for mchp-spdif(tx/rx)
Date: Mon, 16 Sep 2024 12:10:55 +0300
Message-ID: <20240916091056.11910-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch set includes two updates for the MCHP SPDIF RX and TX drivers.
The patches remove the interface name from the stream_name, allowing the
interface name and index to be set in the Device Tree (DT) using the
sound-name-prefix string property.

Codrin Ciubotariu (2):
  ASoC: atmel: mchp-spdiftx: Remove interface name from stream_name
  ASoC: atmel: mchp-spdifrx: Remove interface name from stream_name

 sound/soc/atmel/mchp-spdifrx.c | 2 +-
 sound/soc/atmel/mchp-spdiftx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
-- 
2.34.1


