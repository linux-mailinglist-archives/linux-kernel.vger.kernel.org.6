Return-Path: <linux-kernel+bounces-321663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F286971DC4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2428496C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32791487AE;
	Mon,  9 Sep 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cs9qV1fX"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A0B383AB;
	Mon,  9 Sep 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894923; cv=none; b=qBZsdwZw4H+zyN3a0eZIo39PGqP2XklmMA1dB4Q8OKNQgXGNzyxSypkrylThmoIikIo3tLvqusD/KX8OwkCbgNq1r6IW41Hok3/ct0TtYMF5M0H4yF6nBqZf0RTV5Xmpaf5xStlO8ctEUYi7kDUdalDiQC1G1Ifnds8WAawcr78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894923; c=relaxed/simple;
	bh=7eBDbIZBoCNdgrtkB2Ysz8rn1Ya0WQpeA0tUMqyjFIg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=m/NQP7Nc7juO52z9q5PsBv3pOTOFs+KDDkGJ4e7N4wCb87DpVGHFxkvMiTkWebel9zzaNlDPgSwQg2CoeEgw/fPm/mVabHngo1MsfX9utEed/FjcUQkveVe+AJQQPJ83W99LwXK1ShVI4jLIyZGmyR9UujQy7HCYELQkP/Q0/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cs9qV1fX; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894922; x=1757430922;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=7eBDbIZBoCNdgrtkB2Ysz8rn1Ya0WQpeA0tUMqyjFIg=;
  b=cs9qV1fXyczDsAn7EpX42DWwuVE1knwIqj/B8OnAg+AxlRyCF94B1+rk
   TkWuFi0ZJTLX1b3n4HwZROCDJQCoeH7dO2TQPkQXEgOQvnUi0tRnjeXyD
   +suhHylim12vAzAZyhrBLP+L5kp1X66GxoZVzK+F+LavZIK+KVCFClaGB
   xl67/RJ8TuZyjAj6gx5KRrXii+wTUhLDUy1mGDT2zS6iNQxkvbXp6NQxQ
   s4TxNI8Fou5dLReXKO0zJJ+LGMmNWPxeyi1UboCVIiq3ZvCTmMF2p2kb+
   ybiWqf+/FIoyNnoJl1QcXMqxNZxbUmB51o3D3tsOE9yH0ZMcJJn1HTiDa
   A==;
X-CSE-ConnectionGUID: /ltMKKTeRqSXWxXLFfJz/g==
X-CSE-MsgGUID: FiYGY5+RRX+z7Dxmn8NWFw==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="31514493"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:14:54 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:14:52 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Subject: [PATCH v2 0/9] phy: sparx5-serdes: add support for lan969x serdes
 driver
Date: Mon, 9 Sep 2024 17:14:40 +0200
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAQ32YC/32OQQ7CIBREr2JY+w2lLQFX3sN0QQHlJxaajyE1T
 e8urXuXL5l5MyvLntBndj2tjHzBjClWEOcTs8HEpwd0lZngouNKCMizoaWHl4la6gVq3fkMjrB
 4AtUq7UbntFGaVcVM/oHLob8PlUeTPYxkog27dDIY91jA/E70OU6UZg//9jSX//dKAxyUky2XT
 Wd7ZW4TWko24HyxaWLDtm1fMOtkyOMAAAA=
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

The lan969x switch chip (upstreaming efforts beginning soon) has ten 10G
SERDES'es which share the same features and data rates as the Sparx5 10G
SERDES'es. Lets take advantage of this and reuse the existing SERDES
driver for lan969x.

In order to do this, we add a new indirection layer to the register
macros, that takes register differences into account. Additionally, we
add driver match data for other differences that we need to handle.
These other differences are handled by a combination of constants (eg.
the number of SERDES'es), ops and if's

Patch #1 adds support for match data.

Patch #2 adds a struct to handle constants and adds a constant for the
number of SERDES'es.

Patch #3 adds a constant for the number of CMU's

Patch #4 adds a struct for ops and adds a function for setting SERDES
type.

Patch #5 adds a function for getting the number of CMU's.

Patch #6 adds register macro indirection layer.

Patch #7 adds SERDES target types (eg. Sparx5, lan969x) to be used for
branching out based on the target.

Patch #8 adds support for lan969x in the Sparx5 dt-bindings.

Patch #9 introduces the new lan969x SERDES driver.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
Changes in v2:
- Changed the subject and commit description.
- Added compatible strings for all lan969x SKU's in the dt-bindings.
- Got rid of example in dt-bindings.
- Added new compatible string: lan9691-serdes to driver.
- Link to v1: https://lore.kernel.org/r/20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com

---
Daniel Machon (9):
      phy: sparx5-serdes: add support for private match data
      phy: sparx5-serdes: add constants to match data
      phy: sparx5-serdes: add constant for the number of CMU's
      phy: sparx5-serdes: add ops to match data
      phy: sparx5-serdes: add function for getting the CMU index
      phy: sparx5-serdes: add indirection layer to register macros
      phy: sparx5-serdes: add support for branching on chip type
      dt-bindings: phy: sparx5: document lan969x
      phy: lan969x-serdes: add support for lan969x serdes driver

 .../bindings/phy/microchip,sparx5-serdes.yaml      |  17 +-
 drivers/phy/microchip/sparx5_serdes.c              | 195 +++++-
 drivers/phy/microchip/sparx5_serdes.h              |  44 +-
 drivers/phy/microchip/sparx5_serdes_regs.h         | 746 ++++++++++++++-------
 4 files changed, 706 insertions(+), 296 deletions(-)
---
base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
change-id: 20240822-sparx5-lan969x-serdes-driver-8389dbdd9a89

Best regards,
-- 
Daniel Machon <daniel.machon@microchip.com>


