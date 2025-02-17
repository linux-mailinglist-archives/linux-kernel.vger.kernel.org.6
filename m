Return-Path: <linux-kernel+bounces-517546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C45A38238
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF597A139D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17294219EAB;
	Mon, 17 Feb 2025 11:48:45 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39482219E8F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739792924; cv=none; b=dbwhZLZ0/+c3ae/dCMyTgOSb9grCEd3wwgYhSRgXIlUUQJf9AyFarnv0pfBBYSQxQGV1Juhl7dt7Txi+XF2wETLgNbccuuCJ+eggoZgPuKMQxyqqU+VDRBEDX4K+KxaFmF15xkFTDTvtfrfc0CH54FhHYq740EbDTqxGdMgsf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739792924; c=relaxed/simple;
	bh=7jU8mYBSfRqjNJoHUFjgsre2kcmse57hl5mT85yK2A0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KULAIHNw05SmH1vXukD2PaoE20czSJkR1MfXuTRjpZ8Fi0EKdXTrMMQInvtjyY7FYJyQdZpYBPvRLSkwS1RKnVQUS3qgdzTKxAe5GRdlbYRGyVwkvN2YpRkhFGWe4dIiBDl09sG9LJsbxtsxHg9xVyt4QcfUG1byx6O4gpBSpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 17 Feb
 2025 19:48:33 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 17 Feb 2025 19:48:33 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<chiawei_wang@aspeedtech.com>, <linux-aspeed@lists.ozlabs.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v1 0/3] Add AST2600 LPC PCC support
Date: Mon, 17 Feb 2025 19:48:28 +0800
Message-ID: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2600 has PCC controller in LPC, placed in LPC node. As a result,
add LPC PCC controller driver to support POST code capture.

--
v1:
  - Change pachset from 1.
  - Remove properties in pcc driver.

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  36 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
 drivers/soc/aspeed/Kconfig                    |  10 +
 drivers/soc/aspeed/Makefile                   |   1 +
 drivers/soc/aspeed/aspeed-lpc-pcc.c           | 439 ++++++++++++++++++
 5 files changed, 493 insertions(+)
 create mode 100644 drivers/soc/aspeed/aspeed-lpc-pcc.c

-- 
2.34.1


