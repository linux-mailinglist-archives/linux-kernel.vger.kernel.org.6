Return-Path: <linux-kernel+bounces-543913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58FA4DB5E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543F51894C12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E5200112;
	Tue,  4 Mar 2025 10:49:51 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AEC1FFC60;
	Tue,  4 Mar 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085390; cv=none; b=uAX+yMuV5+FyFiUsDdn0vWJ4kMNa+MCIC2sODoEP476jA9nYT3Mi1Sc1Q9ehyl2aIX5U1pJXroTb5RuzaKUMubgKG9JgIhQI4uJ4p6l7X55LudcoL331Hk9tMuwNNXKVVUcMhAVoNrqGoYoUYrtZSQCKDA2J29CsyLA3GabRJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085390; c=relaxed/simple;
	bh=mlkzvM8y+hfE5dIWO1VXwN7xQKHMLgI8/PlimUaRQKk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Quyl+cj5fkQZqcWTsxySPUY8v7RM6swT5mLwJ/4c7dC6Khn68h2+1yOspkNfaN2aMbTGyTRMyl5DitksTX1W+qjwb9pvUc0gy6dBO9gfwBrmomLjO7zJlkUYGbrKoFWEjyTS5J7oSVxYrb/VnD5kFZD/mVscOw51LncRwyan5Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 4 Mar
 2025 18:44:38 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Tue, 4 Mar 2025 18:44:38 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: Add AST2600 LPC PCC support
Date: Tue, 4 Mar 2025 18:44:31 +0800
Message-ID: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
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
v2:
  -- Change driver path to drivers/misc

Kevin Chen (3):
  dt-binding: aspeed: Add LPC PCC controller
  ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
  soc: aspeed: lpc-pcc: Add PCC controller support

 .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  36 ++
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/aspeed-lpc-pcc.c                 | 441 ++++++++++++++++++
 5 files changed, 495 insertions(+)
 create mode 100644 drivers/misc/aspeed-lpc-pcc.c

-- 
2.34.1


