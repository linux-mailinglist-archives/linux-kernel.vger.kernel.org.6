Return-Path: <linux-kernel+bounces-215813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E9F909746
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 11:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0DF1F232E4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D3C24B34;
	Sat, 15 Jun 2024 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gz6wyzFy"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BA2110E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718444095; cv=none; b=Rc6Q7WeFjGk6kCa+hLvqX35IYczRakTi3JDgDZ0Y+FtAcpQ7Y5aqeb6UB/zMoO8BdUcu3U9YfFSBsai2EnxKakfqjqyM/6tk6JnWgjf6JkpbbWHOpA3mtzKVVQre1aFcDH03yQNUVz9RQFzExYuMbrIs7HGisltps7Tw2CqBl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718444095; c=relaxed/simple;
	bh=DJXGzyNrrCFKqC9YLxqaWfdqpCbiWT0sNV0rdLq4IaM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IjnWQDrBL3JB0Ion1Qx+dI0si81kfKWRpI/2TRqJnN3mKrYpQZAeyseSzMNZkj1LT7zPFxMWJiwHklfD+TEtW5w9xNv8NRE1H6lanvdLUg/ULARB9iHLkbb02ynTGOCNB8cLb5lOAu1I8mwtQE2APH/PmSnMuWQfLOwdnZte1Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gz6wyzFy; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45F9YboC115316;
	Sat, 15 Jun 2024 04:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718444077;
	bh=RZFwA9XAUeyIABlfIlwpHFHwEKviKNrV/iZJejrEtv4=;
	h=From:To:CC:Subject:Date;
	b=gz6wyzFy6MLJRW9byjyHG1oLPTndFbWT3lVsYH6SrbiBGKiw6hvKq6bBY5IxGMx7z
	 V0ItV82uSwxL1MZw+sbASS9RbU5nctaHHgr6pUurrq/Jbsuwsu8TnzgV+yBBg/9OyL
	 K0QtkmqMuecOjTJC4rQOWpQifoMJrcWLo5V5O2WU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45F9YbtS107256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 15 Jun 2024 04:34:37 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 15
 Jun 2024 04:34:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 15 Jun 2024 04:34:37 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45F9YXZ4083099;
	Sat, 15 Jun 2024 04:34:34 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <sjakhade@cadence.com>,
        <rogerq@kernel.org>, <thomas.richard@bootlin.com>, <robh@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Enable PCIe Multilink and USB support in Cadence Torrent SERDES driver
Date: Sat, 15 Jun 2024 15:04:31 +0530
Message-ID: <20240615093433.3659829-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

This series adds support for standalone PCIe Multilink configuration
along with the support for PCIe Multilink + USB configuration in the
Torrent SERDES driver.

Series is based on linux-next tagged next-20240613.

Regards,
Siddharth.

Swapnil Jakhade (2):
  phy: cadence-torrent: Add PCIe multilink configuration for 100MHz
    refclk
  phy: cadence-torrent: Add PCIe multilink + USB with same SSC register
    config for 100 MHz refclk

 drivers/phy/cadence/phy-cadence-torrent.c | 276 ++++++++++++++++++++--
 1 file changed, 257 insertions(+), 19 deletions(-)

-- 
2.40.1


