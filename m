Return-Path: <linux-kernel+bounces-169707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645F8BCC64
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47931F23B80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A73142E62;
	Mon,  6 May 2024 10:51:36 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D42BAE3;
	Mon,  6 May 2024 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992696; cv=none; b=hX3KLA3i3BG6qv7wlEvmLJTY3Zj7LKA5e7JZNsgx9q3zxgTs+t69YpdWdyrIl9ItTaed8PAHnMdhBpd1LHeyjam5x/ps5eGstYh3RXM1CM5vOCzymryhMxBi9COplpkmDrfBPV/RbQMhqDejwdQyTJp4dCbqh+G26tr34z4TzW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992696; c=relaxed/simple;
	bh=vyP1VQPJvGvnR56OM7Va9Lm/gtCLKfyQidwF0Wigk8k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NMbLqvkLiP5PuXRtnmzB/M0MQH6PmJAevNXUWzrlNNAi5Q4IVNnTk1by1Yb6ui+cUa8rnjOrGFgv/XoYUNUp5hC9Y/6PV1Msz2hgwQJ63YMmcKkdv+dU0ftYbyhnVHrrWKIz6Hvj95MGQvFfbXPMhG6BGMhxBTdjGcLdZ8/4/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 6 May
 2024 18:51:20 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 6 May 2024 18:51:20 +0800
From: Dylan Hung <dylan_hung@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>,
	<alexandre.belloni@bootlin.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-i3c@lists.infradead.org>
CC: <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/2] [RFC] i3c: ast2600: Add MCTP-over-I3C support
Date: Mon, 6 May 2024 18:51:18 +0800
Message-ID: <20240506105120.3028083-1-dylan_hung@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add Aspeed AST2600 I3C controllers and add minimal changes to validate
the functionality for MCTP-over-I3C.

Dylan Hung (2):
  [RFC] ARM: dts: aspeed-g6: Add AST2600 I3Cs
  [RFC] i3c: ast2600: Validate AST2600 I3C for MCTP-over-I3C

 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 137 +++++++
 drivers/i3c/master/ast2600-i3c-master.c | 137 +++++++
 drivers/i3c/master/dw-i3c-master.c      | 513 ++++++++++++++++++++----
 drivers/i3c/master/dw-i3c-master.h      |  12 +
 4 files changed, 718 insertions(+), 81 deletions(-)

-- 
2.25.1


